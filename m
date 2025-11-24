Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AD5CCFD317
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 09:53:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNTFq-0004bi-Rr; Mon, 24 Nov 2025 04:53:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNTE5-0004PI-45
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 04:51:19 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNTE1-0001Vi-27
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 04:51:16 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-42bb288c219so3573627f8f.1
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 01:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763977871; x=1764582671; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=i/akuPZSRd8yV/IOBbKpBMlzTHYzdj74JAoDKo5QUQE=;
 b=vOeIjZnNYu0Lxqv6/nFGAOKcBACZKGhqlwZ/AAW7C+Jz8DDRSz8p63TQzUAWYuMqMx
 QYUTzbB7IAqJQ56V/9gzitJ6xxuet7RSgb56c/zRiIm/SWpeiY+uBzPR7Dm6+9u3lX+3
 bVwbwUwsoXSKtB/JRCDCNRmVDSdgIadXz9Zl5xE7dmORky25TdCRINphkjRkrCrS7xtP
 pGHJnfTn6yR71sQs9fRkQp6ebZUgH4szjZuS60DbMRCMrSqOmYRTR2zovTGW/j70sRkn
 F8HqyV9WhFuFjRhq0XvNjCvOEmn4d8JtULKgM7Nkz4Wp4u97xr2c3NGqh8f15oVbk/52
 gXsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763977871; x=1764582671;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i/akuPZSRd8yV/IOBbKpBMlzTHYzdj74JAoDKo5QUQE=;
 b=XUKDtAYGvIDCM3HevhWYVQBmn2nePQDV51ZP/SrqXJwXcXyHVmBoUj2Wht57PZDfVn
 3iDaIgZC6CgPXgxDbtWCbXdAjucMiIVSDA0AOPZcePZYzimOYfohT5EoBYSvhSOVdAix
 0xsVpSRQ1G7Z/eQQUAVvuDkYhXTarKD5vq3HefSmQfZnLLvHksxv2clptwz/gWbXARlm
 i/pMMDkH+O/cwiN9523E8faX4NOTelnN6V5TwfRGwEuzmOyb82bSGbGu7PsjQ+PSsBdy
 mtaPoeTk1csMErLrqUAyH56Dju76sj/gmZSq5WG9q3LQAeEUm3O7KzJgkFCAhQK4zvTr
 m+zA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrOfUnffxQIxImqnYY8NP7olLXe1SvOrYmeHeM8RbrtN/EKz/Sag1J/HiIj88JTlq/H2t1WyxYbKrO@nongnu.org
X-Gm-Message-State: AOJu0Yy3fkqWhG7Cp/YI4cCKoqaupjZPAno2WKRFpbPoXzquTYyA60Vn
 YD629Gq9/o6hfy9oLS2W4dyWiWiRkKPwQH4b4i+c1vjJSps/uewI1XulVYRMVPw0Iww=
X-Gm-Gg: ASbGncuz/qVtKA2aezd2gBdAiwj3Sxljjz2dGDccrsMIC5H1C10e0ISEWI7qQJkTG0f
 5QuUGIFn2vqXUdT2mo1zFcUb034PIB/ynSDrgTu+gedEloZnhLjj0MniK0tRo2o+HwyMXaoIPoI
 giTjtyvXwHiOw/zaSnrKWj2ZJ/eOebws7mFkB5ILtAumX6F16/stIaTalqemqrDt1P0+AVMGjw9
 xzYK5fluf2X9+wrwIGtSvBg0pT68sVbnGET5nHOyFWrjfOnkqj9F3ydZOlf+tPzmFlqs+1yMvUQ
 NLbQbnSDM2xu7UQVXl0PU2ReGt4w7nCOw08XK1TukST7deOhFuOYPJbkyE25bo/y9n2v7lshkDD
 stwhV8tq8CZfP0Rec4kt9REf6shf2OecYuTspV/9dU/zxnXm7EeLKEiOdDnZ1hbFHbClJpCWK1/
 37ij0tt1jcimcOfAiqkK71w/m7xXrCFdx7eOKC4PU7TNQcnewiKOy2r8ctHE91
X-Google-Smtp-Source: AGHT+IEIugpy5dsj9EfZViMSXdNCTb1tTI8/LWY9MdGnn2PVO9rbBDaV1Hp9jAQDKmwjIt0sqE27xg==
X-Received: by 2002:a5d:5f93:0:b0:42b:30d4:e401 with SMTP id
 ffacd0b85a97d-42cc1ac9d58mr12062574f8f.12.1763977871230; 
 Mon, 24 Nov 2025 01:51:11 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fb9022sm27298807f8f.36.2025.11.24.01.51.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Nov 2025 01:51:10 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 qemu-devel@nongnu.org
Cc: Rob Landley <rob@landley.net>, Thorsten Glaser <tg@debian.org>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-11.0 00/13] hw/sh4/r2d: Raise amount of RAM from 64 to 192
 MB
Date: Mon, 24 Nov 2025 10:50:55 +0100
Message-ID: <20251124095109.66091-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

It is possible to add more RAM on the R2D board:
- 1 real 64MB SDRAM
- 1 virtual 64MB SRAM (virtual because back then such
  SRAM size wouldn't exist).

Memory tree change with this series applied:

    $ diff -uw a b
    --- a  2025-11-24 10:48:58
    +++ b  2025-11-24 10:49:30
    @@ -1,4 +1,4 @@
    -QEMU 10.0.0 monitor - type 'help' for more information
    +QEMU 10.1.91 monitor - type 'help' for more information
     (qemu) info mtree -f
     FlatView #0
      AS "memory", root: system
    @@ -6,7 +6,7 @@
      Root memory region: system
       0000000000000000-0000000000ffffff (prio 0, romd): r2d.flash
       0000000004000000-000000000400003f (prio 0, i/o): r2d-fpga
    -  000000000c000000-000000000fffffff (prio 0, ram): r2d.sdram
    +  0000000008000000-000000000fffffff (prio 0, ram): ram
       0000000010000000-00000000107fffff (prio 0, ram): sm501.local
       0000000013e00000-0000000013e0006b (prio 0, i/o): sm501-system-config
       0000000013e10040-0000000013e10053 (prio 0, i/o): sm501-i2c
    @@ -16,6 +16,7 @@
       0000000013f00000-0000000013f00053 (prio 0, i/o): sm501-2d-engine
       000000001400080c-000000001400080f (prio 0, i/o): ide-mmio.2
       0000000014001000-000000001400101f (prio 0, i/o): ide-mmio.1
    +  0000000018000000-000000001bffffff (prio 0, ram): ram @0000000008000000
       000000001e080000-000000001e080003 (prio 0, i/o): intc @000000001e080000
       000000001e080040-000000001e080043 (prio 0, i/o): intc @000000001e080040
       000000001e080060-000000001e080063 (prio 0, i/o): intc @000000001e080060

Philippe Mathieu-Daudé (13):
  hw/sh4/r2d: Bail out early if user request invalid RAM size
  hw/sh4/r2d: Define BOOT_PARAMS_BASE
  hw/sh4/r2d: Introduce sdram_base and sdram_size variables
  hw/sh4/r2d: Use memdev allocation for RAM
  hw/sh4/r2d: Reword SH7750_BCR1 and SH7750_BCR2 initialization comments
  hw/sh4/r2d: Configure flash (CS#0) as 16-bit accessible
  hw/sh4/r2d: Introduce EXT_CS_BASE() macro and use it for SDRAM
  hw/sh4/r2d: Use EXT_CS_BASE() macro for boot flash device
  hw/sh4/r2d: Use EXT_CS_BASE() macro for FPGA device
  hw/sh4/r2d: Use EXT_CS_BASE() macro for display controller
  hw/sh4/r2d: Use EXT_CS_BASE() macro for pseudo ISA bus
  hw/sh4/r2d: Add 64MB of SDRAM in CS#2
  hw/sh4/r2d: Add 64MB of SRAM in CS#6

 hw/sh4/r2d.c | 76 ++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 56 insertions(+), 20 deletions(-)

-- 
2.51.0


