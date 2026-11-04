Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFED6070326
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 19:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256 header.s=google header.b=a9RZwakr
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOgtG-0002uh-7o; Wed, 04 Nov 2026 14:43:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xOgt5-0002ke-BO
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 14:43:11 -0500
Received: from mail-dy1-x132f.google.com ([2607:f8b0:4864:20::132f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xOgt3-0002To-1Z
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 14:43:11 -0500
Received: by mail-dy1-x132f.google.com with SMTP id
 5a478bee46e88-35b2c599f43so286423eec.0
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 11:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1793821388; x=1794426188; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8acSz67SEMp3v6xtI7qoWxZME8sNQUJ6Qw3trWuzqS4=;
 b=a9RZwakruEWMYx6XBdnzmIJgVcyECbPPNLeNolTtX0RYLcFOTNs6gU40tR9csa8nAU
 P0NY2LSjjnT7RHe92Z1N9B9PjZEr+daHNx2JDN4eiIByyoak1GC4SwCORLD4joxyS7kf
 6u3uRW2wBqfR0EsF6rLgNaKP/iaXQTsI6YokWwjSzLSXY7ScAHutvzK8ZAzb7kJYxP1W
 K/D9BXzauSzcQjaYJfCzpPi9MN9CnAaD+fGN26WQRWwYyCaoqEG9E9Y+zCgW7NB8u7CR
 Tkrnl69gWsnyPNXj6fkwXC8EUzWTj7t0iQRy14sWLecTlfyRzGPY8ebkqAcRxfCv5O8S
 GRqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793821388; x=1794426188;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8acSz67SEMp3v6xtI7qoWxZME8sNQUJ6Qw3trWuzqS4=;
 b=OMEVU75BGNztFkPJZn2Z+wN4csTqyd2ALuyzcEXudfF/L6l3ffZz0M7haxrA3KxYV0
 nOg7pbqG2qemgyKGq0rcIGwfniU5SiVx8aO686ISBuV3/WlflS7cLKWef9cA4fl7A1my
 6ES/cn55HIztCtrrGSVGXEcCkBtNf1cUpnNqT3Kj/m2vktL6mFsTb9abaQp0DPefedY1
 Uo+MC2+hnl2uwgl1SOqcRztWt5cqs2BN7LBV2T/am1MEOZ7DLChCb9Es0aKo+uNpIOaU
 4Iwo5cUsbdGfOAMSh40YCbJp74nWydokbALyYzaNJwxENzstTMioaTB3RoKDLTlAJiUk
 HqwA==
X-Gm-Message-State: APuU4Z+H6byLQKHzSl79jza9sTGwA3UYA87gqF5/L6CDyUOoxZTWc6LZ
 +oN+kRIL06mUpstVOKLa7V7jUV/o69PFKOYdwmTCg3T612DmxZ7B5nwRVIdEgYQfE3DXSvncaIb
 /3NY8z2mZRkKKiUHfHqW0Gd9RYONX7gHja/gMYqkI+2runjpQYoYa06UoHJ18chz5KNFK9CFB3+
 j378l5Wjz3WAHcRHhLaw5lhVPbqQCkBk+Rut8Wepg/Bg==
X-Gm-Gg: AYBFou2f8cExx9kygW/37zU7x7MILYl/O/f0pEzh30k/jDHJzOOJnNQUZY6drShItw3
 AS/MjPokpyblyEuwxtwCNsst6DaiJDULpuPzZVXA8MmkmNfIUQLyjb1+QnFj3LC9KbpqvUmLRVp
 huTvVQ036z6R+cicjl5LkGqIIckT4xTV9nyjcR9dBfBELJ8vJsTCx618BbDtHz6agafEC00i8xR
 xR+crhwfGwkSLed/gT9WrDzAZd48Ns0IM5CMK1mKLLr7YX7tb5vpkvtEs1U+b30fgs0ZdcwwqmE
 sf02eafMa5ct1o9YvSAuRD/PbGmtzfG/kq1UmJvf7BGYUJZH7dkD2BEAtqhKaDho2oWRxMZ/4b0
 anXJBXyhwH7BRpnOwF/49HkQFzB73L357I1ZHaHKsccfED4AHytuy0Vw2J5Iu5PkizbiAxl4qC0
 /SnyR59PSJBgIUIIAECCSzFqXhNY1vGxL4nWxT8Smw7b16VCN347p21yEgC7J5u825oMAGGJ/mr
 h2ONHq3KfC8vhrDpu6oN+5r1a0ukt2jgstkSQf0FP946fFLSdmWVHwJzaCOJP+vqaMVz2Dm3xq4
 +DZRgQL6qIAQoP/j8+K9KH9gpoG7KBuv9v95vyDLZFOJ0znUbirVRLj6X0t+DEexZ3QuOeVarel
 CmNIh0up6xWmjl8aQ7S5NMUAXge+b
X-Received: by 2002:a05:693c:6092:b0:369:1084:8ee3 with SMTP id
 5a478bee46e88-36a423e52c8mr29866359eec.23.1793821387091; 
 Wed, 04 Nov 2026 11:43:07 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36ca38d36a1sm11299527eec.12.2026.11.04.11.43.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 11:43:06 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [RFC PATCH 17/38] target/riscv: rvv: Implement Zvfqwdota8f
 instructions
Date: Thu,  5 Nov 2026 03:41:32 +0800
Message-ID: <20261104194155.679241-18-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104194155.679241-1-max.chou@sifive.com>
References: <20261104194155.679241-1-max.chou@sifive.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132f;
 envelope-from=max.chou@sifive.com; helo=mail-dy1-x132f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Implements the Zvfqwdota8f OCP FP8 dot-product instructions:
- vfqwdota.vv: vs2 is E4M3, vs1 format selected by altfmt (0=E4M3, 1=E5M2)
- vfqwdota.alt.vv: vs2 is E5M2, vs1 format selected by altfmt (0=E4M3, 1=E5M2)

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/helper.h                       |  5 ++
 target/riscv/insn32.decode                  |  4 ++
 target/riscv/tcg/insn_trans/trans_rvv.c.inc | 47 ++++++++++++++++
 target/riscv/tcg/vector_helper.c            | 62 +++++++++++++++++++++
 4 files changed, 118 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 918ff21b3e2..48c64f45748 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1395,6 +1395,11 @@ DEF_HELPER_6(vqwdotas_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
 
 /* Zvfwdota16bf - BF16 Dot Product */
 DEF_HELPER_6(vfwdota_vv, void, ptr, ptr, ptr, ptr, env, i32)
+
+/* Zvfqwdota8f - OCP FP8 Dot Product */
+DEF_HELPER_6(vfqwdota_vv, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfqwdota_alt_vv, void, ptr, ptr, ptr, ptr, env, i32)
+
 /* SiFive Custom int8 Matrix-Multiply */
 DEF_HELPER_5(sf_vqmaccu_4x8x4, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(sf_vqmacc_4x8x4, void, ptr, ptr, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index d800ad99451..def5785f8e2 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -1104,3 +1104,7 @@ vqwdotas_vv  100111 . ..... ..... 000 ..... 1110111 @r_vm
 
 # *** Zvfwdota16bf BF16 Dot-Product Extension ***
 vfwdota_vv  100100 . ..... ..... 001 ..... 1110111 @r_vm
+
+# *** Zvfqwdota8f OCP FP8 Dot-Product Extension ***
+vfqwdota_vv     100110 . ..... ..... 001 ..... 1110111 @r_vm
+vfqwdota_alt_vv 100111 . ..... ..... 001 ..... 1110111 @r_vm
diff --git a/target/riscv/tcg/insn_trans/trans_rvv.c.inc b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
index c50f863ea0b..6eb22494838 100644
--- a/target/riscv/tcg/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
@@ -4242,3 +4242,50 @@ static bool trans_vfwdota_vv(DisasContext *s, arg_rmrr * a)
     }
     return false;
 }
+
+/* Zvfqwdota8f OCP FP8 Dot-Product Extension */
+static bool vext_vfqwdota_check(DisasContext *s, arg_rmrr *a)
+{
+    return s->mstatus_fs != EXT_STATUS_DISABLED &&
+           vext_zvdota_base_check(s, a) &&
+           (s->cfg_ptr->ext_zvfqwdota8f && s->sew == MO_8);
+}
+
+#define GEN_ZVDOTA_FP8_TRANS(NAME, CHECK)                               \
+static bool trans_##NAME(DisasContext *s, arg_rmrr *a)                  \
+{                                                                       \
+    if (CHECK(s, a)) {                                                  \
+        TCGv_ptr dest, src1, src2, mask;                                \
+        TCGv_i32 desc;                                                  \
+        uint32_t data = 0;                                              \
+                                                                        \
+        gen_set_rm(s, RISCV_FRM_DYN);                                   \
+                                                                        \
+        data = FIELD_DP32(data, VDATA, VM, a->vm);                      \
+        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);                  \
+        data = FIELD_DP32(data, VDATA, VTA, s->vta);                    \
+        data = FIELD_DP32(data, VDATA, VTA_ALL_1S, s->cfg_vta_all_1s);  \
+                                                                        \
+        dest = tcg_temp_new_ptr();                                      \
+        mask = tcg_temp_new_ptr();                                      \
+        src1 = tcg_temp_new_ptr();                                      \
+        src2 = tcg_temp_new_ptr();                                      \
+        desc = tcg_constant_i32(simd_desc(s->cfg_ptr->vlenb,            \
+                                          s->cfg_ptr->vlenb, data));    \
+                                                                        \
+        tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, a->rd));            \
+        tcg_gen_addi_ptr(src1, tcg_env, vreg_ofs(s, a->rs1));           \
+        tcg_gen_addi_ptr(src2, tcg_env, vreg_ofs(s, a->rs2));           \
+        tcg_gen_addi_ptr(mask, tcg_env, vreg_ofs(s, 0));                \
+                                                                        \
+        gen_helper_##NAME(dest, mask, src1, src2, tcg_env, desc);       \
+                                                                        \
+        finalize_rvv_inst(s);                                           \
+                                                                        \
+        return true;                                                    \
+    }                                                                   \
+    return false;                                                       \
+}
+
+GEN_ZVDOTA_FP8_TRANS(vfqwdota_vv, vext_vfqwdota_check)
+GEN_ZVDOTA_FP8_TRANS(vfqwdota_alt_vv, vext_vfqwdota_check)
diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
index a4c52ed296a..5cb44326200 100644
--- a/target/riscv/tcg/vector_helper.c
+++ b/target/riscv/tcg/vector_helper.c
@@ -6075,3 +6075,65 @@ void HELPER(vfwdota_vv)(void *vd, void *v0, void *vs1, void *vs2,
         vext_set_elems_1s(vd, vta, 1 * 4, total_elems * 4);
     }
 }
+
+/*
+ * Zvfqwdota8f: OCP FP8 Dot Product with Accumulation
+ */
+#define GEN_VEXT_ZVDOTA_FP8(NAME, TYPE_VS2)                              \
+void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,              \
+                  CPURISCVState *env, uint32_t desc)                     \
+{                                                                        \
+    uint32_t vlmax = vext_max_elems(desc, ctzl(sizeof(uint8_t)));        \
+    uint32_t vm = vext_vm(desc);                                         \
+    uint32_t vl = env->vl;                                               \
+    uint32_t vta = vext_vta(desc);                                       \
+    uint32_t vta_all_1s = vext_vta_all_1s(desc);                         \
+    uint32_t total_elems = riscv_cpu_cfg(env)->vlenb >> 2;               \
+    uint32_t altfmt = FIELD_EX64(env->vtype, VTYPE, ALTFMT);             \
+    uint32_t i;                                                          \
+    uint8_t *a_vec, *b_vec;                                              \
+    uint32_t dot_result, acc;                                            \
+                                                                         \
+    VSTART_CHECK_EARLY_EXIT(env, vl);                                    \
+                                                                         \
+    a_vec = g_new0(uint8_t, vlmax);                                      \
+    b_vec = g_new0(uint8_t, vlmax);                                      \
+                                                                         \
+    for (i = 0; i < vl; i++) {                                           \
+        if (!vm && !vext_elem_mask(v0, i)) {                             \
+            continue;                                                    \
+        }                                                                \
+        a_vec[i] = *((uint8_t *)vs2 + H1(i));                            \
+        b_vec[i] = *((uint8_t *)vs1 + H1(i));                            \
+    }                                                                    \
+                                                                         \
+    FloatExceptionFlags pre_fflag =                                      \
+        get_float_exception_flags(&env->fp_status);                      \
+    FloatSNaNRule pre_snan_rule = get_snan_rule(&env->fp_status);        \
+    set_snan_rule(float_snan_never, &env->fp_status);                    \
+    if (altfmt == 0) {                                                   \
+        dot_result = rvbna_dot_float8_##TYPE_VS2##_float8_e4m3(          \
+            a_vec, b_vec, vlmax, &env->fp_status);                       \
+    } else {                                                             \
+        dot_result = rvbna_dot_float8_##TYPE_VS2##_float8_e5m2(          \
+            a_vec, b_vec, vlmax, &env->fp_status);                       \
+    }                                                                    \
+    set_snan_rule(pre_snan_rule, &env->fp_status);                       \
+                                                                         \
+    acc = *((uint32_t *)vd + H4(0));                                     \
+    *((uint32_t *)vd + H4(0)) = rvbna_final_f32_add(dot_result, acc,     \
+                                                    &env->fp_status);    \
+    riscv_cpu_check_fflags(env, pre_fflag);                              \
+                                                                         \
+    g_free(a_vec);                                                       \
+    g_free(b_vec);                                                       \
+                                                                         \
+    env->vstart = 0;                                                     \
+                                                                         \
+    if (vta_all_1s) {                                                    \
+        vext_set_elems_1s(vd, vta, 1 * 4, total_elems * 4);              \
+    }                                                                    \
+}
+
+GEN_VEXT_ZVDOTA_FP8(vfqwdota_vv, e4m3)
+GEN_VEXT_ZVDOTA_FP8(vfqwdota_alt_vv, e5m2)
-- 
2.56.0


