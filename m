Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B83C54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 08:45:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ret2x-0004lm-Oc; Tue, 27 Feb 2024 03:42:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ret2w-0004fx-G9
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 03:42:42 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ret2s-0008QT-KA
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 03:42:42 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-33d32f74833so2217846f8f.3
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 00:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709023355; x=1709628155; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8FdaM9hjFygoV+600zSMTUb6h8PNn83HRuFk/DcEkWM=;
 b=wiGf60xIDbVToLcQFzBWI7nENk8qMq/gTW+K85iPXD9u84dFociocAIL8/7fO2CLiV
 bshQ+P00e7wSXudAuA2zoyiZM2dlDK1bSNDpS7KPiN79qmfqKAjWHcXYCLx7t7w6XWOv
 0AdJPUd+F2ts7Vz6x1TEn/thnO1xeVW/yUkfkI3KRHz8KaFqmudA0gJ34wFba0XF2bSW
 C0JRDS2qG7VXDan7/FzNUaJF7RjcFc4dj1af4PrBqEX8q1UTPjv3MtyMCqbpiySGR0Qp
 n5ZjtpPDi03tYciZEFnB79sR1LnXAIpmtZgMXUOjaA5vz4rxQTwyTRYK5NxejN2WkqLU
 XgFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709023355; x=1709628155;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8FdaM9hjFygoV+600zSMTUb6h8PNn83HRuFk/DcEkWM=;
 b=Up43fxSUy9JBO8OpBRxJxY3Uv529zkTo6TkKNmye+6DlvQ5jJtJ2Pc1FuR5q18cxeG
 8j0LozoOJDJR4ldo3CFt4nDnPnUbN8PM0MUiDLPpBr7dJ80su8Rx9yoczkUU7WalVlft
 2aR4l87VWI6WZfkjY1Ulab9DW+/HK8A3je7Misa2Hk80lAcyjeqHOVMqSPUmUOO5ndOW
 TfqlFv5FPQm5cFJ12W4xWUBAupPYOBhETdZ9fE6uk9uM5XCLGfMdv5EN/dwUHjObJzmv
 +I/RSs5uhfGSkfhJZ+Y54CHHg2p7ouvkeDrRwzoneJW1o0RJzHBs/9wZRtn9tCoWS0iW
 HOuA==
X-Gm-Message-State: AOJu0YxL+szMknUXTLiXXsLfX5loaAghKa9ahgDbMj+49rS+obJYkzN2
 YPeiETFt1EEVij7cjB3bFYEXIAid4skoa/qFnseKmNynWCavKzrPjf8vJOmdsI64kModEpiU+3/
 E
X-Google-Smtp-Source: AGHT+IFdSsjcWnXTI18uJa7c021cMHQExZFABwlT8KepkOq3fEPIpA+qU9mnz5CbbJa11PX38qpJ8Q==
X-Received: by 2002:a5d:4109:0:b0:33d:701f:d179 with SMTP id
 l9-20020a5d4109000000b0033d701fd179mr5574325wrp.19.1709023355631; 
 Tue, 27 Feb 2024 00:42:35 -0800 (PST)
Received: from m1x-phil.lan (mic92-h03-176-184-33-214.dsl.sta.abo.bbox.fr.
 [176.184.33.214]) by smtp.gmail.com with ESMTPSA id
 bq8-20020a5d5a08000000b0033b684d6d5csm10815918wrb.20.2024.02.27.00.42.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Feb 2024 00:42:35 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-block@nongnu.org, qemu-arm@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 26/30] hw/i386/pc: Remove unneeded class attribute
 "kvmclock_enabled"
Date: Tue, 27 Feb 2024 09:39:42 +0100
Message-ID: <20240227083948.5427-27-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240227083948.5427-1-philmd@linaro.org>
References: <20240227083948.5427-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

From: Bernhard Beschow <shentey@gmail.com>

PCMachineClass introduces the attribute into the class hierarchy and sets it to
true. There is no sub class overriding the attribute. Commit 30d2a17b46e9
"hw/i386: Remove the deprecated machines 0.12 up to 0.15" removed the last
overrides of this attribute. The attribute is now unneeded and can be removed.

Fixes: 30d2a17b46e9 "hw/i386: Remove the deprecated machines 0.12 up to 0.15"
Cc: Thomas Huth <thuth@redhat.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Message-ID: <20240224135851.100361-5-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/i386/pc.h | 1 -
 hw/i386/pc.c         | 1 -
 hw/i386/pc_piix.c    | 2 +-
 3 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 27834043c3..4bb1899602 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -92,7 +92,6 @@ struct PCMachineClass {
 
     /* Device configuration: */
     bool pci_enabled;
-    bool kvmclock_enabled;
     const char *default_south_bridge;
 
     /* Compat options: */
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 353edeb2ea..a80f809b83 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1799,7 +1799,6 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     pcmc->smbios_uuid_encoded = true;
     pcmc->gigabyte_align = true;
     pcmc->has_reserved_memory = true;
-    pcmc->kvmclock_enabled = true;
     pcmc->enforce_aligned_dimm = true;
     pcmc->enforce_amd_1tb_hole = true;
     /* BIOS ACPI tables: 128K. Other BIOS datastructures: less than 4K reported
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 814d24326d..49d5d48db9 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -184,7 +184,7 @@ static void pc_init1(MachineState *machine,
     pc_machine_init_sgx_epc(pcms);
     x86_cpus_init(x86ms, pcmc->default_cpu_version);
 
-    if (kvm_enabled() && pcmc->kvmclock_enabled) {
+    if (kvm_enabled()) {
         kvmclock_create(pcmc->kvmclock_create_always);
     }
 
-- 
2.41.0


