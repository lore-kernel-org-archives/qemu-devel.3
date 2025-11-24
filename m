Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E571BCFD317
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 09:54:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNTGK-0004kU-R7; Mon, 24 Nov 2025 04:53:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNTF3-0004Xa-9C
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 04:52:32 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNTF1-0001e9-Lb
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 04:52:16 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-42bb288c17bso2431011f8f.2
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 01:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763977934; x=1764582734; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y2ZTFmU6wpQn2o5DKZtDOyBUX7dktOdowLF5I8J/Wto=;
 b=O7WwIisGf6VOyr6mKjheeMXgQ3XCyy1o6hpmjuhMDh/n55trFgCP1f8ix6oQt6fBlk
 ie0xJBGOO1RW0M2UhfyzTQe8mJxIKkAPv1wRb5dzkIGDXnvqD9/ceEiPm81xruY4O4hg
 +wBUJlXBQsbB+yYjq48ExuWBueHxvnkxjQ4mVonYdMhTSOREgQ2NR241dxnMhXDF/aoO
 LYw+MZ1+d1Vmyz3iM6yPGPZAoWlrI+GGVzRLfMlNgooYEHHHUws8hHpqJVjz0dHxw7do
 u3v/2lGZ+nR7mEDFOwnEoch7ocICr0GIRtvwLFjQHry9fK+iphia5xBij5hng0v8BL8Q
 oFEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763977934; x=1764582734;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Y2ZTFmU6wpQn2o5DKZtDOyBUX7dktOdowLF5I8J/Wto=;
 b=tjNCFDk6QjrExRvWzi3/J8GcNeWJO2eu14BraHdNeyI60it2YO+Yls/HPusewdH/5V
 RgrKCtlCvLX+FKxpkA1UKRG0acNAkHc2kRXXXYx1MR78aOKoKvvfc2dHWTNdSgcl3zT8
 F2p4ghhd9tzsCLJVqdLNjRDVVCRrhjhSv9CcuDJif4GEvHMFmZaHUb76KfT/fprllKD6
 EILrIpYbJx+3JvoIIalKWySlB+YRuKcGbr8YRo3t2vEH7763jt0s4So3ywM/QTwAd/FZ
 aO9L0xFPqxEFC/XyLKIeXOSkHYs895qNAqMUaleqrQhonxN+XxvpTgPT+dYcBzr0xy8n
 GzGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPbikqBlKBMX2FeVATVWfXB6k2087nlSwoGiz0m6FkUQHtuxaAUdFEKNogq2xVlLg+/1GwUazpQnhw@nongnu.org
X-Gm-Message-State: AOJu0YxK7hwN+t93GQYHuTrpD+K3RXG9tWr3uL+epTNR5BVBeUR+ziNt
 auBdDU1qPRB9805gohmr3/QzBpLQadsNeEGdzaZVI1rof3SL9dr7AomiJ5Er7mHgTopWph3dklk
 ToxMvOPpuXQ==
X-Gm-Gg: ASbGncsDAMTF09rypZpRCegq4fYQR79xzH8++CK0Z+WSeyjz+ATdjefhF5bOeXuIHGN
 cr90PexPz16FzPyhDYuF14ki4HGEO2IfkYlSE7j5bJx0sOA7rXI1M0YABl88TCCM0AMKv2Mz46u
 XJ+AMhxB+7e3W6oth8dLDcnRv57Vd1qoALVJcYWA+EjqMRl84HGmLNYVJ7he3WTUEeR0qcQWA3u
 1f0MDGvMWn+aAwrNAjV3jVMxpJ+fTFngj25T9EEgRFmz4T4aBaINhrqzen9RqRaUPS+e3e8Owte
 h297K+awMLgp+0+m6YhOW1Czy0/y0TKce4kDooJDmSXOMAuPatwXCbv2s2bKaiIgpSwhrbNgXW5
 ZiPuk4fzyZ+5eD3Z5N4iu6PtPmkMhBFksSv/+Xj7h5KbpM3lWVWDWBc4pLwc4JbjK867XbGo37d
 u7BZPl4nXl1CEimsWpl8XkDHwsPJPE8o+55kxkq4Os0Cml0WBqT/W17xU29lMU
X-Google-Smtp-Source: AGHT+IF8ciSAbgAMy16t5fHYnpWhqWHq8gNIIWtYj7yTLDBkr4adUEI8ruG/Qe4la7CPnBX31SMQmQ==
X-Received: by 2002:a05:6000:40cb:b0:42b:3ee9:4773 with SMTP id
 ffacd0b85a97d-42cc1ab89eamr10862156f8f.7.1763977933750; 
 Mon, 24 Nov 2025 01:52:13 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7f34ff3sm27949304f8f.16.2025.11.24.01.52.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Nov 2025 01:52:13 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 qemu-devel@nongnu.org
Cc: Rob Landley <rob@landley.net>, Thorsten Glaser <tg@debian.org>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-11.0 09/13] hw/sh4/r2d: Use EXT_CS_BASE() macro for FPGA
 device
Date: Mon, 24 Nov 2025 10:51:04 +0100
Message-ID: <20251124095109.66091-10-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251124095109.66091-1-philmd@linaro.org>
References: <20251124095109.66091-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sh4/r2d.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index 26edcabf2c0..2229cc6fe66 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -253,6 +253,7 @@ static void r2d_init(MachineState *machine)
     USBBus *usb_bus;
     r2d_fpga_t *fpga;
     const hwaddr flash_base = EXT_CS_BASE(0);
+    const hwaddr fpga_base = EXT_CS_BASE(1);
     hwaddr sdram_base;
     uint64_t sdram_size = machine->ram_size;
 
@@ -278,7 +279,7 @@ static void r2d_init(MachineState *machine)
     memory_region_add_subregion(address_space_mem, sdram_base, sdram);
     /* Register peripherals */
     s = sh7750_init(cpu, address_space_mem);
-    fpga = r2d_fpga_init(address_space_mem, 0x04000000, sh7750_irl(s));
+    fpga = r2d_fpga_init(address_space_mem, fpga_base, sh7750_irl(s));
 
     dev = qdev_new("sh_pci");
     busdev = SYS_BUS_DEVICE(dev);
-- 
2.51.0


