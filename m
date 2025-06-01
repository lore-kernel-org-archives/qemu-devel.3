Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E793C54FB3
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Jun 2025 15:29:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLkaN-0004Gp-0l; Sun, 01 Jun 2025 11:26:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uLkZj-0003TY-8u
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 11:26:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uLkZh-0004ho-GL
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 11:26:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748791572;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4TjJ1BjUENeOU9LZAYs1WRacDJvsrt+ES/22xQa6J1E=;
 b=h44AnyVLZnxQ3Me55VdwjENr4F+nSJr1k3XpyphuszMc7m4j/JDUIfmOEvhxG/ACEUtW6b
 xuEMqMRXSIsOQf6D0lP5/JT3I43yaWlKzDY8UoSBvjUfIECBEQDGTDJosuud3DpScn/UBI
 9/2yz9KPU2IBCh4OhHs+sFFid7at4i8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-sa57sDyGPrmro-2dBqdIpw-1; Sun, 01 Jun 2025 11:26:10 -0400
X-MC-Unique: sa57sDyGPrmro-2dBqdIpw-1
X-Mimecast-MFC-AGG-ID: sa57sDyGPrmro-2dBqdIpw_1748791569
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a4f6e0c285so1597975f8f.0
 for <qemu-devel@nongnu.org>; Sun, 01 Jun 2025 08:26:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748791569; x=1749396369;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4TjJ1BjUENeOU9LZAYs1WRacDJvsrt+ES/22xQa6J1E=;
 b=Auso8JQZH6+ZZAGYTttbk2TJe3dLR/WHoXab6q6G8ow/a5/oa89DsrscItgcvBrjy4
 Ks7RblB4KnllUiunoMC5vznjQ8q7LmJG0xStlPLwMUVZfAYILTUGapugZ8HGbXxg09AR
 W1mx/3CV880IVlr4pEr663eBk5h2ljpB2eFcPAH2Up5qqEx9ygGE5LppY9ZNtJpZQmtJ
 jWHTuwRSzkdHCOB/sVFJyUWSbC09m6Y4I8OkOAAKMAd0LLCeIt7D0HoGCedmL9MxQYP0
 tZmZ4aSq/o7QyfCdTGkq5ILoI+gBnB3Xz0zhiwi3L7YkEPqu7FtGkDfQy1XA5Uv9wX8/
 nnqg==
X-Gm-Message-State: AOJu0Ywq4stDjWHiLE5R7wuuNl23za6UHkOZLnoOhapyjkmRyQruLLli
 cBt0LJPJzZjiPu4enrHkn/JxDhKx3IXAXtwNDyi53B3PHcaO8R5nHjy2LXKP5NeoRHaAva0+cqs
 2gJNbJpm9gy4o+5dRQo6U/73Uk23pktpSH4Oq5vIHIjzhLfZZHE4Z0IuLOyz9hBkhQ1QDiO3IaV
 Qt+Ax/n3boclUM1eD1ICz4rN6mBPX2iiVt4w==
X-Gm-Gg: ASbGncuq40vo7zHvRobkd2YMVFMgaxL7ah3m3a0Vf37t/EKaImy3CkKvxlJjVK+VVb6
 ge/UFrBPH8O6hf0TxVuYcg5AgfSwF5lQwoyE94IQsZ2cej1eUsR0NKUy+D5gnmmKKn+QoUnZ9om
 fe3X6QIai3qNE4each5HAxKZnhDOqNrjOli615cemSV5gmUothZu46SfYTq+DpGSwmRn7gbASNz
 FyL39+H67EEqO3lF5dAn/tIYaYRMS+Ni3TQ9cikhR3FVqzXi1jcggn5HXjP6C8Ha50BBE636qXb
 xzZTkQ==
X-Received: by 2002:a05:6000:144e:b0:3a4:d6ed:8e2e with SMTP id
 ffacd0b85a97d-3a4fe395675mr4347568f8f.41.1748791568730; 
 Sun, 01 Jun 2025 08:26:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESnHibAtNr3A74JoQfn32vkr5JAQNcwmgVwhVqOkHIod5U8ozRD6lrXbgDHvT2OUuutzSV8A==
X-Received: by 2002:a05:6000:144e:b0:3a4:d6ed:8e2e with SMTP id
 ffacd0b85a97d-3a4fe395675mr4347547f8f.41.1748791568297; 
 Sun, 01 Jun 2025 08:26:08 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4f00a13fasm11894616f8f.98.2025.06.01.08.26.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Jun 2025 08:26:07 -0700 (PDT)
Date: Sun, 1 Jun 2025 11:26:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 31/31] hw/i386/pc_piix: Fix RTC ISA IRQ wiring of isapc machine
Message-ID: <1c5771c092742b729e2a640be184a0f48c0b2cdb.1748791463.git.mst@redhat.com>
References: <cover.1748791463.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1748791463.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.071,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Commit 56b1f50e3c10 ("hw/i386/pc: Wire RTC ISA IRQs in south bridges")
attempted to refactor RTC IRQ wiring which was previously done in
pc_basic_device_init() but forgot about the isapc machine. Fix this by
wiring in the code section dedicated exclusively to the isapc machine.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2961
Fixes: 56b1f50e3c10 ("hw/i386/pc: Wire RTC ISA IRQs in south bridges")
cc: qemu-stable
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>

Message-Id: <20250526203820.1853-1-shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/pc_piix.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 0dce512f18..6b6359ef65 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -285,6 +285,8 @@ static void pc_init1(MachineState *machine, const char *pci_type)
         pcms->idebus[0] = qdev_get_child_bus(dev, "ide.0");
         pcms->idebus[1] = qdev_get_child_bus(dev, "ide.1");
     } else {
+        uint32_t irq;
+
         isa_bus = isa_bus_new(NULL, system_memory, system_io,
                               &error_abort);
         isa_bus_register_input_irqs(isa_bus, x86ms->gsi);
@@ -292,6 +294,9 @@ static void pc_init1(MachineState *machine, const char *pci_type)
         x86ms->rtc = isa_new(TYPE_MC146818_RTC);
         qdev_prop_set_int32(DEVICE(x86ms->rtc), "base_year", 2000);
         isa_realize_and_unref(x86ms->rtc, isa_bus, &error_fatal);
+        irq = object_property_get_uint(OBJECT(x86ms->rtc), "irq",
+                                       &error_fatal);
+        isa_connect_gpio_out(ISA_DEVICE(x86ms->rtc), 0, irq);
 
         i8257_dma_init(OBJECT(machine), isa_bus, 0);
         pcms->hpet_enabled = false;
-- 
MST


