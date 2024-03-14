Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAC20C54E66
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 02:29:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkaqG-0001hb-P5; Wed, 13 Mar 2024 22:29:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1rkaqF-0001hQ-L8
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 22:29:11 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1rkaqE-0005PP-1M
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 22:29:11 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a446b5a08f0so91785266b.1
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 19:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710383348; x=1710988148; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qqKoE7Fx3Qc4F7kfxXYFA2EHoabnRfr+NWbJs0IvoEk=;
 b=hJYxRyC5p8IcA27rewV4PAT4FJW1pU498qqmNTv0e+xzrM3ogy49FnJe0nR3Wtq2fr
 SEJG1UNUNSmYxILPIJmg1Cp2gPH1YQHN+AmaXpqK6ZULZlxwnIqfe1Yiu4rC5qVYTT5O
 Z/H0yirFBiTQSWzmbPIPsKdUOm7rVEhTKIo6YblA5+BQHimZ1T6FwBQ8W/kUzMZWjCTF
 x5/DjT+/8mPfsuNnnzsRiSXeCygQLAYAHLxrdXOVpomi21wgkr9s6n+zdDAlUy6D8u7p
 p6JR/FZX/1KLjUMkiXtlj0MaOoFxUYqeiLBPiPWEjH1yifIU1u5Gv58XiSd+wEtCCm0E
 iXBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710383348; x=1710988148;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qqKoE7Fx3Qc4F7kfxXYFA2EHoabnRfr+NWbJs0IvoEk=;
 b=F1vVLkefk7CuPpi+abr24N6JcFzu5ndaLQsBpFJBYVCMTUfuhdSNKC2pknwYl8nCJy
 XuKhHmyPg/tRF94tN3hMHPfZKwdjYdsm6asrsXU3t8JL6kO3/h6c4lCN+UsBu0ZQI1kM
 5LtFKALGB+7BeyhKtBX95cEEohb1z14o29pl+TpUVUCrtTSY1cSxCKPDSUjcfpT1JLKQ
 PVTEOV33z0k80Ep1TidQ0EtmS4XTVec6iG0FTJhhwdUalKEauGZ1+BkcLCn7TG2ZwBYM
 pxpuD+PrSLTjwaAe2ejBzMwC5DKYndhqDth4GMxDNnGDkbafG7QEXamvVLRO7DvS6mtp
 +8mQ==
X-Gm-Message-State: AOJu0YyZBjc2DolthhkvAi577AYIFiaCzS6NTHZF1Dj0NtVIfhJ5Bl9+
 QNEqhF5zm9IEMVU6iLRAIebQYsxgBW5SfF9tSNtlFxBG/M2yTnp9URkXnbcqjEqxG7kaHaW49k2
 4djfwe4VJsAODUjMOmbfx+HEilAJDuuwne5OzHOpm
X-Google-Smtp-Source: AGHT+IHvwXSZZzcjhxpEjNTm19uv5RVifCogAPoWwP36+Dnv15F7Cj5IQOYBwtqB4pv2MIpkRgKEZ4i8OgyRrc2H2Tg=
X-Received: by 2002:a17:906:c359:b0:a44:806f:ad56 with SMTP id
 ci25-20020a170906c35900b00a44806fad56mr490787ejb.11.1710383348095; Wed, 13
 Mar 2024 19:29:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240307164835.300412-1-gaosong@loongson.cn>
 <20240307164835.300412-4-gaosong@loongson.cn>
In-Reply-To: <20240307164835.300412-4-gaosong@loongson.cn>
From: chen huacai <zltjiangshi@gmail.com>
Date: Thu, 14 Mar 2024 10:28:59 +0800
Message-ID: <CABDp7Vo9ZOrz+4iKtToC+hs_JzptZg2cup+NdDaniV-3Qev+Tw@mail.gmail.com>
Subject: Re: [PATCH v6 03/17] hw/loongarch: Add slave cpu boot_code
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, maobibo@loongson.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=zltjiangshi@gmail.com; helo=mail-ej1-x62a.google.com
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

Song,

On Fri, Mar 8, 2024 at 12:51=E2=80=AFAM Song Gao <gaosong@loongson.cn> wrot=
e:
>
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> Message-Id: <20240301093839.663947-4-gaosong@loongson.cn>
> ---
>  hw/loongarch/boot.c | 70 ++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 69 insertions(+), 1 deletion(-)
>
> diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
> index 149deb2e01..e560ac178a 100644
> --- a/hw/loongarch/boot.c
> +++ b/hw/loongarch/boot.c
> @@ -15,6 +15,54 @@
>  #include "sysemu/reset.h"
>  #include "sysemu/qtest.h"
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
> @@ -111,8 +159,15 @@ static void loongarch_firmware_boot(LoongArchMachine=
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
> @@ -126,11 +181,24 @@ static void loongarch_direct_kernel_boot(struct loo=
ngarch_boot_info *info)
>          }
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

