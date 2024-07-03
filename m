Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5DD8C3065C
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 02:34:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOpoX-0001Ix-OG; Tue, 02 Jul 2024 22:33:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sOpoV-0001Hq-Nv; Tue, 02 Jul 2024 22:33:43 -0400
Received: from mail-vs1-xe36.google.com ([2607:f8b0:4864:20::e36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sOpoU-00016H-8N; Tue, 02 Jul 2024 22:33:43 -0400
Received: by mail-vs1-xe36.google.com with SMTP id
 ada2fe7eead31-48f415262f5so1646765137.1; 
 Tue, 02 Jul 2024 19:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719974021; x=1720578821; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mw6tAMuoTW5Vj+xyoeT94JsWwl8HEiRb0KtBEG6/rpY=;
 b=Kl7qxnk8C4ZbV8eyU79zijcn/YAp4bowBkypL0TCRmsC4bmbT9FY21xuC0kke1BGLv
 FVySDIj8RU1oAmvmdW0YgefkjgTaIitcr25jEVY5U/+4Qwq+ZrU9Pi31/91vtCQjlZUe
 3exdNNTvkFuzpVnvQiLxpFkWHDf54RRWOpVptzPkb8/ZYYxId9mjMUFgLdB/dIAy1ZnJ
 XuGTlb+1e6YCZSci3OZIB401/9GY+Q/Kx/fIH4xnGIw+0+mROWRL0PkpZqOuu5poNqGE
 AP4EpO7UQIjgdmQCBbTf6L8c8v4fIvEbY8Z/UqLusIU2xhrfUtlwx/mBps11w6Eh7bij
 Zj6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719974021; x=1720578821;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mw6tAMuoTW5Vj+xyoeT94JsWwl8HEiRb0KtBEG6/rpY=;
 b=aLGf+lwB3C+Ho9r0VplVGtLUS0PCRWnzzTJHf5YCXfLJfbMjCV/n88whRRRHIqW05Y
 A8vtdHYOqAAdQ0ri3ZhCNs2jU4fqWQ8cIomSEuDlWl3W6nigjYA7/+oDgcn45LZTrLGP
 qY4G/WEAqXHfNs3QBlqmrd1PRQHrX6wvxzXIgcLeF6t6Nr1sBfSY3Vh8VEcbSWBUHC73
 xKzddYuFdEvlaU0ZU6byg5cGCTkF62gZQPGf7ukUYKqKd4/9UC62q3/Zf5x4R9X8FMJ4
 ITbK0p9AM6bryzfpDNHsoGRYyn7uIdGc/jZfiEHziyGpPPFshnNR+MQXzkdh/SkOr7wb
 MyzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVF9n6PqVGqoIUGozlHoNPUBUg9sr0TtrqiT2djXJEk2EdEjbxDMSTxlT9iqG5oLc8ICHzD/DyZOVL1FLq7W/N/03AFrWM=
X-Gm-Message-State: AOJu0YwyVdmWtpls5Rd5A5YzEaJxTzOhz3kuWeoI6WuXM3BgektNEXTZ
 wyEnZYG8G6gUCh53YYlA+qfB3v4afUSWijEzZV0x8LQ8ygQtll/qkjD/HSS5E44w4fcoxKPfOux
 fcSKvINf5eCC73AA3kmyqi0XGcSTAIl+i
X-Google-Smtp-Source: AGHT+IGyya1UrxRJEXfENJ6PY2srB36odp4fn50bha3gnl9XY14cULbf3biUpGKBMB0l+uJpiCGjaYP5jXnbh+i24R8=
X-Received: by 2002:a05:6102:290b:b0:48f:a4ee:6d73 with SMTP id
 ada2fe7eead31-48faf09ba65mr13297419137.11.1719974020732; Tue, 02 Jul 2024
 19:33:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240701033722.954-1-zhiwei_liu@linux.alibaba.com>
 <20240701033722.954-5-zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20240701033722.954-5-zhiwei_liu@linux.alibaba.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 3 Jul 2024 12:33:14 +1000
Message-ID: <CAKmqyKPsCWRy2Fwpnv3LB5QXVujBHVBHqLUNrVDnG4rfXH5TVA@mail.gmail.com>
Subject: Re: [PATCH 4/6] target/riscv: Detect sxl to set bit width for RV32 in
 RV64
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, dbarboza@ventanamicro.com, liwei1518@gmail.com, 
 bmeng.cn@gmail.com, TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e36;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe36.google.com
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

On Mon, Jul 1, 2024 at 1:41=E2=80=AFPM LIU Zhiwei <zhiwei_liu@linux.alibaba=
.com> wrote:
>
> From: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
>
> Ensure correct bit width based on sxl when running RV32 on RV64 QEMU.
> This is required as MMU address translations run in S-mode.
>
> Signed-off-by: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
> Reviewed-by: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
> ---
>  target/riscv/cpu_helper.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 6709622dd3..1af83a0a36 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -887,12 +887,14 @@ static int get_physical_address(CPURISCVState *env,=
 hwaddr *physical,
>
>      CPUState *cs =3D env_cpu(env);
>      int va_bits =3D PGSHIFT + levels * ptidxbits + widened;
> +    int sxlen =3D 16UL << riscv_cpu_sxl(env);
> +    int sxlen_bytes =3D sxlen / 8;
>
>      if (first_stage =3D=3D true) {
>          target_ulong mask, masked_msbs;
>
> -        if (TARGET_LONG_BITS > (va_bits - 1)) {
> -            mask =3D (1L << (TARGET_LONG_BITS - (va_bits - 1))) - 1;
> +        if (sxlen > (va_bits - 1)) {
> +            mask =3D (1L << (sxlen - (va_bits - 1))) - 1;
>          } else {
>              mask =3D 0;
>          }
> @@ -961,7 +963,7 @@ restart:
>
>          int pmp_prot;
>          int pmp_ret =3D get_physical_address_pmp(env, &pmp_prot, pte_add=
r,
> -                                               sizeof(target_ulong),
> +                                               sxlen_bytes,
>                                                 MMU_DATA_LOAD, PRV_S);
>          if (pmp_ret !=3D TRANSLATE_SUCCESS) {
>              return TRANSLATE_PMP_FAIL;
> @@ -1113,7 +1115,7 @@ restart:
>           *   it is no longer valid and we must re-walk the page table.
>           */
>          MemoryRegion *mr;
> -        hwaddr l =3D sizeof(target_ulong), addr1;
> +        hwaddr l =3D sxlen_bytes, addr1;
>          mr =3D address_space_translate(cs->as, pte_addr, &addr1, &l,
>                                       false, MEMTXATTRS_UNSPECIFIED);
>          if (memory_region_is_ram(mr)) {
> @@ -1126,6 +1128,11 @@ restart:
>              *pte_pa =3D pte =3D updated_pte;
>  #else
>              target_ulong old_pte =3D qatomic_cmpxchg(pte_pa, pte, update=
d_pte);

I think you missed removing this line

Alistair

> +            if (riscv_cpu_sxl(env) =3D=3D MXL_RV32) {
> +                old_pte =3D qatomic_cmpxchg((uint32_t *)pte_pa, pte, upd=
ated_pte);
> +            } else {
> +                old_pte =3D qatomic_cmpxchg(pte_pa, pte, updated_pte);
> +            }
>              if (old_pte !=3D pte) {
>                  goto restart;
>              }
> --
> 2.43.0
>
>

