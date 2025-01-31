Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 636D1C0218A
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 01:41:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdg1Q-0000wI-Lf; Thu, 30 Jan 2025 20:40:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tdg1M-0000vr-Gy; Thu, 30 Jan 2025 20:40:36 -0500
Received: from mail-vk1-xa2c.google.com ([2607:f8b0:4864:20::a2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tdg1K-0000sb-UE; Thu, 30 Jan 2025 20:40:36 -0500
Received: by mail-vk1-xa2c.google.com with SMTP id
 71dfb90a1353d-518a52c8b5aso478707e0c.2; 
 Thu, 30 Jan 2025 17:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738287633; x=1738892433; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4RJ0GmOGZWW7jlWq1iNAmd/Ev+zkOsGt81oHcCiuQgg=;
 b=k6VK4rQ99a8RPzxs4C2ZzsRKmqHNZUdaN17gt9OWkVXDk1/P1WF+oaoDm5N4NzWwH8
 L4BT8CKMK8XSwPWS1zaNqqtawAImyYC4sw7utYybBCHiEhZ22DJVZvTO6KNfBPr1rHPC
 PAaxIt2JcdVd4tQL5yjwYDGGTj+6z2e/67Tj7kLP7ygx5hDmPEAIknINUsp/3ArvGj4s
 LQrKmFtrNS1g9ikCC+PVBToARrpR3TNHHFasPCcn13EHrzZErNOaHSjo6WEkaOTU9MfC
 VRLJfejzF3gJUrpE3T5WYQGH7UiU5J69rup75sY8rRx9v/VyzN0Af+gKq8KdyA/I8E1k
 QVEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738287633; x=1738892433;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4RJ0GmOGZWW7jlWq1iNAmd/Ev+zkOsGt81oHcCiuQgg=;
 b=TzBjMZ+dty5sFLFwgQrNKJbPv0cw0zNFq2UtJKQx7eigqWlLNw9uhZN0tIYEaaiG+h
 b1d5tf4W7ABY1piQeXiXUrQRiGEmR/WFiMay2v0dbHttWwoZsr89c/hjKUKknYUFwgeQ
 r+oklMelm75VGhGTDRIU2qpUYRk9lnneLPxgYoko0Su+zPehsks5T4GFJp4FeeJ73Xa0
 /O4QDcKE8yIPI9kclzdD3LGtAmXMspzFjyjYDURjuLFG6arLmMjwV8bZKnxQ5KKY4uj0
 OT2rg5/bVeHmVcnhHkNjjJ8UlEyOe8cgTNV1AdEzIf1fH6+n6a/yDuQ8tKEh2GLtCC7n
 K2nA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuZ64ZthU6Z8/V4BO7P4rcP8qtq6VjlRDAh/1r5CcEe8M53c0FaVFE7XyUf2rKRL71awsXFCpIT/NO@nongnu.org
X-Gm-Message-State: AOJu0Yz3/v0q2ZI2ma/PSMbCMJhbdkvwn+tdWWG/jZnsaiGDx3nRu4/c
 Ww/EhKmxyVLFLvwX9uUDO6tDEt31K0snQOPntAJxNUfKNODXqOxuunO8QoXqnwQN81ldYGmYKDS
 dyy9T0T2ym11MSrFbDjUMAGdsXdM=
X-Gm-Gg: ASbGnctn0ENDe4WjVEon+t1Vj1gpOZhuQIy7KazrKKN5FpYC+0B7l/xpCS2li4aGQ1w
 /IOeEtrb0/TJyaDeA9M9u7JekOchvesZ49yWlMvmfqnvwJ70c7WlvmdLwqxDx7R+tDP/+qCcfug
 6jcOskmJ0TG9qCny08hhxlucJ88MA=
X-Google-Smtp-Source: AGHT+IEk+VGqVeX5posA1CsS6M34L0XgRd6vjJO/EhuiuHlsYT6o2hfNsoTVtTVxIEvyfNwEmw5d/NEWEYBsKuc8Fp0=
X-Received: by 2002:a05:6122:17a6:b0:516:240b:58ff with SMTP id
 71dfb90a1353d-51e9e45ecc4mr9245466e0c.5.1738287633585; Thu, 30 Jan 2025
 17:40:33 -0800 (PST)
MIME-Version: 1.0
References: <20250116161007.39710-1-vliaskovitis@suse.com>
In-Reply-To: <20250116161007.39710-1-vliaskovitis@suse.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 31 Jan 2025 11:40:07 +1000
X-Gm-Features: AWEUYZkZE2jRhgki6WZhSZ-DHD4ZNlUHUaK6Gl3cQ-hCyMC8TOLe7IgRaWTwGmQ
Message-ID: <CAKmqyKOnSvmGO2ivFLw2fYf167FiZRHwCc=Q2mxJ7wJouJN8iA@mail.gmail.com>
Subject: Re: [PATCH v3] hw/riscv/virt: Add serial alias in DTB
To: Vasilis Liaskovitis <vliaskovitis@suse.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, jason.chien@sifive.com, 
 zhiwei_liu@linux.alibaba.com, dbarboza@ventanamicro.com, 
 ajones@ventanamicro.com, bmeng.cn@gmail.com, liwei1518@gmail.com, 
 philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2c;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2c.google.com
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

On Fri, Jan 17, 2025 at 2:13=E2=80=AFAM Vasilis Liaskovitis
<vliaskovitis@suse.com> wrote:
>
> Add an "aliases" node with a "serial0" entry for the single UART
> in the riscv virt machine.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2774
> Signed-off-by: Vasilis Liaskovitis <vliaskovitis@suse.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/virt.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 2bc5a9dd98..fb1928cebf 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -971,6 +971,7 @@ static void create_fdt_uart(RISCVVirtState *s, const =
MemMapEntry *memmap,
>      }
>
>      qemu_fdt_setprop_string(ms->fdt, "/chosen", "stdout-path", name);
> +    qemu_fdt_setprop_string(ms->fdt, "/aliases", "serial0", name);
>  }
>
>  static void create_fdt_rtc(RISCVVirtState *s, const MemMapEntry *memmap,
> @@ -1180,6 +1181,8 @@ static void create_fdt(RISCVVirtState *s, const Mem=
MapEntry *memmap)
>      qemu_fdt_setprop(ms->fdt, "/chosen", "rng-seed",
>                       rng_seed, sizeof(rng_seed));
>
> +    qemu_fdt_add_subnode(ms->fdt, "/aliases");
> +
>      create_fdt_flash(s, memmap);
>      create_fdt_fw_cfg(s, memmap);
>      create_fdt_pmu(s);
> --
> 2.46.0
>
>

