Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 437EDC27C75
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 08:18:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHJ8N-0002JO-1k; Wed, 12 Jun 2024 04:15:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1sHJ8L-0002Iv-HI
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 04:15:05 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1sHJ8I-0006Le-SU
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 04:15:05 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1f6e183f084so34065145ad.1
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 01:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1718180099; x=1718784899; darn=nongnu.org;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=htuMZxd9RVqlZETMagy8fsRybQcg5cD/2wiawbgeZIg=;
 b=FRUfg/gVw3Oxt4TX8NWhjtqz9ZanX2FS0qSuk0kaAJpUjfccp2JsTW/zkargcP17jv
 GJjF3/77nsPUBWpHFB+2PZp1AL3M1Okn+0zzaW0OTj3PZKTlpdkntUYcbu1Gji80pzIX
 TMSVF1PzrIiWSxDLzKHyWTmvdz7CzDOUt2Bjwar66M/OLoac5pVZ7kb4o2NQckLiOgzS
 N6aakZ/7YuwpGzEiWMHukcLSBxLL6/qA10b0Qqn3GwGqw6lRd40DvOkb/XACOQP4ulEM
 a6vS5/0avLB6jwidtaUj2brawpJBEdFyY+RDOcsVg/FUCEZ2JK2t0iK/gIXntM9sk3+O
 0HJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718180099; x=1718784899;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=htuMZxd9RVqlZETMagy8fsRybQcg5cD/2wiawbgeZIg=;
 b=krKMQ/9ClJBacn3M2oyLZ4i3m72LZbyTVJUJlP0YjctwZDXcCY5Nkj3oAQdX1oyoX5
 Qc0M0O/a7AoQcRdEVGlH0xab8jiFPi9T4sDath616viPEs/bDKi5yB7E1M8oMu1j3Agx
 PaxR7Z2SZ9qlaxfiVCzzVEwPWJyPnsrHT4HKMjyY59Sy8kvxMU8/wR9Q1zjYi4jZJUZi
 jzfXpphsGaDOkLN0n4Tc/l9topr5cTrYDI2f/5+OAzmCjTtgDtqv/lyWXheZv88nCgBM
 EE/2+Xjc7zIDDZF5x0LQvd13NmlxvLgLwdITSStloArGJKXG5FxUv4X/cViXmLM9rEFZ
 K5vg==
X-Gm-Message-State: AOJu0Yw3zDXyJ0UjBTzl3Pov0nodDiwnsI0UYbldLXqkaY0m11LBMGsY
 jQA/G+fTjAQZc/0nsDawkkXEK1zJFNARdEiVXFQZfwcO6RFCv0K2Nr5tMOU9yIbtsRa3ZD4+AIC
 g7L+OXvDUG5/7Ai5EYuKmRJjzmJTLQOp1Fp0/HOo8KEitAVqdlspWoTl1qvDV+MtnS+itM2wmg3
 +Rh6+LEdWBO3UeA7zjwXfCrrJR6p9ZcykWoh73CVRRGw==
X-Google-Smtp-Source: AGHT+IH0NPHsJ9joimlSunHKOZrAbuxsmWvanZHC0tGwoZHwOCxvzYU4tYx3PvGFmGYZRHsKj9LYOQ==
X-Received: by 2002:a17:902:6546:b0:1f7:1931:7a8f with SMTP id
 d9443c01a7336-1f83b709a39mr10224655ad.64.1718180098732; 
 Wed, 12 Jun 2024 01:14:58 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f8393e8e53sm11363875ad.16.2024.06.12.01.14.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jun 2024 01:14:58 -0700 (PDT)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Song Gao <gaosong@loongson.cn>, Laurent Vivier <laurent@vivier.eu>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs),
 qemu-ppc@nongnu.org (open list:PowerPC TCG CPUs),
 qemu-s390x@nongnu.org (open list:S390 TCG CPUs),
 Jim Shu <jim.shu@sifive.com>
Subject: [RFC PATCH 04/16] hw/misc: riscv_worldguard: Add RISC-V WorldGuard
 global config
Date: Wed, 12 Jun 2024 16:14:04 +0800
Message-Id: <20240612081416.29704-5-jim.shu@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240612081416.29704-1-jim.shu@sifive.com>
References: <20240612081416.29704-1-jim.shu@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=jim.shu@sifive.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Add a device for RISCV WG global config, which contains the number of
worlds, reset value, and trusted WID ... etc.

This global config is used by both CPU WG extension and wgChecker devices.

Signed-off-by: Jim Shu <jim.shu@sifive.com>
---
 hw/misc/Kconfig                    |   3 +
 hw/misc/meson.build                |   1 +
 hw/misc/riscv_worldguard.c         | 183 +++++++++++++++++++++++++++++
 include/hw/misc/riscv_worldguard.h |  55 +++++++++
 4 files changed, 242 insertions(+)
 create mode 100644 hw/misc/riscv_worldguard.c
 create mode 100644 include/hw/misc/riscv_worldguard.h

diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 1e08785b83..08fc0f2b8c 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -213,4 +213,7 @@ config IOSB
 config XLNX_VERSAL_TRNG
     bool
 
+config RISCV_WORLDGUARD
+    bool
+
 source macio/Kconfig
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 86596a3888..a75668ff86 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -34,6 +34,7 @@ system_ss.add(when: 'CONFIG_SIFIVE_E_PRCI', if_true: files('sifive_e_prci.c'))
 system_ss.add(when: 'CONFIG_SIFIVE_E_AON', if_true: files('sifive_e_aon.c'))
 system_ss.add(when: 'CONFIG_SIFIVE_U_OTP', if_true: files('sifive_u_otp.c'))
 system_ss.add(when: 'CONFIG_SIFIVE_U_PRCI', if_true: files('sifive_u_prci.c'))
+specific_ss.add(when: 'CONFIG_RISCV_WORLDGUARD', if_true: files('riscv_worldguard.c'))
 
 subdir('macio')
 
diff --git a/hw/misc/riscv_worldguard.c b/hw/misc/riscv_worldguard.c
new file mode 100644
index 0000000000..c839cc4e87
--- /dev/null
+++ b/hw/misc/riscv_worldguard.c
@@ -0,0 +1,183 @@
+/*
+ * RISC-V WorldGuard Device
+ *
+ * Copyright (c) 2022 SiFive, Inc.
+ *
+ * This provides WorldGuard global config.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/log.h"
+#include "exec/hwaddr.h"
+#include "hw/registerfields.h"
+#include "hw/sysbus.h"
+#include "hw/hw.h"
+#include "hw/qdev-properties.h"
+#include "hw/misc/riscv_worldguard.h"
+#include "hw/core/cpu.h"
+#include "target/riscv/cpu.h"
+#include "trace.h"
+
+/*
+ * WorldGuard global config:
+ * List the global setting of WG, like num-of-worlds. It is unique in the machine.
+ * All CPUs with WG extension and wgChecker devices will use it.
+ */
+struct RISCVWorldGuardState *worldguard_config = NULL;
+
+static Property riscv_worldguard_properties[] = {
+    DEFINE_PROP_UINT32("nworlds", RISCVWorldGuardState, nworlds, 0),
+
+    /* Only Trusted WID could access wgCheckers if it is enabled. */
+    DEFINE_PROP_UINT32("trustedwid", RISCVWorldGuardState, trustedwid, NO_TRUSTEDWID),
+
+    /*
+     * WG reset value is bypass mode in HW. All WG permission checkings are
+     * pass by default, so SW could correctly run on the machine w/o any WG
+     * programming.
+     */
+    DEFINE_PROP_BOOL("hw-bypass", RISCVWorldGuardState, hw_bypass, false),
+
+    /*
+     * TrustZone compatible mode:
+     * This mode is only supported in 2 worlds system. It converts WorldGuard
+     * WID to TZ NS signal on the bus so WG could be cooperated with
+     * TZ components. In QEMU, it converts WID to 'MemTxAttrs.secure' bit used
+     * by TZ.
+     */
+    DEFINE_PROP_BOOL("tz-compat", RISCVWorldGuardState, tz_compat, false),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+/* WID to MemTxAttrs converter */
+static void wid_to_mem_attrs(MemTxAttrs *attrs, uint32_t wid)
+{
+    g_assert(wid < worldguard_config->nworlds);
+
+    attrs->unspecified = 0;
+    if (worldguard_config->tz_compat) {
+        attrs->secure = wid;
+    } else {
+        attrs->world_id = wid;
+    }
+}
+
+/* MemTxAttrs to WID converter */
+uint32_t mem_attrs_to_wid(MemTxAttrs attrs)
+{
+    if (attrs.unspecified) {
+        if (worldguard_config->trustedwid != NO_TRUSTEDWID) {
+            return worldguard_config->trustedwid;
+        } else {
+            return worldguard_config->nworlds - 1;
+        }
+    }
+
+    if (worldguard_config->tz_compat) {
+        return attrs.secure;
+    } else {
+        return attrs.world_id;
+    }
+}
+
+bool could_access_wgblocks(MemTxAttrs attrs, const char *wgblock)
+{
+    uint32_t wid = mem_attrs_to_wid(attrs);
+    uint32_t trustedwid = worldguard_config->trustedwid;
+
+    if ((trustedwid == NO_TRUSTEDWID) || (wid == trustedwid)) {
+        return true;
+    } else {
+        /*
+         * Only Trusted WID could access WG blocks if having it.
+         * Access them from other WIDs will get failed.
+         */
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Invalid access to %s from non-trusted WID %d\n",
+                      __func__, wgblock, wid);
+
+        return false;
+    }
+}
+
+static void riscv_worldguard_realize(DeviceState *dev, Error **errp)
+{
+    RISCVWorldGuardState *s = RISCV_WORLDGUARD(dev);
+
+    if (worldguard_config != NULL) {
+        error_setg(errp, "Couldn't realize multiple global WorldGuard configs.");
+        return;
+    }
+
+    if ((s->nworlds) & (s->nworlds - 1)) {
+        error_setg(errp, "Current implementation only support power-of-2 NWorld.");
+        return;
+    }
+
+    if ((s->trustedwid != NO_TRUSTEDWID) && (s->trustedwid >= s->nworlds)) {
+        error_setg(errp, "Trusted WID must be less than the number of world.");
+        return;
+    }
+
+    if ((s->nworlds != 2) && (s->tz_compat)) {
+        error_setg(errp, "Only 2 worlds system could use TrustZone compatible mode.");
+        return;
+    }
+
+    /* Register WG global config */
+    worldguard_config = s;
+
+    /* Initialize global data for wgChecker */
+    wgc_slot_perm_mask = MAKE_64BIT_MASK(0, 2 * worldguard_config->nworlds);
+}
+
+static void riscv_worldguard_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    device_class_set_props(dc, riscv_worldguard_properties);
+    dc->user_creatable = true;
+    dc->realize = riscv_worldguard_realize;
+}
+
+static const TypeInfo riscv_worldguard_info = {
+    .name          = TYPE_RISCV_WORLDGUARD,
+    .parent        = TYPE_DEVICE,
+    .instance_size = sizeof(RISCVWorldGuardState),
+    .class_init    = riscv_worldguard_class_init,
+};
+
+/*
+ * Create WorldGuard global config
+ */
+DeviceState *riscv_worldguard_create(uint32_t nworlds, uint32_t trustedwid,
+                                     bool hw_bypass, bool tz_compat)
+{
+    DeviceState *dev = qdev_new(TYPE_RISCV_WORLDGUARD);
+    qdev_prop_set_uint32(dev, "nworlds", nworlds);
+    qdev_prop_set_uint32(dev, "trustedwid", trustedwid);
+    qdev_prop_set_bit(dev, "hw-bypass", hw_bypass);
+    qdev_prop_set_bit(dev, "tz-compat", tz_compat);
+    qdev_realize(DEVICE(dev), NULL, &error_fatal);
+    return dev;
+}
+
+static void riscv_worldguard_register_types(void)
+{
+    type_register_static(&riscv_worldguard_info);
+}
+
+type_init(riscv_worldguard_register_types)
diff --git a/include/hw/misc/riscv_worldguard.h b/include/hw/misc/riscv_worldguard.h
new file mode 100644
index 0000000000..8a533a0517
--- /dev/null
+++ b/include/hw/misc/riscv_worldguard.h
@@ -0,0 +1,55 @@
+/*
+ * RISC-V WorldGuard Devices
+ *
+ * Copyright (c) 2022 RISCV, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef HW_RISCV_WORLDGUARD_H
+#define HW_RISCV_WORLDGUARD_H
+
+#include "qom/object.h"
+#include "hw/sysbus.h"
+#include "exec/hwaddr.h"
+
+#define TYPE_RISCV_WORLDGUARD "riscv.worldguard"
+
+#define NO_TRUSTEDWID           UINT32_MAX
+
+typedef struct RISCVWorldGuardState RISCVWorldGuardState;
+DECLARE_INSTANCE_CHECKER(RISCVWorldGuardState, RISCV_WORLDGUARD,
+                         TYPE_RISCV_WORLDGUARD)
+
+struct RISCVWorldGuardState {
+    /*< private >*/
+    DeviceState parent_obj;
+
+    /*< public >*/
+
+    /* Property */
+    uint32_t nworlds;
+    uint32_t trustedwid;
+    bool hw_bypass;
+    bool tz_compat;
+};
+
+extern struct RISCVWorldGuardState *worldguard_config;
+
+DeviceState *riscv_worldguard_create(uint32_t nworlds, uint32_t trustedwid,
+                                     bool hw_bypass, bool tz_compat);
+
+uint32_t mem_attrs_to_wid(MemTxAttrs attrs);
+bool could_access_wgblocks(MemTxAttrs attrs, const char *wgblock);
+
+#endif
-- 
2.17.1


