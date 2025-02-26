Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 160A7C18E7C
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 14:41:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnIaw-0005lA-R3; Wed, 26 Feb 2025 09:41:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.lugou@provenrun.com>)
 id 1tnIaH-0005Or-4P; Wed, 26 Feb 2025 09:40:28 -0500
Received: from mail-francecentralazlp170110002.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::2] helo=PAUP264CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.lugou@provenrun.com>)
 id 1tnIaE-0003G1-Qa; Wed, 26 Feb 2025 09:40:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jKGeaR8g57adw6CadqrYpyQhAb7U2ZyVXyrFE9UlXT4UcDMV9JatKTXuaYv0Oe9P8eGO6aizIO09Sk8pzDAaDKXX6PUFhg/baLMZhedVpnl2jSnSFTmVv+RqPoNmc3tBNUdp81bO4ahYFwwIQCH8umjZUMcUCsg0Rb0Id5qNxjx1e++Ec6AbEBbxwJKPK6mD4n249j0V0UHzmpeeUkpPOQeu3WSzrXW+5h7CazDrFDa+PEFkKCYBBiHmsnscYIa6kUx3699BjwNyvR2uyjzSdYUik49k1ouFZ0w1WPkRzwCN4UBRLop+n8Hc4P6qYEEGBLnb07DmYftq1XAr2vMqsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EtdcfQsRu430XON7bWtSEwbLUbBdu7WhQasdSJW1WQc=;
 b=V6/xIA3jc8DHDVc66Vmes7oA79O/AprB4Kon82rbBD7ogWoVB59vlrRLdLRWjthhaaYo0ffpwLPboTAySYFqswJ3/KGWGhp+sADUPrPeuDxIOi3v8xLVaYFUOLN/lTXHD2Hmit8M1tcVyn2WD0NaKAeXMfUfHaz9rE4adMzXDw2p7psXvD5Syb5VU6cUWeCHZZ+wZG4FykZoRTkfFi6JIKCV0T69b9OiULWsDrb4qKZ0cLlJEIQcRJsS39Igzd2IG4I9A3PxV1nqfbMxaLnbsE0S/sfDPG4JDVkqWJ2KW6eaoJnr5vYQGcG+002dobKvj1kmvznQCV4w/t3a+FHJcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=provenrun.com; dmarc=pass action=none
 header.from=provenrun.com; dkim=pass header.d=provenrun.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=provenrun.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EtdcfQsRu430XON7bWtSEwbLUbBdu7WhQasdSJW1WQc=;
 b=FZTkxDZkWWsz4BY3/WSyfJv/g2IhCm/mZMxZT79q5k2XY0uk4M0F2byvGT8XWvxLR/f/ee67nyZDTMMuWt6DuZ7jGAg/lkNs3Ixmj5boZ1pxiigxhCHrktzCrfqttS6jYqrWnLRxxzqzzDKmOqbY3+ij9En+5RpqXOjZIR1tmHAK98idlER/CDY1bTdIRq8S5ZiZ2W9qYRRSk0J1xHOWqLVsP6bYXq5V/Do+Z7chUIvL+1aKx/YvauIq5PFaPLXezZI34RStvIf6J/eBzdqAWYoZxtl9yX+/VoHW9Bd91yBvZHKW73DL7QbY03o7GyxBOHryAMCPZnrQCttLL+/x7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=provenrun.com;
Received: from PAZP264MB2990.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f2::18)
 by MR0P264MB5513.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:4b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Wed, 26 Feb
 2025 14:40:08 +0000
Received: from PAZP264MB2990.FRAP264.PROD.OUTLOOK.COM
 ([fe80::ef1:e8a1:244f:3ca7]) by PAZP264MB2990.FRAP264.PROD.OUTLOOK.COM
 ([fe80::ef1:e8a1:244f:3ca7%5]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 14:40:08 +0000
From: Florian Lugou <florian.lugou@provenrun.com>
To: qemu-devel@nongnu.org
Cc: Florian Lugou <florian.lugou@provenrun.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org
Subject: [PATCH 2/2] target/riscv: Support matching scontext in Sdtrig's
 textra CSRs
Date: Wed, 26 Feb 2025 15:39:14 +0100
Message-ID: <20250226143914.769112-3-florian.lugou@provenrun.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1f2c3a0c-78a1-4206-cb8c-08dd56737748
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|10070799003; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fi80y7yOkK+1Ry5k1YQetMLdJpMcnqDBC7B7w7TPYDV/UDw346uoZHwNV/kE?=
 =?us-ascii?Q?FEXeUYYOWwVn0mwf0r9Dh7i4IIMXx8xvqYSSAKSrVhxOPVQ0yKLhvkNc5q5R?=
 =?us-ascii?Q?tuBVexyKg4oGoWR8HapgDLja1yymiza5S+k8UyMHuctCuIO904zg3bOKah6X?=
 =?us-ascii?Q?LfSpqi/nWcFxCR+W7wF+5LEGwgSEOQu1c7KpCdbm3ITdAGrdXTYgXuKQtF4R?=
 =?us-ascii?Q?B0fcH19CkQE0yPoirFrQ47bbu06yO96Aldc0W+FRnsVLhMwvaMheB/ZRav6y?=
 =?us-ascii?Q?OJUZvU+tAGM5cgRlbpq17HsvAMrsAkQsCQFghl0m8NzmbwNfhD6KUpojQCNb?=
 =?us-ascii?Q?Ztaqcl5kAK0/I6n8lbT8y0s+fDreGdliJMiefCMS7J/FXj7BdB5+n1wRd+1x?=
 =?us-ascii?Q?dL/XhiM72SfkVjbTT2mUpup5Iyp/8Z0sWZHsUGNE0mRhPOv1dV3hCcHejbid?=
 =?us-ascii?Q?MEtmqf0E/eLDeiaIorDJTS51zQcfEQD5QsexTcDLbCyeAJp/24l2LOrA/EGU?=
 =?us-ascii?Q?fJMpwy9YWf9Bjc75p5moDpRT3u8AolnDAzhZCXfCfa6XDo4H5AFSYh1sZUUi?=
 =?us-ascii?Q?AvYvRUpFUJj64D2Q5kPC/D7ShpKvR06qYU9zzllGKweefbpnXZQSB8+/e2FU?=
 =?us-ascii?Q?4tumw0wnca9GwU8bkPRCjSNQwlbqHZjLZEkSXHGBQj/fBH0CwN5cnwGF9ndu?=
 =?us-ascii?Q?OLzAjIVcU7fhzLDEsXxxNsbZzNOYTII0SV8jAcBPF61seqZLdu9uTnz8dtUS?=
 =?us-ascii?Q?9V7r7HFzH/NQV/6BRx0QAl5LI4GRs/PpVvTvJvovme6gBRtu1KDpqH1LlzlB?=
 =?us-ascii?Q?fsPnV76w2y6FUeHnVBJbX5OnJ6szFPihpej6ZXAUW6secwHQDozYkfujy3t3?=
 =?us-ascii?Q?4qDuXS3KlrvWENBEAHssz5leKE6cN3cPMXv12C/vYmEiFZ8rrtMWv+mrb3C1?=
 =?us-ascii?Q?Ok3ivKJO5F1E0jWX65rMa1SvCG21n35+Hx89abMI1s7w13t5IO6GOrFOO6jH?=
 =?us-ascii?Q?H5JUtusnkK7eJKuJ2RFfjCZIRkoHp6rq58O0khVT0L0RjPwufebJnBvyZIgw?=
 =?us-ascii?Q?GpOKHyAHA/Thk5HZWpJTTUlp9yOwgMdep7VSJOdjUPgw5C8IUnSAZRIT+44c?=
 =?us-ascii?Q?vu38XEJetyt8MRbYSAtfymexa+lD0xrG5xmA1yGb4VGoyHj/9VySoOd8FQwB?=
 =?us-ascii?Q?c68XwxYKFBT8UEhD1NPOHWOMaaoS+HjdPbjKk6iWOSPGxih86spbwkK/I4nW?=
 =?us-ascii?Q?IZNZ2NjwcBA+gHUD3xXaZJ4JMZ7hU+HQDiML0X0mMdopiY1mQB1eoeq4bP4F?=
 =?us-ascii?Q?LINPS79DJaU3wFJ5q5BZRBRSciSpIMic3BMmnhBoZD0ZB49cSOWC0+X5MUI/?=
 =?us-ascii?Q?yAtPMNGzF2drmrVz/RkslOhYMDj1?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAZP264MB2990.FRAP264.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(10070799003); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O+IXzHBRT4hRcHdBCs8pIEiTrUM9u4b2Kit9z96xveInH9um32mvzOiifKbS?=
 =?us-ascii?Q?vYGliNQzzsXEvXLkPKqFdS7u9m6kwOmfpLMsq9gcu/eIowbCp1Ca0LkR5UwD?=
 =?us-ascii?Q?7LQ+VUmQ4NgnY/6N6/QKRaOUHOH6inZzNX90TvhYP5lSqfTIlCAfJwnR+JG8?=
 =?us-ascii?Q?sipKC4S8dncdWwZMAqnteGAuCzPjsQkbIarEKPNJVDZpXsLaEYwX+21tvxP8?=
 =?us-ascii?Q?QW5IxKbjsuYq/zxaVLlR2lnKqJeOH5by9yig8FtcjtpWjGarUZk0GqzsdLQa?=
 =?us-ascii?Q?kUkDtohk6UqMFt89Hiy/TpvO78NZ6V7t+PvmQNop92zge0mq4usFEqwitzhL?=
 =?us-ascii?Q?+OTy4Sme5HFcU3tBcgeSeWkhR5sKtddGEx1k1RGGp8eS86QoxiefAytCJVNZ?=
 =?us-ascii?Q?7jGh1SdeqvXdV5vHH6OnGk7CEvmKWflmeVuqMXpVyR/IPUz4xEt8xvTZWDqc?=
 =?us-ascii?Q?7dUrj2fJXbVdDIcNQrDRi+VIuU/w/Tum2gvpY9k0+XYyhDDnch0uRT5UYf/o?=
 =?us-ascii?Q?jKFXPiQHyJwMu1OBTPjYKz/dfJ0DkWkOp7BXOA1+CKgWTckdytyfBekmAfbE?=
 =?us-ascii?Q?+e8oQMsrl6zkMRSsB7o0GTZJ181AXdDduOMDmFK/ZaK7h+mYmxp27b40cKx3?=
 =?us-ascii?Q?ahOIBUla3ZyokFekiEDlAty9EihrnWwTGdXKLgXXKhsRjp15U+HrlWtE/gGl?=
 =?us-ascii?Q?zKMQ/iEdhgqXb3yROyFUQVPmiBR7FifPwEsXkuphRc8AsWJIWy/nyJS61cGY?=
 =?us-ascii?Q?/HrlxJDT6+Hl6/OWQWyqdx5PTg33ipT+7Vl7LNUr4ikv5suFvoc+oPnko6F2?=
 =?us-ascii?Q?f2FuKonN1+N91dgw3sXpOC5DJO4LxwyF96booYSu9LULPJpQPVbJjeTPzK3h?=
 =?us-ascii?Q?zdS3dobOKuNYyKweG72W2l1xm8IybWPS5tmij7Kny2XHppVknbGNsETFsjkF?=
 =?us-ascii?Q?4jRmC03Fqn1RyWToq6hZgBo8RQRFLjRCFl4pUlqpkSZ0LA0D00hBGfLGc/Sw?=
 =?us-ascii?Q?x95VMyNgaKgC3qooX/wC9XnCAE/VHvmfrkfQobwWfv1M3v8DYfvKnyjOsr80?=
 =?us-ascii?Q?I5ksQLiMxuFVcP9CP1RZ3NI/AjFoSGsNRFTo8+FLEcyVAnVT8Wqwif71/LAA?=
 =?us-ascii?Q?TxX77tY96Tke2vxRBSz9qk1AwZYTvUPpdPwkdtFMm28aqPWVLTJmsUpUCZm3?=
 =?us-ascii?Q?GyG7RXzBmFAvbfi9TCwcU/EC78T+Ss9jA3PnLHi+83a8QDIc82YX5NGwyJ0l?=
 =?us-ascii?Q?v3/D7cWjPAZcxMLEfFNUqKwY4QUVAeyMegxo5fhaDoo/SX//P/fXTYcw88hm?=
 =?us-ascii?Q?QVn+yy5GDwY+Lur3Z7++Y+HTU+OwN57PK1ywjfHYLGhsF7sBwJWOgezMyZNv?=
 =?us-ascii?Q?KgAr+Ri9tzfLPXq/fPaf6cQiP/b08N6fwouF+IJ+5y9eskWi5iaageZpb3ac?=
 =?us-ascii?Q?fMIfLE4tOp8XHoshieLrOUhnpD3DP50yV87FI64E2ZrnUpoFRHvuU6mJ0G1f?=
 =?us-ascii?Q?1ySOrcKqOxakF+TvXsIacp6HiENrijp6w2kvxAcK6PAz2fVsLfgOeVaNUbeG?=
 =?us-ascii?Q?wGL7ofOj3OiK761XV8WivKEyzz3XMoq0kBy+BQD5a62sxniA1Hb0Dp/1rxwg?=
 =?us-ascii?Q?Wq8DoTEdcaHUL0qL4sB4PgCmYe0zSPCpbqxr1toPkT+xCHwwCT2p3M22zqku?=
 =?us-ascii?Q?3IV0xA=3D=3D?=
X-OriginatorOrg: provenrun.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f2c3a0c-78a1-4206-cb8c-08dd56737748
X-MS-Exchange-CrossTenant-AuthSource: PAZP264MB2990.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 14:40:07.9919 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: ff654c30-3eb4-4445-b89f-a54a92b1f03d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MftX9qwR4jLeEZEiSMUjyO1lwYyX+L3fgld9cD2VlpZW4937itM87jXGfcB5t36VYi8rKL2hB7NwSeqKqFUGeLVDQdq/zJ3W/ClG3imjAnc=
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

Support setting textra32.sselect or textra64.sselect to 1 (scontext).
The trigger will only match if the content of scontext matches the value
in svalue, after it is masked as configured in sbytemask.

Signed-off-by: Florian Lugou <florian.lugou@provenrun.com>
---
 target/riscv/debug.c | 75 +++++++++++++++++++++++++++++++-------------
 target/riscv/debug.h |  3 ++
 2 files changed, 57 insertions(+), 21 deletions(-)

diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index 914a9ce0f8..ac9752d30e 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -219,8 +219,8 @@ static inline void warn_always_zero_bit(target_ulong val, target_ulong mask,
 
 static target_ulong textra_validate(CPURISCVState *env, target_ulong tdata3)
 {
-    target_ulong mhvalue, mhselect;
-    target_ulong mhselect_new;
+    target_ulong mhvalue, mhselect, sbytemask, svalue, sselect;
+    target_ulong mhselect_new, sselect_new;
     target_ulong textra;
     const uint32_t mhselect_no_rvh[8] = { 0, 0, 0, 0, 4, 4, 4, 4 };
 
@@ -228,25 +228,17 @@ static target_ulong textra_validate(CPURISCVState *env, target_ulong tdata3)
     case MXL_RV32:
         mhvalue  = get_field(tdata3, TEXTRA32_MHVALUE);
         mhselect = get_field(tdata3, TEXTRA32_MHSELECT);
-        /* Validate unimplemented (always zero) bits */
-        warn_always_zero_bit(tdata3, (target_ulong)TEXTRA32_SBYTEMASK,
-                             "sbytemask");
-        warn_always_zero_bit(tdata3, (target_ulong)TEXTRA32_SVALUE,
-                             "svalue");
-        warn_always_zero_bit(tdata3, (target_ulong)TEXTRA32_SSELECT,
-                             "sselect");
+        sbytemask  = get_field(tdata3, TEXTRA32_SBYTEMASK);
+        svalue  = get_field(tdata3, TEXTRA32_SVALUE);
+        sselect = get_field(tdata3, TEXTRA32_SSELECT);
         break;
     case MXL_RV64:
     case MXL_RV128:
         mhvalue  = get_field(tdata3, TEXTRA64_MHVALUE);
         mhselect = get_field(tdata3, TEXTRA64_MHSELECT);
-        /* Validate unimplemented (always zero) bits */
-        warn_always_zero_bit(tdata3, (target_ulong)TEXTRA64_SBYTEMASK,
-                             "sbytemask");
-        warn_always_zero_bit(tdata3, (target_ulong)TEXTRA64_SVALUE,
-                             "svalue");
-        warn_always_zero_bit(tdata3, (target_ulong)TEXTRA64_SSELECT,
-                             "sselect");
+        sbytemask  = get_field(tdata3, TEXTRA64_SBYTEMASK);
+        svalue  = get_field(tdata3, TEXTRA64_SVALUE);
+        sselect = get_field(tdata3, TEXTRA64_SSELECT);
         break;
     default:
         g_assert_not_reached();
@@ -258,17 +250,34 @@ static target_ulong textra_validate(CPURISCVState *env, target_ulong tdata3)
         qemu_log_mask(LOG_UNIMP, "mhselect only supports 0 or 4 for now\n");
     }
 
+    /* Validate sselect. */
+    switch (sselect) {
+    case SSELECT_IGNORE:
+    case SSELECT_SCONTEXT:
+        sselect_new = sselect;
+        break;
+    default:
+        sselect_new = 0;
+        qemu_log_mask(LOG_UNIMP, "sselect only supports 0 or 1 for now\n");
+    }
+
     /* Write legal values into textra */
     textra = 0;
     switch (riscv_cpu_mxl(env)) {
     case MXL_RV32:
-        textra = set_field(textra, TEXTRA32_MHVALUE,  mhvalue);
-        textra = set_field(textra, TEXTRA32_MHSELECT, mhselect_new);
+        textra = set_field(textra, TEXTRA32_MHVALUE,   mhvalue);
+        textra = set_field(textra, TEXTRA32_MHSELECT,  mhselect_new);
+        textra = set_field(textra, TEXTRA32_SBYTEMASK, sbytemask);
+        textra = set_field(textra, TEXTRA32_SVALUE,    svalue);
+        textra = set_field(textra, TEXTRA32_SSELECT,   sselect_new);
         break;
     case MXL_RV64:
     case MXL_RV128:
-        textra = set_field(textra, TEXTRA64_MHVALUE,  mhvalue);
-        textra = set_field(textra, TEXTRA64_MHSELECT, mhselect_new);
+        textra = set_field(textra, TEXTRA64_MHVALUE,   mhvalue);
+        textra = set_field(textra, TEXTRA64_MHSELECT,  mhselect_new);
+        textra = set_field(textra, TEXTRA64_SBYTEMASK, sbytemask);
+        textra = set_field(textra, TEXTRA64_SVALUE,    svalue);
+        textra = set_field(textra, TEXTRA64_SSELECT,   sselect_new);
         break;
     default:
         g_assert_not_reached();
@@ -368,7 +377,7 @@ static bool trigger_textra_match(CPURISCVState *env, trigger_type_t type,
                                  int trigger_index)
 {
     target_ulong textra = env->tdata3[trigger_index];
-    target_ulong mhvalue, mhselect;
+    target_ulong mhvalue, mhselect, sbytemask, svalue, sselect;
 
     if (type < TRIGGER_TYPE_AD_MATCH || type > TRIGGER_TYPE_AD_MATCH6) {
         /* textra checking is only applicable when type is 2, 3, 4, 5, or 6 */
@@ -379,11 +388,17 @@ static bool trigger_textra_match(CPURISCVState *env, trigger_type_t type,
     case MXL_RV32:
         mhvalue  = get_field(textra, TEXTRA32_MHVALUE);
         mhselect = get_field(textra, TEXTRA32_MHSELECT);
+        sbytemask = get_field(textra, TEXTRA32_SBYTEMASK);
+        svalue = get_field(textra, TEXTRA32_SVALUE);
+        sselect = get_field(textra, TEXTRA32_SSELECT);
         break;
     case MXL_RV64:
     case MXL_RV128:
         mhvalue  = get_field(textra, TEXTRA64_MHVALUE);
         mhselect = get_field(textra, TEXTRA64_MHSELECT);
+        sbytemask  = get_field(textra, TEXTRA64_SBYTEMASK);
+        svalue  = get_field(textra, TEXTRA64_SVALUE);
+        sselect = get_field(textra, TEXTRA64_SSELECT);
         break;
     default:
         g_assert_not_reached();
@@ -403,6 +418,24 @@ static bool trigger_textra_match(CPURISCVState *env, trigger_type_t type,
         break;
     }
 
+    target_ulong svalue_mask = ((sbytemask & 1) * 0xFF) |
+        ((sbytemask & 2) * 0x7F80) | ((sbytemask & 4) * 0x3FC000) |
+        ((sbytemask & 8) * 0x1FE00000);
+
+    /* Check svalue and sselect. */
+    switch (sselect) {
+    case SSELECT_IGNORE:
+        break;
+    case SSELECT_SCONTEXT:
+        /* Match if the low bits of scontext equal svalue. */
+        if ((svalue & svalue_mask) != (env->scontext & svalue_mask)) {
+            return false;
+        }
+        break;
+    default:
+        break;
+    }
+
     return true;
 }
 
diff --git a/target/riscv/debug.h b/target/riscv/debug.h
index f76b8f944a..16b66441ca 100644
--- a/target/riscv/debug.h
+++ b/target/riscv/debug.h
@@ -134,6 +134,9 @@ enum {
 #define MHSELECT_IGNORE       0
 #define MHSELECT_MCONTEXT     4
 
+#define SSELECT_IGNORE        0
+#define SSELECT_SCONTEXT      1
+
 bool tdata_available(CPURISCVState *env, int tdata_index);
 
 target_ulong tselect_csr_read(CPURISCVState *env);
-- 
2.43.0


