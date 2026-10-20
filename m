Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8839C606A31D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 10:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=KCffqR3p
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJ7IC-0003em-7o; Tue, 20 Oct 2026 06:42:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xJ7I5-0003eH-3d
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 06:41:58 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xJ7Hz-0004F1-Gr
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 06:41:53 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-8726acc5eadso24715527b3.0
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 03:41:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792492910; cv=none;
 d=google.com; s=arc-20260327;
 b=KC1+7KmSoGph7QIqHyw1uFnJL2s1h7snqkcAEueFJ465iujcGd1haBYZ/oFBQQgQq0
 n/Rkntx+FUiCV7pVtHm+KXzVThJE1PlFyQJhX7cmxkUL+ksfdJODuWio4iDh9VuYB2vU
 LZeMYMS1Q0+0BnpDx7ORTx/2UR/uTyGDJWk1krX5aLit8xUg4jUJGU6gIZeSlD6VXz3L
 X7gVvODn05CUYw9UPgimND7QNtyNT25eYMaATG1EX7zxBAQch4IGokg0mHML19ctEQtE
 PHSzGas3dW4fyVEiEvP+VK5KMep0P/kyo4Uyhczk/atn4RgNgCRi/c9pTR02pTtG7Jmi
 VKEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/DwkCB3WLj6PmgCrTyH1rdYKvFGcb4aooHsaGPf/eH4=;
 fh=4a+RHU8SAvVFnRQId3+YFDW2xFu72bzRw2R4QylhDRg=;
 b=MUwY8dpoI8ew9MyJLI1rL5cHL1YFNtC/qgPXhdsodcGQ7jmMP9/sudX18zYk6VSKy9
 A407TIAbZqi90BRxOtzL9lo3RFYEDcVN4m2UL5X0UOsHG8gPVk7x2N4N13dYOKDKj13/
 pvq9XaFBy0kwLNR19ssyaXjq5BeJX7RqXPg4PVtrpYV6Xz8qzu4387Z80K/3L3xapgdg
 7595Ad3W/ZPvC679joyoQJvQIKiKiDn+x8apCg8jleBJPZB+bUbd6tP/uhaiKQNfnP08
 Bo8yuhNPHJabN12xW9wgKVxI9V3TVwNx86p4grtHi1EhPLnbsJM5KpChpkib21VwILaG
 h1CQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792492910; x=1793097710; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/DwkCB3WLj6PmgCrTyH1rdYKvFGcb4aooHsaGPf/eH4=;
 b=KCffqR3pPIBvw8PknyhCDM6smu3cCdiGHjPllW5cKOiu2Qlt+urn0pordOMbBdERda
 rFGjTye44lxS2vnG/Olpjk2TCCJI7lotHW9DBt1b26Ri8AfFLLW7d/JXfJWei1fFP0hU
 qlzQOYsEl9xZ6pk6FqCAOe0E1e7yAFMud0zEKtdzBsWp8uedYoD1wrShgfYNBBKnCK2X
 T7Kv3810PCAtvUAyUl/gQ3Pu7ab9XlVscmNKHcNYOWune8Jp3eCQ7O5rhE2eX9KFtXFk
 bGGUIBhRjdkEP9ThO60zvl2b90aejWxk8PbI/E1V2VtwUBKaGm77c/O4Ommq+1opeHYD
 uhEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792492910; x=1793097710;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/DwkCB3WLj6PmgCrTyH1rdYKvFGcb4aooHsaGPf/eH4=;
 b=J4ulFm9Wl2M/u+yD9/sDDXOZIfYrzGeiQ+seqpou4LkEl8SRytifYHYJ+qFlPFk5gD
 AIZo/NwUzrdoIQdrFmPymkzAxT7SplAIT3bAXRcKJ45OAAqMdWw16lJ/u3TYjckipDLZ
 j0kizrbIPDkmQziiKGfOBm57WlTGUK3vXaY7lz0rw+4sRgDCNFZQmWQN69OKgEBkFPUq
 ZwHBYBUAtLi2QjDPy3/TXQ5sYQveUHk7b5EJq6FU0YEUNYe8FdhuVxR2VbmkT3g5Ll2v
 TMXSr3NyvoMWqcATYVJ0uUnOqOFC1vcO5pYJpU8ItKf2xW7OkmFwjjx4zU7htbbMMMsj
 eUJQ==
X-Gm-Message-State: AFq9FYLG8gpfV1oSOOyMCIN63pHUFBL2BM95nEzHxh5zAob+Q2/vC+L8
 57i2BmA4L5rpvAF8btclxaxLP6TwxceZa/PQtwu6VDi9IaEDqhHlw6dYr21tF7wKobr5Y5j/Dnn
 nP0TVIj54yvxm9PfjB57B+hr01vJUhLNG9ePCUamaFg==
X-Gm-Gg: AYBFou1GPt9WKVDNKDW0j1tmqnUOdFrF4+PM/IKlQ2cQs8KT5vYgXfXhEuB9I6fe+v+
 oWVA//mahhNFpF/QKbOq7crjYFaDlyj7gqG+VvXmB+I02wl+1TjUVZIZOycDXvXwjB7S0aYuno+
 Mm1mEo3z1fVezJlS+7EGfetT7i0ohEdW98UZSfbJOw6C+w2wRHgeW/M/kfiV08zI8w/LMXyvMC7
 yTsTS8U7jW9jqaNppa3rGD0SgLnrZo/ZtEdPU5gxYZAewWiLdXjL2Yj67f7ajBeQcikHHochBaJ
 ZpszDTs19BRxWSVmUJEnvJCK1L/7fF0WqA3cjw1qDTYBtccW6x9mm6RADAfWXEz0tgZp5w5Jhp8
 FVr87udcHiZhB73IYK9Pzgx+GZ9wDsmNgSuQ0dsI=
X-Received: by 2002:a05:690c:f8b:b0:8a9:b50a:bafa with SMTP id
 00721157ae682-8b0f2209f73mr38995387b3.55.1792492909816; Tue, 20 Oct 2026
 03:41:49 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260428162048.2995097-1-luc.fast2004@gmail.com>
In-Reply-To: <20260428162048.2995097-1-luc.fast2004@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Oct 2026 11:41:36 +0100
X-Gm-Features: AclHuK8m1JUrP1plrHLbZbhxsLe2zgGg60noBSwo7MnCWCpeuJb3yy00MUcMocU
Message-ID: <CAFEAcA_77=_28DvN7R=ARg2ysW1UjSMnUSVYqZN8-Ge2ucY2vw@mail.gmail.com>
Subject: Re: [PATCH v2] hw/audio/fmopl.c: Convert malloc, free to g_malloc0,
 g_new and g_free
To: Lucas Cardoso <luc.fast2004@gmail.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, qemu-trivial@nongnu.org, 
 marcandre.lureau@redhat.com, Michael Tokarev <mjt@tls.msk.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 28 Apr 2026 at 17:21, Lucas Cardoso <luc.fast2004@gmail.com> wrote:
>
> In accordance with QEMU's coding style guidelines, replace raw memory
> allocation functions (malloc/free) with their GLib equivalents
> (g_new/g_malloc0/g_free/g_clear_pointer).
>
> Also removes the old generic error-handling code from
> OPLOpenTable(), since the Glib functions abort the program automatically
> if memory is exhausted.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/1798
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Lucas Cardoso <luc.fast2004@gmail.com>
> ---
> v2:
> - After some studying, I decided to follow Marc-Andr=C3=A9's feedback to =
use g_clear_pointer() instead of g_free(), on the OPLCloseTable function.
>  hw/audio/fmopl.c | 43 ++++++++++++-------------------------------
>  1 file changed, 12 insertions(+), 31 deletions(-)

I was just reminded by traffic on the issue tracker that we had
a discussion on this patch and some debate about different ways
to approach it, but never came to a conclusion.

My preference is to do what this patch does, i.e. replace
the mallocs with g_new(). I think it's a straightforward
obviously-correct update to a pretty unloved piece of code,
and I'd rather we do that than change to using static arrays.

(If anybody does have an interest in modernizing fmopl.c
more generally I have no objection; I'd just rather not hang
up this bit of general cross-codebase cleanup to stop using
raw malloc() that we're nearly done with.)

So:

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

MJT: are you OK with picking it up for -trivial ?

>
> diff --git a/hw/audio/fmopl.c b/hw/audio/fmopl.c
> index a63ad0f04d..91fe806fd6 100644
> --- a/hw/audio/fmopl.c
> +++ b/hw/audio/fmopl.c
> @@ -607,26 +607,10 @@ static int OPLOpenTable( void )
>         double pom;
>
>         /* allocate dynamic tables */
> -       if( (TL_TABLE =3D malloc(TL_MAX*2*sizeof(int32_t))) =3D=3D NULL)
> -               return 0;
> -       if( (SIN_TABLE =3D malloc(SIN_ENT*4 *sizeof(int32_t *))) =3D=3D N=
ULL)
> -       {
> -               free(TL_TABLE);
> -               return 0;
> -       }
> -       if( (AMS_TABLE =3D malloc(AMS_ENT*2 *sizeof(int32_t))) =3D=3D NUL=
L)
> -       {
> -               free(TL_TABLE);
> -               free(SIN_TABLE);
> -               return 0;
> -       }
> -       if( (VIB_TABLE =3D malloc(VIB_ENT*2 *sizeof(int32_t))) =3D=3D NUL=
L)
> -       {
> -               free(TL_TABLE);
> -               free(SIN_TABLE);
> -               free(AMS_TABLE);
> -               return 0;
> -       }
> +    TL_TABLE =3D g_new(int32_t, TL_MAX * 2);
> +    SIN_TABLE =3D g_new(int32_t *, SIN_ENT * 4);
> +    AMS_TABLE =3D g_new(int32_t, AMS_ENT * 2);
> +    VIB_TABLE =3D g_new(int32_t, VIB_ENT * 2);
>      ENV_CURVE =3D g_new(int32_t, 2 * EG_ENT + 1);
>         /* make total level table */
>         for (t =3D 0;t < EG_ENT-1 ;t++){
> @@ -695,11 +679,11 @@ static int OPLOpenTable( void )
>
>  static void OPLCloseTable( void )
>  {
> -    g_free(ENV_CURVE);
> -       free(TL_TABLE);
> -       free(SIN_TABLE);
> -       free(AMS_TABLE);
> -       free(VIB_TABLE);
> +    g_clear_pointer(&ENV_CURVE, g_free);
> +    g_clear_pointer(&TL_TABLE, g_free);
> +    g_clear_pointer(&SIN_TABLE, g_free);
> +    g_clear_pointer(&AMS_TABLE, g_free);
> +    g_clear_pointer(&VIB_TABLE, g_free);
>  }
>
>  /* CSM Key Control */
> @@ -1081,11 +1065,8 @@ FM_OPL *OPLCreate(int clock, int rate)
>         /* allocate OPL state space */
>         state_size  =3D sizeof(FM_OPL);
>         state_size +=3D sizeof(OPL_CH)*max_ch;
> -       /* allocate memory block */
> -       ptr =3D malloc(state_size);
> -       if(ptr=3D=3DNULL) return NULL;
> -       /* clear */
> -       memset(ptr,0,state_size);
> +    /* allocate memory block and zero-initialize */
> +    ptr =3D g_malloc0(state_size);
>         OPL        =3D (FM_OPL *)ptr; ptr+=3Dsizeof(FM_OPL);
>         OPL->P_CH  =3D (OPL_CH *)ptr; ptr+=3Dsizeof(OPL_CH)*max_ch;
>         /* set channel state pointer */
> @@ -1128,7 +1109,7 @@ void OPLDestroy(FM_OPL *OPL)
>         }
>  #endif
>         OPL_UnLockTable();
> -       free(OPL);
> +    g_free(OPL);
>  }

thanks
-- PMM

