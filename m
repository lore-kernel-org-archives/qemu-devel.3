Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D68D5C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 10:12:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4HnN-0005Xz-1p; Tue, 07 May 2024 06:11:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4Hn9-0005U4-K8; Tue, 07 May 2024 06:11:25 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4Hn6-0007Tv-7O; Tue, 07 May 2024 06:11:22 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6f44dc475f4so1906234b3a.2; 
 Tue, 07 May 2024 03:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715076675; x=1715681475; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zy4E1WTzRZ6UqY0m43lSDzQUCgtXtCphXphveT0Np7s=;
 b=SJGZI9jz7r1EVjjMiwN9LL8gq7BNSyWYNVB7OajdonSeg7CGJXGvqAB/lojjeKlk2o
 pwB83t3+DJ/S3RCFoXid/ufMmLqR1R0AZCnA0rtyrWPW2u7www6A1H2zRg/lPSq+KAZS
 fu5cDr2LtuEb+G78MbPN5HiTy4taicpJD4YF1RXLG0tsn/oNoR1sL1ikOnSUUiGlyxeI
 BpDLmluH3HpKAjBhWsGOWAp4GIbmE79Xf7A1vxQ5frX42Z22un3ZgsQg2t1VE5hXPNvJ
 L9pTV+rxeikSOxubzFwunccoSy+FNiB/6t2ZA3tQZSNCvDSMIus9LE/Ag5yTNx/FW+98
 d5/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715076675; x=1715681475;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Zy4E1WTzRZ6UqY0m43lSDzQUCgtXtCphXphveT0Np7s=;
 b=oXtRfJvEoKVhI9Dpyg9CUKdvEcB61D7rL3TxnnC3H9caRjd0VEwyGJZMyHuZC+6OK/
 WvazI64Lzs6Vo5IzxczA9hnGP3gRMlY/itrwKufmQwHSm+7r/kznTzN/Cfw+Jct8O13O
 WgpZq+UYXASX9nL6WtjCF6R96D2OxY/niKG2qRPwlZhfRkuOouXtj3NJqjCo4JxXqLMZ
 JHCWg24l+3kNGFxKVl7qeam6zNEgzBpPRDkEVKgWpNVvqpCJ//Jc95F8pK4LSCM+ZK44
 sr8V7RNf/ns4u2TrjNyIoeH/rC4louLFYuytZTVCYU+rvZZqiXxMWCSw7BBmZvcXJSdO
 Pahw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmhe5RiEk7TQYuNQTRoQVJJ8S5D9dSziUqjOavWeEEoUn8rx5sIt/t5qX/7UyuAgQyj8mXeucOkqpJzNAPohBp3pOGvAXtk4C2LQeaYXVqLEAJLSaiCUm2SOg=
X-Gm-Message-State: AOJu0YzdkD8kzMJzWkyQ8ylUx2fbTNtTaLzQrAkJtJwHJL3ldC7g9OMh
 Lv3OJbAzrgC3K8vb3HI5Sua8xsIR4xVdQN1CTcYVDHaUdd9T/7OO
X-Google-Smtp-Source: AGHT+IEiILzQWS8DKbnQAsVacKDAusEsM65wkUKDdg7bfUJ3s9JH+J2+yfGseFtpMHv2RaiCtvCaOA==
X-Received: by 2002:a05:6a00:1907:b0:6f3:eaa2:539f with SMTP id
 y7-20020a056a00190700b006f3eaa2539fmr14530302pfi.16.1715076675490; 
 Tue, 07 May 2024 03:11:15 -0700 (PDT)
Received: from localhost (220-245-239-57.tpgi.com.au. [220.245.239.57])
 by smtp.gmail.com with ESMTPSA id
 c11-20020aa7880b000000b006ed045e3a70sm9101638pfo.25.2024.05.07.03.11.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 May 2024 03:11:15 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 07 May 2024 20:11:10 +1000
Message-Id: <D13BXTIHY177.2CXLFT8CRIE6M@gmail.com>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH v2 19/28] target/ppc/mmu_common.c: Replace hard coded
 constants in ppc_jumbo_xlate()
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.17.0
References: <cover.1714606359.git.balaton@eik.bme.hu>
 <4285d21c815fda242fa66c54169504fb3e7b26c7.1714606359.git.balaton@eik.bme.hu>
In-Reply-To: <4285d21c815fda242fa66c54169504fb3e7b26c7.1714606359.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x429.google.com
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

On Thu May 2, 2024 at 9:43 AM AEST, BALATON Zoltan wrote:
> The "2" in booke206_update_mas_tlb_miss() call corresponds to
> MMU_INST_FETCH which is the value of access_type in this branch;
> mmubooke206_esr() only checks for MMU_DATA_STORE and it's called from
> code access so using MMU_DATA_LOAD here seems wrong so replace it with
> access_type here as well that yields the same result. This also makes
> these calls the same as the data access branch further down.

Looks right.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  target/ppc/mmu_common.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index 2487b4deff..762b13805b 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -1288,13 +1288,13 @@ static bool ppc_jumbo_xlate(PowerPCCPU *cpu, vadd=
r eaddr,
>                  env->spr[SPR_40x_ESR] =3D 0x00000000;
>                  break;
>              case POWERPC_MMU_BOOKE206:
> -                booke206_update_mas_tlb_miss(env, eaddr, 2, mmu_idx);
> +                booke206_update_mas_tlb_miss(env, eaddr, access_type, mm=
u_idx);
>                  /* fall through */
>              case POWERPC_MMU_BOOKE:
>                  cs->exception_index =3D POWERPC_EXCP_ITLB;
>                  env->error_code =3D 0;
>                  env->spr[SPR_BOOKE_DEAR] =3D eaddr;
> -                env->spr[SPR_BOOKE_ESR] =3D mmubooke206_esr(mmu_idx, MMU=
_DATA_LOAD);
> +                env->spr[SPR_BOOKE_ESR] =3D mmubooke206_esr(mmu_idx, acc=
ess_type);
>                  break;
>              case POWERPC_MMU_REAL:
>                  cpu_abort(cs, "PowerPC in real mode should never raise "


