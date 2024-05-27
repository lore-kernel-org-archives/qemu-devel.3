Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A180DC25B75
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 00:55:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBOZP-0007JQ-Dx; Sun, 26 May 2024 20:50:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBOZJ-0007Cw-CZ
 for qemu-devel@nongnu.org; Sun, 26 May 2024 20:50:29 -0400
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBOZ6-0003eb-2e
 for qemu-devel@nongnu.org; Sun, 26 May 2024 20:50:25 -0400
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-24ca079af98so1576427fac.3
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 17:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716771015; x=1717375815; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8E9ppc4CUToY/h7916Bi0wG7cWa/ImlZUPMW1khZFpk=;
 b=n5QFpQ8r8RYPj/ljCqCJButHZ9rHwdCauFzrsK4M+lo3nmfcj+quzbX+8HsGMS7Snk
 WjuXM3v/ayhcKsR5dH34t/RIPyDE7RFcTjCxh6StYqlG9jMHkOsmf0rNIgWZiyYr47ds
 1qPGnlZPKEW/9lRnaMJ7Ux4Hjynb851KiBPPHK4aGJA4+L8tmVmNmTX6ffkrB8BjXcMZ
 wcheC2amVX88DVz9QRx8nKQiAuclPb2X34kbeqig6rX/n7sGSo1XWyL3KPsEUUdYylvO
 6tjuEsNFNO518FuCe2ENW663RlfnKdkP3IAjCzlv1TXHdRLAGli5AmgPgo36JkJx1+S2
 JCgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716771015; x=1717375815;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8E9ppc4CUToY/h7916Bi0wG7cWa/ImlZUPMW1khZFpk=;
 b=OKvMD4IwhpgWtGf+zYrbGvgsLpPgq5QPsrFUkdmYzx7qYicOpffK9MjgLfeHIE2CLs
 ZJLDoKdYLPwVCcx+Dl5GAkgP5XmIrd13sNiOkygMwfaPTO4mo7EIjd8zYYaeYL/8EG81
 8Hyor9YgYSEVM9EFlQegc3Mw9YxTHL24zXxeu3usfI1KACilwjqBli7dbj+ERxy9LvWo
 o/I3zl2cJVhyl4HzXbxOwqYJtKsOIFDaGn8oVYr+3ArFvzp8/L09UiYeeWfTjacLpSNh
 Neb5Qbk0KNJYh5ZHmZTaZo1zgjfA1Tkkaj15F8QONDg7DWmsjYf9B8Ue6Iou3gvNQ9Zj
 eHmA==
X-Gm-Message-State: AOJu0YyOzeRPOCLaMtr0gOZgQU2Yc8nBYX3wq8OWVG7c8tmR1Vp5U4uy
 RZJzZYr9mQ3zAa2GQs0QJEiC2GcbtzK5YsdJuxvylXcDlJ9f714lljM3JCNoIdkC/6fqaR7OPpQ
 5
X-Google-Smtp-Source: AGHT+IGUQGkQalTFH8QEX243yDgJu2YZd9kSnktp/0w4+znFhNtlvI8y3340x4/zi5JErTt1Xnnuhg==
X-Received: by 2002:a05:6870:724c:b0:24f:cc89:9f7d with SMTP id
 586e51a60fabf-24fcc89aca4mr4967508fac.29.1716771014619; 
 Sun, 26 May 2024 17:50:14 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fd6d7598sm3942958b3a.220.2024.05.26.17.50.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 17:50:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 15/28] linux-user/i386: Drop xfeatures_size from sigcontext
 arithmetic
Date: Sun, 26 May 2024 17:49:48 -0700
Message-Id: <20240527005001.642825-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527005001.642825-1-richard.henderson@linaro.org>
References: <20240527005001.642825-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::33;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x33.google.com
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

This is subtracting sizeof(target_fpstate_fxsave) in
TARGET_FXSAVE_SIZE, then adding it again via &fxsave->xfeatures.
Perform the same computation using xstate_size alone.

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/i386/signal.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/linux-user/i386/signal.c b/linux-user/i386/signal.c
index 824375d42a..89048ed069 100644
--- a/linux-user/i386/signal.c
+++ b/linux-user/i386/signal.c
@@ -253,7 +253,6 @@ static void xsave_sigcontext(CPUX86State *env, struct target_fpstate_fxsave *fxs
         __put_user(0, &fxsave->sw_reserved.magic1);
     } else {
         uint32_t xstate_size = xsave_area_size(env->xcr0, false);
-        uint32_t xfeatures_size = xstate_size - TARGET_FXSAVE_SIZE;
 
         /*
          * extended_size is the offset from fpstate_addr to right after the end
@@ -273,7 +272,8 @@ static void xsave_sigcontext(CPUX86State *env, struct target_fpstate_fxsave *fxs
         __put_user(extended_size, &fxsave->sw_reserved.extended_size);
         __put_user(env->xcr0, &fxsave->sw_reserved.xfeatures);
         __put_user(xstate_size, &fxsave->sw_reserved.xstate_size);
-        __put_user(TARGET_FP_XSTATE_MAGIC2, (uint32_t *) &fxsave->xfeatures[xfeatures_size]);
+        __put_user(TARGET_FP_XSTATE_MAGIC2,
+                   (uint32_t *)((void *)fxsave + xstate_size));
     }
 }
 
@@ -559,7 +559,6 @@ static int xrstor_sigcontext(CPUX86State *env, struct target_fpstate_fxsave *fxs
     if (env->features[FEAT_1_ECX] & CPUID_EXT_XSAVE) {
         uint32_t extended_size = tswapl(fxsave->sw_reserved.extended_size);
         uint32_t xstate_size = tswapl(fxsave->sw_reserved.xstate_size);
-        uint32_t xfeatures_size = xstate_size - TARGET_FXSAVE_SIZE;
 
         /* Linux checks MAGIC2 using xstate_size, not extended_size.  */
         if (tswapl(fxsave->sw_reserved.magic1) == TARGET_FP_XSTATE_MAGIC1 &&
@@ -568,7 +567,7 @@ static int xrstor_sigcontext(CPUX86State *env, struct target_fpstate_fxsave *fxs
                            extended_size - TARGET_FPSTATE_FXSAVE_OFFSET)) {
                 return 1;
             }
-            if (tswapl(*(uint32_t *) &fxsave->xfeatures[xfeatures_size]) == TARGET_FP_XSTATE_MAGIC2) {
+            if (tswapl(*(uint32_t *)((void *)fxsave + xstate_size)) == TARGET_FP_XSTATE_MAGIC2) {
                 cpu_x86_xrstor(env, fxsave_addr, -1);
                 return 0;
             }
-- 
2.34.1


