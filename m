Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26715C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 17:25:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJcZf-0006nw-Vs; Tue, 18 Jun 2024 13:24:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <33sJxZgwKCmUQDELKHVWHIDQJRRJOH.FRPTHPX-GHYHOQRQJQX.RUJ@flex--nabihestefan.bounces.google.com>)
 id 1sJcZd-0006mW-Th
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 13:24:49 -0400
Received: from mail-yw1-x1149.google.com ([2607:f8b0:4864:20::1149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <33sJxZgwKCmUQDELKHVWHIDQJRRJOH.FRPTHPX-GHYHOQRQJQX.RUJ@flex--nabihestefan.bounces.google.com>)
 id 1sJcZc-0003jn-FN
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 13:24:49 -0400
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-6311e0f4db4so104030897b3.3
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 10:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1718731487; x=1719336287; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=mIz+uBMleWspMGOXrthG2m3FtkYnjCAe7akkH5AGnWM=;
 b=TQlnM74L0nNbob+u9CD1xGkq2G5D+9tYvcxDZOiRjGkMRc3T/XjBzYzrQIhmuJ3Kch
 p82GQjVAOWzZS5HmQ0jbmZdIQpipBxcp1f1lUs45VpOW7WCCNTlD+Q7aQSziRIPSY8oR
 rcMbOPOJY+TgwufrGAS88j1tLBNKjIICTkTHcwnpcZMhfAXVWif0hz7IhIClG++LrPaY
 YCOff1Ju+AJTu2PbRXIZuf/GxgaDSgdp67bNu88c7iAmXxlXwxsVwE1axqReJsDq/iyn
 7s1ZTXkNSedQvAuXEjxewQZPW/v4+ypKyxugwvxCljk5kWe4741LY/asHOFy+JUv7ckg
 CHFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718731487; x=1719336287;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mIz+uBMleWspMGOXrthG2m3FtkYnjCAe7akkH5AGnWM=;
 b=YOI7NFBTY3C5MLqr11zgomH2m3xeW0kPHpEuD2DlVcleCt7PKana+hg4VxuBPPbtvu
 8nx2Jdrx2P7vo90csirGyKS/D6GGV7FohTVY0UWB68GCCY8dgOA/1s+H+ATw4GMG+WFr
 VbLgGOSn7B97B5wcMMljc77uPgscj3I2JFtpMre7NJ8/PAxFKNCWaxvUvVIlE+G40Cak
 NJGU9eYW7ytmUep1PXNrjbm4/rho0zBr9caOc0x8v7BYRq3eaiC1N2i8OMBAhkZLUfng
 ANf7m/Mijhn/u+aeiqbdo1v3y+coOq1KfOqKpaVYKvSRj2EVtpT1UCiE1QNO8Nha04fS
 ONwg==
X-Gm-Message-State: AOJu0Yw/jcSZlQhatYG1rdvUX0Go/Nbauw4iqZa9xkJbVfb333tN6Hyv
 sH2v+EPHcXHD0GK6tRQY/jYAyS/Y5Xbu9EXzkC/0HKV9qguNllOjhzci15pS6HIqBooettFlvcM
 lT+X+DckMwFIuF3guZV9NmY37vg==
X-Google-Smtp-Source: AGHT+IFWIP6k+GDRWfoKPWfSwqr8HN1Gi5gLuK1wLizfKh/Qbma4A0YZzKwW/UcGzTTlud3EKzl2CxwVSydd80/vnJs=
X-Received: from nabihestefan.c.googlers.com
 ([fda3:e722:ac3:cc00:20:ed76:c0a8:2737])
 (user=nabihestefan job=sendgmr) by 2002:a05:690c:88:b0:62c:67f4:4f5 with SMTP
 id 00721157ae682-63a8ffc83e1mr907397b3.9.1718731486902; Tue, 18 Jun 2024
 10:24:46 -0700 (PDT)
Date: Tue, 18 Jun 2024 17:24:42 +0000
In-Reply-To: <20240618172442.3449262-1-nabihestefan@google.com>
Mime-Version: 1.0
References: <20240618172442.3449262-1-nabihestefan@google.com>
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Message-ID: <20240618172442.3449262-2-nabihestefan@google.com>
Subject: [PATCH] hw/net: Fix Coverity Issue for npcm-gmac
From: Nabih Estefan <nabihestefan@google.com>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, kfting@nuvoton.com, wuhaotsh@google.com, 
 jasowang@redhat.org, nabihestefan@google.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1149;
 envelope-from=33sJxZgwKCmUQDELKHVWHIDQJRRJOH.FRPTHPX-GHYHOQRQJQX.RUJ@flex--nabihestefan.bounces.google.com;
 helo=mail-yw1-x1149.google.com
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


