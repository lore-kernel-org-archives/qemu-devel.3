Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CA40C27C5F
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 16:24:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGhoF-00045h-Dy; Mon, 10 Jun 2024 12:23:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sGhoD-00044N-8G
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 12:23:49 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sGhoB-0005kv-8w
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 12:23:48 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4218180a122so1272435e9.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2024 09:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718036625; x=1718641425; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=MmJqXEo/cvQTcJBBQgnUyi4Q/sMvVbORelXofEHlP2E=;
 b=TUBsaGmXCXRKSGFInEc+G5T0yUrTQMJ3KD/LhfYzeigk9ieRDBY46cr0QqaTjdAqUP
 jEmVYhvG4yZ5RiSXV33LOW4NRcjmOx9OpMyjaT+RsrLMeqwdmRnLGICcFXAn5NjvCE8N
 2mh5mrOFUZx0tCKa2FIHAGYHuMGbaKqvwPMArXP9k+PosqKtQTQvprXu1/5u5EHIPQIM
 4F1B7eFkzXZeha6DWo7q3+WKkVqKKeLHUao12+ZGFlap2aNlOrhaWZUuKSE1yhUgMsep
 U4wl90k599LFWwCFvDMNKTCnQaE0twqTak0h8x1Cd6soQwDo1dbZY9qsUWrKDGV9QUVB
 8JUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718036625; x=1718641425;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MmJqXEo/cvQTcJBBQgnUyi4Q/sMvVbORelXofEHlP2E=;
 b=nLl8Gmr6l6TLizOeWZg8ZfEgodFPD2dG85vnh89mS3p91oAIVqYBANjp7VQF2rJj9Q
 YcxvBTD7SAoWPqbAc/XxFEUJAhPCu3XXsOgROD1z53CV+iC5AuRJlI/4yQDmr92PxHMR
 jXaaxKgNrM/Csmfail2jH48oTsAEkbke1UAXhczDPnyMR5L+/EYJfZTl1voSPf7YXemd
 GMZKGG/mwdpgojPPBs2zYC8P4y/ZurbaEMwuo/MNAmJKLaGYwr8Q+SWY4bMnM5Wkk6gJ
 VWsC3UrAdRi7qmaeTz+NSFD1f3jZTGTATcwsINdjZgxLPFeusN4k1LKoW0HUNUOelUY2
 jRrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0ujl9Zzkc1ohurk6plXL8tq0ElgIUb42Z5lt4m2u8CTAFzAoyWnjEPedWAoPWmJU2Si6/6pDtxaCtate0rXLVzPAxCJY=
X-Gm-Message-State: AOJu0Yw1r3cVt1+vyguy/ebNXOeCWnO7qv6/LyjIp5n546fHkmePb6ov
 wxwDth1zhPp3QAlIKBRMT7HQu2oUrivjFKUIaVQDeLg5OjPHBrj9bjMlyGgEjmk=
X-Google-Smtp-Source: AGHT+IGzVnQ/niUpJVG8O37nBThXlWypkVF3WQzftlOup8tlm+ZU1BX4gs1RLV6DgznkvJN2I+ls2w==
X-Received: by 2002:a05:600c:3d86:b0:421:81c1:65fa with SMTP id
 5b1f17b1804b1-42181c1661cmr42193745e9.13.1718036625372; 
 Mon, 10 Jun 2024 09:23:45 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4215c2a6225sm147250405e9.25.2024.06.10.09.23.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jun 2024 09:23:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 0/3] hw/arm: Create second NonSecure UART for virt board
Date: Mon, 10 Jun 2024 17:23:40 +0100
Message-Id: <20240610162343.2131524-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
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

This is v2 of a series I posted back in October last year:
 https://patchew.org/QEMU/20231023161532.2729084-1-peter.maydell@linaro.org/
At the time I wanted to wait until EDK2 had been updated so it
didn't behave weirdly in the presence of a second UART. That
happened at the tail end of last year, but I'd forgotten that
we never committed the QEMU side of things until Laszlo kindly
reminded me a few days ago. So there are now no blockers to
getting this patchset into QEMU.


For some use-cases, it is helpful to have more than one UART available
to the guest, but the Arm 'virt' board only creates one.  If the
second UART slot is not already used for a TrustZone Secure-World-only
UART, create it as a NonSecure UART if the user provides a serial
backend for it (e.g. via a second -serial command line option).

We've wanted this for literally years; my first attempt at it
was this series in 2017:
https://lore.kernel.org/all/1512745328-5109-1-git-send-email-peter.maydell@linaro.org/
More recently Axel Heider revived the idea with a patchset in 2022:
https://lore.kernel.org/qemu-devel/166990501232.22022.16582561244534011083-0@git.sr.ht/

However it has previously foundered on the problem that EDK2 does
odd things when presented with multiple UARTs in the DTB. (Specifically,
it will send the guest GRUB bootloader output to UART1, debug output
to both UARTs 0 and 1 depending on how far through boot it is, and the
guest kernel will use UART0 since that's what the ACPI tables say.)

Several things here I think mean we can finally get over this issue:
 * I learnt about the device tree "aliases" node; this allows us to
   explicitly say "this node is the first UART and this node is the
   second UART". So guests like Linux that follow this part of the
   DTB spec will always get the UART order correct; and if there are
   obscure guests that turn out to misbehave, we can point at the
   spec and say "this is how you should fix this on your end"...
 * This patch, like Axel's patch, only creates the second UART if
   the user asks for it on the command line, so any pre-existing
   command lines will not change behaviour.
 * Laszlo Ersek has kindly written some EDK2 patches that rationalise
   what it does when it finds more than one UART. This means that
   we can tell any users who do want to use two UARTs with EDK2
   "you should upgrade your EDK2 blobs to version NNN if you want to
   do that". These are now in a released EDK2 and QEMU's EDK2
   blobs have been updated to a version including these changes.

Changes since v2:
 * rebased (the search-n-replace patch 2 needed some minor tweaks)
 * updated commit message to patch 3 with details of which EDK2
   release you need for second-uart support

Patches 1 and 2 have been reviewed; patch 3 needs review.

thanks
-- PMM

Peter Maydell (3):
  hw/arm/virt: Add serial aliases in DTB
  hw/arm/virt: Rename VIRT_UART and VIRT_SECURE_UART to VIRT_UART[01]
  hw/arm/virt: allow creation of a second NonSecure UART

 docs/system/arm/virt.rst |  6 ++++-
 include/hw/arm/virt.h    |  5 ++--
 hw/arm/virt-acpi-build.c | 22 ++++++++++-------
 hw/arm/virt.c            | 52 +++++++++++++++++++++++++++++++++-------
 4 files changed, 65 insertions(+), 20 deletions(-)

-- 
2.34.1


