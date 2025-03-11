Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42E45C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 19:54:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts5e1-0006xu-PA; Tue, 11 Mar 2025 15:52:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ts5e0-0006xd-MM
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 15:52:04 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ts5dw-0007Ut-Jd
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 15:52:03 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43cf034d4abso26568245e9.3
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 12:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741722717; x=1742327517; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AqlyIjauk+i+WDncRwxPlz+5+tpaK/3rCbEFP1AqOec=;
 b=wUvh38J7Su6FNk+uLLY4ngOqfz6CD5zsOyzPIUupBy5AUoFpam0I1yYhJ+0sy7LjAb
 bQxjSrBvStk7YbrthburL7BcsdsuC0YxtdUGEdN1wlQCVwTOMnOVwFNVU7zCqXQZapW3
 oNZ1DbyZ8/TDB9SpxXHlWI3wJZJ7nvZ3rlKMS0vkw5pJxRco2/POY7OyelLkWSxAbZFq
 143gJjReH5wk0/68wQLvcFtxOKXWa4nZBdE0zTPB3gzlra8LN9JBLjRFJTvqs6nd5ATM
 g/NU8PGSmscSIE1tow5hb8dhztyadqEuXZaxWGu6yO/eyitZ/38yEf6iDyzxVY81vWH5
 Y9Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741722717; x=1742327517;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AqlyIjauk+i+WDncRwxPlz+5+tpaK/3rCbEFP1AqOec=;
 b=VWIAKqr4TdEBwAahXBrtf/HBv1ZZjKJmxopckcMiN8nVmwxCrUGwraNIr7e6krQg0j
 I9dkg+e8ayrdjurihkCRMoRC704QHU8SorpFYtb8fW1xUOU8jY0woQKcDhcC/aA2e0nD
 P/s1qDui2u36QH2Mzg/3px1YyyKfyALoI0YJzoDi8Kn5KtZWa3d4qujMNt/7PH2/u7GA
 6OIrOE18Vq2aoEb2SWvXxYppLH2pmemEjCu/ayaB2G/od1jSz8HN1e7j2fEtVaRhvAkz
 QaqHHdREMD86uO6UXmS3DjoVZK+McRo7geglpOiQCXQcyyaClgHXSDFrrOmfQRxGfWzN
 i6gA==
X-Gm-Message-State: AOJu0Ywdrxk44Jymi1hG9S0U2vHCytLDX66VYgQBwzwtPJH9gseKhVqs
 PWko5CyJFVrAhkhthjXSpQWvbvsbbC+AEJh5iATgxFnCrzO+YW4Mt8up0nWPMQTQRH/Rk5Y3JdE
 w+RU=
X-Gm-Gg: ASbGncsr4fr1SDJmb773e1adiXRGgCBBajBneSfvQdqVHYu86hSGQWvRzmNvOVuX3f/
 HD7Kcr4ZpsJS4FGiIUAt91HqzvHI8ZMUv4O+yONRpdyEpcckQXlB5O68tGT0ZtTHYmmtpkAhdpl
 dBu26L0izTiIn+BAWhiOJtkM7/1tN3Rr6yISV16nUnrrpdT18uUw40jOrSiwjNL5XMYSIum4yuJ
 vkQFDY1VapxTZqwXjlug/FndduSG6ng6BqEvB1NPR5rzGV7FokYb+ivRWOUh9tUFCzkOLsTFk4A
 ZH+DXFNXNZbXE0LWPXpJlhP4JqNg+9TpkQdTTXiDqgSgOf+yq2g1Rx1XqBtFj36aTfGZ4N48EGm
 qADBrgszUe2wGIyd9/9YvdFsGFAFVNA==
X-Google-Smtp-Source: AGHT+IG2YSr3gnM0mQfY9O78NhWOrcEoIQQwO6MDe9bQ3Hgtb0Dh32u6fO6yjpUxSA0n3v0kqKFOFQ==
X-Received: by 2002:a05:600c:3511:b0:43c:f332:7038 with SMTP id
 5b1f17b1804b1-43d01c12586mr52848935e9.21.1741722717397; 
 Tue, 11 Mar 2025 12:51:57 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ce8a493d0sm129562705e9.1.2025.03.11.12.51.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Mar 2025 12:51:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 07/14] hw/xen/hvm: Fix Aarch64 typo
Date: Tue, 11 Mar 2025 20:51:16 +0100
Message-ID: <20250311195123.94212-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311195123.94212-1-philmd@linaro.org>
References: <20250311195123.94212-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

There is no TARGET_ARM_64 definition. Luckily enough,
when TARGET_AARCH64 is defined, TARGET_ARM also is.

Fixes: 733766cd373 ("hw/arm: introduce xenpvh machine")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250305153929.43687-2-philmd@linaro.org>
---
 include/hw/xen/arch_hvm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/xen/arch_hvm.h b/include/hw/xen/arch_hvm.h
index c7c515220d2..df39c819c8f 100644
--- a/include/hw/xen/arch_hvm.h
+++ b/include/hw/xen/arch_hvm.h
@@ -1,5 +1,5 @@
 #if defined(TARGET_I386) || defined(TARGET_X86_64)
 #include "hw/i386/xen_arch_hvm.h"
-#elif defined(TARGET_ARM) || defined(TARGET_ARM_64)
+#elif defined(TARGET_ARM) || defined(TARGET_AARCH64)
 #include "hw/arm/xen_arch_hvm.h"
 #endif
-- 
2.47.1


