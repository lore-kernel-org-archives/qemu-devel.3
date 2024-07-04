Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4A0FC3065C
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 07:20:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPGkp-0004fP-JX; Thu, 04 Jul 2024 03:19:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPGkn-0004dH-BT; Thu, 04 Jul 2024 03:19:41 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPGkl-0004pr-J0; Thu, 04 Jul 2024 03:19:41 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2c95ca60719so264432a91.3; 
 Thu, 04 Jul 2024 00:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720077577; x=1720682377; darn=nongnu.org;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oYIVcDd6a6XHVfTem6LOfnljo1ZQ+M4znzmkeJSy5U4=;
 b=GzpYo7VMa69hJ/uVUtBYh/EMrET5YITXdmRkS0WIBSojLmisRJPTJ+YL+PK46FehJA
 cTO/IcRrzrCx/KGJ9tF48xGrpPZ1W19X4FphG50XtX13RDwkG/NBM6HR4ZEk+6Gfak6/
 WmCtaaVnHTC6cd6s55QTQ2J2nqu9i4Ui3iHpJcjpuMM+ViRMstSCajp2p+Tyl6P81HfE
 48gjl61+4G04QhOaj2ZhY7lQZQ+Jq1PNBGL7moTMcBDp0ns9VIZ/AWZH8YigXMPtqqS9
 /2wd4kUaSrR3+CaLI9fsy9KUyUjigUOpukWnUa2/oWf+Gv5mZWgLvQbEziQgRIpiUXiV
 KQeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720077577; x=1720682377;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=oYIVcDd6a6XHVfTem6LOfnljo1ZQ+M4znzmkeJSy5U4=;
 b=m6np4XMi9WmMMH2tD2jU0L/JU/OnNojjEgnSEaypGJ/iBB/x506QkFMLfUs2nalFbs
 Gq+tOcsUA/XEwd2yK/o317epCjSvMrdnPsIlPjLzoqTzDKVVhE8QYPfJ1oLZnY46Ql2X
 J6sFU3Er4WyV4iaA3qignJrxHEy6pu2op/45SL3fdd38XMSgUqR5Z1UUOvyCHAqtFJBP
 CnZzXC0GLF0Qkvmq166gWuV4U00nTG4fwkd0qYqmbSQ4CZ+qVdZmgE8+op4y67CoX+PG
 fzT9ojPq7NtJMVaG1Gxus6u+jQ6kS/j0LwMVU59LmK0Vr+F6V3bk/g7pvc9xKDTGUhEm
 EqbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5br2rPOSeqWpiT0t4MRHAsQrSrDK5fZHSN1QS/TniGZ9kxWUCWfpIqAqNcD6k52JUPbx1iu+Af+urrisPfl65D6IbvNUcDwtVXD+oOVisLqP67y3MCVO+kCA=
X-Gm-Message-State: AOJu0YztGbd2lYKzwh3vK0fLxoeNA0aVEDtcjSHGVVYG27UKW0deTzmg
 LE1LuU86cQfa1fM220b/dBFEqj0WNHK1YFiI/07vUCsutvXDUTu5
X-Google-Smtp-Source: AGHT+IEMdXZJtD7IoAcSn3ypwnyAFQQoKx5+fZ0T5x3i5VTfdZrRlFUnMtfffGEKNupexnoGY0WDTg==
X-Received: by 2002:a17:90a:8c0a:b0:2c9:81c6:b0e7 with SMTP id
 98e67ed59e1d1-2c99c80b369mr546176a91.30.1720077576754; 
 Thu, 04 Jul 2024 00:19:36 -0700 (PDT)
Received: from localhost ([1.146.24.72]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c99a98ac94sm753560a91.33.2024.07.04.00.19.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jul 2024 00:19:36 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jul 2024 17:19:31 +1000
Message-Id: <D2GKLZP7V4YS.DWYD2TL8WKTA@gmail.com>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH 35/43] target/ppc/mmu-hash32.c: Change parameter type of
 ppc_hash32_bat_lookup()
X-Mailer: aerc 0.17.0
References: <cover.1716763435.git.balaton@eik.bme.hu>
 <c6424ad0d838c2e72e6801544b38ed682aa081ed.1716763435.git.balaton@eik.bme.hu>
In-Reply-To: <c6424ad0d838c2e72e6801544b38ed682aa081ed.1716763435.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1034.google.com
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

On Mon May 27, 2024 at 9:13 AM AEST, BALATON Zoltan wrote:
> This function takes PowerPCCPU but only needs the env from it. Change
> its parameter to CPUPPCState *env.
>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  target/ppc/mmu-hash32.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/target/ppc/mmu-hash32.c b/target/ppc/mmu-hash32.c
> index 44b16142ab..a2c0ac05d2 100644
> --- a/target/ppc/mmu-hash32.c
> +++ b/target/ppc/mmu-hash32.c
> @@ -48,11 +48,10 @@ static target_ulong hash32_bat_size(int mmu_idx,
>      return BATU32_BEPI & ~((batu & BATU32_BL) << 15);
>  }
> =20
> -static hwaddr ppc_hash32_bat_lookup(PowerPCCPU *cpu, target_ulong ea,
> +static hwaddr ppc_hash32_bat_lookup(CPUPPCState *env, target_ulong ea,
>                                      MMUAccessType access_type, int *prot=
,
>                                      int mmu_idx)
>  {
> -    CPUPPCState *env =3D &cpu->env;
>      target_ulong *BATlt, *BATut;
>      bool ifetch =3D access_type =3D=3D MMU_INST_FETCH;
>      int i;
> @@ -316,7 +315,7 @@ bool ppc_hash32_xlate(PowerPCCPU *cpu, vaddr eaddr, M=
MUAccessType access_type,
> =20
>      /* 2. Check Block Address Translation entries (BATs) */
>      if (env->nb_BATs !=3D 0) {
> -        raddr =3D ppc_hash32_bat_lookup(cpu, eaddr, access_type, protp, =
mmu_idx);
> +        raddr =3D ppc_hash32_bat_lookup(env, eaddr, access_type, protp, =
mmu_idx);
>          if (raddr !=3D -1) {
>              if (!check_prot_access_type(*protp, access_type)) {
>                  if (guest_visible) {


