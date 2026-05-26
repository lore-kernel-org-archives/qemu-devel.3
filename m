Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AF57CD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 11:35:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRq2V-0007z4-E5; Tue, 26 May 2026 07:33:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wRq2G-0007sf-Rm
 for qemu-devel@nongnu.org; Tue, 26 May 2026 07:33:26 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wRq2B-0002DL-1S
 for qemu-devel@nongnu.org; Tue, 26 May 2026 07:33:23 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-4526a8170ceso5285601f8f.2
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 04:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1779795192; x=1780399992; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vQ2Ei269qNhwnX8ilyNPENKBqWr0adLcLNyR21NmpyI=;
 b=TfsoYWZWlpGfO8gR/2xxyHhVLMhO3TQ7f/HRZODxCcJ4I0nIXbyZUdqx5OiBeml0T7
 zGXIRGZZAtwgiub9SdFQhhKdj5SlRcbLHrV8KxHa0VD0oiF4xtbyb75FVWGfS/FoX/25
 l9WbwNv50HtNwzl1MGE0FPXqpO18048VYxB6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779795192; x=1780399992;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vQ2Ei269qNhwnX8ilyNPENKBqWr0adLcLNyR21NmpyI=;
 b=TJaQRKErbE/VGa1+T8ghpkNxXtpSltItDYWmc411io+owX1taR5yylCLA51p/wXjDV
 8R8sOue0eecCCZeRYKuMkFBxNLEpt78Cr0Iz6DJP7FETA50IAAx2jFEH96EN0CaZ2pLh
 nYoT5g907kiTe4A0AeMmyieTN2C1S94m8b6VAbe4XFD/LtQ2jNr9Nvc80cajS+YHbEeD
 NJKgjslN4UN1KHe7GRWokPLDQySjiIHbZD+XdbDWbPOlhduGdTEkVu2e6XDfCHN1ixc7
 4fzF3RA0DDuBkzsGWkBrwAdaThvO+lg8RxTDwtfgGQM6hKxrGGhPVIRTj7tdQlig/auT
 KUtA==
X-Gm-Message-State: AOJu0Yx19SjQPlgnltB0r+vSwGDEGBZ+h9pWAIDBDNoikYUR+vnzyRH6
 x+9KAYGaXsZBMl9KtZ6aJslVlydEZR6bfwmSKsmdy44HQjJtRySbmGbaqOMbLId/YqOfikV5Tzn
 VhLLWfUc=
X-Gm-Gg: Acq92OHnNrzEr7mPXktsOeUikS0hqx5gCnYEdiI3NHgPbPGnRQjfz9+GlJn0hxElD3g
 1C4NJTkyo1JZZQKLc6BP84zfQiaYQIIxu/ZIS96SBPtO6ks5CwYlDGn/zcBrXnfMmIgUDI0j0WA
 +lLCmsHaawo/Nc9tesfRVt6dlbCw4qLC/qSCNemyM5zeb0Gx5UMbExNufdKyF7d+anwG7VXplYR
 8Ry3mO4A3zWwS8z8aYON/J0eAuuugtA5Pc/SfMfabmAI0TMGWKvr3htwR6H8vyReEAOJi1LjQTT
 ERzhAuiO0NTbGz48n4otq1nJe6lfixP7bscWRmgKJLHd8HZG4VjDQ6EEmQquEn2O3JF/zedyVPj
 oZeCbj7Lbp/R2SfkZ5JhHQ43K5Z5DnLZof33hqmCZ9ROyRxkRNdZdF17cjMrTpIjgDYbajY6LtN
 1EufwwQotaaZCcS6HxY+SJ1RkF0dziH3ZSC535UhP7jB4lVOi8+qfPBQKBh/3O2TyWOQcT69hJN
 DlGAEgYa/aTu06I1DKMXMg=
X-Received: by 2002:adf:e009:0:10b0:43d:c95b:c46f with SMTP id
 ffacd0b85a97d-45eb38bfdebmr22120030f8f.38.1779795191891; 
 Tue, 26 May 2026 04:33:11 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf57228c00840292fb31d0d80a.dip0.t-ipconnect.de.
 [2003:cf:5722:8c00:8402:92fb:31d0:d80a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d4ca0dsm34366870f8f.18.2026.05.26.04.33.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 04:33:11 -0700 (PDT)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, qemu-block@nongnu.org,
 Klaus Jensen <its@irrelevant.dk>, Laurent Vivier <lvivier@redhat.com>,
 Jesper Devantier <foss@defmacro.it>, Kevin Wolf <kwolf@redhat.com>,
 Fam Zheng <fam@euphon.net>, Zhao Liu <zhao1.liu@intel.com>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 Peter Xu <peterx@redhat.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH v8 8/8] tests/qtest/nvme-test: add migration test with full CQ
Date: Tue, 26 May 2026 13:33:01 +0200
Message-ID: <20260526113301.91492-9-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260526113301.91492-1-alexander@mihalicyn.com>
References: <20260526113301.91492-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alexander@mihalicyn.com; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
---
v7:
    - fixed endianness bugs (and tested on s390x machine)
    - code style changes (don't use ptr type for physical addresses)
v6:
    - test added
---
 tests/qtest/nvme-test.c | 395 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 395 insertions(+)

diff --git a/tests/qtest/nvme-test.c b/tests/qtest/nvme-test.c
index 4aec1651e6e..4d063ee971f 100644
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
@@ -142,6 +145,396 @@ static void nvmetest_pmr_reg_test(void *obj, void *data, QGuestAllocator *alloc)
     qpci_iounmap(pdev, pmr_bar);
 }
 
+#define PAGE_SIZE 4096
+
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
+#define PHYS_ADDR_OF(T, base_phys_addr, accessor) \
+    (uint64_t)&((T *)base_phys_addr)accessor
+
+static void nvme_init_queue_common(nvme_ctrl *ctrl, nvme_queue *q,
+                                   uint16_t db_idx, uint32_t size)
+{
+    q->ctrl = ctrl;
+    q->doorbell = (sizeof(NvmeBar) + db_idx * ctrl->db_stride);
+    g_test_message(" q %p db_idx %u doorbell %lx", q, db_idx, q->doorbell);
+    q->size = size;
+}
+
+static void nvme_init_sq(nvme_ctrl *ctrl, nvme_sq *sq, uint16_t db_idx,
+                         uint32_t size, nvme_cq *cq)
+{
+    nvme_init_queue_common(ctrl, &sq->common, db_idx, size);
+
+    sq->phys_sqe = guest_alloc(ctrl->alloc, PAGE_SIZE);
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
+    cq->phys_cqe = guest_alloc(ctrl->alloc, PAGE_SIZE);
+    g_assert(cq->phys_cqe);
+
+    g_test_message("cq %p db_idx %u cqe 0x%" PRIx64, cq, db_idx, cq->phys_cqe);
+    cq->head = 0;
+    cq->phase = 1;
+}
+
+static int nvme_cqe_pending(nvme_cq *cq)
+{
+    uint16_t status = qtest_readw(cq->common.ctrl->pdev->bus->qts,
+                                  PHYS_ADDR_OF(NvmeCqe, cq->phys_cqe, [cq->head].status));
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
+    uint64_t phys_cqe = PHYS_ADDR_OF(NvmeCqe, cq->phys_cqe, [cq->head]); /* NvmeCqe* */
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
+    qpci_io_writel(cq->common.ctrl->pdev, cq->common.ctrl->bar, cq->common.doorbell, cq->head);
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
+static uint64_t nvme_get_next_sqe(nvme_sq *sq, uint8_t opcode, uint16_t cid, uint64_t prp1)
+{
+    uint64_t phys_sqe = PHYS_ADDR_OF(NvmeCmd, sq->phys_sqe, [sq->tail]);
+
+    if (((sq->tail + 1) % sq->common.size) == sq->head) {
+        /* no space in SQ */
+        g_test_message("%s head %d tail %d", __func__, sq->head, sq->tail);
+        g_assert(false);
+        return 0;
+    }
+
+    qtest_memset(sq->common.ctrl->pdev->bus->qts,
+                 phys_sqe, 0, sizeof(NvmeCmd));
+
+    #define GUEST_MEM_WRITE(fn, phys_addr, val) \
+        fn(sq->common.ctrl->pdev->bus->qts, phys_addr, (val))
+
+    GUEST_MEM_WRITE(qtest_writeb, PHYS_ADDR_OF(NvmeCmd, phys_sqe, ->opcode), opcode);
+    GUEST_MEM_WRITE(qtest_writew, PHYS_ADDR_OF(NvmeCmd, phys_sqe, ->cid), cid);
+    GUEST_MEM_WRITE(qtest_writeq, PHYS_ADDR_OF(NvmeCmd, phys_sqe, ->dptr.prp1), prp1);
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
+    qpci_io_writel(sq->common.ctrl->pdev, sq->common.ctrl->bar, sq->common.doorbell, sq->tail);
+}
+
+static uint64_t nvme_admin_identify_ctrl(nvme_ctrl *ctrl, uint16_t cid, bool no_wait)
+{
+    uint64_t phys_cmd_identify; /* NvmeCmd* */
+    uint64_t phys_identify; /* NvmeIdCtrl* */
+    NvmeCqe cqe;
+
+    g_test_message("sending req cid %u no_wait %d", cid, no_wait);
+
+    phys_identify = guest_alloc(ctrl->alloc, PAGE_SIZE);
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
+    GUEST_MEM_WRITE(qtest_writel, PHYS_ADDR_OF(NvmeCmd, phys_cmd_identify, ->nsid), 0);
+    GUEST_MEM_WRITE(qtest_writel, PHYS_ADDR_OF(NvmeIdentify, phys_cmd_identify, ->cns), NVME_ID_CNS_CTRL);
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
+    g_assert(false);
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
+static void test_migrate_check_nvme(nvme_ctrl *ctrl, test_migrate_req *reqs, int num)
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
+        g_assert_cmpint(GUEST_MEM_READB(PHYS_ADDR_OF(NvmeIdCtrl, reqs[i].phys_identify, ->ieee[0])), ==, 0x0);
+        g_assert_cmpint(GUEST_MEM_READB(PHYS_ADDR_OF(NvmeIdCtrl, reqs[i].phys_identify, ->ieee[1])), ==, 0x54);
+        g_assert_cmpint(GUEST_MEM_READB(PHYS_ADDR_OF(NvmeIdCtrl, reqs[i].phys_identify, ->ieee[2])), ==, 0x52);
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
+    g_autofree gchar *mig_path;
+    g_autofree gchar *uri;
+    GString *dest_cmdline;
+    QTestState *to;
+    QDict *rsp;
+    QNvme *nvme = obj;
+    QPCIDevice *pdev = &nvme->dev;
+    g_autofree nvme_ctrl *ctrl;
+    test_migrate_req test_reqs[] = {
+        { 123, true },
+        { 456, false },
+        { 300, false },
+        { 333, false }
+    };
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
@@ -168,6 +561,8 @@ static void nvme_register_nodes(void)
     });
 
     qos_add_test("reg-read", "nvme", nvmetest_reg_read_test, NULL);
+
+    qos_add_test("migrate", "nvme", test_migrate, NULL);
 }
 
 libqos_init(nvme_register_nodes);
-- 
2.47.3


