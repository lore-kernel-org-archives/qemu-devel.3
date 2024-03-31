Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 982EBCD1284
	for <qemu-devel@archiver.kernel.org>; Sun, 31 Mar 2024 19:31:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rr0tM-0000KT-K5; Sun, 31 Mar 2024 15:30:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1rr0tL-0000Jc-6D; Sun, 31 Mar 2024 15:30:55 -0400
Received: from mail-il1-x12f.google.com ([2607:f8b0:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1rr0tJ-0001QY-Io; Sun, 31 Mar 2024 15:30:54 -0400
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-368cd5ddb65so9149975ab.0; 
 Sun, 31 Mar 2024 12:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711913452; x=1712518252; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wq1YmLBqyP4iUMA93VUo8jDUZAGxmCsbTe8wz4eZ4Wg=;
 b=DLZd3sm2yQRwYrJiHMzunx1lNLYS9QGAaPVA5kafOKxpbNs+Cak5743EZcvk0P3cuC
 CpzEGuI4j5xsfKojCkjXbURR5K3K6r0C25ZUQ/QcYVLUPxQ0x4O+Y9eOFX90MT/58K4M
 O3us3fNoxKwbaOoRrDYu6uPax5S2KpeLSzTrfHW6zSBGeuuPeUycCKrmrsPXPSlB5MM3
 Gptux26L4ZNV9MhOXQwE1y2bmAlisH2eRnT9cHTsoqYbeak75xhWZ5O2SR0xgh9E80nu
 JBSkyJpZ69CJ7VSCyzAGscToV5h5dpRStlendk24GJa1rS8Gfy5AtknKdMXrxMdNut/y
 kSkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711913452; x=1712518252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wq1YmLBqyP4iUMA93VUo8jDUZAGxmCsbTe8wz4eZ4Wg=;
 b=vHORQQd9a+q/gMtQI4zpWBK2YAqrNpDfPZEgNkMxbl5jFuHieKghlY0IqnA0nHaOOb
 KOcFpaq4X8+E7k8pUUN6dz08FNLaN813Dh6DHPjDM6OQ6G+bX5IJ3jzk5YcUDw+smH1l
 isyQSnS63WfL1Bibn9Si34OiIcQecbd7fWcPzrj9mZ7I0G6dQJktndD67CkRtRQzVViH
 HE0FI5Tt0/QWrlqHy0GmehYKqFo1f/HiLi1U36tIIDjb4+Xi4UtVMqMYzkuwEtLm1msD
 peNTBznHldmUpj0Zt+ZzHg54y4csglUesWp7DDHA5uYTrlcfqhAN6tf0QdrwljXV7KtQ
 jmlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSi0PsIvr8cdH+S560Tz+3Mt1RtO5wnoOmyKXd7SqXxUf0cyPkjJCLp1DsDmKowPxmDK/G4ZXooiTVztPXuFyNtg8oKPY=
X-Gm-Message-State: AOJu0YxYsTINuMGRrsQsv1+ODOZhjy4POT0XnpJYmC3zt73MG5ktWmqJ
 btwBcLKUKZ8OgLri0bcLbXURDiZVNmZVg4hwfhcSF0Colw2eDA20
X-Google-Smtp-Source: AGHT+IHH5M22Oi7Hzooz+5f2zp/yM3nTBUnNRnJIIMCL/sitO5lSHE9HOzYkw6VRXMbJtaUr53DcCA==
X-Received: by 2002:a05:6e02:1383:b0:369:9421:89bd with SMTP id
 d3-20020a056e02138300b00369942189bdmr5790416ilo.29.1711913452082; 
 Sun, 31 Mar 2024 12:30:52 -0700 (PDT)
Received: from localhost ([116.121.76.56]) by smtp.gmail.com with ESMTPSA id
 d9-20020a170902b70900b001db37fd26bcsm7235043pls.116.2024.03.31.12.30.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Mar 2024 12:30:51 -0700 (PDT)
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Klaus Jensen <its@irrelevant.dk>,
	Keith Busch <kbusch@kernel.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Minwoo Im <minwoo.im@samsung.com>, Klaus Jensen <k.jensen@samsung.com>
Subject: [PATCH v2 3/4] hw/nvme: Support SR-IOV VFs more than 127
Date: Mon,  1 Apr 2024 04:30:31 +0900
Message-Id: <20240331193032.5186-4-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240331193032.5186-1-minwoo.im.dev@gmail.com>
References: <20240331193032.5186-1-minwoo.im.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12f;
 envelope-from=minwoo.im.dev@gmail.com; helo=mail-il1-x12f.google.com
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

The number of virtual functions(VFs) supported in SR-IOV is 64k as per
spec.  To test a large number of MSI-X vectors mapping to CPU matrix in
the QEMU system, we need much more than 127 VFs.  This patch made
support for 256 VFs per a physical function(PF).

Signed-off-by: Minwoo Im <minwoo.im@samsung.com>
Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 2 +-
 hw/nvme/nvme.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 7e60bc9f2075..893d4e96656b 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -8424,7 +8424,7 @@ static Property nvme_props[] = {
     DEFINE_PROP_UINT8("zoned.zasl", NvmeCtrl, params.zasl, 0),
     DEFINE_PROP_BOOL("zoned.auto_transition", NvmeCtrl,
                      params.auto_transition_zones, true),
-    DEFINE_PROP_UINT8("sriov_max_vfs", NvmeCtrl, params.sriov_max_vfs, 0),
+    DEFINE_PROP_UINT16("sriov_max_vfs", NvmeCtrl, params.sriov_max_vfs, 0),
     DEFINE_PROP_UINT16("sriov_vq_flexible", NvmeCtrl,
                        params.sriov_vq_flexible, 0),
     DEFINE_PROP_UINT16("sriov_vi_flexible", NvmeCtrl,
diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index 02c11d909cd1..ad928c28f2c5 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -26,7 +26,7 @@
 
 #define NVME_MAX_CONTROLLERS 256
 #define NVME_MAX_NAMESPACES  256
-#define NVME_MAX_VFS 127
+#define NVME_MAX_VFS 256
 #define NVME_EUI64_DEFAULT ((uint64_t)0x5254000000000000)
 #define NVME_FDP_MAX_EVENTS 63
 #define NVME_FDP_MAXPIDS 128
@@ -518,7 +518,7 @@ typedef struct NvmeParams {
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


