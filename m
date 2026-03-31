Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C996109B462
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 13:17:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7Yxq-00081d-JJ; Tue, 31 Mar 2026 09:17:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7Yxh-0007oZ-7c
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 09:16:54 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7Yxe-0004ED-6u
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 09:16:52 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-43cf5d14d6eso2308209f8f.0
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 06:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774963008; x=1775567808; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EfBNunGxsX5Za9qOZ3QZ/1tl+TL5Gxf184cmua7DLVc=;
 b=QdbKccuWwgHIrCaKBWgER2A1JDPb0ATeQpeO/7naZTaLPgTQ9j3Uzc4PN7+BQLkVii
 +JeMOB6Ek7h7celaepgG0sype4LvON+iyUWkWR5Cjb5+r/FBRqZTgX3qatcRvs3l/qxL
 Dd4rL+GhDa8DZ6yQmFN++qY8mincGzzYRC/1eDQZ4g6VKgpTUq+bdJ3/u4jt1yrYiVRw
 uQ4Y9sWUSzXwu2iWmk5TG8KlWrU+0tSKpC316ij1vvTDWXhAkmyQm8Bl/gdH7JqmAB8i
 RBkxZ4p1Ls90Q4N278JxhFfgQkVD3uM1mgGVwgPdCLldyIfByhIVduAPcCx5n5pgXnPg
 pTZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774963008; x=1775567808;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=EfBNunGxsX5Za9qOZ3QZ/1tl+TL5Gxf184cmua7DLVc=;
 b=s7DUXx/hXXOoPtBnZzHabAEyaov3CQQBOru3tb9HL7nfUW1tvQV3BNlW9WZYgMCBlI
 ynRlYMJ5f1m6tHtmXdLLa03jzvcHuJUmvT7kzvaBJkAVW/Ms6fndUWiLKuhCZcXDRp6q
 ot2M4OZg6HuZs7THQAw9Z6BuuBos5bXDyKqbV2WBzAWxStIc4kkKXDfNRcapkthlgWm5
 vrkaukl5KsTt2Xzak7QgX6IbT/PvO/2fkHHPy/9XI+qLZITlE7ZF7xGbpkskJ8wfl0vd
 +lDUl4wGLBxMxpobkDXh46NmPEGMFKTEs13ahyyxBl0Bl9uxqZwOyC7pazclPAGsvUPD
 Q1VA==
X-Gm-Message-State: AOJu0Yx7EDzXtVGCrrai6mN8g3Gj8endugCVtLM0joYnEGb6QGgr7znk
 Ye0iAFHC8Hx4Q7l+u+yDDKl3izNrahZvXr7oL5yOcpGWB59vN6iRm+AtLCe2Yae1Q3VR7pehaSF
 EjVIaFsY=
X-Gm-Gg: ATEYQzwz9VGIr4r242w3+NfSNqgU/uf79P64dyazYNpCgURWj14W2uhmzYOatsr/5eP
 c9ppIr9sn2a/Arezc7A0fSMsotgClExKHtaxvnkHr+qflZlUH6WUX8Nbq/y9+Y4DDg2CUI93NA+
 kMz0W5UiMFCxu1o2WpJiT7k2cFVGrZ9/GUad4NhDbF859ParIFnt3mkAc3R4cvtgZK7rRX1PwGR
 /FQT3HyZ0yenwUnGbLESTiovK2IDn0VyUTUmMX9Z7BvNGVNVF8UvW9l0esk8YzCv0OnuFFeXH8x
 ki568FNp6rPoWdZMvkj0uqCBJbBR4WEBF/YPKb9xPgvDAVsahj3oqDIUunoWSjoIHgxSaEWSLnV
 2RJgfhFbd+Juvob6f6iYrt7ZuX6vJwm9QmjhIekJVJHjr2bBJ4geIGVs5hAhoZ5nEl6Dl6SNzpE
 FrkM1vMKxq8kWDIMpHcca2qyEuZBtidX+veI1/uiFkwMtTDKNXLPEpBmTcASU0BZi8R98=
X-Received: by 2002:a05:6000:4027:b0:43a:580:f60d with SMTP id
 ffacd0b85a97d-43b9ea4a5b4mr28407686f8f.35.1774963008160; 
 Tue, 31 Mar 2026 06:16:48 -0700 (PDT)
Received: from localhost.localdomain (43.149.216.82.rev.sfr.net.
 [82.216.149.43]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43cf21ebef9sm28605465f8f.13.2026.03.31.06.16.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 31 Mar 2026 06:16:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/11] MAINTAINERS: fix OSUOSL typo
Date: Tue, 31 Mar 2026 15:15:13 +0200
Message-ID: <20260331131514.21152-12-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331131514.21152-1-philmd@linaro.org>
References: <20260331131514.21152-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

From: Alex Bennée <alex.bennee@linaro.org>

It stands for Oregon State University Open Source Lab.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20260331070401.1125840-1-alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index de8819b7aaa..ad215eced84 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4530,7 +4530,7 @@ R: Philippe Mathieu-Daudé <philmd@linaro.org>
 S: Maintained
 F: tests/tcg/Makefile.target
 
-GitLab custom runners (HW sponsored by Linaro, OSOUL and IBM)
+GitLab custom runners (HW sponsored by Linaro, OSUOSL and IBM)
 M: Alex Bennée <alex.bennee@linaro.org>
 M: Philippe Mathieu-Daudé <philmd@linaro.org>
 S: Maintained
-- 
2.53.0


