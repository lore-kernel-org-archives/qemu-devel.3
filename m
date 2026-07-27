Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EA75C531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 07:24:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woFgn-00004z-9y; Mon, 27 Jul 2026 03:23:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flavien.solt97@gmail.com>)
 id 1woFgR-0008RW-6q
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 03:23:32 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flavien.solt97@gmail.com>)
 id 1woFgO-0005rD-Gv
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 03:23:30 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-caf45fc5202so1798801a12.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 00:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785137007; x=1785741807; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Y6AE8y3sPjdOE+C6H8egNUMmPUkv1NYbHv8T3x0P4+U=;
 b=Pnw7lSuF+FoV6AkSXW/tXQPMHBzaVLVaZuNunx8CddS858LYj4GGwsIqdo9Wle05J6
 NK7teNXYJCTRYepEHUZNhmlBesPICEHxsLFvLT24Vf2JcxYsukFmtt89q54e+91Oo20S
 Q2wIE3Ufx0T3ma9NPyiB/fRY+QK22h62yjEKY9zIeGX6rwlCo4n6snqRBAtRQK+G/IU2
 SEmg5PnFMqMXKhhpJPY2h0kRk8SjZXsQpyHvfTerlbp5igz2zfVgy/BhJN6WTgxd2HxM
 TcZgn0ihW+5NFw6XxpAtsPCWtDaFDcMi4FTmLUzeROxFSle3jXjA2XDBoqYm6RaUGGwc
 XnyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785137007; x=1785741807;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Y6AE8y3sPjdOE+C6H8egNUMmPUkv1NYbHv8T3x0P4+U=;
 b=Iv8adL5LtBUExEyEFKoD73PCRSLZ0sN3YXmNf0qaQC3LAUgoo2nQzeOdGybAAXGy5E
 unsTumYZHMizA7mseeLrGisIXHTJBd2Eqb2c0cHTlb989OYn9sos+2BalPp7JltwJDYh
 MZs04mgm2F0EvNmwFZMyHieLFAzwJ/BQeQ/0DiZv1YibQsSD22PYtK0SND+8taX5YMxb
 VcQ4uU2FtRq5MkZx4Fu+uOEiniRQLuibWuhPggJXGtIJM8IiSOgjyWiyp+4SswIgubP9
 E+6hZqI9w61t3/Xpy3IiMgV50Fc8V8Ip+s1SLwIqAubdyOQuBfEXIfpD+FloKESIUf24
 uqvQ==
X-Gm-Message-State: AOJu0YzxuM69JYtWcotHHB+a5nqcLaE6PflNB1QVfEZqOXRGmmkZfBhn
 GtY879hIvTunI+i4pR9Ley5IOknX3yE5LVloAnX9jv+5kewj3jW0Rl7w
X-Gm-Gg: AR+sD11fF1q5zuU7MfVsz4R/csUf9J4rsZ56T4ID5G50xdic9d13lP+NrjBnmHLB4YC
 HzFfy/bpuBuCA1tsyzafRTOJ/biO87WsJUDCcNogt7IqUw0vcebi/kOgOKvc+mqninsHx6jPTHG
 FHNsCXiIdsEVLZbcMhsJYgRztutn9lCyoA70bxocyqNHAfBY58/lusP91xxPiZ2+VBzVY5uz2FQ
 +YRkWndXYlMrOSBsdKvS3rYjP43Fmey3SMsGu0+jpdyW/EsD3nNSL7NYm8C6n8RjCIE3bisMjwP
 kAGI7TDNU6yUovUB0eQbHbQBpysiEuGbefKJhuMncObnAjp2UBEr2cvb5j8E2qiDpxkmnVx1lbw
 q8IY+LdSNN6QNokuFHNePikdcoORib5E2r92QNexNK6iQJhu49lS6jVdg0iMUU9v7vet2Ko97Tq
 qYkMOqvUYQFvwxt+CmQALQbmjf0ttVLWIfaPn/m+qY9R0zoAXo7JBrAFxGSVLBUxJRyx9Eyfy+y
 mHi/u2asjUTMG3lt4glI4KFVA==
X-Received: by 2002:a05:6a21:d8a:b0:3b4:9171:2573 with SMTP id
 adf61e73a8af0-3c67df206cbmr7646964637.37.1785137007033; 
 Mon, 27 Jul 2026 00:23:27 -0700 (PDT)
Received: from flavien-macm3.ddns.comp.nus.edu.sg ([137.132.220.135])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc419c52sm28481032eec.10.2026.07.27.00.23.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 00:23:26 -0700 (PDT)
From: Flavien Solt <flavien.solt97@gmail.com>
Date: Mon, 27 Jul 2026 15:22:59 +0800
Subject: [PATCH v4 3/3] tests/qtest: add RISC-V IOMMU MRIF notice tests
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-qemu-mrif-v4-v4-3-73e0890ad395@gmail.com>
References: <20260727-qemu-mrif-v4-v4-0-73e0890ad395@gmail.com>
In-Reply-To: <20260727-qemu-mrif-v4-v4-0-73e0890ad395@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Andrew Jones <andrew.jones@oss.qualcomm.com>, 
 Tao Tang <tangtao1634@phytium.com.cn>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Nutty Liu <nutty.liu@hotmail.com>, Flavien Solt <flavien.solt97@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785136991; l=5610;
 i=flavien.solt97@gmail.com; s=qemu-mrif-v4-gmail; h=from:subject:message-id;
 bh=4t7hBi12kQx0si3QEEq84Twv7XWE8/6T8sOjpFerZr0=;
 b=wzoZ0OFvX/7Vog8nEJRorFelzPdlMMrBL/w2dJX6yd+snee10vYgveoeDDoZyFnddoEx9irc8
 vRRmXyb7ZXFCskMCjL4+W5pry8Jf4PNOA2KuenvUxX+1UdCfwXlTXW0
X-Developer-Key: i=flavien.solt97@gmail.com; a=ed25519;
 pk=wEVvqF5SMWVnTyKNb8WAo78S30Q6giJmU/VisghJRtI=
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=flavien.solt97@gmail.com; helo=mail-pg1-x536.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Exercise MRIF-mode MSI writes through iommu-testdev with the destination
interrupt-enable bit both clear and set. Each case requires the pending
bit to be stored plus the configured notice ID to reach guest memory.

The enable-clear case regresses the notice suppression fixed by the
previous patch. The enable-set case provides a control for the existing
path.

Signed-off-by: Flavien Solt <flavien.solt97@gmail.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>
---
 tests/qtest/iommu-riscv-test.c | 102 +++++++++++++++++++++++++++++++++++++++++
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


