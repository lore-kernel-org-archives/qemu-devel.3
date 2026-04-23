Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9AA7F99363
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:04:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFquY-0007Jm-Co; Thu, 23 Apr 2026 06:03:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqtp-0006Tp-F2
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:03:10 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqtn-0002B6-12
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:03:09 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-488b8bc6bc9so46012475e9.3
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776938585; x=1777543385; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qjsOOiWEcKRkZbDhDSNYHUlJMVTSEqAzf3AnwWpREd0=;
 b=V39q3GMUCekCnlrXg0I5fCc9OzxlpGHoIYkomozbmTT6DDNsDSFk5gYMohhr90GPor
 hieM24AoTNp861TQG61sx0nmqUKDCFi0wqDZqaX0O/NBcPmOLmFdVmZnmFAxe0LONmzb
 IZ3fuJhNKIzV3UBzFVoFZMhGDvYVVHevCUvb0UkvI2Q09RJPqepHg+IEdKyPiiiBUjID
 EMpOidaMeuAIDiE+88WDYUBqwQjL5aAnqz5oFxldspQfwP0QZKt2QOdmcTdn9zsfqk1t
 sbhJuV3U/T0K9oACI75xwexeKcR45zb8aYtw+UwtreQwM6+ruGup1b/xXCJpAzdW7qTR
 h2+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776938585; x=1777543385;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qjsOOiWEcKRkZbDhDSNYHUlJMVTSEqAzf3AnwWpREd0=;
 b=F+LRquV9juuxtOeX19xXKIH7UJnq8uwk9eisbjasi5+jWX0gnMUC5e9qLS3YkcjXbF
 NC1TaDpdgasIA+xU37JwOPu8NGSg8JIPJfpiu2Ng+37n/dUPG9OqHTLBMSZ4i0b/mnlV
 Y/Z592Kl/u5Yn7oY8+8zKVt9zCJkdn+YcU0202reM5UoxUpUkAEt4ocFi07KIhLkpIgZ
 1o/bf1yPwf6xYBjJixpRBtIaK+vC0Uz0+G0McXeTEvW9I2PS3xhfk5O86TINDS8k8Zoa
 vHg5BrbXnJbxuIes4EZ84G83nYJY2Mqi2nMpPRdwc7+lhor5PhqNstAT3UhRCcqaSCMl
 XV1A==
X-Gm-Message-State: AOJu0YxDgx/q3OcLd4CYUiaSpxmyg5dnNFxwY2FgTC6z9O2dqJh5UxZ2
 QJpGG88OJ0NRmZImOOpuG5drtJdT7O8wOcHRxGNNbLErIogKDtsRWdN1QfpuMixx1lHeXb0DEJN
 5Nboz
X-Gm-Gg: AeBDiev4ItNx6AEfWZFiBsml1D0SKEc5vRsXb8gaeyWMmRN0YWu1FU0iWF6CxIDU4OP
 k5htt3eECJ5YIO0/faF2bfdV9/IKpVqQrb5kJ9yY3h3zULADfNVc05dJIS7eGGs7Y7g5BrwORYd
 W0s4E3umHb9OUy2xAuFwisNAPXM+59ay4N8AraSm39moS1EyPaZyYaafhsh8IxrShS/ChRith7S
 oSQBcowVGGhPPJI1YRs3K7gR2bkWl0/Lldk9npvjzRU9LNM6bghVc/ULKhec2Hp7IZA2U1Uhjrv
 mE2aTauUQgpNNst6h9rnXHvdacoikb/J3J9qIe4k+hw2FFUiPwrPVIA3xrSAZNru4XT3F8sBMKK
 4Brn/wFjinrKGs29HXtCppf5DGJTsNu2SkFOwEf2Bxx8GKBZn/IoO9CmCO8SySK6Uur7Qf4Wfhv
 84F87UILLdPn1w2krxC1JxKD9HUvEMDbpx4lDAmDoebW3WQMkLAo8ZQRWVfctyYdps+ja0o/fnL
 CDtfid+j2ykRMkEy7yUIDrj75eVfwOvWKbFg5TyDA==
X-Received: by 2002:a05:600c:a08c:b0:48a:563c:c8c0 with SMTP id
 5b1f17b1804b1-48a563cd176mr149717505e9.7.1776938585192; 
 Thu, 23 Apr 2026 03:03:05 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4eec9sm49323930f8f.34.2026.04.23.03.03.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:03:04 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 31/59] target/arm: Replace target_ulong -> vaddr in
 guarded_page_br()
Date: Thu, 23 Apr 2026 11:02:01 +0100
Message-ID: <20260423100229.2941820-32-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423100229.2941820-1-peter.maydell@linaro.org>
References: <20260423100229.2941820-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Following commit 15500df3b3b ("target/arm/tcg/translate.h: replace
target_ulong with vaddr") change, adapt guarded_page_br().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260401143456.79843-1-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper-a64-defs.h | 2 +-
 target/arm/tcg/helper-a64.c      | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/helper-a64-defs.h b/target/arm/tcg/helper-a64-defs.h
index b6008b5a3a..3c3c5dddb7 100644
--- a/target/arm/tcg/helper-a64-defs.h
+++ b/target/arm/tcg/helper-a64-defs.h
@@ -131,7 +131,7 @@ DEF_HELPER_4(cpyfm, void, env, i32, i32, i32)
 DEF_HELPER_4(cpyfe, void, env, i32, i32, i32)
 
 DEF_HELPER_FLAGS_1(guarded_page_check, TCG_CALL_NO_WG, void, env)
-DEF_HELPER_FLAGS_2(guarded_page_br, TCG_CALL_NO_RWG, void, env, tl)
+DEF_HELPER_FLAGS_2(guarded_page_br, TCG_CALL_NO_RWG, void, env, vaddr)
 
 DEF_HELPER_FLAGS_5(gvec_fdiv_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_fdiv_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index 2dec587d38..a7372aa6bb 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -1735,7 +1735,7 @@ void HELPER(cpyfe)(CPUARMState *env, uint32_t syndrome, uint32_t wdesc,
     do_cpye(env, syndrome, wdesc, rdesc, false, GETPC());
 }
 
-static bool is_guarded_page(CPUARMState *env, target_ulong addr, uintptr_t ra)
+static bool is_guarded_page(CPUARMState *env, vaddr addr, uintptr_t ra)
 {
 #ifdef CONFIG_USER_ONLY
     return page_get_flags(addr) & PAGE_BTI;
@@ -1765,7 +1765,7 @@ void HELPER(guarded_page_check)(CPUARMState *env)
     }
 }
 
-void HELPER(guarded_page_br)(CPUARMState *env, target_ulong pc)
+void HELPER(guarded_page_br)(CPUARMState *env, vaddr pc)
 {
     /*
      * We have already checked for branch via x16 and x17.
-- 
2.43.0


