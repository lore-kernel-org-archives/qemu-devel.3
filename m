Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7FC9C3271F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 10:58:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPgci-0002S4-PL; Fri, 05 Jul 2024 06:57:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sPgcY-0002PN-1o
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 06:56:55 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sPgcW-0006e1-Dd
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 06:56:53 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1fafc9e07f8so9767805ad.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 03:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1720177011; x=1720781811; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t0xxob6zB1P7gFRfbCBxVpf1NpVXQswWX1uR6CV85Ls=;
 b=T5NyQC/rAXa+ie0O48aaVKFUMdLI0Urw/O4QHWOxmdo8R3VzTGk9JcNPiSHbzFWUmv
 lZYH646NDkP9BOAxjFCsf/PsfKXfhnNf074fxf+lY1Z9s1qPhkpfUYYO2MXN18wyJ9d/
 HBY+sCCm3jwPQPJUT0PMl3hW5NxR7hOPM4SW1tpmTaBiWgZrV7R8aJ2o67pY7hug6vmp
 RaOjfMla2kzoqENfSE9AVCLi9LJ2S+aKjcJv7rDahLb02cqQeX8GIaNxcNPuDEs9QNnV
 F1PzD6DfjlQO2OwMqa+N+Ir6AwcJ1Isluu/J+mV6krj1RjGZaSZ4fw/3ZFiAONYhz/Z6
 4TtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720177011; x=1720781811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t0xxob6zB1P7gFRfbCBxVpf1NpVXQswWX1uR6CV85Ls=;
 b=Q+KKCMWL+OPIw9QLLAJgmzbDiJcscHqyUAGVjtOgR+93U6xnKznXnxvYYguCPNV1ax
 7KD5v8ZMqyF5Hec+dfiMpgLbYCsqYVvZce2osmj6hKJiff9EJMG2MU+ksHhKopu6aT3m
 emlP+l1nCzzeoTtJ8Nq6icMkH8j8snfKG8VLSAccfi2ry2/zD5d/huZpeEOeFHJ+Zibq
 6I+hKneZBkUuxBPk/fZR2HDjepa2R/uHcSuFdV8XuQxjyawFqdS9gU8Vt8MjXFh+n78a
 4UStYpyX5erp/BUGp/6s0uQZnu8oWsl4SZvylPpa+eDCauNQaFFnIok6SCRW00DPYi28
 jfvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+ba1ADgR8nh33TbzqrVqK0Nwgh3kqrtoDABlj0/PZm5tFyRXqmTAPOK3hHtLjyVjLr0pbObpF8qsOi8jdhbN8mPVc10s=
X-Gm-Message-State: AOJu0YyQqwdVn5jQNcdq1gKMos1ieXT4TLPEcpAN7WKAWqIVQtee9kpt
 zOSaDo0OS0wSpajEVyg/OPHmTDr1EC1z5rLzBGg0z0jcSWPe2xcLfeNumT0dSr8=
X-Google-Smtp-Source: AGHT+IHBRneACYSjBAHCWH46b3ZwQQ2ChM8s2T24Vgd2U4Jej8JOGJo7L8IRjkl5AtyKjhBhOp7K9A==
X-Received: by 2002:a17:902:f543:b0:1fb:3718:ca0b with SMTP id
 d9443c01a7336-1fb3718ced8mr36201345ad.26.1720177009761; 
 Fri, 05 Jul 2024 03:56:49 -0700 (PDT)
Received: from n37-006-243.byted.org ([180.184.84.173])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fac0ba60a2sm141292125ad.0.2024.07.05.03.56.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 03:56:49 -0700 (PDT)
From: Changqi Lu <luchangqi.123@bytedance.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com, Changqi Lu <luchangqi.123@bytedance.com>
Subject: [PATCH v7 07/10] hw/nvme: add helper functions for converting
 reservation types
Date: Fri,  5 Jul 2024 18:56:11 +0800
Message-Id: <20240705105614.3377694-8-luchangqi.123@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240705105614.3377694-1-luchangqi.123@bytedance.com>
References: <20240705105614.3377694-1-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-pl1-x62a.google.com
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


