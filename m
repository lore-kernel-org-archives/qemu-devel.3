Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D80FDC27C4F
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2024 16:33:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNxTq-0000Al-3K; Sun, 30 Jun 2024 12:32:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zheyuma97@gmail.com>)
 id 1sNxTp-0000Aa-3Z
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 12:32:45 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zheyuma97@gmail.com>)
 id 1sNxTn-0000ts-G8
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 12:32:44 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-42138eadf64so16397195e9.3
 for <qemu-devel@nongnu.org>; Sun, 30 Jun 2024 09:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719765162; x=1720369962; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EqaaM/Sv9Uo6r3LoZtnPlrYzJjGkg2VlcLUfxeLqSEs=;
 b=mHNPIAQndjZX1m029/EpVxIS0n/XHx1MIWrKYL89oW2YNF3PuUTtjINwM6Cy0h14HC
 uIu3p0m/3aDc3j2F9LbkSIzdf0b8/FscBSW16V3Xl9jJU7hzW2rlBue19Rzje1JLDU5U
 5rCSvDZmdEQibS7uojX0VqNDh+cWn+lrnvsWdv8GdG4tinTcJDmm0vN1vvRgc/2+9btS
 TgQ6hnBCx07kVB70rYPu9xHw+W/FUblu9DUZQk3o8zAywa7B6OpXVuKwSSOmRwXpv9an
 0E6oMSOsnt58aqTSi2vtRWhrgCeMLcYITMJ8UbRk8WtfQ2a6kcaWtEf7fERDQMUAZlRb
 QYUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719765162; x=1720369962;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EqaaM/Sv9Uo6r3LoZtnPlrYzJjGkg2VlcLUfxeLqSEs=;
 b=Nuqc1XEFpBfZqIxYxdhZ9bSqC3z5dUbQFwUNyQHJvvVAUoa3VOzrdS4dUNPWm+r/Fc
 TSRgIHZNS8VhSYxLv8TjRoiUb7yLOiswYPQhSetPPBy6S1zKFq+l7siCR6IH9ojwwop7
 3/kMbZrV/Hfbo9z583uiaq9Vk6hsDH4Lxd46JVkYdHXV8HiSknMKWXpmIfZIV7ZWR0q5
 QDvYw0x4JEnUXXu0qpKYwD545m6HIHe0CxulFcB5L/x6brwOugn8r18GrIsBnhMcx31E
 YLbgNmOb+ihQmbGFRF0wqGAN0AKD6OOg80S73c+W9p+KJgTd3r3Z2UixeITvH4ni2K3n
 STQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWzvsP1oAlqS240QtdVSe7ZNg1zG8y5TwZjqIsaex+gkjOyuypqohj4cCJWqidACasPhvLIbNrTk2iJJ7FDdD0xKtGjUA=
X-Gm-Message-State: AOJu0YwzsrSlF8OLlwi6JWFeVjeMU5XkYCNp7HIYWAnEdj1wDjhiH4wW
 9o5QgUU5t59YA5sIlkSqLv9WBnVyPvamz9uXlqdJG/PhEk4aTKNU0nO8VvM=
X-Google-Smtp-Source: AGHT+IE4OFj4lXj+WhG83c/P1f6mHcKvtBRjbmglS8SwuM8k0pgZsnbkQdkhyXDzX7qv8sYSCuZloQ==
X-Received: by 2002:a05:600c:1d1e:b0:424:a2be:c161 with SMTP id
 5b1f17b1804b1-4257a03a00bmr24025305e9.20.1719765161359; 
 Sun, 30 Jun 2024 09:32:41 -0700 (PDT)
Received: from wing.epfl.ch (dhcp-122-dist-b-021.epfl.ch. [128.178.122.21])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4257dee5f2asm27714015e9.22.2024.06.30.09.32.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Jun 2024 09:32:40 -0700 (PDT)
From: Zheyu Ma <zheyuma97@gmail.com>
To: 
Cc: Zheyu Ma <zheyuma97@gmail.com>,
	qemu-devel@nongnu.org
Subject: [PATCH] hw/usb: Fix memory leak in musb_reset()
Date: Sun, 30 Jun 2024 18:32:25 +0200
Message-Id: <20240630163225.2973081-1-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=zheyuma97@gmail.com; helo=mail-wm1-x32a.google.com
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

The musb_reset function was causing a memory leak by not properly freeing
the memory associated with USBPacket instances before reinitializing them.
This commit addresses the memory leak by adding calls to usb_packet_cleanup
for each USBPacket instance before reinitializing them with usb_packet_init.

Asan log:

=2970623==ERROR: LeakSanitizer: detected memory leaks
Direct leak of 256 byte(s) in 16 object(s) allocated from:
    #0 0x561e20629c3d in malloc llvm/compiler-rt/lib/asan/asan_malloc_linux.cpp:129:3
    #1 0x7fee91885738 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x5e738)
    #2 0x561e21b4d0e1 in usb_packet_init hw/usb/core.c:531:5
    #3 0x561e21c5016b in musb_reset hw/usb/hcd-musb.c:372:9
    #4 0x561e21c502a9 in musb_init hw/usb/hcd-musb.c:385:5
    #5 0x561e21c893ef in tusb6010_realize hw/usb/tusb6010.c:827:15
    #6 0x561e23443355 in device_set_realized hw/core/qdev.c:510:13
    #7 0x561e2346ac1b in property_set_bool qom/object.c:2354:5
    #8 0x561e23463895 in object_property_set qom/object.c:1463:5
    #9 0x561e23477909 in object_property_set_qobject qom/qom-qobject.c:28:10
    #10 0x561e234645ed in object_property_set_bool qom/object.c:1533:15
    #11 0x561e2343c830 in qdev_realize hw/core/qdev.c:291:12
    #12 0x561e2343c874 in qdev_realize_and_unref hw/core/qdev.c:298:11
    #13 0x561e20ad5091 in sysbus_realize_and_unref hw/core/sysbus.c:261:12
    #14 0x561e22553283 in n8x0_usb_setup hw/arm/nseries.c:800:5
    #15 0x561e2254e99b in n8x0_init hw/arm/nseries.c:1356:5
    #16 0x561e22561170 in n810_init hw/arm/nseries.c:1418:5

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
 hw/usb/hcd-musb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/usb/hcd-musb.c b/hw/usb/hcd-musb.c
index 6dca373cb1..0300aeaec6 100644
--- a/hw/usb/hcd-musb.c
+++ b/hw/usb/hcd-musb.c
@@ -368,6 +368,8 @@ void musb_reset(MUSBState *s)
         s->ep[i].maxp[1] = 0x40;
         s->ep[i].musb = s;
         s->ep[i].epnum = i;
+        usb_packet_cleanup(&s->ep[i].packey[0].p);
+        usb_packet_cleanup(&s->ep[i].packey[1].p);
         usb_packet_init(&s->ep[i].packey[0].p);
         usb_packet_init(&s->ep[i].packey[1].p);
     }
-- 
2.34.1


