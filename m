Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECB2FD58B2A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2026 13:02:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w1l6v-0007Tv-GU; Sun, 15 Mar 2026 09:02:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raghavendraaadhya@gmail.com>)
 id 1w1l6t-0007TI-Eu
 for qemu-devel@nongnu.org; Sun, 15 Mar 2026 09:02:23 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raghavendraaadhya@gmail.com>)
 id 1w1l6s-0003c4-4I
 for qemu-devel@nongnu.org; Sun, 15 Mar 2026 09:02:23 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2aaf59c4f7cso17845655ad.1
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2026 06:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773579737; x=1774184537; darn=nongnu.org;
 h=cc:to:subject:date:from:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GNIfAmKm5ApCc+B0mFDnttKVftHd6ynLG4xrxceTwoc=;
 b=PPSFCg5DL6KGPJsbWS2Qm1lGG4gfopzRT6X3lhjbyoavWZJaH9V8gbH0BV4xZwq1ub
 Gzb2T5BVjBzM74V8yG0eREwGkvOz2fDUMXdZa4NP5WgxtKqH27+emlWYY6znBRBXzIRw
 fGpK79aXN4Aqd+mUAFaHLHGOaeWAaZGc64tarRoT1PTMYjFHGmtPOLwtqkeYnRAt9WXz
 zN2U8SxmShhxb5xr0DhqXp865BZ2kAHn98Ehoi8329Eb0l+FN1qz+h8AanXP4iVervNi
 BG8gfcsSSYWHOXfZr26eueY2LHzAomn3HUSAjJL25J6nPCRv7ryhEwT2ZvzRTMqtghsm
 HYNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773579737; x=1774184537;
 h=cc:to:subject:date:from:message-id:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GNIfAmKm5ApCc+B0mFDnttKVftHd6ynLG4xrxceTwoc=;
 b=ks3rP5egltXoHZcqR3LBPu9E76XcPRoDvELk8Jr6hhvhmL74eDIroKPUczF+qWrd9Z
 GZlt4ySUpx4W5JMQhUfA7wbf7YvbJAzM+1zobsdXQTJFW5cYI5ytlEU/ZdQT50fM0un5
 /W7urNKddUloYFtfbQw/JTSJgHsgDAZF4WHEeSzyPrU5N4+/ZNMyotmPz/FqBQ0Hw46h
 wPKZS0Pd38Cr/zbhrpGR9TtNGm+uYU8/Bdq3EcSizW9Mhowk2bFWpnDC/OeDUote4gcu
 tiqLSriJ3oRI56vG2LV4QCIi9hBPmXPXTDEet42quOzVUH8sldcNzL/vChTYL7e43h7I
 U5Pg==
X-Gm-Message-State: AOJu0YzYNukLn+9LQNWdKfIHbIHsUhAZbyoAPMM89ziUaqsL0pomcI1F
 Bh0I/4pSlk4kj4nNdwP/TPoiHvsGR7wUCbhkzopu8nxOS6OKSzhT+pdr
X-Gm-Gg: ATEYQzyrE1z1WcpV6gNxUAodZi7Z5b0vEv5OPic9GarSS9qKwmPmHR1oMGcWs6eAG0G
 iaU3FXLNFci2D5HKXUSXIHWfFtbnHqjoNIy29rjZb8ZZEQTcL5nA45OP3HYeGwZ3BhpwYMn4SrG
 9LtlUVtkQ6es3CIisQqlB/mLy93MT04PP7j5MbNd6tc/11976hD6VhpkIosiUGG7iw9AcVaIe15
 repZ5l3QCBAuX43mHW95llQXhjf+44+z4qH99wognR9TBDgQ8Df0HlTaFjN4wHPD1zOL44zIzIs
 YPzaJUk9TplyIdWvKdq709U/qarbnFa8Ha7K0pvJZ4OWckF5DkqouotaKq1TY/0lR0WfQHhZDNX
 xQcrLHUcuC6h1PZ0IJfKqGXpiTuZevyrsqG2XDtD97axftbNaCzcrN6iIVXiDWXgvFLPggVaLsd
 D2y9+rnTnxx650u3mWLu2CxOtkL24yDBB5qhuBmEwxDgF967pTl1XVbdaZlpmbhhStK6UybXiCi
 THiY8Kfha5UB8pSJYDXuIIhQw==
X-Received: by 2002:a17:903:2ec7:b0:2ae:7f84:79e3 with SMTP id
 d9443c01a7336-2aeca9c64eamr91020695ad.16.1773579736856; 
 Sun, 15 Mar 2026 06:02:16 -0700 (PDT)
Received: from Obsi.localdomain ([49.43.240.32])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aece56c2c4sm97450845ad.2.2026.03.15.06.02.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Mar 2026 06:02:16 -0700 (PDT)
Message-ID: <69b6add8.170a0220.2bbc48.6528@mx.google.com>
From: Aadhya-R <raghavendraaadhya@gmail.com>
X-Google-Original-From: Aadhya-R <aadhyar.cs24@rvce.edu.in>
Date: Sun, 15 Mar 2026 04:28:32 +0000
Subject: [PATCH v3 1/2] disas/sparc: Fix integer overflow in compare_opcodes
To: mark.cave-ayland@ilande.co.uk
Cc: qemu-devel@nongnu.org,
    qemu-trivial@nongnu.org
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=raghavendraaadhya@gmail.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Change '1 << i' to '1ul << i' to prevent undefined behavior when shifting into the sign bit on the 31st iteration. Resolves SVACE static analyzer warning.
---
 disas/sparc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/disas/sparc.c b/disas/sparc.c
index 5689533ce1..40c1164554 100644
--- a/disas/sparc.c
+++ b/disas/sparc.c
@@ -2515,7 +2515,7 @@ compare_opcodes (const void * a, const void * b)
      another, it is important to order the opcodes in the right order.  */
   for (i = 0; i < 32; ++i)
     {
-      unsigned long int x = 1 << i;
+      unsigned long int x = 1ul << i;
       int x0 = (match0 & x) != 0;
       int x1 = (match1 & x) != 0;
 
@@ -2525,7 +2525,7 @@ compare_opcodes (const void * a, const void * b)
 
   for (i = 0; i < 32; ++i)
     {
-      unsigned long int x = 1 << i;
+      unsigned long int x = 1ul << i;
       int x0 = (lose0 & x) != 0;
       int x1 = (lose1 & x) != 0;
 
-- 
2.43.0



