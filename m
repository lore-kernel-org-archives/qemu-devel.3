Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5E3EC38150
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 05:07:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRPYB-0006j6-VM; Wed, 10 Jul 2024 01:07:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1sRPYA-0006hU-Av; Wed, 10 Jul 2024 01:07:30 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1sRPY8-000421-Ow; Wed, 10 Jul 2024 01:07:30 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-6bce380eb96so3266196a12.0; 
 Tue, 09 Jul 2024 22:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720588045; x=1721192845; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QtV/HpDsGlHRiSK+Eo0yXW2L1S+bNmLxas6eEVuuszw=;
 b=NwmlxxHFh/N4M7xGxbanmDjqQ5TG5qubKfpT/EGaPtClFBmtJXZkvevFBUlU8EiaQS
 EdfiqD+sGgX71QcFDbmArJfznZsjKMTE/YXKDoD8VWP25yi1zrQKmLResoSw6HQ6De52
 69xHv+PpTDLEDliRWd0FqGb0a7yvPs+oUY+mlZyMqFIv/sSjizLVyWLWFNJfJGqDA+ZE
 0p742gcSexxX/LOaMJE2AgsUHVpTljoy9CCyWIKXD52cHrA2spn85PblGw0YOmPFemNN
 EadJbN+FoT4KW7IrjxCcLBjtc3R9qEdllSdStCdKhEHGg51S+5xHlCJSZnOrNMvhC6Pm
 Hysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720588045; x=1721192845;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QtV/HpDsGlHRiSK+Eo0yXW2L1S+bNmLxas6eEVuuszw=;
 b=lgTeOttZqOWT9YXl7ZXEzYBgpbBhH/22V10VNgQIf9JwmWmngInrPuSJIqju5QnzQ1
 qHbTmcnGqlDbc4Vqlkx9ctUoojNRdXufbu2OXuNBL/mvKbXqaPOcU4B184MxKlPG9Yov
 wJ4liH4WG3YhdR87G8hqBMuLTzRJaXClIXa9s1FE+k997dm8WaWT1saB95A/DIHphz3K
 YBCY6VaCikhHVe6xmv1Tc76neZifcXxfEB66/nDC23g0vBvt0F4a5rbDelem9qWft6wR
 LKrDn/r7Xb77rlvKO6Gbg1F4xSquFgsVU+7XxVyh5MGTtbgHh990yfoers8vCpwX6RG4
 805g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhJc6I6XfyuHARL7+4aQJYEux8P4CQIvAUsEDx4vutxCaarnwNWbx1Zn6Y/2M1yDtv/Psy37L/VBtqFgM/fusjoktBdMM=
X-Gm-Message-State: AOJu0YyKeR3IqyBY5E0y1tHkXI8y+9BNZY12jhoFbyQvhFK+ukeSZ2Ni
 RsI44ouWmxc5FPrZ9o7HE2GtzrXRGDmz2f8P4UVZh8rx5GAZPMK+IlzoRk8l
X-Google-Smtp-Source: AGHT+IGJ6chISogTj8S3qeS9CtpE8xbibNn0Gq9/8RPFFmZJzOS9IkWMacBDENjzd/FnkjMgurh0bw==
X-Received: by 2002:a05:6a20:7f96:b0:1c2:93a7:2556 with SMTP id
 adf61e73a8af0-1c2984cf106mr5078150637.41.1720588045266; 
 Tue, 09 Jul 2024 22:07:25 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([210.223.46.112])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fbb6ac0e2dsm24534465ad.187.2024.07.09.22.07.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jul 2024 22:07:24 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
X-Google-Original-From: Jeuk Kim <jeuk20.kim@samsung.com>
To: qemu-devel@nongnu.org
Cc: jeuk20.kim@samsung.com, qemu-block@nongnu.org, j-young.choi@samsung.com,
 thuth@redhat.com, Zheyu Ma <zheyuma97@gmail.com>,
 Minwoo Im <minwoo.im@samsung.com>
Subject: [PATCH v2] hw/ufs: Fix mcq register range check logic
Date: Wed, 10 Jul 2024 14:07:13 +0900
Message-Id: <d385016cdf34dc17054d8e690034dbf1f9d672ce.1720588007.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pg1-x531.google.com
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

The function ufs_is_mcq_reg() and ufs_is_mcq_op_reg() only evaluated
the range of the mcq_reg and mcq_op_reg offset, which is defined as
a constant. Therefore, it was possible for them to return true
even though the ufs device is configured to not support the mcq.
This could cause ufs_mmio_read()/ufs_mmio_write() to result in
Null-pointer-dereference.
So fix it.

Resolves: #2428
Fixes: 5c079578d2e4 ("hw/ufs: Add support MCQ of UFSHCI 4.0")
Reported-by: Zheyu Ma <zheyuma97@gmail.com>
Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
Reviewed-by: Minwoo Im <minwoo.im@samsung.com>
---
 hw/ufs/ufs.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index 683fff5840..945a0ea127 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -57,14 +57,26 @@ static inline uint64_t ufs_reg_size(UfsHc *u)
 
 static inline bool ufs_is_mcq_reg(UfsHc *u, uint64_t addr, unsigned size)
 {
-    uint64_t mcq_reg_addr = ufs_mcq_reg_addr(u, 0);
+    uint64_t mcq_reg_addr;
+
+    if (!u->params.mcq) {
+        return false;
+    }
+
+    mcq_reg_addr = ufs_mcq_reg_addr(u, 0);
     return (addr >= mcq_reg_addr &&
             addr + size <= mcq_reg_addr + sizeof(u->mcq_reg));
 }
 
 static inline bool ufs_is_mcq_op_reg(UfsHc *u, uint64_t addr, unsigned size)
 {
-    uint64_t mcq_op_reg_addr = ufs_mcq_op_reg_addr(u, 0);
+    uint64_t mcq_op_reg_addr;
+
+    if (!u->params.mcq) {
+        return false;
+    }
+
+    mcq_op_reg_addr = ufs_mcq_op_reg_addr(u, 0);
     return (addr >= mcq_op_reg_addr &&
             addr + size <= mcq_op_reg_addr + sizeof(u->mcq_op_reg));
 }
-- 
2.34.1


