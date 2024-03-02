Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13293C54798
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Mar 2024 05:17:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgHji-0002Tm-04; Sat, 02 Mar 2024 00:16:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgHjg-0002TU-HA
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 00:16:36 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgHje-0007Wg-EB
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 00:16:35 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6e5c81ccfb9so931907b3a.3
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 21:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709356593; x=1709961393; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kQ3I8rYu6VW67Fi6xxt1l88oe9BrbgSqjwmsi4V6ivk=;
 b=VpOlyCOl6ztEFJ3zazGNuRE/fis4O8QjagNPMyYQ/zegtZw5x6st35zpHl4MVav7eE
 LwDyCdqFRzmfBSUhuOgPUlnCF6BlRs3S1OEiAucqXIPdz7NiQDOL9q7ZX0gBUB6cD6Zs
 TQiDXV5zEIKJUdLqK+OLcjUKDKPApNQ+5bAlnBRtGQXocV5Jv5dbDqPExA9JqhWyeHw+
 TOHIDWGPJs+/8DQYAazghu40+tMlAGLLa9l9AwmbBz9N2YcMVUGPD1fPRKJpH99MpjzX
 M5IMe62cnBvUaQxVArS1paGnxyLjpENwmvOC4AqHZXJcAyqJqmZw/sU/8bVqwcprYPLF
 7GAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709356593; x=1709961393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kQ3I8rYu6VW67Fi6xxt1l88oe9BrbgSqjwmsi4V6ivk=;
 b=UOkP5CO0npxmJjfcnE0Aa7DGXSQGLYOSoDTF5nFfDlccSZqIXrg2liIXsimfG5CMzE
 /nwYx3HCjWeUP4RDti6ohFb4MdvQ46vZOmDm9K3bRdjQkig5zSXt3WELzYtw0sDtNkm7
 AvssJpZSkxbgAtm5oQ1+JJ0tgyl3XQSB54B3DbYBCwVaIZZ25D++e16YbRc+QcSyOmFX
 snlOIkzrr+wm1ubcHNluw7hJayz7AR2T449Fz03YUaCwmpiHwCdn+SrUfE6x/2TqN2by
 keYaxGOgBejl734jTFfgUZMiT9nO1K/yhBNd5+XWwyle/R7CZ4OmfLozDeDWElYBE67b
 bFjA==
X-Gm-Message-State: AOJu0YwpI214MXLyQItH2hdTLSvT/7B+Fl3BV9g6nZxPu+aYRqd8RxQ4
 jk518VBgT+9XH7hVNI40u2exICltk3JwoPveR4e6KyClzrlQwZaUr5rfmTAGhxpN7X06NIvHBrm
 L
X-Google-Smtp-Source: AGHT+IH72rp6v7FBlGJ3GQgCQHKqnPc1+fJ4AuweiwsM9ZjlekOLaxw2R1n59PUs0SgrUsjGAcl3bw==
X-Received: by 2002:a05:6a20:6aa1:b0:1a1:2cba:baf2 with SMTP id
 bi33-20020a056a206aa100b001a12cbabaf2mr2779640pzb.52.1709356593250; 
 Fri, 01 Mar 2024 21:16:33 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 v8-20020a17090a458800b0029af67d4fd0sm4034901pjg.44.2024.03.01.21.16.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 21:16:32 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 16/41] target/sparc: Implement FCHKSM16
Date: Fri,  1 Mar 2024 19:15:36 -1000
Message-Id: <20240302051601.53649-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240302051601.53649-1-richard.henderson@linaro.org>
References: <20240302051601.53649-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/helper.h     |  1 +
 target/sparc/translate.c  | 32 ++++++++++++++++++++++++++++++++
 target/sparc/vis_helper.c | 23 +++++++++++++++++++++++
 target/sparc/insns.decode |  1 +
 4 files changed, 57 insertions(+)

diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index 9cd9a81f03..37b22afd7f 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -107,6 +107,7 @@ DEF_HELPER_FLAGS_3(bshuffle, TCG_CALL_NO_RWG_SE, i64, i64, i64, i64)
 DEF_HELPER_FLAGS_2(cmask8, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(cmask16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(cmask32, TCG_CALL_NO_RWG_SE, i64, i64, i64)
+DEF_HELPER_FLAGS_2(fchksm16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 #define VIS_CMPHELPER(name)                                              \
     DEF_HELPER_FLAGS_2(f##name##16, TCG_CALL_NO_RWG_SE,      \
                        i64, i64, i64)                                    \
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index fd85fd3e97..d6adbf9236 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -797,6 +797,37 @@ static void gen_op_fmuld8sux16(TCGv_i64 dst, TCGv_i32 src1, TCGv_i32 src2)
     tcg_gen_concat_i32_i64(dst, t0, t1);
 }
 
+#ifdef TARGET_SPARC64
+static void gen_vec_fchksm16(unsigned vece, TCGv_vec dst,
+                             TCGv_vec src1, TCGv_vec src2)
+{
+    TCGv_vec a = tcg_temp_new_vec_matching(dst);
+    TCGv_vec c = tcg_temp_new_vec_matching(dst);
+
+    tcg_gen_add_vec(vece, a, src1, src2);
+    tcg_gen_cmp_vec(TCG_COND_LTU, vece, c, a, src1);
+    /* Vector cmp produces -1 for true, so subtract to add carry. */
+    tcg_gen_sub_vec(vece, dst, a, c);
+}
+
+static void gen_op_fchksm16(unsigned vece, uint32_t dofs, uint32_t aofs,
+                            uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_cmp_vec, INDEX_op_add_vec, INDEX_op_sub_vec,
+    };
+    static const GVecGen3 op = {
+        .fni8 = gen_helper_fchksm16,
+        .fniv = gen_vec_fchksm16,
+        .opt_opc = vecop_list,
+        .vece = MO_16,
+    };
+    tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &op);
+}
+#else
+#define gen_op_fchksm16   ({ qemu_build_not_reached(); NULL; })
+#endif
+
 static void finishing_insn(DisasContext *dc)
 {
     /*
@@ -4738,6 +4769,7 @@ TRANS(FPADD16, VIS1, do_gvec_ddd, a, MO_16, tcg_gen_gvec_add)
 TRANS(FPADD32, VIS1, do_gvec_ddd, a, MO_32, tcg_gen_gvec_add)
 TRANS(FPSUB16, VIS1, do_gvec_ddd, a, MO_16, tcg_gen_gvec_sub)
 TRANS(FPSUB32, VIS1, do_gvec_ddd, a, MO_32, tcg_gen_gvec_sub)
+TRANS(FCHKSM16, VIS3, do_gvec_ddd, a, MO_16, gen_op_fchksm16)
 
 static bool do_ddd(DisasContext *dc, arg_r_r_r *a,
                    void (*func)(TCGv_i64, TCGv_i64, TCGv_i64))
diff --git a/target/sparc/vis_helper.c b/target/sparc/vis_helper.c
index 0278caa25d..c627bb1a1f 100644
--- a/target/sparc/vis_helper.c
+++ b/target/sparc/vis_helper.c
@@ -372,3 +372,26 @@ uint64_t helper_cmask32(uint64_t gsr, uint64_t src)
 
     return deposit64(gsr, 32, 32, mask);
 }
+
+static inline uint16_t do_fchksm16(uint16_t src1, uint16_t src2)
+{
+    uint16_t a = src1 + src2;
+    uint16_t c = a < src1;
+    return a + c;
+}
+
+uint64_t helper_fchksm16(uint64_t src1, uint64_t src2)
+{
+    VIS64 r, s1, s2;
+
+    s1.ll = src1;
+    s2.ll = src2;
+    r.ll = 0;
+
+    r.VIS_W64(0) = do_fchksm16(s1.VIS_W64(0), s2.VIS_W64(0));
+    r.VIS_W64(1) = do_fchksm16(s1.VIS_W64(1), s2.VIS_W64(1));
+    r.VIS_W64(2) = do_fchksm16(s1.VIS_W64(2), s2.VIS_W64(2));
+    r.VIS_W64(3) = do_fchksm16(s1.VIS_W64(3), s2.VIS_W64(3));
+
+    return r.ll;
+}
diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 8f298ca675..120713a28f 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -410,6 +410,7 @@ FCMPEq      10 000 cc:2 110101 .....  0 0101 0111 .....    \
     PDIST       10 ..... 110110 ..... 0 0011 1110 .....    \
                 &r_r_r_r rd=%dfp_rd rs1=%dfp_rd rs2=%dfp_rs1 rs3=%dfp_rs2
 
+    FCHKSM16    10 ..... 110110 ..... 0 0100 0100 .....    @d_d_d
     FALIGNDATAg 10 ..... 110110 ..... 0 0100 1000 .....    @d_d_d
     FPMERGE     10 ..... 110110 ..... 0 0100 1011 .....    @d_r_r
     BSHUFFLE    10 ..... 110110 ..... 0 0100 1100 .....    @d_d_d
-- 
2.34.1


