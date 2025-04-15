Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C352AC369B8
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 08:16:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4bPy-0007Jv-RK; Tue, 15 Apr 2025 04:13:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1u4bPw-0007Em-SU
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 04:13:17 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1u4bPr-0001wR-T4
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 04:13:15 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-225df540edcso61476615ad.0
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 01:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1744704790; x=1745309590; darn=nongnu.org;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xHnyUVIUAy9EeD7Slw5HDOE0YtQ4rJTQDvRGE+rnGQs=;
 b=kOkjzh+awSPpfE/wqGKkTKxSIA/CKo5SshFWRlV2ECaqqyEVnFQHi2+Q70mUM0zmT3
 IFETfytFhrFkEYiU23xTP2+kAqfTNCrNZrVioqV7WQebpSgltP6BllorIwemzaeCi/RS
 r+Okg7rkDkIok3mTlDcm/THKQt0nXCVUi64BSgLX/jdpe4Whxp1WlqoXu2fEbhgHxVo0
 5StWdNadCPdXj4YP8r7crJSwuI4xiU6UBCZKD4mbKMkUwYt2vsbgwHurEDb7Ax7TRtdl
 0siSx8opMfKi+CQ2OWxryfliUooBe8asRV5VwUuMwzebvZtmOPrz0XsFYWN0OexJ4SKT
 C/6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744704790; x=1745309590;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xHnyUVIUAy9EeD7Slw5HDOE0YtQ4rJTQDvRGE+rnGQs=;
 b=EzDFBvl6bhAO9/01TRpEPtnYqcRoA33I8x3w8Qo5C8W608moxSBcpwZ8UsCVQ+jQd4
 mMLEUPRX6r+QufEFj3eWjci/RWXq64W/Oofd4K/WnFW/VlZg53HmK7seFGgWtbHd55jt
 1rv76y9e2Bn3gTgSw36fMCZwbjTwFDYnQNlWCZqtyaeIlb33zmF5MhK9EoUf+Z8VTNkm
 lvsAQeFH6HBYTZSSc2jwt9+Nvg+NuvwPVf5iZ2XJaHBPWydcqARuQ4YWiIu8odUTOTxl
 2UsrcJb28YTnLsxvGOr2rdMkIK5jTXWEgiArKNWFz4X5hwuSbD3X8dJqPbG9bUvnJkU0
 LfrQ==
X-Gm-Message-State: AOJu0Yy+eKhnFMWqTN0WtPMAoFvmJggii/8Sebtqrb5OFXd3mO3VziaZ
 P/0KVKkyYSxg7Q9d5aYjHVjtWxIJ8o/hwvkTYygMAimTyd35psxZquZ3FNgWydJ1M2pNHWUSugc
 qCiOzesD7XA0AfYNQvF60oRLvt4nbPV03gjUA92MngL0Jhtv0dE3/8HXNXhUw6hrOG0+762TrMs
 g2PsbjLZf/8nc5M53VHMgid/L8yqZPU6e1gHwx
X-Gm-Gg: ASbGncuwV9EdfC1UQ/yL5fBvgGaiQwf4CUIgdj03nYxLSAPsfI+w8i9aY7DZAt1GdDd
 HmppnKHqgRj5iGQGlfCSVWnpPQLoSEqP16xnWbCE282Jx/1f6YsWCRF1lncBQGgKK/a8JuTpMZt
 fKQzssnhxkXSezrr5M+nF58oZZB2p5KlgN8rSCiO9VGEuy+DY0TpWOYlhQELtNKanZQL+pme7I4
 Nr/P2Fn7UKwGo2LxhSFFfR1G9ALTb41hFY/V9FTNwP7Ot+pSln3u/LYn8q92atunQp+my5DkOye
 9L4u+4kWLn4NtEdgIZabfEGcH/fl3x/3Y/TSbWoph6FTqiH4TTgTYM22ufjIWro=
X-Google-Smtp-Source: AGHT+IEQYMWfiOxs2M8vBmF8MpgizLLzFWXOp7UMoJudLYSYt+QnYMB5SkX++ICIfRjYoYa7U/MCBg==
X-Received: by 2002:a17:902:e88d:b0:223:517a:d4ed with SMTP id
 d9443c01a7336-22c2498a2ffmr34994655ad.15.1744704789867; 
 Tue, 15 Apr 2025 01:13:09 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7c95cd1sm111082335ad.150.2025.04.15.01.13.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 01:13:09 -0700 (PDT)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Michael Rolnik <mrolnik@gmail.com>, Helge Deller <deller@gmx.de>,
 Song Gao <gaosong@loongson.cn>, Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
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
 qemu-ppc@nongnu.org (open list:PowerPC TCG CPUs),
 qemu-s390x@nongnu.org (open list:S390 TCG CPUs),
 Jim Shu <jim.shu@sifive.com>
Subject: [PATCH 04/17] hw/misc: riscv_worldguard: Add RISC-V WorldGuard global
 config
Date: Tue, 15 Apr 2025 16:12:18 +0800
Message-Id: <20250415081231.21186-5-jim.shu@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250415081231.21186-1-jim.shu@sifive.com>
References: <20250415081231.21186-1-jim.shu@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=jim.shu@sifive.com; helo=mail-pl1-x631.google.com
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

Add a device for RISCV WG global config, which contains the number of
worlds, reset value, and trusted WID ... etc.

This global config is used by both CPU WG extension and wgChecker devices.

Signed-off-by: Jim Shu <jim.shu@sifive.com>
---
 hw/misc/Kconfig                    |   3 +
 hw/misc/meson.build                |   1 +
 hw/misc/riscv_worldguard.c         | 182 +++++++++++++++++++++++++++++
 include/hw/misc/riscv_worldguard.h |  55 +++++++++
 4 files changed, 241 insertions(+)
 create mode 100644 hw/misc/riscv_worldguard.c
 create mode 100644 include/hw/misc/riscv_worldguard.h

diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index ec0fa5aa9f..7677c0e962 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -222,4 +222,7 @@ config IOSB
 config XLNX_VERSAL_TRNG
     bool
 
+config RISCV_WORLDGUARD
+    bool
+
 source macio/Kconfig
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 6d47de482c..3d2f4bb6a3 100644
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
index 0000000000..b02bd28d02
--- /dev/null
+++ b/hw/misc/riscv_worldguard.c
@@ -0,0 +1,182 @@
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


