Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 813A4C48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 15:57:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZv9H-0006LQ-Do; Tue, 13 Feb 2024 10:56:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rZv9F-0006L2-Kt
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 10:56:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rZv9E-0006vR-A7
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 10:56:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707839799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SxctDiX8kY4Gz+7Kaz/DqaqM25ke4UsXK6uTYvM+c50=;
 b=D13j5wFBKkJNVZA8WnQySr9QHFLP1p+T/u8EiAk/qk25iCLK4eEdaCxsnS1HXOgXWG6MRN
 uER+QR5HKMTOjQS5ws6FxgJWl2lIzxGRYO1koseNxSQsuaiEJfurY7c4w7h45K7qt/cg5H
 XgYF21blAgI06NrUA6GpU0Imr08M//c=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-ciXwR073Ozy3p5hAJ_G4Bg-1; Tue, 13 Feb 2024 10:56:38 -0500
X-MC-Unique: ciXwR073Ozy3p5hAJ_G4Bg-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-560f41972easo2528098a12.0
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 07:56:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707839483; x=1708444283;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SxctDiX8kY4Gz+7Kaz/DqaqM25ke4UsXK6uTYvM+c50=;
 b=Sb20iN9HcgeiW07UH9eZzJU95pRu10yGDwjHjRMrxE2W8ChgjGyKrIZUjvaKzbwkse
 HIEEXYxtPPOOBwBq+P4tj/Egfzi9qZIHWrFsHKFkzIu2sIDqI7wOwWktI49Ett5CPAjc
 G2vQI1bum/rwtGfFRTM6rQN4jMyTv46NgM62e8na6XEzsVco/z4s/TdE+so1db8q2Ik+
 08OR77nOQtxuFFEJ7hoCS0pXviLMX2aJUc6GdsKqiYyaHvpQj5sV3mtRJxwWID2KPb6n
 9qxsjJNRiqSxGRrwIEPw2OYWSAZ1YKC1Y/PQbY7tTyHLHUdDVYZEC4nUijnj4dMgONHL
 zaFw==
X-Gm-Message-State: AOJu0YyClhZIQhpV5MmYoG6oWfAHBcrycsHgp+GbvjotjQi+VZ+pCekU
 IVZwwZqWsx+lAL5b5Ho+rPIrGORyiYu5Hu6m0ZnEe/8+aC4vd7dMs+spyxObBdJMAZRlRq0Fdur
 I6k8HVtI/pAgcRkIxAqKorVnD+k3ZDI8BQh6Kn0SXWjGVImzbWFwJQ8aFQEUP86xz7+0HUCKg6m
 mN/eqJIezeu/2ea6JLXMJbab5i2VnovHaeWK1m
X-Received: by 2002:aa7:d354:0:b0:55f:e9ce:7406 with SMTP id
 m20-20020aa7d354000000b0055fe9ce7406mr27025edr.29.1707839483302; 
 Tue, 13 Feb 2024 07:51:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGNfeSqJ4mQB1iWytrwj0OJZpF2aiVxE62ck/lsHfpl+ws76SQfKAPs9QZhvLDW8yRUdFrkAA==
X-Received: by 2002:aa7:d354:0:b0:55f:e9ce:7406 with SMTP id
 m20-20020aa7d354000000b0055fe9ce7406mr27010edr.29.1707839483063; 
 Tue, 13 Feb 2024 07:51:23 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXQ89IsHKKLtWb2YUm7LzvanFQfgAltiTYtB/NtumYfPZebmrXFAawkf8M3vBE1cdy5g1244AObIsAm7qlbPcmxT1x21vrfAPviyIV2oVCl1rgeMnlm
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 dk21-20020a0564021d9500b0055c85e6d75dsm3858934edb.87.2024.02.13.07.51.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 07:51:16 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	shentey@gmail.com,
	balaton@eik.bme.hu
Subject: [PATCH v3 8/9] mips/loongson3_virt: do not require CONFIG_USB
Date: Tue, 13 Feb 2024 16:50:03 +0100
Message-ID: <20240213155005.109954-9-pbonzini@redhat.com>
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

Once the Kconfig for hw/mips is cleaned up, it will be possible to build a
binary that does not include any USB host controller and therefore that
does not include the code guarded by CONFIG_USB.  While the simpler
creation functions such as usb_create_simple can be inlined, this is not
true of usb_bus_find().  Remove it, replacing it with a search of the
single USB bus created by loongson3_virt_devices_init().

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/mips/loongson3_virt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index caedde2df00..bedd3d496bd 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -447,8 +447,9 @@ static inline void loongson3_virt_devices_init(MachineState *machine,
 
     if (defaults_enabled() && object_class_by_name("pci-ohci")) {
         pci_create_simple(pci_bus, -1, "pci-ohci");
-        usb_create_simple(usb_bus_find(-1), "usb-kbd");
-        usb_create_simple(usb_bus_find(-1), "usb-tablet");
+        Object *usb_bus = object_resolve_path_type("", TYPE_USB_BUS, NULL);
+        usb_create_simple(USB_BUS(usb_bus), "usb-kbd");
+        usb_create_simple(USB_BUS(usb_bus), "usb-tablet");
     }
 
     pci_init_nic_devices(pci_bus, mc->default_nic);
-- 
2.43.0


