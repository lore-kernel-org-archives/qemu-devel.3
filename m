Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4142FF8873
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 16:05:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wITrs-0000IW-8p; Thu, 30 Apr 2026 12:04:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1wITrN-0007d4-RQ; Thu, 30 Apr 2026 12:03:31 -0400
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1wITrJ-0007AP-8L; Thu, 30 Apr 2026 12:03:28 -0400
DKIM-Signature: a=rsa-sha256; bh=KLpuStIUCtdEwm7bU4ULI48OBxTw38QY1td1/B8iSN4=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:In-Reply-To:To:Cc; q=dns/txt; s=20240113;
 t=1777564998; v=1;
 b=qrAmmwkCK2sG/SJSdRG2EkRQd9MCIqv5FQ7dsX6fMzuhbkoIsohSAXpBVlSXdefJXwpCVBFn
 ViijwaFpcT37Znrp/lU8pT5EVYIBRvyeEQHV3qPnUWpofRftbCCDVK/5btn2oOWxDtOYqK3/qEE
 FLBxw3QWPY3kRjLK3QG7x/5xiZQd1DixznO9wQpxisEI3UAOri4AiUl5ZX3l8zm7NQTDJu2APFN
 BvmiQllMX5VbuAd3YBYR/Trw44JumcxXAsQN2Vq028ErLE2uh3/oNNYO9cYLdvueIsX3Tkkp02k
 u68FL9aADuy0QTSqR3dC5R7net1nZYkk5wFBCN2LdLevA==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id AC02320C85;
 Thu, 30 Apr 2026 16:03:18 +0000 (UTC)
From: ~lexbaileylowrisc <lexbaileylowrisc@git.sr.ht>
Date: Tue, 07 Apr 2026 15:03:54 +0100
Subject: [PATCH qemu v4 9/9] ot_uart: add tracing
Message-ID: <177756498815.8917.12449488721849651971-9@git.sr.ht>
X-Mailer: git.sr.ht
In-Reply-To: <177756498815.8917.12449488721849651971-0@git.sr.ht>
To: qemu-riscv@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-devel@nongnu.org,
 Amit Kumar-Hermosillo <amitkh@google.com>,
 nabihestefan <nabihestefan@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=46.23.81.152; envelope-from=outgoing@sr.ht;
 helo=mail-a.sr.ht
X-Spam_score_int: 17
X-Spam_score: 1.7
X-Spam_bar: +
X-Spam_report: (1.7 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 DKIM_INVALID=0.1, DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
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
Reply-To: ~lexbaileylowrisc <lex.bailey@lowrisc.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Lex Bailey <lex.bailey@lowrisc.org>

Added some tracing to the OpenTitan UART for transparency when debugging

Signed-off-by: Lex Bailey <lex.bailey@lowrisc.org>
---
 hw/char/ot_uart.c         | 19 +++++++++++++++++++
 hw/char/trace-events      |  8 ++++++++
 hw/riscv/opentitan.c      |  1 +
 include/hw/char/ot_uart.h |  1 +
 4 files changed, 29 insertions(+)

diff --git a/hw/char/ot_uart.c b/hw/char/ot_uart.c
index d00f7bee66..910bef00f2 100644
--- a/hw/char/ot_uart.c
+++ b/hw/char/ot_uart.c
@@ -20,6 +20,7 @@
 #include "qemu/osdep.h"
 #include "hw/char/ot_uart.h"
 #include "qemu/fifo8.h"
+#include "hw/core/cpu.h"
 #include "hw/core/irq.h"
 #include "hw/core/qdev-clock.h"
 #include "hw/core/qdev-properties.h"
@@ -28,6 +29,7 @@
 #include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
+#include "trace.h"
=20
 REG32(INTR_STATE, 0x00)
     SHARED_FIELD(INTR_TX_WATERMARK, 0, 1)
@@ -126,6 +128,9 @@ static void ot_uart_update_irqs(OtUARTState *s)
 {
     uint32_t state_masked =3D s->regs[R_INTR_STATE] & s->regs[R_INTR_ENABLE];
=20
+    trace_ot_uart_irqs(s->ot_id, s->regs[R_INTR_STATE], s->regs[R_INTR_ENABL=
E],
+                       state_masked);
+
     for (int index =3D 0; index < OT_UART_IRQ_NUM; index++) {
         bool level =3D (state_masked & (1U << index)) !=3D 0;
         qemu_set_irq(s->irqs[index], level);
@@ -402,6 +407,10 @@ static uint64_t ot_uart_get_baud(OtUARTState *s)
     baud *=3D clock_get_hz(s->f_clk);
     baud >>=3D 20;
=20
+    if (baud) {
+        trace_ot_uart_check_baudrate(s->ot_id, baud);
+    }
+
     return baud;
 }
=20
@@ -503,6 +512,10 @@ static uint64_t ot_uart_read(void *opaque, hwaddr addr, =
unsigned int size)
         return 0;
     }
=20
+    uint32_t pc =3D current_cpu->cc->get_pc(current_cpu);
+    trace_ot_uart_io_read_out(s->ot_id, (uint32_t)addr, REG_NAME(reg),
+                              retvalue, pc);
+
     return retvalue;
 }
=20
@@ -514,6 +527,9 @@ static void ot_uart_write(void *opaque, hwaddr addr, uint=
64_t val64,
=20
     hwaddr reg =3D R32_OFF(addr);
=20
+    uint32_t pc =3D current_cpu->cc->get_pc(current_cpu);
+    trace_ot_uart_io_write(s->ot_id, (uint32_t)addr, REG_NAME(reg), value, p=
c);
+
     switch (reg) {
     case R_INTR_STATE:
         /* Write 1 clear */
@@ -665,6 +681,7 @@ static const VMStateDescription vmstate_ot_uart =3D {
 };
=20
 static const Property ot_uart_properties[] =3D {
+    DEFINE_PROP_STRING("ot-id", OtUARTState, ot_id),
     DEFINE_PROP_CHR("chardev", OtUARTState, chr),
     DEFINE_PROP_BOOL("oversample-break", OtUARTState, oversample_break, fals=
e),
     DEFINE_PROP_BOOL("toggle-break", OtUARTState, toggle_break, false),
@@ -716,6 +733,8 @@ static void ot_uart_realize(DeviceState *dev, Error **err=
p)
 {
     OtUARTState *s =3D OT_UART(dev);
=20
+    g_assert(s->ot_id);
+
     s->fifo_trigger_handle =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
                                           fifo_trigger_update, s);
=20
diff --git a/hw/char/trace-events b/hw/char/trace-events
index a3fcc77287..17cc9ad2d5 100644
--- a/hw/char/trace-events
+++ b/hw/char/trace-events
@@ -141,3 +141,11 @@ stm32f2xx_usart_receive(char *id, uint8_t chr) " %s rece=
iving '%c'"
 # riscv_htif.c
 htif_uart_write_to_host(uint8_t device, uint8_t cmd, uint64_t payload) "devi=
ce: %u cmd: %02u payload: %016" PRIx64
 htif_uart_unknown_device_command(uint8_t device, uint8_t cmd, uint64_t paylo=
ad) "device: %u cmd: %02u payload: %016" PRIx64
+
+# ot_uart.c
+ot_uart_check_baudrate(const char *id, unsigned baud) "%s: %u bps"
+ot_uart_connect_input_clock(const char *id, const char * srcname) "%s: %s"
+ot_uart_debug(const char *id, const char *msg) "%s: %s"
+ot_uart_io_read_out(const char *id, uint32_t addr, const char *regname, uint=
32_t val, uint32_t pc) "%s: addr=3D0x%02x (%s), val=3D0x%x, pc=3D0x%x"
+ot_uart_io_write(const char *id, uint32_t addr, const char *regname, uint32_=
t val, uint32_t pc) "%s: addr=3D0x%02x (%s), val=3D0x%x, pc=3D0x%x"
+ot_uart_irqs(const char *id, uint32_t active, uint32_t mask, uint32_t eff) "=
%s: act:0x%08x msk:0x%08x eff:0x%08x"
diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
index 97c33d1b53..163d3ac3d3 100644
--- a/hw/riscv/opentitan.c
+++ b/hw/riscv/opentitan.c
@@ -133,6 +133,7 @@ static void lowrisc_ibex_soc_init(Object *obj)
     object_initialize_child(obj, "plic", &s->plic, TYPE_SIFIVE_PLIC);
=20
     object_initialize_child(obj, "uart", &s->uart, TYPE_OT_UART);
+    object_property_set_str(OBJECT(&s->uart), "ot-id", "uart0", &error_fatal=
);
=20
     object_initialize_child(obj, "timer", &s->timer, TYPE_IBEX_TIMER);
=20
diff --git a/include/hw/char/ot_uart.h b/include/hw/char/ot_uart.h
index 4dc51142f7..2f538e1f6f 100644
--- a/include/hw/char/ot_uart.h
+++ b/include/hw/char/ot_uart.h
@@ -54,6 +54,7 @@ struct OtUARTState {
     bool in_break;
     guint watch_tag;
=20
+    char *ot_id;
     Clock *f_clk;
=20
     CharFrontend chr;
--=20
2.49.1

