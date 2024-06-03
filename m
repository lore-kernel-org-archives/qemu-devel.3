Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97714C25B76
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 08:38:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE3CQ-0007Li-Fu; Mon, 03 Jun 2024 04:37:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1sE3CO-0007Kp-FS; Mon, 03 Jun 2024 04:37:48 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1sE3CL-0001Fr-AX; Mon, 03 Jun 2024 04:37:48 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6f8d0a00a35so2400227a34.2; 
 Mon, 03 Jun 2024 01:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717403862; x=1718008662; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zwRBTl9473HbiOu7Tsue/5cHQ70JBNoZdR2txjcpE0A=;
 b=OKKMYR86bPAJY2C0qlYeDyjyNs/pwSbAkk1kQXU6b94M3B+fKeJDMiGUs0tJEFXq2x
 S6bm8Wby7qeicbaiCLi6Kxt/HVlSa44jaj7y2yWoBtkPAbRo2V7v1OL29nlnGve8RYxx
 mxTR3QsaGRJE142c/NwvWOTEd9yG7rcCeWQFUuVu3x1qNP1nps6mknb7I1U0IJrWwKA2
 Jnf3bSElq2i6ExvT6kLWiKbja7TcR06CdZko4xaCBAYfeWhFW+ktOF277NbuU99QUoXh
 k5X9iotKsJSHcPirV2xmwUr3kNjW0Z/c6HHwcWouqn78mzJ5JWdT3meIoJj+lGs5Tn93
 swvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717403862; x=1718008662;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zwRBTl9473HbiOu7Tsue/5cHQ70JBNoZdR2txjcpE0A=;
 b=YRuRgIpP4BhZRBgaqBY5bpddqpl7ZkSZWFQwizVauasm5NJXmpnnlcKF8SihuNVFk4
 ZINNYcF0yvG6NhRGbIImRP9L4w7E54MTUunyXXSLE3bDALYIlka45V0/1TQNmO2GuGvZ
 N6kcL98w092oyGWnI/EgjtPWs4XMCkj9xmKdOxRkFLbm6EOrNxLDkngABlzRl9v5XXWW
 HgzkWoc0RurnyayYeUnf4SjH1pHeS6RYFJ/ZlnCdSWb9olrXq+Ntwc5WuiY5AQhdmYMl
 UQ8oTukYKwZ8Q72czQPDfMLx6SEg9Pa/372y0//nBZQrjD1xlMraN+NRL2bvYraCkz3L
 f8JA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWc1oVPhXzitTo/lYanv+q/RPSNNqPMbEikbxiXQUyEDQg/i4G5GWnigRvrp+J187vS7qLsEPKyISmKbOyAmu35XmB/Zds=
X-Gm-Message-State: AOJu0YwhDxzLh5Ln3pxvF3rT7yIyxHaibyxPvArSzMccnATvvz+8df1H
 Fycpy9LmNJF7oWEyq9rZi4c2h2yWRZdem/kOxRjeW00R0JLr+0Y1E4ZMjQ==
X-Google-Smtp-Source: AGHT+IHf/hIZgJiVq6mB/16b9W3dcG6n3JmaakqNcxXgUkRW6KdILbjojghWkQZlCkjsGQLiIArAAg==
X-Received: by 2002:a05:6870:f617:b0:22a:5ffd:5e40 with SMTP id
 586e51a60fabf-2508bcba59amr8668911fac.59.1717403862333; 
 Mon, 03 Jun 2024 01:37:42 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([210.223.46.112])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-702425e0c6dsm5020762b3a.89.2024.06.03.01.37.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 01:37:41 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: qemu-devel@nongnu.org,
	richard.henderson@linaro.org
Cc: fam@euphon.net, pbonzini@redhat.com, qemu-block@nongnu.org,
 jeuk20.kim@samsung.com, j-young.choi@samsung.com, minwoo.im@samsung.com
Subject: [PULL v2 2/2] hw/ufs: Add support MCQ of UFSHCI 4.0
Date: Mon,  3 Jun 2024 17:37:25 +0900
Message-Id: <5c079578d2e46df626d13eeb629c7d761a5c4e44.1717403572.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1717403572.git.jeuk20.kim@samsung.com>
References: <cover.1717403572.git.jeuk20.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-ot1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Minwoo Im <minwoo.im@samsung.com>

This patch adds support for MCQ defined in UFSHCI 4.0.  This patch
utilized the legacy I/O codes as much as possible to support MCQ.

MCQ operation & runtime register is placed at 0x1000 offset of UFSHCI
register statically with no spare space among four registers (48B):

	UfsMcqSqReg, UfsMcqSqIntReg, UfsMcqCqReg, UfsMcqCqIntReg

The maxinum number of queue is 32 as per spec, and the default
MAC(Multiple Active Commands) are 32 in the device.

Example:
	-device ufs,serial=foo,id=ufs0,mcq=true,mcq-maxq=8

Signed-off-by: Minwoo Im <minwoo.im@samsung.com>
Reviewed-by: Jeuk Kim <jeuk20.kim@samsung.com>
Message-Id: <20240528023106.856777-3-minwoo.im@samsung.com>
Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
---
 hw/ufs/trace-events |  17 ++
 hw/ufs/ufs.c        | 475 ++++++++++++++++++++++++++++++++++++++++++--
 hw/ufs/ufs.h        |  98 ++++++++-
 include/block/ufs.h |  23 ++-
 4 files changed, 593 insertions(+), 20 deletions(-)

diff --git a/hw/ufs/trace-events b/hw/ufs/trace-events
index 665e1a942b..531dcfc686 100644
--- a/hw/ufs/trace-events
+++ b/hw/ufs/trace-events
@@ -11,13 +11,18 @@ ufs_exec_nop_cmd(uint32_t slot) "UTRLDBR slot %"PRIu32""
 ufs_exec_scsi_cmd(uint32_t slot, uint8_t lun, uint8_t opcode) "slot %"PRIu32", lun 0x%"PRIx8", opcode 0x%"PRIx8""
 ufs_exec_query_cmd(uint32_t slot, uint8_t opcode) "slot %"PRIu32", opcode 0x%"PRIx8""
 ufs_process_uiccmd(uint32_t uiccmd, uint32_t ucmdarg1, uint32_t ucmdarg2, uint32_t ucmdarg3) "uiccmd 0x%"PRIx32", ucmdarg1 0x%"PRIx32", ucmdarg2 0x%"PRIx32", ucmdarg3 0x%"PRIx32""
+ufs_mcq_complete_req(uint8_t qid) "sqid %"PRIu8""
+ufs_mcq_create_sq(uint8_t sqid, uint8_t cqid, uint64_t addr, uint16_t size) "mcq create sq sqid %"PRIu8", cqid %"PRIu8", addr 0x%"PRIx64", size %"PRIu16""
+ufs_mcq_create_cq(uint8_t cqid, uint64_t addr, uint16_t size) "mcq create cq cqid %"PRIu8", addr 0x%"PRIx64", size %"PRIu16""
 
 # error condition
 ufs_err_dma_read_utrd(uint32_t slot, uint64_t addr) "failed to read utrd. UTRLDBR slot %"PRIu32", UTRD dma addr %"PRIu64""
 ufs_err_dma_read_req_upiu(uint32_t slot, uint64_t addr) "failed to read req upiu. UTRLDBR slot %"PRIu32", request upiu addr %"PRIu64""
 ufs_err_dma_read_prdt(uint32_t slot, uint64_t addr) "failed to read prdt. UTRLDBR slot %"PRIu32", prdt addr %"PRIu64""
+ufs_err_dma_read_sq(uint8_t sqid, uint64_t addr) "failed to read sq entry. sqid %"PRIu8", hwaddr %"PRIu64""
 ufs_err_dma_write_utrd(uint32_t slot, uint64_t addr) "failed to write utrd. UTRLDBR slot %"PRIu32", UTRD dma addr %"PRIu64""
 ufs_err_dma_write_rsp_upiu(uint32_t slot, uint64_t addr) "failed to write rsp upiu. UTRLDBR slot %"PRIu32", response upiu addr %"PRIu64""
+ufs_err_dma_write_cq(uint8_t cqid, uint64_t addr) "failed to write cq entry. cqid %"PRIu8", hwaddr %"PRIu64""
 ufs_err_utrl_slot_error(uint32_t slot) "UTRLDBR slot %"PRIu32" is in error"
 ufs_err_utrl_slot_busy(uint32_t slot) "UTRLDBR slot %"PRIu32" is busy"
 ufs_err_unsupport_register_offset(uint32_t offset) "Register offset 0x%"PRIx32" is not yet supported"
@@ -31,3 +36,15 @@ ufs_err_query_invalid_opcode(uint8_t opcode) "query request has invalid opcode.
 ufs_err_query_invalid_idn(uint8_t opcode, uint8_t idn) "query request has invalid idn. opcode: 0x%"PRIx8", idn 0x%"PRIx8""
 ufs_err_query_invalid_index(uint8_t opcode, uint8_t index) "query request has invalid index. opcode: 0x%"PRIx8", index 0x%"PRIx8""
 ufs_err_invalid_trans_code(uint32_t slot, uint8_t trans_code) "request upiu has invalid transaction code. slot: %"PRIu32", trans_code: 0x%"PRIx8""
+ufs_err_mcq_db_wr_invalid_sqid(uint8_t qid) "invalid mcq sqid %"PRIu8""
+ufs_err_mcq_db_wr_invalid_db(uint8_t qid, uint32_t db) "invalid mcq doorbell sqid %"PRIu8", db %"PRIu32""
+ufs_err_mcq_create_sq_invalid_sqid(uint8_t qid) "invalid mcq sqid %"PRIu8""
+ufs_err_mcq_create_sq_invalid_cqid(uint8_t qid) "invalid mcq cqid %"PRIu8""
+ufs_err_mcq_create_sq_already_exists(uint8_t qid) "mcq sqid %"PRIu8 "already exists"
+ufs_err_mcq_delete_sq_invalid_sqid(uint8_t qid) "invalid mcq sqid %"PRIu8""
+ufs_err_mcq_delete_sq_not_exists(uint8_t qid) "mcq sqid %"PRIu8 "not exists"
+ufs_err_mcq_create_cq_invalid_cqid(uint8_t qid) "invalid mcq cqid %"PRIu8""
+ufs_err_mcq_create_cq_already_exists(uint8_t qid) "mcq cqid %"PRIu8 "already exists"
+ufs_err_mcq_delete_cq_invalid_cqid(uint8_t qid) "invalid mcq cqid %"PRIu8""
+ufs_err_mcq_delete_cq_not_exists(uint8_t qid) "mcq cqid %"PRIu8 "not exists"
+ufs_err_mcq_delete_cq_sq_not_deleted(uint8_t sqid, uint8_t cqid) "mcq sq %"PRIu8" still has cq %"PRIu8""
diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index bac78a32bb..71a88d221c 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -9,7 +9,7 @@
  */
 
 /**
- * Reference Specs: https://www.jedec.org/, 3.1
+ * Reference Specs: https://www.jedec.org/, 4.0
  *
  * Usage
  * -----
@@ -28,10 +28,45 @@
 #include "trace.h"
 #include "ufs.h"
 
-/* The QEMU-UFS device follows spec version 3.1 */
-#define UFS_SPEC_VER 0x0310
+/* The QEMU-UFS device follows spec version 4.0 */
+#define UFS_SPEC_VER 0x0400
 #define UFS_MAX_NUTRS 32
 #define UFS_MAX_NUTMRS 8
+#define UFS_MCQ_QCFGPTR 2
+
+static void ufs_exec_req(UfsRequest *req);
+static void ufs_clear_req(UfsRequest *req);
+
+static inline uint64_t ufs_mcq_reg_addr(UfsHc *u, int qid)
+{
+    /* Submission Queue MCQ Registers offset (400h) */
+    return (UFS_MCQ_QCFGPTR * 0x200) + qid * 0x40;
+}
+
+static inline uint64_t ufs_mcq_op_reg_addr(UfsHc *u, int qid)
+{
+    /* MCQ Operation & Runtime Registers offset (1000h) */
+    return UFS_MCQ_OPR_START + qid * 48;
+}
+
+static inline uint64_t ufs_reg_size(UfsHc *u)
+{
+    /* Total UFS HCI Register size in bytes */
+    return ufs_mcq_op_reg_addr(u, 0) + sizeof(u->mcq_op_reg);
+}
+
+static inline bool ufs_is_mcq_reg(UfsHc *u, uint64_t addr)
+{
+    uint64_t mcq_reg_addr = ufs_mcq_reg_addr(u, 0);
+    return addr >= mcq_reg_addr && addr < mcq_reg_addr + sizeof(u->mcq_reg);
+}
+
+static inline bool ufs_is_mcq_op_reg(UfsHc *u, uint64_t addr)
+{
+    uint64_t mcq_op_reg_addr = ufs_mcq_op_reg_addr(u, 0);
+    return (addr >= mcq_op_reg_addr &&
+            addr < mcq_op_reg_addr + sizeof(u->mcq_op_reg));
+}
 
 static MemTxResult ufs_addr_read(UfsHc *u, hwaddr addr, void *buf, int size)
 {
@@ -181,9 +216,14 @@ static MemTxResult ufs_dma_read_upiu(UfsRequest *req)
 {
     MemTxResult ret;
 
-    ret = ufs_dma_read_utrd(req);
-    if (ret) {
-        return ret;
+    /*
+     * In case of MCQ, UTRD has already been read from a SQ, so skip it.
+     */
+    if (!ufs_mcq_req(req)) {
+        ret = ufs_dma_read_utrd(req);
+        if (ret) {
+            return ret;
+        }
     }
 
     ret = ufs_dma_read_req_upiu(req);
@@ -335,6 +375,219 @@ static void ufs_process_uiccmd(UfsHc *u, uint32_t val)
     ufs_irq_check(u);
 }
 
+static void ufs_mcq_init_req(UfsHc *u, UfsRequest *req, UfsSq *sq)
+{
+    memset(req, 0, sizeof(*req));
+
+    req->hc = u;
+    req->state = UFS_REQUEST_IDLE;
+    req->slot = UFS_INVALID_SLOT;
+    req->sq = sq;
+}
+
+static void ufs_mcq_process_sq(void *opaque)
+{
+    UfsSq *sq = opaque;
+    UfsHc *u = sq->u;
+    UfsSqEntry sqe;
+    UfsRequest *req;
+    hwaddr addr;
+    uint16_t head = ufs_mcq_sq_head(u, sq->sqid);
+    int err;
+
+    while (!(ufs_mcq_sq_empty(u, sq->sqid) || QTAILQ_EMPTY(&sq->req_list))) {
+        addr = sq->addr + head;
+        err = ufs_addr_read(sq->u, addr, (void *)&sqe, sizeof(sqe));
+        if (err) {
+            trace_ufs_err_dma_read_sq(sq->sqid, addr);
+            return;
+        }
+
+        head = (head + sizeof(sqe)) % (sq->size * sizeof(sqe));
+        ufs_mcq_update_sq_head(u, sq->sqid, head);
+
+        req = QTAILQ_FIRST(&sq->req_list);
+        QTAILQ_REMOVE(&sq->req_list, req, entry);
+
+        ufs_mcq_init_req(sq->u, req, sq);
+        memcpy(&req->utrd, &sqe, sizeof(req->utrd));
+
+        req->state = UFS_REQUEST_RUNNING;
+        ufs_exec_req(req);
+    }
+}
+
+static void ufs_mcq_process_cq(void *opaque)
+{
+    UfsCq *cq = opaque;
+    UfsHc *u = cq->u;
+    UfsRequest *req, *next;
+    MemTxResult ret;
+    uint32_t tail = ufs_mcq_cq_tail(u, cq->cqid);
+
+    QTAILQ_FOREACH_SAFE(req, &cq->req_list, entry, next)
+    {
+        ufs_dma_write_rsp_upiu(req);
+
+        req->cqe.utp_addr =
+            ((uint64_t)req->utrd.command_desc_base_addr_hi << 32ULL) |
+            req->utrd.command_desc_base_addr_lo;
+        req->cqe.utp_addr |= req->sq->sqid;
+        req->cqe.resp_len = req->utrd.response_upiu_length;
+        req->cqe.resp_off = req->utrd.response_upiu_offset;
+        req->cqe.prdt_len = req->utrd.prd_table_length;
+        req->cqe.prdt_off = req->utrd.prd_table_offset;
+        req->cqe.status = req->utrd.header.dword_2 & 0xf;
+        req->cqe.error = 0;
+
+        ret = ufs_addr_write(u, cq->addr + tail, &req->cqe, sizeof(req->cqe));
+        if (ret) {
+            trace_ufs_err_dma_write_cq(cq->cqid, cq->addr + tail);
+        }
+        QTAILQ_REMOVE(&cq->req_list, req, entry);
+
+        tail = (tail + sizeof(req->cqe)) % (cq->size * sizeof(req->cqe));
+        ufs_mcq_update_cq_tail(u, cq->cqid, tail);
+
+        ufs_clear_req(req);
+        QTAILQ_INSERT_TAIL(&req->sq->req_list, req, entry);
+    }
+
+    if (!ufs_mcq_cq_empty(u, cq->cqid)) {
+        u->mcq_op_reg[cq->cqid].cq_int.is =
+            FIELD_DP32(u->mcq_op_reg[cq->cqid].cq_int.is, CQIS, TEPS, 1);
+
+        u->reg.is = FIELD_DP32(u->reg.is, IS, CQES, 1);
+        ufs_irq_check(u);
+    }
+}
+
+static bool ufs_mcq_create_sq(UfsHc *u, uint8_t qid, uint32_t attr)
+{
+    UfsMcqReg *reg = &u->mcq_reg[qid];
+    UfsSq *sq;
+    uint8_t cqid = FIELD_EX32(attr, SQATTR, CQID);
+
+    if (qid >= u->params.mcq_maxq) {
+        trace_ufs_err_mcq_create_sq_invalid_sqid(qid);
+        return false;
+    }
+
+    if (u->sq[qid]) {
+        trace_ufs_err_mcq_create_sq_already_exists(qid);
+        return false;
+    }
+
+    if (!u->cq[cqid]) {
+        trace_ufs_err_mcq_create_sq_invalid_cqid(qid);
+        return false;
+    }
+
+    sq = g_malloc0(sizeof(*sq));
+    sq->u = u;
+    sq->sqid = qid;
+    sq->cq = u->cq[cqid];
+    sq->addr = ((uint64_t)reg->squba << 32) | reg->sqlba;
+    sq->size = ((FIELD_EX32(attr, SQATTR, SIZE) + 1) << 2) / sizeof(UfsSqEntry);
+
+    sq->bh = qemu_bh_new_guarded(ufs_mcq_process_sq, sq,
+                                 &DEVICE(u)->mem_reentrancy_guard);
+    sq->req = g_new0(UfsRequest, sq->size);
+    QTAILQ_INIT(&sq->req_list);
+    for (int i = 0; i < sq->size; i++) {
+        ufs_mcq_init_req(u, &sq->req[i], sq);
+        QTAILQ_INSERT_TAIL(&sq->req_list, &sq->req[i], entry);
+    }
+
+    u->sq[qid] = sq;
+
+    trace_ufs_mcq_create_sq(sq->sqid, sq->cq->cqid, sq->addr, sq->size);
+    return true;
+}
+
+static bool ufs_mcq_delete_sq(UfsHc *u, uint8_t qid)
+{
+    UfsSq *sq;
+
+    if (qid >= u->params.mcq_maxq) {
+        trace_ufs_err_mcq_delete_sq_invalid_sqid(qid);
+        return false;
+    }
+
+    if (!u->sq[qid]) {
+        trace_ufs_err_mcq_delete_sq_not_exists(qid);
+        return false;
+    }
+
+    sq = u->sq[qid];
+
+    qemu_bh_delete(sq->bh);
+    g_free(sq->req);
+    g_free(sq);
+    u->sq[qid] = NULL;
+    return true;
+}
+
+static bool ufs_mcq_create_cq(UfsHc *u, uint8_t qid, uint32_t attr)
+{
+    UfsMcqReg *reg = &u->mcq_reg[qid];
+    UfsCq *cq;
+
+    if (qid >= u->params.mcq_maxq) {
+        trace_ufs_err_mcq_create_cq_invalid_cqid(qid);
+        return false;
+    }
+
+    if (u->cq[qid]) {
+        trace_ufs_err_mcq_create_cq_already_exists(qid);
+        return false;
+    }
+
+    cq = g_malloc0(sizeof(*cq));
+    cq->u = u;
+    cq->cqid = qid;
+    cq->addr = ((uint64_t)reg->cquba << 32) | reg->cqlba;
+    cq->size = ((FIELD_EX32(attr, CQATTR, SIZE) + 1) << 2) / sizeof(UfsCqEntry);
+
+    cq->bh = qemu_bh_new_guarded(ufs_mcq_process_cq, cq,
+                                 &DEVICE(u)->mem_reentrancy_guard);
+    QTAILQ_INIT(&cq->req_list);
+
+    u->cq[qid] = cq;
+
+    trace_ufs_mcq_create_cq(cq->cqid, cq->addr, cq->size);
+    return true;
+}
+
+static bool ufs_mcq_delete_cq(UfsHc *u, uint8_t qid)
+{
+    UfsCq *cq;
+
+    if (qid >= u->params.mcq_maxq) {
+        trace_ufs_err_mcq_delete_cq_invalid_cqid(qid);
+        return false;
+    }
+
+    if (!u->cq[qid]) {
+        trace_ufs_err_mcq_delete_cq_not_exists(qid);
+        return false;
+    }
+
+    for (int i = 0; i < ARRAY_SIZE(u->sq); i++) {
+        if (u->sq[i] && u->sq[i]->cq->cqid == qid) {
+            trace_ufs_err_mcq_delete_cq_sq_not_deleted(i, qid);
+            return false;
+        }
+    }
+
+    cq = u->cq[qid];
+
+    qemu_bh_delete(cq->bh);
+    g_free(cq);
+    u->cq[qid] = NULL;
+    return true;
+}
+
 static void ufs_write_reg(UfsHc *u, hwaddr offset, uint32_t data, unsigned size)
 {
     switch (offset) {
@@ -390,6 +643,12 @@ static void ufs_write_reg(UfsHc *u, hwaddr offset, uint32_t data, unsigned size)
     case A_UCMDARG3:
         u->reg.ucmdarg3 = data;
         break;
+    case A_CONFIG:
+        u->reg.config = data;
+        break;
+    case A_MCQCONFIG:
+        u->reg.mcqconfig = data;
+        break;
     case A_UTRLCLR:
     case A_UTMRLDBR:
     case A_UTMRLCLR:
@@ -402,18 +661,138 @@ static void ufs_write_reg(UfsHc *u, hwaddr offset, uint32_t data, unsigned size)
     }
 }
 
+static void ufs_write_mcq_reg(UfsHc *u, hwaddr offset, uint32_t data,
+                              unsigned size)
+{
+    int qid = offset / sizeof(UfsMcqReg);
+    UfsMcqReg *reg = &u->mcq_reg[qid];
+
+    switch (offset % sizeof(UfsMcqReg)) {
+    case A_SQATTR:
+        if (!FIELD_EX32(reg->sqattr, SQATTR, SQEN) &&
+            FIELD_EX32(data, SQATTR, SQEN)) {
+            if (!ufs_mcq_create_sq(u, qid, data)) {
+                break;
+            }
+        } else if (FIELD_EX32(reg->sqattr, SQATTR, SQEN) &&
+                   !FIELD_EX32(data, SQATTR, SQEN)) {
+            if (!ufs_mcq_delete_sq(u, qid)) {
+                break;
+            }
+        }
+        reg->sqattr = data;
+        break;
+    case A_SQLBA:
+        reg->sqlba = data;
+        break;
+    case A_SQUBA:
+        reg->squba = data;
+        break;
+    case A_SQCFG:
+        reg->sqcfg = data;
+        break;
+    case A_CQATTR:
+        if (!FIELD_EX32(reg->cqattr, CQATTR, CQEN) &&
+            FIELD_EX32(data, CQATTR, CQEN)) {
+            if (!ufs_mcq_create_cq(u, qid, data)) {
+                break;
+            }
+        } else if (FIELD_EX32(reg->cqattr, CQATTR, CQEN) &&
+                   !FIELD_EX32(data, CQATTR, CQEN)) {
+            if (!ufs_mcq_delete_cq(u, qid)) {
+                break;
+            }
+        }
+        reg->cqattr = data;
+        break;
+    case A_CQLBA:
+        reg->cqlba = data;
+        break;
+    case A_CQUBA:
+        reg->cquba = data;
+        break;
+    case A_CQCFG:
+        reg->cqcfg = data;
+        break;
+    case A_SQDAO:
+    case A_SQISAO:
+    case A_CQDAO:
+    case A_CQISAO:
+        trace_ufs_err_unsupport_register_offset(offset);
+        break;
+    default:
+        trace_ufs_err_invalid_register_offset(offset);
+        break;
+    }
+}
+
+static void ufs_mcq_process_db(UfsHc *u, uint8_t qid, uint32_t db)
+{
+    UfsSq *sq;
+
+    if (qid >= u->params.mcq_maxq) {
+        trace_ufs_err_mcq_db_wr_invalid_sqid(qid);
+        return;
+    }
+
+    sq = u->sq[qid];
+    if (sq->size * sizeof(UfsSqEntry) <= db) {
+        trace_ufs_err_mcq_db_wr_invalid_db(qid, db);
+        return;
+    }
+
+    ufs_mcq_update_sq_tail(u, sq->sqid, db);
+    qemu_bh_schedule(sq->bh);
+}
+
+static void ufs_write_mcq_op_reg(UfsHc *u, hwaddr offset, uint32_t data,
+                                 unsigned size)
+{
+    int qid = offset / sizeof(UfsMcqOpReg);
+    UfsMcqOpReg *opr = &u->mcq_op_reg[qid];
+
+    switch (offset % sizeof(UfsMcqOpReg)) {
+    case offsetof(UfsMcqOpReg, sq.tp):
+        if (opr->sq.tp != data) {
+            ufs_mcq_process_db(u, qid, data);
+        }
+        opr->sq.tp = data;
+        break;
+    case offsetof(UfsMcqOpReg, cq.hp):
+        opr->cq.hp = data;
+        ufs_mcq_update_cq_head(u, qid, data);
+        break;
+    case offsetof(UfsMcqOpReg, cq_int.is):
+        opr->cq_int.is &= ~data;
+        break;
+    default:
+        trace_ufs_err_invalid_register_offset(offset);
+        break;
+    }
+}
+
 static uint64_t ufs_mmio_read(void *opaque, hwaddr addr, unsigned size)
 {
     UfsHc *u = (UfsHc *)opaque;
-    uint8_t *ptr = (uint8_t *)&u->reg;
+    uint8_t *ptr;
     uint64_t value;
-
-    if (addr > sizeof(u->reg) - size) {
+    uint64_t offset;
+
+    if (addr < sizeof(u->reg)) {
+        offset = addr;
+        ptr = (uint8_t *)&u->reg;
+    } else if (ufs_is_mcq_reg(u, addr)) {
+        offset = addr - ufs_mcq_reg_addr(u, 0);
+        ptr = (uint8_t *)&u->mcq_reg;
+    } else if (ufs_is_mcq_op_reg(u, addr)) {
+        offset = addr - ufs_mcq_op_reg_addr(u, 0);
+        ptr = (uint8_t *)&u->mcq_op_reg;
+    } else {
         trace_ufs_err_invalid_register_offset(addr);
         return 0;
     }
 
-    value = *(uint32_t *)(ptr + addr);
+    value = *(uint32_t *)(ptr + offset);
     trace_ufs_mmio_read(addr, value, size);
     return value;
 }
@@ -423,13 +802,17 @@ static void ufs_mmio_write(void *opaque, hwaddr addr, uint64_t data,
 {
     UfsHc *u = (UfsHc *)opaque;
 
-    if (addr > sizeof(u->reg) - size) {
+    trace_ufs_mmio_write(addr, data, size);
+
+    if (addr < sizeof(u->reg)) {
+        ufs_write_reg(u, addr, data, size);
+    } else if (ufs_is_mcq_reg(u, addr)) {
+        ufs_write_mcq_reg(u, addr - ufs_mcq_reg_addr(u, 0), data, size);
+    } else if (ufs_is_mcq_op_reg(u, addr)) {
+        ufs_write_mcq_op_reg(u, addr - ufs_mcq_op_reg_addr(u, 0), data, size);
+    } else {
         trace_ufs_err_invalid_register_offset(addr);
-        return;
     }
-
-    trace_ufs_mmio_write(addr, data, size);
-    ufs_write_reg(u, addr, data, size);
 }
 
 static const MemoryRegionOps ufs_mmio_ops = {
@@ -1086,9 +1469,16 @@ void ufs_complete_req(UfsRequest *req, UfsReqResult req_result)
         req->utrd.header.dword_2 = cpu_to_le32(UFS_OCS_INVALID_CMD_TABLE_ATTR);
     }
 
-    trace_ufs_complete_req(req->slot);
     req->state = UFS_REQUEST_COMPLETE;
-    qemu_bh_schedule(u->complete_bh);
+
+    if (ufs_mcq_req(req)) {
+        trace_ufs_mcq_complete_req(req->sq->sqid);
+        QTAILQ_INSERT_TAIL(&req->sq->cq->req_list, req, entry);
+        qemu_bh_schedule(req->sq->cq->bh);
+    } else {
+        trace_ufs_complete_req(req->slot);
+        qemu_bh_schedule(u->complete_bh);
+    }
 }
 
 static void ufs_clear_req(UfsRequest *req)
@@ -1158,6 +1548,11 @@ static bool ufs_check_constraints(UfsHc *u, Error **errp)
         return false;
     }
 
+    if (u->params.mcq_maxq >= UFS_MAX_MCQ_QNUM) {
+        error_setg(errp, "mcq-maxq must be less than %d", UFS_MAX_MCQ_QNUM);
+        return false;
+    }
+
     return true;
 }
 
@@ -1189,15 +1584,24 @@ static void ufs_init_state(UfsHc *u)
                                          &DEVICE(u)->mem_reentrancy_guard);
     u->complete_bh = qemu_bh_new_guarded(ufs_sendback_req, u,
                                          &DEVICE(u)->mem_reentrancy_guard);
+
+    if (u->params.mcq) {
+        memset(u->sq, 0, sizeof(u->sq));
+        memset(u->cq, 0, sizeof(u->cq));
+    }
 }
 
 static void ufs_init_hc(UfsHc *u)
 {
     uint32_t cap = 0;
+    uint32_t mcqconfig = 0;
+    uint32_t mcqcap = 0;
 
-    u->reg_size = pow2ceil(sizeof(UfsReg));
+    u->reg_size = pow2ceil(ufs_reg_size(u));
 
     memset(&u->reg, 0, sizeof(u->reg));
+    memset(&u->mcq_reg, 0, sizeof(u->mcq_reg));
+    memset(&u->mcq_op_reg, 0, sizeof(u->mcq_op_reg));
     cap = FIELD_DP32(cap, CAP, NUTRS, (u->params.nutrs - 1));
     cap = FIELD_DP32(cap, CAP, RTT, 2);
     cap = FIELD_DP32(cap, CAP, NUTMRS, (u->params.nutmrs - 1));
@@ -1206,7 +1610,29 @@ static void ufs_init_hc(UfsHc *u)
     cap = FIELD_DP32(cap, CAP, OODDS, 0);
     cap = FIELD_DP32(cap, CAP, UICDMETMS, 0);
     cap = FIELD_DP32(cap, CAP, CS, 0);
+    cap = FIELD_DP32(cap, CAP, LSDBS, 1);
+    cap = FIELD_DP32(cap, CAP, MCQS, u->params.mcq);
     u->reg.cap = cap;
+
+    if (u->params.mcq) {
+        mcqconfig = FIELD_DP32(mcqconfig, MCQCONFIG, MAC, 0x1f);
+        u->reg.mcqconfig = mcqconfig;
+
+        mcqcap = FIELD_DP32(mcqcap, MCQCAP, MAXQ, u->params.mcq_maxq - 1);
+        mcqcap = FIELD_DP32(mcqcap, MCQCAP, RRP, 1);
+        mcqcap = FIELD_DP32(mcqcap, MCQCAP, QCFGPTR, UFS_MCQ_QCFGPTR);
+        u->reg.mcqcap = mcqcap;
+
+        for (int i = 0; i < ARRAY_SIZE(u->mcq_reg); i++) {
+            uint64_t addr = ufs_mcq_op_reg_addr(u, i);
+            u->mcq_reg[i].sqdao = addr;
+            u->mcq_reg[i].sqisao = addr + sizeof(UfsMcqSqReg);
+            addr += sizeof(UfsMcqSqReg);
+            u->mcq_reg[i].cqdao = addr + sizeof(UfsMcqSqIntReg);
+            addr += sizeof(UfsMcqSqIntReg);
+            u->mcq_reg[i].cqisao = addr + sizeof(UfsMcqCqReg);
+        }
+    }
     u->reg.ver = UFS_SPEC_VER;
 
     memset(&u->device_desc, 0, sizeof(DeviceDescriptor));
@@ -1288,12 +1714,25 @@ static void ufs_exit(PCIDevice *pci_dev)
         ufs_clear_req(&u->req_list[i]);
     }
     g_free(u->req_list);
+
+    for (int i = 0; i < ARRAY_SIZE(u->sq); i++) {
+        if (u->sq[i]) {
+            ufs_mcq_delete_sq(u, i);
+        }
+    }
+    for (int i = 0; i < ARRAY_SIZE(u->cq); i++) {
+        if (u->cq[i]) {
+            ufs_mcq_delete_cq(u, i);
+        }
+    }
 }
 
 static Property ufs_props[] = {
     DEFINE_PROP_STRING("serial", UfsHc, params.serial),
     DEFINE_PROP_UINT8("nutrs", UfsHc, params.nutrs, 32),
     DEFINE_PROP_UINT8("nutmrs", UfsHc, params.nutmrs, 8),
+    DEFINE_PROP_BOOL("mcq", UfsHc, params.mcq, false),
+    DEFINE_PROP_UINT8("mcq-maxq", UfsHc, params.mcq_maxq, 2),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/ufs/ufs.h b/hw/ufs/ufs.h
index 8fda94f4ef..6c9382cbc4 100644
--- a/hw/ufs/ufs.h
+++ b/hw/ufs/ufs.h
@@ -16,6 +16,7 @@
 #include "block/ufs.h"
 
 #define UFS_MAX_LUS 32
+#define UFS_MAX_MCQ_QNUM 32
 #define UFS_BLOCK_SIZE_SHIFT 12
 #define UFS_BLOCK_SIZE (1 << UFS_BLOCK_SIZE_SHIFT)
 
@@ -45,10 +46,11 @@ typedef enum UfsReqResult {
     UFS_REQUEST_NO_COMPLETE = 2,
 } UfsReqResult;
 
+#define UFS_INVALID_SLOT (-1)
 typedef struct UfsRequest {
     struct UfsHc *hc;
     UfsRequestState state;
-    int slot;
+    int slot; /* -1 when it's a MCQ request */
 
     UtpTransferReqDesc utrd;
     UtpUpiuReq req_upiu;
@@ -57,8 +59,18 @@ typedef struct UfsRequest {
     /* for scsi command */
     QEMUSGList *sg;
     uint32_t data_len;
+
+    /* for MCQ */
+    struct UfsSq *sq;
+    struct UfsCqEntry cqe;
+    QTAILQ_ENTRY(UfsRequest) entry;
 } UfsRequest;
 
+static inline bool ufs_mcq_req(UfsRequest *req)
+{
+    return req->sq != NULL;
+}
+
 struct UfsLu;
 typedef UfsReqResult (*UfsScsiOp)(struct UfsLu *, UfsRequest *);
 
@@ -76,13 +88,43 @@ typedef struct UfsParams {
     char *serial;
     uint8_t nutrs; /* Number of UTP Transfer Request Slots */
     uint8_t nutmrs; /* Number of UTP Task Management Request Slots */
+    bool mcq; /* Multiple Command Queue support */
+    uint8_t mcq_qcfgptr; /* MCQ Queue Configuration Pointer in MCQCAP */
+    uint8_t mcq_maxq; /* MCQ Maximum number of Queues */
 } UfsParams;
 
+/*
+ * MCQ Properties
+ */
+typedef struct UfsSq {
+    struct UfsHc *u;
+    uint8_t sqid;
+    struct UfsCq *cq;
+    uint64_t addr;
+    uint16_t size; /* A number of entries (qdepth) */
+
+    QEMUBH *bh; /* Bottom half to process requests in async */
+    UfsRequest *req;
+    QTAILQ_HEAD(, UfsRequest) req_list; /* Free request list */
+} UfsSq;
+
+typedef struct UfsCq {
+    struct UfsHc *u;
+    uint8_t cqid;
+    uint64_t addr;
+    uint16_t size; /* A number of entries (qdepth) */
+
+    QEMUBH *bh;
+    QTAILQ_HEAD(, UfsRequest) req_list;
+} UfsCq;
+
 typedef struct UfsHc {
     PCIDevice parent_obj;
     UfsBus bus;
     MemoryRegion iomem;
     UfsReg reg;
+    UfsMcqReg mcq_reg[UFS_MAX_MCQ_QNUM];
+    UfsMcqOpReg mcq_op_reg[UFS_MAX_MCQ_QNUM];
     UfsParams params;
     uint32_t reg_size;
     UfsRequest *req_list;
@@ -100,8 +142,62 @@ typedef struct UfsHc {
     qemu_irq irq;
     QEMUBH *doorbell_bh;
     QEMUBH *complete_bh;
+
+    /* MCQ properties */
+    UfsSq *sq[UFS_MAX_MCQ_QNUM];
+    UfsCq *cq[UFS_MAX_MCQ_QNUM];
 } UfsHc;
 
+static inline uint32_t ufs_mcq_sq_tail(UfsHc *u, uint32_t qid)
+{
+    return u->mcq_op_reg[qid].sq.tp;
+}
+
+static inline void ufs_mcq_update_sq_tail(UfsHc *u, uint32_t qid, uint32_t db)
+{
+    u->mcq_op_reg[qid].sq.tp = db;
+}
+
+static inline uint32_t ufs_mcq_sq_head(UfsHc *u, uint32_t qid)
+{
+    return u->mcq_op_reg[qid].sq.hp;
+}
+
+static inline void ufs_mcq_update_sq_head(UfsHc *u, uint32_t qid, uint32_t db)
+{
+    u->mcq_op_reg[qid].sq.hp = db;
+}
+
+static inline bool ufs_mcq_sq_empty(UfsHc *u, uint32_t qid)
+{
+    return ufs_mcq_sq_tail(u, qid) == ufs_mcq_sq_head(u, qid);
+}
+
+static inline uint32_t ufs_mcq_cq_tail(UfsHc *u, uint32_t qid)
+{
+    return u->mcq_op_reg[qid].cq.tp;
+}
+
+static inline void ufs_mcq_update_cq_tail(UfsHc *u, uint32_t qid, uint32_t db)
+{
+    u->mcq_op_reg[qid].cq.tp = db;
+}
+
+static inline uint32_t ufs_mcq_cq_head(UfsHc *u, uint32_t qid)
+{
+    return u->mcq_op_reg[qid].cq.hp;
+}
+
+static inline void ufs_mcq_update_cq_head(UfsHc *u, uint32_t qid, uint32_t db)
+{
+    u->mcq_op_reg[qid].cq.hp = db;
+}
+
+static inline bool ufs_mcq_cq_empty(UfsHc *u, uint32_t qid)
+{
+    return ufs_mcq_cq_tail(u, qid) == ufs_mcq_cq_head(u, qid);
+}
+
 #define TYPE_UFS "ufs"
 #define UFS(obj) OBJECT_CHECK(UfsHc, (obj), TYPE_UFS)
 
diff --git a/include/block/ufs.h b/include/block/ufs.h
index 3513b6e772..92da7a89b9 100644
--- a/include/block/ufs.h
+++ b/include/block/ufs.h
@@ -152,7 +152,8 @@ REG32(MCQCONFIG, offsetof(UfsReg, mcqconfig))
     FIELD(MCQCONFIG, MAC, 8, 8)
 
 #define UFS_INTR_MASK                                    \
-    ((1 << R_IS_CEFES_SHIFT) | (1 << R_IS_SBFES_SHIFT) | \
+    ((1 << R_IS_CQES_SHIFT) |                            \
+     (1 << R_IS_CEFES_SHIFT) | (1 << R_IS_SBFES_SHIFT) | \
      (1 << R_IS_HCFES_SHIFT) | (1 << R_IS_UTPES_SHIFT) | \
      (1 << R_IS_DFES_SHIFT) | (1 << R_IS_UCCS_SHIFT) |   \
      (1 << R_IS_UTMRCS_SHIFT) | (1 << R_IS_ULSS_SHIFT) | \
@@ -242,6 +243,21 @@ typedef struct QEMU_PACKED UfsMcqCqIntReg {
 REG32(CQIS, offsetof(UfsMcqCqIntReg, is))
     FIELD(CQIS, TEPS, 0, 1)
 
+/*
+ * Provide MCQ Operation & Runtime Registers as a contiguous addressed
+ * registers for the simplicity.
+ * DAO(Doorbell Address Offset) and  ISAO(Interrupt Status Register Address
+ * Offset) registers should be properly configured with the following
+ * structure.
+ */
+#define UFS_MCQ_OPR_START   0x1000
+typedef struct QEMU_PACKED UfsMcqOpReg {
+    UfsMcqSqReg sq;
+    UfsMcqSqIntReg sq_int;
+    UfsMcqCqReg cq;
+    UfsMcqCqIntReg cq_int;
+} UfsMcqOpReg;
+
 typedef struct QEMU_PACKED DeviceDescriptor {
     uint8_t length;
     uint8_t descriptor_idn;
@@ -1169,6 +1185,11 @@ static inline void _ufs_check_size(void)
 {
     QEMU_BUILD_BUG_ON(sizeof(UfsReg) != 0x38C);
     QEMU_BUILD_BUG_ON(sizeof(UfsMcqReg) != 64);
+    QEMU_BUILD_BUG_ON(sizeof(UfsMcqSqReg) != 20);
+    QEMU_BUILD_BUG_ON(sizeof(UfsMcqCqReg) != 8);
+    QEMU_BUILD_BUG_ON(sizeof(UfsMcqSqIntReg) != 8);
+    QEMU_BUILD_BUG_ON(sizeof(UfsMcqCqIntReg) != 12);
+    QEMU_BUILD_BUG_ON(sizeof(UfsMcqOpReg) != 48);
     QEMU_BUILD_BUG_ON(sizeof(DeviceDescriptor) != 89);
     QEMU_BUILD_BUG_ON(sizeof(GeometryDescriptor) != 87);
     QEMU_BUILD_BUG_ON(sizeof(UnitDescriptor) != 45);
-- 
2.34.1


