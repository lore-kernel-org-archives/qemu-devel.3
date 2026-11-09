Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B1F606A322
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 11:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nMbqt8C3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQNfZ-0005MW-9F; Mon, 09 Nov 2026 06:36:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dovankhai97@gmail.com>)
 id 1xQNfU-0005M8-Uf
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 06:36:08 -0500
Received: from mail-dy1-x132e.google.com ([2607:f8b0:4864:20::132e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dovankhai97@gmail.com>)
 id 1xQNfT-0000Er-5z
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 06:36:08 -0500
Received: by mail-dy1-x132e.google.com with SMTP id
 5a478bee46e88-3645f0f3fcdso1478172eec.0
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 03:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794224165; x=1794828965; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=B1itbbT6pnBCg3irCBnvOt04nv+VbPGU8ZVSoihBkVQ=;
 b=nMbqt8C3xY9M9a0lPk4zKY0hqldYhFxlPwfCmhE/AR9uByRY46/EOf5IuekhN8SQjR
 CmeCYNeVtMA9AoWtiF7cgHPDUeFecvUQJB5nNCk4Ogc6xZ5LGHEkS7yoeLNLwHZWblhu
 wIYkDgKKxk+D54L6rN01lWpqcZ3fFgzCqqLSqkqKHJDc6XX84EaTff9ls5dRBZeAj5jl
 uSkiAGwAxRrSJJ7RYEzEHoFEBWEo7XXFIL76XZyCTj6k6NprZC8y+N7JZ/z57DQ5aolC
 aHg6xHvZ0tihkR8qUrcGUFamkLggb5Sor+Odqk4EmNjjIQVO/noVhlFYoWhNijoj0h9O
 OHcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794224165; x=1794828965;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=B1itbbT6pnBCg3irCBnvOt04nv+VbPGU8ZVSoihBkVQ=;
 b=WX6sZ+yj1iacN9ayj1ac+QixPDxgRhIOwqwUBu6J208Sa2a2tOUf/emqm/MPkkDcr+
 krv2SvCln+LN+nkoLvpRlyBlfTI4uXPpwG+8emnz8cuW+U72Dg9zh9Lv3Z5avOfpwOC3
 FDS5Wbc24ppveHpTa42eRtT8sxn0t/QbmQ9FPd++y4TRWg0sTVYfA+DyHktWPFtBrd5o
 58zuvRnS6Mx92hY2I68xlqqXa5bOH6Z40dtap5++oqlVTwPEMGce0cStctmtuHiOzreb
 1CC315MFUBb8FEZqHsdU3lBYNbSKC0mj4VrGE6FC197+znvqpvWXG5FOE3HQX7Asd8SE
 aPug==
X-Gm-Message-State: APuU4Z/sU8JigvJ9RXlUFrrGCTyGskgJMOSnoPgi4hkMxWXYg6FwpNNI
 QW0e0TosG6+KovaOa6Gro6Uf0D2keCooCx53/BxJcA/KaRbdJVwDwVLM5nxnMpyFdrY=
X-Gm-Gg: AYBFou1twT+AmplKfZycrfC46B8SFvAe+qVrpbYFi1LG38IdYoOJcx3M0XBqgCGnptY
 p8Wr2mtKBGxRLwVnZ7qu/EQY/0QfhyqBiV7R5Eca4KxrgUioPWL4p+hdn2OVM4oVK7JhkIkWe/x
 p8KuIdx064msAjxxwZ3uQ3AkKaUFoi/leySJxJGTMNGX9Y0CzsbSMd4te/sGBN37bl/kMfVZMSu
 ceM3k2WpCHLsNpMqnJHvq1G2bOMcmRQ7Jk1KVqMeNNwGAF8cKWn+ZeVVnNh3q27dVATPQajb5Mt
 8lpG3SFf+2neZf/uMXu79mSlFzrmQg4GuCpE3zBEZy1zN6ESIs7GU9tRKNIaMpCjaCz/uE1heuO
 gaY77XkOKv3rK4h33a9Jj8e9NLleImQ9eC5YKCq2T7lq1PdF5rMSmH0aHce8Il74dCpjnRT8Nmt
 WrdApb3j33bKpoY4hEX5HKOsY73Dp4pxOaoB9om/a7w/tO3l85rHmq+6zhSEJ5Z7OHsAn5sOnbN
 4tALtZ8ii/HmRfTBRz6PytLXAKjOVVmaCW70CKTHs5wj95i29uMkYFFxkm6CZsThBfFIwbtCYAr
 cA6005QEkLQPv+T7tSVln577QqfdMrtc
X-Received: by 2002:a05:693c:87cc:20b0:36f:551:2bd5 with SMTP id
 5a478bee46e88-372570dcb8bmr7326035eec.32.1794224164732; 
 Mon, 09 Nov 2026 03:36:04 -0800 (PST)
Received: from ubuntu.lan ([2405:4802:913e:86f0:35c7:7294:a0c3:69b2])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-372660f444csm19762941eec.19.2026.11.09.03.36.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 03:36:04 -0800 (PST)
From: Khai Do <dovankhai97@gmail.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, pbonzini@redhat.com,
 strahinja.p.jankovic@gmail.com, Khai Do <dovankhai97@gmail.com>
Subject: [PATCH v2 0/8] hw/arm: Add Allwinner H618 SoC and Orange Pi Zero 2W
 machine
Date: Mon,  9 Nov 2026 18:35:28 +0700
Message-ID: <20261109113545.18561-1-dovankhai97@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132e;
 envelope-from=dovankhai97@gmail.com; helo=mail-dy1-x132e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This patch series adds emulation support for the Allwinner H618 SoC and
the Xunlong Orange Pi Zero 2W single-board computer (SBC).

The Allwinner H618 is a quad-core 64-bit ARM Cortex-A53 SoC. This series
follows the incremental skeleton design established for Allwinner SoCs:
- Patch 1: Introduces the basic H618 SoC model with 4x Cortex-A53 cores,
  GICv2, ARM Generic Timer PPIs, UART0/1, SRAM A1/A2, and stubbed unimp MMIO.
- Patch 2: Adds the Orange Pi Zero 2W machine with 1 GiB SDRAM and kernel loader.
- Patch 3: Separates the ALLWINNER_SID Kconfig symbol so other SoCs can reuse it.
- Patch 4: Extends the Allwinner SID eFuse controller to support configurable
  capacity up to 512 bytes (AW_SID_SIZE_MAX), preserving backward compatibility.
- Patch 5: Connects the SID controller into the H618 SoC (256 bytes capacity)
  and sets the default UID.
- Patch 6: Separates the ALLWINNER_SDHOST Kconfig symbol for independent reuse.
- Patch 7: Connects Allwinner SD/MMC host controller 0 (sun50i-a64 compatible)
  at 0x04020000 into the H618 SoC.
- Patch 8: Wires up the SD card bus to Orange Pi Zero 2W machine and supports
  loading bootloader firmware via -bios.

Changes since v1:
- hw/misc/allwinner-sid: Use extract32(s->control, 16, 9) to extract the
  9-bit PRCTL offset and return 0 on out-of-bounds eFuse reads.
- hw/arm/allwinner-h618: Set SID size property to 256 bytes (0x100) to
  match physical H618 eFuse capacity, consistent with Linux and Zephyr DTS.
- hw/sd/allwinner-sdhost: Separate CONFIG_ALLWINNER_SDHOST symbol from H3.
- hw/arm/allwinner-h618: Connect SD/MMC host controller 0.
- hw/arm/orangepi-zero2w: Wire up SD bus and support raw firmware loading
  via -bios (e.g. for U-Boot SPL).

Verification:
- The series has been tested using Zephyr RTOS (v4.5) running on the
  orangepi-zero2w target:
  * UART0 console & kernel boot: PASS
  * Multi-threading with ARM Generic Timer PPIs (k_msleep): PASS
  * HWINFO UID reading from SID eFuse: PASS (16 bytes UID)
  * SID OTP driver: PASS (Offset 0..15, Offset 240..255, and Offset 256
    returning -EINVAL out-of-bounds error)
- Tested raw firmware loading (-bios) with U-Boot SPL.
- All patches pass ./scripts/checkpatch.pl with 0 errors and 0 warnings.

Khai Do (8):
  hw/arm/allwinner-h618: Add Allwinner H618 SoC emulation
  hw/arm/orangepi-zero2w: Add Orange Pi Zero 2W machine
  hw/misc/allwinner-sid: Separate ALLWINNER_SID config symbol
  hw/misc/allwinner-sid: Support configurable eFuse capacity up to 512
    bytes
  hw/arm/allwinner-h618: Connect Allwinner SID controller
  hw/sd/allwinner-sdhost: Separate ALLWINNER_SDHOST config symbol
  hw/arm/allwinner-h618: Connect Allwinner SD/MMC host controller 0
  hw/arm/orangepi-zero2w: Wire up SD card and support firmware loading

 MAINTAINERS                     |   8 ++
 hw/arm/Kconfig                  |  11 ++
 hw/arm/allwinner-h618.c         | 247 ++++++++++++++++++++++++++++++++
 hw/arm/meson.build              |   1 +
 hw/arm/orangepi-zero2w.c        | 114 +++++++++++++++
 hw/misc/Kconfig                 |   3 +
 hw/misc/allwinner-sid.c         |  12 +-
 hw/misc/meson.build             |   2 +-
 hw/sd/Kconfig                   |   4 +
 hw/sd/meson.build               |   2 +-
 include/hw/arm/allwinner-h618.h |  63 ++++++++
 include/hw/misc/allwinner-sid.h |   8 ++
 12 files changed, 471 insertions(+), 4 deletions(-)
 create mode 100644 hw/arm/allwinner-h618.c
 create mode 100644 hw/arm/orangepi-zero2w.c
 create mode 100644 include/hw/arm/allwinner-h618.h

-- 
2.43.0


