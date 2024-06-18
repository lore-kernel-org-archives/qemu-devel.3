Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3E29C2BA18
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 17:26:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJcae-0008S3-D5; Tue, 18 Jun 2024 13:25:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3CsNxZgwKCpE8vw32zDEz0v819916z.x97Bz7F-yzGz689818F.9C1@flex--nabihestefan.bounces.google.com>)
 id 1sJcaQ-0008Jd-T3
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 13:25:41 -0400
Received: from mail-pf1-x449.google.com ([2607:f8b0:4864:20::449])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3CsNxZgwKCpE8vw32zDEz0v819916z.x97Bz7F-yzGz689818F.9C1@flex--nabihestefan.bounces.google.com>)
 id 1sJcaL-00045h-4C
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 13:25:37 -0400
Received: by mail-pf1-x449.google.com with SMTP id
 d2e1a72fcca58-7059fdafc78so4797675b3a.2
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 10:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1718731530; x=1719336330; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=mIz+uBMleWspMGOXrthG2m3FtkYnjCAe7akkH5AGnWM=;
 b=ujUJ/7jfuZI/QvaoX8GuGiMH2BqIFdGkwP/ncqfZB8Hpypjkj0QcwYxLsTYJQp/kCI
 IAn9gf1RD7U4Cu1pJzklLqUenzLSnJQolGJOQf0LKvH5tcrwTuVItRTv49RFj9tIDBrw
 JY1313x9bVHd4FOqxKc8MrMAbFN8ng7vJu51wDagkyZ8V70fR9pujuTefL5PFQ+48PsI
 zre6wVDrEXgsLmDx5y/DBiRibqAsVb0XdA0t8ym95/jS+sq0de5ndKQpJCrZL2tzDxpx
 10hY6NociedyLqANbUdSlUzrpys63mjAG34wJNISDnmty/ctY5Wd1hnpS6pAU82WK5bD
 KlzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718731530; x=1719336330;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mIz+uBMleWspMGOXrthG2m3FtkYnjCAe7akkH5AGnWM=;
 b=JI+MkI/pubo975jEfZgk4kT5q0fVGGpFVvI8CzJVe+50S/YGaRdpC4j8+go5lWPWKE
 6Z0j+T/HNikKHDVRll/qJrLJZploP4OR32QDWl6FTIAWX0Tf6jauCUKR1NaM6KL+wB5T
 q1rVNs9ctWnJyxZWm201VVthtdbbcEd6MEuo+yL8/jp0Z88P66eplHxkFgJJFVDBgVan
 nVxvSCIG8cqDiMrWP/9wcllsBTfun3sBD3skG5Rt6eBWGTV8MJBpnqh/PmtbEOoDewoV
 bHQ/1bVvxkbZ+SzK3uuMiWEDyoLYYUMyiDV+eoyDg7+Xf0hMDeqY6jKtAb53lNIb5b/Z
 lGPA==
X-Gm-Message-State: AOJu0YwCtAj3usM+2TMZnJtGIsMlT0PQgmzrVsXCUnBwBDmp5ZsUUyDQ
 xzt017O19IQ3QbptWZGeZJrdm8VaU7+GCve96s05mo6slkISMCFWIHc9leJsr7P9UWwPB196Thk
 pjqMs+Ah7NOZBcSJJOLtZAwiiVg==
X-Google-Smtp-Source: AGHT+IF+IYqipwq+INBn+wOG+lXUlo0C+Cm0B5L6VFhjVrY0oSIpckGFc3xgh8obLRgb2s6tAby0QoYAtQzOUT2Vnf4=
X-Received: from nabihestefan.c.googlers.com
 ([fda3:e722:ac3:cc00:20:ed76:c0a8:2737])
 (user=nabihestefan job=sendgmr) by 2002:a05:6a00:1d84:b0:705:dbf5:1905 with
 SMTP id d2e1a72fcca58-70629ce5559mr814b3a.3.1718731530081; Tue, 18 Jun 2024
 10:25:30 -0700 (PDT)
Date: Tue, 18 Jun 2024 17:25:27 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Message-ID: <20240618172527.3450098-1-nabihestefan@google.com>
Subject: [PATCH] hw/net: Fix Coverity Issue for npcm-gmac
From: Nabih Estefan <nabihestefan@google.com>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, kfting@nuvoton.com, wuhaotsh@google.com, 
 jasowang@redhat.org, nabihestefan@google.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::449;
 envelope-from=3CsNxZgwKCpE8vw32zDEz0v819916z.x97Bz7F-yzGz689818F.9C1@flex--nabihestefan.bounces.google.com;
 helo=mail-pf1-x449.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

There is an extra `buf=` set that is not used by npcm-gmac. Remove it
for coverity to be happy.

Signed-off-by: Nabih Estefan <nabihestefan@google.com>
---
 hw/net/npcm_gmac.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/net/npcm_gmac.c b/hw/net/npcm_gmac.c
index 1b71e2526e..b397fd5064 100644
--- a/hw/net/npcm_gmac.c
+++ b/hw/net/npcm_gmac.c
@@ -614,7 +614,6 @@ static void gmac_try_send_next_packet(NPCMGMACState *gmac)
             net_checksum_calculate(tx_send_buffer, length, csum);
             qemu_send_packet(qemu_get_queue(gmac->nic), tx_send_buffer, length);
             trace_npcm_gmac_packet_sent(DEVICE(gmac)->canonical_path, length);
-            buf = tx_send_buffer;
             length = 0;
         }
 
-- 
2.45.2.627.g7a2c4fd464-goog


