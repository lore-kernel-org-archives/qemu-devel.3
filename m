Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3AA606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 07:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=h0B/+eLK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJnUX-0007Jy-QV; Thu, 22 Oct 2026 03:45:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3Gr_ZagoKCl0NO5IG9TECPBJJBG9.7JHL9HP-89Q9GIJIBIP.JMB@flex--stanleyjhu.bounces.google.com>)
 id 1xJnUU-0007IQ-Pt
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 03:45:34 -0400
Received: from mail-pg1-x545.google.com ([2607:f8b0:4864:20::545])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3Gr_ZagoKCl0NO5IG9TECPBJJBG9.7JHL9HP-89Q9GIJIBIP.JMB@flex--stanleyjhu.bounces.google.com>)
 id 1xJnUT-0002Hq-1O
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 03:45:34 -0400
Received: by mail-pg1-x545.google.com with SMTP id
 41be03b00d2f7-cd3b9e70f88so1746245a12.0
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 00:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792655131; x=1793259931; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=QW4je3U/3zyQLhRvG412cMinFBcQ+6FyWD2o0c1N0B0=;
 b=h0B/+eLKMlPWnw+ynpgDxmMu4lf6ZMF/BhuokrWAErzG2GxbTPxOyxDmDEmNpbS+jS
 MtAdgyXAjyXR+aYdEHspc1DJakkE60zRhwgtqX9tfGP3LE99LggE+m5AdSX3YRBGclF0
 B5w6pIicqlm4eLVP9gns1buEwrb4ag1ICuC2TD5VmdnFB6uovx8KOU+Lr60D3spq97AL
 SVyiVXhyg1SV8MntwkpFZgu24nj97D55XdQ/J4Tnl6ImxvlD7zF9bvHKzHWpmsyQcek4
 cPdkwDJqQQapyk3XBFUvCgqqKOb25IMufbNKAgXr/0Kcfbi25cfWAJh46zkBGWrXT3nU
 5JZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792655131; x=1793259931;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QW4je3U/3zyQLhRvG412cMinFBcQ+6FyWD2o0c1N0B0=;
 b=eAhlEd+AeDzhfsGDDMkflayuhcHOKzK0rKksw2yEWs8OwQuhcb9z6ok3GpxSVXPE09
 HKJ4EEp4NutJwvmUPP2Ar+xyz6NDI7806SZ7HmD5QxB7U7J+og8RboARS6PEEhbrSr88
 LvAl1dkIwZTsnyRnOTIj51sw4QghH/+xeHJxNr8cdzcjbgF2RzB3ECPkT2XdYr3LlWm1
 Cj04DUFQlFDpa6ZIBLCSaatjtd23pBEaLF9Ne1GYIXxn/BRb4kUJwT5E9kpaG0JXQFwr
 HF9wsGAIHov/QlDys5VTb+5qxZcuVDm0R4qPi7uoOiz44VzrmfW9cJIl7IeOa+rm9a8M
 U2Jw==
X-Gm-Message-State: AFq9FYIFiJwnpn5tyVfmKQlvi4bx9+h5WVRW/N2leNP+ssggvOMhZrVU
 R5yVZOJDigUVnsilC+NqUJ68edYmAKe6a/ojlyYkYoN7t1c0MXHDPER2VegkoV7NfbkAUvbvm0c
 rOYqz8R9t6a0YA6M8/D7wKA==
X-Received: from pgdu13.prod.google.com ([2002:a05:6a02:2f4d:b0:cc9:5e28:9460])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:918a:b0:3e1:a769:9620 with SMTP id
 adf61e73a8af0-3e287f3c888mr3850796637.71.1792655130904; 
 Thu, 22 Oct 2026 00:45:30 -0700 (PDT)
Date: Thu, 22 Oct 2026 15:45:10 +0800
In-Reply-To: <20261022074513.2292281-1-stanleyjhu@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261022074513.2292281-1-stanleyjhu@google.com>
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
Message-ID: <20261022074513.2292281-6-stanleyjhu@google.com>
Subject: [PATCH v2 5/8] tests/qtest/ufs-test: Add TMR and async MCQ SCSI
 submission helpers
From: Stanley Jhu <stanleyjhu@google.com>
To: Jeuk Kim <jeuk20.kim@samsung.com>, Jeuk Kim <jeuk20.kim@gmail.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Jinyoung Choi <j-young.choi@samsung.com>,
 Daejun Park <daejun7.park@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::545;
 envelope-from=3Gr_ZagoKCl0NO5IG9TECPBJJBG9.7JHL9HP-89Q9GIJIBIP.JMB@flex--stanleyjhu.bounces.google.com;
 helo=mail-pg1-x545.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add ufs_send_tmr() and ufs_mcq_send_scsi_cmd_async() helper functions
in preparation for UTMRL task management and QOM fault injection unit
tests.

Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
---
 tests/qtest/ufs-test.c | 53 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/tests/qtest/ufs-test.c b/tests/qtest/ufs-test.c
index e24caa2efc..f577fe2614 100644
--- a/tests/qtest/ufs-test.c
+++ b/tests/qtest/ufs-test.c
@@ -1899,6 +1899,59 @@ static void ufstest_hid(void *obj, void *data, QGuestAllocator *alloc)
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
+
 #define ZONE_SIZE (2 * 1024 * 1024)
 #define ZONE_BLOCKS (ZONE_SIZE / 4096)
 #define MAX_OPEN_ZONE 6
-- 
2.56.0.218.g1ec904b173-goog


