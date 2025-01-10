Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE35DE7719C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 10:47:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWCXh-00029z-Bh; Fri, 10 Jan 2025 05:47:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tWCXW-000299-Hd
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 05:46:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tWCXU-0000wf-R0
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 05:46:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736506011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v0sEEaRcxSx+BsOOhEQYP9sA3DNrT8vp0mZwhjIi2oQ=;
 b=ibZGFeZB7c0rxmU/r9V+e8+PSQkJsRc3a4GS8UVz0erJCc58NeMsMfMMXD4NbfB2vEHkCK
 sDNUR4at3/uNNIyp5AdqdWp5BiP4bRVNCk45U9feHO+Mj+R8GQ53V2AUswvgJ42m+F02vm
 oeUmwjdIWezDGfQmf/copytOsbcC1xE=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-0LtEmmlJO0yIdKDrDlDqFA-1; Fri, 10 Jan 2025 05:46:50 -0500
X-MC-Unique: 0LtEmmlJO0yIdKDrDlDqFA-1
X-Mimecast-MFC-AGG-ID: 0LtEmmlJO0yIdKDrDlDqFA
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2163c2f32fdso50993565ad.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 02:46:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736506009; x=1737110809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v0sEEaRcxSx+BsOOhEQYP9sA3DNrT8vp0mZwhjIi2oQ=;
 b=JX0jQNfeFaLhJyuHhum8rOWHY5HWIVaYNlhszQ32WVw3OGnh9p4QkbeaHSkmAQq4WS
 F15rBDJu4+JCrqFLz/IxbbnV5vEvIJuwQZynQ8pZYACD6MRAy5qp/9RjpSrCEKpc+L0s
 Jvnc8DhDLODNtF1+M7kO22R3mTyu9r91rJsM81mc72ZbPkHVbiMzC1atsyT8EE2wuFk6
 0L2yg8OvB1cTpc/A5tchhYPRZ0+Bx3ZBixyJwzOpicrTa1cXEFSCjH9KDtkvElYmkifg
 wC3wjY5hCFPlzqXY0w6t8hYP+TF4wsjUL5QBdpTCd9kTg59K06vU1+rRqQvRnpsPYXu6
 qWCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjOvmFS9dZqLR0Yr4j9OfhOLTgaYj+SPm71VXbq+Jk76+1F5auno//onFNdPLoPI+TL2btMBaU0q4I@nongnu.org
X-Gm-Message-State: AOJu0YwLJ/jcNlr52digvQglyV+Iyzxs0GH1q5/URHBEM5nmrxM0T5EQ
 KMuhQmSA82FMOuFp4MjrRcgPdvlAwaoOh2u1mULulEjhe999GmHpzy0GT4e3xs7WZ4n0s4X9KZH
 ylSn8yso6NZZzsDp3qfx/mNr9j+/dhD+MAh9Kw5HMxympUWakZwrL
X-Gm-Gg: ASbGncusbTy1c41WD4S0lilTImlv7XhsCpB910RmvjxRjSZ9u7rb2sh5DuU/TNCQX8E
 ofegcz7waF8pXGEAmeEWGNu2oMV/FrBm4eRR//dS0gWu/MAhQvHdpOH9GdsamJ74tUK0CnWb2TT
 FSTbZEPgeMv7g9TsvD/QKw4Uq5eu2SmVso0906DE4U5yvkVRjeYBK6O9279iLwddMshrgN2DT7m
 f4/ND+XtgVAXv29adLa5NrIuLG9wJgi96CNevTciW1oJG9E5aHZtF/Xexgfx9+F6WR+scxZ2/FH
 lHg=
X-Received: by 2002:a17:902:e746:b0:216:3633:36e7 with SMTP id
 d9443c01a7336-21a83f7103amr147737065ad.26.1736506009057; 
 Fri, 10 Jan 2025 02:46:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHYVoncP3/flh2uNY8wX31NHpf2uzMxo7YNPROrqSgR+EfmldhyeVHSYzUZsoRbkl/XSnKo8g==
X-Received: by 2002:a17:902:e746:b0:216:3633:36e7 with SMTP id
 d9443c01a7336-21a83f7103amr147736895ad.26.1736506008781; 
 Fri, 10 Jan 2025 02:46:48 -0800 (PST)
Received: from localhost.localdomain ([115.96.31.209])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-21a9f10ddbesm11722255ad.2.2025.01.10.02.46.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 02:46:48 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Cc: armbru@redhat.com,
	qemu-devel@nongnu.org
Subject: [PATCH v5 3/3] tests/qtest/vmcoreinfo: add a unit test to exercize
 basic vmcoreinfo function
Date: Fri, 10 Jan 2025 16:16:18 +0530
Message-ID: <20250110104619.267564-4-anisinha@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250110104619.267564-1-anisinha@redhat.com>
References: <20250110104619.267564-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.436,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

A new qtest is written that exercizes the fw-cfg DMA based read and write ops
to write values into vmcoreinfo fw-cfg file and read them back and varify that
they are the same.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 MAINTAINERS                   |  2 +
 tests/qtest/meson.build       |  1 +
 tests/qtest/vmcoreinfo-test.c | 90 +++++++++++++++++++++++++++++++++++
 3 files changed, 93 insertions(+)
 create mode 100644 tests/qtest/vmcoreinfo-test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 2101b51217..4723d413ab 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3005,6 +3005,7 @@ F: include/system/device_tree.h
 Dump
 S: Supported
 M: Marc-André Lureau <marcandre.lureau@redhat.com>
+R: Ani Sinha <anisinha@redhat.com>
 F: dump/
 F: hw/misc/vmcoreinfo.c
 F: include/hw/misc/vmcoreinfo.h
@@ -3015,6 +3016,7 @@ F: qapi/dump.json
 F: scripts/dump-guest-memory.py
 F: stubs/dump.c
 F: docs/specs/vmcoreinfo.rst
+F: tests/qtest/vmcoreinfo-test.c
 
 Error reporting
 M: Markus Armbruster <armbru@redhat.com>
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index c5a70021c5..9804451e25 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -57,6 +57,7 @@ qtests_i386 = \
   (config_all_devices.has_key('CONFIG_AHCI_ICH9') ? ['tco-test'] : []) +                    \
   (config_all_devices.has_key('CONFIG_FDC_ISA') ? ['fdc-test'] : []) +                      \
   (config_all_devices.has_key('CONFIG_I440FX') ? ['fw_cfg-test'] : []) +                    \
+  (config_all_devices.has_key('CONFIG_FW_CFG_DMA') ? ['vmcoreinfo-test'] : []) +            \
   (config_all_devices.has_key('CONFIG_I440FX') ? ['i440fx-test'] : []) +                    \
   (config_all_devices.has_key('CONFIG_I440FX') ? ['ide-test'] : []) +                       \
   (config_all_devices.has_key('CONFIG_I440FX') ? ['numa-test'] : []) +                      \
diff --git a/tests/qtest/vmcoreinfo-test.c b/tests/qtest/vmcoreinfo-test.c
new file mode 100644
index 0000000000..dcf3b5ae05
--- /dev/null
+++ b/tests/qtest/vmcoreinfo-test.c
@@ -0,0 +1,90 @@
+/*
+ * qtest vmcoreinfo test case
+ *
+ * Copyright Red Hat. 2025.
+ *
+ * Authors:
+ *  Ani Sinha   <anisinha@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "libqos/libqos-pc.h"
+#include "libqtest.h"
+#include "standard-headers/linux/qemu_fw_cfg.h"
+#include "libqos/fw_cfg.h"
+#include "qemu/bswap.h"
+#include "hw/misc/vmcoreinfo.h"
+
+static void test_vmcoreinfo_write_basic(void)
+{
+    QFWCFG *fw_cfg;
+    QOSState *qs;
+    FWCfgVMCoreInfo info;
+    size_t filesize;
+    uint16_t guest_format;
+    uint16_t host_format;
+    uint32_t size;
+    uint64_t paddr;
+
+    qs = qtest_pc_boot("-device vmcoreinfo");
+    fw_cfg = pc_fw_cfg_init(qs->qts);
+
+    memset(&info, 0 , sizeof(info));
+    /* read vmcoreinfo and read back the host format */
+    filesize = qfw_cfg_read_file(fw_cfg, qs, FW_CFG_VMCOREINFO_FILENAME,
+                                &info, sizeof(info));
+    g_assert_cmpint(filesize, ==, sizeof(info));
+
+    host_format = le16_to_cpu(info.host_format);
+    g_assert_cmpint(host_format, ==, FW_CFG_VMCOREINFO_FORMAT_ELF);
+
+    memset(&info, 0 , sizeof(info));
+    info.guest_format = cpu_to_le16(FW_CFG_VMCOREINFO_FORMAT_ELF);
+    info.size = cpu_to_le32(1 * MiB);
+    info.paddr = cpu_to_le64(0xffffff00);
+    info.host_format = cpu_to_le16(host_format);
+
+    /* write the values to the host */
+    filesize = qfw_cfg_write_file(fw_cfg, qs, FW_CFG_VMCOREINFO_FILENAME,
+                                  &info, sizeof(info));
+    g_assert_cmpint(filesize, ==, sizeof(info));
+
+    memset(&info, 0 , sizeof(info));
+
+    /* now read back the values we wrote and compare that they are the same */
+    filesize = qfw_cfg_read_file(fw_cfg, qs, FW_CFG_VMCOREINFO_FILENAME,
+                                &info, sizeof(info));
+    g_assert_cmpint(filesize, ==, sizeof(info));
+
+    size = le32_to_cpu(info.size);
+    paddr = le64_to_cpu(info.paddr);
+    guest_format = le16_to_cpu(info.guest_format);
+
+    g_assert_cmpint(size, ==, 1 * MiB);
+    g_assert_cmpint(paddr, ==, 0xffffff00);
+    g_assert_cmpint(guest_format, ==, FW_CFG_VMCOREINFO_FORMAT_ELF);
+
+    pc_fw_cfg_uninit(fw_cfg);
+    qtest_shutdown(qs);
+}
+
+int main(int argc, char **argv)
+{
+    const char *arch = qtest_get_arch();
+
+    g_test_init(&argc, &argv, NULL);
+
+    if (strcmp(arch, "i386") && strcmp(arch, "x86_64")) {
+        /* skip for non-x86 */
+        exit(EXIT_SUCCESS);
+    }
+
+    qtest_add_func("vmcoreinfo/basic-write",
+                   test_vmcoreinfo_write_basic);
+
+    return g_test_run();
+}
-- 
2.45.2


