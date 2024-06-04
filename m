Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B965C27C50
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 23:10:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEdHz-0001Oi-WA; Tue, 04 Jun 2024 19:10:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEdHy-0001O2-HV; Tue, 04 Jun 2024 19:09:58 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEdHu-0003OT-H3; Tue, 04 Jun 2024 19:09:58 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2e95a883101so79218251fa.3; 
 Tue, 04 Jun 2024 16:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717542590; x=1718147390; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rrpdjyQf8pCzn8J8GCatCbCiIcT9arpQz49iDaapx1E=;
 b=gV6pGhH/emnIGJqQzKcx10eLhOAr6re35SinUaGzKgkxaPWU9hi6qHoO+A3jCpPM1J
 W5hhqGGNYHU+hsPCqIYHSHfRrE+mA9avSIOLzi8xgoO8dkNHHdObGCk+J+r7ugfJNEKY
 2vppnAsN/IfIfNxInrNuTn/q+wQxf61mz21EAL/Vs8sYPF3LyfaAmMBaefFNt3wki2r6
 8YR+1wGXpBojJjPiIS/QCK4OFuit/40VJdf9fjKs1ySMV1go7VAgtrRlW6pzrFtve5jl
 y/hv3vd+thd4WJrzDsgoju9Rmb1EWl8u9+fzYDjsnVdggC9HoOGl02WpLOw7Q45e70XD
 6EVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717542590; x=1718147390;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rrpdjyQf8pCzn8J8GCatCbCiIcT9arpQz49iDaapx1E=;
 b=XVDFPia7eVUi8Z+ecoeCsBwTgEAiQ/6FyrN/W92sRKUgu5JdmZ4S6VQ/0Hapld89/D
 gHKLlt06GvE7b4Jgz87X4n3lEuxGPdUCm7q964ZOjJg/Vzegzu6CUCD3/GAaDddd9Pn5
 0E53KwIjuysntF1yBkmZRMnJtnuVzlZ0bvCkRlB9oA4eRDROQWByWU2NpMuR1o6w4Lif
 q5KBbziEa2uVrCFSSICuFMAIMPduLEAdVw7ER1dEt2jta5AOvX+4KVR9ofbRiJ+T71BK
 ds8XGJcCPXelOPXsE765tvRsQcmWut3uLqLjiI9iz7oCSzeMk6mHyL7Jm2rWuiCxcmvU
 xU8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJ0LE1w+xy588tv6IL+oYcnyi2/UZcPG5RiQcPGft4w1tV68Ic6ZQT6jF7T05AFLpGhcCXqNTrw2zql9rRWZEJ3DZvxC0=
X-Gm-Message-State: AOJu0Yx4nFk/Dqa+6MohLu24IpsksG6iL/+tIT85WdWDwfWfwz/iS/bh
 coud9B7x4ey1YzMHFpxQUfsFC7+mPuH56+5cuh5toi2Ak7DLR02wF2LqYrA4tKclqTmf/UJGX7R
 tyW2ST5qdwtHGPXWJUlBnkmiSh+o=
X-Google-Smtp-Source: AGHT+IE8Y4O3jfplr7D+6qK64u8tjppA3lq+RF/Et9C/s3N8WjChHhm9mD+4c3G+wY9EGSoKN3br/GjC5CX2ZJIhA5g=
X-Received: by 2002:a2e:99c5:0:b0:2e0:c689:f8cd with SMTP id
 38308e7fff4ca-2eac7a122d0mr3403401fa.29.1717542589673; Tue, 04 Jun 2024
 16:09:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240528073103.1075812-1-sunilvl@ventanamicro.com>
 <20240528073103.1075812-4-sunilvl@ventanamicro.com>
In-Reply-To: <20240528073103.1075812-4-sunilvl@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 5 Jun 2024 09:09:22 +1000
Message-ID: <CAKmqyKM6T2z2VAa4=RoyrK-_p5TUgvS3noHT4jKr76rSHPsCrQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] hw/riscv/virt-acpi-build.c: Update the HID of RISC-V
 UART
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=alistair23@gmail.com; helo=mail-lj1-x236.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Tue, May 28, 2024 at 5:32=E2=80=AFPM Sunil V L <sunilvl@ventanamicro.com=
> wrote:
>
> RISC-V is going to use new HID RSCV0003 for generi UART. So, update the
> HID.
>
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/virt-acpi-build.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
> index 47ec78e432..7f80368415 100644
> --- a/hw/riscv/virt-acpi-build.c
> +++ b/hw/riscv/virt-acpi-build.c
> @@ -192,7 +192,7 @@ acpi_dsdt_add_uart(Aml *scope, const MemMapEntry *uar=
t_memmap,
>                      uint32_t uart_irq)
>  {
>      Aml *dev =3D aml_device("COM0");
> -    aml_append(dev, aml_name_decl("_HID", aml_string("PNP0501")));
> +    aml_append(dev, aml_name_decl("_HID", aml_string("RSCV0003")));
>      aml_append(dev, aml_name_decl("_UID", aml_int(0)));
>
>      Aml *crs =3D aml_resource_template();
> --
> 2.40.1
>
>

