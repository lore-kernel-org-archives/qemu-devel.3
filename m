Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28DECEA7941
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 19:09:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vniAT-0007uv-QI; Wed, 04 Feb 2026 14:04:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vniAF-0007Od-D8
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:03:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vniAD-0007sD-4y
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:03:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770231824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=44CCfFqxFh058FYaqfQ166E828OwbzPeM6ZE6ERmryw=;
 b=efDVeIeBjp1v4KIepxWCV8WJy0+E2D+hiGFnnLRVh7BA7okdb3YceNeolGtEtysDixdbGw
 RCiVFFCO2tBsrvdPz+zNh+GJ59t3+fWMzdVtwIMBlZEklfmHQ6XiMq6M6EJYZyX0InnchU
 Yzd6ezv0XFomX+C8sFvQU5KC4ZWNLU8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-ryCqI1UaOjOdNcyPEcifGA-1; Wed, 04 Feb 2026 14:03:41 -0500
X-MC-Unique: ryCqI1UaOjOdNcyPEcifGA-1
X-Mimecast-MFC-AGG-ID: ryCqI1UaOjOdNcyPEcifGA_1770231820
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4830e7c6131so1250935e9.2
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 11:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770231820; x=1770836620; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=44CCfFqxFh058FYaqfQ166E828OwbzPeM6ZE6ERmryw=;
 b=rksF+dYAceO0KGc96wMOLzZ7ZZiNm+I/oaYto79K0xDTDsUBlvjHRHmhoswGsTk6fy
 27GBRkIaDx/IlJ2Hl5MXbkk4yTZ+6pVYMGVKGObxXZpkk/gGD/a5xeEULMMV6r+kMlso
 OS/6BHRhJ6GUj/uVMawCLbUg1YgI7w3sv0XWHm2nrdD4ZMaxKzmTBH2QU+hcOtczAlor
 RaztWE7tiO3SpuPZaKplGKsqvyJE0ay0Y7HHnoTa8rYkNt1W84BL7NQKnNGJBEFdzeLT
 dZJz33QtrqewAQaptjUhHlQ4TPGOoZnJ+sKxwsM7Fvxw63WnViCQO+aZJCf2aty+ptBA
 qVLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770231820; x=1770836620;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=44CCfFqxFh058FYaqfQ166E828OwbzPeM6ZE6ERmryw=;
 b=h+CHirTjKsb7Sm0FaKlMw5BuMB4cr3x4cHXiudxz9y2GwCfv4mRfm3uM0lhKbAFmaZ
 HcpANJzd/SaOJbYVwbDxNaBZWYJF5SURdgSN+xjVfoI9IvwyhoGkNe/q7+O8+uwyJwCj
 40IfTcnpdNxuG8bLCBv/XU6zv85YYLv8kKRc3w6QEJvIz9gC4Tjf+urzeZkpxLIo7nbB
 j8dsd8XN0oIKgE1LeHbHo+9JE+LlqsyBMovjcdEAelNjlw8krluaVoebGgvqRzUUFkZ3
 cEcfY79Q17ukgIrkQTzsMsPQvKPq093KVw2zI9ecjKyaJTIT7A4WZ7Ag2QsB3B9fQ0WT
 rThA==
X-Gm-Message-State: AOJu0Yys0oL9NylsCs6MrHc2CU9X95wYOW0DuXAKZF237N9bDNuYk4eg
 kruWIkOZTpUu9JCbsz7W5VD4ErFfWvVkfjWWIz9ZZVBw/pUpAKoQxHwHg2tTSeRn957t8c5oAeK
 quzcoQ77iLpPQctlIdCmru93Pe+X5TqEQMOewrZt3IRZ3Aua8PII2HoTXVxMASZZlyV2aYkFMpO
 nMo2sitLvoRVTJtYZhF5t8ovgt/FTmKxTIRg==
X-Gm-Gg: AZuq6aJMUB3Jja4gEXZ9wDa/gHSyZ/EZFa4+kBqtFV3zcmnv6mDB8f0YT8JqmeMOs4W
 hG4G1JDpXr0ElTI05ZB5hRd1OiA1Jkx+LPmnraHy4xzrYl+Js6l2HX8tKfZSPE//IVmzkT16wg/
 lYeYcY7cbzu6qOGxSXTH1oQXH/H/2W1WXDuoEE8P4J1m6PA3ajxgl59zX4f3+NkeIytDGTVhO+6
 boBM132w1LWnGLcBUqXOVZO41nqBWzX0Vt2dM1eMP5Fu8YEMLVCpHvWpFWt7sxaSWeSuTguUMiN
 ZLqLzyNSqBNP1iYRg0RjaXei2+kUwZi2DircGzLQt0VDUDe+WIYeDSHzwBK2nj27jOipZ7Z+5Mk
 CW2qpJPLUUaW2pjlnLvZpeh8KG6ePc0Ymxw==
X-Received: by 2002:a05:600c:4fd0:b0:480:1e9e:f9d with SMTP id
 5b1f17b1804b1-4830e92cbc0mr56364795e9.8.1770231819957; 
 Wed, 04 Feb 2026 11:03:39 -0800 (PST)
X-Received: by 2002:a05:600c:4fd0:b0:480:1e9e:f9d with SMTP id
 5b1f17b1804b1-4830e92cbc0mr56364245e9.8.1770231819433; 
 Wed, 04 Feb 2026 11:03:39 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48317d4b2a6sm3151735e9.12.2026.02.04.11.03.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 11:03:39 -0800 (PST)
Date: Wed, 4 Feb 2026 14:03:37 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 21/51] x86: q35: generate WDAT ACPI table
Message-ID: <3c7a9fcf2e3afcb50a6b740643165e3b6275915c.1770231744.git.mst@redhat.com>
References: <cover.1770231744.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1770231744.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Igor Mammedov <imammedo@redhat.com>

It will generate WDAT table [1] customized for TCO watchdog.
This allows Windows guests (Windows Server 2008/Vista) to
use TCO watchdog using built-in generic driver, which
aleviates need to install vendor specific drivers.

Given that enabling it might change guest behaviour
(both Windows/Linux) the feature is disabled by default.

Users that need it can enable the feature with
following CLI option.
    -global 'ICH9-LPC.wdat=on'

1)
   "Hardware Watchdog Timers Design Specification"
    https://uefi.org/acpi 'Watchdog Action Table (WDAT)'

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20251030123750.136175-4-imammedo@redhat.com>
---
 hw/acpi/meson.build    |  3 +-
 hw/acpi/wdat-ich9.c    | 85 ++++++++++++++++++++++++++++++++++++++++++
 hw/acpi/wdat-stub.c    | 16 ++++++++
 hw/i386/acpi-build.c   | 13 +++++++
 include/hw/acpi/wdat.h |  3 ++
 5 files changed, 119 insertions(+), 1 deletion(-)
 create mode 100644 hw/acpi/wdat-ich9.c
 create mode 100644 hw/acpi/wdat-stub.c

diff --git a/hw/acpi/meson.build b/hw/acpi/meson.build
index 56b5d1ec96..fb4304f21c 100644
--- a/hw/acpi/meson.build
+++ b/hw/acpi/meson.build
@@ -24,7 +24,7 @@ acpi_ss.add(when: 'CONFIG_ACPI_PCI_BRIDGE', if_true: files('pci-bridge.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_PCIHP', if_true: files('pcihp.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_PCIHP', if_false: files('acpi-pci-hotplug-stub.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_VIOT', if_true: files('viot.c'))
-acpi_ss.add(when: 'CONFIG_ACPI_ICH9', if_true: files('ich9.c', 'ich9_tco.c', 'ich9_timer.c'))
+acpi_ss.add(when: 'CONFIG_ACPI_ICH9', if_true: files('ich9.c', 'ich9_tco.c', 'ich9_timer.c', 'wdat-ich9.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_ERST', if_true: files('erst.c'))
 acpi_ss.add(when: 'CONFIG_IPMI', if_true: files('ipmi.c'), if_false: files('ipmi-stub.c'))
 acpi_ss.add(when: 'CONFIG_PC', if_false: files('acpi-x86-stub.c'))
@@ -33,6 +33,7 @@ if have_tpm
 endif
 system_ss.add(when: 'CONFIG_ACPI', if_false: files('acpi-stub.c', 'aml-build-stub.c', 'ghes-stub.c', 'acpi_interface.c'))
 system_ss.add(when: 'CONFIG_ACPI_PCI_BRIDGE', if_false: files('pci-bridge-stub.c'))
+system_ss.add(when: 'CONFIG_ACPI_ICH9', if_false: files('wdat-stub.c'))
 system_ss.add_all(when: 'CONFIG_ACPI', if_true: acpi_ss)
 system_ss.add(when: 'CONFIG_GHES_CPER', if_true: files('ghes_cper.c'))
 system_ss.add(when: 'CONFIG_GHES_CPER', if_false: files('ghes_cper_stub.c'))
diff --git a/hw/acpi/wdat-ich9.c b/hw/acpi/wdat-ich9.c
new file mode 100644
index 0000000000..c32ecf922c
--- /dev/null
+++ b/hw/acpi/wdat-ich9.c
@@ -0,0 +1,85 @@
+/*
+ * TCO Watchdog Action Table (WDAT)
+ *
+ * Copyright Red Hat, Inc. 2025
+ * Author(s): Igor Mammedov <imammedo@redhat.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/acpi/aml-build.h"
+#include "hw/acpi/wdat.h"
+#include "hw/southbridge/ich9.h"
+
+#define TCO_REG(base, reg_offset, reg_width) { .space_id = AML_AS_SYSTEM_IO, \
+            .address = base + reg_offset, .bit_width = reg_width, \
+            .access_width = AML_WORD_ACC, };
+
+/*
+ *   "Hardware Watchdog Timers Design Specification"
+ *       https://uefi.org/acpi 'Watchdog Action Table (WDAT)'
+ */
+void build_wdat(GArray *table_data, BIOSLinker *linker, const char *oem_id,
+                const char *oem_table_id, uint64_t tco_base)
+{
+    AcpiTable table = { .sig = "WDAT", .rev = 1, .oem_id = oem_id,
+                        .oem_table_id = oem_table_id };
+    struct AcpiGenericAddress tco_rld =  TCO_REG(tco_base, 0x0, 16);
+    struct AcpiGenericAddress tco2_sts = TCO_REG(tco_base, 0x6, 16);
+    struct AcpiGenericAddress tco1_cnt = TCO_REG(tco_base, 0x8, 16);
+    struct AcpiGenericAddress tco_tmr =  TCO_REG(tco_base, 0x12, 16);
+
+    acpi_table_begin(&table, table_data);
+    build_append_int_noprefix(table_data, 0x20, 4); /* Watchdog Header Length */
+    build_append_int_noprefix(table_data, 0xff, 2); /* PCI Segment */
+    build_append_int_noprefix(table_data, 0xff, 1); /* PCI Bus Number */
+    build_append_int_noprefix(table_data, 0xff, 1); /* PCI Device Number */
+    build_append_int_noprefix(table_data, 0xff, 1); /* PCI Function Number */
+    build_append_int_noprefix(table_data, 0, 3);    /* Reserved */
+    build_append_int_noprefix(table_data, 0x258, 4);/* Timer Period, ms */
+    build_append_int_noprefix(table_data, 0x3ff, 4);/* Maximum Count */
+    build_append_int_noprefix(table_data, 0x4, 4);  /* Minimum Count */
+    /*
+     * WATCHDOG_ENABLED & WATCHDOG_STOPPED_IN_SLEEP_STATE
+     */
+    build_append_int_noprefix(table_data, 0x81, 1); /* Watchdog Flags */
+    build_append_int_noprefix(table_data, 0, 3);    /* Reserved */
+    /*
+     * watchdog instruction entries
+     */
+    build_append_int_noprefix(table_data, 10, 4);
+    /* Action table */
+    build_append_wdat_ins(table_data, WDAT_ACTION_RESET,
+        WDAT_INS_WRITE_VALUE,
+        tco_rld, 0x1, 0x1ff);
+    build_append_wdat_ins(table_data, WDAT_ACTION_QUERY_RUNNING_STATE,
+        WDAT_INS_READ_VALUE,
+        tco1_cnt, 0x0, 0x800);
+    build_append_wdat_ins(table_data, WDAT_ACTION_SET_RUNNING_STATE,
+        WDAT_INS_WRITE_VALUE | WDAT_INS_PRESERVE_REGISTER,
+        tco1_cnt, 0, 0x800);
+    build_append_wdat_ins(table_data, WDAT_ACTION_QUERY_STOPPED_STATE,
+        WDAT_INS_READ_VALUE,
+        tco1_cnt, 0x800, 0x800);
+    build_append_wdat_ins(table_data, WDAT_ACTION_SET_STOPPED_STATE,
+        WDAT_INS_WRITE_VALUE | WDAT_INS_PRESERVE_REGISTER,
+        tco1_cnt, 0x800, 0x800);
+    build_append_wdat_ins(table_data, WDAT_ACTION_SET_COUNTDOWN_PERIOD,
+        WDAT_INS_WRITE_COUNTDOWN,
+        tco_tmr, 0x0, 0x3FF);
+    build_append_wdat_ins(table_data, WDAT_ACTION_QUERY_COUNTDOWN_PERIOD,
+        WDAT_INS_READ_COUNTDOWN,
+        tco_tmr, 0x0, 0x3FF);
+    build_append_wdat_ins(table_data, WDAT_ACTION_QUERY_WATCHDOG_STATUS,
+        WDAT_INS_READ_VALUE,
+        tco2_sts, 0x2, 0x2);
+    build_append_wdat_ins(table_data, WDAT_ACTION_SET_WATCHDOG_STATUS,
+        WDAT_INS_WRITE_VALUE | WDAT_INS_PRESERVE_REGISTER,
+        tco2_sts, 0x2, 0x2);
+    build_append_wdat_ins(table_data, WDAT_ACTION_SET_WATCHDOG_STATUS,
+        WDAT_INS_WRITE_VALUE | WDAT_INS_PRESERVE_REGISTER,
+        tco2_sts, 0x4, 0x4);
+
+    acpi_table_end(linker, &table);
+}
diff --git a/hw/acpi/wdat-stub.c b/hw/acpi/wdat-stub.c
new file mode 100644
index 0000000000..a9b57a047b
--- /dev/null
+++ b/hw/acpi/wdat-stub.c
@@ -0,0 +1,16 @@
+/*
+ * Copyright Red Hat, Inc. 2025
+ * Author(s): Igor Mammedov <imammedo@redhat.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/acpi/aml-build.h"
+#include "hw/acpi/wdat.h"
+
+void build_wdat(GArray *table_data, BIOSLinker *linker, const char *oem_id,
+                const char *oem_table_id, uint64_t tco_base)
+{
+    g_assert_not_reached();
+}
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 9446a9f862..ac420eab81 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -77,6 +77,7 @@
 
 #include "hw/acpi/hmat.h"
 #include "hw/acpi/viot.h"
+#include "hw/acpi/wdat.h"
 
 #include CONFIG_DEVICES
 
@@ -104,11 +105,13 @@ typedef struct AcpiPmInfo {
     bool smi_on_cpuhp;
     bool smi_on_cpu_unplug;
     bool pcihp_root_en;
+    bool wdat_enabled;
     uint8_t s4_val;
     AcpiFadtData fadt;
     uint16_t cpu_hp_io_base;
     uint16_t pcihp_io_base;
     uint16_t pcihp_io_len;
+    uint64_t tco_io_base;
 } AcpiPmInfo;
 
 typedef struct AcpiMiscInfo {
@@ -203,6 +206,7 @@ static void acpi_get_pm_info(MachineState *machine, AcpiPmInfo *pm)
     pm->pcihp_io_len = 0;
     pm->smi_on_cpuhp = false;
     pm->smi_on_cpu_unplug = false;
+    pm->wdat_enabled = false;
 
     assert(obj);
     init_common_fadt_data(machine, obj, &pm->fadt);
@@ -224,6 +228,9 @@ static void acpi_get_pm_info(MachineState *machine, AcpiPmInfo *pm)
             !!(smi_features & BIT_ULL(ICH9_LPC_SMI_F_CPU_HOTPLUG_BIT));
         pm->smi_on_cpu_unplug =
             !!(smi_features & BIT_ULL(ICH9_LPC_SMI_F_CPU_HOT_UNPLUG_BIT));
+        pm->wdat_enabled = object_property_get_bool(obj, "wdat", NULL);
+        pm->tco_io_base = object_property_get_uint(obj, ACPI_PM_PROP_PM_IO_BASE,
+            NULL) + ICH9_PMIO_TCO_RLD;
     }
     pm->pcihp_io_base =
         object_property_get_uint(obj, ACPI_PCIHP_IO_BASE_PROP, NULL);
@@ -2079,6 +2086,12 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
     acpi_add_table(table_offsets, tables_blob);
     build_waet(tables_blob, tables->linker, x86ms->oem_id, x86ms->oem_table_id);
 
+    if (pm.wdat_enabled == true) {
+        acpi_add_table(table_offsets, tables_blob);
+        build_wdat(tables_blob, tables->linker, x86ms->oem_id,
+                   x86ms->oem_table_id, pm.tco_io_base);
+    }
+
     /* Add tables supplied by user (if any) */
     for (u = acpi_table_first(); u; u = acpi_table_next(u)) {
         unsigned len = acpi_table_len(u);
diff --git a/include/hw/acpi/wdat.h b/include/hw/acpi/wdat.h
index c539e97e9b..67b9136d8c 100644
--- a/include/hw/acpi/wdat.h
+++ b/include/hw/acpi/wdat.h
@@ -115,4 +115,7 @@ void build_append_wdat_ins(GArray *table_data,
                            struct AcpiGenericAddress as,
                            uint32_t val, uint32_t mask);
 
+void build_wdat(GArray *table_data, BIOSLinker *linker, const char *oem_id,
+                const char *oem_table_id, uint64_t tco_base);
+
 #endif /* QEMU_HW_ACPI_WDAT_H */
-- 
MST


