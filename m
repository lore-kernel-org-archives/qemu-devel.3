Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3EB1C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 22:55:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgBGK-0000YN-BT; Mon, 19 Aug 2024 18:54:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sgBEk-0001XQ-7d
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 18:52:32 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sgBEi-0000lF-8H
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 18:52:29 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-428178fc07eso36558065e9.3
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2024 15:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724107944; x=1724712744; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zTcmfZovDL+2at9UVP/rP8+xQ32AOJCb5fxO6lUcn8c=;
 b=iVejb+2gPz99XEHK8h1RETbg9cK8rfLjdGDAfDjlbKl/32I00aV8+KcUvl4ZomZXyF
 L9bon/fVj17yjVEalWdDnm1MLktf+qLQXKjzFC5ZdXhuZ5FISlU5KgOd7LyKNMhy7nal
 2aq8DB6igQ3RejcFyCuWDosllzm5m22CRM1bQhCefWTWLEFKlUCC1a9VPMkcADbTgWVV
 7sKSOLwFC4j6GPc9wlbIDGSFr4OItbLVE/bjv+YN6thaQqKfg9Q2qh1Pd6VSGlpKPUt9
 ZRMg3Xb1KeFJ633QqwneG80tCayuFjOAiN9aHdQ46cunUUudd6sVcEa5CCC3rV4KD+sx
 irVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724107944; x=1724712744;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zTcmfZovDL+2at9UVP/rP8+xQ32AOJCb5fxO6lUcn8c=;
 b=c0XvAoSYWvaMtnHqowkT9EH28YgLgezXG0dnXszz+leE/tpD9GNoXQOgCkSB2tD+3K
 K6ob8YIcqb0CHqwmIx9uj3hPq7/LCaoF6SAWr3A4EYBDZDkCHX1lhWC8iXCtvOOqr8Qg
 Q5hD2kNZDn72C7uWkT8+dkAJwoeKYv0zee+ZLSEaOUZ6R54MrCQYNYbf/9nKVNNGvFo6
 MeQhJAlqbZefa3V08aXq1cQ2JoysecuWr7I8gHVFxl9Goeiq6XN7n7oOJ0TQwo7Cd6OV
 UMHSwHZT3eeaNzz6s4/6PmKHDjxlZfJQP1mNZ+3nBFyJvJ/03wyGUIPvdrglI8vAHpbQ
 zmzA==
X-Gm-Message-State: AOJu0YypHU9NZeKhTbaQ+8JqrqX6UTLsVTtE8cRS3R/Nq2Z5NC7B1nSR
 6TdT9yAuuh88aXrrwrTWiTRhq+f+6k19rk0Lox6RzPeTlGuYUXONVLZRbgjDKogLgB30tDvEeDx
 nxaQ=
X-Google-Smtp-Source: AGHT+IHudnoR6LWmE2RVxE9W9gG2+NwY6H/GTDeY9O1ynzVttZGeR3lWRbgHRUCneLg9BfNStPVTfg==
X-Received: by 2002:a05:600c:4455:b0:427:d8f7:b718 with SMTP id
 5b1f17b1804b1-429ed7e43d7mr87042175e9.24.1724107944227; 
 Mon, 19 Aug 2024 15:52:24 -0700 (PDT)
Received: from localhost.localdomain (88-178-97-237.subs.proxad.net.
 [88.178.97.237]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3718985a6ddsm11569150f8f.58.2024.08.19.15.52.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 19 Aug 2024 15:52:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 14/20] tests/avocado: Mark ppc_hv_tests.py as non-flaky after
 fixed console interaction
Date: Tue, 20 Aug 2024 00:51:10 +0200
Message-ID: <20240819225116.17928-15-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240819225116.17928-1-philmd@linaro.org>
References: <20240819225116.17928-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

From: Nicholas Piggin <npiggin@gmail.com>

Now that exec_command doesn't incorrectly consume console output,
and guest time is set correctly, ppc_hv_tests.py is working more
reliably. Try marking it non-flaky.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Message-ID: <20240805232814.267843-3-npiggin@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/avocado/ppc_hv_tests.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/avocado/ppc_hv_tests.py b/tests/avocado/ppc_hv_tests.py
index bf8822bb97..0e83bbac71 100644
--- a/tests/avocado/ppc_hv_tests.py
+++ b/tests/avocado/ppc_hv_tests.py
@@ -45,7 +45,6 @@ def missing_deps():
 # QEMU already installed and use that.
 # XXX: The order of these tests seems to matter, see git blame.
 @skipIf(missing_deps(), 'dependencies (%s) not installed' % ','.join(deps))
-@skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test sometimes gets stuck due to console handling problem')
 @skipUnless(os.getenv('AVOCADO_ALLOW_LARGE_STORAGE'), 'storage limited')
 @skipUnless(os.getenv('SPEED') == 'slow', 'runtime limited')
 class HypervisorTest(QemuSystemTest):
-- 
2.45.2


