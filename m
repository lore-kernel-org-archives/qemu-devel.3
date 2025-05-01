Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46C96C369D9
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 00:04:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAHPD-0003cC-7c; Wed, 30 Apr 2025 20:03:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uAHPA-0003Ws-Jb; Wed, 30 Apr 2025 20:03:56 -0400
Received: from mail-qt1-x835.google.com ([2607:f8b0:4864:20::835])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uAHP9-0001qV-5H; Wed, 30 Apr 2025 20:03:56 -0400
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-476b4c9faa2so7078821cf.3; 
 Wed, 30 Apr 2025 17:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746057834; x=1746662634; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zU6JZdFla0IcCk/xejufS4v1AMnlPtufAZV2BNDWTQA=;
 b=Q0GM2viRLqDjEV3B55IfFGtWgnxIUosc9XUCz2uWizmj0tyWVGj725YrDDDgusM0wz
 d2FQbttEJMzBZxxsv07PhP0eiUx1M8jo5dUoSYm0IAodZSwhXXGd+eQM0XyQxgwEmZVq
 xJiitvNSQ5bkdtCbxoNTgVVirpHgPB9UpCK+QDpLM6VZUDXFc8pAQi6Z+SJACtolqCSU
 n1sONKW5kEzhZ60qoroKbUwCWw6+hXsfS8zyrDqIhoYL2mvVd/hb/vQ2cMhpSV2t5nhi
 7xNGkLzjDuiADXZTzJiPWW4ha3gf06jLRcFhTy3I8GbuqSDgGOBUh96vP339kiw+lMET
 ZoOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746057834; x=1746662634;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zU6JZdFla0IcCk/xejufS4v1AMnlPtufAZV2BNDWTQA=;
 b=WF2knvm9hqH2LxDGU7M8fkpeFCtm+41/AHWT3ZIFx4EFlq0QMpPy5n1wElwkWht+yW
 PkH0GD/kyON2g/Ewqwv8Y0OUAKw4VBlkPUtk20z5DqFy841v+hrOdfeChOdTVeh0XN/t
 ETn9jEQRc7FAYADViAzsgBfe0S5hO2CHxEE/dqY5JdtOuMs1ICzDQLlH+vSLeIkrcvbw
 7tF1OJcxqwbuxvHwE0jPKXUsqhBHXjkUnxlz0WsnX1yp44Zvj3l+O4XBvXQcy1mrdjG8
 ewzqzdVmntkVaOwAsHo18eOIgoCi6QP5TjPTsn9/4J9EtF1Z7gERRWnjNEYCoRwhieeJ
 T/4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3Cd4t9TsNoo2gLYe9HCssIUvUhgQX/0F/N7NCaMFj2k9ktqB8SMCAmrABXkvLrfCkTMLdlOLDxylu@nongnu.org
X-Gm-Message-State: AOJu0Yw9dC2GKv9Fhtmxo6EtcEv/H5ZWZr+n6Nf4W320bFMS+EVpbXaP
 NU4Jhl+lRGcs2NepP8qwH//j+3X4xDfhrSzfImjkjTcKKwuJ0xnKzJFxVErabsATB40DAsb4AId
 V/V0CDEgNeFLBYnnT+cTOMJ8SH9s=
X-Gm-Gg: ASbGncvp7TMNfUj0uL91x0vfNJImecX0WAv5qWD4y7U6R0yjZfFxz74FLK6vEUO8ZI1
 wiGhrQ+6Y4jTpeAbzpAiyfgUYVFJLaGRnKQAHSHrzYD4Lti/m75+fImYzV9kITVsAOQCgeqh4Vh
 td+vYzt7Ct9TClQ270uEske0bb+PI/S0FvoAPA/WrDEkTJcK7Tz1HR
X-Google-Smtp-Source: AGHT+IF/Rus/i+nHEXDYoaNzElN+fhs4z33D2FcvufDyBzr9JF/7dQhJPBF0lVSKnx4vDOic2eB0TRg5oA2tXryCl7A=
X-Received: by 2002:a05:622a:114f:b0:476:7806:be7e with SMTP id
 d75a77b69052e-48b20580542mr6641361cf.11.1746057833845; Wed, 30 Apr 2025
 17:03:53 -0700 (PDT)
MIME-Version: 1.0
References: <20250429125811.224803-1-dbarboza@ventanamicro.com>
 <20250429125811.224803-5-dbarboza@ventanamicro.com>
In-Reply-To: <20250429125811.224803-5-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 1 May 2025 10:03:27 +1000
X-Gm-Features: ATxdqUEfUnC4h2oDKpazZv8IKGMGrs6XfVL0Q_6M3ku9871CAFjJee5Hm3pLIIo
Message-ID: <CAKmqyKPMDRnLvrBBD-Y8suF44ieZb8EPmdxTXYy=za4=28bdVA@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] hw/riscv/virt.c: add 'base' arg in create_fw_cfg()
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com, 
 joel@jms.id.au, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::835;
 envelope-from=alistair23@gmail.com; helo=mail-qt1-x835.google.com
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

On Tue, Apr 29, 2025 at 11:00=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> The function can receive the value via s->memmap[VIRT_FW_CFG].base from
> the caller, avoiding the use of virt_memmap.
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/virt.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index f324777161..37f8abdd1c 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -1261,9 +1261,8 @@ static inline DeviceState *gpex_pcie_init(MemoryReg=
ion *sys_mem,
>      return dev;
>  }
>
> -static FWCfgState *create_fw_cfg(const MachineState *ms)
> +static FWCfgState *create_fw_cfg(const MachineState *ms, hwaddr base)
>  {
> -    hwaddr base =3D virt_memmap[VIRT_FW_CFG].base;
>      FWCfgState *fw_cfg;
>
>      fw_cfg =3D fw_cfg_init_mem_wide(base + 8, base, 8, base + 16,
> @@ -1681,7 +1680,7 @@ static void virt_machine_init(MachineState *machine=
)
>       * Init fw_cfg. Must be done before riscv_load_fdt, otherwise the
>       * device tree cannot be altered and we get FDT_ERR_NOSPACE.
>       */
> -    s->fw_cfg =3D create_fw_cfg(machine);
> +    s->fw_cfg =3D create_fw_cfg(machine, s->memmap[VIRT_FW_CFG].base);
>      rom_set_fw(s->fw_cfg);
>
>      /* SiFive Test MMIO device */
> --
> 2.49.0
>
>

