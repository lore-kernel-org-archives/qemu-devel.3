Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0730CC6B1C
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 03:39:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHCID-00057b-27; Wed, 14 Oct 2026 23:38:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1xHCIB-00056u-6b
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 23:38:07 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1xHCI9-0008LC-BE
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 23:38:06 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-89a756e5d20so3767268b3a.2
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 20:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1792035484; x=1792640284; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=U7ptBXsKmRklF6bGufE4i32VXEqBAhm3UPl6252cLL4=;
 b=fNslFWQzheg2PEC3WnIxiyAQBtZhYBRPaqclDjvdmX7+3qd0LtjSJoZmCUH3LCK072
 Da+K7Y59KTUCuXH+x7KfsnmubyxXveID6BIwX0w6cUfwNsmzhXpCN7wCCimIzGN5AU6Q
 JHqPCgA/Bs3lKBfcEYT6wyI5qS9/5UQUHPPGVCtDmD82bjvHVq9LVlOCJiB2zFMCkGnF
 z2VIIIK3BgW/CNDpWkie4o45cQqw6CtF881bAiOUg8cjP+pkkyOoFaXDcdDXWg5pea7e
 4I6TOnJnYdzls9RFfReN5xwdDjTrE7OSyi+5IrVoWvlKFNGZOwZmjJeijaHbcrYV29Sg
 8fXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792035484; x=1792640284;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=U7ptBXsKmRklF6bGufE4i32VXEqBAhm3UPl6252cLL4=;
 b=N+yYrCO5pBm5p7DpaiHOxORtjhJ8t1GRWInIDCquEXyhACh0n4vAAAlM48SMDkZuFi
 cUH/bW/K7ysBThsnQzCL2AQEMq5gul5LdhlHtHvzUj8qCPZFpZpJVWi7oMDdJ0SN64Kf
 1WXz2OKpPrNYV2Jbq8u2UtvKAbab9dr+SYtKk3Ri6O1ODpAmphQY+l1JOm/1I3lJ2sxZ
 WgMYj4HcIiVXarxm3SxLM38rduD1QicneU8z94ht+Oo8zQpgIG8sj78k6GPA5Yl7bOya
 hodGsMC5Pc/59thgF5+B7ilvr/z36ZJbuRoqgukCo53qx3oa9lBidt1mTbIlktW9fr9f
 k6GQ==
X-Gm-Message-State: AFq9FYKyhaskw7jD1DjnTzRJUWSSEjkiiA9U2iyJ+nuwoczuSZb4lUJa
 eiTwbNQXpY+VZaS05SOvS791SoXcGUt46dvVE7XDgNJ7Q6a4qBPlD4mE/3gREsPqoLShEMDalCY
 82avFdEu55zuFRsES6Nz12wQSgqlPXlCbTAIiJbBzUtX6yq2+cDO6c4T2sIrSlxBTziUDOjyd/U
 Ya/e2wGZZgMrJiCRJkT5BkahEBhndRBOF36mRnvqtA+CfwWA==
X-Gm-Gg: AYBFou3VCzOfy2Yzen7FEzCyTxf380lb6BOn/WF37W8PACoOTkepaIckC2HHPEoRhTq
 YYUF/AwaG9AkH8RumZ7ygmoZpfWx+hJ2SBS2lkEm9KMY5RM+Wf2Q9uAI0IuxaW3widQG0SIVsY+
 4Xtggb7BHrtHJPqKF/H+snzdcW9wT2snQNBXElGZbQM5RNZdrTcRi2x/wdC4EpqbcMDF9IFOPdn
 +kmESOSq9zdFRjobUhXm4gdc8s9LxTWA71Kd9ggdTHVlz5y1bUalYiaQu2ZkmwYCukNT+WFMCcU
 6mgCRN2Z/ykPi/TMtQ4Q/3RNkkXIea79416im3uWkRaT23UUh3YimuVQo7/XKBKu8JgzlMGR8BB
 nvyfmkjDWgx44/In7N054SgW9ugMrCOuGhPL20i2MDOKz+kfyz76yTKa0aEMPxE10LSO1j5OW0E
 DnjEmjtMpUzdDALwuggALrFp2JQNWU4h8Uy77cZon82IHMYhjIloo7NHo3V0Sexhla0NoEzyz3p
 76zIM7o6H9o+ZKGRsCWVJ/fPikjqZSItnQCbea7xSn0BhQ=
X-Received: by 2002:a05:6a20:6a0e:b0:3e0:de4c:71e6 with SMTP id
 adf61e73a8af0-3e16beb2702mr15660650637.54.1792035483732; 
 Wed, 14 Oct 2026 20:38:03 -0700 (PDT)
Received: from jchang-1875.internal.sifive.com ([136.226.240.181])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd635c612a9sm559188a12.17.2026.10.14.20.38.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 14 Oct 2026 20:38:03 -0700 (PDT)
From: Jay Chang <jay.chang@sifive.com>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jason Wang <jasowangio@gmail.com>,
 qemu-arm@nongnu.org (open list:Xilinx Zynq),
 Jay Chang <jay.chang@sifive.com>, Frank Chang <frank.chang@sifive.com>,
 Jim Shu <jim.shu@sifive.com>
Subject: [PATCH 2/6] hw/dma/xilinx_axidma: Add 64-bit MMIO access support
Date: Thu, 15 Oct 2026 11:37:29 +0800
Message-ID: <20261015033733.35116-3-jay.chang@sifive.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20261015033733.35116-1-jay.chang@sifive.com>
References: <20261015033733.35116-1-jay.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=jay.chang@sifive.com; helo=mail-pf1-x434.google.com
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

Implement 32-bit and 64-bit descriptor register accesses through dedicated MMIO helpers.

Signed-off-by: Jay Chang <jay.chang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Jim Shu <jim.shu@sifive.com>
---
 hw/dma/xilinx_axidma.c | 199 +++++++++++++++++++++++++++++------------
 1 file changed, 143 insertions(+), 56 deletions(-)

diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
index 45fd2e45c1..282f92867d 100644
--- a/hw/dma/xilinx_axidma.c
+++ b/hw/dma/xilinx_axidma.c
@@ -56,7 +56,9 @@ DECLARE_INSTANCE_CHECKER(XilinxAXIDMAStreamSink, XILINX_AXI_DMA_CONTROL_STREAM,
 #define R_DMACR             (0x00 / 4)
 #define R_DMASR             (0x04 / 4)
 #define R_CURDESC           (0x08 / 4)
+#define R_CURDESC_MSB       (0x0C / 4)
 #define R_TAILDESC          (0x10 / 4)
+#define R_TAILDESC_MSB      (0x14 / 4)
 #define R_MAX               (0x30 / 4)
 
 #define CONTROL_PAYLOAD_WORDS 5
@@ -477,12 +479,40 @@ xilinx_axidma_data_stream_push(StreamSink *obj, unsigned char *buf, size_t len,
     return ret;
 }
 
-static uint64_t axidma_read(void *opaque, hwaddr addr,
-                            unsigned size)
+static uint32_t axidma_readl(XilinxAXIDMA *d, struct Stream *s,
+                             hwaddr addr, int sid)
+{
+    switch (addr) {
+    case R_DMACR:
+        /* Simulate one cycle reset delay.  */
+        s->regs[R_DMACR] &= ~DMACR_RESET;
+        return s->regs[R_DMACR];
+    case R_DMASR:
+        s->regs[R_DMASR] &= 0xffff;
+        s->regs[R_DMASR] |= (s->complete_cnt & 0xff) << 16;
+        s->regs[R_DMASR] |= (ptimer_get_count(s->ptimer) & 0xff) << 24;
+        return s->regs[R_DMASR];
+    default:
+        D(qemu_log("%s ch=%d addr=" HWADDR_FMT_plx " v=%x\n",
+                   __func__, sid, addr * 4, s->regs[addr]));
+        return s->regs[addr];
+    }
+}
+
+static uint64_t axidma_readq(XilinxAXIDMA *d, struct Stream *s,
+                             hwaddr addr, int sid)
+{
+    /* Combine two consecutive 32-bit slots into a 64-bit value.  */
+    if (addr + 1 < R_MAX) {
+        return s->regs[addr] | ((uint64_t)s->regs[addr + 1] << 32);
+    }
+    return s->regs[addr];
+}
+
+static uint64_t axidma_read(void *opaque, hwaddr addr, unsigned size)
 {
     XilinxAXIDMA *d = opaque;
     struct Stream *s;
-    uint32_t r = 0;
     int sid;
 
     sid = streamid_from_addr(addr);
@@ -490,26 +520,102 @@ static uint64_t axidma_read(void *opaque, hwaddr addr,
 
     addr = addr % 0x30;
     addr >>= 2;
+
+    switch (size) {
+    case 8:
+        return axidma_readq(d, s, addr, sid);
+    case 4:
+    default:
+        return axidma_readl(d, s, addr, sid);
+    }
+}
+
+static void axidma_kick(XilinxAXIDMA *d, struct Stream *s, int sid)
+{
+    s->regs[R_DMASR] &= ~DMASR_IDLE;
+    if (!sid) {
+        stream_process_mem2s(s, d->tx_data_dev, d->tx_control_dev);
+    }
+}
+
+static void axidma_writel(XilinxAXIDMA *d, struct Stream *s, hwaddr addr,
+                          uint32_t value, int sid)
+{
     switch (addr) {
-        case R_DMACR:
-            /* Simulate one cycles reset delay.  */
-            s->regs[addr] &= ~DMACR_RESET;
-            r = s->regs[addr];
-            break;
-        case R_DMASR:
-            s->regs[addr] &= 0xffff;
-            s->regs[addr] |= (s->complete_cnt & 0xff) << 16;
-            s->regs[addr] |= (ptimer_get_count(s->ptimer) & 0xff) << 24;
-            r = s->regs[addr];
-            break;
-        default:
-            r = s->regs[addr];
-            D(qemu_log("%s ch=%d addr=" HWADDR_FMT_plx " v=%x\n",
-                           __func__, sid, addr * 4, r));
-            break;
+    case R_DMACR:
+        /* Tailptr mode is always on.  */
+        value |= DMACR_TAILPTR_MODE;
+        /* Remember our previous reset state.  */
+        value |= (s->regs[R_DMACR] & DMACR_RESET);
+        s->regs[R_DMACR] = value;
+
+        if (value & DMACR_RESET) {
+            stream_reset(s);
+        }
+
+        if ((value & 1) && !stream_resetting(s)) {
+            /* Start processing.  */
+            s->regs[R_DMASR] &= ~(DMASR_HALTED | DMASR_IDLE);
+        }
+        stream_reload_complete_cnt(s);
+        break;
+
+    case R_DMASR:
+        /* Mask away write to clear irq lines.  */
+        value &= ~(value & DMASR_IRQ_MASK);
+        s->regs[R_DMASR] = value;
+        break;
+
+    case R_CURDESC:
+        s->regs[R_CURDESC] = value;
+        break;
+
+    case R_CURDESC_MSB:
+        s->regs[R_CURDESC_MSB] = value;
+        break;
+
+    case R_TAILDESC:
+        s->regs[R_TAILDESC] = value;
+        axidma_kick(d, s, sid);
+        break;
+
+    case R_TAILDESC_MSB:
+        s->regs[R_TAILDESC_MSB] = value;
+        axidma_kick(d, s, sid);
+        break;
+
+    default:
+        D(qemu_log("%s: ch=%d addr=" HWADDR_FMT_plx " v=%x\n",
+                   __func__, sid, addr * 4, value));
+        s->regs[addr] = value;
+        break;
     }
-    return r;
+}
 
+static void axidma_writeq(XilinxAXIDMA *d, struct Stream *s, hwaddr addr,
+                          uint64_t value, int sid)
+{
+    switch (addr) {
+    case R_CURDESC:
+        s->regs[R_CURDESC] = (uint32_t)value;
+        s->regs[R_CURDESC_MSB] = (uint32_t)(value >> 32);
+        break;
+
+    case R_TAILDESC:
+        s->regs[R_TAILDESC] = (uint32_t)value;
+        s->regs[R_TAILDESC_MSB] = (uint32_t)(value >> 32);
+        axidma_kick(d, s, sid);
+        break;
+
+    default:
+        D(qemu_log("%s: ch=%d addr=" HWADDR_FMT_plx " v=%x\n",
+                   __func__, sid, addr * 4, (unsigned)value));
+        s->regs[addr] = (uint32_t)value;
+        if (addr + 1 < R_MAX) {
+            s->regs[addr + 1] = (uint32_t)(value >> 32);
+        }
+        break;
+    }
 }
 
 static void axidma_write(void *opaque, hwaddr addr,
@@ -524,44 +630,17 @@ static void axidma_write(void *opaque, hwaddr addr,
 
     addr = addr % 0x30;
     addr >>= 2;
-    switch (addr) {
-        case R_DMACR:
-            /* Tailptr mode is always on.  */
-            value |= DMACR_TAILPTR_MODE;
-            /* Remember our previous reset state.  */
-            value |= (s->regs[addr] & DMACR_RESET);
-            s->regs[addr] = value;
-
-            if (value & DMACR_RESET) {
-                stream_reset(s);
-            }
-
-            if ((value & 1) && !stream_resetting(s)) {
-                /* Start processing.  */
-                s->regs[R_DMASR] &= ~(DMASR_HALTED | DMASR_IDLE);
-            }
-            stream_reload_complete_cnt(s);
-            break;
-
-        case R_DMASR:
-            /* Mask away write to clear irq lines.  */
-            value &= ~(value & DMASR_IRQ_MASK);
-            s->regs[addr] = value;
-            break;
 
-        case R_TAILDESC:
-            s->regs[addr] = value;
-            s->regs[R_DMASR] &= ~DMASR_IDLE; /* Not idle.  */
-            if (!sid) {
-                stream_process_mem2s(s, d->tx_data_dev, d->tx_control_dev);
-            }
-            break;
-        default:
-            D(qemu_log("%s: ch=%d addr=" HWADDR_FMT_plx " v=%x\n",
-                  __func__, sid, addr * 4, (unsigned)value));
-            s->regs[addr] = value;
-            break;
+    switch (size) {
+    case 8:
+        axidma_writeq(d, s, addr, value, sid);
+        break;
+    case 4:
+    default:
+        axidma_writel(d, s, addr, (uint32_t)value, sid);
+        break;
     }
+
     if (sid == 1 && d->notify) {
         StreamCanPushNotifyFn notifytmp = d->notify;
         d->notify = NULL;
@@ -574,6 +653,14 @@ static const MemoryRegionOps axidma_ops = {
     .read = axidma_read,
     .write = axidma_write,
     .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 8
+    },
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 8
+    }
 };
 
 static void xilinx_axidma_realize(DeviceState *dev, Error **errp)
-- 
2.48.1


