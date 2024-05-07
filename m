Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96227C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 09:20:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4Gyf-0004Mr-39; Tue, 07 May 2024 05:19:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4Gyd-0004MT-Ex; Tue, 07 May 2024 05:19:11 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4Gyc-0003wN-0K; Tue, 07 May 2024 05:19:11 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2b3c711dfd3so2253187a91.2; 
 Tue, 07 May 2024 02:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715073548; x=1715678348; darn=nongnu.org;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ChL5QlV/NNuHxB5hQirEygLiXEwndmqvymPljTskbBg=;
 b=ZzHx5hwju4MWOFk6jlkRjGch0Feids1IZXFK+7PsJT4Mzfo5tzqIWsS1O8WXS7bZAM
 gP6DFUbV9kirrQhRkXslI23yN0n3ADOqF4Wd0nx3DbekNsYHOHe1oTS8eUQ2SU+s5agb
 d/4tfsr5Bp/5VXVCdoz02pa5iGyOYFMfJ8lCk5eYEAdcyn7cyTitpWA6t4paIR1a5TQl
 92fA0YS/u6/Hka/LRfTTt2SiJ8T61fIiPJeCcRKny+x1o5lCWD/4/nzyAfR3x/qi6sS6
 28RoA2woCHnf5UNdmS3dnhDAXd7uAir3eEREkSHrVY+o/M2IYeXRIVUAy7pTB7ylc0UV
 4GPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715073548; x=1715678348;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ChL5QlV/NNuHxB5hQirEygLiXEwndmqvymPljTskbBg=;
 b=Qh0VPi/sZ8lbHiDjTihNat2z8JINDRwUsiUckbGYYdV36W/3YKwzovkxwsUihmVchI
 wTY0xPlPXMfaEL+7IfgQ7MPqca6O3I/TJU9xnh9ApjVr7pPrhJ4Po9sJSLMFLSfBbQuN
 8Z/oUso6drvRNXQqZeq5xCtrzTcRYNnRMQMxfMk0r7KQFKVRXyz8xdv7wbAHbaC7BWXN
 Y55D2WYW8qb8vNCAKBQkDW1wI/IOF6zEq0eu7sWIH3QioMLcbzLT9gzUZmK+wsGF+usk
 lPFx+D+drYFOXtgionQLA5YyCfaziUvT9frmMRbCMc4087xJLBBplWInVS706rVH/lfp
 LrsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUBurqKtAjOjNu2J5Aj2rHTbEsFT0ZX5zV6M3a4FC8N8aGQjqb94UsehU9PlUSG3Oq705vSalpcGICkCuCxo7LLi2B+dvFWcnV+u09pI8/Boe7NRgsaArdXfg=
X-Gm-Message-State: AOJu0YyF2stk4xptTmshbKwA50ZiAYHIxW/7i9Vce0AnP4B5prxl5zS4
 eYDPAAj2q1M1FiLC/bjWpq88H6jRloyN1Jxlda4QBRgea4UZ2zkI
X-Google-Smtp-Source: AGHT+IEqTwp3eNYxt9wFRLX0BMBgl4LH+T38k0f5k4yjigFTuU68blmKJBCtUkfZw0rOayqpYqEB5w==
X-Received: by 2002:a17:90b:1487:b0:2b2:9660:7d44 with SMTP id
 js7-20020a17090b148700b002b296607d44mr9730581pjb.25.1715073548141; 
 Tue, 07 May 2024 02:19:08 -0700 (PDT)
Received: from localhost (220-245-239-57.tpgi.com.au. [220.245.239.57])
 by smtp.gmail.com with ESMTPSA id
 d20-20020a17090ae29400b0029bf32b524esm11336481pjz.13.2024.05.07.02.19.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 May 2024 02:19:07 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 07 May 2024 19:19:02 +1000
Message-Id: <D13ATWC6RQVA.9ZLADDX17XUU@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH v2 05/28] target/ppc/mmu_common.c: Move calculation of a
 value closer to its usage
From: "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.17.0
References: <cover.1714606359.git.balaton@eik.bme.hu>
 <c60019daaf0218b64205ba2ec4d5f8edca20776a.1714606359.git.balaton@eik.bme.hu>
In-Reply-To: <c60019daaf0218b64205ba2ec4d5f8edca20776a.1714606359.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102d.google.com
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
> In mmubooke_check_tlb() prot2 is calculated first but only used after
> an unrelated check that can return before tha value is used. Move the
> calculation after the check, closer to where it is used, to keep them
> together and avoid computing it when not needed.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Reviwed-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  target/ppc/mmu_common.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index 751403f1c8..168ff842a5 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -634,12 +634,6 @@ static int mmubooke_check_tlb(CPUPPCState *env, ppce=
mb_tlb_t *tlb,
>          return -1;
>      }
> =20
> -    if (FIELD_EX64(env->msr, MSR, PR)) {
> -        prot2 =3D tlb->prot & 0xF;
> -    } else {
> -        prot2 =3D (tlb->prot >> 4) & 0xF;
> -    }
> -
>      /* Check the address space */
>      if ((access_type =3D=3D MMU_INST_FETCH ?
>          FIELD_EX64(env->msr, MSR, IR) :
> @@ -648,6 +642,11 @@ static int mmubooke_check_tlb(CPUPPCState *env, ppce=
mb_tlb_t *tlb,
>          return -1;
>      }
> =20
> +    if (FIELD_EX64(env->msr, MSR, PR)) {
> +        prot2 =3D tlb->prot & 0xF;
> +    } else {
> +        prot2 =3D (tlb->prot >> 4) & 0xF;
> +    }
>      *prot =3D prot2;
>      if (prot2 & prot_for_access_type(access_type)) {
>          qemu_log_mask(CPU_LOG_MMU, "%s: good TLB!\n", __func__);


