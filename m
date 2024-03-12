Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D218C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 22:39:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkAbt-0002k1-7q; Tue, 12 Mar 2024 18:28:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAbf-00022L-0y
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:28:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAbd-0004Xa-MG
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:28:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710282501;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Injg7cneMn8eAOXhLA6j7Wl6zrm7JF8+SWheD737+3s=;
 b=U7QXKRcCNxeenDkkzo/Hr1Qm1iMCWcj+oT/d+ueJ2lF1gs4lnVGp/KBX77vrI6IhCibFX9
 sXdZECZ9GS7phdq/li1kMFSnmpi73hL5f9KR3Tb8oa8Tub76v8h8kkgEhRdmY1VfsWiWVP
 7H8DPDwhZ/Zcc6YIJxVI/YPLWaaw9tI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-ZK5YOAZXObyIWWpTgoxdsg-1; Tue, 12 Mar 2024 18:28:19 -0400
X-MC-Unique: ZK5YOAZXObyIWWpTgoxdsg-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a4606018ec4so29845266b.0
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 15:28:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710282498; x=1710887298;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Injg7cneMn8eAOXhLA6j7Wl6zrm7JF8+SWheD737+3s=;
 b=eDAEPd+o/ssV4X/j4e+aBQ4+xzFgmMK4hEkgSj187MHZxQXqQ3qEjOF7WoLfzuL7FF
 RlZCNqh2FfTuCHa8zi6qG/+3U4OsnKVFXPbf1JlisxUO8iR4OAQNlJeFx50j38GJSGdM
 sw+XrL1X5PZBFqBHYLhKfjQxuCu4HGB1S0uBbXJF5DPFaH1ns+gsD+oP2lNL+y+S8KyW
 6ICHIIuLweEugYjDAC8BKRkFIzM6zIzJ8DSB34uT6OeGXMSa7Jzg1T8KGZGpFd307Abq
 YB26GfP/hsQm9OqgBztfYHbGcu5mhROo8+3LtUlj/MEdkw6xN09UWGfyMAKtIjCi6CnC
 lgGw==
X-Gm-Message-State: AOJu0YzfYRt3y6D8zoooBRFGIExicOiZyl59gRde/pzDeScmB/usp71F
 AaqyqFiAv2u3T8uQEgF1CPvEw6nqY3QXkbyz7T9yL3Ywxvo5Clg/I0MBBMXe8j7B4WPVRLWdpKS
 hcTm4gk62hPqtnCfox7MXALv4QGxkrkpZ0u3JVZrTzqNXW/9jQoH7FpiMDm1qTzVNVreRSAmHsl
 KLKyKDXYlZTlxahkKGhY1A77fpOOoYgSu0
X-Received: by 2002:a17:907:a809:b0:a45:b506:11ca with SMTP id
 vo9-20020a170907a80900b00a45b50611camr915489ejc.7.1710282498465; 
 Tue, 12 Mar 2024 15:28:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFn5JpY9eP8hcgxpEIzKW0ew9Upj7T/CVLDRTuNlcsmsXXOzuIc6kwHsMRmF06FI0QEQopj4g==
X-Received: by 2002:a17:907:a809:b0:a45:b506:11ca with SMTP id
 vo9-20020a170907a80900b00a45b50611camr915469ejc.7.1710282498042; 
 Tue, 12 Mar 2024 15:28:18 -0700 (PDT)
Received: from redhat.com ([2.52.134.16]) by smtp.gmail.com with ESMTPSA id
 v8-20020a1709067d8800b00a45aeaf9969sm4241375ejo.5.2024.03.12.15.28.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 15:28:17 -0700 (PDT)
Date: Tue, 12 Mar 2024 18:28:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 51/68] hw/i386/pc: Avoid one use of the current_machine global
Message-ID: <6605d09791df7387c3e82c9554731a752789987e.1710282274.git.mst@redhat.com>
References: <cover.1710282274.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1710282274.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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

From: Bernhard Beschow <shentey@gmail.com>

The RTC can be accessed through the X86 machine instance, so rather than passing
the RTC it's possible to pass the machine state instead. This avoids
pc_boot_set() from having to access the current_machine global.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-Id: <20240303185332.1408-3-shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 98bcf4d420..4077d8162c 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -425,9 +425,10 @@ static void set_boot_dev(PCMachineState *pcms, MC146818RtcState *s,
 
 static void pc_boot_set(void *opaque, const char *boot_device, Error **errp)
 {
-    PCMachineState *pcms = PC_MACHINE(current_machine);
+    PCMachineState *pcms = opaque;
+    X86MachineState *x86ms = X86_MACHINE(pcms);
 
-    set_boot_dev(pcms, opaque, boot_device, errp);
+    set_boot_dev(pcms, MC146818_RTC(x86ms->rtc), boot_device, errp);
 }
 
 static void pc_cmos_init_floppy(MC146818RtcState *rtc_state, ISADevice *floppy)
@@ -1252,7 +1253,7 @@ void pc_basic_device_init(struct PCMachineState *pcms,
     }
 #endif
 
-    qemu_register_boot_set(pc_boot_set, rtc_state);
+    qemu_register_boot_set(pc_boot_set, pcms);
 
     if (!xen_enabled() &&
         (x86ms->pit == ON_OFF_AUTO_AUTO || x86ms->pit == ON_OFF_AUTO_ON)) {
-- 
MST


