Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EAE1C3064D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:19:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5kd-0001Ws-DE; Fri, 28 Jun 2024 03:10:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5ka-0001Q5-Hn
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:10:28 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5kY-0004o6-MJ
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:10:28 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-42122ac2f38so1540575e9.1
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558625; x=1720163425; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0++Ogxou44hWy9HUie+kN/Bmub/+XHfRbLoibWWU/Qg=;
 b=a7kOqS0hmVjM+ZumUhnocgWKmxftbpo9+fsPyizfuJHSouCCvB728uxLmVeHRYt1sY
 /mPLJUk1NEh13o2hOxbbf0pnqd9smk10Z3rXShWalh5yVAA4YpHu+7Dzx9gz5hDeWQNw
 Er4qWh5z/+8etCvNBDPReEcw8wFdRWYCJ9LqaadzVr+q6AEAWEk9Vj8BFbSf6+tka+xT
 alJoK6iaImTUwr13CiO/KroRGMoHFBOXKn6oy4vQsCm1zzMbCP+2jvPojiQgUSw06edb
 fgF8OLDjKQJP/zyZC7CcTVdpz8kiq6QaZ9bbTYEhB0lfF+hBISaw0+wWCog+KmdnHlsj
 DSUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558625; x=1720163425;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0++Ogxou44hWy9HUie+kN/Bmub/+XHfRbLoibWWU/Qg=;
 b=mkZazjtTGgNyXfcsKyq/5dHhQUxPz4fjTZG33wuxUx2i9iGBTEvkJLy/LguoHJU6Qq
 W9/ic3h1yy7yoP6SqTWyH/jaiensgMHYCv7yyaVCHtN3a0Dg1lJiXMb4Wmv8/wd1BTRk
 Fy5BWW0uLhXSxhu8Swz2i5aumHfu/BLZ1RlxF0neksFtxVovU9rwjrtcvorQYIBvgWXA
 dUrULREGHY53ObpdnwRNY7tWg6pbsizV9VtzMAxuxE7hfmOQzjE50NFgNeXwYeE1myY9
 t2EmeqhFbK6xSzQghMSprbuuB8SEuZ/FMqeCF7OGNxA12kQvVDj51rVcPClGlPOm4eZx
 ZzSQ==
X-Gm-Message-State: AOJu0Yw2HKK1BQ2vV6meMyRooWIFEarPyctpCC1YAAU4hZCGaDhIuXgp
 yNfxIB2lzz9Tvj135FnOop4K48WNdabQ0YLW6ni/ZIi14Wfw7sgjhP5OkX5krm39wAifTChFr28
 yoe4=
X-Google-Smtp-Source: AGHT+IGWSEOvJEopLeIFvtKJN9GUWMXhGah7i54cpUM3pAkXVPUwEZiyyDUuQ0Jzv8/Gnc63JQwOCg==
X-Received: by 2002:a05:600c:3595:b0:424:8743:86b4 with SMTP id
 5b1f17b1804b1-4256d4d35a7mr5558185e9.6.1719558624866; 
 Fri, 28 Jun 2024 00:10:24 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-424a2abcfd0sm62364015e9.1.2024.06.28.00.10.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:10:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v42 83/98] hw/sd/sdcard: Register generic command handlers
Date: Fri, 28 Jun 2024 09:01:59 +0200
Message-ID: <20240628070216.92609-84-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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
 hw/sd/sd.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 249fad0468..ebcd8c1e43 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2383,6 +2383,28 @@ static const SDProto sd_proto_emmc = {
     /* Only v4.5 is supported */
     .name = "eMMC",
     .cmd = {
+        [0]  = {0,  sd_bc,   "GO_IDLE_STATE", sd_cmd_GO_IDLE_STATE},
+        [2]  = {0,  sd_bcr,  "ALL_SEND_CID", sd_cmd_ALL_SEND_CID},
+        [7]  = {0,  sd_ac,   "(DE)SELECT_CARD", sd_cmd_DE_SELECT_CARD},
+        [9]  = {0,  sd_ac,   "SEND_CSD", sd_cmd_SEND_CSD},
+        [10] = {0,  sd_ac,   "SEND_CID", sd_cmd_SEND_CID},
+        [12] = {0,  sd_ac,   "STOP_TRANSMISSION", sd_cmd_STOP_TRANSMISSION},
+        [13] = {0,  sd_ac,   "SEND_STATUS", sd_cmd_SEND_STATUS},
+        [15] = {0,  sd_ac,   "GO_INACTIVE_STATE", sd_cmd_GO_INACTIVE_STATE},
+        [16] = {2,  sd_ac,   "SET_BLOCKLEN", sd_cmd_SET_BLOCKLEN},
+        [17] = {2,  sd_adtc, "READ_SINGLE_BLOCK", sd_cmd_READ_SINGLE_BLOCK},
+        [23] = {2,  sd_ac,   "SET_BLOCK_COUNT", sd_cmd_SET_BLOCK_COUNT},
+        [24] = {4,  sd_adtc, "WRITE_SINGLE_BLOCK", sd_cmd_WRITE_SINGLE_BLOCK},
+        [27] = {4,  sd_adtc, "PROGRAM_CSD", sd_cmd_PROGRAM_CSD},
+        [28] = {6,  sd_ac,   "SET_WRITE_PROT", sd_cmd_SET_WRITE_PROT},
+        [29] = {6,  sd_ac,   "CLR_WRITE_PROT", sd_cmd_CLR_WRITE_PROT},
+        [30] = {6,  sd_adtc, "SEND_WRITE_PROT", sd_cmd_SEND_WRITE_PROT},
+        [35] = {5,  sd_ac,   "ERASE_WR_BLK_START", sd_cmd_ERASE_WR_BLK_START},
+        [36] = {5,  sd_ac,   "ERASE_WR_BLK_END", sd_cmd_ERASE_WR_BLK_END},
+        [38] = {5,  sd_ac,   "ERASE", sd_cmd_ERASE},
+        [42] = {7,  sd_adtc, "LOCK_UNLOCK", sd_cmd_LOCK_UNLOCK},
+        [55] = {8,  sd_ac,   "APP_CMD", sd_cmd_APP_CMD},
+        [56] = {8,  sd_adtc, "GEN_CMD", sd_cmd_GEN_CMD},
     },
 };
 
-- 
2.41.0


