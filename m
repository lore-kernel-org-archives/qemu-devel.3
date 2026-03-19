Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C78107526E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 07:28:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w37n7-0005bD-5K; Thu, 19 Mar 2026 03:27:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1w37mt-0005Yt-KR
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 03:27:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1w37mp-0000E6-R5
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 03:27:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773905238;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SiYrwjNH9gHo6RNCEoGyoSEPAzrVg+V7o4avcRI5xxU=;
 b=SyxMq7gLPe+AOCNxOFbRyVD1JMizq+p0N/PEYfqas36x2PrtGIoDCRDFndiE0/Qqx9CKGW
 DbR8LDwHmB9yFXd7Qsxmjvuwz5pXSTSo5qur8r9c41P5e+/ARW7/kREaOsgnDQhYRIl6zl
 L3Xe6O6AHu5sjA3zGJGRLyHhAL25P9M=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-mxUkIcXGNPiUgQqAshoPkw-1; Thu, 19 Mar 2026 03:27:16 -0400
X-MC-Unique: mxUkIcXGNPiUgQqAshoPkw-1
X-Mimecast-MFC-AGG-ID: mxUkIcXGNPiUgQqAshoPkw_1773905236
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2adc527eaf5so7393425ad.0
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 00:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773905235; x=1774510035; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SiYrwjNH9gHo6RNCEoGyoSEPAzrVg+V7o4avcRI5xxU=;
 b=sOrY6hel3B7oYNSVksexPJIgMdrsylVAFnRT71v3/+Cv87bHWmLqpqJUo+OTxVFqqL
 hx/7xZSCpU+fpMUMwoBsbJjkSXJidms+aV/kAocaf4NOzxdCfDBn4OvVDzPnRIX/1RTG
 snnMUduqbIKzT8Nv/8YHH+iuS9COe1YJHmcYR3+uscombGLvl5xAz6+A7s07tJdDQE2a
 EEbrWR+17BcgzJ9e9ftVaj+/IOUC51gnlFdtEgnahrd6MYhvrocITk+rxbhcZhSyCZFy
 m62IGCzWM1VWf/rcuAzIVpA9ebmDgPBx9PRhRTQ48FbxZJcktAHGQUcqETnvItj39qJH
 AaHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773905235; x=1774510035;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SiYrwjNH9gHo6RNCEoGyoSEPAzrVg+V7o4avcRI5xxU=;
 b=cHO9Vmi+n02ppjXfmFnbMx3f+BElaU0C5qI53k/zH3Y1yg4OtqCrQ/vd4lyOACy+1n
 HFzUhfMGcfY+6dmG4Iu/ltJKGrHquhpAz/EkxgCS7E16rnjOumab4kieiCidmaEnq5Is
 fycrVR9v76a9Rh1kNTKDLxggZneeDMgWxZrwF5/rzqgHsSPcAdVTqOIq2EszbTWhV+AU
 HB0nMOu20E6WeeUkKqXCQB4gZAcrdKxvtKfSbObyIC/wfiL3ABYhdOhBnULF6KqeSA3J
 WeFwsqnTt8pQeR2KN+a9RUYvodDYb9RJ5lkca1ngu3kEK45Txm/RQC9AUM7i8TOHhlSL
 2H2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUz0+qecfGrHFhmHYiDcfwgohfutkux2Irr3emokvhkSZCRpSAcriRgtXNn44tQPZRSiopMgf4vHUF0@nongnu.org
X-Gm-Message-State: AOJu0Yx8N1szg/TPenfcg1fvx0P44jsNae9xbiul4JPSKalDEwpVht8y
 uuEpMVdHtjroIWmMDQHjaaXbTZwiN75IB84D6LfcELh/I74Tss3Aw50Yq6JAhEZ7AY2/1nH5R5s
 UeBA0nI2XAa/oq60mTmiqOmGFckkv+v9IuWuqbM7AzAqbiFY1sWD5Srlw
X-Gm-Gg: ATEYQzznbS4ICAp9qUzKTDEtjRqrzZ8XlsdhSYsCaxNqPCIJ4CxVA1BL16XW9KY0l1G
 38QbMn2O6/meBmpxIZBjx7jpn43m1k86zM/F1BaFryRFuDeOZZ1VyN9Riic62xXBQklhZCTU7rf
 X6XpP8GjyhhUr4HxApKvDuot8elPFFzd5DMe5VyuWyUpIAockVhgJwHWNoprwYv1/dYIhO5tMnp
 BCOi1Y92uo96wVEicfgph9BZIVLyXYL/HMduKuyO+sFfU0wk24iiOw10SyMP64YzvXE/CY2T2mR
 CLFtPc3DAu/BIkxf0cyirPzEQ+Qm1uaBwcexSWrotgUle4sBvDiomAlL8ODNzSLyLWpeQB024gr
 DRH0GAw6kiXfq52mcolbRAYNLyHahl6+7U1T7gAP1mwmoXIZhrYZ13oDUxW5e8bzBVw8UKw==
X-Received: by 2002:a17:902:e787:b0:2ae:fc60:2651 with SMTP id
 d9443c01a7336-2b06e3e4353mr55404225ad.35.1773905235554; 
 Thu, 19 Mar 2026 00:27:15 -0700 (PDT)
X-Received: by 2002:a17:902:e787:b0:2ae:fc60:2651 with SMTP id
 d9443c01a7336-2b06e3e4353mr55403975ad.35.1773905235116; 
 Thu, 19 Mar 2026 00:27:15 -0700 (PDT)
Received: from smtpclient.apple ([122.163.114.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b06e41927bsm64606295ad.10.2026.03.19.00.27.11
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 19 Mar 2026 00:27:14 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [PATCH v6 RESEND 3/4] hw/riscv/virt: add system_powerdown hmp
 command support
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20260319110646912lfH-Px_D4YbtX1Q7ZRSXc@zte.com.cn>
Date: Thu, 19 Mar 2026 12:56:58 +0530
Cc: Michael Tsirkin <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, palmer@dabbelt.com,
 Alistair Francis <alistair.francis@wdc.com>, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 sunilvl@ventanamicro.com, qemu-riscv@nongnu.org,
 qemu-devel <qemu-devel@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <495B8049-E563-41C2-8B53-D965517C7284@redhat.com>
References: <20260319110005712RbJuYoQlyLGr39EPL4uH4@zte.com.cn>
 <20260319110646912lfH-Px_D4YbtX1Q7ZRSXc@zte.com.cn>
To: liu.xuemei1@zte.com.cn
X-Mailer: Apple Mail (2.3826.700.81.1.4)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



> On 19 Mar 2026, at 8:36=E2=80=AFAM, liu.xuemei1@zte.com.cn wrote:
>=20
> From: Xuemei Liu <liu.xuemei1@zte.com.cn>
>=20
> For riscv virt machine, add powerdown notification callback
> and send ACPI_POWER_DOWN_STATUS event by acpi ged. Also add
> acpi dsdt table for ACPI_POWER_BUTTON_DEVICE device in this
> patch.
>=20
> Signed-off-by: Xuemei Liu <liu.xuemei1@zte.com.cn>

Reviewed-by: Ani Sinha <anisinha@redhat.com>

> ---
> hw/riscv/virt-acpi-build.c |  2 ++
> hw/riscv/virt.c            | 14 ++++++++++++++
> include/hw/riscv/virt.h    |  1 +
> 3 files changed, 17 insertions(+)
>=20
> diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
> index 1717b1c24f..77aea55ece 100644
> --- a/hw/riscv/virt-acpi-build.c
> +++ b/hw/riscv/virt-acpi-build.c
> @@ -504,6 +504,8 @@ static void build_dsdt(GArray *table_data,
>                   ACPI_GED_IRQ, AML_SYSTEM_MEMORY,
>                   s->memmap[VIRT_ACPI_GED].base);
>=20
> +    acpi_dsdt_add_power_button(scope);
> +
>     aml_append(dsdt, scope);
>=20
>     /* copy AML table into ACPI tables blob and patch header there */
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 4f1654d5ec..20002c6e43 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -51,6 +51,7 @@
> #include "system/kvm.h"
> #include "system/tpm.h"
> #include "system/qtest.h"
> +#include "system/runstate.h"
> #include "hw/pci/pci.h"
> #include "hw/pci-host/gpex.h"
> #include "hw/display/ramfb.h"
> @@ -1446,6 +1447,16 @@ static void virt_build_smbios(RISCVVirtState =
*s)
>     }
> }
>=20
> +static void virt_powerdown_req(Notifier *notifier, void *opaque)
> +{
> +    RISCVVirtState *s;
> +
> +    s =3D container_of(notifier, RISCVVirtState, powerdown_notifier);
> +    if (s->acpi_ged) {
> +        acpi_send_event(s->acpi_ged, ACPI_POWER_DOWN_STATUS);
> +    }
> +}
> +
> static void virt_machine_done(Notifier *notifier, void *data)
> {
>     RISCVVirtState *s =3D container_of(notifier, RISCVVirtState,
> @@ -1773,6 +1784,9 @@ static void virt_machine_init(MachineState =
*machine)
>         sysbus_realize_and_unref(SYS_BUS_DEVICE(iommu_sys), =
&error_fatal);
>     }
>=20
> +    s->powerdown_notifier.notify =3D virt_powerdown_req;
> +    qemu_register_powerdown_notifier(&s->powerdown_notifier);
> +
>     s->machine_done.notify =3D virt_machine_done;
>     qemu_add_machine_init_done_notifier(&s->machine_done);
> }
> diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
> index 9ea0b3b7b6..e631d57268 100644
> --- a/include/hw/riscv/virt.h
> +++ b/include/hw/riscv/virt.h
> @@ -47,6 +47,7 @@ struct RISCVVirtState {
>=20
>     /*< public >*/
>     Notifier machine_done;
> +    Notifier powerdown_notifier;
>     DeviceState *acpi_ged;
>     DeviceState *platform_bus_dev;
>     RISCVHartArrayState soc[VIRT_SOCKETS_MAX];
> --=20
> 2.27.0
>=20


