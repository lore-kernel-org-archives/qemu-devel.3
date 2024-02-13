Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA3C3C4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 18:57:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZxxy-0002sx-AJ; Tue, 13 Feb 2024 13:57:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rZxxw-0002s2-8s; Tue, 13 Feb 2024 13:57:12 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rZxxu-0006rO-N7; Tue, 13 Feb 2024 13:57:12 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a3be744df3fso495423066b.0; 
 Tue, 13 Feb 2024 10:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707850629; x=1708455429; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RhqeHO5t4PwMad9GTfrLwGYu6j7b1NEzmXwWfKjwiFY=;
 b=Ix4Vlhaa6FJFCJ4W5Q4+1l9ACjQgE4X2KgdS3wConISKimcOBbgmf4XQGyYuESZ27r
 89y/FZFhrz7jjOslvOXn8ZB1bhlZ2kb86HsEL1SPEtpiKLSt9zXEpPXNHYBwBrrITh2I
 FhCQgCYu4hF9J6u6eRo+1oAhI4miJF3qs9UZvq9EHEXrzhzRBXwhLz47yUy2p8GUkfeu
 CcTve9giRnu5FZ9dF6agBpKkxyrBD3fqiVAQp+qjDVHhQGA0Qrf7utpDaoXwYwWLDf9X
 fDnwVvQSBtvyU+EAr+9WwmrgYoqJvW7uP7Hb65Aw8yMUrvoIlwXkGw+mU31/1wieeQEK
 SVug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707850629; x=1708455429;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RhqeHO5t4PwMad9GTfrLwGYu6j7b1NEzmXwWfKjwiFY=;
 b=kbQfi5O5tOqWTOFb8DbS6V7hneoZItwxtytRULR1S3269+KrrT779NgT1WMPVcRX+g
 raifUgIMB+QzZ6j0Dlg9BGIKsdBYLEe7sIQBgBl1Ky0IHOWPYHnTPbRre1Tp4o6nDMtL
 bBN8W/GeFI19OEq535vfCLcENeasYwqST9PnBzO91OJnn1WOTi7H1aA+RUSMuidtOAIx
 /zN5OGBdD5K1X5C25LBvLMYh+MHMua6ft3eE6XutMVSeXLDxhyntxrUW+35xKMpGVce9
 93tBNW5ny7GCLYI5YrokJU88Jy+z/V0JbLBVtewKY0XPnE3kTAub10B6Kn41jQC410o2
 jn3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMFFMPa/uksd7Vvs4flC3scmitdMXR7nmmJmJaSBGu/kIgpiNNLLqKU7im8FYxkMWsO60P4pG5q+VxVHFrBndpNUUBhNxLJMPe8+gsUhovkJ3SLIwH+eU0Pm7TN8En
X-Gm-Message-State: AOJu0YywKQa1nrZsu+qniFEinpY53dwlN3vdv/xRXoutb4X+CN3V3MO5
 QPb6o82PijWnamYNCrN3N1/W/rkZZGg2+ex1Qmd33rpnmqX/EN3/
X-Google-Smtp-Source: AGHT+IEGamCwOpUvCdsKk6XCql4tDLiuUw56UJf9MgO/5R727wHNErRbwEFxkm4e7hVKTHPh+ESSKg==
X-Received: by 2002:a17:906:ff4f:b0:a3c:1046:93dd with SMTP id
 zo15-20020a170906ff4f00b00a3c104693ddmr151525ejb.31.1707850628786; 
 Tue, 13 Feb 2024 10:57:08 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCW/jI6AmCpcLYb567jBF/P4fxU99mcI6783glvhrVJZbDFLCJtZuXw9Y1rhZCa1necuCLJMVr7PvM4+Bb5//1JjA4XyX1FsfGmapyRgX3ERqhn1aMBAhKB4X1CYqmvqRVYoS9LhgUpQATC4eymS/W46Kybd0NTtQBozqUH8PgJhgUaYb0GxYj1JOjU9MJd8h2n15E2RV9i8ija1agI62PsiObNn7XnKAbLiOnHRXfGd9rPmcgcd/qN1jo7o/944WZLRwsiMf0rJ0uucx6JC/iCS1FVVfZZKxhLfXE7cN7fFlMAg0SkM8wU=
Received: from [127.0.0.1] (dynamic-089-012-064-238.89.12.pool.telefonica.de.
 [89.12.64.238]) by smtp.gmail.com with ESMTPSA id
 y22-20020a170906471600b00a3d21455aedsm370902ejq.127.2024.02.13.10.57.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Feb 2024 10:57:08 -0800 (PST)
Date: Tue, 13 Feb 2024 18:57:05 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
CC: Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Ani Sinha <anisinha@redhat.com>, qemu-trivial@nongnu.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_4/7=5D_hw/i386/acpi=3A_Declare_?=
 =?US-ASCII?Q?pc=5Fmadt=5Fcpu=5Fentry=28=29_in_=27acpi-common=2Eh=27?=
In-Reply-To: <20240213120153.90930-5-philmd@linaro.org>
References: <20240213120153.90930-1-philmd@linaro.org>
 <20240213120153.90930-5-philmd@linaro.org>
Message-ID: <35DAA6EC-1C6D-4F36-A595-A7F720D63C20@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62a.google.com
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



Am 13=2E Februar 2024 12:01:49 UTC schrieb "Philippe Mathieu-Daud=C3=A9" <=
philmd@linaro=2Eorg>:
>Since pc_madt_cpu_entry() is only used by:
> - hw/i386/acpi-build=2Ec   // single call
> - hw/i386/acpi-common=2Ec  // definition
>there is no need to expose it outside of hw/i386/=2E
>Declare it in "acpi-common=2Eh"=2E
>acpi-build=2Ec doesn't need "hw/i386/pc=2Eh" anymore=2E
>
>Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro=2Eorg>
>---
> hw/i386/acpi-common=2Eh | 3 +++
> include/hw/i386/pc=2Eh  | 4 ----
> hw/i386/acpi-common=2Ec | 1 -
> 3 files changed, 3 insertions(+), 5 deletions(-)
>
>diff --git a/hw/i386/acpi-common=2Eh b/hw/i386/acpi-common=2Eh
>index b3c56ee014=2E=2Ee305aaac15 100644
>--- a/hw/i386/acpi-common=2Eh
>+++ b/hw/i386/acpi-common=2Eh
>@@ -1,12 +1,15 @@
> #ifndef HW_I386_ACPI_COMMON_H
> #define HW_I386_ACPI_COMMON_H
>=20
>+#include "hw/boards=2Eh"
> #include "hw/acpi/bios-linker-loader=2Eh"
> #include "hw/i386/x86=2Eh"
>=20
> /* Default IOAPIC ID */
> #define ACPI_BUILD_IOAPIC_ID 0x0
>=20
>+void pc_madt_cpu_entry(int uid, const CPUArchIdList *apic_ids,

Since the function is apparently not pc but rather x86-specific: Does it m=
ake sense to rename the function as well, e=2Eg=2E to x86_madt_cpu_entry()?

Best regards,
Bernhard

>+                       GArray *entry, bool force_enabled);
> void acpi_build_madt(GArray *table_data, BIOSLinker *linker,
>                      X86MachineState *x86ms,
>                      const char *oem_id, const char *oem_table_id);
>diff --git a/include/hw/i386/pc=2Eh b/include/hw/i386/pc=2Eh
>index f9fc42c2be=2E=2Ece442372ac 100644
>--- a/include/hw/i386/pc=2Eh
>+++ b/include/hw/i386/pc=2Eh
>@@ -199,10 +199,6 @@ bool pc_system_ovmf_table_find(const char *entry, ui=
nt8_t **data,
>                                int *data_len);
> void pc_system_parse_ovmf_flash(uint8_t *flash_ptr, size_t flash_size);
>=20
>-/* hw/i386/acpi-common=2Ec */
>-void pc_madt_cpu_entry(int uid, const CPUArchIdList *apic_ids,
>-                       GArray *entry, bool force_enabled);
>-
> /* sgx=2Ec */
> void pc_machine_init_sgx_epc(PCMachineState *pcms);
>=20
>diff --git a/hw/i386/acpi-common=2Ec b/hw/i386/acpi-common=2Ec
>index 43dc23f7e0=2E=2Ef1a11f833a 100644
>--- a/hw/i386/acpi-common=2Ec
>+++ b/hw/i386/acpi-common=2Ec
>@@ -27,7 +27,6 @@
> #include "hw/acpi/acpi=2Eh"
> #include "hw/acpi/aml-build=2Eh"
> #include "hw/acpi/utils=2Eh"
>-#include "hw/i386/pc=2Eh"
> #include "target/i386/cpu=2Eh"
>=20
> #include "acpi-build=2Eh"

