Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A26C2C04FFE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2024 09:54:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7uH0-0002LU-Ff; Fri, 17 May 2024 05:53:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1s7uGw-0002KW-GL
 for qemu-devel@nongnu.org; Fri, 17 May 2024 05:53:06 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1s7uGt-0006Qd-Vv
 for qemu-devel@nongnu.org; Fri, 17 May 2024 05:53:06 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1ee954e0aa6so3956495ad.3
 for <qemu-devel@nongnu.org>; Fri, 17 May 2024 02:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1715939582; x=1716544382; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wLeDyHd/NbiVU2EOjQS5MxxKZM5g/6nONQ4TMg1HD4o=;
 b=N9EOGJRiUyZ40lUJPsdnMp6843CnKh1SR17qpjT/bgADZvYQc2G4blqZHnVCn7f4x2
 OtV3zR0vLmoASCTjPu/xZpquz2+IDKUAM4O7Fu3Cx0A2jUcKku5zLe0uHNu0ndxvn3Iv
 jsx3tHLTFS/UKuUSmsY79lqT3OGOXvbESchdwgxspMT9fOD3hfh+oXg95NGm905uUrF8
 ZvS9TGVImwDRvB6n3MkUz2wPGtZMYCZkS1aKDmmE88PoDGarK5Bew0dPdofaO3g2AOcb
 pia4UPLJ+QYltaG5M4B7wuGZ2sjrFlZVTo+ih1R3plrqZCV2pJ58LOc/osqj5sbHIuyD
 2Fag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715939582; x=1716544382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wLeDyHd/NbiVU2EOjQS5MxxKZM5g/6nONQ4TMg1HD4o=;
 b=KtWCBreSSeYj5KVI1ccW/wsftd4+RZ/DksMXYuxJ0bRL8/aZ39IfKXRR8eEyGbSo6B
 tcMZcq29vAg/VvINOMQEBYN2g2ALk0Ulqp0vvqVMA/luFOvYcIJ138D4O0QPGE1jL5N2
 X4FoBpLgeCTr8IaeFXLYjwQtOuQTu0XUQ4gLx7hhRKFh60zEpF8j96hCL1WbrkXmNjyg
 Q+FVFkrrX3YkGtoql3t3dtiD5ZQYUSdiTc+M0e1aBZw9RL6sbxPZQpbJvg5mypKMRxe2
 Sw3/MzpwhHfsRM0Eq2d0w6GczWxdqIAZlwoitqHzVnjgcQSFDl8mSg6V3IQlZeFX/frv
 ZJAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdBx8dI05V5np1N5sWkltS/kMiccm3EG3bIJ+H+MvCZBPj0NhzyTFJBRrRyG5dfVAPUwDkOLjh6NBvzbuNe/yZ8VJgqhY=
X-Gm-Message-State: AOJu0YywXCUT7rkZXjCL+m2VrsrQHDMCXptBouXshk5vhN22FOBo0QaJ
 9WdRdrBudGaiQy+V+nnPsvhb698Rezp7pmuR7VruNtblMaFlUqKX3MRlYpGHlWc=
X-Google-Smtp-Source: AGHT+IHxlvf9EZzINywlfGSrkOFLusERhr1QHF/gHJRp6jMXw9bSMb1ezHd2W2LJxW4TOx1sNrfYAA==
X-Received: by 2002:a17:90a:ab02:b0:2b4:39cd:2e0e with SMTP id
 98e67ed59e1d1-2b6cc76bdd5mr19656662a91.21.1715939582551; 
 Fri, 17 May 2024 02:53:02 -0700 (PDT)
Received: from n37-006-243.byted.org ([180.184.51.134])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2b628ca53cesm16975992a91.44.2024.05.17.02.52.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 May 2024 02:53:02 -0700 (PDT)
From: Changqi Lu <luchangqi.123@bytedance.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com, Changqi Lu <luchangqi.123@bytedance.com>
Subject: [PATCH v3 09/11] hw/nvme: enable namespace rescap function
Date: Fri, 17 May 2024 17:52:16 +0800
Message-Id: <20240517095218.3107672-10-luchangqi.123@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240517095218.3107672-1-luchangqi.123@bytedance.com>
References: <20240517095218.3107672-1-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-pl1-x62a.google.com
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

This commit enables the rescap function in the
namespace by detecting the supported reservation
function in the backend driver.

Signed-off-by: Changqi Lu <luchangqi.123@bytedance.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 hw/nvme/ns.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
index ea8db175db..bb09117f4b 100644
--- a/hw/nvme/ns.c
+++ b/hw/nvme/ns.c
@@ -20,6 +20,7 @@
 #include "qemu/bitops.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/block-backend.h"
+#include "block/block_int.h"
 
 #include "nvme.h"
 #include "trace.h"
@@ -55,6 +56,13 @@ void nvme_ns_init_format(NvmeNamespace *ns)
     }
 
     id_ns->npda = id_ns->npdg = npdg - 1;
+
+    /*
+     * The persistent reservation capacities of block
+     * and nvme are currently defined the same.
+     * If there are subsequent changes, this part needs to be changed.
+     */
+    id_ns->rescap = blk_bs(ns->blkconf.blk)->file->bs->bl.pr_cap;
 }
 
 static int nvme_ns_init(NvmeNamespace *ns, Error **errp)
-- 
2.20.1


