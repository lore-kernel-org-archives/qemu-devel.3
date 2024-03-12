Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45BDBC54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 12:29:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk1Fv-00074P-JB; Tue, 12 Mar 2024 08:29:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk1Ft-00070b-7w; Tue, 12 Mar 2024 08:29:17 -0400
Received: from mail-il1-x12e.google.com ([2607:f8b0:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk1Fr-0005a1-2B; Tue, 12 Mar 2024 08:29:16 -0400
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-3665aca007cso11293295ab.1; 
 Tue, 12 Mar 2024 05:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710246552; x=1710851352; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bV2U+tELVHWoonFsPnlGDR/eMHEi/9779tm38piFg5w=;
 b=W7682vB2gHamYA3UoMQEZrIEPAf0AcNh4db/dIsGGFBcn/hRqcCxVUOllW6HXJ3oQT
 e80/8VYphcn+ybbsTaMfxRMFmn5rxlqDjCGKFGPfwh3uSy3+eCbqbF81u1+npe6Wh0lQ
 G0Mp1g1q3Am5UCAZnMjQ7ypQ/fncQc4t4rWsbHdGi6WBJwLqIpYH8HIPUFBzEniqDjLf
 0te0FEn6VLx8Lrndtt1eloYoutbNAqp36NtEx+V1FmFasHZQTdfAxXjagAdMWp0h7Fv6
 7PfHErV6nQqUB/1xN8DxT4TAIU1a5xlziP3YPdj3jpAoO1aa8JAWmkBfBzfrbXKZOGuK
 /eQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710246552; x=1710851352;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bV2U+tELVHWoonFsPnlGDR/eMHEi/9779tm38piFg5w=;
 b=dbByKsl18fUDcaNvXe1R8zTVvALH3/qFbAQPAWSwZUS+KxFaJdbJoe7u+Qg8HxJTC4
 mFpuhs9Y1upLRI3WIgqKFZQWI8cLBDJeImI0FFBl03OZBmjjAWB8b+Y6GFHY4c8Ao8zM
 1jNEKEGvT1CLjEfEWy3b+/K6cmHnuAfU9rwu2oIsggM9gExHxeYT6sI+aYO4jElQxuFP
 Q3FRzwel4IrIxf5dZcsp0znjSMNIJ4PqR87oneP1328JWW2wtKlCKcPvjbK04N3DdD+7
 jDEq2ytCamraX8PlhtjcuTcGQq4e5Bxy2wi1s8HdD2MD+MMDUz7TCYljVsI2ei/62FoI
 f6Pw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXa9nrZ4ER7kPa/w64VfJCyzfEJ6V/MDRKcmFIpHGdwiiyMG7FRK8HwZl9MjOw5BhPaVjnXU251cu9zD1ZDsykwJDr/z0X657hWtXqoA2u1Fb6rKJTmH2ZYfwg=
X-Gm-Message-State: AOJu0Yw3XaFv6fBtNJONsXNBRMWADK0IklSC+DLfQeGu1CQuWf5cnbV+
 +00CwwUfEf5/K1djhXhJBl+RmeC81U6swp7PydcLsMs/4X3wKah7
X-Google-Smtp-Source: AGHT+IEJKPf/lRtxxkqH9wTAO2sBzuqtRRFWzBD8YC4sfpuNE5R3LdHUtcZOZz6bo1rkeKiM90YD6A==
X-Received: by 2002:a05:6e02:1aae:b0:365:75b2:a330 with SMTP id
 l14-20020a056e021aae00b0036575b2a330mr3236641ilv.13.1710246552276; 
 Tue, 12 Mar 2024 05:29:12 -0700 (PDT)
Received: from localhost ([118.208.155.46]) by smtp.gmail.com with ESMTPSA id
 r35-20020a635d23000000b005c6617b52e6sm5976343pgb.5.2024.03.12.05.29.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 05:29:12 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 Mar 2024 22:29:07 +1000
Message-Id: <CZRRSXGJFPR8.L006RCIUY2U@wheely>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>, <clg@kaod.org>
Subject: Re: [PATCH v7 03/10] target/ppc: Add gen_exception_err_nip() function
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.15.2
References: <cover.1709045654.git.balaton@eik.bme.hu>
 <ee0c65b99d2286dcacb7dbd9a833600fbd5573c9.1709045654.git.balaton@eik.bme.hu>
In-Reply-To: <ee0c65b99d2286dcacb7dbd9a833600fbd5573c9.1709045654.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::12e;
 envelope-from=npiggin@gmail.com; helo=mail-il1-x12e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed Feb 28, 2024 at 1:08 AM AEST, BALATON Zoltan wrote:
> Add gen_exception_err_nip() that does the same as gen_exception_err()
> but takes the nip as a parameter to allow specifying it instead of
> using the current instruction address then change gen_exception_err()
> to use it.
>
> The gen_exception() and gen_exception_nip() functions are similar so
> remove code duplication from those too while at it.
>
> Suggested-by: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Thanks for doing this one

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  target/ppc/translate.c | 28 +++++++++++++++-------------
>  1 file changed, 15 insertions(+), 13 deletions(-)
>
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 28fc7791af..d87aae0cc4 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -296,33 +296,26 @@ static inline void gen_update_nip(DisasContext *ctx=
, target_ulong nip)
>      tcg_gen_movi_tl(cpu_nip, nip);
>  }
> =20
> -static void gen_exception_err(DisasContext *ctx, uint32_t excp, uint32_t=
 error)
> +static void gen_exception_err_nip(DisasContext *ctx, uint32_t excp,
> +                                  uint32_t error, target_ulong nip)
>  {
>      TCGv_i32 t0, t1;
> =20
> -    /*
> -     * These are all synchronous exceptions, we set the PC back to the
> -     * faulting instruction
> -     */
> -    gen_update_nip(ctx, ctx->cia);
> +    gen_update_nip(ctx, nip);
>      t0 =3D tcg_constant_i32(excp);
>      t1 =3D tcg_constant_i32(error);
>      gen_helper_raise_exception_err(tcg_env, t0, t1);
>      ctx->base.is_jmp =3D DISAS_NORETURN;
>  }
> =20
> -static void gen_exception(DisasContext *ctx, uint32_t excp)
> +static inline void gen_exception_err(DisasContext *ctx, uint32_t excp,
> +                                     uint32_t error)
>  {
> -    TCGv_i32 t0;
> -
>      /*
>       * These are all synchronous exceptions, we set the PC back to the
>       * faulting instruction
>       */
> -    gen_update_nip(ctx, ctx->cia);
> -    t0 =3D tcg_constant_i32(excp);
> -    gen_helper_raise_exception(tcg_env, t0);
> -    ctx->base.is_jmp =3D DISAS_NORETURN;
> +    gen_exception_err_nip(ctx, excp, error, ctx->cia);
>  }
> =20
>  static void gen_exception_nip(DisasContext *ctx, uint32_t excp,
> @@ -336,6 +329,15 @@ static void gen_exception_nip(DisasContext *ctx, uin=
t32_t excp,
>      ctx->base.is_jmp =3D DISAS_NORETURN;
>  }
> =20
> +static inline void gen_exception(DisasContext *ctx, uint32_t excp)
> +{
> +    /*
> +     * These are all synchronous exceptions, we set the PC back to the
> +     * faulting instruction
> +     */
> +    gen_exception_nip(ctx, excp, ctx->cia);
> +}
> +
>  #if !defined(CONFIG_USER_ONLY)
>  static void gen_ppc_maybe_interrupt(DisasContext *ctx)
>  {


