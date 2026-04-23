Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 545CDF99363
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:04:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFquh-00085R-Bl; Thu, 23 Apr 2026 06:04:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqtr-0006Uj-Cm
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:03:16 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqtp-0002Ci-T3
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:03:11 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-43d0deb7ad5so5318082f8f.2
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776938588; x=1777543388; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3rKLMQ6RgFwzzecFEkNkkQjw+XyVm/JABTD5On1nUko=;
 b=O9ioZw1EzoKG6qnVDxQKz74KjWwFENoJnMHkGrOBhibkJoa5trs9Zg10U3tF/0TJq4
 XqUjfNUvjQPBbNqQCCLEJxIO1btfye5V7H65qEUdz0lKZb7+ZKap8iOA/2+B3HtbeaBt
 J5Q/a2Mz0gSVCk4MznZVv/NMI3fC3r9P3YMkRvTI88hWM6gwqawWXdML0XGpzp7Dlvc6
 URHSgxlRG5f6bY+RbLxDZuppV+OjGBAuz6iX2ZUm6F2uU51B68dRU2mXC+Z849g+Z1I/
 4hn3LzlkivXZT5MAFXmAtRcTbcgvZeupW47fVaj9wexnnwt4O7mzBQJxxKBzviYsbKjj
 iq7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776938588; x=1777543388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3rKLMQ6RgFwzzecFEkNkkQjw+XyVm/JABTD5On1nUko=;
 b=B4Vg59YFetIRtgXxouyr/8/hwnP8owitPm5obKoUal6OobzSGdVC+SU0Tz5Wvph/r7
 QGuQqQ7KQ4gnrbPV+JzNBs5eJkTVV0uHeeamrxxr+QsWn16yrOHrEUVDM5nen9qb2h4f
 l97ytsGMyrseKmFMCs2aTn8DAjXEmJjGmyEjXJGFEzTVL57wlTV1EPsvRKzbf+5z20nY
 Sod5PB00oOi2Mvlwdfa015tDbfR6DayAsLmkhfPZNk4JZKOJuePTNYNvHr+tFrukiDi6
 yujBPKk7zvMprEJKQ0LH7DcocQJ0V5SmXr9eU9jNIKLQel2o/2eAihn9ZZxWjF7Gb3xm
 EtAA==
X-Gm-Message-State: AOJu0YyGFygrYAkz7Vso4yPXF0jFOWbjB0/IqGiNw1bvZgh1JtnJj+Qs
 QuI5U0ASJe5XDkVT+LdtLAF7uE/yc9XYrf2yJrRkPjbn6AlT7+vDc8OYOLmx2bCuIge2pELiKVi
 6zUeS
X-Gm-Gg: AeBDiev48KVt2GmBEwdE6EnNZcf7on2NPc49Bo39ZzzuBJ4ncocJdBO4hkfkP+ZSm7h
 TXDBiPHWo2mOjZu71kZ7/qWKrW+YPfI9V7y8TIgsUdslmx2roejRSIxkWYJNFQgXrO82YMopisf
 EncXkdKAWMjBdWU6IoFGEUJ3/ITC6OWZ87Lou7ZVknypJ4E7kbNF8rzVDjO0V8pYlhq7NKCF21U
 1Y242Usfmna3GrchnYGN4B1LxBci4TMDrM19BHHGv2yRYiWKfSOnTT/ozGKSeoe1DSlcUAaaOcu
 /cQ5V/ZZyCus6jdDKwTwHY6q98lzZhkt4ABKf1uSFzw9QF+/GM6qYFXN2ZYGRH1nsAniUUQOn72
 y+Z07yu/e+f6J7qUsBUaa615/SHDdERgaRo9fsESpeQKKxNtOpBsnLZkaI3yPy2P7ar+uAzK74S
 HCQi1wzhk58yb+VItewu2tE92pCbS2eFPbKPJqlbbMYapQqnJs4zM7Gon7L6qLnI6VnqY3QoWAT
 LcXp1sjMjrkAKG0/oUICkJqpEAuK/ie+WrdpfYctg==
X-Received: by 2002:a05:6000:40de:b0:441:1ca1:6404 with SMTP id
 ffacd0b85a97d-4411ca1642cmr19823611f8f.18.1776938588388; 
 Thu, 23 Apr 2026 03:03:08 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4eec9sm49323930f8f.34.2026.04.23.03.03.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:03:07 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 34/59] MAINTAINERS: Remove Anup Patel
Date: Thu, 23 Apr 2026 11:02:04 +0100
Message-ID: <20260423100229.2941820-35-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423100229.2941820-1-peter.maydell@linaro.org>
References: <20260423100229.2941820-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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

Anup Patel has not posted to qemu-devel in some years and did not
respond to a query about whether they still wished to be listed in
our MAINTAINERS file.  Remove them, on the assumption that they are
no longer active in QEMU.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260416091654.316158-3-peter.maydell@linaro.org
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2fd2a5ebd2..5b5b686e76 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -842,7 +842,6 @@ F: tests/functional/arm/test_canona1100.py
 F: docs/system/arm/digic.rst
 
 Goldfish RTC
-M: Anup Patel <anup.patel@wdc.com>
 M: Alistair Francis <Alistair.Francis@wdc.com>
 L: qemu-riscv@nongnu.org
 S: Maintained
-- 
2.43.0


