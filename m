Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3AD5C48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 08:08:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcLAQ-00060f-R1; Tue, 20 Feb 2024 03:07:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rcLAP-0005m7-33
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:07:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rcLAN-0000ac-Fy
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:07:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708416470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g73OzMwU0CCIScO+4S6Qdh+LHTOWNxgg7pWe0LAuiOs=;
 b=f/ViD/yrYNJ60S0c0UH5NbtJX6HHtaU6xuzpccNhfTMlwPzpDenMwUD5EZ0kJu7Cd9CRCB
 YFOI4QJlkP+aucqhsPnmm7kt7mWsGJiMH06edQExhYW5paMaeulS/hO0n+IZbtUDfq0jFa
 P5WEoAbKSlF+iGO58KxBZa5oZYoHjWQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-xtKDLGmeM7OqnAzmlVx2sA-1; Tue, 20 Feb 2024 03:07:49 -0500
X-MC-Unique: xtKDLGmeM7OqnAzmlVx2sA-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-564cb5b2bc5so183383a12.0
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 00:07:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708416467; x=1709021267;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g73OzMwU0CCIScO+4S6Qdh+LHTOWNxgg7pWe0LAuiOs=;
 b=uuX2Z1Ofc0XEz89Li/Zt9eA+DYdpR+dhOsRX/0AV1BRo4K5ubYqUSIS5OnRkwjP6av
 h+dSeiPlKXzNMSV12nSYrUxbrbOF0idaj/OoMawqSbESqaLRNLsD2NKc014a6w2nf0be
 GfDm97J6QfRo2ZlobNpG5pZJb7PJxfEvxGWLhWMFX7cO3keLQa7mDeFzdtDtCQGsBSg2
 q1Qb/PMVbc2peqHD1GfFZnT2fBS3BoKtnhRktDHD/IRMeNUmAc+d2rhcIhHSzpFnZkCQ
 1ddzEoio7t70Gvz3jXbQVCb4VeYTNcIaz4L83yoxK360LKHjgwyJBmwzgfYrffvn4wcl
 yWJA==
X-Gm-Message-State: AOJu0Yw9B5JhZ7w8wxGVITNuUUxQ4w0kk5eWhLHtADNfgq5dNr0WhXlJ
 4Tyf0NqrchmeCjh6mdA1uP2hRfdLlHxgTOUbnZzinbOMh86XtuAeSSp1AIlq5wPRziMqQlx8zxK
 hRkZ7HYikJPHnZm5MCeDLF9+oaE9Dl24KlUohlFeKl6gsu4x5gZGqbSa3ipzw8yMWu1Xo68ujq8
 3CoFdeNfmRiTAq94ippue50k76R0yiPpOVudse
X-Received: by 2002:a17:906:bc45:b0:a3e:71eb:c54c with SMTP id
 s5-20020a170906bc4500b00a3e71ebc54cmr4775007ejv.49.1708416467227; 
 Tue, 20 Feb 2024 00:07:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEn6xRmQYWH+PkgaWzzGQit0KqY8UyddgUIje8BKpTV5RxmVZKm4yUzdKs8gb6M95XuvsgolA==
X-Received: by 2002:a17:906:bc45:b0:a3e:71eb:c54c with SMTP id
 s5-20020a170906bc4500b00a3e71ebc54cmr4774976ejv.49.1708416466759; 
 Tue, 20 Feb 2024 00:07:46 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 vg8-20020a170907d30800b00a3d2fe84ff9sm3707394ejc.36.2024.02.20.00.07.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 00:07:46 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>
Subject: [PULL 11/17] smc37c669: remove useless is_enabled functions
Date: Tue, 20 Feb 2024 09:05:52 +0100
Message-ID: <20240220080558.365903-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240220080558.365903-1-pbonzini@redhat.com>
References: <20240220080558.365903-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.072,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Calls to is_enabled are bounded to indices that actually exist in
the SuperIO device.  Therefore, the is_enabled functions in
smc37c669 are not doing anything and they can be removed.

Reviewed-by: Bernhard Beschow <shentey@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/isa/smc37c669-superio.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/hw/isa/smc37c669-superio.c b/hw/isa/smc37c669-superio.c
index 18287741cb4..388e2ed9371 100644
--- a/hw/isa/smc37c669-superio.c
+++ b/hw/isa/smc37c669-superio.c
@@ -14,11 +14,6 @@
 
 /* UARTs (compatible with NS16450 or PC16550) */
 
-static bool is_serial_enabled(ISASuperIODevice *sio, uint8_t index)
-{
-    return index < 2;
-}
-
 static uint16_t get_serial_iobase(ISASuperIODevice *sio, uint8_t index)
 {
     return index ? 0x2f8 : 0x3f8;
@@ -31,11 +26,6 @@ static unsigned int get_serial_irq(ISASuperIODevice *sio, uint8_t index)
 
 /* Parallel port */
 
-static bool is_parallel_enabled(ISASuperIODevice *sio, uint8_t index)
-{
-    return index < 1;
-}
-
 static uint16_t get_parallel_iobase(ISASuperIODevice *sio, uint8_t index)
 {
     return 0x378;
@@ -53,11 +43,6 @@ static unsigned int get_parallel_dma(ISASuperIODevice *sio, uint8_t index)
 
 /* Diskette controller (Software compatible with the Intel PC8477) */
 
-static bool is_fdc_enabled(ISASuperIODevice *sio, uint8_t index)
-{
-    return index < 1;
-}
-
 static uint16_t get_fdc_iobase(ISASuperIODevice *sio, uint8_t index)
 {
     return 0x3f0;
@@ -79,20 +64,17 @@ static void smc37c669_class_init(ObjectClass *klass, void *data)
 
     sc->parallel = (ISASuperIOFuncs){
         .count = 1,
-        .is_enabled = is_parallel_enabled,
         .get_iobase = get_parallel_iobase,
         .get_irq    = get_parallel_irq,
         .get_dma    = get_parallel_dma,
     };
     sc->serial = (ISASuperIOFuncs){
         .count = 2,
-        .is_enabled = is_serial_enabled,
         .get_iobase = get_serial_iobase,
         .get_irq    = get_serial_irq,
     };
     sc->floppy = (ISASuperIOFuncs){
         .count = 1,
-        .is_enabled = is_fdc_enabled,
         .get_iobase = get_fdc_iobase,
         .get_irq    = get_fdc_irq,
         .get_dma    = get_fdc_dma,
-- 
2.43.0


