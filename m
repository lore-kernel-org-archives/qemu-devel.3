Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A153AC4453A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 02:15:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmixQ-0007cH-HD; Wed, 22 Jul 2026 22:14:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jianghaotian.sunday@gmail.com>)
 id 1wmixP-0007bN-Id
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 22:14:43 -0400
Received: from mail-pj2-x03.google.com ([2607:f8b0:4864:39::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jianghaotian.sunday@gmail.com>)
 id 1wmixN-0001MX-U8
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 22:14:43 -0400
Received: by mail-pj2-x03.google.com with SMTP id
 98e67ed59e1d1-38111ea8a88so81827a91.1
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 19:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784772880; x=1785377680; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=o766GxEhV3PGRBXOiHXJb69DGsBYL5EaUQhlyW7i0BA=;
 b=YomiUgTkExByLS6Rb+vrWmS/n3505phM0Ekpni9j+c7CV7niUHwfO8CD184FLtiB42
 Z2C9shGGuje5dIf9uGyEBuxJkGKrZ+PCa21ejOa2hDgQH1Uj8O+eEWUUFNCi7oscP181
 0YsfEEQDRmqX0r7cn3rQzTWTiLytd0uN6kRFeYVhEwYp1PSLe8kleq2Kq5aFF6muGd4h
 EBgpYDs4WCc84vTF73ONpL6BHjBDJEJimeQQGPEklNEkBg5X6GUjQhH97Zcf6RVDWo1N
 2cYI/mRd6qibOhna+8nFqRk5H7md2kHznEFBrJRyXdQZXuXWoYs/8Dwq2+QhWyO7ow5K
 oSig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784772880; x=1785377680;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=o766GxEhV3PGRBXOiHXJb69DGsBYL5EaUQhlyW7i0BA=;
 b=GnLuBSsUntIWjkMTtNbY3M7evlN4zCS1O8U5h8mbN+EzC9ro8PYMegLYQwCjNraf4G
 muYaA+OeFp0LbGFnqFhU69ctpfmr4OnkOBKpy2eAgD4DPWUYjLUXU+oV1ojOg5X2S+7c
 8W4n9bQe10z1RPS2WsvxpvMxGNCoE2y6/l+QdPoN2QMyW5ELLohR7DhHMuU57sbaIgnJ
 X0x/0Qdt4tb9Y3Ycz3WMr6nwnnp6KWZnOO3+uNa/RtMNGMYkEd6f21MrqjketiBNip1g
 J12JHIpURSaDagGw+yk7qo8kxfhZHX/A93zajotGxX50ypoaScCimSJrTwX+dNdo2CSq
 Ovzw==
X-Gm-Message-State: AOJu0YwhwU+vrvZ2igOaAfk5otL9+urapfJK7sESbbhv867bTA9CL6e+
 yTeZjqQCO+utjkMUXNPI77vPfEs+4gobenxN0zM7cDIIh3CRgIsApUwgp2/F0Vk9K/c/bw==
X-Gm-Gg: AR+sD11bmKGxLTzO3NQnJdRaJ4pH3aj5Ez4i90rMzqwfhakfm388Z9xFJGeNzgUgRrh
 rzqZMWX78nakO6mGBRz1xF77J8liuGec95jrVIZlrMFPMqq0+Ob7cdSNme97ln69eYwhdtGjdmL
 fw4v0p3uCqMIioIdsjJNHlQlDX4w/LgdMKN853wjYvOhEGk3oY8VLrAq7mbKRm5BNMRKUahIgFJ
 g1xKJ8/kzYoyGZYd78SZQQyTafkdvG/1EwixHhjSp9FdtrVeIxVDdTkimkKT6l52L/7rK+a9hlL
 ECQhzSego/k94r8JfVAXg3ygjvONfMSAh7Qv6L2JbpBOkFwak6GtScHs8wEWuzLc+5NtS9pi9Ik
 cZL7TqIwgf+gDLZkw2yiKANaH5aimtqRnWjIFbkWFKI9LU/wj4MCz55CipDLJlSHchr7yCmik6A
 yxPmldSC/857z9OwX45IeaTJnz0xilr12mKjpbLJdZD8dyHyjdkgW6jq68gDlDrjwJlxdoB/HoX
 aMjnVn/pnczEM0mi0BIPVkLFzIBAA==
X-Received: by 2002:a17:90b:4c0e:b0:38e:6aa7:68ad with SMTP id
 98e67ed59e1d1-38ec648ac8amr1123522a91.5.1784772879979; 
 Wed, 22 Jul 2026 19:14:39 -0700 (PDT)
Received: from VM-210-252-ubuntu.. ([14.116.239.39])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38ecad34d41sm66860a91.9.2026.07.22.19.14.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 19:14:38 -0700 (PDT)
From: jianghaotian.sunday@gmail.com
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, Haotian Jiang <jianghaotian.sunday@gmail.com>,
 qemu-stable@nongnu.org
Subject: [PATCH] hw/audio/intel-hda: restrict all DMA engine paths to memories
Date: Thu, 23 Jul 2026 10:14:12 +0800
Message-Id: <20260723021412.377244-1-jianghaotian.sunday@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::3;
 envelope-from=jianghaotian.sunday@gmail.com; helo=mail-pj2-x03.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Haotian Jiang <jianghaotian.sunday@gmail.com>

CVE-2021-3611 (commit 79fa99831d) restricted the DMA engine to memories
by setting attrs.memory=true, but only applied this to intel_hda_response.
Three other DMA engine access points still use MEMTXATTRS_UNSPECIFIED,
allowing a malicious guest to trigger DMA-to-self-MMIO reentry:

  - intel_hda_xfer (line 398): called from the audio timer callback
    (hda_codec_xfer -> bus->xfer), so the MemReentrancyGuard does not
    fire (engaged_in_io is false outside MMIO dispatch). A guest that
    points a BDL entry at the HDA controller's own MMIO BAR can write
    audio samples to device registers, triggering whandler side effects
    such as starting/stopping streams or injecting codec commands via
    CORBWP.
  - intel_hda_parse_bdl (line 478): uses pci_dma_read which hardcodes
    MEMTXATTRS_UNSPECIFIED. A guest-controlled BDL base address can
    point at controller MMIO, allowing the DMA engine to read device
    registers as BDL descriptors.
  - intel_hda_corb_run (line 333): ldl_le_pci_dma reads the CORB ring
    with MEMTXATTRS_UNSPECIFIED, allowing the DMA engine to read
    controller MMIO as CORB entries.

Fix all three by passing {.memory = true} explicitly, matching the
fix already applied to intel_hda_response. For intel_hda_parse_bdl,
replace pci_dma_read with pci_dma_rw to pass the controlled attrs.

Fixes: 79fa99831d ("hw/audio/intel-hda: Restrict DMA engine to memories (not MMIO devices)")
Reported-by: Haotian Jiang of Tencent Security (Yunding Lab) <jianghaotian.sunday@gmail.com>
Signed-off-by: Haotian Jiang <jianghaotian.sunday@gmail.com>
Cc: qemu-stable@nongnu.org
---
 hw/audio/intel-hda.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/audio/intel-hda.c b/hw/audio/intel-hda.c
index d7c2c3c2fd..3d361a4976 100644
--- a/hw/audio/intel-hda.c
+++ b/hw/audio/intel-hda.c
@@ -305,6 +305,7 @@ static int intel_hda_send_command(IntelHDAState *d, uint32_t verb)
 
 static void intel_hda_corb_run(IntelHDAState *d)
 {
+    const MemTxAttrs attrs = { .memory = true };
     hwaddr addr;
     uint32_t rp, verb;
 
@@ -330,7 +331,7 @@ static void intel_hda_corb_run(IntelHDAState *d)
 
         rp = (d->corb_rp + 1) & 0xff;
         addr = intel_hda_addr(d->corb_lbase, d->corb_ubase);
-        ldl_le_pci_dma(&d->pci, addr + 4 * rp, &verb, MEMTXATTRS_UNSPECIFIED);
+        ldl_le_pci_dma(&d->pci, addr + 4 * rp, &verb, attrs);
         d->corb_rp = rp;
 
         dprint(d, 2, "%s: [rp 0x%x] verb 0x%08x\n", __func__, rp, verb);
@@ -395,7 +396,7 @@ static void intel_hda_response(HDACodecDevice *dev, bool solicited, uint32_t res
 static bool intel_hda_xfer(HDACodecDevice *dev, uint32_t stnr, bool output,
                            uint8_t *buf, uint32_t len)
 {
-    const MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
+    const MemTxAttrs attrs = { .memory = true };
     HDACodecBus *bus = HDA_BUS(dev->qdev.parent_bus);
     IntelHDAState *d = container_of(bus, IntelHDAState, codecs);
     hwaddr addr;
@@ -466,6 +467,7 @@ static bool intel_hda_xfer(HDACodecDevice *dev, uint32_t stnr, bool output,
 
 static void intel_hda_parse_bdl(IntelHDAState *d, IntelHDAStream *st)
 {
+    const MemTxAttrs attrs = { .memory = true };
     hwaddr addr;
     uint8_t buf[16];
     uint32_t i;
@@ -475,7 +477,8 @@ static void intel_hda_parse_bdl(IntelHDAState *d, IntelHDAStream *st)
     g_free(st->bpl);
     st->bpl = g_new(bpl, st->bentries);
     for (i = 0; i < st->bentries; i++, addr += 16) {
-        pci_dma_read(&d->pci, addr, buf, 16);
+        pci_dma_rw(&d->pci, addr, buf, 16,
+                   DMA_DIRECTION_TO_DEVICE, attrs);
         st->bpl[i].addr  = le64_to_cpu(*(uint64_t *)buf);
         st->bpl[i].len   = le32_to_cpu(*(uint32_t *)(buf + 8));
         st->bpl[i].flags = le32_to_cpu(*(uint32_t *)(buf + 12));
-- 
2.34.1


