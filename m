Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF650C4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 11:16:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXfsn-0002qd-7W; Wed, 07 Feb 2024 06:14:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rXfsl-0002qB-5K
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 06:14:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rXfsj-0003P6-QK
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 06:14:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707304461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BbG1UcNnrJXHseB/1jw2t7pVf1ZGHlpH133WcB15Tq4=;
 b=IVdb1D+2Rf0T260n1ZMjeoEjCusAwCEDqNcKzVxs5VLE/L5pfEVvtD0yoJlyWfKvtNe5hU
 s0eSbZWL5jLY/AtGegyC7eB+BnlJXhWGqwwuqmB4kp8bJgU6Jmvf7gEAmAzOiLWnjgkCH8
 jKZiuT0Yg6oS29Diq5uxNF9sX6sf630=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-6E1RqNE-O9Kiw8EjYSpLSg-1; Wed, 07 Feb 2024 06:14:20 -0500
X-MC-Unique: 6E1RqNE-O9Kiw8EjYSpLSg-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a384e39d0d4so26958266b.1
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 03:14:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707304458; x=1707909258;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BbG1UcNnrJXHseB/1jw2t7pVf1ZGHlpH133WcB15Tq4=;
 b=dgfYDCjA4zLeEEzPyAbiDcDdW4bKmkLQUH3GdW4yz76KUCChvV4ATskRkVHF0mZuAg
 ZxQQ1AUK2psIvJ/qqJIXT709d73yzw2GQoKmJ2/+ezNsg+A6x8k4+PvJXWF1dfsYsjqH
 aUk9/+NqZqtt0AYRK7cYS+DCJsXAxtoAUTQCmzLVXs89ZPjywK1IHjpQ4AIFoCK2sydj
 SqTm7qASDoH6CTnTAZEsOkOaRM9/gjz+eYLcTVLw7iBL4ldbaM+6iYD44RaZX0fQ0hJJ
 5GAmHE33PBhL+b2YPwQ6YTkDqtV0xiV/uSNnNjpi83P6HPRBqlQKAcqDioOtbm04ynrJ
 zCgQ==
X-Gm-Message-State: AOJu0YxS11CzOdnO8ZA++4qpw6yBo07oM9s8M2Whp48A+1e/a9Lk09yN
 9CxdYG28rZnOiKOFy3fY8yfSjmtNDT3i3gXON5E5xyZdhk1ynt86P+fjLIKdHYsXnjRbc+08mAh
 hIFELIr1tPjG4GTW19Lp7K/Ay85/j17aHSwN9b6mvN8PaYLdqs/sr9vqBVB4t1TBW0ex7JNxkxQ
 AlrNLzhcB0PxL/nzC1NVNPUonzp27ZGPzveH99
X-Received: by 2002:a17:907:3c1e:b0:a38:916e:a4fe with SMTP id
 gh30-20020a1709073c1e00b00a38916ea4femr303719ejc.39.1707304458268; 
 Wed, 07 Feb 2024 03:14:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE4TiO4hr1rmyq0zBji3b49kdjYr3FQdBJWf/tJk+1bI5hHuiXssMaxi7fY8TvQKc6GK7MHOA==
X-Received: by 2002:a17:907:3c1e:b0:a38:916e:a4fe with SMTP id
 gh30-20020a1709073c1e00b00a38916ea4femr303707ejc.39.1707304457891; 
 Wed, 07 Feb 2024 03:14:17 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXUilhRUYNNqt83bzv7acwUt0ciWI+oVTAeW7vMfbwR0ufSyIvdkuEeN9WVuteHyjdRqRLcV134QoPlKIxErUTrkgdfJm8a9MwhTPcUAF+MYtkneU5WgebiygdDaDggzA==
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 i16-20020a1709061cd000b00a36c3e2e52dsm639263ejh.61.2024.02.07.03.14.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Feb 2024 03:14:16 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: shentey@gmail.com, philmd@linaro.org,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 2/8] isa: clean up Kconfig selections for ISA_SUPERIO
Date: Wed,  7 Feb 2024 12:14:04 +0100
Message-ID: <20240207111411.115040-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207111411.115040-1-pbonzini@redhat.com>
References: <20240207111411.115040-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
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


