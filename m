Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 916A5C54E58
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 13:13:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl7LR-000200-GO; Fri, 15 Mar 2024 09:11:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rl7Kq-0007qa-Ar
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 09:10:56 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rl7Kl-0008Pu-JA
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 09:10:55 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a44f2d894b7so231494766b.1
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 06:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710508249; x=1711113049; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H3LBH1Jf2Bo2/j/14kl9+1lHNfd8WjvuONiFN4gQJjI=;
 b=v7clIY/q2s1P/Qy1D4Nt55qouMyVa3D5qnVsqZPiZ1UwOkqaDWch3UMiVrSrGr0wWc
 eJSU/bxY+cBZ4Zk+cq0MZcdBCmCNeWUsXg4DHwmWY6YH4Hv2CEo4R7iFX+AekeNTE+eR
 bKvGasWoIAaz7elcMJeIzWLG9d9oAkG+X5iwmLEI2NmEyiJhN8R7sErv9rINnI534Zui
 SHFIZnIe4sPz8SIxcWrskg34ESHMbuzumS5Y8mxyjo5ML+CWMyuQ8PyCi065OnzJMKLX
 6rM4Q24TKjiILm7hwwnUg89/CDplEhnsgIq+UkddG8hQsuW1LWM+1JUpHe1A3kSVD0V3
 SH+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710508249; x=1711113049;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H3LBH1Jf2Bo2/j/14kl9+1lHNfd8WjvuONiFN4gQJjI=;
 b=Xg5abXaJ+u7436+jM3lTjweqtoKocbDABtHt4upyGjh7OApCaU1h55OQlSLaJUYp4I
 vXjQ8EcOTtc5T0QatMLhJF4aqScrbs+P31tH8BCq6xjUMt48mA1cKUMwZKIU2G5K9pxf
 t1hbfLpUP3ka5UaKAIbO8zv4Ndgrj+fAxs8zu7rDYr7R3MDk6hSrthnw31Vbucb1W+Q7
 n89t69uU70HS4vVYeslXkvPAMAUsqyaea9iLWKQP5Ph0L+S3GrFJpKaCfCu4sHlUZG5y
 1mBOmOVsPqE27tttBrRZW8zj+0vkYAEF7GjeYVz8O/1AR4SgMAk+FeNvFypLjr7/Bch6
 /ZbQ==
X-Gm-Message-State: AOJu0Ywm2K4Ovjeg75LIO1KhJ3sP4VBrmsapAIStzJA7MxflMQnMWBA0
 MprRfculUGRrOtVXmPot77R2iRc9njtw7vLoGWmFMAi2MQfZgLZjrW63txveHeKSx0yvtW/Etpp
 S
X-Google-Smtp-Source: AGHT+IHT0ljMv+ZylpuooIW3Z37sPNxE+a2hhO+L1RZyKrqkhraPNn7FD79q/JmglujaaRO/o6TY3g==
X-Received: by 2002:a17:907:7d8f:b0:a46:98a5:ba58 with SMTP id
 oz15-20020a1709077d8f00b00a4698a5ba58mr459522ejc.40.1710508248931; 
 Fri, 15 Mar 2024 06:10:48 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.145.26])
 by smtp.gmail.com with ESMTPSA id
 gx27-20020a1709068a5b00b00a465fd3977esm1730440ejc.143.2024.03.15.06.10.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 15 Mar 2024 06:10:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Cc: qemu-riscv@nongnu.org, Anton Johansson <anjo@rev.ng>,
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Claudio Fontana <cfontana@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Subject: [RFC PATCH-for-9.1 14/21] system: Introduce QMP
 generic_query_cpu_definitions()
Date: Fri, 15 Mar 2024 14:09:02 +0100
Message-ID: <20240315130910.15750-15-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240315130910.15750-1-philmd@linaro.org>
References: <20240315130910.15750-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
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

Each target use a common template for qmp_query_cpu_definitions().

Extract it as generic_query_cpu_definitions(), keeping the
target-specific implementations as the following SysemuCPUOps
handlers:
 - cpu_list_compare()
 - add_definition()
 - add_alias_definitions()

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS                           |  2 +
 include/hw/core/sysemu-cpu-ops.h      | 14 ++++++
 include/qapi/commands-target-compat.h | 14 ++++++
 system/cpu-qmp-cmds.c                 | 71 +++++++++++++++++++++++++++
 system/meson.build                    |  1 +
 5 files changed, 102 insertions(+)
 create mode 100644 include/qapi/commands-target-compat.h
 create mode 100644 system/cpu-qmp-cmds.c

diff --git a/MAINTAINERS b/MAINTAINERS
index af27490243..39d7c14d98 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -148,6 +148,7 @@ M: Richard Henderson <richard.henderson@linaro.org>
 R: Paolo Bonzini <pbonzini@redhat.com>
 S: Maintained
 F: system/cpus.c
+F: system/cpu-qmp-cmds.c
 F: system/cpu-qom-helpers.c
 F: system/watchpoint.c
 F: cpu-common.c
@@ -1894,6 +1895,7 @@ F: qapi/machine-target.json
 F: include/hw/boards.h
 F: include/hw/core/cpu.h
 F: include/hw/cpu/cluster.h
+F: include/qapi/commands-target-compat.h
 F: include/sysemu/numa.h
 F: tests/unit/test-smp-parse.c
 T: git https://gitlab.com/ehabkost/qemu.git machine-next
diff --git a/include/hw/core/sysemu-cpu-ops.h b/include/hw/core/sysemu-cpu-ops.h
index 24d003fe04..2173226e97 100644
--- a/include/hw/core/sysemu-cpu-ops.h
+++ b/include/hw/core/sysemu-cpu-ops.h
@@ -11,6 +11,7 @@
 #define SYSEMU_CPU_OPS_H
 
 #include "hw/core/cpu.h"
+#include "qapi/qapi-types-machine.h"
 
 /*
  * struct SysemuCPUOps: System operations specific to a CPU class
@@ -81,6 +82,19 @@ typedef struct SysemuCPUOps {
      */
     bool (*virtio_is_big_endian)(CPUState *cpu);
 
+    /**
+     * @cpu_list_compare: Sort alphabetically by type name,
+     *                    respecting CPUClass::ordering.
+     */
+    gint (*cpu_list_compare)(gconstpointer cpu_class_a, gconstpointer cpu_class_b);
+    /**
+     * @add_definition: Add the @cpu_class definition to @cpu_list.
+     */
+    void (*add_definition)(gpointer cpu_class, gpointer cpu_list);
+    /**
+     * @add_alias_definitions: Add CPU alias definitions to @cpu_list.
+     */
+    void (*add_alias_definitions)(CpuDefinitionInfoList **cpu_list);
     /**
      * @legacy_vmsd: Legacy state for migration.
      *               Do not use in new targets, use #DeviceClass::vmsd instead.
diff --git a/include/qapi/commands-target-compat.h b/include/qapi/commands-target-compat.h
new file mode 100644
index 0000000000..86d45d8fcc
--- /dev/null
+++ b/include/qapi/commands-target-compat.h
@@ -0,0 +1,14 @@
+/*
+ * QAPI helpers for target specific QMP commands
+ *
+ * SPDX-FileCopyrightText: 2024 Linaro Ltd.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef QAPI_COMPAT_TARGET_H
+#define QAPI_COMPAT_TARGET_H
+
+#include "qapi/qapi-types-machine.h"
+
+CpuDefinitionInfoList *generic_query_cpu_definitions(Error **errp);
+
+#endif
diff --git a/system/cpu-qmp-cmds.c b/system/cpu-qmp-cmds.c
new file mode 100644
index 0000000000..daeb131159
--- /dev/null
+++ b/system/cpu-qmp-cmds.c
@@ -0,0 +1,71 @@
+/*
+ * QAPI helpers for target specific QMP commands
+ *
+ * SPDX-FileCopyrightText: 2024 Linaro Ltd.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qom/object.h"
+#include "qapi/commands-target-compat.h"
+#include "sysemu/arch_init.h"
+#include "hw/core/cpu.h"
+#include "hw/core/sysemu-cpu-ops.h"
+
+static void cpu_common_add_definition(gpointer data, gpointer user_data)
+{
+    ObjectClass *oc = data;
+    CpuDefinitionInfoList **cpu_list = user_data;
+    CpuDefinitionInfo *info;
+    const char *typename;
+
+    typename = object_class_get_name(oc);
+    info = g_malloc0(sizeof(*info));
+    info->name = cpu_model_from_type(typename);
+    info->q_typename = g_strdup(typename);
+
+    QAPI_LIST_PREPEND(*cpu_list, info);
+}
+
+static void arch_add_cpu_definitions(CpuDefinitionInfoList **cpu_list,
+                                     const char *cpu_typename)
+{
+    ObjectClass *oc;
+    GSList *list;
+    const struct SysemuCPUOps *ops;
+
+    oc = object_class_by_name(cpu_typename);
+    if (!oc) {
+        return;
+    }
+    ops = CPU_CLASS(oc)->sysemu_ops;
+
+    list = object_class_get_list(cpu_typename, false);
+    if (ops->cpu_list_compare) {
+        list = g_slist_sort(list, ops->cpu_list_compare);
+    }
+    g_slist_foreach(list, ops->add_definition ? : cpu_common_add_definition,
+                    cpu_list);
+    g_slist_free(list);
+
+    if (ops->add_alias_definitions) {
+        ops->add_alias_definitions(cpu_list);
+    }
+}
+
+CpuDefinitionInfoList *generic_query_cpu_definitions(Error **errp)
+{
+    CpuDefinitionInfoList *cpu_list = NULL;
+
+    for (unsigned i = 0; i <= QEMU_ARCH_BIT_LAST; i++) {
+        const char *cpu_typename;
+
+        cpu_typename = cpu_typename_by_arch_bit(i);
+        if (!cpu_typename) {
+            continue;
+        }
+        arch_add_cpu_definitions(&cpu_list, cpu_typename);
+    }
+
+    return cpu_list;
+}
diff --git a/system/meson.build b/system/meson.build
index c6ee97e3b2..dd78caa9b7 100644
--- a/system/meson.build
+++ b/system/meson.build
@@ -10,6 +10,7 @@ system_ss.add(files(
   'balloon.c',
   'bootdevice.c',
   'cpus.c',
+  'cpu-qmp-cmds.c',
   'cpu-qom-helpers.c',
   'cpu-throttle.c',
   'cpu-timers.c',
-- 
2.41.0


