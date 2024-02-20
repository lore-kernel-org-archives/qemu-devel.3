Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D677FC48BF8
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 00:30:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcE0H-00036h-DR; Mon, 19 Feb 2024 19:28:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rcE0G-00036N-F2; Mon, 19 Feb 2024 19:28:56 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rcE0E-0001x3-Un; Mon, 19 Feb 2024 19:28:56 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6e0f803d9dfso2395193b3a.0; 
 Mon, 19 Feb 2024 16:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708388933; x=1708993733; darn=nongnu.org;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cS+2XMzeH1XFbOvnGCXDjZDuyLiGM1BUY8YlROUbkak=;
 b=hfcXNR98dQGN8Ft64MnWHeu1yi79AKVPUSCOxw5IG/t6kTMF7/ou2f156Rfu5ax75j
 efKGqd6yzyjTa0NQY3RU04D0WzqNgaD2kWzDWNc9yQR6D6O2Sw2brTUqInG/sePlVQqb
 rKKq2aK32sEWj76mvJ3g7C0z5pG/FRjsdvCyf4+XS1hOUXfUsFR0kmfAFYnGPiiQ2F64
 PFZL5tbKZQa8eSl5sil/do1pmpwAU2QK/3s1qbO85N4lUFp5YswAkIhMHectgqfLyeiQ
 dq1vq6g8nUllF6G4pUg8GCC6J6ZMb/Sirbd0IIyFgB5gjOGnpcnw6Rr47UZulvT32f43
 tq+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708388933; x=1708993733;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cS+2XMzeH1XFbOvnGCXDjZDuyLiGM1BUY8YlROUbkak=;
 b=Db421H35LkSE4q2NhgpG0ZIi02JlJ2glD2RqESYcrJwRJqSjj4yl0EtT9QQ91d+Cej
 BOwkekQQhSmd7bfWG6FXIM81jmXyjm7LVkjHJtvsHnziztd66N2tDQ4MWRcuF5PHPwAH
 XatMjLX2R6FJTPydV5ZEPZ2Piu+NlHnbxxDUPPKGhy9kW35EG5dMANPfIWwLUYZkesK3
 BS95itsrkosx2fW5Yvn8p0KT8Unm/6zDHvQ69kEG8SjFAkeV/VKfuX7QSoL1Mqb625un
 P/6nyppyWCdYf8niQuK2JtBvx1+9RE4b0itaX66usEM7xJF97T/E50IcLlw8ipQkno8s
 7xVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVG6UCzM11guqtXVyGnCUXa8eNqS7rPsIQzzhBNSNVfPN2ugPK2jl6acETSz4NjXcCVp01rDu0eF4c0WUbcrrDpPnhK
X-Gm-Message-State: AOJu0Yy9xLX4brbKS1OcxO3B1gQBYAZqueObZAbbMJ7tGF8unloXyM+o
 t+M6EpTXW3nNQw7ZmybQgvqqQBwwf4et0qiXQzLzzw+vM1M/pj45
X-Google-Smtp-Source: AGHT+IFWCoNho0IibTTiYB0yNeOQog65NeXuf1U2xoYZrbpXc65vpce/hICedRQRoa4oqgJdnGC5ug==
X-Received: by 2002:a05:6a20:d905:b0:19e:9d92:b6a6 with SMTP id
 jd5-20020a056a20d90500b0019e9d92b6a6mr19898804pzb.44.1708388932920; 
 Mon, 19 Feb 2024 16:28:52 -0800 (PST)
Received: from localhost (123-243-155-241.static.tpgi.com.au.
 [123.243.155.241]) by smtp.gmail.com with ESMTPSA id
 c18-20020a056a00009200b006dff3ca9e26sm5435702pfj.102.2024.02.19.16.28.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Feb 2024 16:28:52 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 20 Feb 2024 10:28:48 +1000
Message-Id: <CZ9HBYZ004Q8.3ICH68L1E2IGQ@wheely>
To: "Richard Henderson" <richard.henderson@linaro.org>, <qemu-ppc@nongnu.org>
Cc: <qemu-devel@nongnu.org>, "Glenn Miles" <milesg@linux.vnet.ibm.com>
Subject: Re: [PATCH] target/ppc: BHRB avoid using host pointer in translated
 code
From: "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.15.2
References: <20240215171512.800892-1-npiggin@gmail.com>
 <eed2094c-32f9-400d-951a-120c06bb58f9@linaro.org>
In-Reply-To: <eed2094c-32f9-400d-951a-120c06bb58f9@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x429.google.com
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

On Fri Feb 16, 2024 at 5:42 AM AEST, Richard Henderson wrote:
> On 2/15/24 07:15, Nicholas Piggin wrote:
> > diff --git a/target/ppc/machine.c b/target/ppc/machine.c
> > index 731dd8df35..3541cd83cd 100644
> > --- a/target/ppc/machine.c
> > +++ b/target/ppc/machine.c
> > @@ -724,7 +724,7 @@ static const VMStateDescription vmstate_bhrb =3D {
> >       .minimum_version_id =3D 1,
> >       .needed =3D bhrb_needed,
> >       .fields =3D (VMStateField[]) {
> > -        VMSTATE_UINTTL(env.bhrb_offset, PowerPCCPU),
> > +        VMSTATE_UINT32(env.bhrb_offset, PowerPCCPU),
>
> This requires a version bump.

In this case the first patch hasn't gone upstream yet.

> > diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> > index 81afc892de..05f0f1ac52 100644
> > --- a/target/ppc/translate.c
> > +++ b/target/ppc/translate.c
> > @@ -4167,21 +4167,24 @@ static void gen_rvwinkle(DisasContext *ctx)
> >   #endif /* defined(CONFIG_USER_ONLY) */
> >   }
> >  =20
> > -static inline TCGv gen_write_bhrb(TCGv base, TCGv offset, TCGv mask, T=
CGv value)
> > +static TCGv_i32 gen_write_bhrb(TCGv_i32 offset, TCGv_i32 mask, TCGv_i6=
4 value)
> >   {
> > -    TCGv tmp =3D tcg_temp_new();
> > +    TCGv_ptr ptr =3D tcg_temp_new_ptr();
> > +    TCGv_i32 tmp =3D tcg_temp_new_i32();
> >  =20
> > -    /* add base and offset to get address of bhrb entry */
> > -    tcg_gen_add_tl(tmp, base, offset);
> > +    /* add base and offset to tcg_env to get address of bhrb entry */
> > +    tcg_gen_addi_i32(tmp, offset, offsetof(CPUPPCState, bhrb));
> > +    tcg_gen_ext_i32_ptr(ptr, tmp);
> > +    tcg_gen_add_ptr(ptr, ptr, tcg_env);
> >  =20
> >       /* store value into bhrb at bhrb_offset */
> > -    tcg_gen_st_i64(value, (TCGv_ptr)tmp, 0);
> > +    tcg_gen_st_i64(value, ptr, 0);
>
> Better to add the constant with the store offset.
>
>    tcg_gen_ext_i32_ptr(ptr, offset);
>    tcg_gen_add_ptr(ptr, ptr, tcg_env);
>    tcg_gen_st_i64(value, ptr, offsetof(bhrb));

Good suggestion thanks. Maybe in light of the fact I was wrong
about not using host pointer here, the original approach is
better and just needs a smaller fix for 32-bit hosts.

Thanks,
Nick

