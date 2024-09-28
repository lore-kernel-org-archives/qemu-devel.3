Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F10CF6493
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Sep 2024 09:01:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suTIe-0005Kx-64; Sat, 28 Sep 2024 04:59:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1suTIU-0004af-DF
 for qemu-devel@nongnu.org; Sat, 28 Sep 2024 04:59:26 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1suTIQ-0002RZ-VO
 for qemu-devel@nongnu.org; Sat, 28 Sep 2024 04:59:26 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-42cb9a0c300so23476125e9.0
 for <qemu-devel@nongnu.org>; Sat, 28 Sep 2024 01:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1727513961; x=1728118761;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SseSKGbzBfpGZIH6BILqp0UJmtMdERPGWCDtKLJR6rw=;
 b=IW+SYFCpEe5EttlxNen1GAEWTZh/zAi9EzqvjSqxyVEQ5AACI5YGtDnD2a8en9ISVF
 nUWSd9NYce0JLdqjf2agn4eR5cp5/GnOmRlkX289fuLvB7XQerWdb6hsjMMKoF35JnO+
 mhyB34uUkvzG/XOofxTswOzYguplrrKFqDoMs1vMxbkahoayr5ZwdtVxKZsyCn38TqE8
 exSYsWu4I/L49yyHffxQn66+QVyb2P8rlmP556aU7PfP3WLcTHHsiRR7VOPG2uylNWzB
 CV0IIyvWyLyTL05bBNaORBgeg8lYTjba/p6J6QMLMOD4bOUKo2FtxflwN1b6EdvzruF+
 KUow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727513961; x=1728118761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SseSKGbzBfpGZIH6BILqp0UJmtMdERPGWCDtKLJR6rw=;
 b=dd5FvpUrsjCdMGEwJAN7GV0BsJSg30adnREh2BfSKBSFcf18ee8x3SdTkua0yHwpwm
 ck6UYljAa6CUSI6w4eGX408k3wDUutdA2NqR2qZJM8on06XPWvEM0TYhdDZ8obXuC5ZC
 d9f3SC0lD3B/sA/i0QwP0js0GGl8ng4N/VigDR2t3W4pesz+v0hELYijRUq3VPmUDNCR
 EKYGLWm2qX/4slPyHKoghGRvg6AkVMEm7NkGAm5cH0us8l4mZ/ZeDpwHB5ZJcPkU/ELU
 ALJJ4+fRRQ/zvhr5HAjEvuwXpGwZRWaiMQFYQshsGROjxowA3EAIvp3vtyLj/3S940aF
 uBQA==
X-Gm-Message-State: AOJu0Yw96c9iL9pVYhZUetyIFujzqwIDDu0h1v671fwS4RevFOJPoNKO
 G+BCPyUijrghfous5Wn44deN48JQhbGv9QZMqVMxBlp1UMp1/IFKe6q+HR3H8IoHIiLkfeXBY7s
 bdg==
X-Google-Smtp-Source: AGHT+IEUgWe00DAUfjqvnOCRLArfK5lDZlT0OMH5v37RfhdOUmbTp7wJsZv7loh7VNvsv4Ut0XYt/A==
X-Received: by 2002:a5d:6411:0:b0:37c:d0f2:bab2 with SMTP id
 ffacd0b85a97d-37cd5a68d0dmr3607062f8f.3.1727513961103; 
 Sat, 28 Sep 2024 01:59:21 -0700 (PDT)
Received: from localhost.localdomain ([2001:4bb8:2ae:e42d:7dbb:76ba:120d:8a28])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd57423afsm4313167f8f.90.2024.09.28.01.59.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 28 Sep 2024 01:59:20 -0700 (PDT)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: agraf@csgraf.de, phil@philjordan.eu, peter.maydell@linaro.org,
 pbonzini@redhat.com, rad@semihalf.com, quic_llindhol@quicinc.com,
 marcin.juszkiewicz@linaro.org, stefanha@redhat.com, mst@redhat.com,
 slp@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, gaosong@loongson.cn, jiaxun.yang@flygoat.com,
 chenhuacai@kernel.org, kwolf@redhat.com, hreitz@redhat.com,
 philmd@linaro.org, shorne@gmail.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 jcmvbkbc@gmail.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 akihiko.odaki@daynix.com, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 qemu-riscv@nongnu.org, Alexander Graf <graf@amazon.com>
Subject: [PATCH v3 12/14] hw/vmapple/cfg: Introduce vmapple cfg region
Date: Sat, 28 Sep 2024 10:57:25 +0200
Message-Id: <20240928085727.56883-13-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240928085727.56883-1-phil@philjordan.eu>
References: <20240928085727.56883-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::32c;
 envelope-from=phil@philjordan.eu; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

From: Alexander Graf <graf@amazon.com>

Instead of device tree or other more standardized means, VMApple passes
platform configuration to the first stage boot loader in a binary encoded
format that resides at a dedicated RAM region in physical address space.

This patch models this configuration space as a qdev device which we can
then map at the fixed location in the address space. That way, we can
influence and annotate all configuration fields easily.

Signed-off-by: Alexander Graf <graf@amazon.com>
Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>

---
v3:

 * Replaced legacy device reset method with Resettable method

 hw/vmapple/Kconfig       |   3 ++
 hw/vmapple/cfg.c         | 106 +++++++++++++++++++++++++++++++++++++++
 hw/vmapple/meson.build   |   1 +
 include/hw/vmapple/cfg.h |  68 +++++++++++++++++++++++++
 4 files changed, 178 insertions(+)
 create mode 100644 hw/vmapple/cfg.c
 create mode 100644 include/hw/vmapple/cfg.h

diff --git a/hw/vmapple/Kconfig b/hw/vmapple/Kconfig
index 68f88876eb9..8bbeb9a9237 100644
--- a/hw/vmapple/Kconfig
+++ b/hw/vmapple/Kconfig
@@ -4,3 +4,6 @@ config VMAPPLE_AES
 config VMAPPLE_BDIF
     bool
 
+config VMAPPLE_CFG
+    bool
+
diff --git a/hw/vmapple/cfg.c b/hw/vmapple/cfg.c
new file mode 100644
index 00000000000..a5e5c62f59f
--- /dev/null
+++ b/hw/vmapple/cfg.c
@@ -0,0 +1,106 @@
+/*
+ * VMApple Configuration Region
+ *
+ * Copyright © 2023 Amazon.com, Inc. or its affiliates. All Rights Reserved.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/vmapple/cfg.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qapi/error.h"
+
+static void vmapple_cfg_reset(Object *obj, ResetType type)
+{
+    VMAppleCfgState *s = VMAPPLE_CFG(obj);
+    VMAppleCfg *cfg;
+
+    cfg = memory_region_get_ram_ptr(&s->mem);
+    memset((void *)cfg, 0, VMAPPLE_CFG_SIZE);
+    *cfg = s->cfg;
+}
+
+static void vmapple_cfg_realize(DeviceState *dev, Error **errp)
+{
+    VMAppleCfgState *s = VMAPPLE_CFG(dev);
+    uint32_t i;
+
+    strncpy(s->cfg.serial, s->serial, sizeof(s->cfg.serial));
+    strncpy(s->cfg.model, s->model, sizeof(s->cfg.model));
+    strncpy(s->cfg.soc_name, s->soc_name, sizeof(s->cfg.soc_name));
+    strncpy(s->cfg.unk8, "D/A", sizeof(s->cfg.soc_name));
+    s->cfg.ecid = cpu_to_be64(s->cfg.ecid);
+    s->cfg.version = 2;
+    s->cfg.unk1 = 1;
+    s->cfg.unk2 = 1;
+    s->cfg.unk3 = 0x20;
+    s->cfg.unk4 = 0;
+    s->cfg.unk5 = 1;
+    s->cfg.unk6 = 1;
+    s->cfg.unk7 = 0;
+    s->cfg.unk10 = 1;
+
+    g_assert(s->cfg.nr_cpus < ARRAY_SIZE(s->cfg.cpu_ids));
+    for (i = 0; i < s->cfg.nr_cpus; i++) {
+        s->cfg.cpu_ids[i] = i;
+    }
+}
+
+static void vmapple_cfg_init(Object *obj)
+{
+    VMAppleCfgState *s = VMAPPLE_CFG(obj);
+
+    memory_region_init_ram(&s->mem, obj, "VMApple Config", VMAPPLE_CFG_SIZE,
+                           &error_fatal);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mem);
+
+    s->serial = (char *)"1234";
+    s->model = (char *)"VM0001";
+    s->soc_name = (char *)"Apple M1 (Virtual)";
+}
+
+static Property vmapple_cfg_properties[] = {
+    DEFINE_PROP_UINT32("nr-cpus", VMAppleCfgState, cfg.nr_cpus, 1),
+    DEFINE_PROP_UINT64("ecid", VMAppleCfgState, cfg.ecid, 0),
+    DEFINE_PROP_UINT64("ram-size", VMAppleCfgState, cfg.ram_size, 0),
+    DEFINE_PROP_UINT32("run_installer1", VMAppleCfgState, cfg.run_installer1, 0),
+    DEFINE_PROP_UINT32("run_installer2", VMAppleCfgState, cfg.run_installer2, 0),
+    DEFINE_PROP_UINT32("rnd", VMAppleCfgState, cfg.rnd, 0),
+    DEFINE_PROP_MACADDR("mac-en0", VMAppleCfgState, cfg.mac_en0),
+    DEFINE_PROP_MACADDR("mac-en1", VMAppleCfgState, cfg.mac_en1),
+    DEFINE_PROP_MACADDR("mac-wifi0", VMAppleCfgState, cfg.mac_wifi0),
+    DEFINE_PROP_MACADDR("mac-bt0", VMAppleCfgState, cfg.mac_bt0),
+    DEFINE_PROP_STRING("serial", VMAppleCfgState, serial),
+    DEFINE_PROP_STRING("model", VMAppleCfgState, model),
+    DEFINE_PROP_STRING("soc_name", VMAppleCfgState, soc_name),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void vmapple_cfg_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    dc->realize = vmapple_cfg_realize;
+    dc->desc = "VMApple Configuration Region";
+    device_class_set_props(dc, vmapple_cfg_properties);
+    rc->phases.hold = vmapple_cfg_reset;
+}
+
+static const TypeInfo vmapple_cfg_info = {
+    .name          = TYPE_VMAPPLE_CFG,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(VMAppleCfgState),
+    .instance_init = vmapple_cfg_init,
+    .class_init    = vmapple_cfg_class_init,
+};
+
+static void vmapple_cfg_register_types(void)
+{
+    type_register_static(&vmapple_cfg_info);
+}
+
+type_init(vmapple_cfg_register_types)
diff --git a/hw/vmapple/meson.build b/hw/vmapple/meson.build
index d4624713deb..64b78693a31 100644
--- a/hw/vmapple/meson.build
+++ b/hw/vmapple/meson.build
@@ -1,2 +1,3 @@
 system_ss.add(when: 'CONFIG_VMAPPLE_AES',  if_true: files('aes.c'))
 system_ss.add(when: 'CONFIG_VMAPPLE_BDIF', if_true: files('bdif.c'))
+system_ss.add(when: 'CONFIG_VMAPPLE_CFG',  if_true: files('cfg.c'))
diff --git a/include/hw/vmapple/cfg.h b/include/hw/vmapple/cfg.h
new file mode 100644
index 00000000000..3337064e447
--- /dev/null
+++ b/include/hw/vmapple/cfg.h
@@ -0,0 +1,68 @@
+/*
+ * VMApple Configuration Region
+ *
+ * Copyright © 2023 Amazon.com, Inc. or its affiliates. All Rights Reserved.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef HW_VMAPPLE_CFG_H
+#define HW_VMAPPLE_CFG_H
+
+#include "hw/sysbus.h"
+#include "qom/object.h"
+#include "net/net.h"
+
+typedef struct VMAppleCfg {
+    uint32_t version;         /* 0x000 */
+    uint32_t nr_cpus;         /* 0x004 */
+    uint32_t unk1;            /* 0x008 */
+    uint32_t unk2;            /* 0x00c */
+    uint32_t unk3;            /* 0x010 */
+    uint32_t unk4;            /* 0x014 */
+    uint64_t ecid;            /* 0x018 */
+    uint64_t ram_size;        /* 0x020 */
+    uint32_t run_installer1;  /* 0x028 */
+    uint32_t unk5;            /* 0x02c */
+    uint32_t unk6;            /* 0x030 */
+    uint32_t run_installer2;  /* 0x034 */
+    uint32_t rnd;             /* 0x038 */
+    uint32_t unk7;            /* 0x03c */
+    MACAddr mac_en0;          /* 0x040 */
+    uint8_t pad1[2];
+    MACAddr mac_en1;          /* 0x048 */
+    uint8_t pad2[2];
+    MACAddr mac_wifi0;        /* 0x050 */
+    uint8_t pad3[2];
+    MACAddr mac_bt0;          /* 0x058 */
+    uint8_t pad4[2];
+    uint8_t reserved[0xa0];   /* 0x060 */
+    uint32_t cpu_ids[0x80];   /* 0x100 */
+    uint8_t scratch[0x200];   /* 0x180 */
+    char serial[32];          /* 0x380 */
+    char unk8[32];            /* 0x3a0 */
+    char model[32];           /* 0x3c0 */
+    uint8_t unk9[32];         /* 0x3e0 */
+    uint32_t unk10;           /* 0x400 */
+    char soc_name[32];        /* 0x404 */
+} VMAppleCfg;
+
+#define TYPE_VMAPPLE_CFG "vmapple-cfg"
+OBJECT_DECLARE_SIMPLE_TYPE(VMAppleCfgState, VMAPPLE_CFG)
+
+struct VMAppleCfgState {
+    /* <private> */
+    SysBusDevice parent_obj;
+    VMAppleCfg cfg;
+
+    /* <public> */
+    MemoryRegion mem;
+    char *serial;
+    char *model;
+    char *soc_name;
+};
+
+#define VMAPPLE_CFG_SIZE 0x00010000
+
+#endif /* HW_VMAPPLE_CFG_H */
-- 
2.39.3 (Apple Git-145)


