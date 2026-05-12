Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65839CD484C
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 04:44:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMeyR-0006Rv-Cw; Tue, 12 May 2026 00:44:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1wMexr-0006Hw-18
 for qemu-devel@nongnu.org; Tue, 12 May 2026 00:43:27 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1wMexp-00077R-BV
 for qemu-devel@nongnu.org; Tue, 12 May 2026 00:43:26 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2ba17c8cfacso52047415ad.2
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 21:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778561003; x=1779165803; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PDZF1y7Mn8Y8hY0V63j89ooKWGLaAhoP/CbntwCqFU4=;
 b=T0kzef3hLSvwXc354qb7FZVf7Qy/CiX39BrQ3yuhLaDdrPjamJD+LDfhgAbGlLwEEL
 sPTu6OYj1SGKSIWuf2zU3BVCKOyu22MPvvRlZa4M9vLt6BhvnKMbyYT7ZD7VQLMM1bxw
 zToCHzpOtbgqBQNasHDACFZk5NLDxGIkFgVOhJKKAQkprTlY0aWNRBKp1IFedlcFhQIP
 /ffXf+cMw+UhRwWgGbSdSkxIzNBqgRAd+q8cCHJaPWoSs5p42Lcbj0Kzn8rkjBttBOPv
 vulWEXpWm4BnDLJkJjTxVmB+aQKjnR9g3lAZKK6IdLAGFx2yz7kQG5th9yVoPl/TJWJ3
 KLtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778561003; x=1779165803;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PDZF1y7Mn8Y8hY0V63j89ooKWGLaAhoP/CbntwCqFU4=;
 b=Q+CAStUPm9gQqCohcf76KEHwEF/BkXwSfWUtyA8rmmTymblK5Nh+7xuhJYFWhr+xne
 L2kuGGK3kpAhPhYshxdNo5bj5TyvTYfwAU/e2R32QHseXC7JF6lclbfR+LBssePL++wO
 gKc8ovlhpY4puFBsDLMeCF5ujqzqT+8VvOQ6IovMBVIMkBGYfO9tZ0OBfsdjhVzMIkS4
 xyFQEXblzHhWJO1pmV4Ei83+hgNveiczgQlKZ32Z38Ntmq2SUQQu+jcPJS3Nvz+Qa6H7
 3O0AlGgB/J32KEqZpx8vLpqNvmuIICdOy6l9gRuDCaddQzZlEk64AG/hldL6LClPWeFl
 gf4Q==
X-Gm-Message-State: AOJu0Yyj4xXY2A42Ro70lDriOGwKOohxslV0zfhXr1H7fRhcQqKbyO0q
 FgXOiUgNVrHSg8lSqj9385QtZgsoUTWlmyM4sLQt8rvbeWPAcNZSj9ES0YwIXw==
X-Gm-Gg: Acq92OGS24/qcFTxyfQBTa01bNFADUUxldS1eJ9hS69CJ1nUUI/SNg+4rgjoG42g86+
 qQTKQ3c8xN6iRzU2Urf8VNrk5+5X8MxuhyGBfTw6l6CNXy9kv9nyrkEbTUV11fdUBy3F/+joLA1
 OWGGGYospKZJOI81fGL/PZMfuHqAShhUUd9QlQcebYTr9xEE8Y80/QXcrQZeZO7EcDprOs6kgr+
 LkZJ53Gty9SIHS+umK6wvpMJfUMZWqx/fe6CdyjIwZnYPcFI4cGk6MnnLDjtKl+S0AbgL8PfOW8
 Rz1MJM56X6mnowxU2zl+70hANT4A8P8SbSDayX2hF352PdDXWE1qNuWai3rp9ds22v6QmqdFOuE
 2BF/AEwr6xCh3GpJ3cEKP9jwRQlWuODsULrIqmgxtzZESOt+vSuPLP2WWJZukLz8bVkouhr7nvc
 Vp4lh97EcTXsHa6tHtIxFk6uSk0Pfj
X-Received: by 2002:a17:902:ed8b:b0:2b0:7531:b61e with SMTP id
 d9443c01a7336-2bd0135ec3bmr11534585ad.41.1778561003509; 
 Mon, 11 May 2026 21:43:23 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([211.226.54.223])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2baf1ebe7f1sm108938215ad.78.2026.05.11.21.43.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 21:43:23 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, qemu-block@nongnu.org, qemu-stable@nongnu.org,
 jeuk20.kim@samsung.com, j-young.choi@samsung.com
Subject: [PULL 5/5] hw/ufs: Zero reserved bytes in REPORT LUNS response header
Date: Tue, 12 May 2026 13:42:55 +0900
Message-ID: <042dbcff8382393b20b716294a6c4b1a4af6b3f1.1778560533.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1778560533.git.jeuk20.kim@samsung.com>
References: <cover.1778560533.git.jeuk20.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Jeuk Kim <jeuk20.kim@samsung.com>

ufs_emulate_report_luns() writes the 4-byte LUN list length into
outbuf[0..3] via stl_be_p() but leaves outbuf[4..7], the reserved
field, uninitialized. Those bytes are then DMA'd to guest memory,
leaking uninitialized QEMU stack data.

Fixes: 7708e298180 ("hw/ufs/lu: skip automatic zero-init of large array")
Cc: qemu-stable@nongnu.org
Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
---
 hw/ufs/lu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/ufs/lu.c b/hw/ufs/lu.c
index 3f3c9589ce..709d6adcf6 100644
--- a/hw/ufs/lu.c
+++ b/hw/ufs/lu.c
@@ -101,6 +101,10 @@ static int ufs_emulate_report_luns(UfsRequest *req, uint8_t *outbuf,
         return SCSI_COMMAND_FAIL;
     }
 
+    if (outbuf_len < 8) {
+        return SCSI_COMMAND_FAIL;
+    }
+    memset(outbuf, 0, 8);
     len += 8;
 
     for (uint8_t lun = 0; lun < UFS_MAX_LUS; ++lun) {
-- 
2.43.0


