Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52E8AC0218B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 21:57:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tb5C5-000521-UF; Thu, 23 Jan 2025 16:56:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tb5C3-00051Q-U8
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 16:56:55 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tb5C2-0002ok-D1
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 16:56:55 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4361f796586so15349715e9.3
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 13:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737669412; x=1738274212; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gXRYcwTEjcVPemISiJ0oN9v7hHJA///00CaMfmTQwfo=;
 b=mBNS1u/2bI7eV0b3dXgkY4Nl4FANMyu95Q9QDjgop91d3y0XHjnQRlesvPXqjZtszG
 ROfRVRYZVi7gX4ZouPY8mSwfb0LqXh0QyszMxB1bZfTY1EN9MNhyhc1SoN8ASiFfltDv
 fK3p25CxONGhmPAw7GoA2dQ4SQpgW/afelrBY/mJEh9yqLsFWYx41otlmPY3HfJHzaMb
 pPs31oAwS2EpC4vsr9lWS6ilFAeuIAoVZrGGXafB8Ch8yQrXabNTmgKvp0wre+XG9biG
 TWUz9PQyHW1qOJT25MfJVq7j6iwxTBbKmykyftzWcTp15bgrjgcQAXh7SjJ0I896Z5bl
 Gg+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737669412; x=1738274212;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gXRYcwTEjcVPemISiJ0oN9v7hHJA///00CaMfmTQwfo=;
 b=YuHArhJ4HAqmRMlWIdwPKJHwJT9TM6VBzgHb9zarhzmBs+3xoG4Tg7hL1mfnyNpLFl
 IMDYGVoM8+nGGLcdTY+o1WJzmGJmbs1YMcqKacIqchgSIgTFnZOzNapMrEr4GL39GLCU
 JZpxidjP9cwPxENulxGvPhKJ/qYBvWQ+q4tOmor/dwUeWJ9LGj1pTkQ6bHYRcQfO8fQv
 pOxWoxcxjUVOPtXjcGtyk/3qZnFMANAP8caB6EF5khDWk1tJTea4+A77jVxESN4+fkhf
 EFW6W7RFzGGuQi18/k0UTzwCPR5o1WiXcnYNFOeqiLFTqTaDq3B7fu1q0EdaFIMnPpiu
 9s8A==
X-Gm-Message-State: AOJu0YzjZ3JPJE84YRjUnij58UWZh3k9UxIaLvZQZv90ewhmsvpbWf7j
 6Wx6UfvTPIB3mjAvYh2PouDAnCo0eQM0sak9PPKa276PsXY+DuT52sBSOdz6qPFQ/XD4hXh29bV
 5d08=
X-Gm-Gg: ASbGncsz5KSqLdY8KAugiIAdfkNECrhiKVfxWk5xw9ZmAnosXuatcV7+qIpI5O9XobI
 Ywalf8zc8/X+ODMaSk0KZMDc66sQWU3W9UWjJVgNXOdcYgENoekVWJgLfF291cVQ1Qk0GkOCMNm
 ienSQgtl2Rtjwu5z732nl5IukhG5jozggq9w6YOJ5JhOe1fWCMIRwGTtyVrr2m2mciE6sN5GH8z
 WRcxITj/J2EuNS1ecMngeyMP9Vnep8jLtYns3+XUuf4BopxA630NVJwpMZSrOErfaAmsXsTfXv6
 wzAyS2/AE83+HP6zTWQC13YY/MvFvoHHhmE6dyt+pdySU9Kt2zKzWqMmb/1G3++aCQ==
X-Google-Smtp-Source: AGHT+IFY0qJxVjzg8jeg7ghhr/OhcYZFoxyx+HCMNK1al6GySRvW4X4WEaWm30H31WjRjXjRISgdTQ==
X-Received: by 2002:adf:f48c:0:b0:385:f996:1b8e with SMTP id
 ffacd0b85a97d-38bf5659a94mr22526857f8f.16.1737669412599; 
 Thu, 23 Jan 2025 13:56:52 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1c4295sm792689f8f.91.2025.01.23.13.56.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Jan 2025 13:56:51 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 08/15] target/ppc: Remove raise_exception_ra()
Date: Thu, 23 Jan 2025 22:56:02 +0100
Message-ID: <20250123215609.30432-9-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250123215609.30432-1-philmd@linaro.org>
References: <20250123215609.30432-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Introduced in commit db789c6cd33 ("ppc: Provide basic
raise_exception_* functions"), raise_exception_ra() has
never been used. Remove as dead code.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/cpu.h         | 2 --
 target/ppc/excp_helper.c | 6 ------
 2 files changed, 8 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 0b8b4c05172..4ca27d6b389 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -2753,8 +2753,6 @@ static inline void cpu_get_tb_cpu_state(CPUPPCState *env, vaddr *pc,
 #endif
 
 G_NORETURN void raise_exception(CPUPPCState *env, uint32_t exception);
-G_NORETURN void raise_exception_ra(CPUPPCState *env, uint32_t exception,
-                                   uintptr_t raddr);
 G_NORETURN void raise_exception_err(CPUPPCState *env, uint32_t exception,
                                     uint32_t error_code);
 G_NORETURN void raise_exception_err_ra(CPUPPCState *env, uint32_t exception,
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 236e5078f56..9e1a2ecc36f 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -2528,12 +2528,6 @@ void raise_exception(CPUPPCState *env, uint32_t exception)
     raise_exception_err_ra(env, exception, 0, 0);
 }
 
-void raise_exception_ra(CPUPPCState *env, uint32_t exception,
-                        uintptr_t raddr)
-{
-    raise_exception_err_ra(env, exception, 0, raddr);
-}
-
 #ifdef CONFIG_TCG
 void helper_raise_exception_err(CPUPPCState *env, uint32_t exception,
                                 uint32_t error_code)
-- 
2.47.1


