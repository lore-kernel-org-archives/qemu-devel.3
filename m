Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 458CDC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 03:48:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1I06-0005Cj-CI; Sun, 28 Apr 2024 23:48:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s1I02-0005B1-TX; Sun, 28 Apr 2024 23:48:18 -0400
Received: from mail-vk1-xa35.google.com ([2607:f8b0:4864:20::a35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s1I00-0007h1-Uw; Sun, 28 Apr 2024 23:48:18 -0400
Received: by mail-vk1-xa35.google.com with SMTP id
 71dfb90a1353d-4dae34a3806so2597260e0c.1; 
 Sun, 28 Apr 2024 20:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714362495; x=1714967295; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=55S/S/yyd+TxD7aU3CfyTrMkvFHQAVoFmAq7tATJcV0=;
 b=TrzSRDZgLD2ZfDV6qmX8lC+IZwGzeX1KCOCh5CbBusPeeTHR2x2iKHhHDD4cFZllIY
 gSbuQ40hWGiwnBHPVdVV99Uk63ZGAuV4KtzvvyaPOl+VPwLVUo6pxR0F8TeB9KndVPam
 lf2ZjWmaMNJ8znvxfzTN08NXG620nLO6KioNyhUDLAxNKWh6vwXHn14yEf5sjNF9Qys0
 v0fH0Tc+qHtUL4NUAZsUAJmNCD1uyw2ktbXwUrJqBYO5OHFvEMTB/qfiwVaSn2ywl1Bo
 A5zyKqEY+WQo073a8wLznHHr6S0YGgDMXMYAaQZLFSv+2CGATrH0HUE1g363AEr/CJVX
 ERDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714362495; x=1714967295;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=55S/S/yyd+TxD7aU3CfyTrMkvFHQAVoFmAq7tATJcV0=;
 b=moVnbcD9lUxLo6+TXG5HMje/CjWL9yDMWEv9HcvtQr/YuZ67MkXsRxgEe6ymTsMob7
 z8mbT5oYyjXG53YOcGVGmK7MsW7ved5Xf8XugJISAR+TExmjUpcAlGcNYbadChhfOF4d
 9nJTaYSiWJ+Ng0dcLTtifW/N866Q0J86uxfB1CfXNMZ7CAk9rii7iC1luozUH+9p6K0y
 0I8/8n+8CiNr0QA643kNxk29iMHzQxFgkU6mRkJJM9wH6d0QudDlL5n0BxbRGYJZ2M4A
 bPRRdQIFU1nm8ZhpZUC50C42sePEcl46SxW1v4RrWZNQTgpu7mx8wXRRKAG/g+wW+Ig7
 wK7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6r1vOqmy5vSaHsQwN8/6y/vEY3VcH/81RyP/7JUMsGKjMjEWxg+6V6m0LtHVZeKmxnCN1ipmvAfHGRnUEVi+qYtCY4vhCFMMsTJ2PTbVFwFi88FSB5VT4cJw=
X-Gm-Message-State: AOJu0YygC4p2QZV2PocsWDUp18XzI3WaXSjX5t8TU6zSXjrhPjbewffN
 2WiIyHIlyC8SfWqyEnpZAlDiQkVwnTUKDH9YYPeSzqfAYqAVM8j3DH8uhoFwu1T4JqTPyB/fYSn
 xGq/YIqqWcTIt1tmeP9tndrz2M0w=
X-Google-Smtp-Source: AGHT+IHukdUxMIQ4gJiFOPwl8Td9nq8aXFwmrGnFLHjyO8vtiNgkLcb8FcBpVSldQtmQwybqj8Ws3z7SYFQr4E5Hu8k=
X-Received: by 2002:a05:6122:2b2:b0:4da:ddb4:feca with SMTP id
 18-20020a05612202b200b004daddb4fecamr6070746vkq.8.1714362494807; Sun, 28 Apr
 2024 20:48:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240315130924.2378849-1-sunilvl@ventanamicro.com>
 <20240315130924.2378849-5-sunilvl@ventanamicro.com>
In-Reply-To: <20240315130924.2378849-5-sunilvl@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 29 Apr 2024 13:47:48 +1000
Message-ID: <CAKmqyKNHKH9bqhLPaHL0rh_GyNBycxQni+CiQmqahYoSKd-W6w@mail.gmail.com>
Subject: Re: [PATCH 07/12] tests/data/acpi/virt: Move ACPI tables under aarch64
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>, 
 Anup Patel <apatel@ventanamicro.com>, Haibo1 Xu <haibo1.xu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a35;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa35.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Fri, Mar 15, 2024 at 11:09=E2=80=AFPM Sunil V L <sunilvl@ventanamicro.co=
m> wrote:
>
> Since virt is a common machine name across architectures like ARM64 and
> RISC-V, move existing ARM64 ACPI tables under aarch64 folder so that
> RISC-V tables can be added under riscv64 folder in future.
>
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  tests/data/acpi/virt/{ =3D> aarch64}/APIC             | Bin
>  .../data/acpi/virt/{ =3D> aarch64}/APIC.acpihmatvirt  | Bin
>  tests/data/acpi/virt/{ =3D> aarch64}/APIC.topology    | Bin
>  tests/data/acpi/virt/{ =3D> aarch64}/DBG2             | Bin
>  tests/data/acpi/virt/{ =3D> aarch64}/DSDT             | Bin
>  .../data/acpi/virt/{ =3D> aarch64}/DSDT.acpihmatvirt  | Bin
>  tests/data/acpi/virt/{ =3D> aarch64}/DSDT.memhp       | Bin
>  tests/data/acpi/virt/{ =3D> aarch64}/DSDT.pxb         | Bin
>  tests/data/acpi/virt/{ =3D> aarch64}/DSDT.topology    | Bin
>  tests/data/acpi/virt/{ =3D> aarch64}/FACP             | Bin
>  tests/data/acpi/virt/{ =3D> aarch64}/GTDT             | Bin
>  .../data/acpi/virt/{ =3D> aarch64}/HMAT.acpihmatvirt  | Bin
>  tests/data/acpi/virt/{ =3D> aarch64}/IORT             | Bin
>  tests/data/acpi/virt/{ =3D> aarch64}/MCFG             | Bin
>  tests/data/acpi/virt/{ =3D> aarch64}/NFIT.memhp       | Bin
>  tests/data/acpi/virt/{ =3D> aarch64}/PPTT             | Bin
>  .../data/acpi/virt/{ =3D> aarch64}/PPTT.acpihmatvirt  | Bin
>  tests/data/acpi/virt/{ =3D> aarch64}/PPTT.topology    | Bin
>  tests/data/acpi/virt/{ =3D> aarch64}/SLIT.memhp       | Bin
>  tests/data/acpi/virt/{ =3D> aarch64}/SPCR             | Bin
>  .../data/acpi/virt/{ =3D> aarch64}/SRAT.acpihmatvirt  | Bin
>  tests/data/acpi/virt/{ =3D> aarch64}/SRAT.memhp       | Bin
>  tests/data/acpi/virt/{ =3D> aarch64}/SRAT.numamem     | Bin
>  tests/data/acpi/virt/{ =3D> aarch64}/SSDT.memhp       | Bin
>  tests/data/acpi/virt/{ =3D> aarch64}/VIOT             | Bin
>  25 files changed, 0 insertions(+), 0 deletions(-)
>  rename tests/data/acpi/virt/{ =3D> aarch64}/APIC (100%)
>  rename tests/data/acpi/virt/{ =3D> aarch64}/APIC.acpihmatvirt (100%)
>  rename tests/data/acpi/virt/{ =3D> aarch64}/APIC.topology (100%)
>  rename tests/data/acpi/virt/{ =3D> aarch64}/DBG2 (100%)
>  rename tests/data/acpi/virt/{ =3D> aarch64}/DSDT (100%)
>  rename tests/data/acpi/virt/{ =3D> aarch64}/DSDT.acpihmatvirt (100%)
>  rename tests/data/acpi/virt/{ =3D> aarch64}/DSDT.memhp (100%)
>  rename tests/data/acpi/virt/{ =3D> aarch64}/DSDT.pxb (100%)
>  rename tests/data/acpi/virt/{ =3D> aarch64}/DSDT.topology (100%)
>  rename tests/data/acpi/virt/{ =3D> aarch64}/FACP (100%)
>  rename tests/data/acpi/virt/{ =3D> aarch64}/GTDT (100%)
>  rename tests/data/acpi/virt/{ =3D> aarch64}/HMAT.acpihmatvirt (100%)
>  rename tests/data/acpi/virt/{ =3D> aarch64}/IORT (100%)
>  rename tests/data/acpi/virt/{ =3D> aarch64}/MCFG (100%)
>  rename tests/data/acpi/virt/{ =3D> aarch64}/NFIT.memhp (100%)
>  rename tests/data/acpi/virt/{ =3D> aarch64}/PPTT (100%)
>  rename tests/data/acpi/virt/{ =3D> aarch64}/PPTT.acpihmatvirt (100%)
>  rename tests/data/acpi/virt/{ =3D> aarch64}/PPTT.topology (100%)
>  rename tests/data/acpi/virt/{ =3D> aarch64}/SLIT.memhp (100%)
>  rename tests/data/acpi/virt/{ =3D> aarch64}/SPCR (100%)
>  rename tests/data/acpi/virt/{ =3D> aarch64}/SRAT.acpihmatvirt (100%)
>  rename tests/data/acpi/virt/{ =3D> aarch64}/SRAT.memhp (100%)
>  rename tests/data/acpi/virt/{ =3D> aarch64}/SRAT.numamem (100%)
>  rename tests/data/acpi/virt/{ =3D> aarch64}/SSDT.memhp (100%)
>  rename tests/data/acpi/virt/{ =3D> aarch64}/VIOT (100%)
>
> diff --git a/tests/data/acpi/virt/APIC b/tests/data/acpi/virt/aarch64/API=
C
> similarity index 100%
> rename from tests/data/acpi/virt/APIC
> rename to tests/data/acpi/virt/aarch64/APIC
> diff --git a/tests/data/acpi/virt/APIC.acpihmatvirt b/tests/data/acpi/vir=
t/aarch64/APIC.acpihmatvirt
> similarity index 100%
> rename from tests/data/acpi/virt/APIC.acpihmatvirt
> rename to tests/data/acpi/virt/aarch64/APIC.acpihmatvirt
> diff --git a/tests/data/acpi/virt/APIC.topology b/tests/data/acpi/virt/aa=
rch64/APIC.topology
> similarity index 100%
> rename from tests/data/acpi/virt/APIC.topology
> rename to tests/data/acpi/virt/aarch64/APIC.topology
> diff --git a/tests/data/acpi/virt/DBG2 b/tests/data/acpi/virt/aarch64/DBG=
2
> similarity index 100%
> rename from tests/data/acpi/virt/DBG2
> rename to tests/data/acpi/virt/aarch64/DBG2
> diff --git a/tests/data/acpi/virt/DSDT b/tests/data/acpi/virt/aarch64/DSD=
T
> similarity index 100%
> rename from tests/data/acpi/virt/DSDT
> rename to tests/data/acpi/virt/aarch64/DSDT
> diff --git a/tests/data/acpi/virt/DSDT.acpihmatvirt b/tests/data/acpi/vir=
t/aarch64/DSDT.acpihmatvirt
> similarity index 100%
> rename from tests/data/acpi/virt/DSDT.acpihmatvirt
> rename to tests/data/acpi/virt/aarch64/DSDT.acpihmatvirt
> diff --git a/tests/data/acpi/virt/DSDT.memhp b/tests/data/acpi/virt/aarch=
64/DSDT.memhp
> similarity index 100%
> rename from tests/data/acpi/virt/DSDT.memhp
> rename to tests/data/acpi/virt/aarch64/DSDT.memhp
> diff --git a/tests/data/acpi/virt/DSDT.pxb b/tests/data/acpi/virt/aarch64=
/DSDT.pxb
> similarity index 100%
> rename from tests/data/acpi/virt/DSDT.pxb
> rename to tests/data/acpi/virt/aarch64/DSDT.pxb
> diff --git a/tests/data/acpi/virt/DSDT.topology b/tests/data/acpi/virt/aa=
rch64/DSDT.topology
> similarity index 100%
> rename from tests/data/acpi/virt/DSDT.topology
> rename to tests/data/acpi/virt/aarch64/DSDT.topology
> diff --git a/tests/data/acpi/virt/FACP b/tests/data/acpi/virt/aarch64/FAC=
P
> similarity index 100%
> rename from tests/data/acpi/virt/FACP
> rename to tests/data/acpi/virt/aarch64/FACP
> diff --git a/tests/data/acpi/virt/GTDT b/tests/data/acpi/virt/aarch64/GTD=
T
> similarity index 100%
> rename from tests/data/acpi/virt/GTDT
> rename to tests/data/acpi/virt/aarch64/GTDT
> diff --git a/tests/data/acpi/virt/HMAT.acpihmatvirt b/tests/data/acpi/vir=
t/aarch64/HMAT.acpihmatvirt
> similarity index 100%
> rename from tests/data/acpi/virt/HMAT.acpihmatvirt
> rename to tests/data/acpi/virt/aarch64/HMAT.acpihmatvirt
> diff --git a/tests/data/acpi/virt/IORT b/tests/data/acpi/virt/aarch64/IOR=
T
> similarity index 100%
> rename from tests/data/acpi/virt/IORT
> rename to tests/data/acpi/virt/aarch64/IORT
> diff --git a/tests/data/acpi/virt/MCFG b/tests/data/acpi/virt/aarch64/MCF=
G
> similarity index 100%
> rename from tests/data/acpi/virt/MCFG
> rename to tests/data/acpi/virt/aarch64/MCFG
> diff --git a/tests/data/acpi/virt/NFIT.memhp b/tests/data/acpi/virt/aarch=
64/NFIT.memhp
> similarity index 100%
> rename from tests/data/acpi/virt/NFIT.memhp
> rename to tests/data/acpi/virt/aarch64/NFIT.memhp
> diff --git a/tests/data/acpi/virt/PPTT b/tests/data/acpi/virt/aarch64/PPT=
T
> similarity index 100%
> rename from tests/data/acpi/virt/PPTT
> rename to tests/data/acpi/virt/aarch64/PPTT
> diff --git a/tests/data/acpi/virt/PPTT.acpihmatvirt b/tests/data/acpi/vir=
t/aarch64/PPTT.acpihmatvirt
> similarity index 100%
> rename from tests/data/acpi/virt/PPTT.acpihmatvirt
> rename to tests/data/acpi/virt/aarch64/PPTT.acpihmatvirt
> diff --git a/tests/data/acpi/virt/PPTT.topology b/tests/data/acpi/virt/aa=
rch64/PPTT.topology
> similarity index 100%
> rename from tests/data/acpi/virt/PPTT.topology
> rename to tests/data/acpi/virt/aarch64/PPTT.topology
> diff --git a/tests/data/acpi/virt/SLIT.memhp b/tests/data/acpi/virt/aarch=
64/SLIT.memhp
> similarity index 100%
> rename from tests/data/acpi/virt/SLIT.memhp
> rename to tests/data/acpi/virt/aarch64/SLIT.memhp
> diff --git a/tests/data/acpi/virt/SPCR b/tests/data/acpi/virt/aarch64/SPC=
R
> similarity index 100%
> rename from tests/data/acpi/virt/SPCR
> rename to tests/data/acpi/virt/aarch64/SPCR
> diff --git a/tests/data/acpi/virt/SRAT.acpihmatvirt b/tests/data/acpi/vir=
t/aarch64/SRAT.acpihmatvirt
> similarity index 100%
> rename from tests/data/acpi/virt/SRAT.acpihmatvirt
> rename to tests/data/acpi/virt/aarch64/SRAT.acpihmatvirt
> diff --git a/tests/data/acpi/virt/SRAT.memhp b/tests/data/acpi/virt/aarch=
64/SRAT.memhp
> similarity index 100%
> rename from tests/data/acpi/virt/SRAT.memhp
> rename to tests/data/acpi/virt/aarch64/SRAT.memhp
> diff --git a/tests/data/acpi/virt/SRAT.numamem b/tests/data/acpi/virt/aar=
ch64/SRAT.numamem
> similarity index 100%
> rename from tests/data/acpi/virt/SRAT.numamem
> rename to tests/data/acpi/virt/aarch64/SRAT.numamem
> diff --git a/tests/data/acpi/virt/SSDT.memhp b/tests/data/acpi/virt/aarch=
64/SSDT.memhp
> similarity index 100%
> rename from tests/data/acpi/virt/SSDT.memhp
> rename to tests/data/acpi/virt/aarch64/SSDT.memhp
> diff --git a/tests/data/acpi/virt/VIOT b/tests/data/acpi/virt/aarch64/VIO=
T
> similarity index 100%
> rename from tests/data/acpi/virt/VIOT
> rename to tests/data/acpi/virt/aarch64/VIOT
> --
> 2.40.1
>

