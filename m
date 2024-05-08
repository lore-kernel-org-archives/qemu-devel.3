Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E001BC04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 12:32:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4gSI-0005fQ-FG; Wed, 08 May 2024 08:31:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1s4gSD-0005eT-QE; Wed, 08 May 2024 08:31:25 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1s4gSA-0003AS-3G; Wed, 08 May 2024 08:31:24 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6f45f1179c3so3281205b3a.3; 
 Wed, 08 May 2024 05:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715171480; x=1715776280; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ndv57RH03iIiitXdceTxAwpyOl6hTRdMizLr7f5jGsg=;
 b=TwqNuGr4qIdxjpvuQUKvylEHgW6T2PnkOlUFvznhvPnmv6VerEmn51HZVk0vuGKqo7
 ut2ytZ6taxIBzObyi1g82ctbbeXQENAtezw05GVi1CNyQzXHQAdKdbPaFMRnkdGptyDR
 nmFPQLqvUZawQyAK5NlnfORQK++tRewvZv6AQIWU3qU6YiSMmE582cV7jzEc8X++rixT
 FWNQlYFdoymZigw4eosfPetpEQfqU4IWk4YZdohQ68j0hHeXpf+9UgdsuOHf7mCViMHV
 jUXmaecPuxD5c2gcZFbu7HwuYfLui1gnQkM65xrDdHnHRkj6Pn5UA2cmAgOON2pkl7g0
 Q9rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715171480; x=1715776280;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ndv57RH03iIiitXdceTxAwpyOl6hTRdMizLr7f5jGsg=;
 b=QH/LY6iOim686NFWFljCXWbbBMsDrIi7Y60KIugRd4ksCTLuip5nWWTmZOctZG/N5k
 RKaAwlfGhJRmg8rZkhcALGzd97E+Tw2H6oDaP/++nvLZcswZUU7X4fEVp/X4U4DcxHWq
 UObGTD7z4MhG/Noqi5tf8Ja2mOuiqRZBrs1sWuvMG6Dle7ynlRFh9O6OqzlgLv8HD1un
 NGuSPd4YxFuukDO80O8NaI77xDHiZGjQB4tXu2En52Juhz/UCzH6nO21vzeOOJTrSf+z
 YvFInsoQKgmN5nG3lY6xkCEjrY1mDRijkfEj+J5N+kaJWQEmDL+yISksA9sBGSTCa7+b
 TcqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzOYEcNk/jLlhy0MxHlw8dTmN1zIs4txQW+DtWoiJpDxTTQ/FFFlwMlEe7Op/pHsEIaIqLXyKBE2UCa7Dnfo1MzWxxB3E=
X-Gm-Message-State: AOJu0Yy58gw5exvmCdk80rV/UW/O3x1mZwr07AbpPFHpTcXtQcLpd1Ms
 bcgM+xAgTNrrgxc3edN7OwYVLFYqF3oaUjCNrhUa0OiSysm563pw
X-Google-Smtp-Source: AGHT+IEJ7kkrraMPmwlVk9h3wy5ZUoC0ChT6xWRa6783DpajgzkhqB7wDZVxTyDSPkiXkV7XWrfJbA==
X-Received: by 2002:a05:6a21:6da4:b0:1af:8e88:2834 with SMTP id
 adf61e73a8af0-1afc8db7ebdmr3107623637.46.1715171479959; 
 Wed, 08 May 2024 05:31:19 -0700 (PDT)
Received: from localhost ([116.121.76.56]) by smtp.gmail.com with ESMTPSA id
 bf5-20020a656d05000000b0062070308b0esm6922317pgb.46.2024.05.08.05.31.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 May 2024 05:31:19 -0700 (PDT)
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Klaus Jensen <its@irrelevant.dk>,
	Keith Busch <kbusch@kernel.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Minwoo Im <minwoo.im@samsung.com>
Subject: [PATCH v3 3/4] hw/nvme: Allocate sec-ctrl-list as a dynamic array
Date: Wed,  8 May 2024 21:31:06 +0900
Message-Id: <20240508123107.87919-4-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240508123107.87919-1-minwoo.im.dev@gmail.com>
References: <20240508123107.87919-1-minwoo.im.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=minwoo.im.dev@gmail.com; helo=mail-pf1-x42e.google.com
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

To prevent further bumping up the number of maximum VF te support, this
patch allocates a dynamic array (NvmeCtrl *)->sec_ctrl_list based on
number of VF supported by sriov_max_vfs property.

Signed-off-by: Minwoo Im <minwoo.im@samsung.com>
---
 hw/nvme/ctrl.c   | 8 +-------
 hw/nvme/nvme.h   | 5 ++---
 hw/nvme/subsys.c | 2 ++
 3 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 7cf1e8e384b7..8db6828ab2a9 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -7863,12 +7863,6 @@ static bool nvme_check_params(NvmeCtrl *n, Error **errp)
             return false;
         }
 
-        if (params->sriov_max_vfs > NVME_MAX_VFS) {
-            error_setg(errp, "sriov_max_vfs must be between 0 and %d",
-                       NVME_MAX_VFS);
-            return false;
-        }
-
         if (params->cmb_size_mb) {
             error_setg(errp, "CMB is not supported with SR-IOV");
             return false;
@@ -8461,7 +8455,7 @@ static Property nvme_props[] = {
     DEFINE_PROP_UINT8("zoned.zasl", NvmeCtrl, params.zasl, 0),
     DEFINE_PROP_BOOL("zoned.auto_transition", NvmeCtrl,
                      params.auto_transition_zones, true),
-    DEFINE_PROP_UINT8("sriov_max_vfs", NvmeCtrl, params.sriov_max_vfs, 0),
+    DEFINE_PROP_UINT32("sriov_max_vfs", NvmeCtrl, params.sriov_max_vfs, 0),
     DEFINE_PROP_UINT16("sriov_vq_flexible", NvmeCtrl,
                        params.sriov_vq_flexible, 0),
     DEFINE_PROP_UINT16("sriov_vi_flexible", NvmeCtrl,
diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index 485b42c104ea..cc6b4a3a64c2 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -26,7 +26,6 @@
 
 #define NVME_MAX_CONTROLLERS 256
 #define NVME_MAX_NAMESPACES  256
-#define NVME_MAX_VFS 127
 #define NVME_EUI64_DEFAULT ((uint64_t)0x5254000000000000)
 #define NVME_FDP_MAX_EVENTS 63
 #define NVME_FDP_MAXPIDS 128
@@ -532,7 +531,7 @@ typedef struct NvmeParams {
     bool     auto_transition_zones;
     bool     legacy_cmb;
     bool     ioeventfd;
-    uint8_t  sriov_max_vfs;
+    uint32_t  sriov_max_vfs;
     uint16_t sriov_vq_flexible;
     uint16_t sriov_vi_flexible;
     uint8_t  sriov_max_vq_per_vf;
@@ -614,7 +613,7 @@ typedef struct NvmeCtrl {
 
     NvmePriCtrlCap  pri_ctrl_cap;
     uint32_t nr_sec_ctrls;
-    NvmeSecCtrlEntry sec_ctrl_list[NVME_MAX_VFS];
+    NvmeSecCtrlEntry *sec_ctrl_list;
     struct {
         uint16_t    vqrfap;
         uint16_t    virfap;
diff --git a/hw/nvme/subsys.c b/hw/nvme/subsys.c
index 561ed04a5317..77deaf2c2c97 100644
--- a/hw/nvme/subsys.c
+++ b/hw/nvme/subsys.c
@@ -61,6 +61,8 @@ int nvme_subsys_register_ctrl(NvmeCtrl *n, Error **errp)
     if (pci_is_vf(&n->parent_obj)) {
         cntlid = le16_to_cpu(sctrl->scid);
     } else {
+        n->sec_ctrl_list = g_new0(NvmeSecCtrlEntry, num_vfs);
+
         for (cntlid = 0; cntlid < ARRAY_SIZE(subsys->ctrls); cntlid++) {
             if (!subsys->ctrls[cntlid]) {
                 break;
-- 
2.34.1


