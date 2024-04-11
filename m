Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D8ADCD1284
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 10:18:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rurTc-000519-Dw; Thu, 11 Apr 2024 06:16:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rurTL-0004x5-Jb
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 06:16:10 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rurTI-0007Rf-4b
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 06:15:59 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-417d14b3b29so4420105e9.0
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 03:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712830553; x=1713435353; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DYu9NeN6C15PoB5yWPnrDM1Qg3VSjQOVFu4GcSZeT34=;
 b=Cx3RV9w8wW+GAi+XbsX7x/6b4qcdxcuyoOH1t6BI+h7gSUAUerFu/oNjoAuM8NLAtG
 f6U6YRZWNcaaQzLXoe69uEFIDhrD8NU45NslJXJmEo2/MZV/20ZPvU94Rsu0g7X/35t5
 nq4JZ6AsC7nKeTSTj1+L3GDOQEk02p+PlJ2gopVWHSKFQW8BnFNGexlwU8uKXdgzxwxv
 RPALybwWTfTGlN91JFk4+GnNE+tAU061KZy61nEw8bG/OQ8nRGDXDlf55ELHXchXc+ZK
 K1cr5890Yi/NEHjRgEBMvDz2zgdLoyV7g2W/DD9j8DDu50XcowWysYyN76A++AeHJxwG
 8UBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712830553; x=1713435353;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DYu9NeN6C15PoB5yWPnrDM1Qg3VSjQOVFu4GcSZeT34=;
 b=v1Dhgf0njb0kAGU+1WUA2UAUCarI1kPVdR9/cBoWC/9rhsL7v+A8qgC0TlNHbovT6n
 96dL/uc4HL6Bjez6z5bQNSlrLHAJeARgEzjn5Y/D5YP9ruhMIZejzOMjP4t5KnRb8VXo
 35xKKtProUcOLuZ3JZrz5ZRfjIrD0JCUUxt/idp7FMBCdVrdRqnKNaSJiRmKMuK4GG0v
 7aHTpS6YW/Nk9ELCZQtNYPMWc7NhQq11LMuxMD4UPdAlPjlhxwfiW6yR+i9XJZV7Njpp
 s8H3pqNoUiAQc4Ib37xEvoyoLukviiErtxG6th/vy3pNb6lWN4yFdL2ufP0XqsZ4AuIV
 vkIw==
X-Gm-Message-State: AOJu0Yxrzyb2P/lGp42C0vEFxIxIzfowJNlzQIHiOIqc5Vt8ea4EQoL0
 JKjHv6Rk9G5J+NjPly/0JuNhXMFzhWKdIvW+qgr5WyycwJPxUfbvwlly8FJPBHeTtxt+2ehJzjj
 rwgQ=
X-Google-Smtp-Source: AGHT+IGfgM4NHsDiXCi+A2tAf3CuQHSnVnG3nzYQJQ/yrV2P9p1w41Q0djsjgQVl9Cm8951JPsJ1xQ==
X-Received: by 2002:a05:600c:4f95:b0:416:b650:cefe with SMTP id
 n21-20020a05600c4f9500b00416b650cefemr4789263wmq.14.1712830553135; 
 Thu, 11 Apr 2024 03:15:53 -0700 (PDT)
Received: from localhost.localdomain
 (137.red-88-29-174.dynamicip.rima-tde.net. [88.29.174.137])
 by smtp.gmail.com with ESMTPSA id
 he8-20020a05600c540800b00416a08788a5sm5055032wmb.27.2024.04.11.03.15.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 11 Apr 2024 03:15:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org,
 Philippe =?unknown-8bit?q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 00/13] misc: Remove sprintf() due to macOS deprecation
Date: Thu, 11 Apr 2024 12:15:36 +0200
Message-ID: <20240411101550.99392-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Since v1:
- Use snprintf() in patches 1-5

Hi,

sprintf() is deprecated on Darwin since macOS 13.0 / XCode 14.1,
resulting in painful developper experience.

Suggestion to avoid the super-noisy warning on macOS forum are [*]:

* use -Wno-deprecated-declarations on the whole build
* surgically add #pragma clang diagnostic around each use.

None of these options seem reasonable, so we are somehow forced to
spend time converting each sprintf() call, even if they are safe
enough.

I'm so tired of seeing them than I started the conversion. This is
the first part. Help for the rest is welcomed.

Regards,

Phil.

[*] https://forums.developer.apple.com/forums/thread/714675

Philippe Mathieu-Daudé (13):
  ui/console-vc: Replace sprintf() by snprintf()
  hw/vfio/pci: Replace sprintf() by snprintf()
  hw/ppc/spapr: Replace sprintf() by snprintf()
  hw/mips/malta: Add re-usable rng_seed_hex_new() method
  hw/mips/malta: Replace sprintf() by snprintf()
  system/qtest: Replace sprintf() by g_string_append_printf()
  util/hexdump: Rename @offset argument in qemu_hexdump_line()
  util/hexdump: Have qemu_hexdump_line() return heap allocated buffer
  util/hexdump: Replace sprintf() by g_string_append_printf()
  hw/scsi/scsi-disk: Use qemu_hexdump_line() to avoid sprintf()
  hw/ide/atapi: Use qemu_hexdump_line() to avoid sprintf()
  hw/dma/pl330: Use qemu_hexdump_line() to avoid sprintf()
  backends/tpm: Use qemu_hexdump_line() to avoid sprintf()

 include/qemu/cutils.h   | 17 ++++++++++++++---
 backends/tpm/tpm_util.c | 24 ++++++++----------------
 hw/dma/pl330.c          | 12 +++---------
 hw/ide/atapi.c          |  8 ++------
 hw/mips/malta.c         | 23 ++++++++++++++---------
 hw/ppc/spapr.c          |  2 +-
 hw/scsi/scsi-disk.c     |  8 ++------
 hw/vfio/pci.c           |  2 +-
 hw/virtio/vhost-vdpa.c  | 11 ++++++-----
 system/qtest.c          |  8 +++-----
 ui/console-vc.c         |  2 +-
 util/hexdump.c          | 33 ++++++++++++++++++---------------
 12 files changed, 73 insertions(+), 77 deletions(-)

-- 
2.41.0


