Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14A9EC41513
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 12:38:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3xbs-0001I5-TK; Mon, 06 May 2024 08:38:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3xbX-0001BS-Oe
 for qemu-devel@nongnu.org; Mon, 06 May 2024 08:38:07 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3xbU-0001xC-5B
 for qemu-devel@nongnu.org; Mon, 06 May 2024 08:38:01 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-41dc9f98e8dso23312145e9.1
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 05:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714999078; x=1715603878; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5ffJQxiDj3N9yVpQm4QJxpwM7+oszAI+ZoVpwTJT6ns=;
 b=jKQOncH69/KFFgWyMY8ma9sq1Gz/UfQ9rGSC16eVfRVqwKcI2H2rPINSGwTsHHqlBW
 +LPa9v5u2I7PFl6Cu2WecADURIgyZb0+NkeeIrCVq9tW9Sc1yee9sTXWZiEUvbY0OW7U
 1iqbdJAQgvmRA8TkkEWUPAhi8eKHsged2FQo0quun8qDf/e6Qe9HlGvYfN+GRDGsLYRQ
 aPxDs0RIjYpzL8B1OvlaUm8XjTB8dbW1j+1Sqr80Rz2K643w42jV/UtnzyOwYnCu++af
 +4A+ZoxsrIyLGLJnDRJ6W8MFnkl+MXgVG+tE+b8h7cfP5akcMqi9vRHSOt6Kikj8S9Ru
 8gEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714999078; x=1715603878;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5ffJQxiDj3N9yVpQm4QJxpwM7+oszAI+ZoVpwTJT6ns=;
 b=WIDaV6hjXHx0Q9Qhb6x//sHE82Ke3wQqFMlI6VPVa5DoaEXr7XRsv/hAfyfyCsxpAH
 1+eYjaqCoNAwnlPLgsRhO0ykCM/2L2+7z2904JAuxfqcYAXGQrcDVi962x0c9+teqHeX
 h/fT1VH7rWxkzetFGEsTajSqFXUWjcVspE36hFSJHa+cpquS2sTE0Fw5uCCUFV2oZjTf
 UHuJKy3V8UZ78P0M+p2cY4sfFIqfaFRmMAMSyJ75qfTDOkorJjHQfzECg+rW890jZiWo
 ADsPeN1FfxImv2ZmCyLBx10H1IgSm+P26fuWFqdcKvam1zfeN7IANO6yfpNl2Vfvwf4g
 Y7gQ==
X-Gm-Message-State: AOJu0Yy/gRFiYg4wH6WSAmaP7tGUHz4gUos4dy3oOTMveqUkPUrRaY8q
 bl980G9BzHlvCm8t5Xd4T8ufF/1yMSIr0DZ0lOBEE66lZJ19QEjwAzhy3eHvKmr+0/m7Bb8KTF2
 X
X-Google-Smtp-Source: AGHT+IHTQHSl72nnfP9LHwtAD9kMUCzzWaNfKpDI7kSmLk6jE7mmeDRiPw6TyxV+E3ySwr6S1SS0gA==
X-Received: by 2002:a05:600c:3b1b:b0:418:f5a:580b with SMTP id
 m27-20020a05600c3b1b00b004180f5a580bmr11733206wms.18.1714999078325; 
 Mon, 06 May 2024 05:37:58 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.211.4]) by smtp.gmail.com with ESMTPSA id
 m9-20020a05600c4f4900b0041bf7da4200sm16058113wmq.33.2024.05.06.05.37.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 May 2024 05:37:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 03/28] exec/cpu: Remove obsolete PAGE_RESERVED definition
Date: Mon,  6 May 2024 14:37:03 +0200
Message-ID: <20240506123728.65278-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240506123728.65278-1-philmd@linaro.org>
References: <20240506123728.65278-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

We stopped using the PAGE_RESERVED definition in commit
50d25c8aec ("accel/tcg: Drop PAGE_RESERVED for CONFIG_BSD").
This completes commit 2e9a5713f0 ("Remove PAGE_RESERVED").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240427155714.53669-7-philmd@linaro.org>
---
 include/exec/cpu-all.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 14fd40046d..104c5dd2da 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -157,10 +157,6 @@ extern const TargetPageBits target_page;
 
 #define TARGET_PAGE_ALIGN(addr) ROUND_UP((addr), TARGET_PAGE_SIZE)
 
-#if defined(CONFIG_BSD) && defined(CONFIG_USER_ONLY)
-/* FIXME: Code that sets/uses this is broken and needs to go away.  */
-#define PAGE_RESERVED  0x0100
-#endif
 /*
  * For linux-user, indicates that the page is mapped with the same semantics
  * in both guest and host.
-- 
2.41.0


