Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B7D2CD128D
	for <qemu-devel@archiver.kernel.org>; Sun, 31 Mar 2024 19:31:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rr0tP-0000LL-Nr; Sun, 31 Mar 2024 15:30:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1rr0tO-0000Ky-Ia; Sun, 31 Mar 2024 15:30:58 -0400
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1rr0tM-0001R0-Vt; Sun, 31 Mar 2024 15:30:58 -0400
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-22a8df1df8fso2198229fac.2; 
 Sun, 31 Mar 2024 12:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711913455; x=1712518255; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wSDYsWlELwKSPvJjZM7xr4TTz+NGl+wsAw++yWtE5cM=;
 b=lfoi8HWfWLwpVZCjf+VtwFyvgKWiB99MZBDAGtdKskPioE51KBhwUMxGZLiuuzj5q7
 GbXI0WHScjTZJ2jFsDf/qv3Whiq2bPqRImUOzAHsTOz3yPuUWDXVscUbCNbtOKQFt+UX
 Ok3Zvlzsc9Urvx+DcbJ/SAzTP4nvD8y2xbRgeckAsdto0d2ssVOhKtrTEVy3nVKRFgQM
 LR/x7fu9aI57MkQntd9lbKnLnYXr8SHqnAZun6y8Ad947DhHfMm1zxsIvSDKvx4kTS/w
 ai78hEYf3NsOcerXvSr0yZmokVO7zJPaDAMYqjKJZlaRWwzEY4meon+YirXa2jlV4Lfs
 Fqrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711913455; x=1712518255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wSDYsWlELwKSPvJjZM7xr4TTz+NGl+wsAw++yWtE5cM=;
 b=rUAwfZPcE1V0AhIf3jzZo9yNuSR9NV36WU3ssWkiC6UPHtt/2J7bfo/huk1KhlkdsU
 u1ZevSJods7OU5rv8bP1sMzAumG+6EIay4BE9WXtcpcgBLYMLuOq9em5btZWoOnMuzBA
 Z+mkzbNBjdp4W52W1Ppe5/3/Eno9w8BUs8PzPB2uWdReQ4vqIw0ZrGRQx4kBtCUyuT9/
 lFFKk8fCulR3GVo/AnHrIOkVjrmYFcyiRB4ahEQg8v2icKGZWKnH5dVLPbrXYtCx3PbD
 oLZJgwNm5jcFmVpyvawFqQRrtEym1EmWFWVrQbLru6Y0txYHwdXdYRBdAn6xz3zOp63+
 /OPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEcCiWtmyTuL571xpDde7gVbyVKFVXSu1X9hXm7JqTan8JnLMn0cfNJO4fYuDxoF9h3I3yMzZzrQ08dsMvPc5xMODA8H4=
X-Gm-Message-State: AOJu0YzCN5W5kiEx2V/gaFQynDOyPOZZ+YLcTBxwZTvAd1crNOQBJJg9
 xqzL0cADDHJOovwdBYs6QDyb5+1zrrl7uIVjjR+KQHTCVy+x1Mkw
X-Google-Smtp-Source: AGHT+IFCIZUy1J7FasRzcv53Mh006SqS7TTWVq1M8gG6jSnZI9IRE2oGlQoyXzPGD6sklAQcCM4w4A==
X-Received: by 2002:a05:6870:a548:b0:22a:55bd:a048 with SMTP id
 p8-20020a056870a54800b0022a55bda048mr8794638oal.5.1711913454994; 
 Sun, 31 Mar 2024 12:30:54 -0700 (PDT)
Received: from localhost ([116.121.76.56]) by smtp.gmail.com with ESMTPSA id
 j5-20020aa783c5000000b006eac81fa1fbsm6452490pfn.66.2024.03.31.12.30.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Mar 2024 12:30:54 -0700 (PDT)
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Klaus Jensen <its@irrelevant.dk>,
	Keith Busch <kbusch@kernel.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Minwoo Im <minwoo.im@samsung.com>, Klaus Jensen <k.jensen@samsung.com>
Subject: [PATCH v2 4/4] hw/nvme: Expand VI/VQ resource to uint32
Date: Mon,  1 Apr 2024 04:30:32 +0900
Message-Id: <20240331193032.5186-5-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240331193032.5186-1-minwoo.im.dev@gmail.com>
References: <20240331193032.5186-1-minwoo.im.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2c;
 envelope-from=minwoo.im.dev@gmail.com; helo=mail-oa1-x2c.google.com
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

From: Minwoo Im <minwoo.im@samsung.com>

VI and VQ resources cover queue resources in each VFs in SR-IOV.
Current maximum I/O queue pair size is 0xffff, we can expand them to
cover the full number of I/O queue pairs.

This patch also fixed Identify Secondary Controller List overflow due to
expand of number of secondary controllers.

Signed-off-by: Minwoo Im <minwoo.im@samsung.com>
Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 8 ++++----
 hw/nvme/nvme.h | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 893d4e96656b..893afae29336 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -8429,10 +8429,10 @@ static Property nvme_props[] = {
                        params.sriov_vq_flexible, 0),
     DEFINE_PROP_UINT16("sriov_vi_flexible", NvmeCtrl,
                        params.sriov_vi_flexible, 0),
-    DEFINE_PROP_UINT8("sriov_max_vi_per_vf", NvmeCtrl,
-                      params.sriov_max_vi_per_vf, 0),
-    DEFINE_PROP_UINT8("sriov_max_vq_per_vf", NvmeCtrl,
-                      params.sriov_max_vq_per_vf, 0),
+    DEFINE_PROP_UINT32("sriov_max_vi_per_vf", NvmeCtrl,
+                       params.sriov_max_vi_per_vf, 0),
+    DEFINE_PROP_UINT32("sriov_max_vq_per_vf", NvmeCtrl,
+                       params.sriov_max_vq_per_vf, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index ad928c28f2c5..492617f19515 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -521,8 +521,8 @@ typedef struct NvmeParams {
     uint16_t  sriov_max_vfs;
     uint16_t sriov_vq_flexible;
     uint16_t sriov_vi_flexible;
-    uint8_t  sriov_max_vq_per_vf;
-    uint8_t  sriov_max_vi_per_vf;
+    uint32_t  sriov_max_vq_per_vf;
+    uint32_t  sriov_max_vi_per_vf;
 } NvmeParams;
 
 typedef struct NvmeCtrl {
-- 
2.34.1


