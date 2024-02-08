Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CD89C4829E
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 22:05:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYCV4-0007GR-7E; Thu, 08 Feb 2024 17:04:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rYCV2-0007FG-JE
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 17:04:04 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rYCV0-0005Dn-JW
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 17:04:04 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5600c43caddso400373a12.2
 for <qemu-devel@nongnu.org>; Thu, 08 Feb 2024 14:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707429841; x=1708034641; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eDgGO5XlvY/PWkEjL5h/oDmPieaVe3A51Df6gEqV1oQ=;
 b=ScAJwdCeAlVE2L+bwrdhf8HcQMb9yeOxJdwBORZk3goGnKJTUVFpGkDt/AL8Wj7wpr
 rFdFioQ3eTSlOXvcd9NkNNrA+oME8clcFoNslnIiTW+vUmHd9csr1QHZSjE4L15oUJz5
 rWpsx5KtF3UQZH5p89uqQY0LEOvsmttk3ZKU9TgkBpriLwWlPAeyTK1cJJVqODxbjDY2
 DYMcTtieOxfcmj8wPoCKR62pkrmbOVlgyDqpaQraeNvKbHnXwVZaTkWTnBE5JjA1UFGi
 JOjFPpqIfButUOTMcXBbHvwtIm3p6+EZNu6ADhZQiigRwRR5F8f2kuRsJkO5CdB+RIT6
 L3Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707429841; x=1708034641;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eDgGO5XlvY/PWkEjL5h/oDmPieaVe3A51Df6gEqV1oQ=;
 b=i8xUTNSudIK518mynQeA6hE2PugAVaxy/TvWaEQmZwCAbIK7LvdG7U3LzGPMhfkZsE
 V8jvz5DQaiKXJ2x60WQ5Mf2+284oyfnajLazg+nhqfX3omMa5XGlU7wASiXl4fC6ATKV
 zVsD9yOFmjn5MliUO16qjlLT7nn5p2JlSYTEcqFhxeDGYr7zpkS9MF4pc6E71ezXJYm2
 yYvJBWnw6p+3bANWrsxwed2GWbMuimcFLb/yQcJD4+UvgBqOVKZOdlymeqeO3Abm6qLN
 UURM9+QyQgHQhDc/9aWNXee7mk5sq6O0DVz/EI7y//cxRzazSQ4im3V3CeXJbTKchkr5
 NQ9Q==
X-Gm-Message-State: AOJu0YyTUdE9MuUH6FK3Hdh/1dEMlITro5IqvdUDgzGo9AsOdfa8JCE3
 VLHT/D8NQV4t9tvG3xDxsjCGNPx4FyNKpoyn0m6HhbJD7p9yzsYrm/RJ8ul6
X-Google-Smtp-Source: AGHT+IHI/kdOo0LEDtCo5dRoTOL3XaQbT2rQ9UH+MLCplGSd0WBActaQuqbImjNevZDeZGvMRkg7BQ==
X-Received: by 2002:a17:906:80ca:b0:a36:fc15:c6b2 with SMTP id
 a10-20020a17090680ca00b00a36fc15c6b2mr388409ejx.35.1707429840597; 
 Thu, 08 Feb 2024 14:04:00 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCU+UhKv+HDJlgJRBvuXodrKr9Zj7hyv0/SCgs5gCRA0tWW2D6F0HwkcOcuNXe+OjEVeULHaLQ4NG8tyQLDOY3Gc+ObQP7DEJDS47SQkM53B9NPjbNyfu2B/+31AvGPqcdCd5OUqE22Ix50/+IShHFJ0gCYpeoz0SpH0eT7rtmyvnNuDbbi53YpFy6/7ZbTyIkG+Ss2F+uDfb9dL7pcY1riHlKjwHHz/I1PqoNk1jmBbSJrTwahN
Received: from archlinux.. (pd95ed842.dip0.t-ipconnect.de. [217.94.216.66])
 by smtp.gmail.com with ESMTPSA id
 ti9-20020a170907c20900b00a3109a492d4sm109753ejc.20.2024.02.08.14.03.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Feb 2024 14:03:59 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Sergio Lopez <slp@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 4/9] hw/i386/pc: Merge pc_guest_info_init() into
 pc_machine_initfn()
Date: Thu,  8 Feb 2024 23:03:44 +0100
Message-ID: <20240208220349.4948-5-shentey@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240208220349.4948-1-shentey@gmail.com>
References: <20240208220349.4948-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x530.google.com
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

Resolves redundant code in the piix and q35 machines.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/i386/pc.h | 2 --
 hw/i386/pc.c         | 9 +++------
 hw/i386/pc_piix.c    | 2 --
 hw/i386/pc_q35.c     | 2 --
 4 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index ec0e5efcb2..287f1ab553 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -151,8 +151,6 @@ extern int fd_bootchk;
 
 void pc_acpi_smi_interrupt(void *opaque, int irq, int level);
 
-void pc_guest_info_init(PCMachineState *pcms);
-
 #define PCI_HOST_PROP_RAM_MEM          "ram-mem"
 #define PCI_HOST_PROP_PCI_MEM          "pci-mem"
 #define PCI_HOST_PROP_SYSTEM_MEM       "system-mem"
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 12facf73b1..45738d8548 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -706,12 +706,6 @@ void pc_machine_done(Notifier *notifier, void *data)
     }
 }
 
-void pc_guest_info_init(PCMachineState *pcms)
-{
-    pcms->machine_done.notify = pc_machine_done;
-    qemu_add_machine_init_done_notifier(&pcms->machine_done);
-}
-
 /* setup pci memory address space mapping into system address space */
 void pc_pci_as_mapping_init(MemoryRegion *system_memory,
                             MemoryRegion *pci_address_space)
@@ -1751,6 +1745,9 @@ static void pc_machine_initfn(Object *obj)
     object_property_add_alias(OBJECT(pcms), "pcspk-audiodev",
                               OBJECT(pcms->pcspk), "audiodev");
     cxl_machine_init(obj, &pcms->cxl_devices_state);
+
+    pcms->machine_done.notify = pc_machine_done;
+    qemu_add_machine_init_done_notifier(&pcms->machine_done);
 }
 
 int pc_machine_kvm_type(MachineState *machine, const char *kvm_type)
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index adb3b5ed43..4ca2dc08e7 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -226,8 +226,6 @@ static void pc_init1(MachineState *machine,
                                                &error_abort);
     }
 
-    pc_guest_info_init(pcms);
-
     if (pcmc->smbios_defaults) {
         MachineClass *mc = MACHINE_GET_CLASS(machine);
         /* These values are guest ABI, do not change */
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 53da8b552d..fe0c2849fd 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -199,8 +199,6 @@ static void pc_q35_init(MachineState *machine)
         rom_memory = system_memory;
     }
 
-    pc_guest_info_init(pcms);
-
     if (pcmc->smbios_defaults) {
         /* These values are guest ABI, do not change */
         smbios_set_defaults("QEMU", mc->desc,
-- 
2.43.0


