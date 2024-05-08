Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEC73C19F4F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 13:15:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4h5t-0005EJ-3Z; Wed, 08 May 2024 09:12:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1s4dl0-0007mw-P0
 for qemu-devel@nongnu.org; Wed, 08 May 2024 05:38:38 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1s4dky-0000bA-4S
 for qemu-devel@nongnu.org; Wed, 08 May 2024 05:38:37 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1ee0132a6f3so27414645ad.0
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 02:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1715161115; x=1715765915; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RLmdC7xgHK3n63q1edNAVO95cmP2mjRHETTCOF2flbQ=;
 b=CfKjj8WRWhC6XVOLeoMcv1G01FLEE1qwRpvxtv8aQ3EUM/+4qnh39RJNZmxwsrbUhH
 vfQ+TaWk4Bky2RnEifaIOOt0cFFBTD0BS7q7FD/0OK5MjL+HVUboiHK2DIi6PqKMpbI/
 snTlWBXfWXyMB+z7FxzJdmaIpM9J1FwT1QC/l9XyvYzfmLFrl2gXLkdnv9RKX5Dz/PbZ
 XF8YE/K3jHCIv4jhH88LTYZBcTj+IQ/iKMpYO4YVKbPJrP1hEtTJ+eXiK7aGpHW9fT1y
 IM35ZMLRvNBiQvfQqWkaHN8o1ENdKU0aHZENSdkPq4wZqUz/zaqCyk1ZURhVS9fTTktU
 oHvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715161115; x=1715765915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RLmdC7xgHK3n63q1edNAVO95cmP2mjRHETTCOF2flbQ=;
 b=VBzweRjOpF2yY190vY68ZCNw76/7VbuKlwJcRbs6CC7Nbb3+oKPytqmXAxEI0+5enK
 zZKD07BOdqOeR5bE8qK1MPxmBlQ71SO10sCfw0UTpF8VjcDLerHyeyVs4o0+BtTKdq1R
 GzpPWXqihEbWhZstL11E7QH3/05J9gznNO7M8jaesoN21KcMztdWyZ4Se37OfAubqHkq
 NLr663bBdYxYnVYvBw9t4wELBn8q/8DDlBYLPAJA4jcpK9/g7BIQhrA/Xbu0FdPkj8WE
 o9YhXGJ6g6S7rUTIzUjN1ccomKaPDbDjL7h8N5YgkmDR5aULQljw9cDxzdK/8FmvbDZ+
 RuRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQwzswGchIWYMbhIT6sbI+2bAZILDotnCHUnh0SgQEyzYUe7PA1dRgf38XyMwFf9FuDKnti4Ot0bYo/IdHPTTJPdZtX4A=
X-Gm-Message-State: AOJu0Yw/pSqJPAw8wCsYRA7ZhYP3nGqQDUJqYhRaQdbln7mlM0FtYbVJ
 vf002Aczc7e6YhFyoPlVqWWRj1zfbqSzsJhXOaFyA+gI7d9O+9n52gwfgnd1VMc=
X-Google-Smtp-Source: AGHT+IGiQVmoghL6gesnyA9ypkJn2wokeKSw7nKcC10NA6sZ5iYgjXdmtulOk9J+mfI71azCJd/shw==
X-Received: by 2002:a17:902:eb55:b0:1eb:704c:43b3 with SMTP id
 d9443c01a7336-1eeb039e93fmr20501085ad.24.1715161114721; 
 Wed, 08 May 2024 02:38:34 -0700 (PDT)
Received: from n37-006-243.byted.org ([180.184.51.134])
 by smtp.gmail.com with ESMTPSA id
 p16-20020a1709027ed000b001ee13eb2bedsm4992178plb.98.2024.05.08.02.38.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 May 2024 02:38:34 -0700 (PDT)
From: Changqi Lu <luchangqi.123@bytedance.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 Changqi Lu <luchangqi.123@bytedance.com>,
 zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH 7/9] hw/nvme: add helper functions for converting reservation
 types
Date: Wed,  8 May 2024 17:36:27 +0800
Message-Id: <20240508093629.441057-8-luchangqi.123@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240508093629.441057-1-luchangqi.123@bytedance.com>
References: <20240508093629.441057-1-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 08 May 2024 09:12:22 -0400
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


