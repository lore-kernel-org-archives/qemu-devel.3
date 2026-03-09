Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1B08FCA168
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 17:50:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzejw-0001Iw-AV; Mon, 09 Mar 2026 13:50:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzejk-000194-UW
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 13:49:52 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzeji-0002yT-Tj
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 13:49:48 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-48539d21b76so11492765e9.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 10:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773078585; x=1773683385; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IsNjI4BjTTn39ADNHcYY6cGNw6j3aYRSbYWW+jepIQ4=;
 b=x38C0fH2x2BZo6wZIT7MX6MzDpQx4m4Ko0vGeAdILaEWDK2+Rxl8EeSxzOs9WBdB8m
 bjxrhHoGO42aDL3LxKiSG4PJq4h4Olkx53yxyw/KphdN9NodxJGBGRa4WZjvTYrpHfK6
 oAzGgFFODbtdHI+XUJXurkO8CbUVSIdUaSiFYgsGgNZdIt56e4P67zepMJJ6F1RAJ7ol
 Kcb0P/uceN51l5QwNG5klDTkGtGHKKaJ9GUOAXif+fsqbRZ/J90rYGmCDK5a9KW77du8
 tv1eTPu2wPrpXQugfUvzTO0cU++1DlP58G9YbFVWqh1OLcST401od32wsLu+KVZcR96v
 xRVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773078585; x=1773683385;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IsNjI4BjTTn39ADNHcYY6cGNw6j3aYRSbYWW+jepIQ4=;
 b=OQ1t2Nx8M8vRb90Hy/qm7mZFKqE23+Q7sR6HEMxMGYGhG/5qwmD2/ztyR0lCI261Kp
 /y2wRIuHl1BoEoELxR5f0EKUKu1T9JaBEI/MnMeB40m0+27eK+9JGIKjjMrjNYMzh5B6
 iMgaMOJRzsLMrJUEwFhO5bOa2M1nFSxYlgGZ4PQGW/6uKjqvKHveSM+T7qZ4UugWckYV
 qgWLe1ekuLYBVO9a7umMgLTXXmsGaKIZKKNwbXuK8X1xfbjnwRD8XImWf3BXMyOs7cUw
 w+TncQjpFMETdYno6wbdpn4pEqj9j6lc+Vtuix54UII+qjtHg+3idxuT+LH9DsDgnZcO
 opRA==
X-Gm-Message-State: AOJu0YyczOtHgWj0gaMd58Okf5K6bzzMH/jkD5cKHWFcc2Bp6Rz5uWth
 xEPNZd8nfwG9EFKqIC/cnQQxs2VgSsidMXoed9lu81hDWrgT/oG7IO1Ux75JHtdRtg0Zl1X6AN8
 o5wvtZek=
X-Gm-Gg: ATEYQzwkQWNBNVkMKggzWoqGC3oN0aCSc1zArw6A9F/dyF6tYP+Q0/+vTZRy39IDqOf
 WOjVh83zSaeGEH60jKu092xtoO7GHv8Gf88EL5IiPERz80IspWKKW4M56lpP4yXtWYeiAJiKQoE
 IrOtDX2o1B1q71p1912TTqq7DCs5op5+YSiWEFgtbgcWIMO7bIEmBMLLhboWe//yi1vCCuJ9rXW
 xsE7bMD7Nh6jZy181BzaAOpWrG60e3L3g0pEc4hbTNDc1avoFAgttt4jc7ADgietgfXVO/wYpSt
 IDyHVPxcqDiYNigo7KsoOF2ycD8XKgMMlJspBcd+mjndITAnQdB6uDBehhBimnscpfVytKxHNRx
 L3CNNnsHFJ7a8ELap9s70c8xeLhcZjLZ4GkRCUIYsPGil/u0QOIo7iYgyV0v9A9ejWuP24pCbP4
 h8QkLciFCuDqfLodgDeCsc8IfgPq1HgfVZj5lz7EpQR5tfn8XrfSp4KEQpWExB27Ty7dHsnC5PO
 4om5KPAlBQ=
X-Received: by 2002:a05:600c:4507:b0:485:34a2:919e with SMTP id
 5b1f17b1804b1-48534a29447mr104839385e9.33.1773078584740; 
 Mon, 09 Mar 2026 10:49:44 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541b6f708sm9142425e9.11.2026.03.09.10.49.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Mar 2026 10:49:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/2] accel: Build stubs once
Date: Mon,  9 Mar 2026 18:49:39 +0100
Message-ID: <20260309174941.67624-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

v2: Expose kvm_irqchip*notifier() declarations

Philippe Mathieu-Daudé (2):
  system/kvm: Make kvm_irqchip*notifier() declaration non
    target-specific
  accel: Build stubs once

 include/system/kvm.h    |  8 ++++----
 accel/stubs/meson.build | 21 ++++++++++-----------
 2 files changed, 14 insertions(+), 15 deletions(-)

-- 
2.53.0


