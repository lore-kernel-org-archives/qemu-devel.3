Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF0C0CA5FC9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:14:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBrJg-0000iw-4B; Wed, 30 Sep 2026 06:13:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBrJe-0000iV-O8
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:13:34 -0400
Received: from mail-francesouthazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c207::3] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBrJc-00045p-Vq
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:13:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S5fuAzBK6eZpjHbJKNAi9ePbKyRQ6QZIKBN8Jluhvf4DairfZTB+c0Hq2iFjXGhlBnXKTb80CdpEO4IJqJ+Ml+Dqd4MIoA3MReZq6ZhLzrr56tI3Vchgm5Xjv+cXZ83/mbublCScJQjyfdcRNIU+NrjE5KDrtzJmNOldhEVjUsVmlooU1MFQLGDalhrooORBj5hwIK4jAp4z+soOqy361HnCw605sSy6dR9aSSt/YpvFlteojakY05My8wKgb9gW6GkFMUd3JmCjK8jNtJNktLbZY6lzFDX5sKK3awWSc9VWbUImdYh8wZC2l9ptqpIaf8BSNowjgDgozrWiGwyyMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ExIQu0ecC+MilHqTTHG4T+cwdoW/u9j+e/13UOC8evk=;
 b=KGcatq/sPqDmKOLEGIM1BAp/4KdXOsRQyideSUOK2zMMK4IMNHFsDdOdLt9S9JV/1oz3CFOfvE0X1BoJT4dnT+Zt3Ab+RJoInSzQo7CHYb76HvDxtMlbM71d50GGulVVM0Jp2/dNBqw6I53budhVxYVPkDIbMFrLWPgn7/MnPhMEcMuyp3xGIPO9oVEm54P5457HY1bsO5cNO8oxLuxSI3E2fWWRiB2X5ow9CuzDQL7FC9pbDVdDESDc3N/yUTrcEuQQHlpJSy6q7XhpDvUC/4q8jv3ysn///9sfXTsVoV2BtD6yFxK6I3ippYrOpoVL1ulf3r9YF5MotfjzOQiuig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ExIQu0ecC+MilHqTTHG4T+cwdoW/u9j+e/13UOC8evk=;
 b=rqmoBktxT49fev2v92QqGW1iSa7mOisdpjuXs1t9cOud/WBz1eZP5tv0bzLDfKG7y6dQLqVXqygpppdRPx9kM9/O6BDJkqR5Nifl+6AJuCvKFjUBZP2gyN1oRPZgIOuK2ijfkiOb/XC7vo3PDH+Qj6h/iu9hGPuMF4WxKOBDq+8LTLqg7zbdYvLFaIn2MTrR/T70O9p7W57FuuMxrabfrVuwyfoaz9X0yl/n1txgYACyVZmP+VW41/1F2mCMi1eJIlNSIGj5pSgHh5IrNbn/qKT7V/vBn8DgqGqDMiTuJnzDdByfsXQCkQ9EimC/z9er3DKjSbvyYA/9orvP8VkteQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AM8PR08MB6420.eurprd08.prod.outlook.com
 (2603:10a6:20b:314::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.9; Wed, 30 Sep
 2026 10:13:23 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0472.012; Wed, 30 Sep 2026
 10:13:23 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Wed, 30 Sep 2026 13:13:09 +0300
Subject: [PATCH v9 10/18] vhost-vsock: preserve vhost FD during CPR
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-up-vsock-vhost-v5-v9-10-e9096f629770@virtuozzo.com>
References: <20260930-up-vsock-vhost-v5-v9-0-e9096f629770@virtuozzo.com>
In-Reply-To: <20260930-up-vsock-vhost-v5-v9-0-e9096f629770@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: andrey.drobyshev@virtuozzo.com, clg@redhat.com, mst@redhat.com, 
 sgarzare@redhat.com, maciej.szmigiero@oracle.com, dongli.zhang@oracle.com, 
 bchaney@akamai.com, philmd@oss.qualcomm.com, odaki@rsg.ci.i.u-tokyo.ac.jp, 
 farosas@suse.de, mark.kanda@oracle.com, dwmw2@infradead.org, 
 peterx@redhat.com, vsementsov@yandex-team.ru, den@openvz.org
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VIUP296CA0066.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:337::10) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AM8PR08MB6420:EE_
X-MS-Office365-Filtering-Correlation-Id: ebf25e56-b628-40a3-df62-08df1edb757c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|23010399003|366016|1800799024|10067099003|56012099006|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: zU7QXdmGIwL92Hvr9yIAOQ6CfGej2I35TFAPeUIDP6lARIp9O5D258ZfI5KhwrNSbnlMWfdsBLAQW+Lrh9BqRU9IAs6q1/BjDX/NB2jl6g5J43AH3WX5Fu85PCGF2ei0OcRIff0VFneMHBD1Oho7rKKKP52hZgSBlsyErB0uBFb/P4X0ET29Nw50DVKynldmeDRYqMlA6UX1p4AInxw77oD8IO+V/Ou62q1oqxovlJRnS8fIQ5Mvheq05OXC18bOkLlbRTuETedJz8maxZh6+5CI2MhRlr2smkrXndVr+u/63Yzwu01qqwnE5k7SPKKxkMQXaM6aqwisYHy2HaGcZn7ghETRvJlXwWC+oxI3q7MP4FfvWeoDCmeEOehLMjsVk5h4OnNeAPD8MaTiSjSw0P3ptfGzZxTt2oCMrDfoh/89nB7x3PceurHgFNX8yIdHBdygIxdRUEyMRkDw8jpBwETS4kQc5FGIJPTMy/yMh72RSa4i4zZyaVEjq+F3lIqXqEj0E8hKgASdINwtYq1XkYDCrxYbORWl2T9JSR38QXMySvZ+lv7qDIC1Sx7qjT4blusb2FAqWH16QVMQQrCfedsORKfh8x1s785819MNDm1+EtPGUFtX8volshWLP9/BHvkKsOyEZvXt/Cnv2LoQN0hiLlPXMAFbhqvwRkj7K8BZTGEIoJd5WUHJp0g9dSvEljnw3zSOs4PgCAZ9rMvQUTt/j2nyuhW21/JfJeZOd20=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(23010399003)(366016)(1800799024)(10067099003)(56012099006)(18002099003)(22082099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDY5djRVMXRNZEthMExVRERsRTRrV2wzQ0N6bDE3YklhOTBFZy9WMkVLcUtV?=
 =?utf-8?B?c0NWWGxyQXowRFdocFNrMHNxK3N1eGxPczJWaFdVdEF5cEFtVFdIcFY5MFdo?=
 =?utf-8?B?RlVEMzZkMHhzd1BJclVWRVNGb0NDK2k3dU9RWGhOdWkrVWNNcExSeDN2Q0d4?=
 =?utf-8?B?YTJycHJ1WlNCSFFmV1hEKzVwTksydWJBMTB6K1YrOEdDcVV2eG5tektGQVhC?=
 =?utf-8?B?WXo4alBFL3lkTmwrY0dXcVR6WWY1Yk93US9jQklZdHg0WUhIaUdndFFVeU9p?=
 =?utf-8?B?SUFyZ040bFNaRHBVYWVuYkQ0SDd4NW0xTDZpdklvc1U3Q1ZKaUxVZVdpMXE0?=
 =?utf-8?B?dE1MWkF1TzdMWFB1bFNQNWNjeTNKVW5vbGM4SWM5bmI1dVl6d2UvbVNxNE95?=
 =?utf-8?B?UnRlaVJCY05rM0dKV2xReDFUNU1SVUtSZGtxNTl3Q1RySS9OcHNXcTBodkE0?=
 =?utf-8?B?ZlliN1B3b0JIaWd6YVpoTnV5UlJnekZnOXFLQVcxc3VhdERNeGVZVndnSTVv?=
 =?utf-8?B?SER3QUtpSGxwMEhTYjZUK3JmN2d6Mm55NnY1Mm5kS20vY3dmL3I0WkVaTHNq?=
 =?utf-8?B?RXVPQVlYaFBmMTVxay96MUZFekRka1k5RDZ5U25Xc2hvZ3hnQnRRQkZYRjVB?=
 =?utf-8?B?ZzV4eHlRU1Y0dytENGtoUjdVWHhQQjZaeDJJcktzU0pmeWxNdzFZay9VRW4v?=
 =?utf-8?B?UCtobTExZ2U0YTNMczlzcDdBZ1pIT1MrUkVkVlN3WXF6bnU2RzE3M2JJeUZB?=
 =?utf-8?B?TWJzcFZBNU8yUkZlUlJuL2luMWRoSGhLMGxyN29XSFRoUi95M0N6VXpmVjg0?=
 =?utf-8?B?S3BsUUhyeU9FbENuWkpHZjFhZ1Y0Rzd1QXptT3JuemY3Q25wa3BTMmV4cXd5?=
 =?utf-8?B?UUFJYzN5ZW40ZXNlRDJxb2RHQjEyK2hXRi95bXZXN2VEMUZyc0lLZ0Jod05p?=
 =?utf-8?B?aDlzUFBHcnl1ODU2TXBXR1ZNaExabXhkd2ZPZUpJb3JTbC9qOTFJRlFvZllC?=
 =?utf-8?B?VVBYamx6NUJpZncwQ21FeVBBMEFPZngxZlBtZG83QlFvT2R1ajVQQ0dCcW5u?=
 =?utf-8?B?NU1vYzZGQVdGV3BWSzRhaG9XekRjRmVtNk1IMFE4TGZhYnVEMjJCc25zZjli?=
 =?utf-8?B?Nm5iV0prRzRCRElWTE9sWEdRMWM3d1pRQWgzNGUrSVJpUGRhU0F6aHY1bkg1?=
 =?utf-8?B?NUhiaE9OMnMxOWlaUXFST3EyTVJCZExSenhvVU9BRCtNN05uZStRQUY5djJN?=
 =?utf-8?B?NjJHUm0yaTlGVUoxSTBFcVVoZUpzcVRBbDUvckJrTm9oWkVLWDJvWEtMaE5t?=
 =?utf-8?B?WkhkeU54TjhhSGZBVFNRMUkzTlh3K213NmdNKzJaY0t3VEJVOW1nZ2xDdVNC?=
 =?utf-8?B?czl4MmRHQWVjWUgrdk9ranBXNTZGWDFINUl3dXBaOGltZjJVKzdvSmdUeVdH?=
 =?utf-8?B?NjJ0QTRGVHgyZ1haRlMrMU5Da1Y1SmZLcVN6MURBQzZFQ1B4R2RDaE5TRnAy?=
 =?utf-8?B?Zm1jVUlqV2hkVXA3QlpUV1BQaVd0K0xXMHppNUFxMjJTWTg5M3hZWklhTExV?=
 =?utf-8?B?aFB6dFVhR1VBaW5NQzIxbWVnR01YMEoraU5Ka1RnbWwxMXFzZ1l6QjZoQTA0?=
 =?utf-8?B?Y080WVc4M3hnNHBYalErdUpyQnREWksrQ3NkcTFtR1EyYWhJd3BXaCtjOCs1?=
 =?utf-8?B?SXNpUk52cnkrZlNadzBnUWVDaUxHT00yUlNMTnE3WDJJc3VQZHFwOEpqYzR3?=
 =?utf-8?B?MDJkOFBCMUJIY01xVldSdnVGSy90RWJ4Y3JHYlQzUVZ1MlU4Y1YybTZDSFBT?=
 =?utf-8?B?VlNqejBZZzlzbDVxMHZ3eDhPa2ZJaVNaVk5CcFdRdFR4bWdpY1RzSmZSY0VU?=
 =?utf-8?B?TVVXRGJnVnROR2RYMXMrWnNyK0E0WTlsN3VTL1dTbHlXZzE0UUR1S0wvTHVx?=
 =?utf-8?B?aTFJdWdjWUw2a25hdldaNmQzY1VkbGw3SEllSnBtRDN2dEpSNWYrQWNYWmUw?=
 =?utf-8?B?ak1PemFPNXAyVTM3NDJIL0h2SlpEY1YwNUVHdE9DNDRubVRsYWs2OWloVit2?=
 =?utf-8?B?ZGVPNGJkTnp1ZVRxb1JncmxrRE9Ud2Y0NjR2RWRpM09uTFN5WHFWMWxBdWNi?=
 =?utf-8?B?MnkxMkRBeGJtTUxoSkxpQlBhZ3RhcVVqZG41aXJ4eVNnVEhWdzRWNldxcHlT?=
 =?utf-8?B?OHNRR210bDRrVkRvOEJRRkJDaGN2bU5tWjQ2TURTdUJsVXZCK0hRR2ZRdzVq?=
 =?utf-8?B?UGxiWVVGMDNpS0hxRUhSS0NJbXZpdHhLNU55U1dnNWtGaStWT2pjY3E1a3oy?=
 =?utf-8?B?V2h0b25sb05FeWMwa09ybk9waTdBQUxjM2FPNHV3SUhnNTVVQWpTMFZwWS9H?=
 =?utf-8?Q?xrEDL/R6I2hYIcZc=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebf25e56-b628-40a3-df62-08df1edb757c
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 10:13:22.8521 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9qQh02ykRshcf8IzsiTkkqrvpWv9wq9xauO/k0Tdc4XGltGs+l/P0E1noSrBh3RtId154BkD/KCt68Mj765IWhgezq7ANVYerhw+axyaLjY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6420
Received-SPF: pass client-ip=2a01:111:f403:c207::3;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=MRWPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

During CPR (checkpoint-restore) migration the guest keeps running on the
same host, so instead of reopening /dev/vhost-vsock on the destination,
we should reuse the FD from the source.  The FD is saved in the CPR
namespace (hash table) with cpr_save_fd() and then reclaimed on the
target via cpr_find_fd().

Use the (suffixed) device path as the key in CPR hash table.  Device
path is obtained with qdev_get_dev_path() and is essentially the
device's address on the underlying bus.  As any vhost-vsock device is
attached to a virtio bus, whose .get_dev_path() forwards to the proxy
device, and every proxy bus (PCI, MMIO, CCW) implements it, we should
always be getting a unique non-empty path with qdev_get_dev_path().

vhost_dev_init() (and thus VHOST_SET_OWNER) still runs in realize() here.
Deferring the ownership handoff to pre_save/post_load is done in a
following patch.  Until then CPR remains blocked, so the restore path
added here is not reachable yet.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost-vsock.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
index 3ec20d87606..6e89007b2ce 100644
--- a/hw/virtio/vhost-vsock.c
+++ b/hw/virtio/vhost-vsock.c
@@ -69,6 +69,18 @@ static int vhost_vsock_set_running(VirtIODevice *vdev, int start)
     return 0;
 }
 
+/*
+ * Any vhost-vsock device is attached to a virtio bus, whose .get_dev_path()
+ * forwards to the proxy device, and every proxy bus (PCI, MMIO, CCW)
+ * implements it.  Thus qdev_get_dev_path() always returns a non-empty string,
+ * which guarantees us a unique CPR name.
+ */
+static char *vhost_vsock_cpr_name(DeviceState *dev)
+{
+    g_autofree char *path = qdev_get_dev_path(dev);
+    g_assert(path && path[0]);
+    return g_strdup_printf("%s/vhost-vsock", path);
+}
 
 static int vhost_vsock_set_status(VirtIODevice *vdev, uint8_t status)
 {
@@ -143,6 +155,8 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
     VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(dev);
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VHostVSock *vsock = VHOST_VSOCK(dev);
+    g_autofree char *cpr_name = vhost_vsock_cpr_name(dev);
+    bool cpr_incoming = cpr_is_incoming();
     int vhostfd;
     int ret;
 
@@ -170,7 +184,14 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    if (vsock->conf.vhostfd) {
+    if (cpr_incoming) {
+        /* Reuse the fd handed over from the source QEMU */
+        vhostfd = cpr_find_fd(cpr_name, 0);
+        if (vhostfd < 0) {
+            error_setg(errp, "vhost-vsock: could not find restored vhost FD");
+            goto err_blocker;
+        }
+    } else if (vsock->conf.vhostfd) {
         vhostfd = monitor_fd_param(monitor_cur(), vsock->conf.vhostfd, errp);
         if (vhostfd == -1) {
             error_prepend(errp, "vhost-vsock: unable to parse vhostfd: ");
@@ -186,6 +207,9 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
 
     if (!qemu_set_blocking(vhostfd, false, errp)) {
         close(vhostfd);
+        if (cpr_incoming) {
+            cpr_delete_fd(cpr_name, 0);
+        }
         goto err_blocker;
     }
 
@@ -207,11 +231,20 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
         goto err_vhost_dev;
     }
 
+    /* Register the fd for a future CPR after a fully successful realize */
+    if (!cpr_incoming && !cpr_save_fd(cpr_name, 0, vhostfd, errp)) {
+        goto err_vhost_dev;
+    }
+
     return;
 
 err_vhost_dev:
     /* vhost_dev_cleanup() closes the vhostfd passed to vhost_dev_init() */
     vhost_dev_cleanup(&vvc->vhost_dev);
+    if (cpr_incoming) {
+        /* The fd came from cpr_find_fd() and is closed now, drop the entry */
+        cpr_delete_fd(cpr_name, 0);
+    }
 err_virtio:
     vhost_vsock_common_unrealize(vdev);
 err_blocker:
@@ -223,10 +256,12 @@ static void vhost_vsock_device_unrealize(DeviceState *dev)
     VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(dev);
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VHostVSock *vsock = VHOST_VSOCK(dev);
+    g_autofree char *cpr_name = vhost_vsock_cpr_name(dev);
 
     /* This will stop vhost backend if appropriate. */
     vhost_vsock_set_status(vdev, 0);
 
+    cpr_delete_fd(cpr_name, 0);
     migrate_del_blocker(&vsock->migration_blocker);
     vhost_dev_cleanup(&vvc->vhost_dev);
     vhost_vsock_common_unrealize(vdev);

-- 
2.47.1


