Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6944CCD183
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 19:18:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8O3m-0005eJ-Ej; Mon, 13 Oct 2025 15:18:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v8O3j-0005dI-Az
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 15:18:15 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v8O3f-0001pB-Hi
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 15:18:13 -0400
Received: by mail-wr1-x442.google.com with SMTP id
 ffacd0b85a97d-42421b1514fso2281052f8f.2
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 12:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760383089; x=1760987889; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=/B22OX7oPRVjLf1BerxieKilML3SFOHqoUFJ3V+rE90=;
 b=wpj0a7twQ5/TQDq9uoM4YvRc0C01SHIUon5ZAfjTQnU6WO74ZoDcr7qtf6ju4boAax
 kd46fgDTqzk901JS3YNE6IzxrevTTYRArfX6hzUMjrpkAk/uAUB/0smCWvt9IHzhyMoH
 Tl7Y/Kk/STCXpE4zNLH3TrHot+zEvsfGVj9KnGD7zQzm/pxZp81P6fEfqRORzL4FXhYQ
 LNtNnQsaNK9EMTtXPt9LK7TWRgME9iF7VUj12NylA5VvyyyFS2YIf04vwi3AbGaO4gDI
 sdrFg0aEcNY7APq/v66wTKBmjmIyONjLVTlM9/laW7r+eJbGx9LJF3prrTqkhrL6iIzZ
 /LfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760383089; x=1760987889;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/B22OX7oPRVjLf1BerxieKilML3SFOHqoUFJ3V+rE90=;
 b=aJbrRG7XfB3WuKYFN81LneuWaysH/+OeeyL8WL97n8UJvDN99G8y9RzkP3dpZe9cPr
 srf4gpF8JbasNdkVlj5+RC0KA+Ao/X/b1zdmbesg/DhiropsJVvoObRlpXJ+fVRkWxuS
 QjcqypYRSkQ9qwbYzNui5XY+w9BuAdcqcZyC5OqNVBLSZ+fA0nu5oj8UHWnmGsXX3Tj4
 ztZRl48f1cIAXoU1XX0W6d9zUTUFw2Ulg2PXHfMhUexLR3CBluDCwsLTYMKxdLJN/tIN
 Vm7Jw/cOSn0BTccWLvLRBhh8+V0dJ0enCmOIUVTMZq+CcbWBaNvn0Ir1iHmGs4X5i+rC
 YMaw==
X-Gm-Message-State: AOJu0Yz1Tn3GQWQ+w5fI5kJAKZq7/SE7y7Ckt9sYhtz59qzlXPXxYOTY
 dkZwifb/BcmK8J/VkcK3j/8yIDqvkRssM46fc+Ax3VNq/xZgozYTJjye6/8zt+1YqopG1DCHeBR
 d84UjCvVOvLFD
X-Gm-Gg: ASbGnctbF8V9+wfKWFMuzXjRfJC8yk+tIiFsI0vbhqUFixjKfvcLPEIPU3bVnopJrCi
 TzIdOMH7aRjRHbI8Q3tdTCWevnOLnCzr1vMxmD+VP4KzwmMMIAjLIxMDiuRhiigahh0DDFiR1Q9
 D2DAn6S/jj/yh1dRak93aZWAd+ZM0TSiPJ4QPUCmAalw5L+ab9USScCruJBdXi7ouVKEaBS95fC
 MZir1/ueN9bJmcrOFP9SkzPGS/rYm+kyiEi5kvq5hUStVydoF5EPfLuYOGyP09DreWax7CoddbL
 aA8S23eh0ClnWb4NfG30C/hM3Sh/U3NkRs0olp/5849Ylv2KcwfpsBjnMIfR9l8DG9VKQtaVfV4
 My5N/CO9SUFpKjfNWP5LYfdKS5DTb9poV/zKyTGawU3vEh+N3W4I9Eo672HITdJbzOXDTPT9Kwm
 7/nMPGE3Bb/pKJ8zkoutOLeR2D9g+CKw==
X-Google-Smtp-Source: AGHT+IG2fKnQoYV5EmViCvjMZb2eXkyAHKmhvBY4SVMwyUyTAWPdCKnWxlZQiq8v056F8f2z1eMaAA==
X-Received: by 2002:a05:6000:2509:b0:3e4:64b0:a776 with SMTP id
 ffacd0b85a97d-4266e7df845mr14274812f8f.52.1760383089517; 
 Mon, 13 Oct 2025 12:18:09 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5e1284sm19572199f8f.45.2025.10.13.12.18.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Oct 2025 12:18:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/12] Misc HW patches for 2025-10-13
Date: Mon, 13 Oct 2025 21:17:55 +0200
Message-ID: <20251013191807.84550-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x442.google.com
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

The following changes since commit f3f2ad119347e8c086b72282febcaac5d731b343:

  Merge tag 'pull-target-arm-20251010' of https://gitlab.com/pm215/qemu into staging (2025-10-10 08:26:09 -0700)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/hw-misc-20251013

for you to fetch changes up to 9fedc11ff127636900cc7a0a3e7214e5cb60a313:

  hw/hppa: Reduce variables scope in common_init() (2025-10-13 21:13:08 +0200)

----------------------------------------------------------------
Misc HW patches
----------------------------------------------------------------

Cédric Le Goater (1):
  hw/arm/aspeed: Don't set 'auto_create_sdcard'

Luc Michel (1):
  hw/net/can/xlnx-versal-canfd: remove unused include directives

Markus Armbruster (1):
  hw/display/xenfb: Replace unreachable code by g_assert_not_reached()

Mohamed Mediouni (1):
  hw/vmapple: include missing headers

Philippe Mathieu-Daudé (8):
  hw/ppc: Do not open-code cpu_resume() in spin_kick()
  hw/xtensa/xtfpga: Have xtfpga_init() only initialize MMU
  hw/sparc/leon3: Remove unnecessary CPU() QOM cast
  hw/s390x/sclp: Do not ignore address_space_read/write() errors
  hw/loongarch/boot: Remove unnecessary cast to target_ulong
  hw/hppa: Convert type_init() -> DEFINE_TYPES()
  hw/hppa: Factor QOM HPPA_COMMON_MACHINE out
  hw/hppa: Reduce variables scope in common_init()

 hw/arm/aspeed.c                |  22 -------
 hw/display/xenfb.c             |   3 +-
 hw/hppa/machine.c              | 104 +++++++++++++++++----------------
 hw/loongarch/boot.c            |   7 ++-
 hw/net/can/xlnx-versal-canfd.c |   4 --
 hw/ppc/ppce500_spin.c          |   3 +-
 hw/s390x/sclp.c                |  18 +++++-
 hw/sparc/leon3.c               |   2 +-
 hw/vmapple/vmapple.c           |   2 +
 hw/xtensa/xtfpga.c             |   2 +-
 10 files changed, 78 insertions(+), 89 deletions(-)

-- 
2.51.0


