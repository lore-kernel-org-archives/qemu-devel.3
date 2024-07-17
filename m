Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C978EC3DA4B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 11:24:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU2lJ-0000MA-Os; Wed, 17 Jul 2024 07:23:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sU2lH-0000Bh-Lv; Wed, 17 Jul 2024 07:23:55 -0400
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sU2lF-0006p5-Rf; Wed, 17 Jul 2024 07:23:55 -0400
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-5b53bb4bebaso376372eaf.0; 
 Wed, 17 Jul 2024 04:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721215431; x=1721820231; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wwI/SRj99yjPQr9rGqVr8fbwxRLWj9jJISoN9/IKrm4=;
 b=gX4M84MQ1YiXixcTa1oouU0UlP/q5dMHwLd1g23+l2hVTz2i9XgfwJI1jsdFGDHlV3
 fgQ0B/KgLTtD63oRNdFagVW/MsvpnN/LFVUjlrYYzIUfjLPC/hgaTdDnWIQMvio2iJcw
 TAaIl0I7snIZb3qw706GWz5q2Tpq6VapgPjnGvD8dXKRlUMkWpz6BhNzF6Wc7B6kPBvZ
 MahZPgAHSagI09tUcP95LJfzNg+cW8VJ+tAzNbUFMEVWM9i358+1n4DtBl8P6ud+9BMc
 q2Qo+Blh334fxMNig2C9nsfKsYTRVbXlWiGO7p61+JPnaxhUagIHi8Jnz+ovuGZlRSvx
 IUOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721215431; x=1721820231;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wwI/SRj99yjPQr9rGqVr8fbwxRLWj9jJISoN9/IKrm4=;
 b=TtXdPxyNFjoB02062GMLiDMrzmxFSp4KWHNa/Qwa+I0H4Br/XhbMYWY+2WjBW82Cq2
 5zyMlXvrUhiQ3Oa373SHcu8s2NwWOoUG4ZWBoj/n+VCfMfQoVkr5j3vD7c07gNC2nfrV
 SiJGCghYqmNDX/7zgSe8ijRkj+NLN7fev5RU8oftrZ60YsCVzs9osGLRcAvOyL8Oz9zl
 5PozAjuKc2yf71xMoSgAfoYMiacZU4WR/PzTAkC8TyySkG5Gpe+LL++4ZW+aRe6QwZHW
 0yNeHmexksLHLkIiRoKZu58su8hRMdeEGwo2s6q0RHXYEBNnLjRzMPQdSQT1r8+Z3nAQ
 nfwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYQkxaoM5FcxVUfWnHwxUYbUa3mcB2Tx/hJXsZDkewYZlAeK6xJLg5/F4m/lOAnVpr1orvVZNmHSnZq6XJTfc5BnRhXB4=
X-Gm-Message-State: AOJu0Yz5/mZY8Cd9DPTOoUeig0e+vn+LAd9LVecDD/65qDOpMg0Hpuzh
 N3SVp7Hs8DtnVU9wWK4Bb5QtXLIkSofr3ZFlKXxRPtreME4A+Zq0
X-Google-Smtp-Source: AGHT+IFtj4GewuV+D8emF9p27hbz/OzL6JyENLwnYgrqeFn3Epf7EkuTomUdSZPvRtS/L92LxjUAgw==
X-Received: by 2002:a05:6870:9a25:b0:254:9501:db80 with SMTP id
 586e51a60fabf-260d91e0b99mr1186129fac.14.1721215430717; 
 Wed, 17 Jul 2024 04:23:50 -0700 (PDT)
Received: from localhost ([1.146.100.214]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b7ecc9165sm7917982b3a.188.2024.07.17.04.23.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jul 2024 04:23:50 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 17 Jul 2024 21:23:45 +1000
Message-Id: <D2RRY2BN4FC0.2LGCOTO2JZVFY@gmail.com>
Cc: <qemu-ppc@nongnu.org>, <balaton@eik.bme.hu>
Subject: Re: [PATCH 2/4] target/ppc: Hoist dcbz_size out of dcbz_common
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Richard Henderson" <richard.henderson@linaro.org>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.17.0
References: <20240702234659.2106870-1-richard.henderson@linaro.org>
 <20240702234659.2106870-3-richard.henderson@linaro.org>
In-Reply-To: <20240702234659.2106870-3-richard.henderson@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::c36;
 envelope-from=npiggin@gmail.com; helo=mail-oo1-xc36.google.com
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

On Wed Jul 3, 2024 at 9:46 AM AEST, Richard Henderson wrote:
> The 970 logic does not apply to dcbzep, which is an e500 insn.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  target/ppc/mem_helper.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
>
> diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
> index 361fd72226..5067919ff8 100644
> --- a/target/ppc/mem_helper.c
> +++ b/target/ppc/mem_helper.c
> @@ -271,22 +271,12 @@ void helper_stsw(CPUPPCState *env, target_ulong add=
r, uint32_t nb,
>  }
> =20
>  static void dcbz_common(CPUPPCState *env, target_ulong addr,
> -                        uint32_t opcode, int mmu_idx, uintptr_t retaddr)
> +                        int dcbz_size, int mmu_idx, uintptr_t retaddr)
>  {
> -    target_ulong mask, dcbz_size =3D env->dcache_line_size;
> -    uint32_t i;
> +    target_ulong mask =3D ~(target_ulong)(dcbz_size - 1);
>      void *haddr;
> =20
> -#if defined(TARGET_PPC64)
> -    /* Check for dcbz vs dcbzl on 970 */
> -    if (env->excp_model =3D=3D POWERPC_EXCP_970 &&
> -        !(opcode & 0x00200000) && ((env->spr[SPR_970_HID5] >> 7) & 0x3) =
=3D=3D 1) {
> -        dcbz_size =3D 32;
> -    }
> -#endif
> -
>      /* Align address */
> -    mask =3D ~(dcbz_size - 1);
>      addr &=3D mask;
> =20
>      /* Check reservation */
> @@ -300,7 +290,7 @@ static void dcbz_common(CPUPPCState *env, target_ulon=
g addr,
>          memset(haddr, 0, dcbz_size);
>      } else {
>          /* Slow path */
> -        for (i =3D 0; i < dcbz_size; i +=3D 8) {
> +        for (int i =3D 0; i < dcbz_size; i +=3D 8) {
>              cpu_stq_mmuidx_ra(env, addr + i, 0, mmu_idx, retaddr);
>          }
>      }
> @@ -308,12 +298,22 @@ static void dcbz_common(CPUPPCState *env, target_ul=
ong addr,
> =20
>  void helper_dcbz(CPUPPCState *env, target_ulong addr, uint32_t opcode)
>  {
> -    dcbz_common(env, addr, opcode, ppc_env_mmu_index(env, false), GETPC(=
));
> +    int dcbz_size =3D env->dcache_line_size;
> +
> +#if defined(TARGET_PPC64)
> +    /* Check for dcbz vs dcbzl on 970 */
> +    if (env->excp_model =3D=3D POWERPC_EXCP_970 &&
> +        !(opcode & 0x00200000) && ((env->spr[SPR_970_HID5] >> 7) & 0x3) =
=3D=3D 1) {
> +        dcbz_size =3D 32;
> +    }
> +#endif
> +
> +    dcbz_common(env, addr, dcbz_size, ppc_env_mmu_index(env, false), GET=
PC());
>  }
> =20
>  void helper_dcbzep(CPUPPCState *env, target_ulong addr, uint32_t opcode)
>  {
> -    dcbz_common(env, addr, opcode, PPC_TLB_EPID_STORE, GETPC());
> +    dcbz_common(env, addr, env->dcache_line_size, PPC_TLB_EPID_STORE, GE=
TPC());
>  }
> =20
>  void helper_icbi(CPUPPCState *env, target_ulong addr)


