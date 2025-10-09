Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 062F2CCA470
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 03:04:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6gwo-0006lk-Uw; Wed, 08 Oct 2025 23:04:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liuxu@nucleisys.com>)
 id 1v6gwl-0006lU-K6
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 23:04:03 -0400
Received: from smtpbgsg2.qq.com ([54.254.200.128])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liuxu@nucleisys.com>)
 id 1v6gwa-0002v4-OG
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 23:04:03 -0400
X-QQ-mid: zesmtpsz2t1759978984t3d926d36
X-QQ-Originating-IP: 8KdFBEBysXbgZw65RJYENhedEwa5itL23MfWCThH3G0=
Received: from XL-L17C6SCQBD5V.corp.nucleisys. ( [219.139.230.98])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 09 Oct 2025 11:03:01 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9222656471102190832
EX-QQ-RecipientCnt: 5
From: liuxu <liuxu@nucleisys.com>
To: liuxu@git.sr.ht
Cc: alistair23@gmail.com, liuxu@nucleisys.com, qemu-devel@nongnu.org,
 richard.henderson@linaro.org
Subject: Re: [PATCH qemu v10 1/1] target/riscv: Add Zilsd and Zclsd extension
 support
Date: Thu,  9 Oct 2025 11:03:00 +0800
Message-ID: <92130C71B8267DF9+20251009030300.1508-1-liuxu@nucleisys.com>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <175611702979.27776.8893001401121570723-1@git.sr.ht>
References: <175611702979.27776.8893001401121570723-1@git.sr.ht>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:nucleisys.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NgzJQeCZ3xJjctU/8UCIDpNvPog7An8JWNTXTQK9HLkycr7uUMXVGatn
 yGImsHqAkP/kBrPyDE9keaxwdKcfdiUaWq2eWh6vLE4l9kbeSvn82hr6xzx/aoXEZIuhZ+v
 Q790h2kwIm0JH937/6kEQISCB21CGwbrhlq99bi2MqjMDuaDhZVtfU/8lJMpbRu/TOrVZOM
 QyYV/GuCCBdHOXiHF78w7z+EvIhCGGduBbKnVOl6wDRh5MMf4A1M1N/yBvs4t/71oAtCcPz
 0ZO/q0zrj9VlhWgQN7PgW+Ajjvj88Bu1PGeCYsupG96kj7iUSM7gZl2CeVLyz0fRW9ODtw2
 hlKpElkvUAd0zOE6lfhmepQplt118QlGdvV9yNkprgoAajPoCI9VrKhCNPNNzvIVXhDoiKy
 gTsvJz9H15JNWdVIRfxxPg88ovGvknC+UwRSu+A+DcOSgNLlVvdqdKxrAsHbJCi6Au5i00i
 GFCEOF0Z6/cfORX5XFRI1n0HZgECnM86Kf8mtxaPuYcrwcgmVp9DIpDE9NahIa4/RyUdKLm
 uBN0XrKNSSyT8uctlclq2xFW76rEWnAdmzgLxQnHnW8CFRYr/63Pa9oeQ2Drw2FD3nxkZoW
 PTwg1muT3m6ttnYdxDgmKcUF2t8I+sPSfZC9rABfMLBvdxFTrDVMu4flTnimjIdxtjgPw5e
 Z11NmbhG+9lMuHaNFksZYKNHwRWeipOTbha1LMFls5IY+PCF2qbOmWgbCq1nfLdAh6Unt47
 lID9Ay+i0XFtd8fs3yBp7Dqlw/OgfEMuoblaASHzwQU6V81vOhw38zAuFSWGoVlNQi6rbgg
 BXsCRCmiu5goKsdHkoic+IhsyOhb9JS0W0d2sINuEMyTYuKBLhhbICxgZwMvYozP4gS4KZ4
 dVEssA5xnz3FxngEemnWTYgh7fcCd9IdbrFFVIb0KoOKFLaPwfIPMKWF5EJw2ENlCwI5CCA
 O1tuSO/1u2jsGDVMzwjPMKd2rkzVCkJF98IUxuKDCpl3ker4F7pAfFtiQKHxbgcmhjg0Epn
 qlW73l00jzNoZg/wAxHQG4vPc8hU+eh8c2qgx2JNhW1jP5qF6/MGQEBsqjP1kcQA685CK9F
 kSkfgag8MCk
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0
Received-SPF: pass client-ip=54.254.200.128; envelope-from=liuxu@nucleisys.com;
 helo=smtpbgsg2.qq.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

hi Alistair,=0D
=0D
This is a PING email.=0D
=0D
I would be very grateful if you could spare some time to review this new=0D
version. Please let me know if there's anything else I need to adjust or cl=
arify.=0D
=0D
Best regards~=0D
=0D
>From: lxx <1733205434@qq.com>=0D
>=0D
>This patch adds support for the Zilsd and Zclsd extension,=0D
>which is documented at https://github.com/riscv/riscv-zilsd/releases/tag/v=
1.0=0D
>=0D
>Signed-off-by: LIU Xu <liuxu@nucleisys.com>=0D
>Co-developed-by: SUN Dongya <sundongya@nucleisys.com>=0D
>Co-developed-by: ZHAO Fujin <zhaofujin@nucleisys.com>=0D
>Reviewed-by: Alistair Francis <alistair.francis@wdc.com>=0D
>---=0D
> target/riscv/cpu.c                        |   4 +=0D
> target/riscv/cpu_cfg_fields.h.inc         |   2 +=0D
> target/riscv/insn16.decode                |   8 ++=0D
> target/riscv/insn32.decode                |  12 ++-=0D
> target/riscv/insn_trans/trans_zilsd.c.inc | 112 ++++++++++++++++++++++=0D
> target/riscv/tcg/tcg-cpu.c                |  33 +++++++=0D
> target/riscv/translate.c                  |   1 +=0D
> 7 files changed, 170 insertions(+), 2 deletions(-)=0D
> create mode 100644 target/riscv/insn_trans/trans_zilsd.c.inc=0D
>=0D
>diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c=0D
>index d055ddf462..78969a5874 100644=0D
>--- a/target/riscv/cpu.c=0D
>+++ b/target/riscv/cpu.c=0D
>@@ -121,6 +121,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {=0D
>     ISA_EXT_DATA_ENTRY(zihintntl, PRIV_VERSION_1_10_0, ext_zihintntl),=0D
>     ISA_EXT_DATA_ENTRY(zihintpause, PRIV_VERSION_1_10_0, ext_zihintpause)=
,=0D
>     ISA_EXT_DATA_ENTRY(zihpm, PRIV_VERSION_1_12_0, ext_zihpm),=0D
>+    ISA_EXT_DATA_ENTRY(zilsd, PRIV_VERSION_1_12_0, ext_zilsd),=0D
>     ISA_EXT_DATA_ENTRY(zimop, PRIV_VERSION_1_13_0, ext_zimop),=0D
>     ISA_EXT_DATA_ENTRY(zmmul, PRIV_VERSION_1_12_0, ext_zmmul),=0D
>     ISA_EXT_DATA_ENTRY(za64rs, PRIV_VERSION_1_12_0, has_priv_1_12),=0D
>@@ -144,6 +145,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {=0D
>     ISA_EXT_DATA_ENTRY(zcmop, PRIV_VERSION_1_13_0, ext_zcmop),=0D
>     ISA_EXT_DATA_ENTRY(zcmp, PRIV_VERSION_1_12_0, ext_zcmp),=0D
>     ISA_EXT_DATA_ENTRY(zcmt, PRIV_VERSION_1_12_0, ext_zcmt),=0D
>+    ISA_EXT_DATA_ENTRY(zclsd, PRIV_VERSION_1_12_0, ext_zclsd),=0D
>     ISA_EXT_DATA_ENTRY(zba, PRIV_VERSION_1_12_0, ext_zba),=0D
>     ISA_EXT_DATA_ENTRY(zbb, PRIV_VERSION_1_12_0, ext_zbb),=0D
>     ISA_EXT_DATA_ENTRY(zbc, PRIV_VERSION_1_12_0, ext_zbc),=0D
>@@ -1291,6 +1293,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] =
=3D {=0D
> =0D
>     MULTI_EXT_CFG_BOOL("zicntr", ext_zicntr, true),=0D
>     MULTI_EXT_CFG_BOOL("zihpm", ext_zihpm, true),=0D
>+    MULTI_EXT_CFG_BOOL("zilsd", ext_zilsd, false),=0D
> =0D
>     MULTI_EXT_CFG_BOOL("zba", ext_zba, true),=0D
>     MULTI_EXT_CFG_BOOL("zbb", ext_zbb, true),=0D
>@@ -1330,6 +1333,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] =
=3D {=0D
>     MULTI_EXT_CFG_BOOL("zcmp", ext_zcmp, false),=0D
>     MULTI_EXT_CFG_BOOL("zcmt", ext_zcmt, false),=0D
>     MULTI_EXT_CFG_BOOL("zicond", ext_zicond, false),=0D
>+    MULTI_EXT_CFG_BOOL("zclsd", ext_zclsd, false),=0D
> =0D
>     /* Vector cryptography extensions */=0D
>     MULTI_EXT_CFG_BOOL("zvbb", ext_zvbb, false),=0D
>diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fiel=
ds.h.inc=0D
>index e2d116f0df..6c1b523b68 100644=0D
>--- a/target/riscv/cpu_cfg_fields.h.inc=0D
>+++ b/target/riscv/cpu_cfg_fields.h.inc=0D
>@@ -19,6 +19,7 @@ BOOL_FIELD(ext_zce)=0D
> BOOL_FIELD(ext_zcf)=0D
> BOOL_FIELD(ext_zcmp)=0D
> BOOL_FIELD(ext_zcmt)=0D
>+BOOL_FIELD(ext_zclsd)=0D
> BOOL_FIELD(ext_zk)=0D
> BOOL_FIELD(ext_zkn)=0D
> BOOL_FIELD(ext_zknd)=0D
>@@ -41,6 +42,7 @@ BOOL_FIELD(ext_zicond)=0D
> BOOL_FIELD(ext_zihintntl)=0D
> BOOL_FIELD(ext_zihintpause)=0D
> BOOL_FIELD(ext_zihpm)=0D
>+BOOL_FIELD(ext_zilsd)=0D
> BOOL_FIELD(ext_zimop)=0D
> BOOL_FIELD(ext_zcmop)=0D
> BOOL_FIELD(ext_ztso)=0D
>diff --git a/target/riscv/insn16.decode b/target/riscv/insn16.decode=0D
>index bf893d1c2e..c34020e4dc 100644=0D
>--- a/target/riscv/insn16.decode=0D
>+++ b/target/riscv/insn16.decode=0D
>@@ -130,10 +130,14 @@ sw                110  ... ... .. ... 00 @cs_w=0D
> {=0D
>   ld              011  ... ... .. ... 00 @cl_d=0D
>   c_flw           011  ... ... .. ... 00 @cl_w=0D
>+  # *** Zclsd Extension ***=0D
>+  zclsd_ld        011  ... ... .. ... 00 @cl_d=0D
> }=0D
> {=0D
>   sd              111  ... ... .. ... 00 @cs_d=0D
>   c_fsw           111  ... ... .. ... 00 @cs_w=0D
>+  # *** Zclsd Extension ***=0D
>+  zclsd_sd        111  ... ... .. ... 00 @cs_d=0D
> }=0D
> =0D
> # *** RV32/64C Standard Extension (Quadrant 1) ***=0D
>@@ -212,10 +216,14 @@ sw                110 .  .....  ..... 10 @c_swsp=0D
>   c64_illegal     011 -  00000  ----- 10 # c.ldsp, RES rd=3D0=0D
>   ld              011 .  .....  ..... 10 @c_ldsp=0D
>   c_flw           011 .  .....  ..... 10 @c_lwsp=0D
>+  # *** Zclsd Extension ***=0D
>+  zclsd_ldsp      011 .  .....  ..... 10 @c_ldsp=0D
> }=0D
> {=0D
>   sd              111 .  .....  ..... 10 @c_sdsp=0D
>   c_fsw           111 .  .....  ..... 10 @c_swsp=0D
>+  # *** Zclsd Extension ***=0D
>+  zclsd_sd        111 .  .....  ..... 10 @c_sdsp=0D
> }=0D
> =0D
> # *** RV64 and RV32 Zcb Extension ***=0D
>diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode=0D
>index cd23b1f3a9..b341832e41 100644=0D
>--- a/target/riscv/insn32.decode=0D
>+++ b/target/riscv/insn32.decode=0D
>@@ -182,8 +182,16 @@ csrrci   ............     ..... 111 ..... 1110011 @cs=
r=0D
> =0D
> # *** RV64I Base Instruction Set (in addition to RV32I) ***=0D
> lwu      ............   ..... 110 ..... 0000011 @i=0D
>-ld       ............   ..... 011 ..... 0000011 @i=0D
>-sd       ....... .....  ..... 011 ..... 0100011 @s=0D
>+{=0D
>+  ld       ............   ..... 011 ..... 0000011 @i=0D
>+  # *** Zilsd instructions ***=0D
>+  zilsd_ld ............   ..... 011 ..... 0000011 @i=0D
>+}=0D
>+{=0D
>+  sd       ....... .....  ..... 011 ..... 0100011 @s=0D
>+  # *** Zilsd instructions ***=0D
>+  zilsd_sd ....... .....  ..... 011 ..... 0100011 @s=0D
>+}=0D
> addiw    ............   ..... 000 ..... 0011011 @i=0D
> slliw    0000000 .....  ..... 001 ..... 0011011 @sh5=0D
> srliw    0000000 .....  ..... 101 ..... 0011011 @sh5=0D
>diff --git a/target/riscv/insn_trans/trans_zilsd.c.inc b/target/riscv/insn=
_trans/trans_zilsd.c.inc=0D
>new file mode 100644=0D
>index 0000000000..7bdc303298=0D
>--- /dev/null=0D
>+++ b/target/riscv/insn_trans/trans_zilsd.c.inc=0D
>@@ -0,0 +1,112 @@=0D
>+/*=0D
>+ * RISC-V translation routines for the Zilsd & Zclsd Extension.=0D
>+ *=0D
>+ * Copyright (c) 2025 Nucleisys, Inc.=0D
>+ *=0D
>+ * This program is free software; you can redistribute it and/or modify i=
t=0D
>+ * under the terms and conditions of the GNU General Public License,=0D
>+ * version 2 or later, as published by the Free Software Foundation.=0D
>+ *=0D
>+ * This program is distributed in the hope it will be useful, but WITHOUT=
=0D
>+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or=
=0D
>+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License =
for=0D
>+ * more details.=0D
>+ *=0D
>+ * You should have received a copy of the GNU General Public License alon=
g with=0D
>+ * this program.  If not, see <http://www.gnu.org/licenses/>.=0D
>+ */=0D
>+=0D
>+#define REQUIRE_ZILSD(ctx) do {    \=0D
>+    if (!ctx->cfg_ptr->ext_zilsd)  \=0D
>+        return false;              \=0D
>+} while (0)=0D
>+=0D
>+#define REQUIRE_ZCLSD(ctx) do {    \=0D
>+    if (!ctx->cfg_ptr->ext_zclsd)  \=0D
>+        return false;              \=0D
>+} while (0)=0D
>+=0D
>+static bool gen_load_i64(DisasContext *ctx, arg_ld *a)=0D
>+{=0D
>+    if ((a->rd) % 2) {=0D
>+        return false;=0D
>+    }=0D
>+=0D
>+    TCGv dest_low =3D dest_gpr(ctx, a->rd);=0D
>+    TCGv dest_high =3D dest_gpr(ctx, a->rd + 1);=0D
>+    TCGv addr =3D get_address(ctx, a->rs1, a->imm);=0D
>+    TCGv_i64 tmp =3D tcg_temp_new_i64();=0D
>+=0D
>+    tcg_gen_qemu_ld_i64(tmp, addr, ctx->mem_idx, MO_TESQ);=0D
>+=0D
>+    if (a->rd =3D=3D 0) {=0D
>+        return true;=0D
>+    }=0D
>+=0D
>+    tcg_gen_extr_i64_tl(dest_low, dest_high, tmp);=0D
>+=0D
>+    gen_set_gpr(ctx, a->rd, dest_low);=0D
>+    gen_set_gpr(ctx, a->rd + 1, dest_high);=0D
>+=0D
>+    return true;=0D
>+}=0D
>+=0D
>+static bool trans_zilsd_ld(DisasContext *ctx, arg_zilsd_ld *a)=0D
>+{=0D
>+    REQUIRE_32BIT(ctx);=0D
>+    REQUIRE_ZILSD(ctx);=0D
>+    return gen_load_i64(ctx, a);=0D
>+}=0D
>+=0D
>+static bool trans_zclsd_ld(DisasContext *ctx, arg_zclsd_ld *a)=0D
>+{=0D
>+    REQUIRE_32BIT(ctx);=0D
>+    REQUIRE_ZCLSD(ctx);=0D
>+    return gen_load_i64(ctx, a);=0D
>+}=0D
>+=0D
>+static bool trans_zclsd_ldsp(DisasContext *ctx, arg_zclsd_ldsp *a)=0D
>+{=0D
>+    REQUIRE_32BIT(ctx);=0D
>+    REQUIRE_ZCLSD(ctx);=0D
>+=0D
>+    if (a->rd =3D=3D 0) {=0D
>+        return false;=0D
>+    }=0D
>+    return gen_load_i64(ctx, a);=0D
>+}=0D
>+=0D
>+static bool gen_store_i64(DisasContext *ctx, arg_sd *a)=0D
>+{=0D
>+    if ((a->rs2) % 2) {=0D
>+        return false;=0D
>+    }=0D
>+=0D
>+    TCGv data_low =3D get_gpr(ctx, a->rs2, EXT_NONE);=0D
>+    TCGv data_high =3D get_gpr(ctx, a->rs2 + 1, EXT_NONE);=0D
>+    TCGv addr =3D get_address(ctx, a->rs1, a->imm);=0D
>+    TCGv_i64 tmp =3D tcg_temp_new_i64();=0D
>+=0D
>+    if (a->rs2 =3D=3D 0) {=0D
>+        tmp =3D tcg_constant_i64(0);=0D
>+    } else {=0D
>+        tcg_gen_concat_tl_i64(tmp, data_low, data_high);=0D
>+    }=0D
>+    tcg_gen_qemu_st_i64(tmp, addr, ctx->mem_idx, MO_TESQ);=0D
>+=0D
>+    return true;=0D
>+}=0D
>+=0D
>+static bool trans_zilsd_sd(DisasContext *ctx, arg_zilsd_sd *a)=0D
>+{=0D
>+    REQUIRE_32BIT(ctx);=0D
>+    REQUIRE_ZILSD(ctx);=0D
>+    return gen_store_i64(ctx, a);=0D
>+}=0D
>+=0D
>+static bool trans_zclsd_sd(DisasContext *ctx, arg_zclsd_sd *a)=0D
>+{=0D
>+    REQUIRE_32BIT(ctx);=0D
>+    REQUIRE_ZCLSD(ctx);=0D
>+    return gen_store_i64(ctx, a);=0D
>+}=0D
>diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c=0D
>index 78fb279184..873d65a92e 100644=0D
>--- a/target/riscv/tcg/tcg-cpu.c=0D
>+++ b/target/riscv/tcg/tcg-cpu.c=0D
>@@ -818,6 +818,19 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu,=
 Error **errp)=0D
>         cpu->pmu_avail_ctrs =3D 0;=0D
>     }=0D
> =0D
>+    if (cpu->cfg.ext_zclsd) {=0D
>+        if (riscv_has_ext(env, RVC) && riscv_has_ext(env, RVF)) {=0D
>+            error_setg(errp,=0D
>+                    "Zclsd cannot be supported together with C and F exte=
nsion");=0D
>+            return;=0D
>+        }=0D
>+        if (cpu->cfg.ext_zcf) {=0D
>+            error_setg(errp,=0D
>+                    "Zclsd cannot be supported together with Zcf extensio=
n");=0D
>+            return;=0D
>+        }=0D
>+    }=0D
>+=0D
>     if (cpu->cfg.ext_zicfilp && !cpu->cfg.ext_zicsr) {=0D
>         error_setg(errp, "zicfilp extension requires zicsr extension");=0D
>         return;=0D
>@@ -1081,6 +1094,20 @@ static void cpu_enable_zc_implied_rules(RISCVCPU *c=
pu)=0D
>     }=0D
> }=0D
> =0D
>+static void cpu_enable_zilsd_implied_rules(RISCVCPU *cpu)=0D
>+{=0D
>+    CPURISCVState *env =3D &cpu->env;=0D
>+=0D
>+    if (cpu->cfg.ext_zilsd && riscv_has_ext(env, RVC)) {=0D
>+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zclsd), true);=0D
>+    }=0D
>+=0D
>+    if (cpu->cfg.ext_zclsd) {=0D
>+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zca), true);=0D
>+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zilsd), true);=0D
>+    }=0D
>+}=0D
>+=0D
> static void riscv_cpu_enable_implied_rules(RISCVCPU *cpu)=0D
> {=0D
>     RISCVCPUImpliedExtsRule *rule;=0D
>@@ -1089,6 +1116,9 @@ static void riscv_cpu_enable_implied_rules(RISCVCPU =
*cpu)=0D
>     /* Enable the implied extensions for Zc. */=0D
>     cpu_enable_zc_implied_rules(cpu);=0D
> =0D
>+    /* Enable the implied extensions for Zilsd. */=0D
>+    cpu_enable_zilsd_implied_rules(cpu);=0D
>+=0D
>     /* Enable the implied MISAs. */=0D
>     for (i =3D 0; (rule =3D riscv_misa_ext_implied_rules[i]); i++) {=0D
>         if (riscv_has_ext(&cpu->env, rule->ext)) {=0D
>@@ -1592,6 +1622,9 @@ static void riscv_init_max_cpu_extensions(Object *ob=
j)=0D
>     isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_zcmp), false);=0D
>     isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_zcmt), false);=0D
> =0D
>+    isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_zilsd), false);=0D
>+    isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_zclsd), false);=0D
>+=0D
>     if (env->misa_mxl !=3D MXL_RV32) {=0D
>         isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_zcf), false);=0D
>     } else {=0D
>diff --git a/target/riscv/translate.c b/target/riscv/translate.c=0D
>index 9ddef2d6e2..62f714034f 100644=0D
>--- a/target/riscv/translate.c=0D
>+++ b/target/riscv/translate.c=0D
>@@ -1200,6 +1200,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase, =
target_ulong pc)=0D
> /* Include the auto-generated decoder for 16 bit insn */=0D
> #include "decode-insn16.c.inc"=0D
> #include "insn_trans/trans_rvzce.c.inc"=0D
>+#include "insn_trans/trans_zilsd.c.inc"=0D
> #include "insn_trans/trans_rvzcmop.c.inc"=0D
> #include "insn_trans/trans_rvzicfiss.c.inc"=0D
> =0D
>-- =0D
>2.49.1=

