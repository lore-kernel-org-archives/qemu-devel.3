Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA81606A31B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 16:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=selector2 header.b=ZQ8eplgm
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP08G-0000za-Up; Thu, 05 Nov 2026 11:16:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xP085-0000x6-9o; Thu, 05 Nov 2026 11:15:57 -0500
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xP083-0007Lh-QT; Thu, 05 Nov 2026 11:15:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AYuypGPEWq04FaX/a8K3y/Ingk8rRsjGFqvFK6ShQU3Lj2sMSEEyHfOQg8XEU4shTDixw9Qg5lziwfWfQ7+uNG5mw7KCgvY+7VE3Sh6jbj87F6RDJUuOL38yqjTI/Afyxm/tGAVwRf09iB2nxrndJPqyWJU585uldl/o4t4GQHELU9CdRR4e2z/dmrpjNjfU9Tiz0gHmb8r8v8DqMDY124c/8eGQDYg6I0SQ/P6PjXIthv0qISrhYnUu9oYQenh/VjCCwlA5jbgI0cz0xLbhO63wImmuI8rWOtLGIbkxLHaOoNfIP1aItWxC+Yp1kfRncC3cWbzWeWiJdCPNE55uTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5mA7bn7XZ2rm11+3fIzpmPFOFh3W/e7bltcc7sGzzRo=;
 b=NhkXaUINXfSoh4igkWHv2uWvgQSrzVvLHBCDK66yDQD3iFDo7yL1/mTofovejb+POKiyJSrWfPW3e7L6omPdI2fMYO0BddsBlThQHRgIkZME2g5N8VQGosttDo2uGX+46YvHu0/8d22UQVEcTQmj8KUnixjRz+dZY0xIYqGPmoVDCUrWU4euWF9zAaZ50DukcGTP+EC27wrf1ZH/bjsUH8xl5w1hDkkJA8iy1foALQmywAmAQrk9VomrlmdmUf9dWKnHsntQkMTShYbgZ9L1Q+VrMmCfmOeK6h1jwHtJsweVYH5JEsoZEc0GMEMhO8f/SLzOXlh7ovSWWKgdrP0/MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5mA7bn7XZ2rm11+3fIzpmPFOFh3W/e7bltcc7sGzzRo=;
 b=ZQ8eplgm0d0OLFoCBO+uvppdGsFHBfwNCcZekfIyKluzsgWYP32XECZG91yHpqtluJdxqwpm9heuyxFF3SfgKNbGk/ovOyu181c5UwyJH0tj2DqX+KkEOgX2MK7FOnf0Zp7DhdWnpWOHdQJ1HruUl4wyIvNAa0hRFu8oQYmgfU4M8kWyl+Ds97L6SmwPDUlSZb7MwSXy5KQzWm5J2/QY6X61z5rurGslCrMjzm0ZXGiJPlOYQ5fnXZuRUJJJwEY6Ez/hYkpEt5r1TOmywT4AtT9uFbD5V5j6JY43qja1kMNAKNNGp2ecaUSl6rVJCKjfUyXjR0ggfV6yWEJS3HakIw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by MRWPR08MB11805.eurprd08.prod.outlook.com
 (2603:10a6:501:9a::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 16:15:46 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%4]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 16:15:46 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 jean-louis@dupond.be, andrey.drobyshev@virtuozzo.com, den@openvz.org
Subject: [PATCH v2 2/3] qcow2: fix snapshot data corruption with
 discard-no-unref=on
Date: Thu,  5 Nov 2026 18:15:14 +0200
Message-ID: <20261105161515.794213-3-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20261105161515.794213-1-andrey.drobyshev@virtuozzo.com>
References: <20261105161515.794213-1-andrey.drobyshev@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR09CA0182.eurprd09.prod.outlook.com
 (2603:10a6:800:120::36) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|MRWPR08MB11805:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d9741a4-5d65-40d2-3e0b-08df3b580c5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|23010399003|376014|366016|1800799024|18002099003|22082099003|10067099003|56012099006|5023799004|261021123027099003|261021121427099003|261009223027099003|261102123227099003|38350700014;
X-Microsoft-Antispam-Message-Info: 8pKKuL2QHcsn6ui+1Q7T/02/pmDzNiZUS6r20A9r/Cg78XgfE/XrLHJ7A3oYARF+iG5MjJGruZardYR4Gnzjsdqb+11F6MnIaeLOqn2tp0+jr2qOlFjvhmFsTAfGME2529zas4SG9UXSyac4VLcnOaYrRu5xe5ItfieiAg1dJo75L5ZTxm9pb7xfEtqrWSDNBtbzn0g+yjHMseFzqnpB0WEo19Welk/aBUrc/xKFjg9/b1uc76zCv5laZkLNZQxUYiu11PFEYb+fD4oqVKeeDnWahPe1nPEJZHBUWY9m1O2k/OkRcUnVGeHfn0v65QkxTur9lp+K/QWjhiCIHKczc34qYMr21qqPYLuwvtoCNckV1Q6ofPgJ/7IUglg0YlMzQ2J5pH+aQRp3nDNJAGQaQf6RZJTamyKF7/R23tGXK5zZ4We8+I7f9BNtrDLbgvuabGE1hqmWj/VHd4dKXkXl+N5juMApnQKszvd7js7fwWxGUUaT6yWPV2Q/BnfJG5knUmV4woc4YAq3UdIuGC3CCMfl0Pm13D/WVPWag2R7FbMnD0HkRelS/6T2aBuTOJLasKgZvsOwvLNduCTpby0jTw97GiKzbeWXDWjKU7AfhUR2ALUXHemFebyUjEw348hAe5sQc1l5/tF12Nyi/BywoHXRkl3SSndW/pTmQ2Q7R6f+7RAxdG2W+9fDY1uunUsVHEr0mATlokzHjzLpn3sxYlr8WeCNhTUXBW5NjO6Qe6g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(23010399003)(376014)(366016)(1800799024)(18002099003)(22082099003)(10067099003)(56012099006)(5023799004)(261021123027099003)(261021121427099003)(261009223027099003)(261102123227099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ybH82E39y93d3l/VBbfv7A6TJ773sfUD/smX44Qqo/aydXR0eMJQg/PK5zyw?=
 =?us-ascii?Q?KTG3rwOrB/qMlfXWl1XZ9SN+tHiVrWDCkwnFvdKsWENi3VWPpX1yYkIy19EC?=
 =?us-ascii?Q?SE2JL5umHBQoISuCPikJvmpatirRRmQOLKSxLGgDHd22zHbKJpH8U6dIP/AW?=
 =?us-ascii?Q?bfcjBiDAB5tUbkgeMt23Q1EidRoExed2QOKdL/pwRQ9c+s/YU49rwdLSHjcN?=
 =?us-ascii?Q?7wzr0Qv1so+VWxbTQ0gQMxlL3DHg1g7Cz7aXRq2OlJL/MdgjqFUHVAmCzCOI?=
 =?us-ascii?Q?KBWnTCgjPb/L7upjRVTiYT10DsbT5kR8uebimuFcH2mg2epwQCjlTjRsRria?=
 =?us-ascii?Q?ej2isNCIDCSggkiFmwq4kBleOYuFRfZarPnc44jdgvA62SVfNnTLc+/ZXlRJ?=
 =?us-ascii?Q?crvCgxpI9xqQvyIle2vCXYi5fmW0CZZbKmuCenWQKhSjVcTkSZp/nOD3DHUb?=
 =?us-ascii?Q?mmFgOPNE+VcGV4XmVsxZZ5Xyy4lN0B/DMGNmO2Hng0sXxBJMfW+t3af0Q/0T?=
 =?us-ascii?Q?LdxIEEl2PnxY5x4ZZhlcgEt7OH0M37drKYls6EUrZRJORhPBR/Dsu0ri1AIY?=
 =?us-ascii?Q?U1cMuolgPl1/jkeVtMNDmqCA9hzRLOyeJPx7IjUwvjnKj87kwG7b4G/pqweQ?=
 =?us-ascii?Q?fFZUuXzGjqd7/r9J7ifswhyNNFlzImr9g9SaF8W82LsB0sHZNGU7dVuM5K7W?=
 =?us-ascii?Q?9tDsfhB8FqMXtlujVQmESuIJooISmXlLnWEs5KEe5l3J2rux0Khhh4sfV/rc?=
 =?us-ascii?Q?AvGNKxZIO5iQdvxSqDhewniIJygekTvlmvaM2f9A8DkTMTHZ+MwwSR18rSCT?=
 =?us-ascii?Q?NA8ycirn+3pBoEVuMSkOZtx7Yf2S6aVY4QOwyYti1DOmkYXYbfyLh5sFusoU?=
 =?us-ascii?Q?S4wfFrFrc5Oymi4qAx1no9Cq9Lu6DVSiU5LLlyoiam99vBxQN/qoqs3gj545?=
 =?us-ascii?Q?9PZaRDtVyzUUDLlx4F91q2zI7X/hcKbotdID4hQBxHkzwfJbDsuTkq7vQmQU?=
 =?us-ascii?Q?Q7VBQyLokOrYgd9y5DPU3mI3HkvS/eIqmC1OSYxHiY2IZmtCF6h64niDpz/3?=
 =?us-ascii?Q?F0nn73vnL1FjubJw1TWhBa+KOoc5UFxgnkLnzfxUDLPav/HDenKSquWGUh0b?=
 =?us-ascii?Q?ZtfqOapMrav47GHgJdmFvBZWJd8LsMplU4QkKNgT3H/fzXJIc07PbjcY41n9?=
 =?us-ascii?Q?UNrHbzhnE8VBEcwXl6tHSLjLaYwHfnCUIesGmP/oWTSVw9fXMAFS0+pWjBdc?=
 =?us-ascii?Q?N0v4iw2I/dWpyjboaDSCC/Jjxk4lb88KRnbAxH/CCsGgON8gn7S6h77nLHHx?=
 =?us-ascii?Q?yAx933hvBGJndEMOU60twHBr7S1xkF2lwyHqmoouC2lrMfir52GWIDJdCGZ/?=
 =?us-ascii?Q?h7aoQ+OTiKLnPjXY2Fh994yarjt9VA1Lq1UZTaOA5dw8yaAF2L861BrSB0RP?=
 =?us-ascii?Q?GJMSYlxNA25/jscbehXlE1gmAUgjRCrJOzWW/8Boyz0j6EkOD+s+on5TGt9l?=
 =?us-ascii?Q?oJpJZqXYirRMcObB4CetzPnm2O2PlIvcH9sfFpf4MRhiogIhfifve2vFjvFu?=
 =?us-ascii?Q?S6CAOInYHlW24w5+pXLKN6Rkx2IqO9r2Nc3mMzprX6YFLEZ1eesMNIrnOFFy?=
 =?us-ascii?Q?KNZvV9Tgj+P2O3JtWomjnQojiJT0aqOVZsS7uOqed/BFPMJvVj03ieA6nnp8?=
 =?us-ascii?Q?zUL/dlQlMHWOKr08yp6wypuDMcEKvB7bu7IWu7014l3X1F4YxKdN4MG9qPPe?=
 =?us-ascii?Q?Sx3MbrWifJERwF9BiefsUB4U/BCdx4c=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d9741a4-5d65-40d2-3e0b-08df3b580c5d
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 16:15:46.1382 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nMUnGHdzlQSdP4P8PMNlnv/1U9GCJLJAAbaVXlN5xdu7D2HNn7jVVjYhJuSXxwYuyW341s7yDUbHx+dBkOZ5ME2PmOnNBgav4Mny7MYBYYI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR08MB11805
Received-SPF: pass client-ip=2a01:111:f403:c200::1;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=DB3PR0202CU003.outbound.protection.outlook.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Whenever option discard-no-unref=on is enabled, we bypass refcount
machinery and unconditionally punch hole in the data on 'discard' and
'write -z -u' paths.  However, when this same cluster is also referenced
by an internal snapshot, such operations lead to problems.  The active L2
table is copied before it is changed, so the snapshot metadata stays
correct, but the host range under it is punched out and the snapshot reads
zeroes there afterwards. qemu-img check finds nothing wrong.

Fix this by guarding the 'keep_reference' flag by the presence of the
QCOW_OFLAG_COPIED bit.  I.e. only proceed with unconditional data
punching if we own this cluster exclusively.

Fixes: 42a2890a76f4 ("qcow2: add discard-no-unref option")
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2-cluster.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index e02fae6a0c6..cc473c7c796 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1953,6 +1953,7 @@ discard_in_l2_slice(BlockDriverState *bs, uint64_t offset, uint64_t nb_clusters,
         QCow2ClusterType cluster_type =
             qcow2_get_cluster_type(bs, old_l2_entry);
         bool keep_reference = (cluster_type != QCOW2_CLUSTER_COMPRESSED) &&
+                              (old_l2_entry & QCOW_OFLAG_COPIED) &&
                               !full_discard &&
                               (s->discard_no_unref &&
                                type == QCOW2_DISCARD_REQUEST);
@@ -2097,8 +2098,9 @@ zero_in_l2_slice(BlockDriverState *bs, uint64_t offset,
         QCow2ClusterType type = qcow2_get_cluster_type(bs, old_l2_entry);
         bool unmap = (type == QCOW2_CLUSTER_COMPRESSED) ||
             ((flags & BDRV_REQ_MAY_UNMAP) && qcow2_cluster_is_allocated(type));
-        bool keep_reference =
-            (s->discard_no_unref && type != QCOW2_CLUSTER_COMPRESSED);
+        bool keep_reference = s->discard_no_unref &&
+                              type != QCOW2_CLUSTER_COMPRESSED &&
+                              (old_l2_entry & QCOW_OFLAG_COPIED);
         uint64_t new_l2_entry = old_l2_entry;
         uint64_t new_l2_bitmap = old_l2_bitmap;
 
-- 
2.47.1


