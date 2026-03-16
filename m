Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AC88F46445
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 10:43:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w25PU-00021n-TF; Mon, 16 Mar 2026 06:42:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w25PS-0001uw-9c
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 06:42:54 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w25PQ-0003hF-JG
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 06:42:54 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-48557c8ad47so24408765e9.0
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 03:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773657771; x=1774262571; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VoeBwvNz/P8suv3FOeBbsNj8VpBrzg4rCNwkaJZHuV8=;
 b=X18ywJWOFPFCTbt67f9n2+pMnPmIkXR4Nx4M5/BKumRN70vGvg++D1z3apC5yI8FXp
 XMiZMiDO4pBdJXKIKSNwT+hP0Lx4ZroW7bm9GK/k1PvWXg6cHF+uYlmT/bstemSOIGhP
 cfkL2/E+kg5qDGMrZfgC4ycFJTuHRdr7MZYwfjDWLYumHGXMsh2J1lPKwtpewS2uTanp
 lfq52VSXF5NBXxMp7ND8RjJpxbAQGScYGa8Q+thHlxT3lmwIjiMuukRoARJGJ+WYqKv/
 23yL8OhHnVY/OkWsKDoPpdj4bpi5gg32eKfRoW58PPmEj2eY95irgZoT0MrD0akwdVna
 S4YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773657771; x=1774262571;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VoeBwvNz/P8suv3FOeBbsNj8VpBrzg4rCNwkaJZHuV8=;
 b=C6XtPcVfCpLB87wLYROGPZuhL2nTBeHeXNEOrWduyPrmMxlgfKGp6d6lCmMB4/9ibW
 jI+W+5bU8nqXMh+Cdz6P5VdUaEYD0sMxw+uuoDaHYvXMtLO/+f9mGl7DnJ8Rn9LTpMQh
 6XxAiBOU6K47sU4xNtalk5mA70ME8/Z8iK0gNUxtO+d6fVEn3ogLcguAR6kjJQyfhrPh
 Oh3+EnVrGfoQxWY4ypACzBnmG/O1HQzbFEkkv0SlDNM8fgEU1AcLnBic63tAerwbeOdJ
 hdQ+EhQwLkcEB8D9muF3LdQ/PVanhFlZHT9dPWeH3g6gT49O4xD7IHqMcHhapI8CdbhD
 JNgg==
X-Gm-Message-State: AOJu0YyZOq8aDHkbTW3lgItqaulIQpI7l+/M066lmqGeQfLPtGYS8nKP
 opZYwZ3quGKYirb2wYQMObjx3vA26I1i2g60yp66IcMIBImbrgU+uvQsnuIrIUxBt3DIN2K2Jeb
 ih9Uw
X-Gm-Gg: ATEYQzxbK9oIK+plrHulANRmziD8pieTLq40hycq0+wTZ0rPGuNZl3VjlozbXzrQhnW
 QZFdnfcdE9n+i9a9ufpjVr/lPBOYzAZnx+XwjfewxjeQod1I1gnWDHyJJ15Ty8f7BS0UfELRbk2
 lzBXDivEYWpNSvj1JoRH3yB563P1NuPUGZWuz8FPvbLNRWDiaXZBVgvo1UvruWQbwLJE4z3xnTQ
 sxDF99qgis3KISxxw7ZhGCrhhAMR5/c6v1+soo+9dIJfBNhbv79GV8bvTaQr3wb4Kyiq4D+mfNq
 5IReBVxQedBE8K/CFSW539wRJxrrQ5NgQYMWwoq3rU0vqzvKVErXnSyzyKJVQPWzlEf0L1VDct0
 7dJm6BrfSbcujIgAzzBafhAjm4u0OiE2YwX+9resMJovP396pHlo8ev86mUfrfIvMlINKFy1KHr
 XomFIu4oK5FoieObhz8u1ErPagF2T5XF4O0EAwSO+4fHB6QddptPWlWEYy4SkGaDjW6cLejYe1P
 8ts8DG8zPM=
X-Received: by 2002:a05:600c:1c21:b0:485:5ba3:37d8 with SMTP id
 5b1f17b1804b1-4855ba33bf2mr171648935e9.5.1773657771056; 
 Mon, 16 Mar 2026 03:42:51 -0700 (PDT)
Received: from lanath.. ([81.2.115.145]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48557a74266sm85519135e9.17.2026.03.16.03.42.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 03:42:50 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/17] tests/qtest/aspeed_gpio-test: Use g_strdup_printf()
 instead of char arrays
Date: Mon, 16 Mar 2026 10:42:30 +0000
Message-ID: <20260316104230.836962-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316104230.836962-1-peter.maydell@linaro.org>
References: <20260316104230.836962-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

Older versions of gcc with -Wformat-overflow=2 don't like the usage of
fixed size char arrays in this test; gcc 7.5.0 (SUSE Linux) says:

../tests/qtest/aspeed_gpio-test.c: In function ‘test_set_input_pins’:
../tests/qtest/aspeed_gpio-test.c:149:36: error: ‘sprintf’ may write a terminating nul past the end of the destination [-Werror=format-overflow=]
             sprintf(name, "gpio%c%d", c, i);
                                    ^
../tests/qtest/aspeed_gpio-test.c:149:13: note: ‘sprintf’ output between 7 and 17 bytes into a destination of size 16
             sprintf(name, "gpio%c%d", c, i);
             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This can't actually happen because of the limited size of the values
being substituted in.  However rather than require readers to check
whether the arrays really have been declared large enough, we prefer
to use g_strdup_printf() for this kind of string work.

Reported-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Tested-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260310153334.3063224-3-peter.maydell@linaro.org
---
 tests/qtest/aspeed_gpio-test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/aspeed_gpio-test.c b/tests/qtest/aspeed_gpio-test.c
index decbba23c8..029b3731d1 100644
--- a/tests/qtest/aspeed_gpio-test.c
+++ b/tests/qtest/aspeed_gpio-test.c
@@ -140,13 +140,13 @@ static void test_set_colocated_pins(const void *data)
 static void test_set_input_pins(const void *data)
 {
     QTestState *s = (QTestState *)data;
-    char name[16];
     uint32_t value;
 
     qtest_writel(s, AST2600_GPIO_BASE + GPIO_ABCD_DIRECTION, 0x00000000);
     for (char c = 'A'; c <= 'D'; c++) {
         for (int i = 0; i < 8; i++) {
-            sprintf(name, "gpio%c%d", c, i);
+            g_autofree const char *name = g_strdup_printf("gpio%c%d", c, i);
+
             qtest_qom_set_bool(s, "/machine/soc/gpio", name, true);
         }
     }
-- 
2.43.0


