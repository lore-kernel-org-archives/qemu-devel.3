Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0E65C3271F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 10:58:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPgcq-0002uC-FB; Fri, 05 Jul 2024 06:57:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sPgcn-0002c5-9D
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 06:57:09 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sPgca-0006ee-6w
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 06:57:09 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1fafc9e07f8so9768085ad.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 03:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1720177015; x=1720781815; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IyZGNDRE1BJIuJp5qNhxmIBvAAaNOJEW0axHYABlNto=;
 b=D7U/E9mwaFdMfDKq6BJ90p6/eaRpS9Dz0Jkdv6XJnmxpm/euwqsJ1Czx3Ci5ZlPniE
 ockPr/OP5v5E0HvWJ7fS8mpxahlUZaIgwPxsewuw8ra7A0i0Jd6ESP6vJmct6xajtOWx
 CBscNe481QqoG8An3CQ5oI+ebynVx3Txsi9koRCQ5avzx4sSK4sxktHX/BzV7ewph6o+
 m1AEmLCyMnuSMnSs54g5wXjKzumwIXj+Hts28UZYEGUVogyONt8yc8Hasb/NaGIb0/l7
 lv3fNHMEsx1IqzXAUz/cbrX8Xt6R1rgXUCKcLvW2afPPmclPtUbfNYVheApmrWb7iHMp
 5b8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720177015; x=1720781815;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IyZGNDRE1BJIuJp5qNhxmIBvAAaNOJEW0axHYABlNto=;
 b=ltqZNkVLMeqquL7I4EdUeNFUSUpxZ/ThvroXLTIuNPRYUBM6QnL6t2RT6qokUDe1pa
 niRlXWmF+q8Zh1w9g7GSUfcAGnDVJTMbl4BGRBZqMv+ZVLAigF2D/4cQTLFz303dh7lb
 5iS7Cr1fDo+Kte4LVcWe0Gb8D/qNm4ZGo4GMlNwSUYOfXWSmGTzvl4B3ntYxRadx63DW
 WbB6z4fEHaXvmHqXwsy+MRPlEt1leZaMgnW3aZpc41qYqn9fs22cU5dPAJWnjkVNLEEZ
 xZ4jglaPCj9njdE6z/QF4rnXJITolsWYqTvvvRW3T7r9N5SV4s+crR7zDHttDdBLWaR+
 svhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcpIVwL5z1B1yN1Vx20srCBuRDLuDsGT3lvPFoHKX/Ufq7OYDnENJLjJOwb51jPlcvaIe7WtpFeb+03KcUnp9ru0C+B0s=
X-Gm-Message-State: AOJu0YzuDO4ozidhdpWKQOcfaOCKMgC4q2Qo8NkQ1vxccokRf+MqSEIN
 2i1vHqN8CiKpdw3YzbYPiXRcovyyciXbrg/Q89yFs3U4jOqnnbHmSl1qk2CGVFA=
X-Google-Smtp-Source: AGHT+IFAE7z0vLJyaPWMeky2CLlou97DodjnmmZ+zlY/lsANWYMrbYkNLLMlw2JGEvLe6Qi+yrDsTA==
X-Received: by 2002:a17:902:d4c7:b0:1fb:4b87:6e8e with SMTP id
 d9443c01a7336-1fb4b877196mr11405555ad.42.1720177014874; 
 Fri, 05 Jul 2024 03:56:54 -0700 (PDT)
Received: from n37-006-243.byted.org ([180.184.84.173])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fac0ba60a2sm141292125ad.0.2024.07.05.03.56.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 03:56:54 -0700 (PDT)
From: Changqi Lu <luchangqi.123@bytedance.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com, Changqi Lu <luchangqi.123@bytedance.com>
Subject: [PATCH v7 08/10] hw/nvme: enable ONCS and rescap function
Date: Fri,  5 Jul 2024 18:56:12 +0800
Message-Id: <20240705105614.3377694-9-luchangqi.123@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240705105614.3377694-1-luchangqi.123@bytedance.com>
References: <20240705105614.3377694-1-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

This commit enables ONCS to support the reservation
function at the controller level. Also enables rescap
function in the namespace by detecting the supported reservation
function in the backend driver.

Signed-off-by: Changqi Lu <luchangqi.123@bytedance.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 hw/nvme/ctrl.c       | 3 ++-
 hw/nvme/ns.c         | 5 +++++
 include/block/nvme.h | 2 +-
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 127c3d2383..ad212de723 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -8248,7 +8248,8 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     id->nn = cpu_to_le32(NVME_MAX_NAMESPACES);
     id->oncs = cpu_to_le16(NVME_ONCS_WRITE_ZEROES | NVME_ONCS_TIMESTAMP |
                            NVME_ONCS_FEATURES | NVME_ONCS_DSM |
-                           NVME_ONCS_COMPARE | NVME_ONCS_COPY);
+                           NVME_ONCS_COMPARE | NVME_ONCS_COPY |
+                           NVME_ONCS_RESERVATIONS);
 
     /*
      * NOTE: If this device ever supports a command set that does NOT use 0x0
diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
index ea8db175db..a5c903d727 100644
--- a/hw/nvme/ns.c
+++ b/hw/nvme/ns.c
@@ -20,6 +20,7 @@
 #include "qemu/bitops.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/block-backend.h"
+#include "block/block_int.h"
 
 #include "nvme.h"
 #include "trace.h"
@@ -33,6 +34,7 @@ void nvme_ns_init_format(NvmeNamespace *ns)
     BlockDriverInfo bdi;
     int npdg, ret;
     int64_t nlbas;
+    uint8_t blk_pr_cap;
 
     ns->lbaf = id_ns->lbaf[NVME_ID_NS_FLBAS_INDEX(id_ns->flbas)];
     ns->lbasz = 1 << ns->lbaf.ds;
@@ -55,6 +57,9 @@ void nvme_ns_init_format(NvmeNamespace *ns)
     }
 
     id_ns->npda = id_ns->npdg = npdg - 1;
+
+    blk_pr_cap = blk_bs(ns->blkconf.blk)->bl.pr_cap;
+    id_ns->rescap = block_pr_cap_to_nvme(blk_pr_cap);
 }
 
 static int nvme_ns_init(NvmeNamespace *ns, Error **errp)
diff --git a/include/block/nvme.h b/include/block/nvme.h
index 8b125f7769..9b9eaeb3a7 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -1251,7 +1251,7 @@ enum NvmeIdCtrlOncs {
     NVME_ONCS_DSM           = 1 << 2,
     NVME_ONCS_WRITE_ZEROES  = 1 << 3,
     NVME_ONCS_FEATURES      = 1 << 4,
-    NVME_ONCS_RESRVATIONS   = 1 << 5,
+    NVME_ONCS_RESERVATIONS  = 1 << 5,
     NVME_ONCS_TIMESTAMP     = 1 << 6,
     NVME_ONCS_VERIFY        = 1 << 7,
     NVME_ONCS_COPY          = 1 << 8,
-- 
2.20.1


