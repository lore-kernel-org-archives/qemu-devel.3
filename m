Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78C52C0218D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 06:07:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcejZ-0007RF-3c; Tue, 28 Jan 2025 01:06:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tcejX-0007Qx-Ta; Tue, 28 Jan 2025 01:05:59 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tcejW-0008Co-Am; Tue, 28 Jan 2025 01:05:59 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-219f8263ae0so96196755ad.0; 
 Mon, 27 Jan 2025 22:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738044356; x=1738649156; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YrAW79KiOv42U4iKuxM5UGtySL8UZjDnK2Geh/ESVTc=;
 b=McC2KsoX4u92Qn4cI/o1XpoVSrXyxd+hp37IfEuoYKgt4svYrzal8lRRVa94w8evke
 9EJQS1GYHNwl9r4OfPRea2SbRHR7jKl8H5dEAI0tHWAdv9xMMyWKF/Av+OpPUQBsXgDC
 wBQQiT7eCH3kae4kHRDxFeTFPi97eC1G2f5aFI9KO2Eah4/WMCvyhwxsf5HYRLJfB8cl
 Tq+SyfwwMWRAYHPOIi3CI9B6cNN39qJNjenD4PjJRWaEIIlBIOaJkFQHMt10z6Q/5j/A
 IWwmSPB64aTwxEMkipWPUcoz0F6v/rCXWD15vLiKRbwFqhT2/e6k8bNRdOwmCAHMk9iz
 GoSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738044356; x=1738649156;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YrAW79KiOv42U4iKuxM5UGtySL8UZjDnK2Geh/ESVTc=;
 b=Ul1px8lYpsJQQWTih5YGG0wPRA6nn4nqy9+LtuZstSa/ZiN1OFIdsVr3oBxKxV57+a
 eqMxh96lm3wzaS8kU5ijI2/yJlFBSnKltD2wp5z/uaYBtsnxVuV5HnYBH6IjgucPCgK5
 pnsZVayngnJLk0BdKpNWB/B/78Rth0tCJ/A0JDmQUrfpWlZMZU3RXhVnHfK3BTE7/D/G
 shJC6JIIoDEXUwiQ+ve8+IOLg8HXquQDas6C0O26zMtRXop5HjHFAtZpbjg9eyQnR4ja
 CPO5fd3Lla+wuKoy4Ul4aUsYim4zxXdHEA9l4OrNTjdrXHnpW0iIaM4KGQWTl6w/VgGr
 vWpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEi0mpd2iaEhyNYo/O7Dhc6JBT/pdLFxAR7Piyv9eAT/ZGVHWDMw/GGsFbYLe+LGSo9S6l5pprWg7V@nongnu.org
X-Gm-Message-State: AOJu0Yz5IVmqLfsZcc1rExgf2W52G86QvN5r530gLMf8QvzIqho7KQMR
 fpCkWXQxUkHK1AYxjFuPCWSBYx+DQIJlCDgnhWCZ+dMDpt57cwq+
X-Gm-Gg: ASbGnctMLITX+i4B3J/u7qsHn15wrCV6AL+kfjVXnOUiGS4fnB4ZEdKN22+ycB3g0+f
 lwvssM4DC0B9dPd8XckIf3CFU6wkt0S+xV4v2XHOIIndoOOOPfwXc1gMhzGoGmC7YRbWP/QYe1H
 zA8JBcSgc7aVQyQxXDt4Nkkokt32+ZxJjaOK/zXQVMLHI1e7uCMiEz2u4XuvjnSwHOcVdZmntk6
 Q8vO3o81X+c99EtbZaqAga7xUVIy8s4zDZzG705ORnfrRLRGHdxODztfjBgTFy0kyuRjQ42+BRp
 oIfnQ4buF6WEj6JsAQd6RhN9oOt0Uqk3O2av3ukqMykHaDoZSmBbLRK9RgEEahVJlKqCkXVPjbA
 MghBu5+QkRxuu6BCX1C6a0nLS18tzDw==
X-Google-Smtp-Source: AGHT+IE6oeSsJ7WA/7Ag1h0zI3KSmNi4b8INrQVQY55DMvVA65HCITIvSbbOBlzAVJV/p8Nxbh59tw==
X-Received: by 2002:a17:902:f644:b0:216:4e8d:4803 with SMTP id
 d9443c01a7336-21c355f6ab4mr620505475ad.42.1738044356016; 
 Mon, 27 Jan 2025 22:05:56 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da3ea3b3asm73741145ad.85.2025.01.27.22.05.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2025 22:05:54 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: palmer@dabbelt.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, qemu-riscv@nongnu.org, philmd@linaro.org
Cc: qemu-devel@nongnu.org,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH] MAINTAINERS: Remove Bin Meng from RISC-V maintainers
Date: Tue, 28 Jan 2025 16:05:46 +1000
Message-ID: <20250128060546.1374394-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Bin Meng has been a long time contributor and maintainer for QEMU RISC-V
and has been very beneficial to the RISC-V ecosystem.

Unfortunately his email has started to bounce so this patch is removing
them from MAINTAINERS. If in the future Bin Meng wants to return we will
happily re-add them.

Note that I'm not removing Bin Meng as a "SD (Secure Card)" maintainer.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 MAINTAINERS | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7be3d8f431..a0e305aa99 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -318,7 +318,6 @@ F: tests/functional/test_ppc_74xx.py
 RISC-V TCG CPUs
 M: Palmer Dabbelt <palmer@dabbelt.com>
 M: Alistair Francis <alistair.francis@wdc.com>
-M: Bin Meng <bmeng.cn@gmail.com>
 R: Weiwei Li <liwei1518@gmail.com>
 R: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
 R: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
@@ -1599,7 +1598,6 @@ F: include/hw/riscv/opentitan.h
 F: include/hw/*/ibex_*.h
 
 Microchip PolarFire SoC Icicle Kit
-M: Bin Meng <bmeng.cn@gmail.com>
 L: qemu-riscv@nongnu.org
 S: Supported
 F: docs/system/riscv/microchip-icicle-kit.rst
@@ -1626,7 +1624,6 @@ F: include/hw/char/shakti_uart.h
 
 SiFive Machines
 M: Alistair Francis <Alistair.Francis@wdc.com>
-M: Bin Meng <bmeng.cn@gmail.com>
 M: Palmer Dabbelt <palmer@dabbelt.com>
 L: qemu-riscv@nongnu.org
 S: Supported
@@ -3721,7 +3718,7 @@ S: Orphan
 F: hw/i386/amd_iommu.?
 
 OpenSBI Firmware
-M: Bin Meng <bmeng.cn@gmail.com>
+L: qemu-riscv@nongnu.org
 S: Supported
 F: pc-bios/opensbi-*
 F: .gitlab-ci.d/opensbi.yml
-- 
2.48.1


