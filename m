Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEE8EC47422
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 14:20:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rURmh-00084U-H1; Mon, 29 Jan 2024 08:34:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rURmP-00082J-W2
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 08:34:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rURmO-00082i-CO
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 08:34:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706535266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=L28DiEdX8ibXzBrQEA4ZMcHS/C82KNZ2LFxsi4oHYBs=;
 b=Cc0adNvm4RO/Ql5aMQSVOZ7T/tt89AJnFIQeKXfXIsuJESed9CIttj914hMH/neoHzdnU/
 +wEBfQsoEAsrzMPXjMUfMQDTSTWKORIoykE2WUVPCQGkAcAbyJOaNAFGXHNbaamFQpqwZR
 +6hh/kbUEwnvhSCEDCDZ8QDxci+9tOc=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-mz8o2mm2M-CsIIY3hgr-WA-1; Mon, 29 Jan 2024 08:34:24 -0500
X-MC-Unique: mz8o2mm2M-CsIIY3hgr-WA-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5101af0a385so1447003e87.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 05:34:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706535262; x=1707140062;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L28DiEdX8ibXzBrQEA4ZMcHS/C82KNZ2LFxsi4oHYBs=;
 b=WUZ1dC76sC1mfri052Vyi66/yPRSai22K91hO4aZhK6gXKyMk9pn0/LILYYwMOrW4z
 qXK6go66A0zZSh9iIZQAgh296cZHY9EMvRo8OfF+Fx3dtHFK36k7UsiE8nXFQ5lcYvpc
 0NoulyT6ELaGi5jOyLp1v9UQf9pOQalswnA+3KLWurXLQc/6t4faKeRbBFP3hSdnPWTk
 S5NYLvjS2EK4fwToaB00avb7cuHYZPvi/UMB3LTvnf/BAfGlxcwBH4JzIjzrtuq6hK/M
 SF7Q51inyICPJJqJlxU1osGsWCCL2JOZ7iUevMrg7CqZfbslWoeheiHxWMV4JA1Hh6Q1
 NwzA==
X-Gm-Message-State: AOJu0YyByCHfpU4qTVeSpjXMH/HXmAXWBX3mmAYOuG+hpvmj62qlbnGL
 Yu6XbpOC4d+LCv/YlxCKf37p6pId+pp5c5xtVKmFtedMVGlwBSUIM0SPEk6LSkp7RNdIgDEZyJv
 A7BJrYNtJujTsF1yEx8raKpl8Mbghn6YOp1cns/1/RkVRTLEsI+G6tmdAfsM4sUCao7qsNJw4AK
 RNa9l+dLELvBOvtVFB2Z17i4a9iA8PMg1BPEIQ
X-Received: by 2002:a05:6512:3ca1:b0:50e:609c:ab90 with SMTP id
 h33-20020a0565123ca100b0050e609cab90mr4307890lfv.32.1706535262282; 
 Mon, 29 Jan 2024 05:34:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGWIXqOAqPxRCr0eLaSUbnSbJ2uLgwFzT7wQdnonoVmS+W3ZZggv8jfQz0AIcU7C0pb3ca+XA==
X-Received: by 2002:a05:6512:3ca1:b0:50e:609c:ab90 with SMTP id
 h33-20020a0565123ca100b0050e609cab90mr4307872lfv.32.1706535261808; 
 Mon, 29 Jan 2024 05:34:21 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 og16-20020a1709071dd000b00a28aba1f56fsm3907791ejc.210.2024.01.29.05.34.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 05:34:21 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] smc37c669: remove useless is_enabled functions
Date: Mon, 29 Jan 2024 14:34:20 +0100
Message-ID: <20240129133420.1105877-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.29,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Calls to is_enabled are bounded to indices that actually exist in
the SuperIO device.  Therefore, the is_enabled functions in
smc37c669 are not doing anything and they can be removed.

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


