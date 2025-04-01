Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E079C3600C
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 01:15:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzQE1-0002I2-43; Mon, 31 Mar 2025 21:15:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenhuacai@kernel.org>)
 id 1tzQDx-0002HZ-At
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 21:15:29 -0400
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenhuacai@kernel.org>)
 id 1tzQDv-0005rb-8j
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 21:15:29 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 5094FA43F93
 for <qemu-devel@nongnu.org>; Tue,  1 Apr 2025 01:09:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5316C4CEEB
 for <qemu-devel@nongnu.org>; Tue,  1 Apr 2025 01:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1743470120;
 bh=iw/MuBBtuZvJ2rILGIvlBV0RRsM4HMwHCKY2B2wg7iE=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=tH9kQHoPS5PKeAIrC8oC/6/pnJW547/6Nv9kTlJKZgqZzK/H9GJRhDfiIImz5SSco
 jDu4dZtrVt4P1o8lEooedVLWf0lp4H6TqqU/YKG2q0Oho6H8+jlhBrEvpu4YgV4EbN
 7toh9/w27iq6K81GB1v67E5TvXLpdZfZKIv1zo6gk3YE9XSULGShY4ycGvOtUu0Ji/
 MZBmoXrIVcEHHBDuUmQ55KHstsX/KBhdghZtlLHmkNxCBUqf8MgX/p18QDHYob0SIn
 P0LtoYsOjO7Es7hNTf0UFI9cFnSXa8Ld9nv18sdJ0SiRkzjKPVf9LUT+FpF7O4QmX5
 n0yNlovtJrYVw==
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-ab78e6edb99so722467466b.2
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 18:15:20 -0700 (PDT)
X-Gm-Message-State: AOJu0YzCBeAHwWN7TXAecMuLwqzLGfitrv2xyc2I0veM7KdOL9TMX3jB
 qHHYl1fo4Bxl3PomhIE4SrrGAv3OYhGctUn05GrC+qiITzZ/blUGS4m4/H1/6Yn6pzTn3+TAqDl
 CK1kbfnciZgE0MIErgAa6AW82LmE=
X-Google-Smtp-Source: AGHT+IH1xbDBO9G28RA7jQuupMgmV0D5Xhd8eCok7MH0nrMOjen0jOr1CGGgEYxw2TB8FA0OjxcuCuhDQl1A3FJ9ccU=
X-Received: by 2002:a17:907:7fa1:b0:ac3:2ad9:f126 with SMTP id
 a640c23a62f3a-ac738bbe70fmr946435066b.41.1743470119337; Mon, 31 Mar 2025
 18:15:19 -0700 (PDT)
MIME-Version: 1.0
References: <20250328175526.368121-1-richard.henderson@linaro.org>
 <20250328175526.368121-2-richard.henderson@linaro.org>
In-Reply-To: <20250328175526.368121-2-richard.henderson@linaro.org>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 1 Apr 2025 09:15:13 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6=iZOBfxF=_DXqc5M9GjTiXJ7nxotLAJ-0Eb7=zVd0bQ@mail.gmail.com>
X-Gm-Features: AQ5f1JqUSZzRWpiCqn5S8o_7KaQDy9vjjzGJBiEsSCVNmdrlqn74LRHKDNBdLH4
Message-ID: <CAAhV-H6=iZOBfxF=_DXqc5M9GjTiXJ7nxotLAJ-0Eb7=zVd0bQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] target/mips: Revert TARGET_PAGE_BITS_VARY
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, jiaxun.yang@flygoat.com, 
 arikalo@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2604:1380:45d1:ec00::3;
 envelope-from=chenhuacai@kernel.org; helo=nyc.source.kernel.org
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.198,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi, Richard,

On Sat, Mar 29, 2025 at 1:55=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Revert ee3863b9d41 and a08d60bc6c2b.  The logic behind changing
> the system page size because of what the Loongson kernel "prefers"
> is flawed.
>
> In the Loongson-2E manual, section 5.5, it is clear that the cpu
> supports a 4k page size (along with many others).  Therefore we
> must continue to support a 4k page size.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/mips/cpu-param.h             | 5 -----
>  hw/mips/fuloong2e.c                 | 1 -
>  hw/mips/loongson3_virt.c            | 1 -
>  target/mips/tcg/system/cp0_helper.c | 7 +------
>  target/mips/tcg/system/tlb_helper.c | 2 +-
>  5 files changed, 2 insertions(+), 14 deletions(-)
>
> diff --git a/target/mips/cpu-param.h b/target/mips/cpu-param.h
> index 11b3ac0ac6..8fcb1b4f5f 100644
> --- a/target/mips/cpu-param.h
> +++ b/target/mips/cpu-param.h
> @@ -18,12 +18,7 @@
>  #  define TARGET_VIRT_ADDR_SPACE_BITS 32
>  #endif
>  #endif
> -#ifdef CONFIG_USER_ONLY
>  #define TARGET_PAGE_BITS 12
> -#else
> -#define TARGET_PAGE_BITS_VARY
> -#define TARGET_PAGE_BITS_MIN 12
> -#endif
I'm a bit confused about TARGET_PAGE_BITS and other macros.

In my opinion, if we define TARGET_PAGE_BITS as 12, that means we only
support 4K pages. And if we define TARGET_PAGE_BITS_VARY and
TARGET_PAGE_BITS_MIN as 12, that means we support the minimum page as
4K, but we also support larger pages.

Am I wrong?

>
>  #define TCG_GUEST_DEFAULT_MO (0)
>
> diff --git a/hw/mips/fuloong2e.c b/hw/mips/fuloong2e.c
> index 646044e274..2a8507b8b0 100644
> --- a/hw/mips/fuloong2e.c
> +++ b/hw/mips/fuloong2e.c
> @@ -334,7 +334,6 @@ static void mips_fuloong2e_machine_init(MachineClass =
*mc)
>      mc->default_cpu_type =3D MIPS_CPU_TYPE_NAME("Loongson-2E");
>      mc->default_ram_size =3D 256 * MiB;
>      mc->default_ram_id =3D "fuloong2e.ram";
> -    mc->minimum_page_bits =3D 14;
Loongson prefers 16K pages not because it doesn't support 4K, but
because 4K pages cause cache aliases, which make the kernel difficult
to implement.

Huacai

>      machine_add_audiodev_property(mc);
>  }
>
> diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
> index db1cc51314..1da20dccec 100644
> --- a/hw/mips/loongson3_virt.c
> +++ b/hw/mips/loongson3_virt.c
> @@ -677,7 +677,6 @@ static void loongson3v_machine_class_init(ObjectClass=
 *oc, void *data)
>      mc->max_cpus =3D LOONGSON_MAX_VCPUS;
>      mc->default_ram_id =3D "loongson3.highram";
>      mc->default_ram_size =3D 1600 * MiB;
> -    mc->minimum_page_bits =3D 14;
>      mc->default_nic =3D "virtio-net-pci";
>  }
>
> diff --git a/target/mips/tcg/system/cp0_helper.c b/target/mips/tcg/system=
/cp0_helper.c
> index 01a07a169f..8c2114c58a 100644
> --- a/target/mips/tcg/system/cp0_helper.c
> +++ b/target/mips/tcg/system/cp0_helper.c
> @@ -877,18 +877,13 @@ void update_pagemask(CPUMIPSState *env, target_ulon=
g arg1, int32_t *pagemask)
>      if ((mask >> maskbits) !=3D 0) {
>          goto invalid;
>      }
> -    /* We don't support VTLB entry smaller than target page */
> -    if ((maskbits + TARGET_PAGE_BITS_MIN) < TARGET_PAGE_BITS) {
> -        goto invalid;
> -    }
>      env->CP0_PageMask =3D mask << CP0PM_MASK;
>
>      return;
>
>  invalid:
>      /* When invalid, set to default target page size. */
> -    mask =3D (~TARGET_PAGE_MASK >> TARGET_PAGE_BITS_MIN);
> -    env->CP0_PageMask =3D mask << CP0PM_MASK;
> +    env->CP0_PageMask =3D 0;
>  }
>
>  void helper_mtc0_pagemask(CPUMIPSState *env, target_ulong arg1)
> diff --git a/target/mips/tcg/system/tlb_helper.c b/target/mips/tcg/system=
/tlb_helper.c
> index ca4d6b27bc..123639fa18 100644
> --- a/target/mips/tcg/system/tlb_helper.c
> +++ b/target/mips/tcg/system/tlb_helper.c
> @@ -875,7 +875,7 @@ refill:
>              break;
>          }
>      }
> -    pw_pagemask =3D m >> TARGET_PAGE_BITS_MIN;
> +    pw_pagemask =3D m >> TARGET_PAGE_BITS;
>      update_pagemask(env, pw_pagemask << CP0PM_MASK, &pw_pagemask);
>      pw_entryhi =3D (address & ~0x1fff) | (env->CP0_EntryHi & 0xFF);
>      {
> --
> 2.43.0
>

