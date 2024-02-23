Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19876C5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 12:45:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdUv3-00010A-S7; Fri, 23 Feb 2024 07:44:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rdUuh-0000hZ-DA
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 07:44:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rdUuf-0003tu-RB
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 07:44:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708692264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PbisCKnnZebt0o4X5xYHZ/NyWPkyeznjN5JGV4Gvo+s=;
 b=LJeqnH/62tYGdrZmz9u6NykD4jvRFWcXq3ukqVEq96t54BF8fyUH8233zhorLOcbLhwsF7
 5mtzf5blxQPnqlbwh5eVTFoRt77PoZib8PVtu3kC9YRlYQb8o0Hvk5Fay12fB6mcHNf55W
 0/gjOaY7BskdzfhS3sgzdTUWdoNeroU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-eGiuqqP3OZygJLI8_5hs3w-1; Fri, 23 Feb 2024 07:44:23 -0500
X-MC-Unique: eGiuqqP3OZygJLI8_5hs3w-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-33d782add49so293081f8f.2
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 04:44:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708692260; x=1709297060;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PbisCKnnZebt0o4X5xYHZ/NyWPkyeznjN5JGV4Gvo+s=;
 b=GYdlJwiYzYtK6x8HPuH3ty6vGGRvmKJfQjM8UYQy+FEIfidb2PH3B4PaDO3vHo0qn1
 Pts9D309ihvHcc+3AUEp7APBrs+otB7boBkgSXUTzXrdnSMuItAkNkvBHxZNNtRW54hr
 Mpe7ykkYCXbcA7twYtqCe436GWnS3H/2lJtnU7ksJNQ7J28w19jNOltEf2XINIiMiYM5
 PGMAAxmcdx190ZHlfqWHqVFzO/xUmN8ixDhXIxpXe+2NQbLxmp4B/09DAeUFEeK0bGA2
 ghpNCVvBjbYLS9mmpMehN15I/t6pB94GapYG6GZIqKP+5JwAJR/3BNHUih3dSBAtpcuE
 PkZg==
X-Gm-Message-State: AOJu0YxjFGR84cGVthG5Ee10UDbKTXa1yVPZe5zl0zyJlFBT0pADMcDr
 AfURaH1SICqHdfsFXfCGUkwoHU9mchRCXt1gICTauKXOvk1VUOTgUgoUwJtobIh0smSKqeIv+Fv
 eVqLsRUeXthS6VAKE+qSlBgh+4o6nbffuEZ5K6VI6GpVemM/qlcBS8WfNFE8FxrJEw57wXkemAt
 UFNoXUeB+SHj0nMAwpBlmNohCetUiq7Jw4dWYM
X-Received: by 2002:a5d:68c8:0:b0:33d:1352:3dcc with SMTP id
 p8-20020a5d68c8000000b0033d13523dccmr1240310wrw.35.1708692260367; 
 Fri, 23 Feb 2024 04:44:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGe0d0tPctkR+DgQEeWJbMgH4kW86kTsKvAX+QsatP6gJjyf59gAyAK/xMtkdqIy5PR5r7Kwg==
X-Received: by 2002:a5d:68c8:0:b0:33d:1352:3dcc with SMTP id
 p8-20020a5d68c8000000b0033d13523dccmr1240298wrw.35.1708692260046; 
 Fri, 23 Feb 2024 04:44:20 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 co22-20020a0560000a1600b0033db0c866f7sm982711wrb.11.2024.02.23.04.44.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Feb 2024 04:44:17 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	balaton@eik.bme.hu
Subject: [PATCH 04/10] mips/loongson3_virt: do not require CONFIG_USB
Date: Fri, 23 Feb 2024 13:44:00 +0100
Message-ID: <20240223124406.234509-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240223124406.234509-1-pbonzini@redhat.com>
References: <20240223124406.234509-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.066,
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
index caedde2df00..b2a8b22b4ea 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -447,8 +447,9 @@ static inline void loongson3_virt_devices_init(MachineState *machine,
 
     if (defaults_enabled() && object_class_by_name("pci-ohci")) {
         pci_create_simple(pci_bus, -1, "pci-ohci");
-        usb_create_simple(usb_bus_find(-1), "usb-kbd");
-        usb_create_simple(usb_bus_find(-1), "usb-tablet");
+        Object *usb_bus = object_resolve_type_unambiguous(TYPE_USB_BUS, &error_abort);
+        usb_create_simple(USB_BUS(usb_bus), "usb-kbd");
+        usb_create_simple(USB_BUS(usb_bus), "usb-tablet");
     }
 
     pci_init_nic_devices(pci_bus, mc->default_nic);
-- 
2.43.0


