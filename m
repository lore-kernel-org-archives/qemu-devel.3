Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24661CCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 11:50:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vImrQ-00072W-5W; Tue, 11 Nov 2025 06:48:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vImqx-0005qP-1G
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 06:48:03 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vImqu-0004TQ-7u
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 06:48:02 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-297ef378069so27478865ad.3
 for <qemu-devel@nongnu.org>; Tue, 11 Nov 2025 03:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1762861678; x=1763466478; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Crky1vMWebfz9/HpBtY7DyZt1iGNX1EI7tQZJybiMs0=;
 b=B1O7affPNw1IdH70yCFzKV98xKduweUnHhVjOfpoY92rt5hSm1jbiSlKHtSVrcJd13
 hxB8tiaIhEhvHrhDk9O4DFN+UWEv5mgg8jGVpB+p0Mk+K7FeCvMRxcTXQixa0gA/eRwZ
 pls0IAmaP+nT4JJ+wtu5IwIeY4P403xLZmEVcTKOHgWJ6/az58izVjPtYHQ+87d/+58F
 1Cl/FQAbqjQcXSiZnDXte3kIx34110lLSO09oAUM1sIc3g9j6RXuzh8rFeI8Dj6cUn7D
 Kn3f+2zaHG03yGdeIQ57UA7LHTHdLdHzY27MT39K0EkkkLfTjcoJ99C2K0oyfdVD/AyM
 meCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762861678; x=1763466478;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Crky1vMWebfz9/HpBtY7DyZt1iGNX1EI7tQZJybiMs0=;
 b=K2ueGqNwIA2Vcryk/fGBtV5g2q1VWKpzq5aKv1IbZocdeGZIV8Te/5flprjDpCXkO+
 +vjk/jsHrF1fHR/tO2gmPHM353dEokkZ9nND9V/WdDxRCpNLbPEJ0F+eyipyL3M2N682
 9e6nQo6MqwnT5HNRbKA/YI2DtyUBGraPtG1vLxj3NH0knYsSjUJqd0KzBksR9Qm4nZG7
 ErL57j5nC7Cia0WayrmxyqOrwPA30nQY/hF3lnMff6bA88119QTiSWoP+oWgZ1Eombrd
 9EfQ0aBiqSPBb4dQjiuN1Gx5tULizDw0l53hITTZkJtnzZty3IkEsdD3EJambiargC5U
 oAcw==
X-Gm-Message-State: AOJu0YzJFp0DKLf0CRCvCPP36J+KsJU4TC1ebomDsXdkMozpEgG/4Wjd
 NAQmHSZskDjgCkjvIf4ownbYHgOP086vSnz9AN5iM0LHshOBzMdD1xcm/4q3OQ/w2U+tKSZlbKH
 AF6GdmS8=
X-Gm-Gg: ASbGnctIV9IqV8BCWPsdOKwLck5oDfxyW84g0PgbOHqHvDpwnj9gzerWuJ3Rfh5db0I
 BxYujELnkVojyC2iQQgp06QUFR1ADJRADOfmenw8viQ7S/De6yelr63XYGtwFitNWgLsv0yUut3
 ZSZ0ilNB2MX2T3IlOvdFLSF5vEY7TutfmJLKH9iffmhEstGo8vpQ0w8UBn8iQcZQfnBHZzltNKy
 E0UrVuDGv+SARD6eoKYKLPayPZpFPcNiGSgMRARIHKH1drE37buMiDN8feY/xa3gx7k/odY5Vu0
 HYTobE9e8W+RGhC6pjmoLBqf5zWoOms67bRdVqkldNj9S6WSMEKFNPwcJQzpulQWxv/R1+l86PD
 hnZGUIZIknbUnox2fiGje8Zs3lKTKt3zT/zM73DoyPDAjZgE+K9Lfn14MOkKZgzZK0UqBNVA/DV
 QqgRs/3c5YzD4c6ceHL4vQqA40FGbUadwtqFenVg==
X-Google-Smtp-Source: AGHT+IGhdsaHcNXvikuXvh9SGUlxeZRWVCPepvZWhYs9PN9EOE3dVtqxPONvNZSA/C3T39DFN9YIrw==
X-Received: by 2002:a17:903:ac6:b0:294:ccc6:cd30 with SMTP id
 d9443c01a7336-297e56223aemr158656905ad.17.1762861678443; 
 Tue, 11 Nov 2025 03:47:58 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([179.93.21.233])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29651c747d1sm177533125ad.63.2025.11.11.03.47.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Nov 2025 03:47:57 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 08/17] hw/riscv/trace-encoder: write e-trace packets to RAM
 sink
Date: Tue, 11 Nov 2025 08:46:47 -0300
Message-ID: <20251111114656.2285048-9-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251111114656.2285048-1-dbarboza@ventanamicro.com>
References: <20251111114656.2285048-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

We have the needed pieces to make the trace encoder write messages (or
packets, in e-trace lingo) in its associated RAM sink.

We'll start by writing a sync message that we're already able to fetch
from the TCG instruction train. The trace encoder must be able to
read/write TR_RAM_WP RAM sink regs to know where it is supposed to write
packets, thus a handful of helpers are added to manipulate both the ram
sink SMEM memory and relevant registers.

The bulk of the work is done in trencoder_send_message_smem() where the
trace encoder writes each trace packet. The 'wrap' mechanism is
implemented to keep writing the RAM sink memory even after a SMEM
workflow.  If we can't fit a full packet in the end of the ring buffer
we're filling with NULLs and writing a new packet back to ramstart.

In an overflow event we'll wrap the TR_RAM_WP_LOW WRAP bit and userspace
is supposed to clear it after the wrapping was handled (i.e. userspace
read the whole ring buffer back to the start).

We're also allowing userspace to freely set ramsink and ramstart before
the trace session begins, allowing for more freedom w.r.t where the SMEM
will be written by the encoder. Note that this also means that userspace
is responsible for setting at least TR_RAM_WP_LOW and TR_RAM_WP_HIGH
before starting a trace session.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/riscv/trace-encoder.c | 121 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/hw/riscv/trace-encoder.c b/hw/riscv/trace-encoder.c
index 9701ce43cf..16c9475d46 100644
--- a/hw/riscv/trace-encoder.c
+++ b/hw/riscv/trace-encoder.c
@@ -20,6 +20,34 @@
 #include "system/device_tree.h"
 #include "hw/register.h"
 #include "cpu.h"
+#include "hw/riscv/trace-ram-sink.h"
+#include "rv-trace-messages.h"
+
+/*
+ * Size of header + payload since we're not sending
+ * srcID and timestamp.
+ */
+#define TRACE_MSG_MAX_SIZE 32
+
+static TracePrivLevel trencoder_get_curr_priv_level(TraceEncoder *te)
+{
+    CPURISCVState *env = &te->cpu->env;
+
+    switch (env->priv) {
+    case PRV_U:
+        return env->virt_enabled ? VU : U;
+    case PRV_S:
+        return env->virt_enabled ? VS : S_HS;
+    case PRV_M:
+        return M;
+    }
+
+    /*
+     * Return a reserved value to signal an error.
+     * TODO: handle Debug (D).
+     */
+    return RESERVED;
+}
 
 /*
  * trTeControl register fields
@@ -82,6 +110,41 @@ REG32(TR_TE_IMPL, 0x4)
 REG32(TR_TE_INST_FEATURES, 0x8)
     FIELD(TR_TE_INST_FEATURES, NO_ADDR_DIFF, 0, 1)
 
+static uint32_t trencoder_read_reg(TraceEncoder *te, uint32_t reg_addr)
+{
+    hwaddr addr = te->dest_baseaddr + reg_addr;
+    uint32_t val;
+
+    cpu_physical_memory_read(addr, &val, sizeof(uint32_t));
+    return val;
+}
+
+static void trencoder_write_reg(TraceEncoder *te, uint32_t reg_addr,
+                                uint32_t val)
+{
+    hwaddr addr = te->dest_baseaddr + reg_addr;
+
+    cpu_physical_memory_write(addr, &val, sizeof(uint32_t));
+}
+
+static hwaddr trencoder_read_ramsink_writep(TraceEncoder *te)
+{
+    hwaddr ret = trencoder_read_reg(te, A_TR_RAM_WP_HIGH);
+    ret <<= 32;
+    ret += trencoder_read_reg(te, A_TR_RAM_WP_LOW);
+
+    return ret;
+}
+
+static hwaddr trencoder_read_ramsink_ramlimit(TraceEncoder *te)
+{
+    hwaddr ret = trencoder_read_reg(te, A_TR_RAM_LIMIT_HIGH);
+    ret <<= 32;
+    ret += trencoder_read_reg(te, A_TR_RAM_LIMIT_LOW);
+
+    return ret;
+}
+
 static uint64_t trencoder_te_ctrl_set_hardwire_vals(uint64_t input)
 {
     input = FIELD_DP32(input, TR_TE_CONTROL, INST_MODE, 0x6);
@@ -171,6 +234,9 @@ static void trencoder_te_ctrl_postw(RegisterInfo *reg, uint64_t val)
     if (!te->trace_running && trTeInstTracing) {
         /* Starting trace. Ask the CPU for the first trace insn */
         te->trace_next_insn = true;
+
+        te->ramsink_ramstart = trencoder_read_ramsink_writep(te);
+        te->ramsink_ramlimit = trencoder_read_ramsink_ramlimit(te);
     }
 
     te->trace_running = trTeInstTracing ? true : false;
@@ -274,12 +340,67 @@ static void trencoder_realize(DeviceState *dev, Error **errp)
     }
 }
 
+static void trencoder_update_ramsink_writep(TraceEncoder *te,
+                                            hwaddr wp_val,
+                                            bool wrapped)
+{
+    uint32_t wp_low = trencoder_read_reg(te, A_TR_RAM_WP_LOW);
+
+    wp_low = FIELD_DP32(wp_low, TR_RAM_WP_LOW, ADDR,
+                        extract64(wp_val, 2, 30));
+
+    if (wrapped) {
+        wp_low = FIELD_DP32(wp_low, TR_RAM_WP_LOW, WRAP, 1);
+    }
+
+    trencoder_write_reg(te, A_TR_RAM_WP_LOW, wp_low);
+    trencoder_write_reg(te, A_TR_RAM_WP_HIGH, extract64(wp_val, 32, 32));
+}
+
+static void trencoder_send_message_smem(TraceEncoder *trencoder,
+                                        uint8_t *msg, uint8_t msg_size)
+{
+    hwaddr dest = trencoder_read_ramsink_writep(trencoder);
+    bool wrapped = false;
+
+    msg_size = QEMU_ALIGN_UP(msg_size, 4);
+
+    /* clear trRamWrap before writing to SMEM */
+    dest = FIELD_DP64(dest, TR_RAM_WP_LOW, WRAP, 0);
+
+    /*
+     * Fill with null bytes if we can't fit the packet in
+     * ramlimit, set wrap and write the packet in ramstart.
+     */
+    if (dest + msg_size > trencoder->ramsink_ramlimit) {
+        g_autofree uint8_t *null_packet = NULL;
+        uint8_t null_size = trencoder->ramsink_ramlimit - dest;
+
+        null_packet = g_malloc0(null_size);
+        cpu_physical_memory_write(dest, null_packet, null_size);
+
+        dest = trencoder->ramsink_ramstart;
+        wrapped = true;
+    }
+
+    cpu_physical_memory_write(dest, msg, msg_size);
+    dest += msg_size;
+
+    trencoder_update_ramsink_writep(trencoder, dest, wrapped);
+}
+
 void trencoder_set_first_trace_insn(Object *trencoder_obj, uint64_t pc)
 {
     TraceEncoder *trencoder = TRACE_ENCODER(trencoder_obj);
+    TracePrivLevel priv = trencoder_get_curr_priv_level(trencoder);
+    g_autofree uint8_t *msg = g_malloc0(TRACE_MSG_MAX_SIZE);
+    uint8_t msg_size;
 
     trencoder->first_pc = pc;
     trace_trencoder_first_trace_insn(pc);
+    msg_size = rv_etrace_gen_encoded_sync_msg(msg, pc, priv);
+
+    trencoder_send_message_smem(trencoder, msg, msg_size);
 }
 
 static const Property trencoder_props[] = {
-- 
2.51.1


