Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABC06089CB4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 19:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256 header.s=google header.b=CatFJqbU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOgtv-0005SI-JL; Wed, 04 Nov 2026 14:44:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xOgts-0005DG-1L
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 14:44:00 -0500
Received: from mail-dy1-x1329.google.com ([2607:f8b0:4864:20::1329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xOgtq-0002eX-6i
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 14:43:59 -0500
Received: by mail-dy1-x1329.google.com with SMTP id
 5a478bee46e88-36cad25b8b0so1633857eec.1
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 11:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1793821437; x=1794426237; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aJbH3935rrJI7kkIS9jO0elK6gKGfMQq7hH3Gf5a28o=;
 b=CatFJqbUrCcFc2pQRonSpwvwg7d8EQDFnCSZqHGuB81TbsMcMc2Y+xpnoybSC/veoR
 USA+3r+urq59wJmJRcqpfL7W/voyq/GgjKsL3UOUGKbwKYle7fS3jY6GhyQWReJOGrZ8
 gu6XVAWuxd1zrFOXOoypRmeWE7eEdv+qP5+11ZJUWMyh95ohVelQyyTnLi+lwkIYfwkW
 PO66wy5jrFPjjniwnSKXA6T/56vs31wg7kov8DH2o8vWHKYKwboeWcAs94YPksRMchAS
 QjfqRiKn4WZQ9yA8cLf+7kvfLYNxYfBx8rzRnQWrN+vDiaFui+hPUHtkKwcQZNAol83z
 BAgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793821437; x=1794426237;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=aJbH3935rrJI7kkIS9jO0elK6gKGfMQq7hH3Gf5a28o=;
 b=bU++EwaiWFn2EcB41zHmx6ULGcBiyLvKQ+ZE+c6QNIdqxOifAsvS2B/cFqHg6iIw2k
 4tq0G9TIRoJan1D0rEkN80ECA5VAMfTiBXWY1N26yn9QdX78KDNOsBNysu2oGj7Q0lH6
 NU3ozXRNnJWj+cekk11xtSrpJnFZJEuDdpRmauiSTX8IOC+oraBC8dQi4UHpq4MxEiiO
 aaMkwmNFIUG8JjkRci0KHWvT6PBxwm0psazTRSJrN9HNj9Ygm/xReNFTBnLXpb7Kd93V
 S5/RO9b3JDtJfXMCBHSGLsPt/gZbFbUM6Tb1Pyj2Km89Y27KlzGq38+EkCv7sGVS+Lpw
 WA6w==
X-Gm-Message-State: APuU4Z/r8IG8w2uPs+Fr5JFuhy0vlaLgvdu/8wDUWdsI6gtel9KOMbeA
 tWL3Qk23FF0vtHKfiwGkWaVX3tqXmTmlKwAulYkkDEnrrrQCNQFFswc3al36ThOVOIOOmHmNtFJ
 /hbspiiqpnliIV387z2ZdrCKjJ3z6jGCEV1hK8zvu36XkEwpLBd+WLqZymbfOlvpv9fANSoicgb
 RwNI7ftwnlyKf/hyovsCshhgx1GQMKCKrnn9+Vrn8aAA==
X-Gm-Gg: AYBFou3l7cJQUsMWem6joCr1Na8lD0knUzJ3O91i34f4vHXep2hdqq035e6aHGFkl2N
 YJCly+wCGYPTJC+8uZCra6ZWbVbYuKnVah4scyFlDbp36HsAZB29TmWrH05XVOnPhlLvn7LyAkD
 SzpWl/8mDSgv/ufzUiYhn9jkGldiKUpkY4dZxy7FnqNq5yNvea5AAtxDSN2tP769f9er5G3GG0+
 XvWp9+jmGyhyLXeON0FsX12jXmfZhf+gRy57FO3oWKAb2aS7xg8hoLKbonnkVtCahG46kjUpkOp
 cCyE8TDR8DxX9v6ieGByQFrw0TKeYvdMYZBNBIHnJael56DIiMflfmlwX2GjUlIXt/WqJlmNyLK
 Mdfo7aTTEIaOSYOsbn6b/4c5KV3ltqAHVWmNOU8gcCSqDgujnvqJkEA50BqN5BQsyRR45zcK0jc
 dUMvGGiyNWV1PEPpwGRSMIwb2+A1gHH/D9ZiRREE+XNA7dx1jk6I/OKdDBFXZqqFDAHdprbF14V
 7nNHZqwYR9qKZ9ocfIELMnAkTZcpLlFF3Gq64RYD+vQRufw+mAGph6GadhyVjwMgkyobuASO2zB
 hWiL8E+NGPV8bKJznDZejJIu9GwcQnhnRHkvI4iYH31Z7OQ/dn2SEqZu3WegdZ/PCGfKa1A7L/s
 u6CFydX6LdQXnKO58tII4t3bSm8dG
X-Received: by 2002:a05:693c:42d3:b0:369:faa2:1fb2 with SMTP id
 5a478bee46e88-36a4236a650mr25480724eec.8.1793821436357; 
 Wed, 04 Nov 2026 11:43:56 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36ca38d36a1sm11299527eec.12.2026.11.04.11.43.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 11:43:54 -0800 (PST)
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
Subject: [RFC PATCH 32/38] target/riscv: rvv: Implement Zvfqwbdota8f
 instructions
Date: Thu,  5 Nov 2026 03:41:47 +0800
Message-ID: <20261104194155.679241-33-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104194155.679241-1-max.chou@sifive.com>
References: <20261104194155.679241-1-max.chou@sifive.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1329;
 envelope-from=max.chou@sifive.com; helo=mail-dy1-x1329.google.com
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
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Support the Zvfqwbdota8f OCP FP8 batched dot-product instructions.
These instructions perform 8 parallel dot products between OCP FP8 vectors,
accumulating into FP32 elements.

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/helper.h                       |  4 ++
 target/riscv/insn32.decode                  |  4 ++
 target/riscv/tcg/insn_trans/trans_rvv.c.inc | 13 ++++
 target/riscv/tcg/vector_helper.c            | 69 +++++++++++++++++++++
 4 files changed, 90 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 1f2dfd6d557..a257436fb31 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1398,6 +1398,10 @@ DEF_HELPER_6(vfwdota_vv, void, ptr, ptr, ptr, ptr, env, i32)
 /* Zvfwbdota16bf - BF16 Batched Dot Product */
 DEF_HELPER_7(vfwbdota_vv, void, ptr, ptr, ptr, ptr, i32, env, i32)
 
+/* Zvfqwbdota8f - OCP FP8 Batched Dot Product */
+DEF_HELPER_7(vfqwbdota_vv, void, ptr, ptr, ptr, ptr, i32, env, i32)
+DEF_HELPER_7(vfqwbdota_alt_vv, void, ptr, ptr, ptr, ptr, i32, env, i32)
+
 /* Zvfqwdota8f - OCP FP8 Dot Product */
 DEF_HELPER_6(vfqwdota_vv, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfqwdota_alt_vv, void, ptr, ptr, ptr, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 00ed64b73fd..48597915f7b 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -1108,6 +1108,10 @@ vfwdota_vv  100100 . ..... ..... 001 ..... 1110111 @r_vm
 # *** Zvfwbdota16bf BF16 Batched Dot-Product Extension ***
 vfwbdota_vv 101100 . ..... ..... 001 ..... 1110111 @r_vm
 
+# *** Zvfqwbdota8f OCP FP8 Batched Dot-Product Extension ***
+vfqwbdota_vv     101110 . ..... ..... 001 ..... 1110111 @r_vm
+vfqwbdota_alt_vv 101111 . ..... ..... 001 ..... 1110111 @r_vm
+
 # *** Zvfqwdota8f OCP FP8 Dot-Product Extension ***
 vfqwdota_vv     100110 . ..... ..... 001 ..... 1110111 @r_vm
 vfqwdota_alt_vv 100111 . ..... ..... 001 ..... 1110111 @r_vm
diff --git a/target/riscv/tcg/insn_trans/trans_rvv.c.inc b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
index d4678171ac5..50f0f67ea60 100644
--- a/target/riscv/tcg/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
@@ -4417,3 +4417,16 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr * a)                 \
 }
 
 GEN_ZVBDOTA_FP_TRANS(vfwbdota_vv, vext_vfwbdota_check, MO_32)
+
+/* Zvfqwbdota8f OCP FP8 Batched Dot-Product Extension */
+static bool vext_vfqwbdota_check(DisasContext *s, arg_rmrr * a)
+{
+    int32_t sew = s->sew;
+    int32_t vd_eew = sew + 2;
+    return s->mstatus_fs != EXT_STATUS_DISABLED &&
+           vext_zvbdota_base_check(s, a, vd_eew) &&
+           (s->cfg_ptr->ext_zvfqwbdota8f && sew == MO_8);
+}
+
+GEN_ZVBDOTA_FP_TRANS(vfqwbdota_vv, vext_vfqwbdota_check, MO_32)
+GEN_ZVBDOTA_FP_TRANS(vfqwbdota_alt_vv, vext_vfqwbdota_check, MO_32)
diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
index 6f3b666784e..e641e21d088 100644
--- a/target/riscv/tcg/vector_helper.c
+++ b/target/riscv/tcg/vector_helper.c
@@ -6258,3 +6258,72 @@ void HELPER(vfwbdota_vv)(void *vd, void *v0, void *vs1, void *vs2, uint32_t ci,
         }
     }
 }
+
+/*
+ * Zvfqwdota8f: OCP FP8 Dot Product with Accumulation
+ */
+#define GEN_VEXT_ZVBDOTA_FP8(NAME, TYPE_VS2)                             \
+void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,              \
+                  uint32_t ci, CPURISCVState *env, uint32_t desc)        \
+{                                                                        \
+    uint32_t vm = vext_vm(desc);                                         \
+    uint32_t vl = env->vl;                                               \
+    uint32_t vta = vext_vta(desc);                                       \
+    uint32_t vta_all_1s = vext_vta_all_1s(desc);                         \
+    uint32_t vlenb = riscv_cpu_cfg(env)->vlenb;                          \
+    uint32_t vd_emul = vext_lmul(desc);                                  \
+    uint32_t total_elems = (vlenb << vd_emul) >> 2;                      \
+    uint32_t vlmax = vlenb;                                              \
+    uint32_t altfmt = FIELD_EX64(env->vtype, VTYPE, ALTFMT);             \
+    uint32_t n, k;                                                       \
+    uint8_t *a_vec, *b_vec;                                              \
+    float32 acc, dot_result;                                             \
+                                                                         \
+    VSTART_CHECK_EARLY_EXIT(env, vl);                                    \
+                                                                         \
+    a_vec = g_new0(uint8_t, vlmax);                                      \
+    b_vec = g_new0(uint8_t, vlmax);                                      \
+                                                                         \
+    FloatExceptionFlags pre_fflag =                                      \
+        get_float_exception_flags(&env->fp_status);                      \
+    for (n = 0; n < 8; n++) {                                            \
+        if (!vm && !vext_elem_mask(v0, ci + n)) {                        \
+            continue;                                                    \
+        }                                                                \
+                                                                         \
+        for (k = 0; k < vl; k++) {                                       \
+            a_vec[k] = *((uint8_t *)vs2 + n * vlmax + H1(k));            \
+            b_vec[k] = *((uint8_t *)vs1 + H1(k));                        \
+        }                                                                \
+                                                                         \
+        FloatSNaNRule pre_snan_rule = get_snan_rule(&env->fp_status);    \
+        set_snan_rule(float_snan_never, &env->fp_status);                \
+        if (altfmt == 0) {                                               \
+            dot_result = rvbna_dot_float8_##TYPE_VS2##_float8_e4m3(      \
+                    a_vec, b_vec, vlmax, &env->fp_status);               \
+        } else {                                                         \
+            dot_result = rvbna_dot_float8_##TYPE_VS2##_float8_e5m2(      \
+                    a_vec, b_vec, vlmax, &env->fp_status);               \
+        }                                                                \
+        set_snan_rule(pre_snan_rule, &env->fp_status);                   \
+                                                                         \
+        acc = *((float32 *)vd + H4(ci + n));                             \
+        *((float32 *)vd + H4(ci + n)) = rvbna_final_f32_add(             \
+                dot_result, acc, &env->fp_status);                       \
+    }                                                                    \
+    riscv_cpu_check_fflags(env, pre_fflag);                              \
+                                                                         \
+    g_free(a_vec);                                                       \
+    g_free(b_vec);                                                       \
+                                                                         \
+    env->vstart = 0;                                                     \
+                                                                         \
+    if (ci + 8 < total_elems) {                                          \
+        if (vta_all_1s) {                                                \
+            vext_set_elems_1s(vd, vta, (ci + 8) * 4, total_elems * 4);   \
+        }                                                                \
+    }                                                                    \
+}
+
+GEN_VEXT_ZVBDOTA_FP8(vfqwbdota_vv, e4m3)
+GEN_VEXT_ZVBDOTA_FP8(vfqwbdota_alt_vv, e5m2)
-- 
2.56.0


