Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43ED0C4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 15:51:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZv3j-0002qg-Tj; Tue, 13 Feb 2024 10:50:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rZv3e-0002hv-Ni
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 10:50:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rZv3b-0005Vo-Nq
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 10:50:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707839448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mC2nbMoxIBuABmRhVbve0jC38/PoAQ5rTGQURWt/4Kk=;
 b=MhOyJOE4TrmhSNP9POB0F1avakD6WJiCZ0zAiwFop7BQuYIStIWbQif1gfHB+RStR80ctd
 mkycoo9BF7JiyVRtGej5fosN0IidJw/K9dqJItZ82aNxY6VEIzZxYKweyhRqWF8SYL1Ukp
 AZDBlk0eFQTcbXEU5eyff3BMAOGaW88=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-Ms1QCywhMXim4tu-K0sAqQ-1; Tue, 13 Feb 2024 10:50:46 -0500
X-MC-Unique: Ms1QCywhMXim4tu-K0sAqQ-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-785a91f4c28so532294385a.2
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 07:50:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707839443; x=1708444243;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mC2nbMoxIBuABmRhVbve0jC38/PoAQ5rTGQURWt/4Kk=;
 b=YmWKNXb7STmKiGh/yTVRxylY2uvqhGmcY/XYSqISTVV5MBq6GTwAH4cvjuFplzRnPJ
 QWF4Qt2E/jmtm1TvOJppMP9VZPAlw7PUufXGS5gESEmcYXcs++FDJCOKlp0/rgNSUr8J
 24aPWb+uvtQTrQErU5BvrNqsGAd/BQoEByPMQcRc7l/GPrwVrNkYylGQi3x3TVZ6t/Hv
 CFbChc7H560wzNbyQzFEwnQamHDa3tgN8xxXiUGNNO9UDA/Gl/Tj4xxtAUdYqhnmyYvU
 Co3uIuzyNVS2mQrjRIP2jAOanQssaJZT2MyGw8uSmlizuzYm7k36gW8NHVDygs5C0wS5
 1APA==
X-Gm-Message-State: AOJu0YwqwcL0hsaA3ALOfxklOs4dj5NDoC0RQ45XNMIot3DNd22F+2As
 JWp2SY6zA/N2QTF/AfUqx73u4ZqBnZtbreXb0QCOFYkYSH2yNbzNX2MB/UWs9bH8RL1TRyL6flJ
 UsBUsvyoiLxqNMgQJGrsDRl7EZDKo2EoJMIcsjKROv0srVeW7TxuUBf6ZdtC5R2ECjCrp444JVm
 vRZTedIwvP5o6QgvH2oee4oBUg/yoN86lpnkKb
X-Received: by 2002:a05:6214:4104:b0:68c:bcc4:f312 with SMTP id
 kc4-20020a056214410400b0068cbcc4f312mr14643052qvb.61.1707839443551; 
 Tue, 13 Feb 2024 07:50:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHNYk404EhQ+ABXoqyXKpF1QNsktTDQ/gHnTLUL8uOzERQmiTOxJt/iybmwjgmsNccGoiF6XQ==
X-Received: by 2002:a05:6214:4104:b0:68c:bcc4:f312 with SMTP id
 kc4-20020a056214410400b0068cbcc4f312mr14643026qvb.61.1707839443234; 
 Tue, 13 Feb 2024 07:50:43 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVgAWEVNFtpPKkSk7WJnwQSwY0/5fKbfcC6rfmB66Z0UIOaV7a+XIlMdIesJPB/Vwq+G28rRBhsKt72kxHsVZvxZvA8l0E5m0pU3KxYLfVtHDEjQwIn
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 x9-20020ad440c9000000b0068ccba4896asm1366913qvp.47.2024.02.13.07.50.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 07:50:39 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	shentey@gmail.com,
	balaton@eik.bme.hu
Subject: [PATCH v3 3/9] hw/mips/Kconfig: Remove ISA dependencies from MIPSsim
 board
Date: Tue, 13 Feb 2024 16:49:58 +0100
Message-ID: <20240213155005.109954-4-pbonzini@redhat.com>
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

From: Bernhard Beschow <shentey@gmail.com>

The board doesn't have a working ISA bus, only some I/O space.
Selecting ISA_BUS and including hw/isa/isa.h is not necessary.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-ID: <20230109204124.102592-3-shentey@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/mips/mipssim.c | 7 +++++--
 hw/mips/Kconfig   | 3 +--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/mips/mipssim.c b/hw/mips/mipssim.c
index 16af31648e2..a12427b6c8a 100644
--- a/hw/mips/mipssim.c
+++ b/hw/mips/mipssim.c
@@ -31,7 +31,6 @@
 #include "hw/clock.h"
 #include "hw/mips/mips.h"
 #include "hw/char/serial.h"
-#include "hw/isa/isa.h"
 #include "net/net.h"
 #include "sysemu/sysemu.h"
 #include "hw/boards.h"
@@ -206,7 +205,11 @@ mips_mipssim_init(MachineState *machine)
     cpu_mips_irq_init_cpu(cpu);
     cpu_mips_clock_init(cpu);
 
-    /* Register 64 KB of ISA IO space at 0x1fd00000. */
+    /*
+     * Register 64 KB of ISA IO space at 0x1fd00000.  But without interrupts
+     * (except for the hardcoded serial port interrupt) -device cannot work,
+     * so do not expose the ISA bus to the user.
+     */
     memory_region_init_alias(isa, NULL, "isa_mmio",
                              get_system_io(), 0, 0x00010000);
     memory_region_add_subregion(get_system_memory(), 0x1fd00000, isa);
diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
index ab61af209a0..afcfb2b8eca 100644
--- a/hw/mips/Kconfig
+++ b/hw/mips/Kconfig
@@ -6,8 +6,7 @@ config MALTA
 
 config MIPSSIM
     bool
-    select ISA_BUS
-    select SERIAL_ISA
+    select SERIAL
     select MIPSNET
 
 config JAZZ
-- 
2.43.0


