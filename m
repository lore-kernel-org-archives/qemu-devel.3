Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4B67CD128D
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 15:59:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rps6e-0002zs-BF; Thu, 28 Mar 2024 11:55:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rps6d-0002zH-Bk
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:55:55 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rps6b-0002HX-RJ
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:55:55 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-568c714a9c7so1312492a12.2
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 08:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711641352; x=1712246152; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZJ3NIU3pO9930vwNFx0mYgma5e7GvztHkS/rmyU15RU=;
 b=g5kDrfi6D4PPgQey6KAAPOIxbj5tQTxWmFhyio+RChkZVTxMAynTp7lD7FmmobGKyy
 GbnE5kxDWImzGZgXLNZeBTxIB/PPbGCingoGu8kja3p0GomhcnNzRDqcrnn7baH1q8jr
 otCzfjr6l5XmXzF//SzKFpZ/cLEoBrxFzZnHYdqEZNmm2uqCssIXyVR/gzrHOHa0Zg1w
 apzn/XvnzPqRejoFPbPG6bOQf7WcYOqq0oLASzWFSXDg9smnNCNPExL2qK0qz2ztLHzd
 Q7dknxJZO0Sslcy1uTACB1ufqgBnCWOEK4lK0d0TVRwmDTY2X878gqN2cXRrfjP940FC
 krLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711641352; x=1712246152;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZJ3NIU3pO9930vwNFx0mYgma5e7GvztHkS/rmyU15RU=;
 b=OdSevUxWIpjBIkxJxfxIEBx+sXrhP1Sn1Bs9uOa3ei3OL+5Gm40GRFxLdh+bHvDHvF
 1GkLO6lHPKjXrewQj1T/XnbyD1joivzGYUvZphsP9Vc2hjJpIqm03ecFynAlff4OY4EI
 Hg8UAX492j8rYODZR70TSYxrN8mSw66ac1wgWgE6Jc73Gzd3O9Wi8LdKVmSVGGYR04u+
 AmX8ZNyf7Kz2Uz6IYllHvR4L8gWnDcuj1k36g1eLx3U6UCV0UWyWfhLhDBzcRNez2Sri
 PdbenzNPtEwy/qXQn0OurnS3Qn9oZgdhjoEGtdzN0RE5O+JdURAZ1XptCA0sWtFMVfAS
 0XKg==
X-Gm-Message-State: AOJu0YzJRL02/n+JdwlDGnBzmdyUakz4+sByJYUuBm/iuKOOzIVxlel/
 T2yNwgqVssAEcgpU2LYkm2WnkWwtBvjO6ap7HeSFamECNtPEpYksiotCnZYmmwWdX/JKDfpoA9Q
 B
X-Google-Smtp-Source: AGHT+IH3/f3B+fppMfqmjp05mNuhqqUlRQgmruUJACUpH3wuIu7IVWjtNOwP7TTyrIw4MimWKbfy0Q==
X-Received: by 2002:a50:d6d8:0:b0:568:ae7:bc0 with SMTP id
 l24-20020a50d6d8000000b005680ae70bc0mr2301236edj.34.1711641351948; 
 Thu, 28 Mar 2024 08:55:51 -0700 (PDT)
Received: from m1x-phil.lan (pas38-h02-176-184-5-52.dsl.sta.abo.bbox.fr.
 [176.184.5.52]) by smtp.gmail.com with ESMTPSA id
 u23-20020aa7d897000000b0056ba017ca7fsm953482edq.87.2024.03.28.08.55.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 28 Mar 2024 08:55:51 -0700 (PDT)
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
Subject: [RFC PATCH-for-9.1 11/29] hw/i386/pc: Move acpi_setup() call to
 pc_pci_machine_done()
Date: Thu, 28 Mar 2024 16:54:19 +0100
Message-ID: <20240328155439.58719-12-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240328155439.58719-1-philmd@linaro.org>
References: <20240328155439.58719-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x529.google.com
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

acpi_setup() returns early if acpi_build_enabled is not set:

  2752 void acpi_setup(PCMachineState *pcms)
  2753 {
   ...
  2768     if (!pcms->acpi_build_enabled) {
  2769         ACPI_BUILD_DPRINTF("ACPI build disabled. Bailing out.\n");
  2770         return;
  2771     }

acpi_build_enabled is only set on PCI-based machines, so it
is pointless to call acpi_setup() from non-PCI like the ISA-only
machine, move the call to pc_pci_machine_done().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index f0dc04e2fc..47fe3a7c02 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -601,7 +601,6 @@ void pc_machine_done(Notifier *notifier, void *data)
     /* set the number of CPUs */
     x86_rtc_set_cpus_count(x86ms->rtc, x86ms->boot_cpus);
 
-    acpi_setup(pcms);
     if (x86ms->fw_cfg) {
         fw_cfg_build_smbios(pcms, x86ms->fw_cfg, pcms->smbios_entry_point_type);
         fw_cfg_build_feature_control(MACHINE(pcms), x86ms->fw_cfg);
@@ -627,6 +626,8 @@ static void pc_pci_machine_done(Notifier *notifier, void *data)
     }
 
     fw_cfg_add_extra_pci_roots(pcms->pcibus, x86ms->fw_cfg);
+
+    acpi_setup(pcms);
 }
 
 /* setup pci memory address space mapping into system address space */
-- 
2.41.0


