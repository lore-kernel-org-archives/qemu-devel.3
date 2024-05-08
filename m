Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14A26C25B75
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 12:44:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4ge6-0006tf-Ar; Wed, 08 May 2024 08:43:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4ge5-0006tD-67; Wed, 08 May 2024 08:43:41 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4ge3-0007JO-Ds; Wed, 08 May 2024 08:43:40 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-5f415fd71f8so3285821a12.3; 
 Wed, 08 May 2024 05:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715172217; x=1715777017; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ieZ0vCdr6R64hCFjE9M9F/pX46I1vACKS4vqu4E0bLI=;
 b=l3N/pS7B7fF9zfljH1Y8hN7UaBOliKOnSGQkSC2tej+qQ3N5YIsRvNgz1jsmrECftu
 5yvN7F594pJlZz56EwBxCn0hCBi6oh7LPjB5TPJmE7h0HhMmHLefuG/a4d7lDhDy7fvz
 mzCR3+VKKZbiYM4/eCOYm42bT4MITS4soOVlDnWc+fAnlvtqzYPUwfDtiBioF7K+sz4F
 /jSFzz7jR7PEw1oSGnQJzro/s7fEusgkwjs8+BUNiGLRuHdEtK8gXahQZRuRUQn3lbCO
 ITGKud9UtOOH1iUX+MdjJ8jFenK8ef1OYgHkk+zc1fFYRtsdtBByV+QHG2GVWTBzP/OJ
 3LvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715172217; x=1715777017;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ieZ0vCdr6R64hCFjE9M9F/pX46I1vACKS4vqu4E0bLI=;
 b=AYpv1Fo/wAy5DeS7ZBzOhGW8zP32N9VLUSlggTO7G2IGEmAgEPOkwq/OPaDxUwnebZ
 L83OEJ0bDt7oQO6wyY+mFKGc38Al2hynaf499266rXhbt2XrWISTHJu++ZHwynnCMOuV
 OtvN1tNlTpKvXMlovETfGIe/1S3EeeMu63QnkHxYZjI60R2RLGBZyKUtjNk55SSnIEnl
 ntzlCPCDasiqkPN6Bi4mctkIkTCmvJUvDxKTNXHInASj37G5yWKZVMiLwUpgMPdJNREF
 dvm7ddCWHwaNz5m2BA1sdWQUcgm4APjbVB375ZqMJ+/NhQyZJiGFTSI5acDXN1L6sWpB
 FDcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRwuwaFvjVu1heHlKwHm7NLH6W5uzMtpKR9Oz2rzENCtfVL20k7XUa9AW6wnydtCZzKWjaAN5Vn3XfEThBZaJZaz6blk9Jh41HSkeUErxgIDzpLPc7r1WNH1Y=
X-Gm-Message-State: AOJu0YwiRhPTWX3RwhOu6HyQ0W2ovdHWFCcFRNFBcST0WG7E0C1Rxcxz
 Kkw5h7/ho72Q+Pva3n1Vl1i6bnQN6O/28ENsQf0xz2yCvgQAGW9W
X-Google-Smtp-Source: AGHT+IFAEDv493x5+DFzZQHkPHEpG9YC1RCNTcWfeSo/37kmn1cDtcthhJDmDgqNQedhlT5ZyoF5Xg==
X-Received: by 2002:a05:6a21:622:b0:1af:814f:ce69 with SMTP id
 adf61e73a8af0-1afc8dea26bmr2232470637.38.1715172217439; 
 Wed, 08 May 2024 05:43:37 -0700 (PDT)
Received: from localhost ([1.146.8.34]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2b62886b608sm1334840a91.27.2024.05.08.05.43.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 05:43:36 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 May 2024 22:43:31 +1000
Message-Id: <D149T0JQP30B.19VOKY5L4ZMSV@gmail.com>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH v3 10/33] target/ppc/mmu_common.c: Move else branch to
 avoid large if block
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.17.0
References: <cover.1715125376.git.balaton@eik.bme.hu>
 <ee43b245720833981a9c8152920fde31713f78e4.1715125376.git.balaton@eik.bme.hu>
In-Reply-To: <ee43b245720833981a9c8152920fde31713f78e4.1715125376.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52b.google.com
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
> In mmu6xx_get_physical_address() we have a large if block with a two
> line else branch that effectively returns. Invert the condition and
> move the else there to allow deindenting the large if block to make
> the flow easier to follow.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  target/ppc/mmu_common.c | 71 ++++++++++++++++++++---------------------
>  1 file changed, 34 insertions(+), 37 deletions(-)
>
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index 181273579b..9d337a73ba 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -405,47 +405,44 @@ static int mmu6xx_get_physical_address(CPUPPCState =
*env, mmu_ctx_t *ctx,
>      ret =3D -1;
>      if (!ds) {
>          /* Check if instruction fetch is allowed, if needed */
> -        if (type !=3D ACCESS_CODE || ctx->nx =3D=3D 0) {
> -            /* Page address translation */
> -            qemu_log_mask(CPU_LOG_MMU, "htab_base " HWADDR_FMT_plx
> -                    " htab_mask " HWADDR_FMT_plx
> -                    " hash " HWADDR_FMT_plx "\n",
> -                    ppc_hash32_hpt_base(cpu), ppc_hash32_hpt_mask(cpu), =
hash);
> -            ctx->hash[0] =3D hash;
> -            ctx->hash[1] =3D ~hash;
> -
> -            /* Initialize real address with an invalid value */
> -            ctx->raddr =3D (hwaddr)-1ULL;
> -            /* Software TLB search */
> -            ret =3D ppc6xx_tlb_check(env, ctx, eaddr, access_type);
> +        if (type =3D=3D ACCESS_CODE && ctx->nx) {
> +            qemu_log_mask(CPU_LOG_MMU, "No access allowed\n");
> +            return -3;
> +        }

Function is already inconsistent with assigning ret and falling
through to the return ret at the end vs returning immediately, so
okay since you're tidying it up.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> +        /* Page address translation */
> +        qemu_log_mask(CPU_LOG_MMU, "htab_base " HWADDR_FMT_plx " htab_ma=
sk "
> +                      HWADDR_FMT_plx " hash " HWADDR_FMT_plx "\n",
> +                      ppc_hash32_hpt_base(cpu), ppc_hash32_hpt_mask(cpu)=
, hash);
> +        ctx->hash[0] =3D hash;
> +        ctx->hash[1] =3D ~hash;
> +
> +        /* Initialize real address with an invalid value */
> +        ctx->raddr =3D (hwaddr)-1ULL;
> +        /* Software TLB search */
> +        ret =3D ppc6xx_tlb_check(env, ctx, eaddr, access_type);
>  #if defined(DUMP_PAGE_TABLES)
> -            if (qemu_loglevel_mask(CPU_LOG_MMU)) {
> -                CPUState *cs =3D env_cpu(env);
> -                hwaddr curaddr;
> -                uint32_t a0, a1, a2, a3;
> -
> -                qemu_log("Page table: " HWADDR_FMT_plx " len " HWADDR_FM=
T_plx
> -                         "\n", ppc_hash32_hpt_base(cpu),
> -                         ppc_hash32_hpt_mask(cpu) + 0x80);
> -                for (curaddr =3D ppc_hash32_hpt_base(cpu);
> -                     curaddr < (ppc_hash32_hpt_base(cpu)
> -                                + ppc_hash32_hpt_mask(cpu) + 0x80);
> -                     curaddr +=3D 16) {
> -                    a0 =3D ldl_phys(cs->as, curaddr);
> -                    a1 =3D ldl_phys(cs->as, curaddr + 4);
> -                    a2 =3D ldl_phys(cs->as, curaddr + 8);
> -                    a3 =3D ldl_phys(cs->as, curaddr + 12);
> -                    if (a0 !=3D 0 || a1 !=3D 0 || a2 !=3D 0 || a3 !=3D 0=
) {
> -                        qemu_log(HWADDR_FMT_plx ": %08x %08x %08x %08x\n=
",
> -                                 curaddr, a0, a1, a2, a3);
> -                    }
> +        if (qemu_loglevel_mask(CPU_LOG_MMU)) {
> +            CPUState *cs =3D env_cpu(env);
> +            hwaddr curaddr;
> +            uint32_t a0, a1, a2, a3;
> +
> +            qemu_log("Page table: " HWADDR_FMT_plx " len " HWADDR_FMT_pl=
x "\n",
> +                     ppc_hash32_hpt_base(cpu), ppc_hash32_hpt_mask(cpu) =
+ 0x80);
> +            for (curaddr =3D ppc_hash32_hpt_base(cpu);
> +                 curaddr < (ppc_hash32_hpt_base(cpu)
> +                            + ppc_hash32_hpt_mask(cpu) + 0x80);
> +                 curaddr +=3D 16) {
> +                a0 =3D ldl_phys(cs->as, curaddr);
> +                a1 =3D ldl_phys(cs->as, curaddr + 4);
> +                a2 =3D ldl_phys(cs->as, curaddr + 8);
> +                a3 =3D ldl_phys(cs->as, curaddr + 12);
> +                if (a0 !=3D 0 || a1 !=3D 0 || a2 !=3D 0 || a3 !=3D 0) {
> +                    qemu_log(HWADDR_FMT_plx ": %08x %08x %08x %08x\n",
> +                             curaddr, a0, a1, a2, a3);
>                  }
>              }
> -#endif
> -        } else {
> -            qemu_log_mask(CPU_LOG_MMU, "No access allowed\n");
> -            ret =3D -3;
>          }
> +#endif
>      } else {
>          qemu_log_mask(CPU_LOG_MMU, "direct store...\n");
>          /* Direct-store segment : absolutely *BUGGY* for now */


