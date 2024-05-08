Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C051C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 12:33:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4gS7-0005bf-AN; Wed, 08 May 2024 08:31:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1s4gS5-0005bA-Lb; Wed, 08 May 2024 08:31:17 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1s4gS3-00039t-Vh; Wed, 08 May 2024 08:31:17 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1e651a9f3ffso22166615ad.1; 
 Wed, 08 May 2024 05:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715171474; x=1715776274; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=41zciqobW1lSQYD67CMpHII/+O0mLdb6RkZbAdkYnvw=;
 b=aWQpjIWgUwGFPb5a8dylvy6UO1mWnn3SXcPHXFlddfQ7UzaCz419gYza2QW2Xa48ej
 ZzQRpuPMFtruZhuXrqVIk7l8UIPkwsmka7v2qFA8i1YX0XND5TJ2k2MZZ0IJTQS5bWtJ
 6ptex7yjwGyaHDiv5YORCCANIwcCGaueFcncb93IRFm4h6gP55C/haAoRZUxdOD46oeP
 zhbLk3ovogYQPWxigXwny2jWHgATeOpiKapYf/3whRC4fZe9EAzUBzUEaZ2IKzJqhU13
 9vygKat985uMB/k3Wx+KtsWlAgilX5hrFqM7RzCleMjvCm++paoxHvkq8dyByGHqQXR7
 IOLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715171474; x=1715776274;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=41zciqobW1lSQYD67CMpHII/+O0mLdb6RkZbAdkYnvw=;
 b=bIfOcGvKh0OExYVq9k9rfiPU+HpI5Y6u7rK2i0oboYUINUgDaPIu437amjSmopq6X1
 jFmiZDZMFJHGJXYv5f6262L28tG7y0wbraNicZ9PKQ+VXpXt0MHbUTF8u5vgrx6q39YG
 D3b2+cox2D1aPN2dd3R0VwwmoMS5Nx8OzCFZEjpJZ9AMadFvbCSIYPxihLslEeVTOJYf
 rowsdaKIacrqQFvFWWK65Z7/qq5yMyrtLGIsBALvZIX8trIb9SfpWr5XsISA8R8huViu
 zPNgekZBSfO3Oiw1Fwdanncipq2Z8kFY4IrjjVWwN70rg9XTHkuPhCdAspyCc8HAFdaB
 wV4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpFkdJ8nZutuZ5l6HqF4JttoIqfuPa8o9xy192Z5vVT0Y8junc1+5VbjrjT7boKspIryuwgtXCvsbzuKUCXvEwOHzMZoo=
X-Gm-Message-State: AOJu0YyR/BwF2pOeJzJ67L0Zx5lx8J2fb6WlQQsu8xPqd+oS/xfZA89X
 T6SFya2r39ME0nas16Z0+o67TKtxZghT+69gzNnXSQiPOJ7ivq42R+aAWQ==
X-Google-Smtp-Source: AGHT+IGNcVh4SAxQDXmWeZr40KH95b2x0M7A7hh1Zzq+UlNU4mzN1qV6EhOobm6wZCrX14M6J1c/1w==
X-Received: by 2002:a17:902:ce8a:b0:1e1:1791:3681 with SMTP id
 d9443c01a7336-1eeb0796948mr29718035ad.61.1715171473939; 
 Wed, 08 May 2024 05:31:13 -0700 (PDT)
Received: from localhost ([116.121.76.56]) by smtp.gmail.com with ESMTPSA id
 b3-20020a170902d30300b001e2a479954dsm11741336plc.181.2024.05.08.05.31.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 May 2024 05:31:13 -0700 (PDT)
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Klaus Jensen <its@irrelevant.dk>,
	Keith Busch <kbusch@kernel.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Minwoo Im <minwoo.im@samsung.com>, Klaus Jensen <k.jensen@samsung.com>
Subject: [PATCH v3 1/4] hw/nvme: add Identify Endurance Group List
Date: Wed,  8 May 2024 21:31:04 +0900
Message-Id: <20240508123107.87919-2-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240508123107.87919-1-minwoo.im.dev@gmail.com>
References: <20240508123107.87919-1-minwoo.im.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=minwoo.im.dev@gmail.com; helo=mail-pl1-x631.google.com
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

Commit 73064edfb864 ("hw/nvme: flexible data placement emulation")
intorudced NVMe FDP feature to nvme-subsys and nvme-ctrl with a
single endurance group #1 supported.  This means that controller should
return proper identify data to host with Identify Endurance Group List
(CNS 19h).  But, yes, only just for the endurance group #1.  This patch
allows host applications to ask for which endurance group is available
and utilize FDP through that endurance group.

Signed-off-by: Minwoo Im <minwoo.im@samsung.com>
Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c       | 22 ++++++++++++++++++++++
 include/block/nvme.h |  1 +
 2 files changed, 23 insertions(+)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 127c3d238346..18672f66193f 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -5629,6 +5629,26 @@ static uint16_t nvme_identify_nslist_csi(NvmeCtrl *n, NvmeRequest *req,
     return nvme_c2h(n, list, data_len, req);
 }
 
+static uint16_t nvme_endurance_group_list(NvmeCtrl *n, NvmeRequest *req)
+{
+    uint16_t list[NVME_CONTROLLER_LIST_SIZE] = {};
+    uint16_t *nr_ids = &list[0];
+    uint16_t *ids = &list[1];
+    uint16_t endgid = le32_to_cpu(req->cmd.cdw11) & 0xffff;
+
+    /*
+     * The current nvme-subsys only supports Endurance Group #1.
+     */
+    if (!endgid) {
+        *nr_ids = 1;
+        ids[0] = 1;
+    } else {
+        *nr_ids = 0;
+    }
+
+    return nvme_c2h(n, list, sizeof(list), req);
+}
+
 static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeNamespace *ns;
@@ -5744,6 +5764,8 @@ static uint16_t nvme_identify(NvmeCtrl *n, NvmeRequest *req)
         return nvme_identify_nslist(n, req, false);
     case NVME_ID_CNS_CS_NS_ACTIVE_LIST:
         return nvme_identify_nslist_csi(n, req, true);
+    case NVME_ID_CNS_ENDURANCE_GROUP_LIST:
+        return nvme_endurance_group_list(n, req);
     case NVME_ID_CNS_CS_NS_PRESENT_LIST:
         return nvme_identify_nslist_csi(n, req, false);
     case NVME_ID_CNS_NS_DESCR_LIST:
diff --git a/include/block/nvme.h b/include/block/nvme.h
index bb231d0b9ad0..7c77d38174a7 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -1074,6 +1074,7 @@ enum NvmeIdCns {
     NVME_ID_CNS_CTRL_LIST             = 0x13,
     NVME_ID_CNS_PRIMARY_CTRL_CAP      = 0x14,
     NVME_ID_CNS_SECONDARY_CTRL_LIST   = 0x15,
+    NVME_ID_CNS_ENDURANCE_GROUP_LIST  = 0x19,
     NVME_ID_CNS_CS_NS_PRESENT_LIST    = 0x1a,
     NVME_ID_CNS_CS_NS_PRESENT         = 0x1b,
     NVME_ID_CNS_IO_COMMAND_SET        = 0x1c,
-- 
2.34.1


