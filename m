Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E664C41513
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 13:36:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sURHb-0003W3-ID; Thu, 18 Jul 2024 09:34:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sURHR-0002dN-SG
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:34:48 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sURHP-00007F-VO
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:34:45 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4266f344091so2837445e9.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 06:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721309682; x=1721914482; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kccTi0ZFoJFLXkrpp7aedV5PRYpdvGGcofBCMl8r5k4=;
 b=ezM4RzB5wjGpMikxSaKOmyv7iZUmBCRMGXrwXuriIuMJ/20lycBxhLo2GihFg5SuwT
 5w0nOhVtDO525Dj6+Dm3EwRcMiL55kpOWiM5xQs8IrAphFcKwFGUgKv6ZFPk11rYxxQa
 gmvD+MJ75SCHZ/bC02qZm507ihGkWHnJ0qz/nt/Yi5AUqJPkbFDK8Kd/u+O258p1tAFL
 CtAkwS8od7V2i5VVcP1D4XX1JD6BbtJxRbcQrQ2ohXMja1qa+kifQR83XEijOdq9ifSv
 osdP5ZiK9hb3TGpPNnL/dtMJjQDudeBFiR3JxcFfqJNSmjl0KnPIfXZnGG+9FVZ8ACTk
 RC1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721309682; x=1721914482;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kccTi0ZFoJFLXkrpp7aedV5PRYpdvGGcofBCMl8r5k4=;
 b=COu6VisSmJtt9RmnzlGpuTls0qz5xlAQPH0zK7MF6puFAgEjyoY3uprfhSdxXitxA/
 MTmjZ6RRH1NzxlSME+bQ7n4Wv4edeDwfSrIEYwKfAAbvl28dlL9OMXERNhEm7RLeGfFd
 K394WtZBxyeQ2LweQRfym+50lnP9yKOIHQiIVBRDnzaIeFPUZDued+4SbgBR/KpSIcQm
 8aJZF+hAmj2E2V4JDvajgcN8JeIWS7W1Ebp4OCL80+Pbr6K791Bvxdot4gOprdxrgIJv
 AUH4ofTMGchK0ZbrEWdrby86kYN3Kni/4VFU9zyvABuib4SX88OBWYB6h4jCMhxYf8pH
 TKww==
X-Forwarded-Encrypted: i=1;
 AJvYcCXE2l/TxH43szqoarf3dcwAF4yAPaVXwFclQyqOgq4GFU7iEcLYxzMP74t24zR/Ac3mc61jsrL/aOONCvBTjbRywjy2rmU=
X-Gm-Message-State: AOJu0YwL7GpcDwrTNphtt7rzxPzTLBepsRS2GpBGG4E8xju0gtN+j3Zk
 njcKJRZRRTxkSUV61oMvJU+oHugNMgYpFZUCIo9gmkE47hbLilwIKAADzwlwTyo=
X-Google-Smtp-Source: AGHT+IFOBybHuents0oOXDPA5tCz5I324tpOomQ11JBzSRe37TP5mxsbbu9bxiokep1nm7ZSuTxGPg==
X-Received: by 2002:a05:600c:4e90:b0:426:6326:4cec with SMTP id
 5b1f17b1804b1-427c2ce8d0emr35264935e9.29.1721309682223; 
 Thu, 18 Jul 2024 06:34:42 -0700 (PDT)
Received: from localhost.localdomain ([176.176.173.113])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2b29342sm13216315e9.31.2024.07.18.06.34.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jul 2024 06:34:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Bibo Mao <maobibo@loongson.cn>, qemu-devel@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Song Gao <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Xianglai Li <lixianglai@loongson.cn>
Subject: [PATCH v5 15/19] hw/intc/loongarch_ipi: Add loongarch IPI support
Date: Thu, 18 Jul 2024 15:33:07 +0200
Message-ID: <20240718133312.10324-16-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240718133312.10324-1-philmd@linaro.org>
References: <20240718133312.10324-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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
Co-Developed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Tested-by: Bibo Mao <maobibo@loongson.cn>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Song Gao <gaosong@loongson.cn>
---
 include/hw/intc/loongarch_ipi.h | 25 ++++++++++++
 hw/intc/loongarch_ipi.c         | 68 +++++++++++++++++++++++++++++++++
 hw/intc/Kconfig                 |  4 ++
 hw/intc/meson.build             |  1 +
 4 files changed, 98 insertions(+)
 create mode 100644 include/hw/intc/loongarch_ipi.h
 create mode 100644 hw/intc/loongarch_ipi.c

diff --git a/include/hw/intc/loongarch_ipi.h b/include/hw/intc/loongarch_ipi.h
new file mode 100644
index 0000000000..276b3040a3
--- /dev/null
+++ b/include/hw/intc/loongarch_ipi.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * LoongArch IPI interrupt header files
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
index 0000000000..2ae1a42c46
--- /dev/null
+++ b/hw/intc/loongarch_ipi.c
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * LoongArch IPI interrupt support
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
+static const TypeInfo loongarch_ipi_types[] = {
+    {
+        .name               = TYPE_LOONGARCH_IPI,
+        .parent             = TYPE_LOONGSON_IPI_COMMON,
+        .class_init         = loongarch_ipi_class_init,
+    }
+};
+
+DEFINE_TYPES(loongarch_ipi_types)
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


