Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F80ACC6B38
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 06:09:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHEe1-0003p8-9s; Thu, 15 Oct 2026 02:08:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <35m3QagoKCmERS9MKDXIGTFNNFKD.BNLPDLT-CDUDKMNMFMT.NQF@flex--stanleyjhu.bounces.google.com>)
 id 1xHEdw-0003oo-0W
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 02:08:44 -0400
Received: from mail-pg1-x546.google.com ([2607:f8b0:4864:20::546])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <35m3QagoKCmERS9MKDXIGTFNNFKD.BNLPDLT-CDUDKMNMFMT.NQF@flex--stanleyjhu.bounces.google.com>)
 id 1xHEdt-0004Id-8X
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 02:08:43 -0400
Received: by mail-pg1-x546.google.com with SMTP id
 41be03b00d2f7-cc1cade6b71so4280856a12.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 23:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792044519; x=1792649319; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=BP2D91D2T47w5fozrvKUMcyoVTR3V2MQvJV2pxRE3N4=;
 b=vVzdskW8oF6d6FeOzpxACrwew+7NDVllaAfZavhomL/baG51Yp0nvqT+peOiG1QFT2
 y64TOIYwI5SygEboMlid1NEINeeTnAZHZsBFXAQlE2UeRg9yUVX4fS6OfLRXZanzKmPI
 /DGz9VLyU/UMkK7T7lPwWL6qZufkuBgvhrhG8bg5McRyv7dc7v+kFqCwpUvjhI0Xe7DI
 dkhGJcSzBq9cGTm76xQZU2q45fnJaMpp8uBXVZ9LZsf/QsI2HmVPGWjwZmJMT64Z7Tuo
 ga3V5GuGThnvqVxUpg2BKaNPyEjYhbbmKIphoMD2WdmitRiyV0+z20FMROnsH4so8lHI
 dggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792044519; x=1792649319;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BP2D91D2T47w5fozrvKUMcyoVTR3V2MQvJV2pxRE3N4=;
 b=cs9Ls/KjTIIt6EditndrTSqo25+oGyhXJ5VNCVldQn/hBsU4nb8zoEitdKySm8qzUl
 9GDPR9LL5bUaXkG5puQydypTYfDXtOJFlGegv9fTgni6vgvYVAzArmVu45H3jB7AAnMX
 6z3t1IaMLvF6VQONNPOXpZGO8t2zZh8FTANEWLzbiTn/utop+YvA0byCeMgW8FyGGleg
 oul3N0G+auOLgj9SHwgLYu43tzzvpRSOVW5C0GAcytbaZ2i68uxOF7VC6f25kk2lsKzf
 HcnqbrOZ6FCS3cEQneBpsfr2+xwW0E/a1LAa0+P6g6zpAdfh+0v+Gn9Ez7l9XxmU4rF2
 N4lw==
X-Gm-Message-State: AFq9FYJ339DZBKc/8er4zAiIRt6nnMR2slfS8goxridaBOZ1J+jl/u58
 H70m4F0VT7gAfkDVrENME4vAGaWHg88mNZ3GKhbBZGj/+hlbe5y6xLb9Flq/HD94khWzjz4rJ/O
 TIG5RUyqf4HRM+41uUCz6pA==
X-Received: from pgbcx11.prod.google.com
 ([2002:a05:6a02:220b:b0:cc7:9d5b:c2a1])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:908f:b0:3de:48ab:3b90 with SMTP id
 adf61e73a8af0-3e16be0f0a9mr11192049637.26.1792044518718; 
 Wed, 14 Oct 2026 23:08:38 -0700 (PDT)
Date: Thu, 15 Oct 2026 14:08:24 +0800
In-Reply-To: <20261015060827.341298-1-stanleyjhu@google.com>
Mime-Version: 1.0
References: <20261015060827.341298-1-stanleyjhu@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261015060827.341298-6-stanleyjhu@google.com>
Subject: [PATCH 5/8] tests/qtest/ufs-test: Add TMR and async MCQ SCSI
 submission helpers
From: Stanley Jhu <stanleyjhu@google.com>
To: Jeuk Kim <jeuk20.kim@samsung.com>, Jeuk Kim <jeuk20.kim@gmail.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Jinyoung Choi <j-young.choi@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::546;
 envelope-from=35m3QagoKCmERS9MKDXIGTFNNFKD.BNLPDLT-CDUDKMNMFMT.NQF@flex--stanleyjhu.bounces.google.com;
 helo=mail-pg1-x546.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

Add ufs_send_tmr() and ufs_mcq_send_scsi_cmd_async() helper functions
in preparation for UTMRL task management and QOM fault injection unit
tests.

Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
---
 tests/qtest/ufs-test.c | 52 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/tests/qtest/ufs-test.c b/tests/qtest/ufs-test.c
index 9a9c5ca834..d8329d1409 100644
--- a/tests/qtest/ufs-test.c
+++ b/tests/qtest/ufs-test.c
@@ -1673,6 +1673,58 @@ static void ufstest_hid(void *obj, void *data, QGuestAllocator *alloc)
     ufs_exit(ufs, alloc);
 }
 
+static G_GNUC_UNUSED void ufs_send_tmr(QUfs *ufs, uint64_t utmrlba, int slot,
+                                       uint8_t tm_func, uint8_t lun,
+                                       uint32_t task_tag,
+                                       UtpTaskReqDesc *utrd_out)
+{
+    uint64_t desc_addr = utmrlba + slot * sizeof(UtpTaskReqDesc);
+    UtpTaskReqDesc desc = { 0 };
+
+    desc.header.dword_0 = cpu_to_le32(UFS_UTP_REQ_DESC_INT_CMD);
+    desc.header.dword_2 = cpu_to_le32(UFS_OCS_INVALID_COMMAND_STATUS);
+
+    desc.upiu_req.req_header.trans_type = UFS_UPIU_TRANSACTION_TASK_REQ;
+    desc.upiu_req.req_header.query_func = tm_func;
+    desc.upiu_req.req_header.lun = lun;
+    desc.upiu_req.req_header.task_tag = 0x10 + slot;
+    desc.upiu_req.input_param1 = cpu_to_be32(lun);
+    desc.upiu_req.input_param2 = cpu_to_be32(task_tag);
+
+    qtest_memwrite(ufs->dev.bus->qts, desc_addr, &desc, sizeof(desc));
+
+    ufs_wreg(ufs, A_UTMRLDBR, 1 << slot);
+    ufs_wait_for_irq(ufs);
+    g_assert_true(FIELD_EX32(ufs_rreg(ufs, A_IS), IS, UTMRCS));
+    ufs_wreg(ufs, A_IS, FIELD_DP32(0, IS, UTMRCS, 1));
+    g_assert_cmpuint(ufs_rreg(ufs, A_UTMRLDBR) & (1 << slot), ==, 0);
+
+    qtest_memread(ufs->dev.bus->qts, desc_addr, utrd_out, sizeof(*utrd_out));
+}
+
+static G_GNUC_UNUSED int ufs_mcq_send_scsi_cmd_async(QUfs *ufs, uint8_t lun,
+                                                     const uint8_t *cdb)
+{
+    int cmd_desc_slot = alloc_cmd_desc_slot(ufs);
+    uint64_t req_upiu_addr =
+        ufs->cmd_desc_addr + cmd_desc_slot * UTP_COMMAND_DESCRIPTOR_SIZE;
+    UtpUpiuReq req_upiu = { 0 };
+    UtpTransferReqDesc utrd;
+
+    req_upiu.header.trans_type = UFS_UPIU_TRANSACTION_COMMAND;
+    req_upiu.header.flags = UFS_UPIU_CMD_FLAGS_NONE;
+    req_upiu.header.lun = lun;
+    req_upiu.header.task_tag = cmd_desc_slot;
+    memcpy(req_upiu.sc.cdb, cdb, UFS_CDB_SIZE);
+    qtest_memwrite(ufs->dev.bus->qts, req_upiu_addr, &req_upiu,
+                   sizeof(req_upiu));
+
+    utrd = ufs_build_req_utrd(req_upiu_addr, UFS_UTP_NO_DATA_TRANSFER, 0);
+    __ufs_send_transfer_request_mcq_async(ufs, lun, &utrd);
+
+    return cmd_desc_slot;
+}
+
 static void ufs_register_nodes(void)
 {
     const char *arch;
-- 
2.56.0.385.gd3acb90ef8-goog


