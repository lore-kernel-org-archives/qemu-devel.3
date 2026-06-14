Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FC96CD98D2
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:06:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYq9e-0007Mn-J1; Sun, 14 Jun 2026 15:05:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYq9b-0007Lu-Dz
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:05:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYq9Z-0001a0-Ne
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:05:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781463952;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nXKhAwb3pP4WDH+I4sQx9G0qUS7ctc0XUmuZY1RMbDY=;
 b=QUCZLerjzHNgM+HkfrsndbVoo55dKQnNCVJP3u15f/jHSPbM1UiA3dFxWnCY6fl2wfcICg
 NYmilBHuR/B4oRHFBl0iwxLaX0lsMJ0yoLGneBoDFYOmKqmKqqmEDp3RtTDrfOFTDD76CJ
 WasA28eknE3CUFzykbJl7jdRhrrF6DE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-9Hz9QXMSPmCSIIZDMOSahw-1; Sun, 14 Jun 2026 15:05:51 -0400
X-MC-Unique: 9Hz9QXMSPmCSIIZDMOSahw-1
X-Mimecast-MFC-AGG-ID: 9Hz9QXMSPmCSIIZDMOSahw_1781463950
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-490b93debc8so25292895e9.1
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781463950; x=1782068750; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nXKhAwb3pP4WDH+I4sQx9G0qUS7ctc0XUmuZY1RMbDY=;
 b=j5WH1z9DGeINDJ+VSBZItVyRwsdLlg4rebLxmlpPhrkRj/kh77eV3CqPBOgtnkzFMQ
 aKzwDPsZtzR6lKxwhRMf342hD89h2Uy1ZS1td4vhKN48+/MizzG0wVLnI/x68JILFB2z
 iHKenizogsS5fzO2MZsqidSXxOPnAb3LHq/Lush3QKvMk49QohaMhDqIgkYiz0MWmlSp
 V0fmJxioF0n10ZGUQyq7oRdjFf6t4XkFH4tXvcAzgahNtbI/Zp2XrEr1olx9NVszJEKf
 IjgBuUxx0Zsn4coYeUAwb/NP3qGWYHMP0VSi2kmNNREVgRJYqp2fjuYMARNwgyJHiv8u
 dqNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781463950; x=1782068750;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nXKhAwb3pP4WDH+I4sQx9G0qUS7ctc0XUmuZY1RMbDY=;
 b=FVoI3BIIWAPGEYxOaExBGdWaP2oNN2Ca8KLL2vEEfGde3WJvheAUtp86OZXE77yRnV
 F5oxL7cqr/Bn2IHrh1Srq8sb2qPVYIRF1jOj4OiVoBV2jIhHFmiVkCTAg8Ds9a4rWXH5
 iYpAOa1/BWee0Vn6vfhMHySqgoCa7kQmZ9ZYAbxMG8dH6Gu/NTZYrO47s/Q4UBNf6sAl
 6Y27n5SrQ0AA82nHRt0bewDrU4uTBe6IxrhjFh6hTrCD+iT7+AplN9QxX0wjpeT7AFkN
 HN5/yiAXBnEHzcTHOkw92SIlASCokzBS+pRBMsmRtmHQpOMjTOP8+09m4FQx2btdj0uC
 10xQ==
X-Gm-Message-State: AOJu0YytWYi7rXJVa3wsTanC/x5sxupg8ic8aPmOTQqSzSvgPgLC7IF+
 MoCnVQS2N3oOoK6G9cztyoxe+yK7e4wgyUuujs21X9aT1KNDVUf6TbuGVt8iBqO4NqjOb3QFyYp
 /KnrdRKcEFOZXcztzX23O98EBeY8Z/gbtrkiTCP/vkPjLEnWCUM1TgIJr393iwRMw+4UA5jRWXy
 4ftJ0EGOHdVVy9PEznQDtrvdIwu6KdJnHSuw==
X-Gm-Gg: Acq92OG9hqZGeqTnmYh5MEpkyIIPjjJqFN7F6V/QVfNtRxbmqwoPTd8Gn5gm/XanmHa
 UjM51SNcCxsKrTXZ1o51eRAFRDG6xlNIHiUwvgjS4McU0bq7UNmT8cp11GpfmbLcYTmc2biuekd
 7xUSkz/rw9n7+7k7AEfvaEFZZFae30S1xy8DPzdvys18rhFFKf2jw0Q/omx7jOhAGbpQDdth9DO
 2HUO7bJbMAnxWh0RAOQ1RMuAaJV97xTzYfbB6hNxkd9hOUUtHAzAaPqTIJdb11atD1vVLfDiHjA
 JhiSi8O/M7Ikfra7TdcONZSbfsAa1MV5L6JEPJ70hlq29wapMHdXFeR4hffEH20rEc4YKiepaRP
 +P9ImIGnc50ZPWdDEZ4sKiHSJHBpEISFBefCcYsFXvM8=
X-Received: by 2002:a05:600d:8494:20b0:48a:75b9:b0bc with SMTP id
 5b1f17b1804b1-492200e8766mr66748215e9.29.1781463949802; 
 Sun, 14 Jun 2026 12:05:49 -0700 (PDT)
X-Received: by 2002:a05:600d:8494:20b0:48a:75b9:b0bc with SMTP id
 5b1f17b1804b1-492200e8766mr66747865e9.29.1781463949251; 
 Sun, 14 Jun 2026 12:05:49 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2e6a8fsm27230144f8f.37.2026.06.14.12.05.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:05:48 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:05:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Costas Argyris <costas.argyris@amd.com>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Sairaj Kodilkar <sarunkod@amd.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 003/106] tests/qtest: Add amd-iommu command buffer head wrap
 test
Message-ID: <8a1c09cbd3fe776a467398700c610cd126ee8a59.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Costas Argyris <costas.argyris@amd.com>

Add a qtest for AMD IOMMU command buffer head pointer wraparound.
The test programs a command buffer, fills it with COMPLETION_WAIT commands,
advances the tail to consume all but the final entry, then wraps the tail
to zero to force the final command to advance CmdHeadPtr past the end of
the buffer. The guest-visible CmdHeadPtr register must then wrap back to zero.

This covers the case fixed by an earlier CmdHeadPtr wraparound patch.

The Linux kernel AMD IOMMU driver is not affected by this bug because it
uses COMPLETION_WAIT with a memory store doorbell to detect command progress.

Signed-off-by: Costas Argyris <costas.argyris@amd.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260530183458.7778-1-costas.argyris@amd.com>
---
 MAINTAINERS                  |  1 +
 tests/qtest/amd-iommu-test.c | 76 ++++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build      |  1 +
 3 files changed, 78 insertions(+)
 create mode 100644 tests/qtest/amd-iommu-test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index a90daf0308..3b768fc080 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4053,6 +4053,7 @@ M: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
 R: Sairaj Kodilkar <sarunkod@amd.com>
 S: Supported
 F: hw/i386/amd_iommu*
+F: tests/qtest/amd-iommu-test.c
 
 OpenSBI Firmware
 L: qemu-riscv@nongnu.org
diff --git a/tests/qtest/amd-iommu-test.c b/tests/qtest/amd-iommu-test.c
new file mode 100644
index 0000000000..fb28511588
--- /dev/null
+++ b/tests/qtest/amd-iommu-test.c
@@ -0,0 +1,76 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "hw/i386/amd_iommu.h"
+
+#define CMDBUF_ADDR       0x200000
+#define CMDBUF_LEN_FIELD  8
+#define CMDBUF_ENTRIES    (1U << CMDBUF_LEN_FIELD)
+
+static inline uint64_t amdvi_reg_readq(QTestState *s, uint64_t offset)
+{
+    return qtest_readq(s, AMDVI_BASE_ADDR + offset);
+}
+
+static inline void amdvi_reg_writeq(QTestState *s, uint64_t offset,
+                                    uint64_t val)
+{
+    qtest_writeq(s, AMDVI_BASE_ADDR + offset, val);
+}
+
+static void test_cmdbuf_head_wrap(void)
+{
+    QTestState *s;
+    uint64_t head;
+    int i;
+    /* 16 bytes per command */
+    struct {
+        uint64_t qw0;
+        uint64_t qw1;
+    } cmdbuf[CMDBUF_ENTRIES];
+
+    if (!qtest_has_machine("q35")) {
+        g_test_skip("q35 machine not available");
+        return;
+    }
+
+    s = qtest_init("-M q35 -device amd-iommu");
+
+    /* fill the command buffer with COMPLETION_WAIT (no-op) commands */
+    for (i = 0; i < CMDBUF_ENTRIES; i++) {
+        cmdbuf[i].qw0 = (uint64_t)AMDVI_CMD_COMPLETION_WAIT << 60;
+        cmdbuf[i].qw1 = 0;
+    }
+    qtest_memwrite(s, CMDBUF_ADDR, cmdbuf, sizeof(cmdbuf));
+
+    /* point the IOMMU at the command buffer and set its length */
+    amdvi_reg_writeq(s, AMDVI_MMIO_COMMAND_BASE,
+                     CMDBUF_ADDR | ((uint64_t)CMDBUF_LEN_FIELD << 56));
+
+    /* enable the IOMMU and its command buffer processor */
+    amdvi_reg_writeq(s, AMDVI_MMIO_CONTROL,
+                     AMDVI_MMIO_CONTROL_AMDVIEN | AMDVI_MMIO_CONTROL_CMDBUFLEN);
+
+    /* advance tail to the last entry, consuming all but the final entry */
+    amdvi_reg_writeq(s, AMDVI_MMIO_COMMAND_TAIL,
+                     (CMDBUF_ENTRIES - 1) * AMDVI_COMMAND_SIZE);
+
+    /* wrap tail to 0, consuming the final entry and completing the buffer */
+    amdvi_reg_writeq(s, AMDVI_MMIO_COMMAND_TAIL, 0);
+
+    /* after consuming all entries the IOMMU must wrap CmdHeadPtr to 0 */
+    head = amdvi_reg_readq(s, AMDVI_MMIO_COMMAND_HEAD);
+    g_assert((head & AMDVI_MMIO_CMDBUF_HEAD_MASK) == 0);
+
+    qtest_quit(s);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+    qtest_add_func("/q35/amd-iommu/cmdbuf-head-wrap", test_cmdbuf_head_wrap);
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 728dde54b3..67eea5c71a 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -95,6 +95,7 @@ qtests_i386 = \
   (config_all_devices.has_key('CONFIG_SB16') ? ['fuzz-sb16-test'] : []) +                   \
   (config_all_devices.has_key('CONFIG_SDHCI_PCI') ? ['fuzz-sdcard-test'] : []) +            \
   (config_all_devices.has_key('CONFIG_ESP_PCI') ? ['am53c974-test'] : []) +                 \
+  (config_all_devices.has_key('CONFIG_AMD_IOMMU') ? ['amd-iommu-test'] : []) +             \
   (config_all_devices.has_key('CONFIG_VTD') ? ['intel-iommu-test'] : []) +                 \
   (config_all_devices.has_key('CONFIG_VTD') and
    config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') ? ['iommu-intel-test'] : []) +      \
-- 
MST


