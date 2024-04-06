Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2014ACD1284
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Apr 2024 10:38:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rt3RW-000455-Tj; Sat, 06 Apr 2024 06:38:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rt3RV-00044q-7k
 for qemu-devel@nongnu.org; Sat, 06 Apr 2024 06:38:37 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rt3RT-0005Fp-B0
 for qemu-devel@nongnu.org; Sat, 06 Apr 2024 06:38:37 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a51c37a5025so5617566b.1
 for <qemu-devel@nongnu.org>; Sat, 06 Apr 2024 03:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712399913; x=1713004713; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=katZgpXheBWu/q6Hj0m0PLK3Zp+Dqpr33WEzx5gAdMI=;
 b=ahknNi+mBIoqQ2EuJD6LD6/RJhO9sfHR82ESNPzH5pIoZaqUv0sh6YjTiZ1X9Fti3H
 Ey2FWYOkoZhLuQN2q88DS7seOrqQpdfeKOOsMmXhH48T1USHyL5khOXP4Wx4My+dJQyk
 KaQ6QRvebLhK+yTIzpMPdUYw+yaVVQ97ePEVqs2x1u2n/Sk0T82paqq9l2LJjR/5jJGC
 IhzOImhy9HpWvd6UCoac2jbVhffn48i/ANatjipwxzqydagIMXUIx8cAozKrz2fUYMxC
 7KFCO+9IBApFy5/9Dfhq9pl+6WC93yYujGYjCH2gS3gvhCkDQXJzibwwRS/UVYDxqTDk
 uBbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712399913; x=1713004713;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=katZgpXheBWu/q6Hj0m0PLK3Zp+Dqpr33WEzx5gAdMI=;
 b=pOg4j3pQ8aLr4amss2cwW3gBKQssvVkhrM8Wumxx3OIZwv2u2mvvTZ62wtS01Pet3I
 aNNQZRF5V5CY9K/qnCu46tC3jXLo0HPIUEGFpPkmnlbIOpbqiVE+eUrt7UHa3HLyYhkG
 MUy0+QcAYqGxnrTGmg8Js6k/8nGaRphMSIQKJWYJqo1QmEXSsHKrnX0mlE7UODrotS57
 N6VBL7XIWXaGmuImnO7CZAhqPXULhwspcJalKlKHqEu1AjASFkWiPmVmSgyvq5HKjie+
 FH9QnjHuFvXQsNSrjv+oult3s/n64O6HnN0GP2A82HgS2BX5UkZ+sIO4WY4m+gH8YdNI
 4O5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWE1Q2MYQsxAsMECxpVi5b7N2SodOB5pHAGkp7drvpcDuBI9DFHDRxRXHkqIxOGEYcsuXWIdZBIIimjRM35D7P6jSwBnIE=
X-Gm-Message-State: AOJu0YxChkd8XKvJEwmECK1rZZYLSOhn6Y4V7Xq+/O1ybTk2mrtPTE9u
 Y32lyJfvHjlOGm2W39sDnvFnqarKU4QspneMwfOvcURygwGVIebf
X-Google-Smtp-Source: AGHT+IE37mkMY75cSujzRGF6ERkZ9H+hOCgYE/IiYgC0qWxnHTAEtopYDUeK2NRAdz/uFiOlMmqlhg==
X-Received: by 2002:a17:906:3546:b0:a51:7b86:671e with SMTP id
 s6-20020a170906354600b00a517b86671emr2304903eja.8.1712399913278; 
 Sat, 06 Apr 2024 03:38:33 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-077-013-220-023.77.13.pool.telefonica.de.
 [77.13.220.23]) by smtp.gmail.com with ESMTPSA id
 nb33-20020a1709071ca100b00a4628cacad4sm1870100ejc.195.2024.04.06.03.38.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 06 Apr 2024 03:38:32 -0700 (PDT)
Date: Sat, 06 Apr 2024 10:38:30 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
CC: Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org,
 Thomas Huth <thuth@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, Ani Sinha <anisinha@redhat.com>
Subject: =?US-ASCII?Q?Re=3A_=5BRFC_PATCH-for-9=2E1_09/29=5D_hw/i386/pc=3A_P?=
 =?US-ASCII?Q?ass_PCMachineState_argument_to_acpi=5Fsetup=28=29?=
In-Reply-To: <20240328155439.58719-10-philmd@linaro.org>
References: <20240328155439.58719-1-philmd@linaro.org>
 <20240328155439.58719-10-philmd@linaro.org>
Message-ID: <B476D63B-DE8E-4DB0-A876-ADC61B08D5A3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 28=2E M=C3=A4rz 2024 15:54:17 UTC schrieb "Philippe Mathieu-Daud=C3=A9"=
 <philmd@linaro=2Eorg>:
>acpi_setup() caller knows about the machine state, so pass
>it as argument to avoid a qdev_get_machine() call=2E
>
>We already resolved X86_MACHINE(pcms) as 'x86ms' so use the
>latter=2E
>
>Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro=2Eorg>

This patch looks like good material on its own=2E

Reviewed-by: Bernhard Beschow <shentey@gmail=2Ecom>

>---
> hw/i386/acpi-build=2Eh | 3 ++-
> hw/i386/acpi-build=2Ec | 5 ++---
> hw/i386/pc=2Ec         | 2 +-
> 3 files changed, 5 insertions(+), 5 deletions(-)
>
>diff --git a/hw/i386/acpi-build=2Eh b/hw/i386/acpi-build=2Eh
>index 0dce155c8c=2E=2E31de5bddbd 100644
>--- a/hw/i386/acpi-build=2Eh
>+++ b/hw/i386/acpi-build=2Eh
>@@ -2,6 +2,7 @@
> #ifndef HW_I386_ACPI_BUILD_H
> #define HW_I386_ACPI_BUILD_H
> #include "hw/acpi/acpi-defs=2Eh"
>+#include "hw/i386/pc=2Eh"
>=20
> extern const struct AcpiGenericAddress x86_nvdimm_acpi_dsmio;
>=20
>@@ -9,7 +10,7 @@ extern const struct AcpiGenericAddress x86_nvdimm_acpi_d=
smio;
> #define ACPI_PCIHP_SEJ_BASE 0x8
> #define ACPI_PCIHP_BNMR_BASE 0x10
>=20
>-void acpi_setup(void);
>+void acpi_setup(PCMachineState *pcms);
> Object *acpi_get_i386_pci_host(void);
>=20
> #endif
>diff --git a/hw/i386/acpi-build=2Ec b/hw/i386/acpi-build=2Ec
>index 6e8e32e5d2=2E=2Ee702d5e9d2 100644
>--- a/hw/i386/acpi-build=2Ec
>+++ b/hw/i386/acpi-build=2Ec
>@@ -2749,9 +2749,8 @@ static const VMStateDescription vmstate_acpi_build =
=3D {
>     },
> };
>=20
>-void acpi_setup(void)
>+void acpi_setup(PCMachineState *pcms)
> {
>-    PCMachineState *pcms =3D PC_MACHINE(qdev_get_machine());
>     X86MachineState *x86ms =3D X86_MACHINE(pcms);
>     AcpiBuildTables tables;
>     AcpiBuildState *build_state;
>@@ -2771,7 +2770,7 @@ void acpi_setup(void)
>         return;
>     }
>=20
>-    if (!x86_machine_is_acpi_enabled(X86_MACHINE(pcms))) {
>+    if (!x86_machine_is_acpi_enabled(x86ms)) {
>         ACPI_BUILD_DPRINTF("ACPI disabled=2E Bailing out=2E\n");
>         return;
>     }
>diff --git a/hw/i386/pc=2Ec b/hw/i386/pc=2Ec
>index 6d87d1d4c2=2E=2Edfc0247bb6 100644
>--- a/hw/i386/pc=2Ec
>+++ b/hw/i386/pc=2Ec
>@@ -601,7 +601,7 @@ void pc_machine_done(Notifier *notifier, void *data)
>     /* set the number of CPUs */
>     x86_rtc_set_cpus_count(x86ms->rtc, x86ms->boot_cpus);
>=20
>-    acpi_setup();
>+    acpi_setup(pcms);
>     if (x86ms->fw_cfg) {
>         fw_cfg_build_smbios(pcms, x86ms->fw_cfg, pcms->smbios_entry_poin=
t_type);
>         fw_cfg_build_feature_control(MACHINE(pcms), x86ms->fw_cfg);

