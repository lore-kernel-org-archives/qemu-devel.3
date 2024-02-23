Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C144C54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 12:44:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdUv5-00010H-Fx; Fri, 23 Feb 2024 07:44:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rdUud-0000fn-DD
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 07:44:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rdUub-0003tc-UP
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 07:44:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708692261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HLIJwMQykn2L6I9vYNiaAjV57GAq+AzK2swjE7KZHkg=;
 b=MIbTTm1fSBbR/kDwyuofhjcvE8nk3UYFZ9Bgu9tAVWQsd9JsZuS8ban8AELZdr8TMHjNyc
 YjxiF2yCqyJP2SjEnFdMtZOiYU4DahX3jZJtTaZNQQ5Oh6BDi3mgT+zPI00ECWygBAwnFn
 VPijL9LI8N8GgDHNKXt+DP4Twhlx7h8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-NTp9x-weN2OUN-8E-QgVZg-1; Fri, 23 Feb 2024 07:44:19 -0500
X-MC-Unique: NTp9x-weN2OUN-8E-QgVZg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-33d4c09ec04so458203f8f.0
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 04:44:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708692257; x=1709297057;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HLIJwMQykn2L6I9vYNiaAjV57GAq+AzK2swjE7KZHkg=;
 b=GdAGBcQX1jqQ5rNeAPj6SfpgI+5J6aD5PKAsxDHdNGMJIs8br0FcvDVcuPolH82idd
 ymTqMzCDmdNMcTCq1RqMpqLIfSPJirOOr49FN8dXDePi74gpMdGEXTghzGeC0jMfTuU0
 n4edGmHiAM5Vj2AkwHs57D4x2SCUmads5jaBM3jRDo236owI4oeS/ZssSvDkZLQN/Mqz
 g3ibJnA3xbyOhiDTOfN3P3SjzKpIUbrj8LQZpk1UoKEoLntTRIcyHm0oUUy3qK5DCINp
 3DkNtLrlSP/rwSkyaCHUd1GCVWO7qSnNLbESbX4Q005334I4c4YJ8Whnl1CAum+i5FtL
 QlPg==
X-Gm-Message-State: AOJu0YyZDtCAmjk8aScrjNODn7QsI7a3v5JaqFj2lCKEJV9FrY4o8dnB
 rV+4uS/xHg2INwEV40ck1WUW9Sa9nPCcbyPtIZhz1iuqc89j7np5tOBhSaURegS/9zidYX9C+sB
 q2F5fC3w4fKHFUn+PzjodEUXWjx8I0EuJhgVJ3tgddSceHth8AUXBnhfMF1Ev+G75+Y1/7gZB9f
 eW5+albk+fsPwV6mVhW3TEHiUomaDgmi8cPfrP
X-Received: by 2002:a5d:4a06:0:b0:33d:47c4:fbb3 with SMTP id
 m6-20020a5d4a06000000b0033d47c4fbb3mr1339305wrq.65.1708692257233; 
 Fri, 23 Feb 2024 04:44:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGdaEFF2W0YaTJSSFxp5TPBI1+zxYk7W2YedWW5RAii4ZqSkh0c8QaceJU1gD+loMluipTxjg==
X-Received: by 2002:a5d:4a06:0:b0:33d:47c4:fbb3 with SMTP id
 m6-20020a5d4a06000000b0033d47c4fbb3mr1339291wrq.65.1708692256897; 
 Fri, 23 Feb 2024 04:44:16 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 ay16-20020a5d6f10000000b0033da4f601c9sm2650332wrb.55.2024.02.23.04.44.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Feb 2024 04:44:14 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	balaton@eik.bme.hu
Subject: [PATCH 03/10] sh4: r2d: do not use usb_bus_find()
Date: Fri, 23 Feb 2024 13:43:59 +0100
Message-ID: <20240223124406.234509-4-pbonzini@redhat.com>
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

usb_bus_find() is always used with argument -1; it can be replaced with
a search of the single USB bus on the machine.

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/sh4/r2d.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index c73e8f49b8a..4d34ad00d93 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -244,6 +244,7 @@ static void r2d_init(MachineState *machine)
     SysBusDevice *busdev;
     MemoryRegion *address_space_mem = get_system_memory();
     PCIBus *pci_bus;
+    USBBus *usb_bus;
 
     cpu = SUPERH_CPU(cpu_create(machine->cpu_type));
     env = &cpu->env;
@@ -312,7 +313,8 @@ static void r2d_init(MachineState *machine)
     pci_init_nic_devices(pci_bus, mc->default_nic);
 
     /* USB keyboard */
-    usb_create_simple(usb_bus_find(-1), "usb-kbd");
+    usb_bus = USB_BUS(object_resolve_type_unambiguous(TYPE_USB_BUS, &error_abort));
+    usb_create_simple(usb_bus, "usb-kbd");
 
     /* Todo: register on board registers */
     memset(&boot_params, 0, sizeof(boot_params));
-- 
2.43.0


