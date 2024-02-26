Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92439C5478C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 22:00:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rej0P-0004p8-P1; Mon, 26 Feb 2024 16:59:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rej0O-0004oJ-J8
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 16:59:24 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rej0M-0007h1-4r
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 16:59:23 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-41241f64c6bso28374365e9.0
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 13:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708984759; x=1709589559; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3YYRUkefd8YL5Lg3wVrT05FHUF/ngn4lf4vkoMHN3l4=;
 b=FUzWcOvNjtR0QAAbcJfpVVQM3ezEczjXxkcSY0AxcekVxXjq4clvCdoxDk26ThtiKm
 5OxNXPUE8p/FOt0FDhzEGLMWskEgpFGd75tBd5wjodwMeFqmXYN3JuJiORMzM0/2op3W
 nKhxyI9gUmg3e/oCnRPhFPVe/d+Jh0lE+lf9SAt/dR+NB+enMu7LmiTYR2Ql0BZSeIzr
 w7OhIyBVNz4ZmCpQK/uFmuwrvVy1OyfEmi31nEFpbc0pIUTYNHrhxBGLpg5hdBv20pQ6
 xXF6oc7zmo70uC2PVAruQSUJdWdx4lPi0kdN9PU+Jq3W6rIeiVxce3d0J2qO1g2H1Ddi
 QRtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708984759; x=1709589559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3YYRUkefd8YL5Lg3wVrT05FHUF/ngn4lf4vkoMHN3l4=;
 b=Ztz9TA4VJaXDcB4HV9tdF1DatidNQULLuzXIXM2MVONkvdU2YcHx/3DSg4H5jFmMxJ
 s52j4KDpb/w8W6rqTKCT6a3kymxwJjWMw469pECzOMXJ0c0EJTazuywYUqdrCMEEi03r
 YK37dVqd5rh1M9W4sU38vt1dzEUDPsjWN7uBUZ31ztN2C0QWPy+YFsKiKzFNBachUHjE
 7vOTZzWuj1fyarcaFM5tk6zuZ0tFpEU6fXUUTaktdkEZ3ysrAkCCkaJ/8XcjSxi3YfyN
 LOADTjlPmaQ8VStqbH+LULlT2iP0BZMOuRXVUDtPGDkMYlxvSxcNYHhO1CFl8pL/iHiI
 nTew==
X-Gm-Message-State: AOJu0YySyOm6esPjNen2KUpwUs8Qr1dvcdgl7aOkuQE4wbiLf5FLqJmH
 WuaXNuEGK4A7xkKf/n4coRg4SamTg7ppJl9tKX7KbRZKkBd66YmPMqhQozzf
X-Google-Smtp-Source: AGHT+IHUe2zMYyrHVEKmMKgh3HAg6L05m+JxACtac3xclKzSE9tZJokMxjvR7R2Et6pNzoIiqfFBJw==
X-Received: by 2002:a05:6000:2aa:b0:33d:4978:6e37 with SMTP id
 l10-20020a05600002aa00b0033d49786e37mr7662757wry.71.1708984758844; 
 Mon, 26 Feb 2024 13:59:18 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-077-188-008-186.77.188.pool.telefonica.de. [77.188.8.186])
 by smtp.gmail.com with ESMTPSA id
 h4-20020a05600016c400b0033dda0e82e5sm3985753wrf.32.2024.02.26.13.59.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 13:59:17 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
Subject: [PATCH 2/2] Revert "hw/i386/pc: Confine system flash handling to
 pc_sysfw"
Date: Mon, 26 Feb 2024 22:59:09 +0100
Message-ID: <20240226215909.30884-3-shentey@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240226215909.30884-1-shentey@gmail.com>
References: <20240226215909.30884-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x329.google.com
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

Specifying the property `-M pflash0` results in a regression:
  qemu-system-x86_64: Property 'pc-q35-9.0-machine.pflash0' not found
Revert the change for now until a solution is found.

This reverts commit 6f6ad2b24582593d8feb00434ce2396840666227.

Reported-by: Volker Rümelin <vr_qemu@t-online.de>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/i386/pc.h | 2 ++
 hw/i386/pc.c         | 1 +
 hw/i386/pc_piix.c    | 1 +
 hw/i386/pc_sysfw.c   | 6 ++----
 4 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index e88468131a..0f9c1a45fc 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -191,6 +191,8 @@ void pc_i8259_create(ISABus *isa_bus, qemu_irq *i8259_irqs);
 #define TYPE_PORT92 "port92"
 
 /* pc_sysfw.c */
+void pc_system_flash_create(PCMachineState *pcms);
+void pc_system_flash_cleanup_unused(PCMachineState *pcms);
 void pc_system_firmware_init(PCMachineState *pcms, MemoryRegion *rom_memory);
 bool pc_system_ovmf_table_find(const char *entry, uint8_t **data,
                                int *data_len);
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index f8eb684a49..2ad8de5097 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1733,6 +1733,7 @@ static void pc_machine_initfn(Object *obj)
 #endif
     pcms->default_bus_bypass_iommu = false;
 
+    pc_system_flash_create(pcms);
     pcms->pcspk = isa_new(TYPE_PC_SPEAKER);
     object_property_add_alias(OBJECT(pcms), "pcspk-audiodev",
                               OBJECT(pcms->pcspk), "audiodev");
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index ec7c07b362..34203927e1 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -231,6 +231,7 @@ static void pc_init1(MachineState *machine,
         assert(machine->ram_size == x86ms->below_4g_mem_size +
                                     x86ms->above_4g_mem_size);
 
+        pc_system_flash_cleanup_unused(pcms);
         if (machine->kernel_filename != NULL) {
             /* For xen HVM direct kernel boot, load linux here */
             xen_load_linux(pcms);
diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index b9c1eb352d..3efabbbab2 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -91,7 +91,7 @@ static PFlashCFI01 *pc_pflash_create(PCMachineState *pcms,
     return PFLASH_CFI01(dev);
 }
 
-static void pc_system_flash_create(PCMachineState *pcms)
+void pc_system_flash_create(PCMachineState *pcms)
 {
     PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
 
@@ -103,7 +103,7 @@ static void pc_system_flash_create(PCMachineState *pcms)
     }
 }
 
-static void pc_system_flash_cleanup_unused(PCMachineState *pcms)
+void pc_system_flash_cleanup_unused(PCMachineState *pcms)
 {
     char *prop_name;
     int i;
@@ -210,8 +210,6 @@ void pc_system_firmware_init(PCMachineState *pcms,
         return;
     }
 
-    pc_system_flash_create(pcms);
-
     /* Map legacy -drive if=pflash to machine properties */
     for (i = 0; i < ARRAY_SIZE(pcms->flash); i++) {
         pflash_cfi01_legacy_drive(pcms->flash[i],
-- 
2.44.0


