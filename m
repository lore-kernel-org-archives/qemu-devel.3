Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E976F357D5
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 10:23:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvC1A-0004KF-PV; Wed, 25 Feb 2026 05:21:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vvC0c-00040u-2z; Wed, 25 Feb 2026 05:20:47 -0500
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vvC0Z-0002uZ-VX; Wed, 25 Feb 2026 05:20:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GfjOgE9MtdIyOqXnWt59Yz0pTEApi59B4O+vQU1uMlbVoESqc88+ZHyThVa7Z3qnW996P2H8LzJBPXcJFP7SCUW+uSiB5i2KIHFrCzutofo/FyuTOrDSoPABPw7nGRouNHlTBa60684tiKpns1BXUGuJZJTSEWrbUp3OoorHkd6rsssBhAxN3Xhhkw0BsGAVIl4NwG1M6nOgdicxhtqtf8hoQk5ZKZVZE7iylDEUMJ5rPdMH0cwMad5GKYFngy/0p/FqCeTVRb5ze02J2pWuC+y1qHKfqqmdhMJw+Ln21RkI04O8hEbnuZZNrceq9UTsEEc3ZEJBRaA28d4c6bMvmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M5sCJrxICc+smsasQXi8MXvc7WNfca6x4uw8xkFqqmA=;
 b=P0byIHSKT2/oLG22XCtNQVXHu7rC6UryL7TJseDoW6Wor1aN7bhTUbAdT1eukXetHDbPMYdCWAW6P2x8P/gOM7+k/c/gbLxZMKs3BtIbdP8qHPPYNyqxWnoT//x7H1GrqSybaD2JjxLgyTdG1Fhv6U1oSfwKTxZwQ7aOjiMuC+9WtBPAu7KLWxNgwE3h2SEoEs4ma/yVO18lqMbMm4CmMFbh29qKZ+zV66zH7A00Bn6K+fcsIIC7pGp0k8Lf5nFPuIr49XBsRzmr8Vufg3tS9pwZ7QN0pPxQQPpPspwIIwl2uPaFmEph4SgWjZ/0XguOJAFvM4ns/n8B1w6jlX1Hww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5sCJrxICc+smsasQXi8MXvc7WNfca6x4uw8xkFqqmA=;
 b=rk76YTUGBjCPRRMgdYcs9NNbYpnmV8bEFcNb5sLm/mM+RR+0JT5rs9GMYBdb7dCMoET3q69hb7FM9Mdi17MqoY8FyOtp51OMFSEoiU8F9iZFOSr7ldUpkuaTcu8rjjv8Inu3ylnaQbr/Qv1tY5uTpEqtxvv/AUOaSgPb72jkzPwtFVhfWaukoOlmspKbjw7o3IP+/X8ye3b/GsQWFVOCHZFprhAq3DZ/f2d5UCuB4rubwfFK0T+wTuz3dNB0ZM2GYycAS0UfbdoWUpRTmnD8tZyWMQ2E6Wu7eL/RCO3yj63vhn8P0LAwkJpTNNJ/xNv8SpjFftvV/eotRuRClhSghg==
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com (2603:10a6:150:358::6)
 by PA1PR09MB7406.eurprd09.prod.outlook.com (2603:10a6:102:466::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Wed, 25 Feb
 2026 10:20:28 +0000
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63]) by GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63%3]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 10:20:28 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v2 04/16] target/riscv: Ensure LE instruction fetching
Thread-Topic: [PATCH v2 04/16] target/riscv: Ensure LE instruction fetching
Thread-Index: AQHcpkBbk7FSXzKBFE+nx3zQqf0BIA==
Date: Wed, 25 Feb 2026 10:20:26 +0000
Message-ID: <20260225102016.200654-5-djordje.todorovic@htecgroup.com>
References: <20260225102016.200654-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20260225102016.200654-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR09MB8755:EE_|PA1PR09MB7406:EE_
x-ms-office365-filtering-correlation-id: c7e0e61e-8dad-43ae-8a14-08de74577fcd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: IehthOOlI8njyRkABuGPuF+aqiTQmnipcG/mex0xhkvWwd3Ni+J9YQjKVOHwoArIgdx//pP01SCDjtbs9fALxAi332g2kO92UnYqi98Gl7MHcNwbY9gqIBWk7IyryRM9DXdJooWdbBBqm9Tc8+CxwzvzVkStmcfQbdu0Gnpl2JoDaIWSKHTXa0C0nXj2EmvPYWC6pKG6VYZGK4tU6eA0eFqYDep7zzcSb3nNt9kt1oL4vHxyz2H5ADrgJDLkvpxJ5HDlyfv45GXananjbrv8Im/sNn3LVwstvZva9mQ2VyywUIRL29I/elkKykV8SK56A0ZBUM0S9qvsYWd2j+1S0C96KQ9rzPFqThSU/bTqGlPq73R0ANb20bqEeuXjnisZYs4ao8BRXTsVes9LrLYxcXwfILEkVIK4FADo7xQEaAzfOnAPRWDZ9EQbiQ95tnM+fL+KwHFoIfPYHxU6kciV5/k6/y4JEx6/cZGtPFGWWmU16gChK8WeGWzCQB4ZNb9LlGd2rnx6r/p8vevwTOLwCFYa8xFHZcMHDdo6HQTHaicGf5sutcRYiz7Ukqe1ojdGz94NsNZt+7y+roSPqTVXDp0v3zgxnBiqSev02FAyfnzC+dtVfub7JSbZqz+yGjOPuO3bsxJmpJOkNE+Eyl7K8QxhalQQcVzFcEOvD2Gz7E2qsvkP4qElpGNtbh9yHMfZSY5ehW3OlJUaNcsjXpbtO6ahwz1sYlRVdB1KApTsjmSPCOwEGtdKpFu0weKX/SjnIplDYV4orvwOe5/5Gxj46icvM0uvaftmNCsvJQFy3z4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR09MB8755.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?xv/ishc38mPEo6ehyrL2DqQaAYO2O1YkF5sbKZx+jPm8Nv2dAn1xR9ASrB?=
 =?iso-8859-1?Q?XO26Qsw5fxCMRl/YPLnC3HBWZztoC4mwSjvTcQdU+JzifJs3CMBt0PKr9x?=
 =?iso-8859-1?Q?ClDwtdLiMYSmvwAUhAsHkuAoi3bXNrMyKMvwfthPqq5tlme7UIG2bccbFO?=
 =?iso-8859-1?Q?4yovh3aP++ddFaz1qqtzPJ9f+/S4LHNZCGx7VvIuwmBZROd/LTeVYs+pYD?=
 =?iso-8859-1?Q?W7+y1L6Hp0YZ8sBljdX3ayvJYHjdRDJ4TFrNHRWoR4l5QVh6orPW61e+QI?=
 =?iso-8859-1?Q?C2nlaZtJ+FRHXokR55kQfaQCDZKv+o8uGoC4fbZDjb1LbfB81m+1AM+q3O?=
 =?iso-8859-1?Q?idU/lamgbrDDFiXxML44Tc0xhhQo/vHOy3xPQrHt77Rbluu1n7iVCcsB50?=
 =?iso-8859-1?Q?xPcbA1cfEJRtOI2g8LW4N7IDioMpCci+RaxO5eUQOn4/pB1Aqpizz6IJuI?=
 =?iso-8859-1?Q?JTQNaLp6V6WJ0jAwtcX59WLaHBgllFmRBSMkRLNW4kYdQQCQ5SohgAhveo?=
 =?iso-8859-1?Q?h7ZFiA/mllq2ul8d0/s2FID53FAaMhgw/wK0yBzyXVevXAygL/LzevMBW6?=
 =?iso-8859-1?Q?bS16Fde5DDa1dpgQz5KqaqKaIw4Jf8npy4RgsxAJ/uHA+e7UlmCmbFpkJS?=
 =?iso-8859-1?Q?/2tzRlF/Q2WMi/p7uXxh+cKd6viykK54V4kztOIMchRIDHrKUiTXmy35PB?=
 =?iso-8859-1?Q?lljpJ3YULc87TDuPEAVWl8eDMS9svtaOASSjnKfG+JUtAj1ZlC0iR6gQUj?=
 =?iso-8859-1?Q?AEBcynm6KXAjZMgvKGPEdAtyDibo+3MW4X63v7RCIPMvmsxJJuDif4srDN?=
 =?iso-8859-1?Q?bfB1M+XfqmyeyZhMzR1UWDrOzWsR88MWoM+QuwDuZTKhQyjJYi0/UOWjvw?=
 =?iso-8859-1?Q?QWvgSdKTGwU5rDfkJgAckFcQuvaPiQ89XDz9DInuhN1GbPo952rXrI4GmC?=
 =?iso-8859-1?Q?6g9gBH1V13FCqkNBwAhBvs58tu0TG5/H3OBhlHuwAayIFKqFhauq+9WBK6?=
 =?iso-8859-1?Q?nHol1tO+MPdC3GEJgDbfhagtTPKXaNbl+qIc3kujlUbu150v4kXudz9Ugm?=
 =?iso-8859-1?Q?cLOyjZjGN6/+7rJ/awVJa7UMDmDM/MqZuwz+hcDw2yUAyD3/B+47zoD6Rg?=
 =?iso-8859-1?Q?c8ouQg5uvF9oLY1rgB6Cb3phPc9xczrIHFQEw/mQS0CZhcDp6kLCUcMCjM?=
 =?iso-8859-1?Q?4CQAA8jmoCbzit3UmNtymF+4B/thRh2vAkcbZGw7UMT+xYNCjV6k9FXK0M?=
 =?iso-8859-1?Q?4mEf0qi2hhnptdTDPGzyo2AzPAXk6rhSLuRKvmkEyAiX5HqtZ9oXDgY3fh?=
 =?iso-8859-1?Q?32YFHnV0Gll+B+/4IP3C57Jqmy86FIwD0M7JxnH63IyvYX/R5LU0q+U02V?=
 =?iso-8859-1?Q?IhrGokGKYjCHNTEDI93Fp3I9dwwESO1NwhCRx8EQGTyBUpbXQwEgQn8m2h?=
 =?iso-8859-1?Q?+sLzc9XabTcTZZvUseqs53Gh9bhPlr+JzYJ01WoOLfyn6VAfUQZ+87+74K?=
 =?iso-8859-1?Q?WP7qkcErUS7k2FHaqJnr77/7JMXUzmzzw4vjqUUeU46IcwywvyLZ76IQt9?=
 =?iso-8859-1?Q?HEvrHwANi/CXUZcBSYz9+qNMlAPCha40MFGlzzgnsIlVR6HlNeA11KaBCB?=
 =?iso-8859-1?Q?8lI5srrnJiVbyGvd0Sj2pS/J7F0JDWnvrA1yjhKoeXkbDDWdK1JaBjnShe?=
 =?iso-8859-1?Q?oBelT0LEYNWaMjzyUyV4xFk3Vp3sbYP0AQsGbU20nHyiWSKpuaudPGoex3?=
 =?iso-8859-1?Q?zY/VZm0tX/sMbkyUbOBa5ZUkAOAn7EgzY1XGU4aBCC0S+npbmm/+mA0RuR?=
 =?iso-8859-1?Q?pcdb62wR9i5uNQlFKMUOYXqbDAf4V7VfMUg7811CwyUnZiJ8ujZ+?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR09MB8755.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7e0e61e-8dad-43ae-8a14-08de74577fcd
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 10:20:26.3005 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QTJg6FcMv8/XhI9+YIULqwcFLv4pzpwL5Bkd4QNTD83WLv0ybdroYSOAwtXBqIhuEerM+ipJ1rK5Tdmi9h39unXRZunF8mk9i0QlhdK7UEY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR09MB7406
Received-SPF: pass client-ip=2a01:111:f403:c201::1;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=AM0PR83CU005.outbound.protection.outlook.com
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

With the insroduction of BE RISCV target, instruction fetching
needs to always expect instructions to be LE encoded as specified
by the RISCV specification.
---
 target/riscv/translate.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index f687c75fe4..67dfb5f1c0 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -23,6 +23,8 @@
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
 #include "exec/target_page.h"
+#include "exec/tswap.h"
+
 #include "exec/translator.h"
 #include "accel/tcg/cpu-ldst.h"
 #include "exec/translation-block.h"
@@ -302,7 +304,7 @@ static void gen_goto_tb(DisasContext *ctx, unsigned tb_=
slot_idx,
                         target_long diff)
 {
     target_ulong dest =3D ctx->base.pc_next + diff;
-
+   =20
      /*
       * Under itrigger, instruction executes one by one like singlestep,
       * direct block chain benefits will be small.
@@ -617,7 +619,7 @@ static void gen_ctr_jal(DisasContext *ctx, int rd, targ=
et_ulong imm)
 static void gen_jal(DisasContext *ctx, int rd, target_ulong imm)
 {
     TCGv succ_pc =3D dest_gpr(ctx, rd);
-
+   =20
     /* check misaligned: */
     if (!riscv_cpu_allow_16bit_insn(ctx->cfg_ptr,
                                     ctx->priv_ver,
@@ -1253,13 +1255,13 @@ static void decode_opc(CPURISCVState *env, DisasCon=
text *ctx)
          * real one is 2 or 4 bytes. Instruction preload wouldn't trigger
          * additional page fault.
          */
-        opcode =3D translator_ldl(env, &ctx->base, ctx->base.pc_next);
+        opcode =3D tswap32(translator_ldl(env, &ctx->base, ctx->base.pc_ne=
xt));
     } else {
         /*
          * For unaligned pc, instruction preload may trigger additional
          * page fault so we only load 2 bytes here.
          */
-        opcode =3D (uint32_t) translator_lduw(env, &ctx->base, ctx->base.p=
c_next);
+        opcode =3D (uint32_t) tswap16(translator_lduw(env, &ctx->base, ctx=
->base.pc_next));
     }
     ctx->ol =3D ctx->xl;
=20
@@ -1278,9 +1280,9 @@ static void decode_opc(CPURISCVState *env, DisasConte=
xt *ctx)
     } else {
         if (!pc_is_4byte_align) {
             /* Load last 2 bytes of instruction here */
-            opcode =3D deposit32(opcode, 16, 16,
-                               translator_lduw(env, &ctx->base,
-                                               ctx->base.pc_next + 2));
+            uint16_t opcode_hi =3D translator_lduw(env, &ctx->base,
+                                                 ctx->base.pc_next + 2);
+            opcode =3D deposit32(opcode, 16, 16, tswap16(opcode_hi));
         }
         ctx->opcode =3D opcode;
=20
@@ -1396,6 +1398,7 @@ static void riscv_tr_translate_insn(DisasContextBase =
*dcbase, CPUState *cpu)
             if (page_ofs > TARGET_PAGE_SIZE - MAX_INSN_LEN) {
                 uint16_t next_insn =3D
                     translator_lduw(env, &ctx->base, ctx->base.pc_next);
+                next_insn =3D tswap16(next_insn);
                 int len =3D insn_len(next_insn);
=20
                 if (!translator_is_same_page(&ctx->base, ctx->base.pc_next=
 + len - 1)) {
--=20
2.34.1

