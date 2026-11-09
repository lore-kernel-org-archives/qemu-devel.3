Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF23B606A332
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 06:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GfAqisUo
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQJIz-0006Bd-DK; Mon, 09 Nov 2026 01:56:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1xQJIx-0006BM-98
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 01:56:36 -0500
Received: from mail-dl1-x1232.google.com ([2607:f8b0:4864:20::1232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1xQJIv-0005WY-Jt
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 01:56:35 -0500
Received: by mail-dl1-x1232.google.com with SMTP id
 a92af1059eb24-15ea896ddc8so1057591c88.0
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2026 22:56:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794207392; cv=none;
 d=google.com; s=arc-20260327;
 b=Mv5AtCgrF9RUzvxFpZXIyU8MEOWMXMGQDxZNogB9+2Eq3kO9dj74td7JVY0OGg2pKn
 OVsZIWyUHKCQcO2vw9/bxt2mT3ch5bRif1p5F01n6zOmmQBCXkzRP0R9cu6CY7VYw+jw
 0mMGPpqnFMn7PsMCp1rsKQB2Iya/cqjy+fGwlRVFZlUTXbcq0s5KS0590fBqAGRSZsrZ
 e0oXBkjsPa2G6cPNf1H5VpeFTY41B9eN09BgUODnDmVRe7UGqyINic19pjniTvvT1l/p
 k7Tx4AW0hRGj6qI60TPR2O+tpx55Dr+MWvfrS7dnyx4TltFIj8vIQqAHBS8u+svOZ6uA
 masg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Qt3peenUIT5UR42iLe0ejXdrsPZgXlz6E1ssuY9cXzo=;
 fh=ro6pPoFkuMMcEs00YvdLOAp9F95/m2tn+FF8CzQJnlw=;
 b=YJpUf+tREjXl+4UgfZuHHTmWGm7JawpkEuTZe4rEmsA6N87FRnP19veFw9Z1ZdyjvN
 gdrXWlYoaqkSYcwbspHkWcAbPeSw3Q+6iTiuR6pIZ1mQXFT7MQU0w/DMoW4SZDD5XJdQ
 XMMLn5V2cAo9E7d89wPs2za1BWbuHyNcP6tOXYjkVeMHQW5ujfBNaPafz8nOjJgUKmSQ
 tXe3JBP8yyWUnRvzhjpUy2Zt5TmOzBLJf9Clvf97I6ZF4zml8jR4QUuduMLDc6A7Nzw1
 dhhVLimAdMMsNAI/rCk6aoSIM6wiWJMPkRT3ZoTy6uw2qUK7JeFtiYLLiyLcoMNTf+eA
 8xLw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794207392; x=1794812192; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Qt3peenUIT5UR42iLe0ejXdrsPZgXlz6E1ssuY9cXzo=;
 b=GfAqisUoa/YD3PNtlPJZAgnl1qQVqbAN0/AcHNzLYCsYeiETsN+of0N3USQXLj9dQM
 8dGDryWwNfwdz6Xu9DBHssFETaE/xS7FHDgE5MU1WtCHKDd0Nc6vnPhQ/Gigp3ipG0UR
 i/GAAhqQFwAWclVHU9aBCpkKt3H3SDy/M+swB3uPEQOxuWsLlcWqFmaer9iNUsTxxjQt
 82Gbb3kSQ7w0qomdpZOydYoG1QdbLcq3vne5qNHzh7O4Uy358snGg+tjoXiH4alXYJyt
 SI8RW8sLptmC2UQr8BwSuercw4fGzfURmiYUVKugavdCXKPgf9iB68VQaxFAMeViRqEi
 2L+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794207392; x=1794812192;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Qt3peenUIT5UR42iLe0ejXdrsPZgXlz6E1ssuY9cXzo=;
 b=HhmdigSyKqk3dscpE9fYf6+GTDJ+i9Qb4Ep0Yy6CzV211cV0oK//caRPDipOYL/CXA
 e90/SO8HdUR+fNpe17GSHQbNvb8OFb/tMNCChRAo8tSMLZVRHzXVl5MoaujZHsMA/9nZ
 1DU0mv5sROgz3N9TOsmhKDDROyNaFORqG+SS+Xbsh1waesPISbvy1HYj4I1UZ61CPvBI
 1tlXROoltuNp3c/MS6kdRvcIYWRK5rncTg5lPB7LTnZZ+RHy0zu/uEee8MircBHDDV/8
 9SDjmsXnl2p4Jbx4a+GcrEIFWw2S6GAO5LQPBOAIOfKnZn2TtVBl7QOT/UV8lFxlcVek
 +t4Q==
X-Gm-Message-State: APuU4Z9jEG3KAAoChKkCrZj82HzHSRKbiMLeYL6OSXej4o5mSixG+vV3
 0Vx7XBBxJp+BuiTY8n1wUNNniZXrzqht+HPKCx0YkuKZNE+Ai/obCygRfqGKiiBWfR3ajQBIIZv
 CcivtZrD+afaMvuKX1tl8TjEF7YE10fYRUfDYepQ=
X-Gm-Gg: AYBFou3hC7/luxq3rXWxAkrcCPfBlyVujCBe441mY2EmZC948+oum/XZ7M80FPoseQG
 bdxhLjJLiqyK1YQzjgcMdFFVaQEQn4PiksGHkSHQO1Q0dIu73ypcU4MqzhbLiHktYqwVPuGTxf9
 7Qq96w4zyqpoIfdoHdjgoQ9cmWTlfK6qy9IKrz83+oVowFgbCQyNaGFsaa1SshObubJ0oYD7+RW
 SVGzaUQ/IHGRZDQg+GYPHP3JnEw2rHAQ6FuaiALRyKtGXNT+wQvQ3MF56BB7BN7Ehq1xtpO6MdF
 3cAwlH9+SS4mYOCh8qg2Q+Zlx6c4GRuXO0jh4zbw4HFnfBOTyghxUj4jwqFwNNJLcvK39cPChtc
 HKBa7SJn9XTXK1zN4xi5SvcyWrHBVxUbak6ZQ9nyPgRbMo43t+qbc10R1kbBDhCnJFcgql/zqaS
 zFPTCrDz0bto3vwQ==
X-Received: by 2002:a05:7301:180b:b0:36a:1732:1e7 with SMTP id
 5a478bee46e88-37255e4c0fcmr6276278eec.31.1794207391852; Sun, 08 Nov 2026
 22:56:31 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261108193418.225672-1-jpaulma23@gmail.com>
In-Reply-To: <20261108193418.225672-1-jpaulma23@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 9 Nov 2026 10:56:19 +0400
X-Gm-Features: AclHuK9yiEaujl4G1Dsyzr5PXByNIRmP8O5SqfV4eegvXnVgWUZm9My9gps2EcY
Message-ID: <CAJ+F1CKqg5_09zedVY_TgG5g32vxhnQfzEaNe-K1bNz3r1hRkg@mail.gmail.com>
Subject: Re: [PATCH] hw/audio/fmopl: Convert malloc, free to g_malloc0/g_new
 and g_free
To: jiputer <jpaulma23@gmail.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1232;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dl1-x1232.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 9, 2026 at 12:40=E2=80=AFAM jiputer <jpaulma23@gmail.com> wrote=
:
>
> In the function OPLOpenTable, replaced the usage of malloc with g_new
> and removed the NULL checks meant for malloc.
> In OPLCloseTable and OPLDestroy, replaced the usage of free to g_free.
> In OPLCreate, replaced malloc with g_malloc0 and removed the NULL check
> for ptr, and the now unnecessary memset.
> The program will now abort when memory allocation fails instead of
> checking if the pointer returned is null.
>
> Signed-off-by: jiputer <jpaulma23@gmail.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>
> A couple things to note, in the function OPL_LockTable, it checks the
> return of OPLOpenTable but in the case of which memory allocation fails
> it will abort before reaching this branch.
>
> This patch belongs to this issue:
> https://gitlab.com/qemu-project/qemu/-/work_items/1798
>
>  hw/audio/fmopl.c | 41 +++++++++++------------------------------
>  1 file changed, 11 insertions(+), 30 deletions(-)
>
> diff --git a/hw/audio/fmopl.c b/hw/audio/fmopl.c
> index a63ad0f04d..6bf4e74e80 100644
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
> @@ -696,10 +680,10 @@ static int OPLOpenTable( void )
>  static void OPLCloseTable( void )
>  {
>      g_free(ENV_CURVE);
> -       free(TL_TABLE);
> -       free(SIN_TABLE);
> -       free(AMS_TABLE);
> -       free(VIB_TABLE);
> +    g_free(TL_TABLE);
> +    g_free(SIN_TABLE);
> +    g_free(AMS_TABLE);
> +    g_free(VIB_TABLE);
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
> +    /* allocate memory block and set to 0 */
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
>
>  /* ----------  Option handlers ----------       */
> --
> 2.43.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

