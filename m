Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEE56C67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 05:07:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru3e4-0003Gp-00; Tue, 09 Apr 2024 01:03:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ru3e2-0003GN-9c
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 01:03:42 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ru3e0-0005PO-JY
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 01:03:42 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-5d4d15ec7c5so4163695a12.1
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 22:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712639019; x=1713243819; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=i+D5XYE0Hfp+YN9LtsSBmGwI6H0rpmZNTNUQOtDcToo=;
 b=CdL4K8S7qB8v+vrvnhQfsVfXUgOvKzQWH/wo0qHHWJFR1ivm8iGKf3AtkfW86ogK4s
 WGz2BSZZKcZrCe2Gs6/x4n4Mt8XG3uO8Bwh+zKE2Puy9qEpG/Cyqgce6X1tpmDj5WJVY
 8KUEm4uEm+i5wPsMTgyFtu4n2zg08PFmokcaKUS8KGEIYQBQ+yRraGNhodPXxWXSo+Hs
 3ksOV3e5mPYL/5+l6ilcH+r40dulAErbYgiGqd1BvxJTRG11y5d85Sdu6wqUZxSZXo4y
 1A+ym9N7cXQJzT3+tYIhveGLYiPIU+OmEwYthC779ODmbzSzM285LNvXD3R/7S9TMnl+
 XaXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712639019; x=1713243819;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i+D5XYE0Hfp+YN9LtsSBmGwI6H0rpmZNTNUQOtDcToo=;
 b=qlZxifQRdXV4RCGNBJIeb1nH7m93VNoWDXSfrgI0wV+nq34ay/GvQcDQtXriN2iJAg
 jdZ1EEIuGk1ClvhHO4eeygQUNaw09usNLr3ZwHGm9QIxti7Jx73KVXfPle3dYyyOJaFf
 tOOZ4Oqu27/Iw77nzj8PqHxtDaQb1mdJWzeqU02sYihmXD+oIPHN64vw51bjwp4tnKy9
 cNcsmkjKqsKkY6C7frqx/D4KE7iFSKkTZkRn6uf5FY6yBdwu5zUYUf5irWmtePZV2J3/
 mHL5NF0TBtN5vxGzj4Y3vTdZb9RuiYYRjYPQRbEP+Efc6orc05RHKKVzAsFtwuQd+E1U
 Qy6Q==
X-Gm-Message-State: AOJu0Yz3khecEXFht7A/WLZuZeOtfoDnSBad/lHhJ2feYi+gAIh1R2i3
 Aq1WO1xVyW03kjOO+EU0Yn1+TCG+1A3uiAsqrvk8H44V9TqM+1GdmrygEKrTom2Qszh/AdgmbyJ
 4
X-Google-Smtp-Source: AGHT+IF9KrhKygMkKkgoEw8iPSbFDFS8JhzVtDMmuvUc0FhweNYlI0PMvob880ZCeodFpca4l/Vd7A==
X-Received: by 2002:a05:6a20:e614:b0:1a3:50b7:7b5b with SMTP id
 my20-20020a056a20e61400b001a350b77b5bmr13865608pzb.60.1712639019156; 
 Mon, 08 Apr 2024 22:03:39 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 z26-20020aa785da000000b006e64ddfa71asm7654894pfn.170.2024.04.08.22.03.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 22:03:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 27/28] target/i386: Pass host pointer and size to
 cpu_x86_{fxsave, fxrstor}
Date: Mon,  8 Apr 2024 19:03:01 -1000
Message-Id: <20240409050302.1523277-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240409050302.1523277-1-richard.henderson@linaro.org>
References: <20240409050302.1523277-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
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

We have already validated the memory region in the course of
validating the signal frame.  No need to do it again within
the helper function.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/cpu.h            |  4 ++--
 linux-user/i386/signal.c     | 13 +++++--------
 target/i386/tcg/fpu_helper.c | 26 ++++++++++++++++----------
 3 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 8eb97fdd7a..35a8bf831f 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2234,8 +2234,8 @@ int cpu_x86_get_descr_debug(CPUX86State *env, unsigned int selector,
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
index 7178440d67..b823dee17f 100644
--- a/linux-user/i386/signal.c
+++ b/linux-user/i386/signal.c
@@ -293,14 +293,11 @@ static abi_ptr get_sigframe(struct target_sigaction *ka, CPUX86State *env,
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
 
@@ -411,7 +408,7 @@ static void setup_sigcontext(CPUX86State *env,
         xsave_sigcontext(env, fxstate, fpstate_addr, fxstate_addr, fpend_addr);
         break;
     case FPSTATE_FXSAVE:
-        fxsave_sigcontext(env, fxstate, fxstate_addr);
+        fxsave_sigcontext(env, fxstate);
         break;
     default:
         break;
@@ -668,7 +665,7 @@ static bool xrstor_sigcontext(CPUX86State *env, FPStateKind fpkind,
         break;
     }
 
-    cpu_x86_fxrstor(env, fxstate_addr);
+    cpu_x86_fxrstor(env, fxstate, sizeof(*fxstate));
     return true;
 }
 
@@ -686,7 +683,7 @@ static bool frstor_sigcontext(CPUX86State *env, FPStateKind fpkind,
         }
         break;
     case FPSTATE_FXSAVE:
-        cpu_x86_fxrstor(env, fxstate_addr);
+        cpu_x86_fxrstor(env, fxstate, sizeof(*fxstate));
         break;
     case FPSTATE_FSAVE:
         break;
diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index 0a91757690..1c2121c559 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -3040,22 +3040,28 @@ void cpu_x86_frstor(CPUX86State *env, void *host, size_t len)
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


