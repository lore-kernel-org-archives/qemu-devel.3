Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0133FC2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 17:12:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMsfT-0007pk-5M; Thu, 27 Jun 2024 13:12:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsfL-0007cV-ER
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 13:12:14 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsfG-0002Fw-Hl
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 13:12:09 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-424adaa6ceeso16913265e9.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 10:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719508324; x=1720113124; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UmLMWLzqSVJb3i4hpxGU8DfPCxonGkzeRg9cK3jhrKk=;
 b=Y1A6NfH35RWYCWR5yW7NnBmLBTojHHvwFtr2CLm+vn64wxlTaQWThTmfD+omNjBlUk
 4gb0lx3GctdZIpZPBgyl78wlV0vlI2u0rBxVk07mzd8YsUfZpXMldI2QceDpXDFtNOww
 gYadD0uiATnK0uQWSXO8rvx3PRCenMORojDSgClT0W9b6JtvzKAl4b3wZBzQ6E1Qyopi
 WCDHnuB0wN/lsBnKr87h6YGi12AeiT9ZSZ9+y5L0b65wIDZfCo0At+TN+5Wn/LGvgMY0
 bP9X+Jj2i48r/69OEeFuQDj6qm8BFw+7oCW1SIJDehw7bxQztkwyCB7ALqZEmZ0UYhiG
 pkgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719508324; x=1720113124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UmLMWLzqSVJb3i4hpxGU8DfPCxonGkzeRg9cK3jhrKk=;
 b=QAEO8rHyN0EdYRaqJdWjoMIO7q3PwEIplfIMf7zta76Lqmd4Flj8lWLhQe42TRl5sA
 HDbgbPvw5Oa1lAvC+VFWt8JOb/e6A3qS3M+gsOwc9MWpz4lrUY4hMyUXN0MWFXTqUanO
 Um8w4VtkZyA7XNDJkcGMvZ4z6ZlBaJy8sFFQthvnO45c2+gJRI60/m5dorUwdGJiLFT2
 nm0b3oEcjcOdEI/R8TZakYHocva2EoIlIg97Y2+nHdOxy/TUNQ6zhnGjhuKkAOciLFt9
 u1ktOzyErW3uaFD8dsLw4PYCihxHJVPh1Mt/SkIZHsEDdkFLD8LiSHXd+2gz30K6jsPB
 m7Ug==
X-Gm-Message-State: AOJu0Yywxhwgo6+lxZCgfs2e3X9COMY9GJg12ijVE/dgF/rzD0h08BfD
 tMkmcaT6uTo2Rsutr6oDy8wd3qfnSfMuq7S+ZIOubN+W5ENFWppfvN/M+16QuHuoNdXY3wy9G6D
 8ktU=
X-Google-Smtp-Source: AGHT+IGDCyAn0fUeqPsEP+b662QuYiY3plVCB+tt6PlWVPAmTWWb/ialx1X6Iva0FsqSI7zt1PMnkw==
X-Received: by 2002:a05:600c:158a:b0:424:b3cf:d704 with SMTP id
 5b1f17b1804b1-424b3cfd940mr38158575e9.37.1719508324562; 
 Thu, 27 Jun 2024 10:12:04 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b09a681sm650995e9.30.2024.06.27.10.12.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 10:12:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Luc Michel <luc.michel@amd.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Vincent Palatin <vpalatin@chromium.org>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH 05/19] hw/sd/sdcard: Register unimplemented command handlers
Date: Thu, 27 Jun 2024 19:10:45 +0200
Message-ID: <20240627171059.84349-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627171059.84349-1-philmd@linaro.org>
References: <20240627171059.84349-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Per the spec v4.5 these commands are mandatory,
but we don't implement them.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index ebcd8c1e43..9a2bfeaab6 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2385,24 +2385,30 @@ static const SDProto sd_proto_emmc = {
     .cmd = {
         [0]  = {0,  sd_bc,   "GO_IDLE_STATE", sd_cmd_GO_IDLE_STATE},
         [2]  = {0,  sd_bcr,  "ALL_SEND_CID", sd_cmd_ALL_SEND_CID},
+        [4]  = {0,  sd_bc,   "SEND_DSR", sd_cmd_unimplemented},
         [7]  = {0,  sd_ac,   "(DE)SELECT_CARD", sd_cmd_DE_SELECT_CARD},
         [9]  = {0,  sd_ac,   "SEND_CSD", sd_cmd_SEND_CSD},
         [10] = {0,  sd_ac,   "SEND_CID", sd_cmd_SEND_CID},
         [12] = {0,  sd_ac,   "STOP_TRANSMISSION", sd_cmd_STOP_TRANSMISSION},
         [13] = {0,  sd_ac,   "SEND_STATUS", sd_cmd_SEND_STATUS},
+        [14] = {0,  sd_adtc, "BUSTEST_R", sd_cmd_unimplemented},
         [15] = {0,  sd_ac,   "GO_INACTIVE_STATE", sd_cmd_GO_INACTIVE_STATE},
         [16] = {2,  sd_ac,   "SET_BLOCKLEN", sd_cmd_SET_BLOCKLEN},
         [17] = {2,  sd_adtc, "READ_SINGLE_BLOCK", sd_cmd_READ_SINGLE_BLOCK},
+        [19] = {0,  sd_adtc, "BUSTEST_W", sd_cmd_unimplemented},
         [23] = {2,  sd_ac,   "SET_BLOCK_COUNT", sd_cmd_SET_BLOCK_COUNT},
         [24] = {4,  sd_adtc, "WRITE_SINGLE_BLOCK", sd_cmd_WRITE_SINGLE_BLOCK},
         [27] = {4,  sd_adtc, "PROGRAM_CSD", sd_cmd_PROGRAM_CSD},
         [28] = {6,  sd_ac,   "SET_WRITE_PROT", sd_cmd_SET_WRITE_PROT},
         [29] = {6,  sd_ac,   "CLR_WRITE_PROT", sd_cmd_CLR_WRITE_PROT},
         [30] = {6,  sd_adtc, "SEND_WRITE_PROT", sd_cmd_SEND_WRITE_PROT},
+        [31] = {6,  sd_adtc, "SEND_WRITE_PROT_TYPE", sd_cmd_unimplemented},
         [35] = {5,  sd_ac,   "ERASE_WR_BLK_START", sd_cmd_ERASE_WR_BLK_START},
         [36] = {5,  sd_ac,   "ERASE_WR_BLK_END", sd_cmd_ERASE_WR_BLK_END},
         [38] = {5,  sd_ac,   "ERASE", sd_cmd_ERASE},
+        [39] = {9,  sd_ac,   "FAST_IO", sd_cmd_unimplemented},
         [42] = {7,  sd_adtc, "LOCK_UNLOCK", sd_cmd_LOCK_UNLOCK},
+        [49] = {0,  sd_adtc, "SET_TIME", sd_cmd_unimplemented},
         [55] = {8,  sd_ac,   "APP_CMD", sd_cmd_APP_CMD},
         [56] = {8,  sd_adtc, "GEN_CMD", sd_cmd_GEN_CMD},
     },
-- 
2.41.0


