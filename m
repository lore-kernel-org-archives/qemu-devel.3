Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8E96C43327
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 10:21:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wes3M-0005Qn-Th; Wed, 01 Jul 2026 06:20:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wes3E-00057k-Ew
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 06:20:16 -0400
Received: from mail-dl1-x122e.google.com ([2607:f8b0:4864:20::122e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wes3A-0005GP-UD
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 06:20:16 -0400
Received: by mail-dl1-x122e.google.com with SMTP id
 a92af1059eb24-1390f75d8bbso825689c88.0
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 03:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782901211; x=1783506011; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PZTbT1dhTtg0bcqDcW5c5jUwySoXm0jFKsV3PPsjufE=;
 b=fZP/SuQt61FEy8+ZHJd9RKpVyw4zctyTB2GT+ny3ChmU+c2FMGTbeFAGjDuCSVd7GU
 8Q3GB9uAfg7BxmL6251/NTGdwRhWD3u7kLiKhNkFVCEkCsP7hiG6JnxXsh+uCpArH0YB
 02T0pbV+4z/7XFDqOdvZLZXYslDemUESw0hN/EO8kb/snI0u3oBOJLbCUJzVCMYuPob3
 6H0Nq0D3m7YpsK8PxOW9W1S+/NV810sf0t4ujapUolcZC3WvKMRpxOs0A7VijWNTynCr
 3cZdvgp0PR6Nnh9xlbjlV9BTTLVjg8lgE58nfleL3o69DZZywHuLB7qHKxYdyb4900QV
 YuGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782901211; x=1783506011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PZTbT1dhTtg0bcqDcW5c5jUwySoXm0jFKsV3PPsjufE=;
 b=oUgFrdID5XvSUYnN1hHS6oAuUo4sanpC+tGSr2+agGAW/tYJjEdB5umwWOYInxVrfv
 Ivf7M6vWvK5PpOb7tRfCse31HGLGf8QKoEW2149XXXl5Pkw0OfXihUtO93AswSvrS+PP
 lHN/iv0x+vhAmZcsIBqOhdv1blHf79ha+eGvGwfZppb+UZ7zHD5QVwDc7auXtIzdGiLz
 FtRXyksh7MJjibPo6AZqYBM6PRwXDUUaTTsvYlYwqyi6c0bWoXIRJhhH0srrG2D1Nk2K
 2y7yQzcc8FMRWpcY3ZovNSPt7t6DZg/kSf/fuHPV7xWXzFNp8KOllLdPRGX/whoJUuVt
 IQ+A==
X-Gm-Message-State: AOJu0YwvvNgKCDEeSWdkT4hACCBdrSJWBMZ8GT+yHCZRCZQwCDGLuplc
 7qWoRuD0BTCrBZHP2yeWGcNntx4WVU8ByPlQ/ePF9XoGnlpzIdwnSRflt+e9UA==
X-Gm-Gg: AfdE7ckhVIQH5r59wM8XaMh4JSNpgK1RLz4uoCiAn3GvxPARlED/swPmLuaY67fKSYM
 TbdN219jjzrSjbfzcl9krVYGoXYSjWmDTJTYLsY5r3rtr4klc3nPfdc8SDKY2kAYHi3swHlaoPd
 ZZTu6wsFPLFfiQ27KsqOvZJW4DRkJGPE7XDXBpivNIoRSm1gCIgg4ayFlzTcFKiamLjWdDDummi
 nuDZr+6v4e0eQvugmj4zp2e0glFdef7C7r2T+8uA8I3AkfQVfV513zPkK76iqedzqyy0fj11lTG
 PzjrfPSMwP4brDyuYk0F5r82M1iefkdxd3WbelxrLK6VFWdr73a5jeUSZOOJrMqT2djnGL0jVYz
 lNIFCyJ3iwNBZl3UJW6ux/rEPVtpspSDKAvnRUfsTu0vevYBkHLkoLkocKr22oJAGvWNoRuoy7C
 nbNkk/cYH6u3cWtTq3tZoFan7KJS+c8wA=
X-Received: by 2002:a05:7022:6714:b0:137:fec9:8ffb with SMTP id
 a92af1059eb24-13b36e02ffbmr972634c88.25.1782901211524; 
 Wed, 01 Jul 2026 03:20:11 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b2ab2e0e3sm19355047c88.7.2026.07.01.03.20.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 03:20:11 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: [PULL 38/39] hw/riscv/atlantis: Add some i2c peripherals
Date: Wed,  1 Jul 2026 20:17:51 +1000
Message-ID: <20260701101752.2522962-39-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701101752.2522962-1-alistair.francis@wdc.com>
References: <20260701101752.2522962-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::122e;
 envelope-from=alistair23@gmail.com; helo=mail-dl1-x122e.google.com
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

From: Joel Stanley <joel@jms.id.au>

Add an I2C RTC device and a temperature sensor. These are not present
on the board but help for testing.

The tmp105 is a lm75 compatible temperature sensor used by the
SENSORS_LM75 Linux kernel driver.

The ds1338 is a RTC device that is used by the RTC_DRV_DS1307 Linux
kernel driver.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
Message-ID: <20260630024952.1520546-13-joel@jms.id.au>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/tt_atlantis.c | 27 +++++++++++++++++++++++++++
 hw/riscv/Kconfig       |  2 ++
 2 files changed, 29 insertions(+)

diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index 5ce150fff7..beaf64e0c1 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -64,6 +64,13 @@ static const MemMapEntry tt_atlantis_memmap[] = {
     [TT_ATL_DDR_HI] =          { 0x100000000,  0x1000000000 },
 };
 
+static I2CBus *i2c_get_bus(TTAtlantisState *s, unsigned busnr)
+{
+    assert(busnr < TT_ATL_NUM_I2C);
+
+    return s->i2c[busnr].bus;
+}
+
 static uint32_t fdt_phandle = 1;
 static uint32_t next_phandle(void)
 {
@@ -309,6 +316,19 @@ static void create_fdt_i2c(void *fdt, const MemMapEntry *mem, uint32_t irq,
     qemu_fdt_setprop_cell(fdt, name, "#size-cells", 0);
 }
 
+static void create_fdt_i2c_device(TTAtlantisState *s, int bus,
+                                  const char *compat, int addr)
+{
+    void *fdt = MACHINE(s)->fdt;
+    hwaddr base = s->memmap[TT_ATL_I2C0 + bus].base;
+    g_autofree char *name = g_strdup_printf("/soc/i2c@%"HWADDR_PRIX"/sensor@%x",
+                                            base, addr);
+
+    qemu_fdt_add_subnode(fdt, name);
+    qemu_fdt_setprop_string(fdt, name, "compatible", compat);
+    qemu_fdt_setprop_cell(fdt, name, "reg", addr);
+}
+
 static void finalize_fdt(TTAtlantisState *s)
 {
     uint32_t aplic_s_phandle = next_phandle();
@@ -336,6 +356,9 @@ static void finalize_fdt(TTAtlantisState *s)
                        TT_ATL_I2C0_IRQ + i,
                        aplic_s_phandle, periph_clk_phandle);
     }
+
+    create_fdt_i2c_device(s, 0, "dallas,ds1338", 0x6f);
+    create_fdt_i2c_device(s, 4, "ti,tmp105", 0x48);
 }
 
 static void create_fdt(TTAtlantisState *s)
@@ -551,6 +574,10 @@ static void tt_atlantis_machine_init(MachineState *machine)
                            qdev_get_gpio_in(s->irqchip, TT_ATL_I2C0_IRQ + i));
     }
 
+    /* I2C peripherals: qemu specific */
+    i2c_slave_create_simple(i2c_get_bus(s, 0), "ds1338", 0x6f);
+    i2c_slave_create_simple(i2c_get_bus(s, 4), "tmp105", 0x48);
+
     /* Load or create device tree */
     if (machine->dtb) {
         load_fdt(s);
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index dcce819bf6..de37c08cae 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -130,6 +130,8 @@ config TENSTORRENT
     select SERIAL_MM
     select DEVICE_TREE
     select DESIGNWARE_I2C
+    select DS1338
+    select TMP105
 
 config XIANGSHAN_KUNMINGHU
     bool
-- 
2.54.0


