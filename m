Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 736C0C61CE8
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 10:20:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN7eI-0007YL-Bm; Thu, 05 Jun 2025 06:16:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uN7dz-0007SA-CN
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 06:16:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uN7dx-0001LW-Rx
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 06:16:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749118577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VTevlSH5ZQkYyW+Mm1Gr4K/vGmq39vmXxviFGBBggFI=;
 b=Gh69lGaM/3Zfv0nIA7rEixZi6ycjddQIkeAxvY2BtsI50HXrS/I/byYloMWLXZLiOM1T6O
 hRpvPsuLMSJlgPUalGlb/AIP+X2q7NHmPeuqfbb+bemgtXB7B1yvS4yn5PPH7EPVjcjUCf
 0ZbhPyOogWA6qaz9viGdthvVvLlqpXc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-ZL1OpXgLOf-pOOOxulkkrQ-1; Thu, 05 Jun 2025 06:16:16 -0400
X-MC-Unique: ZL1OpXgLOf-pOOOxulkkrQ-1
X-Mimecast-MFC-AGG-ID: ZL1OpXgLOf-pOOOxulkkrQ_1749118575
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a4e6d426b1so971541f8f.1
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 03:16:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749118574; x=1749723374;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VTevlSH5ZQkYyW+Mm1Gr4K/vGmq39vmXxviFGBBggFI=;
 b=BIi2aMW8zbrurnCPibZCD7ypxnkpXSHYc5Ue+hSrY+sLGH0GpzIupAHaFNitwzZe3A
 5HlHIzlFw2hXFpJpMzEj0HJQIjFJUdwMImcIddgcDfQNyjAPaCQ/RYTwAhLAiKLqo2UR
 2V89jzBVabWN16Pa+jnLWsEj7Nu/nFhjEnUKzKUBhyJlTkHXK7S8+GzC+cb8qaWuw0BW
 e8aWqXdb9CGayzsf7P190eU3uwRIqKF31Cq5WGunrNwHBd5HFLO1BtvLDmSHg1LrPdcm
 5aVQSHsb90mM8r8KEKpYMLvw+6LL+plPa/SKZNkJg8QSwInxSJ8b+4WfXaAhNqAy5GUM
 WHdQ==
X-Gm-Message-State: AOJu0Yx0OZGfbRb/ld/XLGFE8mmy0nQp+XiO8l73OcMIcn/5R6Ek2gOQ
 TkybcugaFThjNgFyOf12BkQuiddzSNqQO9h3xgA5+MToaZm6GGBCTOAxSElGGzUQDej9LcupTaF
 t/dqLDRWVEfCMlCoq5u7dBOR+PH7i4OrGnwDRHoxmXbOjahoMwTb4kGNalpklhB7V5b3lkdqiKG
 I/kPIsSHJwW2BiJDylSnYhpB4wg6UKJ/CCA2tfCuUv
X-Gm-Gg: ASbGncvUN6bh/zJfQz2vkk8tepsbim6QvRdAqsh5cDxXpvYEiL655g71ATJE/UVVhlg
 Q88oT8+Rs9CnqKM77O1M/EoyOHVtZdBegQLgEuc7KYYK8TvSoJ9IYgwIQGMUMvfxGYI81JK2812
 EonfB2ja1ao0Bf1WES1uhlAfo6/Ae2i8NCSujugnhhgI1lzGQEHepI7O3ZK5jczkI+oE9OO7Nbd
 ExdvkjbvKmzYU6UKujK+WtVX7UzBhuYeYsDeMbLxpikbjuT63uNmQbYaX+/txAdfFr6k/YYlbZm
 GGggKhtx7PwnElJ68woo0+lt
X-Received: by 2002:adf:a29e:0:b0:3a5:271e:c684 with SMTP id
 ffacd0b85a97d-3a5271ec74dmr1773816f8f.24.1749118574257; 
 Thu, 05 Jun 2025 03:16:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOh3cD0KZpsvpGZ/pQsCY6Fp/N6aQKKYgtvbN/uCdquTaBlIjQGa0RQBH0Zpn6p42Bc82C5w==
X-Received: by 2002:adf:a29e:0:b0:3a5:271e:c684 with SMTP id
 ffacd0b85a97d-3a5271ec74dmr1773799f8f.24.1749118573862; 
 Thu, 05 Jun 2025 03:16:13 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-451f828715esm17540095e9.0.2025.06.05.03.16.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 03:16:12 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com,
	zhao1.liu@intel.com,
	qemu-rust@nongnu.org
Subject: [PATCH 11/14] hpet: return errors from realize if properties are
 incorrect
Date: Thu,  5 Jun 2025 12:15:40 +0200
Message-ID: <20250605101544.368953-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250605101544.368953-1-pbonzini@redhat.com>
References: <20250605101544.368953-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Do not silently adjust num_timers, and fail if intcap is 0.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/timer/hpet.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index 9db027cf76f..cb48cc151f1 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -691,8 +691,14 @@ static void hpet_realize(DeviceState *dev, Error **errp)
     int i;
     HPETTimer *timer;
 
+    if (s->num_timers < HPET_MIN_TIMERS || s->num_timers > HPET_MAX_TIMERS) {
+        error_setg(errp, "hpet.num_timers must be between %d and %d",
+                   HPET_MIN_TIMERS, HPET_MAX_TIMERS);
+        return;
+    }
     if (!s->intcap) {
-        warn_report("Hpet's intcap not initialized");
+        error_setg(errp, "hpet.hpet-intcap not initialized");
+        return;
     }
     if (hpet_fw_cfg.count == UINT8_MAX) {
         /* first instance */
@@ -700,7 +706,7 @@ static void hpet_realize(DeviceState *dev, Error **errp)
     }
 
     if (hpet_fw_cfg.count == 8) {
-        error_setg(errp, "Only 8 instances of HPET is allowed");
+        error_setg(errp, "Only 8 instances of HPET are allowed");
         return;
     }
 
@@ -710,11 +716,6 @@ static void hpet_realize(DeviceState *dev, Error **errp)
         sysbus_init_irq(sbd, &s->irqs[i]);
     }
 
-    if (s->num_timers < HPET_MIN_TIMERS) {
-        s->num_timers = HPET_MIN_TIMERS;
-    } else if (s->num_timers > HPET_MAX_TIMERS) {
-        s->num_timers = HPET_MAX_TIMERS;
-    }
     for (i = 0; i < HPET_MAX_TIMERS; i++) {
         timer = &s->timer[i];
         timer->qemu_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, hpet_timer, timer);
-- 
2.49.0


