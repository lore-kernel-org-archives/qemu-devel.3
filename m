Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94682C531FA
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 10:30:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnDAM-0000MY-9c; Fri, 24 Jul 2026 06:30:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mike.malyshev@gmail.com>)
 id 1wnDAK-0000ME-TA
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 06:30:04 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mike.malyshev@gmail.com>)
 id 1wnDAI-0002pZ-NE
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 06:30:04 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4954c0833b4so2532205e9.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 03:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784889001; x=1785493801; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=OAjAgnPYD2WaOu663GkkWsCmQkeSlXjK0w493DiVgow=;
 b=AVrrxNDAVCmJep/bIeeawZvLhuuj3oI7GvSRM8zFBWMgVDrAzXk05owQUnCfv5OXfQ
 hS7XAIXVQ2SzsFK9XzRsG3Zlm0Ae4wiTFlOgM9xDk6EleQ6CaizsakbLXQ7/vMLnPeXc
 8s3RCbIJDup4vOARf7OZvClxevwE1jgz/N3cGH/rTDifxgrSGMuxipOYCgKSd62WF9ts
 hm4Cg0MDXJY9GJhH0X0aFCP6ctiR6uEqDM4OQaqOkn761a6zmwSlqEeHwJI+G8vxt9xx
 An1j/7XOvZ5w3NEszoprtbZiKi2yJvQb+nsRxO44k2oXJ80zk5jhxZZ/cwp/MprRET7A
 SXow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784889001; x=1785493801;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=OAjAgnPYD2WaOu663GkkWsCmQkeSlXjK0w493DiVgow=;
 b=LQ3xx7NxDrzsubqfT/gQZTjJtMm6QIVlTG0fj+2WGbHCV7m+b/q8PVZLti3YP8w7Wq
 PXHiHpnMxhlIH/+EqdSB9tqfNlTILoMIOo5NXBbtKDyKF3TgsPxx59E4bK3Ot1USNEft
 f70MMoIP3wtdrInDSBMoiCyAyv2wLX0s56L2/kXCwgtPpt60prqt6Zr9icxENjtF4cfv
 EkdH9MmQxaDN5ItToIYoRSp3QKtzqOEqFYu3xbg1ZAG57SrtsHzz9OAYf7UKdVL/eSh2
 PmQegWpgGYUPDcigs+Bm3TxqatboCen83syMG44OUkm802lnpCMZm4fIsDzUcx3kop/5
 Edhw==
X-Gm-Message-State: AOJu0Ywjtj8Kf4Z3wAhcckWbYS6jrHObay3QJMELRm78UOVZ274YpkRH
 StwjM3p3IvbHl7hrDTxV2LbNPRJ8hvKuT7p6tMDcedbv+NA2g6dMVnJCWBlkKyru
X-Gm-Gg: AR+sD12rjCIUdUVHIh5uJhCUeI1aeQrPGpnwPZL+32Mvn6bst7FzbWKekBrM5zECMUZ
 VwvCEGPE2oihrmLhJwW8LFcYqRuPPbWcB57l/2WOxKBtv5/V8qmAsHyohL4OTCckaCYk4CKy7Yq
 J/IMRahmDm3LgzE5G6pLGctVvYcBM67cqMnkrMgsFufGeWb0tSNVSSwesNAvRd2qtrt9UvJL8NL
 Bwv7+QPRTfiCnphL2EQoMbHSqZuX1iAF6FeXvoaNBWJEOwtVbnRUHtQFbonz0OyDsGTJe4AtoSH
 5TYnFZRF6dcM2wqW/yMLB4tNglgpnP2BwkbXKj3bthz5si0SDY/qv8xE+aHbN1MekW0uEfQJeGo
 le9J3EE1gleKdWQ1SNblFdWTycflw/8dyp9Zd7zfV4T45SG+veFVo43SyFDLYEWMqinUcfCC8Wq
 QGFESLZM8=
X-Received: by 2002:a05:600c:4687:b0:495:5dcc:52ae with SMTP id
 5b1f17b1804b1-49573cc2eb8mr82062105e9.3.1784889000608; 
 Fri, 24 Jul 2026 03:30:00 -0700 (PDT)
Received: from build-server.. ([62.96.37.222])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85bb57cfsm22658750f8f.11.2026.07.24.03.29.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 03:30:00 -0700 (PDT)
From: mike.malyshev@gmail.com
To: qemu-devel@nongnu.org, Tomita Moeko <tomitamoeko@gmail.com>,
 alex@shazbot.org
Subject: [PATCH v2] vfio/igd: sanitize DBUF_CTL POWER_STATE for iGPU
 passthrough
Date: Fri, 24 Jul 2026 10:29:58 +0000
Message-ID: <20260724102959.1043264-1-mike.malyshev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20027e4f-5a4d-4842-a60d-cd83a5755cff@gmail.com>
References: <20027e4f-5a4d-4842-a60d-cd83a5755cff@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=mike.malyshev@gmail.com; helo=mail-wm1-x334.google.com
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

From: Mikhail Malyshev <mike.malyshev@gmail.com>

On some hosts the firmware POST modeset leaves the display data buffer
(DBUF) powered, so the passed-through iGPU's DBUF_CTL registers read
back POWER_STATE=1 while POWER_REQUEST=0 -- an inconsistent leftover that
never occurs under GVT-g, which emulates the register so POWER_STATE
follows POWER_REQUEST.

This was observed with a Windows guest (Intel KMD) on QEMU 9.1; a
Linux/i915 guest was not tested.  On the first-boot modeset the guest
driver samples POWER_STATE to decide which DBUF slices are already
enabled, sees the stale "powered" bit, and therefore never issues
POWER_REQUEST.  DBUF then powers down, the plane FIFO underruns, and
scanout is corrupted (vertical stripes) until a full modeset (e.g. a
display sleep/wake) re-requests power.

The programming is a single inconsistent read-modify-write.  Traced with
x-no-mmap=on so every BAR0 access is visible:

  read  0x45008 = 0x4040c000   STATE=1, REQUEST=0 (stale leftover)
  write 0x45008 = 0x4043c000   RMW: tracker bits only; REQUEST still 0
  read  0x45008 = 0x0043c000   STATE=0: DBUF powered down -> underrun

The driver sees STATE=1, assumes the slice is already powered, and leaves
REQUEST clear.  Only after a display sleep/wake does it set REQUEST, which
is why sleep/wake repairs the display:

  write 0x45008 = 0x8043c000   REQUEST=1
  read  0x45008 = 0xc043c000   STATE follows -> powered, scanout clean

The same pattern occurs on the other slice registers (0x44fe8, 0x44300,
0x44304).

Present a consistent view like GVT-g: trap the DBUF_CTL slice registers
(S1..S4, only as many as the generation exposes) in BAR0 and clear
POWER_STATE on read whenever POWER_REQUEST is not set.  Writes pass
straight through to the device.

Signed-off-by: Mikhail Malyshev <mike.malyshev@gmail.com>
---

Changes in v2:
- Expand the commit message with the traced read-modify-write sequence
  that shows POWER_REQUEST is never set on first boot (Tomita Moeko).
- Collapse the per-slice quirk allocations into a single
  vfio_quirk_alloc(nslices) with one mem[] entry per slice, backed by a
  single IGDDbufCtlQuirk array (Tomita Moeko).
- Split the quirk allocation onto its own line for readability (Tomita
  Moeko).
 hw/vfio/igd.c | 119 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 413a49aae9..5e6160763c 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -455,6 +455,96 @@ static bool vfio_pci_igd_override_gms(int gen, uint32_t gms, uint32_t *gmch)
 #define IGD_GGC_MMIO_OFFSET     0x108040
 #define IGD_BDSM_MMIO_OFFSET    0x1080C0
 
+/*
+ * IGD BAR0 DBUF_CTL sanitize quirk.
+ *
+ * On hosts where the firmware POST modeset left the display engine powered,
+ * DBUF_CTL reads back POWER_STATE=1 while POWER_REQUEST=0 -- an inconsistent
+ * leftover that never occurs under GVT-g (which emulates the register so
+ * STATE follows REQUEST).  A passed-through guest driver samples POWER_STATE
+ * to decide which DBUF slices are already enabled, sees this stale "powered"
+ * bit, and therefore never issues POWER_REQUEST.  DBUF then powers down, the
+ * plane FIFO underruns, and scanout is corrupted until a full modeset (e.g.
+ * a display sleep/wake) re-requests power.
+ *
+ * Present a consistent view like GVT-g: intercept DBUF_CTL reads and clear
+ * POWER_STATE whenever POWER_REQUEST is not set.  Writes pass straight
+ * through to the device.
+ */
+#define IGD_DBUF_POWER_REQUEST  (1u << 31)
+#define IGD_DBUF_POWER_STATE    (1u << 30)
+
+/*
+ * DBUF_CTL slice registers within BAR0, in slice order (i915 numbers these
+ * S1..S4).  How many slices exist is generation-dependent, so only the first
+ * igd_dbuf_ctl_nslices(gen) entries are real DBUF_CTL registers on a given
+ * part; the rest are unrelated registers and must not be trapped.
+ */
+static const uint32_t igd_dbuf_ctl_offsets[] = {
+    0x45008, /* S1 */ 0x44FE8, /* S2 */ 0x44300, /* S3 */ 0x44304, /* S4 */
+};
+
+/*
+ * DBUF slice count by generation, matching i915 dbuf.slice_mask:
+ * gen9/10 = 1 (S1), gen11 = 2 (S1-S2), gen12+ = 4 (S1-S4).
+ *
+ * Within gen12 the slice count is actually per-platform, not per-gen: ADL-P /
+ * RPL-P / DG2 expose 4 slices, but TGL / RKL / ADL-S have only 2.  We return 4
+ * for all gen12+ (igd_gen() can't distinguish them), so on a <4-slice gen12
+ * part S3/S4 (0x44300/0x44304) are over-trapped.  This is harmless in practice:
+ * the read handler only mutates a value when POWER_REQUEST=0 && POWER_STATE=1,
+ * which whatever register lives at those offsets is very unlikely to present.
+ * A fully-correct count would have to key off the PCI device ID.
+ */
+static int igd_dbuf_ctl_nslices(int gen)
+{
+    if (gen <= 10) {
+        return 1;
+    }
+    if (gen == 11) {
+        return 2;
+    }
+    return 4;
+}
+
+typedef struct IGDDbufCtlQuirk {
+    VFIOPCIDevice *vdev;
+    uint32_t bar_offset;    /* offset within BAR0 MMIO */
+    uint8_t bar;
+} IGDDbufCtlQuirk;
+
+static uint64_t igd_dbuf_ctl_read(void *opaque, hwaddr addr, unsigned size)
+{
+    IGDDbufCtlQuirk *q = opaque;
+    VFIOPCIDevice *vdev = q->vdev;
+    uint64_t val = vfio_region_read(&vdev->bars[q->bar].region,
+                                    addr + q->bar_offset, size);
+
+    if (size == 4 && !(val & IGD_DBUF_POWER_REQUEST) &&
+        (val & IGD_DBUF_POWER_STATE)) {
+        val &= ~(uint64_t)IGD_DBUF_POWER_STATE;
+        error_report_once("IGD quirk: DBUF_CTL@0x%x cleared stale "
+                          "POWER_STATE (POWER_REQUEST=0)", q->bar_offset);
+    }
+    return val;
+}
+
+static void igd_dbuf_ctl_write(void *opaque, hwaddr addr,
+                               uint64_t data, unsigned size)
+{
+    IGDDbufCtlQuirk *q = opaque;
+    VFIOPCIDevice *vdev = q->vdev;
+
+    vfio_region_write(&vdev->bars[q->bar].region,
+                      addr + q->bar_offset, data, size);
+}
+
+static const MemoryRegionOps igd_dbuf_ctl_ops = {
+    .read = igd_dbuf_ctl_read,
+    .write = igd_dbuf_ctl_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
 void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
 {
     VFIOQuirk *ggc_quirk, *bdsm_quirk;
@@ -507,6 +597,35 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
                                         1);
 
     QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, bdsm_quirk, next);
+
+    /*
+     * DBUF_CTL sanitize quirk (gen9+): trap the DBUF_CTL slice registers so
+     * POWER_STATE is reported consistently with POWER_REQUEST (see
+     * igd_dbuf_ctl_read()).  Only trap slices that actually exist on this
+     * generation -- the remaining offsets are unrelated registers.
+     */
+    if (gen >= 9) {
+        int i, nslices = igd_dbuf_ctl_nslices(gen);
+        VFIOQuirk *dbuf_quirk = vfio_quirk_alloc(nslices);
+        IGDDbufCtlQuirk *dq;
+
+        dq = g_new0(IGDDbufCtlQuirk, nslices);
+        dbuf_quirk->data = dq;
+
+        for (i = 0; i < nslices; i++) {
+            dq[i].vdev = vdev;
+            dq[i].bar = nr;
+            dq[i].bar_offset = igd_dbuf_ctl_offsets[i];
+            memory_region_init_io(&dbuf_quirk->mem[i], OBJECT(vdev),
+                                  &igd_dbuf_ctl_ops, &dq[i],
+                                  "vfio-igd-dbuf-ctl-quirk", 4);
+            memory_region_add_subregion_overlap(vdev->bars[nr].region.mem,
+                                                igd_dbuf_ctl_offsets[i],
+                                                &dbuf_quirk->mem[i], 1);
+        }
+
+        QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, dbuf_quirk, next);
+    }
 }
 
 static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
-- 
2.43.0


