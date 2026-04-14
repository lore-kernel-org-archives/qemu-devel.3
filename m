Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75268F531E1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 00:31:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCRgf-0002Nh-9c; Mon, 13 Apr 2026 20:31:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCRge-0002Mp-4m
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 20:31:28 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCRgc-0003D8-IQ
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 20:31:27 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-488e1a8ac40so34954525e9.2
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 17:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776126685; x=1776731485; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+gugBCWVY82uTJlbHhOJnHmVxWC9Bv2gRPQgW/p0QwY=;
 b=iGl8kVKlrLMtqXw35uWpKljGwVyucgKvZ4XyDTvbzj6gEPtLbGTmKIkUSiGxwSgRhF
 YoYJuZ1WjnP841BzPlj2ZnJt7ezSTKFLzfg1uKuK9AjP/fE0/9Nk4w7fKV4qnhEzAqGZ
 hlhz9GfpkDE7Ud/DxH8yPYAqZKsryjdBqK+P07KIpTx/gk/BLAVEh9jSMQxzTfDXq9Hr
 4qFiRQ9BqqVCAvo8qLefxFcdwRUA4BYB2EHRCT3e2+/l4yEjelMpW5nbXx9dvdmWKRue
 w/aXOasIgR1xLq/BhTxofPaqC6LgMnwQtUzQonVvS4/rIHfapf5fVlO5nLlevCyep8m6
 /EYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776126685; x=1776731485;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+gugBCWVY82uTJlbHhOJnHmVxWC9Bv2gRPQgW/p0QwY=;
 b=Spz4ESEgiFhwY9/ZXGB0sGCn0hH/CyR5q/Ih64IeMefqklgyglNxuJzp+7H6we52Mg
 8qHtUhHicjq0mb1nHgBlanlF/Fd2SDzkoSR4Ex8cRsM96IOsZh40GLg1l8mZcCVLx+IL
 O2Fe6m3czhl+3uVsT/bjCNihbYSiMIWCJ89oA3+CN1HOo/V3zNEnxkD0iVQAZYTqtGx5
 qkMOrsu/AUuTnK0qOVBA3DKbkQ3pqQINgUMRjYixqjctyKSdYRZMlyYDdp4MQe3SnHiW
 sClf/9I5XGq2Ob5IuR7bYbzqd1RXtyIPNDOTufzq8ELD4sXzdfdbtBjGsNVLBXH0rT/T
 BIPA==
X-Gm-Message-State: AOJu0Yzb6eKt3alUB5rmeKnXBWmbKnPdycFPyHVg3OVtYIqFsPqTqaRV
 6BLLez5kFpJ8BDP1OFht515PvWTuQFBZ+MB3p8mj/hlCC/cX2B5oNlTs6zR79RWfGt75CuDVtJV
 hFUT0mP8=
X-Gm-Gg: AeBDievP3epU1fHE82dT+SULgQXb6s2+A0lz3NemIbbZ18dfW1Dm1cM20CvVz/M8uFt
 Z8ALwjTCSX35yLlD0GtvK8lCij5j6Dj8qErx36mK0qSPpEW4kbTPL6ta/jccXSsvppOPKkVP6lX
 38tkEvwLQs810ftjgHqzkLeYPhM+j2CQMGQerluc+34EDuA58Go2uBiRM2TTJ7rvqtDmXTJP0Xd
 TwWrVlckwCv4MSwX6F6Gp2ush/tfz0F8UY5SelMUnrGLtHDROQW1NB+wBJBeeT1pIIaGlpQwsUI
 SXzlAFKeQaLINCDOIQkOyRlfUdLtkBCi37rkzH8t3lGwkf9HEJKsN2CzHifLw3/F2yLM+Qx6tIF
 AFOgH7cZl8+5Z+r2BTdEpG8qGOFYRVERsnQln9kFBuDWsZWL4sX+3uyBQdipF2wyCAe84MP5xnf
 ki1EvkUbMDWl2CEnx4CCoTvQyMMxq7oj1DxSznuEoub2+AbC3v9UjjNbPte/cSI2v8PcUD6uF3
X-Received: by 2002:a05:600c:5249:b0:485:7f02:afd5 with SMTP id
 5b1f17b1804b1-488d680079bmr201952685e9.13.1776126684652; 
 Mon, 13 Apr 2026 17:31:24 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ee019d9bsm5975475e9.14.2026.04.13.17.31.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Apr 2026 17:31:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org
Subject: [PATCH v3 11/27] monitor: Do not check TARGET_I386 to build 'info
 sgx' command
Date: Tue, 14 Apr 2026 02:29:43 +0200
Message-ID: <20260414003001.97571-12-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414003001.97571-1-philmd@linaro.org>
References: <20260414003001.97571-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

This command is filtered at build-time for i386/x86_64 binaries.
By using the recently introduced HMPCommand::arch_bitmask flag
we can filter it at runtime, making it possible to compile
hmp-commands-info.hx once.

Since the method depends on the CONFIG_SGX definition, define it
in its own stub file.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 MAINTAINERS            |  1 +
 hw/i386/sgx-hmp-stub.c | 16 ++++++++++++++++
 hw/i386/sgx-stub.c     |  5 -----
 hmp-commands-info.hx   |  3 +--
 hw/i386/meson.build    |  1 +
 5 files changed, 19 insertions(+), 7 deletions(-)
 create mode 100644 hw/i386/sgx-hmp-stub.c

diff --git a/MAINTAINERS b/MAINTAINERS
index a0c8f484163..16a3d71af02 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -514,6 +514,7 @@ L: kvm@vger.kernel.org
 S: Supported
 F: docs/system/i386/amd-memory-encryption.rst
 F: docs/system/i386/sgx.rst
+F: hw/i386/sgx*
 F: stubs/qmp-i386-sev.c
 F: stubs/qmp-i386-sgx.c
 F: target/i386/kvm/
diff --git a/hw/i386/sgx-hmp-stub.c b/hw/i386/sgx-hmp-stub.c
new file mode 100644
index 00000000000..cf1d9a6344b
--- /dev/null
+++ b/hw/i386/sgx-hmp-stub.c
@@ -0,0 +1,16 @@
+/*
+ * Human Monitor 'info sgx' stub (CONFIG_SGX)
+ *
+ * Copyright (c) Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "monitor/hmp.h"
+#include "monitor/monitor.h"
+
+void hmp_info_sgx(Monitor *mon, const QDict *qdict)
+{
+    monitor_printf(mon, "SGX is not available in this QEMU\n");
+}
diff --git a/hw/i386/sgx-stub.c b/hw/i386/sgx-stub.c
index 1dd8d9afbfa..2b083c77bc1 100644
--- a/hw/i386/sgx-stub.c
+++ b/hw/i386/sgx-stub.c
@@ -23,11 +23,6 @@ SgxInfo *qmp_query_sgx_capabilities(Error **errp)
     return NULL;
 }
 
-void hmp_info_sgx(Monitor *mon, const QDict *qdict)
-{
-    monitor_printf(mon, "SGX is not available in this QEMU\n");
-}
-
 void pc_machine_init_sgx_epc(PCMachineState *pcms)
 {
     memset(&pcms->sgx_epc, 0, sizeof(SGXEPCState));
diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index b575e4ac993..da9fdc0ab7b 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -866,15 +866,14 @@ SRST
     Display the vcpu dirty page limit information.
 ERST
 
-#if defined(TARGET_I386)
     {
         .name       = "sgx",
         .args_type  = "",
         .params     = "",
         .help       = "show intel SGX information",
         .cmd        = hmp_info_sgx,
+        .arch_bitmask = QEMU_ARCH_I386,
     },
-#endif
 
 SRST
   ``info sgx``
diff --git a/hw/i386/meson.build b/hw/i386/meson.build
index 63ae57baa51..b611fbb5a7f 100644
--- a/hw/i386/meson.build
+++ b/hw/i386/meson.build
@@ -24,6 +24,7 @@ i386_ss.add(when: 'CONFIG_VTD', if_true: files('intel_iommu.c'))
 i386_ss.add(when: 'CONFIG_VTD_ACCEL', if_true: files('intel_iommu_accel.c'))
 i386_ss.add(when: 'CONFIG_SGX', if_true: files('sgx-epc.c','sgx.c'),
                                 if_false: files('sgx-stub.c'))
+stub_ss.add(files('sgx-hmp-stub.c'))
 
 i386_ss.add(when: 'CONFIG_ACPI', if_true: files('acpi-common.c'))
 i386_ss.add(when: 'CONFIG_PC', if_true: files(
-- 
2.53.0


