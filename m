Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 550B4C54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 13:46:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhV7H-0005NS-4X; Tue, 05 Mar 2024 08:45:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhV5M-0003q8-TL
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:44:01 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhV5K-0004CJ-RL
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:44:00 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-412e993a82eso5910655e9.0
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 05:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709646237; x=1710251037; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5TGU952DKVM2tYEewPZVbKhW/aUuUpfwS5FrOa58Xf0=;
 b=vtF1tvFDKeRE41WleMynsESZi1ZcL4GnrdkVf+bYgwd76jM4a7vI8mLBQZu88GxV7B
 mdIMqprGLnzEiWUM5TuGw6FPK7fV0WWkhNXmvwyFrAAgplP0SPh7l++nRNF+6UEBkLnW
 AvqI82k8KXrbqlU8241J+Q3iaCLEPl7hzyajOeTOBA/PLlxT4R3xLW4N4k8/RiA9BlP4
 qM042zqAry6doADPolty/CtBElhNqHR3K7o6LP3IRl3RtOaqM7pFF8QS1yJyUZS7AyjA
 f0/nCEvYsr4xAKEE4McVJkh1GBkHcSPV3pB+d9Ngq/bRXZW33jBuIy4B7uOtKcgWPYUM
 ZqEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709646237; x=1710251037;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5TGU952DKVM2tYEewPZVbKhW/aUuUpfwS5FrOa58Xf0=;
 b=EkbH/23sFKt4dAsIrd47xrFRknP1F0c9/rz3N8QJdDuQtLUV70KnF6skRUkcXF4VDB
 2Fcrkom3DBt1a63A3xnwax3/wPF328jUkLY+g17M1q+K0P0Bf8UFS3e/H7oGQTy7NCZv
 PtNkbGSWky4iSX88eXM3m7jrxmdZhGz7YIEj7GVTVzKVZZjXF2N/KieRzP/P9vpET+QK
 eNCOXOzIMYlVEtUg93DxC18S+hOhF5wEhbGxPlLMX/WZXEmIUNjk5EMqL68gHE4ENBVv
 5jk0sGrgh4+jb5x6TxOKKjqKZOpf9RSmzQ5+H87PzPl8/zdm0OycpPEeZKg0Ky2B8FWH
 Z9Dw==
X-Gm-Message-State: AOJu0YxL0qKPWhsfGL9t38gD5noLtx4mGSq7T6bqV5Pwh1zs59UF0pVj
 Mwh3Vgv7iRRnt2+em/Cgv/Tn3jjCbaR8LbsclkAahx1tcGSuEdUcTCWBJxTco2C1YSx6k9g2+7/
 7
X-Google-Smtp-Source: AGHT+IGC2D2rmKYCMfxA0oHHpGajfv51gJDo/dA1KdNcDkrWRiY8zzCZcuiUCdaP0oLhW6EOx+KtAg==
X-Received: by 2002:a05:600c:1d17:b0:412:e993:d5da with SMTP id
 l23-20020a05600c1d1700b00412e993d5damr2100311wms.32.1709646236748; 
 Tue, 05 Mar 2024 05:43:56 -0800 (PST)
Received: from m1x-phil.lan ([176.176.177.70])
 by smtp.gmail.com with ESMTPSA id
 o17-20020a05600c4fd100b00412d68dbf75sm10917201wmq.35.2024.03.05.05.43.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Mar 2024 05:43:56 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Thomas Huth <thuth@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org,
 Marcelo Tosatti <mtosatti@redhat.com>, devel@lists.libvirt.org,
 David Hildenbrand <david@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH-for-9.1 13/18] hw/i386/pc: Remove
 PCMachineClass::resizable_acpi_blob
Date: Tue,  5 Mar 2024 14:42:15 +0100
Message-ID: <20240305134221.30924-14-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240305134221.30924-1-philmd@linaro.org>
References: <20240305134221.30924-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

PCMachineClass::resizable_acpi_blob was only used by the
pc-i440fx-2.2 machine, which got removed. It is now always
true. Remove it, simplifying acpi_build().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/i386/pc.h | 3 ---
 hw/i386/acpi-build.c | 9 ---------
 hw/i386/pc.c         | 1 -
 3 files changed, 13 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index f7a5f4f283..be3a58c972 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -124,9 +124,6 @@ struct PCMachineClass {
     /* create kvmclock device even when KVM PV features are not exposed */
     bool kvmclock_create_always;
 
-    /* resizable acpi blob compat */
-    bool resizable_acpi_blob;
-
     /*
      * whether the machine type implements broken 32-bit address space bound
      * check for memory.
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 8c7fad92e9..a56ac8dc90 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2688,15 +2688,6 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
      * All this is for PIIX4, since QEMU 2.0 didn't support Q35 migration.
      */
     /* Make sure we have a buffer in case we need to resize the tables. */
-    if ((tables_blob->len > ACPI_BUILD_TABLE_SIZE / 2) &&
-        !pcmc->resizable_acpi_blob) {
-        /* As of QEMU 2.1, this fires with 160 VCPUs and 255 memory slots.  */
-        warn_report("ACPI table size %u exceeds %d bytes,"
-                    " migration may not work",
-                    tables_blob->len, ACPI_BUILD_TABLE_SIZE / 2);
-        error_printf("Try removing CPUs, NUMA nodes, memory slots"
-                     " or PCI bridges.\n");
-    }
     acpi_align_size(tables_blob, ACPI_BUILD_TABLE_SIZE);
 
     acpi_align_size(tables->linker->cmd_blob, ACPI_BUILD_ALIGN_SIZE);
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index a762df7686..8139cd4a7d 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1768,7 +1768,6 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     pcmc->acpi_data_size = 0x20000 + 0x8000;
     pcmc->pvh_enabled = true;
     pcmc->kvmclock_create_always = true;
-    pcmc->resizable_acpi_blob = true;
     x86mc->apic_xrupt_override = true;
     assert(!mc->get_hotplug_handler);
     mc->get_hotplug_handler = pc_get_hotplug_handler;
-- 
2.41.0


