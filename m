Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F6E1C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 08:54:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOvl5-00056Q-Mw; Wed, 03 Jul 2024 04:54:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1sOvl4-000562-0p; Wed, 03 Jul 2024 04:54:34 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1sOvl2-00052B-Ay; Wed, 03 Jul 2024 04:54:33 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-70670188420so3537271b3a.2; 
 Wed, 03 Jul 2024 01:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719996868; x=1720601668; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lBtGd/kc9qY147JUp6Sd3Zdv63Ew3wYPxd807yyYljE=;
 b=iHOIXihS7KPEIrBbL+FVFl4dbPpNf75UFDH1fOnHsBfczKVbT4Z4amYdOwOr+6/FOS
 KnqAUUdpd+XcvkDt7W0bZNIyLManlu4WdxfbFi31pY97XeMIhAI3Qb9BjnW3AHwRi5vV
 sZxLsmGUOncZV7Kkir4i+MyxQnaC5QYyOWL+XXX8bIN8Jm9t7j1LYU1e08AN9Cnj0+Hl
 8466OFPm5GgjORoWcvohMNQ3lhUH4DNDAgLy8+BFlTdd/6ZMoI/L3yPoP1KYIdBLsMZI
 dVOcL9U2ieTt9OTwbnC8tlymYX1M7AYC/VUjOMd1KJeUMt00XaRVozfQ3/eGzu1L4UW0
 5vaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719996868; x=1720601668;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lBtGd/kc9qY147JUp6Sd3Zdv63Ew3wYPxd807yyYljE=;
 b=JCuZ9HilvzRvGiJCvRTQES/dbg1F/IkNYmo/fDxgYt3nKtmuELKSbgh/ZU6hhCwciu
 6paslcwWd3Lp7LHPdlE0NsLkrfyfjtOTTXca7NpCmxG8VflQdiQxwC4C3/zrVDY7/FGh
 8kTQeuUdaZaDQWreurSc/dCMvdhdN7xJyFDEkUGdLyX1vfHwuK7D1cipROPPNyKBZFrZ
 QiDpIJw2ydKrgCJNPt4L/5Dt7e/AvzUfsYj0O9ECKM+rqxiQASOcU1KmV7YCnOgbp01j
 OOq2Tp1Fm/Fzx7PgtSKGYZjKsvUSMMSySeL4PfS6BgkgEGOH4FX2SDTI/i3vX2hI+4+f
 NN8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoH/X9To72zaIMTO8T48r685NJ5o3S657Z0/DK9uRteDM/JZa40xPgAmktjPN8d0zvpHmlH1MABWURJ7AGC4k09OY4XmQ=
X-Gm-Message-State: AOJu0YzKbSP6vdrvu1mx+s5t3JEzZzBGCGy8tOVi2OSuJnlOcoaJSY+3
 wN9O54a+VwU5d0Wnnuurm0SFtJ43l5Zfen+sxLbxTQgeytwyEJAHvsoslURI
X-Google-Smtp-Source: AGHT+IEmi3qMPx0c+sBI2hThJxDEPHmbpRinGwXkWR5s2eZ2VIyPaGFs6m+ORnCP+j4o2I+R2ZV0uQ==
X-Received: by 2002:a05:6a00:2ea6:b0:705:bf9c:4cdd with SMTP id
 d2e1a72fcca58-70aaad4f015mr12089110b3a.16.1719996868368; 
 Wed, 03 Jul 2024 01:54:28 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([210.223.46.112])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7080246e1d9sm9905498b3a.71.2024.07.03.01.54.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 01:54:27 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
X-Google-Original-From: Jeuk Kim <jeuk20.kim@samsung.com>
To: qemu-devel@nongnu.org
Cc: jeuk20.kim@samsung.com, qemu-block@nongnu.org, j-young.choi@samsung.com,
 minwoo.im@samsung.com
Subject: [PATCH] hw/ufs: Fix mcq register range determination logic
Date: Wed,  3 Jul 2024 17:54:10 +0900
Message-Id: <6dcb63036f3b35c833de752d1472d08bf4a9c289.1719996804.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pf1-x42c.google.com
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

The function ufs_is_mcq_reg() only evaluated the range of the
mcq_op_reg offset, which is defined as a constant.
Therefore, it was possible for ufs_is_mcq_reg() to return true
despite ufs device is configured to not support the mcq.
This could cause ufs_mmio_read()/ufs_mmio_write() to overflow the
buffer. So fix it.

Fixes: 5c079578d2e4 ("hw/ufs: Add support MCQ of UFSHCI 4.0")
Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
---
 hw/ufs/ufs.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index 683fff5840..cf0edd281c 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -57,7 +57,13 @@ static inline uint64_t ufs_reg_size(UfsHc *u)
 
 static inline bool ufs_is_mcq_reg(UfsHc *u, uint64_t addr, unsigned size)
 {
-    uint64_t mcq_reg_addr = ufs_mcq_reg_addr(u, 0);
+    uint64_t mcq_reg_addr;
+
+    if (!u->params.mcq) {
+        return false;
+    }
+
+    mcq_reg_addr = ufs_mcq_reg_addr(u, 0);
     return (addr >= mcq_reg_addr &&
             addr + size <= mcq_reg_addr + sizeof(u->mcq_reg));
 }
-- 
2.34.1


