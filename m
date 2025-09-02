Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7AE7CA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 09:22:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utNCI-0001yP-Fv; Tue, 02 Sep 2025 05:21:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1utNC6-0001ws-3r
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 05:20:50 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1utNC3-00067x-25
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 05:20:49 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-45b9c35bc0aso1338835e9.2
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 02:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756804844; x=1757409644; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:in-reply-to
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gamy29gSA9Ji+RJyXqpzasJan+IzYu/xM24dBdO6Bv4=;
 b=LGwIOH1wx4IOAnwRluMxcPndqUJ6qrhLkQkqxg5yCfmO99IeDs5EdlDXVWtTQD20FY
 psW+6vlmxHmUKHH1gxQpfBSJOeK6iwwgjjcVOYItv8gK05fjR2YJTnZ7hG2OtHqZCXaj
 Na1amF5+rjy3ayHj5h35NcxYgzv1bAo5dQPVdPCkntimt/tiJ+yNeXprqRe6tM0hgSdt
 hBfEPiiicvtlPSEhcT40TNzHl87083u8lPw+OJY79fdfRLtbMwMuca/kunPkIdxY5cpC
 cRvQApL9CHhLkZObOAA6Fv1IFmpdY1VWfgSFB67KSRODQAfTSZlBpvtTOG0CBfrd+S0e
 looQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756804844; x=1757409644;
 h=content-transfer-encoding:mime-version:message-id:date:in-reply-to
 :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gamy29gSA9Ji+RJyXqpzasJan+IzYu/xM24dBdO6Bv4=;
 b=NH1OhnZzfa2L8T21xvEo7SE28SWAktGcyk7lnx5DI4US4ZuVko6eZ6TGl/okWexs1w
 ZIh/6NuZLZ1Fe0+M5hvC41U9F9j9N8X7qSXb6VqZ3pZnGoyDrLTJ5gXYL8DRqYkJL5fI
 EKOJg23CV8FmslOqko6Q0b4ht7p0NdM3/xjrG5z4/jEFuAnW9UWPIlGsUP8whuiNKoo8
 Ca0NNtva4gu5P0UDMRBt5jZnh8lWRbgafvpMvd1TYcFMQB9oJLSwsaIgss1oplWorJMe
 KUrcb6dLi+jtmb8JT1MPpBEdM0WLmPMD9Z3a75AtxCUAfPw+RJUSDZf4bS5vTEHpioj1
 BkzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSsMC8TENl40EqRBnYa0Ha7OBsQmwfkFFSqXxbYy4KfCb6rS8dw1PXSNzNrAeqGlIhH5+MWpuMDk4j@nongnu.org
X-Gm-Message-State: AOJu0YxG8RuVQFE3K+Y3yEguS047ylkcTMh1DUYD/eOQkzc595McIf7r
 to7qo0AAnFl8XkRudSHbt1aFYY3GbqVevqEQxhuZ8IwWheEpMfhChPovX1B6FNgz2Xw=
X-Gm-Gg: ASbGncvFSB2QQK+hjYrn3lDW+uT1ZDHK7clDDLeafEB+tYIpI1FX1zPq3wLGI7LgK6o
 x3Mdy1MnXCYs625xOc/DWPwi0QsosA8P/Y6I2h80McwefH369UGPanm1Rps4gGcvMUaWZasFDpk
 OVEYbJxazfd/bbXcjahcpAFfVZ9MJIKqRHoKWd4UJUWVzXiEq1R+xg/U+oURMeIh47Ro5PFa+AY
 R8kJpFozlKZCCQRJ+BgnI4autG07uqnlmjqRtIcnXBzpIPvB1PAn08FgW7YSiz6AdlScR6dC+8m
 TjKRKWo5eL5njN3x/VVQlyyaWIePsn2ihW51mr4cowQlrThT+rt7gFHciJ82dTTy1pPlFeXvbtB
 itefmgigtQ/vxofiP4TyRLe0AnA/GeLqJtw==
X-Google-Smtp-Source: AGHT+IFEtQuJmXi1y0zKfICl9LIBBEjqNn+tznv1KnDzE0WWGEn80XR4LRHN0i8+0lE8mU2M+H+45A==
X-Received: by 2002:a05:600c:4687:b0:45b:8e26:5f46 with SMTP id
 5b1f17b1804b1-45b8ee17c88mr47064585e9.5.1756804844018; 
 Tue, 02 Sep 2025 02:20:44 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b7e8ab093sm196789795e9.22.2025.09.02.02.20.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Sep 2025 02:20:43 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2ADC95F894;
 Tue, 02 Sep 2025 10:20:42 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: peter.maydell@linaro.org,  qemu-arm@nongnu.org,  qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/arm/raspi4b: replace fprintf with error_report
In-Reply-To: <20250901213607.69603-1-osama.abdelkader@gmail.com> (Osama
 Abdelkader's message of "Mon, 1 Sep 2025 23:35:53 +0200")
Date: Tue, 02 Sep 2025 10:20:42 +0100
Message-ID: <87zfbdyzv9.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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

References: <20250901213607.69603-1-osama.abdelkader@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Osama Abdelkader <osama.abdelkader@gmail.com> writes:

> Replace direct fprintf(stderr, .%80.) with QEMU's
> error_report() API,

Not sure what happened with the encoding there, it seems to be non-utf-8.

> which ensures consistent formatting and integrates with QEMU's
> logging infrastructure.
>
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> ---
>  hw/arm/raspi4b.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
> index 20082d5266..4a5f0eb91e 100644
> --- a/hw/arm/raspi4b.c
> +++ b/hw/arm/raspi4b.c
> @@ -47,7 +47,7 @@ static int raspi_add_memory_node(void *fdt, hwaddr mem_=
base, hwaddr mem_len)
>      scells =3D qemu_fdt_getprop_cell(fdt, "/", "#size-cells",
>                                     NULL, &error_fatal);
>      if (acells =3D=3D 0 || scells =3D=3D 0) {
> -        fprintf(stderr, "dtb file invalid (#address-cells or #size-cells=
 0)\n");
> +        error_report("dtb file invalid (#address-cells or #size-cells 0)=
");

This change is fine as far as it goes but I wonder if it is an
error_report or a warn_report. The reason being:

>          ret =3D -1;

we set -1 to ret here but it is ignored by the call:

    if (info->ram_size > UPPER_RAM_BASE) {
        raspi_add_memory_node(fdt, UPPER_RAM_BASE, ram_size - UPPER_RAM_BAS=
E);
    }

which implies this isn't a fatal error, but the user should certainly be
warned they won't get all the memory they were expecting.

While these single line patches are a good way to get comfortable with
the review and submission process I would also encourage you to look at
the call chain.

In this case we get here from arm_load_dtb:

    if (binfo->modify_dtb) {
        binfo->modify_dtb(binfo, fdt);
    }

And you can see further up that function we do the same test:

    acells =3D qemu_fdt_getprop_cell(fdt, "/", "#address-cells",
                                   NULL, &error_fatal);
    scells =3D qemu_fdt_getprop_cell(fdt, "/", "#size-cells",
                                   NULL, &error_fatal);
    if (acells =3D=3D 0 || scells =3D=3D 0) {
        fprintf(stderr, "dtb file invalid (#address-cells or #size-cells 0)=
\n");
        goto fail;
    }

which fails and ultimately causes QEMU to exit as it can't continue. In
that case I don't think we could ever hit this condition. As it would be
a programming failure I think we could replace the whole if leg with:

  /* validated by arm_load_dtb */
  g_assert(acells && scells);

and maybe remove the ignored (and redundant) return value from
raspi_add_memory_node().

>      } else {
>          qemu_fdt_add_subnode(fdt, nodename);

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro
Date: Tue, 02 Sep 2025 10:20:42 +0100

