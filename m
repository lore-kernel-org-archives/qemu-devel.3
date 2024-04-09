Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C1B4C67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 05:06:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru3dZ-00036i-M8; Tue, 09 Apr 2024 01:03:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ru3dX-00035K-0q
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 01:03:11 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ru3dU-0005CS-N2
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 01:03:10 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6ecf8ebff50so3128118b3a.1
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 22:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712638987; x=1713243787; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=V5J2w56+6+p4hbOrq3RzfNRUe5UKleBy/qCHeJy8gMU=;
 b=RaBtI/FBxW9PWiHZWgPI8DDbhhSQodAwd77oCxYSYIHCDpNReBqINwbJN/2KD9d/SI
 ywoeqO/vrfZxdK6IJK7bfPy6tcL8dvdvjjRb0F6NfI/xyo6lOA6aZDsFDsAo8NQbeV+T
 4C4BsZTo9KARcAwzXfthqptyZy/eDGQtzfPUtHQI+bsEsOwG1FSUa3BS1bPZw/WxevB6
 Hke3iA4CkWqFkbuZJi+6ubrrebRfupmQZmpWUxs7zJ3Jf4/LiA2MUQe5mM//6yzV2K6Z
 vwukMWqEJEQwYixcT4FzxfFKX1nx65LdhBZERi4TUJsAF+iMc/VpnA1sAmFHVnRwmhzI
 tK9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712638987; x=1713243787;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V5J2w56+6+p4hbOrq3RzfNRUe5UKleBy/qCHeJy8gMU=;
 b=R+6mC6vvo6ubOI6hId9JSfjWyQ3RghVoKU6Z7C4mMLlRH1kTytZxghK5LhNAxxHoaW
 yo+va8/OcLVdx4lHSvRBXQbM6VYGaQTEiLmCU70v75894XkG6oNl6wibY5SOEPa2uI1s
 RCRiIlEaFxv7tqpWMeLHchWm40iQukVlUjxoX8w/VEAOLLIPKyalA5tpa6fpLcL/4EhI
 9H4TYN+yMZ9FTYFeWOP9vdd3ND+qqjinXxn8wVqJCwFTJLoDTHyAAEsA63blwW8iZ34a
 LQX51KhnBCAuw9cn2v90vpTS4pBtjwZJm6aPHJPyZShYGhszXTj5S5qR5FZaS4AJACvX
 BBpQ==
X-Gm-Message-State: AOJu0YwgXNoHIvzLqmzoEbfrmWx/Ug3FfHTSDSyuI7jCcRgb2GY5l5Sn
 oLlcdYSJQaaXHvB51SrZN9JzQPof/6Hk7hITVU/IT0nQ/1SFegfDmoZKC/6o8HZA3je+ko0mAGp
 3
X-Google-Smtp-Source: AGHT+IEipLGnRrIdrH5aTGuu08ADHlSRE/oZH4pjYTpFSDlGZI06N/XqfC45y7YB2G5fe0hiwhNy7g==
X-Received: by 2002:a05:6a00:929b:b0:6ec:d3a6:801 with SMTP id
 jw27-20020a056a00929b00b006ecd3a60801mr2622378pfb.11.1712638987345; 
 Mon, 08 Apr 2024 22:03:07 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 z26-20020aa785da000000b006e64ddfa71asm7654894pfn.170.2024.04.08.22.03.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 22:03:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 02/28] target/i386: Convert do_fldt, do_fstt to X86Access
Date: Mon,  8 Apr 2024 19:02:36 -1000
Message-Id: <20240409050302.1523277-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240409050302.1523277-1-richard.henderson@linaro.org>
References: <20240409050302.1523277-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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
 target/i386/tcg/fpu_helper.c | 44 +++++++++++++++++++++++++-----------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index 4b965a5d6c..878fad9795 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -26,6 +26,7 @@
 #include "fpu/softfloat.h"
 #include "fpu/softfloat-macros.h"
 #include "helper-tcg.h"
+#include "access.h"
 
 /* float macros */
 #define FT0    (env->ft0)
@@ -83,23 +84,22 @@ static inline void fpop(CPUX86State *env)
     env->fpstt = (env->fpstt + 1) & 7;
 }
 
-static floatx80 do_fldt(CPUX86State *env, target_ulong ptr, uintptr_t retaddr)
+static floatx80 do_fldt(X86Access *ac, target_ulong ptr)
 {
     CPU_LDoubleU temp;
 
-    temp.l.lower = cpu_ldq_data_ra(env, ptr, retaddr);
-    temp.l.upper = cpu_lduw_data_ra(env, ptr + 8, retaddr);
+    temp.l.lower = access_ldq(ac, ptr);
+    temp.l.upper = access_ldw(ac, ptr + 8);
     return temp.d;
 }
 
-static void do_fstt(CPUX86State *env, floatx80 f, target_ulong ptr,
-                    uintptr_t retaddr)
+static void do_fstt(X86Access *ac, target_ulong ptr, floatx80 f)
 {
     CPU_LDoubleU temp;
 
     temp.d = f;
-    cpu_stq_data_ra(env, ptr, temp.l.lower, retaddr);
-    cpu_stw_data_ra(env, ptr + 8, temp.l.upper, retaddr);
+    access_stq(ac, ptr, temp.l.lower);
+    access_stw(ac, ptr + 8, temp.l.upper);
 }
 
 /* x87 FPU helpers */
@@ -381,16 +381,22 @@ int64_t helper_fisttll_ST0(CPUX86State *env)
 void helper_fldt_ST0(CPUX86State *env, target_ulong ptr)
 {
     int new_fpstt;
+    X86Access ac;
+
+    access_prepare(&ac, env, ptr, 10, MMU_DATA_LOAD, GETPC());
 
     new_fpstt = (env->fpstt - 1) & 7;
-    env->fpregs[new_fpstt].d = do_fldt(env, ptr, GETPC());
+    env->fpregs[new_fpstt].d = do_fldt(&ac, ptr);
     env->fpstt = new_fpstt;
     env->fptags[new_fpstt] = 0; /* validate stack entry */
 }
 
 void helper_fstt_ST0(CPUX86State *env, target_ulong ptr)
 {
-    do_fstt(env, ST0, ptr, GETPC());
+    X86Access ac;
+
+    access_prepare(&ac, env, ptr, 10, MMU_DATA_STORE, GETPC());
+    do_fstt(&ac, ptr, ST0);
 }
 
 void helper_fpush(CPUX86State *env)
@@ -2459,15 +2465,18 @@ void helper_fldenv(CPUX86State *env, target_ulong ptr, int data32)
 static void do_fsave(CPUX86State *env, target_ulong ptr, int data32,
                      uintptr_t retaddr)
 {
+    X86Access ac;
     floatx80 tmp;
     int i;
 
     do_fstenv(env, ptr, data32, retaddr);
 
     ptr += (target_ulong)14 << data32;
+    access_prepare(&ac, env, ptr, 80, MMU_DATA_STORE, GETPC());
+
     for (i = 0; i < 8; i++) {
         tmp = ST(i);
-        do_fstt(env, tmp, ptr, retaddr);
+        do_fstt(&ac, ptr, tmp);
         ptr += 10;
     }
 
@@ -2482,14 +2491,17 @@ void helper_fsave(CPUX86State *env, target_ulong ptr, int data32)
 static void do_frstor(CPUX86State *env, target_ulong ptr, int data32,
                       uintptr_t retaddr)
 {
+    X86Access ac;
     floatx80 tmp;
     int i;
 
     do_fldenv(env, ptr, data32, retaddr);
     ptr += (target_ulong)14 << data32;
 
+    access_prepare(&ac, env, ptr, 80, MMU_DATA_LOAD, retaddr);
+
     for (i = 0; i < 8; i++) {
-        tmp = do_fldt(env, ptr, retaddr);
+        tmp = do_fldt(&ac, ptr);
         ST(i) = tmp;
         ptr += 10;
     }
@@ -2506,6 +2518,7 @@ static void do_xsave_fpu(CPUX86State *env, target_ulong ptr, uintptr_t ra)
 {
     int fpus, fptag, i;
     target_ulong addr;
+    X86Access ac;
 
     fpus = (env->fpus & ~0x3800) | (env->fpstt & 0x7) << 11;
     fptag = 0;
@@ -2524,9 +2537,11 @@ static void do_xsave_fpu(CPUX86State *env, target_ulong ptr, uintptr_t ra)
     cpu_stq_data_ra(env, ptr + XO(legacy.fpdp), 0, ra); /* edp+sel; rdp */
 
     addr = ptr + XO(legacy.fpregs);
+    access_prepare(&ac, env, addr, 8 * 16, MMU_DATA_STORE, GETPC());
+
     for (i = 0; i < 8; i++) {
         floatx80 tmp = ST(i);
-        do_fstt(env, tmp, addr, ra);
+        do_fstt(&ac, addr, tmp);
         addr += 16;
     }
 }
@@ -2699,6 +2714,7 @@ static void do_xrstor_fpu(CPUX86State *env, target_ulong ptr, uintptr_t ra)
 {
     int i, fpuc, fpus, fptag;
     target_ulong addr;
+    X86Access ac;
 
     fpuc = cpu_lduw_data_ra(env, ptr + XO(legacy.fcw), ra);
     fpus = cpu_lduw_data_ra(env, ptr + XO(legacy.fsw), ra);
@@ -2711,8 +2727,10 @@ static void do_xrstor_fpu(CPUX86State *env, target_ulong ptr, uintptr_t ra)
     }
 
     addr = ptr + XO(legacy.fpregs);
+    access_prepare(&ac, env, addr, 8 * 16, MMU_DATA_LOAD, GETPC());
+
     for (i = 0; i < 8; i++) {
-        floatx80 tmp = do_fldt(env, addr, ra);
+        floatx80 tmp = do_fldt(&ac, addr);
         ST(i) = tmp;
         addr += 16;
     }
-- 
2.34.1


