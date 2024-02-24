Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D05ECC5478C
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Feb 2024 14:01:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdsYj-0004EC-GL; Sat, 24 Feb 2024 08:59:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rdsYc-0004Ah-To
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 08:59:14 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rdsYb-0002m0-13
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 08:59:14 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3392b045e0aso1314160f8f.2
 for <qemu-devel@nongnu.org>; Sat, 24 Feb 2024 05:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708783150; x=1709387950; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eSTZZKZJd9onOmZuoGSDc/R40/Oc/o39d6sBD3S+k2A=;
 b=CHvu3BXfpqhjcQLQTbwVgi4PFE2MjqMymbfnfNPZtjXlGa3cUtzn10B9nhp6WS3Bou
 TRBuUi0hL5rarL6wCjPzV1uhRNSTeWyHCSao0OF2YaVP5TbhdI6/9kxkv+BhvcruGOyW
 J6VACOnLRsQZrasrkXAJqlQR64ZxalsDcBdwg5VHvtHqHvcanWLIkj7AwRb/842/KKkc
 cslfi9Ch8ngvSKI/s1VCAzt1xO+cr3jIxZobx4a23miLpoHZY3ceebdP9La3Xh0j6vhI
 UmCMYdtdCSC0RS6eO5wvxivBXnMa5oE5QKBuTSvvqtDkBBGQaKobUYZXtqFAj/tN64dA
 QOdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708783150; x=1709387950;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eSTZZKZJd9onOmZuoGSDc/R40/Oc/o39d6sBD3S+k2A=;
 b=hOQ4e/UbWF3QpKEUZMy+6D3YGBuoRUEeADbLAS2I2KnT5eH0n8LcHSwZYfow7+8CVY
 HOfwa8OBSrKD/OgvWXUmxY3bzkQ5c1fSsV1fKwDfZSV8j/vLoklWgHoVvcBnubT4nXnW
 CPQeTe/QrbIDtL33iH4cDUkqsNlWN3efHSyu+5favxDbbcJ6N5LOnsCxDk2/wnLHSBJo
 QvGrNS0d8jjkl3IAyYfguHsHR62m3NANloCOX2HRIkDyyEbVgdxfx+XWf2RDPGL4ZX/E
 +0tmpivMfM60fI+GskJPP15Kxby9MkRIphVM4TnD9yn6oMHSjDiiAt6YxmFZ7ngnk0rw
 SOpA==
X-Gm-Message-State: AOJu0Yy9i1HkLpP8kPWKNFFFjjS03beuGXhxCe958+HpC3AVRDSD2oTc
 Zguv+bZoJCrkVLzRqq331xT8PmbHRIJUWhOlk5fw/wUeXUgMSkWmaydOoPGf
X-Google-Smtp-Source: AGHT+IEDelizaLxsH9REnnjXKRVT9AC2w8qLDghH4sPV9ZmjXoSfpnCJTRYYrXhArVbpLG1ofC0UCw==
X-Received: by 2002:a5d:6743:0:b0:33c:f9d6:fb20 with SMTP id
 l3-20020a5d6743000000b0033cf9d6fb20mr1849577wrw.45.1708783150577; 
 Sat, 24 Feb 2024 05:59:10 -0800 (PST)
Received: from archlinux.. (dynamic-089-012-138-060.89.12.pool.telefonica.de.
 [89.12.138.60]) by smtp.gmail.com with ESMTPSA id
 n8-20020a056000170800b0033d817eddd3sm2285542wrc.13.2024.02.24.05.59.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Feb 2024 05:59:09 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Paul Durrant <paul@xen.org>,
 Igor Mammedov <imammedo@redhat.com>, Jason Wang <jasowang@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>, Sergio Lopez <slp@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 6/6] hw/i386/pc: Inline pc_cmos_init() into
 pc_cmos_init_late() and remove it
Date: Sat, 24 Feb 2024 14:58:51 +0100
Message-ID: <20240224135851.100361-7-shentey@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240224135851.100361-1-shentey@gmail.com>
References: <20240224135851.100361-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Now that pc_cmos_init() doesn't populate the X86MachineState::rtc attribute any
longer, its duties can be merged into pc_cmos_init_late() which is called within
machine_done notifier. This frees pc_piix and pc_q35 from explicit CMOS
initialization.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/i386/pc.h |  2 --
 hw/i386/pc.c         | 10 ----------
 hw/i386/pc_piix.c    |  2 --
 hw/i386/pc_q35.c     |  2 --
 4 files changed, 16 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 4bb1899602..2b7c53d619 100644
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
index 880e95de26..fad4c54512 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -567,14 +567,6 @@ static void pc_cmos_init_late(PCMachineState *pcms)
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
 
@@ -617,8 +609,6 @@ void pc_cmos_init(PCMachineState *pcms,
     val |= 0x02; /* FPU is there */
     val |= 0x04; /* PS/2 mouse installed */
     mc146818rtc_set_cmos_data(s, REG_EQUIPMENT_BYTE, val);
-
-    /* hard drives and FDC are handled by pc_cmos_init_late() */
 }
 
 static void handle_a20_line_change(void *opaque, int irq, int level)
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index ce6aad758d..637f4d38be 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -342,8 +342,6 @@ static void pc_init1(MachineState *machine,
     }
 #endif
 
-    pc_cmos_init(pcms, x86ms->rtc);
-
     if (piix4_pm) {
         smi_irq = qemu_allocate_irq(pc_acpi_smi_interrupt, first_cpu, 0);
 
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index e0b3f55a02..df0a5f934c 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -310,8 +310,6 @@ static void pc_q35_init(MachineState *machine)
         smbus_eeprom_init(pcms->smbus, 8, NULL, 0);
     }
 
-    pc_cmos_init(pcms, x86ms->rtc);
-
     /* the rest devices to which pci devfn is automatically assigned */
     pc_vga_init(isa_bus, pcms->pcibus);
     pc_nic_init(pcmc, isa_bus, pcms->pcibus);
-- 
2.44.0


