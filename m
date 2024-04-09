Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF060C67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 05:07:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru3dr-0003CX-Kr; Tue, 09 Apr 2024 01:03:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ru3dq-0003CN-EE
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 01:03:30 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ru3do-0005KD-O9
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 01:03:30 -0400
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3c5efef980cso303318b6e.2
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 22:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712639007; x=1713243807; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lfYCgXuXxRvNB6GamBg7nUp4jaKTlVTiooGSAkryLH8=;
 b=lqnqz0UeH9XnkiLJWsRywouGizM1Ym/QZ7H+plEk6CsH0WiUNyE+g7gWpBAwJ6fuDY
 Uzd7Z+FS4VBvlfAlYV28btvDulNRl3ELaFsirkMI1+b2Y35xCYSzLgFwV72b66rKsniR
 xGlR/TLjzH/Gq6Q2l8cuJo3JrvOyrE9rflLU9wP38pOPDgwblt87/3bMxrB7hsKgEWlP
 T0qxG2m1zzEfMVzr8LD3TI+67mypJNs63Z8D/kouzveeJCDKhendENjpjTbRkKytiXmO
 1B4b0QFiQ01AHrFUoqFuZ+ZfMmmbGe1+IiEa870884kaQ2JaIabf/RYxFZ0fc2gnfyNE
 LbYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712639007; x=1713243807;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lfYCgXuXxRvNB6GamBg7nUp4jaKTlVTiooGSAkryLH8=;
 b=fzlCmujbWB9gOsGCKmzSbOzC8zJzdHtvGT4OMbuhyQzG+FbUf0HehYHFtqQT6bQF9h
 v/9PPmKOKKTSWrv1VHIWjw+yK7qqxxci2Hqo/UbRGcVUrRrGJ9dNYMJwxTFQg6wK7ezp
 z0Ddwy4RKU8ZRkv7s+jIysZ0raSugFweImxbRKJu1gOIk2f53gyDNRLCwEqqJIriur5m
 X487ZVzTynq4Dp3XARW35WsVQt45BPXG8dCajrHgMIXy88HFCmfCUDdH7sfWji0huVNn
 eR1MtIQHCFwLYs+N5IJA/4yvOsaJ//+hjY7kRp02jMi/8Vc0p1+zWpRMraTmo8042J2K
 0B0w==
X-Gm-Message-State: AOJu0YxdfQeJI2HCxu7JjH2/eAobi7fToVln4Dimb90LjjDD3f6TmvVy
 cu40SW+61MUWFdoYWbsK82vZegH85rDyZHBSYe+lofF42irc9VdFbvTyZy/oVGir6bHsMiIIHdE
 L
X-Google-Smtp-Source: AGHT+IGzTEB+sJnh4UeHa/tFlbut/7yUK7by8JNX2uyzRJHYnPcyOxuSQpnolqCBorkpNKW+Th59xA==
X-Received: by 2002:aca:110d:0:b0:3c6:3bc:a686 with SMTP id
 13-20020aca110d000000b003c603bca686mr24979oir.17.1712639007568; 
 Mon, 08 Apr 2024 22:03:27 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 z26-20020aa785da000000b006e64ddfa71asm7654894pfn.170.2024.04.08.22.03.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 22:03:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 18/28] linux-user/i386: Split out struct target_fregs_state
Date: Mon,  8 Apr 2024 19:02:52 -1000
Message-Id: <20240409050302.1523277-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240409050302.1523277-1-richard.henderson@linaro.org>
References: <20240409050302.1523277-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22f.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/i386/signal.c | 43 +++++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 18 deletions(-)

diff --git a/linux-user/i386/signal.c b/linux-user/i386/signal.c
index ed98b4d073..559b63c25b 100644
--- a/linux-user/i386/signal.c
+++ b/linux-user/i386/signal.c
@@ -33,6 +33,23 @@ struct target_fpreg {
     uint16_t exponent;
 };
 
+/* Legacy x87 fpu state format for FSAVE/FRESTOR. */
+struct target_fregs_state {
+    uint32_t cwd;
+    uint32_t swd;
+    uint32_t twd;
+    uint32_t fip;
+    uint32_t fcs;
+    uint32_t foo;
+    uint32_t fos;
+    struct target_fpreg st[8];
+
+    /* Software status information [not touched by FSAVE]. */
+    uint16_t status;
+    uint16_t magic;   /* 0xffff: FPU data only, 0x0000: FXSR FPU data */
+};
+QEMU_BUILD_BUG_ON(sizeof(struct target_fregs_state) != 32 + 80);
+
 struct target_fpx_sw_bytes {
     uint32_t magic1;
     uint32_t extended_size;
@@ -43,29 +60,19 @@ struct target_fpx_sw_bytes {
 QEMU_BUILD_BUG_ON(sizeof(struct target_fpx_sw_bytes) != 12*4);
 
 struct target_fpstate_32 {
-    /* Regular FPU environment */
-    uint32_t cw;
-    uint32_t sw;
-    uint32_t tag;
-    uint32_t ipoff;
-    uint32_t cssel;
-    uint32_t dataoff;
-    uint32_t datasel;
-    struct target_fpreg st[8];
-    uint16_t  status;
-    uint16_t  magic;          /* 0xffff = regular FPU data only */
-    X86LegacyXSaveArea fxsave;
+    struct target_fregs_state fpstate;
+    X86LegacyXSaveArea fxstate;
 };
 
 /*
  * For simplicity, setup_frame aligns struct target_fpstate_32 to
  * 16 bytes, so ensure that the FXSAVE area is also aligned.
  */
-QEMU_BUILD_BUG_ON(offsetof(struct target_fpstate_32, fxsave) & 15);
+QEMU_BUILD_BUG_ON(offsetof(struct target_fpstate_32, fxstate) & 15);
 
 #ifndef TARGET_X86_64
 # define target_fpstate target_fpstate_32
-# define TARGET_FPSTATE_FXSAVE_OFFSET offsetof(struct target_fpstate_32, fxsave)
+# define TARGET_FPSTATE_FXSAVE_OFFSET offsetof(struct target_fpstate_32, fxstate)
 #else
 # define target_fpstate X86LegacyXSaveArea
 # define TARGET_FPSTATE_FXSAVE_OFFSET 0
@@ -278,15 +285,15 @@ static void setup_sigcontext(struct target_sigcontext *sc,
     __put_user(env->segs[R_SS].selector, (unsigned int *)&sc->ss);
 
     cpu_x86_fsave(env, fpstate_addr, 1);
-    fpstate->status = fpstate->sw;
+    fpstate->fpstate.status = fpstate->fpstate.swd;
     if (!(env->features[FEAT_1_EDX] & CPUID_FXSR)) {
         magic = 0xffff;
     } else {
-        xsave_sigcontext(env, &fpstate->fxsave,
+        xsave_sigcontext(env, &fpstate->fxstate,
                          fpstate_addr + TARGET_FPSTATE_FXSAVE_OFFSET);
         magic = 0;
     }
-    __put_user(magic, &fpstate->magic);
+    __put_user(magic, &fpstate->fpstate.magic);
 #else
     __put_user(env->regs[R_EDI], &sc->rdi);
     __put_user(env->regs[R_ESI], &sc->rsi);
@@ -622,7 +629,7 @@ restore_sigcontext(CPUX86State *env, struct target_sigcontext *sc)
             cpu_x86_frstor(env, fpstate_addr, 1);
             err = 0;
         } else {
-            err = xrstor_sigcontext(env, &fpstate->fxsave,
+            err = xrstor_sigcontext(env, &fpstate->fxstate,
                                     fpstate_addr + TARGET_FPSTATE_FXSAVE_OFFSET);
         }
 #else
-- 
2.34.1


