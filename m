Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 356A7C4451C
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2026 17:52:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wl9D4-0004cE-Km; Sat, 18 Jul 2026 13:52:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielpaziyski@gmail.com>)
 id 1wl9D2-0004bl-RZ
 for qemu-devel@nongnu.org; Sat, 18 Jul 2026 13:52:20 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielpaziyski@gmail.com>)
 id 1wl9D0-00081g-Sl
 for qemu-devel@nongnu.org; Sat, 18 Jul 2026 13:52:20 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-493bd302c91so3658765e9.3
 for <qemu-devel@nongnu.org>; Sat, 18 Jul 2026 10:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784397137; x=1785001937; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dDCJ20hyaBwLFUDMgdk7nW9nfTiRjuME6/CJfovCLnc=;
 b=V73umKaovWN3SEl3camgLGMKUjHUEArLte7/cJ6BWPuooxB4kfQqyLEsmUOy+rgGb+
 55jQqaiXbeb2P3B+u668NcsAtTnJ6fb252YSC88q6GmN/w+wa9DRdkSEtN/QXM3UiRMJ
 w1NSUhgFQPqMyFYrMpcMoLXL96NUTvng15lVtqMEUX9o0qe+S3xXTTwnMwNAX0fIHQ2+
 zrG4yGbYJEMHuGVJf3C9nkPjagUkyHS8ZJWp2Jlv0lfI7/5ZXa1x2xyY3MNf7czEG7JK
 3jpVPZdESrUNOj7szf/hPg6qyFa2YM9aq+tIYUijbFMepZA/IAoB5FvK42cueyNpUIqa
 Y7nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784397137; x=1785001937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dDCJ20hyaBwLFUDMgdk7nW9nfTiRjuME6/CJfovCLnc=;
 b=Tn6tFqojL7jlJ49bpkSRzfA3bVg+6Sry+3pc92YPtLkGfXL3wVunrJc+4BzdK1lwTX
 DzDfyCZTwxdFMPi2masI99SDLpM3Z2IV0Aq8r1PsU7/1soh+yDHDFT6x32dNvjNJDpbv
 zO06KxQte1KOz66zHElzDhNE1ibvzu8MgLiUxMQzpMH18jR+JeRu/ccE1wyFhcA0mMbe
 RbErh6HaJQMBmw8zeFcQ3+2Y+S6slY37m0+j+tdP8RYy+bTs7JHFEWQvDXsdo2vrsCjo
 9Z0O7rWy3VQXhoh4w3o12VQ3IDhINfBCt6zpnzYJov5GU0H8Y2xYBHN+WZS/WN1YbtQW
 3+eQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp8wl9k9kq+X+lmU7SaX3W8TeqV0jK6HKvO7/4GCPz2z5GEuPDCfQ6Q34YhIrnSO3M+xs5pTuDNbe3H@nongnu.org
X-Gm-Message-State: AOJu0Yx8818lzMhYMKFqBlqvdKeUswe+1kupcxryNeAwdTz1tKkOtAuy
 QQgbpE2Dgx+jsQYd2CxdREWNrKw0QZuWyQf5aSGkPLMJGDbcnoDNihlP
X-Gm-Gg: AfdE7clQYrBQjxa3jtHzKVWmER1ZpCiD3yoEzzsKcze69rxanmzW6Okd8M9jttNaRub
 Et8SihgTEWNGg9h8Xjr36zDv/qnc+UE+yMeuR565/nBS5QoJ04rvCb8qBZYoCIEQru8dPTt9Dwh
 Ic/VWgmZog0UqKVcRVWKr8vP/hjeKTo/3+/OnYxBCxrHlTxio+5oYFV5pQtOSheJ+9ULk/9CE0d
 UJSEJEGyFcH05s90Q9GpqbRzvjqTDFyGhvfN+39k+qWN6ISun+c0yUGUDWnco8eOUyUo3HBAGUO
 PR/8tLQEVjNewgdwjMCZPeOc8X7mm5ektlB/KMb+pebFsuW6g3kk3gY1A1F819JPXKeB9IMrsDB
 fuEGpJZ5QUDM9fSTa3bxrP6aeZ4Hiim8XVOFTk/WQL7oNqfz+LReLSrOC8O44IaqYpzdkT9WeZd
 4=
X-Received: by 2002:a05:600c:35c8:b0:495:4505:dad0 with SMTP id
 5b1f17b1804b1-4954a3eb076mr70047345e9.2.1784397137231; 
 Sat, 18 Jul 2026 10:52:17 -0700 (PDT)
Received: from AtiePC ([79.117.54.17]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63e52aa4sm15220181f8f.10.2026.07.18.10.52.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jul 2026 10:52:16 -0700 (PDT)
From: Daniel Paziyski <danielpaziyski@gmail.com>
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
Cc: Daniel Paziyski <danielpaziyski@gmail.com>,
 Sairaj Kodilkar <sarunkod@amd.com>,
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [PATCH 2/2] tests/qtest: Add amd-iommu passthrough mode test
Date: Sat, 18 Jul 2026 19:52:07 +0200
Message-ID: <20260718175208.118721-3-danielpaziyski@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260718175208.118721-1-danielpaziyski@gmail.com>
References: <20260718175208.118721-1-danielpaziyski@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=danielpaziyski@gmail.com; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Test whether the AMD IOMMU behaves correctly when a device is in passthrough
mode: that is, DTE[V] = 1, DTE[TV] = 1, and DTE[IR] and DTE[IW] are some
combination of 0 and 1. The edu device is used as an initiator of DMA
transactions.

We are looking for, in order:

    - when IR = 1 and IW = 1, no IO page faults
    - when IR = 1 and IW = 0, an IO page fault on device write
    - when IR = 0 and IW = 1, an IO page fault on read
    - when IR = 1 and IW = 1, no IO page fault (back to nodma region)
    - when IR = 0 and IV = 0, an IO page fault on device read/write
    - after reset, the device to behave as if IR = 1 and IW = 1 (nodma)

Signed-off-by: Daniel Paziyski <danielpaziyski@gmail.com>
---
 tests/qtest/amd-iommu-test.c | 230 +++++++++++++++++++++++++++++++++++
 1 file changed, 230 insertions(+)

diff --git a/tests/qtest/amd-iommu-test.c b/tests/qtest/amd-iommu-test.c
index fb28511588..79a65d9cbf 100644
--- a/tests/qtest/amd-iommu-test.c
+++ b/tests/qtest/amd-iommu-test.c
@@ -4,11 +4,23 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
+#include "libqos/pci-pc.h"
 #include "hw/i386/amd_iommu.h"
 
 #define CMDBUF_ADDR       0x200000
 #define CMDBUF_LEN_FIELD  8
 #define CMDBUF_ENTRIES    (1U << CMDBUF_LEN_FIELD)
+#define CMDBUF_SIZE       (CMDBUF_ENTRIES * AMDVI_COMMAND_SIZE)
+
+#define DEVTAB_ADDR       (CMDBUF_ADDR + CMDBUF_SIZE)
+#define DEVTAB_LEN_FIELD  0x1ff
+#define DEVTAB_ENTRIES    (((DEVTAB_LEN_FIELD + 1) << 12U) / AMDVI_DEVTAB_ENTRY_SIZE)
+#define DEVTAB_SIZE       ((DEVTAB_LEN_FIELD + 1) << 12U)
+
+#define EVLOG_ADDR        (DEVTAB_ADDR + DEVTAB_SIZE)
+#define EVLOG_LEN_FIELD   0x0f
+#define EVLOG_ENTRIES     ((4096U << (EVLOG_LEN_FIELD - 8)) / AMDVI_EVENT_LEN)
+#define EVLOG_SIZE        (4096U << (EVLOG_LEN_FIELD - 8))
 
 static inline uint64_t amdvi_reg_readq(QTestState *s, uint64_t offset)
 {
@@ -21,6 +33,34 @@ static inline void amdvi_reg_writeq(QTestState *s, uint64_t offset,
     qtest_writeq(s, AMDVI_BASE_ADDR + offset, val);
 }
 
+static void amdvi_invalidate_devtab_entry(QTestState *s, uint16_t bdf)
+{
+    uint64_t tail = amdvi_reg_readq(s, AMDVI_MMIO_COMMAND_TAIL);
+
+    qtest_writel(s, CMDBUF_ADDR + tail, bdf);
+    qtest_writel(s, CMDBUF_ADDR + tail + 4, 0x20000000);
+    qtest_writel(s, CMDBUF_ADDR + tail + 8, 0);
+    qtest_writel(s, CMDBUF_ADDR + tail + 12, 0);
+
+    g_assert_true(amdvi_reg_readq(s, AMDVI_MMIO_STATUS)
+                  & AMDVI_MMIO_STATUS_CMDBUF_RUN);
+
+    tail = (tail + AMDVI_COMMAND_SIZE) % CMDBUF_SIZE;
+    amdvi_reg_writeq(s, AMDVI_MMIO_COMMAND_TAIL, tail);
+
+    for (;;) {
+        g_assert_true(amdvi_reg_readq(s, AMDVI_MMIO_STATUS) &
+                            AMDVI_MMIO_STATUS_CMDBUF_RUN);
+        if ((amdvi_reg_readq(s, AMDVI_MMIO_COMMAND_HEAD)
+            & AMDVI_MMIO_CMDBUF_HEAD_MASK) == tail) {
+                break;
+        }
+    }
+
+    g_assert_true(amdvi_reg_readq(s, AMDVI_MMIO_STATUS)
+                  & AMDVI_MMIO_STATUS_CMDBUF_RUN);
+}
+
 static void test_cmdbuf_head_wrap(void)
 {
     QTestState *s;
@@ -68,9 +108,199 @@ static void test_cmdbuf_head_wrap(void)
     qtest_quit(s);
 }
 
+static void test_dte_mode_0_edu_dma(QTestState *s,
+                                    QPCIDevice *edu, QPCIBar edu_bar,
+                                    hwaddr edu_dma_src, hwaddr edu_dma_dst,
+                                    bool edu_to_ram,
+                                    bool expect_fail)
+{
+    bool log;
+    uint64_t head, tail, addr;
+
+    qpci_io_writeq(edu, edu_bar, 0x80, edu_dma_src);
+    qpci_io_writeq(edu, edu_bar, 0x88, edu_dma_dst);
+    qpci_io_writeq(edu, edu_bar, 0x90, 1);
+    qpci_io_writeq(edu, edu_bar, 0x98, 0x01 | (edu_to_ram ? 0x02 : 0x00));
+
+    while (qpci_io_readq(edu, edu_bar, 0x98) & 0x01) {
+        /* edu uses a timer for scheduling the DMA operation */
+        qtest_clock_step_next(s);
+    }
+
+    log = amdvi_reg_readq(s, AMDVI_MMIO_STATUS) & AMDVI_MMIO_STATUS_EVENT_INT;
+    if (expect_fail) {
+        g_assert_true(log);
+        amdvi_reg_writeq(s, AMDVI_MMIO_STATUS, AMDVI_MMIO_STATUS_EVENT_INT);
+    } else {
+        g_assert_false(log);
+    }
+
+    if (expect_fail) {
+        head = amdvi_reg_readq(s, AMDVI_MMIO_EVENT_HEAD) &
+                        AMDVI_MMIO_EVTLOG_HEAD_MASK;
+        tail = amdvi_reg_readq(s, AMDVI_MMIO_EVENT_TAIL) &
+                        AMDVI_MMIO_EVTLOG_TAIL_MASK;
+
+        /* make sure only one event has occurred */
+        g_assert_true(((head + AMDVI_EVENT_LEN) % EVLOG_SIZE) ==
+                      (tail % EVLOG_SIZE));
+
+        addr = qtest_readq(s, EVLOG_ADDR + head + 8);
+
+        if (edu_to_ram) {
+            g_assert_true(addr == edu_dma_dst);
+        } else {
+            g_assert_true(addr == edu_dma_src);
+        }
+
+        head = (head + AMDVI_EVENT_LEN) % EVLOG_SIZE;
+        amdvi_reg_writeq(s, AMDVI_MMIO_EVENT_HEAD, head);
+    }
+}
+
+static void test_dte_mode_0_iommu_setup(QTestState *s)
+{
+    /* command buffer */
+    amdvi_reg_writeq(s, AMDVI_MMIO_COMMAND_BASE,
+                     CMDBUF_ADDR | ((uint64_t)CMDBUF_LEN_FIELD << 56));
+    amdvi_reg_writeq(s, AMDVI_MMIO_COMMAND_HEAD, 0);
+    amdvi_reg_writeq(s, AMDVI_MMIO_COMMAND_TAIL, 0);
+
+    /* event log */
+    amdvi_reg_writeq(s, AMDVI_MMIO_EVENT_BASE,
+                     EVLOG_ADDR | ((uint64_t)EVLOG_LEN_FIELD << 56));
+    amdvi_reg_writeq(s, AMDVI_MMIO_EVENT_HEAD, 0);
+    amdvi_reg_writeq(s, AMDVI_MMIO_EVENT_TAIL, 0);
+
+    /* device table */
+    amdvi_reg_writeq(s, AMDVI_MMIO_DEVICE_TABLE,
+                     DEVTAB_ADDR | DEVTAB_LEN_FIELD);
+
+    /* enable */
+    amdvi_reg_writeq(s, AMDVI_MMIO_CONTROL, AMDVI_MMIO_CONTROL_AMDVIEN |
+                     AMDVI_MMIO_CONTROL_CMDBUFLEN |
+                     AMDVI_MMIO_CONTROL_EVENTLOGEN |
+                     AMDVI_MMIO_CONTROL_EVENTINTEN);
+}
+
+static void test_dte_mode_0(void)
+{
+    QTestState *s;
+    QPCIBus *bus;
+    QPCIDevice *edu;
+    QPCIBar edu_bar;
+    const unsigned int edu_devfn = PCI_DEVFN(0x14, 0),
+                       edu_devtab_off = edu_devfn * AMDVI_DEVTAB_ENTRY_SIZE;
+    const hwaddr edu_dma_test_buf = 0x1000, edu_dma_dev_buf = 0x40000;
+
+    if (!qtest_has_machine("q35")) {
+        g_test_skip("q35 machine not available");
+    }
+
+    if (!qtest_has_device("edu")) {
+        g_test_skip("edu device not available");
+    }
+
+    s = qtest_init("-M q35 -device amd-iommu,dma-remap=on,dma-translation=on,"
+                   "device-iotlb=on -device edu,addr=14.0,dma_mask=0xffffffff");
+    bus = qpci_new_pc(s, NULL);
+
+    test_dte_mode_0_iommu_setup(s);
+
+    /* get bar of EDU device */
+    edu = qpci_device_find(bus, edu_devfn);
+    g_assert_nonnull(edu);
+
+    edu_bar = qpci_iomap(edu, 0, NULL);
+    qpci_device_enable(edu);
+
+    g_test_message("testing DMA passthrough, IR = 1, IW = 1");
+    qtest_writeq(s, DEVTAB_ADDR + edu_devtab_off,
+                 AMDVI_DEV_PERM_READ | AMDVI_DEV_PERM_WRITE |
+                 AMDVI_DEV_TRANSLATION_VALID | AMDVI_DEV_VALID);
+    amdvi_invalidate_devtab_entry(s, edu_devfn);
+
+    g_test_message("testing read");
+    test_dte_mode_0_edu_dma(s, edu, edu_bar, edu_dma_test_buf, edu_dma_dev_buf,
+                            false, false);
+    g_test_message("testing write");
+    test_dte_mode_0_edu_dma(s, edu, edu_bar, edu_dma_dev_buf, edu_dma_test_buf,
+                            true, false);
+
+    g_test_message("testing DMA passthrough, IR = 1, IW = 0");
+    qtest_writeq(s, DEVTAB_ADDR + edu_devtab_off,
+                 AMDVI_DEV_PERM_READ |
+                 AMDVI_DEV_TRANSLATION_VALID | AMDVI_DEV_VALID);
+    amdvi_invalidate_devtab_entry(s, edu_devfn);
+
+    g_test_message("testing read");
+    test_dte_mode_0_edu_dma(s, edu, edu_bar, edu_dma_test_buf, edu_dma_dev_buf,
+                            false, false);
+    g_test_message("testing write");
+    test_dte_mode_0_edu_dma(s, edu, edu_bar, edu_dma_dev_buf, edu_dma_test_buf,
+                            true, true);
+
+    g_test_message("testing DMA passthrough, IR = 0, IW = 1");
+    qtest_writeq(s, DEVTAB_ADDR + edu_devtab_off,
+                 AMDVI_DEV_PERM_WRITE |
+                 AMDVI_DEV_TRANSLATION_VALID | AMDVI_DEV_VALID);
+    amdvi_invalidate_devtab_entry(s, edu_devfn);
+
+    g_test_message("testing read");
+    test_dte_mode_0_edu_dma(s, edu, edu_bar, edu_dma_test_buf, edu_dma_dev_buf,
+                            false, true);
+    g_test_message("testing write");
+    test_dte_mode_0_edu_dma(s, edu, edu_bar, edu_dma_dev_buf, edu_dma_test_buf,
+                            true, false);
+
+    /* make sure the nodma memory region is activated again properly */
+    g_test_message("testing DMA passthrough, IR = 1, IW = 1 (reset to nodma)");
+    qtest_writeq(s, DEVTAB_ADDR + edu_devtab_off,
+                 AMDVI_DEV_PERM_READ | AMDVI_DEV_PERM_WRITE |
+                 AMDVI_DEV_TRANSLATION_VALID | AMDVI_DEV_VALID);
+    amdvi_invalidate_devtab_entry(s, edu_devfn);
+
+    g_test_message("testing read");
+    test_dte_mode_0_edu_dma(s, edu, edu_bar, edu_dma_test_buf, edu_dma_dev_buf,
+                            false, false);
+    g_test_message("testing write");
+    test_dte_mode_0_edu_dma(s, edu, edu_bar, edu_dma_dev_buf, edu_dma_test_buf,
+                            true, false);
+
+    g_test_message("testing DMA passthrough, IR = 0, IW = 0");
+    qtest_writeq(s, DEVTAB_ADDR + edu_devtab_off,
+                 AMDVI_DEV_TRANSLATION_VALID | AMDVI_DEV_VALID);
+    amdvi_invalidate_devtab_entry(s, edu_devfn);
+
+    g_test_message("testing read");
+    test_dte_mode_0_edu_dma(s, edu, edu_bar, edu_dma_test_buf, edu_dma_dev_buf,
+                            false, true);
+    g_test_message("testing write");
+    test_dte_mode_0_edu_dma(s, edu, edu_bar, edu_dma_dev_buf, edu_dma_test_buf,
+                            true, true);
+
+    /* make sure that after reset, the device switches to nodma */
+    qtest_system_reset(s);
+    test_dte_mode_0_iommu_setup(s);
+
+    g_test_message("testing DMA after reset");
+    edu_bar = qpci_iomap(edu, 0, NULL);
+    qpci_device_enable(edu);
+
+    g_test_message("testing read");
+    test_dte_mode_0_edu_dma(s, edu, edu_bar, edu_dma_test_buf, edu_dma_dev_buf,
+                            false, false);
+    g_test_message("testing write");
+    test_dte_mode_0_edu_dma(s, edu, edu_bar, edu_dma_dev_buf, edu_dma_test_buf,
+                            true, false);
+
+    qtest_quit(s);
+}
+
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
     qtest_add_func("/q35/amd-iommu/cmdbuf-head-wrap", test_cmdbuf_head_wrap);
+    qtest_add_func("/q35/amd-iommu/dte-mode-0", test_dte_mode_0);
     return g_test_run();
 }
-- 
2.55.0


