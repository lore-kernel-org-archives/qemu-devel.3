Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC200C3DA5D
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 21:49:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUCWC-0005wa-D2; Wed, 17 Jul 2024 17:49:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUCWB-0005pW-3x
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 17:48:59 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUCW9-0002QL-7j
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 17:48:58 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-426526d30aaso1065275e9.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 14:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721252936; x=1721857736; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PHiJgzHYk3q/G42f0TYNMlRJT0DdF9sH/CZJUoSP/yQ=;
 b=E4xzTD2nDM4waYAJSNsncleyjLowYB9s+0gVz2impNpD/f5d6DM2AeMY9F/LH4fQiD
 6hzpPWzcIA0jVfe+t2hfA9E3IWQM/skE84qspSVc69RrhEltL1XYZivHFMozgT66yN4u
 7vEggp9sovw1vVE+betPMHwi/6Qqg6nXqZ277PHlK8rrKylWPIIkJKXaqrQWfaJqU5mb
 eKGakSxpJ1VglHvbRBHH2bRAgnw8mDkwJzQ4oI2B9COH46WiJLqNkzFvc+4RPCxu23Wq
 x/UyGgyfK0Qm8ch8w9SG3piXtEG4A2xqgXHARZrNBDarg1qcLloONLknLg4JpLfcc32B
 tuPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721252936; x=1721857736;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PHiJgzHYk3q/G42f0TYNMlRJT0DdF9sH/CZJUoSP/yQ=;
 b=VXk8pCpX38r+wMMQwlP6GlRPps4AisQ5+aNyuuHLpc5WM6vNHF8Y09IDpEI+d2s7bo
 3ve6vJs47ugzOiSwkN+EbI1SSZJBsucRHNmX+8w3hOwxhOWyrpP+Ht6DwCCN4Ag+W7bL
 aV7ofjF+VEGcGK0Nb5T4uW2KRBLNF8NIkxh98pnWClt2sPnZLa06TIXh35+BOS2wTHjv
 OJE4GFabe2y13fy4GMG/6OBi0mVIhoR/fSFgwItfYTNl/Efm+GmN57pIUFir5Jur4ZbB
 iCmoE2b6CcPsGK41Fh2DIKAFbvc9eOaZXM3p1HmaSM8DjrMwMMaEIlGteZs/XoG73nDl
 Z3NA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDvL/0xbIYtenkZAtCf1UCsp/X6j156+nMdnuyPzV4ScytLwwCJ3SXeAPUjeHiOGQ4vnBvJNUhtKgU1Bstq8ahjK7VXv8=
X-Gm-Message-State: AOJu0YzQph768DIQ/6f7iIxzne7bCF70869vEjwLF7s9gcIH+JA+5eEU
 nXwMCy8w5JdC81zHlN5nxc3E5KOxdmn+pTKOYHJHDEde21GYr/xjckzgUHG8v1s=
X-Google-Smtp-Source: AGHT+IGjx/wrfmqwB2mQ8+S1Oz1IAhmQDiP4JO4VpPZGsGmgY8Yb101IORpLcpDQPosg3iqR4XoHWg==
X-Received: by 2002:a05:600c:1c21:b0:426:5d0d:a2c9 with SMTP id
 5b1f17b1804b1-427c2cd36d1mr20885515e9.10.1721252935792; 
 Wed, 17 Jul 2024 14:48:55 -0700 (PDT)
Received: from localhost.localdomain ([176.187.208.21])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427c77a56f3sm11695425e9.11.2024.07.17.14.48.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Jul 2024 14:48:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Bibo Mao <maobibo@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-devel@nongnu.org
Cc: Xianglai Li <lixianglai@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>
Subject: [PATCH v3 14/17] hw/intc/loongarch_ipi: Add loongarch IPI support
Date: Wed, 17 Jul 2024 23:47:05 +0200
Message-ID: <20240717214708.78403-15-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240717214708.78403-1-philmd@linaro.org>
References: <20240717214708.78403-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Bibo Mao <maobibo@loongson.cn>

Loongarch IPI is added here, it inherits from class
TYPE_LOONGSON_IPI_COMMON, and two interfaces get_iocsr_as() and
cpu_by_arch_id() are added for Loongarch 3A5000 machine. It can
be used when ipi is emulated in userspace with KVM mode.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
[PMD: Rebased and simplified]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/intc/loongarch_ipi.h | 25 ++++++++++++
 hw/intc/loongarch_ipi.c         | 71 +++++++++++++++++++++++++++++++++
 hw/intc/Kconfig                 |  4 ++
 hw/intc/meson.build             |  1 +
 4 files changed, 101 insertions(+)
 create mode 100644 include/hw/intc/loongarch_ipi.h
 create mode 100644 hw/intc/loongarch_ipi.c

diff --git a/include/hw/intc/loongarch_ipi.h b/include/hw/intc/loongarch_ipi.h
new file mode 100644
index 0000000000..d134c9d0c7
--- /dev/null
+++ b/include/hw/intc/loongarch_ipi.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Loongarch ipi interrupt header files
+ *
+ * Copyright (C) 2024 Loongson Technology Corporation Limited
+ */
+
+#ifndef HW_LOONGARCH_IPI_H
+#define HW_LOONGARCH_IPI_H
+
+#include "qom/object.h"
+#include "hw/intc/loongson_ipi_common.h"
+
+#define TYPE_LOONGARCH_IPI  "loongarch_ipi"
+OBJECT_DECLARE_TYPE(LoongarchIPIState, LoongarchIPIClass, LOONGARCH_IPI)
+
+struct LoongarchIPIState {
+    LoongsonIPICommonState parent_obj;
+};
+
+struct LoongarchIPIClass {
+    LoongsonIPICommonClass parent_class;
+};
+
+#endif
diff --git a/hw/intc/loongarch_ipi.c b/hw/intc/loongarch_ipi.c
new file mode 100644
index 0000000000..277de7c4e4
--- /dev/null
+++ b/hw/intc/loongarch_ipi.c
@@ -0,0 +1,71 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Loongarch ipi interrupt support
+ *
+ * Copyright (C) 2024 Loongson Technology Corporation Limited
+ */
+
+#include "qemu/osdep.h"
+#include "hw/boards.h"
+#include "hw/intc/loongarch_ipi.h"
+#include "target/loongarch/cpu.h"
+
+static AddressSpace *get_iocsr_as(CPUState *cpu)
+{
+    return LOONGARCH_CPU(cpu)->env.address_space_iocsr;
+}
+
+static int archid_cmp(const void *a, const void *b)
+{
+   CPUArchId *archid_a = (CPUArchId *)a;
+   CPUArchId *archid_b = (CPUArchId *)b;
+
+   return archid_a->arch_id - archid_b->arch_id;
+}
+
+static CPUArchId *find_cpu_by_archid(MachineState *ms, uint32_t id)
+{
+    CPUArchId apic_id, *found_cpu;
+
+    apic_id.arch_id = id;
+    found_cpu = bsearch(&apic_id, ms->possible_cpus->cpus,
+                        ms->possible_cpus->len,
+                        sizeof(*ms->possible_cpus->cpus),
+                        archid_cmp);
+
+    return found_cpu;
+}
+
+static CPUState *loongarch_cpu_by_arch_id(int64_t arch_id)
+{
+    MachineState *machine = MACHINE(qdev_get_machine());
+    CPUArchId *archid;
+
+    archid = find_cpu_by_archid(machine, arch_id);
+    if (archid) {
+        return CPU(archid->cpu);
+    }
+
+    return NULL;
+}
+
+static void loongarch_ipi_class_init(ObjectClass *klass, void *data)
+{
+    LoongsonIPICommonClass *licc = LOONGSON_IPI_COMMON_CLASS(klass);
+
+    licc->get_iocsr_as = get_iocsr_as;
+    licc->cpu_by_arch_id = loongarch_cpu_by_arch_id;
+}
+
+static const TypeInfo loongarch_ipi_info = {
+    .name          = TYPE_LOONGARCH_IPI,
+    .parent        = TYPE_LOONGSON_IPI_COMMON,
+    .class_init    = loongarch_ipi_class_init,
+};
+
+static void loongarch_ipi_register_types(void)
+{
+    type_register_static(&loongarch_ipi_info);
+}
+
+type_init(loongarch_ipi_register_types)
diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig
index a2a0fdca85..dd405bdb5d 100644
--- a/hw/intc/Kconfig
+++ b/hw/intc/Kconfig
@@ -94,6 +94,10 @@ config LOONGSON_IPI
     bool
     select LOONGSON_IPI_COMMON
 
+config LOONGARCH_IPI
+    bool
+    select LOONGSON_IPI_COMMON
+
 config LOONGARCH_PCH_PIC
     bool
     select UNIMP
diff --git a/hw/intc/meson.build b/hw/intc/meson.build
index a09a527207..f4d81eb8e4 100644
--- a/hw/intc/meson.build
+++ b/hw/intc/meson.build
@@ -71,6 +71,7 @@ specific_ss.add(when: ['CONFIG_KVM', 'CONFIG_XIVE'],
 specific_ss.add(when: 'CONFIG_M68K_IRQC', if_true: files('m68k_irqc.c'))
 specific_ss.add(when: 'CONFIG_LOONGSON_IPI_COMMON', if_true: files('loongson_ipi_common.c'))
 specific_ss.add(when: 'CONFIG_LOONGSON_IPI', if_true: files('loongson_ipi.c'))
+specific_ss.add(when: 'CONFIG_LOONGARCH_IPI', if_true: files('loongarch_ipi.c'))
 specific_ss.add(when: 'CONFIG_LOONGARCH_PCH_PIC', if_true: files('loongarch_pch_pic.c'))
 specific_ss.add(when: 'CONFIG_LOONGARCH_PCH_MSI', if_true: files('loongarch_pch_msi.c'))
 specific_ss.add(when: 'CONFIG_LOONGARCH_EXTIOI', if_true: files('loongarch_extioi.c'))
-- 
2.41.0


