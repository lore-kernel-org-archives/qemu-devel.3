Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8AF8D0EE12
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 17:24:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szJIr-0001rn-3H; Fri, 11 Oct 2024 13:19:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1szJ7h-0003aE-IV
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 13:08:18 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1szEWN-0004vC-Pa
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 08:13:31 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-20c805a0753so16927935ad.0
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2024 05:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1728648806; x=1729253606; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tjqh17JUE1WkBpchsBFPlHMHCUXRZeQxBDgeEciSrXM=;
 b=b9utYs0/amEyOh566GS5xhCCz11IVtONLnkiqjZtctIaKuq0dXxy9Ej0ZafZC6WT5N
 B70Hlr8poPyl77HevRX1J5pHs4MQVzw/5qIT9y0Yld07pJdOySzWEX9bREMh08uXO6DX
 bazlx7ZQ9A+xVte/ysLr+garDb65RAW6HkkPWvjC9TbKhtNMshxRTJu047lThdsTOvpJ
 3UU2K0MZ4vmntiHPJx8OqCLkWOnRTR1dsMbi65HmNnifq4pouxwplGRzFWBziia8DoeR
 Poftag7fOmgrQh46sUQKbBpNE+K5YXloT4Ke+9I8FcFEG349FcbxXlm04L2LAkThtl2J
 n2bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728648806; x=1729253606;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tjqh17JUE1WkBpchsBFPlHMHCUXRZeQxBDgeEciSrXM=;
 b=VV1Wnt/XTr+0H1dXPWfrdW/qtdST73vOUKZ/3wW836K8tE2e0Cj3xgjv2vgqM8jdDe
 fGnSGn2cf/3T+xORtnNuo/MK/5h9p9hEIVUVt+HYYeJmI/qxav29AyksPtdO+VImTcdc
 1IkU57iIVDNu9qppDMFwVpuea/+pwGcgZwMOJheq+MDOqfCyPjaR3KKSNpJDaHGfruIK
 2cpiKqc73dX7bL7nAzSFOsMuJYOr+Mc68S4z8/7ubQVsc39UoLZthzIbrWbjpDpBPLBo
 pHw3FgOAgpVtCVHWmyRQfy7YVch+Z77/Ij3vAdXp5/VMHBsxNbWqey1J5mUt81qU/oG2
 YSrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeLmr85ffXCvhwPeCIgNK3idycGN3+aSRyF6kXJrLlCnWZqbqc7+olca/lnjGCaOPNsDfVXWfNfrBx@nongnu.org
X-Gm-Message-State: AOJu0Yxv3P31JfmlObjCSHf47gBc05zrS1IP8TrHdV09uCtx8TWaG/2Z
 H5UwxRReRJQNTBSMwwPm90rYTYYUGEK82lVXK97DGPlvScLSheVRSZdOaWOWFJs=
X-Google-Smtp-Source: AGHT+IHr3k/GjowYMBaarGF5ocWNMxBhuHUNF9vLD3vpoOBjQNJwn6N7i9YrHNtn0084x+6Cc74yog==
X-Received: by 2002:a17:902:e845:b0:20b:a6f5:2780 with SMTP id
 d9443c01a7336-20ca1459d58mr42210685ad.17.1728648806488; 
 Fri, 11 Oct 2024 05:13:26 -0700 (PDT)
Received: from TF4D9JK212.bytedance.net ([139.177.225.232])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c8bc13551sm22569305ad.88.2024.10.11.05.13.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 11 Oct 2024 05:13:26 -0700 (PDT)
From: Changqi Lu <luchangqi.123@bytedance.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com, k.jensen@samsung.com,
 Changqi Lu <luchangqi.123@bytedance.com>
Subject: [PATCH v14 07/10] hw/nvme: add helper functions for converting
 reservation types
Date: Fri, 11 Oct 2024 20:12:28 +0800
Message-Id: <20241011121231.18333-8-luchangqi.123@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20241011121231.18333-1-luchangqi.123@bytedance.com>
References: <20241011121231.18333-1-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-pl1-x631.google.com
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


