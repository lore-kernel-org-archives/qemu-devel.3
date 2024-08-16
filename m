Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04A7FC531DE
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 07:24:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1serJB-0007d4-A9; Fri, 16 Aug 2024 03:23:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1serJ9-0007XG-QX
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 03:23:35 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1serJ7-00044i-QV
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 03:23:35 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-20202df1c2fso5491355ad.1
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 00:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723793012; x=1724397812; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eY2K2/64+QKeWeBSKyuHFBnKeWv7V3FsHg7jq9ZTy0Y=;
 b=htwc9HDy9A5i1b3ySgrLTt1bDGsUOaAmdgPBG0/do1ATFHrmTXxwJhbsUOJxcUkgks
 2bvnHhCOx+8wf93ftYdnWZE+xkGt+P02M726jFFdMD98p+Da0D+dL/TONOLivyTj53Dl
 G9GHCDsX/jqSIKOunuW4V5eKkD19eq/pcLvq/nYGqVS/iEPosbQpCzt/HxNus/O/AYHc
 U1xB160psscd2/9S+CH9tyc5Rw//1fRVh/W5gBiKLl5CmyDURmlcovbAK9mbZ6njKvGF
 qfZ7c85gkwpCXq8Yo5C8gbvb4QiQpINAFKAhI0Azx1+gQqDm6hfgG1Mz1/Ja0x3T9+Ag
 CXvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723793012; x=1724397812;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eY2K2/64+QKeWeBSKyuHFBnKeWv7V3FsHg7jq9ZTy0Y=;
 b=aEkRVIHTCkMDgEzCqjPHup06gaMx9rrFRQwWoOt4hFd+u0MeQNLiIciwoUjM2Yk6IF
 2vW1vcruTaRgzgyIj542BgNrZWzwRI1Y97cP3krbYs6SxJ6gxvJEE9SLAw8VnrBCUqrm
 ISQb1O/cC4huvW70urRW3iAnx1VmF5Zt1dCT1V6/PvDT9MWclEgf4mikGoy/wJFD5T2y
 MCmKUbHyzga3gRoCJ/yvRVb7pV+MzFBdB735+sJnMzcqgnUhTIlqOudeWpmLmBrQwIzt
 a+IsswkJirRwo4v9lIX+YleOyYbiynBEgL7gHrzQG+Qm/m8PvWFcam7J5Ee+UWlWNrZI
 Yd9g==
X-Gm-Message-State: AOJu0Yyxe1p5PqoDUhqxZZI0Mm+yuNgLW3Gw4erF+Xbqj/c1PEvflOBg
 sgKiQPjneV0b3sP1Sq6C0Ljzj4/sK1zOqz8kJ5JE/SEMZYnJ0B/uLBk6H9eZfUcJWh+TFST/mzZ
 /S2I=
X-Google-Smtp-Source: AGHT+IETvN1H6mgHjSKA+hzSjemJzQx9Q9EdAwQuyAtKy/60xf74yVwhro81lq6qRMuY8/6RW0s+fg==
X-Received: by 2002:a17:903:3607:b0:1fb:9cbf:b4e3 with SMTP id
 d9443c01a7336-2020625cdf1mr30627165ad.22.1723793011911; 
 Fri, 16 Aug 2024 00:23:31 -0700 (PDT)
Received: from stoup.. (2403-580a-f89b-0-1b6b-8c7b-90f9-144f.ip6.aussiebb.net.
 [2403:580a:f89b:0:1b6b:8c7b:90f9:144f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201f037588esm20195525ad.171.2024.08.16.00.23.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 00:23:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: chauser@pullman.com
Subject: [PATCH v3 6/6] target/sparc: Add gen_trap_if_nofpu_fpexception
Date: Fri, 16 Aug 2024 17:23:11 +1000
Message-ID: <20240816072311.353234-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240816072311.353234-1-richard.henderson@linaro.org>
References: <20240816072311.353234-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

Model fp_exception state, in which only fp stores are allowed
until such time as the FQ has been flushed.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 90 +++++++++++++++++++++++++++-------------
 1 file changed, 61 insertions(+), 29 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 6d4c0e79c9..46eb27c497 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1465,15 +1465,48 @@ static void gen_op_fpexception_im(DisasContext *dc, int ftt)
     gen_exception(dc, TT_FP_EXCP);
 }
 
-static int gen_trap_ifnofpu(DisasContext *dc)
+static bool gen_trap_ifnofpu(DisasContext *dc)
 {
 #if !defined(CONFIG_USER_ONLY)
     if (!dc->fpu_enabled) {
         gen_exception(dc, TT_NFPU_INSN);
-        return 1;
+        return true;
     }
 #endif
-    return 0;
+    return false;
+}
+
+static bool gen_trap_iffpexception(DisasContext *dc)
+{
+#if !defined(TARGET_SPARC64) && !defined(CONFIG_USER_ONLY)
+    /*
+     * There are 3 states for the sparc32 fpu:
+     * Normally the fpu is in fp_execute, and all insns are allowed.
+     * When an exception is signaled, it moves to fp_exception_pending state.
+     * Upon seeing the next FPop, the fpu moves to fp_exception state,
+     * populates the FQ, and generates an fp_exception trap.
+     * The fpu remains in fp_exception state until FQ becomes empty
+     * after execution of a STDFQ instruction.  While the fpu is in
+     * fp_exception state, and FPop, fp load or fp branch insn will
+     * return to fp_exception_pending state, set FSR.FTT to sequence_error,
+     * and the insn will not be entered into the FQ.
+     *
+     * In QEMU, we do not model the fp_exception_pending state and
+     * instead populate FQ and raise the exception immediately.
+     * But we can still honor fp_exception state by noticing when
+     * the FQ is not empty.
+     */
+    if (dc->fsr_qne) {
+        gen_op_fpexception_im(dc, FSR_FTT_SEQ_ERROR);
+        return true;
+    }
+#endif
+    return false;
+}
+
+static bool gen_trap_if_nofpu_fpexception(DisasContext *dc)
+{
+    return gen_trap_ifnofpu(dc) || gen_trap_iffpexception(dc);
 }
 
 /* asi moves */
@@ -2643,7 +2676,7 @@ static bool do_fbpfcc(DisasContext *dc, arg_bcc *a)
 {
     DisasCompare cmp;
 
-    if (gen_trap_ifnofpu(dc)) {
+    if (gen_trap_if_nofpu_fpexception(dc)) {
         return true;
     }
     gen_fcompare(&cmp, a->cc, a->cond);
@@ -4482,7 +4515,7 @@ static bool do_ld_fpr(DisasContext *dc, arg_r_r_ri_asi *a, MemOp sz)
     if (addr == NULL) {
         return false;
     }
-    if (gen_trap_ifnofpu(dc)) {
+    if (gen_trap_if_nofpu_fpexception(dc)) {
         return true;
     }
     if (sz == MO_128 && gen_trap_float128(dc)) {
@@ -4510,6 +4543,7 @@ static bool do_st_fpr(DisasContext *dc, arg_r_r_ri_asi *a, MemOp sz)
     if (addr == NULL) {
         return false;
     }
+    /* Store insns are ok in fp_exception_pending state. */
     if (gen_trap_ifnofpu(dc)) {
         return true;
     }
@@ -4574,7 +4608,7 @@ static bool trans_LDFSR(DisasContext *dc, arg_r_r_ri *a)
     if (addr == NULL) {
         return false;
     }
-    if (gen_trap_ifnofpu(dc)) {
+    if (gen_trap_if_nofpu_fpexception(dc)) {
         return true;
     }
 
@@ -4598,7 +4632,7 @@ static bool do_ldxfsr(DisasContext *dc, arg_r_r_ri *a, bool entire)
     if (addr == NULL) {
         return false;
     }
-    if (gen_trap_ifnofpu(dc)) {
+    if (gen_trap_if_nofpu_fpexception(dc)) {
         return true;
     }
 
@@ -4635,6 +4669,7 @@ static bool do_stfsr(DisasContext *dc, arg_r_r_ri *a, MemOp mop)
     if (addr == NULL) {
         return false;
     }
+    /* Store insns are ok in fp_exception_pending state. */
     if (gen_trap_ifnofpu(dc)) {
         return true;
     }
@@ -4677,7 +4712,7 @@ static bool do_ff(DisasContext *dc, arg_r_r *a,
 {
     TCGv_i32 tmp;
 
-    if (gen_trap_ifnofpu(dc)) {
+    if (gen_trap_if_nofpu_fpexception(dc)) {
         return true;
     }
 
@@ -4718,7 +4753,7 @@ static bool do_env_ff(DisasContext *dc, arg_r_r *a,
 {
     TCGv_i32 tmp;
 
-    if (gen_trap_ifnofpu(dc)) {
+    if (gen_trap_if_nofpu_fpexception(dc)) {
         return true;
     }
 
@@ -4738,7 +4773,7 @@ static bool do_env_fd(DisasContext *dc, arg_r_r *a,
     TCGv_i32 dst;
     TCGv_i64 src;
 
-    if (gen_trap_ifnofpu(dc)) {
+    if (gen_trap_if_nofpu_fpexception(dc)) {
         return true;
     }
 
@@ -4758,7 +4793,7 @@ static bool do_dd(DisasContext *dc, arg_r_r *a,
 {
     TCGv_i64 dst, src;
 
-    if (gen_trap_ifnofpu(dc)) {
+    if (gen_trap_if_nofpu_fpexception(dc)) {
         return true;
     }
 
@@ -4780,7 +4815,7 @@ static bool do_env_dd(DisasContext *dc, arg_r_r *a,
 {
     TCGv_i64 dst, src;
 
-    if (gen_trap_ifnofpu(dc)) {
+    if (gen_trap_if_nofpu_fpexception(dc)) {
         return true;
     }
 
@@ -4820,7 +4855,7 @@ static bool do_env_df(DisasContext *dc, arg_r_r *a,
     TCGv_i64 dst;
     TCGv_i32 src;
 
-    if (gen_trap_ifnofpu(dc)) {
+    if (gen_trap_if_nofpu_fpexception(dc)) {
         return true;
     }
 
@@ -4863,7 +4898,7 @@ static bool do_env_qq(DisasContext *dc, arg_r_r *a,
 {
     TCGv_i128 t;
 
-    if (gen_trap_ifnofpu(dc)) {
+    if (gen_trap_if_nofpu_fpexception(dc)) {
         return true;
     }
     if (gen_trap_float128(dc)) {
@@ -4884,7 +4919,7 @@ static bool do_env_fq(DisasContext *dc, arg_r_r *a,
     TCGv_i128 src;
     TCGv_i32 dst;
 
-    if (gen_trap_ifnofpu(dc)) {
+    if (gen_trap_if_nofpu_fpexception(dc)) {
         return true;
     }
     if (gen_trap_float128(dc)) {
@@ -4907,7 +4942,7 @@ static bool do_env_dq(DisasContext *dc, arg_r_r *a,
     TCGv_i128 src;
     TCGv_i64 dst;
 
-    if (gen_trap_ifnofpu(dc)) {
+    if (gen_trap_if_nofpu_fpexception(dc)) {
         return true;
     }
     if (gen_trap_float128(dc)) {
@@ -4930,7 +4965,7 @@ static bool do_env_qf(DisasContext *dc, arg_r_r *a,
     TCGv_i32 src;
     TCGv_i128 dst;
 
-    if (gen_trap_ifnofpu(dc)) {
+    if (gen_trap_if_nofpu_fpexception(dc)) {
         return true;
     }
     if (gen_trap_float128(dc)) {
@@ -4953,10 +4988,7 @@ static bool do_env_qd(DisasContext *dc, arg_r_r *a,
     TCGv_i64 src;
     TCGv_i128 dst;
 
-    if (gen_trap_ifnofpu(dc)) {
-        return true;
-    }
-    if (gen_trap_float128(dc)) {
+    if (gen_trap_if_nofpu_fpexception(dc)) {
         return true;
     }
 
@@ -5013,7 +5045,7 @@ static bool do_env_fff(DisasContext *dc, arg_r_r_r *a,
 {
     TCGv_i32 src1, src2;
 
-    if (gen_trap_ifnofpu(dc)) {
+    if (gen_trap_if_nofpu_fpexception(dc)) {
         return true;
     }
 
@@ -5222,7 +5254,7 @@ static bool do_env_ddd(DisasContext *dc, arg_r_r_r *a,
 {
     TCGv_i64 dst, src1, src2;
 
-    if (gen_trap_ifnofpu(dc)) {
+    if (gen_trap_if_nofpu_fpexception(dc)) {
         return true;
     }
 
@@ -5246,7 +5278,7 @@ static bool trans_FsMULd(DisasContext *dc, arg_r_r_r *a)
     TCGv_i64 dst;
     TCGv_i32 src1, src2;
 
-    if (gen_trap_ifnofpu(dc)) {
+    if (gen_trap_if_nofpu_fpexception(dc)) {
         return true;
     }
     if (!(dc->def->features & CPU_FEATURE_FSMULD)) {
@@ -5355,7 +5387,7 @@ static bool do_env_qqq(DisasContext *dc, arg_r_r_r *a,
 {
     TCGv_i128 src1, src2;
 
-    if (gen_trap_ifnofpu(dc)) {
+    if (gen_trap_if_nofpu_fpexception(dc)) {
         return true;
     }
     if (gen_trap_float128(dc)) {
@@ -5379,7 +5411,7 @@ static bool trans_FdMULq(DisasContext *dc, arg_r_r_r *a)
     TCGv_i64 src1, src2;
     TCGv_i128 dst;
 
-    if (gen_trap_ifnofpu(dc)) {
+    if (gen_trap_if_nofpu_fpexception(dc)) {
         return true;
     }
     if (gen_trap_float128(dc)) {
@@ -5469,7 +5501,7 @@ static bool do_fcmps(DisasContext *dc, arg_FCMPs *a, bool e)
     if (avail_32(dc) && a->cc != 0) {
         return false;
     }
-    if (gen_trap_ifnofpu(dc)) {
+    if (gen_trap_if_nofpu_fpexception(dc)) {
         return true;
     }
 
@@ -5493,7 +5525,7 @@ static bool do_fcmpd(DisasContext *dc, arg_FCMPd *a, bool e)
     if (avail_32(dc) && a->cc != 0) {
         return false;
     }
-    if (gen_trap_ifnofpu(dc)) {
+    if (gen_trap_if_nofpu_fpexception(dc)) {
         return true;
     }
 
@@ -5517,7 +5549,7 @@ static bool do_fcmpq(DisasContext *dc, arg_FCMPq *a, bool e)
     if (avail_32(dc) && a->cc != 0) {
         return false;
     }
-    if (gen_trap_ifnofpu(dc)) {
+    if (gen_trap_if_nofpu_fpexception(dc)) {
         return true;
     }
     if (gen_trap_float128(dc)) {
-- 
2.43.0


