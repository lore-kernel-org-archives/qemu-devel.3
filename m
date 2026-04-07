Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 201BE10F996A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 18:36:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAXkz-0008Vw-6a; Wed, 08 Apr 2026 14:36:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wAXkx-0008Us-Mt
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:36:03 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wAERs-0005Ss-E4
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 17:59:05 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-488a9033b2cso33769535e9.2
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 14:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775599142; x=1776203942; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tV1e/4BFg/wOZsuU2i4w/0jpAg2hYrKYxbHJIAW/kXQ=;
 b=E1AY7g6AaFr0CwmVNbAYw7s3cf1LBTd68dsQsK/YVpsE3X7L0c/4kP3FmBxJi794yu
 pnLzI24GOcXWYFMERCOEHySkbzoHbk3AdlhVCfw3W86cZG3Ri7Lsh+GSyPoklMhzDi6L
 ck7ba5uWmD8kmLA5UBWRYEaPbpLPiBjh2PbpGLhuPXyJwOvn/hCNc/pWcpQUaT9Y5tuO
 t8ErBHC9HfGKE/bZgzKu2ccUEEd69H2Z4YzZbtXYgilyVwoz0zWdgrRVbn+6kfeUZYhC
 rqQQHarRT9MC8ZmOM4RaChWfdFSrRF64iAfYNxM1w15L1OmwEQNI0mFA1o320O7cU06o
 EpMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775599142; x=1776203942;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tV1e/4BFg/wOZsuU2i4w/0jpAg2hYrKYxbHJIAW/kXQ=;
 b=AKucISli6jcdU7gybNWIvZ1aGjkCe2PmAlFKjA8+DyMPrys2K25SsgxeBSi4GxBWni
 +4j7kiFnQNpYsONCqdOY6WhZs4GsYEKUJ57gEOeSltHdllcewV8UO3lP7/VuWvTSucAd
 tiKh/zTmqHu3zsQgZu6oUuuNQ+JK3aqumBbGSAfX6a8u+oAo4DTJGKl5a7gfwnu4eJHJ
 Wmh9Mm5G48LiD34cjD/nL0eZkxbMRTHCgOzVZSVSInmtHA5EmMqgqv3pWROyLzp6NbEJ
 Z0xJZcmngYXe2h3cB7+D9XDW2E0TRDr2RUignNzCnDS7j/YL5suBTBoWgc/l4TCP2Dhs
 HHFA==
X-Gm-Message-State: AOJu0YwnK2iEbjCVoVyZjr4A3E7iAApx5htrSCFlEorsJRE8B05W0veF
 dve1r/skPWGjKc9Ls68z/0vogt6MYBzTd/M9vdNUwNWaK/1glk0RX2sxXQyUa6EE4zNG0hxs/YT
 GNh2COu4=
X-Gm-Gg: AeBDieurksO9GD1q64KJyuNNNNGzQc50XkiUuX7KG+4h5NaRU6U40Z2rk+y2rdSka5v
 IY3KqOI62e5462OWZVWW/TYK3baUHKKEHT0LjDSRA6T1o8w2RwAZmzfqekhd5Zne9SYbyJe1eSj
 2ZUtJCY+w4BIc4HSzUASht/e3SulNVt6ocI/xb0ZeBwsxxoFfh3w2WcVBhd798aG+h70HTXS9Z7
 2oQrLAT6wHxiUHr/TWv04Txy501fAV8YrZcmtQDPBxGoi/fdkM5OdrZoDq/KJd63mMpsLfrVY+5
 vI7tNn370bdTg22BQAqohXdkb9A4I+WAt8D06+3iFFqLWrJgAn4pw1N6O8tsvRKfMKSi4yZbm1I
 HIPpM+bjjtCne1tdpFGAxxVj3Hm5qJlBlm9IubG99ksF9x2uo+rgYamRrDhiBYcrCV/Q+C3agFn
 GFi2UTNuAwVLgjXIj5IVvJ0fF0JxYEr7e42mXkvpr2x74rJPFo8jT3d7a26PcVMbYYbmmtZcxx
X-Received: by 2002:a05:600c:4e4b:b0:486:fe83:8621 with SMTP id
 5b1f17b1804b1-488997ac760mr260114425e9.23.1775599142211; 
 Tue, 07 Apr 2026 14:59:02 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887e80a616sm1081974165e9.2.2026.04.07.14.59.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Apr 2026 14:59:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Fabiano Rosas <farosas@suse.de>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH-for-11.0 0/6] Misc patches for 2026-04-07
Date: Tue,  7 Apr 2026 23:58:54 +0200
Message-ID: <20260407215900.63390-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

The following changes since commit b6a7d06213e5d2f7d124d16418bc289c4a8a4b82:

  Update version for v11.0.0-rc2 release (2026-04-01 20:48:02 +0100)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/hw-misc-20260407

for you to fetch changes up to 992e01e838733c8063f8a17e92034c5f35e34963:

  ati-vga: Do not crash on 24 bits per pixel (2026-04-07 22:40:29 +0200)

----------------------------------------------------------------
Misc HW patches

Few fixes, mostly for VGA display models.
----------------------------------------------------------------

BALATON Zoltan (4):
  cirrus-vga: Make frame buffer endianness little endian by default
  ati-vga: Fix setting CRTC_OFFSET
  ati-vga: Update mode on CRTC_PITCH change
  ati-vga: Do not crash on 24 bits per pixel

GuoHan Zhao (1):
  hw/arm/omap_sx1: map CS3 at the correct base

Philippe Mathieu-Daudé (1):
  docs/about/removed-features: Replace 'since' -> 'removed in'

 docs/about/removed-features.rst | 32 +++++++++++++-------------
 hw/arm/omap_sx1.c               |  2 +-
 hw/display/ati.c                | 40 ++++++++++++++++++---------------
 hw/display/ati_2d.c             |  9 ++++++++
 hw/display/cirrus_vga.c         |  2 ++
 5 files changed, 50 insertions(+), 35 deletions(-)

-- 
2.53.0


