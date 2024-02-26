Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 299A6C54E49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 11:15:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reYwc-0000nj-89; Mon, 26 Feb 2024 06:14:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reYwa-0000lf-Nj
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 06:14:48 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reYwY-0008SM-40
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 06:14:47 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-33d6f26ff33so2085705f8f.0
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 03:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708946084; x=1709550884; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+8DBH+8DhWLlCRMzjMefALJRNboH1BCtR+qCvzO7EXA=;
 b=Z1TeUqV6L/njzuUPaG2kzLhsMlJr0flB/NcQ0pVcH0tmLDd4RY5YhINtkjdjYiVV0L
 8F9ptNQ3WYZLzDDvj1eJ7a7l7tGchJYQbZl6i05EUyjQGFICOCJEfY/+W6U5IuwnLl7p
 gtHGCnZjYoxp9efkDDaOIE7vZjnsy/bULwIyVUTSSw/bKU9za5PydFS6k35DVR2Ej2VI
 IqqtjmPwNuVi2P7P4zCvQebND3WCiyemPuD1qyjS6zl7sZ+13ncmRLjGVmA+4SMcg7nz
 /uFSyzSGnrQiIL/nWzhCUTMsf+j0RSXPDI1IrTT0ei2MH03mX5n46vON2R/049485Nd1
 kBXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708946084; x=1709550884;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+8DBH+8DhWLlCRMzjMefALJRNboH1BCtR+qCvzO7EXA=;
 b=wD9LeAHFFbZ+j6EgB8qW/vf/imhK1RQ4+0Vf8CkZcWa7EH3myqHdeTZctV8Ljp1u0i
 A/Kr0ZqLspi0HmNyZNk067vUR1lmAkZIQv7jWVxuYTBV/SjJZDypCgEEfhOhPXmV8r1x
 cPwN5+dikKI7CMEGlPqzXr8vkvPi8wS+ppJCMD9sLumk9dSKkvoEzAaK/XKrdeNUkG7I
 Dq0PbBAVCYl4nDR4MnqQBTGLHMPMtI3t1ZbKZOKpUej7qTAcR6IeJdux1//p4YCTAkbz
 iAEBrxjQ+/orPMMfyv3BEkhlSYkGY/wXnsP7zvHoZEUEX4UwpuBwzrRWzqkY3dfcyhu7
 mnCQ==
X-Gm-Message-State: AOJu0Yw2uPLhqciuEK4UOQPYkBw1NHOkoeq3MH9NE58c9nJda6AIzpO3
 G1Zu8h9+1q+kkYmLm51T0fOIp54pl1dFoyRazQoZfJu0Mn+Amuks2fG2D8Wg4CqgpzUEJTu/aoj
 W
X-Google-Smtp-Source: AGHT+IG7JJl8wNoNWb9pNXKSUsv0CRdKLx+B/jTOFAeiusWHqhrQYyS0Kcy19XRze027PQXuD6PVjA==
X-Received: by 2002:a5d:4a88:0:b0:33d:4fca:a47f with SMTP id
 o8-20020a5d4a88000000b0033d4fcaa47fmr5347798wrq.18.1708946084399; 
 Mon, 26 Feb 2024 03:14:44 -0800 (PST)
Received: from m1x-phil.lan ([176.176.164.69])
 by smtp.gmail.com with ESMTPSA id
 h4-20020a5d4304000000b0033d6c928a95sm7952487wrq.63.2024.02.26.03.14.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 Feb 2024 03:14:43 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Bernhard Beschow <shentey@gmail.com>
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Ani Sinha <anisinha@redhat.com>,
 qemu-block@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 04/15] hw/acpi/ich9_tco: Include 'ich9' in names
Date: Mon, 26 Feb 2024 12:14:03 +0100
Message-ID: <20240226111416.39217-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240226111416.39217-1-philmd@linaro.org>
References: <20240226111416.39217-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Make it explicit the following are ICH9 specific:
  acpi_pm_tco_init()  -> ich9_acpi_pm_tco_init()
  vmstate_tco_io_sts  -> vmstate_ich9_sm_tco.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/acpi/ich9_tco.h | 5 ++---
 hw/acpi/ich9.c             | 4 ++--
 hw/acpi/ich9_tco.c         | 4 ++--
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/include/hw/acpi/ich9_tco.h b/include/hw/acpi/ich9_tco.h
index 2562a7cf39..1c99781a79 100644
--- a/include/hw/acpi/ich9_tco.h
+++ b/include/hw/acpi/ich9_tco.h
@@ -75,9 +75,8 @@ typedef struct TCOIORegs {
     MemoryRegion io;
 } TCOIORegs;
 
-/* tco.c */
-void acpi_pm_tco_init(TCOIORegs *tr, MemoryRegion *parent);
+void ich9_acpi_pm_tco_init(TCOIORegs *tr, MemoryRegion *parent);
 
-extern const VMStateDescription vmstate_tco_io_sts;
+extern const VMStateDescription vmstate_ich9_sm_tco;
 
 #endif /* HW_ACPI_TCO_H */
diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index 4c75d1b56b..daf93361eb 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -186,7 +186,7 @@ static const VMStateDescription vmstate_tco_io_state = {
     .minimum_version_id = 1,
     .needed = vmstate_test_use_tco,
     .fields = (const VMStateField[]) {
-        VMSTATE_STRUCT(tco_regs, ICH9LPCPMRegs, 1, vmstate_tco_io_sts,
+        VMSTATE_STRUCT(tco_regs, ICH9LPCPMRegs, 1, vmstate_ich9_sm_tco,
                        TCOIORegs),
         VMSTATE_END_OF_LIST()
     }
@@ -317,7 +317,7 @@ void ich9_pm_init(PCIDevice *lpc_pci, ICH9LPCPMRegs *pm, qemu_irq sci_irq)
     memory_region_add_subregion(&pm->io, ICH9_PMIO_SMI_EN, &pm->io_smi);
 
     if (pm->enable_tco) {
-        acpi_pm_tco_init(&pm->tco_regs, &pm->io);
+        ich9_acpi_pm_tco_init(&pm->tco_regs, &pm->io);
     }
 
     if (pm->acpi_pci_hotplug.use_acpi_hotplug_bridge) {
diff --git a/hw/acpi/ich9_tco.c b/hw/acpi/ich9_tco.c
index 81606219f7..dd4aff82e0 100644
--- a/hw/acpi/ich9_tco.c
+++ b/hw/acpi/ich9_tco.c
@@ -224,7 +224,7 @@ static const MemoryRegionOps tco_io_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
-void acpi_pm_tco_init(TCOIORegs *tr, MemoryRegion *parent)
+void ich9_acpi_pm_tco_init(TCOIORegs *tr, MemoryRegion *parent)
 {
     *tr = (TCOIORegs) {
         .tco = {
@@ -250,7 +250,7 @@ void acpi_pm_tco_init(TCOIORegs *tr, MemoryRegion *parent)
     memory_region_add_subregion(parent, ICH9_PMIO_TCO_RLD, &tr->io);
 }
 
-const VMStateDescription vmstate_tco_io_sts = {
+const VMStateDescription vmstate_ich9_sm_tco = {
     .name = "tco io device status",
     .version_id = 1,
     .minimum_version_id = 1,
-- 
2.41.0


