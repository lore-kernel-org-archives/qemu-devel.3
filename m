Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C36CC55838
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 15:18:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrGuF-0006e7-Ct; Tue, 04 Aug 2026 11:18:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wrGu9-0006cU-Cv
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 11:18:09 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wrGu7-0004md-Ug
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 11:18:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WKRz9fOa58NceBiN1R8WTb3to2KrBqjZnSzUxs0aNu4oBL3/qDnW4GydeK7zImmJaWHWaUJYP3Dy1aB/ZF0Q7EugiWnXb6wf+0LCJGO2Ojgx3H5DFyW/ROUhEfdEpZzv9uQe/NqlttJOlZbmHmq2yWyZbPxnuxgDZhUULY3TXEkE5U90oIUxL84G9WBYN9kjw46HecpQMwuUFLsH+ux9J+2HNnDUMISBldEpn1nzT9sc/JOWNloavaKQ+VZlHR5up47XFGeuPcto29pabQD9akuZarq8rVGdC/XPoBvX41bSORj7sgI7H0jIjzBnqH6kjNf1rQb1K5Neo5JmBBTc4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CiAN3eQVDCWQIdw6pFyfdRCYPPaxB1lVTRx0fAnTrjo=;
 b=L4T+rd0zzeWgQFNEt+yiVsvzAu9WaFykbaZRsf4fb3HtVmSBJsP+O1mPWXJWyc7yCO/n0Dag/+C4WbS2stxkqYhIM0bRtnMpqQPN9PYte0P55wGjyAgCYtZIsF0FjqsgtU85yrT3Oxl+7AYss+VjK0nPqWvNtQrlkWZ7XKOwhcsQD6vqr7JLyJJFH1BppXr90JecR41um7DM+SqlWPK4JvZBEv4F0I1frY9Wo7H2etvsUdcT7Ga5K9B5jGmqbtZLBnj8yGXMnfQE+T6NL7nqZm/bgXBSt6p7NlQDdmA61jUcsx7MrfglPGcMrcO/a4i02zdwgVBlP7NqTZhrRHsQyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CiAN3eQVDCWQIdw6pFyfdRCYPPaxB1lVTRx0fAnTrjo=;
 b=TzYJbJnuBVHG7TmFVv8FWwdg0diA5PGXWCFL64DCpOEN9cycJhWxHgwB7Gpp/YJkEkpkIv9tqDmNSLrEhKau6SIUOA5D9k6pU2tfmwPM/IaJmkECUK1tUBHZgBXPdEbp+w9wruPcU+x8Jf7p4JfCRj8jZIgep/Pzv6MahdjA6RvfBxR42dteJx/XfSReeDwUUdhmDUdiiPcR3NzlIOc2fABxi86BdE8Ym8TI4qNuR5+FSO36Tq0+OX/cMLXv/sv2gRWPM2Omt9Km09XAnW1/B1FjgxGAklyQaMMLUJCNc8wNJphDR66uLbgxwGy3qOQl8u9n6Il/xR3Q/beFsBk8uQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by PAWPR08MB10317.eurprd08.prod.outlook.com
 (2603:10a6:102:330::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Tue, 4 Aug
 2026 15:17:56 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0270.016; Tue, 4 Aug 2026
 15:17:56 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, kwolf@redhat.com, peterx@redhat.com,
 andrey.drobyshev@virtuozzo.com
Subject: [PATCH 5/9] scripts/qemugdb: coroutine: Fix patching pt_regs in the
 coredump
Date: Tue,  4 Aug 2026 18:17:39 +0300
Message-ID: <20260804151743.937694-6-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260804151743.937694-1-andrey.drobyshev@virtuozzo.com>
References: <20260804151743.937694-1-andrey.drobyshev@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR09CA0148.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::32) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|PAWPR08MB10317:EE_
X-MS-Office365-Filtering-Correlation-Id: e0d8a4ab-2595-434b-3ecd-08def23b8f8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|376014|23010399003|366016|38350700014|6133799003|5023799004|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: orM92GHzF+24SCZ+z4Uys4mocHEgUCFm4lJShQA0ks8J+uD6h0SbAKt1SghyMHLEZQZMnQETp6O4SARFYlfP2xKWdRgng6AnkqilWiJlrxVQns/2KvkFDtusNU54njK9cA0pgX7wntUdzpE06ioQnFgE0T5RIdZS8rYINh2YBaFNB/qtkAzf2Edi3uoNgnqJfPn1GG1ORTrnHm3vfCRCx4GMRv3iMNnNOoWOOGUwtuGRVGZckSrOjVFzH2ZglnjiJxd3Pl7OR32BG4Nz1SZ5j7ppe6al1vQ9s8wafARoL6HbI1NKQTJEFt7Gal2s2Sqqau/TaQIVipr/llKUMgTYF7IkcLWeamWFKDaJ3wu0Ypy8mdNqbZba8Emyb279pK2hlKz9TbnSyhD4p26VOKh2vBrmcQqjnK8zDobC0B/6fovwQ2FMhVyAPBXS4tqmMXMGLsqERrE5ly1FiGgqKOV8i+8L3zgbOCymL6v9OV67QUT0b8hLhim3VwSt1WAQjSNWQpRBlcRmIM9ys4yupTsN2Q6J+0aRlQ/8ccRZsbiJupokqYgBUcibLSTc/CF/OFV7BlzfS3JCIMrrIYSOQYyTDZCHi07ogw7DHkrttHpiJy0stifELqprlKQGrDBsZ76G6YbbyN1/C6ayJ2YmFfEM+c9m5d56gPLSua2sOrVfXzLDGxs1pD2qdDm1wae+4ZmQbC5pG0gu3kIcG8HnfcI2EUYNQ18dKbCjQVX4i0KxYpc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(376014)(23010399003)(366016)(38350700014)(6133799003)(5023799004)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YcxhYKnTx494yVBNM5w82F8ONgRrNMP6PehCq6Et80pFtuWaPH9dnsdK2BNc?=
 =?us-ascii?Q?b3gN7yI+Acs1YlJ5/F0EfFZ0SxACS78w18aCqwWABXNveNkGkWY9/Mo5wQOi?=
 =?us-ascii?Q?1V84sxgnqXkxTmiMoJQzHl7PBgUvPUeXQcIxpDRlzuSiYz5Hxi97GWkiNYPg?=
 =?us-ascii?Q?AnR0uqvxlz9XuPrpncH2S8VUtuI19D5V/hgOZmjrobfYCpsLO1qSytbvdaNj?=
 =?us-ascii?Q?ct/arRzwNHe5aAhQp97ABE3QTZv6Y5jpe9Dou3R8eLbsJHhCedr8ypDkBsqZ?=
 =?us-ascii?Q?9yh+6YR9QQ478BiuQxIMnAom/ZS3g7lLw7BOF4Pjt0iheUPZNMyy/F+3wLFq?=
 =?us-ascii?Q?gzvsMjwh8t58j60byEGHLEseVvxupypU3SfTawlOf2hvdIX5tVqSh1kBb0aH?=
 =?us-ascii?Q?o65njCJmatDYTFXoUVByxLT6LmjS/UqXHIS1RB7Wpx0ib4PG/tJ8yP4dY2uw?=
 =?us-ascii?Q?XcaG5fYE8Tt5WU0u4hz15UlmvGEmPRK4aqlgYRLFLq1TbDKIpsLlw2ccirlq?=
 =?us-ascii?Q?6nyCkHwTAuE9a3pWHgjXCpbHEHUHJJXXrdG6KW8kfUjUcRFmmRconhY/9cEW?=
 =?us-ascii?Q?HyU+a3nBDAyPrs450HpdVRl8arw5JtFIxXNUE24PlmBOj8NOAIkkXX3q2rS7?=
 =?us-ascii?Q?FNakZkpGKtfJX5qSz7xDW7HrQa4E+nLdH/Mo2AehZX4L935sHoNl33YndI+g?=
 =?us-ascii?Q?E7jUHavaa95uoPstoUd+dsCE403Zapo1jNjyB4+xoSJfr50hFpZdgCzB5KWJ?=
 =?us-ascii?Q?xdZ7QOXdv6OnYI3cVvufwbYHIjvD3lqnvjc5Jx5frhdMWFnw6C6xuaWiyy2K?=
 =?us-ascii?Q?NmI40GY0nPDCMiu6FzJbiGXq+qc/6DHItF13Uq+/kV82x4YQ/CdEHChzLWcG?=
 =?us-ascii?Q?X+bcF8qJH+/r6k6z+5fv3p4xEyLcCyaaNIoLsNz++LtS1hzpLlHDvsFaXzMh?=
 =?us-ascii?Q?vUgK6ThregadKnjlYDhv9s+2iJckpJJIYoiyI3XDAwPF++7a1xitsEghdlfm?=
 =?us-ascii?Q?c8ygnSr0ScOVY1J/T9BODd+SR4NB9K9wdmHroOsxsqobhciohcQtye7cePq/?=
 =?us-ascii?Q?cSA3ZqkNEkGSpBho8Kl8U/e7GTDzk2fbeyOkZyLwrtZi/oEKdAzfSbS7S8Gw?=
 =?us-ascii?Q?TsT0Xs2yaK3+D/3aAogoXSgWGkAMy3VBDznvmY252VpMIhtc0e/C7Gu81g4l?=
 =?us-ascii?Q?IpQQc9twhuFr61Y3ycnAxzXZjenyx/F8OK+YCg+vgNuhPOqlqauYsjCYFvMC?=
 =?us-ascii?Q?LUoA8E08HM5nfxxhCv37NsoPlgvIVSAZIZ66TxErUH87YCOlYQpyCMnkjnMG?=
 =?us-ascii?Q?WXs0Z8knsN4zhOPrmA2PHL9SR7vGLXdF8EGvR5xQXU2WOZ7ofrk95wS5YFzC?=
 =?us-ascii?Q?rBQ96JtmZI1AbdYKZLz5QaWJiSVRQ7TLxPsAJQkkjNLmgdUNQ8d7oRMTYRL/?=
 =?us-ascii?Q?Me4b6OE60PyfOX+/STx0Y0amDP7paG2CSSxImXHXuybz9TVYblDMmlYs3dT1?=
 =?us-ascii?Q?JeSAEATnCXjiR5iZWr90hrbl/3gT/NlGHY1S5pGt9ALtnOH8kms07Z9nyaRY?=
 =?us-ascii?Q?KcFXGprDyu4KHbBHJABfViVyaqRC1tiyVp4CDlx4ypsjh/D8206aOLWZ6Dbv?=
 =?us-ascii?Q?24nNmF4wqfT0eU7Qhyw9V5ndZlLYviXK3fqtdDiixmZqQI/70XFWtKNjb7tj?=
 =?us-ascii?Q?sARBNgmKmf1OdqWpWe5m4z4Lb92CxDdmDKIyOLZhTYsSQ06n4ROlQ5VoXXzc?=
 =?us-ascii?Q?dKztKqujEpaSx/2T68K4XjsboYGfeX8=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0d8a4ab-2595-434b-3ecd-08def23b8f8b
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 15:17:56.0450 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oCEtIPW/6DI6MWNEQyTn+56TwQDPpHJ7TQqmDTQshqk7+TA0OyW0VyL6O/jwerQT+GEDDwHoIom5c5HpttPK4NWN8x2eRNzX+Q893ZnaGFE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB10317
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

patch_regs() and restore_regs() open the coredump with 'ab', i.e. with
O_APPEND.  This repositions the file offset to the end of the file before
every write.  The seek() to pt_regs therefore has no effect: instead of
patching the saved registers, we just append the binary blob with patched
regs at the end of the file.

Nothing fails, and the gdb subprocess still prints a plausible backtrace.
However it's a backtrace of the crashed thread rather than of the
requested coroutine.  The .ptregs blob kept for recovery is dead for the
same reason as there's never anything to restore.

Open the file with 'r+b' so that the writes actually land where seek()
points.

Fixes: 42f3c143c3a0 ("scripts/qemugdb: coroutine: Add option for obtaining detailed trace in coredump")
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 scripts/qemugdb/coroutine.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/qemugdb/coroutine.py b/scripts/qemugdb/coroutine.py
index da395a1a13e..4803914dde0 100644
--- a/scripts/qemugdb/coroutine.py
+++ b/scripts/qemugdb/coroutine.py
@@ -90,7 +90,7 @@ def patch_regs(self, regs):
         int_regs = {k: int(v) for k, v in regs.items()}
         patched_ptregs.update(int_regs)
 
-        with open(self.coredump, 'ab') as f:
+        with open(self.coredump, 'r+b') as f:
             gdb.write(f'assume pt_regs at 0x{self._ptregs_offset:x}\n')
             f.seek(self._ptregs_offset, 0)
             gdb.write('writing regs:\n')
@@ -106,7 +106,7 @@ def restore_regs(self):
             return
 
         gdb.write(f'\nrestoring original regs in core file {self.coredump}\n')
-        with open(self.coredump, 'ab') as f:
+        with open(self.coredump, 'r+b') as f:
             gdb.write(f'assume pt_regs at 0x{self._ptregs_offset:x}\n')
             f.seek(self._ptregs_offset, 0)
             f.write(struct.pack(f"={len(PT_REGS)}q",
-- 
2.47.1


