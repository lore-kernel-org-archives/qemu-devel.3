Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2091FCD37A7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 16:13:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slW5i-0002JS-RW; Tue, 03 Sep 2024 12:09:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1slW5f-0001vV-TV
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 12:09:11 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1slW5c-00030L-PZ
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 12:09:11 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-428e0d184b4so46223915e9.2
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 09:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725379747; x=1725984547; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=98dHBXppZY7GIvhfWwkwSB+S+qCyCFrZ2JMSYpx+b9s=;
 b=VIJG3UsiXrMsogi3ocjPz8wds1OyQVVDoi/a7Oa2gLwPPT/xiSNI9TgsNlkcNKW7Np
 3ZYV9mp2LN3PCVpMUpjpETukgS22LHycWlpndfKlYU1+eLFA2+wpmmjfVBOyXitltM4V
 U34gI5nj2Qa53/gyOb1+QxGkbIKPyMl9Vmw5XPo+AWnmfTslqJ/9gCQmJkSUFJQ9P0sE
 hapzcJMylxSPEZ4lsUgcHq1E5+wH1Nl1Ce41N3AArrO6MiuA8sRYlo60fvuAlA6TUYZy
 PwekQDnEF9yMZvIoSwF1cqhGy3TSsIpmm2Ha/sjtrNuersKv/3WC9I3417ngTW80q2fs
 LWxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725379747; x=1725984547;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=98dHBXppZY7GIvhfWwkwSB+S+qCyCFrZ2JMSYpx+b9s=;
 b=wQ6oLbmnh7JkKXITJFJFHKOYu4vPA8REzaUXgYe8ymOOTFjjS5BI3yEV85/8axtUfV
 Otbsc6IuOg/zonBba5B64PhyweW8GuoMOklY5W1Hvk3VYva6tmQpy3ecGNCjGSJSZdAh
 6C43VVnQDlLqVImV4EuVB43QibtkU6RW7a9mm0QL6aI8WoIRR8oljlfcdSQ2dxY8bWcZ
 0Qtr2nDxJ/J65nQrO+fbumpXbXX6NAQJZ30UCSPgN1cdX81EYnu8GpaXwxfZtoxcl6dD
 2COiJ+iA2sTFPqdMByBDAhGDj3/ueawlkwUq02vRElzmBChuwek22uHOSfQNsY+Kv2W6
 inRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnox0LDJKJM/LPFOMQMnG8OFhRVkC75AxlrevI7ZVgcC+mjvydH4yiDFNy1KEFpYh8cNOjpY76xbmW@nongnu.org
X-Gm-Message-State: AOJu0YwVYwkiYSiCrFpUovqu25Mk4cc8mE7nZm0KGcCqpePcvSrvbh6z
 RRW/sLjQqdWTDLLhJeRe6CV4eIRKA9kHd1R2X/sXsQjzRr8bVgdf7SraGnaOwDF2oTHFMVt1rvM
 a
X-Google-Smtp-Source: AGHT+IG4B7YQkmHZs8XousnWTVdC5xuHvPGZePhdB0TuHH5TModpzGCTI0Yw6RSPJ72XmciT0oKOsg==
X-Received: by 2002:adf:e602:0:b0:374:b9a0:ddee with SMTP id
 ffacd0b85a97d-374bf1e4a3dmr6742058f8f.56.1725379747195; 
 Tue, 03 Sep 2024 09:09:07 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6df1066sm175123065e9.18.2024.09.03.09.09.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 09:09:06 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH for-9.2 50/53] hw/misc: Remove omap_l4 device
Date: Tue,  3 Sep 2024 17:07:48 +0100
Message-Id: <20240903160751.4100218-51-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240903160751.4100218-1-peter.maydell@linaro.org>
References: <20240903160751.4100218-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The omap_l4 device is OMAP2 only, so we can remove it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/omap.h |  42 -----------
 hw/misc/omap_l4.c     | 162 ------------------------------------------
 hw/misc/meson.build   |   1 -
 3 files changed, 205 deletions(-)
 delete mode 100644 hw/misc/omap_l4.c

diff --git a/include/hw/arm/omap.h b/include/hw/arm/omap.h
index 2300b97716d..f82b820d4d8 100644
--- a/include/hw/arm/omap.h
+++ b/include/hw/arm/omap.h
@@ -108,45 +108,6 @@ DECLARE_INSTANCE_CHECKER(Omap1GpioState, OMAP1_GPIO,
 /* TODO: clock framework (see above) */
 void omap_gpio_set_clk(Omap1GpioState *gpio, omap_clk clk);
 
-/* OMAP2 l4 Interconnect */
-struct omap_l4_s;
-struct omap_l4_region_s {
-    hwaddr offset;
-    size_t size;
-    int access;
-};
-struct omap_l4_agent_info_s {
-    int ta;
-    int region;
-    int regions;
-    int ta_region;
-};
-struct omap_target_agent_s {
-    MemoryRegion iomem;
-    struct omap_l4_s *bus;
-    int regions;
-    const struct omap_l4_region_s *start;
-    hwaddr base;
-    uint32_t component;
-    uint32_t control;
-    uint32_t status;
-};
-struct omap_l4_s *omap_l4_init(MemoryRegion *address_space,
-                               hwaddr base, int ta_num);
-
-struct omap_target_agent_s;
-struct omap_target_agent_s *omap_l4ta_get(
-    struct omap_l4_s *bus,
-    const struct omap_l4_region_s *regions,
-    const struct omap_l4_agent_info_s *agents,
-    int cs);
-hwaddr omap_l4_attach(struct omap_target_agent_s *ta,
-                                         int region, MemoryRegion *mr);
-hwaddr omap_l4_region_base(struct omap_target_agent_s *ta,
-                                       int region);
-hwaddr omap_l4_region_size(struct omap_target_agent_s *ta,
-                                       int region);
-
 /*
  * Common IRQ numbers for level 1 interrupt handler
  * See /usr/include/asm-arm/arch-omap/irqs.h in Linux.
@@ -890,9 +851,6 @@ struct omap_mpu_state_s {
         uint16_t dsp_idlect2;
         uint16_t dsp_rstct2;
     } clkm;
-
-    /* OMAP2-only peripherals */
-    struct omap_l4_s *l4;
 };
 
 /* omap1.c */
diff --git a/hw/misc/omap_l4.c b/hw/misc/omap_l4.c
deleted file mode 100644
index b7875489da3..00000000000
--- a/hw/misc/omap_l4.c
+++ /dev/null
@@ -1,162 +0,0 @@
-/*
- * TI OMAP L4 interconnect emulation.
- *
- * Copyright (C) 2007-2009 Nokia Corporation
- * Written by Andrzej Zaborowski <andrew@openedhand.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 or
- * (at your option) any later version of the License.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, see <http://www.gnu.org/licenses/>.
- */
-#include "qemu/osdep.h"
-#include "hw/arm/omap.h"
-
-struct omap_l4_s {
-    MemoryRegion *address_space;
-    hwaddr base;
-    int ta_num;
-    struct omap_target_agent_s ta[];
-};
-
-struct omap_l4_s *omap_l4_init(MemoryRegion *address_space,
-                               hwaddr base, int ta_num)
-{
-    struct omap_l4_s *bus = g_malloc0(
-                    sizeof(*bus) + ta_num * sizeof(*bus->ta));
-
-    bus->address_space = address_space;
-    bus->ta_num = ta_num;
-    bus->base = base;
-
-    return bus;
-}
-
-hwaddr omap_l4_region_base(struct omap_target_agent_s *ta,
-                                       int region)
-{
-    return ta->bus->base + ta->start[region].offset;
-}
-
-hwaddr omap_l4_region_size(struct omap_target_agent_s *ta,
-                                       int region)
-{
-    return ta->start[region].size;
-}
-
-static uint64_t omap_l4ta_read(void *opaque, hwaddr addr, unsigned size)
-{
-    struct omap_target_agent_s *s = opaque;
-
-    if (size != 2) {
-        return omap_badwidth_read16(opaque, addr);
-    }
-
-    switch (addr) {
-    case 0x00:	/* COMPONENT */
-        return s->component;
-
-    case 0x20:	/* AGENT_CONTROL */
-        return s->control;
-
-    case 0x28:	/* AGENT_STATUS */
-        return s->status;
-    }
-
-    OMAP_BAD_REG(addr);
-    return 0;
-}
-
-static void omap_l4ta_write(void *opaque, hwaddr addr,
-                            uint64_t value, unsigned size)
-{
-    struct omap_target_agent_s *s = opaque;
-
-    if (size != 4) {
-        omap_badwidth_write32(opaque, addr, value);
-        return;
-    }
-
-    switch (addr) {
-    case 0x00:	/* COMPONENT */
-    case 0x28:	/* AGENT_STATUS */
-        OMAP_RO_REG(addr);
-        break;
-
-    case 0x20:	/* AGENT_CONTROL */
-        s->control = value & 0x01000700;
-        if (value & 1)					/* OCP_RESET */
-            s->status &= ~1;				/* REQ_TIMEOUT */
-        break;
-
-    default:
-        OMAP_BAD_REG(addr);
-    }
-}
-
-static const MemoryRegionOps omap_l4ta_ops = {
-    .read = omap_l4ta_read,
-    .write = omap_l4ta_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
-};
-
-struct omap_target_agent_s *omap_l4ta_get(struct omap_l4_s *bus,
-        const struct omap_l4_region_s *regions,
-        const struct omap_l4_agent_info_s *agents,
-        int cs)
-{
-    int i;
-    struct omap_target_agent_s *ta = NULL;
-    const struct omap_l4_agent_info_s *info = NULL;
-
-    for (i = 0; i < bus->ta_num; i ++)
-        if (agents[i].ta == cs) {
-            ta = &bus->ta[i];
-            info = &agents[i];
-            break;
-        }
-    if (!ta) {
-        fprintf(stderr, "%s: bad target agent (%i)\n", __func__, cs);
-        exit(-1);
-    }
-
-    ta->bus = bus;
-    ta->start = &regions[info->region];
-    ta->regions = info->regions;
-
-    ta->component = ('Q' << 24) | ('E' << 16) | ('M' << 8) | ('U' << 0);
-    ta->status = 0x00000000;
-    ta->control = 0x00000200;	/* XXX 01000200 for L4TAO */
-
-    memory_region_init_io(&ta->iomem, NULL, &omap_l4ta_ops, ta, "omap.l4ta",
-                          omap_l4_region_size(ta, info->ta_region));
-    omap_l4_attach(ta, info->ta_region, &ta->iomem);
-
-    return ta;
-}
-
-hwaddr omap_l4_attach(struct omap_target_agent_s *ta,
-                                         int region, MemoryRegion *mr)
-{
-    hwaddr base;
-
-    if (region < 0 || region >= ta->regions) {
-        fprintf(stderr, "%s: bad io region (%i)\n", __func__, region);
-        exit(-1);
-    }
-
-    base = ta->bus->base + ta->start[region].offset;
-    if (mr) {
-        memory_region_add_subregion(ta->bus->address_space, base, mr);
-    }
-
-    return base;
-}
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index b7e97e47cf9..a2951951b59 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -75,7 +75,6 @@ system_ss.add(when: 'CONFIG_NPCM7XX', if_true: files(
 ))
 system_ss.add(when: 'CONFIG_OMAP', if_true: files(
   'omap_clk.c',
-  'omap_l4.c',
 ))
 system_ss.add(when: 'CONFIG_RASPI', if_true: files(
   'bcm2835_mbox.c',
-- 
2.34.1


