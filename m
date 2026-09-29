Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88BAECA5FA7
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 17:24:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBbYl-00069W-Rw; Tue, 29 Sep 2026 13:24:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBbYj-00067z-Os
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 13:24:05 -0400
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBbYi-0002ne-35
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 13:24:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vW9G6tCj71xJ9K9coHXPVfTmUBqUTyf0nyHu5lk+LSesnQkNwokS/YjGN00cZ7BhAgNM4Bt4/MRUR4ULZlhzbmeLdmVvlzw6bseDk3tg4ndW07Fkee+S32PndIG1yDIxi4ryfekFkJYOfTI6cgYC9D9Ukapwl2XR15N+LU946bvpTtOUTcauDVszyCoPtGREHbtRgcVgWWai2BCfiBdxMMVJ7X7JXtTI8oRjmmbluybniQ3lNntwKRSq8YbrPhFVgh7LrUbe6yN9ZDwl7msYaC2g8CwKpGqju+Hqyi5s7IMvgMDofOMxbjti9Dp3F2iWiN2CwZK+FOKo1AWB8XNuNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZsVXvvvzwqJ72NVYywAYrq/LWoyKs50mmgOws/1FLo0=;
 b=t6RPJbB6Fd7xoXmMaPLZ2sKSlcpnKMdW1O4Ax4BfGOXhBN67hNwdMt2VAlduZGj0P5HiP8xSjocAkD6kiH0v2/TVGq4PEwaFfhMDfUcSkl+663QWbZ5lt9o1xvXZBY81ahNGMD5N5+xJid0IMcz45z/9HKe/9iwgkXdwoglPcSLJDdcUh9qf/PGJRqRTnMNXZ0nawj3a481OW0TEqKKEpvJYeCmeneAeXgpk/RNezoxXzWfGX7REcE3qjKGYWRnnM7VkHxfG3+5+UTqbiDFmvtzV29s6D5099QNlL2NPLo1eHZE0A5gUQTQ2Fn9HpeLN4Rals6Ti+y2Y5093/h4cBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZsVXvvvzwqJ72NVYywAYrq/LWoyKs50mmgOws/1FLo0=;
 b=VjH8v5LOXmAP/85W9RhSarJq+OCLcH+WCm5t8bJ5uQq39F07D9MfcFL11wwgHppZ35h984E9NiCzAo2bQm0rlHfrbx/C0AC2K4zEgy8fUE6yIRiKSpgFwuKwBe0TZhU2+zgFQdnXUfBP1j/xWdu63iBWYktssN5juhfbyav/VrG58yjpLIlzHhEK/C6R4ixmSwoBHQPQPomlCFXPuDWFHzDNbOOZJUD2rKyjLYCCG4KlU6UqcrVySiIpEqxDOPkzKeoOEz3k4UUV779xi8KftVVmej3RUoel9HVpFKrL0fPo2a6cUEXZRPGmIJlX2efoMPeVj6uJ/3baHr7xMg9pcA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by MA9PR08MB435041.eurprd08.prod.outlook.com
 (2603:10a6:250:101::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.7; Tue, 29 Sep
 2026 17:23:54 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0472.012; Tue, 29 Sep 2026
 17:23:54 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Tue, 29 Sep 2026 20:23:32 +0300
Subject: [PATCH v8 13/17] vhost: add vhost_dev_set_owner() /
 vhost_dev_reset_owner() helpers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-up-vsock-vhost-v5-v8-13-12bcf1c0b84a@virtuozzo.com>
References: <20260929-up-vsock-vhost-v5-v8-0-12bcf1c0b84a@virtuozzo.com>
In-Reply-To: <20260929-up-vsock-vhost-v5-v8-0-12bcf1c0b84a@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, maciej.szmigiero@oracle.com, philmd@oss.qualcomm.com, 
 odaki@rsg.ci.i.u-tokyo.ac.jp, clg@redhat.com, den@openvz.org, 
 andrey.drobyshev@virtuozzo.com, mark.kanda@oracle.com, 
 vsementsov@yandex-team.ru, farosas@suse.de, peterx@redhat.com, 
 sgarzare@redhat.com, bchaney@akamai.com, dongli.zhang@oracle.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI1PR04CA0130.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::28) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|MA9PR08MB435041:EE_
X-MS-Office365-Filtering-Correlation-Id: 008c19bf-5f8a-4452-f89e-08df1e4e6fa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|7416014|23010399003|1800799024|38350700014|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: VnFR9RkQgqYFPsZMXsADpeSRm2Q9PNifAPJp6HGYqu3j7+CBmM3MXIM5CSWn5L1IkRw1jXY4rcDVomHWL+g7nwNrsyY50mvVzGrMVWz/2ngX8tpTeqDBZGEskIfA2eSmvrEgcViGAXL+4g+0QhvP7hI/+zC5HLLzxWBnIVhm8Lo2mUPN+DdEJFNl5ns0UXRHXEFThugZofcQ1sFK5rOgNMQo0WvF0SvupC768+BTZ6IXx0egASuS3TQ9XbxKv3ZmxOjZmj7VQp6IjvY75Q7LVXLAUhlqQEyJpI+B25naGun0kK1f/B05U/iGHONH+wnq+y8OMusF4V+UIQTt3aEqzdqQyT60u4ztvGiu0mgicNf8Opw6zfraLIIhTPKDC95nSlZJWHmFntHEIPz4EgxVLt5HDaF/A3qZtUBXo0PNP7PJFuEWT2sUoJYjYnxx3yii1fyLNRj3PhFM1OyUz7CgUJ0L7DcHUoWVmp3I8BzEYDToEHCdx0RxXPsbh6DQtaiAcuQQotI+ezMIP2Mq5Z1snX4z1R8gyKCaO7/8AqF9Imyg7mca6Q5F7C+nD7l5hDw0MTOxD+2t4ihYR/67Vu07M8tsnokRbhMw1ciL1eR7O65NWPJe9nXQDIn50+P1XCXbKROXW+W2t0qu0Jx9jADYo7N0bTj8Sw5qp34DRreIPELilvc6o5BnsRlo5HXGFh6Jt6LRtD4g4iVez7Ir2HPn+oUWLCu9yMuFxfXpeU0BDrQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(7416014)(23010399003)(1800799024)(38350700014)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkZ5L1NGOHVsVjZUQ0RuOHUrNFFlNWVxbWpLTWswWGlCc2lZTXJaVURmMHFP?=
 =?utf-8?B?bjkzaFhPMnVwRk1NeEQxVW1ZOHVpQlJ4b2NCTU1aRjFrUC8xYmthS01FTWpk?=
 =?utf-8?B?Y0U1eXpnbEJsdXdCQ1pmRVVza0k3bXBaNjRzQnk1eUVpRW5JWEZOZnIyNUI5?=
 =?utf-8?B?ellaSFc2cExKQXRkcTFrY0pKaXBuNHVuR254eG9RdytRRmIra3hTcVdGWTFp?=
 =?utf-8?B?U2lsZTdnTzd4bUUrZlo4V0tFRUFVL05lSnoyb1NRV20xZTVjUzBWNWJKcWYz?=
 =?utf-8?B?VFN5Mk1KUllyU1BzNmZJQnRqN2U3MUJzaFhRTzJ1WUtmcEpNNnJuWVhJc3l1?=
 =?utf-8?B?Y2xHamZiVnZPUXp4R01oU1F5RUlyYmljd3lxNGc3eEJURTdkV2x3OG5Ic1By?=
 =?utf-8?B?WHYxRGFPcVZiSWJIUHhDMnkwOWkvQkQzNVQrNlM4U2FPa0VYdExnLzRLSVln?=
 =?utf-8?B?L1M5Ly9teVF1c1ZORVorS2VDS2ZaM0V4dXJiREVJMi9UeTduSUhtM0R6dUMz?=
 =?utf-8?B?aU9zM29oTCsvbWJUcHNOeHlrQ3QvUGRRRDNCbFV5c3U0RWlPM3VNL2wwVzR3?=
 =?utf-8?B?R3FkSDAvajM0d2pabmtPVitUYjlkdVJzdWV1R2o2dThRQStBOWI0cDQ2ZUlq?=
 =?utf-8?B?Y2Y4SER0M3Y0Qm9uWVBxUFBqNVlJMTVkQVVuVC9URzAxbGYrYkNFTm1PVTgv?=
 =?utf-8?B?OHNyczBweUNkcFR0eFVwL0FBdk9ScVo4eldZNHd4RTNmNVZoNFZUbjVieDBN?=
 =?utf-8?B?OGc4Vk9OeExUeDFOYlhjODVObUpvWVBMemFyQXE1eE1WRkhObVNKY3hwVmtt?=
 =?utf-8?B?RUlnczZhLzE2d2dkS1AzU0o4U3FOTTVGeUloQ2dJZ3Z1bmF0M3RZSlZ5VHJx?=
 =?utf-8?B?ZUJEOFFSR1dRc3hrRW5sd0s1cXR0cXBZS1ppM2k0S3V4M0FONXpDRWJRVXpk?=
 =?utf-8?B?Z2RETFF4L1U5TkJSbVZ2c2tDTVhUNCtFa0RTRlBDZUJiMHl1SEs5c3UvMG94?=
 =?utf-8?B?aVd0bndIUnpSR29zQ08yL0g3ZUZZVzJ1azFxa08rbjlYaGIrd1BueFd3b215?=
 =?utf-8?B?R05YZlRYS3lidGpieDJNQlJ1bXdpUHdPT3lTVlFYdHFBaGZMcUdlK0hyM0xp?=
 =?utf-8?B?VFB0Q21jZTRjMXF1dk80MmlnTEFQeEdRQ1h6aCtQWjl4eCsxRjhTcUI4RWJY?=
 =?utf-8?B?WFFtQ3dTVHhVbjYvazV5Q2pPd2NDcXNiS1VNajlHSUZ3bU0rbkN6ZlRqb0Nh?=
 =?utf-8?B?WkFqT3Y2VXQ2SnhqNHJ2YzF1ZzFoakNMZzlPQXhxTXUrV2dZWDVpVTBQazJ5?=
 =?utf-8?B?dmlqcVRLR1VvZVErZHc4NjcyN0RKUWtTbVlUNW42UTBpclBQbk1QanV3cG1u?=
 =?utf-8?B?czJ5bWQzbXNpaEpTcHVFQUMzRTM1NytvcWNRcllmN0hCU3luTGhiYUkrV3Ba?=
 =?utf-8?B?dXgweHN5MzFiMUN3TzRDclZmRzlnTmFyQ2ZRVVdiaXRyNVkvYUJiMkQ2dGIy?=
 =?utf-8?B?bFJQanZ5Z0EzZ0hSTlREeFkwR1pkekVmU3VqNTM2R2Noa3l5SEpZVDU3N1ZE?=
 =?utf-8?B?SldidW15UktPd0k2K1NPdk9nRzErSjJJN0t3bFhBMGVtS2NMZlVTVFRtcTdW?=
 =?utf-8?B?N0JBTmxsUUxWZlFXd25pWTFyZnpRTE5BU3NoOHVQRzhLOWx5cEFjcUF6VU1N?=
 =?utf-8?B?Yzk3T1c1TDFQUmE3VGY5b0VCb2d0NXRJdmxTYlVva1BkZVIxMW51STMrcDRu?=
 =?utf-8?B?Qno2MUkwZnRRNlFuM3hHczVzeElNM1hVS0VFOVo2Q1JhZWdMMUYwcWtVczVw?=
 =?utf-8?B?bExaRkRjNlJrWnZGSWF0VnFrZzdudlZORTBiNVNXQThBbWVhUlpZaVhCQUFl?=
 =?utf-8?B?K3p2MEpvbE1Nb1M4OTZxdUduWmlrRzZVd1pTWEZYR1NFMCtyNU5iZWlralli?=
 =?utf-8?B?UHkveFFRUWFNVEkwQmJkRS9yVy9hRkxFS1ZzMnQ2YXJINUdleG5qYUx1S05q?=
 =?utf-8?B?M0p0aXhKeldFNWdUVFJGeDQvYjZ4cldOenA0WllrS2RYR1Y0MktNZjl4NHBu?=
 =?utf-8?B?b2pqdURtMGR6RFhqZTAxODBqdHoyNnU1WHFRK0h3Z2VWNjEybXBEUE9DbjNW?=
 =?utf-8?B?dHcwYVJ1cVl6VVAxQzhsbC9zOG1uMk9tM1VpT29zcmx3L3NKSXM0L1VpYWZK?=
 =?utf-8?B?UWVucktNWUhGeU9Db1I3ZUt5TUIwNFF0SjdtRVBmRmZMaTJGM2Vwa0g4R21y?=
 =?utf-8?B?bERDSVovTFZWMnFQZjYwam1na0Y0U2ltdGNJek1ONHRsUW13dUc1Ykg3dS9T?=
 =?utf-8?B?MDFxRDV0SGFvTWhDQTRONlhGU3dKaThBUjlHUVNVdm5GdFZNKzhrZk9CRGFa?=
 =?utf-8?Q?BRIsSyjQdumCIA+U=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 008c19bf-5f8a-4452-f89e-08df1e4e6fa7
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 17:23:54.0629 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ta7KccdC7DIA0C1MW/yn6jRp10wlJN6zLAYPFR25hkKRq2RnYVtye/T/44H2X+v2kv9rEjcEtYee3A4NiCVoHXVQtENBQhyxesNriepZ6oY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA9PR08MB435041
Received-SPF: pass client-ip=2a01:111:f403:c200::5;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=DUZPR83CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Wrap the set_owner/reset_owner backend ops in dev-level helpers, matching
other vhost_dev_* wrappers, so device code can take or release ownership
without reaching into vhost_ops directly.  vhost_dev_init() now uses
vhost_dev_set_owner(). Both return -ENOSYS if the backend has no such op.

No functional change.  These are used by the following vhost-vsock patch to
hand a device between owners during CPR.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost.c         | 20 +++++++++++++++++++-
 include/hw/virtio/vhost.h | 25 +++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index dfdfd49da3f..56fa4345886 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1703,6 +1703,24 @@ int vhost_dev_init_backend(struct vhost_dev *hdev, void *opaque,
     return 0;
 }
 
+int vhost_dev_set_owner(struct vhost_dev *hdev)
+{
+    assert(hdev->vhost_ops);
+    if (!hdev->vhost_ops->vhost_set_owner) {
+        return -ENOSYS;
+    }
+    return hdev->vhost_ops->vhost_set_owner(hdev);
+}
+
+int vhost_dev_reset_owner(struct vhost_dev *hdev)
+{
+    assert(hdev->vhost_ops);
+    if (!hdev->vhost_ops->vhost_reset_owner) {
+        return -ENOSYS;
+    }
+    return hdev->vhost_ops->vhost_reset_owner(hdev);
+}
+
 int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
                    VhostBackendType backend_type, uint32_t busyloop_timeout,
                    Error **errp)
@@ -1720,7 +1738,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
         goto fail;
     }
 
-    r = hdev->vhost_ops->vhost_set_owner(hdev);
+    r = vhost_dev_set_owner(hdev);
     if (r < 0) {
         error_setg_errno(errp, -r, "vhost_set_owner failed");
         goto fail;
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index b2b644c0d1c..8127a9a5a2c 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -178,6 +178,31 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
 int vhost_dev_init_backend(struct vhost_dev *hdev, void *opaque,
                            VhostBackendType backend_type, Error **errp);
 
+/**
+ * vhost_dev_set_owner() - take ownership of a vhost device
+ * @hdev: the common vhost_dev structure
+ *
+ * Issue VHOST_SET_OWNER on a device that has already been set up, e.g. to
+ * complete a CPR handoff on the destination, or to take the device back on
+ * the source after a failed CPR.
+ *
+ * Return: 0 on success, -ENOSYS if the backend has no such op, negative
+ * errno on failure.
+ */
+int vhost_dev_set_owner(struct vhost_dev *hdev);
+
+/**
+ * vhost_dev_reset_owner() - release ownership of a vhost device
+ * @hdev: the common vhost_dev structure
+ *
+ * Issue VHOST_RESET_OWNER so that another process can take the device over
+ * with vhost_dev_set_owner(), e.g. on the CPR source once the VM is stopped.
+ *
+ * Return: 0 on success, -ENOSYS if the backend has no such op, negative
+ * errno on failure.
+ */
+int vhost_dev_reset_owner(struct vhost_dev *hdev);
+
 /**
  * vhost_dev_cleanup() - tear down and cleanup vhost interface
  * @hdev: the common vhost_dev structure

-- 
2.47.1


