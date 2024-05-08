Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B491FC19F4F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 12:32:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4gSM-0005iS-Sg; Wed, 08 May 2024 08:31:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1s4gSL-0005gV-CN; Wed, 08 May 2024 08:31:33 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1s4gSC-0003Aw-Ia; Wed, 08 May 2024 08:31:33 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1ee5235f5c9so21834755ad.2; 
 Wed, 08 May 2024 05:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715171483; x=1715776283; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RXQz1dwRLC7iNrSUqXMbmSa+SmczD7+CTqmM7iOnNMU=;
 b=PDQuUlycWAcq4rW1FJ9YE4RiuL3Dk7Kp5Xj2AAG+Wp8SGLTNcu20IHWniZfui0V2aF
 fm4P193EW5Q2FO10BnDaN4z2BDyIQtGye3WHdjH7qmBTqZqLokNa39f59/+mSeOxZbUd
 VHCNCziaHCsQh8+5DUCPoqkEK4S+oWrv+TKvtP3rOY0HII8ti7hzyOVwTPj/VYCDeNgi
 noBPo+zjy2GNZYo+BpiMDbnmPppqRWc+k/KAGlII0LUyNXg+JwWnzaoTzu5Gy+UBn88y
 KOsZ9E2CMj7iGME+lkJAd2LIu3zNRCzkT/GQN+2RYOVK8t8fushNW30dzrq0SeKkz7m8
 nU3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715171483; x=1715776283;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RXQz1dwRLC7iNrSUqXMbmSa+SmczD7+CTqmM7iOnNMU=;
 b=fnvYJ4VbmbIU+ebh88sCF9+hmegL1nCaDSGU4EB6iVIn8CeikBP1Z7PKf7zhqJ+RKT
 OHWrAd2AahU0aSo7JfuC0J54GpXkgdhbuZ0PQCAvO/3MRYJ76IsnZ7/zwtl731dd41hH
 zCyLgzUdrPHiPeBqinH0f4OlsFvlFZbW7xT3zpNesgKvzFWKoFH+fkd2M/tSOLfoIgo0
 JaWo5MR5efwFUNwFjjMLt/qdf+M+Wjzz3x52lPz53+EDhIaR7POQ+7cehhSqjjfV67Nr
 YxW5fDa20SHjMumhc8ZN9RKL0YP/RwS05lg59KkNZ3XtgFZdFryLNRhKzDrsvN15oJqJ
 8Vmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvoQHnVU1vliBxravUnnMU23+YvPpXLEuDo4d6+eWKD39AgXSUelSKuYEXmj4q/v4PIiHA7R/fQh7j4t3bAImM8rmrIgU=
X-Gm-Message-State: AOJu0YzXCR+/I0SD9veQuaU6h6pkKzX4TOL9YSnkYb5LoTTyV5QszYIa
 5IxVnu7wqGyV4PWNgArjEtUg25d2N28pJdyR0YrH7TALlhiIBPul
X-Google-Smtp-Source: AGHT+IGkqU8PlSae/qWJE8ew/mjttkZD0XyX5fXU2OI2ATvXVkYSBp+Lnuic/fJYGsjtPCEXqcKq+w==
X-Received: by 2002:a17:902:eb87:b0:1eb:152a:5a6e with SMTP id
 d9443c01a7336-1eeb03a6a3bmr30119205ad.3.1715171482695; 
 Wed, 08 May 2024 05:31:22 -0700 (PDT)
Received: from localhost ([116.121.76.56]) by smtp.gmail.com with ESMTPSA id
 c17-20020a170902d49100b001ebd73f61fcsm11708026plg.121.2024.05.08.05.31.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 May 2024 05:31:22 -0700 (PDT)
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Klaus Jensen <its@irrelevant.dk>,
	Keith Busch <kbusch@kernel.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Minwoo Im <minwoo.im@samsung.com>, Klaus Jensen <k.jensen@samsung.com>
Subject: [PATCH v3 4/4] hw/nvme: Expand VI/VQ resource to uint32
Date: Wed,  8 May 2024 21:31:07 +0900
Message-Id: <20240508123107.87919-5-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240508123107.87919-1-minwoo.im.dev@gmail.com>
References: <20240508123107.87919-1-minwoo.im.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=minwoo.im.dev@gmail.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index 8db6828ab2a9..5a94f47b1cf1 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -8460,10 +8460,10 @@ static Property nvme_props[] = {
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
     DEFINE_PROP_BOOL("msix-exclusive-bar", NvmeCtrl, params.msix_exclusive_bar,
                      false),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index cc6b4a3a64c2..aa708725c875 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -534,8 +534,8 @@ typedef struct NvmeParams {
     uint32_t  sriov_max_vfs;
     uint16_t sriov_vq_flexible;
     uint16_t sriov_vi_flexible;
-    uint8_t  sriov_max_vq_per_vf;
-    uint8_t  sriov_max_vi_per_vf;
+    uint32_t  sriov_max_vq_per_vf;
+    uint32_t  sriov_max_vi_per_vf;
     bool     msix_exclusive_bar;
 } NvmeParams;
 
-- 
2.34.1


