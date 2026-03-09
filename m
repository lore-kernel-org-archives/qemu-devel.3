Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9349F417F3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 16:05:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzcy9-0002ZV-BO; Mon, 09 Mar 2026 11:56:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcxW-0001pB-I8
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:55:56 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcxU-0000i4-J2
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:55:54 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4852f8ac7e9so27301895e9.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 08:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773071750; x=1773676550; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7zwtW9IWQF9xqKnStppovSkYASlgGiUn9sqSyXCNFBc=;
 b=dAW9C6tM/XUvJEMbRe7KxM8mJ4imQWDrOS/Bd53gQASo0R1v6WSYaQvKGU1pE8yGW4
 nGf+kdYLiX6iipzAg0OL3ytiDLGdx05WEg+XF/QkTeOnW/dUChU9hFWkNwcL++KYD4H1
 IAXz/57onR0nXS3FsPZ0RFISMC3Gvz+XmOgjpj6SOfCnyOO6i9bFZcSs9c1qOtp369Ql
 fQWY401e53/8rAeVncwwDH+ap+kSq8ID1cytvuMp3ye/0qxvFqP/RuTBEqOOQyMmLb1s
 ylSBw/0X0jPmAY/2g0+gb3TXyhwADCE6MHi+0XUdGUTGZtJNShchCDPyCaKVVXDgF2yK
 Vr0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773071750; x=1773676550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7zwtW9IWQF9xqKnStppovSkYASlgGiUn9sqSyXCNFBc=;
 b=hOdWdj6SPfJDxUCFl/F+BOCmhj6khWbgsSqexAg6lev6QGzME/ndg79J2TRlHqmwvR
 SyhT2IKUgPuv8a68tb3oXv1JZI4w8cqJct/I41z/+WniPcGOo4hqtnQBXStUNQVX5m7w
 xB9aKlqf2sMaOcqVDUwuB+Kh0Pavc0/Y2gYepsjfhog3ctVB2JotFpbYD9UjPzxDKvXf
 PIuZrqynHd8cUK0h6gyxpSGYHf2RtUMQzfWHbj8UPh5PGO0Uwbe9uFtX+MFC4LmX6FFH
 fH9bZtaeXjHe2MrG9NJOD9ynZ+OvaO2drlWlAEvGA8ABIBmHluWcJqz+OIIUjHBNxxk2
 6nyQ==
X-Gm-Message-State: AOJu0Yzs/xMahZH/kddSiwH1g7vkp6thdtVSYgLEmRPomaJps7naDzOd
 zY3TRj4s9q575G83//nSgMWN/zuE9K4CV3/LYTdZ+eeMpzDTD2DwP4MZp+NWKwl6C++9f3cmn9O
 4DQO7nBU=
X-Gm-Gg: ATEYQzxxuVLVaggPn/D0yHhUQJVWLqu+cyjyFwG0NqRIlGoYMpcbjtLYdMLGIliMOEV
 AFMXUh1XjDb5H4NT1+iMLkSrpYJo+4tA57RcUmjmOydw2FhVVHI9HD2N4TYMd06F6mcvuQO9cUU
 eU+I8M3bhfEEz4gVLdUMOVvCLwuRuT7Pu6Ce8ldrHFdF14vAA17nxBrVJ13aV2wBfa89hMu2q0V
 gJdYlg12EZs591qFhgUBdC9dYkS+vDMRuIg/IvHCaL//WPZj0RJ16GfrbegJkgrD6jMBrbB88am
 pCD9jnq8JbgeMXw3QEvc2SeQtFgEcec5mC4IYAfvySawdd9kbv0h4ciQJ0WR19dIg9zAearMynO
 f/OzcnVgFKvD8OSYIcURc8uGuW1X7D01z+UHrSFswlY26dCJe8XHEOXTv16fZldCJAz8DNCSQiH
 OFwK/J5xnmRj9nIV3teIMHN1Gz7eodFk6xkNx0uH3CjutdvdDVbBh5VQV9Q8mTFoSNUDjQ/kEw
X-Received: by 2002:a05:600c:1395:b0:485:2fc5:3b0 with SMTP id
 5b1f17b1804b1-4852fc506a5mr135763805e9.27.1773071750239; 
 Mon, 09 Mar 2026 08:55:50 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48523803b5fsm92346795e9.7.2026.03.09.08.55.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Mar 2026 08:55:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 31/49] hw/sparc/sun4m: Don't set up dummy cpu interrupts
Date: Mon,  9 Mar 2026 16:52:01 +0100
Message-ID: <20260309155219.62400-32-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309155219.62400-1-philmd@linaro.org>
References: <20260309155219.62400-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

In the sun4m machine init, we set up the cpu_irqs[] array
with the real inbound IRQs for each CPU, followed by some
dummy IRQs for the remaining slots from smp_cpus up to
MAX_CPUS. These dummy IRQs do nothing when set/cleared
because the dummy_cpu_set_irq() function does nothing.

Instead of creating these "do nothing" qemu_irqs, instead
pass the number of CPUs to slavio_intctl_init() so that it
can only wire up the interrupt controller's interrupts
for the CPUs that actually exist. Calling qemu_set_irq()
on an irq that isn't connected does nothing, so this is
a simpler way to achieve the same result.

This cleanup fixes an unimportant memory leak reported by
the address sanitizer that happens because we allocate these
dummy IRQs with qemu_allocate_irqs():

Direct leak of 1920 byte(s) in 15 object(s) allocated from:
    #0 0x5cb7b120cf63 in malloc (/home/pm215/qemu/build/san/qemu-system-sparc+0xe0bf63) (BuildId: d27f9230a7cc82ebfaf0cf9e439dc215ddd7ac68)
    #1 0x743cd6dc5ac9 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x62ac9) (BuildId: 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
    #2 0x5cb7b1a42fb4 in qemu_extend_irqs /home/pm215/qemu/build/san/../../hw/core/irq.c:77:51
    #3 0x5cb7b19e7e72 in sun4m_hw_init /home/pm215/qemu/build/san/../../hw/sparc/sun4m.c:845:23
    #4 0x5cb7b141d3dd in machine_run_board_init /home/pm215/qemu/build/san/../../hw/core/machine.c:1709:5
    #5 0x5cb7b1542895 in qemu_init_board /home/pm215/qemu/build/san/../../system/vl.c:2717:5
    #6 0x5cb7b1542895 in qmp_x_exit_preconfig /home/pm215/qemu/build/san/../../system/vl.c:2811:5
    #7 0x5cb7b15493ac in qemu_init /home/pm215/qemu/build/san/../../system/vl.c:3849:9
    #8 0x5cb7b1f3f201 in main /home/pm215/qemu/build/san/../../system/main.c:71:5
    #9 0x743cd4a2a1c9 in __libc_start_call_main csu/../sysdeps/nptl/libc_start_call_main.h:58:16
    #10 0x743cd4a2a28a in __libc_start_main csu/../csu/libc-start.c:360:3
    #11 0x5cb7b1172114 in _start (/home/pm215/qemu/build/san/qemu-system-sparc+0xd71114) (BuildId: d27f9230a7cc82ebfaf0cf9e439dc215ddd7ac68)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <20260307112931.3322532-2-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sparc/sun4m.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index a17bdb36927..29bc26ebcb7 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -196,10 +196,6 @@ static void cpu_set_irq(void *opaque, int irq, int level)
     }
 }
 
-static void dummy_cpu_set_irq(void *opaque, int irq, int level)
-{
-}
-
 static void sun4m_cpu_reset(void *opaque)
 {
     SPARCCPU *cpu = opaque;
@@ -344,6 +340,7 @@ static void *sparc32_dma_init(hwaddr dma_base,
 
 static DeviceState *slavio_intctl_init(hwaddr addr,
                                        hwaddr addrg,
+                                       unsigned int smp_cpus,
                                        qemu_irq **parent_irq)
 {
     DeviceState *dev;
@@ -355,7 +352,7 @@ static DeviceState *slavio_intctl_init(hwaddr addr,
     s = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(s, &error_fatal);
 
-    for (i = 0; i < MAX_CPUS; i++) {
+    for (i = 0; i < smp_cpus; i++) {
         for (j = 0; j < MAX_PILS; j++) {
             sysbus_connect_irq(s, i * MAX_PILS + j, parent_irq[i][j]);
         }
@@ -841,9 +838,6 @@ static void sun4m_hw_init(MachineState *machine)
         cpu_devinit(machine->cpu_type, i, hwdef->slavio_base, &cpu_irqs[i]);
     }
 
-    for (i = smp_cpus; i < MAX_CPUS; i++)
-        cpu_irqs[i] = qemu_allocate_irqs(dummy_cpu_set_irq, NULL, MAX_PILS);
-
     /* Create and map RAM frontend */
     dev = qdev_new("memory");
     object_property_set_link(OBJECT(dev), "memdev", OBJECT(ram_memdev), &error_fatal);
@@ -860,6 +854,7 @@ static void sun4m_hw_init(MachineState *machine)
 
     slavio_intctl = slavio_intctl_init(hwdef->intctl_base,
                                        hwdef->intctl_base + 0x10000ULL,
+                                       smp_cpus,
                                        cpu_irqs);
 
     for (i = 0; i < 32; i++) {
-- 
2.53.0


