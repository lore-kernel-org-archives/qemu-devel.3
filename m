Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDD62E77188
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 05:50:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUg0b-0002Kk-Nq; Mon, 06 Jan 2025 00:50:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tUg0a-0002JH-I5
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 00:50:36 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tUg0T-00054y-AE
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 00:50:31 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4364a37a1d7so146934145e9.3
 for <qemu-devel@nongnu.org>; Sun, 05 Jan 2025 21:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736142626; x=1736747426; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Lch83+sWW4D6zSGFy7scMKQ0gegkVhZFdESLJqLkSW4=;
 b=qOXu0X+DZYkTy5pRXs8N9xuDq759hjOnoaeoaxBFhC5+HvHNJdOrgpZerexm2R7UZs
 +P+LKX/cCffWuQF2ZTsY3qFpbHQAQZAyNJRrv8R9vyz4QtwyJJbACW3eMkWGtsEWYzjh
 lYHjWyByOaEpkHsAvXfGFHeKgpa9yJOeEaT9fa8GH0Rzl0J4WzrdTY8s83KJq36SojA+
 RwRWyLp5KY8AN2gLbAvvlajZyXLcINFhX/7QtyK6WhYufj6b31Pshjkr4jGNlQw5c88m
 3p5LLEoyEisT48WCRfLeCcxlPs1W5BKFSXy/2TmMZlimKKg364g7pK7KfOG31Fc5QW5L
 o0Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736142626; x=1736747426;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Lch83+sWW4D6zSGFy7scMKQ0gegkVhZFdESLJqLkSW4=;
 b=YmWvh/hd7D8J277MvHdxj3YFUZHgBZAeU+Fmh0AC0y1jXx4GHH49L8VVtnUNIOLT6X
 y2ZrDOQkOWPUlp/kGBZSNqx4vG7ps65++1Of8iYVL+8IzXSvyXqndTICr+f4zY5Pz1fV
 w2va6zYFlDJChRyK41GYtdfYbXMZgW/WP+lJlKTtNjJaZben50i1PpF0kpNJFpPMznRM
 JpQ1WtsdmTYKuXmd4BI9nPZlGC1SddFJ9ipjl9Sp6MSg6Hi0tutDp45oSunJXqbYY63n
 i3qd6fbzzWiL54Z0ALC8mGDMmrylR9pLROwfG1kPwNZ+tLmmWxU1ByyDe4S/bI9Nhz5A
 1Dww==
X-Gm-Message-State: AOJu0YwWaa59FRNa69uBqIQf7nXzIn1G8ytdE8eq7eiryCrqaX5bp+CJ
 CjgFbNHqT/ZT5bnf023+Clsh/mmNavp3GiMn1d3Gxhzwys6cNYce9mF84pnsbFh62azuLU6bNek
 QEvs=
X-Gm-Gg: ASbGncvi1KxWCFOW6pNbo7ZqpJHwSEfdQ5VFW6+GsI2b5JmS9q1chJNp52oOSgiVmC1
 82Q3NjENPI3gkajQ3cWLr3W8z5xSCl/UiLePr1WMNs9lCw6SFIZS8UAh1T9LyaUK5W90eKxkV7b
 xct4CEphAxpzjpt2WiyxlqJqGJ6n8GHe52hyD7fCw220xgdI1XEC7EZLCd+VUy5DBoTij/UQxG7
 fN0hS36cb8bjTTBOvugwXm1daTWsHnP5n6t8JETF+BiepiSrgiQWrIB6wXXPRJdfVmBCRx0DDPT
 7r7Y8Ndo9Ctao2hOTACYZkZBUcJGDws=
X-Google-Smtp-Source: AGHT+IGhDtQQbLZQYs8NJLQPphazj8f/hL49ngixi+seQhiz8utW4j5A/TPeiW3fE/YU2gCSBPiv2g==
X-Received: by 2002:a05:600c:198c:b0:434:a19a:5965 with SMTP id
 5b1f17b1804b1-43668548ad7mr447663015e9.6.1736142626336; 
 Sun, 05 Jan 2025 21:50:26 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43661289d3dsm563419195e9.41.2025.01.05.21.50.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 05 Jan 2025 21:50:25 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2] MAINTAINERS: Remove myself as Avocado Framework reviewer
Date: Mon,  6 Jan 2025 06:50:24 +0100
Message-ID: <20250106055024.70139-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

While I was very enthusiastic when Avocado was presented to
the QEMU community and pushed forward to have it integrated,
time passed and I lost interest. Be honest, remove my R: tag
to not give fake expectation I'd review patches related to
Avocado anymore.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2101b512175..8d7044e91fa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4196,7 +4196,6 @@ F: tests/tcg/Makefile.target
 Integration Testing with the Avocado framework
 W: https://trello.com/b/6Qi1pxVn/avocado-qemu
 R: Cleber Rosa <crosa@redhat.com>
-R: Philippe Mathieu-Daudé <philmd@linaro.org>
 R: Wainer dos Santos Moschetta <wainersm@redhat.com>
 S: Odd Fixes
 F: tests/avocado/
-- 
2.47.1


