Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA338CD128D
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 22:33:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqKlP-0002eT-DK; Fri, 29 Mar 2024 18:31:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rqKlC-0002aw-NI
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 18:31:43 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rqKlA-0003YS-DQ
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 18:31:41 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1e0b213efa3so21816085ad.0
 for <qemu-devel@nongnu.org>; Fri, 29 Mar 2024 15:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711751499; x=1712356299; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uX24NXcgU6IiX12Wm/xfyInlmTJOdDVKWFpfbbYjENA=;
 b=OQvZuSeZldBeu0fXHKc0jzrY1CZCImKC7H362h3/nW4fwZXdOB60dfjft2Fwz84/sx
 pPUQH9kuRxV3POaudSdEZsECApdKOBRkFRJoDUKxaq20QuEk3wdU+i+CcDk/0kwn3HT5
 l/K3y28ErVDBkHYCEk2rpEjE7sTy1/pX0RD6RiwamJGRDqNBDqwJ+CXmF6KgqSRUw2Lu
 5oklnatBHCGW88t9zBKRhLwb5LRQ0bAe7DTiXshW8klbsuTeW020OTsa70lYMX+xTUlg
 e5LXPwv72T1h26KXylG8Oss5bYc4uyya9dGzpGzZzJtd6BcTTGlY1B5c6DtjNdIaI/P/
 nwJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711751499; x=1712356299;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uX24NXcgU6IiX12Wm/xfyInlmTJOdDVKWFpfbbYjENA=;
 b=fuyNCAd/UG+KnmVAHlRo2TYqhUpbmARPdbzDB8JxwkW92EwGAMtmtl7S9hzrz5R1ay
 LX2FD/d7/wIvrlYg4pwsMF8KGOGTFZsjlNOtYh/3wsL1WTxh8kLRgXtru0V6DbQ/1zjn
 cmGYIhoTefVrBOflH+uq5v9U02k6dD35b5+M8ZTiG3HTStHfZngUJYkxE1OFBSLtb3mW
 Cx+yXqRD/c55yESTeUnswlh3XtpK4ojiEwhlqO+nESO1/xssTly0p843mz1Kt6cN8qph
 7AMKmGea8ZRe9w0zkJfQoKgKXuZZ9evAi6my+WRoWpyinxBMBLD9P4AfQYyRF6Oq3peP
 /kRQ==
X-Gm-Message-State: AOJu0YxnIvHlj2xiNonkD9D6evnD38+cUDncHnBx93vns6BKyq2d3XZB
 G5W3QhtVk2FOmKcKkUEsbx+JMCr1fLDD14FxNoR6bKHVmoOXpfXZEo/ow8tOGp9KSOtOw15YnhV
 7
X-Google-Smtp-Source: AGHT+IFIaEFtTKTy5ZwLtF0iKJhwCoFiYYugC5+haZecyj+LzGPxPkvBDJDcqpo6UkyPNDwojcXH0w==
X-Received: by 2002:a17:902:d508:b0:1e0:cdbf:24c2 with SMTP id
 b8-20020a170902d50800b001e0cdbf24c2mr4464153plg.29.1711751499093; 
 Fri, 29 Mar 2024 15:31:39 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 f8-20020a170902684800b001e09b636cafsm4000955pln.287.2024.03.29.15.31.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Mar 2024 15:31:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@kernel.org>,
	Helge Deller <deller@gmx.de>
Subject: [PULL 17/18] target/hppa: Add diag instructions to set/restore shadow
 registers
Date: Fri, 29 Mar 2024 12:31:10 -1000
Message-Id: <20240329223111.1735826-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329223111.1735826-1-richard.henderson@linaro.org>
References: <20240329223111.1735826-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

From: Helge Deller <deller@kernel.org>

The 32-bit PA-7300LC (PCX-L2) CPU and the 64-bit PA8700 (PCX-W2) CPU
use different diag instructions to save or restore the CPU registers
to/from the shadow registers.

Implement those per-CPU architecture diag instructions to fix those
parts of the HP ODE testcases (L2DIAG and WDIAG, section 1) which test
the shadow registers.

Signed-off-by: Helge Deller <deller@gmx.de>
[rth: Use decodetree to distinguish cases]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Helge Deller <deller@gmx.de>
Tested-by: Helge Deller <deller@gmx.de>
---
 target/hppa/insns.decode | 10 ++++++++++
 target/hppa/translate.c  | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index 9f6ffd8e2c..71074a64c1 100644
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
+    # For 32-bit PA-7300LC (PCX-L2)
+    diag_getshadowregs_pa1  000101 00 0000 0000 0001 1010 0000 0000
+    diag_putshadowregs_pa1  000101 00 0000 0000 0001 1010 0100 0000
+
+    # For 64-bit PA8700 (PCX-W2)
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


