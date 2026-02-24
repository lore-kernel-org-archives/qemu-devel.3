Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31849F4BB70
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 18:21:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vux1y-0002il-T7; Tue, 24 Feb 2026 13:21:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vux1Y-0002Rj-CS
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 13:20:48 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vux1V-0004Ca-UL
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 13:20:43 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-48069a48629so59756945e9.0
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 10:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771957240; x=1772562040; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f42Pvns6tbLPcjWo5xKtxLAjp3FYfFBrQQWktkyMXLE=;
 b=YeMf78zF+lowpUJxKILryi9fDdj0xKio/kIkn2kP5PQzZGKYv7kYR6GX4ubwMKw4cO
 Ulfyp/3mzX2v2FwYE+ctaz3FemCplsKl5DqgkVwqeDbPQQ9SfyyhQXPaYmi11vNOQq7r
 vf7+XBwhltmDYFVScnpTl5XjjkF6GjjhImezW81/zSOb5MPJJbS919CiQv5V2ftWVg5J
 +94QpFgZEDcqGcol3wZ/qC78kme1ZghATwcfUVlfp4KPkd3LWBpt+t72WYSc2qQgSzwv
 CPOFN/wcOhuI0OP1UKpJgKeU19DU/aqFGWUELMTJAdshTD/Uqro6t2ZyYDfjVmSsLcr0
 I9Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771957240; x=1772562040;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=f42Pvns6tbLPcjWo5xKtxLAjp3FYfFBrQQWktkyMXLE=;
 b=hODjlMNIaycICfnrbrnlALtdxVX4sycIZT+AEcygEI98nw0dwL6GrrXFNeLa2QZKOU
 hiaDy3P5qQT1dCipMc75aZrGvV0WIwhv5yvfx8hvmGUsZntYEvyQaJ+KmGyXNTfBHuf+
 AH1OMMZrVHK2Rpeuafwe47haHnfiGSTGquG1gFWVMb+aXz4JoeiJVcFowDDKgf+KqbKf
 9CYfxb9O6qqCjR0ov5aep4gauXCzWOQzPHVOji7UqKobAbqNT4Kyd7pFtHhJfAOPGYxK
 5ymVC87v9CpS6nb51jPEsDehGMOGz/okYicov5IiFRWbUP4msEWIyX1ftq8AhT/oOI/h
 HjMw==
X-Gm-Message-State: AOJu0Yx9S1P2drbehsyJsEvGnSgDrDsJyhPwvmgrIR1IHTJlqxLh4Aal
 hjqd7/oDNzNzIPKE5r+qoC9QiP9X/Xcoidhn2AMYUlpQHaTkOkdvBhlMzxg74qT2FeLDAJusfHD
 nz/25Icc=
X-Gm-Gg: AZuq6aK/AUc2ecKrsVUyD9z4NW4slvFwWAeTiZ1m/V6GhJFviEaRPlBfBjouB8N/+jt
 RsGtyOPbFdycu3Gb5zMvfPKxHqOOEthigeix8M/t3T8xo1qhCw/l7vVEoxjbfDJlvL11f6WnAzw
 gcKrXGAy3EEIoDGQ2gJFMfpac8skobZUsC6XBKgasdVwNQ7ecBLrTpIym+l2CJpZfFrzo2eDcDr
 4HfrOAkV2dIvFERbAFwZyd5l7adndQ44ZmeLV5YT1/ztocq2rCLE8K1ACkOB20IHDq0XGDB05h9
 11yysTMbrTCN1PUkSTF8ZCGbQCeT3zuOQaEvZ/hSvmb5/2cfl/836ALPRRLwxYEAXPEdjBWU8SD
 dj8DSHBz0J2q4b7BcKmudX5sfMuQFwLyzMQOab9c6+hd8qjPrjC4mz0/SOkC75B9scGRToGDWGS
 Fzpmj0HJqu1JjY/rVIjPR241Lp3lHFu7FLxsMWMAgJaHI2vyoOPO4STq24a+YHbir2XbY7vdc8
X-Received: by 2002:a05:600c:5397:b0:483:71f9:37f3 with SMTP id
 5b1f17b1804b1-483a95a85c0mr230034575e9.1.1771957239682; 
 Tue, 24 Feb 2026 10:20:39 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483beb4a2a0sm685095e9.9.2026.02.24.10.20.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Feb 2026 10:20:39 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PATCH 03/10] hw/acpi: Move qbus_build_aml() function out of
 acpi_interface.c
Date: Tue, 24 Feb 2026 19:20:09 +0100
Message-ID: <20260224182017.99865-4-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260224182017.99865-1-philmd@linaro.org>
References: <20260224182017.99865-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

acpi_interface.c should only register QOM interfaces. Move
the qbus_build_aml() function to aml-build.c with the other
AML build-related helpers.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/acpi/acpi_interface.c | 10 ----------
 hw/acpi/aml-build.c      | 11 +++++++++++
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/hw/acpi/acpi_interface.c b/hw/acpi/acpi_interface.c
index e58e8aaee23..a44679017ea 100644
--- a/hw/acpi/acpi_interface.c
+++ b/hw/acpi/acpi_interface.c
@@ -2,16 +2,6 @@
 #include "hw/acpi/acpi_dev_interface.h"
 #include "hw/acpi/acpi_aml_interface.h"
 #include "qemu/module.h"
-#include "qemu/queue.h"
-
-void qbus_build_aml(BusState *bus, Aml *scope)
-{
-    BusChild *kid;
-
-    QTAILQ_FOREACH(kid, &bus->children, sibling) {
-        call_dev_aml_func(DEVICE(kid->child), scope);
-    }
-}
 
 static void register_types(void)
 {
diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index ea1c415b211..4b374050881 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -25,12 +25,14 @@
 #include "hw/acpi/acpi.h"
 #include "qemu/bswap.h"
 #include "qemu/bitops.h"
+#include "qemu/queue.h"
 #include "system/numa.h"
 #include "hw/core/boards.h"
 #include "hw/acpi/tpm.h"
 #include "hw/pci/pci_host.h"
 #include "hw/pci/pci_bus.h"
 #include "hw/pci/pci_bridge.h"
+#include "hw/acpi/acpi_aml_interface.h"
 #include "qemu/cutils.h"
 
 static GArray *build_alloc_array(void)
@@ -2647,3 +2649,12 @@ Aml *aml_error_device(void)
 
     return dev;
 }
+
+void qbus_build_aml(BusState *bus, Aml *scope)
+{
+    BusChild *kid;
+
+    QTAILQ_FOREACH(kid, &bus->children, sibling) {
+        call_dev_aml_func(DEVICE(kid->child), scope);
+    }
+}
-- 
2.52.0


