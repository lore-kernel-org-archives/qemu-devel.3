Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7138EC27C54
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 12:26:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFCBU-0005iD-1h; Thu, 06 Jun 2024 08:25:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sFCBN-0005h3-5G
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 08:25:29 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sFCBL-0007Zq-9o
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 08:25:28 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2c1b9152848so704163a91.1
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 05:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1717676726; x=1718281526; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LacZkfFTIs+WwWhTp32Cf6oxkrCggAGRd8oJ1DAZ4Jg=;
 b=iHFlaRt+JjzXgykJspg54UntDYmwxa3e1r/9RaHcYIkLHO0qC5ORoOhNjgbggLvWG1
 KzSmiOXnjOpY46kaCnaP59oa3wiajPzQVQMNOnE4pj6dFzEE0cZkvGgrrQuuZT0pi6rI
 vVXoWaACmde5AZPvty6YYmSFRUrWbmBeMnUC1LKJ106Q37ti9kjJ3ZfQ8VG0tWURKoRr
 nTwG5yjUz3H1r5kqPhPaiuoC7+llnyB6/oiUF2x6m9xu2uiJdcBN60TRZZK36QrR+Css
 04aMh1u2CKDtY0zha9PCv0IEYGVIykSEb2irhf5oUmccZ9bnWOsuc0RjXXKZmRi/kusx
 A5pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717676726; x=1718281526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LacZkfFTIs+WwWhTp32Cf6oxkrCggAGRd8oJ1DAZ4Jg=;
 b=gwnbaLYrFWWtYfGBtrFD8GkJlDfVeQB7RgXgAWaVkShps3wv+sehqe7qEvdOh6SpkH
 fWiZP6ZjzO5hnCNGT0oS0UkkHxYmQbprc7pKEWC2gl94yi8DK0RDPGyVMnXquKMZQOvl
 JqVX4dEQYDNsbwC5+g+H4AlVR49GXavIl5kE8PYlxyZ4R3VHNtKl94VlKUGFkevu7zoL
 dOOEOWr/yFTL+qk6TupVlKQDVJyl67SMIJe87ePKzwfYw3PutiIXvNaDw63PaEpPs/2K
 wUE+EjZyp4+6frWQZHl91nQ7BjmBLDfTFk9DWomX5QyuHRY6OpeNWFzhOjRSy4TfNXz9
 KsvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrUwSvtNkS45wwwLweSpHUkCkvVx8FFLQTPmejHjTStIhEOSR9wfPNKswW2aaXFqgm9Kg1eM6r8J2AJvq68D/RR8YXJL4=
X-Gm-Message-State: AOJu0YyKKC7QukOmMHHGrbNzDDvhKNqbj8uGQsLfiumzNB0YFi88PpkA
 Ypkn9puw7gMXUY9vjmn/a4SJKkMP2hvabxSa8OHb3jRKVCPi6Z5in36RdT3DQpU=
X-Google-Smtp-Source: AGHT+IHyoPlfGpgT5qnYH68kdKW1LFTnVSnLqjdJAdc3cVGF/utu2rYCcPlVKAEQARS+EgZ4nD6ZNw==
X-Received: by 2002:a17:90b:48a:b0:2bd:dbfe:817d with SMTP id
 98e67ed59e1d1-2c27db1f419mr5428010a91.21.1717676725796; 
 Thu, 06 Jun 2024 05:25:25 -0700 (PDT)
Received: from n37-006-243.byted.org ([180.184.51.142])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c29c20d7adsm1459396a91.9.2024.06.06.05.25.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 05:25:25 -0700 (PDT)
From: Changqi Lu <luchangqi.123@bytedance.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com, Changqi Lu <luchangqi.123@bytedance.com>
Subject: [PATCH v5 07/10] hw/nvme: add helper functions for converting
 reservation types
Date: Thu,  6 Jun 2024 20:24:41 +0800
Message-Id: <20240606122444.2914576-8-luchangqi.123@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240606122444.2914576-1-luchangqi.123@bytedance.com>
References: <20240606122444.2914576-1-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

This commit introduces two helper functions
that facilitate the conversion between the
reservation types used in the NVME protocol
and those used in the block layer.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Changqi Lu <luchangqi.123@bytedance.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 hw/nvme/nvme.h | 80 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index bed8191bd5..b1ad27c8f2 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -474,6 +474,86 @@ static inline const char *nvme_io_opc_str(uint8_t opc)
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


