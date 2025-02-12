Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A241BC02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 11:30:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiAwk-0007ZA-KF; Wed, 12 Feb 2025 06:30:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiAwQ-0007QO-NL
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 06:30:09 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiAwO-0006sK-Bi
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 06:30:05 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4394345e4d5so24244495e9.0
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 03:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739359800; x=1739964600; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yv/Wx3foFGD7aPDIjRISRWc4lx4Hpogt3SBOSTL89do=;
 b=CdOSn2g+j6dQabRgUYp80M5tQ78VYDECKY6z7q1gHGoG5GzX4X9VVlsKPvifMXK65F
 hzH6wT8e+rjPW9Q3NZiLdUXd+8+nNRBXHg/2KmUZYKZRH3wbc6uD3V9FAYleSPsVFqrC
 TxAbX6TciXAzRYHXAi1IxXk8+H5Enzx92N2br/5mNDPbCDVyTVmTD64FbXebLcOubXvh
 gQB3CDkenQ+f4/Fm2KEt978+NpgBBESJ03LGtVOrsKcklIOxu+1Rcox31g7MrJGz3a7g
 UbN5O6cmIToGwoUanHnwvHtEaaqNgbodxNub5ivMxAF1Zmf4UTMui2hdTcnCMi14TQQy
 qF6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739359800; x=1739964600;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yv/Wx3foFGD7aPDIjRISRWc4lx4Hpogt3SBOSTL89do=;
 b=RRhBSQlP8oep1r6D+bWYTHn7YT8x7SQJp7l0q7Ic1eSWhw8ptb4AfiGHF9ESIwqamB
 yPlEAqttG6qhfrbnqFRI8oePnfzBOKoOgJtTW1/7E/MbtW836+zSHssgRqA0A6sHUp/t
 O5MDFYbWONUQDdTypPPtAlBamDDty9o4F/X6ptDbjdugPP3PYk0Xq9Tb+Rcnquj1/HiZ
 d1N64isgX9ltzN//CxtizkxaAgu034XCvHcmEQzIjmWjAy0GeQQiMbw4rAq8c6l1Zx0a
 jZnmj1c1x2O9uJwHUxT8AVvTn9hNjreickfElHyHW94yC6AH3THsSlNDBomjkX8b1ODE
 K2VQ==
X-Gm-Message-State: AOJu0YxtJlv7IYylwMoEYOsAO+SU4zREdp7NaRCen9EVeAyw/C4ODV8X
 4Cvr3ar4DX7DQfBtaeqTgjYVCj0nggJlriq3Ph3yASMqq0IAzzauJVX706fWigJzcNVeursHHMh
 mj5I=
X-Gm-Gg: ASbGncuHpHm3xYzxCXgoWHlJWYabKoLLIvjSjw0CLUVr0esYPuganm5a1n+4OQWDEnr
 xvW7NN783zTPrKFir5BxY3vWWrD5R4REI+j7Y8l+TMxrAle7uo3VCWWKx5q5g/9kawO10LTTbuf
 IJMy6g2aylOn9J0Rh6XKnxjhDVORRT+CaTCiXKy2mckKKijUTmf+kh6tjeoxquFsDGmQEqh33tu
 SPR5cdS1qWAyvyUlmyNyz/EPb1dLHjtSpoEnBevDhmHm0W+7P236798sm7Xk/2xAXaKxLy34myO
 nUexqf5nV4eagzQP0xs6NWMb2VSH/L/kBa0U3+D7JsCrsc5A1KEFWbLrwCff/du8Qw==
X-Google-Smtp-Source: AGHT+IEhL6o5+l8kQkTie3z+c4UV8g6n14atfpDO0yofyqDf3uw4gjNwSpR5s8CMjkbliKETF5zzYQ==
X-Received: by 2002:a05:600c:444c:b0:439:477c:cf73 with SMTP id
 5b1f17b1804b1-43958176299mr33745645e9.11.1739359800135; 
 Wed, 12 Feb 2025 03:30:00 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dd4c8ca52sm11456892f8f.89.2025.02.12.03.29.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Feb 2025 03:29:59 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] meson: Display summary of Darwin libraries detected
Date: Wed, 12 Feb 2025 12:29:58 +0100
Message-ID: <20250212112958.38023-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 meson.build | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/meson.build b/meson.build
index 18cf9e2913b..10f4c9fd30d 100644
--- a/meson.build
+++ b/meson.build
@@ -4826,6 +4826,13 @@ summary_info += {'libdw':             libdw}
 if host_os == 'freebsd'
   summary_info += {'libinotify-kqueue': inotify}
 endif
+if host_os == 'darwin'
+  summary_info += {'Hypervisor support': hvf}
+  summary_info += {'CoreFoundation support': coref}
+  summary_info += {'IOKit support': iokit}
+  summary_info += {'ParavirtualizedGraphics support': pvg}
+  summary_info += {'Metal support': metal}
+endif
 summary(summary_info, bool_yn: true, section: 'Dependencies')
 
 if host_arch == 'unknown'
-- 
2.47.1


