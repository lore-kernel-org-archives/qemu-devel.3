Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B51C8C27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 07:15:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHeez-0007b9-Nr; Thu, 13 Jun 2024 03:14:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sHeew-0007ai-S5
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 03:14:10 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sHeev-0007A8-6E
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 03:14:10 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-6ce533b6409so512179a12.1
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2024 00:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1718262848; x=1718867648; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CiOn0d9Pa8+qXsbBr3wAGk2xL3bXuiI7sz/i/2tw7Go=;
 b=d3KurSEpviZ4SiZpjz4TSmLU8BEcC/6EY3FV9qG4oRNnNOBbox034saFO5dAFm9EIL
 N7nnBice4ew4RmXeHZ0FdRKqNQZiFDHwymVQbLlivJVBUxj3Diu1g55CkYsmenmXJqP2
 Ykwe9FYfC5b6bL+ghXfDVRgeEMrCDfrglYj55ly+uo7/rzbr5flPKy2hfSoQjSRxH3yD
 Qv/h8CtEJymrVKcuyM4wxdHb20Z25YMosG+XtRdvPKTYFFw0b2F0o6AMLVlKKPcAZ/YH
 hJgi4S/LmatqDBcEBbT18AJSo51SItbPii83vSSkNiWGcf6fGWFnpgP6rzSxeMF8WWOM
 iFPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718262848; x=1718867648;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CiOn0d9Pa8+qXsbBr3wAGk2xL3bXuiI7sz/i/2tw7Go=;
 b=kxSGDGTjT42Q7BoiwSrdABYpOzkmXlwrLQAy7pzC5hptWG68UCF7g8kxt+labg6fgg
 uiltziN1GPjzCCOFJswVGbN2RzwXOkY7usg1CzLQuY8yaa/FMrh/wR0noHhJYyMZwzun
 vI01NQop1GR1vcLLJ4zvRHXeDfJr2HfDxwPO15cdszuerMm6rTq7kn0hxm98AsapNluQ
 6nnkmtxew1kZPta3gtfkF/uhRbVxSOlOYEA0vf249sDgYW1W49P9+s9hNnhUjBxsdmEU
 8f02al+0ALxyVF5pe31b6tiVzhMu28eDpPRyROKcmIdwuUbZ0383cm5UR2x5786zjBCT
 M1xw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNw04NwWMh88RZsgIsTpLXY+EmHzC+p75oJMhadikQUC3lWpBHNbxP930JZHVu6/o12eD7FVs+Nrrzb4977YazXkC2F0o=
X-Gm-Message-State: AOJu0YxvcZh6Hp4YMjMNharauxPOV8QYYVFx+OGWbxP7X4ZXzXLjDzst
 Bfi9oAMhla3u77EFVpmRf9QWAZMVcPwm4bzVbqsun0X7eNqKppx8mXztnILTGPs=
X-Google-Smtp-Source: AGHT+IEZnM4oRyAh6omnUpQAeUxnRaxPKYJ3V/g4g1RqaMgBdqm++j3livDVVHh7BYmOONF3+q51bw==
X-Received: by 2002:a17:902:d489:b0:1f7:b24:3e8d with SMTP id
 d9443c01a7336-1f83b679d38mr47433495ad.38.1718262847830; 
 Thu, 13 Jun 2024 00:14:07 -0700 (PDT)
Received: from n37-006-243.byted.org ([180.184.84.173])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f855ee6e7esm6378345ad.139.2024.06.13.00.14.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jun 2024 00:14:07 -0700 (PDT)
From: Changqi Lu <luchangqi.123@bytedance.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com, Changqi Lu <luchangqi.123@bytedance.com>
Subject: [PATCH v6 08/10] hw/nvme: enable ONCS and rescap function
Date: Thu, 13 Jun 2024 15:13:25 +0800
Message-Id: <20240613071327.2498953-9-luchangqi.123@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240613071327.2498953-1-luchangqi.123@bytedance.com>
References: <20240613071327.2498953-1-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-pg1-x531.google.com
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

This commit enables ONCS to support the reservation
function at the controller level. Also enables rescap
function in the namespace by detecting the supported reservation
function in the backend driver.

Signed-off-by: Changqi Lu <luchangqi.123@bytedance.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 hw/nvme/ctrl.c | 3 ++-
 hw/nvme/ns.c   | 5 +++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 127c3d2383..182307a48b 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -8248,7 +8248,8 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     id->nn = cpu_to_le32(NVME_MAX_NAMESPACES);
     id->oncs = cpu_to_le16(NVME_ONCS_WRITE_ZEROES | NVME_ONCS_TIMESTAMP |
                            NVME_ONCS_FEATURES | NVME_ONCS_DSM |
-                           NVME_ONCS_COMPARE | NVME_ONCS_COPY);
+                           NVME_ONCS_COMPARE | NVME_ONCS_COPY |
+                           NVME_ONCS_RESRVATIONS);
 
     /*
      * NOTE: If this device ever supports a command set that does NOT use 0x0
diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
index ea8db175db..320c9bf658 100644
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
+    blk_pr_cap = blk_bs(ns->blkconf.blk)->file->bs->bl.pr_cap;
+    id_ns->rescap = block_pr_cap_to_nvme(blk_pr_cap);
 }
 
 static int nvme_ns_init(NvmeNamespace *ns, Error **errp)
-- 
2.20.1


