Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04873C25B4F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 09:44:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4HM3-0005HT-RD; Tue, 07 May 2024 05:43:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4HM1-0005BE-NO; Tue, 07 May 2024 05:43:21 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4HM0-0007Uj-0J; Tue, 07 May 2024 05:43:21 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1ee0132a6f3so16773525ad.0; 
 Tue, 07 May 2024 02:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715074998; x=1715679798; darn=nongnu.org;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=04Oz8jcaSe+p7prA09HLsICSGpfQsX9m+g8AK44s6So=;
 b=N0/R8WRKjJkP5no6ZJSzqxwERGBPkuE+Wm8+ub7qX0JnJ/hmEr3PLQqYwlPWrKx3fO
 FOKcZRnC7M/DMQ7KbwmxOViacYDcJehgss/ZiFRu1L/gjBIVMDRi3s4SEvbg1NOYSS/M
 bgIlZliae2QW+buhQnCYcBiexXsw+X6s5dw3ARdrmIS3uSOPJ/Cp09tuwenRNsINLeY4
 qEHPJ9kO1M2Aq0pbYn/5eem9skDQQYHG4QzmBft/dofSBhrmYIkTaz+pY2KRphdhhs8s
 zhq26HY4LS0c8BqotkX7pkf8E4Rjnq+1H1FT9MooXxK4Na4rGgZOgnN8RtPiKcm+y84+
 Fwfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715074998; x=1715679798;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=04Oz8jcaSe+p7prA09HLsICSGpfQsX9m+g8AK44s6So=;
 b=k58wlUxiW103j/pb/YeeRfOFrwP0rJGqquaHB2L8Vcjse57dfR7Sn6janNuCWTnwWZ
 Spsmnov71jADWaRSaWvKOmRih16CfRpYgd96HsuJ7bKLkleeiwypPxO6MuCBZ5aizeZt
 57yGwUw2GnkLLth82oZ4wnRoUE1VNkPeTZOeeQqDbgSTI9Jwf0Oy+TXUqqonKeH3bO6z
 ZzZDKGSbOzbPj+4hH64lM13MAEwmuCHlRn7UVudFj0KrW1uMZ4Xn4pDO7hQ7X+HfO1kG
 3UmOFTKQdKFP/AntYyQWjQASAOm+eBDqLW+Sm7sJBSIL6YvV4xmh0q4L6SbXH0EjCOs9
 AzRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXG/5uCqwjEvVm6rAYQkdHOEiDWZZBZrlUrXDz3O82T3pEnHIeK3yM6pleGCGi2wGf7WeNErl6AfDgB61rQhD1Fvd13vJ7ks3pGyZ2b91N4Ahv8M/aRnmi9FE=
X-Gm-Message-State: AOJu0YxKgwkdXvI3JwsnB7eG9E9BY07+aPYzm70wczZtflADhu/5x5oM
 6+LanfoXVvrmHPv7auG9nGc6ogMVR7nVkm2f6DOIKQWbTumVtzJgGBdvAA==
X-Google-Smtp-Source: AGHT+IF0F9JXfPcHzVTx+gD30CTC0Yr+lPLjGXU5rQHpjm61bqRqBeSyuEqLi/udomBsD0pgAqVFxw==
X-Received: by 2002:a17:902:c94e:b0:1ea:fb65:a0c9 with SMTP id
 i14-20020a170902c94e00b001eafb65a0c9mr15463679pla.20.1715074998053; 
 Tue, 07 May 2024 02:43:18 -0700 (PDT)
Received: from localhost (220-245-239-57.tpgi.com.au. [220.245.239.57])
 by smtp.gmail.com with ESMTPSA id
 o16-20020a17090323d000b001ea26bdfca6sm9640879plh.282.2024.05.07.02.43.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 May 2024 02:43:17 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 07 May 2024 19:43:11 +1000
Message-Id: <D13BCE6A3VHI.64MA1779MLMW@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH v2 11/28] target/ppc/mmu_common.c: Rename get_bat_6xx_tlb()
From: "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.17.0
References: <cover.1714606359.git.balaton@eik.bme.hu>
 <400affc638d56c4669abe2e20bf9a22c18ea29fe.1714606359.git.balaton@eik.bme.hu>
In-Reply-To: <400affc638d56c4669abe2e20bf9a22c18ea29fe.1714606359.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62f.google.com
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
> Rename to ppc6xx_tlb_get_bat() to match other similar names in the
> same file.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Acked-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  target/ppc/mmu_common.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index ef1669b01d..a069e4083f 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -288,8 +288,8 @@ static inline void bat_size_prot(CPUPPCState *env, ta=
rget_ulong *blp,
>      *protp =3D prot;
>  }
> =20
> -static int get_bat_6xx_tlb(CPUPPCState *env, mmu_ctx_t *ctx,
> -                           target_ulong virtual, MMUAccessType access_ty=
pe)
> +static int ppc6xx_tlb_get_bat(CPUPPCState *env, mmu_ctx_t *ctx,
> +                              target_ulong virtual, MMUAccessType access=
_type)
>  {
>      target_ulong *BATlt, *BATut, *BATu, *BATl;
>      target_ulong BEPIl, BEPIu, bl;
> @@ -371,7 +371,7 @@ static int mmu6xx_get_physical_address(CPUPPCState *e=
nv, mmu_ctx_t *ctx,
> =20
>      /* First try to find a BAT entry if there are any */
>      if (env->nb_BATs !=3D 0) {
> -        ret =3D get_bat_6xx_tlb(env, ctx, eaddr, access_type);
> +        ret =3D ppc6xx_tlb_get_bat(env, ctx, eaddr, access_type);
>      }
>      if (ret >=3D 0) {
>          return ret;


