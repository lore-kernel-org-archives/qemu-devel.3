Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E924C282C5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 09:39:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp2Fr-0002ee-89; Mon, 03 Mar 2025 04:38:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.lugou@provenrun.com>)
 id 1tp2EZ-0001sl-4s; Mon, 03 Mar 2025 04:37:11 -0500
Received: from mail-francecentralazlp170100000.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::] helo=PA5P264CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.lugou@provenrun.com>)
 id 1tp2EX-00007q-El; Mon, 03 Mar 2025 04:37:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X1HrK0EoU5y/N0Zz8q7E/6orfzI2iJPdC2lMv2ugRXy7JJRWCbG9v2cUdJDL2rZeh84YNGswMJtiigLh3h4RILGLv+uxEPbFrCcLBAxPDraYtncqiO4RqKilekQcGeO5xw4jtcSx5AwrwjckMuvir9dL3OQN+QTe5frQicVCftNFPZELkP0DnGN64b9QuiZhkK0gDDLfvW2Vo1NcIov55/qG0wfIga2PWM8SVnb5up5A0byx5rGW7NXVa4X1MIcjXTy5hj/qlppSxmV8DGv+msnfAHGTmL4Mxkirns8xE+8TajrC2So7k63x+HWFFg5OP+o75vXkoPXuX2AUkHjcYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=64A9Fn7HdqowCJ3QpFBhwP4Doh34P44tu8H/rIAPdco=;
 b=jj42ckkojNumtl5rMYjZVuhnH4Vd3NteuBGv/J5ABlXr0461suaH5AbxXfA91mqZ1h1M2+agjvEAzEoEFeAEsxdJAjYdIH2YEB2JjPPpWQuKZAaaLgwyR2fXUNZAe6WBIAXEjGZQI8RVIO9BKA5rnParTvMBJMWqgkE2b1NkktMPg6Yssao7fcw1c+M5HExUcMSM3M2V03Zs2xFfMtf5Xsehz5+u+xWaAgwPgr+OjYABRP6X/ih3udaXmCaZcc3yLEr2zfF8nQIrkQsnyagUwJAqXN4oyUo1ex9/v9mIW99l2uBQHZj9OhUKEHyE8V0sy0veoIR/XvgZxWt1m13f3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=provenrun.com; dmarc=pass action=none
 header.from=provenrun.com; dkim=pass header.d=provenrun.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=provenrun.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=64A9Fn7HdqowCJ3QpFBhwP4Doh34P44tu8H/rIAPdco=;
 b=dGH1Xaj+Bx4m74ismzgX8s3vVBz22WxPNXRfmIuV7xkn86dk41vIdi4ARxPrT9gpGfawyf8Q3YWz9f586FIKJ3jIHO9bSaCfm9VG4ij2udIVTWK1RWYKpoSsIKJnMyUparG02ISSp8CAk9KQSms/DAEEiBA6P6WnqxN3MSXh+Br5sFUFpv4MwILHmRJ3yp32lflqA0yTGP0w9nqL8f0+nu3n8cxkGE2PokFAtVciLXD2KEd9jkVP4kDpJ18KseU/Bt3VHw5a+ZRY5VwaZ1OD3Q2aTAeThs9pxRyukiLhmJiHJ9uuE91380C9I4gxPKdJwSTd/2JAZ67GvvYjMCAxhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=provenrun.com;
Received: from PAZP264MB2990.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f2::18)
 by MR0P264MB5530.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:4e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Mon, 3 Mar
 2025 09:37:02 +0000
Received: from PAZP264MB2990.FRAP264.PROD.OUTLOOK.COM
 ([fe80::ef1:e8a1:244f:3ca7]) by PAZP264MB2990.FRAP264.PROD.OUTLOOK.COM
 ([fe80::ef1:e8a1:244f:3ca7%5]) with mapi id 15.20.8489.028; Mon, 3 Mar 2025
 09:37:02 +0000
From: Florian Lugou <florian.lugou@provenrun.com>
To: qemu-devel@nongnu.org
Cc: Florian Lugou <florian.lugou@provenrun.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org
Subject: [PATCH v2 1/2] target/riscv: Add scontext CSR handling
Date: Mon,  3 Mar 2025 10:31:54 +0100
Message-ID: <20250303093155.35585-2-florian.lugou@provenrun.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250303093155.35585-1-florian.lugou@provenrun.com>
References: <20250303093155.35585-1-florian.lugou@provenrun.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0158.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:36c::14) To PAZP264MB2990.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1f2::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAZP264MB2990:EE_|MR0P264MB5530:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f142c59-84fd-4bd3-fe85-08dd5a36f3a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|10070799003; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UEQp406lJfbQW8UetuKg6suXRvdf/YWTJsCDS3wWY7Va6F3h0PW3174Ke41d?=
 =?us-ascii?Q?xXK8k/8+TXzXxhWwX26hRtr+w4sfK72w1sahGVs9V803lfpiZj0tPqSt6z5z?=
 =?us-ascii?Q?0cjJSBWjGi7f3/GC4Zm0qY3KNy4TltWYYxz7GdYSF/uh2Se80wrf0DYDUv68?=
 =?us-ascii?Q?wQ02WXHxIciCHH4QTt03gG0k0oelkmy8pJs0bHA7qmB7AjW3cvciYzIYgCrD?=
 =?us-ascii?Q?Q9HAa2sjQJwLM7ZEOL0vSpQJ0aHKk+iokqZJw5f/7Wq1WpVCFmCFqimYk0/g?=
 =?us-ascii?Q?qtTbExLA/PXm7VU154w6F7Yu4fVCN98AzoY05PwMqJcsJHx+BQ1g8A8UDrwf?=
 =?us-ascii?Q?RFMYOJsFH1iQuR37g9AnPftJxQkcCu/f0DhmaZe9HKyLRRmyP4TdsKbVahVQ?=
 =?us-ascii?Q?7kBQy0ri4d3N+mP2xjyQmBzZf8BEsQfHwwAuP0Q6sLSg5+nRogYyUn3XThVt?=
 =?us-ascii?Q?fdihml2TunBYQVvKgHRDwt66NZOUXyH/XgRO8WDsc6oTyea+UMVLBK8Gdruf?=
 =?us-ascii?Q?ensFbYIryoRYD1NzI9iKssI4lbxUhOlVOjfH/xNlCWXLZSSrR4SYcDd9L42O?=
 =?us-ascii?Q?7/JjDpGFdSYoW9rCX4GzQohs69SaGMqmXds44KVkCug3DEi4ya7ZTA19CoWt?=
 =?us-ascii?Q?KB2pudTmdsrUXmP7pLCikMis+EBtzBudOAXF2IokDzdkWQ7GYa/LM2X54cq9?=
 =?us-ascii?Q?+xvCP+M1tlVCfWYBOnVPhynaEWfsnLSbSaICfyaVSIGvURoHebP+rScoYSGM?=
 =?us-ascii?Q?thPdEHjRCoIIN83s14f1ZRaY6BDSuVmq8pMbrbEKJcyBKO1gYnk2sXYkn7of?=
 =?us-ascii?Q?QhMemCBRceL9A20bzEOzojU+dZLDrY8+b/vedwUycAT0rJhq9siVjSbYbd1s?=
 =?us-ascii?Q?kIVUhcStU7iwOTjtt+uc+qKeP4MouSNP8G9MFeQizD/o2cCWZXPaWzsLuZtO?=
 =?us-ascii?Q?jbybbTZIk3a3snGoq3638+7TbGfu0v/uD0HHN3UN87h3dhk3B1rw+6BWx9a7?=
 =?us-ascii?Q?zHKi/bEsFE/liQPXV962fZ0mXYpjITdVpHKAGvhEgZZBCfGzmldwPGnKRoyS?=
 =?us-ascii?Q?/Ydzg2HzBDCGhYskDWUwcLYUcEW4Dsjgd2KxNFecYOIgzp/jIM/SZ/7yuAXo?=
 =?us-ascii?Q?xy1NKREbfldLVN9P/EBEwJ1PTnT9NvagxRyUjyr0LL9i77ogyBcwajDa4um2?=
 =?us-ascii?Q?ijFZKIBChvzeLpp/o/NOWo24uMz72cl79M71fCStZ8nYvWuBUlLQp40OKAcB?=
 =?us-ascii?Q?ekg7F0kWeNPiFRYUFeL3dNA74r4aU4V5vKC+kSLkoAFbbLWFEsTtODIyBWpC?=
 =?us-ascii?Q?OriNzkiDHU8XvxmQGzuJggh7G419egm3YUCP0N5PMOa3nqbbR0uAVXAJT1Qo?=
 =?us-ascii?Q?istdKxkpall9vWwhMX5pfHmUf3xj?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAZP264MB2990.FRAP264.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(10070799003); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zuF00wexNmXUqUto0Tl4Oq5tn9I/bWFADeAmd1HxA4fKNyRljEUL4AOrzB7O?=
 =?us-ascii?Q?eFtRfQMfHb697ovY3QwOkOzErHdyJR4tZ2QX4tJdq+2U+z90WlxmhhPKZVml?=
 =?us-ascii?Q?LFre3LOLgzErv7gcbA8kanreIVBLEPI1gX2qAI2M+f/3Yw32CWLEVlhiI/Wh?=
 =?us-ascii?Q?IESm0ZcRd3R/ixaUBqvtitnYZ9Sp0kzCXee+ji84sqWI2iDk5hyVcNg0RdsW?=
 =?us-ascii?Q?sss6X7CyxybMPckmI8sQaP9xDp7L/FNYTHK9np/exU7jDUu+V5birQCtn8Uj?=
 =?us-ascii?Q?nIr50ft25Jn/4tBrn3mDhWxnw53TSwVA2nX9+VncH4dnkiWwotakYGpyB7jr?=
 =?us-ascii?Q?Pxu5v56sRIq3qlWXjVm9J2nY9MDNUsHElR3uxAO65LOs15d4Ur0mK1pfD/F3?=
 =?us-ascii?Q?XtCWVCATmi9sQ1wxkuoZZHKbzf4c+JKO5jsgFz/x4V89H2qehPcOr4BIRrY6?=
 =?us-ascii?Q?VtyOYFI9xx4P7Kuy9pRi2zbIewPxxsEBP6862dqSxb9Ttrxuo/u6KqDYdkHP?=
 =?us-ascii?Q?tdJKcVgbv0Wy/ZG8sUQX1x5Wl1mXvYRnsVRBZXoYizy3Y+kHSOgItWZp04Q+?=
 =?us-ascii?Q?ClNA8s7nkVfCBPH2PfxSRbsHo9yxK7lNHIt/TGQ6gnWX1d0A89FSqssmNmH8?=
 =?us-ascii?Q?HjU0eXU5BSHZ31vsrP5bys4CjWAHhnYn71qnlnrPrebWq5JJiJRn/iAR9EoD?=
 =?us-ascii?Q?TDF1v5taYXTGVOKYi4EmhxpklFPJjD6RFCw3LxIJHY3/ITL7sElTHszjTD08?=
 =?us-ascii?Q?oX4S4sYJeZM5h3KDFnK9fG/nFRSwOALYSW1/LIf2elNrXZmNnwpHzUXXygmt?=
 =?us-ascii?Q?vc5Yl3kLOOa2yTP/a8SOBfG6uDuzLGTyqSYY9hl93i+b+rVMsD0I8BeLuMqt?=
 =?us-ascii?Q?UL1hXoFJsXAO6h+uvN0dotvXTyycxHwKww+l7cKB7GRrIU2SEg73mEUk3tzx?=
 =?us-ascii?Q?yGPRgmmBsEmX4hNWpNIGoakL2uyWopdi/m3AAsqheNwSYR1QeVCKx0lio22z?=
 =?us-ascii?Q?XiUF2I1x5D52Wac5qQHzexNf14x6xsYG8wEfMStMn5M3uj0Jw167ZekFCCx5?=
 =?us-ascii?Q?bAid/Po76I6qK7CweqA5g5UkWN2F6uHv4EON5setrDAlVKr4Y07xIs6thhu6?=
 =?us-ascii?Q?9NwxScKb+gAyMXQLgsK+peyQkRClUMch6U/rMYFLUP5wdVsL1+CDC46ZWaWw?=
 =?us-ascii?Q?+olW0UnNcsOe5K5jCKdt9vOC+TqY5tEg0CDhNLrb7BjGG8RshgZ48Mn8DQM9?=
 =?us-ascii?Q?ViIGbkZLUVCiblJVagAdfV28oAx4qZzHsFCmp7eo4+qMGyi7mEqeSxqFGJRc?=
 =?us-ascii?Q?wrZLXH59I6gUqiGRx9ePLH22n+RlUnPbZoICf5OE8HUU/bHyFyLzRHbJeSK+?=
 =?us-ascii?Q?Se7PlPCph9hBzBPbfXs5PbqEQvPXgLfD1Ke82aY7P/TOcEqv4AINnGeAZOkx?=
 =?us-ascii?Q?F6SZRejTt6IJrc23bc945KsTeI5CV09kx220rkuKgUPNBaf4B/ubQFiyEO2z?=
 =?us-ascii?Q?nXrV+sQ/X9eOqvgjUzhILzS/cyfPVX42SXnlAnU/e7bXVl+Y631FnjzVIfTb?=
 =?us-ascii?Q?vPbbhG8SXtP+X493XFjYF2d4xJTrpXhMgeM6EEpgXIXN37YPuoST6HZ3l5Fz?=
 =?us-ascii?Q?zFQ8QZYaPA8/PnvlUUd6kZtEiY+V10x+R0nGoIadyJrbz0AJ/7atg5pDGe3O?=
 =?us-ascii?Q?khnyBw=3D=3D?=
X-OriginatorOrg: provenrun.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f142c59-84fd-4bd3-fe85-08dd5a36f3a6
X-MS-Exchange-CrossTenant-AuthSource: PAZP264MB2990.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 09:37:02.0119 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: ff654c30-3eb4-4445-b89f-a54a92b1f03d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NJk+qi1GVeJaYoPSuHx6RjbIqbIubQJshqpZfPgQg2PCcq4XlKlwYiTtP+6rGUlTR72VOoVxeOpYSmbBxHmYm1oxZEpL5Jj22e2lAnCnF9c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR0P264MB5530
Received-SPF: pass client-ip=2a01:111:f403:c20a::;
 envelope-from=florian.lugou@provenrun.com;
 helo=PA5P264CU001.outbound.protection.outlook.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

scontext size is 16 bits on RV32 and 32 bits on RV64, as recommended by
version 1.0 2025-02-21 of the debug specification.

When the Smstateen extension is implemented, accessibility to the
scontext CSR is controlled by bit 57 of the [mh]stateen0 CSRs.

Signed-off-by: Florian Lugou <florian.lugou@provenrun.com>
---
 target/riscv/cpu.h      |  1 +
 target/riscv/cpu_bits.h |  5 +++++
 target/riscv/csr.c      | 36 ++++++++++++++++++++++++++++++++++++
 target/riscv/debug.c    |  1 +
 4 files changed, 43 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 616c3bdc1c..102e8285a6 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -440,6 +440,7 @@ struct CPUArchState {
     target_ulong tdata2[RV_MAX_TRIGGERS];
     target_ulong tdata3[RV_MAX_TRIGGERS];
     target_ulong mcontext;
+    target_ulong scontext;
     struct CPUBreakpoint *cpu_breakpoint[RV_MAX_TRIGGERS];
     struct CPUWatchpoint *cpu_watchpoint[RV_MAX_TRIGGERS];
     QEMUTimer *itrigger_timer[RV_MAX_TRIGGERS];
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index a30317c617..e8997f3153 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -258,6 +258,9 @@
 /* VS-Level Control transfer records CSRs */
 #define CSR_VSCTRCTL        0x24e
 
+/* Supervisor-Level Sdtrig CSRs (debug) */
+#define CSR_SCONTEXT        0x5a8
+
 /* Hpervisor CSRs */
 #define CSR_HSTATUS         0x600
 #define CSR_HEDELEG         0x602
@@ -1103,4 +1106,6 @@ typedef enum CTRType {
 #define MCONTEXT64                         0x0000000000001FFFULL
 #define MCONTEXT32_HCONTEXT                0x0000007F
 #define MCONTEXT64_HCONTEXT                0x0000000000003FFFULL
+#define SCONTEXT32                         0x0000FFFF
+#define SCONTEXT64                         0x00000000FFFFFFFFULL
 #endif
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 0ebcca4597..37b38f24a6 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -3393,6 +3393,10 @@ static RISCVException write_mstateen0(CPURISCVState *env, int csrno,
         wr_mask |= SMSTATEEN0_P1P13;
     }
 
+    if (riscv_cpu_cfg(env)->debug) {
+        wr_mask |= SMSTATEEN0_HSCONTXT;
+    }
+
     if (riscv_cpu_cfg(env)->ext_smaia || riscv_cpu_cfg(env)->ext_smcsrind) {
         wr_mask |= SMSTATEEN0_SVSLCT;
     }
@@ -5321,6 +5325,35 @@ static RISCVException write_mcontext(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
+static RISCVException read_scontext(CPURISCVState *env, int csrno,
+                                    target_ulong *val)
+{
+    RISCVException ret = smstateen_acc_ok(env, 0, SMSTATEEN0_HSCONTXT);
+    if (ret != RISCV_EXCP_NONE) {
+        return ret;
+    }
+
+    *val = env->scontext;
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException write_scontext(CPURISCVState *env, int csrno,
+                                     target_ulong val)
+{
+    bool rv32 = riscv_cpu_mxl(env) == MXL_RV32 ? true : false;
+
+    RISCVException ret = smstateen_acc_ok(env, 0, SMSTATEEN0_HSCONTXT);
+    if (ret != RISCV_EXCP_NONE) {
+        return ret;
+    }
+
+    /* Spec suggest 16-bit for RV32 and 34-bit for RV64 */
+    target_ulong mask = rv32 ? SCONTEXT32 : SCONTEXT64;
+
+    env->scontext = val & mask;
+    return RISCV_EXCP_NONE;
+}
+
 static RISCVException read_mnscratch(CPURISCVState *env, int csrno,
                                      target_ulong *val)
 {
@@ -5973,6 +6006,9 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_SIEH]       = { "sieh",   aia_smode32, NULL, NULL, rmw_sieh },
     [CSR_SIPH]       = { "siph",   aia_smode32, NULL, NULL, rmw_siph },
 
+    /* Supervisor-Level Sdtrig CSRs (debug) */
+    [CSR_SCONTEXT]   = { "scontext", debug, read_scontext, write_scontext },
+
     [CSR_HSTATUS]     = { "hstatus",     hmode,   read_hstatus, write_hstatus,
                           .min_priv_ver = PRIV_VERSION_1_12_0                },
     [CSR_HEDELEG]     = { "hedeleg",     hmode,   read_hedeleg, write_hedeleg,
diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index 9db4048523..072593ab12 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -1088,4 +1088,5 @@ void riscv_trigger_reset_hold(CPURISCVState *env)
     }
 
     env->mcontext = 0;
+    env->scontext = 0;
 }
-- 
2.43.0


