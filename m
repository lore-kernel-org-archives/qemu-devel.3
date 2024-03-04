Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7806BC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 22:42:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhH0W-0005Qa-Hh; Mon, 04 Mar 2024 17:42:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rhH0T-0005QN-Kt
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 17:42:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rhH0Q-0008WS-J1
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 17:41:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709592117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=aebmdz72auw7FdWgPSUo/EZDnyUGWLM7RYqlprxy43U=;
 b=iLTJWsynFyy4VZJ77Lb3sbYd0XzNANtPMHMdHuwFefUPYKIhNV/O5TyONDpdF/VfZJMCH2
 VCqjIpZsOXz/aUiv/8cL2aelHj4O0c9HoD7+IEYBiImrKwUzUBZtbWKBI2+Br8jvgLv7xQ
 OG9bc6Y5/9vmRdJDMgfCP4tGHOPvxiw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-WKBbMBpgPhKaWzvoJ_9lFw-1; Mon, 04 Mar 2024 17:41:56 -0500
X-MC-Unique: WKBbMBpgPhKaWzvoJ_9lFw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-40e53200380so32919455e9.3
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 14:41:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709592095; x=1710196895;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aebmdz72auw7FdWgPSUo/EZDnyUGWLM7RYqlprxy43U=;
 b=mZ5SRvE6J6HezyjDok1aKHTS1dInQNnZMtMvpHctTnYgSIrG/7QqC2W4X3YLpHII+T
 Py5Lsk0yuNS6Ila5SQfsqpKB/LjsJjBaIVv1+PORHSsGRyEcECSF0+sjW6cWw+tMYkIY
 Usxle6gYfKe7lYZmwKNIfSer0u5ciUJLL5et+A7Jw6be0y7G2lj56/25OUPXdHUdKNb6
 XT9kVFdoDUi1uF3fZVy8bEZCwZoTGWgs7bWYazUN034fS5Y4ATA8aNCa6h+0ZsDUW747
 Ya5JmA+eTqoX7vcidedQPT8h6fLda524wEEWKpOEfC5e8WoDvpmGVC72MOWD01TOpIbD
 TLlQ==
X-Gm-Message-State: AOJu0YyONHfFUdhx258gBa4nfJMMtOlop6vkFPS8LAzSZObE2j//bG5z
 qQaJQ0Rd8NfgCfn2PJ0WF43lZ0T8j9w5RihHYW9ZdelN6n/n6bbtJjggVaBDrBPXiZ03egKVKdc
 Ctn/EbrxbWv/fNFrTtrMt5d6DisD8ke62aCDdQEoDJskxEBTIXBxSK0NNWLsntR2HKXR+el9gNt
 dkeSfm+PNqCZO+u6hpMheM+WJtUqygWA6BUN03
X-Received: by 2002:a05:600c:3b8e:b0:412:e4f9:2f4e with SMTP id
 n14-20020a05600c3b8e00b00412e4f92f4emr2222936wms.0.1709592095059; 
 Mon, 04 Mar 2024 14:41:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHqnVdE7GicBsJMudjUKdM0OPrSrWv+AnfO736J+RNN0P52ZveQ0Oq1sKjHfixBhjL6uSsyOQ==
X-Received: by 2002:a05:600c:3b8e:b0:412:e4f9:2f4e with SMTP id
 n14-20020a05600c3b8e00b00412e4f92f4emr2222929wms.0.1709592094648; 
 Mon, 04 Mar 2024 14:41:34 -0800 (PST)
Received: from [192.168.10.118] ([151.49.77.21])
 by smtp.gmail.com with ESMTPSA id
 bg14-20020a05600c3c8e00b004122b7a680dsm16130417wmb.21.2024.03.04.14.41.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 14:41:34 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: minhquangbui99@gmail.com
Subject: [PATCH] hw/intc/apic: fix memory leak
Date: Mon,  4 Mar 2024 23:41:33 +0100
Message-ID: <20240304224133.267640-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.571,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


