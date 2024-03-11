Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F250CC54791
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 02:23:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjVJ6-0004CI-Iw; Sun, 10 Mar 2024 22:22:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1rjVJ4-0004Bw-1W
 for qemu-devel@nongnu.org; Sun, 10 Mar 2024 22:22:26 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1rjVJ2-0002Ul-Au
 for qemu-devel@nongnu.org; Sun, 10 Mar 2024 22:22:25 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a45fd0a0980so163111866b.2
 for <qemu-devel@nongnu.org>; Sun, 10 Mar 2024 19:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710123741; x=1710728541; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wwQXXkfBYFlzBnINcq/CDorygVn5cKNzlrBlbGaNdtA=;
 b=P0j+MaGzNxSeAXm09x1hw1S25DESemTyGaDVIm7hEnkWe0HjbjRU6+dyDkZ39nIyOj
 L4W85vaaqmLZCgtRxfhRFV6VdHzy2CPXmYuRlpucY/V4srumhg5XTjVMzLHeOmBLHryD
 B0sfXS0BSdfhRAS3SsmUxGqXO8xk298TLawxN9+2h3k7j5cfKgq448xdXZEwDEW1mis7
 YfYQ0RcINrbU9CEYP5nraGCwuKwvFCugHFEqQss5Pm/cwBsyJnvuPrb1/Kg7q7ABnLhY
 ado6jJVpswS6n4Mn1x6Tif3stBfMYVISWKz8zoUNnaItODqvPyZj19th12rMVIwbJAbJ
 WUJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710123741; x=1710728541;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wwQXXkfBYFlzBnINcq/CDorygVn5cKNzlrBlbGaNdtA=;
 b=SwM2X6TkMMROK9AbX2iMCyKVZugJ3u0pDsFTfb4Uvdy8edMLdgXOMHgURoLcc0LvdW
 X3X9Fl0MzMzlgJ4aUqbhrY+FraNEHpTZ0Mn2QRANMq6rCWuuAFfGqVVi5scq6+I6Dgs9
 2vbJZmK9J6m/wl3F8BcZNTmsNON6Qu91Hf1ZsBD65fQU2+bIdqaFZoIrdQomEBqCuuL8
 UEBo1MwLQcERAkQ6qU1lsoTOCePATMluqCDC/DwTmsmg5Hr2rV70U0tq8prf6ZFBYmZW
 vrOjNC1hLv956e8LMUvNdYJrDih927BAke2oLu9kkEoQxZ25FVrGMKYIBkGRTOrFjUjh
 r4GA==
X-Gm-Message-State: AOJu0YwO6bqQ51biWebfGyXnfoIcA78wZQsc9ATTzm1CJhd66mly/Fa2
 spPwScmGmteuecJ9B7SZApBJlWqajhQwYCWsoHYJQCx2BGxxxO7upnnKPpQ+9K55CPtkeNolAZK
 VCzZ7kTK8U9OEqFWBwBN30BWUjpo=
X-Google-Smtp-Source: AGHT+IEALs3jbYeu13XNM9kdXS/SVi/OKq/nKGnB0z07ucahcBOyogd92uwUb0QuP+xHLcgg/QcGDWX+7+7PT64Y7wI=
X-Received: by 2002:a17:907:a0ce:b0:a45:ed7f:265c with SMTP id
 hw14-20020a170907a0ce00b00a45ed7f265cmr4035422ejc.0.1710123740974; Sun, 10
 Mar 2024 19:22:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240307152835.299233-1-gaosong@loongson.cn>
 <20240307152835.299233-4-gaosong@loongson.cn>
In-Reply-To: <20240307152835.299233-4-gaosong@loongson.cn>
From: chen huacai <zltjiangshi@gmail.com>
Date: Mon, 11 Mar 2024 10:22:10 +0800
Message-ID: <CABDp7Vq7z+euAfdTD10vC14MRebw3sSyLpmNBFr4wiZAexa=GQ@mail.gmail.com>
Subject: Re: [PULL v2 03/17] hw/loongarch: Add slave cpu boot_code
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=zltjiangshi@gmail.com; helo=mail-ej1-x631.google.com
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

On Thu, Mar 7, 2024 at 11:35=E2=80=AFPM Song Gao <gaosong@loongson.cn> wrot=
e:
>
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> Message-Id: <20240301093839.663947-4-gaosong@loongson.cn>
> ---
>  hw/loongarch/boot.c | 70 ++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 69 insertions(+), 1 deletion(-)
>
> diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
> index 3075c276d4..2f398260af 100644
> --- a/hw/loongarch/boot.c
> +++ b/hw/loongarch/boot.c
> @@ -14,6 +14,54 @@
>  #include "qemu/error-report.h"
>  #include "sysemu/reset.h"
>
> +static const unsigned int slave_boot_code[] =3D {
> +                  /* Configure reset ebase.         */
> +    0x0400302c,   /* csrwr      $r12,0xc            */
Use reg-names may be a little better than reg-nums.

Huacai
> +
> +                  /* Disable interrupt.             */
> +    0x0380100c,   /* ori        $r12,$r0,0x4        */
> +    0x04000180,   /* csrxchg    $r0,$r12,0x0        */
> +
> +                  /* Clear mailbox.                 */
> +    0x1400002d,   /* lu12i.w    $r13,1(0x1)         */
> +    0x038081ad,   /* ori        $r13,$r13,0x20      */
> +    0x06481da0,   /* iocsrwr.d  $r0,$r13            */
> +
> +                  /* Enable IPI interrupt.          */
> +    0x1400002c,   /* lu12i.w    $r12,1(0x1)         */
> +    0x0400118c,   /* csrxchg    $r12,$r12,0x4       */
> +    0x02fffc0c,   /* addi.d     $r12,$r0,-1(0xfff)  */
> +    0x1400002d,   /* lu12i.w    $r13,1(0x1)         */
> +    0x038011ad,   /* ori        $r13,$r13,0x4       */
> +    0x064819ac,   /* iocsrwr.w  $r12,$r13           */
> +    0x1400002d,   /* lu12i.w    $r13,1(0x1)         */
> +    0x038081ad,   /* ori        $r13,$r13,0x20      */
> +
> +                  /* Wait for wakeup  <.L11>:       */
> +    0x06488000,   /* idle       0x0                 */
> +    0x03400000,   /* andi       $r0,$r0,0x0         */
> +    0x064809ac,   /* iocsrrd.w  $r12,$r13           */
> +    0x43fff59f,   /* beqz       $r12,-12(0x7ffff4) # 48 <.L11> */
> +
> +                  /* Read and clear IPI interrupt.  */
> +    0x1400002d,   /* lu12i.w    $r13,1(0x1)         */
> +    0x064809ac,   /* iocsrrd.w  $r12,$r13           */
> +    0x1400002d,   /* lu12i.w    $r13,1(0x1)         */
> +    0x038031ad,   /* ori        $r13,$r13,0xc       */
> +    0x064819ac,   /* iocsrwr.w  $r12,$r13           */
> +
> +                  /* Disable  IPI interrupt.        */
> +    0x1400002c,   /* lu12i.w    $r12,1(0x1)         */
> +    0x04001180,   /* csrxchg    $r0,$r12,0x4        */
> +
> +                  /* Read mail buf and jump to specified entry */
> +    0x1400002d,   /* lu12i.w    $r13,1(0x1)         */
> +    0x038081ad,   /* ori        $r13,$r13,0x20      */
> +    0x06480dac,   /* iocsrrd.d  $r12,$r13           */
> +    0x00150181,   /* move       $r1,$r12            */
> +    0x4c000020,   /* jirl       $r0,$r1,0           */
> +};
> +
>  static uint64_t cpu_loongarch_virt_to_phys(void *opaque, uint64_t addr)
>  {
>      return addr & MAKE_64BIT_MASK(0, TARGET_PHYS_ADDR_SPACE_BITS);
> @@ -110,8 +158,15 @@ static void loongarch_firmware_boot(LoongArchMachine=
State *lams,
>      fw_cfg_add_kernel_info(info, lams->fw_cfg);
>  }
>
> +static void init_boot_rom(struct loongarch_boot_info *info, void *p)
> +{
> +    memcpy(p, &slave_boot_code, sizeof(slave_boot_code));
> +    p +=3D sizeof(slave_boot_code);
> +}
> +
>  static void loongarch_direct_kernel_boot(struct loongarch_boot_info *inf=
o)
>  {
> +    void  *p, *bp;
>      int64_t kernel_addr =3D 0;
>      LoongArchCPU *lacpu;
>      CPUState *cs;
> @@ -123,11 +178,24 @@ static void loongarch_direct_kernel_boot(struct loo=
ngarch_boot_info *info)
>          exit(1);
>      }
>
> +    /* Load 'boot_rom' at [0 - 1MiB] */
> +    p =3D g_malloc0(1 * MiB);
> +    bp =3D p;
> +    init_boot_rom(info, p);
> +    rom_add_blob_fixed("boot_rom", bp, 1 * MiB, 0);
> +
>      CPU_FOREACH(cs) {
>          lacpu =3D LOONGARCH_CPU(cs);
>          lacpu->env.load_elf =3D true;
> -        lacpu->env.elf_address =3D kernel_addr;
> +        if (cs =3D=3D first_cpu) {
> +            lacpu->env.elf_address =3D kernel_addr;
> +        } else {
> +            lacpu->env.elf_address =3D 0;
> +        }
> +        lacpu->env.boot_info =3D info;
>      }
> +
> +    g_free(bp);
>  }
>
>  void loongarch_load_kernel(MachineState *ms, struct loongarch_boot_info =
*info)
> --
> 2.34.1
>
>


--=20
Huacai Chen

