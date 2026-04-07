Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C30F10F9977
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:33:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYa3-00069B-08; Wed, 08 Apr 2026 15:28:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1wAY8C-000823-Kv; Wed, 08 Apr 2026 15:00:04 -0400
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1wAQok-0003EP-UZ; Wed, 08 Apr 2026 07:11:33 -0400
DKIM-Signature: a=rsa-sha256; bh=1/4coCVA2N6x/mToKvWs3wRYdqXcBrzAmfmEEcyd3Os=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:In-Reply-To:To:Cc; q=dns/txt; s=20240113;
 t=1775646441; v=1;
 b=a/Orkh+eyzLWobqbjsDavq6tCl1jxgNjS25D67QCb66p3VBImMEe1fM7orVAZuKAEYctHeXU
 4aWUwgstdxks2Dagdo1wTtmadkx4pBpl5HUP5Rfl1uh6SIkW9JRQpyGDM73fzYX2oyj7tWFfaHa
 ZSMK83GTZvXnM6ZkXL66wx7yLV3Dxpb9B6T8JN+aYqKC84191yj2cNvaeo0z6BEdAQq16y9QW0F
 PN6ERT1p8b4cIp6lX/rGL3jncsprpgq6PtEsEwWqC44TOFaIrf8EBRYBRTG8zMUJ2cyZqABqH6N
 fsfjKP4Ibow4CJVLngOfXqEzMiB/koZX592+ZTTzBW4ww==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id 24FF620803;
 Wed, 08 Apr 2026 11:07:21 +0000 (UTC)
From: ~lexbaileylowrisc <lexbaileylowrisc@git.sr.ht>
Date: Tue, 07 Apr 2026 15:03:54 +0100
Subject: [PATCH qemu v2 7/7] ot_uart: add tracing
Message-ID: <177564643888.23414.7922925369077631439-7@git.sr.ht>
X-Mailer: git.sr.ht
In-Reply-To: <177564643888.23414.7922925369077631439-0@git.sr.ht>
To: qemu-riscv@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-devel@nongnu.org,
 Amit Kumar-Hermosillo <amitkh@google.com>, nabihestefan@google.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=46.23.81.152; envelope-from=outgoing@sr.ht;
 helo=mail-a.sr.ht
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIM_INVALID=0.1, DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
 hw/char/ot_uart.c         | 30 ++++++++++++++++++++++++++++++
 hw/char/trace-events      |  8 ++++++++
 hw/riscv/opentitan.c      |  1 +
 include/hw/char/ot_uart.h |  1 +
 4 files changed, 40 insertions(+)

diff --git a/hw/char/ot_uart.c b/hw/char/ot_uart.c
index 1dda771724..6f7b8946e8 100644
--- a/hw/char/ot_uart.c
+++ b/hw/char/ot_uart.c
@@ -30,6 +30,7 @@
 #include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
+#include "trace.h"
=20
 /* clang-format off */
 REG32(INTR_STATE, 0x00)
@@ -135,6 +136,9 @@ static void ot_uart_update_irqs(OtUARTState *s)
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
@@ -156,6 +160,18 @@ static bool ot_uart_is_rx_enabled(const OtUARTState *s)
     return FIELD_EX32(s->regs[R_CTRL], CTRL, RX);
 }
=20
+static void ot_uart_check_baudrate(const OtUARTState *s)
+{
+    uint32_t nco =3D FIELD_EX32(s->regs[R_CTRL], CTRL, NCO);
+
+    unsigned baudrate =3D (unsigned)(((uint64_t)nco * (uint64_t)s->pclk) >>
+                                   (R_CTRL_NCO_LENGTH + 4));
+
+    if (baudrate) {
+        trace_ot_uart_check_baudrate(s->ot_id, s->pclk, baudrate);
+    }
+}
+
 static int ot_uart_can_receive(void *opaque)
 {
     OtUARTState *s =3D opaque;
@@ -403,6 +419,7 @@ static void ot_uart_clock_input(void *opaque, int irq, in=
t level)
     s->pclk =3D (unsigned)level;
=20
     /* TODO: disable UART transfer when PCLK is 0 */
+    ot_uart_check_baudrate(s);
 }
=20
 static uint64_t ot_uart_read(void *opaque, hwaddr addr, unsigned int size)
@@ -500,6 +517,10 @@ static uint64_t ot_uart_read(void *opaque, hwaddr addr, =
unsigned int size)
         break;
     }
=20
+    uint32_t pc =3D current_cpu->cc->get_pc(current_cpu);
+    trace_ot_uart_io_read_out(s->ot_id, (uint32_t)addr, REG_NAME(reg), val32,
+                              pc);
+
     return (uint64_t)val32;
 }
=20
@@ -511,6 +532,9 @@ static void ot_uart_write(void *opaque, hwaddr addr, uint=
64_t val64,
=20
     hwaddr reg =3D R32_OFF(addr);
=20
+    uint32_t pc =3D current_cpu->cc->get_pc(current_cpu);
+    trace_ot_uart_io_write(s->ot_id, (uint32_t)addr, REG_NAME(reg), val32, p=
c);
+
     switch (reg) {
     case R_INTR_STATE:
         val32 &=3D INTR_MASK;
@@ -541,6 +565,9 @@ static void ot_uart_write(void *opaque, hwaddr addr, uint=
64_t val64,
         uint32_t prev =3D s->regs[R_CTRL];
         s->regs[R_CTRL] =3D val32 & CTRL_MASK;
         uint32_t change =3D prev ^ s->regs[R_CTRL];
+        if (change & R_CTRL_NCO_MASK) {
+            ot_uart_check_baudrate(s);
+        }
         if ((change & R_CTRL_RX_MASK) && ot_uart_is_rx_enabled(s) &&
             !ot_uart_is_sys_loopack_enabled(s)) {
             qemu_chr_fe_accept_input(&s->chr);
@@ -621,6 +648,7 @@ static const VMStateDescription vmstate_ot_uart =3D {
 };
=20
 static const Property ot_uart_properties[] =3D {
+    DEFINE_PROP_STRING("ot-id", OtUARTState, ot_id),
     DEFINE_PROP_CHR("chardev", OtUARTState, chr),
     DEFINE_PROP_BOOL("oversample-break", OtUARTState, oversample_break, fals=
e),
     DEFINE_PROP_BOOL("toggle-break", OtUARTState, toggle_break, false),
@@ -669,6 +697,8 @@ static void ot_uart_realize(DeviceState *dev, Error **err=
p)
 {
     OtUARTState *s =3D OT_UART(dev);
=20
+    g_assert(s->ot_id);
+
     qdev_init_gpio_in_named(DEVICE(s), &ot_uart_clock_input, "clock-in", 1);
=20
     fifo8_create(&s->tx_fifo, OT_UART_TX_FIFO_SIZE);
diff --git a/hw/char/trace-events b/hw/char/trace-events
index a3fcc77287..c859d8af4e 100644
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
+ot_uart_check_baudrate(const char *id, unsigned pclk, unsigned baud) "%s: @ =
%u Hz: %u bps"
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
index 221c581e52..7c2b5f3457 100644
--- a/include/hw/char/ot_uart.h
+++ b/include/hw/char/ot_uart.h
@@ -46,6 +46,7 @@ struct OtUARTState {
     unsigned pclk; /* Current input clock */
     const char *clock_src_name; /* IRQ name once connected */
=20
+    char *ot_id;
     DeviceState *clock_src;
     CharFrontend chr;
     bool oversample_break; /* Should mock break in the oversampled VAL reg? =
*/
--=20
2.49.1

