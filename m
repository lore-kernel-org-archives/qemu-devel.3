Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0916ECA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 13:20:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utQps-0007yR-FZ; Tue, 02 Sep 2025 09:14:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utQpC-0007IV-NB
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:13:29 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utQp7-0004nO-Vs
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:13:25 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-45b8b8d45b3so20465855e9.1
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 06:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756818798; x=1757423598; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IiaqMhKzb+hmnzQCD7wPPRZkhh4jutFo9MeWh47ViIw=;
 b=T04mcPkO2zL7IqMK/1Wru2Oo8UKe8xsXkOQjbsGS9nVbmuTvJwpgJPOXf96gJBD3ym
 tkyeWgwqM6attKcel0rtxPlQPSQR4nFVgcqvDFvDMl8UVvVgtVCvaDjBf/djXEseAR57
 QeZxIikQMhldsMWWV3Ukv+X6wDvY3UIeCFn8nbSXe22I4hYetOdHc8MWyO1R5r8nXfQJ
 lxGvd9/vpGmM7uX7R3mP9R+Sv9CD07bIcxS1ckSUWNp8zJmvQjkJlWqZwf8VHz1bOYQY
 frlKWP5gsJVaCz6omXwkJ9gEisXsJmWswv3jZod2U1KXewehgssn6DeQnpWJ+/ys40Bc
 GtwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756818798; x=1757423598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IiaqMhKzb+hmnzQCD7wPPRZkhh4jutFo9MeWh47ViIw=;
 b=KxWCAuKy2p5gxks3p2OQAdR6Q3y1S+fy92scX9+t6asWLTGuJ1fageMVw21VZpf72s
 fjVeIOpNq19hMa6+LrFh0Rq2sbebZxBIivG0UGK3QQfbPbMpOrBO/oMvP3tzOSvsGgw0
 xv+Mz8GVNNxz46VXjzXeU25WFWIDkIBP4JFtNuF5BBdvKimKKhaKtZNWwzSbo78yw84n
 vh69sHJpFFsLdgPlCBCnXtI+83qN7jhpLdwTWW9PZl3tq+RgItsOPKEpF8zcJaXyEYkp
 I4UEPnpcb/bYJRnBA0JtMLST+G8rH9aJcXCW9VH2E/CV3yVFpghuQjpIl+rGf5fW+QOH
 OOkw==
X-Gm-Message-State: AOJu0YxGkRDBJntoOWP0OuUwUdpQbaDP+CymfrMWiE9Iy+z8xE5izDbx
 rq45OF4cB4E28FeA8RYt63MTM7xqYP2FX83Wjsy5Y68TzfgASPz1FdjiE8z23pqSCbXW7VXbNPi
 jkzMI
X-Gm-Gg: ASbGncu4tRhnH7a7drWzjstWI/v6Dv03sAeOfAcPH9TOSsdzgZyoWto3VKH3lu12HVA
 KtB9dRuM3ujT2jJIVNE6HH0fy/wPAT0ARYj1+BkL8r2bb0RKWmIwjTckxDkJuUa4vXggcFHU/+h
 vTpb9/RQTi0BGPyFh2c5w5KtcM23BVUL5GeOr8JEVkg7xCpcE6UfiYhUP2qyYjnIWnspPCrKt/w
 6qTzpcL5S4HaOwmgJR9NPf4G/PuoklBz7gsKC9RUNSiIqeUWw6pAGZ44oJciNosJInWpzU4yWEp
 hzzu27NQwGupNAc3R9FjmNToX0P5fOOD0lt9Y0Ntxdhwnsl6W+2JYPx2LroeiTJZ3L2Krmi1OSD
 y4TTZGmsXSkSjQS5V6tZPD1LVn1c36sWmfkB7nQUhTzdKn06aj81r5KBFSa4CSwjMe5NrifkL0d
 AwMG4s8cU=
X-Google-Smtp-Source: AGHT+IHuKyd7Gr32qW6rTX74DYVdWJ4mz5v3D3N6BiYWZ7vIQkHvuGZDBDaOM6KaDdDfe0KYsWUJew==
X-Received: by 2002:a05:600c:1ca8:b0:45b:90fc:1ede with SMTP id
 5b1f17b1804b1-45b90fc20bemr36418755e9.6.1756818798253; 
 Tue, 02 Sep 2025 06:13:18 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b732671b7sm138309095e9.3.2025.09.02.06.13.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Sep 2025 06:13:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 39/39] hw/i386/pc_piix.c: remove unnecessary if() from
 pc_init1()
Date: Tue,  2 Sep 2025 15:10:16 +0200
Message-ID: <20250902131016.84968-40-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902131016.84968-1-philmd@linaro.org>
References: <20250902131016.84968-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

From: Mark Cave-Ayland <mark.caveayland@nutanix.com>

Now that the isapc logic has been split out of pc_piix.c, the PCI Host Bridge
(phb) object is now always set in pc_init1().

Since phb is now guaranteed not to be NULL, Coverity reports that the if()
statement surrounding ioapic_init_gsi() is now unnecessary and can be removed
along with the phb NULL initialiser.

Coverity: CID 1620557
Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Fixes: 99d0630a45 ("hw/i386/pc_piix.c: assume pcmc->pci_enabled is always true in pc_init1()")
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250901203409.1196620-1-mark.caveayland@nutanix.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc_piix.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 7e78b6daa6d..caf8bab68e2 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -106,7 +106,7 @@ static void pc_init1(MachineState *machine, const char *pci_type)
     X86MachineState *x86ms = X86_MACHINE(machine);
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *system_io = get_system_io();
-    Object *phb = NULL;
+    Object *phb;
     ISABus *isa_bus;
     Object *piix4_pm = NULL;
     qemu_irq smi_irq;
@@ -284,9 +284,7 @@ static void pc_init1(MachineState *machine, const char *pci_type)
         pc_i8259_create(isa_bus, gsi_state->i8259_irq);
     }
 
-    if (phb) {
-        ioapic_init_gsi(gsi_state, phb);
-    }
+    ioapic_init_gsi(gsi_state, phb);
 
     if (tcg_enabled()) {
         x86_register_ferr_irq(x86ms->gsi[13]);
-- 
2.51.0


