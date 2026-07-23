Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 243C5C44524
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 07:03:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmnRR-00020w-LY; Thu, 23 Jul 2026 03:02:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wmnRM-0001xm-2J
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 03:01:57 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wmnRJ-00043x-Gx
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 03:01:55 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-47f703a9d05so122702f8f.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 00:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784790112; x=1785394912; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gx+nP4/fruRtsOB2fGcEDD0bbwS2iaaOfg3Ia3056d8=;
 b=YkS9ZCxPF3LCwLdqn+Gbw2A6pH92DpLBBNJFh5kmDWjFvM0LjDSrRMQUkVtaYrk4sD
 M7q4gom7UwgqYqZ5cck6RuemmqLyoECa7dNFDTE/FrZL1nWWyzZqlNJ3CS299p1eAHws
 6ucMPi0zfEzam/G+rzhxUcy4A+akBl7hhlOgnx9UJV+5K/9jlrS+wiDCiGI4NX8EYCbB
 IpzIVhks6XxAM17Bj1mNlgIPY9DfGWhW0iUz/f3Xa1pnoWAYm+IMk3imJMFLSy4Hw5XU
 VQAgCLMRWyCgl38ALavBQTG1cke+EdRRjzane54PPgypq2xrh0BTq5fYAmO79xNczJ+M
 m5Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784790112; x=1785394912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gx+nP4/fruRtsOB2fGcEDD0bbwS2iaaOfg3Ia3056d8=;
 b=pG6jyDRVGOJlAEpPSVyRIXlv7MH7c/or2/ons0v4EEN0Zu/48KP29FCxf8LiDYqV9t
 5SKEkiJUDzt9rjro/lAZIW5avohuHqQCQOQoDSZqQmeUud2TIyGK6c4woIFaq9gql0ES
 H06G/7ieH0oAmTSJkie7dk7R6HTV7PHgq1bDHtTiQaGSbog/WJWlyv/p91KA7aHYuQ5W
 zAKAISXdrAcqozEWECUHilN/flsXY9v2a5hP0NGwf3nBhuDOzIkmVzG60hGSLan5a8fO
 eQBji6e19LpodiAG8DQlvXHbY+GYHqqSo8O9ol5FI80wbYXgXjKMdumCqC31U8B9qzhe
 auoQ==
X-Gm-Message-State: AOJu0YzwamU/b9UQd9tlac5lOZQp4LN0At351qyyQV2m896AeDDX8OS5
 DoVdCp+SpxwGxhonZB50DVozOly+fTnvHBBt1WrHvG9ia3NHer1VYno7PBSYUzWc
X-Gm-Gg: AR+sD12lkBuZlChWTZD7gAwJXUSjtQR0kka/3qp3T7igbUNtZpZ6LcD5xmZPkBMKoHz
 MqHb1aEVwG2cYH8R+NxSpOdr9pSiU7Jg1Hct+CKeVV6p9aS9YWhbwd+4B5Hh3AGQiTYf534jr13
 mVMV1dquCNFWxmaf4lJL6ij+ONhiUeo0Feswdd2AZBmQcnu1bFGgX2J1CArAy22+fSYDrR77oUy
 uJx7B5nZyEZndpnnWPxuPO2B3zC64kGBdPGTU23Xej2NPTIPsC262FGZ0AsARiHTj9YBxUY1btW
 u609IQdKW29StxiJVcdOI82Ovc050uzkljrZtG8GwBnzJJDNo/MGTILtNUmUe96Ew/sJnfIHO40
 HrBffC75aIUmFm4ezVrbWZl9bw6Vb5FyVjzvn2wg5VLFis4IFvC1W50H2Fei83VmbhE/lX1kffA
 7XQmeOf24ewZy0xlIhaC0PmquIt/VARAb0i4xU87pvgU0zJkmMs+3X4XIoeh0HEQ2+nSQ2yp/bm
 i5PBOYomkUo5LoiLKPemFcu7F6Onnhi5+Mi
X-Received: by 2002:a05:6000:230a:b0:47f:8817:eb6f with SMTP id
 ffacd0b85a97d-47f8dcb377amr2111163f8f.49.1784790111571; 
 Thu, 23 Jul 2026 00:01:51 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-2a02-3100-29ed-6000-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:29ed:6000:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c6dc25sm13293923f8f.33.2026.07.23.00.01.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 00:01:51 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Pavel Pisa <pisa@cmp.felk.cvut.cz>, Matyas Bobek <matyas.bobek@gmail.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Jason Wang <jasowangio@gmail.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 9/9] hw/net/can/flexcan: Remove RX SMB raw view
Date: Thu, 23 Jul 2026 09:00:59 +0200
Message-ID: <20260723070059.6332-10-shentey@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260723070059.6332-1-shentey@gmail.com>
References: <20260723070059.6332-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x429.google.com
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

Use the existing `rx_smb0` message buffer view for register masks instead
of the raw register array. Since all accesses now use the structured view,
remove the redundant `rx_smb0_raw` union member.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/net/flexcan.h |  5 +----
 hw/net/can/flexcan.c     | 12 ++++++++++--
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/include/hw/net/flexcan.h b/include/hw/net/flexcan.h
index 9affdff837..eee70bad42 100644
--- a/include/hw/net/flexcan.h
+++ b/include/hw/net/flexcan.h
@@ -81,10 +81,7 @@ typedef struct FlexcanRegs {
     uint32_t _rx14mask;          /* 0xAA8 */
     uint32_t _rx15mask;          /* 0xAAC */
     uint32_t tx_smb[4];          /* 0xAB0 */
-    union {                      /* 0xAC0, used for SMB emulation */
-        uint32_t rx_smb0_raw[4];
-        FlexcanRegsMessageBuffer rx_smb0;
-    };
+    FlexcanRegsMessageBuffer rx_smb0; /* 0xAC0, used for SMB emulation */
     uint32_t rx_smb1[4];         /* 0xAD0 */
     uint32_t mecr;               /* 0xAE0 */
     uint32_t erriar;             /* 0xAE4 */
diff --git a/hw/net/can/flexcan.c b/hw/net/can/flexcan.c
index 205d0d6413..a8bad83cb8 100644
--- a/hw/net/can/flexcan.c
+++ b/hw/net/can/flexcan.c
@@ -106,7 +106,11 @@ static const FlexcanRegs flexcan_regs_write_mask = {
     .gfwr_mx6 = 0xFFFFFFFF,
     ._reserved6 = {0},
     ._reserved8 = {0},
-    .rx_smb0_raw = {0, 0, 0, 0},
+    .rx_smb0 = {
+        .can_ctrl = 0,
+        .can_id = 0,
+        .data = { 0, 0 },
+    },
     .rx_smb1 = {0, 0, 0, 0},
 };
 static const FlexcanRegs flexcan_regs_reset_mask = {
@@ -145,7 +149,11 @@ static const FlexcanRegs flexcan_regs_reset_mask = {
     .gfwr_mx6 = 0,
     ._reserved6 = {0},
     ._reserved8 = {0},
-    .rx_smb0_raw = {0, 0, 0, 0},
+    .rx_smb0 = {
+        .can_ctrl = 0,
+        .can_id = 0,
+        .data = { 0, 0 },
+    },
     .rx_smb1 = {0, 0, 0, 0},
 };
 
-- 
2.55.0


