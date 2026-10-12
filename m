Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCB5CCA9ED0
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 10:29:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGDHe-0007ra-El; Mon, 12 Oct 2026 06:29:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xGDHF-0007f7-Sq
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:29:09 -0400
Received: from mail-swedencentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c202::7] helo=GVXPR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xGDHE-0005Eh-0E
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:29:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KQaELBrRt/eVO7rOARWFFp3E6auCqEvOmXa9skjWGR1+F4h2z9TVmUxj5wEN2xslTBLu9bX3gzelhXRbcn4Oe4/bpaJOtezQhEuYSK00HzOJdsnREQg8/rae2aXAxpvOgzwr4fQB2j0D8U7q8bN+qAYeqH/c9o/sc0JW0MKvpQhrNbeivb3BXOvGT8DD3Vxkf6k8CI9JG8wJfHjYfccEWX4m7wXfKXCFJ6jS3CCk8RaK4AajPOfwWTc3dFS9XEJlORcfKysD02eldIqwH49EPLd/T9+kcc/7ibxh5NrLMK1BSGmwVDCW9uK3NXI8Y7SQc7oydYukRavqf2kY3itOlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KQgnkcViSHs3Rahhzmph6ktL2+UOz0MojTzm/dDNgZA=;
 b=QKczJEs4QKh66nJ3a2/Y2HwSFF2RZkip+uVbuuLnQTkqOkNNAwZciBeZZpyif9WEb0JN8jnv+H8pPScLWNkRo2HdCdzW4lS/moySWOSzFM0OMhVYhOKc3Lua07qRTiajJ/H7qxtGhkm7F6tRe0brN8jZaKv1wCwERUrwzzXg5i4FQE3/UhplE+CWAh0lqNsHMI5vOvVh7WuHriV7vaj1bEDJ9LJ/CB5cPVxtrejUE9quMdDdA+ken6nDZg115ftz2YbeA91jc/bXMpK5ofENrOQ6DIUlES54XZuA8ZrkNuuSiV7LOxwOR6kDxB8BcIGe1Zojiy2NhOkm+UGEBO9ryg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQgnkcViSHs3Rahhzmph6ktL2+UOz0MojTzm/dDNgZA=;
 b=RevetBraq2Y48jDVTUzBL8sSx2Q9yOuECDYpNedeXEZs00AJeoH5u+a1M0wfLVAhyBvU2/oOPAGoaSc9ITauqdHO+d39fSeZxOCiMbJK818QITMvFtZGDIvQ3HyEDGlDH6Et+5TpwNtcOMwPKL5UCAR34dSKw3eIzwSyepepGWigLyVeepXWjsheoJnhaGVFW7N1YZ2qCPENp6K7jsJq9pnvAP7D+8++7iWdcLt+KiphhlCcCQSJcMlL9ibpLTV6DycH1Z+ENb++HQ8MgVyqXwcV50aNwOwPhIk2j6wy0Tdg6TckD0hAwPp6HB5Ip0tiSWcmZPfs5Uv+tAY6BuIYAw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AM0PR08MB5523.eurprd08.prod.outlook.com
 (2603:10a6:208:17f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.11; Mon, 12 Oct
 2026 10:28:42 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0522.008; Mon, 12 Oct 2026
 10:28:42 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Mon, 12 Oct 2026 13:28:22 +0300
Subject: [PATCH v16 14/22] vhost: add vhost_dev_is_initialized() helper
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-up-vsock-vhost-v5-v16-14-36c38bd15ffc@virtuozzo.com>
References: <20261012-up-vsock-vhost-v5-v16-0-36c38bd15ffc@virtuozzo.com>
In-Reply-To: <20261012-up-vsock-vhost-v5-v16-0-36c38bd15ffc@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: odaki@rsg.ci.i.u-tokyo.ac.jp, bchaney@akamai.com, mst@redhat.com, 
 maciej.szmigiero@oracle.com, sgarzare@redhat.com, mark.kanda@oracle.com, 
 vsementsov@yandex-team.ru, clg@redhat.com, den@openvz.org, 
 dongli.zhang@oracle.com, farosas@suse.de, andrey.drobyshev@virtuozzo.com, 
 peterx@redhat.com, dwmw2@infradead.org, philmd@oss.qualcomm.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI1PR03CA0043.eurprd03.prod.outlook.com
 (2603:10a6:803:50::14) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AM0PR08MB5523:EE_
X-MS-Office365-Filtering-Correlation-Id: 32c80613-0f2a-4f22-b3af-08df284b968f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|1800799024|23010399003|366016|10067099003|22082099003|18002099003|261009223027099003|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info: WwTaXCMIdZJSUl4+sp5DmeZ4gO7apppGlOa/fOOdcEhHsmDjlNY2Y0/gckvxG3PGJlmMxJCZnReASB5KlJfDjdxVPT0Xq7w8/5rgv98vEYrsxDsE8rnGvBFUhTNn1nR0dC6q+xs+5fgNeDCvlOy/zrdBr8IY/HoMiAGPdFxAiR/brFKv9fGQn7Vhl7JglEj+qNXyC3MjQvB5eWe4GM5+CluKjoDnQ6HWmR+yBDeSJFWtMoK0SZP+hbqglAz+lCECsBqmeGtc3mRmMQ2ug9kevqcmCsJWUZjoWFCuZH4fRt8z5oF25eR+PKGdx/rkdka9l6DaDa9yBt4dbvhZDm0K30bUhqnM5mXQy1Kyql9HP5TIM/ZX1QOX8n9gk3tR64R18M6lSHGDfQwjlj7oY7CXzRMbsM+QpiXnpgvz25tAF7tT5MPP1ZqTg7bJ6CPMUfqv/RswAJvsF5WuJiCg+srgKvXcvzInM6gxW0/0xJVelhhmyowMQpRomKaJWcYLmidCJCciFiFhYGgTf49mdOMa9TEDLP2vXb4Q9fhEQOL+Qka13y37DF+dv0qJWiEp37JNSPr37cQy7IcbJQ9724k1w+GWV6GFgvb65d/KtzrtmZ3n3usqkZ/gy1YO8YO0MMeRt4voknQg35nodyURQdFHd8YbyxGun9Jxd14IpuPBOklZwFzIQLms9vp+3IECKlHDvNuTRy3rFyYZz/0kqcLnwsluIErafEhDvEPklrkgq0o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(23010399003)(366016)(10067099003)(22082099003)(18002099003)(261009223027099003)(56012099006)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTNicXA0Ty9kcE82R1YxazYwWDBFSjVINW1lK21LcHoyL0ZRa3ZWSzBkY051?=
 =?utf-8?B?M0xsMm42bTV4RUJ6WnJoQ2tMdm9ad3NrLzRIbnFHQm9iZ1VCN0JIVjlwSjVm?=
 =?utf-8?B?N29GS1o2UEZYTWYyOHZLK3YrV3JjalcrbVB0YlNHYmdTR2VQc1F3QTZjeU9K?=
 =?utf-8?B?MGdBMHlMQUJBUTZQcllCU1ozbmRPbTdKNVFzdmhyaEJNWmhqVkFRcUYyemlp?=
 =?utf-8?B?NlBlYmRzZWVLNXdNcEtyWThHZnBIM1RsMHZYSzNGRGhwMndPY1Q1d0g0YmVD?=
 =?utf-8?B?c2l5aC9tckVhUldrMm1XS3ltZXRYOHovY0gybW5ya3ZYaHJ4SXovRjV6eUNQ?=
 =?utf-8?B?VDZCV0FuazlIemhVMVd6QWlxcjladWpzZ2JmaTVQdm45NUNsU3JLNUZSQ0lQ?=
 =?utf-8?B?NG5rNHg1Mmw4Unl6NExtaXM2R0gvU0hINWFMYm1qQlU4d3YyTWJSUzlLL2dU?=
 =?utf-8?B?OWNSNll3MjRUdUMxckUxNW9zb3dPa2UxSFRYbEF1QmZaaklvSmFrMGsxd3ZE?=
 =?utf-8?B?ZzBpbWQ3WHJ4YzdNNWhzOHg1dmJpd09zSXZrdWxmb2k0dmllN1N2djh3aDk4?=
 =?utf-8?B?YzBPZXMybW1LbFlmWW50eEdDcXVDdE5pb3N1NGF4U1loVjFWMXU3NkdibkFz?=
 =?utf-8?B?d3RqNkxVMkx5NW9pNGI4MldxMUVudjV5Z3o1ZEc2MjliVXFRZTVvR3AxcXcw?=
 =?utf-8?B?M01nV3o2MXpzeWJ0Y1JxTVRnWjg4ZFV2cVNGU21YaVdER29JK0t6ZnJKdWp6?=
 =?utf-8?B?MjlqUFpRZTZvcDlMT1A1VUZ4cU9qcm00R3NndFpHSFcvWitiOHZvZml4QVlz?=
 =?utf-8?B?QXdKdG5vMlVtYlRRRjc3aUp3YmZod3VRNWF4RDJxUXNVZEoxVGE3bVEvTWM4?=
 =?utf-8?B?K0llNTVKNHc1SlVCYS9GMlFRdTdkUStDd3BkUFRlM2JtYmlUWEFXN05CdWJq?=
 =?utf-8?B?ZHlIYi83dGRUbkV6b0lDUzN1c2w2VWJWdEppbG9tUTlIaVlibXJQRk9tU3Vv?=
 =?utf-8?B?WkhnRk0vU1dIMHkrbFRlby93S0pNMnJReEhsREpUUzJ6ZTkzVndzNVNwWlFQ?=
 =?utf-8?B?Z00rQ3pwMXVaZGFsdEZPWllSZkw4S3RQL0N3U1RlS2xSTEdnMzNpUEZVbWxS?=
 =?utf-8?B?VnN4aGZKbEcySXhobFhReEVDbG5NMnM2QjlJSlREa002djVEY2g2VVRTUitV?=
 =?utf-8?B?MTQrV1hvcHZLRlZEK3FVMVZoTXNiUGlTV2lCQnVYOThnSnRtQjFPZ0laWjRG?=
 =?utf-8?B?QUErOHpzWnRqMmR1VzVLc2VVdUhVa3Bpdk4zTUtWcEl3WmJ4ZE9hRURRVGNm?=
 =?utf-8?B?Vnp3Y3RpWnd6TUhQNlFmVnZ5RkQ4Ly9CeWNPS2d6elBVbFoxdHZ4aVJYS1VX?=
 =?utf-8?B?QTNZdG1IejRmdDFVUVZ5SVhaRitPY3NHMktkanNpL2I0R2dBaEZkTUhOSklj?=
 =?utf-8?B?aFp2TWNnUG5YRTcrRUhXSHpCYkZHMXlxMnNnSjhwSUx2L1lMZGwxeEYreERx?=
 =?utf-8?B?SXBqWTFCZklqbmp3c0tpRzhoUmU3c2hCaWVtcGVlUW51OVgxbDRTaFRJenhI?=
 =?utf-8?B?bXJoU01tK3hRcml0ckVHdDk5YSs1YWZ2OW11bWtNd3hHTTM0SXI2SzExSjRU?=
 =?utf-8?B?ZmlWbEl4TlAraXpNbHovWGZsZ2thaFBBSVphZ25kMVVRVjVtekVxOHorYXhL?=
 =?utf-8?B?cFQ0T1dTSUhKTEYzYWFNZFc3R2FYbkRGNzR0aU9GOVFPZnNpMDhTWXV4eWN1?=
 =?utf-8?B?dXRaVUFjRTZQdEM1Snp5TUFTL2tBdngzSHR1bjBHQVlQZnZ6ZG9XUWZwaDlx?=
 =?utf-8?B?elhkdU1TdHNOcjJVUDRVZDdsNnhMYkZuVG9YRDhBbGNhdXF4b3ZaQzlGUXhu?=
 =?utf-8?B?RHJETkhUZ0FkMVhqVGJBaWNYbHZwaXNTMjgxY1FqNFBUeFhWTExkdzBsNjFJ?=
 =?utf-8?B?aU1pSlZVWWZmb1RIV0xMbERLWTF5M2R3VWdNNTE4SS81TzYydlIwQ2w5Nksy?=
 =?utf-8?B?d1pRRWdhaWk3cVBXS1E5b3BGdm5yZklXYXphNUxTWlJ4ZTluVGJyeFJyWUVR?=
 =?utf-8?B?THF6cEdiRTByMzhwY0JGYzh5S28yYzlyRUxRWVZSQUhiZmFLL3hCaGJzNDJ2?=
 =?utf-8?B?TTNVRVlGa0wrZWtPWjFERVVhcHIwMnR4TmdYZDBQVnpnWGFNdmFoVisvK1dv?=
 =?utf-8?B?akI1WUN4eTVvNS9BN2dVS0hNMWF4NFlIWUwvVW11cXQrbUhZTWJBb0ZXaStY?=
 =?utf-8?B?NkZnUWN0QjliaFN0Qld3K0xIR3BpVTdkUEdubzM4WXRQZjZmVktVSE5NWHhk?=
 =?utf-8?B?TGNRaWNRbVZaSmdiYTg0S2pCTXJnRTV1K0VMNGRXTWFxVndRbHlTUjA4UFJt?=
 =?utf-8?Q?SBrbZZTRoELwqXlY=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32c80613-0f2a-4f22-b3af-08df284b968f
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 10:28:42.4819 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jxh7xGDc4D8U/hZJhiHkUWrZvTu7de0v195ok5dqWGZr+OBVa9DuT47lQGnjLwham+vyrP3DFFcWP762fepXPMrySgTjTDK7b9Do6MaEH7Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5523
Received-SPF: pass client-ip=2a01:111:f403:c202::7;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=GVXPR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

The upcoming CPR support for vhost-vsock defers the full vhost_dev_init()
to .post_load(). On an incoming CPR .realize() only sets up the backend,
so we need a way to tell a fully initialized vhost device from a partially
initialized one.

Add an explicit 'bool initialized' field, set once vhost_dev_init()
succeeds, and cleared only in vhost_dev_cleanup() (by memset(0)). Also add
a public vhost_dev_is_initialized() helper.

Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost.c         |  2 ++
 include/hw/virtio/vhost.h | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 56fa4345886..c01ccc800cb 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1834,6 +1834,8 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
         goto fail;
     }
 
+    hdev->initialized = true;
+
     trace_vhost_dev_init_out(hdev);
 
     return 0;
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 8127a9a5a2c..73ea130d7ee 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -109,6 +109,8 @@ struct vhost_dev {
     uint64_t backend_cap;
     /* @started: is the vhost device started? */
     bool started;
+    /* @initialized: has the full vhost_dev_init() completed? */
+    bool initialized;
     bool log_enabled;
     uint64_t log_size;
     Error *migration_blocker;
@@ -248,6 +250,18 @@ static inline bool vhost_dev_is_started(struct vhost_dev *hdev)
     return hdev->started;
 }
 
+/**
+ * vhost_dev_is_initialized() - report init status of vhost device
+ * @hdev: common vhost_dev structure
+ *
+ * Return true if the full vhost_dev_init() has completed successfully
+ * (and vhost_dev_cleanup() has not run since).
+ */
+static inline bool vhost_dev_is_initialized(struct vhost_dev *hdev)
+{
+    return hdev->initialized;
+}
+
 static inline int vhost_dev_set_vring_enable(struct vhost_dev *hdev, int enable)
 {
     if (!hdev->vhost_ops->vhost_set_vring_enable) {

-- 
2.47.1


