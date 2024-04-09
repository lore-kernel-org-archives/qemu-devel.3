Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2B92CD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 05:07:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru3dv-0003Dq-4M; Tue, 09 Apr 2024 01:03:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ru3du-0003DJ-3k
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 01:03:34 -0400
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ru3ds-0005M8-8b
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 01:03:33 -0400
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-22f01274622so1543947fac.1
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 22:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712639011; x=1713243811; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HlBd919hOWRpacVU0kzMPBm6pP4Z5Z1zQwF3gBDERhU=;
 b=IaOGd88uwSlx2AXSmDSochmWr+CSxz7bTPXoeShfh4H8VooUz2uRzF+h4F86Pqs3E7
 B2YI4h3XN72Jxr9fI0QuXi/GEX0I5UCD7ZhJC/MwSMYWImbcvWkn26O/T2Qyj+CWhp6n
 HJPm5TeyDBy1IQ40umBhLdrN6wi5oSIGyt5+kbHqQzFz5OneViO41qYPpZIcKGOpSh5s
 w41AaQitDXx1G3qlfAwqhrkaXC88Nb5+1ZOMzmJ+76npyZ3b3NZCxyVVat5yjNQpMn9d
 o3xKV7mdSfEnAlzz4ib1+mCqiOTQBF/OljWm7wiQk2fs2p0vq+khbF4f+cdKS0Kvqodz
 oEuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712639011; x=1713243811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HlBd919hOWRpacVU0kzMPBm6pP4Z5Z1zQwF3gBDERhU=;
 b=qdsFslyv5TjIXy4uuIG0XQcE4F+2HgBm4JZGZ9v8LUp+Tfs7P96cUVf7HQKNYuzKGs
 DM334Ewl7JbpMyoXRCmY0TrGd6ijkU3ozSHn7aOOSL6a77x+9cMtaOg0HzacVgZNmr8F
 QiOoAKJ86QjrUPSU5jhCcY6c1M8BHE9fIkwp0XsB+5NUesINCmCJHnjt+B8ygODLI4Md
 OIvRqGgxfY+towvmGWjqNxqu9iyeoQ0L12EQDMUhfILUwwu8OqRSvK7GwhvRBJ0JebPX
 c6tS1/dFnIkNf8iJHyUiR3dd7CY3QOZSJovsdeV3rIEyswCvLTN9CoBp3Q41qVsGWxGr
 A8JQ==
X-Gm-Message-State: AOJu0YxwPhi+97YXTK2CHrCqL+xvpzxWkv9ddfXAYFJ4aX6EYdmJhxoN
 /NOkcNEcv9/0ZYzulNE6AbVmqDhHuT2AUJEWTICA/1mvR088LmE16agQSkLEFi2Wn5TubRiBODi
 k
X-Google-Smtp-Source: AGHT+IGX7K4kgiY7YEfVlbp3W+EK6O6AVb/AYeihJwA+6YOridLVVe1+IzvBB/ara7OhH3uTio6i6A==
X-Received: by 2002:a05:6871:88a:b0:22e:dfbc:4d90 with SMTP id
 r10-20020a056871088a00b0022edfbc4d90mr11912206oaq.5.1712639011107; 
 Mon, 08 Apr 2024 22:03:31 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 z26-20020aa785da000000b006e64ddfa71asm7654894pfn.170.2024.04.08.22.03.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 22:03:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 21/28] linux-user/i386: Return boolean success from
 xrstor_sigcontext
Date: Mon,  8 Apr 2024 19:02:55 -1000
Message-Id: <20240409050302.1523277-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240409050302.1523277-1-richard.henderson@linaro.org>
References: <20240409050302.1523277-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x35.google.com
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

Invert the sense of the return value and use bool.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/i386/signal.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/linux-user/i386/signal.c b/linux-user/i386/signal.c
index 1571ff8553..d600a4355b 100644
--- a/linux-user/i386/signal.c
+++ b/linux-user/i386/signal.c
@@ -529,8 +529,8 @@ give_sigsegv:
     force_sigsegv(sig);
 }
 
-static int xrstor_sigcontext(CPUX86State *env, X86LegacyXSaveArea *fxsave,
-                             abi_ulong fxsave_addr)
+static bool xrstor_sigcontext(CPUX86State *env, X86LegacyXSaveArea *fxsave,
+                              abi_ulong fxsave_addr)
 {
     struct target_fpx_sw_bytes *sw = (void *)&fxsave->sw_reserved;
 
@@ -548,19 +548,19 @@ static int xrstor_sigcontext(CPUX86State *env, X86LegacyXSaveArea *fxsave,
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
@@ -628,11 +628,11 @@ static bool restore_sigcontext(CPUX86State *env, struct target_sigcontext *sc)
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


