Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3827CC6B1C
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 03:38:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHCI4-00055g-5o; Wed, 14 Oct 2026 23:38:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1xHCI0-00055D-ND
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 23:37:56 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1xHCHy-0008KT-TR
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 23:37:56 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-881269371acso3349709b3a.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 20:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1792035474; x=1792640274; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Cel5+2eqrSaSNQE0/ea7lfr60XbLmvN5Ji76fJ0qJK0=;
 b=ItJJLWo9LHcBUaio8Yt2B1N6c01RzJCVRcbgEapZ7mziyxa1eLxoZLt5gHgwm/gPJ0
 AwiOrhwxxbwqKRfvnUSCsGj9vxSdVo4xfp0x2+GtfEjEaC21UGsu9YioQGKReXsVjO4l
 LmcUn4K+Jesb01HHcLxoNFb4NReIvYxk+/xNVyY0earaWw4t53SsH09l72ov34mCfwmK
 KB7pS4vgtLNs00PyRYO35MEy+UBGvYaUrE9+dxyrqSSon7BpeseanTl5W5zoJWaKrgMO
 LczeS/p+DcPzUVlg9GlfmijGVfKt70YSkl7IfDhKRnU/vmSNH6i70lJT2xBK/Zi67kbd
 SGNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792035474; x=1792640274;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Cel5+2eqrSaSNQE0/ea7lfr60XbLmvN5Ji76fJ0qJK0=;
 b=DlCjw+oSgEj7bhxE6d05F9Ji99tlbCxcbE2eeHRMPfW6MWFAgZsM0WJMg0A13AUqAr
 xpMIjlVmXxKDW8MPisG3do9Uky3r0wJxtQiNO9GIHLZg9SRxNcTnlv7UPhH1eC+Zskvv
 JZpkMJ/TDbh54iPf1Z+9abgZq1nfxXpdlABVb7c4A4u4Qu01WH0f1b72/kLjzYCCDNUG
 i4hpD7tzDR1nMeBzjHULBG/O1UH9d4RTppev9PUq5U3QHdkoZ9lfNJBtjgExxMlMpqFr
 Ibeq8KxFg7RMbAnPgwCzPMWwLOFtUm262vcmJrWzUZTUmkg9Lg0XuGZ3d/DU9Nx/pUmY
 6D8Q==
X-Gm-Message-State: AFq9FYIBxX27SvmNZrYjtckl31pvfcnGeoBpVtCJpOYaEDstTa3ciyjt
 oUaJERomz9UmBT/gwwvbcwM6bA35ZIikRpWRkttFeVir3gDna7KROZgmvZXWOaggwMldkCB2gQv
 yPndXQiE3RzA9PkyspUHmcetxRi7Z3oRsK2RVtRvEORfWCEHEUOiDaAzlfqX/rNiRbke6acgM+9
 WMlvm8pMMHq0BxuKRt6Ne409RBAIdJ7gOTsQIhwUAvIgXk2w==
X-Gm-Gg: AYBFou2pK4c6XcI1Q+Qdhc8ef8Dk18oWJuvDE2ov87p+X3jl2fkR990LYlowdOZDgp5
 x9Ya2BshUjObH+LCbUa1SFXRhIjOuGKRGZTBPmluzu/tDs1d+vC+ngANFxwdxXXG0fexGbdO8RK
 ienhRS5K/l3vgrtXTCq2lb0IM4XF8/zj3AdQLtlEoVDjjQ2KGL877AK5mh3QEYn3BP1XtVXBYNj
 fbMzKOpxwgpg8l9zUSfWLzYbRulaYj2K8sDFtvwNsUHfj/lWFrL6fYagYmB9c3GHUcuW03VmSiz
 wnOFr5CcQ9l9aCCuGpMj4PJPKu3l+d4xWOOmUgj15ZTafbfl5EQx8etP0OIQ4AKcKpXvTQ4nCCd
 C1OHax6oi0bZf79Gmdr/wsbatV/oq0jBrceM4vxhrpp7OaRb8Eu70UxtX2SnA4zT8C+oq2raYT+
 Nmeo1ZpgtnT+P7y9mVQeF4xM0sX+PXtVpsSUNdUnTQNXkUJFAPaxuF6uN9+Wi3oPXxqiryb8VZR
 Tm1+EN7AHpf8ivA5/Sn6xW7JAlWnVe0bk8n
X-Received: by 2002:a05:6a20:a10e:b0:3e1:37c9:5ca2 with SMTP id
 adf61e73a8af0-3e164f2cb92mr11336303637.19.1792035473338; 
 Wed, 14 Oct 2026 20:37:53 -0700 (PDT)
Received: from jchang-1875.internal.sifive.com ([136.226.240.181])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd635c612a9sm559188a12.17.2026.10.14.20.37.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 14 Oct 2026 20:37:52 -0700 (PDT)
From: Jay Chang <jay.chang@sifive.com>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jason Wang <jasowangio@gmail.com>,
 qemu-arm@nongnu.org (open list:Xilinx Zynq),
 Jay Chang <jay.chang@sifive.com>, Frank Chang <frank.chang@sifive.com>,
 Jim Shu <jim.shu@sifive.com>
Subject: [PATCH 1/6] hw/dma/xilinx_axidma: Support 64-bit descriptor
 addressing in stream processing
Date: Thu, 15 Oct 2026 11:37:28 +0800
Message-ID: <20261015033733.35116-2-jay.chang@sifive.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20261015033733.35116-1-jay.chang@sifive.com>
References: <20261015033733.35116-1-jay.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=jay.chang@sifive.com; helo=mail-pf1-x42f.google.com
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

The Xilinx AXI DMA controller supports both 32-bit and 64-bit descriptor
addressing through register pairs (e.g., CURDESC/CURDESC_MSB and
TAILDESC/TAILDESC_MSB). However, the original implementation only handled
32-bit addresses correctly in the stream processing functions.

This resulted in MEMTX_DECODE_ERROR when the DMA engine attempted to
access buffer descriptors at invalid addresses, breaking network operations
like DHCP and ping.

Signed-off-by: Jay Chang <jay.chang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Jim Shu <jim.shu@sifive.com>
---
 hw/dma/xilinx_axidma.c | 42 ++++++++++++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 12 deletions(-)

diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
index 22dec8b3eb..45fd2e45c1 100644
--- a/hw/dma/xilinx_axidma.c
+++ b/hw/dma/xilinx_axidma.c
@@ -181,6 +181,11 @@ static void stream_reset(struct Stream *s)
 {
     s->regs[R_DMASR] = DMASR_HALTED;  /* starts up halted.  */
     s->regs[R_DMACR] = 1 << 16; /* Starts with one in compl threshold.  */
+    /* Initialize descriptor registers to zero for both 32 and 64 bit */
+    s->regs[R_CURDESC] = 0;
+    s->regs[R_CURDESC + 1] = 0; /* CURDESC_MSB */
+    s->regs[R_TAILDESC] = 0;
+    s->regs[R_TAILDESC + 1] = 0; /* TAILDESC_MSB */
     s->sof = true;
 }
 
@@ -194,6 +199,16 @@ static inline int streamid_from_addr(hwaddr addr)
     return sid;
 }
 
+static inline hwaddr stream_desc_addr(struct Stream *s)
+{
+    return s->regs[R_CURDESC] | ((uint64_t)s->regs[R_CURDESC + 1] << 32);
+}
+
+static inline hwaddr stream_tail_addr(struct Stream *s)
+{
+    return s->regs[R_TAILDESC] | ((uint64_t)s->regs[R_TAILDESC + 1] << 32);
+}
+
 static MemTxResult stream_desc_load(struct Stream *s, hwaddr addr)
 {
     struct SDesc *d = &s->desc;
@@ -290,9 +305,9 @@ static void stream_complete(struct Stream *s)
 static void stream_process_mem2s(struct Stream *s, StreamSink *tx_data_dev,
                                  StreamSink *tx_control_dev)
 {
-    uint32_t prev_d;
-    uint32_t txlen;
+    uint32_t txlen, origin_txlen;
     uint64_t addr;
+    hwaddr curdesc;
     bool eop;
 
     if (!stream_running(s) || stream_idle(s) || stream_halted(s)) {
@@ -300,7 +315,8 @@ static void stream_process_mem2s(struct Stream *s, StreamSink *tx_data_dev,
     }
 
     while (1) {
-        if (MEMTX_OK != stream_desc_load(s, s->regs[R_CURDESC])) {
+        curdesc = stream_desc_addr(s);
+        if (MEMTX_OK != stream_desc_load(s, curdesc)) {
             break;
         }
 
@@ -314,6 +330,7 @@ static void stream_process_mem2s(struct Stream *s, StreamSink *tx_data_dev,
         }
 
         txlen = s->desc.control & SDESC_CTRL_LEN_MASK;
+        origin_txlen = txlen;
 
         eop = stream_desc_eof(&s->desc);
         addr = s->desc.buffer_address;
@@ -334,13 +351,13 @@ static void stream_process_mem2s(struct Stream *s, StreamSink *tx_data_dev,
         }
 
         /* Update the descriptor.  */
-        s->desc.status = txlen | SDESC_STATUS_COMPLETE;
-        stream_desc_store(s, s->regs[R_CURDESC]);
+        s->desc.status = origin_txlen | SDESC_STATUS_COMPLETE;
+        stream_desc_store(s, curdesc);
 
         /* Advance.  */
-        prev_d = s->regs[R_CURDESC];
         s->regs[R_CURDESC] = s->desc.nxtdesc;
-        if (prev_d == s->regs[R_TAILDESC]) {
+        s->regs[R_CURDESC + 1] = s->desc.nxtdesc >> 32;
+        if (curdesc == stream_tail_addr(s)) {
             s->regs[R_DMASR] |= DMASR_IDLE;
             break;
         }
@@ -350,16 +367,17 @@ static void stream_process_mem2s(struct Stream *s, StreamSink *tx_data_dev,
 static size_t stream_process_s2mem(struct Stream *s, unsigned char *buf,
                                    size_t len, bool eop)
 {
-    uint32_t prev_d;
     unsigned int rxlen;
     size_t pos = 0;
+    hwaddr curdesc;
 
     if (!stream_running(s) || stream_idle(s) || stream_halted(s)) {
         return 0;
     }
 
     while (len) {
-        if (MEMTX_OK != stream_desc_load(s, s->regs[R_CURDESC])) {
+        curdesc = stream_desc_addr(s);
+        if (MEMTX_OK != stream_desc_load(s, curdesc)) {
             break;
         }
 
@@ -388,13 +406,13 @@ static size_t stream_process_s2mem(struct Stream *s, unsigned char *buf,
 
         s->desc.status |= s->sof << SDESC_STATUS_SOF_BIT;
         s->desc.status |= SDESC_STATUS_COMPLETE;
-        stream_desc_store(s, s->regs[R_CURDESC]);
+        stream_desc_store(s, curdesc);
         s->sof = eop;
 
         /* Advance.  */
-        prev_d = s->regs[R_CURDESC];
         s->regs[R_CURDESC] = s->desc.nxtdesc;
-        if (prev_d == s->regs[R_TAILDESC]) {
+        s->regs[R_CURDESC + 1] = s->desc.nxtdesc >> 32;
+        if (curdesc == stream_tail_addr(s)) {
             s->regs[R_DMASR] |= DMASR_IDLE;
             break;
         }
-- 
2.48.1


