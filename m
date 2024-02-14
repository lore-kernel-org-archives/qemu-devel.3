Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58C7BC48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 22:24:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raNfb-000317-1M; Wed, 14 Feb 2024 17:23:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1raNfX-0002zf-Eg; Wed, 14 Feb 2024 17:23:55 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1raNfV-0004Mn-1d; Wed, 14 Feb 2024 17:23:54 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6e08dd0fa0bso257536b3a.1; 
 Wed, 14 Feb 2024 14:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707949431; x=1708554231; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fkuI8eX5TD1s1j3VvJ6QWefmEmgPFSztzD62i65A9U0=;
 b=XbOPC/o48W4+gKvCbb5SXbwdDivRYY4VIojnZMkAeEJkI5z08Mr+6V4wBOZxVX7OGm
 YNEKyrivKzaAXA0cgx8k3BEJkWw/3RPwoqpnjs4Q1kQs0m7clscDRdrF6SHdaK2vwq5f
 BeL21uUo4FqhUjDQ9pytHV9zGd2PaVsX941TyPoyfO8CdCC3TdVthLP/fdsSfk8l8B1q
 NPZEE9AZvY78+36938IyccxvId1n55Nk1TVWkGRcvfqkjfPQUEWphfOom4qQd3nvsRdV
 AszVaKihPaNJPFFTs+mTPX23oe8r9PD2yGIkdG0DqfeDHulnt0mAc8W/fORkVBo0U+yN
 GVJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707949431; x=1708554231;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fkuI8eX5TD1s1j3VvJ6QWefmEmgPFSztzD62i65A9U0=;
 b=J7Yicz0WFFuyzmJ265roVv8HcT4K8QW3627mvhUlZVSKWe1MczCRtqojK32Q2tzs6s
 scPZCak4jN70oehbW2hZ5UVD98OF9nfw3lca6tWlqhgvzErmKcRA/PAaku9zGJfaNwvM
 IoJctCIWY6j/uud+HP/hTI2JW1yeoeS7vG/wLOx64XgKK2qsi6rPcYeljrLrmlScRRZ0
 Qm75wpmwXMQ5ct8TdI4WTSM/kQmjLlSA+PQLnr/hacfUV8ZKLQavGoFnF/4OajLW16iq
 /UbiLd5iofN+RXSl+QalPbDVRDwgy+uOIu04jnPvYy9mBru7bCZLxvzOq6GdLh9UeVcL
 uKOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyPn5kZgBF8j95DdXFWgAAmCV3zwIKmfLciZuneiJ/h2aXQ56GaE5f8H4poVSfVRM8MU8b5rXGZbILm24B1xOeil+Bm+g=
X-Gm-Message-State: AOJu0YznIdiJqw7BPErlrTKquigQI0ENHEP9jMvzlJIY4AsaHspBRLIg
 qXKl5Gwgf27VwaT1VEhGdfnTkuaWOX4/QVT2VfuNNDGNTrDatPgS
X-Google-Smtp-Source: AGHT+IEt9YGylY1X3+V/PQnQOznmIF0upJUu2HBf2qNI6cej9h9exfO8Ag4FeF+fJJi5y64HQqdsJw==
X-Received: by 2002:a05:6a00:3d0c:b0:6e0:8a23:65c with SMTP id
 lo12-20020a056a003d0c00b006e08a23065cmr4852772pfb.13.1707949431201; 
 Wed, 14 Feb 2024 14:23:51 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXoxNa8pTwbEiOTBvYkfoF+r1E/Y5S9gLVmEQ4QrIx6FFzf5D4gdPK/3MXAQPPdzeO2NP5egA7DxQBWyQE2Pak+2D5SSMt0sARIKzdvzMBT5sg4K9VOhLUe9SgEyrl/IKDRXbswE+M2qrFl0uNeqRvlQnSYncxW1BhZYGDikgF+U5QJWI9p
Received: from localhost ([116.121.76.56]) by smtp.gmail.com with ESMTPSA id
 q2-20020aa79822000000b006e118ff3564sm658035pfl.133.2024.02.14.14.23.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 14:23:50 -0800 (PST)
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Keith Busch <kbusch@kernel.org>,
	Klaus Jensen <its@irrelevant.dk>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Minwoo Im <minwoo.im@samsung.com>, Klaus Jensen <k.jensen@samsung.com>
Subject: [PATCH 3/3] hw/nvme: Expand VI/VQ resource to uint32
Date: Thu, 15 Feb 2024 07:23:37 +0900
Message-Id: <20240214222337.5699-4-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240214222337.5699-1-minwoo.im.dev@gmail.com>
References: <20240214222337.5699-1-minwoo.im.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=minwoo.im.dev@gmail.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Minwoo Im <minwoo.im@samsung.com>

VI and VQ resources cover queue resources in each VFs in SR-IOV.
Current maximum I/O queue pair size is 0xffff, we can expand them to
cover the full number of I/O queue pairs.

This patch also fixed Identify Secondary Controller List overflow due to
expand of number of secondary controllers.

Signed-off-by: Minwoo Im <minwoo.im@samsung.com>
Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 10 +++++-----
 hw/nvme/nvme.h |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 8198fd2d8e46..6f3fd96f7572 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -5486,7 +5486,7 @@ static uint16_t nvme_identify_sec_ctrl_list(NvmeCtrl *n, NvmeRequest *req)
 
     for (i = 0; i < num_sec_ctrl; i++) {
         if (n->sec_ctrl_list.sec[i].scid >= min_id) {
-            list.numcntl = num_sec_ctrl - i;
+            list.numcntl = (num_sec_ctrl - i > 127) ? 127 : num_sec_ctrl - i;
             memcpy(&list.sec, n->sec_ctrl_list.sec + i,
                    list.numcntl * sizeof(NvmeSecCtrlEntry));
             break;
@@ -8430,10 +8430,10 @@ static Property nvme_props[] = {
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
index db2cda098ebd..d0f4c6c9b7af 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -520,8 +520,8 @@ typedef struct NvmeParams {
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


