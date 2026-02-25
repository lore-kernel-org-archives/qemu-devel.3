Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21B9AFD45F1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 23:24:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvOAW-0007QH-7G; Wed, 25 Feb 2026 18:19:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvOAT-0007PO-Sa
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:19:45 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvOAS-0003Tw-AG
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:19:45 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-48371119eacso2917875e9.2
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 15:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772061582; x=1772666382; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=txwgsK6qnNhvJOsrDFmGGS9GEAd+UggP9g1V6IJl2ds=;
 b=BzF2xfjhERh0+RGyS0QAMEnlYjk/LMz5XHL1hwyC5npgjEP5/3kHo+/6tZCaTjLCnm
 4foW6aKTbXL2ZWf77fIhyvHk43RmyjB7/XVyY4nlRCTv6/TKvabve2RAiEm4kZGEtmF5
 NRdqBo0PtFz+m51EXh8rycuxEca2g/bDJJ8b/NDGCJ0rfnmiiqv/JQKce68OAhKxKOM/
 uFEd5EPMMqjIAtK8OwXTItp1hCqxumWgMkTHCvCEM92VjLbl4ln/GsdBoAYbNrqH9b8Z
 OGnTQPCdZtA36rbguiOsTXJhi2C8EVZim6oiEhvsyMeOxoe/qXpQ9mxV55nRredkAvB5
 ywGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772061582; x=1772666382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=txwgsK6qnNhvJOsrDFmGGS9GEAd+UggP9g1V6IJl2ds=;
 b=j5iqOIyMWqRo4vHitBW+AqnZB9rOyoC9yJbZla091mq21QEuzaydDFzOso0y08RCh6
 XI60R9ZnZJMCmM3Fa/mEes2ZtkOPd3lOlJfqVZFT5iJksa0CMEUyPy+wKo79ifXX3STT
 zvELUxANZdOAfRDEvW4PDuSs4Eq5Rjn0gfpTYQJXExoS3RmmlG+7oE7Eqyfpa0QAUwwz
 rUAj9Wt+0RKaKiY87v83Kex8N08nqBjPPwe2oQus8CRTeKd3vd0m9t+3preSdfh3hzcg
 yx+ifLQb8V3CtWDDBoPbXtwzFxw96wCwxq9GfXPpDjqnvlEuT9YttNnT6gXVlnd8rXZ7
 QZdw==
X-Gm-Message-State: AOJu0YyGpCZN4cpL9/qkq/q5H/YaPQpNUlTSx/XUmWKeQRJjTOD9HuPd
 +RWdL3E3Oi448jaz6k8RMcqV7X2O0UsITOh5t4Sghn9yGeASkIeS8f0hPIV9DheRcF5va6lxbIO
 0m70O21A=
X-Gm-Gg: ATEYQzyVrMlJsSBe6jcHInNdeKsK+go6oe87PYQxrRzzRJrwAIe/lHqAxH4F/kYycJt
 TcnOH+ByFBY08SXoEmMMqMXmi1IIcN0xC5bfVXZLdbGqCO8rqTVcLUnekuBGUTC5VGD5E9tHMR2
 +3bJYctvmsjPrQsqX/oBQdQpvnuRB5dcWEbb38xzlakk7kmrZlU3nGg/56ji4ZJcf+Mw+ct/sF/
 +TK9VDTv5YfH1gxw7nHIDSF/0XErFoVp+nqsxdriyWQYRXuQxM07g+P7HXzDZgfu7rRWmLAGSjZ
 wBa0Gw4yCGHxL/CtuBS0l/LXBkfCVjtD/JSRQOaVcsCd5NyxZHIKmDB7e8upMVPV+cUQzsWldt+
 3az7DfuPMn4zQNzV4Jps54rGI57p+OAy5Gy/hRt04h9zTBKt69YCxzN4wR8yOlEKZOWpuAprdhQ
 haCHjIcr6xI3em1w9fuRC4YuVYFYCVhpZIdnZbX3w7GE3AWjT4uwX/zh/IYUqfVmUezKDCwyTW
X-Received: by 2002:a05:600c:348f:b0:47e:e91d:73c0 with SMTP id
 5b1f17b1804b1-483c3dd7806mr1308575e9.19.1772061582382; 
 Wed, 25 Feb 2026 15:19:42 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483c3b84023sm4020995e9.12.2026.02.25.15.19.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Feb 2026 15:19:41 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 48/70] target/sh4: Build 'gdbstub.c' once for system binaries
Date: Thu, 26 Feb 2026 00:13:48 +0100
Message-ID: <20260225231411.96482-49-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225231411.96482-1-philmd@linaro.org>
References: <20260225231411.96482-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

'gdbstub.c' can now be built once for all qemu-system-sh4*
binaries.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260219191955.83815-41-philmd@linaro.org>
---
 target/sh4/meson.build | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/sh4/meson.build b/target/sh4/meson.build
index 1327507dfc8..3861d9b194a 100644
--- a/target/sh4/meson.build
+++ b/target/sh4/meson.build
@@ -1,7 +1,6 @@
 sh4_ss = ss.source_set()
 sh4_ss.add(files(
   'cpu.c',
-  'gdbstub.c',
   'helper.c',
   'op_helper.c',
   'translate.c',
@@ -9,8 +8,13 @@ sh4_ss.add(files(
 
 sh4_common_system_ss = ss.source_set()
 sh4_common_system_ss.add(files(
+  'gdbstub.c',
   'monitor.c',
 ))
 
+sh4_user_ss = ss.source_set()
+sh4_user_ss.add(files('gdbstub.c'))
+
 target_arch += {'sh4': sh4_ss}
+target_user_arch += {'sh4': sh4_user_ss}
 target_common_system_arch += {'sh4': sh4_common_system_ss}
-- 
2.52.0


