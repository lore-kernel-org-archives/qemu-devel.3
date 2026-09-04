Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFD71C79F80
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 05:24:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2MLr-0005wL-I5; Fri, 04 Sep 2026 01:20:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1x2MLk-0005kb-B6
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:20:28 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1x2MLi-0001Gw-IT
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:20:28 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-cbe827e3cb4so741733a12.3
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 22:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788499225; x=1789104025; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bE31VsjC3BVZxE/12f/J/EV90ViktIlOgWatYn0ZTXU=;
 b=pL0RnmV/aumHg2gKRylyFoqBV/vRDVoqZ/MwTTC6W1Bys7srJe9wFEa8TgPJ0xFhSm
 uN9HjFS5+/WPhRbVY6vNi8Ozv7X36dV2lECl/v/DQy7nUFwhxyE54RBky6ASMSD60Spm
 09th34KW/b70M/8Sk9enFkNw7dXLiHncsPIaoGePfriAUHsdTF6dPmye9IhqnxP2dsCy
 pBgqhqSuJWKCIWm/hf3HBXBAuhZWmAMoixi0rLEGY6dN2IGBJnc4s7h2ryv9FYN457GT
 RXtEMRUmHUTIjFJ8JYVx2cwVVrF8hr2mndZX6NfT4hqi8YM9YT6M80jPjT2+YyXjCc/d
 +HJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788499225; x=1789104025;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bE31VsjC3BVZxE/12f/J/EV90ViktIlOgWatYn0ZTXU=;
 b=NCDgtMAH67CCZA2ByvZmmMMDJIaoTFYt2nY8ePcnBnfYccm1zKPLjFVO0/cKbOLvsr
 rmv+0xb0K1I4qx5FRpq7+XPby1qqPTey+8SMMYUr5gn/IgSD4zAZarAgOs1svzar/zmk
 ZHb3Q1gXmi1FOq5a4XUUgKctjkpatFIOJ8GXZpX/+3dT9D67mtld5spA+g6z+ZiHeIEf
 WyRdRRX5ph1vjOTVLZIuTzH2CirA8w6tZgPCzRIlUe6fBzrC9ANIgJaR9ecCGudy0zn8
 kkxjsadvNE9I+UVOu8pn4wgr7h4C6wjB6ojVcbe7c64oluM5/UAflJwet/Mqg9WgGFGD
 x1Dg==
X-Gm-Message-State: AFuF++llPAtEdFNjKggMfksZPNHsXNtxNDPPa97W+1yKp58C+bZSmwUT
 B405yAFAL2lFqo5sOSKN5aizSGxwncD6xCuxKKTRSj3MzRhfsGKjfsAhqXPUDQ==
X-Gm-Gg: AYBFou2fhfPTuW8id95qUpZA+U/sna7HAr7qSsovGAGd5AKMNbODpw9pJjgaoa0AYpC
 ZTlT0i18QIuvgR9HewFMSEVRNAGAGrw8hUsTxOk7TQm500UAvTZSC9/kLdBxSE9Vvhk7QlqEDZd
 uG71AIyVSAcMzwYImv95BDsN0suS2JKnGnpWwJFjlizHWvtdLewRgJzQt5Vi1784pleowYPoCfh
 lwcVrz76uu4iel61WQQLpMvYfcuyD0rNJOfTmWOBH3I2A5hY+jpa1XJx8yVBIeEsDPVVAY8RJ8W
 FW6arpUSAeuBEsOSO9DCgAI6PDF2f7S+uyzZFJQJshNHBUJyq+rN9UhhdRvBi1INjzUuV7QOeAa
 HQ+GmPQj3U+0E6d8P/EOlqRH7ZdPTC6lO7ykac49Bv/zoJTUC6MYzcwEYk/Q4Hi8Zpj0yG7z9LK
 q7bmCMmwdpVGj4I92sbDyJNu5SGHjcHdm5lsXNOXFOkjjcoNYF4khSzE8RPbSjw2PYMJ8/jMUWE
 79cE63kzZoKISJD
X-Received: by 2002:a05:6a20:9c11:b0:3d2:3e73:29eb with SMTP id
 adf61e73a8af0-3da39bb596fmr5647799637.1.1788499225021; 
 Thu, 03 Sep 2026 22:20:25 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc455445e34sm402147a12.15.2026.09.03.22.20.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 22:20:24 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair.francis@wdc.com>,
 Portia Stephens <portias@oss.tenstorrent.com>
Subject: [PULL 10/47] hw/riscv: Make s-mode IMSIC stride explicit
Date: Fri,  4 Sep 2026 15:19:06 +1000
Message-ID: <20260904051943.799041-11-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904051943.799041-1-alistair.francis@wdc.com>
References: <20260904051943.799041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Joel Stanley <joel@jms.id.au>

Existing machines tightly coupled s-mode IMSIC stride with the guest
bits value. There need to be enough bits to describe the guest in
GEILEN, but that's a minimum bound and machines may choose to use a
larger stride. This change decouples the two and updates Atlantis and
Virt to use the new API.

AIA guest count used by the Atlantis machine was not correct. It looks
like a placeholder value was chosen in order to size the stride to
0x40000, but this gives the wrong guest count. From the (currently
internal) docs, the guest count is 5:

> |NUM_GEILEN|5 (0 - 64)|Number of supported guest index from the S-mode interrupt domain|

Add that value to a define, and add a separate define for the stride, to
reduce the opportunity for future confusion.

Fixes: 7778f4b27bb1 ("hw/riscv: Add Tenstorrent Atlantis machine")
Signed-off-by: Joel Stanley <joel@jms.id.au>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Portia Stephens <portias@oss.tenstorrent.com>
Message-ID: <20260824030509.18078-2-joel@jms.id.au>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/aia.h         |  1 +
 hw/riscv/aia.c         |  5 ++---
 hw/riscv/tt_atlantis.c | 19 +++++++++++--------
 hw/riscv/virt.c        |  2 ++
 4 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/hw/riscv/aia.h b/hw/riscv/aia.h
index 565f91accc..3b6d7f9625 100644
--- a/hw/riscv/aia.h
+++ b/hw/riscv/aia.h
@@ -15,6 +15,7 @@ uint32_t imsic_num_bits(uint32_t count);
 
 DeviceState *riscv_create_aia(bool msimode, int aia_guests,
                              uint32_t m_imsic_stride,
+                             uint32_t s_imsic_stride,
                              uint16_t num_sources,
                              const MemMapEntry *aplic_m,
                              const MemMapEntry *aplic_s,
diff --git a/hw/riscv/aia.c b/hw/riscv/aia.c
index ed89160029..c33a3b32bd 100644
--- a/hw/riscv/aia.c
+++ b/hw/riscv/aia.c
@@ -26,6 +26,7 @@ uint32_t imsic_num_bits(uint32_t count)
 
 DeviceState *riscv_create_aia(bool msimode, int aia_guests,
                              uint32_t m_imsic_stride,
+                             uint32_t s_imsic_stride,
                              uint16_t num_sources,
                              const MemMapEntry *aplic_m,
                              const MemMapEntry *aplic_s,
@@ -36,7 +37,6 @@ DeviceState *riscv_create_aia(bool msimode, int aia_guests,
 {
     int i;
     hwaddr addr = 0;
-    uint32_t guest_bits;
     DeviceState *aplic_s_dev = NULL;
     DeviceState *aplic_m_dev = NULL;
 
@@ -55,10 +55,9 @@ DeviceState *riscv_create_aia(bool msimode, int aia_guests,
         }
 
         /* Per-socket S-level IMSICs */
-        guest_bits = imsic_num_bits(aia_guests + 1);
         addr = imsic_s->base + socket * (1U << IMSIC_MMIO_GROUP_MIN_SHIFT);
         for (i = 0; i < hart_count; i++) {
-            riscv_imsic_create(addr + i * IMSIC_HART_SIZE(guest_bits),
+            riscv_imsic_create(addr + i * s_imsic_stride,
                                base_hartid + i, false, 1 + aia_guests,
                                num_msis);
         }
diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index 4fd8679ae1..fda848c3a6 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -36,8 +36,12 @@
 #define TT_IRQCHIP_NUM_MSIS       255
 #define TT_IRQCHIP_NUM_SOURCES    128
 #define TT_IRQCHIP_NUM_PRIO_BITS  3
-#define TT_IRQCHIP_GUESTS         63 /* aia_guests, gives guest_index_bits=6 */
-#define TT_IRQCHIP_MIMSIC_STRIDE  0x40000
+#define TT_IMSIC_GUESTS           5
+#define TT_IMSIC_STRIDE           0x40000 /* Same stride for M and S */
+#define TT_IMSIC_GUEST_BITS       6
+
+/* Stride is fixed by hardware, check it's consistent with guest bits. */
+QEMU_BUILD_BUG_ON(TT_IMSIC_STRIDE != (0x1000 << TT_IMSIC_GUEST_BITS));
 
 #define TT_ACLINT_MTIME_SIZE    0x8050
 #define TT_ACLINT_MTIME         0x0
@@ -230,18 +234,16 @@ static void create_fdt_cpu(TTAtlantisState *s, const MemMapEntry *memmap,
 
     create_fdt_aclint(s, intc_phandles);
 
-    uint32_t imsic_guest_bits = imsic_num_bits(TT_IRQCHIP_GUESTS + 1);
-
     /* M-level IMSIC node */
     uint32_t msi_m_phandle = next_phandle();
     create_fdt_one_imsic(fdt, &s->memmap[TT_ATL_MIMSIC], ms->smp.cpus,
                          intc_phandles, msi_m_phandle,
-                         IRQ_M_EXT, imsic_guest_bits);
+                         IRQ_M_EXT, TT_IMSIC_GUEST_BITS);
 
     /* S-level IMSIC node */
     create_fdt_one_imsic(fdt, &s->memmap[TT_ATL_SIMSIC], ms->smp.cpus,
                          intc_phandles, imsic_s_phandle,
-                         IRQ_S_EXT, imsic_guest_bits);
+                         IRQ_S_EXT, TT_IMSIC_GUEST_BITS);
 
     uint32_t aplic_m_phandle = next_phandle();
 
@@ -493,8 +495,9 @@ static void tt_atlantis_machine_init(MachineState *machine)
                             &error_abort);
     sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
 
-    s->irqchip = riscv_create_aia(true, TT_IRQCHIP_GUESTS,
-                                  TT_IRQCHIP_MIMSIC_STRIDE,
+    s->irqchip = riscv_create_aia(true, TT_IMSIC_GUESTS,
+                                  TT_IMSIC_STRIDE,
+                                  TT_IMSIC_STRIDE,
                                   TT_IRQCHIP_NUM_SOURCES,
                                   &s->memmap[TT_ATL_MAPLIC],
                                   &s->memmap[TT_ATL_SAPLIC],
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index a5d2452d97..c43a23af02 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1410,9 +1410,11 @@ static void virt_machine_init(MachineState *machine)
             s->irqchip[i] = virt_create_plic(s->memmap, i,
                                              base_hartid, hart_count);
         } else {
+            int imsic_bits = imsic_num_bits(s->aia_guests + 1);
             s->irqchip[i] = riscv_create_aia(s->aia_type == VIRT_AIA_TYPE_APLIC_IMSIC,
                                              s->aia_guests,
                                              IMSIC_HART_SIZE(0),
+                                             IMSIC_HART_SIZE(imsic_bits),
                                              s->num_sources,
                                              &s->memmap[VIRT_APLIC_M],
                                              &s->memmap[VIRT_APLIC_S],
-- 
2.55.0


