Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3477DC44509
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 04:09:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjURn-0003O8-TF; Tue, 14 Jul 2026 00:08:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wjURe-0003Mi-JY
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 00:08:35 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wjURX-00086p-2D
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 00:08:34 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-38dfe910e9dso1390779a91.3
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 21:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784002099; x=1784606899; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yFgyz2PuTWXNXdAIxw4+nZ0WFieFllO62m9f0PvmWKw=;
 b=TXL/P4ahVHRwZtUPImikbd478NuhYYqf3vx8vrCjgO5+cCOTSU3lpYWTvAnRos5P+k
 vmn1GTICbYkfexAB03aShoGMFTS7dKuhzCtqSH4rPqmQgzHwUNQ+NPcR6WVZQsQGAqgi
 iPbtk1xDNgTOYnK4dqcnng7Or3LThP4lDGFB0jxuXa87AC23IyAkpAo+U9YbW/J+O5Nv
 IZPV5tTPuDAeU0ueOvytjAfAx7vgPGMJQYRyAQEbtThX9sqB0r0ZZEW026U7CaZIDoEF
 GSRCVjZQyqWU4WmzBwMn3NNVZpzzNRUjL/56fcvhS+/4EKJ1POeOiYVnsv3wBxI6J1gG
 l2ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784002099; x=1784606899;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yFgyz2PuTWXNXdAIxw4+nZ0WFieFllO62m9f0PvmWKw=;
 b=moXH0BnFsHxgLlDGeN6kttk8DGzbJ8ufIwwzMCC5GFPLbflroy18J9Dz/8TeqvNfn/
 zuFU1LJtj7C/18AnNblDPweh08Ybn3pPXe4foOdn3Nw8v2nuOj/SYRMNSz1FWwkZ0kK/
 zbyB6MbVBbaHyKkbcI0qOtIWVKmVWRAyNa2OiftD/IDz8qC92yCHLwDSidDCdXOVaf9Q
 lZSlGUQRpunDlraoZPnF9i2Up9/ZH4p6TOcw5IDZeKmrdMiTbZX9hrYrxaUfnEHiY1e5
 Ly2NPGQMKuALrCX/efRftyq02ZGYs4jyXvcUbpQqyn8dKmfnbCd/Xq4o1v3bHDvNomj+
 aKLw==
X-Gm-Message-State: AOJu0YwwstoYVAilqG5Adyb1bK3plVlbJnM6KZe7c6We4seZgfEsAqNn
 Zr3WtJ8/BuDy1zpHDFzS9sYj7jv6cn05nmNxylplrxMpSoAIZwzYHN0yeu0olw==
X-Gm-Gg: AfdE7cnypZbUDh/eDmCsdZymloDK7hGyQxEHt28im4dquKNFyUDVwa78MKnzYmwBT/X
 myoB5MZyQcmkTT120F+65uGhN64K5zGHHWe5x8pCxoItvaZuEzLa1SV74Tiepbmx9JaaIfodDpm
 qFqz4IFCH+H0xqRnt8UlwEAEBBEb7753eMD05IEtkyD9NKAJG85abdG/y+dJNOh1qTFoVBr3Xt+
 VKd27y5foZbMRT9MenCXLlgrA92CCjHRyhx3vqaJ2KTQqaNejngn1b6G472OhoD8RfB1qmSDm1K
 NT/9yFOX/jZ+5WXlr5JQHlNW/oomBs2uYyfYbSz6HZgSbqBvncu8E+HNFiZXWRixNKOWfHHO9T3
 OALY+r0xDUY+K9zSHLuBh+JzAwAaGpMFSFVESUlntqpxSAkn/jJ3R3hUZ5nV+yxicT2U4GsNxNZ
 5OAV9fH1uO0mF5qbERkRBu6msdmdA24e8Mm3JlK/FxzQ==
X-Received: by 2002:a17:90b:58c5:b0:380:83fc:4315 with SMTP id
 98e67ed59e1d1-38e17e44165mr1676796a91.21.1784002098908; 
 Mon, 13 Jul 2026 21:08:18 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38e172b6cfbsm778840a91.3.2026.07.13.21.08.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 21:08:18 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Bin Meng <bin.meng@processmission.com>,
 Chao Liu <chao.liu@processmission.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 4/4] tests/functional/riscv64: sifive_u: Fix kernel command line
Date: Tue, 14 Jul 2026 14:07:58 +1000
Message-ID: <20260714040758.28332-5-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260714040758.28332-1-alistair.francis@wdc.com>
References: <20260714040758.28332-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1032.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Bin Meng <bin.meng@processmission.com>

Build the complete kernel command line before adding it to the QEMU
arguments. This ensures the panic, noreboot and rootwait options are
passed to the guest.

Fixes: 7db162fa0138 ("tests/functional: Test SPI-SD adapter without SD card connected")
Signed-off-by: Bin Meng <bin.meng@processmission.com>

Reviewed-by: Chao Liu <chao.liu@processmission.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260713120245.781959-1-bin.meng@processmission.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 tests/functional/riscv64/test_sifive_u.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/functional/riscv64/test_sifive_u.py b/tests/functional/riscv64/test_sifive_u.py
index 847f709da1..54a0f9c648 100755
--- a/tests/functional/riscv64/test_sifive_u.py
+++ b/tests/functional/riscv64/test_sifive_u.py
@@ -35,9 +35,6 @@ def do_test_riscv64_sifive_u_mmc_spi(self, connect_card):
         kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
                                'earlycon=sbi console=ttySIF0 '
                                'root=/dev/mmcblk0 ')
-        self.vm.add_args('-kernel', kernel_path,
-                         '-append', kernel_command_line,
-                         '-no-reboot')
         if connect_card:
             kernel_command_line += 'panic=-1 noreboot rootwait '
             self.vm.add_args('-drive', f'file={rootfs_path},if=sd,format=raw')
@@ -46,6 +43,9 @@ def do_test_riscv64_sifive_u_mmc_spi(self, connect_card):
             kernel_command_line += 'panic=0 noreboot '
             pattern = 'Cannot open root device "mmcblk0" or unknown-block(0,0)'
 
+        self.vm.add_args('-kernel', kernel_path,
+                         '-append', kernel_command_line,
+                         '-no-reboot')
         self.vm.launch()
         self.wait_for_console_pattern(pattern)
 
-- 
2.54.0


