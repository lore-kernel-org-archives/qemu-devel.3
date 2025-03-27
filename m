Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16A9EC3600B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 10:32:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txkW2-0000q4-3U; Thu, 27 Mar 2025 06:31:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hz1624917200@gmail.com>)
 id 1txkW0-0000o0-4t
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 06:31:12 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hz1624917200@gmail.com>)
 id 1txkVy-0006yZ-2H
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 06:31:11 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2239c066347so18894475ad.2
 for <qemu-devel@nongnu.org>; Thu, 27 Mar 2025 03:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743071467; x=1743676267; darn=nongnu.org;
 h=content-transfer-encoding:subject:from:cc:to:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=zjHt9d4qa8QPI32fJvHRRZlzx1fV91NMAG/BFfy8U5c=;
 b=LhcEmawFx7yEsV2ZbS+DzM17D7vW2vkHD2faZaQRkZb3HNuQsDVd5FUtq5TewULX/l
 k0SBuCdLTP4T89yHTmCDySycT7GabF/fE4zLjHz2NqA0b+rwhHIw0sZaPbGIwoe0RCHS
 aGnfoY7fXqGmyHb5PFfcVf7QhnsWgowFORJ0qnaNKelaVPfgOgtTGq0z9eggQ/nesEhf
 VioCBaqpHt+fhL6VPiszwU8fQL8ZFmeK5Cf5DPqnRw9QKM5dvk+heHJ4Z+n7HZattP85
 nArRXNNX86iBnAm+ktbkPn2GbisgafvptJJnpEekCGcoSoyiBZDZPrXi7mf/kaEy0712
 XPhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743071467; x=1743676267;
 h=content-transfer-encoding:subject:from:cc:to:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=zjHt9d4qa8QPI32fJvHRRZlzx1fV91NMAG/BFfy8U5c=;
 b=w8A5I+wN+qjnHZMLf8VB9DXvYt5E/kM7vw1O3UZ2cunGCROoFKy5Tl3eHchr6ygXi1
 qeV3JS1gTl0j7qXFvfo7rO1isDOqSPggsqApXQFOkFkk7cdYA5mFTCw/rcD4RbPMRs6e
 Qk4KITjJ+JJFjuiUMfLoxaRR5RtgarQb/d4BdY/PTOUsQg/s50ySsmCn7FNkLQYmx9/a
 LPiRXQaXf9j7Ka0f+4iy+dPwBO0UNB6yWaBYNTqJy3kGGjHJGIafibXC2MQrJtxoh1cW
 zfvMtC2DLRJz32Pn0qTIRRciJPEUZOeFJSPEwhFWTyVD1oags4yuWIvMQWgADU++MLZP
 ZJQw==
X-Gm-Message-State: AOJu0YzEqth2MZlx+RpMoVJnj5ZfNIEW8UBCfwgLFIr4gyTrbQEtOZCC
 jEVe4KqPa6BAlhoTaWl1ascVgmMrtGf9z51d1viLd7ke0b/S2P1lDvZUhw==
X-Gm-Gg: ASbGnctSXJzEwXVe7sig4/jct+74iPGSo/QIQ7aVoCCMCKupmW6ioI8RIz/6jQ25I8V
 x1ykukj88A7QADH6SbRHc8w7vc/KUWzWgqrUyV41XCKTYcsk4ch6UaUJNblhYxcs1a48roAsxJA
 I325/sHK5tcnkX44k50h886s0D31Qfuk9MZibd92BvX3xzHTvnH39rK4FKdxaqTTRUfYi9as2AR
 REukNzJE4mpzGomMvMmF7r6A+S53/rbbl5AHqQVuBNF2QL3wHilbeb4Aqu3lqWmAhN4JBpKEAxm
 i/33If5CYDlvmLPC58/dpuUbR5Eh7dl6mpB9ibQbcG+iYqjt4fss1sp/riyrcyOZ
X-Google-Smtp-Source: AGHT+IHsK10LCGcZs2HJLF8OQ3BdaBr/lT7CqI0IpO947gEy1OrQuzn4REte91yh/oVzt66x4ILsew==
X-Received: by 2002:a05:6a00:1823:b0:736:5438:ccc with SMTP id
 d2e1a72fcca58-73960e32694mr3645996b3a.9.1743071466435; 
 Thu, 27 Mar 2025 03:31:06 -0700 (PDT)
Received: from [192.168.31.221] ([124.64.23.229])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739060089fasm13934749b3a.75.2025.03.27.03.31.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Mar 2025 03:31:06 -0700 (PDT)
Message-ID: <697cedd2-e480-4988-aace-49a8e4fa9c89@gmail.com>
Date: Thu, 27 Mar 2025 18:31:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: qemu-devel@nongnu.org
Cc: mst@redhat.com
From: Zheng Huang <hz1624917200@gmail.com>
Subject: [PATCH] hw/timer/hpet: fix memory leak in hpet_del_timer()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=hz1624917200@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Hi,
This patch addresses a memory leak bug in the function `hpet_del_timer()`.
The issue arisesfrom the incorrect use of the ambiguous timer API 
`timer_del()`, which does not free the timer object. The leak sanitizer
report this issue during fuzzing. The correct API, `timer_free()`, was 
introduced 4 years ago, but the usage in isue dates back 12 years, which
led to this problem. 

Also I'd like to ask for a way to fix all 100+ wrong usages. In my
opinion, the best way to fix this is to hide to `timer_del()` API and
eliminate all usages of it.

Signed-off-by: Zheng Huang <hz1624917200@outlook.com>

---
 hw/timer/hpet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index dcff18a987..0162f4cc32 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -428,7 +428,7 @@ static void hpet_set_timer(HPETTimer *t)
 static void hpet_del_timer(HPETTimer *t)
 {
     HPETState *s = t->state;
-    timer_del(t->qemu_timer);
+    timer_free(t->qemu_timer);
 
     if (s->isr & (1 << t->tn)) {
         /* For level-triggered interrupt, this leaves ISR set but lowers irq.  */
-- 
2.34.1

