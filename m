Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC473C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 13:19:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOdQE-0004J3-Nw; Tue, 02 Jul 2024 09:19:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1sOdQB-0003xO-GW
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 09:19:47 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1sOdQ6-00077P-2g
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 09:19:47 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-64b101294c0so37434597b3.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 06:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1719926380; x=1720531180;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vZmANW0AKX6ZG2qcZyynwhma0XY2RvAfF3kc2Hd/JEU=;
 b=mZPT9qHqmYNWhmYH2w4zUrkbOzGbv3N5R6CifNtSOkzWoZBQJdTo/6HeJbnWP2kJKE
 iNsmP2FqAvPAFxOj0N6Qanla7YLq9uos3V8qrQ90yvjR9U82y9yE86BOMS5ARTDDZOwr
 IJ3qQlLDkET+dp3BFantC4ktcbsIUuOpC9sVos44jf8TjjANUUndxPnhsaBowbqiBCRH
 Nf0j8MbWjZZupDSZPsUcwrBya5AXrUd7h2ihsuT9XnIJ8zEvvDLrf4cEMlrMjo7GXNcB
 OxP8UnT6QXuq8lYA2CQp9WjwH4q22Ey7ZoU9LdrjqEOoUrIRl52DynuuAckuRg9Mfb+Q
 WKXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719926380; x=1720531180;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vZmANW0AKX6ZG2qcZyynwhma0XY2RvAfF3kc2Hd/JEU=;
 b=OVGQQfWgNdwAECWJNtKR+Dv50g83F05UZBXzyxtzJzy/D17GVIkyIHowE75M5p2zB1
 EK004/9vHzx+kbqGfxeiixH4Lth1V3FYkm+LJl3MrBuVqYx6x0L6qUMI7JVueYE5GmoN
 fIsj8bBnSH7W5/yN6Bksm6h+TqcyDHXxcLSctaxyCFU1UhCW8YnGDWQwQHTgIiFdPnEs
 LiLaFxlCRxG9Ter3cR0nnB8N1Qlgyf5T3A7CQXTt7zIVqxyheXMWXpQCF1JAu99ABNhK
 ND4po/EMsf85x6act5goLmOym+zZHkU7LMngxubojtcY4UAWqv2ZFbLo3kfU8/+T/Dfg
 Wh8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYX+gavQSS0kF7Iq7Ommxiou7bZL+WaH6liWgfdLXBpRyqs0pIObV+uskRNELp40UVc/qLsNfNUTSWNy09s3GG8fpwlVk=
X-Gm-Message-State: AOJu0YwZAB08ZW1Gvz2C0xUdtHNgtIG40yw6RXrAD9BAKMmYu+NdjV0o
 oY4fFws1tYd5upt/hV8Bt3IwLtKKemYA1d9LXe9dcvWwXzDuv+e0TNM3pEiNjXG3n071HbKCsxB
 TR1XZR+UDNnuM8mDJqYyh5XAIYOpZpgYQ5rj3
X-Google-Smtp-Source: AGHT+IHTzsk0SMK5FGEAjfZssE+rJhj3UBPLBT3r1DikKGlog4ckRAMEW9Q0SakVs5bmobus1Ua3gdikENGYAoqO1eQ=
X-Received: by 2002:a0d:e854:0:b0:650:82b1:4729 with SMTP id
 00721157ae682-65082b14aebmr10157407b3.33.1719926380605; Tue, 02 Jul 2024
 06:19:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240627-cursor-v2-0-c3cd3ee35616@daynix.com>
 <20240627-cursor-v2-3-c3cd3ee35616@daynix.com>
In-Reply-To: <20240627-cursor-v2-3-c3cd3ee35616@daynix.com>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Tue, 2 Jul 2024 15:19:29 +0200
Message-ID: <CAAibmn0S+BvotSV6Sw-d17ybCu10a6Hgyu2sEUrJrzejHs9WZA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] ui/cocoa: Add cursor composition
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000f4cc08061c4390e4"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::1135;
 envelope-from=phil@philjordan.eu; helo=mail-yw1-x1135.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

--000000000000f4cc08061c4390e4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 27 Jun 2024 at 13:17, Akihiko Odaki <akihiko.odaki@daynix.com>
wrote:

> Co-authored-by: Phil Dennis-Jordan <phil@philjordan.eu>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>
> +- (void)setCursor:(QEMUCursor *)given_cursor
> +{
> +    [=E2=80=A6]
> +
> +    provider =3D CGDataProviderCreateWithData(
> +        NULL,
> +        cursor->data,
> +        cursor->width * cursor->height * 4,
> +        NULL
> +    );
> +
> +    image =3D CGImageCreate(
> +        cursor->width, //width
> +        cursor->height, //height
> +        8, //bitsPerComponent
> +        32, //bitsPerPixel
> +        cursor->width * 4, //bytesPerRow
> +        colorspace, //colorspace
> +        kCGBitmapByteOrder32Little | kCGImageAlphaFirst, //bitmapInfo
> +        provider, //provider
> +        NULL, //decode
> +        0, //interpolate
> +        kCGRenderingIntentDefault //intent
> +    );
>

I still think this is an awkward amount of boilerplate that could be
outsourced to a helper function - especially as you've now reminded me in
patch 1/4 that drawRect: does essentially the same thing and could probably
share that helper.

I'm still keen on NSCursor support for absolute pointing mode though, so I
can experiment with doing a better job of cleaning it up as part v3 of that
patch series. So:

Reviewed-by: Phil Dennis-Jordan <phil@philjordan.eu>
Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>

--000000000000f4cc08061c4390e4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, 27 Jun 2024 at 13:17, Akihiko=
 Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com">akihiko.odaki@daynix=
.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex"><div>
Co-authored-by: Phil Dennis-Jordan &lt;<a href=3D"mailto:phil@philjordan.eu=
" target=3D"_blank">phil@philjordan.eu</a>&gt;<br>
Signed-off-by: Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com=
" target=3D"_blank">akihiko.odaki@daynix.com</a>&gt;<br><br>
+- (void)setCursor:(QEMUCursor *)given_cursor<br>
+{<br></div>
+=C2=A0 =C2=A0 [=E2=80=A6]<br><div>
+<br>
+=C2=A0 =C2=A0 provider =3D CGDataProviderCreateWithData(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cursor-&gt;data,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cursor-&gt;width * cursor-&gt;height * 4,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL<br>
+=C2=A0 =C2=A0 );<br>
+<br>
+=C2=A0 =C2=A0 image =3D CGImageCreate(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cursor-&gt;width, //width<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cursor-&gt;height, //height<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 8, //bitsPerComponent<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 32, //bitsPerPixel<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cursor-&gt;width * 4, //bytesPerRow<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 colorspace, //colorspace<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 kCGBitmapByteOrder32Little | kCGImageAlphaFirs=
t, //bitmapInfo<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 provider, //provider<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL, //decode<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 0, //interpolate<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 kCGRenderingIntentDefault //intent<br>
+=C2=A0 =C2=A0 );<br></div></blockquote><div>=C2=A0</div><div>I still think=
 this is an awkward amount of boilerplate that could be outsourced to a hel=
per function - especially as you&#39;ve now reminded me in patch 1/4 that d=
rawRect: does essentially the same thing and could probably share that help=
er.</div><div><br></div><div>I&#39;m still keen on NSCursor support for abs=
olute pointing mode though, so I can experiment with doing a better job of =
cleaning it up as part v3 of that patch series. So:<br></div><div><br></div=
><div>Reviewed-by: Phil Dennis-Jordan &lt;<a href=3D"mailto:phil@philjordan=
.eu">phil@philjordan.eu</a>&gt;</div><div>Signed-off-by: Phil Dennis-Jordan=
 &lt;<a href=3D"mailto:phil@philjordan.eu">phil@philjordan.eu</a>&gt;</div>=
<div><br></div></div></div>

--000000000000f4cc08061c4390e4--

