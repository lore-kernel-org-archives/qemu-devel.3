Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FA31C2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:19:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5jt-00074Q-3Y; Fri, 28 Jun 2024 03:09:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5jc-0006eY-Fv
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:09:33 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5ja-0004Vs-6p
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:09:28 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42122ac2f38so1534595e9.1
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558563; x=1720163363; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=if+k3pC7/tUCTUn2xmGg3zarIgu5LY5GHs2T467fbqI=;
 b=RQrPWzeKrxgUy+ZYVNpVACIc72t2AhgelClWyO0cVZfWapJDkPPwjCBw4qPYSHds5c
 Ic5StwTv7RLSm1qZawywpBcjChCcE+9q3qhuUSdsWZf7bU70j4ALb0C6VbbjqG0vnQ/D
 yRao4BzKw0nAW9rpuFAjfKQIEFssiZQ2r1SGag7o+Gl9ZmaRVhQiYIRB3fUAKtD3K0/Y
 87t2uSiehUHXfB77diBgeZxI4OYutPPqXuwREm2B0VTAFxTLjHiHja6QeuXg3YFG4T+I
 8mlkOYXIQc0zTnd3fbTzECLb1rVNFrICRN4oh+th67TzIOecVWGWuDKRre/6B8tITUWQ
 IHjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558563; x=1720163363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=if+k3pC7/tUCTUn2xmGg3zarIgu5LY5GHs2T467fbqI=;
 b=kDUgjNDciyRlLiYyKMaip5ErkPrNy+BvGUIbkAeG1T1Ck2kChWp6p7tsvGgq8mhvdL
 f/8oQFEuQarukWdgUfn2ExBZTbLFAA6S2ofyvsxTUq67ERA7lbMfvyCnlrJDFhvYox14
 Y+8ReYV65pWdjLmjurCTk8o6IyBYOjX2f7nB+sxP9KLzJp04ySgUgsmjhq+STBJrdz7w
 d2/o5jicJjeLcHroQg/Kb8xjGD7lH2nlOx8plCBmpjSFh7NzayK3cn6ZBcw2iZHsQa5y
 DizE70DhDlErntIv1xQ+d8XrUx/vPyWBCTdDfmmoPPokrE5ef63H7X5hfHJXZ0pBOfTL
 ycYA==
X-Gm-Message-State: AOJu0YwHq8Xo4kx33PlI++P5qVFyjiHwXx+zr+WAKlBm6bhzgKaPKfPp
 4yGh69bTV3hUsRpuNvLWCUbIcjNPHCjifhIAbqTdZG19kA8LttG2h8mwWlsZEmbf6WeZaqQotmd
 A6Cg=
X-Google-Smtp-Source: AGHT+IE4BFn/be5hKbmYafC0DQDq84x9fy/guzI1TCbdvOH/vFd8+O1xjPK+ia/KfaYH0vL20Ki6sg==
X-Received: by 2002:a05:600c:5114:b0:424:895c:b84b with SMTP id
 5b1f17b1804b1-4256d4c3f40mr6269645e9.4.1719558563723; 
 Fri, 28 Jun 2024 00:09:23 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0fb97esm1331280f8f.89.2024.06.28.00.09.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:09:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v42 71/98] hw/sd/sdcard: Add sd_acmd_SET_WR_BLK_ERASE_COUNT
 handler (ACMD23)
Date: Fri, 28 Jun 2024 09:01:47 +0200
Message-ID: <20240628070216.92609-72-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 9d66c3715a..cd207a3090 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -263,7 +263,6 @@ static const char *sd_acmd_name(SDState *sd, uint8_t cmd)
         [14] = "DPS_spec",                  [15] = "DPS_spec",
         [16] = "DPS_spec",
         [18] = "SECU_spec",
-                                            [23] = "SET_WR_BLK_ERASE_COUNT",
         [42] = "SET_CLR_CARD_DETECT",
         [51] = "SEND_SCR",
         [52] = "SECU_spec",                 [53] = "SECU_spec",
@@ -1696,6 +1695,15 @@ static sd_rsp_type_t sd_acmd_SEND_NUM_WR_BLOCKS(SDState *sd, SDRequest req)
                                  &sd->blk_written, sizeof(sd->blk_written));
 }
 
+/* ACMD23 */
+static sd_rsp_type_t sd_acmd_SET_WR_BLK_ERASE_COUNT(SDState *sd, SDRequest req)
+{
+    if (sd->state != sd_transfer_state) {
+        return sd_invalid_state_for_cmd(sd, req);
+    }
+    return sd_r1;
+}
+
 static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 {
     uint64_t addr;
@@ -1804,16 +1812,6 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
     }
 
     switch (req.cmd) {
-    case 23:  /* ACMD23: SET_WR_BLK_ERASE_COUNT */
-        switch (sd->state) {
-        case sd_transfer_state:
-            return sd_r1;
-
-        default:
-            break;
-        }
-        break;
-
     case 41:  /* ACMD41: SD_APP_OP_COND */
         if (sd->state != sd_idle_state) {
             break;
@@ -2320,6 +2318,7 @@ static const SDProto sd_proto_spi = {
     .acmd = {
         [13] = {8,  sd_spi, "SD_STATUS", sd_acmd_SD_STATUS},
         [22] = {8,  sd_spi, "SEND_NUM_WR_BLOCKS", sd_acmd_SEND_NUM_WR_BLOCKS},
+        [23] = {8,  sd_spi, "SET_WR_BLK_ERASE_COUNT", sd_acmd_SET_WR_BLK_ERASE_COUNT},
         [41] = {8,  sd_spi, "SEND_OP_COND", spi_cmd_SEND_OP_COND},
     },
 };
@@ -2379,6 +2378,7 @@ static const SDProto sd_proto_sd = {
         [6]  = {8,  sd_ac,   "SET_BUS_WIDTH", sd_acmd_SET_BUS_WIDTH},
         [13] = {8,  sd_adtc, "SD_STATUS", sd_acmd_SD_STATUS},
         [22] = {8,  sd_adtc, "SEND_NUM_WR_BLOCKS", sd_acmd_SEND_NUM_WR_BLOCKS},
+        [23] = {8,  sd_ac,   "SET_WR_BLK_ERASE_COUNT", sd_acmd_SET_WR_BLK_ERASE_COUNT},
     },
 };
 
-- 
2.41.0


