Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDC7AC04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 13:13:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4h5q-0005Cr-KV; Wed, 08 May 2024 09:12:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4h5p-0005CD-8r; Wed, 08 May 2024 09:12:21 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4h5n-0001UI-Gd; Wed, 08 May 2024 09:12:20 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6f44bcbaae7so3328471b3a.2; 
 Wed, 08 May 2024 06:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715173937; x=1715778737; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2dBMKpwgs823k+0HdgakBvb+PExtC6R1IbH4IGUW/VI=;
 b=QRyutxQukjzcAimOA008fnDCx2ndgCRUZj29uYaefYbbY7sQJ8CkicyzL/Jm3awK/V
 ryhr+SbzjVGezWkuEyFcfJZaInHK4dboYMzq3LADo4oHdimfnZ6qdeQJB5KVhchVG/RZ
 lLKUVOByLIaYVhp3/XkGJFFcBMimzWK2XemqjVOJSvaa1BqEmjGrSFtjzOcqsy81myyU
 NmB9U7TJkTB/51SM8gz9nOdm2aPVnQpQ626M9ilQalCqBFXbcHAm39D8fc4qcC63fNix
 wa7h9JZTVtMku1fNXiV31HpSuQXXfhfHaF9k2zxQ2xwNM6RHWZsBs8mqJ4MCu5k9DVQq
 kIEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715173937; x=1715778737;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2dBMKpwgs823k+0HdgakBvb+PExtC6R1IbH4IGUW/VI=;
 b=JuRPBI4weRJpc78XrZjvdMIcm14vVamH59DEGljz2OXJ+yq9rwarlhpuh2dfT80HqO
 FGiJhWDXrkRWmk3bRskFr4y5r3RsWv9AR8It5h2uspVTHp3+nlURAjIP5uR1BquHi2RL
 oUbIRKd8hxAnw9tC+PAz1uiwXnI7qav2e54rZWb54onTo9o7IxA4jT3jibZC9T0u6cdY
 dLSRRPUR2PO0oE9RwH243+QgT06KgcyciD2OZTPf5FV6iffx7Wb1mAa8LM3kWMtTDx21
 EGSKAPV4UQODVx+1uKviW8OdYH+/cZ1KdM0OL9jp/zkMIAkEFIloVu0FLhyDFWv4svQq
 1FGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9eEF6R+R3iFUTvS8bmyVwWR9lhI42X+hbzAhSs/zjgdn+Ew+p5RK8epFTZSL7Y4aIsw/G5F0dV89KomD7KkMstP5wi/QrQO+9CEWqqtXNr2dLyRbW9KtQtv8=
X-Gm-Message-State: AOJu0YzRjOQEsNEoDEbaaKWG2exSb8oZo5l6k41dwZDoR2WOCoErNrVh
 gEC4o+eqD6FzH3Ejpjut1pJ3ur/OCE7qZYjFMMBGzfbIiVdPC9L6
X-Google-Smtp-Source: AGHT+IEGJjnnsRoJLM89PcZ0SuROcEtvAY2L1ws8oU9hvyKxT89cZJKvP4pVtb0gFJXhJotqDUmPTA==
X-Received: by 2002:a05:6a21:7882:b0:1af:41d1:732e with SMTP id
 adf61e73a8af0-1afc8dc6c5bmr3220400637.46.1715173937513; 
 Wed, 08 May 2024 06:12:17 -0700 (PDT)
Received: from localhost ([1.146.8.34]) by smtp.gmail.com with ESMTPSA id
 hy12-20020a056a006a0c00b006ed26aa0ae6sm11138296pfb.54.2024.05.08.06.12.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 06:12:17 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 May 2024 23:12:12 +1000
Message-Id: <D14AEZ3KMI1B.5O131WO4JO7@gmail.com>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH v3 25/33] target/ppc/mmu_common.c: Remove BookE handling
 from get_physical_address_wtlb()
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.17.0
References: <cover.1715125376.git.balaton@eik.bme.hu>
 <31a3baf4f598b8ebd0108180c3f5e26ebfbaff64.1715125376.git.balaton@eik.bme.hu>
In-Reply-To: <31a3baf4f598b8ebd0108180c3f5e26ebfbaff64.1715125376.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42e.google.com
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
> This function is no longer called for BookE MMU model so remove parts
> related to it. This has uncovered a few may be used uninitialised
> warnings that are also fixed.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  target/ppc/mmu_common.c | 25 +++++--------------------
>  1 file changed, 5 insertions(+), 20 deletions(-)
>
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index 83dc041a77..788e2bebd5 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -629,12 +629,10 @@ static int mmubooke_get_physical_address(CPUPPCStat=
e *env, mmu_ctx_t *ctx,
>          ret =3D mmubooke_check_tlb(env, tlb, &raddr, &ctx->prot, address=
,
>                                   access_type, i);
>          if (ret !=3D -1) {
> -            if (ret >=3D 0) {
> -                ctx->raddr =3D raddr;
> -            }
>              break;
>          }
>      }
> +    ctx->raddr =3D raddr;

Not sure if this is quite the right thing to do or if it's just masking
used uninits.

>      qemu_log_mask(CPU_LOG_MMU,
>                    "%s: access %s " TARGET_FMT_lx " =3D> " HWADDR_FMT_plx
>                    " %d %d\n", __func__, ret < 0 ? "refused" : "granted",
> @@ -841,9 +839,6 @@ static int mmubooke206_get_physical_address(CPUPPCSta=
te *env, mmu_ctx_t *ctx,
>              ret =3D mmubooke206_check_tlb(env, tlb, &raddr, &ctx->prot, =
address,
>                                          access_type, mmu_idx);
>              if (ret !=3D -1) {
> -                if (ret >=3D 0) {
> -                    ctx->raddr =3D raddr;
> -                }
>                  goto found_tlb;
>              }
>          }
> @@ -851,6 +846,7 @@ static int mmubooke206_get_physical_address(CPUPPCSta=
te *env, mmu_ctx_t *ctx,
> =20
>  found_tlb:
> =20
> +    ctx->raddr =3D raddr;
>      qemu_log_mask(CPU_LOG_MMU, "%s: access %s " TARGET_FMT_lx " =3D> "
>                    HWADDR_FMT_plx " %d %d\n", __func__,
>                    ret < 0 ? "refused" : "granted", address, raddr,
> @@ -1107,20 +1103,9 @@ static int get_physical_address_wtlb(CPUPPCState *=
env, mmu_ctx_t *ctx,
>                                       MMUAccessType access_type, int type=
,
>                                       int mmu_idx)
>  {
> -    bool real_mode;
> -
> -    if (env->mmu_model =3D=3D POWERPC_MMU_BOOKE) {
> -        return mmubooke_get_physical_address(env, ctx, eaddr, access_typ=
e);
> -    } else if (env->mmu_model =3D=3D POWERPC_MMU_BOOKE206) {
> -        return mmubooke206_get_physical_address(env, ctx, eaddr, access_=
type,
> -                                                mmu_idx);
> -    }

Also still don't like how this gets removed here rather than when it's
stopped being called. I know it's a tangle but it would be better to
try squash the would-be warnings first, then put this in the same as
the previous patch.

Add /* quiet used uninit */ warnings if they can't be fixed properly.

Thanks,
Nick

> -
> -    real_mode =3D (type =3D=3D ACCESS_CODE) ? !FIELD_EX64(env->msr, MSR,=
 IR)
> -                                      : !FIELD_EX64(env->msr, MSR, DR);
> -    if (real_mode && (env->mmu_model =3D=3D POWERPC_MMU_SOFT_6xx ||
> -                      env->mmu_model =3D=3D POWERPC_MMU_SOFT_4xx ||
> -                      env->mmu_model =3D=3D POWERPC_MMU_REAL)) {
> +    bool real_mode =3D (type =3D=3D ACCESS_CODE) ? !FIELD_EX64(env->msr,=
 MSR, IR)
> +                                           : !FIELD_EX64(env->msr, MSR, =
DR);
> +    if (real_mode) {
>          memset(ctx, 0, sizeof(*ctx));
>          ctx->raddr =3D eaddr;
>          ctx->prot =3D PAGE_RWX;


