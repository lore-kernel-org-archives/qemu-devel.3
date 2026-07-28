Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 927ABC54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 12:35:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wogyQ-0005U7-F4; Tue, 28 Jul 2026 08:31:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wogyI-0005SZ-6V
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 08:31:46 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wogyG-00037Q-Hy
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 08:31:45 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-47c2b362ee2so3176744f8f.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 05:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785241903; x=1785846703; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=C7yk9/Cofggcz2azu0Eut4VC7tv1BI0gzSR/Fs/eWuA=;
 b=RO2iwCvdQxq7uHW455lbqh2PdhEsqFc/Ofr0fsi9oDdQF5yB2a8a+zWcNp2bUTQf0H
 eUTy/9lGNI4SYmRpe+c9YnJxmlXt+wpIwF+aGKEUJSV/w9/TzkSJ5UJ6csAITEtzriw9
 pifjUfK+tKsmW5JV+n8S8W1FZQUPEhx3sFba1VM64FFx1gAbpp6FtYIFpbTa3PerFsRD
 zNrvn36nM+5XTbtzqwUhR4pLHsXUehyVDqZ3bJU3HsCuaGuvNRkK8aVx27D9JgxKpEnl
 Rfhq/O7leVsJq4xjdmhqv4iuwUIG5o8ZigyJOjDo6Hk4ej67jvfpshqFEhEAuNWDtT+M
 EVDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785241903; x=1785846703;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=C7yk9/Cofggcz2azu0Eut4VC7tv1BI0gzSR/Fs/eWuA=;
 b=AdXWJpRhTrFVR4uXcON8WI6LBg/SGs5JCcJzIzt10unxOUbiD7HvIe1jbrci3EcdCv
 MPCF705ZRckyNsuUUkV/WBpxMsvm4BjQllyzRUmcvn8Ubyer1Awi95wWX3lejX9E2HNf
 Bt6TgRlCwAn5Jg9NgKFPqh/hqf10WBbNAtBefCnGXc6ItgxYYsoy34naLfiaKwGzPcWG
 teUbybR6jltF0zBaYb8ffgEpFIEgPzJKGNowXy6po3cqWTku3Yu7P6yhkjJF1ieWe4Sx
 ASxx8G56skNqxdjBYDbz1zLZf4C3x8vsN1O/9P3Yeq1nF8MmJSSLoCI7Dhh9Wy7raM9S
 o7hA==
X-Gm-Message-State: AOJu0YwkgZMn0g604Y/Ar4WyYUOsPjUBwEqw76CSQ2c6KP5+aXc9H6GU
 dNo/eVeGRMWDTFKE7cwLBtF+ALDtdrNfNclsz5i/K/0YpkHbg4w5XiFhtByZM1jPLvYDYXPwCvI
 HmvUl
X-Gm-Gg: AR+sD13PCS+T+2M/IjluThOVPq0BQH3mt6scZOcS6Znek8qhS3LacAIfpqkcyjQl4e+
 BO7SMtNODKRsKzWWA9tZQcf6wTuGamHhohRptbd2E/Oz2y9urmkBazPBYXGi2DMwuqHLDgWB1IJ
 O4SYioiEPtJYoszfZFQL62wLx5Rx9ao3XGZ387zfNjHtZWFwAw20vy9dbCdDckllJ9czL5Pg9qb
 34O0yi8+/Vd+WHZLuck2mDb2A9Qxa2h1oB/ApcuLO4o7a3wgPam1CbM7ozpK9bcrhtW2fFBar6b
 UE/NrBkpK0bgOTxlMfT5YY4TfwR7IKIh6fwsqDQW8ECE+Rc9nf6lm89n8jDO4Ib4UTnUBwaV+pa
 +ad4rXgQdGO/UzXz3KjvC4MF3QJTdBNJx6810YHVDr2w77HQ9gfHaRG/+MULzXG9r/XwAG74FF4
 THJjo41hxeD0Roozk76hPV1X8rcF8sgJDI9Eo6LgBFBsoRwyjqDFC2aE+C2GDLotx5zhc0hQhlu
 R53TI6fEJ4xhQKaczJL9Q==
X-Received: by 2002:a05:6000:2408:b0:47f:80e5:b98c with SMTP id
 ffacd0b85a97d-47fb1f149c7mr2336344f8f.36.1785241903029; 
 Tue, 28 Jul 2026 05:31:43 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c6f076sm58499039f8f.34.2026.07.28.05.31.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 05:31:42 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/20] hw/net/can/flexcan: Remove RX SMB raw view
Date: Tue, 28 Jul 2026 13:31:20 +0100
Message-ID: <20260728123127.1711653-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728123127.1711653-1-peter.maydell@linaro.org>
References: <20260728123127.1711653-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

From: Bernhard Beschow <shentey@gmail.com>

Use the existing `rx_smb0` message buffer view for register masks instead
of the raw register array. Since all accesses now use the structured view,
remove the redundant `rx_smb0_raw` union member.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Tested-by: Pavel Pisa <pisa@fel.cvut.cz>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-id: 20260723070059.6332-10-shentey@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/can/flexcan.c     | 12 ++++++++++--
 include/hw/net/flexcan.h |  5 +----
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/hw/net/can/flexcan.c b/hw/net/can/flexcan.c
index 205d0d64134..a8bad83cb87 100644
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
 
diff --git a/include/hw/net/flexcan.h b/include/hw/net/flexcan.h
index 9affdff8372..eee70bad422 100644
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
-- 
2.43.0


