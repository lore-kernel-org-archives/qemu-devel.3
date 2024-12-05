Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F6F5E77170
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 10:56:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJ9WQ-0005QJ-VD; Thu, 05 Dec 2024 05:55:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tJ9WP-0005QA-DK
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 05:55:49 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tJ9WN-0002qD-JO
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 05:55:49 -0500
Received: by mail-pg1-x543.google.com with SMTP id
 41be03b00d2f7-7fcfac22a30so846466a12.3
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 02:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733396146; x=1734000946; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+Sg9Bf0uEM+6jmwHeQI7G0jHZ7j06qITo+dro1HL79Y=;
 b=FhUEdKMuXhNPMPysUJPUYjFp8VSl9uKOiqN8RYCctfyx9rebSXGsXZKHSXZfAP7u39
 OpbfN1HlCuPiOUFStInI8kCBy+8cZnwzJqbpxlRK6yYfsek4LESPjs6FZ4c5LvYa8LA0
 7peMUeLVKtmA+55v0vSli/383f6BUd+C7gYj5ESoFwVdRVTCLIzvZoQyk8INLN6Keula
 kRsuPPcs1UgOaaYMsdouOgNxTdf8hfs2wV43tiGbhdZ1wBGgFl6XYrZbpKoE28TVa3NL
 QL1aImRW6ZzaafzlsA8jSrHPB901kASNwBMo9/50v5Do62Z07MP3Wwe+8s/i2eZXCUSN
 eWLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733396146; x=1734000946;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+Sg9Bf0uEM+6jmwHeQI7G0jHZ7j06qITo+dro1HL79Y=;
 b=ZjBm7YpL1vpEqY/JXvXl5syt9bl46Y5bWUgIZ/IrhquiW1lVOfEKsn2ZvuBSrq+Jsn
 sPrRSyc7WFJAan58TQlPsqLnmpy9hLxSBIOP+GX10aSUwTT/+uCYJiT/CyA8VQNDBP5u
 7Ilq91UtdLY5tVVZqeIDjxmpK//N1rt8izf8CdwQTPHtsVa/jysjS4egvJNOGn5k9zou
 wL6Ix0eM44sskrBo4gbSvcnn1y3zkKsL/DQc5Gam64n8psaEv3ohSp6u0E/GW+DGG3xi
 Jnfv2zadpLeJiKDqysAg4Rv3oOv2Xor+VpBftInX2dXNp2krA/V33rK98vn5jNJIyPCT
 gr4Q==
X-Gm-Message-State: AOJu0YwpkiLCIfsKEwNfiXI6Pm8kN5KiQbAU5ECweiLDcTEFTSTXl9OY
 FT0zcW2gtVrA9d7SBdsD/I5AQvQ0VtyMPDBqEtWvyO7qL9nAMx2hQMmn+zHULw==
X-Gm-Gg: ASbGnctBMS8758BUTkUCRhD5XXlpUTFW6DYMF35IRhmlsf4gXQ310lba1f6dDcyk/F/
 v+PG71+kabUkYwoABh7Jne09jg9luCKYXidWouY80gVWI3ank3+c2OR3xlepwr61sAJTyDostp5
 YyG780pMXz6sYpq60LjJbSyVBuMdpxOELq4XpdAakbyLpjSwC2ywoLvw4gcgetqCg+E2seVqjQJ
 AiNUOTPbbwbQKkD7W0khd4BRUX98PPOisfaYJnaqm5ppx2U5iSfCKgLCA==
X-Google-Smtp-Source: AGHT+IF4iGgHrfG+hhn60/bQBraNoPiUicHOI3o2n+meaYQhkeCkwjUy2roHCAQGVErgYY1duz0KZA==
X-Received: by 2002:a17:90b:3c84:b0:2ee:b2be:f398 with SMTP id
 98e67ed59e1d1-2ef011e4904mr14456440a91.2.1733396145801; 
 Thu, 05 Dec 2024 02:55:45 -0800 (PST)
Received: from kotori-desktop.lan ([58.38.120.33])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-725a2ca6747sm1010905b3a.149.2024.12.05.02.55.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 02:55:45 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH v3 00/10] vfio/igd: Enable legacy mode on more devices
Date: Thu,  5 Dec 2024 18:55:25 +0800
Message-ID: <20241205105535.30498-1-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pg1-x543.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This patchset extends the support of legacy mode igd passthrough to
all Intel Gen 11 and 12 devices (including Ice Lake, Jasper Lake,
Rocket Lake, Alder Lake and Raptor Lake), and emulates GGC register
in MMIO BAR0 for better compatibiltiy (It is tested Windows and GOP
driver will read this MMIO register).

It also replaces magic numbers with macros to improve readability,
and aligns behavior (BDSM registor mirroring and GGMS calculation for
gen7) with i915 driver to avoid possible issues.

The x-igd-gms option removed in 971ca22f041b ("vfio/igd: don't set
stolen memory size to zero") is also added back so that data stolen
memory size can be specified for guest. It is tested that GMS may
related to framebuffer size, a small GMS value may cause display issues
like blackscreen. It can be changed by DVMT Pre-allocated option in
host BIOS, but not all BIOS comes with this option. Having it in QEMU
helps resolves such issues.

This patchset was verified on Intel i9-12900K CPU(UHD 770, 8086:4680)
with custom OVMF firmware [1] and IntelGopDriver extracted from host
bios. IGD device works well in both Windows and Linux guests, and
scored 726 in 3DMark Time Spy Graphics on Windows guest.

[1] https://github.com/tomitamoeko/edk2/commits/igd-pt-adl/

Btw, IO BAR4 seems never be used by guest, and it the IO BAR itself
is not working on Gen11+ devices in my experiments. There is no hints
about that in old commit message and mailing list. It would be greatly
appreciated if someone shares the background.

Changelog:
v3:
* Added new patch to fix GTT stolen memory size calculation for gen 8+
  devicess.
* Fixed quirk index in "vfio/igd: add macro for declaring mirrored
  registers"
* Fixed condition in "vfio/igd: add x-igd-gms option back to set DSM
  region size for guest"
* Updated comments and commit message.
Link: https://lore.kernel.org/qemu-devel/20241203133548.38252-1-tomitamoeko@gmail.com/

v2:
* Droped "vfio/igd: fix GTT stolen memory size calculation for gen 7".
* Fixed conditions when calculating GGMS size.
* Added Gemini Lake and Comet Lake device ids.
* Splited mirroring register declaration macro into a new patch.
* Minor fixes.
Link: https://lore.kernel.org/qemu-devel/20241201160938.44355-1-tomitamoeko@gmail.com/

Tomita Moeko (10):
  vfio/igd: remove unsupported device ids
  vfio/igd: align generation with i915 kernel driver
  vfio/igd: fix GTT stolen memory size calculation for gen 8+
  vfio/igd: canonicalize memory size calculations
  vfio/igd: add Gemini Lake and Comet Lake device ids
  vfio/igd: add Alder/Raptor/Rocket/Ice/Jasper Lake device ids
  vfio/igd: add macro for declaring mirrored registers
  vfio/igd: emulate GGC register in mmio bar0
  vfio/igd: emulate BDSM in mmio bar0 for gen 6-10 devices
  vfio/igd: add x-igd-gms option back to set DSM region size for guest

 hw/vfio/igd.c | 262 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 165 insertions(+), 97 deletions(-)

-- 
2.45.2


