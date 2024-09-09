Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBBB5ECE579
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 11:37:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sncgV-0003Hl-6b; Mon, 09 Sep 2024 07:35:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sncgK-0002hG-Uu
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 07:35:46 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sncgF-00016R-Pr
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 07:35:42 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2055136b612so50333465ad.0
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 04:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1725881738; x=1726486538; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tjqh17JUE1WkBpchsBFPlHMHCUXRZeQxBDgeEciSrXM=;
 b=fovf+5y1CFPoyazgk68ACbAmvjOLYTnSuF3c8EEOL4HIXYkxOddOhPy35QW6hl+PVd
 1g+gMbFLYPUYGN1NexiqJS0xsFB3lW5w3K3+8ml+XDp8MEM0N2TKCzNHlyyz9Gz7b0HP
 CDlqeav3CDDJrWBMrM/uR6528c0kUXvKOXBCpyNKo5RNmKbCZcYg/KMOHmc1C7LY3QND
 hYBaQLwOJUPlvouy5EYPb1KlsWBA1i0ZLrRAbyGLlSE2SZyCjD7jul35xEUSbVkvO+RV
 MnHgysZSDsCgFG0R8Wutr4tQCCG/CIkl7LsoV6ox3fM3m9DXj7fjezci28qnLNbds/uc
 rCag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725881738; x=1726486538;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tjqh17JUE1WkBpchsBFPlHMHCUXRZeQxBDgeEciSrXM=;
 b=mIQjCsHpXeiIf42ig/6sRPTIeVoxvxolVtLAjmnDpRm3zVPImvXKVUhhp3QUvNWZ60
 Ker/cdr5iM1JsDm1WQ2aOQtosRc5PrztYZcywH6NxLyLhDS0tMNP9VVO8LEJDUw4rDSW
 AncfMYo6Lhqyi+F4W34D+0H8gFKceT+Dsyur8irVY2vBxyasOW88e5cp0wnihia+SS+T
 3JfBo4e2HxY5VtvVwH6PEZh8VZP1OyLgLJaKtnjBDN7RECDM9QAYycxujOOhSiUDC5OW
 G0ZNZ9y2u6JXTCeNtrG6yrw6awHsrwUtv01Hhj/GdRMh+9Ly4fMkcuJE7iLzRlIoZV9u
 QShA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOuK2vGyTFRy1Fc/RnCmz+y2HPaCH9DMv7CZPQBqGXxIaA0yO+69ijeClmRyN7PC2+Snl322empI8L@nongnu.org
X-Gm-Message-State: AOJu0YxfZiRoqs7Yx/qToIz1sJl0aAQjsEM7PY9PjTLEi5ulMFSGzhaX
 1Rds4YezvI3MqKFi01ZnyhHyHdcXkyDVCsWj7M9Y5bX79uXEDHQIYGvan963eSY=
X-Google-Smtp-Source: AGHT+IEkOJEdI7O9jktVB01C8D1rBMJfHWnq9uytx+QieGGCZTPAPc1PatogovAzscxVJU3oaPWimQ==
X-Received: by 2002:a17:902:ecc2:b0:202:100f:7b99 with SMTP id
 d9443c01a7336-206f0529ea9mr172591675ad.22.1725881738028; 
 Mon, 09 Sep 2024 04:35:38 -0700 (PDT)
Received: from TF4D9JK212.bytedance.net ([61.213.176.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710e328aasm32378605ad.91.2024.09.09.04.35.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Sep 2024 04:35:37 -0700 (PDT)
From: Changqi Lu <luchangqi.123@bytedance.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com, k.jensen@samsung.com,
 Changqi Lu <luchangqi.123@bytedance.com>
Subject: [PATCH v11 07/10] hw/nvme: add helper functions for converting
 reservation types
Date: Mon,  9 Sep 2024 19:34:50 +0800
Message-Id: <20240909113453.64527-8-luchangqi.123@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20240909113453.64527-1-luchangqi.123@bytedance.com>
References: <20240909113453.64527-1-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-pl1-x634.google.com
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

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Changqi Lu <luchangqi.123@bytedance.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 hw/nvme/nvme.h | 84 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index bed8191bd5..6d0e456348 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -474,6 +474,90 @@ static inline const char *nvme_io_opc_str(uint8_t opc)
     }
 }
 
+static inline NvmeResvType block_pr_type_to_nvme(BlockPrType type)
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
+static inline BlockPrType nvme_pr_type_to_block(NvmeResvType type)
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
+static inline uint8_t nvme_pr_cap_to_block(uint16_t nvme_pr_cap)
+{
+    uint8_t res = 0;
+
+    res |= (nvme_pr_cap & NVME_PR_CAP_PTPL) ?
+           NVME_PR_CAP_PTPL : 0;
+    res |= (nvme_pr_cap & NVME_PR_CAP_WR_EX) ?
+           BLK_PR_CAP_WR_EX : 0;
+    res |= (nvme_pr_cap & NVME_PR_CAP_EX_AC) ?
+           BLK_PR_CAP_EX_AC : 0;
+    res |= (nvme_pr_cap & NVME_PR_CAP_WR_EX_RO) ?
+           BLK_PR_CAP_WR_EX_RO : 0;
+    res |= (nvme_pr_cap & NVME_PR_CAP_EX_AC_RO) ?
+           BLK_PR_CAP_EX_AC_RO : 0;
+    res |= (nvme_pr_cap & NVME_PR_CAP_WR_EX_AR) ?
+           BLK_PR_CAP_WR_EX_AR : 0;
+    res |= (nvme_pr_cap & NVME_PR_CAP_EX_AC_AR) ?
+           BLK_PR_CAP_EX_AC_AR : 0;
+
+    return res;
+}
+
+static inline uint8_t block_pr_cap_to_nvme(uint8_t block_pr_cap)
+{
+    uint16_t res = 0;
+
+    res |= (block_pr_cap & BLK_PR_CAP_PTPL) ?
+              NVME_PR_CAP_PTPL : 0;
+    res |= (block_pr_cap & BLK_PR_CAP_WR_EX) ?
+              NVME_PR_CAP_WR_EX : 0;
+    res |= (block_pr_cap & BLK_PR_CAP_EX_AC) ?
+              NVME_PR_CAP_EX_AC : 0;
+    res |= (block_pr_cap & BLK_PR_CAP_WR_EX_RO) ?
+              NVME_PR_CAP_WR_EX_RO : 0;
+    res |= (block_pr_cap & BLK_PR_CAP_EX_AC_RO) ?
+              NVME_PR_CAP_EX_AC_RO : 0;
+    res |= (block_pr_cap & BLK_PR_CAP_WR_EX_AR) ?
+              NVME_PR_CAP_WR_EX_AR : 0;
+    res |= (block_pr_cap & BLK_PR_CAP_EX_AC_AR) ?
+              NVME_PR_CAP_EX_AC_AR : 0;
+
+    return res;
+}
+
 typedef struct NvmeSQueue {
     struct NvmeCtrl *ctrl;
     uint16_t    sqid;
-- 
2.20.1


