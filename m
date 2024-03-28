Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C57C9CD1284
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 16:01:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rps6I-0001uL-Lx; Thu, 28 Mar 2024 11:55:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rps6E-0001dE-4H
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:55:31 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rps6C-00028G-K1
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:55:29 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5688eaf1165so1560004a12.1
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 08:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711641327; x=1712246127; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6t/11DBdsC4+Se7Vaykag7BJymn7PIzchj3B9U9dVz4=;
 b=m1TOQnBCfg32QxJAem8LWUqmGFVed53ttCwNU1MG3lXrPgjFijU57C7dxp5AO24MPy
 OAxDYF0nFs9xDWYUwbcTYXNZF88NTPkqlO2K/7TV5N28NGHjxw9hZZ1BeA+3uQZ4HtKP
 KG9FdQEgXPJeJC4OH7wxjhGfVHSY6dPfoYeTX1zK/hYsYf3rguD5oQ84mFOFmgHdg6tF
 kWkHN/1cUFV8E4GgoOsQckBiZkn9QDyVzFr3aEyLRlmN351PeSNs9Zj4tl2OuhGPsPo+
 t4nUfZoiaFLxMl1XAKKuvcWIO+1YZIqRexOUsrbeqPk5QonTnW5jKEf9MxcNzk5cAX9e
 vXvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711641327; x=1712246127;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6t/11DBdsC4+Se7Vaykag7BJymn7PIzchj3B9U9dVz4=;
 b=HIlNYUjQ36I95g4jjqWbhAGIEumG/v1YqBVKgTOCR+FAj91laUL5KbCH5XlOe6drkv
 Dd1uylpjw6rDZOx1xKwN13txVlJo64bWXYk1JTN6bNICkRNi0rpLRMY+WCWQW1Gkq3r0
 GtswEpu7y0tejGoXudjq4y7Vag4cUWA/CrLKqQPHr+dUBhiHNd3C54gVUHiXqsmH8p+K
 UMnMyymX1BqIy+6awMWD/Gu3yiM1Qk/ozO7ST2yVC6DZrBLnsIEtzquYCuHCNUg06Nqp
 aMJUfSc7tIxGen78CQDwtK/adEB+WWCCySId4YG21Kf1C9mzAzZwTa93tJLveEn/MCyz
 McWw==
X-Gm-Message-State: AOJu0Yxa6OkD5KqDTdR/eUF0lZ61o1pLhLomz+gs6X75g2JxESDWH/Dm
 H6PsGV9795aiFWG/jyE82/nu+bamu5EI2MHN3grr9Tjh5xEIJtULfxD+kDkN1D4olViyyeMNQYB
 e
X-Google-Smtp-Source: AGHT+IGa5cOf+IgzGIenKqeTpz5Pqe+oCRGklHarD29ZvICujPU9lddIF/mJjLz/l0UjTGpZalGbwQ==
X-Received: by 2002:a50:9e64:0:b0:56b:900b:a2e with SMTP id
 z91-20020a509e64000000b0056b900b0a2emr2672032ede.32.1711641326922; 
 Thu, 28 Mar 2024 08:55:26 -0700 (PDT)
Received: from m1x-phil.lan (pas38-h02-176-184-5-52.dsl.sta.abo.bbox.fr.
 [176.184.5.52]) by smtp.gmail.com with ESMTPSA id
 k7-20020aa7c047000000b0056c443ce781sm968470edo.85.2024.03.28.08.55.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 28 Mar 2024 08:55:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Stefano Stabellini <sstabellini@kernel.org>,
 xen-devel@lists.xenproject.org, Bernhard Beschow <shentey@gmail.com>,
 Thomas Huth <thuth@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH-for-9.1 07/29] hw/i386/pc: Call
 fw_cfg_add_extra_pci_roots() in pc_pci_machine_done()
Date: Thu, 28 Mar 2024 16:54:15 +0100
Message-ID: <20240328155439.58719-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240328155439.58719-1-philmd@linaro.org>
References: <20240328155439.58719-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

fw_cfg_add_extra_pci_roots() expects a PCI bus, which only
PCI-based machines have. No need to call it on the ISA-only
machine. Move it to the PCI-specific machine_done handler.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index a16bb1554c..f9226f7115 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -608,8 +608,6 @@ void pc_machine_done(Notifier *notifier, void *data)
     /* set the number of CPUs */
     x86_rtc_set_cpus_count(x86ms->rtc, x86ms->boot_cpus);
 
-    fw_cfg_add_extra_pci_roots(pcms->pcibus, x86ms->fw_cfg);
-
     acpi_setup();
     if (x86ms->fw_cfg) {
         fw_cfg_build_smbios(pcms, x86ms->fw_cfg, pcms->smbios_entry_point_type);
@@ -623,6 +621,12 @@ void pc_machine_done(Notifier *notifier, void *data)
 
 static void pc_pci_machine_done(Notifier *notifier, void *data)
 {
+    PcPciMachineState *ppms = container_of(notifier,
+                                           PcPciMachineState, machine_done);
+    PCMachineState *pcms = PC_MACHINE(ppms);
+    X86MachineState *x86ms = X86_MACHINE(pcms);
+
+    fw_cfg_add_extra_pci_roots(pcms->pcibus, x86ms->fw_cfg);
 }
 
 /* setup pci memory address space mapping into system address space */
-- 
2.41.0


