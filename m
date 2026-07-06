Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A7DEC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:45:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgs3v-0002IE-Ne; Mon, 06 Jul 2026 18:45:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wgs3u-0002GB-RN; Mon, 06 Jul 2026 18:45:14 -0400
Received: from fout-b2-smtp.messagingengine.com ([202.12.124.145])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wgs3s-0001IR-BT; Mon, 06 Jul 2026 18:45:14 -0400
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.stl.internal (Postfix) with ESMTP id 037C31D001A0;
 Mon,  6 Jul 2026 18:45:10 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Mon, 06 Jul 2026 18:45:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1783377910; x=
 1783464310; bh=dkwpCF19oN1zTVemqGjoa4hHaHi7pYuc15wMZDftZss=; b=n
 8ZUaubnnfJEpGxHejFNtgjzzoBT21zd/yPFBKDdlMScFQU9e3yhnBFqmvoL0kdgc
 6E+dLOA29CguSZxnOX7W8P04KiLvgWYtwFzpR62KeLV+JtDob+1WeupPcz61z+He
 hCyic2iR5NiEi1howqUtgVx9I/46aGOgX5X3PgMs0fQYg1xiGJymlZaNbqTd9wFh
 8QT2UOXJec8HclBo/j26k5q0Q5WfUa3NsGK8lP96dW4uBbiXzaO7i+lTpf4hTXT+
 VaJ+67p3ZOai2Q/OHeR3e+4EIJ+ProCTGdwaHAJ9kf0xwpmF7B+S2hQ5J7rHr+ka
 8U0GwOHykzLiJMxRIS3Kg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1783377910; x=1783464310; bh=d
 kwpCF19oN1zTVemqGjoa4hHaHi7pYuc15wMZDftZss=; b=EKQhzVFxeIwfA+miJ
 K8w6ObT12EZ8eerFOOuzxpsspcqnjtuaIzsvHmhCEVjtSu8cml3rdvqk15cm+cUV
 hQ5RJjkg2IQ5o/nb2L7ec1WC4HbHWzY+UdESoyV2jTWt6zyJ5b6Hx8u5e/uBi4Tp
 ByWzWV7ggmu2Fz/m4SZV9xLOXnpxKzX9YcLA58XiQYZdZfEP2o1fHqHqN2LPLhRq
 QlkMTKGjYp1WbjkvNATmsukzy6wsQKSqBHdihfhVfW7tQjuL3KqjG2KlK6DMFo7M
 EEL0HzVzS6/d7Cwx89T3k7KZnZHnDoSTeMybPC9SHuWAFl/kEw+cjR80/vkNeLkz
 dAj6w==
X-ME-Sender: <xms:9i9MaqqfBtf5GTyUSiEwOJYFVOZgO33zILHyuiM2t9di7TOvfXs7IQ>
 <xme:9i9MakiK4RTqiAXO4QZGIqxGACjdhO9NegsJ-IUO2SMM1ssrvHpP9VN9CIv6A7XXz
 _06hVD4FkTZYb3wI54yXIlz2_ez4lzKC5cw3227EMNfUzEKT8BzOOA>
X-ME-Received: <xmr:9i9MasOrb0BHRp34S5vqDHw5PU0ZkIHw_f_zkNz2R6jnvThdxw_HPLu162LsB5proWesDqnf5U4tf8KMvivbo-ouf2r8Rr0SUa9TzIZbIjnBB6ICs2-C2ldVAw>
X-ME-Proxy-Cause: dmFkZTET5nCFT/MuVvE4xAefAzoQyvBHR+RkHY9ixFObea2t0bJM1174F9XqtsnVozRuyR
 EWxsKAqJK84tStfgTS5bGvHVkH/oh3XdJEnmZ56oHn7QWgM37UKpg+9zZ153tudqGfKeg6
 wN1YwB/QsoP9U8TXcYjJRg3HcQCsv5s/2GBHLYvMj9kvs0pP96jQj1braT3PWbJBSkcJqo
 nmTEwFzT16ZvkfnECKe+AKNhsekQuE0DS1+zLQkhBWmmM4oTRiAdjt37S4aq6K0PqyREkf
 ojAVDd+PI7ULxjBfmMqPAGVcBfF2fj0mBU+h/YCRWwQbOcAayGdy0fOLhMAJ8NJN1ZTeTW
 fJe7GnTlNWaaHYghyAKKITk0613wl8sPHHIVK/hvXbjWn6aH/f4/oU7CCscIYPBqT6658K
 w3n4ShvQoj8Z7U1uQ4dqAso+Dl0SyLR069cNWI4UUkFmM1+eq1jyQWykbsl9iKPcWatiI9
 iShMnAhW5CB+zXlXXqEFLFAL1PR96ynu+DFVcajnp+g39MWYDzbQ6F/4OkDH7EFTqVIMW1
 /zDBfDUwSx0AMWS9VuSWCeSAk5kx0PfcnpeyWj+MwJK5A8U7JTtrpY9RnAu6JrNmwwOxYr
 JVG1nYND7Nc1wJllWvvke9jyMRXGXPLeANSXuWZ83Z8UXttkb4YUuTyLfs0w
X-ME-Proxy: <xmx:9i9Mauy-0vLMHpXlSpTxSiXRL5Ed6Rg3q-quPm4qV5kQLRo5TCEXKw>
 <xmx:9i9MauqLJC0nNqJHkM-S8IfORQGHOnDn91VvzGMe4O4VzhIa6TjaGg>
 <xmx:9i9MauMLqijrKjlUkNiY4IbLGj-6o-XavTfFCGrsLKle1Gn8G4Q6AA>
 <xmx:9i9MaieY4yxXp0UR2Or0nf-COdvEGLvQ_jZzrchJhs0m5a5JRNnNQw>
 <xmx:9i9MaigfuPuB_71Gj6hMDRjKmdLjaM8-k61kdtwhia6a_uUVr2ffdW_3>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 18:45:09 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Klaus Jensen <k.jensen@samsung.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org
Subject: [PULL 10/11] tests/qtest/nvme-test: add migration test with full CQ
Date: Tue,  7 Jul 2026 00:44:22 +0200
Message-ID: <20260706224426.14156-11-its@irrelevant.dk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706224426.14156-1-its@irrelevant.dk>
References: <20260706224426.14156-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.145; envelope-from=its@irrelevant.dk;
 helo=fout-b2-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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

From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

As suggested by Stefan [1], let's add a migration test to cover
rare scenario when CQ is full of non-processed CQEs and migration
happens.

To run this test:
$ meson test -C build 'qtest-x86_64/qos-test'

Link: https://lore.kernel.org/qemu-devel/20260408183529.GB319710@fedora/ [1]
Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Acked-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 tests/qtest/nvme-test.c | 419 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 419 insertions(+)

diff --git a/tests/qtest/nvme-test.c b/tests/qtest/nvme-test.c
index 4aec1651e6e2..f9395cc252b2 100644
--- a/tests/qtest/nvme-test.c
+++ b/tests/qtest/nvme-test.c
@@ -8,9 +8,12 @@
  */
 
 #include "qemu/osdep.h"
+#include <glib/gstdio.h>
+#include "qemu/bswap.h"
 #include "qemu/module.h"
 #include "qemu/units.h"
 #include "libqtest.h"
+#include "libqtest-single.h"
 #include "libqos/qgraph.h"
 #include "libqos/pci.h"
 #include "block/nvme.h"
@@ -142,6 +145,420 @@ static void nvmetest_pmr_reg_test(void *obj, void *data, QGuestAllocator *alloc)
     qpci_iounmap(pdev, pmr_bar);
 }
 
+typedef struct nvme_ctrl nvme_ctrl;
+
+typedef struct nvme_queue {
+    nvme_ctrl *ctrl;
+    uint64_t doorbell;
+    uint32_t size;
+} nvme_queue;
+
+typedef struct nvme_cq {
+    nvme_queue common;
+    uint64_t phys_cqe; /* NvmeCqe* */
+    uint16_t head;
+    uint8_t phase;
+} nvme_cq;
+
+typedef struct nvme_sq {
+    nvme_queue common;
+    uint64_t phys_sqe; /* NvmeCmd* */
+    nvme_cq *cq;
+    uint16_t head;
+    uint16_t tail;
+} nvme_sq;
+
+struct nvme_ctrl {
+    QGuestAllocator *alloc;
+    QPCIDevice *pdev;
+    QPCIBar bar;
+
+    uint32_t db_stride;
+
+    nvme_sq admin_sq;
+    nvme_cq admin_cq;
+};
+
+#define PHYS_ADDR_OF_FIELD(T, base_phys_addr, field) \
+    ((uint64_t)&((T *)(base_phys_addr))->field)
+
+#define PHYS_ADDR_OF(T, base_phys_addr, accessor) \
+    ((uint64_t)&((T *)(base_phys_addr))accessor)
+
+static void nvme_init_queue_common(nvme_ctrl *ctrl, nvme_queue *q,
+                                   uint16_t db_idx, uint32_t size)
+{
+    q->ctrl = ctrl;
+    q->doorbell = (sizeof(NvmeBar) + db_idx * ctrl->db_stride);
+    g_test_message(" q %p db_idx %u doorbell 0x%" PRIx64, q, db_idx, q->doorbell);
+    q->size = size;
+}
+
+static void nvme_init_sq(nvme_ctrl *ctrl, nvme_sq *sq, uint16_t db_idx,
+                         uint32_t size, nvme_cq *cq)
+{
+    nvme_init_queue_common(ctrl, &sq->common, db_idx, size);
+
+    sq->phys_sqe = guest_alloc(ctrl->alloc, sizeof(NvmeCmd) * size);
+    g_assert(sq->phys_sqe);
+
+    g_test_message("sq %p db_idx %u sqe 0x%" PRIx64, sq, db_idx, sq->phys_sqe);
+    sq->cq = cq;
+    sq->head = 0;
+    sq->tail = 0;
+}
+
+static void nvme_init_cq(nvme_ctrl *ctrl, nvme_cq *cq, uint16_t db_idx,
+                         uint32_t size)
+{
+    nvme_init_queue_common(ctrl, &cq->common, db_idx, size);
+
+    cq->phys_cqe = guest_alloc(ctrl->alloc, sizeof(NvmeCqe) * size);
+    g_assert(cq->phys_cqe);
+
+    g_test_message("cq %p db_idx %u cqe 0x%" PRIx64, cq, db_idx, cq->phys_cqe);
+    cq->head = 0;
+    cq->phase = 1;
+}
+
+static int nvme_cqe_pending(nvme_cq *cq)
+{
+    uint16_t status = qtest_readw(
+        cq->common.ctrl->pdev->bus->qts,
+        PHYS_ADDR_OF(NvmeCqe, cq->phys_cqe, [cq->head].status));
+    return (status & 1) == cq->phase;
+}
+
+static int nvme_is_cqe_success(NvmeCqe *cqe)
+{
+    return (le16_to_cpu(cqe->status) >> 1) == NVME_SUCCESS;
+}
+
+static NvmeCqe nvme_handle_cqe(nvme_sq *sq)
+{
+    nvme_cq *cq = sq->cq;
+    uint64_t phys_cqe = PHYS_ADDR_OF(
+                            NvmeCqe, cq->phys_cqe, [cq->head]); /* NvmeCqe* */
+    NvmeCqe cqe;
+    uint16_t cq_next_head;
+
+    g_assert(nvme_cqe_pending(cq));
+
+    qtest_memread(sq->common.ctrl->pdev->bus->qts, phys_cqe, &cqe, sizeof(cqe));
+
+    cq_next_head = (cq->head + 1) % cq->common.size;
+    g_test_message("cq %p head %u -> %u", cq, cq->head, cq_next_head);
+    if (cq_next_head < cq->head) {
+        cq->phase ^= 1;
+    }
+    cq->head = cq_next_head;
+
+    if (cqe.sq_head != sq->head) {
+        sq->head = cqe.sq_head;
+        g_test_message("sq %p head = %u", sq, sq->head);
+    }
+
+    qpci_io_writel(cq->common.ctrl->pdev, cq->common.ctrl->bar,
+                   cq->common.doorbell, cq->head);
+
+    return cqe;
+}
+
+static NvmeCqe nvme_wait(nvme_sq *sq)
+{
+    int i;
+    bool ready = false;
+
+    for (i = 0; i < 10; i++) {
+        if (nvme_cqe_pending(sq->cq)) {
+            ready = true;
+            break;
+        }
+
+        g_usleep(1000);
+    }
+
+    g_assert(ready);
+
+    return nvme_handle_cqe(sq);
+}
+
+static uint64_t nvme_get_next_sqe(nvme_sq *sq, uint8_t opcode,
+                                  uint16_t cid, uint64_t prp1)
+{
+    uint64_t phys_sqe = PHYS_ADDR_OF(NvmeCmd, sq->phys_sqe, [sq->tail]);
+
+    if (((sq->tail + 1) % sq->common.size) == sq->head) {
+        /* no space in SQ */
+        g_test_message("%s head %d tail %d", __func__, sq->head, sq->tail);
+        g_assert_not_reached();
+        return 0;
+    }
+
+    qtest_memset(sq->common.ctrl->pdev->bus->qts,
+                 phys_sqe, 0, sizeof(NvmeCmd));
+
+    #define GUEST_MEM_WRITE(fn, phys_addr, val) \
+        fn(sq->common.ctrl->pdev->bus->qts, phys_addr, (val))
+
+    GUEST_MEM_WRITE(qtest_writeb,
+                    PHYS_ADDR_OF_FIELD(NvmeCmd, phys_sqe, opcode), opcode);
+    GUEST_MEM_WRITE(qtest_writew,
+                    PHYS_ADDR_OF_FIELD(NvmeCmd, phys_sqe, cid), cid);
+    GUEST_MEM_WRITE(qtest_writeq,
+                    PHYS_ADDR_OF_FIELD(NvmeCmd, phys_sqe, dptr.prp1), prp1);
+
+    #undef GUEST_MEM_WRITE
+
+    g_test_message("sq %p next_sqe %u sqe 0x%" PRIx64, sq, sq->tail, phys_sqe);
+    return phys_sqe;
+}
+
+static void nvme_commit_sqe(nvme_sq *sq)
+{
+    g_test_message("sq %p commit sqe tail %u", sq, sq->tail);
+    sq->tail = (sq->tail + 1) % sq->common.size;
+    qpci_io_writel(sq->common.ctrl->pdev, sq->common.ctrl->bar,
+                   sq->common.doorbell, sq->tail);
+}
+
+static uint64_t nvme_admin_identify_ctrl(nvme_ctrl *ctrl,
+                                         uint16_t cid, bool no_wait)
+{
+    uint64_t phys_cmd_identify; /* NvmeCmd* */
+    uint64_t phys_identify; /* NvmeIdCtrl* */
+    NvmeCqe cqe;
+
+    g_test_message("sending req cid %u no_wait %d", cid, no_wait);
+
+    phys_identify = guest_alloc(ctrl->alloc, sizeof(NvmeIdCtrl));
+    g_assert(phys_identify);
+
+    phys_cmd_identify = nvme_get_next_sqe(&ctrl->admin_sq,
+                                          NVME_ADM_CMD_IDENTIFY, cid,
+                                          phys_identify);
+    g_assert(phys_cmd_identify);
+
+    #define GUEST_MEM_WRITE(fn, phys_addr, val) \
+        fn(ctrl->pdev->bus->qts, phys_addr, (val))
+
+    GUEST_MEM_WRITE(qtest_writel,
+                    PHYS_ADDR_OF_FIELD(NvmeCmd, phys_cmd_identify, nsid), 0);
+    GUEST_MEM_WRITE(qtest_writel,
+                    PHYS_ADDR_OF_FIELD(NvmeIdentify, phys_cmd_identify, cns),
+                    NVME_ID_CNS_CTRL);
+
+    #undef GUEST_MEM_WRITE
+
+    nvme_commit_sqe(&ctrl->admin_sq);
+
+    if (no_wait) {
+        return phys_identify;
+    }
+
+    cqe = nvme_wait(&ctrl->admin_sq);
+    g_assert(nvme_is_cqe_success(&cqe));
+    g_assert(le16_to_cpu(cqe.cid) == cid);
+
+    return phys_identify;
+}
+
+static void nvme_wait_ready(nvme_ctrl *ctrl, int val)
+{
+    int i;
+
+    for (i = 0; i < 10; i++) {
+        uint32_t csts = qpci_io_readl(ctrl->pdev, ctrl->bar, NVME_REG_CSTS);
+        g_test_message("%s: csts %x", __func__, csts);
+
+        if (NVME_CSTS_RDY(csts) == val) {
+            return;
+        }
+
+        g_usleep(1000);
+    }
+
+    g_assert_not_reached();
+}
+
+static void test_migrate_setup_nvme_ctrl(nvme_ctrl *ctrl)
+{
+    uint64_t cap;
+
+    /* disable controller */
+    qpci_io_writel(ctrl->pdev, ctrl->bar, NVME_REG_CC, 0);
+    nvme_wait_ready(ctrl, 0);
+
+    cap = qpci_io_readq(ctrl->pdev, ctrl->bar, NVME_REG_CAP);
+    ctrl->db_stride = 4 << NVME_CAP_DSTRD(cap);
+
+    nvme_init_cq(ctrl, &ctrl->admin_cq, 1, 2 /* CQEs num */);
+    nvme_init_sq(ctrl, &ctrl->admin_sq, 0, 4 /* SQEs num */, &ctrl->admin_cq);
+
+    qpci_io_writel(ctrl->pdev, ctrl->bar, NVME_REG_AQA,
+        ((ctrl->admin_cq.common.size - 1) << AQA_ACQS_SHIFT) |
+        ((ctrl->admin_sq.common.size - 1) << AQA_ASQS_SHIFT)
+    );
+
+    qpci_io_writeq(ctrl->pdev, ctrl->bar,
+                   NVME_REG_ASQ, (uint64_t)ctrl->admin_sq.phys_sqe);
+    qpci_io_writeq(ctrl->pdev, ctrl->bar,
+                   NVME_REG_ACQ, (uint64_t)ctrl->admin_cq.phys_cqe);
+
+    /* enable controller */
+    {
+        uint32_t cc = 0;
+        NVME_SET_CC_EN(cc, 1);
+        qpci_io_writel(ctrl->pdev, ctrl->bar, NVME_REG_CC, cc);
+    }
+
+    nvme_wait_ready(ctrl, 1);
+}
+
+typedef struct test_migrate_req {
+    uint16_t cid;
+    bool handle_cqe;
+    uint64_t phys_identify; /* NvmeIdCtrl* */
+} test_migrate_req;
+
+static void test_migrate_send_nvme_reqs(nvme_ctrl *ctrl, test_migrate_req *reqs,
+                                        int num)
+{
+    int i;
+
+    for (i = 0; i < num; i++) {
+        reqs[i].phys_identify = nvme_admin_identify_ctrl(ctrl, reqs[i].cid,
+                                                         !reqs[i].handle_cqe);
+        g_assert(reqs[i].phys_identify);
+
+        if (reqs[i].handle_cqe) {
+            guest_free(ctrl->alloc, reqs[i].phys_identify);
+        }
+    }
+}
+
+static void test_migrate_check_nvme(nvme_ctrl *ctrl,
+                                    test_migrate_req *reqs, int num)
+{
+    int i;
+
+    for (i = 0; i < num; i++) {
+        NvmeCqe cqe;
+
+        if (reqs[i].handle_cqe) {
+            continue;
+        }
+
+        cqe = nvme_wait(&ctrl->admin_sq);
+        g_assert(nvme_is_cqe_success(&cqe));
+
+        g_assert_cmpint(le16_to_cpu(cqe.cid), ==, reqs[i].cid);
+
+        #define GUEST_MEM_READB(phys_addr) \
+                    qtest_readb(ctrl->pdev->bus->qts, (phys_addr))
+
+        g_assert_cmpint(GUEST_MEM_READB(
+            PHYS_ADDR_OF_FIELD(NvmeIdCtrl, reqs[i].phys_identify, ieee[0])),
+            ==, 0x0);
+        g_assert_cmpint(GUEST_MEM_READB(
+            PHYS_ADDR_OF_FIELD(NvmeIdCtrl, reqs[i].phys_identify, ieee[1])),
+            ==, 0x54);
+        g_assert_cmpint(GUEST_MEM_READB(
+            PHYS_ADDR_OF_FIELD(NvmeIdCtrl, reqs[i].phys_identify, ieee[2])),
+            ==, 0x52);
+
+        #undef GUEST_MEM_READB
+
+        guest_free(ctrl->alloc, reqs[i].phys_identify);
+    }
+}
+
+static void test_migrate(void *obj, void *data, QGuestAllocator *alloc)
+{
+    g_autofree gchar *tmpfs = NULL;
+    GError *err = NULL;
+    g_autofree gchar *mig_path = NULL;
+    g_autofree gchar *uri = NULL;
+    GString *dest_cmdline;
+    QTestState *to;
+    QDict *rsp;
+    QNvme *nvme = obj;
+    QPCIDevice *pdev = &nvme->dev;
+    g_autofree nvme_ctrl *ctrl = NULL;
+    test_migrate_req test_reqs[] = {
+        { 123, true },
+        { 456, false },
+        { 300, false },
+        { 333, false }
+    };
+
+    if (qpci_check_buggy_msi(pdev)) {
+        return;
+    }
+
+    /* create temporary dir and prepare unix socket path for migration */
+    tmpfs = g_dir_make_tmp("nvme-test-XXXXXX", &err);
+    if (!tmpfs) {
+        g_test_message("Can't create temporary directory in %s: %s",
+                       g_get_tmp_dir(), err->message);
+        g_error_free(err);
+    }
+    g_assert(tmpfs);
+
+    mig_path = g_strdup_printf("%s/socket.mig", tmpfs);
+    uri = g_strdup_printf("unix:%s", mig_path);
+
+    /* enable NVMe PCI device */
+    qpci_device_enable(pdev);
+
+    ctrl = g_malloc0(sizeof(*ctrl));
+    ctrl->alloc = alloc;
+    ctrl->pdev = pdev;
+    ctrl->bar = qpci_iomap(ctrl->pdev, 0, NULL);
+    g_assert(pdev->bus->qts == global_qtest);
+
+    test_migrate_setup_nvme_ctrl(ctrl);
+    test_migrate_send_nvme_reqs(ctrl, test_reqs, ARRAY_SIZE(test_reqs));
+
+    qpci_iounmap(ctrl->pdev, ctrl->bar);
+
+    dest_cmdline = g_string_new(qos_get_current_command_line());
+    g_string_append_printf(dest_cmdline, " -incoming %s", uri);
+
+    /* Create destination VM */
+    to = qtest_init(dest_cmdline->str);
+
+    /* Get access to PCI device from destination VM */
+    nvme = qos_allocate_objects(to, &ctrl->alloc);
+    pdev = &nvme->dev;
+    ctrl->pdev = pdev;
+    ctrl->bar = qpci_iomap(ctrl->pdev, 0, NULL);
+    g_assert(pdev->bus->qts == to);
+
+    /* Migrate VM */
+    rsp = qmp("{ 'execute': 'migrate', 'arguments': { 'uri': %s } }", uri);
+    g_assert(qdict_haskey(rsp, "return"));
+    qobject_unref(rsp);
+
+    /* Wait when source VM is stopped */
+    qmp_eventwait("STOP");
+
+    /* Copy guest physical memory allocator state */
+    migrate_allocator(alloc, ctrl->alloc);
+
+    /* Wait for destination VM to become alive */
+    qtest_qmp_eventwait(to, "RESUME");
+
+    test_migrate_check_nvme(ctrl, test_reqs, ARRAY_SIZE(test_reqs));
+
+    qpci_iounmap(ctrl->pdev, ctrl->bar);
+
+    qtest_quit(to);
+    g_unlink(mig_path);
+    g_rmdir(tmpfs);
+    g_string_free(dest_cmdline, true);
+}
+
 static void nvme_register_nodes(void)
 {
     QOSGraphEdgeOptions opts = {
@@ -168,6 +585,8 @@ static void nvme_register_nodes(void)
     });
 
     qos_add_test("reg-read", "nvme", nvmetest_reg_read_test, NULL);
+
+    qos_add_test("migrate", "nvme", test_migrate, NULL);
 }
 
 libqos_init(nvme_register_nodes);
-- 
2.53.0


