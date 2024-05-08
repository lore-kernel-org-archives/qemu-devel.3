Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12BEFC19F4F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 12:40:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4gau-000589-U2; Wed, 08 May 2024 08:40:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4gaq-00057Y-2v; Wed, 08 May 2024 08:40:20 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4gaf-0005gt-SB; Wed, 08 May 2024 08:40:16 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6edc61d0ff6so4002707b3a.2; 
 Wed, 08 May 2024 05:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715172007; x=1715776807; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+UlvMxTtsXz1xUP5ogc5i4h/iWeqJzetk3w++4utfJk=;
 b=FxF6HA9GpeR6E7LPmadzHsAdLBMJVGZWxFWPhMygi+h93Av24tKUob6ePxbnf6dZoz
 fAu8yatw+jiKUNUo28YTpvQyarTiq0rRqs6Vmv8dk6HK52w/Hh+B/fGTUpy6MS7IJ4pR
 kbLVbzA45wLHYUl3xtbBsEkY6Tp/HTRlBfTZcA6me6RrtDRM8xEtkHuqSRCHQ+BnCJiQ
 b45tnvEfUyUqSuoRdXOKiaddSlEXHDF6m+7hNRLfnC3cXDfED9BnjKAKbQyeDWJhfNrb
 hPnA0y/BRQCSIJO7JGDBk0NormQGmcVUezzPM+5y+9x6Lt38Vez7qPn3jZbLuyaf4z4O
 8v9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715172007; x=1715776807;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+UlvMxTtsXz1xUP5ogc5i4h/iWeqJzetk3w++4utfJk=;
 b=hg4t/Kpgr0mE90kQ8qA8FHyh7JwUZNYH6zLOmMm3AgTA7QJQF3oVs8SwUPnxmtQCtA
 t/6xB5z/90fzBLqpdGZQbGncumwULajtN5CL2miWpG/kpYpElHb7sbvlukdllYZGWKy3
 N2cmlEF0CvbhrKe28TX1nSt/IGKsgomQt6juTr2UFJjBnv9xF+yt4HNAhfmTJFzQ2C44
 nPzYyBpGTS1d3mfvAWVSSArpyU10gL9j9pVU2wFYDylgQerrpLcG3uVPKkjnGw83BhfF
 HcTCpE0htJU9DJrtQwq+eXEBSoZdQbTkzunxNHhM6gbJ4Si3Xn4Qj5kKkOEh2VKler82
 raWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWv2MymMgeadO6U+rp4RbjL7T0J7pius1tdEXikGVW28yixM3qLT+DhpGdRa1/HRvkYS/jMZWerPJ1Wy1nWJ9QKdnE7/xSYmGHQOV/37jrBTmIo0TEKCyHYTTw=
X-Gm-Message-State: AOJu0Yw/wz1BWzdrlhMlANkSqgQomiTHM3yKM9su5Ux2dxlCELYDnnEZ
 yNugZ8Mwjap6elAoh8hQxzeUXZ+AT4gC1bgTG6yGqyYfJDtbw8uo
X-Google-Smtp-Source: AGHT+IEh+17qYy/k1EXUN4N8BD9bZIVKY06nU1Q3GAN4PbF1h3wx7O6dTSYM+1fDxPe3tzczePTDFw==
X-Received: by 2002:a05:6a20:d428:b0:1af:aeb8:c4be with SMTP id
 adf61e73a8af0-1afc8d96decmr2662856637.39.1715172006724; 
 Wed, 08 May 2024 05:40:06 -0700 (PDT)
Received: from localhost ([1.146.8.34]) by smtp.gmail.com with ESMTPSA id
 e14-20020a17090301ce00b001ec80dbb8b1sm11675075plh.73.2024.05.08.05.40.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 05:40:06 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 May 2024 22:40:01 +1000
Message-Id: <D149QBR8JZPE.8ZYLASYU0K05@gmail.com>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH v3 09/33] target/ppc/mmu_common.c: Introduce
 mmu6xx_get_physical_address()
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.17.0
References: <cover.1715125376.git.balaton@eik.bme.hu>
 <31d941a8fb27034147c8376ee26d446fb0c2cc06.1715125376.git.balaton@eik.bme.hu>
In-Reply-To: <31d941a8fb27034147c8376ee26d446fb0c2cc06.1715125376.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed May 8, 2024 at 10:15 AM AEST, BALATON Zoltan wrote:
> Repurpose get_segment_6xx_tlb() to do the whole address translation
> for POWERPC_MMU_SOFT_6xx MMU model by moving the BAT check there and
> renaming it to match other similar functions. These are only called
> once together so no need to keep these separate functions and
> combining them simplifies the caller allowing further restructuring.
>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  target/ppc/mmu_common.c | 26 ++++++++++++--------------
>  1 file changed, 12 insertions(+), 14 deletions(-)
>
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index aa137123a4..181273579b 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -360,19 +360,23 @@ static int get_bat_6xx_tlb(CPUPPCState *env, mmu_ct=
x_t *ctx,
>      return ret;
>  }
> =20
> -/* Perform segment based translation */
> -static int get_segment_6xx_tlb(CPUPPCState *env, mmu_ctx_t *ctx,
> -                               target_ulong eaddr, MMUAccessType access_=
type,
> -                               int type)
> +static int mmu6xx_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
> +                                       target_ulong eaddr,
> +                                       MMUAccessType access_type, int ty=
pe)
>  {
>      PowerPCCPU *cpu =3D env_archcpu(env);
>      hwaddr hash;
> -    target_ulong vsid;
> +    target_ulong vsid, sr, pgidx;
>      int ds, target_page_bits;
>      bool pr;
>      int ret;
> -    target_ulong sr, pgidx;
> =20
> +    /* First try to find a BAT entry if there are any */
> +    if (env->nb_BATs && get_bat_6xx_tlb(env, ctx, eaddr, access_type) =
=3D=3D 0) {
> +        return 0;
> +    }
> +
> +    /* Perform segment based translation when no BATs matched */
>      pr =3D FIELD_EX64(env->msr, MSR, PR);
>      ctx->eaddr =3D eaddr;
> =20
> @@ -1194,14 +1198,8 @@ int get_physical_address_wtlb(CPUPPCState *env, mm=
u_ctx_t *ctx,
>          if (real_mode) {
>              ret =3D check_physical(env, ctx, eaddr, access_type);
>          } else {
> -            /* Try to find a BAT */
> -            if (env->nb_BATs !=3D 0) {
> -                ret =3D get_bat_6xx_tlb(env, ctx, eaddr, access_type);
> -            }
> -            if (ret < 0) {
> -                /* We didn't match any BAT entry or don't have BATs */
> -                ret =3D get_segment_6xx_tlb(env, ctx, eaddr, access_type=
, type);
> -            }
> +            ret =3D mmu6xx_get_physical_address(env, ctx, eaddr, access_=
type,
> +                                              type);
>          }
>          break;
> =20


