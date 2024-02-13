Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F4D4C4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 12:04:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZrW9-0007hZ-00; Tue, 13 Feb 2024 07:04:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZrUt-0005YI-0l
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 07:02:49 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZrUg-00018N-1P
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 07:02:46 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-33b4e6972f6so2268602f8f.2
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 04:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707825739; x=1708430539; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iSiHu0C9dIi1NiXQI0bkwiZLyOTky1dJTMwQJyq+dek=;
 b=ahliYT/rNp0t/q9usd10ezajfH4A+vYglkTzuz0aea03Iz5uoRBiZ+fjYeyLHoQtjh
 mzdh4IrM+eRL16bbTUaoaADsJV8BC3KQ6MU/Q7vOlPxbnrNr4HBkvDMRiHQrug5y8C7A
 vwoQNK/tsqEmsg/Ws1wtmG7aU9Zxx9SyVlyvQEcNUNuE90d5he4hy7j7lcwltFEyLE0Z
 H5l2fomXCrB27dFL+VbyEjqlnTW9kx9C+o0sJN75kWzPmGopwQxryzl5Pe4wql50xtGR
 /D9RhY8SjVo4VtCvKhMSoTBO6fJbzFLby4+smR5C6jtXrlC6E0ObkWbqL/O5YnMDvZtb
 vzTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707825740; x=1708430540;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iSiHu0C9dIi1NiXQI0bkwiZLyOTky1dJTMwQJyq+dek=;
 b=WajWJqJNeZvfUPYRmOcc8TOgcHVbiSuHMjg5BjnkFExzsf3xeb6NGpHm8ftKnCeZ8m
 fPCcwhoDgekXSqqk4mcldVIi1GBvTe84WMuySpN3UgmwnPGh2/j4KYTX5jx24jZ8JUP6
 eHl/mHCwLA8ExWj0+408QHfJfKZH+s2kwtmI3NBL2k4C2Av/aWNHC4LG8na7SHUUAFRA
 MDHg84kW2d/mKs5HSa7t8fgnY+57s2Jy3SaqLmWXgNbnSQ9vTeS0hpjZfMOpKOuItEW/
 P+Ev9HcwZVD2SSG8CDjqbnCeL0XNJzWm8V93+qTnCEAWDuxj/Zs8vOKF2kqgBVgG0BWf
 inBA==
X-Gm-Message-State: AOJu0YxZNkMNWoTLo5NyWDKcoBwKksBzG4dos8MTdlm0L2dESe020Bta
 ovb6XNagAtnOuR/hkocRd73cVsIF8xZzctGCniBT7ECrJ+45uax+fSUpUKNwF5LkSHLqVegybiA
 4
X-Google-Smtp-Source: AGHT+IGAQCiDsIxeY1VWXFGXt44SCk2WBSDXytr/c1oFpUbBy8hwOMhYnPd951f+JsXeRt0+qDqJvg==
X-Received: by 2002:a05:6000:1acb:b0:33a:eb5b:f8cd with SMTP id
 i11-20020a0560001acb00b0033aeb5bf8cdmr8971657wry.7.1707825739759; 
 Tue, 13 Feb 2024 04:02:19 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXIpLe52WvVWm13e8JKcSmsu8NeWvHMYrrVrNdWwmz4zloLQ/wedUmFH/AqALXCWvRRkkxHKXrrB6nXXCnv2t2ntTfMXShtBL+D/VEpNHiNZCpf6jwwE8zETAxSC4j1j+Xgobk1cB6AKs8tH90dH3gqHkgz1bNJhHL+sViOOm5HfSlWI05eKDlid7GzTpfUbDDfkB8d/JxzOYX8lGZh0Nd6pv1RVBxDMsLwhet1/G2xyiR7gL7lHxbTpJ8iI2t4QAZ3pnFCIGZOS7o4StFtKyaztW7IPLP4yEsKI0ussmmYenDxmOOdpme9XX0czfLl/W9BxQZl4fc=
Received: from m1x-phil.lan ([176.176.128.243])
 by smtp.gmail.com with ESMTPSA id
 x10-20020adfcc0a000000b0033cd1959681sm1816333wrh.112.2024.02.13.04.02.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 Feb 2024 04:02:19 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/7] hw/i386/acpi: Declare pc_madt_cpu_entry() in
 'acpi-common.h'
Date: Tue, 13 Feb 2024 13:01:49 +0100
Message-ID: <20240213120153.90930-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240213120153.90930-1-philmd@linaro.org>
References: <20240213120153.90930-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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

Since pc_madt_cpu_entry() is only used by:
 - hw/i386/acpi-build.c   // single call
 - hw/i386/acpi-common.c  // definition
there is no need to expose it outside of hw/i386/.
Declare it in "acpi-common.h".
acpi-build.c doesn't need "hw/i386/pc.h" anymore.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/acpi-common.h | 3 +++
 include/hw/i386/pc.h  | 4 ----
 hw/i386/acpi-common.c | 1 -
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/hw/i386/acpi-common.h b/hw/i386/acpi-common.h
index b3c56ee014..e305aaac15 100644
--- a/hw/i386/acpi-common.h
+++ b/hw/i386/acpi-common.h
@@ -1,12 +1,15 @@
 #ifndef HW_I386_ACPI_COMMON_H
 #define HW_I386_ACPI_COMMON_H
 
+#include "hw/boards.h"
 #include "hw/acpi/bios-linker-loader.h"
 #include "hw/i386/x86.h"
 
 /* Default IOAPIC ID */
 #define ACPI_BUILD_IOAPIC_ID 0x0
 
+void pc_madt_cpu_entry(int uid, const CPUArchIdList *apic_ids,
+                       GArray *entry, bool force_enabled);
 void acpi_build_madt(GArray *table_data, BIOSLinker *linker,
                      X86MachineState *x86ms,
                      const char *oem_id, const char *oem_table_id);
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index f9fc42c2be..ce442372ac 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -199,10 +199,6 @@ bool pc_system_ovmf_table_find(const char *entry, uint8_t **data,
                                int *data_len);
 void pc_system_parse_ovmf_flash(uint8_t *flash_ptr, size_t flash_size);
 
-/* hw/i386/acpi-common.c */
-void pc_madt_cpu_entry(int uid, const CPUArchIdList *apic_ids,
-                       GArray *entry, bool force_enabled);
-
 /* sgx.c */
 void pc_machine_init_sgx_epc(PCMachineState *pcms);
 
diff --git a/hw/i386/acpi-common.c b/hw/i386/acpi-common.c
index 43dc23f7e0..f1a11f833a 100644
--- a/hw/i386/acpi-common.c
+++ b/hw/i386/acpi-common.c
@@ -27,7 +27,6 @@
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/aml-build.h"
 #include "hw/acpi/utils.h"
-#include "hw/i386/pc.h"
 #include "target/i386/cpu.h"
 
 #include "acpi-build.h"
-- 
2.41.0


