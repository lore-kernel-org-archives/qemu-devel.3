Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84AECC54E41
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Mar 2024 05:19:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgHjr-0002Wh-98; Sat, 02 Mar 2024 00:16:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgHjo-0002Vq-59
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 00:16:44 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgHjm-0007Yr-Cp
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 00:16:43 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6e56a5b2812so1862670b3a.1
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 21:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709356600; x=1709961400; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eFgQq/tUbJgjC/SMzYSpMDPxCXRaDcih395pAQkBr2M=;
 b=PM3BSWxxC1D3ciyGbEbysMDcuSVEkvvNUqD3ptZAt/dFB4P33mrmab0Nw0iXxqnv01
 Eil6SGBUExbU2EVNCbX+nvDgrcfmylH30FWANAJKuMTLvsGNwt4Fy9JWLKymUGvVXdUL
 8OPlHeYNqkTrVy3wkGKGidJqSRrDx5d1joo0KZe/UkGQe8JdIGU7WZHWx7oXGDMDt9k6
 6XYU5VbSCWi2jVqo+zqH6jEoEnDKQk+MaJeSJCBisGvIIf1UTqH2xBtkbnbfwTMyp+1s
 RwO4UuScxnvE+3gImAR9Fez0ORaQLReOJDZddB4lp6jtdJVrTso7OdpNBhqPzIceLW+l
 9qew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709356600; x=1709961400;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eFgQq/tUbJgjC/SMzYSpMDPxCXRaDcih395pAQkBr2M=;
 b=rKVAkPD+8ctLUg5AxWut5GrLViFdbP3RepRMJHIIOkUBGZmc8NUaCh9AFGL+8Ze8CZ
 aUwDX/1czVcZM9KS+6hZwVMQ+doedTdnR4NrUerx2XGIO7L51CBtS0VBiFI/zKgZ8rRb
 IzBf7CGO0Te8WGrsZfh0mF44/LjCIgFOplfVNQPZb5ySQuWzGWuKR9ziFks6wMqcuAFh
 VqJT3c3AUnE1rl/l3As3nlZWFJxBES7SrfiWmh9qSCioWsJ6+VkkasQ6nHXYzUobxmit
 KMQm5/9nyLTClsOQ2CTERk67BmZvWj9Xr7H56l8oKPCb+B90WEi3ozXEq6rW+NPj8uhk
 6YpQ==
X-Gm-Message-State: AOJu0Yx+JvXz56sAjsv7K5ewAv7kAZIcF60UIIWGG5NSyQ8j6gvbzyJ6
 eGbr7KAPNPRFVT/TK8vHadk5q0msTKY4sG0TqRqadJg3cr5M436KBdZ8ENZKRCSEJS5FAl304iR
 D
X-Google-Smtp-Source: AGHT+IEEKo2Z0yX6+9ER/3hTFBo2nCS+XizQ4Z0CZN2jQ4QC9BlBmiOFxVtMm5SfsSY+++O2m/H7Pg==
X-Received: by 2002:a05:6a20:1582:b0:1a0:d57b:1c93 with SMTP id
 h2-20020a056a20158200b001a0d57b1c93mr4058590pzj.33.1709356599924; 
 Fri, 01 Mar 2024 21:16:39 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 v8-20020a17090a458800b0029af67d4fd0sm4034901pjg.44.2024.03.01.21.16.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 21:16:39 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 20/41] target/sparc: Implement FMEAN16
Date: Fri,  1 Mar 2024 19:15:40 -1000
Message-Id: <20240302051601.53649-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240302051601.53649-1-richard.henderson@linaro.org>
References: <20240302051601.53649-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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
 target/sparc/translate.c  | 30 ++++++++++++++++++++++++++++++
 target/sparc/vis_helper.c | 21 +++++++++++++++++++++
 target/sparc/insns.decode |  1 +
 4 files changed, 53 insertions(+)

diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index 97b3c24fb3..8a5191414e 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -113,6 +113,7 @@ DEF_HELPER_FLAGS_2(cmask8, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(cmask16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(cmask32, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(fchksm16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
+DEF_HELPER_FLAGS_2(fmean16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 #define VIS_CMPHELPER(name)                                              \
     DEF_HELPER_FLAGS_2(f##name##16, TCG_CALL_NO_RWG_SE,      \
                        i64, i64, i64)                                    \
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 6dba0fcca6..4876d46ebb 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -824,8 +824,37 @@ static void gen_op_fchksm16(unsigned vece, uint32_t dofs, uint32_t aofs,
     };
     tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &op);
 }
+
+static void gen_vec_fmean16(unsigned vece, TCGv_vec dst,
+                            TCGv_vec src1, TCGv_vec src2)
+{
+    TCGv_vec t = tcg_temp_new_vec_matching(dst);
+
+    tcg_gen_or_vec(vece, t, src1, src2);
+    tcg_gen_and_vec(vece, t, t, tcg_constant_vec_matching(dst, vece, 1));
+    tcg_gen_sari_vec(vece, src1, src1, 1);
+    tcg_gen_sari_vec(vece, src2, src2, 1);
+    tcg_gen_add_vec(vece, dst, src1, src2);
+    tcg_gen_add_vec(vece, dst, dst, t);
+}
+
+static void gen_op_fmean16(unsigned vece, uint32_t dofs, uint32_t aofs,
+                           uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_add_vec, INDEX_op_sari_vec,
+    };
+    static const GVecGen3 op = {
+        .fni8 = gen_helper_fmean16,
+        .fniv = gen_vec_fmean16,
+        .opt_opc = vecop_list,
+        .vece = MO_16,
+    };
+    tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &op);
+}
 #else
 #define gen_op_fchksm16   ({ qemu_build_not_reached(); NULL; })
+#define gen_op_fmean16    ({ qemu_build_not_reached(); NULL; })
 #endif
 
 static void finishing_insn(DisasContext *dc)
@@ -4836,6 +4865,7 @@ TRANS(FPADD32, VIS1, do_gvec_ddd, a, MO_32, tcg_gen_gvec_add)
 TRANS(FPSUB16, VIS1, do_gvec_ddd, a, MO_16, tcg_gen_gvec_sub)
 TRANS(FPSUB32, VIS1, do_gvec_ddd, a, MO_32, tcg_gen_gvec_sub)
 TRANS(FCHKSM16, VIS3, do_gvec_ddd, a, MO_16, gen_op_fchksm16)
+TRANS(FMEAN16, VIS3, do_gvec_ddd, a, MO_16, gen_op_fmean16)
 
 static bool do_ddd(DisasContext *dc, arg_r_r_r *a,
                    void (*func)(TCGv_i64, TCGv_i64, TCGv_i64))
diff --git a/target/sparc/vis_helper.c b/target/sparc/vis_helper.c
index c627bb1a1f..93a6239f41 100644
--- a/target/sparc/vis_helper.c
+++ b/target/sparc/vis_helper.c
@@ -395,3 +395,24 @@ uint64_t helper_fchksm16(uint64_t src1, uint64_t src2)
 
     return r.ll;
 }
+
+static inline int16_t do_fmean16(int16_t src1, int16_t src2)
+{
+    return (src1 + src2 + 1) / 2;
+}
+
+uint64_t helper_fmean16(uint64_t src1, uint64_t src2)
+{
+    VIS64 r, s1, s2;
+
+    s1.ll = src1;
+    s2.ll = src2;
+    r.ll = 0;
+
+    r.VIS_SW64(0) = do_fmean16(s1.VIS_SW64(0), s2.VIS_SW64(0));
+    r.VIS_SW64(1) = do_fmean16(s1.VIS_SW64(1), s2.VIS_SW64(1));
+    r.VIS_SW64(2) = do_fmean16(s1.VIS_SW64(2), s2.VIS_SW64(2));
+    r.VIS_SW64(3) = do_fmean16(s1.VIS_SW64(3), s2.VIS_SW64(3));
+
+    return r.ll;
+}
diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 51a7fb62fb..bc5640aa5f 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -421,6 +421,7 @@ FCMPEq      10 000 cc:2 110101 .....  0 0101 0111 .....    \
     PDIST       10 ..... 110110 ..... 0 0011 1110 .....    \
                 &r_r_r_r rd=%dfp_rd rs1=%dfp_rd rs2=%dfp_rs1 rs3=%dfp_rs2
 
+    FMEAN16     10 ..... 110110 ..... 0 0100 0000 .....    @d_d_d
     FCHKSM16    10 ..... 110110 ..... 0 0100 0100 .....    @d_d_d
     FALIGNDATAg 10 ..... 110110 ..... 0 0100 1000 .....    @d_d_d
     FPMERGE     10 ..... 110110 ..... 0 0100 1011 .....    @d_r_r
-- 
2.34.1


