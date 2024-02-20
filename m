Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26F94C48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 08:08:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcLAH-00051S-EA; Tue, 20 Feb 2024 03:07:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rcLAD-0004zh-MB
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:07:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rcLAB-0000WL-O8
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:07:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708416459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0gMIIZtbr1VC+ByGiOX54Iv2fvudEImt7S0oZ9/WbL4=;
 b=B6P2Yfh28LK8vEmLnqfBNyGee4N5x7fSGPNDz71LOF9eQLXjvLT5tsMorXwtAlXzFjF+it
 /pEgOEQnP6g1ucCtnrlFHAUhv83jKJ+sIegTDgCpfyiajSh8N9Dq804zLx4/LWEUWVRlPk
 ArSBmYEiR1895k0OHNgXXTDNR0grjN4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-8xLyHdwpMfiWH9f28zsStQ-1; Tue, 20 Feb 2024 03:07:37 -0500
X-MC-Unique: 8xLyHdwpMfiWH9f28zsStQ-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-563e6dd8d64so2093926a12.2
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 00:07:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708416455; x=1709021255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0gMIIZtbr1VC+ByGiOX54Iv2fvudEImt7S0oZ9/WbL4=;
 b=P4xry9HgW/L2/aPuOnwr7RIW06amLfOHhhIMeI78zfKxGf/hKyXxHwy1XIn2OnUXwK
 FCd8Y6HVap7+4+eyG1ImAfi3LHl+o+dsvR/1d5mXcfVA2TBE2SkE4AH/YK0bvQhFACeQ
 lMlNJTAwIba0CFyzzt8rGJK/bwuZbMHbANZo+COKe7jfSYW5isqHk3LDMb6V0aWOof/V
 8N36XNOeNM5IXZNZLnpxZhTIgAvtY5LWaK98ZH8l5ozzF9dDJSsXBQVIoswr6bIZlQdr
 ec3upZIkB1SVLA9r0Rc/d+sg3S54FePr23+0WBlig1AuRGoHqgmmx0v1ezwc/ErexLSj
 32vA==
X-Gm-Message-State: AOJu0YycEhACbnn9sYdXQFjx0j3p/LWAIJncWvuiLn9ZG1qg9QFrIBQY
 2ZarX4Q5pQ3Px/zSZ3XwVViXqiWYa5W6bI/xSWq8hiqyYy7y8LBUXLseVexoghevDAAJtRNajwB
 WNz5fMk+HeCB3yLtSyvuwr1DdkSKa+utjs99C6gP3Xdw/7H79zOdh7GhtsPJBMlNIbRs6Wqqeh4
 6NrsijxOvxypamudAz6NWVdOJkB+NR5lVshSHm
X-Received: by 2002:aa7:c646:0:b0:563:f889:24bd with SMTP id
 z6-20020aa7c646000000b00563f88924bdmr6426380edr.8.1708416455504; 
 Tue, 20 Feb 2024 00:07:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGIQ39Hd1LapZCqpukh9LegPgsMbU8l9vBFK84/XMbGLkIiD1/eCWLEmpMmPqq3z5XbYKn/nQ==
X-Received: by 2002:aa7:c646:0:b0:563:f889:24bd with SMTP id
 z6-20020aa7c646000000b00563f88924bdmr6426369edr.8.1708416455168; 
 Tue, 20 Feb 2024 00:07:35 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 u20-20020aa7d894000000b00564648bb01csm2056702edq.22.2024.02.20.00.07.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 00:07:34 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 10/17] isa-superio: validate floppy.count value
Date: Tue, 20 Feb 2024 09:05:51 +0100
Message-ID: <20240220080558.365903-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240220080558.365903-1-pbonzini@redhat.com>
References: <20240220080558.365903-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Ensure that the value is valid; it can only be zero or one.
And never create a floppy disk controller if it is zero.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/isa/isa-superio.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/isa/isa-superio.c b/hw/isa/isa-superio.c
index 7dbfc374da3..e06a548c682 100644
--- a/hw/isa/isa-superio.c
+++ b/hw/isa/isa-superio.c
@@ -116,7 +116,9 @@ static void isa_superio_realize(DeviceState *dev, Error **errp)
     }
 
     /* Floppy disc */
-    if (!k->floppy.is_enabled || k->floppy.is_enabled(sio, 0)) {
+    assert(k->floppy.count <= 1);
+    if (k->floppy.count &&
+        (!k->floppy.is_enabled || k->floppy.is_enabled(sio, 0))) {
         isa = isa_new(TYPE_ISA_FDC);
         d = DEVICE(isa);
         if (k->floppy.get_iobase) {
-- 
2.43.0


