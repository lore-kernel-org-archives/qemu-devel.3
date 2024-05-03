Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5541DC4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 11:11:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2qoI-0003tN-75; Fri, 03 May 2024 07:10:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s2qoA-0003qJ-8c
 for qemu-devel@nongnu.org; Fri, 03 May 2024 07:10:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s2qo8-0007yN-H1
 for qemu-devel@nongnu.org; Fri, 03 May 2024 07:10:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714734626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4GcCaGYwL/5+To8R5RwmPoaHqNLYYY2D6FMPVQfERz4=;
 b=Q/ZcnFBv177SQ6ZDBLrEhxhgmhINu2j89C/vIuLpcs4SpUrGm76fS4VbTSpMO8oXN3gBcI
 IW5PuqnmLOTe71M/aTDEvXz3iTw+WGVNXqEIk18yOb1RqW7QtCu+Mbg+DX9pX87b5tVUbl
 UwCtD7Uy10dXPH7qMLQvmUNz3utGMqE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-D-kP2m9eMgGzp53INh-8QA-1; Fri, 03 May 2024 07:10:23 -0400
X-MC-Unique: D-kP2m9eMgGzp53INh-8QA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a599dbd2b6aso3427066b.2
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 04:10:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714734621; x=1715339421;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4GcCaGYwL/5+To8R5RwmPoaHqNLYYY2D6FMPVQfERz4=;
 b=diaFt6koHR8r8UXXVABMwLiTXo8w8G/uP5znwwBw3rqZ9lZ21Hu59W789EueuZ0aIr
 ZJ/uhbeocmwtLpt/q6Lu896SmncObIN2CHebWr9OLcZd7YYT/hlbA8rIVYxh86pk+7BA
 CxXj+Fq5UJJltCjVRPWh48Yt2s/ADolcOklx2aLEg0rj/5sNpa6rY/TPLPMB5Rf2E+qc
 4QfAxaMvuRfFFMLdfXpVsGsyilAN0Gx4p/ErwDCequzbB5euEXxLFDPjatnK8Cx2fKvX
 eGYzxo2Vusm9jt5M8S+Alk/dO/XqpziFLIw3P6CdjojNLPEQkzTxyOQWD6NXTEYbcoAk
 cAIA==
X-Gm-Message-State: AOJu0YwGsB3NT9aqs4W5LT2UXUv143YX6wlOuaI3t5aESrya+hNasL8J
 QBnJ0EmpUz/9S0W8J+WWa0VPCYWpditOx5jFTcEWuiisCFR36mswjAKF1QE3VzQRM3N1HZGud3e
 NRQiLdK2cKwzxkg9PBKJXs0uQrG6RYgQ9ykBJv+kWYmI8H4dBxYXx+aRZUjLVk+hg9q5jvN0TnM
 67VuoR/W3JxKLPVOvPhNfuvxNarNX0lU9D6CgT
X-Received: by 2002:a17:907:7653:b0:a52:4edb:6db7 with SMTP id
 kj19-20020a170907765300b00a524edb6db7mr1325839ejc.54.1714734621358; 
 Fri, 03 May 2024 04:10:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJEYs1vwCZd3npXSzE8piWZfV7Ldizj/M3fhbNEA0qSt1ti+2sVAzWc1aXKRE7XLLzs5Yp0w==
X-Received: by 2002:a17:907:7653:b0:a52:4edb:6db7 with SMTP id
 kj19-20020a170907765300b00a524edb6db7mr1325821ejc.54.1714734620973; 
 Fri, 03 May 2024 04:10:20 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 md1-20020a170906ae8100b00a534000d525sm1589950ejb.158.2024.05.03.04.10.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 May 2024 04:10:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH] stm32l4x5_usart: add missing class_size
Date: Fri,  3 May 2024 13:10:19 +0200
Message-ID: <20240503111019.210717-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.483,
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

Depending on the phase of the moon, this seems to be causing CI failures on FreeBSD.
Fortunately, valgrind catches it too, and in a fully deterministic way:

==210026== Invalid write of size 4
==210026==    at 0x5222F3: stm32l4x5_lpuart_class_init (stm32l4x5_usart.c:611)
==210026==    by 0xA499E1: object_class_foreach_tramp (object.c:1132)
==210026==    by 0x5A60BEA: g_hash_table_foreach (ghash.c:2117)
==210026==    by 0xA4A190: object_class_foreach (object.c:1154)
==210026==    by 0xA4A190: object_class_get_list (object.c:1211)
==210026==    by 0x7A5777: select_machine (vl.c:1664)
==210026==    by 0x7A5777: qemu_create_machine (vl.c:2104)
==210026==    by 0x7A5777: qemu_init (vl.c:3667)
==210026==    by 0x47E528: main (main.c:47)
==210026==  Address 0xe131340 is 0 bytes after a block of size 192 alloc'd
==210026==    at 0x4849E60: calloc (vg_replace_malloc.c:1595)
==210026==    by 0x5A79F71: g_malloc0 (gmem.c:133)
==210026==    by 0xA48E9B: type_initialize (object.c:361)
==210026==    by 0xA48E9B: type_initialize (object.c:336)
==210026==    by 0xA499E1: object_class_foreach_tramp (object.c:1132)
==210026==    by 0x5A60BEA: g_hash_table_foreach (ghash.c:2117)
==210026==    by 0xA4A190: object_class_foreach (object.c:1154)
==210026==    by 0xA4A190: object_class_get_list (object.c:1211)
==210026==    by 0x7A5777: select_machine (vl.c:1664)
==210026==    by 0x7A5777: qemu_create_machine (vl.c:2104)
==210026==    by 0x7A5777: qemu_init (vl.c:3667)
==210026==    by 0x47E528: main (main.c:47)

Cc: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Cc: Inès Varhol <ines.varhol@telecom-paris.fr>
Cc: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/char/stm32l4x5_usart.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/char/stm32l4x5_usart.c b/hw/char/stm32l4x5_usart.c
index 2627aab8324..8dbcc7e19e7 100644
--- a/hw/char/stm32l4x5_usart.c
+++ b/hw/char/stm32l4x5_usart.c
@@ -615,6 +615,7 @@ static const TypeInfo stm32l4x5_usart_types[] = {
     {
         .name           = TYPE_STM32L4X5_USART_BASE,
         .parent         = TYPE_SYS_BUS_DEVICE,
+        .class_size     = sizeof(Stm32l4x5UsartBaseClass),
         .instance_size  = sizeof(Stm32l4x5UsartBaseState),
         .instance_init  = stm32l4x5_usart_base_init,
         .class_init     = stm32l4x5_usart_base_class_init,
-- 
2.44.0


