Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94A14FCB60B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 15:08:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyWiX-0007Et-NL; Fri, 06 Mar 2026 10:03:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1vyWiV-0006w8-1N
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:03:51 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1vyWiT-0003Ja-2q
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:03:50 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b9431300833so105979466b.0
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 07:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1772809427; x=1773414227; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZTBRdCe4EKhZ7QFgzj0snqvNaQKXZdaqV+19ND1Hpu0=;
 b=SM46xUtGsgh2mVP7iK1ZhTTYLCe26dwEfOWGNxIYzzz8cYfaFrrmgDZ/sFNiW7FbEs
 nFExOKNnD8Fw/LstbmNl5DFrlg56wFC+SZDWPfeEtbfojLo/IBzFHXHzdESbcmev+wrm
 /q0E9utZH+AX8fSJMnkQGKi528QeEdNCMjass=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772809427; x=1773414227;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZTBRdCe4EKhZ7QFgzj0snqvNaQKXZdaqV+19ND1Hpu0=;
 b=VONwvqzgSEW2z9XgjSSPuKBixnMP/Uycn/iZvmZgZofQwgQqQS4bpFDsik1SJYHu1h
 H99z7cJyYR2VdPWec7VbWGWhqf/aul8cpEAQMK4tdC0Jd1Kl5xubskC6H1two4nSRCOd
 1B5msbTMIZ4GB5h6D6KCQ9bD/s3Ch464NaQ45TBWA8SszMy4997bGJlL8I3wi06tZ9SM
 f9dWFHH/1872vurORcDKdXxiY1pq6+W7i5MK06yCSMgqa7uIYtB9VlBGpR+nRpARGD9f
 wSsYFntv+L0wDniK0XXQNLGbZVSLtq2KXBTDRdiXav1Ro59wBa+jvgIEmXfTgJuUKbCb
 QmDg==
X-Gm-Message-State: AOJu0YwyXmzDqNFOAwajgvJ833moWiMMsCGM607t0oSuIMrQuz+FVZta
 bxbciZOhpgjz60maxMMXiLhDftLF1RoLd30gAL2G+y+c1nQKiLc3dANNHnlwvjbD+P5kEGc4mYm
 3EO56VCQ=
X-Gm-Gg: ATEYQzzVC1TRlwRKM+T6T9S6A1OAeKRzDUm5c26a9pqgUflgz/K/ty/d/rCkEs8xZD6
 pGu3rIxAqnFjJ1cuoy1eH44aJ+g4QjUeV8G9M88eZI1KLmyOZRA8ugsEEPCyxHzezcMf7tFpkPd
 rtlU5L9agXhi4QiyQNWuZQIXUpc4x1lQO7Hg5oLAUsXkFtJJ+2+jCEZNOt87miiJtBy5GKyZ3OC
 nEGlJ4oJZkpCaseERAw31dVnA97pmrlioZVJpuACX6EiWfVltfbDh3VMXZpCei0z3ir/JFeusk+
 P+sBR54r4/ioXU/ChTTeSJTyoOC+Q3CPVedOd1ZQ+aV8bXYs2/GTDOK6GYeb8JERnAJCEcYn3Ms
 joqUXsr0P9TDy5l5S21q7Ev4wlZxfW6/fBmRipaHPAGrPvQXGK/71CrT5HaPiFIUH5QCw574hN1
 mwWan8I3gzeWAkFO8+2UetEnXpLns9QcVSdB3l3UsZz8iWvBZwlZP/1UJObleRQ0fmonkx1m+Po
 i/poO39AUZTA2k10gG3SKg=
X-Received: by 2002:a17:907:6092:b0:b90:ba11:1694 with SMTP id
 a640c23a62f3a-b942dfbd66fmr150488866b.50.1772809427194; 
 Fri, 06 Mar 2026 07:03:47 -0800 (PST)
Received: from alex-laptop.lan
 (p200300cf57228c00583f1937c9b9cecc.dip0.t-ipconnect.de.
 [2003:cf:5722:8c00:583f:1937:c9b9:cecc])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae36785sm4703623f8f.27.2026.03.06.07.03.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 07:03:46 -0800 (PST)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Jesper Devantier <foss@defmacro.it>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Klaus Jensen <its@irrelevant.dk>,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 Keith Busch <kbusch@kernel.org>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH v3 3/6] hw/nvme: add migration blockers for non-supported cases
Date: Fri,  6 Mar 2026 16:03:39 +0100
Message-ID: <20260306150342.395923-4-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260306150342.395923-1-alexander@mihalicyn.com>
References: <20260306150342.395923-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alexander@mihalicyn.com; helo=mail-ej1-x636.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

Let's block migration for cases we don't support:
- SR-IOV
- CMB
- PMR
- SPDM

No functional changes here, because NVMe migration is
not supported at all as of this commit.

Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
---
 hw/nvme/ctrl.c | 35 +++++++++++++++++++++++++++++++++++
 hw/nvme/nvme.h |  3 +++
 2 files changed, 38 insertions(+)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index cc4593cd427..4694bdb4d02 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -207,6 +207,7 @@
 #include "hw/pci/msix.h"
 #include "hw/pci/pcie_sriov.h"
 #include "system/spdm-socket.h"
+#include "migration/blocker.h"
 #include "migration/vmstate.h"
 
 #include "nvme.h"
@@ -8962,6 +8963,14 @@ static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
     pcie_endpoint_cap_init(pci_dev, 0x80);
     pcie_cap_flr_init(pci_dev);
     if (n->params.sriov_max_vfs) {
+        if (n->migration_blocker == NULL) {
+            error_setg(&n->migration_blocker,
+                       "Migration is disabled when SR-IOV capability is set");
+            if (migrate_add_blocker(&n->migration_blocker, errp) < 0) {
+                return false;
+            }
+        }
+
         pcie_ari_init(pci_dev, 0x100);
     }
 
@@ -9025,6 +9034,14 @@ static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
     if (pci_dev->spdm_port) {
         uint16_t doe_offset = PCI_CONFIG_SPACE_SIZE;
 
+        if (n->migration_blocker == NULL) {
+            error_setg(&n->migration_blocker,
+                       "Migration is disabled when SPDM responder is used");
+            if (migrate_add_blocker(&n->migration_blocker, errp) < 0) {
+                return false;
+            }
+        }
+
         switch  (pci_dev->spdm_trans) {
         case SPDM_SOCKET_TRANSPORT_TYPE_PCI_DOE:
             if (n->params.sriov_max_vfs) {
@@ -9053,10 +9070,26 @@ static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
     }
 
     if (n->params.cmb_size_mb) {
+        if (n->migration_blocker == NULL) {
+            error_setg(&n->migration_blocker,
+                       "Migration is disabled when CMB feature is used");
+            if (migrate_add_blocker(&n->migration_blocker, errp) < 0) {
+                return false;
+            }
+        }
+
         nvme_init_cmb(n, pci_dev);
     }
 
     if (n->pmr.dev) {
+        if (n->migration_blocker == NULL) {
+            error_setg(&n->migration_blocker,
+                       "Migration is disabled when PMR feature is used");
+            if (migrate_add_blocker(&n->migration_blocker, errp) < 0) {
+                return false;
+            }
+        }
+
         if (!nvme_init_pmr(n, pci_dev, errp)) {
             return false;
         }
@@ -9365,6 +9398,8 @@ static void nvme_exit(PCIDevice *pci_dev)
     }
 
     memory_region_del_subregion(&n->bar0, &n->iomem);
+
+    migrate_del_blocker(&n->migration_blocker);
 }
 
 static const Property nvme_props[] = {
diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index d66f7dc82d5..457b6637249 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -666,6 +666,9 @@ typedef struct NvmeCtrl {
 
     /* Socket mapping to SPDM over NVMe Security In/Out commands */
     int spdm_socket;
+
+    /* Migration-related stuff */
+    Error *migration_blocker;
 } NvmeCtrl;
 
 typedef enum NvmeResetType {
-- 
2.47.3


