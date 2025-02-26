Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD6E7C021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 14:41:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnIav-0005h3-O0; Wed, 26 Feb 2025 09:41:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.lugou@provenrun.com>)
 id 1tnIaD-0005JY-75; Wed, 26 Feb 2025 09:40:21 -0500
Received: from mail-francecentralazlp170110002.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::2] helo=PAUP264CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.lugou@provenrun.com>)
 id 1tnIaB-0003G1-58; Wed, 26 Feb 2025 09:40:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nF1xtrLSKmWZPsg/jL4U6iNspF8hA8+suVt4WW7pNdEH8tlFCoVHZU3MyA8q6UaVOWY194FO7hrc0fuV2oxn1zqhnmwQorUprl2tpXhCpGaDEHZ1OmOzmVHVUFszWlK3/tulek9iXR8P8ARn6xpLY6UGPI159Mhcd0RnXoXzctXa61HsmDvPShY/uRCN6XyHA+0XBBpMalmsYHa9O6GrwxKGezSKkjnlR6H7boJEMhg8M1Dej29WUp+gNuQJsxn2UIsrMGeOq0ZFVrJpz+i3Uk1jMX+FNT6lQt07/CK53rgBgbqNwsCHTjb+oSoq8bwvdfSJZT8SvI+C/fiR3QwFAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mp4r+VOmadAMNQZUvb3pycde9VptQ8u6s3FC6wREQko=;
 b=c196B2X8XvhlsDC8lv4CNYRf+9XDz2QJdsXtibmWOXSbQoTTdP80SNrD8JYmkGqTAlHQfgtNGf4ET6as1vW6EPcQUBkAJSR10oKpB/Ff2NQqihMUW5gI33jDCsE4q32deJOaSylBppEuSklahzC2PLMR9cE8CllaZnhdTPhlIo+EN+1+RxtuySosfDuJT7X008jlF4rxnyjUcqTBnTXwgoOG66ebH4fUaa5wzO913Z337sA766xomUO1T/L4swyOk3QSd7v5fk2P5zpiXrjAaZvQvo9J1SXwZiYhLW4DYUU/W4EofASlGmRsBGJMvFwD+cEZHQWyPnDpxP72o8kuHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=provenrun.com; dmarc=pass action=none
 header.from=provenrun.com; dkim=pass header.d=provenrun.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=provenrun.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mp4r+VOmadAMNQZUvb3pycde9VptQ8u6s3FC6wREQko=;
 b=lDoxSx01P7GjyRJg6ovVnqEh8JOFZ2HeyNjSNFa3YzxlMMIDgZQ+w0Ro3q3lL/TL7QoTi0gNjSCJcMTISLj9oeFKcMW+YWakZrXXBDyVDPddpah8vNRnNM61pIEizkKvap2vvEUabngW+5r28MqZechro+Op4SgN9j7GhbarYQKYY+SwO/ANSRYJni2ar3vhDAWaKXDt5zgiNLv62t3iJayc9JZFf7Ro5IskybYZ84FJyWRgAsq96mHCzOh4Nym5tqxrwMeAIZfq3gq60hJ08Yr/dUHrimiogt99o9EONec9vOcDRx1Vq5HR1tqAiRz6mUvfqFaK94ZHgQFy2v6hdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=provenrun.com;
Received: from PAZP264MB2990.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f2::18)
 by MR0P264MB5513.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:4b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Wed, 26 Feb
 2025 14:40:07 +0000
Received: from PAZP264MB2990.FRAP264.PROD.OUTLOOK.COM
 ([fe80::ef1:e8a1:244f:3ca7]) by PAZP264MB2990.FRAP264.PROD.OUTLOOK.COM
 ([fe80::ef1:e8a1:244f:3ca7%5]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 14:40:07 +0000
From: Florian Lugou <florian.lugou@provenrun.com>
To: qemu-devel@nongnu.org
Cc: Florian Lugou <florian.lugou@provenrun.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org
Subject: [PATCH 1/2] target/riscv: Add scontext CSR handling
Date: Wed, 26 Feb 2025 15:39:13 +0100
Message-ID: <20250226143914.769112-2-florian.lugou@provenrun.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250226143914.769112-1-florian.lugou@provenrun.com>
References: <20250226143914.769112-1-florian.lugou@provenrun.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0019.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2df::15) To PAZP264MB2990.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1f2::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAZP264MB2990:EE_|MR0P264MB5513:EE_
X-MS-Office365-Filtering-Correlation-Id: 063c8666-2ee1-4818-577a-08dd567376d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|10070799003; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XgtEUKWUQmMZoxncraqoTG8Dc6BKiIO/2WvZNst7XcqkjXeJU2qqXjVsuSa3?=
 =?us-ascii?Q?40icftNgZRFuonnHGUWEXCgkqPNCWLjRhzWwSaj/F9chS2YmfmSC2XnDaSDp?=
 =?us-ascii?Q?1i9aRv9liLvj/yfHNQU1IqAaIIbeT0xUCJ6K935CSJ2ad/P117e8tjW4Ujno?=
 =?us-ascii?Q?/otMliya0t0rqOKt4hnI4OWg7iYh9rY05EqgYIOgp5SJ1hja5o1VabBPPnAd?=
 =?us-ascii?Q?/i136xXyvthp9Ca8m98sAcitxhwbU66+yO7hn6IbGUJj0hQ7lg95UdMF5uxL?=
 =?us-ascii?Q?8TXahrIhgrSOOd1r11xEKr4EBsKgsbg5pxa3jeuTHS+kBAHNT28yHro+i5fa?=
 =?us-ascii?Q?644GhtZ8lELprS/VSywXjcK18iQktVibEffs9oYVyOThrXPrZ2ISxxPq4YCk?=
 =?us-ascii?Q?rkf0yst1NOJggiYV9IDPJpZCvk/xWPDYGQyMYYf90Dt/SuqSWGntNu0Q4RZm?=
 =?us-ascii?Q?n0Q6U6HKIS+Ye8tbIIm7JIJuWb+Rdnh6hbHpZIR51IQ30uScK5D83IQsHUUu?=
 =?us-ascii?Q?4suDCbuqKCmK+dwmJJuSzRgxCDZoWXhywb91+28yM4OmTfh9vKSj/7aCsJxN?=
 =?us-ascii?Q?mJnYXD8f67ZefJ4I8BDFNV8Pa/NgRVkdCeZo5mfL8af2bYbIh1em8rbCyy2E?=
 =?us-ascii?Q?jOqgkHvoVhDsuwQoq/sRvzDdzWLtkg92upLwKthjPeBxSLoGl0ffNjNl+RJD?=
 =?us-ascii?Q?y6SdZshy2YLuqeB47zPODJUoH9Km1vkGtm85Pns81GUnhpLLOOH6EMhfckDt?=
 =?us-ascii?Q?rxVS6dsRTY1/i4fevNolEuvo2F5gce4fLBjdQXk0Kwr8NrxRsFtttmm4c/fM?=
 =?us-ascii?Q?PdfUXcZ3RbX9vkWb9Le3nVHJ65kXHaCxvbFvVfml7XZ8f/FCjUa8TDbjQndz?=
 =?us-ascii?Q?A6bDyR6yqqeHqcC8BRQIXnESSPivPPIY1p54eQ7dluJc+1G9TtBOn6XaYT7H?=
 =?us-ascii?Q?pxQfvCeZ/nX0/9DDtOkbvZJ9Ywg4vR6sgE541L4Z3+dJ4+2HBKVXM1baVGv3?=
 =?us-ascii?Q?EMwF73bNGn02Afw56+UO+44xfsUkjo/rJEcCTcoN4t6PNFGKWzWc4cXEh3m+?=
 =?us-ascii?Q?n7DIAPN5SfEEdbCpV09NhmCJE2A8P6A49qUhPaIvo9rhgnhH8YEv2d4iafxL?=
 =?us-ascii?Q?baUoLXLs9B9RoUjqgmWwBjadbjNMYr7/gktaEPaD/QMbkam91GXqoeJlGSxf?=
 =?us-ascii?Q?6/mkcpWgV2lvQ3vWFhfsO1RjENfIoOF7bZer/Dvm6J1+70BaJGhMDzhta7L3?=
 =?us-ascii?Q?xsi2nPSh4s3AqXCnuvx/BEvQuJ0Isa58BHMg1SYx9Q8umTVjVEXhKta9CLqc?=
 =?us-ascii?Q?1A7FbYgtsAuVPdnqQoleN18t0x68t0ABUq0cROkzGrumA1hdTHEwBV9/L0Pt?=
 =?us-ascii?Q?QhIxawfJEfHnfIOrbnk2zytOUArx?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAZP264MB2990.FRAP264.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(10070799003); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IUCyktQt+5Zkh+kNF75DzPyRyEBjM0NyU46fE7oRLr6gwciDskscTSZuHRt4?=
 =?us-ascii?Q?i+L5uoaQ9i2p3UGSgrUV73EwJFfh9+aGMvQjQ/liHCWQnKcoAKiYxKXI7QeZ?=
 =?us-ascii?Q?JjjX8nwnlc95ocZv/IFPpdzvoPNyh7vURvX8d9z8ib+otRE06MCZUSwIVY5t?=
 =?us-ascii?Q?0lboq4qPt/SeTT+gFMaeZcQBz9ObOQI0ml0jhhrc61lJFPU84kKwVYYfdcIX?=
 =?us-ascii?Q?zKspIy5xWbegOZg0lGQkp0ncUF96ATdL9mMJGfSDa/iQEz2SOnMYzRJu3pwq?=
 =?us-ascii?Q?BXwWAqN3lv4khkA23W29SS0BD2zAE5rrJiyqekF3iKWmHEwc+5SdztPK6C0O?=
 =?us-ascii?Q?y4VtgF2G7R79/iEwReQKtiw1UTMAAiPDUVarlOpb7WNjfQD10ZsQb+JiruDK?=
 =?us-ascii?Q?0r7XHUqfXXXYY6G15dLsJwUD42IVCNjT/074z75OVb4tGMaa4a5Bh3EcU7yV?=
 =?us-ascii?Q?AVp0JwjW20scIH5LH0Q/BfmE50ViDGt3lFEnEb4proL5QKSqKvXy0DD/H7d2?=
 =?us-ascii?Q?ZzkQlKwly4BBki61M84RZy+F/mBJ0ieeVpGxQYauBetMNFR650W0jmRViNBc?=
 =?us-ascii?Q?fqOp8ZrhfBTqEiokIcVop2mmCj097g6ArK4+SpNYItv/TPZr6ivBPnyflkUD?=
 =?us-ascii?Q?loFpQyI6DdQ2Ray5gb5njlWKQYPESm9QbeAKZZKvmouswFLCiwQPVJn5HNaU?=
 =?us-ascii?Q?DOR/CClOR6Xqo0Cx3o/HRxjSGhBNYRoU3JBr0TsRpWXxDOTH6jy6oDxG8LLc?=
 =?us-ascii?Q?y6lV0Sssvjkvvl5mUfapfrEk31OeH8ZkaMrCsfgIHI6yKJk4nCW7D5iqXZ2r?=
 =?us-ascii?Q?rySAg7hfaVRLAVZPDIseZW9KeilZle6HjRXe5P1bJgciZC93L8dOPd1TL3u+?=
 =?us-ascii?Q?2ot9Un4hqammrxR7VXyX8VccsxgB4schqihbbg39RzGuKFqSDABDIFvNw+7H?=
 =?us-ascii?Q?zsTDKoF1LW0KC66lWuXQ1Psbp2FR3cVwIjpnlFlmOPHZjIXdp4CEjXUYzoXT?=
 =?us-ascii?Q?f+qRP6McdNJmy1sun7SS7WOndkjlrKMdwTA+LD+5qlgiCa3NI7hNLQscAu4s?=
 =?us-ascii?Q?Iu7QSejXAZ7HPRdCVBkcv4VKOeVxh/EwywULk8lLb1mIIHYNty0zYPRNBZSH?=
 =?us-ascii?Q?cr1w2FcGsqNadzOUZaFQwduR2LozMt0VK6MQCjtRSY/wtwndGxKsshO2nedJ?=
 =?us-ascii?Q?INyNuzcaLqlL821svVQXkolbRf13MiGbNI7DLbCLek1yFOym1Vg0oLUqZJGA?=
 =?us-ascii?Q?AMzGWSTDFXJvkHmuABHFL/Y/q8vD38iOiXNSyH2+j0N/T7HU7N5q1N2uAJpp?=
 =?us-ascii?Q?qL3mQTXo0o3sXdzS04PxPXFIvo29Nc2g5fYLf1KkN3fo+2P3vyRYG45tL/7/?=
 =?us-ascii?Q?e3u5FGrctGDz0oa1uhO7eY5XJqlUZivxPjrjCqeoZcvd8Bab2U8bsFlmjGr1?=
 =?us-ascii?Q?HFQNgVSnU8nVVjXD8aTOpFvFNDv25pwfU/zU5k7Ewh5YJs6MIzf6yGeEbaCA?=
 =?us-ascii?Q?9Z/Z7BHnIbqty39ujaPONImaquWWI6tXNtDQCtZ8a6nnZSI+HxShnYqG9IM2?=
 =?us-ascii?Q?jfKGYnvreeBqGr2KCe2F0shD34L/Mm3dCe6XKpjPovFS9VmVQNo02OvSQgN1?=
 =?us-ascii?Q?OFOi33/CCkZJIc9ww0fdYs/AaXokFAUtM8AtQ6poYqknzWdlriTCbQyP+pJW?=
 =?us-ascii?Q?DDU0ZQ=3D=3D?=
X-OriginatorOrg: provenrun.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 063c8666-2ee1-4818-577a-08dd567376d0
X-MS-Exchange-CrossTenant-AuthSource: PAZP264MB2990.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 14:40:07.5430 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: ff654c30-3eb4-4445-b89f-a54a92b1f03d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7IdU0fxLy8yKVvDZFqaSDXuOUvWwXqDLK0d0pqFaXlixHw6+E1wXp79LJQ/wmfF5A0BWuEwOyuzi5p1oKD47TZQnnN8WqbUXYp2gWfN9RAs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR0P264MB5513
Received-SPF: pass client-ip=2a01:111:f403:c20a::2;
 envelope-from=florian.lugou@provenrun.com;
 helo=PAUP264CU001.outbound.protection.outlook.com
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
index 97713681cb..e47200f409 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -430,6 +430,7 @@ struct CPUArchState {
     target_ulong tdata2[RV_MAX_TRIGGERS];
     target_ulong tdata3[RV_MAX_TRIGGERS];
     target_ulong mcontext;
+    target_ulong scontext;
     struct CPUBreakpoint *cpu_breakpoint[RV_MAX_TRIGGERS];
     struct CPUWatchpoint *cpu_watchpoint[RV_MAX_TRIGGERS];
     QEMUTimer *itrigger_timer[RV_MAX_TRIGGERS];
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index f97c48a394..add0bb9d0e 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -247,6 +247,9 @@
 #define CSR_SIEH            0x114
 #define CSR_SIPH            0x154
 
+/* Supervisor-Level Sdtrig CSRs (debug) */
+#define CSR_SCONTEXT        0x5a8
+
 /* Hpervisor CSRs */
 #define CSR_HSTATUS         0x600
 #define CSR_HEDELEG         0x602
@@ -959,4 +962,6 @@ typedef enum RISCVException {
 #define MCONTEXT64                         0x0000000000001FFFULL
 #define MCONTEXT32_HCONTEXT                0x0000007F
 #define MCONTEXT64_HCONTEXT                0x0000000000003FFFULL
+#define SCONTEXT32                         0x0000FFFF
+#define SCONTEXT64                         0x00000000FFFFFFFFULL
 #endif
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index afb7544f07..1c1ac8ed67 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -3221,6 +3221,10 @@ static RISCVException write_mstateen0(CPURISCVState *env, int csrno,
         wr_mask |= SMSTATEEN0_P1P13;
     }
 
+    if (riscv_cpu_cfg(env)->debug) {
+        wr_mask |= SMSTATEEN0_HSCONTXT;
+    }
+
     if (riscv_cpu_cfg(env)->ext_smaia || riscv_cpu_cfg(env)->ext_smcsrind) {
         wr_mask |= SMSTATEEN0_SVSLCT;
     }
@@ -5053,6 +5057,35 @@ static RISCVException write_mcontext(CPURISCVState *env, int csrno,
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
@@ -5705,6 +5738,9 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_SIEH]       = { "sieh",   aia_smode32, NULL, NULL, rmw_sieh },
     [CSR_SIPH]       = { "siph",   aia_smode32, NULL, NULL, rmw_siph },
 
+    /* Supervisor-Level Sdtrig CSRs (debug) */
+    [CSR_SCONTEXT]   = { "scontext", debug, read_scontext, write_scontext },
+
     [CSR_HSTATUS]     = { "hstatus",     hmode,   read_hstatus, write_hstatus,
                           .min_priv_ver = PRIV_VERSION_1_12_0                },
     [CSR_HEDELEG]     = { "hedeleg",     hmode,   read_hedeleg, write_hedeleg,
diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index f6241a80be..914a9ce0f8 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -1086,4 +1086,5 @@ void riscv_trigger_reset_hold(CPURISCVState *env)
     }
 
     env->mcontext = 0;
+    env->scontext = 0;
 }
-- 
2.43.0


