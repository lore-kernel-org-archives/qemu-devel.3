Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7935C54E66
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 22:34:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkAbs-0002i5-Vl; Tue, 12 Mar 2024 18:28:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAbl-0002KV-EN
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:28:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAbj-0004Y8-Tz
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:28:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710282507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HRYAFmiIOZoNHp71a+p+TPZ7pg4hnnbXtufAOJw7DWA=;
 b=XU/2vra1PWQSHPur1xTVrnYq19RsDQjGYCF9ZClR3ib98GvK3cyha6DPysRACxtZO64hxk
 aVn546Jec/KX+GU6ZPN9SaYHjhPx6Yyw8n1CcLrw813sN+dRKj2sKhD52qENJnrO9qErGG
 D9QJkdUSyeBToAUpM28Kg0ngIUZQsCw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168--rx-xyUmMmatqjUSnaJXbg-1; Tue, 12 Mar 2024 18:28:26 -0400
X-MC-Unique: -rx-xyUmMmatqjUSnaJXbg-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a4489805a2dso176750166b.2
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 15:28:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710282504; x=1710887304;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HRYAFmiIOZoNHp71a+p+TPZ7pg4hnnbXtufAOJw7DWA=;
 b=Rc5I9oqncetp2qwoP3RPZKzJZ3onycVdZb7fL4Ch37tGuvsWHGiqmvPJxRrV4vfP3T
 RSQSJ9OC2SPMITqo17CnKrQ7feUN357mKHfTVo3mrF7Dc7ss3vyNZ7gVmSoxD6/Vk48F
 IU4mvOl7h6G9SOP/4mSpHPDcHlv0emR+64+WCuLSbJGz0K/xVsk9mDNIvYbOHCXlwFRC
 xHXEokk/kKJ+6hC9gafnc6k8SIOQhz9r9YT0XZ6ErBT4EgK72xNe/0scZhN8G0cqX8Ew
 5dUEicIli9kb4iQdcegQztG7MriEvOveulLUOOwKwbxPIcY4BEwYW9czUXz9IiYFDB+b
 L7lg==
X-Gm-Message-State: AOJu0Yz4HZahX1/YhUjRxtiuB6cYOPyLgRZulhueO+NZahddPNjmNBD0
 Sd9bTViplaoBJmJKXiyPbSK+wVTjMoL4MIPwjzSaPe2H39/Uf1QqEZqQzQsLEfwLAmrPfa9S29g
 YfG1C3D/3HgYtEoO3sRtYmr+tVedU5esEVH1dYDQXTmWTRfnJ0jidLqQvLUVEIVK9l8C8CzV89h
 nj1WDTniqT7e2bT34O7GUuAuWvZ72LaiXv
X-Received: by 2002:a17:907:cbc1:b0:a45:a3e9:debd with SMTP id
 vk1-20020a170907cbc100b00a45a3e9debdmr8213828ejc.59.1710282504462; 
 Tue, 12 Mar 2024 15:28:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAvwH57dOUxhey4nr9xzfL0gG/qe5PxWH+ERvbPuSEkol8XBL1gj4Napla/sPHr1tplaMDpw==
X-Received: by 2002:a17:907:cbc1:b0:a45:a3e9:debd with SMTP id
 vk1-20020a170907cbc100b00a45a3e9debdmr8213810ejc.59.1710282503982; 
 Tue, 12 Mar 2024 15:28:23 -0700 (PDT)
Received: from redhat.com ([2.52.134.16]) by smtp.gmail.com with ESMTPSA id
 jo11-20020a170906f6cb00b00a46522c38c4sm200844ejb.207.2024.03.12.15.28.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 15:28:23 -0700 (PDT)
Date: Tue, 12 Mar 2024 18:28:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 53/68] hw/i386/pc: Inline pc_cmos_init() into
 pc_cmos_init_late() and remove it
Message-ID: <7d12305ec8c3fa8c60b39aae0d952245a62696d4.1710282274.git.mst@redhat.com>
References: <cover.1710282274.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Now that pc_cmos_init() doesn't populate the X86MachineState::rtc attribute any
longer, its duties can be merged into pc_cmos_init_late() which is called within
machine_done notifier. This frees pc_piix and pc_q35 from explicit CMOS
initialization.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-Id: <20240303185332.1408-5-shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/i386/pc.h |  2 --
 hw/i386/pc.c         | 10 ----------
 hw/i386/pc_piix.c    |  2 --
 hw/i386/pc_q35.c     |  2 --
 4 files changed, 16 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 8458487a5e..27a68071d7 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -178,8 +178,6 @@ void pc_basic_device_init(struct PCMachineState *pcms,
                           ISADevice *rtc_state,
                           bool create_fdctrl,
                           uint32_t hpet_irqs);
-void pc_cmos_init(PCMachineState *pcms,
-                  ISADevice *s);
 void pc_nic_init(PCMachineClass *pcmc, ISABus *isa_bus, PCIBus *pci_bus);
 
 void pc_i8259_create(ISABus *isa_bus, qemu_irq *i8259_irqs);
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index c614697ca6..1590352bb5 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -570,14 +570,6 @@ static void pc_cmos_init_late(PCMachineState *pcms)
     mc146818rtc_set_cmos_data(s, 0x39, val);
 
     pc_cmos_init_floppy(s, pc_find_fdc0());
-}
-
-void pc_cmos_init(PCMachineState *pcms,
-                  ISADevice *rtc)
-{
-    int val;
-    X86MachineState *x86ms = X86_MACHINE(pcms);
-    MC146818RtcState *s = MC146818_RTC(rtc);
 
     /* various important CMOS locations needed by PC/Bochs bios */
 
@@ -618,8 +610,6 @@ void pc_cmos_init(PCMachineState *pcms,
     val |= 0x02; /* FPU is there */
     val |= 0x04; /* PS/2 mouse installed */
     mc146818rtc_set_cmos_data(s, REG_EQUIPMENT_BYTE, val);
-
-    /* hard drives and FDC are handled by pc_cmos_init_late() */
 }
 
 static void handle_a20_line_change(void *opaque, int irq, int level)
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 9dd9f5562e..c9a6c0aa68 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -344,8 +344,6 @@ static void pc_init1(MachineState *machine, const char *pci_type)
     }
 #endif
 
-    pc_cmos_init(pcms, x86ms->rtc);
-
     if (piix4_pm) {
         smi_irq = qemu_allocate_irq(pc_acpi_smi_interrupt, first_cpu, 0);
 
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index df63a92b78..1356c5d107 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -311,8 +311,6 @@ static void pc_q35_init(MachineState *machine)
         smbus_eeprom_init(pcms->smbus, 8, NULL, 0);
     }
 
-    pc_cmos_init(pcms, x86ms->rtc);
-
     /* the rest devices to which pci devfn is automatically assigned */
     pc_vga_init(isa_bus, pcms->pcibus);
     pc_nic_init(pcmc, isa_bus, pcms->pcibus);
-- 
MST


