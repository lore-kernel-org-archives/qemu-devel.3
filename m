Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C335C5DF7E
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 20:55:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww4KK-0006XP-Bu; Mon, 17 Aug 2026 16:53:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1ww4K9-0006Vd-RJ
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 16:52:50 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1ww4K7-0006dx-7i
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 16:52:49 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-47362928f65so3736225f8f.2
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 13:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1786999965; x=1787604765; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=YvUPaKQQgjPVD+IsTphAHv+sRXoPnww2/iJNAC6pq3s=;
 b=gZ+B7/zSLlgY2cQCFFXnOipz2Z55cmMvtCTw2s5FIIACtQ839S2xiUoSNig8GVTHyk
 4ZIT5dibRo2n536XawgctMkab+LeUlQUzT1r3xYtrG4uJb76cIaJnpBvQuPvzmym/uCA
 UlCiC9ShqPKao9h138L8M0GNaWiXXjSWHzWmcXOBhDyEpfYo/QjvXOf9TtHuKm6p5kBV
 kQnRuzMBu4mukLtqyZjdCeDHFzA4yzPe/fUJR0iqfuEBGQ3cz9vItDyPvwSF1scdt4Hn
 qsWS0RTyheEu8HlYBIEAu5BMpnz5Boc/uya6SWNt69wKiivBclmBVYqr4SveOKWqpuoq
 O/Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786999965; x=1787604765;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YvUPaKQQgjPVD+IsTphAHv+sRXoPnww2/iJNAC6pq3s=;
 b=eyxBidBd9tpdJaM9WHqK6cyGCItoZ1yzv5V0CdheLW6vgsFMla66JDWHa6tJyX7kU5
 KoB1Cw+pT1YJJnTQl8wFo6ltEflQNaBfOuknhucBF4a0hnpqOoJMBu7et1zTvRKfKm6y
 7fmxx7gy7XerEl3UFcnMnYYAZ4hGXojhXRQel/CZYB/ZyITloqWgIeP0p8itCxy1TuCw
 2npv+5F8LX4QXj3yhD4+Ya9MTxVQpTixD161Fqd+ScXsAV8D8GaNdHaZXZ/E/kM+Nhux
 KRMmvo1DMFLetmZEZsKBbDu5KMMY6dFhNMKUopT7QqwKKffW1enegaqfgyRU836OqekM
 rrpg==
X-Gm-Message-State: AOJu0YxUii/AbnfJqswUj+OYKECljDdbEqCAw1SKPj6JjLhQ2FZjH1QS
 9eYgJv6KjASxUvENMlIax2cfHtZhMjmtDgoRsBsboG+HYxlz0gSCxyEZg7q+b/X5CwdWt5AL+uj
 L/70p
X-Gm-Gg: AR+sD10CaWbbBV3TbQWu1KULjyhdDGQAz9Yb5lCi5ryxTT/74ba6fD2Ci8nNvJv7PKh
 cxcj0fGBkyxW8jfd3E1cD8gRTg1+cE52yQAP1Nf8BynfIbEDkdy7M4rjKmc2qrKJB89KxU3Xft3
 KfNZP4O21LbdoRnYayuV7Zqf6LxozPjeKWmOE87O+4zoR4r/Ukwy+gwcs85mANCbezxSc1BbOAO
 WxcqyVEXMCJdO5FRM/DBQstdVwz3KCy8SRaDuIGJLf/fT+wEiPuRMLYWVpueGt3q13MSPnQC4fP
 dRkpjbEYtBmSN1qfZfDJtVk+XlSjw2jOdc01FnAJjGudUiC1qj+QHHHjP8e2YdTvQvW1LrsMJgb
 onIl6LdHR2CSg8oTUEDXtZJeR3p391XbMM6ukJPoOm1/Mi9bXBMX3r+3wUKCQMTRnWaW/j6VcNj
 qqMYiRFvKvMa0EdksycxtNjqFgIU5jE1nGtrwMYq1HZNPNRGLkj+s=
X-Received: by 2002:a05:600c:468c:b0:495:52a5:8829 with SMTP id
 5b1f17b1804b1-4999fb6d4d8mr35187345e9.11.1786999965252; 
 Mon, 17 Aug 2026 13:52:45 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:f6f8:884c:b162:eaeb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499961098cdsm202573365e9.6.2026.08.17.13.52.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 13:52:44 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 00/15] hw/ide: fix the logical CHS translation a guest selects
Date: Mon, 17 Aug 2026 22:52:27 +0200
Message-ID: <20260817205242.1199851-1-den@openvz.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=den@openvz.org; helo=mail-wr1-x429.google.com
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

INITIALIZE DEVICE PARAMETERS lets a guest replace the logical CHS
translation that turns the CHS registers into an LBA. cmd_specify() has
implemented it since 176e4961bb33, released in v7.2, and the geometry it
stores is mishandled four ways.

It is not validated: zero sectors per logical track kills QEMU with SIGFPE
in ide_set_sector(), which is issue 2399, and since handle_cmd() takes the
count from a 16 bit field of the register FIS, an AHCI guest can drive
ide_get_sector() into an int overflow as well. It is not reported:
IDENTIFY DEVICE is built once and cached, so both the words describing the
default geometry and the words describing the current one go wrong. It
does not travel, leaving a migrated guest addressing the disk in a
translation the destination does not have. And it does not revert on a
hardware reset, which ATA-5 9.1 requires, so it outlives the reset of the
machine it was selected on.

The two subsections patches 8 and 9 add are the only change to the
migration stream, and both are sent only when the guest replaced the
default geometry. An unaffected guest migrates to an older QEMU as before;
an affected one now fails the load on the unknown subsection instead of
silently addressing the wrong sectors.

Tested with ide-test (25 cases), ahci-test (74), a full make check, a
clang build, and real guests on both controllers: FreeDOS reading a FAT16
disk through INT 13h CHS, Red Hat Linux 9 whose 2.4 IDE driver prints the
geometry it read, and Ubuntu 26.04 over libata, each with a CD and a disk,
plus a machine reset in the middle.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Cc: John Snow <jsnow@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>

Denis V. Lunev (15):
  hw/ide: reject an unsupported CHS translation
  tests/qtest/ide-test: cover a CHS translation with zero sectors
  tests/qtest/libqos/ahci: allow a count and an expected error
  tests/qtest/ahci: cover the sector count of INITIALIZE DEVICE
    PARAMETERS
  hw/ide: report the default CHS translation in IDENTIFY DEVICE
  hw/ide: keep the IDENTIFY DEVICE current geometry in sync
  hw/ide: restore the power-on device state before loading
  hw/ide: migrate the logical CHS translation
  hw/ide: migrate the power-on defaults revert flag
  tests/qtest/ide-test: cover the CHS translation across migration
  tests/qtest/ide-test: cover a rejected CHS translation in the stream
  tests/qtest/ide-test: cover the IDENTIFY DEVICE geometry words
  hw/ide: revert the CHS translation on a hardware reset
  tests/qtest/ide-test: cover the CHS translation across resets
  hw/ide: drop a redundant interrupt from INITIALIZE DEVICE PARAMETERS

 hw/ide/ahci.c             |  12 +-
 hw/ide/cmd646.c           |   2 +-
 hw/ide/core.c             | 141 ++++++++---
 hw/ide/ide-internal.h     |   7 +-
 hw/ide/isa.c              |   2 +-
 hw/ide/macio.c            |   2 +-
 hw/ide/mmio.c             |   2 +-
 hw/ide/piix.c             |   2 +-
 hw/ide/sii3112.c          |   6 +-
 hw/ide/via.c              |   2 +-
 tests/qtest/ahci-test.c   |  40 +++
 tests/qtest/ide-test.c    | 499 ++++++++++++++++++++++++++++++++++++++
 tests/qtest/libqos/ahci.c |  14 ++
 tests/qtest/libqos/ahci.h |   6 +
 14 files changed, 687 insertions(+), 50 deletions(-)


base-commit: 9696bf5dc5a5bf0b4a9d05b6cdfe5f13990f97aa
-- 
2.53.0


