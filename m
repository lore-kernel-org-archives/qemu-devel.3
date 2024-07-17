Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 346FCC3DA4B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 05:05:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTwpl-0001aT-8A; Wed, 17 Jul 2024 01:04:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sTwpe-00018C-61
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 01:04:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sTwpc-0001za-IZ
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 01:04:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721192639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aPrZh1EXv7kaFvhhCibNvYsmIuHRfgJwPxgiKZ4HtGI=;
 b=QdhLYf3BsTX8oN40LPCLZXlYgrajJz7yyKq9NOKztPy2eJZA9hSLnmW0IMMdlVRkyL9C3G
 cu5WKFtZ7bb8HU2w6xTbOlXgvzggjExx6F0V7TAPZm9uF872fNavKijTut8UUe54DwPgCX
 LF6mCB8W2uyfMw/uffUwEkrzCxUvgOw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-UUp-bLDJMx-2aD_3J_BOTQ-1; Wed, 17 Jul 2024 01:03:57 -0400
X-MC-Unique: UUp-bLDJMx-2aD_3J_BOTQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-367987e6ebcso4587321f8f.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 22:03:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721192635; x=1721797435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aPrZh1EXv7kaFvhhCibNvYsmIuHRfgJwPxgiKZ4HtGI=;
 b=gdHJX5Uf3QSGTPUDTTc2BqWzrblQH4p39DgVTo0R8s9y64FpE25GCPnSTpzeCgjFRw
 muD/ZQhj/o7D5tR1PWi9Vjb+qZv3c9/Uu9jmpYAxALGB74dp9IW84Od6JX8PBh/SAtfv
 wy5beZFc78i4G8R47NDQirr0vR4Jxt7EtYKR4xOOBG8VvkQNPPVty/HhBwITq4D4nw4g
 x8cXmdsPhSHgsVfwxwIKoDkapyTLk6XlHnSiF6D+X3sUuX/IvkL3xRSor5kQ0phgoEY2
 vpeUSE8CPF5vSlYuKU2MAfeXDKtxyatAKYSIxuOpqc6YxJy7blB/ZTh2L6UwifKbn6+i
 ajGw==
X-Gm-Message-State: AOJu0YymQfWhY8Fituui4HxHAtd3dShAWQ1EStHawQY+Tt+3KDez50ys
 tgnh2E4RYXH5RE3xx/j7qqESWeoAo/ivRNGLB2eJP9Tjj2GPCEmI5nu50+GOhGuBy+47Q9Glv7W
 VgBPLFMIe9+13/FNJp1abAgAV07aunrH/Z7FIkm0K1OYQrpSGH+iSmmq3vpo4gHg9LjDLXB9Nd/
 fqPjlXO0gIzFbu9usmN83/TuCLAYRz/X7hqGfn
X-Received: by 2002:a05:6000:1fa6:b0:368:38af:9a2e with SMTP id
 ffacd0b85a97d-36838af9ceemr2342f8f.21.1721192635670; 
 Tue, 16 Jul 2024 22:03:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELBO43EGmalceKyhDuved+qHLFLgyogTGar+IdSl0yXUQv8ul3MlkHmVKkw7Ql2Ew5KYw0Xw==
X-Received: by 2002:a05:6000:1fa6:b0:368:38af:9a2e with SMTP id
 ffacd0b85a97d-36838af9ceemr2331f8f.21.1721192635299; 
 Tue, 16 Jul 2024 22:03:55 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680daccc86sm10682437f8f.61.2024.07.16.22.03.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 22:03:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 09/20] hpet: fix clamping of period
Date: Wed, 17 Jul 2024 07:03:19 +0200
Message-ID: <20240717050331.295371-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240717050331.295371-1-pbonzini@redhat.com>
References: <20240717050331.295371-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

When writing a new period, the clamping should use a maximum value
rather tyhan a bit mask.  Also, when writing the high bits new_val
is shifted right by 32, so the maximum allowed period should also
be shifted right.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/timer/hpet.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index 01efe4885db..ad881448bf3 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -548,7 +548,9 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
                  * FIXME: Clamp period to reasonable min value?
                  * Clamp period to reasonable max value
                  */
-                new_val &= (timer->config & HPET_TN_32BIT ? ~0u : ~0ull) >> 1;
+                if (timer->config & HPET_TN_32BIT) {
+                    new_val = MIN(new_val, ~0u >> 1);
+                }
                 timer->period =
                     (timer->period & 0xffffffff00000000ULL) | new_val;
             }
@@ -567,7 +569,7 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
                  * FIXME: Clamp period to reasonable min value?
                  * Clamp period to reasonable max value
                  */
-                new_val &= (timer->config & HPET_TN_32BIT ? ~0u : ~0ull) >> 1;
+                new_val = MIN(new_val, ~0u >> 1);
                 timer->period =
                     (timer->period & 0xffffffffULL) | new_val << 32;
                 }
-- 
2.45.2


