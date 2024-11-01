Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D73AE6F069
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 15:26:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6tWs-0007qu-Cf; Fri, 01 Nov 2024 11:25:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t6tWp-0007qi-Sj
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 11:25:35 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t6tWo-0002ot-3K
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 11:25:35 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2fb3110b964so18955981fa.1
 for <qemu-devel@nongnu.org>; Fri, 01 Nov 2024 08:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730474731; x=1731079531; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vqfGTyS3edor4O3OVIQaPGLb9QWSKyW8YtpSczMfxrM=;
 b=zDssvybe4pErObJKtq3CFxXefzg7Kv8ln7ppqA2P9pz7NAeub37+mzDiZAgjqz7jQp
 HH8GrRCxwFuf/iDUX9ykRjhuIlEOnIwaSst/1CGzK2pVrw0uHmTv5P8SBViYY4HCQmaN
 RLA1LASpAVxdfqrzbQTnx/uI/EFNrP0Ivw8z5L8SWaRso0P+l7duEGc8XZqEF+0pKMHq
 hC3poNcdwOgDm0IDLtEXEFgY5aVTSdM57m8Xapyao4yUt515N6tOQmSwR+H2eiWH4Zs2
 v8LyU0Cl+w7BO9dYuCGz1pNkfWvRI1dsXNYf4B5pZYdgaFHrmXPWMWiKQM03VYTJAAcY
 fWJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730474731; x=1731079531;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vqfGTyS3edor4O3OVIQaPGLb9QWSKyW8YtpSczMfxrM=;
 b=Z+ue8pKn4wRNvUNG6XPqerTfi3CRncEIZOoDQ3rUmt9AxBXrlSAG0e6C/xqX6KA8p5
 K7Gxb6uAMf9u7cFv5sa36mZszS/lPvG5BrNGjptqVrvgm6WNnU6A39phppBbshi/+hqZ
 ajPUqKLvg2ZXMV4E7wrFzf0BklhtWjef7pn5J3lVnRISHvf4Z5xwwJbRUoC2VH32okhN
 Pc/TM1EJD6lj5/MzOZqsXb5G8QU2GTf70HgonOIwtGmgso88Wdq5g/d9KwXJEKPWRpVR
 r5xoFdxX+ngJ3nDhTO4b8W10kQeCt73ZvNOfi6UGzwxuiHJ+tHvAD0Opr0XbB/fmG+Id
 P99g==
X-Gm-Message-State: AOJu0YymVk3sfifO2VLwzNgNxJKYzxGYEOPOmq+ufPPhM0QT6fiILme6
 g5uw1ouUk10rBapM0N9RGOGm+9f/8wHPFbOhAmnrWpVN2UljcLLv1cr+rPv5c4nuV/+MCpRDbx2
 cGIq3V3m0IV71eKjtdo3mDnbFZSHCS56NYI2JpQ==
X-Google-Smtp-Source: AGHT+IGOWO+5suNJbsRVKvtLG0jySKkegJqJNcDlqLEQQwbJgkA2kEuV2W+ZINt6RRPJCqetoc9s8sujE5yyN0QdPjQ=
X-Received: by 2002:a05:651c:2210:b0:2fb:5035:7e4 with SMTP id
 38308e7fff4ca-2fedb75775fmr23769421fa.5.1730474731064; Fri, 01 Nov 2024
 08:25:31 -0700 (PDT)
MIME-Version: 1.0
References: <20241015085150.219486-1-marcandre.lureau@redhat.com>
 <20241015085150.219486-8-marcandre.lureau@redhat.com>
In-Reply-To: <20241015085150.219486-8-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Nov 2024 15:25:19 +0000
Message-ID: <CAFEAcA8DztPbmp_PavV9EGs=1RUeszDOpGRtwVexQbcCOXWO0A@mail.gmail.com>
Subject: Re: [PULL 7/8] chardev/mux: implement detach of frontends from mux
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Roman Penyaev <r.peniaev@gmail.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22a.google.com
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

On Tue, 15 Oct 2024 at 09:52, <marcandre.lureau@redhat.com> wrote:
>
> From: Roman Penyaev <r.peniaev@gmail.com>
>
> With bitset management now it becomes feasible to implement
> the logic of detaching frontends from multiplexer.
>
> Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
> Cc: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
> Cc: qemu-devel@nongnu.org
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Message-ID: <20241014152408.427700-8-r.peniaev@gmail.com>

Hi; Coverity reports an issue with this patch. I think
it's probably a bit confused, but on the other hand
I read the code and am also a bit confused so we could
probably adjust it to be clearer...

> +bool mux_chr_detach_frontend(MuxChardev *d, unsigned int tag)
> +{
> +    unsigned int bit;
> +
> +    bit =3D find_next_bit(&d->mux_bitset, MAX_MUX, tag);

Why are we calling find_next_bit() here? Coverity
points out that it can return MAX_MUX, which means that
if the caller passed in MAX_MUX then we will try to
dereference d->backends[MAX_MUX] which is off the
end of the array.

What I was expecting this code to do was to check
"is the bit actually currently set?", which would be
   if (!(d->mux_bitset & (1 << bit))) {
       ...
   }

Why do we want to find the next bit set after the
'tag' bit ?

> +    if (bit !=3D tag) {
> +        return false;
> +    }
> +
> +    d->mux_bitset &=3D ~(1 << bit);
> +    d->backends[bit] =3D NULL;
> +
> +    return true;
> +}

(This is CID 1563776.)

thanks
-- PMM

