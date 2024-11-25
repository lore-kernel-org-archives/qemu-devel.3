Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1A73D58D5F
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 15:23:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFatm-0003wC-D6; Mon, 25 Nov 2024 10:21:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tFatk-0003uw-MF
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 10:21:12 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tFati-0001k6-DD
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 10:21:12 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-38230ed9baeso3240002f8f.1
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 07:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732548069; x=1733152869; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9xy5oFlaPkvPwNoncoXfXZpBDbwAIbVa+1JyITx0C4k=;
 b=ByjD9kDkc+WptvGbsHiLjioU9Jc39KEfzgWT9nTZlWj2DsbChB2LWbReXyRY9e5NMM
 yl6XQYIlZ0OpMqYeYwSXQNrEBlhSOION4aoxRV1PwcApSdixGHL7vh0Vhx5SN27yN1XO
 2scVoa4vYr8ual4Pjpq4PlM5WVobQyYgChTxRKeJNStAkyksOxjA6wl10+3ocumxQYrI
 9PrcmcR9AGoPacSZE4vLq9UJWO2YS8ooBTCJVv5JeBQe0+4mT7U17X60VOsSGXI66sza
 O+cY/1yl3aV7cpP/kpSeG4I2+r9R1mJusjzX7RSCZ/1onefhZ8R8M7EVQCULaQyaFSV5
 Hqkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732548069; x=1733152869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9xy5oFlaPkvPwNoncoXfXZpBDbwAIbVa+1JyITx0C4k=;
 b=nNaC8RgXg5n48XN+WsVO5Kl+9MYqcuhnMrm9tFtt5MYd1SFJKEizHjk2kosqoQt49f
 3o2yHgh2Mteehpt+bdr27qprz2wfY8xF0DXhcjMxoL9KrbBhY+9ABre7G7Aro+ow1Mtt
 WBL9LUQWNw+lyrkn56E9WoQThdjRhe1+yRSu2ikI6JiIY0BmTVRXiRsxHffFjaR01jR6
 ezPuDm6s4sTOB9ARsRR69Gekz4g/XrAew2R84pB+JTxxhV12KGSWKeqbgtfsd1W2PBhs
 DP/8giu0G0Jar/v3EGyHL44Ptl1OaBGJWKyPdnWqfGIkzDgTOYLv3ngYymVHpri9ea1W
 AgQA==
X-Gm-Message-State: AOJu0Yw1bND/nvXq6D4jlYMGdlSVjFa4q0UCvK0CrRKfEiBWHQoRgbRz
 n4JoAIYkolXMK66Jwy1pcuqNyYvhJyJQOgClJ2GkjazM6UjN9Xcu6j8ofR8IiBc=
X-Gm-Gg: ASbGnctd97YzmMpKTRdiM1nL+mjRk+A0XDRbUV3g7elFhq3vkEj1acrSR3R0SU7Va/x
 lZPOnKasaJC14CzWNig6JcGEUhneG7XvNNLDfgvLIhJwEQnCT4ZqT0JFjduLkhnNrA0pooSZqQS
 CeVAdvE/P8By5OraVBhTh681rXA4ICMf9JRP5L0Od4sIAd89+V/nsBtzNumViO38baK855b16aO
 jBy3N2+8Gp9ctclF/kB5xyhZJimoe37a+8qZgW0qRD5GLlG
X-Google-Smtp-Source: AGHT+IHacDaIj7+VpoFydEtb1tf7Wc/5Eih4ujK9ZBPJ7SblUc9lE6fWQy2hCkplz46031oP2jqXtg==
X-Received: by 2002:a05:6000:1f8c:b0:382:5492:466c with SMTP id
 ffacd0b85a97d-38260bcd0fcmr11147644f8f.45.1732548068984; 
 Mon, 25 Nov 2024 07:21:08 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fad6441sm10919004f8f.4.2024.11.25.07.21.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 07:21:06 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 187F65F93E;
 Mon, 25 Nov 2024 15:21:06 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PULL 03/28] tests/functional: remove "AVOCADO" from env variable name
Date: Mon, 25 Nov 2024 15:20:40 +0000
Message-Id: <20241125152105.2100395-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241125152105.2100395-1-alex.bennee@linaro.org>
References: <20241125152105.2100395-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
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

From: Daniel P. Berrangé <berrange@redhat.com>

This env variable is a debugging flag to save screendumps in the
mips64el malta tests.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20241121154218.1423005-4-berrange@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20241121165806.476008-4-alex.bennee@linaro.org>

diff --git a/tests/functional/test_mips64el_malta.py b/tests/functional/test_mips64el_malta.py
index 24ebcdb9c1..6d1195d362 100755
--- a/tests/functional/test_mips64el_malta.py
+++ b/tests/functional/test_mips64el_malta.py
@@ -159,7 +159,7 @@ def do_test_i6400_framebuffer_logo(self, cpu_cores_count):
         loc = np.where(result >= match_threshold)
         tuxlogo_count = 0
         h, w = tuxlogo_bgr.shape[:2]
-        debug_png = os.getenv('AVOCADO_CV2_SCREENDUMP_PNG_PATH')
+        debug_png = os.getenv('QEMU_TEST_CV2_SCREENDUMP_PNG_PATH')
         for tuxlogo_count, pt in enumerate(zip(*loc[::-1]), start=1):
             logger.debug('found Tux at position (x, y) = %s', pt)
             cv2.rectangle(screendump_bgr, pt,
-- 
2.39.5


