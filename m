Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48CD4C48BF6
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Feb 2024 14:01:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdsYd-0004Al-2e; Sat, 24 Feb 2024 08:59:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rdsYb-00049m-9Y
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 08:59:13 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rdsYX-0002kz-Jp
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 08:59:11 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4129f33d2e8so1467745e9.1
 for <qemu-devel@nongnu.org>; Sat, 24 Feb 2024 05:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708783147; x=1709387947; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lg93a47qvzmza3RMrC5PuS5WPquGN42j8mbqdeYWlPQ=;
 b=iTza3Tc4bHSX50uvRqJKzmjgS2+0WSemkzTVyJfaxHvTFYSMeugDTvW4zc0HvvWDeM
 +qGxs1cY6c3dn5Z3qgTBkFNgJE+FZuoeW+uC5lcAvFxb8IFbfiKEAh2OeITqxr6lc7rk
 wpAP9vCqmNBfNamXEJfQqjrZZVuCYThj0NseX9CN3oeCafs2cWN42k2T07Qykatu2Bfm
 WI+67sGByjC2TbxRwaKh0PVRxe0bYdSfKij2JhlY3/NsUDRUAqQ55X9T415XSC2NU+1y
 M3dz+6cRXzVPThaa9++Tub+0cfWanKVUY1Y+4g8D2BPMahOXtXm2pz1XHdTDzoR9i+Lu
 pIPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708783147; x=1709387947;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lg93a47qvzmza3RMrC5PuS5WPquGN42j8mbqdeYWlPQ=;
 b=gn/oxG3NmSH853zNYLXwgt/j++759y20Z+9M7lXprHRs4JXggDRRxNcwFCzqB9ts4a
 lI8cYoeHqhsm33cjpT0l923i3Av3ImIi99LxdzHBZFyBUAgQUTiaQ/C7wkuz3AYNZyN/
 8VWTHQOI7naMGfGCGvYJLtRCaXPWBKglzlhK3ftsVZ165jQ2VIMSoyBjKzF5a08zVIyL
 ndkVi89DzrLxCMUxFfvCtieEYcQQxu2ojJ/ur4P0J0GaLcsWr7QNYwYe6x+L600oXi/G
 JJsYR/yDMj4SG0klKCHO5EJZtELdrfErw5vlhFbd8n0Ec+1k3w5kKz1vAjKgUNe92JuE
 SqfQ==
X-Gm-Message-State: AOJu0YyzXMNFF96HcycoQ4Q4IS9Sgsi/+coyjUmS+OgP18yQjgvR1Gxi
 qnc0E43P0qupxWMZ8LDag565AuR0iz2hphXhjxTLLU6D88jT7u9e6P0U60NH
X-Google-Smtp-Source: AGHT+IFq8qTmtZ6r89tRRd2U2f68ZvjcHUrgYrSs1y7kHdJCDE6c2TILEOR76eaSaEwt1f71dlj6Qw==
X-Received: by 2002:a5d:51d0:0:b0:33d:a1c4:9c63 with SMTP id
 n16-20020a5d51d0000000b0033da1c49c63mr1788939wrv.49.1708783147714; 
 Sat, 24 Feb 2024 05:59:07 -0800 (PST)
Received: from archlinux.. (dynamic-089-012-138-060.89.12.pool.telefonica.de.
 [89.12.138.60]) by smtp.gmail.com with ESMTPSA id
 n8-20020a056000170800b0033d817eddd3sm2285542wrc.13.2024.02.24.05.59.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Feb 2024 05:59:06 -0800 (PST)
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
 Bernhard Beschow <shentey@gmail.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 4/6] hw/i386/pc: Remove unneeded class attribute
 "kvmclock_enabled"
Date: Sat, 24 Feb 2024 14:58:49 +0100
Message-ID: <20240224135851.100361-5-shentey@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240224135851.100361-1-shentey@gmail.com>
References: <20240224135851.100361-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x331.google.com
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

PCMachineClass introduces the attribute into the class hierarchy and sets it to
true. There is no sub class overriding the attribute. Commit 30d2a17b46e9
"hw/i386: Remove the deprecated machines 0.12 up to 0.15" removed the last
overrides of this attribute. The attribute is now unneeded and can be removed.

Fixes: 30d2a17b46e9 "hw/i386: Remove the deprecated machines 0.12 up to 0.15"
Cc: Thomas Huth <thuth@redhat.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/i386/pc.h | 1 -
 hw/i386/pc.c         | 1 -
 hw/i386/pc_piix.c    | 2 +-
 3 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 27834043c3..4bb1899602 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -92,7 +92,6 @@ struct PCMachineClass {
 
     /* Device configuration: */
     bool pci_enabled;
-    bool kvmclock_enabled;
     const char *default_south_bridge;
 
     /* Compat options: */
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 353edeb2ea..a80f809b83 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1799,7 +1799,6 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     pcmc->smbios_uuid_encoded = true;
     pcmc->gigabyte_align = true;
     pcmc->has_reserved_memory = true;
-    pcmc->kvmclock_enabled = true;
     pcmc->enforce_aligned_dimm = true;
     pcmc->enforce_amd_1tb_hole = true;
     /* BIOS ACPI tables: 128K. Other BIOS datastructures: less than 4K reported
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 814d24326d..49d5d48db9 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -184,7 +184,7 @@ static void pc_init1(MachineState *machine,
     pc_machine_init_sgx_epc(pcms);
     x86_cpus_init(x86ms, pcmc->default_cpu_version);
 
-    if (kvm_enabled() && pcmc->kvmclock_enabled) {
+    if (kvm_enabled()) {
         kvmclock_create(pcmc->kvmclock_create_always);
     }
 
-- 
2.44.0


