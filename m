Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1A14C531C9
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 12:59:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnyRe-0001Aa-Jc; Sun, 26 Jul 2026 08:59:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flavien.solt97@gmail.com>)
 id 1wnxro-0001lM-1Z
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 08:22:05 -0400
Received: from mail-qv1-xf29.google.com ([2607:f8b0:4864:20::f29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flavien.solt97@gmail.com>)
 id 1wnxrm-0001gp-D2
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 08:22:03 -0400
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-8eeb4508f29so17006696d6.0
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 05:22:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785068521; cv=none;
 d=google.com; s=arc-20260327;
 b=pg9DZtgmJ25zk0YLwPKJ1mWPBfrvG69Pvll5FGWgFnN8P/Bq6ehirKC0JLKwmn/m0C
 LduX30zRnhR6/L0wjCj+kmD8NCHpQvNKqzEg+27PWDdrCE2G8Pu21EQy1c0oFl3lYh6e
 1pA2JNVoCnK0Z8f/oT5VF9qorOo/BsjgxV18OAofMRDHdpapEMiBFHZYAN0W4NF2X9Xb
 VSQ5kRAZuDAZWB4kWk4HMC07QDg44FZkSEM43dJV/xiC6JGxzkkUt3/VR2rV7kS+vmcP
 7p8H4S86r1xRiW6ZKonbIa//60LfMpPNhKXaZCEEDg431wIaZID7j/3LF0j1QiVgA4If
 6wOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:references:in-reply-to:from
 :mime-version:dkim-signature;
 bh=O/q3QYM6wLJ7zsYR/uxMX4LJeLZI0uTc1RVjYB4W/mw=;
 fh=QaT6lRC5y6lD/gWdSAGuafbdbUY/EiCC08Uj3KsmyVY=;
 b=fV2xf/CBTOcoHmeiURrLL4sssw7C5RIb/Qfy9411raSlnGiweIS9GT3tleQVI7T3f8
 7ZqGc+y6ts0cgGq++bt1PUC2emACkMvu8QPMr4owDax5NyuI99m2VKk1nj1F0NJTv2iX
 J2XtMewXDAn5cQxcuSuTG4u/6cSmwiCO628emIlJAIwi0Wxt7u0wAq9x+j+3l0YkJ7vU
 WXn1Kri1DsN7NrdWRRc6sQ6Sga8rRB6iMhtwozVNc00M1hVdXCWd80cmQ6PjDikUz0Vv
 NNR8iGVDBJ4tEGvOACAWmcgq1sBBbCTUlL1bLkVKPKg/NQwczZ/SvU67SoAnT34TfRlF
 DCMg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785068521; x=1785673321; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:references:in-reply-to
 :from:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=O/q3QYM6wLJ7zsYR/uxMX4LJeLZI0uTc1RVjYB4W/mw=;
 b=YGBrRh6p4LzyT5L4fqpdqL7eo/NVp0KO+MLoZ7J54DSXVhwfBN5gRxg8u+wsTnG2S0
 CXgT2m68+WMuR0PYKDxBmcGKwDJ6P06HH54iSK6lLwHW9MUfoXa8MeFvCaQwUpp3NS3H
 AFLKlWkqRchElISFfJSNHZHIA6tGgk96GKios9x342M7vqFYooW+S3WeyPGyk6fZIe2x
 Z5yN04BlAy5Zm/ipM1c7xnCGmAG8pl4XbIMEeRbkWBm4gr4YmHGwlxrd7e8epRglSHpg
 XVK4zxLNcVFKJGEc8oBzhTeVclLY96DBrIgWv031UGWyouBBDhmz2p4iysw5UwuY92fC
 sMeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785068521; x=1785673321;
 h=content-type:cc:to:subject:message-id:date:references:in-reply-to
 :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=O/q3QYM6wLJ7zsYR/uxMX4LJeLZI0uTc1RVjYB4W/mw=;
 b=qWJuNErwNHx1yL5isjlY1WSXF1d3hSKehcqZee8VXh7dUkah+QBT39UehA0TzoK+yZ
 0JlGSb5BR4BQfTfgK3hazPux0F/LVUQwN/vnMEISGlloRQBcm9sU/RC9pcTfgsPIxe/C
 9RVWU6XhiALrMxpv0Cr//U55THLZriq6qW8D/1mqHkjNGkv/kjXuEtLV11GelOZcUQ+z
 LwZUscvarZ/b7Lep0hCmbyGizdJdplwa4kEKTpaj5QfWWL1mh4sAdgEZ3poX2jxc85hO
 hChaJOvpNLYValwgXw3jFJtsdQAysnKJ3q+Hyw/O2O7FXbn3EQ6+U8O5NpgnbJsuVdZc
 lOhg==
X-Gm-Message-State: AOJu0YyrskB2hEluNP/XgYNKHqsO5R0daC7TxzAGc9DEj5lR9LEx6lJe
 neZ9hS9TkLn3+UV6jXx+TObis44J8F5mzolEYsKDKEnzFgGCx790arc/KIQrXsNfALiMH4/NPVy
 k9gvKX9ateVl6mBbhbDuXUeC4QX+8WtI7G/pY
X-Gm-Gg: AR+sD13y3855sgw7bC+W960OdZO/obsySk4crujL3WeGV2WpnofuVDWD6+VMXHEGyi2
 5CGZ6kfJgQDBrC92QU7kZ1rSwUm2IVfhf49WondaFUua6iVQtlqIEL3JYIaJxCkhkeEANs/PbeH
 69Kp5dYERC6bySDu6tMmgA7sHMjoE2wgEGW2JKboRoW8KXc0jNqKkpQIqbd5Dr3tXObDRhq9wdV
 k9OR0OHWmnsFhKl9smDZZSu8qAlKXD9/mv7+LBwW5Y/cpTbrlXEI0xrEbCFVxlKA+48p9b409Dq
 OnPmJYK3837y9FCtcw==
X-Received: by 2002:a05:6214:3d87:b0:904:86a4:cf76 with SMTP id
 6a1803df08f44-907ec803624mr65855786d6.40.1785068521291; Sun, 26 Jul 2026
 05:22:01 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Sun, 26 Jul 2026 05:22:01 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Sun, 26 Jul 2026 05:21:13 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Sun, 26 Jul 2026 05:20:10 -0700
MIME-Version: 1.0
From: flavien.solt97@gmail.com
In-Reply-To: <CANVUYGtOgMnNRkfU=zs=jvtg7yKOHXZVb8k5oVnp+D2=U4xeWA@mail.gmail.com>
References: <CANVUYGtOgMnNRkfU=zs=jvtg7yKOHXZVb8k5oVnp+D2=U4xeWA@mail.gmail.com>
Date: Sun, 26 Jul 2026 05:22:00 -0700
X-Gm-Features: AUfX_mwCyYiKC-PzaWEFXkDFxNJlPu3REtW6K-gokHIoj3j3BUwwJMUKlssel84
Message-ID: <CANVUYGs1Poa1i53Xwg=Us=UJejDbCmch2jGGmYw_Z0dE=Q-Utg@mail.gmail.com>
Subject: [PATCH v2 3/3] tests/qtest: add RISC-V IOMMU MRIF notice tests
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Andrew Jones <andrew.jones@oss.qualcomm.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::f29;
 envelope-from=flavien.solt97@gmail.com; helo=mail-qv1-xf29.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 26 Jul 2026 08:59:03 -0400
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

Exercise MRIF-mode MSI writes through iommu-testdev with the destination
interrupt-enable bit both clear and set. Each case requires the pending
bit to be stored plus the configured notice ID to reach guest memory.

The enable-clear case regresses the notice suppression fixed by the
previous patch. The enable-set case provides a control for the existing
path.

Signed-off-by: Flavien Solt <flavien.solt97@gmail.com>
---
 tests/qtest/iommu-riscv-test.c | 102 +++++++++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/tests/qtest/iommu-riscv-test.c b/tests/qtest/iommu-riscv-test.c
index 2638024..85f79ea 100644
--- a/tests/qtest/iommu-riscv-test.c
+++ b/tests/qtest/iommu-riscv-test.c
@@ -14,6 +14,7 @@
 #include "hw/pci/pci_regs.h"
 #include "hw/misc/iommu-testdev.h"
 #include "hw/riscv/riscv-iommu-bits.h"
+#include "libqos/qos-iommu-testdev.h"
 #include "libqos/qos-riscv-iommu.h"
 #include "libqos/riscv-iommu.h"

@@ -26,6 +27,13 @@
 #define RISCV_BUS_MMIO_LIMIT       0x80000000
 #define RISCV_ECAM_ALLOC_PTR       0x30000000

+#define RISCV_MRIF_MSI_IOVA        0x00000000fee00000ull
+#define RISCV_MRIF_MSI_PT_GPA      (QRIOMMU_SPACE_OFFS + 0x00030000ull)
+#define RISCV_MRIF_BASE_GPA        (QRIOMMU_SPACE_OFFS + 0x00031000ull)
+#define RISCV_MRIF_NOTICE_GPA      (QRIOMMU_SPACE_OFFS + 0x00032000ull)
+#define RISCV_MRIF_INTID           5u
+#define RISCV_MRIF_NOTICE_ID       0x12du
+
 typedef struct RiscvIommuTestState {
     QTestState *qts;
     QGenericPCIBus gbus;
@@ -264,6 +272,96 @@ static void test_riscv_iommu_nested(void)
     run_riscv_iommu_translation(&cfg);
 }

+static void riscv_iommu_setup_mrif_context(RiscvIommuTestState *state)
+{
+    uint64_t dc_addr;
+    uint64_t msiptp;
+    uint64_t pte0;
+    uint64_t pte1;
+
+    qtest_memset(state->qts, QRIOMMU_SPACE_OFFS + QRIOMMU_DDT_BASE, 0,
+                 0x1000);
+    qtest_memset(state->qts, RISCV_MRIF_MSI_PT_GPA, 0, 0x1000);
+    qtest_memset(state->qts, RISCV_MRIF_BASE_GPA, 0, 0x1000);
+    qtest_memset(state->qts, RISCV_MRIF_NOTICE_GPA, 0, 4);
+
+    dc_addr = QRIOMMU_SPACE_OFFS + QRIOMMU_DDT_BASE +
+              state->testdev->devfn * sizeof(struct riscv_iommu_dc);
+
+    msiptp = (RISCV_MRIF_MSI_PT_GPA >> 12) |
+             ((uint64_t)RISCV_IOMMU_DC_MSIPTP_MODE_FLAT << 60);
+
+    qtest_writeq(state->qts, dc_addr + 0, RISCV_IOMMU_DC_TC_V);
+    qtest_writeq(state->qts, dc_addr + 8, 0);
+    qtest_writeq(state->qts, dc_addr + 16, 0);
+    qtest_writeq(state->qts, dc_addr + 24, 0);
+    qtest_writeq(state->qts, dc_addr + 32, msiptp);
+    qtest_writeq(state->qts, dc_addr + 40, 0);
+    qtest_writeq(state->qts, dc_addr + 48, RISCV_MRIF_MSI_IOVA >> 12);
+    qtest_writeq(state->qts, dc_addr + 56, 0);
+
+    pte0 = RISCV_IOMMU_MSI_PTE_V |
+           ((uint64_t)RISCV_IOMMU_MSI_PTE_M_MRIF << 1) |
+           ((RISCV_MRIF_BASE_GPA >> 9) << 7);
+    pte1 = ((RISCV_MRIF_NOTICE_GPA >> 12) << 10) | RISCV_MRIF_NOTICE_ID;
+
+    qtest_writeq(state->qts, RISCV_MRIF_MSI_PT_GPA, pte0);
+    qtest_writeq(state->qts, RISCV_MRIF_MSI_PT_GPA + 8, pte1);
+
+    qriommu_program_regs(state->qts, state->iommu_base);
+}
+
+static void run_riscv_iommu_mrif_notice(bool enable_bit)
+{
+    RiscvIommuTestState state = { 0 };
+    uint64_t pending;
+    uint64_t enabled;
+    uint32_t notice;
+    uint32_t dma_result;
+
+    if (!riscv_iommu_test_setup(&state)) {
+        return;
+    }
+
+    riscv_iommu_check(state.qts, state.iommu_base, QRIOMMU_TM_BARE);
+    riscv_iommu_setup_mrif_context(&state);
+
+    enabled = enable_bit ? (1ull << RISCV_MRIF_INTID) : 0;
+    qtest_writeq(state.qts, RISCV_MRIF_BASE_GPA + 8, enabled);
+    qpci_io_writel(state.testdev, state.testdev_bar, ITD_REG_DMA_WRITE_VAL,
+                   RISCV_MRIF_INTID);
+
+    dma_result = qos_iommu_testdev_trigger_dma(
+        state.testdev, state.testdev_bar, RISCV_MRIF_MSI_IOVA,
+        RISCV_MRIF_NOTICE_GPA, DMA_LEN, qriommu_build_dma_attrs());
+
+    pending = qtest_readq(state.qts, RISCV_MRIF_BASE_GPA);
+    notice = qtest_readl(state.qts, RISCV_MRIF_NOTICE_GPA);
+
+    g_test_message("MRIF notice: enable=%u pending=0x%" PRIx64
+                   " notice=0x%x", enable_bit, pending, notice);
+
+    /*
+     * Interrupt remapping consumes the original DMA write; the generic
+     * test device cannot read it back from the supplied physical address.
+     */
+    g_assert_cmpuint(dma_result, ==, ITD_DMA_ERR_MISMATCH);
+    g_assert_cmpuint(pending & (1ull << RISCV_MRIF_INTID), !=, 0);
+    g_assert_cmpuint(notice, ==, RISCV_MRIF_NOTICE_ID);
+
+    riscv_iommu_test_teardown(&state);
+}
+
+static void test_riscv_iommu_mrif_notice_enable_clear(void)
+{
+    run_riscv_iommu_mrif_notice(false);
+}
+
+static void test_riscv_iommu_mrif_notice_enable_set(void)
+{
+    run_riscv_iommu_mrif_notice(true);
+}
+
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
@@ -275,5 +373,9 @@ int main(int argc, char **argv)
                    test_riscv_iommu_g_stage_only);
     qtest_add_func("/iommu-testdev/translation/ns-nested",
                    test_riscv_iommu_nested);
+    qtest_add_func("/iommu-testdev/mrif-notice/enable-clear",
+                   test_riscv_iommu_mrif_notice_enable_clear);
+    qtest_add_func("/iommu-testdev/mrif-notice/enable-set",
+                   test_riscv_iommu_mrif_notice_enable_set);
     return g_test_run();
 }
-- 
2.54.0

