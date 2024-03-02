Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FA28C54798
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Mar 2024 05:18:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgHjp-0002W2-7J; Sat, 02 Mar 2024 00:16:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgHjm-0002VM-Rx
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 00:16:42 -0500
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgHjl-0007YY-4Q
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 00:16:42 -0500
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-29a378040daso1962549a91.1
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 21:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709356598; x=1709961398; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jb3S9sAOtWQUrtkfEVb6TzNvEgYDzIjiOKbzwuL1fFg=;
 b=MeF5PULGGmXCDAtcZZyldTxvULj3Y4DMfmb6wTIYwe3ufpPuze3nMXJxAmYttlEps4
 xly2UQBrK/E36RBTMHWDXi5LrhVdA8NmO6pUN2akgy8rGV0Qh4wgDQ1aYq+oDQeSf/0U
 tR1coatDsbglxr8ubPLiJ2xVCblOroOqvnpm7MAWsNRjKE4BWjJlqAo2Lc/K5dchqJAF
 SsBFhhZunrbE8rrAX3L1pktxgMx8UqalFsGV7LzveqAKVeL5w345q5my5bj6iHMFXbsC
 2DbL+H8zPHWNT5GPdcuRI6mJkkiRvGialFAcheViiHk5vtgXDvbQgASe26RTrgVOuE1v
 UUMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709356598; x=1709961398;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jb3S9sAOtWQUrtkfEVb6TzNvEgYDzIjiOKbzwuL1fFg=;
 b=Ycz1RI5STZ2h4UCv1jExFzW19MXQEsQVhe4e0VZiZt+JbQz+UqhYRtniPBN8fA37+6
 dGOf1fYPWoJRiqPrFXdAOSwWH3+8pV3WnIBiNMMpEYSQVsG3wwHY1QHFoAB9Ndg5t6lV
 gN38kE4QeCgdWd18B/Hjl4LpPiJp6j9EFvkum6giFV1SiD3s3rrQQQG+rCg8ypPmTx/B
 Xvyin/IeyX2htzzs/nmDGMtp1WzGoESIahIX571+LtaF1A4UuozgUvG2TkyQ/kVhYxsF
 2hAkEaeHc5Oxvj8fbHrD54TXP6463nXoRNDbVKDx6vdPQVfQYJ/u3SEmWjkKZmcjO6Tw
 W81Q==
X-Gm-Message-State: AOJu0YxsegndpulOSEWSv/7I4fOh2rF2a/jSoJxVBUsZ1gr1SIir//z2
 fbigxIzBycAyq1t+7JDxuIm84g62+oZC9GIbqMF2geIZQdJIoUxEYes7e0EoHdlq00YvioeYBXr
 x
X-Google-Smtp-Source: AGHT+IEjKBy2JmhD6UQP+p8o49SqStbYwrJ7aGM6kHdxEZwtsiUjUPvLcYpU7NUIIdN5NoXKNVbXMg==
X-Received: by 2002:a17:90a:c397:b0:29b:178e:d9cb with SMTP id
 h23-20020a17090ac39700b0029b178ed9cbmr3112000pjt.44.1709356598608; 
 Fri, 01 Mar 2024 21:16:38 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 v8-20020a17090a458800b0029af67d4fd0sm4034901pjg.44.2024.03.01.21.16.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 21:16:38 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 19/41] target/sparc: Implement FLCMP
Date: Fri,  1 Mar 2024 19:15:39 -1000
Message-Id: <20240302051601.53649-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240302051601.53649-1-richard.henderson@linaro.org>
References: <20240302051601.53649-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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
 target/sparc/helper.h     |  2 ++
 target/sparc/fop_helper.c | 46 +++++++++++++++++++++++++++++++++++++++
 target/sparc/translate.c  | 34 +++++++++++++++++++++++++++++
 target/sparc/insns.decode |  4 ++++
 4 files changed, 86 insertions(+)

diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index 926b579e97..97b3c24fb3 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -47,6 +47,8 @@ DEF_HELPER_FLAGS_3(fcmpd, TCG_CALL_NO_WG, i32, env, f64, f64)
 DEF_HELPER_FLAGS_3(fcmped, TCG_CALL_NO_WG, i32, env, f64, f64)
 DEF_HELPER_FLAGS_3(fcmpq, TCG_CALL_NO_WG, i32, env, i128, i128)
 DEF_HELPER_FLAGS_3(fcmpeq, TCG_CALL_NO_WG, i32, env, i128, i128)
+DEF_HELPER_FLAGS_2(flcmps, TCG_CALL_NO_RWG_SE, i32, f32, f32)
+DEF_HELPER_FLAGS_2(flcmpd, TCG_CALL_NO_RWG_SE, i32, f64, f64)
 DEF_HELPER_2(raise_exception, noreturn, env, int)
 
 DEF_HELPER_FLAGS_3(faddd, TCG_CALL_NO_WG, f64, env, f64, f64)
diff --git a/target/sparc/fop_helper.c b/target/sparc/fop_helper.c
index ea9d4ec235..8c07442ad6 100644
--- a/target/sparc/fop_helper.c
+++ b/target/sparc/fop_helper.c
@@ -458,6 +458,52 @@ uint32_t helper_fcmpeq(CPUSPARCState *env, Int128 src1, Int128 src2)
     return finish_fcmp(env, r, GETPC());
 }
 
+uint32_t helper_flcmps(float32 src1, float32 src2)
+{
+    /*
+     * FLCMP never raises an exception nor modifies any FSR fields.
+     * Perform the comparison with a dummy fp environment.
+     */
+    float_status discard = { };
+    FloatRelation r = float32_compare_quiet(src1, src2, &discard);
+
+    switch (r) {
+    case float_relation_equal:
+        if (src2 == float32_zero && src1 != float32_zero) {
+            return 1;  /* -0.0 < +0.0 */
+        }
+        return 0;
+    case float_relation_less:
+        return 1;
+    case float_relation_greater:
+        return 0;
+    case float_relation_unordered:
+        return float32_is_any_nan(src2) ? 3 : 2;
+    }
+    g_assert_not_reached();
+}
+
+uint32_t helper_flcmpd(float64 src1, float64 src2)
+{
+    float_status discard = { };
+    FloatRelation r = float64_compare_quiet(src1, src2, &discard);
+
+    switch (r) {
+    case float_relation_equal:
+        if (src2 == float64_zero && src1 != float64_zero) {
+            return 1;  /* -0.0 < +0.0 */
+        }
+        return 0;
+    case float_relation_less:
+        return 1;
+    case float_relation_greater:
+        return 0;
+    case float_relation_unordered:
+        return float64_is_any_nan(src2) ? 3 : 2;
+    }
+    g_assert_not_reached();
+}
+
 target_ulong cpu_get_fsr(CPUSPARCState *env)
 {
     target_ulong fsr = env->fsr | env->fsr_cexc_ftt;
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index b3714ada6a..6dba0fcca6 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -5199,6 +5199,40 @@ static bool do_fcmpq(DisasContext *dc, arg_FCMPq *a, bool e)
 TRANS(FCMPq, ALL, do_fcmpq, a, false)
 TRANS(FCMPEq, ALL, do_fcmpq, a, true)
 
+static bool trans_FLCMPs(DisasContext *dc, arg_FLCMPs *a)
+{
+    TCGv_i32 src1, src2;
+
+    if (!avail_VIS3(dc)) {
+        return false;
+    }
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+
+    src1 = gen_load_fpr_F(dc, a->rs1);
+    src2 = gen_load_fpr_F(dc, a->rs2);
+    gen_helper_flcmps(cpu_fcc[a->cc], src1, src2);
+    return advance_pc(dc);
+}
+
+static bool trans_FLCMPd(DisasContext *dc, arg_FLCMPd *a)
+{
+    TCGv_i64 src1, src2;
+
+    if (!avail_VIS3(dc)) {
+        return false;
+    }
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+
+    src1 = gen_load_fpr_D(dc, a->rs1);
+    src2 = gen_load_fpr_D(dc, a->rs2);
+    gen_helper_flcmpd(cpu_fcc[a->cc], src1, src2);
+    return advance_pc(dc);
+}
+
 static void sparc_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 8c0df3004d..51a7fb62fb 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -470,6 +470,10 @@ FCMPEq      10 000 cc:2 110101 .....  0 0101 0111 .....    \
     FZEROs      10 rd:5  110110 00000 0 0110 0001 00000
     FONEd       10 ..... 110110 00000 0 0111 1110 00000    rd=%dfp_rd
     FONEs       10 rd:5  110110 00000 0 0111 1111 00000
+
+    FLCMPs      10 000 cc:2 110110 rs1:5 1 0101 0001 rs2:5
+    FLCMPd      10 000 cc:2 110110 ..... 1 0101 0010 ..... \
+                rs1=%dfp_rs1 rs2=%dfp_rs2
   ]
   NCP           10 ----- 110110 ----- --------- -----      # v8 CPop1
 }
-- 
2.34.1


