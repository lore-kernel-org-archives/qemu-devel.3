Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37470CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:50:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENwX-0004JK-6Y; Wed, 07 Oct 2026 05:28:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xENCO-0001NU-0A
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 04:40:42 -0400
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xENCK-0006wV-II
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 04:40:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rvNQ/w4RLrUM91uR55lJShk3XTVdoxhhriZ79Uf0XATxuhJeq/2ZsnP77gCD1ph0zEnu8fRAzUy4W6AM+8nt/gKW4ykg/WOS1o3CRHueTUJwQaTFKrEPp5rmwiPp1Q3iPYa3OGD5zWAr5r/Oy8y1uV2yZb/IGd25JpS1UPsw9AXyh72xhxg/ZC+WvUlAYzWC9/xx9cTiNcn6HnNcaG5xZt0qLTg1uisR7g0yeeQo0WN9R9xjNg/0DlYU0qHhM/t3lsRJZdrQ/GcZPYEVlx+lTpGgluh2PCjhtlnZ7XfI5D+39A+4f1lFTJdofZYwMO75f/8rSdpSb8uz5nQDHyt6dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V6q2GHBgHdJlc3pvGu4nrnjI3eiXCruumbkNRO+iAT4=;
 b=ITRdYAlRgKy53+5tIYIVuPkLAhNjVyWpL0VcR7ar92B0i71yv0u3LTfTG5WqskLPD5sLp7LCdlaJ9dgZTJnZvlQ9BskQLwQqfSEB4a7vQi1jXGN1pfMqmQ/R4tW4OstZPnlWGgmCruZD6HGjKAaSKkC1vCv3/iiMJ9tmjLCr4yrm0xPH582MdLRV0SjgpSEOghB+WRPIYLp8WSpu1YiTOSoHjMGRmItyUbgeg0tN95zs1zkIWxllxxNg80FHKHwGviIaZn565l330xL++1jj3cc7GDWlNGupVzlW7g0Ew6j7odJNU3SPf1l5KwPj6enCfEwREWAdSbThsKfA+sCgnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V6q2GHBgHdJlc3pvGu4nrnjI3eiXCruumbkNRO+iAT4=;
 b=OhIz/HNMD6vbb98KXhM1HXW/rM6MLUEK2SfBH7q28ZDf5FxN3PP6lzoz79g9aZh3dcsyiJCRM+Nwgs4A7lNTpmFtYuKSbG+RtrCOhLz/6XQlVemxgxjGLCo9IYlLM+wZnWPz8KBHxe1bLcaoMJm8jgyyxaZfisyQEw2ol7F46OqHqs+/vTjIbsjpP7GFrY3lplRLMQxotAdm20RWN14bvBxX63/P8JkhzAlFlw32XzgJG8ubrjUPKOICGGZ4I+NAiQHsDMFsWoSuR4S88gp/PvZuWb6ZDRjLrfwHDjHCUe6906sBgC97FNqnjuPJG5WRe29zhucOpCBOu5aXRjqfQw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DB3PR08MB9058.eurprd08.prod.outlook.com
 (2603:10a6:10:430::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 08:40:09 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Wed, 7 Oct 2026
 08:40:09 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Wed, 07 Oct 2026 11:40:10 +0300
Subject: [PATCH v14 17/22] vhost: release ownership when the incoming
 migration fails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-up-vsock-vhost-v5-v14-17-e16de9962df0@virtuozzo.com>
References: <20261007-up-vsock-vhost-v5-v14-0-e16de9962df0@virtuozzo.com>
In-Reply-To: <20261007-up-vsock-vhost-v5-v14-0-e16de9962df0@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: dwmw2@infradead.org, mst@redhat.com, vsementsov@yandex-team.ru, 
 farosas@suse.de, peterx@redhat.com, dongli.zhang@oracle.com, den@openvz.org, 
 andrey.drobyshev@virtuozzo.com, mark.kanda@oracle.com, sgarzare@redhat.com, 
 maciej.szmigiero@oracle.com, odaki@rsg.ci.i.u-tokyo.ac.jp, 
 philmd@oss.qualcomm.com, bchaney@akamai.com, clg@redhat.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI6PEPF00000236.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::8ee) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DB3PR08MB9058:EE_
X-MS-Office365-Filtering-Correlation-Id: dd67ca52-288a-43ea-fe2b-08df244e984d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|376014|23010399003|366016|1800799024|10067099003|56012099006|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: x81zsbfkUdxFznyrJR3hYamlG4qR7wKLV2J9lVNGBue/oC+Du+3/bgl6fLR1zvwZG9vpWQHQR68zvXpJ5YGcuo+z0b3NpuPdVdGwwZLU6YW0bb2rQdYRmYWnKks0tmEAbKvECpY/6SKU0H9nq4ObRFAxSbh4zYlEI08Jc+DN33A91sHq7r5r2Pp4Nci/FwszQrEeqZnzCsgcfgJLPseVgPtz5MMrPGfSUKzi9M7KMxJIDfNmuV7ds+XrTokyQl+bM/LLS437/ZIpi4tWLb5xApe7bVo0czh/yKIp+LnIfbl5ai4lAGEs2bO//US0cKdoT6k7pUZHOsFUpDMaYpwYBkuH1M7ss51aGPQvd+49VdfT5/gljraQTV/ykcaFNHqzcBPjOeeh0HT61uN04KzgE8elDNE9e1Zo54PR7OYwr2iK5k8AgjPK4CAXlnblIdO4G+z6t7j5qc4XWAyC50YYRx9ACnx107GgFsLq5+gDHG2vAQNTxmuevw4gTtWF1KnHmVrE24jcPTqktch786gDnY4QOOYP4IW7N1mNQ8j9hPiBYrEZB4iijbaC9lqR4jeO9LbyW8vVJvCH6A3bHTCcGzsQJcB/zcXTMN2BX9Bv7SJfYI2wR2wq0NHhAqItduPIwY2jK1EZ+2ceUYCYO3B7/mV5Z4Cebu7pk5WfWjTPz+VfzXLnTYoZ1ii9kJ2vrIiSeqFYPpZpUnoROGIPnNDIww==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(376014)(23010399003)(366016)(1800799024)(10067099003)(56012099006)(18002099003)(22082099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmlHazRNUEh2bjhTT2M5VVVuaEVGUnJPOXJDMmtxWTBPQWVjd2dEaFBoMDBl?=
 =?utf-8?B?SWRJZVR6RVlYRW15emJOb3lzTThyejlyaElZK3k1NXgzVzczdXB5TDVoN29t?=
 =?utf-8?B?aDZuQjFSVFRQYWttRGNFVkc5SjUrTmg1aXZKZWw2SVlUbzh1T3luVjdieHlq?=
 =?utf-8?B?eXlWMW5UdlhMUHlSeEh4NHY0S1V5Q2Z5c0c0ckpJNFR3czdMNEY3WE0yOTkv?=
 =?utf-8?B?Q1djUjZJQ1dGWGpOeFJob1hTaGEvb3d1Q3dJMDBDL2MvMUx6clR2cENQQTNy?=
 =?utf-8?B?eUlmbUl4RzRvR1hPaUVBZkMza3phR1J1OUc3aTRObjFrU3FJVVp6NW16TTE1?=
 =?utf-8?B?eUdmNVJPMmpwWVhoa2JGU0hXSEdkSEd4K3cxVlVLNU5BcG1Id1VEbE1IQ0tX?=
 =?utf-8?B?WTNNT214TlVQTVpMV3RIa2NIY1MvbGxPZ1UrMStIeFZGUk8xS1pRYVJ1ajRa?=
 =?utf-8?B?V0RtT1Vzbm85dE1BQnZUUlBrdzJuZmx4NjRrWWVxR3ZvZXNHT0VGTjdDcnlH?=
 =?utf-8?B?WWNsdXJvSFZ3OW9vU0N3QkYxSnZsa1FPSzRVZXVqT0JmUytJTnIzNlBlTlNB?=
 =?utf-8?B?NlhQUGRBYjRCanZYZDhzcWRMaEZJN2tBN0FQV05tdnVYck1pVW5wbk93OWps?=
 =?utf-8?B?UUY2SW04dVREZnh3dXRBaWRpNUVmbmxPQzV3SXJZSzNWMWx0S0hLMWYyZGc3?=
 =?utf-8?B?MUVjOFlITkR3VGdhaDU2Yy9oYU5Yazh3R1o4RHBCL3NUWCtjRzF4NlZ0cE83?=
 =?utf-8?B?ZHNoTEpRSVp2L3IvdUVqN1R1VFZJQlhNSVlCMnJTYjZPL2hCbnhkeUdvSUNR?=
 =?utf-8?B?eHJFdGJ0OHhwNEhucTl6SGlCS2haaWdtQTBKenpvTldRL3F0aDhVdFBwNmIx?=
 =?utf-8?B?NmNwTUd1MWliVlVjckN0WHU1UVVzSjdLWUxvMFV0ZUpucmUydFhCUm5CR0VC?=
 =?utf-8?B?VkpvOFU3d0ZLSEFGelNJOG5sQlhYbFRSdEhYZzgxRGh0R1VKY0NQMjlFUlpv?=
 =?utf-8?B?c3FlK3hvOXh0WUJWZFA4Mk0rcDNXZFMraW9LY2VQVkJvY2U3SEZMWnpubmsr?=
 =?utf-8?B?RHpRajN3Q2h0YUwyVVd4cVlYNTBLb3JVemtHRzV2TklxcElaVk5PeU54YVp1?=
 =?utf-8?B?TjV2UnZ1VnRTbVV3RzBPWDdSRzY1Z1FJTzlyYldOZlBpUTJreFFNT1dWS0RB?=
 =?utf-8?B?OTFKNU43MCtsM0Y4VzlDZXkxZEIxbCtQeDdYMXhOUXFEWS83cUtFZm90MlZw?=
 =?utf-8?B?SDVWYnZiYmp5ZHNlYzdEenZxMGt3QWMvdzU2VnBRNzd1bmEwL3BWR2M5dklp?=
 =?utf-8?B?TkdOSEdGYjBpV1dYalMyNWdVOHdYcUdyYVhqek0yRkcvOHdPeTRQK0pVTGVi?=
 =?utf-8?B?VEZ4aGl1dmw1UFc3bGowbjdTOFZ3VnhVbUpvYVZ4d0MyaXdFNVhKSTZQSEMr?=
 =?utf-8?B?eTR2UU5UOEY3MXFsZzFqcUxTOStOYXJNOWRpMXBpbnd5S3Q1VTdyNExpUDVr?=
 =?utf-8?B?SkwvaVN5bDdaRmFubWFwR3dTZ2FkNW5VZWVvbE1XMENIcURmNUxNNFRJcFlS?=
 =?utf-8?B?Nnp2NXZSOUh6VHBubUtDS0JOQWN4Ry9ZaGN4NnZDdDdpT3BpcURDci9VNzc1?=
 =?utf-8?B?d0hUNmVQMkZKVzFmaXFteU1ZYVlIVlJ2dkovdkpsVThqa1FuandaeEU3ZU5F?=
 =?utf-8?B?NzYvdG1Oc2ZrMWtiTkJQejZvYm4vOHRLbURTeTAwbXNXUVpoVkNnaXk4WkRa?=
 =?utf-8?B?S0NTSHlxazlpZ3RncjZyMk5HeHJkSWdUbE5mMnkrUE43RmhRaEdzMFZYQ1lV?=
 =?utf-8?B?RkVhRmVmbGw1V2tsamYrMUtraGtJT0dkd0VmQUxJdElmaDFpeGJCTjQ0YjYv?=
 =?utf-8?B?dzEvYVczcEZQVGYyd3YvL05vUEJZVFlHNEdYUTBobmtYa1ZhdEVHNmhDWlM3?=
 =?utf-8?B?UjNVMzRhMlZiNm1ZWVRGMnpqdkhRWTQrbU5WU0M3MjN3c0RWb1ozZngxVTJH?=
 =?utf-8?B?M0Z6OWtEK3lVa3lEQ1RmTDdoOUxOTDRkcThiWnhZT3o1dlRlcFdkTWI2VDVH?=
 =?utf-8?B?YXo2eTRUeGNaM0FpV2pCU1UyWnFOL3Z5Mk5GUy9ySEZ3eTlnK2hnTVlPTkZQ?=
 =?utf-8?B?bFhDb1JRUEljRXAwYUZmczhFNFhBQXdnaDBUSXpKNVFnWHFOQXBwc1BnV2Nq?=
 =?utf-8?B?Y04wODZGYkJqYUpxWVM0SWpOYTBJMmE3b1RQUno4NUhQRHk5b1ZLQ3ZNSGhl?=
 =?utf-8?B?U0hnUjhsNkloeHM3RW45S3RnM1RrejZlV0pveWtodjZQMUluczQyNWQ1aWcx?=
 =?utf-8?B?TTdMVExaa0YyWEpoRkNQY0gwOFpCam5wTktlRU5PZ1lQcjcrNFJBcjlEUjlT?=
 =?utf-8?Q?rjydOhZZ7eFH3dcY=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd67ca52-288a-43ea-fe2b-08df244e984d
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 08:40:09.2033 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bjsHHV/tOk+GCWJX1Jv+XXO+eSqiTrrvdTWwrDc1sVXXGk9QPtAJcw1VtiO6dhBL/Pb/lfTX8/B2hGDOpL/wxxpBxGu4tbJDPodzvyXtIsg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR08MB9058
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

A CPR target that has taken the device ownership in post_load() doesn't
always reach vhost_dev_cleanup(): a subsequent load error, e.g. a
truncated migration stream footer, makes QEMU exit() right away, and the
ownership stays with the dead process.  The source still holds the FD,
so the kernel never releases the device, and the source can't take it
back after being resumed -> SET_OWNER fails with EBUSY.

Releasing the ownership at exit isn't enough either: with the
return-path capability the target reports the failure to the source
before exiting, and the source resumes right away, racing with the
target's exit for the ownership.  And with exit-on-error=false the
target doesn't exit at all.

Add a migration notifier to each vhost_dev, registered for its lifetime
for the CPR modes, that releases the ownership if still held on
MIG_EVENT_INCOMING_FAILED.  It runs before the failure is published in
any way.

Reported-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost.c         | 25 +++++++++++++++++++++++++
 include/hw/virtio/vhost.h |  6 ++++++
 2 files changed, 31 insertions(+)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 3432b9a43c8..36e82bc14f0 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -26,6 +26,7 @@
 #include "hw/virtio/vhost-user.h"
 #include "hw/mem/memory-device.h"
 #include "migration/blocker.h"
+#include "migration/misc.h"
 #include "migration/qemu-file-types.h"
 #include "system/dma.h"
 #include "system/memory.h"
@@ -53,6 +54,25 @@ static QLIST_HEAD(, vhost_dev) vhost_log_devs[VHOST_BACKEND_TYPE_MAX];
 static QLIST_HEAD(, vhost_dev) vhost_devices =
     QLIST_HEAD_INITIALIZER(vhost_devices);
 
+/*
+ * A CPR target takes the device ownership in post_load().  If the load
+ * fails afterwards, release it before the source learns about the failure
+ * and resumes, so that the source can take the device back.
+ */
+static int vhost_migration_notify(NotifierWithReturn *notifier,
+                                  MigrationEvent *e, Error **errp)
+{
+    struct vhost_dev *hdev = container_of(notifier, struct vhost_dev,
+                                          migration_notifier);
+
+    if (e->type == MIG_EVENT_INCOMING_FAILED && hdev->owner &&
+        vhost_dev_reset_owner(hdev) < 0) {
+        error_report("vhost: cannot release device ownership on "
+                     "incoming migration failure");
+    }
+    return 0;
+}
+
 unsigned int vhost_get_max_memslots(void)
 {
     unsigned int max = UINT_MAX;
@@ -1823,6 +1843,10 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
     hdev->log_enabled = false;
     hdev->started = false;
     memory_listener_register(&hdev->memory_listener, &address_space_memory);
+    migration_add_notifier_modes(&hdev->migration_notifier,
+                                 vhost_migration_notify,
+                                 BIT(MIG_MODE_CPR_TRANSFER) |
+                                 BIT(MIG_MODE_CPR_EXEC));
     QLIST_INSERT_HEAD(&vhost_devices, hdev, entry);
 
     /*
@@ -1872,6 +1896,7 @@ void vhost_dev_cleanup(struct vhost_dev *hdev)
         memory_listener_unregister(&hdev->memory_listener);
         QLIST_REMOVE(hdev, entry);
     }
+    migration_remove_notifier(&hdev->migration_notifier);
     migrate_del_blocker(&hdev->migration_blocker);
     g_free(hdev->mem);
     g_free(hdev->mem_sections);
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index f6e32b59ab2..14484b8de24 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -3,6 +3,7 @@
 
 #include "net/vhost_net.h"
 #include "hw/virtio/vhost-backend.h"
+#include "qemu/notify.h"
 #include "hw/virtio/virtio.h"
 #include "system/memory.h"
 
@@ -116,6 +117,11 @@ struct vhost_dev {
      * Updated only by vhost_dev_set_owner()/vhost_dev_reset_owner()
      */
     bool owner;
+    /*
+     * @migration_notifier: releases the ownership when an incoming
+     * migration fails, vhost_migration_notify()
+     */
+    NotifierWithReturn migration_notifier;
     bool log_enabled;
     uint64_t log_size;
     Error *migration_blocker;

-- 
2.47.1


