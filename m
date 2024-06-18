Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2C86C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 17:25:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJcZd-0006le-Dp; Tue, 18 Jun 2024 13:24:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <33cJxZgwKCmQPCDKJGUVGHCPIQQING.EQOSGOW-FGXGNPQPIPW.QTI@flex--nabihestefan.bounces.google.com>)
 id 1sJcZc-0006gh-97
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 13:24:48 -0400
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <33cJxZgwKCmQPCDKJGUVGHCPIQQING.EQOSGOW-FGXGNPQPIPW.QTI@flex--nabihestefan.bounces.google.com>)
 id 1sJcZa-0003jg-Q6
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 13:24:48 -0400
Received: by mail-yb1-xb4a.google.com with SMTP id
 3f1490d57ef6-dfdfe3d9fc8so11618807276.3
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 10:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1718731485; x=1719336285; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=mIz+uBMleWspMGOXrthG2m3FtkYnjCAe7akkH5AGnWM=;
 b=NZvO4POqm3dOP3hzSMt9Q4BNMOc9I70qtyRyOJ2gAsPfYmd9gN5gmWVkGgSiEyg3WL
 NIlsnk7LqLGHfR6qc1h7i1wKxnNyp9zuN16vObqaE2CL/91XdBZUSPzVbI1ihT0FSflL
 a6oSxAFt/by8KWNHwerQJQe+vPJfAyYizZLur/1H1s6/OkoRAlFhU5E4QIFryjPGAE5q
 MBwtBnoO6A8j1Dnz+u0fP3xni1Mrx+yFn529I6FHkkt908VIPk/a3lQnDZ8q3EH2JqFo
 OqJPfvyBsF+OW/MUCuaLvWsVq0DOkBePpjqKjzRAlQ8QDCm8BK70H5utL0rz8gAdBeTA
 RHmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718731485; x=1719336285;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mIz+uBMleWspMGOXrthG2m3FtkYnjCAe7akkH5AGnWM=;
 b=Hx9CcV2E5qWBxymC+6zlmwKaifv/GZuPTOx0c8C284PR9aryEUY8XNgw2Pwbzu9wsT
 m3CpucMMvdLh6DSkIMxB6HsJyopSqalNlAyQyH6CIwIzp5ZJHoiD6i9CNe7UnBgo9uu9
 OZnZ7k9eWHq0vY/oTta9LgWDzcB+Y+uIA42km3+NsWslJb1nRAmcxmmahHHwy4uCasQy
 fuOVK3vvkx8MfPVd/4wZ4WeSZtrbTuDO8lyHAVWJBPMvuUJkWcxgqZo3sdN30JENsa73
 RVIHe0dfCnma1H6KFPtZbBD6CeCNr4XjhatAGVYHBhnQWa6jV9tiUMsduEOmjjdH7TjZ
 tHEA==
X-Gm-Message-State: AOJu0Yx77pf7bc7oBMGzJMcjGYCSg0Tix3mLUIcPBb3S4CW/AQT5Be4n
 TUN1/g/KeZ79fnxp8xE+QBUYk9FNstLDugl1Ed1Fejnme0D7GS3lY4bfL7Pkj58bm25EtswXA5s
 HxmDg+164XIsbShD8ot551SFHtQ==
X-Google-Smtp-Source: AGHT+IGRp4Ay58e/c525IPweLS64hY6oueuf/bUPVoRO9t0gQUZo/6uiyAg0aFku8ru4mqwGp9Z9Es3iwVOgI4/I/08=
X-Received: from nabihestefan.c.googlers.com
 ([fda3:e722:ac3:cc00:20:ed76:c0a8:2737])
 (user=nabihestefan job=sendgmr) by 2002:a05:6902:114b:b0:dff:3a30:472b with
 SMTP id 3f1490d57ef6-e02be18d4c7mr149028276.5.1718731485390; Tue, 18 Jun 2024
 10:24:45 -0700 (PDT)
Date: Tue, 18 Jun 2024 17:24:41 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Message-ID: <20240618172442.3449262-1-nabihestefan@google.com>
Subject: [PATCH] hw/net: Fix Coverity Issue for nocm-gmac
From: Nabih Estefan <nabihestefan@google.com>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, kfting@nuvoton.com, wuhaotsh@google.com, 
 jasowang@redhat.org, nabihestefan@google.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b4a;
 envelope-from=33cJxZgwKCmQPCDKJGUVGHCPIQQING.EQOSGOW-FGXGNPQPIPW.QTI@flex--nabihestefan.bounces.google.com;
 helo=mail-yb1-xb4a.google.com
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


