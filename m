Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF8D1C47422
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 14:08:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rURpu-0002ES-27; Mon, 29 Jan 2024 08:38:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rURpr-0002Cp-Kn
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 08:38:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rURpp-0000lD-3q
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 08:38:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706535478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nLOABirsn5jmWA1R6juqxKb1mavf0htw/yc/6sFKvLU=;
 b=Ix5GgWGSeKTObuONPXVZ5mguVwZBnbq6QWX4imbj5ANcjZfYxbbcFG9mXBm/33ubbKwVW/
 TxI0N1d4caU5A5MQxC0RXyXCm21smgpb3WyvRkMdpkXEWf3AS79cznFfzCR0NH2CPRx/kc
 UGx54kpRO0g0JoTRY8Z2Ka4kPFvXQ8g=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-OEdI8YtNOi-o_vUT77YDkg-1; Mon, 29 Jan 2024 08:37:57 -0500
X-MC-Unique: OEdI8YtNOi-o_vUT77YDkg-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a35bcf841a0so46549966b.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 05:37:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706535475; x=1707140275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nLOABirsn5jmWA1R6juqxKb1mavf0htw/yc/6sFKvLU=;
 b=M55szV7SLIqos2FL/h+fB5Jbczm/tgJQYlnfC+1/mDjHOVwtigCX56SKNxWTpf+jzP
 cprbAEfByUzGnm//FQhG4SIWIgKBsqjNTHP1fqHneOUj+PNv0HdLO9F/k9GzGmrl2YWi
 YkNIftWPij85AKtg2Afccbmjm2+iEyMvelZdloN2TvDZwR306xeH3bEILgT/J8X5ezPl
 oGcg0qpqN4YNjT1nCsTVFAb7jQhYKQWHcvJGWfA0fTTj17uEvz+aERLIJRKSCFTtkQwR
 hcfwC1WJQdlk+sJXZVEpw9FyaVJq+MYSmwtEy1EtdCa1zDVMH+CRNlkHyISRB2aJjXJQ
 AJJQ==
X-Gm-Message-State: AOJu0YxH2HOsBvceRK1oZogIlC/ZABr6KWV+iaxDl6HISUznfQgyBEo4
 NphpSpqLHQoo8U+lxLxdCfOJ15AHoLInYPIj/GZVA8SSXcIiuMR+Mxe7DpCITdlT5GkLEOZkgtD
 DuWhCAlXrmpmRCeNPNYf7f/HUhRoeaoSknmIJquj+XBOb+XNLmDKDWG0KeAx8yZlhxWX1kHAm18
 PX/vfNVHKKj2SD0uYEDICl0oMtd7bO4NgrE8TW
X-Received: by 2002:a17:906:fa9a:b0:a35:e22a:9d15 with SMTP id
 lt26-20020a170906fa9a00b00a35e22a9d15mr1031744ejb.8.1706535475746; 
 Mon, 29 Jan 2024 05:37:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjDbEfbkd+1PzY3NFE1S2ScMacqj2Jbt3ZcUx6WRDSTpTvT2uGtq1CygzeQxaGDEFpFuoD8Q==
X-Received: by 2002:a17:906:fa9a:b0:a35:e22a:9d15 with SMTP id
 lt26-20020a170906fa9a00b00a35e22a9d15mr1031729ejb.8.1706535475391; 
 Mon, 29 Jan 2024 05:37:55 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 pk27-20020a170906d7bb00b00a35242f5976sm3157264ejb.164.2024.01.29.05.37.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 05:37:54 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH 1/4] isa: clean up Kconfig selections for ISA_SUPERIO
Date: Mon, 29 Jan 2024 14:37:45 +0100
Message-ID: <20240129133751.1106716-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129133751.1106716-1-pbonzini@redhat.com>
References: <20240129133751.1106716-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.29,
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

All users of ISA_SUPERIO include a floppy disk controller, serial port
and parallel port via the automatic creation mechanism of isa-superio.c.

Select the symbol and remove it from the dependents.

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


