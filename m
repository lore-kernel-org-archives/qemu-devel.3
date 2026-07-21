Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 318D4C4452B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 06:10:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm3gQ-0004Qc-Fy; Tue, 21 Jul 2026 02:10:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jianghaotian.sunday@gmail.com>)
 id 1wm3gJ-0004NI-Ko
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 02:10:21 -0400
Received: from mail-pj2-x01.google.com ([2607:f8b0:4864:39::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jianghaotian.sunday@gmail.com>)
 id 1wm3gH-0001Me-7j
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 02:10:18 -0400
Received: by mail-pj2-x01.google.com with SMTP id
 d9443c01a7336-2ce7ac92dfcso60079795ad.1
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 23:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784614215; x=1785219015; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=o766GxEhV3PGRBXOiHXJb69DGsBYL5EaUQhlyW7i0BA=;
 b=NN3BTMGMV68ijsiObLXDA2T32pmgwDBJJgEjqi0ZGAff21pRVvOokbsss6Wilu1Q+e
 VskPVpEtxbpmQSv903Ixs5FI3euyU1keHNV++ttCR0efQj9UMgSiniugV1BE7wGEOx9h
 oCV6Oo90kb/ZKDPHyb+sCiICnfh6zHZSPi3n/RAJx7z5yt/+VR0pDWrr2Dp+UssrOA7P
 Ii63sWU75U9s+y4GA5Y4q0ARaYYFefNa9dl7tYV+qlowUoiraQ63eMufk1u8ZQChIEaK
 F/8DDXS4KqDPzJAw9JLeyJ9Yq7+vPMiv3p2KrpzqgDTCqs/d+17TSAJwiSrPxurdJsL4
 8mRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784614215; x=1785219015;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=o766GxEhV3PGRBXOiHXJb69DGsBYL5EaUQhlyW7i0BA=;
 b=XelOLyKoMVOXF1dP6rzyg5Hwl0WGJmkP8CDY5bFBhDA/DOvUwbm9D4TUx9voAolBkx
 4iC9QLsjXmZFSBIHpwwNJt+BD/C+wcBgh/qejYdviuHc3XuL9KNEzJyh3JUWfWlQiC/k
 OAW6SPachHnlfI1qaThS9ADlZM6zmHopif0J3uvOrPUM6gr/zhJ2GsnupIy/oe+H9Pbx
 QGW5e1fYb6x9OTMHSD+2fLXn+eFEaaVn6e46AjkEGwKn4he+D5lCYhwhfCrJLQPwtZtQ
 taZqRFUOUW/TAFxkc8dxS8CqONxBeeuxMsxbbq85gobjFb78/YMqvszSgO+LsV24SVgz
 bHdA==
X-Gm-Message-State: AOJu0Yx6J6o1Q6xIqtjhdw7CP5xPaTBGtLssj/Gp6Oz+ZLSJEyjKWUtx
 NnP77iq7XmAAGlrXRmG878q8Ft9WltHUZirv1268hlUuWcnm7hY00bY35F8spFMfCSgwE37p
X-Gm-Gg: AR+sD10ssFYajsoqiNmduzAq8EvxkoEvG/jBoH5yj9xglkwCk6231092DLDdu1H5bIJ
 gR1gSh7bu3T8A2z4/5CoInpVVxlJ/iWMp01SDtXmpd9ZdGY/1RLTq7NG7ysBmpIZb5686ZDrTH7
 DvXzNsNT0d7ee51Z36uS+r1p1+zM8P8vS1R7UXBo+/xf6RDKl7adHc4rIhQA5sYnI78wpewdgOZ
 J0GbdA0Lr0fmgQrvPinep2QNKCndH5NO7V28FB2mvqdmJtaP5xN4qulDe9cel2vd2PipZ38rRAm
 LElFGVfcveZ6RShjs9Kwf/ZTqZ7Xm5ZDfKVWAleW0QBibAXi/sPhE68lHlQeN9Uw2euDeK6ow5H
 /6xeAvcG32RFP5Glb74toxt1kLCoVeCl6Q56uxM6JzOX+LTPCRPiMO4tw8QYaRYpkiGYKaKYM8f
 JZFTXWrgL23NYziJ4+5qTwKxSsUaBJEcWrQEkrrj4uEZwS7ZVpizwkZY7jP/FFxZZAt0yzMAevq
 Aph91QhAaeB8OmYtl3uaT0LBerfHg==
X-Received: by 2002:a17:902:c411:b0:2c9:97a9:2096 with SMTP id
 d9443c01a7336-2cf349edab6mr171939945ad.42.1784614215156; 
 Mon, 20 Jul 2026 23:10:15 -0700 (PDT)
Received: from VM-210-252-ubuntu.. ([14.116.239.40])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cf3477eecdsm68615165ad.78.2026.07.20.23.10.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 23:10:14 -0700 (PDT)
From: jianghaotian.sunday@gmail.com
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, philmd@redhat.com, thuth@redhat.com, alxndr@bu.edu,
 qemu-stable@nongnu.org, Haotian Jiang <jianghaotian.sunday@gmail.com>
Subject: [PATCH] hw/audio/intel-hda: restrict all DMA engine paths to memories
Date: Tue, 21 Jul 2026 14:09:41 +0800
Message-Id: <20260721060941.2989396-1-jianghaotian.sunday@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::1;
 envelope-from=jianghaotian.sunday@gmail.com; helo=mail-pj2-x01.google.com
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


