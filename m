Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E61606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 16:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=bgsflDgd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMSwQ-00057G-RY; Thu, 29 Oct 2026 12:25:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xMSwF-0004xT-Vq
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 12:25:16 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xMSwC-0001lz-Tw
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 12:25:15 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-8ab395abf79so21799147b3.0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 09:25:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793291111; cv=none;
 d=google.com; s=arc-20260327;
 b=Mi7UbK6yqS4S3Qh1mBWy/Cw0VYY5mmdm67AlVLu0LBK0R8SPKpVx6goUXRUVMCfk3o
 Ce/Be6CttXjusHyXdF22iE2zcd5rWqbpylr61TWNOkkgUzvwNwuncak+o1TBvecrgps7
 609RBjPJszmo5Nm02Qe+xUTbWVHCx5fLHuq9hxtks5mG5e8unozzGnwqN1y50M0z121s
 5QIjuMhnB6bxXxcPjNJUkgw4QsXe/K9l5WKoawAThjf6lL9ZiPcVCxyMHo3op5FXqoBM
 ZzLZ9oZn3oYm/PID2hdZR6F7j3raCKBDX51EXttsspwuR3yBE6KXfUZ2/MLR7TgGKlml
 z34g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=splBKlMlcrvGccJeIJ187T4TxJMqgNzFe1PSJ6nKeO8=;
 fh=awQMMknHcj1HIuFUrvcecN0YXHDVa/EdgcU1qdAHEHg=;
 b=QDJinbkTSiOQaIzJfvA0DA8dKsY0t44nHTbLGEStiSTKhCo3gIqpLtcGCAn6Ru38r1
 WU7nfCvYuymkHtmKRxACjvs51FHYxMG3K8f1/lwbwVqSH8/AkcSuC32j7vBCi6iYQgFI
 ++2L6aQLNFCj2YDMZcWCMRPlNH6bbN2VUz1x5S0mikTfLKVQ0EJMGsywAxVE9RJRs4Lr
 mIuYJxBiuwkZ7fgF0ujQ/eAgqX5wImNygv2UPs54Dc5loD41/9pLiVG8DL5K/rFBhjLn
 xPYkXQoDe23pj3RwnwQVQSg9WLr+3qe4byJ0Dq3PAelztg1DG44x7pb0o2UUFaJ7TAlP
 PjNg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793291111; x=1793895911; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=splBKlMlcrvGccJeIJ187T4TxJMqgNzFe1PSJ6nKeO8=;
 b=bgsflDgd8HSC+/QA6aLn97tH2SS4vnRrx+H58AxYEEsljr12IU0jdURyZk2RRTU9cb
 ynv4o5sOP+qdqw1JXl+n/i5xF4fH6CGYCMKh2qf7UmmidVFDIZOHzVYtQUW197Pr4rhJ
 V8Q6qpaGkJ2uJ72uLPqaR8qFE8r+m6sX3eHbr3FLfp6gEGum76upPcwjc0Ih2D2D1pLI
 XyUZW5e8Z8wiCLyif8cpC9kwz1R1yr+Z1F+ykZu8ah7Yv23ql6E7HpmWj4w+IF0n3tN2
 z0+dxKfyrKtolh/iejuTDzZ/UyxqK6sC7JlOtGanT8qyl5Z6Bp3oKcSLAJbWXmlsSvMk
 UyIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793291111; x=1793895911;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=splBKlMlcrvGccJeIJ187T4TxJMqgNzFe1PSJ6nKeO8=;
 b=tzVTl/6xVizOteW38JJdn/xfdre7hGqXLVnRI2QzGNK51UT07yP8QeGWj3bJehZrPU
 R42D9dBxwAcuaajoB3fRVgMuU4ibHZkipmEhZGwFlBsDFP97U1bB1ZFPrDdrMByAZBY6
 52uVoYmIG4HqR6PP9Ca8cNwSdTmfJW//WNux5ZyK1ArjSA+U0toe9z2gcIZCL8CuIUlg
 SalCk46dZ64wNItX9RlBHLP89Mt6Q7WWzKdFGmIS5sIngnmumaAS0K6PBi53q/25+wHr
 SQ/vvwwgYLa77W4TtyiEUvqNfo4CNiopmseU9zKYjoehtK9jCk/kJb7IVgy0wRquT8Uv
 M0Aw==
X-Gm-Message-State: AFq9FYKlFv/La3JHvlMxq9CZExRmOlyYxIrpDBkw8SmJsnyWR5/XSpgt
 /4lypYkd49SrtBZBcX+/IqU0tu15EMrcuur7ntIRJBLDcWbMpzuarFHr3e0mmp6OHMNoJoVSnDh
 cH9lRWJisIY30hXTZefd6a9w6TeEUum4lmHOzgaWPjg==
X-Gm-Gg: AYBFou2I6FS+IKJZmkXKQ5pv347zmqGKdn0VrCoCDgF4wwh7zodS0dsSsXyAu9qDRvO
 h8Zrgxnvt+jhpHY7Iy4O4L91HowIeAzAY8is4Dz2KUDdSAEH+AHTErhrc526HCrytJtroKV+XS3
 BSwa5WIvqPQjpKfeqGGE7B7pNG+P3W9up9btX6P6fibJyrgLEvO2ceMyn3Huh9xbGMEMCqnIf//
 NyyLV3zvNWwnVxea4MujFuCYeaZZhD3JB+IZlpitLe69eFrxN4xRBgOxhUZ1IdSvWKDiJbD+18M
 A+8c0bVw8J9p4yc4+evUabrOFn5YwZqAxABLFXYGWB0/ZFpJcRp8ALA+YKLnzYfo/aLGUdk2TPH
 dq5KEPJq3KF7s+X9jIeL37WxzlhZaJVRqoK58XT8s1e7IlfdBX56HsHaQXTRU5o5fLXGXiPte9L
 rD/Oslct15nChFbKyLucqB
X-Received: by 2002:a05:690c:31d:b0:886:70a9:3ad2 with SMTP id
 00721157ae682-8b1b5bbc1afmr44624467b3.15.1793291111249; Thu, 29 Oct 2026
 09:25:11 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261029161310.2065290-1-alex.bennee@linaro.org>
 <20261029161310.2065290-9-alex.bennee@linaro.org>
In-Reply-To: <20261029161310.2065290-9-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Oct 2026 16:24:59 +0000
X-Gm-Features: AclHuK88JNA3RzGsb-is0Cegamf9ln1emsLMJRIMh-AbcZmkmyRVpFlCq34ze-k
Message-ID: <CAFEAcA_CeWj-teRt0bzdcnRfZ5oU_hLOvcaXuDZPtrb3SPoi5w@mail.gmail.com>
Subject: Re: [PATCH 8/8] target/arm: fix bcm2835 migration issue
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, 
 Chao Liu <chao.liu@processmission.com>, Tyrone Ting <kfting@nuvoton.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Hao Wu <wuhaotsh@google.com>, Halil Pasic <pasic@linux.ibm.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 29 Oct 2026 at 16:13, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> We don't take care to force re-validation of the config on migration
> leading to a crash when the defaults don't match the migration stream.
> The other frame-buffers seem to do a similar thing in post-loads to
> address this.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4668
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> ---

>  hw/display/bcm2835_fb.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/hw/display/bcm2835_fb.c b/hw/display/bcm2835_fb.c
> index bd58f625fcd..c5731521b57 100644
> --- a/hw/display/bcm2835_fb.c
> +++ b/hw/display/bcm2835_fb.c
> @@ -352,10 +352,21 @@ static const MemoryRegionOps bcm2835_fb_ops =3D {
>      .valid.max_access_size =3D 4,
>  };
>
> +static int bcm2835_fb_post_load(void *opaque, int version_id)
> +{
> +    BCM2835FBState *s =3D opaque;
> +
> +    bcm2835_fb_validate_config(&s->config);
> +    s->invalidate =3D true;
> +    qemu_console_resize(s->con, s->config.xres, s->config.yres);
> +    return 0;
> +}
> +
>  static const VMStateDescription vmstate_bcm2835_fb =3D {
>      .name =3D TYPE_BCM2835_FB,
>      .version_id =3D 1,
>      .minimum_version_id =3D 1,
> +    .post_load =3D bcm2835_fb_post_load,
>      .fields =3D (const VMStateField[]) {
>          VMSTATE_BOOL(lock, BCM2835FBState),
>          VMSTATE_BOOL(invalidate, BCM2835FBState),
> --
> 2.47.3

For the fix

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

