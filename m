Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 855D3C3271E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 02:49:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR0tl-00075V-Rc; Mon, 08 Jul 2024 22:48:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sR0tS-0006iy-AW
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 22:47:51 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sR0tQ-0003vG-JU
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 22:47:50 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2c9a1ea8cc3so2911852a91.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 19:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1720493267; x=1721098067; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CUQGygF7ax3lHkGrG99vLN6/xen2jiCuqCocfv+MI40=;
 b=eqOC0i5hkWsBvBiM3o2w0nPVZ+dbrTgSxkpnUg6lCCY7d8AHb4Kf1mFuHke+DOBPKY
 c5oXx6gxeReKHSeefGe6AY3u+0QhI5OSdHNZgl9WuxnbScXWc3P6+e2Ioi5ET3diGHh0
 pgeHBFhUHLrJqGsef9SvdauPrjWwWxW9wZ8QIetSjOfhBb6GFyJtyeM7gRN8zGOA3Xud
 Tfnl0EsUJpdyxZdl2c5+jzQg/8O0/CW8Hxy+EN0N9CzYm1FuBtks3qoESvlQlrA4vc7N
 /sp+GRBui4sG59MH3eqkUXhbEO5HlbTJtNpEOBHHOUfdZKc99APG8AJcIBFovUeGMIj6
 +ruQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720493267; x=1721098067;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CUQGygF7ax3lHkGrG99vLN6/xen2jiCuqCocfv+MI40=;
 b=FPpbeIAF6jOKHw57mu1rhY7QxQeHLw05Sn7SeVNzuYjX46/dSWefv1AM0eiDgbTpAj
 JPfIoqzjvqI2In3ic/+bBPHqZFzUkGt7A5HHBzv47F+pxHdNE/tCRny3hjEvAgoc0Z5C
 PsfisiOlhaj4/HPbb9ic6U1ktHTHx3FHc3On/XPmlLWJiL/rvoNWwHqc5bXukmBC1ob7
 VNk09kWcZ5cCCCwxxuPLos8hSt4xg117Sy7lRaYp7/lsTifJf135ReZ/iFtkHQrzrlye
 pDpYURdwMOwSehOCZGrPFqEWX1iqcIsk09H4mcvL5byn8F4AqCDt1rogSIT86Y8xf4zW
 CrzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUu8ncC+y2pp9l7pBx4xXeAbKU1pJunKE02KgO8xKV44V6FjbVvTkc2uA/AbiRFJnrI+n+9O1bDmCVNl1+ODCMq2sOZ5vc=
X-Gm-Message-State: AOJu0Yz/vIRq1wcj0yU3FDdEAYPdIbuJxQX32lYvZM5k/j9KumQB4IkF
 MWC1QuIttaf7l1suwizcuyyRe0Tj8ygYCYRxuyy2onRDypnojDtL984xeBkHwm4=
X-Google-Smtp-Source: AGHT+IFOU4Neoj7hWnBDufij+xm3oWBKDxSvv4N/swxxU3oViMSAZ8mPoMo0jTRWPYFeNIXAJh6AmA==
X-Received: by 2002:a17:90b:1904:b0:2c8:f5c2:ad0c with SMTP id
 98e67ed59e1d1-2ca3a7ac2bbmr1410107a91.2.1720493266872; 
 Mon, 08 Jul 2024 19:47:46 -0700 (PDT)
Received: from TF4D9JK212.bytedance.net ([61.213.176.9])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c99a97e8a5sm8964661a91.27.2024.07.08.19.47.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 08 Jul 2024 19:47:46 -0700 (PDT)
From: Changqi Lu <luchangqi.123@bytedance.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com, Changqi Lu <luchangqi.123@bytedance.com>
Subject: [PATCH v8 04/10] scsi/util: add helper functions for persistent
 reservation types conversion
Date: Tue,  9 Jul 2024 10:47:00 +0800
Message-Id: <20240709024706.4108-5-luchangqi.123@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20240709024706.4108-1-luchangqi.123@bytedance.com>
References: <20240709024706.4108-1-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-pj1-x1036.google.com
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
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/scsi/utils.h |  8 +++++
 scsi/utils.c         | 81 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 89 insertions(+)

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
index 357b036671..0dfdeb499d 100644
--- a/scsi/utils.c
+++ b/scsi/utils.c
@@ -658,3 +658,84 @@ int scsi_sense_from_host_status(uint8_t host_status,
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
+
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
+
+    return res;
+}
+
+uint16_t block_pr_cap_to_scsi(uint8_t block_pr_cap)
+{
+    uint16_t res = 0;
+
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
+
+    return res;
+}
-- 
2.20.1


