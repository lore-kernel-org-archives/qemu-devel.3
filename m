Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55A6510F6FB5
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 14:45:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7woj-0002hD-1h; Wed, 01 Apr 2026 10:45:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7wog-0002dN-3q
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 10:45:10 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7woe-0000iN-IL
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 10:45:09 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-43cf8fe9c2aso2108872f8f.2
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 07:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775054705; x=1775659505; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gmVtwQqQB1P9iwd2Fbr/JpK0B5FKNrqvUXxvLboWf0I=;
 b=G4p8rbn83pt1jeyMe4hQ/7/8VxLrRfFdbKcrydeNHPXdg9N1ruyofDVnolXidt7xuY
 zY6MpQW2E3PrgN7CbtWZ9ubGsjp5ZbokiFcArdtPzisZ4ZwOSscCYsXn+096NH9S1V1S
 yQxZKS0TC9xRtXqkya9TOEVmZhZp5HzFf31p92JeuOvYbH+q+Uugfrgm+7yymoYi8Hz+
 D5Ob919ntcHmLJLJh5UbUVqJLIoIQ2Ciag94MHgjrr3Wl9JaXzj2Wf08OWStnYE0UEFc
 sQcW+KhlRne9n0NtnU1nm1HdP4jy4jOew+fbCF9F92d1azMSXCPs7jqAO+oZIDxV0nhd
 jbbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775054705; x=1775659505;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gmVtwQqQB1P9iwd2Fbr/JpK0B5FKNrqvUXxvLboWf0I=;
 b=SWlNBUbQ9wMBp3MauzB1/uyrkbBHUR/eU2qkw+Ube3UkZXf87jWuzKNTYBZwdSkAqD
 wY9mtGdg9k3qU0eYk8GQBvoFeeR3Vypw2RO6nzpFlHr7UHShqclKUZU9T4UoHvRXoRXg
 8ln5C6rBJSCF492dnD53wLi9k4Wi+G9PV0EaYTxPi55j8ZYOvjF+vf49NwfjSZfZkuT0
 D+8QqfJqkQRSlzrKjBZgF3xHellylZ4yo3OC3ew+lDkEL8LivYgQRcUV4DTK84i7/fmc
 JZhHiaXvL8XQI9OaXWVcgihzhbpTW9OPVCRFKr3VYn8aEWiCMua1zDgaYuydL4VyEjSp
 i3oQ==
X-Gm-Message-State: AOJu0Yw7P/5lGK/dwrwHOnRl+DwWMTQ7ksyK2EpcdRR9j/hG7n/0no9c
 sPqvn9Ah4j8JYRNX/DiSBUR1/QUyC2YTTpALfvppOAtk4z5jbllkNb8tC0XRRmzub4RCHKQOfxj
 KCVBPt6o=
X-Gm-Gg: ATEYQzz1+Z9DYkAebsgQUnBDuADZ5AnjJ6Vf2azhBJVe13dW/o/kk+AUIUhCqiJd3R7
 vaet8divIAio3K9OdneB+Zf8k7YkibRlqW789TMFg8VwJ5kSEO7NGoqH1XvQR2dieLrGgBWBMvL
 Gklroi34gpN/M62e9oBTVfigM64xsrOxrJ/Lzq07dYOI97rYcNbdVXWjkeqIQN+rwXQMlj0Kj0x
 X5wfW7u9aIP0oAIgWTKShVOlyOSLHNjyB/2Zygn5budqt8DOgHzDIM/l0KdLyZL/OQ0SoeA/Ysu
 z2YKysg0iL6yn+EujH88RKLtyVVjQq7B7jMNkgjiJNNKSW2DkQ1F+b1ux6M8k6CjYC7qWHrBeU1
 /YjppSk0iZymsj8O7WqC20k4BPYM6AnY6dOQL8ISf4RyVAyw/kLQNZNPioTjCYDkqfyP91xnhJM
 udkZYY+HliMx1t0LAalF1hQDdx40NohusjWmv5PK7mGwtyJSC87BxAnocVPV0FtHfdkUmKOnSA
X-Received: by 2002:a05:6000:178d:b0:43d:184:8aa2 with SMTP id
 ffacd0b85a97d-43d15051ecbmr7036193f8f.16.1775054705098; 
 Wed, 01 Apr 2026 07:45:05 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d1e4e5890sm276675f8f.31.2026.04.01.07.45.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 01 Apr 2026 07:45:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>, Anton Johansson <anjo@rev.ng>
Subject: [PATCH-for-11.1 0/2] target/mips: Expand TCGv for fixed wordsize
 extensions
Date: Wed,  1 Apr 2026 16:45:00 +0200
Message-ID: <20260401144503.80510-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Expand the TCG definitions when a translation file is only
built for either 32 or 64 bits targets.

Philippe Mathieu-Daudé (2):
  target/mips: Expand TCGv type as 32-bit for XBurst MXU
  target/mips: Expand TCGv type for 64-bit extensions

 target/mips/tcg/lcsr_translate.c   |   16 +-
 target/mips/tcg/loong_translate.c  |   92 +-
 target/mips/tcg/mxu_translate.c    | 1954 ++++++++++++++--------------
 target/mips/tcg/octeon_translate.c |   60 +-
 target/mips/tcg/tx79_translate.c   |   14 +-
 5 files changed, 1068 insertions(+), 1068 deletions(-)

-- 
2.53.0


