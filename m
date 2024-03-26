Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5E88C6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 18:13:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpBI0-0003M4-J3; Tue, 26 Mar 2024 14:12:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rpBHz-0003Le-AH
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 14:12:47 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rpBHx-0006aD-LF
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 14:12:47 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6ea8ee55812so3467864b3a.0
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 11:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711476764; x=1712081564; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m1ZbZybHY9lhm5Q1WYSajtVJ/Bd2oVTk+eDSnSXGvRY=;
 b=htfheGND1eg1pQLsSoZQksdkx7rhBcmUHfQiKdZeRJ9a+VRQ4+8l5mKd9ji8mbum14
 5TvdlQYA3zxMXF7XJNKr9EGrF5lZBqmTRhtQITTkpWRektwdXKxNZ92JMA8gNvlPs+4V
 lU6b9nR5vjTtC/IP0lHdPSGWtjbuzukzQ0/G75ZzScUdWls+uAnh3+ZwcyETFnHcmJkh
 UtFxMaMFiqI+AcH1/77/yF3xDquGqweJIsYd2BYyRGxNzxuFZvAqplYd+PCvmNSdOH3U
 RAToDlwm0d1GUq6dzGvJXzSQIxcnCS/Ro59PI2j0sl2ohuMl4hjb066qNb2v41zz/HXF
 ++qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711476764; x=1712081564;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m1ZbZybHY9lhm5Q1WYSajtVJ/Bd2oVTk+eDSnSXGvRY=;
 b=Gc44jYbSQ5PZJnGCvW9BcXddU8MyXeN5axccay5eTSI9iMeA1Jn5L/DejtKDFXaREJ
 8UAVLJ9Hw3Zd7ErPSGro/xmkNjmm3WAWS1G/hlDRTq2fbP+CQJ9Z8tBW1yyhAe5rrMr8
 6F0L+1Ey/zWsB0LSvEf2RD9ngmMQ07eGiRiu6+pIzOYZxIq3DJPfbsKo78GTHvfzrjF2
 7jDKxKVpgIALGKeHgWKh6tDwqqAFoGxpfBPOtFq94msPUn5XgrEipzoDRrSdxr1Edgc1
 6YCCojtP7bbSOMiNNDoQCEuabDDl1Yj2z3q8xMc8+iLSVF4LnoXBF7TguFjrwgvIu9C5
 PWug==
X-Gm-Message-State: AOJu0YzmuCh6SWAHWT7l0X1QWOnj+MbPBnHn2Wwup7FQxicxuF/UYmYT
 619VWRerqQXiNxg2Wt4F8sbVp1vC4X3Ie+sdhnMxfrO8AeLsJspCyjQCPCgVy/8vHUTcLs1/7/m
 B
X-Google-Smtp-Source: AGHT+IEbIF77nY62uxWh2qWXSh9g+9J+PxqYXph+csroNX7g0QF/xNNcdG8vys+LXj9HUuw5IPl5uw==
X-Received: by 2002:a05:6a20:244d:b0:1a3:c404:37fc with SMTP id
 t13-20020a056a20244d00b001a3c40437fcmr9107588pzc.13.1711476764404; 
 Tue, 26 Mar 2024 11:12:44 -0700 (PDT)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 q27-20020a63751b000000b005bd980cca56sm7835336pgc.29.2024.03.26.11.12.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Mar 2024 11:12:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@kernel.org,
	Helge Deller <deller@gmx.de>
Subject: [PATCH v2 3/3] target/hppa: Fix diag instructions to set/restore
 shadow registers
Date: Tue, 26 Mar 2024 08:10:28 -1000
Message-Id: <20240326181028.332867-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240326181028.332867-1-richard.henderson@linaro.org>
References: <20240326181028.332867-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The 32-bit 7300LC CPU and the 64-bit PCX-W 8500 CPU use different
diag instructions to save or restore the CPU registers to/from
the shadow registers.

Implement those per-CPU architecture diag instructions to fix those
parts of the HP ODE testcases (L2DIAG and WDIAG, section 1) which test
the shadow registers.

Signed-off-by: Helge Deller <deller@gmx.de>
[rth: Use decodetree to distinguish cases]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/insns.decode | 10 ++++++++++
 target/hppa/translate.c  | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index 9f6ffd8e2c..c2acb3796c 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -65,6 +65,8 @@
 # Argument set definitions
 ####
 
+&empty
+
 # All insns that need to form a virtual address should use this set.
 &ldst           t b x disp sp m scale size
 
@@ -638,6 +640,14 @@ xmpyu           001110 ..... ..... 010 .0111 .00 t:5    r1=%ra64 r2=%rb64
   [
     diag_btlb               000101 00 0000 0000 0000 0001 0000 0000
     diag_cout               000101 00 0000 0000 0000 0001 0000 0001
+
+    # For 32-bit 7300C
+    diag_getshadowregs_pa1  000101 00 0000 0000 0001 1010 0000 0000
+    diag_putshadowregs_pa1  000101 00 0000 0000 0001 1010 0100 0000
+
+    # For 64-bit PCX-W 8500
+    diag_getshadowregs_pa2  000101 00 0111 1000 0001 1000 0100 0000
+    diag_putshadowregs_pa2  000101 00 0111 0000 0001 1000 0100 0000
   ]
   diag_unimp                000101 i:26
 }
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 42dd3f2c8d..143818c2d9 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2399,6 +2399,20 @@ static bool do_getshadowregs(DisasContext *ctx)
     return nullify_end(ctx);
 }
 
+static bool do_putshadowregs(DisasContext *ctx)
+{
+    CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
+    nullify_over(ctx);
+    tcg_gen_st_i64(cpu_gr[1], tcg_env, offsetof(CPUHPPAState, shadow[0]));
+    tcg_gen_st_i64(cpu_gr[8], tcg_env, offsetof(CPUHPPAState, shadow[1]));
+    tcg_gen_st_i64(cpu_gr[9], tcg_env, offsetof(CPUHPPAState, shadow[2]));
+    tcg_gen_st_i64(cpu_gr[16], tcg_env, offsetof(CPUHPPAState, shadow[3]));
+    tcg_gen_st_i64(cpu_gr[17], tcg_env, offsetof(CPUHPPAState, shadow[4]));
+    tcg_gen_st_i64(cpu_gr[24], tcg_env, offsetof(CPUHPPAState, shadow[5]));
+    tcg_gen_st_i64(cpu_gr[25], tcg_env, offsetof(CPUHPPAState, shadow[6]));
+    return nullify_end(ctx);
+}
+
 static bool trans_getshadowregs(DisasContext *ctx, arg_getshadowregs *a)
 {
     return do_getshadowregs(ctx);
@@ -4594,6 +4608,26 @@ static bool trans_diag_cout(DisasContext *ctx, arg_diag_cout *a)
 #endif
 }
 
+static bool trans_diag_getshadowregs_pa1(DisasContext *ctx, arg_empty *a)
+{
+    return !ctx->is_pa20 && do_getshadowregs(ctx);
+}
+
+static bool trans_diag_getshadowregs_pa2(DisasContext *ctx, arg_empty *a)
+{
+    return ctx->is_pa20 && do_getshadowregs(ctx);
+}
+
+static bool trans_diag_putshadowregs_pa1(DisasContext *ctx, arg_empty *a)
+{
+    return !ctx->is_pa20 && do_putshadowregs(ctx);
+}
+
+static bool trans_diag_putshadowregs_pa2(DisasContext *ctx, arg_empty *a)
+{
+    return ctx->is_pa20 && do_putshadowregs(ctx);
+}
+
 static bool trans_diag_unimp(DisasContext *ctx, arg_diag_unimp *a)
 {
     CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
-- 
2.34.1


