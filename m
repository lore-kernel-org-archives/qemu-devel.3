Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B0AC5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 12:48:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdUxo-0007K2-RS; Fri, 23 Feb 2024 07:47:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rdUun-0000mj-RV
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 07:44:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rdUuk-0003uO-Dv
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 07:44:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708692269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7f1rYsUVXVWM9aVY7w8eUmrIaIbBx6X0kUvj6Xvo3iY=;
 b=Lng8j+DfgopdYSQxT1CM+fLyrhj7iSYyZWbXfVuUb0Ych2CMYMGZbftKRJNwGRmrEr+ugF
 80mSlyOss53qfcFrj9Vb6Od3faAj8N8Y2fc2lPG0BSpRPwSmuOWSL9siDrl/8z/JYJOwiI
 9W+P1v9lDeOfSFHiKY8GxmZE5ZTVX0o=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-7vgVU-OhNp-FaJY7vEIt4Q-1; Fri, 23 Feb 2024 07:44:28 -0500
X-MC-Unique: 7vgVU-OhNp-FaJY7vEIt4Q-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-33d51bb9353so363777f8f.2
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 04:44:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708692266; x=1709297066;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7f1rYsUVXVWM9aVY7w8eUmrIaIbBx6X0kUvj6Xvo3iY=;
 b=G2AG9BB9ElZTJVSM6Flqu3qjwTCd3+In0SkIDxIVDCA06eGy2aB0UQYtHzs3DAVvO6
 mugyUOO0mhap6141RsTyitfMfW0cmtdzGwQ0fHGMh+H5W57b3rZpI3j9TKkotvEHF1YZ
 DtTCQ9LdRmZZh0APStQ5JadCFKMh3qj2hRuSgpRq4CsHXwWmRbS4nmDDa+yjwC5VxSKZ
 JQvycgLSNFYNsEon6vOd+tr+zyyUai1y6gJVvdIQ5LLVtEdWAfHfSgl9gRFaOgGVobhV
 L2j9oC5Q2LCxV0aSpQPGGg5YLUpjG8lJ6glz8BfCVUgEesacPgcg7im9AoyOPVXNpQIK
 7QCw==
X-Gm-Message-State: AOJu0Ywb8p471BPT+coduvd5I6E1HWc5pzfFXeEQ5oVidQBpO+TMHWQA
 eAifjPYVc/jSMxZoBMG+K+UlW3rjG7QPbs4IvVl/xqsXJYfQcYIty98fbwE5TJWdC2nRO/jFfoO
 xuqMlnU5ouig84Kb9fstyzXv4/OcL0KqpEdEr1F347pcbvmOIkGbHeF5sDNBaf8GgVwGPJE7S96
 rAuVfLTJZL10hJRkuf6Y4qDtnzBlRbeKKqxCow
X-Received: by 2002:adf:e789:0:b0:33d:3566:b5bf with SMTP id
 n9-20020adfe789000000b0033d3566b5bfmr1545605wrm.14.1708692266772; 
 Fri, 23 Feb 2024 04:44:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE9HiiapX5Ydb8YEpnBoLAATyy/JkywlvMQJDQx/gvppnw/04bZvrl4m7Mk8QcOo5Vmj3iheA==
X-Received: by 2002:adf:e789:0:b0:33d:3566:b5bf with SMTP id
 n9-20020adfe789000000b0033d3566b5bfmr1545592wrm.14.1708692266523; 
 Fri, 23 Feb 2024 04:44:26 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 m4-20020adff384000000b0033cfa00e497sm2797729wro.64.2024.02.23.04.44.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Feb 2024 04:44:23 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	balaton@eik.bme.hu
Subject: [PATCH 06/10] mac_newworld: do not require CONFIG_USB
Date: Fri, 23 Feb 2024 13:44:02 +0100
Message-ID: <20240223124406.234509-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240223124406.234509-1-pbonzini@redhat.com>
References: <20240223124406.234509-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.066,
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

With --without-default-devices it should not be required to have
devices in the binary that are removed by -nodefaults.  It should be
therefore possible to build a binary that does not include any USB
host controller or any of the code guarded by CONFIG_USB.  While the
simpler creation functions such as usb_create_simple can be inlined,
this is not true of usb_bus_find().  Remove it, replacing it with a
search of the single USB bus on the machine.

With this change, it is possible to change "select USB_OHCI_PCI" into
an "imply" directive.

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/ppc/mac_newworld.c | 7 +++----
 hw/ppc/Kconfig        | 2 +-
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index b36dbaf2b68..4efebab66b4 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -431,10 +431,9 @@ static void ppc_core99_init(MachineState *machine)
         /* U3 needs to use USB for input because Linux doesn't support via-cuda
         on PPC64 */
         if (!has_adb || machine_arch == ARCH_MAC99_U3) {
-            USBBus *usb_bus = usb_bus_find(-1);
-
-            usb_create_simple(usb_bus, "usb-kbd");
-            usb_create_simple(usb_bus, "usb-mouse");
+            Object *usb_bus = object_resolve_type_unambiguous(TYPE_USB_BUS, &error_abort);
+            usb_create_simple(USB_BUS(usb_bus), "usb-kbd");
+            usb_create_simple(USB_BUS(usb_bus), "usb-mouse");
         }
     }
 
diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
index 44263a58c4d..9841c2c9690 100644
--- a/hw/ppc/Kconfig
+++ b/hw/ppc/Kconfig
@@ -116,13 +116,13 @@ config MAC_NEWWORLD
     imply PCI_DEVICES
     imply SUNGEM
     imply TEST_DEVICES
+    imply USB_OHCI_PCI
     select ADB
     select MACIO
     select MACIO_GPIO
     select MAC_PMU
     select UNIN_PCI
     select FW_CFG_PPC
-    select USB_OHCI_PCI
 
 config E500
     bool
-- 
2.43.0


