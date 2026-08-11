Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B328C5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 14:36:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtnZy-0008WL-JL; Tue, 11 Aug 2026 10:35:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1wtnZx-0008W3-Av
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 10:35:45 -0400
Received: from mail-qv1-xf34.google.com ([2607:f8b0:4864:20::f34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1wtnZv-0001oN-Or
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 10:35:45 -0400
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-8ee88fce572so30623736d6.1
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 07:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786458942; x=1787063742; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Ju4k6Uw6J7STjyBdAmgWYqFJGwIyD69LG9KPLzGDOjQ=;
 b=XLk8RtfdQWWLAiK5kCbclutpH3/bzbjY2hgmIqTLlowtj/zt8iI3eUUCmw7XwMH5IU
 8fkYie+9n3qpDIytOn/penvZ14wYYoha9ZZbKtS1RSbxWwuXY09yFl+adnoqbCxSMTXP
 +T8FMFsyzhRA7bLrB7Y7zizLYacC3vNHOZPEr8Nqf2fUke6sWpfvbgs+Vq6ureQHn11V
 Dk3Y06FsQJTKSRxw6xzQQ3rKApNP6DA0Kdn7FII98HyLIzedG6CFYF4LBgojyT/mgcIU
 Ii3PwGdP/+bsWG/kLl5N9LjN+7tCErlcAVXsWXm6cvDVciqxs9Wb2ybsC2n8ClYd7FeP
 bH8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786458942; x=1787063742;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ju4k6Uw6J7STjyBdAmgWYqFJGwIyD69LG9KPLzGDOjQ=;
 b=miEKSHkd7Hg9DIhuGeWKdjGPE+9sPzltfWF7xLS4k+Ji2Amvp8On3fBPI7X9W52JtT
 UADtHhYzazLsb1jbVn6G0+CyC91XoXu/DOE2V4qmymj/xzxcuJDlTsRXRxS3ApB3Hfqz
 ST+GBhq/iw8JorUJSP9uSY6LTLo7AuTF4ZaT7Rlto3gxMKpBnv5kuk1MJvaFB5IMHh5n
 S+G7fuoumf2vDVMtHUF+fyY60QOFLF4bK/SoO8ZbnQswPcMtu1C68Z72WQs4cQ/mGeyr
 Km1pA3/H8RpV2gdmrjFfhgyQYBO8L7PAsQiiDlEQr1wi8cTTUjZOK0hgt3uANkLob03D
 9wKQ==
X-Gm-Message-State: AOJu0Yzoj5y3Js+Lq2K4ZBivnEL8/EJOXzP5YN2yDLI83i8BmCrkTosg
 T2UUjYS9nrajWM4LofrEnsDW6Xzo3lMjNwkQKJFcjyLgoqNdXCjXap3X5F023Q==
X-Gm-Gg: AR+sD13HFk46MvuYJqQs2zrRgTbVi151tGZ5TurM2sCBN1VBoQdkdlRbL/mIBopCL1W
 6kQCpCo31GsD1UWTe9nvDIpqXz8owXysSpom29uVQfTYQhyfA868PauWvCn1qzQEWuGNAasD6Ld
 SUOIl3Ex1TIO/3UObSM0NE88a39OgFeJYGKS8XuOAm/tFG0LzDLUau/1cnbZ5Qxd3mkCbdN0VbD
 gH8s4QFpeOKqIn+O5drUkluDqHxnEzI4CsCURuJRvzs71P2MZLsedXlM1Ph+SwX40eAjWLGDucj
 oXmL92e3NGSAWPviGPkxjSijAawK5sHKd6lI9qVnsqJp8mpqMAXXqBesTi+p9mVL2mXkMyrbaFY
 /YaqmxLBvBGx+we7oEncmO1E7y2Pnmda8Br4NVN2KCeJ+fE9s+TcN+vYSWO68qg3d5hwYFQOKTy
 Y5yMZCD4wDjHoQ0C0gAapx59cr4Vsr8EL+SqGIM7qR1yU12+LRabuCEFnL3D5n+QU3zHz4xxOE5
 oI2tWw+81Vj9sD/5M8FMnInvA2eaw==
X-Received: by 2002:ad4:5aa5:0:b0:8f5:c166:b418 with SMTP id
 6a1803df08f44-90a667b5011mr28702916d6.11.1786458941975; 
 Tue, 11 Aug 2026 07:35:41 -0700 (PDT)
Received: from localhost.localdomain ([198.16.145.87])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90a6c3ec565sm376396d6.43.2026.08.11.07.35.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Aug 2026 07:35:41 -0700 (PDT)
From: Marcelo Manzo <marcelomanzo@gmail.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Marcelo Manzo <marcelomanzo@gmail.com>
Subject: [PATCH v3 0/2] hw/arm/raspi4b: fix guest RAM capped at ~1 GiB
 regardless of machine size
Date: Tue, 11 Aug 2026 10:35:37 -0400
Message-ID: <20260811143539.7835-1-marcelomanzo@gmail.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f34;
 envelope-from=marcelomanzo@gmail.com; helo=mail-qv1-xf34.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
(--target-list=aarch64-softmmu). All 5 tests in
tests/functional/aarch64/test_raspi4.py pass, including the 4
pre-existing ones (no regression) and the RAM check added here.

v3:
- Folded the RAM-size check into the existing test_arm_raspi4_initrd
  test instead of a new standalone boot, per Peter's review -- saves
  the extra full-kernel-boot the suite would otherwise pay for.
- Trimmed the explanatory comment in the test to a couple of lines;
  the details are in git history, per Peter's review.

v2:
- Dropped the explanatory comment added in raspi4_modify_dtb() in patch
  1 -- the commit message already covers it, per Philippe's review.
- Picked up Philippe Mathieu-Daudé's Reviewed-by on patch 1.

Marcelo Manzo (2):
  hw/arm/raspi4b: fix guest never seeing more than ~1 GiB of RAM
  tests/functional/aarch64: add raspi4b full-RAM regression test

 hw/arm/raspi4b.c                        |  2 +-
 tests/functional/aarch64/test_raspi4.py | 17 +++++++++++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

-- 
2.47.1


