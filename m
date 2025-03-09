Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24EF3C282D1
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 10:33:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trDxN-0000Yx-Bk; Sun, 09 Mar 2025 06:32:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1trDxD-0000FV-KB
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 06:32:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1trDxB-00046B-Vn
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 06:32:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741516337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=04PJRmuUiucourfgT/J1T0+xS+Kfg0driBOXjjm6/8k=;
 b=BWelvljqiE9D3vhlod2js8v/a3OokgjKOY3rbvMpwPJjCk4T/yZEE9axHibkQJ2M2wxFDx
 XbDU08d/2zEucEwSLWYQ8fd0RH4NJezFquWc6l8yJfQII23hwgSmicFU2BgVGXqsaTFInP
 p3J3ZXOw6XFp2SaPq3L5mfXcCLozD/A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-eU8B3-oANgWy4P1-lqIYUg-1; Sun, 09 Mar 2025 06:32:16 -0400
X-MC-Unique: eU8B3-oANgWy4P1-lqIYUg-1
X-Mimecast-MFC-AGG-ID: eU8B3-oANgWy4P1-lqIYUg_1741516335
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43cf6c03535so373155e9.0
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 03:32:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741516334; x=1742121134;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=04PJRmuUiucourfgT/J1T0+xS+Kfg0driBOXjjm6/8k=;
 b=faId3iJ5Tiw7USSCs99JUB1wPkTFTmMpHWA1PbIeRMPl1m3IreoLGu6uYkysmlBAz1
 X+VkE2nbW/IAOabxXcuR8vRmOgEAAldlgne95sfsk5JXrkpMm2FwJ85r3yKOiMc9CBJk
 3aQk625iGdj/Ttx1IBmh4zvesYxiwI4O096htUSCEkDyw6AOqK3XWhWP3CvLWBVeswy4
 /jiEsZcOL6K454BzZhOUbDCo88SAMT+r20mFIQ8EIvIixeF5pH6AvwG5IedJDTS6SsqC
 reauUiWZf91h2Hjf5r0eDfGbFlJzP3M3B4T+DI9v5GyQq8sgU1OrHvqWG6beCdRVcclb
 Q2bw==
X-Gm-Message-State: AOJu0YxzPqodbSzChPhy08w0nCX1o1oi+hpSloKU37ApzWYZdLBEpTon
 5eLTyiw4YFEaLIDsu0M5n+cMtYyOrRenmbGKoVzGUBbjZMMvewBapY3P2cpUgfwDBYJZKaH43VX
 nmLjfRmsTzuYEGKpeYGLtFMoP/p0tJgQpGpoJoNuc7a0dm7zDsf2xJrSYxOKI0RTu/+7oGpLFBG
 jcV5qGP1oX8LZDGoWKZmYVnQs51kJCLVY+FJp8HyA=
X-Gm-Gg: ASbGncuBDGQaXRf8KvU6HHHVNOwZItAeFTOFZj58m56FZTqeCXvRNDuZFAcVbREJ4x+
 GkBGnlQc9vy3Mc/FAjWRFdqjZz98HnnyJmNlm/Eh2S1a9ox1HziXmDM4uQ7DlsIl1StjUiGwhLu
 ljHJ/ClmHa7ZJIa0KeT1l+Qk2WgK3NqMvMEjnw3+LdSOA8Mhgy1jnnV8vwIrpJDCPBzZPXcw47e
 GTNav4Io+UByPa/KBZpThfxM1Kyd0J/IBjwvqkbXv/0mp9v/cGwDdKrpxm2emEy2UVCnCj5KgVh
 MeKgDwtlcZ/+vC0o5Jqlmw==
X-Received: by 2002:a05:600c:3510:b0:43b:cf12:2ca5 with SMTP id
 5b1f17b1804b1-43c601d9145mr57763075e9.8.1741516334382; 
 Sun, 09 Mar 2025 03:32:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEg58JPD3eO13I8Q7YpVRP4M0Qc8+j/cGJObbGoPvO8WabBqZjwqRAsWCWFheYT/ahYE8QNXQ==
X-Received: by 2002:a05:600c:3510:b0:43b:cf12:2ca5 with SMTP id
 5b1f17b1804b1-43c601d9145mr57762905e9.8.1741516333928; 
 Sun, 09 Mar 2025 03:32:13 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.122.167])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bdd9471b7sm109267005e9.34.2025.03.09.03.32.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Mar 2025 03:32:12 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 25/25] rust: pl011: Allow NULL chardev argument to
 pl011_create()
Date: Sun,  9 Mar 2025 11:31:19 +0100
Message-ID: <20250309103120.1116448-26-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309103120.1116448-1-pbonzini@redhat.com>
References: <20250309103120.1116448-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Peter Maydell <peter.maydell@linaro.org>

It's valid for the caller to pass a NULL chardev to pl011_create();
this means "don't set the chardev property on the device", which
in turn means "act like there's no chardev". All the chardev
frontend APIs (in C, at least) accept a NULL pointer to mean
"do nothing".

This fixes some failures in 'make check-functional' when Rust support
is enabled.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/r/20250307190051.3274226-1-peter.maydell@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index af93ae8bebe..f137b49feaf 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -648,10 +648,12 @@ pub fn post_load(&self, _version_id: u32) -> Result<(), ()> {
     // SAFETY: The callers promise that they have owned references.
     // They do not gift them to pl011_create, so use `Owned::from`.
     let irq = unsafe { Owned::<IRQState>::from(&*irq) };
-    let chr = unsafe { Owned::<Chardev>::from(&*chr) };
 
     let dev = PL011State::new();
-    dev.prop_set_chr("chardev", &chr);
+    if !chr.is_null() {
+        let chr = unsafe { Owned::<Chardev>::from(&*chr) };
+        dev.prop_set_chr("chardev", &chr);
+    }
     dev.sysbus_realize();
     dev.mmio_map(0, addr);
     dev.connect_irq(0, &irq);
-- 
2.48.1


