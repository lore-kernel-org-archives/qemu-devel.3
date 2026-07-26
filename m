Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8220BC531C9
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 14:41:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wo02Z-00038Z-VI; Sun, 26 Jul 2026 10:41:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1wo02X-00035a-VJ
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 10:41:17 -0400
Received: from mail-ua1-x92e.google.com ([2607:f8b0:4864:20::92e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1wo02W-00050k-9M
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 10:41:17 -0400
Received: by mail-ua1-x92e.google.com with SMTP id
 a1e0cc1a2514c-966eabad303so360295241.1
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 07:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785076874; x=1785681674; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=G4V9XY94ovym+5Cnyt49gIvgAQYwYCxslJfMeTimWUY=;
 b=Ofa7WY+tAeXvmQYmUswicnGeml6NcPSl+cMVJe/4tN4o3XEu05+z7aX9kwHAXBFZpP
 FrOgyIJewbcjGWNhfPvOr8uLc1reXTrzbQQveeFmK8o4qcIdNd6BY/yvTIvKde20rOoG
 0WMVY+/J3wf8YFHF1iZ4bOQqcWhVfiI7JDdKqxvLBjNcGWWS+eSjtTYrXm0a0ze/bcTd
 jlvKxBhgtL3SoI81iBnBVq4+L6nnNfKGpCG5QvMbSJ2vaVRuoP6JcUqVTXSQSWRZvuGE
 XW5ZvD6XRH8CSTEzvCYPdlaBwJiQefm0jpxNRaZFd2gfTIvopATcJe0K1d4LxI86S29X
 Rslw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785076874; x=1785681674;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=G4V9XY94ovym+5Cnyt49gIvgAQYwYCxslJfMeTimWUY=;
 b=Zbh2MY3FK08Z70mMGaiXHmhQnxHT8b5abiBF9Xlfgkd1CbTMkEzLh01hXrtkfFfH+c
 J8NA+aLVdtOoAXNmxUZSXSmcw0qjTujpO/pqEsXLvBQ5cKZiabUForw2KdC/+qpY7Flk
 JlOGcFUK9qIGN4fvz1k4wF/jMba9MMYEWLyIBzLfkNgWyuydoNm72yVfaUyKEcj+1Nb/
 14bg6ZjXM4AmamM4Y3ehHrjeCKMxCFFgQgU9ba+rfGXq6MWXs8xfcsZxUp8f3VUmMxmJ
 axqonNT/GFxS5qrTRhQpZGXgY3QUiWLgdXsrA92FuwrJKqBksPj3SJyKqXPYbCpHLAFA
 +tbg==
X-Gm-Message-State: AOJu0YzdUAsh1RV9VMFg/A6iDwObgbOzf8OEUvaKu+sHRyE6KSLSW6ag
 8FgVcCxrnEUk5RL3E6wWsORIcE+SFkTntyBdITtTBnTo7QUJp9fSr4IWLXV8TA==
X-Gm-Gg: AR+sD12S1yf2CqXmbGwoRMGnpSARu6lCnNqjxpErHfhp7DRYqWEWBr3+aA0/n7x0a/D
 Uh7fdYJnAa1o+euwJ17sXgkzlf7+NxVqiB/czMJjWLx4nWImTjv7X5cQGZ8wHV6sRnZ1F1Qm8Ln
 z6RDcxH7264TFrMBRggOum1YQRUAeh72qkPNgr2W81qXsusFadQYFVCGlXN+rcMZ0YzX0L5U/AC
 DBsjhWo2LZyiqr9A6ds51rcGz9MPJqNq+Ny3PPZc12RdBU98rlYtXgNWHaGU08MfYfCTjgOSWuv
 NXr+ig4y2XBIco4IVgz5x9+C/ar9gqH0kHICaMIQTsH7w/fNhnM2WeNEn+GUdBXJYoNhdYNhxYU
 ZCW6YTTKYHgkPsd2U+wjTWzrPG2d8ARRXOgBKUo2KoK9cKFR+yd8tpVumlBeSwRhd74kEmXCEwA
 Bo2t9oVfZ9sv04VVOX1DNpJdzLt6oVLk6A
X-Received: by 2002:a05:6102:54ac:b0:73e:605c:405c with SMTP id
 ada2fe7eead31-7503e874670mr2844892137.12.1785076874400; 
 Sun, 26 Jul 2026 07:41:14 -0700 (PDT)
Received: from localhost.localdomain ([146.71.8.128])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-7503436f542sm3682735137.4.2026.07.26.07.41.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 26 Jul 2026 07:41:13 -0700 (PDT)
From: Marcelo Manzo <marcelomanzo@gmail.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Marcelo Manzo <marcelomanzo@gmail.com>
Subject: [PATCH 0/2] hw/arm/raspi4b: fix guest RAM capped at ~1 GiB regardless
 of machine size
Date: Sun, 26 Jul 2026 10:41:10 -0400
Message-ID: <20260726144112.56321-1-marcelomanzo@gmail.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::92e;
 envelope-from=marcelomanzo@gmail.com; helo=mail-ua1-x92e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

While working on unrelated raspi4b issues, I noticed the guest never
seemed to have as much RAM as I'd given it and tracked it down to
hw/arm/raspi4b.c's raspi4_modify_dtb(): it decides whether to add a
second memory node above the 1 GiB peripheral hole by checking
info->ram_size, but that field is the boot loader's RAM budget for
where it's allowed to place the kernel/initrd/dtb image, itself always
capped to at most UPPER_RAM_BASE - vcram_size by
raspi_base_machine_init(). Since that capped value can never exceed
UPPER_RAM_BASE by construction, the condition was never true for any
raspi4b configuration -- the second node was never added, and the
guest never saw more than ~1 GiB of RAM regardless of the machine's
nominal size. board_ram_size(info->board_id), computed one line above
in the same function, is the value that was actually needed.

Patch 1 fixes it (one line); patch 2 adds a regression test.

Confirmed via direct measurement inside the guest ("free -h" /
/proc/meminfo) on raspi4b's default 2 GiB configuration:

    before: MemTotal:  943524 kB (~921 MiB)
    after:  MemTotal: 1905824 kB (~1861 MiB)

Also verified against two real, unmodified Raspberry Pi OS releases
(Debian 11/Bullseye and Debian 13/Trixie): both now report ~1.8 GiB of
usable RAM instead of ~900 MiB, with clean boots, working SSH, and no
kernel errors on either.

I also looked into extending this to raspi4b's real 4 GiB and 8 GiB
hardware variants (real boards exist in 1/2/4/8 GiB configurations),
since board_ram_size()'s encoding already supports arbitrary sizes and
this same bug meant the necessary split-memory-node path had never
actually been exercised at any size, ever. 2 GiB now works cleanly
with this fix (tested above); 4 GiB hits a real kernel panic
(`kernel BUG at arch/arm64/mm/mmu.c:192!` in early page-table setup,
addresses landing in the BCM2711 peripheral region around 0xfc000000)
that looks like it needs the "high peripheral alias" real BCM2711
firmware sets up for boards with enough RAM to otherwise collide with
that region -- out of scope for this series, so I'm leaving 4/8 GiB
support for later and keeping this fix minimal.

checkpatch.pl is clean (0 errors, 0 warnings) on both patches, and the
series builds standalone from a clean worktree
(--target-list=aarch64-softmmu). All 6 tests in
tests/functional/aarch64/test_raspi4.py pass, including the 5
pre-existing ones (no regression) and the new one added here.

Marcelo Manzo (2):
  hw/arm/raspi4b: fix guest never seeing more than ~1 GiB of RAM
  tests/functional/aarch64: add raspi4b full-RAM regression test

 hw/arm/raspi4b.c                        | 14 ++++++-
 tests/functional/aarch64/test_raspi4.py | 51 +++++++++++++++++++++++++
 2 files changed, 64 insertions(+), 1 deletion(-)

-- 
2.47.1


