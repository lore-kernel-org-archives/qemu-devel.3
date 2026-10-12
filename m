Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D97DECA9ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 10:30:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGDHt-0008Od-QH; Mon, 12 Oct 2026 06:29:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xGDHN-0007jc-EB
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:29:14 -0400
Received: from mail-francesouthazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c207::3] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xGDHJ-0005FA-6n
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:29:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XNoX2PaEqyu81WQMN9OYei++WpQWuUqb7icIGbs1OYto85LNAjhFnVJcgYzUHH6x1jblZkf2OrXO05UQksGhmjE1pXcbZSmmVQaOTH7nx3z+QTkQS9kOswvtJyMBCQ8rZSLiVcMA1Ava0tsZVsom8KuQzZIdWvItwmLW6YGW1rNtbiWXPTi6xJRC2ANprwyPWKVHlhoBHSNyBnMc/KA3Gspdm980ObDFPtqJmO4mHgpORir64XhoLiR876LTZBgxF4q05E01plvpIb1Gg3XVRgAG8p56OmuBJ1Hv6IG8K+zCpYjU9Ee6SO8C0R83sxfP7FTpQPz9XinBfpHyoYbPwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zuZ1L1/6fDMoqJD4xhpbWURBAK0zYGO/l+m96Q1DYGg=;
 b=g1DAyHlcb8Rw2kE5xT1gFedDUScEfgGtgEalXht1WpPK2MEVD0bwq6XYw2FNC7zUhFTtJcpnSuJvWb7505jUZry3sfHRtOy5x39/0YcDr23/75uf/lLtlpoxrOk95o+0e1LyyjKYk0J7+h5j9vSOgv9sy28nhV2YLWnS5xMmiAz9hn8ni+MmrosjBgdcdQURIaihnjqa0r3a0449pD469LwYHJ8gu+0pQ4quENLcNMcOa3qytjOOBVH0qdNxpLm9CnoA3M2LwPu5o7EKdqT/+Atp+cLF0sdalAfjm/zxR39wuCitkaHguZQyASMA6mDUEIXeb2ciGPzg1nY3j3vcvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zuZ1L1/6fDMoqJD4xhpbWURBAK0zYGO/l+m96Q1DYGg=;
 b=mkSG12HrkT9iPmYQsn5vT0eC3IwDu/u7Qo6L/jaYs5hzOQWE/fPxM5jf7uRmvSScK8UvyL57O1u6wUwPwO7ZwO3H71tF0/toekMbl6Crwrl2OQ3b0lgehc19V/Cdw8fGPfB7mAJRMCDZSGQ2UeSsWFXAC581Uopha2XvUP/ZjYM/1e3h955JCOqvhgDJ2wCTfKlM55iNTlSDyCMQNkbV4OfwNjhkMYLZUEuMYTJ8kgjhhUOfcC/QdXOQVNvaU9Io/4dl5xhhX3UTOCRuRF40RLWNMAhS92+iU8xBc01bq+KagadUhiO74N0WG1zlcsLfR91yBomgCR3WbJIp1laXuA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AM0PR08MB5523.eurprd08.prod.outlook.com
 (2603:10a6:208:17f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.11; Mon, 12 Oct
 2026 10:28:46 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0522.008; Mon, 12 Oct 2026
 10:28:46 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Mon, 12 Oct 2026 13:28:25 +0300
Subject: [PATCH v16 17/22] vhost: release ownership when the incoming
 migration fails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-up-vsock-vhost-v5-v16-17-36c38bd15ffc@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: bdbeb5b8-a756-4df3-617a-08df284b9868
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|1800799024|23010399003|366016|10067099003|22082099003|18002099003|261009223027099003|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info: xNuvcT6KICEwNZ8munevQ+EfW5HhSoOcEOgKIUKzbHfmS96RUzp7TiWS34GSHO9JtvSeo4ebji7RPuvjiVFOkPWoVfqoeYheK7kYNe2wmrcjHAV7ysXTdo5nB7JELk8SLPi7YLRcgHB73dENMz7GApdKW//PxXvyaLacngx4znHXUfUj72yeF3dNU7ouWsWkgzMG81ut4JPnfC1X7XK5Qh5ewqPFqlV+puXPQ5x+dcKal5IpvB8c/mrHxS174hIHjx4W/ZoTrg8hqzDlP770q7Hn4AMJeknW4ZSvBmB4Yeb5BhM8CB0T3o8/zqPjkzMhwXj65X6kxJi7Oa9ztXqHqq3GfCPWiFCFXF48NyhUM7WGH6z8hakh/asiRtmDtYE8nbhUQr4QgZa0F/7qwUe5bwb6UEnGCF2SEJWGI5M3zePhVkFBzlPfE9rvhK76LJkvAesEbXjtsgzvaWTTFPd6/m+QJUfK+iaGLr9gm+APTx/T/fv1q6wBZp19FzNTWPZpx45IvndoA9BZ+MleWh8/265bmU6ZDr1NNr5CFWEEf9islY5+8XVZyaxHb+ylwvi26YeeqNghfBV1kEV//clvWNazqfU+slqLtP5P1496GaABR6wH1FD7TeRVAAO3fQxTRAYfctSXQ9TxaGSFRsY8w58HGQ+A/xO+7aVm+1t257CFqJGA6pl874SIBm+1mrQj98boAXsnYaUiTBkB3NNFr2IAU0dGXCky09JODdnhrpg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(23010399003)(366016)(10067099003)(22082099003)(18002099003)(261009223027099003)(56012099006)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qll6L0hMU1g4OGlua1p1NDZBWkErTWhHL1daWDZQY2pQRXV3ajZJOXJldzJr?=
 =?utf-8?B?UTFtN3Z3MmVFNHBQbm94eWV2bEhxdWtYTjFHVFNNV3h4L2dUMzBrcUJyUmp4?=
 =?utf-8?B?WlBYb1hIWGd2LzZNc3d1K1RSUjJMNjZKZ2tDTEIzelhSMG0yb1FMc0ptVVNH?=
 =?utf-8?B?S1NOTWI4U0gyejBYdXJIM1d4dkVZZzdpMHVDMnU5aGdBZ2VIMVN1RnE2Ynkx?=
 =?utf-8?B?bkVrZzR6aTA1VTY3ZUE0ancyb0tLV01ZNDhsKzdPdXE2WnNnWFVBQVJIdkhi?=
 =?utf-8?B?dlJiSU5rL1ZzYWRDbFJzNzg5eWt4cW5PZy9lbThmZUpSM3JzbjhFOFZxbkdY?=
 =?utf-8?B?TXhRUGJqS0NYdlJZRlRtclV2YitvNVZoaktINGk1MUdmM2tpczhtcEF3R3V4?=
 =?utf-8?B?TW5ESkdiZzdGWFdrcGJaTmtITDhZOEFjTVJSd0lRQXZCMkhRV1k2STRYSVcw?=
 =?utf-8?B?TDRpbVQxUmFacmFEV2tCZzh0anBqREp4WXgxSDdkTkh0RUt5cUhUMCtMUUp5?=
 =?utf-8?B?M1JlVjJuL2xMb28vTnZpbnNnQU5KWHE1aGlPZy9WUVZFYzRTbnkrN0RJazFi?=
 =?utf-8?B?ZEdpTkpOK0ZGRENsa2QwRm1vOTJ0Z3pYNk9ZaWdMais0M1NKYjRjQnJCcTFB?=
 =?utf-8?B?L3FoTnFmdDRzTm1nSHBGTFVZYVA2ZHFXeld4c25iMHZwSDNMQytyc0tXeVVJ?=
 =?utf-8?B?R1AzNCtjMVdLNHdIRlVqTU55Y3NOYWpPUmFJczlJVS9na3o0akFyK1NFeVAv?=
 =?utf-8?B?bE9WcllWYzhjbzc3OSsrc3FCS0pWT3lmcFpEMTBUTzR6aXErQVFSQ0xvcnFM?=
 =?utf-8?B?VkJxRzlKSVBkL0xickFUa2ZBRnp5d255bDVhZzZCMUZrWEYxTGRCNlVtTmF6?=
 =?utf-8?B?dUlOTWVpU0R5djRiT2NsUjBnNjBDcXJ2b1J1RFlwMXd1djAvdmJ6bXVJbnVO?=
 =?utf-8?B?UUhOeExxd2swU1dUWXlQZkN1NERONzBDcGVjU1I5U3JCTExsSlVTNUd5R1E5?=
 =?utf-8?B?RnhXRjdYYjF3ZkViNnBBSWZ0eWkxQU0yNFQ3cmtrZE1rUFVqRDdlUmJxMmpm?=
 =?utf-8?B?SUlYZW1tZXZDczJLb3VWbmxndm92Q2NjRnZWdlFXYXRLcDVMc0JEL1Q0bURj?=
 =?utf-8?B?TXlGYUxDY0ozb2dtamxKLzVMN1ZnVlhMbmVoRUMxdnJUQ2VEWUFBZ2NILzlm?=
 =?utf-8?B?NFpnMEhSM09KOGFHNWF4T1RIZERDYjREbG9TWWlRY0h4MVpGdWRDSTRuNzVm?=
 =?utf-8?B?YlRvVXFHQStxdFdicUZRaFVYdXdWYXFnQ2tESWRYZVduOVI5a3NFR2ZnSDVo?=
 =?utf-8?B?U2pBeWt5RCtVQXQ2UitiMm50QU5IVnY1UHlBdGF0cTZteHVSR3VIS2pqZFRx?=
 =?utf-8?B?WlpRaXlkQ21uMG1iNkJtQzFXQ3RuZWpBeEJKU3ZFZXpwV1FVbWM0ZGJLS1Ir?=
 =?utf-8?B?VjJTbXJwakxnVVNSQWw1cHJkWWMrOU5UUVdlOUNvVlJQS2MwMnprQksrQk5m?=
 =?utf-8?B?UjI5MytBdWsyZWcveUhLYWRiSUdsdUVFTlprcklwb0sxQXJIVHFQVmNrUGdq?=
 =?utf-8?B?QXBEdk1PVXF4UHd3K0taSWtvdWtyYjdpTG5wK0QvMG1oZ3c0VzRTL2ptTm1H?=
 =?utf-8?B?QU5NeFpydE1xUU56RHpvY3hlT1R4T0hqaUtaVEpub1RZV29ZK1lLUU4zWW9y?=
 =?utf-8?B?ZUJVSVI0NHNVdG94TXBhZitJeUp4MTZHaVk1S0hXaHBhU2F5UlZxWFIxQzFJ?=
 =?utf-8?B?b1hLOWlJV2tDRzRUbGRDa2ViQmxqdDNzeWdpUGZXTnVjNVdqOTZxcGx1UXZ1?=
 =?utf-8?B?ZWZ5cTJOTmNUVU16RVFteVY2V296dWVsSmZHSjdocDYxdmE2dlJwNzlZZGdR?=
 =?utf-8?B?VGozb1R3Tk5LZS8rQ29TOUd3SGJsd1NDblJZTHgzTHQ4L1p6bERYZGZDVUM3?=
 =?utf-8?B?Sno2L1ZLYjlocklvZ0xrdFJ0MUplUzNKY1dPYXRva3ArYzZVV0s1SWVCU3FH?=
 =?utf-8?B?ckJsZXJ6Q25PMTV2T0xiUGFUVFRPZFZhbVRrUDRsY0ltMndseVZtY0V5YVIr?=
 =?utf-8?B?Qk9hSEkvQ1QrZ1VtQ2F3ZWpuZzY3VlU3M3EzL2piVzIrN3FQRmt5d25hRFJw?=
 =?utf-8?B?QmZDVWRsSFlSQXlYK3h6WGlKaFJQcGVDbm14YTdCTVBYZStkWC9kRWswbFdH?=
 =?utf-8?B?TDlMMTA3UmxBWWMvc0ZWT3U1SUVpdUVSY1pRd1laR2lJNDBOYzN6bTdrY1pG?=
 =?utf-8?B?YWF5cGhZZytnYmlBOGJOSmY5YzYzYUxEZVprY1o3RnN3NVZmaGlaeVZ6THBj?=
 =?utf-8?B?R0RKamlybjBMUmlrVVpyclI1NjRUaXdwb2wvWjYrZzU5KytRUElLbzRrRG1n?=
 =?utf-8?Q?tt6OgEn1W5fQwsxU=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdbeb5b8-a756-4df3-617a-08df284b9868
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 10:28:45.6528 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g5hMRg5px8O2QXwwkQF2Xhsv6Q3wzlFm6JNsN3rDOd4HXGlLWaBH+DKwTimUnRI2oxOC5z4DPwCFqKBSlWq6ZKH9r/KMIWI4Jj8ygHLKd6U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5523
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
 hw/virtio/vhost.c         | 23 +++++++++++++++++++++++
 include/hw/virtio/vhost.h |  6 ++++++
 2 files changed, 29 insertions(+)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 085e2ef6f16..7fd2883504f 100644
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
@@ -72,6 +73,23 @@ static void vhost_dev_try_release_owner(struct vhost_dev *hdev,
     }
 }
 
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
+    if (e->type == MIG_EVENT_INCOMING_FAILED) {
+        vhost_dev_try_release_owner(hdev, "incoming migration failure");
+    }
+    return 0;
+}
+
 unsigned int vhost_get_max_memslots(void)
 {
     unsigned int max = UINT_MAX;
@@ -1842,6 +1860,10 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
     hdev->log_enabled = false;
     hdev->started = false;
     memory_listener_register(&hdev->memory_listener, &address_space_memory);
+    migration_add_notifier_modes(&hdev->migration_notifier,
+                                 vhost_migration_notify,
+                                 BIT(MIG_MODE_CPR_TRANSFER) |
+                                 BIT(MIG_MODE_CPR_EXEC));
     QLIST_INSERT_HEAD(&vhost_devices, hdev, entry);
 
     /*
@@ -1891,6 +1913,7 @@ void vhost_dev_cleanup(struct vhost_dev *hdev)
         memory_listener_unregister(&hdev->memory_listener);
         QLIST_REMOVE(hdev, entry);
     }
+    migration_remove_notifier(&hdev->migration_notifier);
     migrate_del_blocker(&hdev->migration_blocker);
     g_free(hdev->mem);
     g_free(hdev->mem_sections);
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index efe1eed2606..3b9ef86bacf 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -3,6 +3,7 @@
 
 #include "net/vhost_net.h"
 #include "hw/virtio/vhost-backend.h"
+#include "qemu/notify.h"
 #include "hw/virtio/virtio.h"
 #include "system/memory.h"
 
@@ -122,6 +123,11 @@ struct vhost_dev {
      * when this vhost_dev goes away.  Set by the device.
      */
     bool owner_handed_over;
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


