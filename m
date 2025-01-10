Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1070BE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 23:05:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWO3G-00044z-Eu; Fri, 10 Jan 2025 18:04:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWO3F-00044g-5z
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 18:04:25 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWO3D-0006TZ-L2
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 18:04:24 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4363ae65100so27417315e9.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 15:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736550261; x=1737155061; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kLrJ8UeidzK/n4qe+Iz3ETsOIq+mzd0rmA6JjfZJ3ls=;
 b=TUiKq222BVKlmKHRCoQyWmB0mm2h7NWRXdyjLhubB7JfRy+IlCn8gZw2/ZlwULIXrC
 MvOCLmBAnmNFPvB18YPUWBHZagq+3Y+LkpYZgMYWylDFD04Qlz3bb56LzLOUm9/t9VKp
 yBeI3wgmdnmbYpM5LOE8Pzr61nmE5EZCLu9y+S1+halIXHc+0H95MrRPxMHqHJ44LpQr
 gtxDQ1hjWzCLoLerqkWE7cLUKbh6rVxFzfuXHK4AsYUR7VjGCz6p9kz5OPi9rjyPx2v+
 dB3LMOnoAxcrnWLAZu2tKMaVpFJ9fWvipg2C3sb9LhKqrZ5FuK4Y0McxVFuIwDJkhZnE
 hNew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736550261; x=1737155061;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kLrJ8UeidzK/n4qe+Iz3ETsOIq+mzd0rmA6JjfZJ3ls=;
 b=CtO5WtY3qValUiIG85v8Ui2ETkDNX2/ReGcWPhXUnvU7kuhoIr2DR5AKR0uYZTnDsh
 xwE4DGmcl8yp4poJ+Chb9s6omXGWz2LiXFI+Gl5W02XeTVCSJ+cUJsA2JNyOMhZ6eJ2C
 aXH/627ZuHa4vfaKzXn2zL3snh8Wz5ysW3qZX/uDZvGoaXDBTpeE22qIKCh15LiMY5yL
 HvyM9DMQV9X4ZyIoS7oP2WPnt/qAjQ8PMMPUa66vNw7uuyv+b8i1n/ZdDQWjlne3aXDm
 SnyNLQblhQI11AGaiyZCxHsxo5GhjUKnVm9dYJE3IYNkXCRX3yeCMZd4L5kFHaSg9LAV
 EKKA==
X-Gm-Message-State: AOJu0Yz9H1mmDx0kuf1tFD5TNyq7VTQbVIO7L4EUMblrl1nogKwWMfd5
 7eRU7U6jh/Lu0hfKSzqw0WnDxPNSux8I2HzVaKpNMpm74PtrsxhqcxspejKwOZUew1+pQq8wHr0
 qDqY=
X-Gm-Gg: ASbGnctKM/+NTPLfYE/p9Do4MCSFAgJi+iv0s8q0qw0bj0Bh6xD//jtuO8Til9+CQt2
 GN5ZNjNRwqHSIdyFJY7hjVhaiTgmDXG+RBdob9FWw1mhxgoQa4mIFQDHzGZ3hEgDF7Bwv0obgPH
 YJeQUHqs8XyiRizaqSXecxO9a9TZ4OF5RFsXbw7TG5Vd/II/TW4L9BoO4R9vKjxYOfSWBotxjFl
 GrrUhpxBLnCLuJuhoBwiFL6kFCdir161r+v7A3KDKC7RfoGh+rqWDe5v4sErUq7o9B0XBvgErPe
 kwdilETsCPdb1Z2UjA2z1Y4YZVGI52sTnage
X-Google-Smtp-Source: AGHT+IFAryNsoaZmhJbHO4Xfjnz6njEmbdX8eqR9fDOa0QCcMwhcpBXW3nEgwVHXadhZEqbsAYVj/A==
X-Received: by 2002:a05:600c:3c85:b0:436:18d0:aa6e with SMTP id
 5b1f17b1804b1-436e2679a7cmr131838755e9.5.1736550261374; 
 Fri, 10 Jan 2025 15:04:21 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9e03f62sm64639885e9.22.2025.01.10.15.04.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Jan 2025 15:04:20 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 0/2] hw/char/serial: Convert to three-phase reset
Date: Sat, 11 Jan 2025 00:04:16 +0100
Message-ID: <20250110230418.95571-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

v3 (rework v2's crap):
- SerialState::irq is supposed to be a 'protected' field,
  do not set it from 'outside' of the object, expose it
  as QDev GPIO.
- Manually Reset SerialState from parents,
  register global reset handler for SERIAL_MM (not on qbus)

v2:
- Addressed Paolo's comments from v1 (except &error_abort).

Note, this fixes a bug where serial_realize() was calling
serial_reset() -> qemu_irq_lower() while the IRQ was not
yet created.

Philippe Mathieu-Daudé (2):
  hw/char/serial: Expose SerialState::irq as QDev GPIO
  hw/char/serial: Convert to three-phase reset

 hw/char/serial-isa.c       | 12 +++++++++++-
 hw/char/serial-mm.c        | 11 +++++++++++
 hw/char/serial-pci-multi.c | 21 ++++++++++++++++++++-
 hw/char/serial-pci.c       | 14 +++++++++++++-
 hw/char/serial.c           | 12 ++++++------
 5 files changed, 61 insertions(+), 9 deletions(-)

-- 
2.47.1


