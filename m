Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1C97C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 18:13:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riehm-0007A7-HG; Fri, 08 Mar 2024 13:12:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1riehl-00079y-Si
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 13:12:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1riehi-0005o9-2s
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 13:12:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709921541;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=is4uaTsB7JqW33WeDjUhKzI7gp3GUbX8PHe/5xTz5cQ=;
 b=Pi2AYXJr5sRjKU8TsxFtTvjPlHBO1Kt2/r9FM5nyZH/Js8Wvu/ncA6MoYWihq5fxCvl1eF
 /QZwWi4GQOkGjC9BAeBsBH/QSfxv64x4q5VX2sgcX/MT1dh4Y03nKmlGvtWgQL3HM8b98x
 vAfFVrXlBk+uTWb9B6nBZv8WjsbIURo=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-pNafbxupPzqctGn2qtm23A-1; Fri, 08 Mar 2024 13:12:20 -0500
X-MC-Unique: pNafbxupPzqctGn2qtm23A-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a4489805a2dso43607966b.2
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 10:12:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709921538; x=1710526338;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=is4uaTsB7JqW33WeDjUhKzI7gp3GUbX8PHe/5xTz5cQ=;
 b=k/EMQ5Sproozyqum9kuM7NRPYjvpqYFTZoToXjT4ALLx6Eh/9wFR7K/rHOTO+pSqom
 6jH30DtejNewApe77TuiUe1JOpMflgN/Y1cts9wqsLXDgRJk0e1u14zBOJCSJBOYEl1y
 0jg2OhXXXrDJnPFlr7zC/EWrKaVxBrN+tnTDQadRGhgaoYJP/7gNw+XdQ3Uq2kVc8qt+
 tHipxqpjL4XGfY3eYfit4J+XZ0OtDx/zysofUK4x2KiGZgBA3veeJEUKAfII9m1X/a9d
 mWzBicCzDyPDh+K/0y/y15aX6NsGLT04l4HQ9SCt0SJlAMPg/AKyv/IJYa9JdBcsbTex
 oPAQ==
X-Gm-Message-State: AOJu0YwjP0NY2zM5zrv3sL5q5jPZmTLu99udOaFGVmHMpkuyzvapOmbS
 6M9qciiSCGxxKNTmuIyAL1MTKSCYimJJtrPCDaqCgpvqfNe3qfn+8YWW3Ep4lITnV91Iy75iUHs
 svVY/+yS+AVcFXRxkHwtUFOPKLeJewD/G7AUSJqvS2aa6GSFdsyKdiH60FmOW5FAJBynKbLkhK3
 5yNausWHqLd/RPd13ZA7NLgprbnK71Jdp4fmwp
X-Received: by 2002:a17:906:4109:b0:a45:a3e9:debd with SMTP id
 j9-20020a170906410900b00a45a3e9debdmr8126507ejk.59.1709921538571; 
 Fri, 08 Mar 2024 10:12:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEGZIJA4sb4gzAYwgu1CNu5gtYm00yZm1oZIG1uSvRqPlfmJpJUKRZ7JaB/aeI+bBhxQpJwnw==
X-Received: by 2002:a17:906:4109:b0:a45:a3e9:debd with SMTP id
 j9-20020a170906410900b00a45a3e9debdmr8126498ejk.59.1709921538325; 
 Fri, 08 Mar 2024 10:12:18 -0800 (PST)
Received: from [192.168.10.118] ([151.49.77.21])
 by smtp.gmail.com with ESMTPSA id
 j7-20020a170906278700b00a4324ae24dbsm40450ejc.62.2024.03.08.10.12.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 10:12:15 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PULL 5/9] hw/intc/apic: fix memory leak
Date: Fri,  8 Mar 2024 19:11:57 +0100
Message-ID: <20240308181202.617329-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240308181202.617329-1-pbonzini@redhat.com>
References: <20240308181202.617329-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.572,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

deliver_bitmask is allocated on the heap in apic_deliver(), but there
are many paths in the function that return before the corresponding
g_free() is reached.  Fix this by switching to g_autofree and, while at
it, also switch to g_new.  Do the same in apic_deliver_irq() as well
for consistency.

Fixes: b5ee0468e9d ("apic: add support for x2APIC mode", 2024-02-14)
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Bui Quang Minh <minhquangbui99@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/intc/apic.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/intc/apic.c b/hw/intc/apic.c
index 1d887d66b86..4186c57b34c 100644
--- a/hw/intc/apic.c
+++ b/hw/intc/apic.c
@@ -291,14 +291,13 @@ static void apic_deliver_irq(uint32_t dest, uint8_t dest_mode,
                              uint8_t delivery_mode, uint8_t vector_num,
                              uint8_t trigger_mode)
 {
-    uint32_t *deliver_bitmask = g_malloc(max_apic_words * sizeof(uint32_t));
+    g_autofree uint32_t *deliver_bitmask = g_new(uint32_t, max_apic_words);
 
     trace_apic_deliver_irq(dest, dest_mode, delivery_mode, vector_num,
                            trigger_mode);
 
     apic_get_delivery_bitmask(deliver_bitmask, dest, dest_mode);
     apic_bus_deliver(deliver_bitmask, delivery_mode, vector_num, trigger_mode);
-    g_free(deliver_bitmask);
 }
 
 bool is_x2apic_mode(DeviceState *dev)
@@ -662,7 +661,7 @@ static void apic_deliver(DeviceState *dev, uint32_t dest, uint8_t dest_mode,
     APICCommonState *s = APIC(dev);
     APICCommonState *apic_iter;
     uint32_t deliver_bitmask_size = max_apic_words * sizeof(uint32_t);
-    uint32_t *deliver_bitmask = g_malloc(deliver_bitmask_size);
+    g_autofree uint32_t *deliver_bitmask = g_new(uint32_t, max_apic_words);
     uint32_t current_apic_id;
 
     if (is_x2apic_mode(dev)) {
@@ -708,7 +707,6 @@ static void apic_deliver(DeviceState *dev, uint32_t dest, uint8_t dest_mode,
     }
 
     apic_bus_deliver(deliver_bitmask, delivery_mode, vector_num, trigger_mode);
-    g_free(deliver_bitmask);
 }
 
 static bool apic_check_pic(APICCommonState *s)
-- 
2.43.2


