Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F33E2C48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 22:24:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raNfZ-00030J-5R; Wed, 14 Feb 2024 17:23:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1raNfS-0002z3-SG; Wed, 14 Feb 2024 17:23:51 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1raNfR-0004M8-Bf; Wed, 14 Feb 2024 17:23:50 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-296e22f85abso240789a91.3; 
 Wed, 14 Feb 2024 14:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707949428; x=1708554228; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jIzhi0zXwyxAcxfW0vbAAZ1pHXKlkaBvG4gA8eFEa9A=;
 b=bfgfKYEB2JF346wzQX8PKzH8YUx5Jlq/M7WKUp+huptRp29FEEpcx7Eg/8WjdcWVHR
 DCqU6bZbjELamn+5P2LAU7oLFaFP2a+E0wdHlgqGf588CeZ71SaFym9NsDjWedsmRsax
 spyzWhl+TTh2eXsmkwyyrhJjbGzo8J4k6LS3Ce6YmBZ/P/UWegiUx7vZX7RaO7r7fre/
 JnSm2S7aYsN8yQZGvD1jmlhkZsYandb2rLMbe8gnIfv2x7vmU1vi+KtRAuA2WIZE9XRV
 V7emOgzAa7h/Om2Ef1U2t3v98UVVSEux49a3FQ4w2+N5YmxiEEIjXGI5hDKd5ziKGzJM
 lgMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707949428; x=1708554228;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jIzhi0zXwyxAcxfW0vbAAZ1pHXKlkaBvG4gA8eFEa9A=;
 b=BfTmjOJni6gflIOSBb943BQh53I31peRRuojsrFi6TuAynkVqCmnPAkSUdxnQEyUUe
 y03ReEhyyl3163POS/3uGG1Co4JDctgWxrx/3fvs9bbWMW3HSRixVeKhUTvB/ek4htXs
 lNnXZDsLHcF6gh9xCD8YDZACQx+xgQ4UXQWbFIkZUj3kKEB9D0ku/MXQrp3OqSJ7tNOl
 ENKL/Tsi5wU2u4PjXvUPf3ujODNri3U8gqfKXjAST9JUGlK07rZXUnTt+lV+QHRxCqAF
 TEorLIMcKihIVJgrJnsJaPyesHbh/mNu/4ltLEY4RYhvtL22OCm15No63pDol+zBBd93
 Ctjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYKpnZ6eKJ14CANQGDsSVOvkcLhxeIv1Pgh42OU3LUpFIWOL+PaYKolYdPFK/TzDaCfTekAsy/Mf8fSUgvBpXRowE3FDU=
X-Gm-Message-State: AOJu0YwOTk4BDngVZMhXE1g1GKnwx+2gatHlBUb6kps1c+TO7d26WhjV
 oVsiYIkhbwalWPh5PLoJyhMB5ppLtC6NmbLyT9yd9O8XPWULb0uK
X-Google-Smtp-Source: AGHT+IFCcGGaUMNsTMtX8M4MYlCwspn1uju5fI/ghhBvOu/AM5bKGm1dGIExa9dWdn2BkWlMAZg7JQ==
X-Received: by 2002:a17:90b:3708:b0:297:17ad:52a3 with SMTP id
 mg8-20020a17090b370800b0029717ad52a3mr79092pjb.1.1707949427758; 
 Wed, 14 Feb 2024 14:23:47 -0800 (PST)
Received: from localhost ([116.121.76.56]) by smtp.gmail.com with ESMTPSA id
 nd13-20020a17090b4ccd00b00298f4341feesm591063pjb.28.2024.02.14.14.23.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 14:23:47 -0800 (PST)
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Keith Busch <kbusch@kernel.org>,
	Klaus Jensen <its@irrelevant.dk>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Minwoo Im <minwoo.im@samsung.com>, Klaus Jensen <k.jensen@samsung.com>
Subject: [PATCH 2/3] hw/nvme: Support SR-IOV VFs more than 127
Date: Thu, 15 Feb 2024 07:23:36 +0900
Message-Id: <20240214222337.5699-3-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240214222337.5699-1-minwoo.im.dev@gmail.com>
References: <20240214222337.5699-1-minwoo.im.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=minwoo.im.dev@gmail.com; helo=mail-pj1-x1036.google.com
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

The number of virtual functions(VFs) supported in SR-IOV is 64k as per
spec.  To test a large number of MSI-X vectors mapping to CPU matrix in
the QEMU system, we need much more than 127 VFs.  This patch made
support for 256 VFs per a physical function(PF).

Signed-off-by: Minwoo Im <minwoo.im@samsung.com>
Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 4 ++--
 hw/nvme/nvme.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index cfe53a358871..8198fd2d8e46 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -219,7 +219,7 @@
 #define NVME_TEMPERATURE_CRITICAL 0x175
 #define NVME_NUM_FW_SLOTS 1
 #define NVME_DEFAULT_MAX_ZA_SIZE (128 * KiB)
-#define NVME_MAX_VFS 127
+#define NVME_MAX_VFS 256
 #define NVME_VF_RES_GRANULARITY 1
 #define NVME_VF_OFFSET 0x1
 #define NVME_VF_STRIDE 1
@@ -8425,7 +8425,7 @@ static Property nvme_props[] = {
     DEFINE_PROP_UINT8("zoned.zasl", NvmeCtrl, params.zasl, 0),
     DEFINE_PROP_BOOL("zoned.auto_transition", NvmeCtrl,
                      params.auto_transition_zones, true),
-    DEFINE_PROP_UINT8("sriov_max_vfs", NvmeCtrl, params.sriov_max_vfs, 0),
+    DEFINE_PROP_UINT16("sriov_max_vfs", NvmeCtrl, params.sriov_max_vfs, 0),
     DEFINE_PROP_UINT16("sriov_vq_flexible", NvmeCtrl,
                        params.sriov_vq_flexible, 0),
     DEFINE_PROP_UINT16("sriov_vi_flexible", NvmeCtrl,
diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index 5f2ae7b28b9c..db2cda098ebd 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -517,7 +517,7 @@ typedef struct NvmeParams {
     bool     auto_transition_zones;
     bool     legacy_cmb;
     bool     ioeventfd;
-    uint8_t  sriov_max_vfs;
+    uint16_t  sriov_max_vfs;
     uint16_t sriov_vq_flexible;
     uint16_t sriov_vi_flexible;
     uint8_t  sriov_max_vq_per_vf;
-- 
2.34.1


