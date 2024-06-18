Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39ED3C41513
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 17:24:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJcYs-0005hb-OO; Tue, 18 Jun 2024 13:24:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3rcJxZgwKCjQdQRYXUijUVQdWeeWbU.SecgUck-TUlUbdedWdk.ehW@flex--nabihestefan.bounces.google.com>)
 id 1sJcYq-0005h1-Uz
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 13:24:00 -0400
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3rcJxZgwKCjQdQRYXUijUVQdWeeWbU.SecgUck-TUlUbdedWdk.ehW@flex--nabihestefan.bounces.google.com>)
 id 1sJcYp-0003e9-BG
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 13:24:00 -0400
Received: by mail-yb1-xb4a.google.com with SMTP id
 3f1490d57ef6-dfeff072f65so9665201276.3
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 10:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1718731437; x=1719336237; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=mIz+uBMleWspMGOXrthG2m3FtkYnjCAe7akkH5AGnWM=;
 b=x2zDHnilQj07o/AAtGTF5aqnl2AJOT6FWZnKTwX/YXJVx8GEm4516V6uKfujBSBGfL
 foAMbnw0IH5qbm6iBrELOyX9kNlnKeods3uN9vwlk/Yb1IFtJK9YEzrh5FDL2ilzryFx
 8JJ3lTEFQN4dgD+0NJf4b64vf8vV2h/pUqQJt+LctKOZfkjSuUTpyuzbMJv/2Jl04rMv
 y2UDdIMuWojnD/bDw0qYIjZ4LSiqT35d5/ingH9FHhdVI6b1uABBd83oE4e3A+3iBwH8
 mL66bz+i1VXiXl3hX16zmOyQG++eDrum4L5EHiFMZxuno+r5MfNIE9bEXTzHM8viNzhR
 MiKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718731437; x=1719336237;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mIz+uBMleWspMGOXrthG2m3FtkYnjCAe7akkH5AGnWM=;
 b=AG02MFDx7SV0osKSdRc2/6CFQNuN5kKkfGYHqKfDrH+UEp8JGeJjGHYZRV5ThynL57
 Ylw+LQ615X7WJ3slVfYgNPr7w3aNfSmstO10rmtRP3oAP2Iim6CtaDusJfw/fGH4XcOz
 FZhtgXtfUnvmGIsD5L2i7zHLBIpgE/OPcmNAuEiL0EWJnGRo1mEqeJxYxdJCoIUBtYdf
 L4Uxcq3kArPv4UTyUi0mX3jyemKAs9INkIR3Okv62JaVs5EmP32BYsiuG3IYK79bifLs
 AaEycmy+gSQ8j85nfpABP7fJUe/l18vIPbAMFUE4keLvMQMtkb87BtaetLEFm0zu79Dk
 i2qA==
X-Gm-Message-State: AOJu0YyUDO9wOVsuUhMiA+R7jGUB6ndzQtnyLTHuI4wmjvTuPkTTXqg5
 x+oPgOOlxS4pWbbngfBbw6URioK2gAL5c/N8ddMgJrJpWM9lKwkGoNMXSSE2iI3ud5Rr2SPR0Ov
 siDW9eiIWilzTUIiioR5s+OQQpA==
X-Google-Smtp-Source: AGHT+IEQiOggCm23YdIlilTZI7HkDqJe9gOvFBnRSRF+k9wFA/yuWZKuoCmISCH00m/Hixpf9dJLqZ+oHdYXwo87ZP8=
X-Received: from nabihestefan.c.googlers.com
 ([fda3:e722:ac3:cc00:20:ed76:c0a8:2737])
 (user=nabihestefan job=sendgmr) by 2002:a05:6902:18c8:b0:df4:8ecb:ae57 with
 SMTP id 3f1490d57ef6-e02be1dc849mr96548276.10.1718731437433; Tue, 18 Jun 2024
 10:23:57 -0700 (PDT)
Date: Tue, 18 Jun 2024 17:23:44 +0000
In-Reply-To: <20240618172344.3448375-1-nabihestefan@google.com>
Mime-Version: 1.0
References: <20240618172344.3448375-1-nabihestefan@google.com>
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Message-ID: <20240618172344.3448375-2-nabihestefan@google.com>
Subject: [PATCH] hw/net: Fix Coverity Issue for npcm-gmac
From: Nabih Estefan <nabihestefan@google.com>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, kfting@nuvoton.org, wuhaotsh@google.com, 
 jasowang@redhat.org, nabihestefan@google.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b4a;
 envelope-from=3rcJxZgwKCjQdQRYXUijUVQdWeeWbU.SecgUck-TUlUbdedWdk.ehW@flex--nabihestefan.bounces.google.com;
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


