Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F452C25B78
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 00:52:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBOZb-0007UW-L8; Sun, 26 May 2024 20:50:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBOZJ-0007Cx-Ce
 for qemu-devel@nongnu.org; Sun, 26 May 2024 20:50:30 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBOZA-0003gm-My
 for qemu-devel@nongnu.org; Sun, 26 May 2024 20:50:25 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6f8f34cb0beso1883057b3a.1
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 17:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716771019; x=1717375819; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gXRsFZySXvSqPrOv+ZAPgTOAgNl/fCJyejJjD81KENM=;
 b=eOWZXK176K0uKHlxveEv8uNAnvORbSMoSnhkJ6dJKfsN2h8UA684Fp1iGwlXd8FXpm
 MPKyl5B6AGDS0G5ObwcB5Ym2yoCdaA/buDO41RdWuWZGyL5gFPWpSkMWB3H6pmeYlKw5
 5FwE1E0FHSL8UOa6/eWO4Hx2tk/uqVaGbYwxaXslWzOIMv+8qXMI7VdiTU9BjcorarL/
 4xR0S9Sswy4gvE1/eHi9Rf+Gic8VPJpKc9IxmLmSKEq/2TkXY3vG1AjfhyyZfzX3tuZP
 E+ABbbI/B779nOQO/FLHwJL3N7TWhh5CSomq35PPy0yID9mhLeUO+ULIndjE/cTbz2Bq
 bRhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716771019; x=1717375819;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gXRsFZySXvSqPrOv+ZAPgTOAgNl/fCJyejJjD81KENM=;
 b=Wb8WDqI924+BJXMrNWDULbeQOJKEIOj+PSAGZrvA9H7wploR/PI3qQ+YeGhDPgXF3H
 tum3SaMZLPGlwWYnj1gF3U3MBv5ccfGXEcZfS4R4cjocOjx+qjLRuxfFNZzWr3Ws1J8N
 G9L6YqNg5KjKv2mlrgdA9Jwx9eiUoVhZDzSxq1aX1h+TlfMADDChhJuyLBcH7VFxQIis
 tgAkVxolZGN1DiKrrMS57dI7C51DxwSIEjaazQmr059iUEjfFZT2U4kkRCmYxw2/doIq
 CnjsZnve5sjar4wPDWQFKp5tzu0XVpfhKHLtrEFJ+fmxqMcavq2xjQcrxWcyTuwWok2H
 Tl2Q==
X-Gm-Message-State: AOJu0Yz3/KHC21akUz46gT0M7dS9fl1a5JySLM4hJpTt4wqrXF5BU7u4
 Rvy/JaR4PScuWL6DJzncfIQCyOkb/jqdgiup/5OvIMQJz5lWv5bsc+cPz3ubpF4dy7T3n4q+72E
 1
X-Google-Smtp-Source: AGHT+IHOTCePmeGCrV4hA1L3PAxSyNm/x/SHMgb72ai8+EnpFf8d4+Kbpsfk/hB1JfLZ9txMtXghRg==
X-Received: by 2002:a05:6a00:4603:b0:701:78af:4a72 with SMTP id
 d2e1a72fcca58-70178af5edfmr1219498b3a.0.1716771019202; 
 Sun, 26 May 2024 17:50:19 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fd6d7598sm3942958b3a.220.2024.05.26.17.50.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 17:50:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 21/28] linux-user/i386: Return boolean success from
 xrstor_sigcontext
Date: Sun, 26 May 2024 17:49:54 -0700
Message-Id: <20240527005001.642825-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527005001.642825-1-richard.henderson@linaro.org>
References: <20240527005001.642825-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

Invert the sense of the return value and use bool.

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/i386/signal.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/linux-user/i386/signal.c b/linux-user/i386/signal.c
index 9e6d883ea1..03031ef9e5 100644
--- a/linux-user/i386/signal.c
+++ b/linux-user/i386/signal.c
@@ -530,8 +530,8 @@ give_sigsegv:
     force_sigsegv(sig);
 }
 
-static int xrstor_sigcontext(CPUX86State *env, X86LegacyXSaveArea *fxsave,
-                             abi_ulong fxsave_addr)
+static bool xrstor_sigcontext(CPUX86State *env, X86LegacyXSaveArea *fxsave,
+                              abi_ulong fxsave_addr)
 {
     struct target_fpx_sw_bytes *sw = (void *)&fxsave->sw_reserved;
 
@@ -549,19 +549,19 @@ static int xrstor_sigcontext(CPUX86State *env, X86LegacyXSaveArea *fxsave,
             && extended_size >= minimum_size) {
             if (!access_ok(env_cpu(env), VERIFY_READ, fxsave_addr,
                            extended_size - TARGET_FPSTATE_FXSAVE_OFFSET)) {
-                return 1;
+                return false;
             }
             magic2 = tswapl(*(uint32_t *)((void *)fxsave + xstate_size));
             if (magic2 == TARGET_FP_XSTATE_MAGIC2) {
                 cpu_x86_xrstor(env, fxsave_addr, -1);
-                return 0;
+                return true;
             }
         }
         /* fall through to fxrstor */
     }
 
     cpu_x86_fxrstor(env, fxsave_addr);
-    return 0;
+    return true;
 }
 
 static bool restore_sigcontext(CPUX86State *env, struct target_sigcontext *sc)
@@ -629,11 +629,11 @@ static bool restore_sigcontext(CPUX86State *env, struct target_sigcontext *sc)
         cpu_x86_frstor(env, fpstate_addr, 1);
         ok = true;
     } else {
-        ok = !xrstor_sigcontext(env, &fpstate->fxstate,
-                                fpstate_addr + TARGET_FPSTATE_FXSAVE_OFFSET);
+        ok = xrstor_sigcontext(env, &fpstate->fxstate,
+                               fpstate_addr + TARGET_FPSTATE_FXSAVE_OFFSET);
     }
 #else
-    ok = !xrstor_sigcontext(env, fpstate, fpstate_addr);
+    ok = xrstor_sigcontext(env, fpstate, fpstate_addr);
 #endif
     unlock_user_struct(fpstate, fpstate_addr, 0);
 
-- 
2.34.1


