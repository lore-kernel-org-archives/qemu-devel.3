Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48239C61DD3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 05:22:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2MN5-0001cp-Mw; Fri, 04 Sep 2026 01:21:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1x2MN2-0001L3-5l
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:21:48 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1x2MN0-0001To-3d
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:21:47 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-c9e7391839cso754124a12.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 22:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788499305; x=1789104105; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=K1OiMH+p0rBdnErCCxiY7AeU+Qi4V8Bi6IEwcesojMg=;
 b=LUfXdRrl3+liyFA8WYtExAocBVOx2Iq9AkH5B5KNxQEjS15fxc20wkvWMF+tCi3hx7
 BhFoU8yXE3uu2mHMBj7jiXaSJCCfaTLQ2Ws5jDauUfsZOo4W8+K6Z6F1rwaVT86oi/2f
 YmYuWQJyhNRanbDZ40iSxc9PPWEzftTyzNazLY/UvqqZ3j7a++JoO9FOz8UCwa8mX7Cn
 LDY4GGQMATQ9dxoeKqaMgL1E6SK8IMOzwzdsQI3bzyxMQmUh7fNaiahxtTA8cdlt9aUA
 yrGfw1aSbmWeM9ipX22NLspRifLqkGDXYNQZXua7diy/rHCN9p7r71CoNgmI8aPO9eLY
 y1Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788499305; x=1789104105;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=K1OiMH+p0rBdnErCCxiY7AeU+Qi4V8Bi6IEwcesojMg=;
 b=NxutTtpO20FS08tJZPcZ1+ND+Z1162Sg2dW1cgvHILBo/Dv+gwq8ajNg4m64pDZ6f4
 eF4z6A0Y1Spfo6bjec7/LoeaU1wmfsjbryhJmKOIeH846yORVxYlQwjHK3Buab15pdcP
 WsRKn7QHbw0DP0VIijQj+z80R0xfrBpIGHNJ7gzoHZ3MLw4mVOswu/+Gtpssf8cs1fT/
 bkCEllNOieYnl04Ro6Fv2nn+SQlcwkFueg0qCzQ4jI3Q98w9y7wUUy1Yucl0OWBFh3aP
 l73hcGygSxM9EB6adCQobqtGUe7+QZy3xRcHBVKPwr/tUJtNDSsu6NN3WayUtHIwAiY5
 2cbQ==
X-Gm-Message-State: AFuF++lcgDRa+HKiE6hTTQ6uWYNMUYTtZIrSHYkBcwBRGt65C4JIeCsK
 6JM0Ao4uaChjMwqf6TdSkOtLXiJuLbwrLusFWzsAmjdDUJewE69FZ8GMIsbHmQ==
X-Gm-Gg: AYBFou0/ZXWkQZJIuLRf6bu+qn9TUNvC7TMI6pBuOtAi/cygTSg77RaIUNJsMsVdH1q
 c/l3BNGZv+chVLDZvKz+2okNTLvl51/OwCiONeTcBU5g1PdY9YiIx3AfdTMdUh3MnW8wTEBahOH
 1XHmPhVt97jHDzXE3jC4/wz7lifQmLgiIlULsZmSQFlbA7lSllw5ffQygO4bLVVHleE9hZotm1G
 ViWmNQT+n1RqShcN3cqGc8Nfk/F/nqhHHzMbRVIssrhD7NpQhf6c0Bm8DvzBlZe/vwAaAmduCkd
 4+fo8RYkEmIYC7BlB/R4FBuBTSD9YZENRzUEfM6QFvmO7RmJwa1YLXMGnyf3pRipMMFnwREjvhB
 G83mA/7VEYQsBmljcpsI5/fD8Nejj8tGAmQUrT76X5vySLpQMtEXQOou0rUncdmFegxNvK9xVc8
 BrWOFFQaqLIFhSYOrBt3/mvfy5SgkAhIm88G/PVpttMOW6JhGaFRXrbmUAqFQqbszXJkG1c4XAv
 BB0YA==
X-Received: by 2002:a05:6a21:3cc2:b0:3da:2e53:4f1d with SMTP id
 adf61e73a8af0-3da3a171cb6mr6033334637.22.1788499304731; 
 Thu, 03 Sep 2026 22:21:44 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc455445e34sm402147a12.15.2026.09.03.22.21.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 22:21:43 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 35/47] hw/intc/riscv_aplic: Take a MemoryRegion for the created
 device
Date: Fri,  4 Sep 2026 15:19:31 +1000
Message-ID: <20260904051943.799041-36-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904051943.799041-1-alistair.francis@wdc.com>
References: <20260904051943.799041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x530.google.com
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

riscv_aplic_create() maps the device it creates into system_memory,
which prevents its use by SoCs that map devices into their own memory
container.

Add a MemoryRegion parameter and map the device into it instead of
calling sysbus_mmio_map(). The mapping still only happens when the
APLIC is emulated. All callers pass system_memory, so there is no
change in behaviour.

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
Message-ID: <20260903055131.257903-5-joel@jms.id.au>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/intc/riscv_aplic.h |  7 ++++---
 hw/intc/riscv_aplic.c         | 10 ++++++----
 hw/riscv/aia.c                |  8 ++++----
 hw/riscv/cps.c                |  6 ++++--
 hw/riscv/xiangshan_kmh.c      |  6 ++++--
 5 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/include/hw/intc/riscv_aplic.h b/include/hw/intc/riscv_aplic.h
index c7a4d4ad01..62d2b33ade 100644
--- a/include/hw/intc/riscv_aplic.h
+++ b/include/hw/intc/riscv_aplic.h
@@ -80,8 +80,9 @@ bool riscv_is_kvm_aia_aplic_imsic(bool msimode);
 bool riscv_use_emulated_aplic(bool msimode);
 void riscv_aplic_set_kvm_msicfgaddr(RISCVAPLICState *aplic, hwaddr addr);
 
-DeviceState *riscv_aplic_create(hwaddr addr, hwaddr size,
-    uint32_t hartid_base, uint32_t num_harts, uint32_t num_sources,
-    uint32_t iprio_bits, bool msimode, bool mmode, DeviceState *parent);
+DeviceState *riscv_aplic_create(MemoryRegion *container,
+    hwaddr addr, hwaddr size, uint32_t hartid_base, uint32_t num_harts,
+    uint32_t num_sources, uint32_t iprio_bits, bool msimode, bool mmode,
+    DeviceState *parent);
 
 #endif
diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index 84606e9f3d..d8e25bfda1 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -1109,9 +1109,10 @@ void riscv_aplic_add_child(DeviceState *parent, DeviceState *child)
 /*
  * Create APLIC device.
  */
-DeviceState *riscv_aplic_create(hwaddr addr, hwaddr size,
-    uint32_t hartid_base, uint32_t num_harts, uint32_t num_sources,
-    uint32_t iprio_bits, bool msimode, bool mmode, DeviceState *parent)
+DeviceState *riscv_aplic_create(MemoryRegion *container,
+    hwaddr addr, hwaddr size, uint32_t hartid_base, uint32_t num_harts,
+    uint32_t num_sources, uint32_t iprio_bits, bool msimode, bool mmode,
+    DeviceState *parent)
 {
     DeviceState *dev = qdev_new(TYPE_RISCV_APLIC);
     uint32_t i;
@@ -1137,7 +1138,8 @@ DeviceState *riscv_aplic_create(hwaddr addr, hwaddr size,
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     if (riscv_use_emulated_aplic(msimode)) {
-        sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
+        memory_region_add_subregion(container, addr,
+            sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0));
 
         if (!msimode) {
             for (i = 0; i < num_harts; i++) {
diff --git a/hw/riscv/aia.c b/hw/riscv/aia.c
index eae7638f97..56fc064533 100644
--- a/hw/riscv/aia.c
+++ b/hw/riscv/aia.c
@@ -72,8 +72,8 @@ DeviceState *riscv_create_aia(MemoryRegion *container,
 
     if (!kvm_enabled()) {
         /* Per-socket M-level APLIC */
-        aplic_m_dev = riscv_aplic_create(aplic_m->base +
-                                     socket * aplic_m->size,
+        aplic_m_dev = riscv_aplic_create(container,
+                                     aplic_m->base + socket * aplic_m->size,
                                      aplic_m->size,
                                      (msimode) ? 0 : base_hartid,
                                      (msimode) ? 0 : hart_count,
@@ -83,8 +83,8 @@ DeviceState *riscv_create_aia(MemoryRegion *container,
     }
 
     /* Per-socket S-level APLIC */
-    aplic_s_dev = riscv_aplic_create(aplic_s->base +
-                                 socket * aplic_s->size,
+    aplic_s_dev = riscv_aplic_create(container,
+                                 aplic_s->base + socket * aplic_s->size,
                                  aplic_s->size,
                                  (msimode) ? 0 : base_hartid,
                                  (msimode) ? 0 : hart_count,
diff --git a/hw/riscv/cps.c b/hw/riscv/cps.c
index 5cfb54aa27..d2fd9638a0 100644
--- a/hw/riscv/cps.c
+++ b/hw/riscv/cps.c
@@ -135,14 +135,16 @@ static void riscv_cps_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < num_of_clusters; i++) {
         uint64_t cm_base = GLOBAL_CM_BASE + (CM_SIZE * i);
         uint32_t hartid_base = i << MHARTID_CLUSTER_SHIFT;
-        s->aplic = riscv_aplic_create(cm_base + AIA_PLIC_M_OFFSET,
+        s->aplic = riscv_aplic_create(get_system_memory(),
+                                      cm_base + AIA_PLIC_M_OFFSET,
                                       AIA_PLIC_M_SIZE,
                                       hartid_base, /* hartid_base */
                                       MAX_HARTS, /* num_harts */
                                       APLIC_NUM_SOURCES,
                                       APLIC_NUM_PRIO_BITS,
                                       false, true, NULL);
-        riscv_aplic_create(cm_base + AIA_PLIC_S_OFFSET,
+        riscv_aplic_create(get_system_memory(),
+                           cm_base + AIA_PLIC_S_OFFSET,
                            AIA_PLIC_S_SIZE,
                            hartid_base, /* hartid_base */
                            MAX_HARTS, /* num_harts */
diff --git a/hw/riscv/xiangshan_kmh.c b/hw/riscv/xiangshan_kmh.c
index bb9b1e05ef..a234c5f352 100644
--- a/hw/riscv/xiangshan_kmh.c
+++ b/hw/riscv/xiangshan_kmh.c
@@ -79,13 +79,15 @@ static DeviceState *xiangshan_kmh_create_aia(uint32_t num_harts)
     }
 
     /* M-level APLIC */
-    aplic_m = riscv_aplic_create(memmap[XIANGSHAN_KMH_APLIC_M].base,
+    aplic_m = riscv_aplic_create(get_system_memory(),
+                                 memmap[XIANGSHAN_KMH_APLIC_M].base,
                                  memmap[XIANGSHAN_KMH_APLIC_M].size,
                                  0, 0, XIANGSHAN_KMH_APLIC_NUM_SOURCES,
                                  1, true, true, NULL);
 
     /* S-level APLIC */
-    riscv_aplic_create(memmap[XIANGSHAN_KMH_APLIC_S].base,
+    riscv_aplic_create(get_system_memory(),
+                       memmap[XIANGSHAN_KMH_APLIC_S].base,
                        memmap[XIANGSHAN_KMH_APLIC_S].size,
                        0, 0, XIANGSHAN_KMH_APLIC_NUM_SOURCES,
                        1, true, false, aplic_m);
-- 
2.55.0


