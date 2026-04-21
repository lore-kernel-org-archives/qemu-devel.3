Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC666F8FA9E
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 17:29:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFEtN-0003u8-5e; Tue, 21 Apr 2026 13:28:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wFEtB-0003nM-CA
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 13:27:58 -0400
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wFEt5-0006hi-84
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 13:27:54 -0400
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-415e568a7ecso1911221fac.0
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 10:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776792464; x=1777397264; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BIsUw1mp7IHlqAyWM9/A9YdCTgfbL/y/tQpzXOmlOQ0=;
 b=Bm9F9t0avNpLIH5IEs95LaGXk8ArQeNe5z+dqFv81uHMJyQiZQ68kOhLR1oJk4WjFG
 TnOakXtTAU92e8vM5FyP5BSwPZqmFw3sMsFFMNgHsTkJ/nFiOy7AqcNJmUwdOdrZ/mrb
 Tp/SDbRvW+HzcpE2/r4pqK12I6ZB6h390GlOmS8lR0k/awFCQ0BQaXdwQJ9ZR1B5mkOe
 dS19imuC138BonTL3rUZdWzyuhWup3IZeqqI3PKDoquF6h9hHq2NWAFbLHu28MaQDZDH
 1DBWymwf19xW7p1eWF4DWO19HyniMcZs+oUdXQ+dvuRBYIATizFv7F2rTJp5Ho6x3cgo
 A0xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776792464; x=1777397264;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BIsUw1mp7IHlqAyWM9/A9YdCTgfbL/y/tQpzXOmlOQ0=;
 b=NJBGX57sn/d8I3BKU/x6SfLCSURv5zAS1rOUm5660huZr9vNvkSW9n67Z+/BNNRqhW
 ZFibCHtFSvLYNn4zqLJUkSD3mmxg1/z3WIC+4qx25qTP3EfRxfBmFsf490qR/Gdv3kza
 3Ncx6OeT7FSg5YJ8bI7HzsRAVdBimg7fimibCf5CdlTuUp0NIz5qYCKqBqZpfx/3AqUZ
 DmXOV9hb+b1OSfEuGB9wSYu1WXZaADLxVj5TDo4FxQskRlQo9yi03gk+DyXgnVj2jq5o
 1VKA0M/YtBGiB9N4WzHSJ13eH6yYqWd9N5xAq0xlc/8Dvt6PFILCM5Ph3q0j2zuLByR6
 D+DQ==
X-Gm-Message-State: AOJu0Yzshsf36ecMA4n/S7wST9XlL6UG7FkYXkutXQMclQJELcqw2KRp
 OCrF8R+ssUz4yuFXe7rVYIqfEjtNWTMqJz9SUOxRV/wv0YozIDLcKn65
X-Gm-Gg: AeBDieveDhycG28hTGwTPmVfYfoV181RIp7I6khCmChbOheJost53dtX3YCBd843KnP
 Bocn7bFYcJcM9fcN3t/taqncwhjyZzMcVFZuHBpBNnpJwNLtURunvsEV50oat5adQLmHf6oW10s
 p/j9jK6KlTtdRAZa6JdThYUXIH5Dw7iGkQJtjdOrm2sKvC1fe5G3asMrL4osbXOuxFENNLkSzg3
 lkxPi654KUo+S+SQMojQxWKinHoPBe00yrQYXPs8F3S8gbPd+fUNaoP78bIoggUJpcALEElc9aa
 JwUg0lkeLSNsAWDfc5wh3xiXkS95rvbuE3YxdkJl9KL2ZdS11ikT9doOD9/jK9ZhC0Bgeq9e3rz
 vdx6bqwzw26wQrXv49tZhtmgJyVaCkBTwTPe6Thmg/aVi9VTXlvIXYFgibmTg7oChjlZg8yUxO/
 r010mikXYEklpB6mXRqQ+M32/cUfIMFVRbIPY/jVhuDh1TAfB/YnYS5C9ekJK6k7DK/EfzDtgZT
 mBoX/0MZrRY63P51ij6eYup8V1QDihVxJoXsVDKuGp4WFTCmNjEOTYz6ZjX6T+hkUWYRLq66iUX
 YacIHSNwumijpxrQ
X-Received: by 2002:a05:6870:b61a:b0:424:6bf4:314e with SMTP id
 586e51a60fabf-42aded18a4dmr11650984fac.18.1776792463872; 
 Tue, 21 Apr 2026 10:27:43 -0700 (PDT)
Received: from mac.localdomain (97-118-149-104.hlrn.qwest.net.
 [97.118.149.104]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b8fe2c52bsm12209290fac.0.2026.04.21.10.27.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 10:27:43 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 21 Apr 2026 11:27:32 -0600
Subject: [PATCH v2 05/13] target/mips: add Octeon arithmetic and memory
 instructions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260421-mips-octeon-missing-insns-v2-v2-5-a0791df188c9@gmail.com>
References: <20260421-mips-octeon-missing-insns-v2-v2-0-a0791df188c9@gmail.com>
In-Reply-To: <20260421-mips-octeon-missing-insns-v2-v2-0-a0791df188c9@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2001:4860:4864:20::33;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oa1-x33.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Octeon CPUs define additional integer, memory, and multiply operations
beyond the base MIPS64 ISA. Add the missing decode and helper support
for the remaining regular Octeon instructions used by existing user-mode
workloads.

This covers the indexed load forms, cache block zero operations, the
Octeon multiply family, population count handling, and related
arithmetic and atomic memory operations in the translator and helper
layer.

Add a TCG smoke test that exercises the arithmetic, compare, population
count, and multiplier instructions introduced here.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

---

Changes v1 -> v2:

  - Fold the initial Octeon arithmetic and multiplier smoke test into
    this patch.

  - Keep SAA/SAAD atomics naturally aligned for Octeon L2 transactions.

  - Split pre-existing BADDU/DMUL and SEQ/SNE translator changes into
    preliminary patches.  (suggested by Philippe Mathieu-Daudé)

  - Store Octeon multiplier state in uint64_t arrays instead of
    target_ulong scalar fields.  (suggested by Philippe Mathieu-Daudé)

  - Keep Octeon68XX CPU feature exposure out of this patch.  (suggested
    by Philippe Mathieu-Daudé)
---
 MAINTAINERS                                   |   2 +
 target/mips/cpu.h                             |   4 +
 target/mips/helper.h                          |   3 +
 target/mips/system/machine.c                  |  33 +++++
 target/mips/tcg/octeon.decode                 |  22 ++++
 target/mips/tcg/octeon_translate.c            | 166 ++++++++++++++++++++++++++
 target/mips/tcg/op_helper.c                   |  99 +++++++++++++++
 tests/tcg/mips/Makefile.target                |  11 ++
 tests/tcg/mips/user/isa/octeon/octeon-insns.c | 145 ++++++++++++++++++++++
 tests/tcg/mips64/Makefile.target              |  20 ++++
 tests/tcg/mips64el/Makefile.target            |   8 ++
 11 files changed, 513 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ad215eced8..3cfb10d076 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -306,6 +306,8 @@ F: target/mips/
 F: disas/*mips.c
 F: docs/system/cpu-models-mips.rst.inc
 F: tests/tcg/mips/
+F: tests/tcg/mips64/
+F: tests/tcg/mips64el/
 
 OpenRISC TCG CPUs
 M: Stafford Horne <shorne@gmail.com>
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index ac81470576..540edf2906 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -497,6 +497,10 @@ struct TCState {
     target_ulong CP0_TCScheFBack;
     int32_t CP0_Debug_tcstatus;
     target_ulong CP0_UserLocal;
+    struct {
+        uint64_t MPL[2 * 3];
+        uint64_t P[2 * 3];
+    } octeon;
 
     int32_t msacsr;
 
diff --git a/target/mips/helper.h b/target/mips/helper.h
index b6cd53c853..756ef92bfd 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -24,6 +24,9 @@ DEF_HELPER_FLAGS_1(dbitswap, TCG_CALL_NO_RWG_SE, tl, tl)
 DEF_HELPER_3(crc32, tl, tl, tl, i32)
 DEF_HELPER_3(crc32c, tl, tl, tl, i32)
 DEF_HELPER_FLAGS_4(rotx, TCG_CALL_NO_RWG_SE, tl, tl, i32, i32, i32)
+DEF_HELPER_3(octeon_vmulu, i64, env, i64, i64)
+DEF_HELPER_3(octeon_vmm0, i64, env, i64, i64)
+DEF_HELPER_3(octeon_v3mulu, i64, env, i64, i64)
 
 /* microMIPS functions */
 DEF_HELPER_4(lwm, void, env, tl, tl, i32)
diff --git a/target/mips/system/machine.c b/target/mips/system/machine.c
index 473d3ab036..c29b7c56fa 100644
--- a/target/mips/system/machine.c
+++ b/target/mips/system/machine.c
@@ -118,6 +118,17 @@ static const VMStateDescription vmstate_inactive_tc = {
     .fields = vmstate_tc_fields
 };
 
+static const VMStateDescription vmstate_octeon_multiplier_tc = {
+    .name = "cpu/tc/octeon_multiplier",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT64_ARRAY(octeon.MPL, TCState, 2 * 3),
+        VMSTATE_UINT64_ARRAY(octeon.P, TCState, 2 * 3),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 /* MVP state */
 
 static const VMStateDescription vmstate_mvp = {
@@ -237,6 +248,27 @@ static const VMStateDescription mips_vmstate_timer = {
     }
 };
 
+static bool mips_octeon_needed(void *opaque)
+{
+    MIPSCPU *cpu = opaque;
+
+    return cpu->env.insn_flags & INSN_OCTEON;
+}
+
+static const VMStateDescription mips_vmstate_octeon_multiplier = {
+    .name = "cpu/octeon_multiplier",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = mips_octeon_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_STRUCT(env.active_tc, MIPSCPU, 1,
+                       vmstate_octeon_multiplier_tc, TCState),
+        VMSTATE_STRUCT_ARRAY(env.tcs, MIPSCPU, MIPS_SHADOW_SET_MAX, 1,
+                             vmstate_octeon_multiplier_tc, TCState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 const VMStateDescription vmstate_mips_cpu = {
     .name = "cpu",
     .version_id = 21,
@@ -353,6 +385,7 @@ const VMStateDescription vmstate_mips_cpu = {
     },
     .subsections = (const VMStateDescription * const []) {
         &mips_vmstate_timer,
+        &mips_vmstate_octeon_multiplier,
         NULL
     }
 };
diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 8a262feb1d..2eb15aa17f 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -44,10 +44,32 @@ SEQ          011100 rs:5 rt:5 rd:5 00000 101010 &cmp3 ne=0
 SNE          011100 rs:5 rt:5 rd:5 00000 101011 &cmp3 ne=1
 SEQI         011100 rs:5 rt:5 imm:s10 101110 &cmpi ne=0
 SNEI         011100 rs:5 rt:5 imm:s10 101111 &cmpi ne=1
+&r2          rs rt
+MTM0         011100 rs:5 rt:5 00000 00000 001000 &r2
+MTP0         011100 rs:5 rt:5 00000 00000 001001 &r2
+MTP1         011100 rs:5 rt:5 00000 00000 001010 &r2
+MTP2         011100 rs:5 rt:5 00000 00000 001011 &r2
+MTM1         011100 rs:5 rt:5 00000 00000 001100 &r2
+MTM2         011100 rs:5 rt:5 00000 00000 001101 &r2
+VMULU        011100 ..... ..... ..... 00000 001111 @r3
+VMM0         011100 ..... ..... ..... 00000 010000 @r3
+V3MULU       011100 ..... ..... ..... 00000 010001 @r3
+
+&saa         base rt
+@saa         ...... base:5 rt:5 ................ &saa
+SAA          011100 ..... ..... 00000 00000 011000 @saa
+SAAD         011100 ..... ..... 00000 00000 011001 @saa
+
+&zcb         base
+ZCB          011100 base:5 00000 00000 11100 011111 &zcb
+ZCBT         011100 base:5 00000 00000 11101 011111 &zcb
 
 &lx          base index rd
 @lx          ...... base:5 index:5 rd:5 ...... ..... &lx
 LWX          011111 ..... ..... ..... 00000 001010 @lx
 LHX          011111 ..... ..... ..... 00100 001010 @lx
+LHUX         011111 ..... ..... ..... 10100 001010 @lx
 LBUX         011111 ..... ..... ..... 00110 001010 @lx
+LWUX         011111 ..... ..... ..... 10000 001010 @lx
+LBX          011111 ..... ..... ..... 10110 001010 @lx
 LDX          011111 ..... ..... ..... 01000 001010 @lx
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 73090ce6d8..cdb4d36c8e 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -13,6 +13,8 @@
 /* Include the auto-generated decoder.  */
 #include "decode-octeon.c.inc"
 
+typedef void gen_helper_lmi(TCGv_i64, TCGv_ptr, TCGv_i64, TCGv_i64);
+
 static bool octeon_check_64(DisasContext *ctx)
 {
     check_mips_64(ctx);
@@ -222,7 +224,171 @@ static bool trans_lx(DisasContext *ctx, arg_lx *a, MemOp mop)
     return true;
 }
 
+static bool trans_saa(DisasContext *ctx, arg_saa *a, MemOp mop)
+{
+    if (mop == MO_UQ && !octeon_check_64(ctx)) {
+        return true;
+    }
+
+    TCGv_i64 addr = tcg_temp_new_i64();
+    MemOp amo = mo_endian(ctx) | mop | MO_ALIGN;
+
+    gen_base_offset_addr(ctx, addr, a->base, 0);
+
+    if (mop == MO_UQ) {
+        TCGv_i64 value = tcg_temp_new_i64();
+        TCGv_i64 old = tcg_temp_new_i64();
+
+        gen_load_gpr(value, a->rt);
+        tcg_gen_atomic_fetch_add_i64(old, addr, value, ctx->mem_idx, amo);
+    } else {
+        TCGv_i64 value = tcg_temp_new_i64();
+        TCGv_i32 value32 = tcg_temp_new_i32();
+        TCGv_i32 old = tcg_temp_new_i32();
+
+        gen_load_gpr(value, a->rt);
+        tcg_gen_extrl_i64_i32(value32, value);
+        tcg_gen_atomic_fetch_add_i32(old, addr, value32, ctx->mem_idx, amo);
+    }
+
+    return true;
+}
+
+static bool trans_ZCB(DisasContext *ctx, arg_zcb *a)
+{
+    TCGv_i64 addr = tcg_temp_new_i64();
+    TCGv_i64 line = tcg_temp_new_i64();
+    TCGv_i64 zero = tcg_constant_i64(0);
+
+    gen_base_offset_addr(ctx, addr, a->base, 0);
+
+    /*
+     * QEMU models ZCB/ZCBT as zeroing the containing 128-byte cache line
+     * in guest memory.
+     */
+    tcg_gen_andi_i64(line, addr, ~0x7fULL);
+
+    for (int i = 0; i < 16; i++) {
+        TCGv_i64 slot = tcg_temp_new_i64();
+
+        tcg_gen_addi_i64(slot, line, i * 8);
+        tcg_gen_qemu_st_i64(zero, slot, ctx->mem_idx, mo_endian(ctx) | MO_UQ);
+    }
+
+    return true;
+}
+
+static bool trans_ZCBT(DisasContext *ctx, arg_zcb *a)
+{
+    return trans_ZCB(ctx, a);
+}
+
+static ptrdiff_t octeon_tc_mpl_offset(unsigned int index)
+{
+    return offsetof(CPUMIPSState, active_tc.octeon.MPL[index]);
+}
+
+static ptrdiff_t octeon_tc_p_offset(unsigned int index)
+{
+    return offsetof(CPUMIPSState, active_tc.octeon.P[index]);
+}
+
+static void octeon_store_tc_field(ptrdiff_t offset, TCGv_i64 value)
+{
+    tcg_gen_st_i64(value, tcg_env, offset);
+}
+
+static void octeon_zero_partial_product_state(void)
+{
+    TCGv_i64 zero = tcg_constant_i64(0);
+
+    for (int i = 0; i < 2 * 3; i++) {
+        octeon_store_tc_field(octeon_tc_p_offset(i), zero);
+    }
+}
+
+static void octeon_clear_upper_multiplier_state(void)
+{
+    TCGv_i64 zero = tcg_constant_i64(0);
+
+    /*
+     * MTM0 starts a new multiplier chain.  Guest code relies on a single
+     * MTM0 load making the remaining multiplier limbs zero unless later
+     * MTM1/MTM2 instructions explicitly populate them.
+     */
+    octeon_store_tc_field(octeon_tc_mpl_offset(1), zero);
+    octeon_store_tc_field(octeon_tc_mpl_offset(2), zero);
+    octeon_store_tc_field(octeon_tc_mpl_offset(4), zero);
+    octeon_store_tc_field(octeon_tc_mpl_offset(5), zero);
+}
+
+static bool trans_mtm(DisasContext *ctx, arg_r2 *a, unsigned int index)
+{
+    if (!octeon_check_64(ctx)) {
+        return true;
+    }
+
+    TCGv_i64 value = tcg_temp_new_i64();
+
+    gen_load_gpr(value, a->rs);
+    octeon_store_tc_field(octeon_tc_mpl_offset(index), value);
+    gen_load_gpr(value, a->rt);
+    octeon_store_tc_field(octeon_tc_mpl_offset(index + 3), value);
+    if (index == 0) {
+        octeon_clear_upper_multiplier_state();
+    }
+    octeon_zero_partial_product_state();
+    return true;
+}
+
+static bool trans_mtp(DisasContext *ctx, arg_r2 *a, unsigned int index)
+{
+    if (!octeon_check_64(ctx)) {
+        return true;
+    }
+
+    TCGv_i64 value = tcg_temp_new_i64();
+
+    gen_load_gpr(value, a->rs);
+    octeon_store_tc_field(octeon_tc_p_offset(index), value);
+    gen_load_gpr(value, a->rt);
+    octeon_store_tc_field(octeon_tc_p_offset(index + 3), value);
+    return true;
+}
+
+static bool trans_vmul(DisasContext *ctx, arg_decode_ext_octeon1 *a,
+                       gen_helper_lmi *helper)
+{
+    if (!octeon_check_64(ctx)) {
+        return true;
+    }
+
+    TCGv_i64 rs = tcg_temp_new_i64();
+    TCGv_i64 rt = tcg_temp_new_i64();
+    TCGv_i64 rd = tcg_temp_new_i64();
+
+    gen_load_gpr(rs, a->rs);
+    gen_load_gpr(rt, a->rt);
+    helper(rd, tcg_env, rs, rt);
+    gen_store_gpr(rd, a->rd);
+    return true;
+}
+
+TRANS(SAA,  trans_saa, MO_UL);
+TRANS(SAAD, trans_saa, MO_UQ);
+TRANS(LBX,  trans_lx, MO_SB);
 TRANS(LBUX, trans_lx, MO_UB);
 TRANS(LHX,  trans_lx, MO_SW);
+TRANS(LHUX, trans_lx, MO_UW);
 TRANS(LWX,  trans_lx, MO_SL);
+TRANS(LWUX, trans_lx, MO_UL);
 TRANS(LDX,  trans_lx, MO_UQ);
+TRANS(MTM0, trans_mtm, 0);
+TRANS(MTM1, trans_mtm, 1);
+TRANS(MTM2, trans_mtm, 2);
+TRANS(MTP0, trans_mtp, 0);
+TRANS(MTP1, trans_mtp, 1);
+TRANS(MTP2, trans_mtp, 2);
+TRANS(VMULU, trans_vmul, gen_helper_octeon_vmulu);
+TRANS(VMM0, trans_vmul, gen_helper_octeon_vmm0);
+TRANS(V3MULU, trans_vmul, gen_helper_octeon_v3mulu);
diff --git a/target/mips/tcg/op_helper.c b/target/mips/tcg/op_helper.c
index 4502ae2b5b..47b13a583c 100644
--- a/target/mips/tcg/op_helper.c
+++ b/target/mips/tcg/op_helper.c
@@ -144,6 +144,105 @@ target_ulong helper_rotx(target_ulong rs, uint32_t shift, uint32_t shiftx,
     return (int64_t)(int32_t)(uint32_t)tmp5;
 }
 
+static void octeon_add_limb(uint64_t *sum, int limb_count,
+                            uint64_t value, int limb)
+{
+    while (limb < limb_count) {
+        uint64_t old = sum[limb];
+
+        sum[limb] += value;
+        if (sum[limb] >= old) {
+            break;
+        }
+        value = 1;
+        limb++;
+    }
+}
+
+uint64_t helper_octeon_vmulu(CPUMIPSState *env, uint64_t rs, uint64_t rt)
+{
+    uint64_t lo, hi;
+    uint64_t sum[3] = {};
+
+    mulu64(&lo, &hi, env->active_tc.octeon.MPL[0], rs);
+    sum[0] = lo;
+    sum[1] = hi;
+
+    mulu64(&lo, &hi, env->active_tc.octeon.MPL[1], rs);
+    octeon_add_limb(sum, 3, lo, 1);
+    octeon_add_limb(sum, 3, hi, 2);
+
+    octeon_add_limb(sum, 3, rt, 0);
+    octeon_add_limb(sum, 3, env->active_tc.octeon.P[0], 0);
+    octeon_add_limb(sum, 3, env->active_tc.octeon.P[1], 1);
+
+    env->active_tc.octeon.P[0] = sum[1];
+    env->active_tc.octeon.P[1] = sum[2];
+    return sum[0];
+}
+
+uint64_t helper_octeon_vmm0(CPUMIPSState *env, uint64_t rs, uint64_t rt)
+{
+    uint64_t lo = helper_octeon_vmulu(env, rs, rt);
+
+    /*
+     * Complete the VMULU accumulation, then apply the MTM0-style state
+     * update with the low result and a zero high operand.
+     */
+    env->active_tc.octeon.MPL[0] = lo;
+    env->active_tc.octeon.MPL[3] = 0;
+    for (int i = 0; i < 2 * 3; i++) {
+        env->active_tc.octeon.P[i] = 0;
+    }
+    return lo;
+}
+
+uint64_t helper_octeon_v3mulu(CPUMIPSState *env, uint64_t rs, uint64_t rt)
+{
+    uint64_t lo, hi;
+    uint64_t sum[7] = {};
+
+    mulu64(&lo, &hi, env->active_tc.octeon.MPL[0], rs);
+    sum[0] = lo;
+    sum[1] = hi;
+
+    mulu64(&lo, &hi, env->active_tc.octeon.MPL[1], rs);
+    octeon_add_limb(sum, 7, lo, 1);
+    octeon_add_limb(sum, 7, hi, 2);
+
+    mulu64(&lo, &hi, env->active_tc.octeon.MPL[2], rs);
+    octeon_add_limb(sum, 7, lo, 2);
+    octeon_add_limb(sum, 7, hi, 3);
+
+    mulu64(&lo, &hi, env->active_tc.octeon.MPL[3], rs);
+    octeon_add_limb(sum, 7, lo, 3);
+    octeon_add_limb(sum, 7, hi, 4);
+
+    mulu64(&lo, &hi, env->active_tc.octeon.MPL[4], rs);
+    octeon_add_limb(sum, 7, lo, 4);
+    octeon_add_limb(sum, 7, hi, 5);
+
+    mulu64(&lo, &hi, env->active_tc.octeon.MPL[5], rs);
+    octeon_add_limb(sum, 7, lo, 5);
+    octeon_add_limb(sum, 7, hi, 6);
+
+    octeon_add_limb(sum, 7, rt, 0);
+    octeon_add_limb(sum, 7, env->active_tc.octeon.P[0], 0);
+    octeon_add_limb(sum, 7, env->active_tc.octeon.P[1], 1);
+    octeon_add_limb(sum, 7, env->active_tc.octeon.P[2], 2);
+    octeon_add_limb(sum, 7, env->active_tc.octeon.P[3], 3);
+    octeon_add_limb(sum, 7, env->active_tc.octeon.P[4], 4);
+    octeon_add_limb(sum, 7, env->active_tc.octeon.P[5], 5);
+
+    env->active_tc.octeon.P[0] = sum[1];
+    env->active_tc.octeon.P[1] = sum[2];
+    env->active_tc.octeon.P[2] = sum[3];
+    env->active_tc.octeon.P[3] = sum[4];
+    env->active_tc.octeon.P[4] = sum[5];
+    env->active_tc.octeon.P[5] = sum[6];
+    return sum[0];
+}
+
 /* these crc32 functions are based on target/loongarch/tcg/op_helper.c */
 target_ulong helper_crc32(target_ulong val, target_ulong m, uint32_t sz)
 {
diff --git a/tests/tcg/mips/Makefile.target b/tests/tcg/mips/Makefile.target
index 5d17c1706e..d9dc16f8ec 100644
--- a/tests/tcg/mips/Makefile.target
+++ b/tests/tcg/mips/Makefile.target
@@ -8,6 +8,17 @@ MIPS_SRC=$(SRC_PATH)/tests/tcg/mips
 # Set search path for all sources
 VPATH 		+= $(MIPS_SRC)
 
+ifneq ($(findstring 64,$(TARGET_NAME)),)
+VPATH += $(MIPS_SRC)/user/isa/octeon
+
+MIPS64_TESTS=octeon-insns
+
+TESTS += $(MIPS64_TESTS)
+
+octeon-insns: CFLAGS+=-mabi=64
+run-octeon-insns: QEMU_OPTS+=-cpu Octeon68XX
+endif
+
 # hello-mips is 32 bit only
 ifeq ($(findstring 64,$(TARGET_NAME)),)
 MIPS_TESTS=hello-mips
diff --git a/tests/tcg/mips/user/isa/octeon/octeon-insns.c b/tests/tcg/mips/user/isa/octeon/octeon-insns.c
new file mode 100644
index 0000000000..e9db93d1b6
--- /dev/null
+++ b/tests/tcg/mips/user/isa/octeon/octeon-insns.c
@@ -0,0 +1,145 @@
+/*
+ * Test Octeon-specific user-mode instructions.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <assert.h>
+#include <stdint.h>
+
+static uint64_t octeon_baddu(uint64_t rs, uint64_t rt)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[rs]\n\t"
+        "move $9, %[rt]\n\t"
+        ".word 0x71095028\n\t" /* baddu $10, $8, $9 */
+        "move %[rd], $10\n\t"
+        : [rd] "=r" (rd)
+        : [rs] "r" (rs), [rt] "r" (rt)
+        : "$8", "$9", "$10");
+
+    return rd;
+}
+
+static uint64_t octeon_dmul(uint64_t rs, uint64_t rt)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[rs]\n\t"
+        "move $9, %[rt]\n\t"
+        ".word 0x71095003\n\t" /* dmul $10, $8, $9 */
+        "move %[rd], $10\n\t"
+        : [rd] "=r" (rd)
+        : [rs] "r" (rs), [rt] "r" (rt)
+        : "$8", "$9", "$10");
+
+    return rd;
+}
+
+static uint64_t octeon_dpop(uint64_t rs)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[rs]\n\t"
+        ".word 0x7100502d\n\t" /* dpop $10, $8 */
+        "move %[rd], $10\n\t"
+        : [rd] "=r" (rd)
+        : [rs] "r" (rs)
+        : "$8", "$10");
+
+    return rd;
+}
+
+static uint64_t octeon_seq(uint64_t rs, uint64_t rt)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[rs]\n\t"
+        "move $9, %[rt]\n\t"
+        ".word 0x7109502a\n\t" /* seq $10, $8, $9 */
+        "move %[rd], $10\n\t"
+        : [rd] "=r" (rd)
+        : [rs] "r" (rs), [rt] "r" (rt)
+        : "$8", "$9", "$10");
+
+    return rd;
+}
+
+static uint64_t octeon_sne(uint64_t rs, uint64_t rt)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[rs]\n\t"
+        "move $9, %[rt]\n\t"
+        ".word 0x7109502b\n\t" /* sne $10, $8, $9 */
+        "move %[rd], $10\n\t"
+        : [rd] "=r" (rd)
+        : [rs] "r" (rs), [rt] "r" (rt)
+        : "$8", "$9", "$10");
+
+    return rd;
+}
+
+static uint64_t octeon_vmulu(uint64_t mpl0, uint64_t rs, uint64_t rt)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[mpl0]\n\t"
+        "move $9, $0\n\t"
+        ".word 0x71090008\n\t" /* mtm0 $8, $9 */
+        "move $8, %[rs]\n\t"
+        "move $9, %[rt]\n\t"
+        ".word 0x7109500f\n\t" /* vmulu $10, $8, $9 */
+        "move %[rd], $10\n\t"
+        : [rd] "=r" (rd)
+        : [mpl0] "r" (mpl0), [rs] "r" (rs), [rt] "r" (rt)
+        : "$8", "$9", "$10");
+
+    return rd;
+}
+
+static uint64_t octeon_vmm0(uint64_t mpl0, uint64_t p0,
+                            uint64_t rs, uint64_t rt)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[mpl0]\n\t"
+        "move $9, $0\n\t"
+        ".word 0x71090008\n\t" /* mtm0 $8, $9 */
+        "move $8, %[p0]\n\t"
+        "move $9, $0\n\t"
+        ".word 0x71090009\n\t" /* mtp0 $8, $9 */
+        "move $8, %[rs]\n\t"
+        "move $9, %[rt]\n\t"
+        ".word 0x71095010\n\t" /* vmm0 $10, $8, $9 */
+        "move %[rd], $10\n\t"
+        : [rd] "=r" (rd)
+        : [mpl0] "r" (mpl0), [p0] "r" (p0),
+          [rs] "r" (rs), [rt] "r" (rt)
+        : "$8", "$9", "$10");
+
+    return rd;
+}
+
+int main(void)
+{
+    assert(octeon_baddu(0x123, 0x0f0) == 0x13);
+    assert(octeon_dmul(0x12345678, 0x10) == 0x123456780);
+    assert(octeon_dpop(0xf0f0f0f0f0f0f0f0ULL) == 32);
+    assert(octeon_seq(0xabc, 0xabc) == 1);
+    assert(octeon_seq(0xabc, 0xdef) == 0);
+    assert(octeon_sne(0xabc, 0xabc) == 0);
+    assert(octeon_sne(0xabc, 0xdef) == 1);
+    assert(octeon_vmulu(5, 7, 11) == 46);
+    assert(octeon_vmm0(5, 13, 7, 11) == 59);
+
+    return 0;
+}
diff --git a/tests/tcg/mips64/Makefile.target b/tests/tcg/mips64/Makefile.target
new file mode 100644
index 0000000000..042855844a
--- /dev/null
+++ b/tests/tcg/mips64/Makefile.target
@@ -0,0 +1,20 @@
+# -*- Mode: makefile -*-
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# MIPS64 - included from tests/tcg/Makefile.target
+#
+
+MIPS64_SRC=$(SRC_PATH)/tests/tcg/mips64
+MIPS_OCTEON_SRC=$(SRC_PATH)/tests/tcg/mips/user/isa/octeon
+
+# Set search path for all sources
+VPATH 		+= $(MIPS64_SRC) $(MIPS_OCTEON_SRC)
+
+MIPS64_TESTS=octeon-insns
+
+TESTS += $(MIPS64_TESTS)
+
+$(MIPS64_TESTS): CFLAGS+=-mabi=64
+
+run-octeon-insns: QEMU_OPTS+=-cpu Octeon68XX
diff --git a/tests/tcg/mips64el/Makefile.target b/tests/tcg/mips64el/Makefile.target
new file mode 100644
index 0000000000..dbc5f8dc5f
--- /dev/null
+++ b/tests/tcg/mips64el/Makefile.target
@@ -0,0 +1,8 @@
+# -*- Mode: makefile -*-
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# MIPS64 little-endian - included from tests/tcg/Makefile.target
+#
+
+include $(SRC_PATH)/tests/tcg/mips64/Makefile.target

-- 
2.53.0


