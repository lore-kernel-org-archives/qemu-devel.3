Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB7EC04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 13:16:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4h5u-0005F5-Q7; Wed, 08 May 2024 09:12:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1s4dko-0007Y6-Fx
 for qemu-devel@nongnu.org; Wed, 08 May 2024 05:38:26 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1s4dkm-0000YO-ML
 for qemu-devel@nongnu.org; Wed, 08 May 2024 05:38:26 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1ed96772f92so29859035ad.0
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 02:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1715161103; x=1715765903; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t8zABI1BTj8XZR99oMhp56K6CNAOT5mRJrRHjuL0Qm8=;
 b=OuJnLGBSxAH2AnVAwizTKS9JfDe2ZhfyvedCpIe+vg7BHWMA4hV7pTtoYF97qUO+pa
 Dy/7I0nGEZgp7ZqRiTpTQUfqhGjl3czSAY5wYDgREpIo+xZ8bJAPb5eqR4VF8eBmXuzD
 UWunbFWj9cmu/Ovnw397IIU8vvTSusRqZJswWpH210B2ViBBeuOk/XcEQCHt1b7qbbwV
 Uf3AFEN3Xpj4hfUF8shpK5I+aW3m6BD7guDDmWAxKRcszE5XzJ/Xvxru4aw1+m7nwPPd
 yRNt+20/Yqakodfxg+CDukwLTsFD9crw9yrNQfTLAtIo+eu57jcJQd9xwKRBkau8r6kR
 Jmhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715161103; x=1715765903;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t8zABI1BTj8XZR99oMhp56K6CNAOT5mRJrRHjuL0Qm8=;
 b=qNrsFIjhbE0ZZx0yDIS6iLpqa5Z++RKiUyvDtT73605yLYJAZt2ftCTu3zlnHJstGX
 2NxHGeYZ/H4qS47m8wmJ+pi0RyecOtFYVQEk+61HxOwgb6DKCrzHNQb9BFltRrH9K6KZ
 XnIvzXDqpp15ldeefz3m+9wgK91VpedsMId1w0O7jff6bkt8VMBHoOGGGxB3lbNWTLrg
 o3JgOZQG4Og6EuR+2GT3Gp5YvGgIZN7zZdX/WbS48LrNAQ9CbEf/pSgK5KSTUyNezuXt
 Z7wTGXV4cx0Eh/s42Zc5tagiivcqd+ETsjOhRNP603z48o7P8Zdie9WGnDpk1phTEylu
 D/mQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuMkoSYqaef/01LQ4EaqbQKe+BEfFPYkWg2BPuLLRiOGn3rjIKS8YSSPyed5wap1gLQWA6n3W7qiGPOjvrtC7nytiWxrs=
X-Gm-Message-State: AOJu0YzWVEF79Y2e+GEyk7Ro5qWCn/PsxAQiippYOmXppENSRYg5U+0E
 lGgDC+fGT+Jp/K1g9REIuur0smndYa9qgZ3mD1npRcUvpB0fD3foxOzrDGdT0jE=
X-Google-Smtp-Source: AGHT+IGLfOb2/pZZLUKFCv/PRWqHkuHM2tIc7DrP6Rko5KabxplsHKrKo/yrfHJCHgZUh6pyRHSj5A==
X-Received: by 2002:a17:902:ef52:b0:1ec:c6bd:4157 with SMTP id
 d9443c01a7336-1eeb078eca4mr27541745ad.59.1715161102715; 
 Wed, 08 May 2024 02:38:22 -0700 (PDT)
Received: from n37-006-243.byted.org ([180.184.51.134])
 by smtp.gmail.com with ESMTPSA id
 p16-20020a1709027ed000b001ee13eb2bedsm4992178plb.98.2024.05.08.02.38.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 May 2024 02:38:22 -0700 (PDT)
From: Changqi Lu <luchangqi.123@bytedance.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 Changqi Lu <luchangqi.123@bytedance.com>,
 zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH 4/9] scsi/util: add helper functions for persistent
 reservation types conversion
Date: Wed,  8 May 2024 17:36:24 +0800
Message-Id: <20240508093629.441057-5-luchangqi.123@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240508093629.441057-1-luchangqi.123@bytedance.com>
References: <20240508093629.441057-1-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 08 May 2024 09:12:22 -0400
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

This commit introduces two helper functions
that facilitate the conversion between the
persistent reservation types used in the SCSI
protocol and those used in the block layer.

Signed-off-by: Changqi Lu <luchangqi.123@bytedance.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 include/scsi/utils.h |  5 +++++
 scsi/utils.c         | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/include/scsi/utils.h b/include/scsi/utils.h
index d5c8efa16e..8212860231 100644
--- a/include/scsi/utils.h
+++ b/include/scsi/utils.h
@@ -1,6 +1,8 @@
 #ifndef SCSI_UTILS_H
 #define SCSI_UTILS_H
 
+#include "block/block-common.h"
+#include "scsi/constants.h"
 #ifdef CONFIG_LINUX
 #include <scsi/sg.h>
 #endif
@@ -135,6 +137,9 @@ uint32_t scsi_data_cdb_xfer(uint8_t *buf);
 uint32_t scsi_cdb_xfer(uint8_t *buf);
 int scsi_cdb_length(uint8_t *buf);
 
+BlockPrType scsi_pr_type_to_block(SCSIPrType type);
+SCSIPrType block_pr_type_to_scsi(BlockPrType type);
+
 /* Linux SG_IO interface.  */
 #ifdef CONFIG_LINUX
 #define SG_ERR_DRIVER_TIMEOUT  0x06
diff --git a/scsi/utils.c b/scsi/utils.c
index 357b036671..381803c81c 100644
--- a/scsi/utils.c
+++ b/scsi/utils.c
@@ -658,3 +658,43 @@ int scsi_sense_from_host_status(uint8_t host_status,
     }
     return GOOD;
 }
+
+BlockPrType scsi_pr_type_to_block(SCSIPrType type)
+{
+    switch (type) {
+    case SCSI_PR_WRITE_EXCLUSIVE:
+        return BLK_PR_WRITE_EXCLUSIVE;
+    case SCSI_PR_EXCLUSIVE_ACCESS:
+        return BLK_PR_EXCLUSIVE_ACCESS;
+    case SCSI_PR_WRITE_EXCLUSIVE_REGS_ONLY:
+        return BLK_PR_WRITE_EXCLUSIVE_REGS_ONLY;
+    case SCSI_PR_EXCLUSIVE_ACCESS_REGS_ONLY:
+        return BLK_PR_EXCLUSIVE_ACCESS_REGS_ONLY;
+    case SCSI_PR_WRITE_EXCLUSIVE_ALL_REGS:
+        return BLK_PR_WRITE_EXCLUSIVE_ALL_REGS;
+    case SCSI_PR_EXCLUSIVE_ACCESS_ALL_REGS:
+        return BLK_PR_EXCLUSIVE_ACCESS_ALL_REGS;
+    }
+
+    return 0;
+}
+
+SCSIPrType block_pr_type_to_scsi(BlockPrType type)
+{
+    switch (type) {
+    case BLK_PR_WRITE_EXCLUSIVE:
+        return SCSI_PR_WRITE_EXCLUSIVE;
+    case BLK_PR_EXCLUSIVE_ACCESS:
+        return SCSI_PR_EXCLUSIVE_ACCESS;
+    case BLK_PR_WRITE_EXCLUSIVE_REGS_ONLY:
+        return SCSI_PR_WRITE_EXCLUSIVE_REGS_ONLY;
+    case BLK_PR_EXCLUSIVE_ACCESS_REGS_ONLY:
+        return SCSI_PR_EXCLUSIVE_ACCESS_REGS_ONLY;
+    case BLK_PR_WRITE_EXCLUSIVE_ALL_REGS:
+        return SCSI_PR_WRITE_EXCLUSIVE_ALL_REGS;
+    case BLK_PR_EXCLUSIVE_ACCESS_ALL_REGS:
+        return SCSI_PR_EXCLUSIVE_ACCESS_ALL_REGS;
+    }
+
+    return 0;
+}
-- 
2.20.1


