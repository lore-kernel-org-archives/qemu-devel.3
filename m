Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27E60C25B78
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2024 09:54:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7uGq-0002JH-FV; Fri, 17 May 2024 05:53:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1s7uGn-0002Id-TD
 for qemu-devel@nongnu.org; Fri, 17 May 2024 05:52:57 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1s7uGm-0006Pl-8m
 for qemu-devel@nongnu.org; Fri, 17 May 2024 05:52:57 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-53fa455cd94so975421a12.2
 for <qemu-devel@nongnu.org>; Fri, 17 May 2024 02:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1715939575; x=1716544375; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iZOIOSzWw7S5O/W1X23ZvIZbIDRDARXSDRkqo9S5Wbo=;
 b=Ki66xKssI/xrW56X4GZixv9fq19SSfXkjtLI6kN2X5TVZwl8kotrLfKcnr8aSpm5ZN
 /F/LqZWV+EWU7fIgU+4spssxf44keCzxuAw3EnCJYjIsECQNeWpp8i/v8bTKOVyh0XwB
 1PUeGgUCqe1JWKdJbyN7fABh6Z6wSxipWe156HYHGcJP1NlTF7irzLB9z/tbYdPyKjvH
 JrWtPOrwZrluIrGWv0Mwy/NmTd9x87bfxXKifv1Y4l8hccozyy+0NozIb6IxmZrcB+LK
 RpfI2b2J2VO2Mc7XpdP0JdFWfBAT7AJtBOS5FYG1Ioa0gDg4V7KWG3y9D/AGSOkVRRv/
 vYcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715939575; x=1716544375;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iZOIOSzWw7S5O/W1X23ZvIZbIDRDARXSDRkqo9S5Wbo=;
 b=nD4WRtEiELSCVcC1DMKN1IWzelRQ2f1+e3LnZL3q2GqFmN3fiGnBbQ4YeD9X7rTE/b
 /IVDB0U2W5eanuWb2wB5oxj/hSWG+B0OBfFDjDzL1Hs0rIQhU/3u6PMz8UXuUl1Q8CJ7
 u/+/eJo6nRF52FiXOCf5dB2Pg4OwUPyQx6EntCccTA65rFQTpFaLsGcRZMEdFWHJiSc4
 zI9PS8wnIFLNbD8nsKkrLjcM3O09tk0II3Nd9sfuQEk0Ume09RzpszyUMVyy/cm9yFi4
 0U8gsJT19P1FP8LxYNq1D4MO8CAL0BIZMDn5irlsjwsmUHccMxXWbuCFjAN377SlmzAp
 I0uA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCtg9108vAsDh2sbnNTu1YFDq0HCso30GkY6ctabxgksBsmPKg5y4LGogApkM1GLZyjjx8HCyo+Wz0NSnPpWhvrTEICAY=
X-Gm-Message-State: AOJu0YyCJECuHOq6Ysa9LY08pjQx0KCB9ExAl9bdLKTUNHS+3IwagfXJ
 C0HGo+QYGrpopubURlpKDTOWqtbNBtWmCPADAG6b+mC8aqJwn3gicW5+mbVjPhs=
X-Google-Smtp-Source: AGHT+IFfCKP10yietJFmlfPErr/wBiyYhmkqZuoILVCnXYvWY/jmFJSOCG7TKa5nonuP6aojFG2AMw==
X-Received: by 2002:a17:90a:fb4c:b0:2b5:af18:4222 with SMTP id
 98e67ed59e1d1-2b6ccef64b2mr17104038a91.44.1715939574954; 
 Fri, 17 May 2024 02:52:54 -0700 (PDT)
Received: from n37-006-243.byted.org ([180.184.51.134])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2b628ca53cesm16975992a91.44.2024.05.17.02.52.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 May 2024 02:52:54 -0700 (PDT)
From: Changqi Lu <luchangqi.123@bytedance.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com, Changqi Lu <luchangqi.123@bytedance.com>
Subject: [PATCH v3 07/11] hw/nvme: add helper functions for converting
 reservation types
Date: Fri, 17 May 2024 17:52:14 +0800
Message-Id: <20240517095218.3107672-8-luchangqi.123@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240517095218.3107672-1-luchangqi.123@bytedance.com>
References: <20240517095218.3107672-1-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-pg1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

This commit introduces two helper functions
that facilitate the conversion between the
reservation types used in the NVME protocol
and those used in the block layer.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Changqi Lu <luchangqi.123@bytedance.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 hw/nvme/nvme.h | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index bed8191bd5..6abe479410 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -474,6 +474,46 @@ static inline const char *nvme_io_opc_str(uint8_t opc)
     }
 }
 
+static inline NVMEResvType block_pr_type_to_nvme(BlockPrType type)
+{
+    switch (type) {
+    case BLK_PR_WRITE_EXCLUSIVE:
+        return NVME_RESV_WRITE_EXCLUSIVE;
+    case BLK_PR_EXCLUSIVE_ACCESS:
+        return NVME_RESV_EXCLUSIVE_ACCESS;
+    case BLK_PR_WRITE_EXCLUSIVE_REGS_ONLY:
+        return NVME_RESV_WRITE_EXCLUSIVE_REGS_ONLY;
+    case BLK_PR_EXCLUSIVE_ACCESS_REGS_ONLY:
+        return NVME_RESV_EXCLUSIVE_ACCESS_REGS_ONLY;
+    case BLK_PR_WRITE_EXCLUSIVE_ALL_REGS:
+        return NVME_RESV_WRITE_EXCLUSIVE_ALL_REGS;
+    case BLK_PR_EXCLUSIVE_ACCESS_ALL_REGS:
+        return NVME_RESV_EXCLUSIVE_ACCESS_ALL_REGS;
+    }
+
+    return 0;
+}
+
+static inline BlockPrType nvme_pr_type_to_block(NVMEResvType type)
+{
+    switch (type) {
+    case NVME_RESV_WRITE_EXCLUSIVE:
+        return BLK_PR_WRITE_EXCLUSIVE;
+    case NVME_RESV_EXCLUSIVE_ACCESS:
+        return BLK_PR_EXCLUSIVE_ACCESS;
+    case NVME_RESV_WRITE_EXCLUSIVE_REGS_ONLY:
+        return BLK_PR_WRITE_EXCLUSIVE_REGS_ONLY;
+    case NVME_RESV_EXCLUSIVE_ACCESS_REGS_ONLY:
+        return BLK_PR_EXCLUSIVE_ACCESS_REGS_ONLY;
+    case NVME_RESV_WRITE_EXCLUSIVE_ALL_REGS:
+        return BLK_PR_WRITE_EXCLUSIVE_ALL_REGS;
+    case NVME_RESV_EXCLUSIVE_ACCESS_ALL_REGS:
+        return BLK_PR_EXCLUSIVE_ACCESS_ALL_REGS;
+    }
+
+    return 0;
+}
+
 typedef struct NvmeSQueue {
     struct NvmeCtrl *ctrl;
     uint16_t    sqid;
-- 
2.20.1


