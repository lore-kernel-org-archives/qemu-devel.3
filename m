Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6E84C25B78
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 03:54:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6MkM-0001GB-SN; Sun, 12 May 2024 23:53:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1s6MkK-0001FD-Kk
 for qemu-devel@nongnu.org; Sun, 12 May 2024 23:53:04 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1s6MkH-0008Jv-Kh
 for qemu-devel@nongnu.org; Sun, 12 May 2024 23:53:03 -0400
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3c9963a2205so1881817b6e.2
 for <qemu-devel@nongnu.org>; Sun, 12 May 2024 20:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1715572376; x=1716177176; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FAwSEwTg0VLUXzExYfMLsFCBpPvpWvSWBpepVbcuGYo=;
 b=UmwUkuPjdvAiaUlaabmzjHnQz3xlY4R0TWgzF3Y38UT3pnsxL0/Bl2dWvdgC3j3GjK
 73zick/idfjaj3+LmS8Nr24RJjXfjgkVRtP9Ji3Ba+ex1CFDESxCsknjFKoFZYieqLZQ
 QjuNrY1K5lI/l7aeZ33L++E6cKEZrbptPNi1kr3oRtjQcNNXl8p2eRCRx6FWc2DmU6LA
 b/ngsACjt45jYAvtOvwlmY13jqKLqrIqWP14KaAF5jeRZBilW+ApWFdfPnoqRRSI67xn
 P0jiexqwlY3JAyYHor75CK+WZdcA/3t2hPOE4bz2zNl7VkwFAjbP9jNYO5jt+3Hw1z9d
 MqNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715572376; x=1716177176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FAwSEwTg0VLUXzExYfMLsFCBpPvpWvSWBpepVbcuGYo=;
 b=iRZ1bmsX572ZQAYRR0Y2KD0qry2cMKkvQ1l2c4F/nh3d2wJhpx2cY5P/qDdGRIyBkI
 YM+DC5E7y44RiUDAKK7ATj04Elz5gEIY1gzJLrlJEd6/7qH03nLjvDHv/B67ebt1XzdI
 R7hJ5Y3Ma28ED+yNL+Dx8H8kkuZCFiarse5S7ELO4IUs+KLUtG2wfUtHJJME3mJGMfJZ
 4nygluvceVH8m3R4Nt7whUP3F2vPO8ya4Lto5Q6A6Q+vtSsUEimbTfG/zuL/C6vGChyF
 ltwbwe2ov0TViVAXoEGO9tehlv8+6omAa6Nzwu3oexJ1dsfTaohYqp0lTGg2wwKJ2E1z
 yFFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWT6pick+S5Q9htgOX3csnSFzFStvDMEFgfvPZP0coN9coHHAXTWgU1SxmRBiDcA997RQVWcL3aSl3cZ0Slva4jbgY8kRg=
X-Gm-Message-State: AOJu0YyRRZyYV2FEp8XobmJSEBbUSAi0VrcTEwgOXozz2L3wORM9B+Ez
 oIfWoO9t0bEhqhwzp52Fo5q6Tjb7llNR4oSG3NKpQd2cerjflOx5ZbbHxrN/mQM=
X-Google-Smtp-Source: AGHT+IGRwheycfMeZE37wdLeo7Rzu/MRs8kA/2uwwhXvmvkUEwZNStKsASnoNOz3icaXZnGwfoY0QA==
X-Received: by 2002:a05:6808:eca:b0:3c9:6e4f:eeec with SMTP id
 5614622812f47-3c9970bde8cmr11745544b6e.37.1715572376295; 
 Sun, 12 May 2024 20:52:56 -0700 (PDT)
Received: from n37-006-243.byted.org ([180.184.51.40])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f4d2a8137asm6407947b3a.45.2024.05.12.20.52.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 May 2024 20:52:55 -0700 (PDT)
From: Changqi Lu <luchangqi.123@bytedance.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com, Changqi Lu <luchangqi.123@bytedance.com>
Subject: [PATCH v2 04/11] scsi/util: add helper functions for persistent
 reservation types conversion
Date: Mon, 13 May 2024 11:52:23 +0800
Message-Id: <20240513035230.60162-5-luchangqi.123@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240513035230.60162-1-luchangqi.123@bytedance.com>
References: <20240513035230.60162-1-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-oi1-x22e.google.com
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

This commit introduces two helper functions
that facilitate the conversion between the
persistent reservation types used in the SCSI
protocol and those used in the block layer.

Signed-off-by: Changqi Lu <luchangqi.123@bytedance.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 include/scsi/utils.h |  8 +++++
 scsi/utils.c         | 77 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+)

diff --git a/include/scsi/utils.h b/include/scsi/utils.h
index d5c8efa16e..89a0b082fb 100644
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
@@ -135,6 +137,12 @@ uint32_t scsi_data_cdb_xfer(uint8_t *buf);
 uint32_t scsi_cdb_xfer(uint8_t *buf);
 int scsi_cdb_length(uint8_t *buf);
 
+BlockPrType scsi_pr_type_to_block(SCSIPrType type);
+SCSIPrType block_pr_type_to_scsi(BlockPrType type);
+
+uint8_t scsi_pr_cap_to_block(uint16_t scsi_pr_cap);
+uint16_t block_pr_cap_to_scsi(uint8_t block_pr_cap);
+
 /* Linux SG_IO interface.  */
 #ifdef CONFIG_LINUX
 #define SG_ERR_DRIVER_TIMEOUT  0x06
diff --git a/scsi/utils.c b/scsi/utils.c
index 357b036671..f1b63f9196 100644
--- a/scsi/utils.c
+++ b/scsi/utils.c
@@ -658,3 +658,80 @@ int scsi_sense_from_host_status(uint8_t host_status,
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
+
+
+uint8_t scsi_pr_cap_to_block(uint16_t scsi_pr_cap)
+{
+    uint8_t res = 0;
+    res |= (scsi_pr_cap & SCSI_PR_CAP_WR_EX) ?
+           BLK_PR_CAP_WR_EX : 0;
+    res |= (scsi_pr_cap & SCSI_PR_CAP_EX_AC) ?
+           BLK_PR_CAP_EX_AC : 0;
+    res |= (scsi_pr_cap & SCSI_PR_CAP_WR_EX_RO) ?
+           BLK_PR_CAP_WR_EX_RO : 0;
+    res |= (scsi_pr_cap & SCSI_PR_CAP_EX_AC_RO) ?
+           BLK_PR_CAP_EX_AC_RO : 0;
+    res |= (scsi_pr_cap & SCSI_PR_CAP_WR_EX_AR) ?
+           BLK_PR_CAP_WR_EX_AR : 0;
+    res |= (scsi_pr_cap & SCSI_PR_CAP_EX_AC_AR) ?
+           BLK_PR_CAP_EX_AC_AR : 0;
+    return res;
+}
+
+uint16_t block_pr_cap_to_scsi(uint8_t block_pr_cap)
+{
+    uint16_t res = 0;
+    res |= (block_pr_cap & BLK_PR_CAP_WR_EX) ?
+              SCSI_PR_CAP_WR_EX : 0;
+    res |= (block_pr_cap & BLK_PR_CAP_EX_AC) ?
+              SCSI_PR_CAP_EX_AC : 0;
+    res |= (block_pr_cap & BLK_PR_CAP_WR_EX_RO) ?
+              SCSI_PR_CAP_WR_EX_RO : 0;
+    res |= (block_pr_cap & BLK_PR_CAP_EX_AC_RO) ?
+              SCSI_PR_CAP_EX_AC_RO : 0;
+    res |= (block_pr_cap & BLK_PR_CAP_WR_EX_AR) ?
+              SCSI_PR_CAP_WR_EX_AR : 0;
+    res |= (block_pr_cap & BLK_PR_CAP_EX_AC_AR) ?
+              SCSI_PR_CAP_EX_AC_AR : 0;
+    return res;
+}
-- 
2.20.1


