Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9F7FC04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 13:00:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4gtw-0002Pf-6r; Wed, 08 May 2024 09:00:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4gtu-0002Np-Ie; Wed, 08 May 2024 09:00:02 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4gts-0004pj-JS; Wed, 08 May 2024 09:00:02 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1ed41eb3382so32741505ad.0; 
 Wed, 08 May 2024 05:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715173199; x=1715777999; darn=nongnu.org;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vFZl3AQdpM1NLeP9FGk3tiWhrfBRx5WhrsnxR+pehfU=;
 b=G9+jiISF5ACcbmAd7fXrAIk1kkRIU32Cp60E7LPewAWJzHeJFAiG0wq7zQfIqhpy5c
 U5BP1q5rYyxmVCSAgkSFQInJTMBMIlZfOyG06RQyoTD5X+5YLxucmtRrhrJhZESj5ysR
 M7pgwFRTVQBUdYby2of/61LeLTdaZGMSCkIoDwZNdsirqkXykQAj1X2VvcZRdGyYGluP
 SWL+bzrJEXCzsEr8LcGHjTJ5wAs0CQfz9hiLRyIPqHaMvbUBEhVyQJf0otBpo4hi9+/3
 1/t9ziONgfVjWXd5S3Q+fJWkV0N6f83/tl4rgPurC4VqM/chN5a3VLaetSIur2rZW9AE
 IFKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715173199; x=1715777999;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vFZl3AQdpM1NLeP9FGk3tiWhrfBRx5WhrsnxR+pehfU=;
 b=vNBxQiBMttXd9Wj6/GxmR3qfxyI5hRUXhQ6TxqX/l7amcOdNFaGm+IO+YGZ2oYdAhC
 7GesY/sUtD9vJDNSTCU2+QLhoWh1NFlkieE3o/lYy2wjby2I65hhVH3EZAYSRd3+Dt3l
 MRq2Ud3I6cCD6HHeQLldUQpqVg394F6RwST443jzeNSruEXdvEFrFFMcTvre17WlnnLe
 mDodwUDWr1WvgHpxB3MNr82vh1SnYrr8teNPnaUd/DAr7qt5Jvp3USO1up6XOj3saQk/
 4So3exZEs9fYcMuIOIvmi8qzXzrgQuuRFBoaSpKraahpkU7SuoYbq+0Cq9yu830FhC7U
 9AeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaD/puqJphoexu1Yc62kgfhAYGVASXdhiAQ9jKO3fn1GsSDofmV0Fh5ZKZsftWFB8icAkLvvWYJxPJiKm0DPFSoSNFi/nDQT5MyS0aRcS25Sh1eNQjoNO1Ws0=
X-Gm-Message-State: AOJu0Ywb1GTLbYrhM5DPJopf/eUgd/rDro6LdRwsAxYILi6Ao4OBJ8v/
 rgwKVxSJnxt8wvI6rxXRkh7HHTjD9tCfEs6PECRacegC2ZhXQT4I9EdkpA==
X-Google-Smtp-Source: AGHT+IH7QRH1O9EtKck5VddwEkW1MoSEuBefVPTrE89klwJ2Y7xmDwBE1yXWb9cwuGC52SohKBkrQw==
X-Received: by 2002:a17:903:41cb:b0:1e4:2b90:758e with SMTP id
 d9443c01a7336-1eeb03a6162mr32548185ad.39.1715173198716; 
 Wed, 08 May 2024 05:59:58 -0700 (PDT)
Received: from localhost ([1.146.8.34]) by smtp.gmail.com with ESMTPSA id
 c4-20020a170903234400b001eb8fb27b59sm11786682plh.111.2024.05.08.05.59.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 05:59:58 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 May 2024 22:59:53 +1000
Message-Id: <D14A5JEZM7P0.3FB8K9W0R5PD8@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH v3 23/33] target/ppc/mmu_common.c: Remove BookE from
 direct store handling
From: "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.17.0
References: <cover.1715125376.git.balaton@eik.bme.hu>
 <e3b98c7e622d76e6eac1f29b84b3a73ac88f8159.1715125376.git.balaton@eik.bme.hu>
In-Reply-To: <e3b98c7e622d76e6eac1f29b84b3a73ac88f8159.1715125376.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62a.google.com
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
> As BookE never returns -4 we can drop BookE from the direct store case
> in ppc_jumbo_xlate().
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  target/ppc/mmu_common.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index 87cac12d68..03b834eb77 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -1287,12 +1287,7 @@ static bool ppc_jumbo_xlate(PowerPCCPU *cpu, vaddr=
 eaddr,
>              /* Direct store exception */
>              /* No code fetch is allowed in direct-store areas */
>              cs->exception_index =3D POWERPC_EXCP_ISI;
> -            if ((env->mmu_model =3D=3D POWERPC_MMU_BOOKE) ||
> -                (env->mmu_model =3D=3D POWERPC_MMU_BOOKE206)) {
> -                env->error_code =3D 0;
> -            } else {
> -                env->error_code =3D 0x10000000;
> -            }
> +            env->error_code =3D 0x10000000;
>              break;
>          }
>      } else {


