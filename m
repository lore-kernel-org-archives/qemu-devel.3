Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E15711094489
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2026 15:47:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3yXy-00038e-T2; Sat, 21 Mar 2026 11:47:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtao0430@163.com>)
 id 1w3yXx-00037K-2C; Sat, 21 Mar 2026 11:47:29 -0400
Received: from m16.mail.163.com ([220.197.31.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtao0430@163.com>)
 id 1w3yXq-0003JY-Tb; Sat, 21 Mar 2026 11:47:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=7E
 AlcOrlE4davJbWmpLv4X8UIF6sirfV3lw6Oi0idPM=; b=Pojh4s6ubAcx5L7w3M
 AQkN9fn2f8YlT65dIqkfP6mLbUg28hiyairyuYhoMiqZodelwUxlbC6o9NNz7IMv
 X22R217yd4/x1c7VL2X3zgI56MXvYsOY3E4/PgmW2TsXsZnxF09tPAACQ9nNPJF8
 Te8LkrmQ8ziqp1Y/O+4nAAIWc=
Received: from dt-VM.localdomain (unknown [])
 by gzsmtp5 (Coremail) with SMTP id QCgvCgAH9XF2vb5p1YbwTQ--.2111S2;
 Sat, 21 Mar 2026 23:47:04 +0800 (CST)
From: Tao Ding <dingtao0430@163.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Tao Ding <dingtao0430@163.com>
Subject: [PATCH v1 0/5] PL011 and PL080 for dma transfer
Date: Sat, 21 Mar 2026 23:46:55 +0800
Message-ID: <cover.1774099044.git.dingtao0430@163.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: QCgvCgAH9XF2vb5p1YbwTQ--.2111S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3ZFyDuw4DWFW5KF4fGF1xZrb_yoWDZFWDpr
 W3KF9xtr1UtF4xX343Jr1UGr13Jw48GryUGr17Jr48AF4jyr4xJr1UK3WfJr9rXrZ7Zr15
 XFyUJa47Jryqqw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziByIUUUUUU=
X-Originating-IP: [101.204.36.117]
X-CM-SenderInfo: pglqw3tdrqkjqq6rljoofrz/xtbC4hiX1Wm+vXjWSAAA30
Received-SPF: pass client-ip=220.197.31.5; envelope-from=dingtao0430@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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

The PL080 implementation in QEMU currently supports memory-to-memory data transfers 
but lacks support for peripheral-related data transfers. 

To enable this functionality, signal interfaces have been added for PL011 and PL080 to 
emulate the DMA request handshake, thereby completing the peripheral-related 
transfer features that were previously unimplemented in PL080. Specifically, 
memory-to-peripheral, peripheral-to-memory and periphral-to-periphral under dma controll.

Although PL011 and PL080 are not strongly coupled, for the convenience of verification, 
they are still placed in the same patch thread. Finally, unit testing was conducted using Qtest, 
and Linux system testing was conducted on "Versatilepb" machine in Qemu.

Tao Ding (5):
  Fixed the PL011 FIFO level bug
  PL011 generate receive timeout interrupt
  Implement the DMA interface of PL011
  Run pl080_run in main loop
  PL080 add transfer memory and peripheral

 hw/char/pl011.c         |  72 ++++++++++++++++++++++---
 hw/dma/pl080.c          | 116 ++++++++++++++++++++++++++++++++++------
 include/hw/char/pl011.h |   1 +
 include/hw/dma/pl080.h  |   7 +++
 4 files changed, 174 insertions(+), 22 deletions(-)


base-commit: 8e711856d7639cbffa51405f2cc2366e3d9e3a23

Testing:
========

Testing prepare:
	1. The changes in the patch need to be applied. 
	2. Then connect the DMA signals of PL011 and PL080 in the Versatilepb board.
		Channel0 is used to do UART's TX, memory to peripheral. Use 0 signal index.
		Channel1 is used to do UART's RX, peripheral to memory. Use 1 signal index.
		(The connection of the signal needs to consider the offset in the device.)

Change in Versatilepb.c :
-----------------------------------------
diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index 254b1610b3..ee0056e831 100644
--- a/hw/arm/versatilepb.c
+++ b/hw/arm/versatilepb.c
@@ -281,7 +281,7 @@ static void versatile_init(MachineState *machine, int board_id)
     }
 
     pl011_create(0x101f1000, pic[12], serial_hd(0));
-    pl011_create(0x101f2000, pic[13], serial_hd(1));
+    DeviceState *pl011_dev = pl011_create(0x101f2000, pic[13], serial_hd(1));
     pl011_create(0x101f3000, pic[14], serial_hd(2));
     pl011_create(0x10009000, sic[6], serial_hd(3));
 
@@ -292,6 +292,15 @@ static void versatile_init(MachineState *machine, int board_id)
     sysbus_realize_and_unref(busdev, &error_fatal);
     sysbus_mmio_map(busdev, 0, 0x10130000);
     sysbus_connect_irq(busdev, 0, pic[17]);
+    sysbus_connect_irq(busdev, 3, qdev_get_gpio_in(pl011_dev, 0));
+    sysbus_connect_irq(busdev, 4, qdev_get_gpio_in(pl011_dev, 1));
+
+    sysbus_connect_irq(SYS_BUS_DEVICE(pl011_dev), 6, qdev_get_gpio_in(dev, 0));
+    sysbus_connect_irq(SYS_BUS_DEVICE(pl011_dev), 7, qdev_get_gpio_in(dev, 1));
+
+    sysbus_connect_irq(SYS_BUS_DEVICE(pl011_dev), 8, qdev_get_gpio_in(dev, 16));
+    sysbus_connect_irq(SYS_BUS_DEVICE(pl011_dev), 9, qdev_get_gpio_in(dev, 17));
+
 
     sysbus_create_simple("sp804", 0x101e2000, pic[4]);
     sysbus_create_simple("sp804", 0x101e3000, pic[5]);
-----------------------------------------

Unit Test by QTest:
	1. create pl080-test.c in tests/qtest directory.
------------ pl080-test.c ------------
#include "qemu/osdep.h"
#include "libqtest-single.h"

#define PL011_BASE   0x101f2000
#define PL080_BASE   0x10130000
#define RAM_BASE     0x0

/* ---------------- PL011 Registers ---------------- */
#define UARTDR     0x00
#define UARTFR     0x18
#define UARTCR     0x30
#define UARTLCR_H  0x2C
#define UARTDMACR  0x48
/* UARTFR bits */
#define FR_RXFE  (1 << 4)
#define FR_TXFF  (1 << 5)

/* UARTCR bits */
#define CR_UARTEN (1 << 0)
#define CR_TXE    (1 << 8)
#define CR_RXE    (1 << 9)
#define CR_LBE    (1 << 7)

#define LCRH_FEN (1 << 4)   // FIFO enable

/* ---------------- PL080 DMA Registers ---------------- */
#define DMAC_CONFIG       0x30

/* Channel offsets */
#define DMA_CH_SRC        0x00
#define DMA_CH_DST        0x04
#define DMA_CH_LLI        0x08
#define DMA_CH_CTRL       0x0C
#define DMA_CH_CFG        0x10

/* Control Register Fields */
#define CTRL_TRANSFER_SIZE(x)   ((x) & 0xFFF)
#define CTRL_SRC_WIDTH(x)       ((x) << 18)
#define CTRL_DST_WIDTH(x)       ((x) << 21)
#define CTRL_SRC_INC            (1 << 26)
#define CTRL_DST_INC            (1 << 27)

/* Width */
#define WIDTH_8BIT   0
#define WIDTH_16BIT  1
#define WIDTH_32BIT  2

/* Config Register Fields */
#define CFG_ENABLE           (1 << 0)

/* Flow control */
#define CFG_FLOW_MEM2MEM     (0 << 11)
#define CFG_FLOW_MEM2PER     (1 << 11)
#define CFG_FLOW_PER2MEM     (2 << 11)
#define CFG_FLOW_PER2PER     (3 << 11)

/* Peripheral IDs (VersatilePB, PL011 UART) */
#define PERIPH_UART_TX       0 
#define PERIPH_UART_RX       1

/* Macro to set peripheral in CFG */
#define CFG_DST_PERIPH(x)    ((x) << 6)   // DST peripheral ID
#define CFG_SRC_PERIPH(x)    ((x) << 1)   // SRC peripheral ID

static void test_pl080_pl011(void)
{
    QTestState *s;
    uint32_t cr;
    uint32_t i;

    /* --------------------------- */
    /* 1.  UART(loopback) */
    /* --------------------------- */
    s = qtest_start("-machine versatilepb -d guest_errors,trace:memory_region_ops_* -D qemu.log");

    qtest_writel(s, PL011_BASE + UARTCR, 0);
    qtest_writel(s, PL011_BASE + UARTLCR_H, LCRH_FEN);

    cr = CR_UARTEN | CR_TXE | CR_RXE | CR_LBE;
    qtest_writel(s, PL011_BASE + UARTCR, cr);

    qtest_writel(s, PL011_BASE + UARTDMACR, 0x3);

    /* --------------------------- */
    /* 2. data in memory */
    /* --------------------------- */
    uint8_t tx_buff[12] = {
        0x1,0x2,0x3,0x4,
        0x5,0x6,0x7,0x8,
        0x9,0xa,0xb,0xc
    };

    uint32_t src_addr = RAM_BASE + 0x1000;
    uint32_t dst_addr = RAM_BASE + 0x2000;
    int len = 12;

    for (i = 0; i < len; i++) {
        qtest_writeb(s, src_addr + i, tx_buff[i]);  
        qtest_writeb(s, dst_addr + i, 0);           
    }

    /* --------------------------- */
    /* 3. enable DMA controller */
    /* --------------------------- */
    qtest_writel(s, PL080_BASE + DMAC_CONFIG, 1);

    /* --------------------------- */
    /* 4. DMA channel 0: mem -> UART */
    /* --------------------------- */
    uint32_t ch0_base = PL080_BASE + 0x100;

    qtest_writel(s, ch0_base + DMA_CH_SRC, src_addr);
    qtest_writel(s, ch0_base + DMA_CH_DST, PL011_BASE + UARTDR);

    qtest_writel(s, ch0_base + DMA_CH_CTRL,
        CTRL_TRANSFER_SIZE(len/4) |
        CTRL_SRC_WIDTH(WIDTH_32BIT) |
        CTRL_DST_WIDTH(WIDTH_8BIT) |
        CTRL_SRC_INC
    );

    /* CFG: enable + flow + destination peripheral */
    qtest_writel(s, ch0_base + DMA_CH_CFG,
        CFG_ENABLE |
        CFG_FLOW_MEM2PER |
        CFG_DST_PERIPH(PERIPH_UART_TX)
    );

    /* --------------------------- */
    /* 5. DMA channel 1: UART -> mem */
    /* --------------------------- */
    uint32_t ch1_base = PL080_BASE + 0x120;

    qtest_writel(s, ch1_base + DMA_CH_SRC, PL011_BASE + UARTDR);
    qtest_writel(s, ch1_base + DMA_CH_DST, dst_addr);

    qtest_writel(s, ch1_base + DMA_CH_CTRL,
        CTRL_TRANSFER_SIZE(len) |
        CTRL_SRC_WIDTH(WIDTH_8BIT) |
        CTRL_DST_WIDTH(WIDTH_32BIT) |
        CTRL_DST_INC
    );

    /* CFG: enable + flow + source peripheral */
    qtest_writel(s, ch1_base + DMA_CH_CFG,
        CFG_ENABLE |
        CFG_FLOW_PER2MEM |
        CFG_SRC_PERIPH(PERIPH_UART_RX)
    );

    /* --------------------------- */
    /* 6. DMA run*/
    /* --------------------------- */
    clock_step(1000000);

    
    /* wait Channel 0 */
    while (true) {
        uint32_t cfg = qtest_readl(s, ch0_base + DMA_CH_CFG);
        if (!(cfg & CFG_ENABLE)) {
            printf("Channel 0 finish\n");
            break;
        }
        clock_step(1000000);  
    }

    /* wait Channel 1 */
    while (true) {
        uint32_t cfg = qtest_readl(s, ch1_base + DMA_CH_CFG);
        if (!(cfg & CFG_ENABLE)) {
            printf("Channel 1 finish\n");
            break;
        }
        clock_step(1000000);  
    }

    /* --------------------------- */
    /* 7. check data */
    /* --------------------------- */
    for (i = 0; i < len; i++) {
        uint8_t s_val = qtest_readb(s, src_addr + i);
        uint8_t d_val = qtest_readb(s, dst_addr + i);

        g_assert_cmpuint(s_val, ==, d_val);
    }

    qtest_end();
}

int main(int argc, char **argv)
{
    g_test_init(&argc, &argv, NULL);
    qtest_add_func("/pl080/test1", test_pl080_pl011);
    return g_test_run();
}
-----------------------------------------
	2. modify meson
-----------------------------------------
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index be4fa627b5..6ea187517f 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -249,7 +249,8 @@ qtests_arm = \
   (config_all_devices.has_key('CONFIG_STM32L4X5_SOC') and
    config_all_devices.has_key('CONFIG_DM163')? ['dm163-test'] : []) + \
   ['arm-cpu-features',
-   'boot-serial-test']
+   'boot-serial-test'] + \
+  ['pl080-test']
 
 # TODO: once aarch64 TCG is fixed on ARM 32 bit host, make bios-tables-test unconditional
 qtests_aarch64 = \
-----------------------------------------

Configuration:
	../configure --target-list=arm-softmmu --enable-debug --disable-werror
build:
	make
Run:
	QTEST_QEMU_BINARY=./qemu-system-arm ./tests/qtest/pl080-test
Result:
-----------------------------------------
	TAP version 13
	# random seed: R02Sf2f5311a926a969453439a52838a6fd0
	1..1
	# Start of arm tests
	# Start of pl080 tests
	# starting QEMU: exec ./qemu-system-arm -qtest unix:/tmp/qtest-23375.sock 
    -qtest-log /dev/null -chardev socket,path=/tmp/qtest-23375.qmp,id=char0 -mon chardev=char0,mode=control 
    -display none -audio none -run-with exit-with-parent=on -machine versatilepb -d guest_errors,trace:memory_region_ops_* 
    -D qemu.log -accel qtest
	Channel 0 finish
	Channel 1 finish
	ok 1 /arm/pl080/test1
	# End of pl080 tests
	# End of arm tests
-----------------------------------------

System Test:
	1. Refer to qemu/docs/system/arm/volatile.rst to boot Linux.
	2. modify versatile-pb.dts in linux to use dma.
		serial@101f2000 {
			compatible = "arm,pl011\0arm,primecell";
			reg = <0x101f2000 0x1000>;
			interrupts = <0x0d>;
			clocks = <0x05 0x06>;
			clock-names = "uartclk\0apb_pclk";
			auto-poll;
+			dmas = <&dma0 1 1>,
+					<&dma0 0 1>;
+			dma-names = "rx", "tx";
		};

Run:
	./build/qemu-system-arm -M versatilepb -nographic \
	-serial mon:stdio \
	-serial pty \
	-kernel zImage \
	-dtb versatile-pb.dtb \
	-drive if=scsi,driver=file,filename=rootfs.img \
	-append "console=ttyAMA0 rw root=/dev/sda" \
	-d guest_errors -D qemu.log

Send and receive data to the guest's UART in another console of the host by pty.

Test result:

guest:
	~ # echo "hello" > /dev/ttyAMA1
	uart-pl011 101f2000.serial: DMA channel TX dma1chan0
	uart-pl011 101f2000.serial: DMA channel RX dma1chan1
host:
	cat /dev/pts/1
	hello

-- 
2.43.0


