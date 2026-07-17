Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9363C4451C
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2026 06:34:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkycO-0006Pg-C5; Sat, 18 Jul 2026 02:33:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian.gellermann@codasip.com>)
 id 1wkl9o-000182-Sk; Fri, 17 Jul 2026 12:11:24 -0400
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian.gellermann@codasip.com>)
 id 1wkl9n-00057k-Dg; Fri, 17 Jul 2026 12:11:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZQ3sRaymFAs6MHu+VBhN8xugCmEkjDgWC5OrlzN7I/GhUMMJ6aVCFBkslJ7WXXqiKI0i73YcUHTEB/zPJtPX1NRvK07jIXdbRF3FZnwLasN3azMma0kquF2m+gixAV5+9Cz+ctidOmCrvcL9LOoyNH+4APd00PDz6q2KAH9pWQH/ReSD/qiVB6txKUTImNv3mhUEgCngVAavbMcG7rS1KQ+mXPPyjMAjWoCVQIqTprxUCD4clvldDYub0uqrX28es+F3JlvTIQAw2GA/UoRXXIXZLPbCPEhjZKGyeROpTVIgkrHrtq2nXOEl+X9MQJIUxPsksGmSwWRdYIBzF9atgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=27umomn9Z19SYE1JE4OQ/qTx9TA/wrZwqbp2ywVCP1Q=;
 b=mFzoM7HlLLDS74d6RBT0iJ+wBxqaDoa6REGXyjt608Vk0nhkWm2S/04mWgghtL2tBedtriiSebW4u8OFIPrzZzgbNsghDjJXWjasD7rRodJFF7pBvQscwXQhgMnEQprbreNAEGwFcY6B47HW+aPu+jCu/Pf05p5/CSNLiRiBjuZM+nzuzhwy9W3q9PUAgFWaaE/wQJZmT3ycdsN6mRVLEpqyBAoJK4n+cmPnu2FOrTh5Q8FD8Jc/rIJne+5165cpNnJmyzVEU/Z/7bvGXjmfgmwGU5aZsx4QHqBHhLVz28Kj6EZaGBi2suHuoopnMUY52dFfNuFBWGvy8vKwRCn+Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=codasip.com; dmarc=pass action=none header.from=codasip.com;
 dkim=pass header.d=codasip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codasip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=27umomn9Z19SYE1JE4OQ/qTx9TA/wrZwqbp2ywVCP1Q=;
 b=OymYPbBrmdIMJzzuu6Bc4lQoWEEZUv+Pq3oUfMyUVvquznQYBwF13Css/XL1ehLqrOMxvvNVJevfzpL9z6ieiQH/XvUcWCwC4FkP7XKlmPqRmi1pMVjnLtgdGDKK3sAgXdKxsyInimKvfJUoQs+H2TBptgBUdGQADisXQ8NThQIT5RGm+cq45tqd6rjvq+sWEIYf6Vr6UaRmTMOq6SLo8+PkI+Fe+4hPh+KXYzHcRQrcR8NMLpf9ntt2aTXCSChgnzfUnBG1LcwYfnKRrtOtRqEJpnCnCoLipLqSmP96PhDkwfF/7rTaZa1HwsL4crzxutEJIZ1YdHFqZN2rGsCU0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=codasip.com;
Received: from PR3P192MB0796.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:46::8) by
 AS8P192MB2173.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:637::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.12; Fri, 17 Jul 2026 16:11:19 +0000
Received: from PR3P192MB0796.EURP192.PROD.OUTLOOK.COM
 ([fe80::8209:40a:b436:bb07]) by PR3P192MB0796.EURP192.PROD.OUTLOOK.COM
 ([fe80::8209:40a:b436:bb07%6]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 16:11:19 +0000
From: Chris Gellermann <christian.gellermann@codasip.com>
To: kbusch@kernel.org,
	its@irrelevant.dk,
	foss@defmacro.it
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Chris Gellermann <christian.gellermann@codasip.com>
Subject: [PATCH 1/1] nvme/ctrl: Fix stale CQ event index causing interrupt
 storm
Date: Fri, 17 Jul 2026 18:11:11 +0200
Message-ID: <20260717161111.2714244-2-christian.gellermann@codasip.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260717161111.2714244-1-christian.gellermann@codasip.com>
References: <20260717161111.2714244-1-christian.gellermann@codasip.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P190CA0012.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::25) To PR3P192MB0796.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:46::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR3P192MB0796:EE_|AS8P192MB2173:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e77766a-1b19-4210-a975-08dee41e0980
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|10070799003|366016|1800799024|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: LZqifVzQHSjAOvcJXaw/OuBZ/FGttEyDGiSBjLebucdcRND7lrzp+2W1KdTXyF8ipAxtmuFwWo2mW+aIVhHcwxsKSRm7+GNy9NVv3fKOO79Dnkp+/3K4btya7gw0nAJM82dYdl4wVC1WWNq/SvUC9Sod8LfyJejk52f5HEjCtlQuuWWDNScbQdKhsTAMpYQdznV25Q1TpqLV6ROTgYOVBVpf5hhszJQJqM1arP7d2e6fIcbQwlAASZ1NCyAVrST59ygv6p0v5bhHoNVyilCd8VBmtSZxShuT05MvHzGZheSjMgLh0HpHh//QSOrtASDJ93ib4vZ1ok9JvG5vQOc991jhSSwKXKaJTZ5nRM9HpOoSXs0AX+KzW2C8yJHQIMLD1FRjdGAYAu1Ah5sVTdycuhrLXbXhLWu2hROTh46iSbQj3ryYZYeTWTaNXooPjd6kasQoUMLoWliiJu2S66YwFLlrAd/Yg4B6oSDe7tb+Djoo4l1goKwjHnPgOF/qeF3j01iv0nn8+iwETXFW8w/wx3Kp++jkAC0c6iif+eqDp+Q4IHQdM8bgSzfHl2gKe8MYvKs7qOes4OxrBwslGpdOXVaS9ZTRrIZSA8MtmGeVyn15CowmwzbB74G9WmWbTvXLIampfRTbPna2czveAYhqobMMAaZhy58DP0mP61K4fDQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PR3P192MB0796.EURP192.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(10070799003)(366016)(1800799024)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k8wJ7COQYUi9CtP7sa3cfyc6502GsSsjmeAVwJ9rftZsvEyXxlMfew38VTAV?=
 =?us-ascii?Q?q97sYaaQK7pfyjLMth3EngRN6TnK3DcoJaMFxy4r7t7HwUwPaO60lTvizv81?=
 =?us-ascii?Q?qUFjrmXwbQ7yTehwiT9Uu1VKZiOzykazUPIZu73kDnhxgfjkeaKt3Dcd3Py1?=
 =?us-ascii?Q?Xi+kSOxOPeY2zgLS945bLMCoJhI1qH53TEQS+OgG400MALz4KK977U/cCSXS?=
 =?us-ascii?Q?gKHFJdkJ7HcDDfRJqXdcn8eb+bhu1M1jyWcsGTf0BWslElD/SzYMLgBfBc1N?=
 =?us-ascii?Q?Ye3nYN1gY0nsoG3ZghkOEW1o7v+xQHeOswJ2JmGgt0myyq7VW1c2fSELMG2Z?=
 =?us-ascii?Q?clTt0Tdydw94wicdvcwZ8cBeQw1j60sqBkgYgzlTuRQqkYZWWiMuP6uX0Vhx?=
 =?us-ascii?Q?hbs7PoCp9JO6zwTPucA5TrBwrdmQYu4Lf6G+Ks0NiC7cTYRVE6Slw+4cDc6R?=
 =?us-ascii?Q?sC1CDLD7ycSU3JdiH1vNzow5KLdOVl1xingm7cTQPLXZiC6xudnOgbtPnDJ3?=
 =?us-ascii?Q?qlHnztLxxRTBHDlutppaaP3ruW2Bf+GtiZP5YQkH4Xnf/gz050PG9ooyjZFE?=
 =?us-ascii?Q?u3eI8q9Pk51TGsZNjhphAvE7k63I/aOILfw6PrA9IHnrqxBe6vvMEOdBB02g?=
 =?us-ascii?Q?9r+oXb3xcKXLyJ5fdNjJwZnC2F7NotvxKgtFhFSbLsbHocbL3d1hesYZmtlU?=
 =?us-ascii?Q?gdUv5NypwIenHTZTk9dm+tzH5CsiF5Wh7BnasNWRrCgkQwRxXAY2uZmgus0N?=
 =?us-ascii?Q?tMv3JtS9SiagzV0+x5lx92RwWXshW0D1M2LX9Jqbn7AAM2kKqU4zH73agZIF?=
 =?us-ascii?Q?p48bBTo3vwOgie0dAptvozq61Zv1y9MaQwMURnmxSJ21ev5QWiXPuazUN1vd?=
 =?us-ascii?Q?vulZRB1RYIKsvGH+Ir2VEwc1Xrj1L0jIabNRlDygYMxT8SG3ERCmmtYgFVOg?=
 =?us-ascii?Q?H4TrPOwb8FN4Go4c0kviHn05sZGcsLFH0mr1DXTOEoZlElGaKrUVKZEqazx6?=
 =?us-ascii?Q?z/KQvT4WaqtE5dZ5Ohbid9w1mO9ptKWZ61kwWa3D3liMGe9RUFuR6upfsIAh?=
 =?us-ascii?Q?xUpcjebTGTJFJpRd83rb4IXAzlVeoaRbl2QuX05G2ebDES/R2mwDuihu/oot?=
 =?us-ascii?Q?aFH9bdJRW2lEHCQdk9EKwGN3zLxM8W2tcw8DApQjk2Vs/23/R/jqNpaCB0TL?=
 =?us-ascii?Q?XlHKNhSBkPn6YXQm0R0ETWekDidIV1EuTClMIQqvvmJ8A9eT4hURAVqphAQ8?=
 =?us-ascii?Q?nl3+ceMTIbn5LwQCQNI0XfTDgHTCFX8DSdcaHqn84OUwkXl0uA5upPx4JJQb?=
 =?us-ascii?Q?PENnnRtwM+YKQMxKsY/OC2g9EahxjO7nfiYHLDvz3DYwJ6efWNm6BxzTpLOm?=
 =?us-ascii?Q?Jj6VJ7xpLDrE+kR81OF08fgNVqV7C9ydhZ6q8zrG/YDSaCTp5nZJ0Fhag2HH?=
 =?us-ascii?Q?dqCn5zyve37vgmHwUWTBKzoyFOErDMVs7aDRP/0W+1EvMiLZTtL2qjyJD7SF?=
 =?us-ascii?Q?9ZQu5BbFcylBCKmL+g1WYE0SlZK6kEtJCsj8mwgGO6dgn/w1GknvzxwlpOIH?=
 =?us-ascii?Q?wl/61LrJQR6K9wLgLIkMG7GGgCKDdBCHxRs6sW9Wj9I7HbMVXvBLYn2eJEty?=
 =?us-ascii?Q?O/87o36MqG00BlLdeiiUhSCLDIt1OlPl+bAGUQpZmsaXazyBVOIUqT1gEmTx?=
 =?us-ascii?Q?ixyymPg9+Me5F+45/cmjW0xCIAY1R1Y9v8bCCmLPMIJLcYGzsczw+GVDZrcJ?=
 =?us-ascii?Q?m0mvZm0I2PFr9kC1b9Fsfq3MSY5nlYxQepKgK1zUBa1W/Lptko3WKHuLNIV4?=
X-MS-Exchange-AntiSpam-MessageData-1: rR5rH5w5zPZJzwDFCPZ83Tll/1PA9qQj2ufZibiEkw4RcbpsuGNiY9Ug
X-OriginatorOrg: codasip.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e77766a-1b19-4210-a975-08dee41e0980
X-MS-Exchange-CrossTenant-AuthSource: PR3P192MB0796.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 16:11:19.4812 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d91ffef-bb81-4cbd-b9b8-552583685f20
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EC64RnWhpd9hy1Po9Gljq4dUGS6N7UYakebi8/3f+jNnc5aUbW7EvoMYDQh/xZ6rr+kM62vEYGGSXNvd0m63rr8mZNUkm2+eCrE5ky77rpsJJbwMxuMiq0x4CMRhFMQh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P192MB2173
Received-SPF: pass client-ip=2a01:111:f403:c200::5;
 envelope-from=christian.gellermann@codasip.com;
 helo=DUZPR83CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 18 Jul 2026 02:33:18 -0400
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

If doorbell buffering is used, a missing update of the CQ event index on
a host doorbell write may lead to a situation where the interrupt
remains asserted, but the host does not issue another mmio write to the
doorbell as the previously written value is newer than the event index.
The interrupt is not deasserted, causing an interrupt storm on the host
side. Fix this by updating the event index if the doorbell write does
not deassert the interrupt.

Assume a situation where the interrupt is deasserted, so cq->head ==
cq->tail == x. A first CQE is posted, so cq->tail becomes x + 1 and the
interrupt is asserted as cq->tail != cq->head. The host is handling the
CQE and writes x + 1 to it its shadow doorbell. Before the host issues
an mmio doorbell write, another CQE is posted, so event index remains x,
cq->head becomes x + 1, cq->tail becomes x + 2 and the IRQ remains
asserted. Just after the CQE has been posted, the host checks if the
condition to issue an mmio doorbell write applies:
  new_shadow_db - event_idx <= old_shadow_db - new_shadow_db
with new_shadow_db == x + 1, event_idx == x and old_shadow_db == x.
So the host issues an mmio to write x + 1 to the doorbell. As cq->tail
is x + 2, the interrupt remains asserted. But now, after the host is
done with processing the second CQE, it won't issue another doorbell
mmio write as the above condition is not met due to the CQ event_idx
still being x. Thus, the interrupt remains pending.

Update the event index on the doorbell write if the interrupt is not
deasserted. This causes the above condition to be met. So another mmio
write will be issued by the host and the interrupt will be deasserted.

[1] NVMe Base Specification, Rev. 2.3, Annex B.5.2

Fixes: 3f7fe8de3d49 ("hw/nvme: Implement shadow doorbell buffer support")
Signed-off-by: Chris Gellermann <christian.gellermann@codasip.com>
---
 hw/nvme/ctrl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 22e878c42e1..fc9bc676764 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -6936,6 +6936,11 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
             }
 
             nvme_irq_deassert(n, cq);
+        } else {
+            if (n->dbbuf_enabled) {
+                nvme_update_cq_eventidx(cq);
+                nvme_update_cq_head(cq);
+            }
         }
     } else {
         /* Submission queue doorbell write */
-- 
2.47.3


