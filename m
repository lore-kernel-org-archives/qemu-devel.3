Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55479C41513
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 05:07:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTwpy-000213-5k; Wed, 17 Jul 2024 01:04:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sTwpl-0001bX-Da
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 01:04:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sTwph-000203-EG
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 01:04:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721192644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nJbrLLVXpXeNx7wVIlep8y3RawRslaxRsonV5x8RR/g=;
 b=P9swUp7Onu1NqBd3tOUchahvvBVWpFbr31VsJOI1pbrtHVpgtfRhVP70IyNQLLR/6ELlBb
 Zujv6Hxd7naCEZCn6kNRtWP09MTRhqsFmP9iexJgar1oyLBnVluY1+YfMTkb+KgCIVHlCK
 KUlcE+x97MahsS92IPRoQa4MGDaPSeE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-RV15qMSdPlWajIrIVpAPWQ-1; Wed, 17 Jul 2024 01:03:59 -0400
X-MC-Unique: RV15qMSdPlWajIrIVpAPWQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-36832c7023bso130419f8f.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 22:03:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721192637; x=1721797437;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nJbrLLVXpXeNx7wVIlep8y3RawRslaxRsonV5x8RR/g=;
 b=aKD+/Qm7dV4UxUuNuROcf7hJGAfzuqYULW7xaYosqvrW9ieUurYzMOYZ6mimVaUoH5
 rQb1dNldzBZ5VpNaEOQBCZ50BII1oX18yS3MwHq79/KbNs6L/yR5ycdLP++V0+qF5Jrd
 YXBOuje7CEcTf/jwo2rpVkOMdsmQwvCLIm+/3h1vbz0feWnanAbLPtqXSzy2CwUYXuto
 01cD/kySzgBjiuE8QldakRo2qYGXp9IqaU4sB9a7jNcjqpri6UAg9ZMdh7C+Y/imIt1B
 4h5ynmYh5Zu4HOXtphW3VEpPfM74eAjp2rY1fPhVtYpKO1pBiRivwtsAYKN8o+mrIixt
 feTg==
X-Gm-Message-State: AOJu0Yx3nuVEibx06vqo4hVgMNFr6GFgehegOEBvGAwa2FMpPKXDTN5d
 JOIroKVNvvzhXBnRu2J4Mwb5heOF5rbCCOzIIH21UljBQDtyA3QZ7zzTDarpgbQWNmfw42FXAEA
 aDT5OIyZ2JcPlzwXwD0IPX9XsVSFT89Ht5JzNXjGe/5W//Q3GNrrFmnLaTdISxkdxZt0sZf/T2K
 /ZB+qxzFieVHZphGbHsbbt3zJfUd/6fE7KCv55
X-Received: by 2002:adf:ef4a:0:b0:368:12ef:92cf with SMTP id
 ffacd0b85a97d-3683171149cmr675477f8f.48.1721192637149; 
 Tue, 16 Jul 2024 22:03:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOrqoHXNIOgCEmK6hCnrcXIGxKeV0K33RFTLIDL6PngL/fnn8Zg+dEUelp61bnd2U3kl0Lpg==
X-Received: by 2002:adf:ef4a:0:b0:368:12ef:92cf with SMTP id
 ffacd0b85a97d-3683171149cmr675458f8f.48.1721192636873; 
 Tue, 16 Jul 2024 22:03:56 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f2cc229sm191252725e9.38.2024.07.16.22.03.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 22:03:56 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: TaiseiIto <taisei1212@outlook.jp>
Subject: [PULL 10/20] hpet: fix HPET_TN_SETVAL for high 32-bits of the
 comparator
Date: Wed, 17 Jul 2024 07:03:20 +0200
Message-ID: <20240717050331.295371-11-pbonzini@redhat.com>
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
index ad881448bf3..4cb5393c0b5 100644
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


