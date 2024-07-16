Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C83CC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 09:34:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTeZk-00049a-8b; Tue, 16 Jul 2024 05:34:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sTeZj-00046a-Dv
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 05:34:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sTeZh-0006CD-SD
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 05:34:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721122461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hCKUcMyw6jo+b/MlTxyrqx03yCH+nSKVzYEnqWKmFpk=;
 b=hpVj2/rurVH7GzgoOvUg05U/xeIXDE/8Zj3yn+ghSuzvhDAadCh9e92116Y8qSrscnedPK
 1HW2GsVawkRdrT4ZOSAEybAF330VjcZdclBc5TrkeTJOxVrzaX5BVDQO7taLOsebM1B76Q
 306eD73Oo1JIWQi21jNhUIo8BQqZlkM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-ycaeVn7BM6ut__-EFxaeGg-1; Tue, 16 Jul 2024 05:34:17 -0400
X-MC-Unique: ycaeVn7BM6ut__-EFxaeGg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3679ed08797so3430217f8f.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 02:34:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721122455; x=1721727255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hCKUcMyw6jo+b/MlTxyrqx03yCH+nSKVzYEnqWKmFpk=;
 b=waeYdGp937jEh9+VVA2e77PcBY9sVfYfQqbqGp6wR5LSY0Zu6L0KMUYAm+i7BlyONO
 H3Piqy0x45t2nOF4f1XTqtR5V5axt+HrgOIadvnfcAMtLNPG3x85gNC/TGW0L+/JMrxs
 9dapmc+KiK0tkWsSOfihm4Fu8rn/nKFFBVHKSKS98OC0AoiTUWfLyzfI+jo90niRIDdS
 zRCVHWZyiiAEVMDjNEB/ea3+9jZc/TcwQYdA4AhJuU0LUofkbwylVy0VjezUBE8Uhqj0
 6ytuYPZ0EG2G+ws8Dh95zf/0oVSK7HHgNhG0zgkWifLqKc9BiEVxJdh4YJ9FEnT8OqCZ
 XaTQ==
X-Gm-Message-State: AOJu0Yz6ZUsxzS04BFrX/3ePaCLPswSSosVhnHOGfjTxOAnNQaCj2feA
 3Q2U64P3SNLFSVO1LEi97xd5dQ6YKXlc8zAVSBVsQ/lKATReBx6Z1WK8M5ANqfNNippFrhyUuuw
 YEy0anXDANf8/RfHiBMCPrNF8Z/xvTMgC7bIYYYEKcmCHRajuW0954K2uqULWJF77J6YrQXS/re
 E+GOu6Ismgksykomms14fr6B8CXKzFbCsopgUr
X-Received: by 2002:a5d:6d82:0:b0:367:9792:8bd4 with SMTP id
 ffacd0b85a97d-3682631f973mr1064561f8f.43.1721122455227; 
 Tue, 16 Jul 2024 02:34:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBKjMhcM0PCLywvkXh0re17X/AbyGcUI1MYkn0HQeAbfv7jPex74WymaPQBnOzKqRf/R/DGQ==
X-Received: by 2002:a5d:6d82:0:b0:367:9792:8bd4 with SMTP id
 ffacd0b85a97d-3682631f973mr1064539f8f.43.1721122454660; 
 Tue, 16 Jul 2024 02:34:14 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dab3f13sm8523414f8f.4.2024.07.16.02.34.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 02:34:13 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: taisei1212@outlook.jp
Subject: [PATCH 2/2] hpet: fix HPET_TN_SETVAL for high 32-bits of the
 comparator
Date: Tue, 16 Jul 2024 11:34:07 +0200
Message-ID: <20240716093407.194065-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716093407.194065-1-pbonzini@redhat.com>
References: <20240716093407.194065-1-pbonzini@redhat.com>
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

Commit 3787324101b ("hpet: Fix emulation of HPET_TN_SETVAL (Jan Kiszka)",
2009-04-17) applied the fix only to the low 32-bits of the comparator, but
it should be done for the high bits as well.  Otherwise, the high 32-bits
of the comparator cannot be written and they remain fixed to 0xffffffff.

Co-developed-by: TaiseiIto <taisei1212@outlook.jp>
Signed-off-by: TaiseiIto <taisei1212@outlook.jp>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/timer/hpet.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index 16be1278d09..85fb2c07ae3 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -554,6 +554,10 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
                 timer->period =
                     (timer->period & 0xffffffff00000000ULL) | new_val;
             }
+            /*
+             * FIXME: on a 64-bit write, HPET_TN_SETVAL should apply to the
+             * high bits part as well.
+             */
             timer->config &= ~HPET_TN_SETVAL;
             if (hpet_enabled(s)) {
                 hpet_set_timer(timer);
@@ -564,7 +568,8 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
             if (!timer_is_periodic(timer)
                 || (timer->config & HPET_TN_SETVAL)) {
                 timer->cmp = (timer->cmp & 0xffffffffULL) | new_val << 32;
-            } else {
+            }
+            if (timer_is_periodic(timer)) {
                 /*
                  * FIXME: Clamp period to reasonable min value?
                  * Clamp period to reasonable max value
@@ -572,12 +577,12 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
                 new_val = MIN(new_val, ~0u >> 1);
                 timer->period =
                     (timer->period & 0xffffffffULL) | new_val << 32;
-                }
-                timer->config &= ~HPET_TN_SETVAL;
-                if (hpet_enabled(s)) {
-                    hpet_set_timer(timer);
-                }
-                break;
+            }
+            timer->config &= ~HPET_TN_SETVAL;
+            if (hpet_enabled(s)) {
+                hpet_set_timer(timer);
+            }
+            break;
         case HPET_TN_ROUTE:
             timer->fsb = (timer->fsb & 0xffffffff00000000ULL) | new_val;
             break;
-- 
2.45.2


