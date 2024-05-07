Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42F1DC10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 09:37:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4HFZ-0002Vj-22; Tue, 07 May 2024 05:36:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4HFW-0002VB-Vv; Tue, 07 May 2024 05:36:39 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4HFV-0006Lh-8n; Tue, 07 May 2024 05:36:38 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1ec4dc64c6cso19945455ad.0; 
 Tue, 07 May 2024 02:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715074595; x=1715679395; darn=nongnu.org;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=McJgeskVaNBhXNd2L/5EeBazzW54LoAyMkLBM+eXtSM=;
 b=bP7+44hjuigICeNuT1Oa5CkWKHU6kbx0Zz1TJODyvMzm3z8sKlwJus+mJT9o4kxzBt
 AnJIlsCnTxm5cK/VwO1yIUSuQ72KHjf2wjAD2Zqp5zQokA02Jo6qMEk46TZSYjMwiGZm
 breWiSY9agSECUso7PXZnaYgyTINRGJEXv5491WRxHWuRGSEuKAYvmMGqCSAu5fp1CwY
 4tZ6Jl2P3Fb3a6y4HbGDoo/FjszJPgcpP4Gs3pf9CrzsbGuRW5HGzfjCsZdFF25dVnOR
 vtwZgWU3I0WcIuZYQqaAq6xP70OREnoHsjcAjKsilgRSU5N7d83HGyn3E/NyRyUhA4TW
 0pGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715074595; x=1715679395;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=McJgeskVaNBhXNd2L/5EeBazzW54LoAyMkLBM+eXtSM=;
 b=rFGL5iL6UvhpW3qBIkoErTX/Hqeun7HVoTyvlKEsnkN1tBYZ7kJbMluMy/SP1ht60u
 uM1q7v1vg6qMs2iQG9oPNf9wQYE2mL+0Mycu7kkMjKMtR5muz8sJOOs4vGKJbyl8n4XR
 H8U1fUfjwTpGnZvvX8umNytMFbOoKpDjZMc0QHbrAEFFPEjGzEEnDNQmIeK4Omr49eTZ
 bR9npPS8HSmDk8+pwd+6WAG4li7iMxlZJy9FqtPTYzcZ7sKYbR0WezohLQ0yDk1C7VlV
 t5Udt4w1TvdxgJwL60+ruLm4FxzwDkdKEmy1Ce5VU40YEF3TbzijesC2VobnnS6uhIup
 3rcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWzBsLjpaUt56VmHW+se01bgTMGcV5GHHShvY94YuoTFBe065lrJ5jrxJnTlq7VI9ntBVo2yu3UQIJifa7FQJT+3A7otuc8TFtMv51WWpDkFIVpi51a9tPMc0=
X-Gm-Message-State: AOJu0Yz6+8Vio6JBd+pUdBA84EWWfJHcQrqWGIO/cGs3jtdOavJqJycJ
 LFLuXdAE8LJdE/cObUfQqmOliNrlfNXIwznqy8/aa7oYSZH9Rm3ek+jU4g==
X-Google-Smtp-Source: AGHT+IEjWGWGt3oN2BFRAZp3ou/Mn48NYiZaWYUB23WH+1zfQoeCPsMzB7spguwG04joNuBcVd85iA==
X-Received: by 2002:a17:903:18d:b0:1e4:d548:818f with SMTP id
 z13-20020a170903018d00b001e4d548818fmr15276933plg.58.1715074595304; 
 Tue, 07 May 2024 02:36:35 -0700 (PDT)
Received: from localhost (220-245-239-57.tpgi.com.au. [220.245.239.57])
 by smtp.gmail.com with ESMTPSA id
 f5-20020a170902ce8500b001e98f928d0fsm9657378plg.10.2024.05.07.02.36.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 May 2024 02:36:35 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 07 May 2024 19:36:29 +1000
Message-Id: <D13B79ISMML7.1VPDPUVQ8UBHQ@gmail.com>
Subject: Re: [PATCH v2 09/28] target/ppc/mmu_common.c: Drop cases for
 unimplemented MPC8xx MMU
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
X-Mailer: aerc 0.17.0
References: <cover.1714606359.git.balaton@eik.bme.hu>
 <f2a28beff3a413aac97d17b46985a752b9bd0e60.1714606359.git.balaton@eik.bme.hu>
In-Reply-To: <f2a28beff3a413aac97d17b46985a752b9bd0e60.1714606359.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x635.google.com
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
> The default case will catch this and abort the same way and there is
> still a warning about it in ppc_tlb_invalidate_all() so drop these
> from mmu_common.c to simplify this code.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  target/ppc/mmu_common.c | 9 ---------
>  1 file changed, 9 deletions(-)
>
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index 45b6501ecb..98730035b1 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -1218,10 +1218,6 @@ int get_physical_address_wtlb(CPUPPCState *env, mm=
u_ctx_t *ctx,
>          ret =3D mmubooke206_get_physical_address(env, ctx, eaddr, access=
_type,
>                                                 mmu_idx);
>          break;
> -    case POWERPC_MMU_MPC8xx:
> -        /* XXX: TODO */
> -        cpu_abort(env_cpu(env), "MPC8xx MMU model is not implemented\n")=
;
> -        break;
>      case POWERPC_MMU_REAL:
>          if (real_mode) {
>              ret =3D check_physical(env, ctx, eaddr, access_type);
> @@ -1352,8 +1348,6 @@ static bool ppc_jumbo_xlate(PowerPCCPU *cpu, vaddr =
eaddr,
>                      env->spr[SPR_BOOKE_DEAR] =3D eaddr;
>                      env->spr[SPR_BOOKE_ESR] =3D mmubooke206_esr(mmu_idx,=
 MMU_DATA_LOAD);
>                      break;
> -                case POWERPC_MMU_MPC8xx:
> -                    cpu_abort(cs, "MPC8xx MMU model is not implemented\n=
");
>                  case POWERPC_MMU_REAL:
>                      cpu_abort(cs, "PowerPC in real mode should never rai=
se "
>                                "any MMU exceptions\n");
> @@ -1426,9 +1420,6 @@ static bool ppc_jumbo_xlate(PowerPCCPU *cpu, vaddr =
eaddr,
>                          env->spr[SPR_40x_ESR] =3D 0x00000000;
>                      }
>                      break;
> -                case POWERPC_MMU_MPC8xx:
> -                    /* XXX: TODO */
> -                    cpu_abort(cs, "MPC8xx MMU model is not implemented\n=
");
>                  case POWERPC_MMU_BOOKE206:
>                      booke206_update_mas_tlb_miss(env, eaddr, access_type=
, mmu_idx);
>                      /* fall through */


