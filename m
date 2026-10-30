Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E20606A31D
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 08:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i+VtY5+f
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMhm0-0006XS-Hz; Fri, 30 Oct 2026 04:15:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1xMhls-0006R0-0O
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 04:15:36 -0400
Received: from mail-dl1-x1231.google.com ([2607:f8b0:4864:20::1231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1xMhlm-0001br-6a
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 04:15:31 -0400
Received: by mail-dl1-x1231.google.com with SMTP id
 a92af1059eb24-1438d9363fbso345169c88.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 01:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793348124; x=1793952924; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UpU5RDRKzNoJvyj8f8RzWBQ1TwN1Z6+4TWa8z4piMBk=;
 b=i+VtY5+f6ShVF/Qax5qWzQRg4qYVpdpA8WNGBO8BTg1o7DFc8sKMperVOdhQuXH5IP
 qVXpyR0pGNvHh4FYvyJV4AigazJWDI+o57PmaW5Iio3V2PkE2T3N8F8eYjb67iws1D+s
 Xvb7HYF0hlS8rtGR493VUbTJYNzMVuEnvob60M6Q2vq1k4zxfaqKTsBVqNX5CCa8vCZk
 yiqTxMexaDN9CfKqrxSlFcIndtK3UsUuJBQ4j5G+nZYtJD2DdFXRJdzO7ljUe5L4MKhP
 jUegnWz6Upmy5sNYrTI1f6vFxHKVpRiCQi/r4F6x3+2BpUCem7OICBNqHLWYGd1XYg6u
 Dfug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793348124; x=1793952924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=UpU5RDRKzNoJvyj8f8RzWBQ1TwN1Z6+4TWa8z4piMBk=;
 b=J090Xh6dc1GysbG8U8OHcot/QEUBPWQmkFspPPj70TaYWGc3u/hCRXJ7wUl9UA+6uG
 ePu7t7nCqx1M1m/dsjonsDvNdBEA1NG8VjaP+76r4w18JIXVsXh/YRV0XnPV7WCr8NqG
 d0eYohDrrtGD7ymJFnhoWh2hXOW7X0S/4vlCP3Q1mxV3IRw5ET8QmRj7FK1SHzD7VvOj
 7bdIxD7bhwdaI+d1rYk5K1f/knR0lfAfHPfyXRWxyRHpZiQvNILw6KVoYj8p9YhHbn+A
 hqFAC3wAZjEvWBmRMISeTreGGjOotY0lrw+cB+ZofbiSL2URX3ntaIqbbA+3w5Ujfp3H
 rIBw==
X-Gm-Message-State: AFq9FYKUN2p9Tzi6UQwycNMziMYdkCKocpnuTyVUzCskqgLvbtxxpYOq
 wIX2n9V2xCWRPClJi5J7juM2hjjMIN9V2kbCLe/8o9cuPmZlqQnvqViNeIh1Wg==
X-Gm-Gg: AYBFou0Yx7RR4ttTK3ukOhm+1kO7Gl8uTVOHnc8DFhxDerIBw1oTHk/of/gekd04U4a
 bSDREf08nr/z3AF8S9HmZtdYlkr/be3DWmRSphr3tHm8RbxzrjyJDcqGKlaVmM3Uefbzv/IUlRP
 HnWye4tVdPTVSWYoTpk65+bFGpKe2xlLva04LBq1z5MMtbELcupI/s5Pt3MGmOWBUHAavdMm6YQ
 Jt5T/u6ahs3+nmhNPxTcWCaYY07aX2CSl47Zq+/imUzdK1KkVILK0ywuxZsvDjBQ4iCGMDEHAgo
 8ORhAo9ogQRRKPyxqrjZR2YIYZIdgPfdystM/wn4n/JLsqOZb+KvHvfBTbew3X9T502xwKSmmyC
 h+AcGL1iKtZJUer+5nBBpHLVq8F3pA9a5jIjLiq8qUw2DspVk3hbFow4QPxoOutnYdcVnH+1zTD
 99/ViKQ/rowBBnV861bGHgbTCdwECskRZApecIsZ0NHMxvKTYC3JwAnwcBJXA+DwD16iHVlhiN7
 NNuHn/C6BzLqBSJNOfkYA6oCeBlnJ/Rs03u32ciV4ZbseBvYtURrgdMH4a1tSCCJhwtxPjllbEp
 Bf4ly04TQn+pICfghBs+Cip/SO4bl7smFRn/d6z0ZXbyrFgpuWJjA/rDSVL3HIJOIg==
X-Received: by 2002:a05:701b:2710:b0:196:7590:8bed with SMTP id
 a92af1059eb24-1ac55960a88mr2309924c88.2.1793348124495; 
 Fri, 30 Oct 2026 01:15:24 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([211.226.54.223])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac193b8179sm5905766c88.11.2026.10.30.01.15.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 01:15:23 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: qemu-devel@nongnu.org,
	richard.henderson@linaro.org
Cc: stefanha@redhat.com, pbonzini@redhat.com, fam@euphon.net, kwolf@redhat.com,
 hreitz@redhat.com, qemu-block@nongnu.org, daejun7.park@samsung.com,
 stanleyjhu@google.com, dridiha98@gmail.com, jeuk20.kim@samsung.com,
 j-young.choi@samsung.com
Subject: [PULL 09/12] tests/qtest/ufs-test: Add TMR and async MCQ SCSI
 submission helpers
Date: Fri, 30 Oct 2026 17:14:35 +0900
Message-ID: <4da9629dd63c9d92056608b9bbea446004f55431.1793347487.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793347487.git.jeuk20.kim@samsung.com>
References: <cover.1793347487.git.jeuk20.kim@samsung.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1231;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-dl1-x1231.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Stanley Jhu <stanleyjhu@google.com>

Add ufs_send_tmr() and ufs_mcq_send_scsi_cmd_async() helper functions
in preparation for UTMRL task management and QOM fault injection unit
tests.

Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
Reviewed-by: Jeuk Kim <jeuk20.kim@samsung.com>
Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
---
 tests/qtest/ufs-test.c | 53 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/tests/qtest/ufs-test.c b/tests/qtest/ufs-test.c
index e8993e8c246..2914723430c 100644
--- a/tests/qtest/ufs-test.c
+++ b/tests/qtest/ufs-test.c
@@ -1899,6 +1899,59 @@ static void ufstest_hid(void *obj, void *data, QGuestAllocator *alloc)
     ufs_exit(ufs, alloc);
 }
 
+static G_GNUC_UNUSED void ufs_send_tmr(QUfs *ufs, uint64_t utmrlba, int slot,
+                         uint8_t tm_func, uint8_t lun,
+                         uint32_t task_tag,
+                         UtpTaskReqDesc *utrd_out)
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
+                                       const uint8_t *cdb)
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
+
 static void ufs_register_nodes(void)
 {
     const char *arch;
-- 
2.43.0


