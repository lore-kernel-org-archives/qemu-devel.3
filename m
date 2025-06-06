Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDE12C5AD49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 12:39:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNWIM-0002fY-GQ; Fri, 06 Jun 2025 08:35:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uNWIK-0002fP-LG
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 08:35:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uNWIF-0005ts-D7
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 08:35:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749213330;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VTevlSH5ZQkYyW+Mm1Gr4K/vGmq39vmXxviFGBBggFI=;
 b=O9MtPa5nQx8ru04Wen5ySHpWFuSKvID6F68dCfRkOhq9SX6Jg6W/L7c3tvlSd5z+fXNPXp
 GGjNUYC5bJbMB/LpNV8G1M/x25J6yODJy8ezCFISYXW1QJ1A5qfN3WEM4Uaahb4FLGjfrL
 vytD6bPP5h9+JVRq+8XNjd8waAuzBHQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-DnMmQxMhMOy0LPTU0IeLTg-1; Fri, 06 Jun 2025 08:35:28 -0400
X-MC-Unique: DnMmQxMhMOy0LPTU0IeLTg-1
X-Mimecast-MFC-AGG-ID: DnMmQxMhMOy0LPTU0IeLTg_1749213328
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a4f6ba526eso1303337f8f.1
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 05:35:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749213327; x=1749818127;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VTevlSH5ZQkYyW+Mm1Gr4K/vGmq39vmXxviFGBBggFI=;
 b=TnsZTItSsq3zUDWvYwhHyMcYpjFHNGyzvpg8cO6aB6D616N/+wmkUqXPGIS3spzGKu
 ZMPYhBKIseTyJ+y0YXIFKBQ9kyOfBSuVBDCimTAAwghmJLcp7CoJf9ILi3QOefUa5dS3
 C50+Gin967oQNdRRzmmp1UT78c+2F0J+XKzaqiVKHAS2GuaiwcCWrgl1s7i0nx/Xx3fS
 Xd3Em17MBcnMdyUi9WghWeqJUEF7jABQkjaeKn+PVWIm8sR3kew8KWESa540xUAW1drs
 2kArG2trJ0CPUjvjcl4MSSHohKDH7RT+IUC9v3NZeIhMJrIKgtDXlDuXRR6cACgonlun
 HvPQ==
X-Gm-Message-State: AOJu0YztmtJX8K5UX9tcbUQTRqYI273Xh5V8OpHlII5wmn283Rq0HTQ7
 1U8XGEw2T4h2GD4SqczGQ/PZ1F+g49pJFU2h0b471wzqv1z6U0RhF+9ZUm905syjSrSNXK+7A4C
 5YLOd1zOOllwFeudwo6ahPAv71882i2pzEB4OKt1ne5MgzsQnXGYT/cevoc2TGY3bnuRNxBlhk1
 wAViGyI/vAfFJ+0M/7WeJalwfxZDERIX70voPbG/b0
X-Gm-Gg: ASbGnct3Q3PXL9ZIWxkY+b/kExBN++MLCrhkQxeXnKk1W84/DkXHAVo8kvjo+8zi3Fe
 9azqKYsdfwbSx118i8A2xJxUMm8lubZNn+M3cOITInWhUxECVzFDGZPi2uwkpZDUk2FVBw8/rNn
 KTMTqYg3OIcV4Rv3Z8lmEhR8dkWki/NsKEks9oxAzke8rvK8IQQhc5l8n7odo8LuYcUIZ99g49Z
 GGoNt1wLG5dRF69jR3zd2461LpmHCCrFzX81G+o7kN3zW6hlwJlEz3a+3XEnEb8VQITdchISSDr
 eQLXBjQaLmoh146PoWtvoEBI
X-Received: by 2002:a05:6000:4023:b0:3a4:e68e:d33c with SMTP id
 ffacd0b85a97d-3a531ab7294mr2418441f8f.47.1749213326878; 
 Fri, 06 Jun 2025 05:35:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4Nmb6MbuJ1qQAYvKQeeFwk77+mCZ0SepLBIOade+yQ7Qh4UOnPk/sxr5aMOW5RbUOfuaOGQ==
X-Received: by 2002:a05:6000:4023:b0:3a4:e68e:d33c with SMTP id
 ffacd0b85a97d-3a531ab7294mr2418424f8f.47.1749213326456; 
 Fri, 06 Jun 2025 05:35:26 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4526e158428sm19837585e9.14.2025.06.06.05.35.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 05:35:24 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 11/31] hpet: return errors from realize if properties are
 incorrect
Date: Fri,  6 Jun 2025 14:34:25 +0200
Message-ID: <20250606123447.538131-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250606123447.538131-1-pbonzini@redhat.com>
References: <20250606123447.538131-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


