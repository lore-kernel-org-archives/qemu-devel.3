Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EB85C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 02:28:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Gjo-0001rz-VY; Sun, 28 Apr 2024 22:27:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s1Gjm-0001rV-3f; Sun, 28 Apr 2024 22:27:26 -0400
Received: from mail-ua1-x929.google.com ([2607:f8b0:4864:20::929])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s1Gjk-0002bW-Mj; Sun, 28 Apr 2024 22:27:25 -0400
Received: by mail-ua1-x929.google.com with SMTP id
 a1e0cc1a2514c-7f043c9ac21so507023241.0; 
 Sun, 28 Apr 2024 19:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714357643; x=1714962443; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HLGOR0osTICR2F2QFlaTjse2AVfp36sNDATFzPAaB84=;
 b=YoPyCJ3ubtcPVFOMMURQU+iTr3o8BYfzEhHHAIyiL6uWIy5SvBSd83fMDVgJ3AOgp+
 AUClBGX0z4Uqu8Sja2i+mzvodoSU5WWnpqicIwuHbFuzm1CFThWevVtPWawDMeb3nmAo
 sTPEaFM7y21ybA7I11pPQ4hW+0PTEA1SF2lM9gPdudpTMBtkouphbAGgS+6JpOY/R0hV
 Gxe7KswerkxqB2lEcdDCd92DaySYzh1Xh03jMKJ/cySbT+o92ZBDz5tdYiWWUEcRJ3UF
 ic0sf67l/LB8tb54quWASnkIYLKZ6hh392hmsiD86rd7aGvwp3AbUiWf+oqVWTlDIkqD
 bDNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714357643; x=1714962443;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HLGOR0osTICR2F2QFlaTjse2AVfp36sNDATFzPAaB84=;
 b=cqvKU5/kRRUG6UZnlK8wGGclrtWfo9CVigXzrVAC7x4Iq09mNfHtJOcqj+326p/6Wl
 VUlLjXclypJ4rX6iYc7+cyYYRAj7oWG5vXz7/bdp41rlBqaHPWT0PYPPQu5ufLca9W6t
 69BBegEZiBL5IFY/mTBvoBuYAU37ZasMbIGZcXGzexq+BWiI7STwTrqoF7wbCigo9uUu
 zOk6pN0OKY9FRdvhhiBrZgqvjF26wdX6SmW4bmbc5TFW/LtCU4oyKhZykIbRkGI0MAZd
 T1KjUu7QvOB1maisZxNKhlYO06Kt9hqxxsuDl8iTjFXRcoK1VvxpoNyXxTYfve1YTUaZ
 QrFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1JDaZandg8J8zzaf7BwgBaocdTOhhzzurUf0W8G2Pe7kUBPuuo3wdYfrzyW74blgy5OBPsb3VGCYCB7cmX2/YLq9i0pw=
X-Gm-Message-State: AOJu0YyMJ1w4IXvXcCU41dmeE9Xmx50lCBpoYlZ4+BhHsMRcrayZyGfb
 fJFrMFsUANfJB1s6M1QcsEXzpX1R36mROkcKOwOMzLFqqOf66uLzyl+IcTN6S5OYdiq/HolzfTd
 qAnRtLEulnud0kOpAGWT5lPqmRMc=
X-Google-Smtp-Source: AGHT+IGMbFdMHSd3xMlZSv8Wl8tlX+kPTbdmemxu8aEW8Nv9YeglcCGhAgelD2YXXQQSjob/dbYBsKIheH/UaM8RTzY=
X-Received: by 2002:a05:6122:328f:b0:4d4:1e99:7c8f with SMTP id
 cj15-20020a056122328f00b004d41e997c8fmr10758414vkb.6.1714357643224; Sun, 28
 Apr 2024 19:27:23 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_A4482251DD0890F312758FA6B33F60815609@qq.com>
In-Reply-To: <tencent_A4482251DD0890F312758FA6B33F60815609@qq.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 29 Apr 2024 12:26:57 +1000
Message-ID: <CAKmqyKPQRR7oDiMyz6BA8ssTU43Df_G-7Acq1tmkuwhjBtxOVA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] hw/riscv/boot.c: Support 64-bit address for initrd
To: Cheng Yang <yangcheng.work@foxmail.com>
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bin.meng@windriver.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::929;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x929.google.com
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

On Mon, Apr 1, 2024 at 10:44=E2=80=AFPM Cheng Yang <yangcheng.work@foxmail.=
com> wrote:
>
> Use qemu_fdt_setprop_u64() instead of qemu_fdt_setprop_cell()
> to set the address of initrd in FDT to support 64-bit address.
>
> Signed-off-by: Cheng Yang <yangcheng.work@foxmail.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/boot.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
> index 09878e722c..47281ca853 100644
> --- a/hw/riscv/boot.c
> +++ b/hw/riscv/boot.c
> @@ -209,8 +209,8 @@ static void riscv_load_initrd(MachineState *machine, =
uint64_t kernel_entry)
>      /* Some RISC-V machines (e.g. opentitan) don't have a fdt. */
>      if (fdt) {
>          end =3D start + size;
> -        qemu_fdt_setprop_cell(fdt, "/chosen", "linux,initrd-start", star=
t);
> -        qemu_fdt_setprop_cell(fdt, "/chosen", "linux,initrd-end", end);
> +        qemu_fdt_setprop_u64(fdt, "/chosen", "linux,initrd-start", start=
);
> +        qemu_fdt_setprop_u64(fdt, "/chosen", "linux,initrd-end", end);
>      }
>  }
>
> --
> 2.34.1
>
>

