Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87DEBC25B75
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 00:51:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBOZY-0007Rp-PX; Sun, 26 May 2024 20:50:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBOZO-0007IA-8i
 for qemu-devel@nongnu.org; Sun, 26 May 2024 20:50:34 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBOZK-0003ii-2J
 for qemu-devel@nongnu.org; Sun, 26 May 2024 20:50:33 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6f966840af7so2064456b3a.2
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 17:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716771024; x=1717375824; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aa3AsEcYakMh3o0hu9O0oS/cWYuG+cYxYdDSiNcDG9s=;
 b=vjD3bJrI/rCK8JCyEEO4eah0+kA+lcCI+PPMKKTk/BQMCV/Kc2x+b5DJmdpo3d8KMQ
 1vYDMKrpwTl8hLGaJgWRztpSMtyJINFfYJB13qqdMQQAnPPgWJMhsY1P4+t3tFgkRtMo
 2DAMAyIG4PWRt9c39t/XX7tNRaEwM265PgnKgbLVvYZba+f88rPW/pAOTo7s6qM43w0N
 bj5pugj7iQX74Prf8wqOrEJnoqO+TdZoPlTrIkZXilI8smcJiw/CwqZbul4TBh4Iv9RU
 1bUdLjoc2SYgpXBrJXK37/U8IZiHGZSyGZEoYidHKcKEZIk5slrf2XOTB0aKucNJHd5K
 7xQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716771024; x=1717375824;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aa3AsEcYakMh3o0hu9O0oS/cWYuG+cYxYdDSiNcDG9s=;
 b=U07NxsE1K5lpYWWE9CFH1oW9rLiMhvfmmGlsislvwpnLHBR5pI9zwmS3xhf70rDwvG
 ijdUegcCvY6ID/C1k8taPmnRb/krBTzuXuW/p8/eWX6lY5HaJ0H4oYtyUOmJflZ/pdd4
 tx29ZEVfDub5Imktp/xKBccf5J8IavwyBjRJTRXjk27oNwS12jfPVask/AmhS/fBlf7c
 LalMZiGnIGazomI8jnjPTtRKOa6Jwv/W/sQcrKMlYYFGEb2AV2jGwHHmIxwZWW1tGesR
 FesYLCHSqf3l81xwbcwfl14UvyDTxQvEy+evj3gSElnZPYKqaBWMBrld2DkPIS2HDXw6
 nEvw==
X-Gm-Message-State: AOJu0YwaZjJDKwvcmJliucIJ8hHMugI+HqyqOe/pWWvuiARqglpRkbj3
 ANCl8lhYfTQKYEHTFqporTje9J/rzgsYt3PWos3gZDBJU2GlLg5QoQe0pBxbgwDOQa8+Z6Xlu95
 d
X-Google-Smtp-Source: AGHT+IG/QTsbNniHHz8qpAY0e60uGdOv8owZPW+6m7GEGVtlZgYGzsZJ2bXyhQfssKKV/33gI5zJ3g==
X-Received: by 2002:a05:6a00:e0c:b0:6ed:caf6:6e54 with SMTP id
 d2e1a72fcca58-6f8f42bd52amr7461438b3a.28.1716771024676; 
 Sun, 26 May 2024 17:50:24 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fd6d7598sm3942958b3a.220.2024.05.26.17.50.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 17:50:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 27/28] target/i386: Pass host pointer and size to
 cpu_x86_{fxsave, fxrstor}
Date: Sun, 26 May 2024 17:50:00 -0700
Message-Id: <20240527005001.642825-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527005001.642825-1-richard.henderson@linaro.org>
References: <20240527005001.642825-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

We have already validated the memory region in the course of
validating the signal frame.  No need to do it again within
the helper function.

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/cpu.h            |  4 ++--
 linux-user/i386/signal.c     | 13 +++++--------
 target/i386/tcg/fpu_helper.c | 26 ++++++++++++++++----------
 3 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index f6020e0b6b..257cd5a617 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2273,8 +2273,8 @@ int cpu_x86_get_descr_debug(CPUX86State *env, unsigned int selector,
 void cpu_x86_load_seg(CPUX86State *s, X86Seg seg_reg, int selector);
 void cpu_x86_fsave(CPUX86State *s, void *host, size_t len);
 void cpu_x86_frstor(CPUX86State *s, void *host, size_t len);
-void cpu_x86_fxsave(CPUX86State *s, target_ulong ptr);
-void cpu_x86_fxrstor(CPUX86State *s, target_ulong ptr);
+void cpu_x86_fxsave(CPUX86State *s, void *host, size_t len);
+void cpu_x86_fxrstor(CPUX86State *s, void *host, size_t len);
 void cpu_x86_xsave(CPUX86State *s, target_ulong ptr, uint64_t rbfm);
 void cpu_x86_xrstor(CPUX86State *s, target_ulong ptr, uint64_t rbfm);
 
diff --git a/linux-user/i386/signal.c b/linux-user/i386/signal.c
index dfbb811b56..2e2972002b 100644
--- a/linux-user/i386/signal.c
+++ b/linux-user/i386/signal.c
@@ -294,14 +294,11 @@ static abi_ptr get_sigframe(struct target_sigaction *ka, CPUX86State *env,
  * Set up a signal frame.
  */
 
-static void fxsave_sigcontext(CPUX86State *env, X86LegacyXSaveArea *fxstate,
-                              abi_ptr fxstate_addr)
+static void fxsave_sigcontext(CPUX86State *env, X86LegacyXSaveArea *fxstate)
 {
     struct target_fpx_sw_bytes *sw = (void *)&fxstate->sw_reserved;
 
-    /* fxstate_addr must be 16 byte aligned for fxsave */
-    assert(!(fxstate_addr & 0xf));
-    cpu_x86_fxsave(env, fxstate_addr);
+    cpu_x86_fxsave(env, fxstate, sizeof(*fxstate));
     __put_user(0, &sw->magic1);
 }
 
@@ -412,7 +409,7 @@ static void setup_sigcontext(CPUX86State *env,
         xsave_sigcontext(env, fxstate, fpstate_addr, fxstate_addr, fpend_addr);
         break;
     case FPSTATE_FXSAVE:
-        fxsave_sigcontext(env, fxstate, fxstate_addr);
+        fxsave_sigcontext(env, fxstate);
         break;
     default:
         break;
@@ -669,7 +666,7 @@ static bool xrstor_sigcontext(CPUX86State *env, FPStateKind fpkind,
         break;
     }
 
-    cpu_x86_fxrstor(env, fxstate_addr);
+    cpu_x86_fxrstor(env, fxstate, sizeof(*fxstate));
     return true;
 }
 
@@ -687,7 +684,7 @@ static bool frstor_sigcontext(CPUX86State *env, FPStateKind fpkind,
         }
         break;
     case FPSTATE_FXSAVE:
-        cpu_x86_fxrstor(env, fxstate_addr);
+        cpu_x86_fxrstor(env, fxstate, sizeof(*fxstate));
         break;
     case FPSTATE_FSAVE:
         break;
diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index 05db16a152..0e5368951f 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -3041,22 +3041,28 @@ void cpu_x86_frstor(CPUX86State *env, void *host, size_t len)
     do_frstor(&ac, 0, true);
 }
 
-void cpu_x86_fxsave(CPUX86State *env, target_ulong ptr)
+void cpu_x86_fxsave(CPUX86State *env, void *host, size_t len)
 {
-    X86Access ac;
+    X86Access ac = {
+        .haddr1 = host,
+        .size = sizeof(X86LegacyXSaveArea),
+        .env = env,
+    };
 
-    access_prepare(&ac, env, ptr, sizeof(X86LegacyXSaveArea),
-                   MMU_DATA_STORE, 0);
-    do_fxsave(&ac, ptr);
+    assert(ac.size <= len);
+    do_fxsave(&ac, 0);
 }
 
-void cpu_x86_fxrstor(CPUX86State *env, target_ulong ptr)
+void cpu_x86_fxrstor(CPUX86State *env, void *host, size_t len)
 {
-    X86Access ac;
+    X86Access ac = {
+        .haddr1 = host,
+        .size = sizeof(X86LegacyXSaveArea),
+        .env = env,
+    };
 
-    access_prepare(&ac, env, ptr, sizeof(X86LegacyXSaveArea),
-                   MMU_DATA_LOAD, 0);
-    do_fxrstor(&ac, ptr);
+    assert(ac.size <= len);
+    do_fxrstor(&ac, 0);
 }
 
 void cpu_x86_xsave(CPUX86State *env, target_ulong ptr, uint64_t rfbm)
-- 
2.34.1


