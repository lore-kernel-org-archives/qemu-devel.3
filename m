Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F8FC54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 14:58:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ribe6-0003L7-4u; Fri, 08 Mar 2024 09:56:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ribe0-0003EA-0W
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 09:56:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ribdt-0005RW-VM
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 09:56:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709909770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=is4uaTsB7JqW33WeDjUhKzI7gp3GUbX8PHe/5xTz5cQ=;
 b=D1eoI+1qGf0d6wy7rzMdKqouQO2O9765Z9zGOLwUanDeUe03gdLnkvxwBP3ot9jQllMDxZ
 RMouJuG0rNRHToCGMSAR+JG5zngJdzpgv7h4fZDRjQ/heCe+J8Sfj3o0/oQjgoJb2afqgr
 j/AmzxqSIweypuUG5Wz6tNDnpbDd/Lo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-MGS263DXPy2aF-Xw_7lUFw-1; Fri, 08 Mar 2024 09:56:09 -0500
X-MC-Unique: MGS263DXPy2aF-Xw_7lUFw-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5681b29771fso1443007a12.1
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 06:56:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709909767; x=1710514567;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=is4uaTsB7JqW33WeDjUhKzI7gp3GUbX8PHe/5xTz5cQ=;
 b=f3pPL3Kk1PDEOd1GXjKShW9ARbGPfae85CxOXhhGtc2lvAzIAWP2ZrwpCF4J5dhNEh
 lYHCPg4W9ec/JEA6Q/gnMMFznh3lvr8oNPJxEoDUoCaaEJlci4vFiFY9m8KAvSU9h9n0
 5WHjMY2PKmTTvkcLOqm0m5x9CcWR7+W98f0ISzM/w4lwPJD/QBWxOYrBWO3HSard+YIW
 PfsL8cYkWjHhS6FCEUhM/Z0EPypSed3zFUGltRBbl716BzBEnCaCxLDWNCijbZANRd3S
 KqfFY2+oJpzh/CYgsyXgsH7hw4QJPT7aL7ygzoNqcGaDhIvp2Ve4s3Ef00SuOP1gKz9m
 luDg==
X-Gm-Message-State: AOJu0YxsTv8KirPBkXpNno6xyGDI7KG0axCVe5M2goSjT4e3RmmavUX6
 Ik46Gyuc/i1ptvzHpquXHg/qE5T7Bl7p4GNlZG3QcCXWVt8MQ9bXQ6NRGlKoh+xFh6/BdXi4cjL
 FGa8aaWbctSSavHTcz1rfet339fR7eCoU4aeNVN3R4BBcUs2lBc3EeB2/chjNodUBMrYm/UJ82+
 cvbrmQ5RG1EqxaRCABUW8y4a17CRq3V8HhBrh1
X-Received: by 2002:a50:858b:0:b0:568:2578:f520 with SMTP id
 a11-20020a50858b000000b005682578f520mr2276013edh.35.1709909766920; 
 Fri, 08 Mar 2024 06:56:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFxsfg4VgWuq0PlNF60MMntpa9IZmm3+ApzWnuA/xEI7440fFKuWoIrRRy6bY7ODPaCDeZONw==
X-Received: by 2002:a50:858b:0:b0:568:2578:f520 with SMTP id
 a11-20020a50858b000000b005682578f520mr2275998edh.35.1709909766570; 
 Fri, 08 Mar 2024 06:56:06 -0800 (PST)
Received: from [192.168.10.118] ([151.49.77.21])
 by smtp.gmail.com with ESMTPSA id
 i23-20020a0564020f1700b00567f780d4a2sm2686623eda.78.2024.03.08.06.56.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 06:56:04 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PULL 05/12] hw/intc/apic: fix memory leak
Date: Fri,  8 Mar 2024 15:55:47 +0100
Message-ID: <20240308145554.599614-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240308145554.599614-1-pbonzini@redhat.com>
References: <20240308145554.599614-1-pbonzini@redhat.com>
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


