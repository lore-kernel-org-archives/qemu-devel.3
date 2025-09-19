Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24EAFCAC59A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 14:00:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzbcM-0004Xl-Hc; Fri, 19 Sep 2025 09:57:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gergely.futo@hightec-rt.com>)
 id 1uzZu9-0001IJ-Dy
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 08:07:59 -0400
Received: from mail.hightec-rt.com ([87.191.157.241])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gergely.futo@hightec-rt.com>)
 id 1uzZtz-0007TU-40
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 08:07:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=hightec-rt.com; s=dkim1; h=Content-Type:MIME-Version:Subject:Message-ID:CC:
 To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HZgZg1Ay3SEyQjxwqSy2dGEcGx+FR5oAUBVhD8KpYgs=; b=k6A0pNr2LUvhXxAmKzPwBnmiWd
 uYqd4NHmE/dEzUNwyQ/+OmNg4RJ2i6Y8/My+r7agv2GBrpk+7kLat0yBtGl8yFl1G57IK4E9oNeld
 FMpDUWEuymLMd2DlJcEqqT2ftZ6rXMKdoRUfY0/K5UxIktpinuN3mk9Q70KL8jsRBjRJsBSLGQDyY
 TJYdgjZMz2hbZlyh9mywtuS7mdwJpzAMgpzR8n16KzhN++viqvU0dL4kmSbdGfKjGY66tHnifUJ0n
 BPopo2uzgIUqWy9UE0lpMuqWvy+6snGFGf7NzfIraKbLVtkmOI8dsw9R4Kl2jS2JWXw3ybUNbPxE6
 poQ+LmWQ==;
Received: from htsrv210.server.htc ([192.168.44.210]:48418
 helo=cipher.server.htc)
 by mail.hightec-rt.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.97.1)
 (envelope-from <Gergely.Futo@hightec-rt.com>)
 id 1uzZto-000000000D8-1BTk; Fri, 19 Sep 2025 14:07:37 +0200
Received: from ciphermail (localhost [127.0.0.1])
 by cipher.server.htc (CipherMail) with ESMTP id 4cSrqD3lM5zFpcR;
 Fri, 19 Sep 2025 14:07:36 +0200 (CEST)
Received: from mail.hightec-rt.com (exchange.hightec.htc [192.168.44.91])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by cipher.server.htc (CipherMail) with ESMTPS id 4cSrqC5z6DzFpcR;
 Fri, 19 Sep 2025 14:07:35 +0200 (CEST)
Received: from exchange.hightec.htc (192.168.44.91) by exchange.hightec.htc
 (192.168.44.91) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Fri, 19 Sep
 2025 14:07:35 +0200
Received: from exchange.hightec.htc ([::1]) by exchange.hightec.htc ([::1])
 with mapi id 15.02.1544.034; Fri, 19 Sep 2025 14:07:35 +0200
X-SASI-Hits: BODY_SIZE_10000_PLUS 0.000000, BODY_SIZE_25K_PLUS 0.000000,
 HTML_00_01 0.050000, HTML_00_10 0.050000, INVOICE_ATTACHMENT 0.100000,
 MULTIPLE_RCPTS 0.100000, NO_CTA_URI_FOUND 0.000000, NO_FUR_HEADER 0.000000,
 NO_URI_HTTPS 0.000000, OUTBOUND 0.000000, OUTBOUND_SOPHOS 0.000000,
 SENDER_NO_AUTH 0.000000, TO_NAME_IS_ADDY 0.000000, WEBMAIL_SOURCE 0.000000,
 WEBMAIL_XOIP 0.000000, WEBMAIL_X_IP_HDR 0.000000, __ANY_URI 0.000000,
 __ATTACHMENT_FNAME_SPACE 0.000000, __ATTACHMENT_NOT_IMG 0.000000,
 __ATTACHMENT_SIZE_0_10K 0.000000, __ATTACHMENT_SIZE_25_50K 0.000000,
 __ATTACH_CTE_BASE64 0.000000, __ATTACH_CTE_QUOTED_PRINTABLE 0.000000,
 __BODY_NO_MAILTO 0.000000, __BULK_NEGATE 0.000000, __CC_NAME 0.000000,
 __CT 0.000000, __CTYPE_HAS_BOUNDARY 0.000000, __CTYPE_MULTIPART 0.000000,
 __DQ_NEG_DOMAIN 0.000000, __DQ_NEG_HEUR 0.000000, __DQ_NEG_IP 0.000000,
 __FUR_RDNS_SOPHOS 0.000000, __HAS_ATTACHMENT 0.000000,
 __HAS_ATTACHMENT1 0.000000, __HAS_ATTACHMENT2 0.000000,
 __HAS_CC_HDR 0.000000, __HAS_FROM 0.000000, __HAS_MSGID 0.000000,
 __HAS_XOIP 0.000000, __INVOICE_MULTILINGUAL 0.000000,
 __MIME_ATTACHMENT_1_N 0.000000, __MIME_ATTACHMENT_N_2 0.000000,
 __MIME_TEXT_P 0.000000, __MIME_TEXT_P1 0.000000, __MIME_TEXT_P2 0.000000,
 __MIME_VERSION 0.000000, __MSGID_32HEX 0.000000,
 __MULTIPLE_RCPTS_CC_X2 0.000000, __NO_HTML_TAG_RAW 0.000000,
 __OUTBOUND_SOPHOS_FUR 0.000000, __OUTBOUND_SOPHOS_FUR_IP 0.000000,
 __OUTBOUND_SOPHOS_FUR_RDNS 0.000000, __RCVD_FROM_DOMAIN 0.000000,
 __RCVD_FROM_SUSP_HOSTNAME 0.000000, __SANE_MSGID 0.000000,
 __SUBJ_STARTS_S_BRACKETS 0.000000, __TO_MALFORMED_2 0.000000,
 __TO_NAME 0.000000, __TO_NO_NAME 0.000000, __URI_MAILTO 0.000000,
 __URI_NO_WWW 0.000000, __URI_NS 0.000000
X-SASI-Probability: 8%
X-SASI-RCODE: 200
X-SASI-Version: Antispam-Engine: 5.1.4, AntispamData: 2025.9.19.112719
Date: Fri, 19 Sep 2025 12:07:35 +0000
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, "alistair.francis@wdc.com"
 <alistair.francis@wdc.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>
Message-ID: <c20e4af47811456eaf5f185cd75fca7f@hightec-rt.com>
Subject: [PATCH] target/riscv: check registers for RV32E/RV64E
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; 
 boundary="----=_Part_15591_1876304020.1758283656427"
Thread-Topic: [PATCH] target/riscv: check registers for RV32E/RV64E
Thread-Index: AQHcKV2SZMdcuEG8pUSF28nzKuQBxw==
Accept-Language: en-US, de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.20.26.224]
Received-SPF: pass client-ip=87.191.157.241;
 envelope-from=gergely.futo@hightec-rt.com; helo=mail.hightec-rt.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 19 Sep 2025 09:57:31 -0400
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
Reply-to:  Gergely Futo <Gergely.Futo@hightec-rt.com>
From:  Gergely Futo via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

------=_Part_15591_1876304020.1758283656427
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US

RV32E and RV64E reduce the integer register count to 16 general-purpose
registers, (x0-x15), where x0 is a dedicated zero register.

This patch checks the register usage if the `E` extension is active.

The instructions from the following extensions are covered:
   - Base Integer Instruction Set
   - "M" for Integer Multiplication and Division
   - "A" Extension for Atomic Instructions
   - "B" Extension for Bit Manipulation
   - "Zce" Extension for Code Size Reduction
   - "Zicond" Extension for Integer Conditional Operations

Signed-off-by: Gergely Futo <gergely.futo@hightec-rt.com>
---
 target/riscv/insn_trans/trans_rva.c.inc      |  44 ++++++
 target/riscv/insn_trans/trans_rvb.c.inc      |  96 +++++++++++++
 target/riscv/insn_trans/trans_rvi.c.inc      | 134 +++++++++++++++++++
 target/riscv/insn_trans/trans_rvm.c.inc      |  32 +++++
 target/riscv/insn_trans/trans_rvzce.c.inc    |   3 +
 target/riscv/insn_trans/trans_rvzicond.c.inc |   2 +
 target/riscv/translate.c                     |  28 ++++
 7 files changed, 339 insertions(+)

diff --git a/target/riscv/insn_trans/trans_rva.c.inc b/target/riscv/insn_tr=
ans/trans_rva.c.inc
index 9cf3ae8019..b87534b9aa 100644
--- a/target/riscv/insn_trans/trans_rva.c.inc
+++ b/target/riscv/insn_trans/trans_rva.c.inc
@@ -99,72 +99,96 @@ static bool gen_sc(DisasContext *ctx, arg_atomic *a, Me=
mOp mop)
 static bool trans_lr_w(DisasContext *ctx, arg_lr_w *a)
 {
     REQUIRE_A_OR_ZALRSC(ctx);
+    CHECK_X_REG_RD_RS1(ctx, a);
+
     return gen_lr(ctx, a, (MO_ALIGN | MO_TESL));
 }
=20
 static bool trans_sc_w(DisasContext *ctx, arg_sc_w *a)
 {
     REQUIRE_A_OR_ZALRSC(ctx);
+    CHECK_X_REG_RD_RS1_RS2(ctx, a);
+
     return gen_sc(ctx, a, (MO_ALIGN | MO_TESL));
 }
=20
 static bool trans_amoswap_w(DisasContext *ctx, arg_amoswap_w *a)
 {
     REQUIRE_A_OR_ZAAMO(ctx);
+    CHECK_X_REG_RD_RS1_RS2(ctx, a);
+
     return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, MO_TESL);
 }
=20
 static bool trans_amoadd_w(DisasContext *ctx, arg_amoadd_w *a)
 {
     REQUIRE_A_OR_ZAAMO(ctx);
+    CHECK_X_REG_RD_RS1_RS2(ctx, a);
+
     return gen_amo(ctx, a, &tcg_gen_atomic_fetch_add_tl, MO_TESL);
 }
=20
 static bool trans_amoxor_w(DisasContext *ctx, arg_amoxor_w *a)
 {
     REQUIRE_A_OR_ZAAMO(ctx);
+    CHECK_X_REG_RD_RS1_RS2(ctx, a);
+
     return gen_amo(ctx, a, &tcg_gen_atomic_fetch_xor_tl, MO_TESL);
 }
=20
 static bool trans_amoand_w(DisasContext *ctx, arg_amoand_w *a)
 {
     REQUIRE_A_OR_ZAAMO(ctx);
+    CHECK_X_REG_RD_RS1_RS2(ctx, a);
+
     return gen_amo(ctx, a, &tcg_gen_atomic_fetch_and_tl, MO_TESL);
 }
=20
 static bool trans_amoor_w(DisasContext *ctx, arg_amoor_w *a)
 {
     REQUIRE_A_OR_ZAAMO(ctx);
+    CHECK_X_REG_RD_RS1_RS2(ctx, a);
+
     return gen_amo(ctx, a, &tcg_gen_atomic_fetch_or_tl, MO_TESL);
 }
=20
 static bool trans_amomin_w(DisasContext *ctx, arg_amomin_w *a)
 {
     REQUIRE_A_OR_ZAAMO(ctx);
+    CHECK_X_REG_RD_RS1_RS2(ctx, a);
+
     return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smin_tl, MO_TESL);
 }
=20
 static bool trans_amomax_w(DisasContext *ctx, arg_amomax_w *a)
 {
     REQUIRE_A_OR_ZAAMO(ctx);
+    CHECK_X_REG_RD_RS1_RS2(ctx, a);
+
     return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smax_tl, MO_TESL);
 }
=20
 static bool trans_amominu_w(DisasContext *ctx, arg_amominu_w *a)
 {
     REQUIRE_A_OR_ZAAMO(ctx);
+    CHECK_X_REG_RD_RS1_RS2(ctx, a);
+
     return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umin_tl, MO_TESL);
 }
=20
 static bool trans_amomaxu_w(DisasContext *ctx, arg_amomaxu_w *a)
 {
     REQUIRE_A_OR_ZAAMO(ctx);
+    CHECK_X_REG_RD_RS1_RS2(ctx, a);
+
     return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umax_tl, MO_TESL);
 }
=20
 static bool trans_lr_d(DisasContext *ctx, arg_lr_d *a)
 {
     REQUIRE_64BIT(ctx);
+    CHECK_X_REG_RD_RS1(ctx, a);
+
     REQUIRE_A_OR_ZALRSC(ctx);
     return gen_lr(ctx, a, MO_ALIGN | MO_TEUQ);
 }
@@ -172,6 +196,8 @@ static bool trans_lr_d(DisasContext *ctx, arg_lr_d *a)
 static bool trans_sc_d(DisasContext *ctx, arg_sc_d *a)
 {
     REQUIRE_64BIT(ctx);
+    CHECK_X_REG_RD_RS1_RS2(ctx, a);
+
     REQUIRE_A_OR_ZALRSC(ctx);
     return gen_sc(ctx, a, (MO_ALIGN | MO_TEUQ));
 }
@@ -180,6 +206,8 @@ static bool trans_amoswap_d(DisasContext *ctx, arg_amos=
wap_d *a)
 {
     REQUIRE_64BIT(ctx);
     REQUIRE_A_OR_ZAAMO(ctx);
+    CHECK_X_REG_RD_RS1_RS2(ctx, a);
+
     return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, MO_TEUQ);
 }
=20
@@ -187,6 +215,8 @@ static bool trans_amoadd_d(DisasContext *ctx, arg_amoad=
d_d *a)
 {
     REQUIRE_64BIT(ctx);
     REQUIRE_A_OR_ZAAMO(ctx);
+    CHECK_X_REG_RD_RS1_RS2(ctx, a);
+
     return gen_amo(ctx, a, &tcg_gen_atomic_fetch_add_tl, MO_TEUQ);
 }
=20
@@ -194,6 +224,8 @@ static bool trans_amoxor_d(DisasContext *ctx, arg_amoxo=
r_d *a)
 {
     REQUIRE_64BIT(ctx);
     REQUIRE_A_OR_ZAAMO(ctx);
+    CHECK_X_REG_RD_RS1_RS2(ctx, a);
+
     return gen_amo(ctx, a, &tcg_gen_atomic_fetch_xor_tl, MO_TEUQ);
 }
=20
@@ -201,6 +233,8 @@ static bool trans_amoand_d(DisasContext *ctx, arg_amoan=
d_d *a)
 {
     REQUIRE_64BIT(ctx);
     REQUIRE_A_OR_ZAAMO(ctx);
+    CHECK_X_REG_RD_RS1_RS2(ctx, a);
+
     return gen_amo(ctx, a, &tcg_gen_atomic_fetch_and_tl, MO_TEUQ);
 }
=20
@@ -208,6 +242,8 @@ static bool trans_amoor_d(DisasContext *ctx, arg_amoor_=
d *a)
 {
     REQUIRE_64BIT(ctx);
     REQUIRE_A_OR_ZAAMO(ctx);
+    CHECK_X_REG_RD_RS1_RS2(ctx, a);
+
     return gen_amo(ctx, a, &tcg_gen_atomic_fetch_or_tl, MO_TEUQ);
 }
=20
@@ -215,6 +251,8 @@ static bool trans_amomin_d(DisasContext *ctx, arg_amomi=
n_d *a)
 {
     REQUIRE_64BIT(ctx);
     REQUIRE_A_OR_ZAAMO(ctx);
+    CHECK_X_REG_RD_RS1_RS2(ctx, a);
+
     return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smin_tl, MO_TEUQ);
 }
=20
@@ -222,6 +260,8 @@ static bool trans_amomax_d(DisasContext *ctx, arg_amoma=
x_d *a)
 {
     REQUIRE_64BIT(ctx);
     REQUIRE_A_OR_ZAAMO(ctx);
+    CHECK_X_REG_RD_RS1_RS2(ctx, a);
+
     return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smax_tl, MO_TEUQ);
 }
=20
@@ -229,6 +269,8 @@ static bool trans_amominu_d(DisasContext *ctx, arg_amom=
inu_d *a)
 {
     REQUIRE_64BIT(ctx);
     REQUIRE_A_OR_ZAAMO(ctx);
+    CHECK_X_REG_RD_RS1_RS2(ctx, a);
+
     return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umin_tl, MO_TEUQ);
 }
=20
@@ -236,5 +278,7 @@ static bool trans_amomaxu_d(DisasContext *ctx, arg_amom=
axu_d *a)
 {
     REQUIRE_64BIT(ctx);
     REQUIRE_A_OR_ZAAMO(ctx);
+    CHECK_X_REG_RD_RS1_RS2(ctx, a);
+
     return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umax_tl, MO_TEUQ);
 }
diff --git a/target/riscv/insn_trans/trans_rvb.c.inc b/target/riscv/insn_tr=
ans/trans_rvb.c.inc
index e4dcc7c991..f8eae605ce 100644
--- a/target/riscv/insn_trans/trans_rvb.c.inc
+++ b/target/riscv/insn_trans/trans_rvb.c.inc
@@ -69,6 +69,8 @@ static void gen_clzw(TCGv ret, TCGv arg1)
 static bool trans_clz(DisasContext *ctx, arg_clz *a)
 {
     REQUIRE_ZBB(ctx);
+    CHECK_X_REG_RD_RS1(ctx, a);
+
     return gen_unary_per_ol(ctx, a, EXT_NONE, gen_clz, gen_clzw);
 }
=20
@@ -85,66 +87,88 @@ static void gen_ctzw(TCGv ret, TCGv arg1)
 static bool trans_ctz(DisasContext *ctx, arg_ctz *a)
 {
     REQUIRE_ZBB(ctx);
+    CHECK_X_REG_RD_RS1(ctx, a);
+
     return gen_unary_per_ol(ctx, a, EXT_ZERO, gen_ctz, gen_ctzw);
 }
=20
 static bool trans_cpop(DisasContext *ctx, arg_cpop *a)
 {
     REQUIRE_ZBB(ctx);
+    CHECK_X_REG_RD_RS1(ctx, a);
+
     return gen_unary(ctx, a, EXT_ZERO, tcg_gen_ctpop_tl);
 }
=20
 static bool trans_andn(DisasContext *ctx, arg_andn *a)
 {
     REQUIRE_EITHER_EXT(ctx, zbb, zbkb);
+    CHECK_X_REG_RD_RS1_RS2(ctx, a);
+
     return gen_logic(ctx, a, tcg_gen_andc_tl);
 }
=20
 static bool trans_orn(DisasContext *ctx, arg_orn *a)
 {
     REQUIRE_EITHER_EXT(ctx, zbb, zbkb);
+    CHECK_X_REG_RD_RS1_RS2(ctx, a);
+
     return gen_logic(ctx, a, tcg_gen_orc_tl);
 }
=20
 static bool trans_xnor(DisasContext *ctx, arg_xnor *a)
 {
     REQUIRE_EITHER_EXT(ctx, zbb, zbkb);
+    CHECK_X_REG_RD_RS1_RS2(ctx, a);
+
     return gen_logic(ctx, a, tcg_gen_eqv_tl);
 }
=20
 static bool trans_min(DisasContext *ctx, arg_min *a)
 {
     REQUIRE_ZBB(ctx);
+    CHECK_X_REG_RD_RS1_RS2(ctx, a);
+
     return gen_arith(ctx, a, EXT_SIGN, tcg_gen_smin_tl, NULL);
 }
=20
 static bool trans_max(DisasContext *ctx, arg_max *a)
 {
     REQUIRE_ZBB(ctx);
+    CHECK_X_REG_RD_RS1_RS2(ctx, a);
+
     return gen_arith(ctx, a, EXT_SIGN, tcg_gen_smax_tl, NULL);
 }
=20
 static bool trans_minu(DisasContext *ctx, arg_minu *a)
 {
     REQUIRE_ZBB(ctx);
+    CHECK_X_REG_RD_RS1_RS2(ctx, a);
+
     return gen_arith(ctx, a, EXT_SIGN, tcg_gen_umin_tl, NULL);
 }
=20
 static bool trans_maxu(DisasContext *ctx, arg_maxu *a)
 {
     REQUIRE_ZBB(ctx);
+    CHECK_X_REG_RD_RS1_RS2(ctx, a);
+
     return gen_arith(ctx, a, EXT_SIGN, tcg_gen_umax_tl, NULL);
 }
=20
 static bool trans_sext_b(DisasContext *ctx, arg_sext_b *a)
 {
     REQUIRE_ZBB(ctx);
+    CHECK_X_REG_RD_RS1(ctx, a);
+
     return gen_unary(ctx, a, EXT_NONE, tcg_gen_ext8s_tl);
 }
=20
 static bool trans_sext_h(DisasContext *ctx, arg_sext_h *a)
 {
     REQUIRE_ZBB(ctx);
+    CHECK_X_REG_RD_RS1(ctx, a);
+
     return gen_unary(ctx, a, EXT_NONE, tcg_gen_ext16s_tl);
 }
=20
@@ -165,12 +189,16 @@ static void gen_bset(TCGv ret, TCGv arg1, TCGv shamt)
 static bool trans_bset(DisasContext *ctx, arg_bset *a)
 {
     REQUIRE_ZBS(ctx);
+    CHECK_X_REG_RD_RS1_RS2(ctx, a);
+
     return gen_shift(ctx, a, EXT_NONE, gen_bset, NULL);
 }
=20
 static bool trans_bseti(DisasContext *ctx, arg_bseti *a)
 {
     REQUIRE_ZBS(ctx);
+    CHECK_X_REG_RD_RS1(ctx, a);
+
     return gen_shift_imm_tl(ctx, a, EXT_NONE, gen_bset);
 }
=20
@@ -185,12 +213,16 @@ static void gen_bclr(TCGv ret, TCGv arg1, TCGv shamt)
 static bool trans_bclr(DisasContext *ctx, arg_bclr *a)
 {
     REQUIRE_ZBS(ctx);
+    CHECK_X_REG_RD_RS1_RS2(ctx, a);
+
     return gen_shift(ctx, a, EXT_NONE, gen_bclr, NULL);
 }
=20
 static bool trans_bclri(DisasContext *ctx, arg_bclri *a)
 {
     REQUIRE_ZBS(ctx);
+    CHECK_X_REG_RD_RS1(ctx, a);
+
     return gen_shift_imm_tl(ctx, a, EXT_NONE, gen_bclr);
 }
=20
@@ -205,12 +237,16 @@ static void gen_binv(TCGv ret, TCGv arg1, TCGv shamt)
 static bool trans_binv(DisasContext *ctx, arg_binv *a)
 {
     REQUIRE_ZBS(ctx);
+    CHECK_X_REG_RD_RS1_RS2(ctx, a);
+
     return gen_shift(ctx, a, EXT_NONE, gen_binv, NULL);
 }
=20
 static bool trans_binvi(DisasContext *ctx, arg_binvi *a)
 {
     REQUIRE_ZBS(ctx);
+    CHECK_X_REG_RD_RS1(ctx, a);
+
     return gen_shift_imm_tl(ctx, a, EXT_NONE, gen_binv);
 }
=20
@@ -223,12 +259,16 @@ static void gen_bext(TCGv ret, TCGv arg1, TCGv shamt)
 static bool trans_bext(DisasContext *ctx, arg_bext *a)
 {
     REQUIRE_ZBS(ctx);
+    CHECK_X_REG_RD_RS1_RS2(ctx, a);
+
     return gen_shift(ctx, a, EXT_NONE, gen_bext, NULL);
 }
=20
 static bool trans_bexti(DisasContext *ctx, arg_bexti *a)
 {
     REQUIRE_ZBS(ctx);
+    CHECK_X_REG_RD_RS1(ctx, a);
+
     return gen_shift_imm_tl(ctx, a, EXT_NONE, gen_bext);
 }
=20
@@ -250,6 +290,8 @@ static void gen_rorw(TCGv ret, TCGv arg1, TCGv arg2)
 static bool trans_ror(DisasContext *ctx, arg_ror *a)
 {
     REQUIRE_EITHER_EXT(ctx, zbb, zbkb);
+    CHECK_X_REG_RD_RS1_RS2(ctx, a);
+
     return gen_shift_per_ol(ctx, a, EXT_NONE, tcg_gen_rotr_tl, gen_rorw, N=
ULL);
 }
=20
@@ -265,6 +307,8 @@ static void gen_roriw(TCGv ret, TCGv arg1, target_long =
shamt)
 static bool trans_rori(DisasContext *ctx, arg_rori *a)
 {
     REQUIRE_EITHER_EXT(ctx, zbb, zbkb);
+    CHECK_X_REG_RD_RS1(ctx, a);
+
     return gen_shift_imm_fn_per_ol(ctx, a, EXT_NONE,
                                    tcg_gen_rotri_tl, gen_roriw, NULL);
 }
@@ -287,6 +331,8 @@ static void gen_rolw(TCGv ret, TCGv arg1, TCGv arg2)
 static bool trans_rol(DisasContext *ctx, arg_rol *a)
 {
     REQUIRE_EITHER_EXT(ctx, zbb, zbkb);
+    CHECK_X_REG_RD_RS1_RS2(ctx, a);
+
     return gen_shift_per_ol(ctx, a, EXT_NONE, tcg_gen_rotl_tl, gen_rolw, N=
ULL);
 }
=20
@@ -299,6 +345,8 @@ static bool trans_rev8_32(DisasContext *ctx, arg_rev8_3=
2 *a)
 {
     REQUIRE_32BIT(ctx);
     REQUIRE_EITHER_EXT(ctx, zbb, zbkb);
+    CHECK_X_REG_RD_RS1(ctx, a);
+
     return gen_unary(ctx, a, EXT_NONE, gen_rev8_32);
 }
=20
@@ -306,6 +354,8 @@ static bool trans_rev8_64(DisasContext *ctx, arg_rev8_6=
4 *a)
 {
     REQUIRE_64BIT(ctx);
     REQUIRE_EITHER_EXT(ctx, zbb, zbkb);
+    CHECK_X_REG_RD_RS1(ctx, a);
+
     return gen_unary(ctx, a, EXT_NONE, tcg_gen_bswap_tl);
 }
=20
@@ -330,6 +380,8 @@ static void gen_orc_b(TCGv ret, TCGv source1)
 static bool trans_orc_b(DisasContext *ctx, arg_orc_b *a)
 {
     REQUIRE_ZBB(ctx);
+    CHECK_X_REG_RD_RS1(ctx, a);
+
     return gen_unary(ctx, a, EXT_ZERO, gen_orc_b);
 }
=20
@@ -350,6 +402,7 @@ GEN_SHADD(3)
 static bool trans_sh##SHAMT##add(DisasContext *ctx, arg_sh##SHAMT##add *a)=
 \
 {                                                                         =
 \
     REQUIRE_ZBA(ctx);                                                     =
 \
+    CHECK_X_REG_RD_RS1_RS2(ctx, a);                                       =
 \
     return gen_arith(ctx, a, EXT_NONE, gen_sh##SHAMT##add, NULL);         =
 \
 }
=20
@@ -361,6 +414,8 @@ static bool trans_zext_h_32(DisasContext *ctx, arg_zext=
_h_32 *a)
 {
     REQUIRE_32BIT(ctx);
     REQUIRE_ZBB(ctx);
+    CHECK_X_REG_RD_RS1(ctx, a);
+
     return gen_unary(ctx, a, EXT_NONE, tcg_gen_ext16u_tl);
 }
=20
@@ -368,6 +423,8 @@ static bool trans_zext_h_64(DisasContext *ctx, arg_zext=
_h_64 *a)
 {
     REQUIRE_64BIT(ctx);
     REQUIRE_ZBB(ctx);
+    CHECK_X_REG_RD_RS1(ctx, a);
+
     return gen_unary(ctx, a, EXT_NONE, tcg_gen_ext16u_tl);
 }
=20
@@ -375,6 +432,8 @@ static bool trans_clzw(DisasContext *ctx, arg_clzw *a)
 {
     REQUIRE_64BIT(ctx);
     REQUIRE_ZBB(ctx);
+    CHECK_X_REG_RD_RS1(ctx, a);
+
     return gen_unary(ctx, a, EXT_NONE, gen_clzw);
 }
=20
@@ -382,6 +441,8 @@ static bool trans_ctzw(DisasContext *ctx, arg_ctzw *a)
 {
     REQUIRE_64BIT(ctx);
     REQUIRE_ZBB(ctx);
+    CHECK_X_REG_RD_RS1(ctx, a);
+
     ctx->ol =3D MXL_RV32;
     return gen_unary(ctx, a, EXT_ZERO, gen_ctzw);
 }
@@ -390,6 +451,8 @@ static bool trans_cpopw(DisasContext *ctx, arg_cpopw *a=
)
 {
     REQUIRE_64BIT(ctx);
     REQUIRE_ZBB(ctx);
+    CHECK_X_REG_RD_RS1(ctx, a);
+
     ctx->ol =3D MXL_RV32;
     return gen_unary(ctx, a, EXT_ZERO, tcg_gen_ctpop_tl);
 }
@@ -398,6 +461,8 @@ static bool trans_rorw(DisasContext *ctx, arg_rorw *a)
 {
     REQUIRE_64BIT(ctx);
     REQUIRE_EITHER_EXT(ctx, zbb, zbkb);
+    CHECK_X_REG_RD_RS1_RS2(ctx, a);
+
     ctx->ol =3D MXL_RV32;
     return gen_shift(ctx, a, EXT_NONE, gen_rorw, NULL);
 }
@@ -406,6 +471,8 @@ static bool trans_roriw(DisasContext *ctx, arg_roriw *a=
)
 {
     REQUIRE_64BIT(ctx);
     REQUIRE_EITHER_EXT(ctx, zbb, zbkb);
+    CHECK_X_REG_RD_RS1(ctx, a);
+
     ctx->ol =3D MXL_RV32;
     return gen_shift_imm_fn(ctx, a, EXT_NONE, gen_roriw, NULL);
 }
@@ -414,6 +481,8 @@ static bool trans_rolw(DisasContext *ctx, arg_rolw *a)
 {
     REQUIRE_64BIT(ctx);
     REQUIRE_EITHER_EXT(ctx, zbb, zbkb);
+    CHECK_X_REG_RD_RS1_RS2(ctx, a);
+
     ctx->ol =3D MXL_RV32;
     return gen_shift(ctx, a, EXT_NONE, gen_rolw, NULL);
 }
@@ -439,6 +508,7 @@ static bool trans_sh##SHAMT##add_uw(DisasContext *ctx, =
       \
 {                                                             \
     REQUIRE_64BIT(ctx);                                       \
     REQUIRE_ZBA(ctx);                                         \
+    CHECK_X_REG_RD_RS1_RS2(ctx, a);                           \
     return gen_arith(ctx, a, EXT_NONE, gen_sh##SHAMT##add_uw, NULL); \
 }
=20
@@ -457,6 +527,8 @@ static bool trans_add_uw(DisasContext *ctx, arg_add_uw =
*a)
 {
     REQUIRE_64BIT(ctx);
     REQUIRE_ZBA(ctx);
+    CHECK_X_REG_RD_RS1_RS2(ctx, a);
+
     return gen_arith(ctx, a, EXT_NONE, gen_add_uw, NULL);
 }
=20
@@ -469,12 +541,16 @@ static bool trans_slli_uw(DisasContext *ctx, arg_slli=
_uw *a)
 {
     REQUIRE_64BIT(ctx);
     REQUIRE_ZBA(ctx);
+    CHECK_X_REG_RD_RS1(ctx, a);
+
     return gen_shift_imm_fn(ctx, a, EXT_NONE, gen_slli_uw, NULL);
 }
=20
 static bool trans_clmul(DisasContext *ctx, arg_clmul *a)
 {
     REQUIRE_EITHER_EXT(ctx, zbc, zbkc);
+    CHECK_X_REG_RD_RS1_RS2(ctx, a);
+
     return gen_arith(ctx, a, EXT_NONE, gen_helper_clmul, NULL);
 }
=20
@@ -487,12 +563,16 @@ static void gen_clmulh(TCGv dst, TCGv src1, TCGv src2=
)
 static bool trans_clmulh(DisasContext *ctx, arg_clmulr *a)
 {
     REQUIRE_EITHER_EXT(ctx, zbc, zbkc);
+    CHECK_X_REG_RD_RS1_RS2(ctx, a);
+
     return gen_arith(ctx, a, EXT_NONE, gen_clmulh, NULL);
 }
=20
 static bool trans_clmulr(DisasContext *ctx, arg_clmulh *a)
 {
     REQUIRE_ZBC(ctx);
+    CHECK_X_REG_RD_RS1_RS2(ctx, a);
+
     return gen_arith(ctx, a, EXT_NONE, gen_helper_clmulr, NULL);
 }
=20
@@ -522,18 +602,24 @@ static void gen_packw(TCGv ret, TCGv src1, TCGv src2)
 static bool trans_brev8(DisasContext *ctx, arg_brev8 *a)
 {
     REQUIRE_ZBKB(ctx);
+    CHECK_X_REG_RD_RS1(ctx, a);
+
     return gen_unary(ctx, a, EXT_NONE, gen_helper_brev8);
 }
=20
 static bool trans_pack(DisasContext *ctx, arg_pack *a)
 {
     REQUIRE_ZBKB(ctx);
+    CHECK_X_REG_RD_RS1_RS2(ctx, a);
+
     return gen_arith(ctx, a, EXT_NONE, gen_pack, NULL);
 }
=20
 static bool trans_packh(DisasContext *ctx, arg_packh *a)
 {
     REQUIRE_ZBKB(ctx);
+    CHECK_X_REG_RD_RS1_RS2(ctx, a);
+
     return gen_arith(ctx, a, EXT_NONE, gen_packh, NULL);
 }
=20
@@ -541,6 +627,8 @@ static bool trans_packw(DisasContext *ctx, arg_packw *a=
)
 {
     REQUIRE_64BIT(ctx);
     REQUIRE_ZBKB(ctx);
+    CHECK_X_REG_RD_RS1_RS2(ctx, a);
+
     return gen_arith(ctx, a, EXT_NONE, gen_packw, NULL);
 }
=20
@@ -548,6 +636,8 @@ static bool trans_unzip(DisasContext *ctx, arg_unzip *a=
)
 {
     REQUIRE_32BIT(ctx);
     REQUIRE_ZBKB(ctx);
+    CHECK_X_REG_RD_RS1(ctx, a);
+
     return gen_unary(ctx, a, EXT_NONE, gen_helper_unzip);
 }
=20
@@ -555,17 +645,23 @@ static bool trans_zip(DisasContext *ctx, arg_zip *a)
 {
     REQUIRE_32BIT(ctx);
     REQUIRE_ZBKB(ctx);
+    CHECK_X_REG_RD_RS1(ctx, a);
+
     return gen_unary(ctx, a, EXT_NONE, gen_helper_zip);
 }
=20
 static bool trans_xperm4(DisasContext *ctx, arg_xperm4 *a)
 {
     REQUIRE_ZBKX(ctx);
+    CHECK_X_REG_RD_RS1_RS2(ctx, a);
+
     return gen_arith(ctx, a, EXT_NONE, gen_helper_xperm4, NULL);
 }
=20
 static bool trans_xperm8(DisasContext *ctx, arg_xperm8 *a)
 {
     REQUIRE_ZBKX(ctx);
+    CHECK_X_REG_RD_RS1_RS2(ctx, a);
+
     return gen_arith(ctx, a, EXT_NONE, gen_helper_xperm8, NULL);
 }
diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_tr=
ans/trans_rvi.c.inc
index b9c7160468..c69a655ad6 100644
--- a/target/riscv/insn_trans/trans_rvi.c.inc
+++ b/target/riscv/insn_trans/trans_rvi.c.inc
@@ -32,6 +32,8 @@ static bool trans_c64_illegal(DisasContext *ctx, arg_empt=
y *a)
=20
 static bool trans_lui(DisasContext *ctx, arg_lui *a)
 {
+    CHECK_X_REG_RD(ctx, a);
+
     gen_set_gpri(ctx, a->rd, a->imm);
     return true;
 }
@@ -81,6 +83,8 @@ static bool trans_lpad(DisasContext *ctx, arg_lpad *a)
=20
 static bool trans_auipc(DisasContext *ctx, arg_auipc *a)
 {
+    CHECK_X_REG_RD(ctx, a);
+
     TCGv target_pc =3D dest_gpr(ctx, a->rd);
     gen_pc_plus_diff(target_pc, ctx, a->imm);
     gen_set_gpr(ctx, a->rd, target_pc);
@@ -89,6 +93,8 @@ static bool trans_auipc(DisasContext *ctx, arg_auipc *a)
=20
 static bool trans_jal(DisasContext *ctx, arg_jal *a)
 {
+    CHECK_X_REG_RD(ctx, a);
+
     gen_jal(ctx, a->rd, a->imm);
     return true;
 }
@@ -140,6 +146,8 @@ static void gen_ctr_jalr(DisasContext *ctx, arg_jalr *a=
, TCGv dest)
=20
 static bool trans_jalr(DisasContext *ctx, arg_jalr *a)
 {
+    CHECK_X_REG_RD_RS1(ctx, a);
+
     TCGLabel *misaligned =3D NULL;
     TCGv target_pc =3D tcg_temp_new();
     TCGv succ_pc =3D dest_gpr(ctx, a->rd);
@@ -332,31 +340,43 @@ static bool gen_branch(DisasContext *ctx, arg_b *a, T=
CGCond cond)
=20
 static bool trans_beq(DisasContext *ctx, arg_beq *a)
 {
+    CHECK_X_REG_RS1_RS2(ctx, a);
+
     return gen_branch(ctx, a, TCG_COND_EQ);
 }
=20
 static bool trans_bne(DisasContext *ctx, arg_bne *a)
 {
+    CHECK_X_REG_RS1_RS2(ctx, a);
+
     return gen_branch(ctx, a, TCG_COND_NE);
 }
=20
 static bool trans_blt(DisasContext *ctx, arg_blt *a)
 {
+    CHECK_X_REG_RS1_RS2(ctx, a);
+
     return gen_branch(ctx, a, TCG_COND_LT);
 }
=20
 static bool trans_bge(DisasContext *ctx, arg_bge *a)
 {
+    CHECK_X_REG_RS1_RS2(ctx, a);
+
     return gen_branch(ctx, a, TCG_COND_GE);
 }
=20
 static bool trans_bltu(DisasContext *ctx, arg_bltu *a)
 {
+    CHECK_X_REG_RS1_RS2(ctx, a);
+
     return gen_branch(ctx, a, TCG_COND_LTU);
 }
=20
 static bool trans_bgeu(DisasContext *ctx, arg_bgeu *a)
 {
+    CHECK_X_REG_RS1_RS2(ctx, a);
+
     return gen_branch(ctx, a, TCG_COND_GEU);
 }
=20
@@ -421,22 +441,32 @@ static bool gen_load(DisasContext *ctx, arg_lb *a, Me=
mOp memop)
=20
 static bool trans_lb(DisasContext *ctx, arg_lb *a)
 {
+    CHECK_X_REG_RD_RS1(ctx, a);
+
     return gen_load(ctx, a, MO_SB);
 }
=20
 static bool trans_lh(DisasContext *ctx, arg_lh *a)
 {
+    CHECK_X_REG_RD_RS1(ctx, a);
+
     return gen_load(ctx, a, MO_TESW);
 }
=20
 static bool trans_lw(DisasContext *ctx, arg_lw *a)
 {
+    CHECK_X_REG_RD_RS1(ctx, a);
+
     return gen_load(ctx, a, MO_TESL);
 }
=20
 static bool trans_ld(DisasContext *ctx, arg_ld *a)
 {
     REQUIRE_64_OR_128BIT(ctx);
+    if (get_xl(ctx) =3D=3D MXL_RV64) {
+        CHECK_X_REG_RD_RS1(ctx, a);
+    }
+
     return gen_load(ctx, a, MO_TESQ);
 }
=20
@@ -448,17 +478,25 @@ static bool trans_lq(DisasContext *ctx, arg_lq *a)
=20
 static bool trans_lbu(DisasContext *ctx, arg_lbu *a)
 {
+    CHECK_X_REG_RD_RS1(ctx, a);
+
     return gen_load(ctx, a, MO_UB);
 }
=20
 static bool trans_lhu(DisasContext *ctx, arg_lhu *a)
 {
+    CHECK_X_REG_RD_RS1(ctx, a);
+
     return gen_load(ctx, a, MO_TEUW);
 }
=20
 static bool trans_lwu(DisasContext *ctx, arg_lwu *a)
 {
     REQUIRE_64_OR_128BIT(ctx);
+    if (get_xl(ctx) =3D=3D MXL_RV64) {
+        CHECK_X_REG_RD_RS1(ctx, a);
+    }
+
     return gen_load(ctx, a, MO_TEUL);
 }
=20
@@ -516,22 +554,32 @@ static bool gen_store(DisasContext *ctx, arg_sb *a, M=
emOp memop)
=20
 static bool trans_sb(DisasContext *ctx, arg_sb *a)
 {
+    CHECK_X_REG_RS1_RS2(ctx, a);
+
     return gen_store(ctx, a, MO_SB);
 }
=20
 static bool trans_sh(DisasContext *ctx, arg_sh *a)
 {
+    CHECK_X_REG_RS1_RS2(ctx, a);
+
     return gen_store(ctx, a, MO_TESW);
 }
=20
 static bool trans_sw(DisasContext *ctx, arg_sw *a)
 {
+    CHECK_X_REG_RS1_RS2(ctx, a);
+
     return gen_store(ctx, a, MO_TESL);
 }
=20
 static bool trans_sd(DisasContext *ctx, arg_sd *a)
 {
     REQUIRE_64_OR_128BIT(ctx);
+    if (get_xl(ctx) =3D=3D MXL_RV64) {
+        CHECK_X_REG_RS1_RS2(ctx, a);
+    }
+
     return gen_store(ctx, a, MO_TEUQ);
 }
=20
@@ -572,6 +620,8 @@ static void gen_addi2_i128(TCGv retl, TCGv reth,
=20
 static bool trans_addi(DisasContext *ctx, arg_addi *a)
 {
+    CHECK_X_REG_RD_RS1(ctx, a);
+
     return gen_arith_imm_fn(ctx, a, EXT_NONE, tcg_gen_addi_tl, gen_addi2_i=
128);
 }
=20
@@ -599,26 +649,36 @@ static void gen_sltu_i128(TCGv retl, TCGv reth,
=20
 static bool trans_slti(DisasContext *ctx, arg_slti *a)
 {
+    CHECK_X_REG_RD_RS1(ctx, a);
+
     return gen_arith_imm_tl(ctx, a, EXT_SIGN, gen_slt, gen_slt_i128);
 }
=20
 static bool trans_sltiu(DisasContext *ctx, arg_sltiu *a)
 {
+    CHECK_X_REG_RD_RS1(ctx, a);
+
     return gen_arith_imm_tl(ctx, a, EXT_SIGN, gen_sltu, gen_sltu_i128);
 }
=20
 static bool trans_xori(DisasContext *ctx, arg_xori *a)
 {
+    CHECK_X_REG_RD_RS1(ctx, a);
+
     return gen_logic_imm_fn(ctx, a, tcg_gen_xori_tl);
 }
=20
 static bool trans_ori(DisasContext *ctx, arg_ori *a)
 {
+    CHECK_X_REG_RD_RS1(ctx, a);
+
     return gen_logic_imm_fn(ctx, a, tcg_gen_ori_tl);
 }
=20
 static bool trans_andi(DisasContext *ctx, arg_andi *a)
 {
+    CHECK_X_REG_RD_RS1(ctx, a);
+
     return gen_logic_imm_fn(ctx, a, tcg_gen_andi_tl);
 }
=20
@@ -637,6 +697,8 @@ static void gen_slli_i128(TCGv retl, TCGv reth,
=20
 static bool trans_slli(DisasContext *ctx, arg_slli *a)
 {
+    CHECK_X_REG_RD_RS1(ctx, a);
+
     return gen_shift_imm_fn(ctx, a, EXT_NONE, tcg_gen_shli_tl, gen_slli_i1=
28);
 }
=20
@@ -660,6 +722,8 @@ static void gen_srli_i128(TCGv retl, TCGv reth,
=20
 static bool trans_srli(DisasContext *ctx, arg_srli *a)
 {
+    CHECK_X_REG_RD_RS1(ctx, a);
+
     return gen_shift_imm_fn_per_ol(ctx, a, EXT_NONE,
                                    tcg_gen_shri_tl, gen_srliw, gen_srli_i1=
28);
 }
@@ -684,17 +748,23 @@ static void gen_srai_i128(TCGv retl, TCGv reth,
=20
 static bool trans_srai(DisasContext *ctx, arg_srai *a)
 {
+    CHECK_X_REG_RD_RS1(ctx, a);
+
     return gen_shift_imm_fn_per_ol(ctx, a, EXT_NONE,
                                    tcg_gen_sari_tl, gen_sraiw, gen_srai_i1=
28);
 }
=20
 static bool trans_add(DisasContext *ctx, arg_add *a)
 {
+    CHECK_X_REG_RD_RS1_RS2(ctx, a);
+
     return gen_arith(ctx, a, EXT_NONE, tcg_gen_add_tl, tcg_gen_add2_tl);
 }
=20
 static bool trans_sub(DisasContext *ctx, arg_sub *a)
 {
+    CHECK_X_REG_RD_RS1_RS2(ctx, a);
+
     return gen_arith(ctx, a, EXT_NONE, tcg_gen_sub_tl, tcg_gen_sub2_tl);
 }
=20
@@ -727,16 +797,22 @@ static void gen_sll_i128(TCGv destl, TCGv desth,
=20
 static bool trans_sll(DisasContext *ctx, arg_sll *a)
 {
+    CHECK_X_REG_RD_RS1_RS2(ctx, a);
+
     return gen_shift(ctx, a, EXT_NONE, tcg_gen_shl_tl, gen_sll_i128);
 }
=20
 static bool trans_slt(DisasContext *ctx, arg_slt *a)
 {
+    CHECK_X_REG_RD_RS1_RS2(ctx, a);
+
     return gen_arith(ctx, a, EXT_SIGN, gen_slt, gen_slt_i128);
 }
=20
 static bool trans_sltu(DisasContext *ctx, arg_sltu *a)
 {
+    CHECK_X_REG_RD_RS1_RS2(ctx, a);
+
     return gen_arith(ctx, a, EXT_SIGN, gen_sltu, gen_sltu_i128);
 }
=20
@@ -769,6 +845,8 @@ static void gen_srl_i128(TCGv destl, TCGv desth,
=20
 static bool trans_srl(DisasContext *ctx, arg_srl *a)
 {
+    CHECK_X_REG_RD_RS1_RS2(ctx, a);
+
     return gen_shift(ctx, a, EXT_ZERO, tcg_gen_shr_tl, gen_srl_i128);
 }
=20
@@ -802,27 +880,39 @@ static void gen_sra_i128(TCGv destl, TCGv desth,
=20
 static bool trans_sra(DisasContext *ctx, arg_sra *a)
 {
+    CHECK_X_REG_RD_RS1_RS2(ctx, a);
+
     return gen_shift(ctx, a, EXT_SIGN, tcg_gen_sar_tl, gen_sra_i128);
 }
=20
 static bool trans_xor(DisasContext *ctx, arg_xor *a)
 {
+    CHECK_X_REG_RD_RS1(ctx, a);
+
     return gen_logic(ctx, a, tcg_gen_xor_tl);
 }
=20
 static bool trans_or(DisasContext *ctx, arg_or *a)
 {
+    CHECK_X_REG_RD_RS1(ctx, a);
+
     return gen_logic(ctx, a, tcg_gen_or_tl);
 }
=20
 static bool trans_and(DisasContext *ctx, arg_and *a)
 {
+    CHECK_X_REG_RD_RS1_RS2(ctx, a);
+
     return gen_logic(ctx, a, tcg_gen_and_tl);
 }
=20
 static bool trans_addiw(DisasContext *ctx, arg_addiw *a)
 {
     REQUIRE_64_OR_128BIT(ctx);
+    if (get_xl(ctx) =3D=3D MXL_RV64) {
+        CHECK_X_REG_RD_RS1(ctx, a);
+    }
+
     ctx->ol =3D MXL_RV32;
     return gen_arith_imm_fn(ctx, a, EXT_NONE, tcg_gen_addi_tl, NULL);
 }
@@ -830,6 +920,10 @@ static bool trans_addiw(DisasContext *ctx, arg_addiw *=
a)
 static bool trans_slliw(DisasContext *ctx, arg_slliw *a)
 {
     REQUIRE_64_OR_128BIT(ctx);
+    if (get_xl(ctx) =3D=3D MXL_RV64) {
+        CHECK_X_REG_RD_RS1(ctx, a);
+    }
+
     ctx->ol =3D MXL_RV32;
     return gen_shift_imm_fn(ctx, a, EXT_NONE, tcg_gen_shli_tl, NULL);
 }
@@ -837,6 +931,10 @@ static bool trans_slliw(DisasContext *ctx, arg_slliw *=
a)
 static bool trans_srliw(DisasContext *ctx, arg_srliw *a)
 {
     REQUIRE_64_OR_128BIT(ctx);
+    if (get_xl(ctx) =3D=3D MXL_RV64) {
+        CHECK_X_REG_RD_RS1(ctx, a);
+    }
+
     ctx->ol =3D MXL_RV32;
     return gen_shift_imm_fn(ctx, a, EXT_NONE, gen_srliw, NULL);
 }
@@ -844,6 +942,10 @@ static bool trans_srliw(DisasContext *ctx, arg_srliw *=
a)
 static bool trans_sraiw(DisasContext *ctx, arg_sraiw *a)
 {
     REQUIRE_64_OR_128BIT(ctx);
+    if (get_xl(ctx) =3D=3D MXL_RV64) {
+        CHECK_X_REG_RD_RS1(ctx, a);
+    }
+
     ctx->ol =3D MXL_RV32;
     return gen_shift_imm_fn(ctx, a, EXT_NONE, gen_sraiw, NULL);
 }
@@ -872,6 +974,10 @@ static bool trans_sraid(DisasContext *ctx, arg_sraid *=
a)
 static bool trans_addw(DisasContext *ctx, arg_addw *a)
 {
     REQUIRE_64_OR_128BIT(ctx);
+    if (get_xl(ctx) =3D=3D MXL_RV64) {
+        CHECK_X_REG_RD_RS1_RS2(ctx, a);
+    }
+
     ctx->ol =3D MXL_RV32;
     return gen_arith(ctx, a, EXT_NONE, tcg_gen_add_tl, NULL);
 }
@@ -879,6 +985,10 @@ static bool trans_addw(DisasContext *ctx, arg_addw *a)
 static bool trans_subw(DisasContext *ctx, arg_subw *a)
 {
     REQUIRE_64_OR_128BIT(ctx);
+    if (get_xl(ctx) =3D=3D MXL_RV64) {
+        CHECK_X_REG_RD_RS1_RS2(ctx, a);
+    }
+
     ctx->ol =3D MXL_RV32;
     return gen_arith(ctx, a, EXT_NONE, tcg_gen_sub_tl, NULL);
 }
@@ -886,6 +996,10 @@ static bool trans_subw(DisasContext *ctx, arg_subw *a)
 static bool trans_sllw(DisasContext *ctx, arg_sllw *a)
 {
     REQUIRE_64_OR_128BIT(ctx);
+    if (get_xl(ctx) =3D=3D MXL_RV64) {
+        CHECK_X_REG_RD_RS1_RS2(ctx, a);
+    }
+
     ctx->ol =3D MXL_RV32;
     return gen_shift(ctx, a, EXT_NONE, tcg_gen_shl_tl, NULL);
 }
@@ -893,6 +1007,10 @@ static bool trans_sllw(DisasContext *ctx, arg_sllw *a=
)
 static bool trans_srlw(DisasContext *ctx, arg_srlw *a)
 {
     REQUIRE_64_OR_128BIT(ctx);
+    if (get_xl(ctx) =3D=3D MXL_RV64) {
+        CHECK_X_REG_RD_RS1_RS2(ctx, a);
+    }
+
     ctx->ol =3D MXL_RV32;
     return gen_shift(ctx, a, EXT_ZERO, tcg_gen_shr_tl, NULL);
 }
@@ -900,6 +1018,10 @@ static bool trans_srlw(DisasContext *ctx, arg_srlw *a=
)
 static bool trans_sraw(DisasContext *ctx, arg_sraw *a)
 {
     REQUIRE_64_OR_128BIT(ctx);
+    if (get_xl(ctx) =3D=3D MXL_RV64) {
+        CHECK_X_REG_RD_RS1_RS2(ctx, a);
+    }
+
     ctx->ol =3D MXL_RV32;
     return gen_shift(ctx, a, EXT_SIGN, tcg_gen_sar_tl, NULL);
 }
@@ -1047,6 +1169,8 @@ static bool trans_csrrw(DisasContext *ctx, arg_csrrw =
*a)
 {
     RISCVMXL xl =3D get_xl(ctx);
     if (xl < MXL_RV128) {
+        CHECK_X_REG_RD_RS1(ctx, a);
+
         TCGv src =3D get_gpr(ctx, a->rs1, EXT_NONE);
=20
         /*
@@ -1087,6 +1211,8 @@ static bool trans_csrrs(DisasContext *ctx, arg_csrrs =
*a)
      * unmodified value back to the csr and will cause side effects.
      */
     if (get_xl(ctx) < MXL_RV128) {
+        CHECK_X_REG_RD_RS1(ctx, a);
+
         if (a->rs1 =3D=3D 0) {
             return do_csrr(ctx, a->rd, a->csr);
         }
@@ -1116,6 +1242,8 @@ static bool trans_csrrc(DisasContext *ctx, arg_csrrc =
*a)
      * unmodified value back to the csr and will cause side effects.
      */
     if (get_xl(ctx) < MXL_RV128) {
+        CHECK_X_REG_RD_RS1(ctx, a);
+
         if (a->rs1 =3D=3D 0) {
             return do_csrr(ctx, a->rd, a->csr);
         }
@@ -1138,6 +1266,8 @@ static bool trans_csrrwi(DisasContext *ctx, arg_csrrw=
i *a)
 {
     RISCVMXL xl =3D get_xl(ctx);
     if (xl < MXL_RV128) {
+        CHECK_X_REG_RD(ctx, a);
+
         TCGv src =3D tcg_constant_tl(a->rs1);
=20
         /*
@@ -1177,6 +1307,8 @@ static bool trans_csrrsi(DisasContext *ctx, arg_csrrs=
i *a)
      * unmodified value back to the csr and will cause side effects.
      */
     if (get_xl(ctx) < MXL_RV128) {
+        CHECK_X_REG_RD(ctx, a);
+
         if (a->rs1 =3D=3D 0) {
             return do_csrr(ctx, a->rd, a->csr);
         }
@@ -1205,6 +1337,8 @@ static bool trans_csrrci(DisasContext *ctx, arg_csrrc=
i * a)
      * unmodified value back to the csr and will cause side effects.
      */
     if (get_xl(ctx) < MXL_RV128) {
+        CHECK_X_REG_RD(ctx, a);
+
         if (a->rs1 =3D=3D 0) {
             return do_csrr(ctx, a->rd, a->csr);
         }
diff --git a/target/riscv/insn_trans/trans_rvm.c.inc b/target/riscv/insn_tr=
ans/trans_rvm.c.inc
index 795f0ccf14..e72463a465 100644
--- a/target/riscv/insn_trans/trans_rvm.c.inc
+++ b/target/riscv/insn_trans/trans_rvm.c.inc
@@ -65,6 +65,8 @@ static void gen_mul_i128(TCGv rl, TCGv rh,
 static bool trans_mul(DisasContext *ctx, arg_mul *a)
 {
     REQUIRE_M_OR_ZMMUL(ctx);
+    CHECK_X_REG_RD_RS1_RS2(ctx, a);
+
     return gen_arith(ctx, a, EXT_NONE, tcg_gen_mul_tl, gen_mul_i128);
 }
=20
@@ -103,6 +105,8 @@ static void gen_mulh_w(TCGv ret, TCGv s1, TCGv s2)
 static bool trans_mulh(DisasContext *ctx, arg_mulh *a)
 {
     REQUIRE_M_OR_ZMMUL(ctx);
+    CHECK_X_REG_RD_RS1_RS2(ctx, a);
+
     return gen_arith_per_ol(ctx, a, EXT_SIGN, gen_mulh, gen_mulh_w,
                             gen_mulh_i128);
 }
@@ -147,6 +151,8 @@ static void gen_mulhsu_w(TCGv ret, TCGv arg1, TCGv arg2=
)
 static bool trans_mulhsu(DisasContext *ctx, arg_mulhsu *a)
 {
     REQUIRE_M_OR_ZMMUL(ctx);
+    CHECK_X_REG_RD_RS1_RS2(ctx, a);
+
     return gen_arith_per_ol(ctx, a, EXT_NONE, gen_mulhsu, gen_mulhsu_w,
                             gen_mulhsu_i128);
 }
@@ -161,6 +167,8 @@ static void gen_mulhu(TCGv ret, TCGv s1, TCGv s2)
 static bool trans_mulhu(DisasContext *ctx, arg_mulhu *a)
 {
     REQUIRE_M_OR_ZMMUL(ctx);
+    CHECK_X_REG_RD_RS1_RS2(ctx, a);
+
     /* gen_mulh_w works for either sign as input. */
     return gen_arith_per_ol(ctx, a, EXT_ZERO, gen_mulhu, gen_mulh_w,
                             gen_mulhu_i128);
@@ -206,6 +214,8 @@ static void gen_div(TCGv ret, TCGv source1, TCGv source=
2)
 static bool trans_div(DisasContext *ctx, arg_div *a)
 {
     REQUIRE_EXT(ctx, RVM);
+    CHECK_X_REG_RD_RS1_RS2(ctx, a);
+
     return gen_arith(ctx, a, EXT_SIGN, gen_div, gen_div_i128);
 }
=20
@@ -238,6 +248,8 @@ static void gen_divu(TCGv ret, TCGv source1, TCGv sourc=
e2)
 static bool trans_divu(DisasContext *ctx, arg_divu *a)
 {
     REQUIRE_EXT(ctx, RVM);
+    CHECK_X_REG_RD_RS1_RS2(ctx, a);
+
     return gen_arith(ctx, a, EXT_ZERO, gen_divu, gen_divu_i128);
 }
=20
@@ -283,6 +295,8 @@ static void gen_rem(TCGv ret, TCGv source1, TCGv source=
2)
 static bool trans_rem(DisasContext *ctx, arg_rem *a)
 {
     REQUIRE_EXT(ctx, RVM);
+    CHECK_X_REG_RD_RS1_RS2(ctx, a);
+
     return gen_arith(ctx, a, EXT_SIGN, gen_rem, gen_rem_i128);
 }
=20
@@ -316,6 +330,8 @@ static void gen_remu(TCGv ret, TCGv source1, TCGv sourc=
e2)
 static bool trans_remu(DisasContext *ctx, arg_remu *a)
 {
     REQUIRE_EXT(ctx, RVM);
+    CHECK_X_REG_RD_RS1_RS2(ctx, a);
+
     return gen_arith(ctx, a, EXT_ZERO, gen_remu, gen_remu_i128);
 }
=20
@@ -323,6 +339,10 @@ static bool trans_mulw(DisasContext *ctx, arg_mulw *a)
 {
     REQUIRE_64_OR_128BIT(ctx);
     REQUIRE_M_OR_ZMMUL(ctx);
+    if (get_xl(ctx) =3D=3D MXL_RV64) {
+        CHECK_X_REG_RD_RS1_RS2(ctx, a);
+    }
+
     ctx->ol =3D MXL_RV32;
     return gen_arith(ctx, a, EXT_NONE, tcg_gen_mul_tl, NULL);
 }
@@ -339,6 +359,10 @@ static bool trans_divuw(DisasContext *ctx, arg_divuw *=
a)
 {
     REQUIRE_64_OR_128BIT(ctx);
     REQUIRE_EXT(ctx, RVM);
+    if (get_xl(ctx) =3D=3D MXL_RV64) {
+        CHECK_X_REG_RD_RS1_RS2(ctx, a);
+    }
+
     ctx->ol =3D MXL_RV32;
     return gen_arith(ctx, a, EXT_ZERO, gen_divu, NULL);
 }
@@ -347,6 +371,10 @@ static bool trans_remw(DisasContext *ctx, arg_remw *a)
 {
     REQUIRE_64_OR_128BIT(ctx);
     REQUIRE_EXT(ctx, RVM);
+    if (get_xl(ctx) =3D=3D MXL_RV64) {
+        CHECK_X_REG_RD_RS1_RS2(ctx, a);
+    }
+
     ctx->ol =3D MXL_RV32;
     return gen_arith(ctx, a, EXT_SIGN, gen_rem, NULL);
 }
@@ -355,6 +383,10 @@ static bool trans_remuw(DisasContext *ctx, arg_remuw *=
a)
 {
     REQUIRE_64_OR_128BIT(ctx);
     REQUIRE_EXT(ctx, RVM);
+    if (get_xl(ctx) =3D=3D MXL_RV64) {
+        CHECK_X_REG_RD_RS1_RS2(ctx, a);
+    }
+
     ctx->ol =3D MXL_RV32;
     return gen_arith(ctx, a, EXT_ZERO, gen_remu, NULL);
 }
diff --git a/target/riscv/insn_trans/trans_rvzce.c.inc b/target/riscv/insn_=
trans/trans_rvzce.c.inc
index c77c2b927b..f0e9292632 100644
--- a/target/riscv/insn_trans/trans_rvzce.c.inc
+++ b/target/riscv/insn_trans/trans_rvzce.c.inc
@@ -270,6 +270,7 @@ static bool trans_cm_popretz(DisasContext *ctx, arg_cm_=
popret *a)
 static bool trans_cm_mva01s(DisasContext *ctx, arg_cm_mva01s *a)
 {
     REQUIRE_ZCMP(ctx);
+    CHECK_X_REG_RS1_RS2(ctx, a);
=20
     TCGv src1 =3D get_gpr(ctx, a->rs1, EXT_NONE);
     TCGv src2 =3D get_gpr(ctx, a->rs2, EXT_NONE);
@@ -288,6 +289,8 @@ static bool trans_cm_mvsa01(DisasContext *ctx, arg_cm_m=
vsa01 *a)
         return false;
     }
=20
+    CHECK_X_REG_RS1_RS2(ctx, a);
+
     TCGv a0 =3D get_gpr(ctx, xA0, EXT_NONE);
     TCGv a1 =3D get_gpr(ctx, xA1, EXT_NONE);
=20
diff --git a/target/riscv/insn_trans/trans_rvzicond.c.inc b/target/riscv/in=
sn_trans/trans_rvzicond.c.inc
index c8e43fa325..abca39f634 100644
--- a/target/riscv/insn_trans/trans_rvzicond.c.inc
+++ b/target/riscv/insn_trans/trans_rvzicond.c.inc
@@ -43,6 +43,7 @@ static void gen_czero_nez(TCGv dest, TCGv src1, TCGv src2=
)
 static bool trans_czero_eqz(DisasContext *ctx, arg_r *a)
 {
     REQUIRE_ZICOND(ctx);
+    CHECK_X_REG_RD_RS1_RS2(ctx, a);
=20
     return gen_logic(ctx, a, gen_czero_eqz);
 }
@@ -50,6 +51,7 @@ static bool trans_czero_eqz(DisasContext *ctx, arg_r *a)
 static bool trans_czero_nez(DisasContext *ctx, arg_r *a)
 {
     REQUIRE_ZICOND(ctx);
+    CHECK_X_REG_RD_RS1_RS2(ctx, a);
=20
     return gen_logic(ctx, a, gen_czero_nez);
 }
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 9ddef2d6e2..91568abfe6 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -812,6 +812,34 @@ EX_SH(12)
     }                                            \
 } while (0)
=20
+#define CHECK_X_REG_RD(ctx, arg) do { \
+    if (has_ext(ctx, RVE) &&          \
+        (arg->rd & 0x10)) {           \
+        return false;                 \
+    }                                 \
+  } while (0)
+
+#define CHECK_X_REG_RD_RS1(ctx, arg) do {        \
+    if (has_ext(ctx, RVE) &&                     \
+        ((arg->rd | arg->rs1) & 0x10)) {         \
+        return false;                            \
+    }                                            \
+  } while (0)
+
+#define CHECK_X_REG_RS1_RS2(ctx, arg) do { \
+    if (has_ext(ctx, RVE) &&               \
+        ((arg->rs1 | arg->rs2) & 0x10)) {  \
+        return false;                      \
+    }                                      \
+  } while (0)
+
+#define CHECK_X_REG_RD_RS1_RS2(ctx, arg) do {       \
+    if (has_ext(ctx, RVE) &&                        \
+        ((arg->rd | arg->rs1 | arg->rs2) & 0x10)) { \
+        return false;                               \
+    }                                               \
+  } while (0)
+
 static int ex_rvc_register(DisasContext *ctx, int reg)
 {
     return 8 + reg;
--=20


------=_Part_15591_1876304020.1758283656427
Content-Type: application/pkcs7-signature; name=smime.p7s; smime-type=signed-data
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDTALBglghkgBZQMEAgEwgAYJKoZIhvcNAQcBAACggDCCBjQw
ggUcoAMCAQICEQDAdiXqKbHqNgx0hsSjceoMMA0GCSqGSIb3DQEBCwUAMIGWMQswCQYDVQQGEwJH
QjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQK
Ew9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNh
dGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMB4XDTI0MDgwODAwMDAwMFoXDTI2MDgwODIzNTk1OVow
LDEqMCgGCSqGSIb3DQEJARYbR2VyZ2VseS5GdXRvQGhpZ2h0ZWMtcnQuY29tMIICIjANBgkqhkiG
9w0BAQEFAAOCAg8AMIICCgKCAgEAn/KBvcz0ZXihwBjMEmatMV/TvBftk6Phtx2oOqsedERaTHCG
UXjC/LpqGWtol03XPZWCH2//kODVuZv/Fg9xu3K6+gwrEnxwhVgTLyK8Rn5HoBmeZtP3Om9s+b44
WFJ/AYyoPya9bXGKV/jnGrmYKwuLeiQov9KA8LGVYAH+421iQdU4908ypbSqNR92i2SZ57WCAqb/
Au5wc+jrIdRdv4HhhGFkVnKZFz0Yz24JmpnAIxZVD0OKubsERsADJv6RBlWeRyKdoKtGxajL23/K
mYybmNbLt546OTZakdQ4S1NWYkOwWiCVzUWJov0ibvNUWCIGbqf7BBO4SsWoFDPkmazndxW00cDC
myekS89KHdmTx/4j1mg4JWrPQqTAb0TNy5hjmRT+z4gNInLcrRXzU0k6WJi9j8AM4hJHJyfcPm16
66MwbIAaiAwZPehXARGjQhJzdNYEQK3HvhQth1mmMvHJmEs3bHoKNE0xOmstOzzF2Za7s2DO5JwE
Nu36N/63MCjpFMNwkt0D38cZ2jyooelP2EgwZ1VrhGCtWv1L5IDqIlMHVyaWSVfn/PFQyMYSS1JX
gPgPUZYipYwe+NSoKVM8pPQQu0JlxeYf8qppD19YqC2/PuLwVvvU6kxGMHrhbt+X0wmiFVs1o01P
NPxbV/zKGCEUPRMVaHe/6I1VACcCAwEAAaOCAeQwggHgMB8GA1UdIwQYMBaAFAnA8vwL2pTbX/4r
36iZQs/J4K0AMB0GA1UdDgQWBBTtjTdKK16VvnfiN2IIyNgqnBVoMzAOBgNVHQ8BAf8EBAMCBaAw
DAYDVR0TAQH/BAIwADAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwUAYDVR0gBEkwRzA6
BgwrBgEEAbIxAQIBCgEwKjAoBggrBgEFBQcCARYcaHR0cHM6Ly9zZWN0aWdvLmNvbS9TTUlNRUNQ
UzAJBgdngQwBBQECMFoGA1UdHwRTMFEwT6BNoEuGSWh0dHA6Ly9jcmwuc2VjdGlnby5jb20vU2Vj
dGlnb1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcmwwgYoGCCsGAQUF
BwEBBH4wfDBVBggrBgEFBQcwAoZJaHR0cDovL2NydC5zZWN0aWdvLmNvbS9TZWN0aWdvUlNBQ2xp
ZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNydDAjBggrBgEFBQcwAYYXaHR0cDov
L29jc3Auc2VjdGlnby5jb20wJgYDVR0RBB8wHYEbR2VyZ2VseS5GdXRvQGhpZ2h0ZWMtcnQuY29t
MA0GCSqGSIb3DQEBCwUAA4IBAQAio5jYF9cBbEvs7VKnTDASj+j0mmimgssffqzKc18XWdeD7E1/
B5eJQnqIXf0mOAuwS8ghzcJ8C2ANdlYRiH4yyv3L2QFCA0X3IhRY/DO+2UtmHboKYCcGhMl2wU9z
UMNyyjoUAczXqlThFcdExFqd6R148NlnvI+Dzk/vBNTl7hsT8PGpj0Q7MNWdvrqbICJSn2gI6zjF
wjUFoOqocnM9LIWPgyGm22CPggm3fLUfobWxGPJmj8b8XCUVzCOVk4uhDsaXX080zp53WuEkjrmg
A+rUSq2+FBL4hUiM+nk3+3V4KJot3aHVKYc4l7+k8EcCJ+bv185rZTP3UUJGkSWbMIIGEDCCA/ig
AwIBAgIQTZQsENQ74JQJxYEtOisGTzANBgkqhkiG9w0BAQwFADCBiDELMAkGA1UEBhMCVVMxEzAR
BgNVBAgTCk5ldyBKZXJzZXkxFDASBgNVBAcTC0plcnNleSBDaXR5MR4wHAYDVQQKExVUaGUgVVNF
UlRSVVNUIE5ldHdvcmsxLjAsBgNVBAMTJVVTRVJUcnVzdCBSU0EgQ2VydGlmaWNhdGlvbiBBdXRo
b3JpdHkwHhcNMTgxMTAyMDAwMDAwWhcNMzAxMjMxMjM1OTU5WjCBljELMAkGA1UEBhMCR0IxGzAZ
BgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYGA1UEChMPU2Vj
dGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdvIFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24g
YW5kIFNlY3VyZSBFbWFpbCBDQTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMo87ZQK
Qf/e+Ua56NY75tqSvysQTqoavIK9viYcKSoq0s2cUIE/bZQu85eoZ9X140qOTKl1HyLTJbazGl6n
BEibivHbSuejQkq6uIgymiqvTcTlxZql19szfBxxo0Nm9l79L9S+TZNTEDygNfcXlkHKRhBhVFHd
JDfqB6Mfi/Wlda43zYgo92yZOpCWjj2mz4tudN55/yE1+XvFnz5xsOFbme/SoY9WAa39uJORHtbC
0x7C7aYivToxuIkEQXaumf05Vcf4RgHs+Yd+mwSTManRy6XcCFJE6k/LHt3ndD3sA3If/JBz6OX2
ZebtQdHnKav7Azf+bAhudg7PkFOTuRMCAwEAAaOCAWQwggFgMB8GA1UdIwQYMBaAFFN5v1qqK0rP
VIDh2JvAnfKyA2bLMB0GA1UdDgQWBBQJwPL8C9qU21/+K9+omULPyeCtADAOBgNVHQ8BAf8EBAMC
AYYwEgYDVR0TAQH/BAgwBgEB/wIBADAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwEQYD
VR0gBAowCDAGBgRVHSAAMFAGA1UdHwRJMEcwRaBDoEGGP2h0dHA6Ly9jcmwudXNlcnRydXN0LmNv
bS9VU0VSVHJ1c3RSU0FDZXJ0aWZpY2F0aW9uQXV0aG9yaXR5LmNybDB2BggrBgEFBQcBAQRqMGgw
PwYIKwYBBQUHMAKGM2h0dHA6Ly9jcnQudXNlcnRydXN0LmNvbS9VU0VSVHJ1c3RSU0FBZGRUcnVz
dENBLmNydDAlBggrBgEFBQcwAYYZaHR0cDovL29jc3AudXNlcnRydXN0LmNvbTANBgkqhkiG9w0B
AQwFAAOCAgEAQUR1AKs5whX13o6VbTJxaIwA3RfXehwQOJDI47G9FzGR87bjgrShfsbMIYdhqpFu
SUKzPM1ZVPgNlT+9istp5UQNRsJiD4KLu+E2f102qxxvM3TEoGg65FWM89YN5yFTvSB5PelcLGnC
LwRfCX6iLPvGlh9j30lKzcT+mLO1NLGWMeK1w+vnKhav2VuQVHwpTf64ZNnXUF8p+5JJpGtkUG/X
fdJ5jR3YCq8H0OPZkNoVkDQ5CSSF8Co2AOlVEf32VBXglIrHQ3v9AAS0yPo4Xl1FdXqGFe5TcDQS
qXh3TbjugGnG+d9yZX3lB8bwc/Tn2FlIl7tPbDAL4jNdUNA7jGee+tAnTtlZ6bFz+CsWmCIb6j6l
DFqkXVsp+3KyLTZGXq6F2nnBtN4t5jO3ZIj2gpIKHAYNBAWLG2Q2fG7Bt2tPC8BLC9WIM90gbMhA
mtMGquITn/2fORdsNmaV3z/sPKuIn8DvdEhmWVfh0fyYeqxGlTw0RfwhBlakdYYrkDmdWC+XszE1
9GUi8K8plBNKcIvyg2omAdebrMIHiAHAOiczxX/aS5ABRVrNUDcjfvp4hYbDOO6qHcfzy/uY0fO5
ssebmHQREJJA3PpSgdVnLernF6pthJrGkNDPeUI05svqw1o5A2HcNzLOpklhNwZ+4uWYLcAi14AC
HuVvJsmzNicAADGCBBEwggQNAgEBMIGsMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRl
ciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQx
PjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVt
YWlsIENBAhEAwHYl6imx6jYMdIbEo3HqDDALBglghkgBZQMEAgGgggE3MBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDkxOTEyMDczNlowKwYJKoZIhvcNAQk0MR4w
HDALBglghkgBZQMEAgGhDQYJKoZIhvcNAQELBQAwLwYJKoZIhvcNAQkEMSIEIKqvWmrdTICaKgNY
LVyQlGe0IZ7msEv6nAB5qvx/vkO2MIGeBgkqhkiG9w0BCQ8xgZAwgY0wCwYJYIZIAWUDBAEqMAsG
CWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA8GCSqG
SIb2fQdCCgICAIAwDQYLKoMIjJpLPQEBAQQwDQYLKoMIjJpLPQEBAQMwDQYLKoMIjJpLPQEBAQIw
CgYIKoMajJpEAQQwDQYJKoZIhvcNAQELBQAEggIAC/RH9urEtaJFAOiD+zefYKDhIolXRJuT9wz6
yPjAdamx1H+Iexotk2W9HbSh/xQqvLuSSG1s6Q91Fnq1MpPAbpDe6D++ffei74kibKNh4YxPIs/0
FqrI8h5USfO1eIF9d5l4H47OeOeMj9h8GXDgoEeiCTCapECsgaHY5UCofQoZ/PArSyFXEl6OkQmQ
utn7WYq9u888CUkHm7upbPOFRjJNSM1Rtnb/YFIPVW0SPCg+7kRV9ZBxJV+fphlh438klIyYvuvH
7JcqdLa+zJXpW5oGN0EG5IbIZSGfa3JJlUWgEQg+cc3BAKpaAKgUsynzuGkMpmElnvaBZS5zLH1k
EqCzOVhm/CL/fk+Yc8vGmy7BKvlD9/p3ZFzmGvlfDNjDK8ZHUiyvvkexeHQQY2PrNjgzDQp+UZv1
UOETi8hcXv6oN04JKKSXJ2SmXWChNiu/3sMCz4AmQRwNrl7Z2HdbqlYq95JdBNWSn3cxVu0hogej
Ew30PrtE471I5hVs542JqLQl0bizXrXq++jhiKSxKXVNf0c3bJAzNuU5WIGPmpcq4AWZyFyw5Ixc
Tqux+aA08yJxqmW5WdwSGR5QA/HaDB1jDBLeX+aRcjKdUkSD9iO8N0B3PtN67zRwO9hsTHVp6vBW
XpbTcALLtCgOwAvULD74omkwuZzez+xD8+xMlbsAAAAAAAA=
------=_Part_15591_1876304020.1758283656427--

