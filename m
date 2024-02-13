Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4777DC48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 15:51:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZv3k-0002uB-QO; Tue, 13 Feb 2024 10:51:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rZv3g-0002jO-Q8
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 10:50:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rZv3b-0005V7-O6
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 10:50:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707839441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BbG1UcNnrJXHseB/1jw2t7pVf1ZGHlpH133WcB15Tq4=;
 b=Yc7AP2/YK/vBwlxI4lfVHk6kXWs33kpt4xMwvtACtNljKn34roYtSDa8oq/VDuVlK9QsSO
 WBGp/sCBHeDXFj2hOv7/5F3I7rd26SqeCiR/WnNEeIX6HwFDAkw35T2kL2J4Hh7UNdQsAy
 aTCG+zZGk49KV/QLJpEfjjW39W6b8KQ=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-WyfZAwalPZ6VgEcqCDPlaA-1; Tue, 13 Feb 2024 10:50:39 -0500
X-MC-Unique: WyfZAwalPZ6VgEcqCDPlaA-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-68c4f2aca5dso80529716d6.3
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 07:50:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707839437; x=1708444237;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BbG1UcNnrJXHseB/1jw2t7pVf1ZGHlpH133WcB15Tq4=;
 b=UYXvD/Q3wHsZCvdz01i7W4PCFHui/oQ7mUxY9bNydXaeNuhrr4A3z6xaKLwIIrQdQ9
 a5o7fap6DtAWDhTdv/MMbWWuBm/4ioHow7XyhZdUjoUk2vA1FVqqh+9rhPD+ysRQXf14
 7QT9w8xK9BSE87JIffKnnUTHHXqc6IEgkzEOGi6+14gGgfBaJaiJXo4t0O6ZqLriV0DP
 p9yiP2UVNhKc2onX7xCmPlgZVtUewUBcSRxtnMUJ38swX8T5BqcX0YQZY0fS+vYNxAvE
 p0gD3+DjIEx+zKEdL4+kUzLg2ZrOkTNlnLGTwOO+tET2irnH0ByfTjwNuWvFQvBXq52S
 v19w==
X-Gm-Message-State: AOJu0Yz+1+jB3pa4hB/WhFQLl9SDdBlc5xP/XQrJYerU9Z0TjGUdi7Yh
 91CFZPc6iZoL2sJzG+riDt3IzSoSKv0u2yCBqrDFtJjNTS3e3AFNB8az0fwTiyzlpNTQRizqESL
 2fGW++3xmqnBm668616u5h0jAXOuWIEcEpMHK6TPDfq1s7p8FXmY8t+RNAIPloRNTqv/vx+KhjW
 k1B3+1d82MHmyYk1vd0QwGtQ9WFRggJZ6pl7Le
X-Received: by 2002:a0c:f54d:0:b0:68c:8bee:a617 with SMTP id
 p13-20020a0cf54d000000b0068c8beea617mr9217066qvm.39.1707839437616; 
 Tue, 13 Feb 2024 07:50:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExqNDqol1z+aASmo8b3qMSL9/Ycr9wPupvHUTzeSKUmlx2T9HgV7QGf34J6kGGO2pITzwURw==
X-Received: by 2002:a0c:f54d:0:b0:68c:8bee:a617 with SMTP id
 p13-20020a0cf54d000000b0068c8beea617mr9217049qvm.39.1707839437304; 
 Tue, 13 Feb 2024 07:50:37 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXSSduA+98Mzjn18XeFAseyv/CK3WGQZpcStXqrp+DggPxqKojLLe7nSSjucA+R8MOvrQoPI6VaPg5CGm/Tj0HLkU7Wh/cTVo/LV7ke0MhE4lr7jc25mGGTvrbUjr3vK8LZw2Rl+P0HoZmPJMp7x1Flr9h7
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 lx15-20020a0562145f0f00b0068ee9aeacefsm601825qvb.146.2024.02.13.07.50.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 07:50:24 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, shentey@gmail.com, balaton@eik.bme.hu,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 2/9] isa: clean up Kconfig selections for ISA_SUPERIO
Date: Tue, 13 Feb 2024 16:49:57 +0100
Message-ID: <20240213155005.109954-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213155005.109954-1-pbonzini@redhat.com>
References: <20240213155005.109954-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.504,
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

All users of ISA_SUPERIO include a floppy disk controller, serial port
and parallel port via the automatic creation mechanism of isa-superio.c.

Select the symbol and remove it from the dependents.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/isa/Kconfig | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/hw/isa/Kconfig b/hw/isa/Kconfig
index 040a18c0709..7884179d08b 100644
--- a/hw/isa/Kconfig
+++ b/hw/isa/Kconfig
@@ -17,7 +17,11 @@ config ISA_SUPERIO
     bool
     select ISA_BUS
     select PCKBD
+    select PARALLEL
+    select SERIAL_ISA
     select FDC_ISA
+    # Some users of ISA_SUPERIO do not use it
+    #select IDE_ISA
 
 config PC87312
     bool
@@ -26,9 +30,6 @@ config PC87312
     select I8254
     select I8257
     select MC146818RTC
-    select SERIAL_ISA
-    select PARALLEL
-    select FDC_ISA
     select IDE_ISA
 
 config PIIX
@@ -49,8 +50,6 @@ config VT82C686
     select ISA_SUPERIO
     select ACPI
     select ACPI_SMBUS
-    select SERIAL_ISA
-    select FDC_ISA
     select USB_UHCI
     select APM
     select I8254
@@ -58,14 +57,10 @@ config VT82C686
     select I8259
     select IDE_VIA
     select MC146818RTC
-    select PARALLEL
 
 config SMC37C669
     bool
     select ISA_SUPERIO
-    select SERIAL_ISA
-    select PARALLEL
-    select FDC_ISA
 
 config LPC_ICH9
     bool
-- 
2.43.0


