Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA449CA9ED0
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 10:29:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGDHS-0007lt-EQ; Mon, 12 Oct 2026 06:29:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xGDH4-0007dJ-KJ
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:29:00 -0400
Received: from mail-swedencentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c202::7] helo=GVXPR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xGDH2-0005Eh-Ru
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:28:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aZmNSwSkasCn6t0LqsDBLwkjHo+KtIRvUtvQ7UCy7e4YLihD/VBp3dNk7PfSSw3q/w9IEGyvHr/c5wcyTUuvCgKzxCtRVNUL/rRg+RhtwbTEyUzpZOSngk99mhFJlq22IogiQa4ytq14DHpfPTnzzwAsdEJATcZcSgJhuAnaczU7fL9UkKssIgS5mazRVT/K7tW5R+P964HDTnnrGnw2TMUJH+BaxLY13wdIs8aMqqtFb2Pb3Qw2vQJMPwkg9R/5DbUrybLkFVBgxgd1J8RMppWz7456Al0cuXVHFipMydBmc3Zty7Pxb0/muIx+swrf5ndY/Zn25qMAWtn5u89ywA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I5ksPgqxpkvwMZR46juSzPb3Jx553hY74OuSgtWMf94=;
 b=XVE6hzwMlVKDyvGBJe6NhVEKTBPTUY0xui5tDQHEvZiMctL7tAy7Cy1Y0ifPMFlq7VRncfmhxtg5Awj5J+7lWfrKkjr7aBq/fqu2fqMdhJadZwujizUrN1433hv0Ry6v405aI+SaXZK1y2O2FZqwh41BE8MRpjkGRsE5mwg4OfzsQmVr4aHjji36WZgJ8/lVWevCk7bAhLlsc5WsNAD5ZRkIFaoDNZ0JfsP9nWwQOiN14eHPK14GCBYHEyo6WxSkZ7ihS582UwXIIuHzIjPBxU+WxnwMT7sUmtqpc/owKNJFpQKQcL1fEtKh2dGbnqwlb/mFXDV34dUQGJ/voDosRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5ksPgqxpkvwMZR46juSzPb3Jx553hY74OuSgtWMf94=;
 b=IIx/o6K0t3tP8ub1Z242WGsOCbj7Vy5/6qAulSu4GpmUer2dgnpJ8FYXJcseIYvM/PcOaqH7ev0E63K46FOtJ1r2ydwkQVKhi6gdBKWBTbcPTgv4dvujPlSdIsr9gWbxeHSq1lOI8qfSohyAPkWhxRVNkdJmqc3xx08lF9D/u9ddvn4BWV04FEQ28SeXWiJr10OOc1j+AwI+9VMMzHMKzdjVLfBJBAVGUcJqtLdACTV9B3ZsrBfZa51eizYqG/u2yNb8ft6lnzSZmNHM+Wwj7kqEbFo9+WTd3KnyyviDFhVSit/g+lIi0zcK6knK1xy/leEhe+bTfzpGyDzQ++RMUA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AM0PR08MB5523.eurprd08.prod.outlook.com
 (2603:10a6:208:17f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.11; Mon, 12 Oct
 2026 10:28:38 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0522.008; Mon, 12 Oct 2026
 10:28:37 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Mon, 12 Oct 2026 13:28:16 +0300
Subject: [PATCH v16 08/22] vhost-vsock: don't reset connections during CPR
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-up-vsock-vhost-v5-v16-8-36c38bd15ffc@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 650e7f90-6970-4bbc-6d42-08df284b93d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|1800799024|23010399003|366016|10067099003|22082099003|18002099003|261009223027099003|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info: 0Hub7sHc8QkmjWJHzJlYe2MHrwYs/N/dm7mZnzfaaiSDkgGFMi7LO8aZxBwUajnFbbO8ZQGk7EaFxIgCm6jwMJFVQ/jXJpQffZIfRuzSMjTcfMlbJc4Nt5IO3dZi727wvT+wz5/q4qF6gzKEuViMUulebmmVGdMErnum8dBXEcSfkZZeeQbA6KdgkigwS+JmMFiihMRIOUiwyAdOAdqzdLJvRRa/AxZTsrw2eQQ8WwkYXf7TSUGkRWi3ialnJi0GU7+XW45DGcS1ofCI+zS1sSM/ahp8kHmrjDCNxTDCwKZB4+WA7eUSUIEhv6bgtQQM8KSi8ntWcE7gmGIQt8/nxnWFsXc+ucMMmXtvLIvrRfr6XS9idgOhctUcZp5VuChsi8xVY3aSDvOF3+qen7nakBsYZSTKjaz22ObiwFx5zcPc0Mv3HpMJjkaHwGDqKzKPRuSjHqySQ9wRn0B9Bz86UumkMh0BIgb9U4c/yyW/vfreCkoWIPVmtE1ozxbfmcnOtIrlsb+Aq6E5ElR/XXK1OIQYxIGqtOBjCTHVi4YYi7+60oEBAGQjFXFrc6ywwoUrcYpNZ9e7UGoG/qdeU5u+Z7/D/p+BN2AVBeVTruEljcgzuoZP3t9y8RMi+3hrzhRlo4JyNtduqErAaV53+5uEeKxRb+WBCWkFF51/6g5lKyKUfexS7PUngyKl4R/CMiozoYQR4MqTrGzrmxhn3/JQj48LeDIkK5HyV5nQnJNaWzE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(23010399003)(366016)(10067099003)(22082099003)(18002099003)(261009223027099003)(56012099006)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2Nwbk8wZXFDRXBaSjUreWpwajVMbDZyZVUvaTd4SHdHVWIwNldvQTBidmtJ?=
 =?utf-8?B?SWg1OEpweS9VblZYTE83OGtERlpqN1c2ZldBR2wwVUJrVFJuakJTelFTRWJF?=
 =?utf-8?B?SktmOGh4ZmlaQlc3KzRGZUlxNjY4OXNTWm5hSFVyejJVNVE4VVV4em1qN0l5?=
 =?utf-8?B?cXlqVnoxWWV6bXJVV2E0cENhNDdXTTJaRlEzV2d2QjI1TkpvUThYTk0wM0Fv?=
 =?utf-8?B?Y2NzVFgyN3AxbEZyYkdOcVBPcDBrdmxMVC9MVWpuZXV1K3VlM0hCaGM3RE1r?=
 =?utf-8?B?MmhNdC9QWE5yT3I1WVd1WWhxOUtlSEs2YmJJRkJVcFFtUmwxdVNtMHc0VzdL?=
 =?utf-8?B?YUNxcGozenJ0bzdyTXRST2Zac0ZJV01palRnY2czUjJCdG03TW5NVWpZQUNX?=
 =?utf-8?B?cUlmZ25JT3dQajF4WUZ2b3VVeUh1dUQxWHRRTjBLTTBzMzRWcVNrMnljQk5z?=
 =?utf-8?B?b3NUQ080NTlvTVpSa0w1Sm9sUGoyNVAxRTRkTVRGbWUvZ0tWK1hFUGRBNFlr?=
 =?utf-8?B?MklwMTFsa1duUEZDckRwaEM0ZWxkZ0pGdGdGV2FsdHY5RTFyWnFHMkpZajUw?=
 =?utf-8?B?ZmE3NEMrOE5SNC9rREN3R1l1VXRCdEVTM0g5YmYrSmxXNjNFZWt4bDgydGR0?=
 =?utf-8?B?ZGQ4V2NLQWZWaThMZGUrV1BraWFvdG00Z283U2lGdHUxc2Q2THZDRVpRU3pl?=
 =?utf-8?B?WjV2MFczaHpFS09obkhKL2ZYaklKZ0pUcVpSTTlRSzNuVSsvS2Izb3owdnBu?=
 =?utf-8?B?QnF4VVRud3k5RXBvUVhVOGVoMnpLSEEyUjNDVVdRbDdIc3lyTXJIQ05UVWpM?=
 =?utf-8?B?UnkxcVJiZGxDVUMvSW9uYVNBSDRlR2F0eFJUUlRndFRxbGVMUXZrVDU1ZUt2?=
 =?utf-8?B?dHNuYnZyNW4vakZXWkh5Z2MvME5XV1RsNi9DMXQycmVvZ3JwYjZTSVcwSFk2?=
 =?utf-8?B?aUMrQ1NNdEtiV1lNaUVBNGdsWGxtWlpyb1V5V1FWNHRMaDgzOXYzR1JqVHU3?=
 =?utf-8?B?UHNmcUw4bml0dm05cnEzQVlrMzRwekt2eFZXTnJUR3RIOGpNUGk1WU5ldnlm?=
 =?utf-8?B?WVFOQkVzNWc5M3NNcXVCak16UEs2UkppLzlPbVN1TXJ4dmVTR242R2FqNWdt?=
 =?utf-8?B?RUs4dmZSYmNJOU95cStMcVpqc0s5WDNORFVmVk9jRTB3eS9LRHpJVUJXbzA2?=
 =?utf-8?B?RHgyUEErdkp3am1CWFFvZ2tzMksvelpVRHhHOWlzMm1nMllMQUlPL0VIeUhP?=
 =?utf-8?B?YmVMNk54LythWEVlclg2djk2Z0EzdU1jR0JKbVk0VHd3Q2NkZm5LTVduOGp2?=
 =?utf-8?B?RGVBZ21XQlVSZytueHV0U3V0aVh1NkFkaStHOGNFZUkxaVdlTkRPcTdkMWVL?=
 =?utf-8?B?aHBUbE5HQ1NtR0lUZ0I5NXRJekhaUUNHVXpleHZxMnhpNmkrWmoyTjloL0d2?=
 =?utf-8?B?TDNYWFRFRFNPdFBWVUtvWHZOTTVkdDBBbW9IYVc4NjFxb3VTS3RUaFNVZmV3?=
 =?utf-8?B?alUwd0lZbVB4MW4zem01ZkVlQi8vUVRxdXlxY2NCVFp0MlEzQXFmaDVYTzBk?=
 =?utf-8?B?UU1nWVdiT0dmK1UrbmxkNDlmcTRKQzJNUk5WUWRmOS83ZmU0aC9OZVhFd0xi?=
 =?utf-8?B?QWlGUzJGSm5XWnlCNnVMOFhLOUwwVFN5Z0Ntc3M4SUtKRmJlLy9rSTAwOUtO?=
 =?utf-8?B?dEZXblJncGhlamhjSURFSVVIUE1kOXhKVnVYYlV3UTlYWXBzUGRzN2hDYWR6?=
 =?utf-8?B?T09RTDU1MkxVclVPVVlXTkZnLytuWEhXd05BTTMzWk8rVmtCSlk5Z3FkeGJL?=
 =?utf-8?B?NEdVT1NJR2F0eGQvUklFTzAyNHR3Vi9ZeWgydEhWMktGdG1mNG1TQXZQT0tO?=
 =?utf-8?B?OFZueWtSb0FBaGhPM1grcDkrRVQrVkxYVm8wRStsQ1lJRllVNXdyMFc5aUds?=
 =?utf-8?B?ZVpQck81Q0l1U3YyOEpUZzBVdi85V0wxQ2tXb0tYa3VqK2UyUnF0OTRITkNV?=
 =?utf-8?B?RzJEdDlwWkxNME96TThvL0ZCUGd1OStSZDVuSVVxMnpyUGRYNlJHRXNyTVdv?=
 =?utf-8?B?dFZ3UVFsclRnbDg2bVMvZ0NORzNBMVVwWDRhd2VUZk56RzlQZEEwMDZaRnMx?=
 =?utf-8?B?NU5NZFN5YlhJdm9WNzhJNXF4cUNKV0RpR094WjAvdzZ0Ym8xZVU4VklOQU1K?=
 =?utf-8?B?WDBjcXFMYmhtSEcyS2tvSW1lbHZ0V0Z0ZWhWR2V1OUJHR2VaQUd6SXZJK1hD?=
 =?utf-8?B?azM4TEQwLzVUMWNwMnBVY2pJbUQ2K3k4UnBKRHBMM1k3cXlUcVFYZVlBL1Bw?=
 =?utf-8?B?azBtV3k3aStuenc5RC9idEEyL3JiS1M0Mk1Na2s3c3hOejU5dUlYd2JYSHhl?=
 =?utf-8?Q?qE0kWYbKLHQEr/h8=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 650e7f90-6970-4bbc-6d42-08df284b93d4
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 10:28:37.9518 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7JIbOJ7v/QmHB0OrBp1CBBgLGP9i/vz17xccBP9HMRTq1sV5scr8bZkQFKE7Ey8q4pyc0utMQWuf7+aCzaXELIJ2YmO6J92oWjKOs9hJi5U=
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

Migration target with a vhost-vsock device in the .post_load() hook issues
VIRTIO_VSOCK_EVENT_TRANSPORT_RESET event to the guest.  This results into
the guest tearing down all its vsock connections.  That reset exists
because after a normal migration the cid may change.

However it's not true for CPR-style migration.  In this case cid remains
the same, and we want the connections to persist.  Thus, let's customize
the .post_load() hook to skip the common transport reset part in this case.

Acked-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost-vsock.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
index 503d248a617..c582ac9fcc8 100644
--- a/hw/virtio/vhost-vsock.c
+++ b/hw/virtio/vhost-vsock.c
@@ -20,6 +20,7 @@
 #include "hw/core/qdev-properties.h"
 #include "hw/virtio/vhost-vsock.h"
 #include "monitor/monitor.h"
+#include "migration/cpr.h"
 #include "migration/blocker.h"
 #include "migration/misc.h"
 
@@ -110,6 +111,20 @@ static uint64_t vhost_vsock_get_features(VirtIODevice *vdev,
     return vhost_vsock_common_get_features(vdev, requested_features, errp);
 }
 
+static int vhost_vsock_post_load(void *opaque, int version_id)
+{
+    /*
+     * Only reset vsock connections for non-CPR migration.  For CPR the
+     * guest cid is unchanged, and the cid-change reset would otherwise
+     * tear the vsock connections down.
+     */
+    if (!cpr_is_incoming()) {
+        return vhost_vsock_common_post_load(opaque, version_id);
+    }
+
+    return 0;
+}
+
 static const VMStateDescription vmstate_virtio_vhost_vsock = {
     .name = "virtio-vhost_vsock",
     .minimum_version_id = VHOST_VSOCK_SAVEVM_VERSION,
@@ -119,7 +134,7 @@ static const VMStateDescription vmstate_virtio_vhost_vsock = {
         VMSTATE_END_OF_LIST()
     },
     .pre_save = vhost_vsock_common_pre_save,
-    .post_load = vhost_vsock_common_post_load,
+    .post_load = vhost_vsock_post_load,
 };
 
 static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)

-- 
2.47.1


