Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20185C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 09:34:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1jrY-0002gE-9C; Tue, 30 Apr 2024 05:33:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s1jrN-0002eV-5k
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 05:33:13 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s1jrK-0004hD-12
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 05:33:12 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-56e477db7fbso9278541a12.3
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 02:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714469588; x=1715074388; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gQXAzTFMnsXw1pFM5UUXGZniErQhxR3nHrd/oZ7AE/Q=;
 b=WQOcAFXgjeouAhwIaJpfvlmGqjyI5zycHtiJ+Nmg8DXsYDvOi7merIMt86PMWKnVCu
 FT7nN3o60l/OrUA4b+mhzXtuQ569ZAwkvR6wmYtp5ztjUQmhZZpN89TMN1jJloNu6C/y
 ZGJUy4Gyl8ZqAFzwXwcnxdkeHY7xfdHYanJd1INTmVb5JHUAMgQPa1199lsYQB5ZWw3s
 tCZaDkh+PmKsYRda2Ku3rSIzqyTmfNJY6IyAbWOSoC69+4QijKaCkAJs3D2ZyhfoI3UB
 zUGK4CUCYgHwTjZfLuhqynm6oaIP4G1Ja9oqdqBsCDabcEUo2dDGFB79OB6AMDtyHtqG
 8XLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714469588; x=1715074388;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gQXAzTFMnsXw1pFM5UUXGZniErQhxR3nHrd/oZ7AE/Q=;
 b=Dq3lrbSEBtyXN8B7owEoxDTC+H5RdxRzzwTgP5lpmkkU8lpR/nsjxWLWZWUYWiZwyC
 GZcImU82I58p/j2Wjm/WC9Yt6Nitml3Kaz5QsF32lSDMlp1c+ECX9XDE6a9/MmsoehJu
 ggwY6SS9rbmMaAFRjyqIdew5+wk2RkHrt5IIBZZ6QNaYDtzLCirHES8s093eHD0hrLI9
 U1RUGa4NuNW6ic3xmqosoMid9htI3EFfMTA9yX4hNo6UewLlVUYFDFvZ60Qmt1iqzAEB
 qZijCP6DbMNB3rPLZJ62udehBrRUkgwroSU0Y4SHENA763956I3uKCdJH7WsqdJNyoFh
 aatg==
X-Gm-Message-State: AOJu0Yw7T/LlP3Ku+EjTiPnSBHBow1kF71kGwZ7CD/XF6KZa0mG1j/Dw
 BDpHM/N7n9Y0W3bNHLZr/QVEPK2V0+qu+nAl2nkHFKw8AALcPfk3YjxOQ0WsV9aE1yV9s30elrj
 IM8w5Du+69A0AB8UC74DVeSIKSxGnZlqJpe3WOQ==
X-Google-Smtp-Source: AGHT+IGe62GPIYPF7EUGUC8zzT835WIzpVbwOCAb8gbPh56AQRFaRh5HkuiugzuzyWTPLarHYKGtg34v/eUg1AMgZv4=
X-Received: by 2002:a50:9b49:0:b0:572:4681:8c1d with SMTP id
 a9-20020a509b49000000b0057246818c1dmr8867818edj.9.1714469588210; Tue, 30 Apr
 2024 02:33:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240430064529.411699-1-thuth@redhat.com>
In-Reply-To: <20240430064529.411699-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Apr 2024 10:32:56 +0100
Message-ID: <CAFEAcA_wbogO85vf=Z9cN2tMX-iwonraX4-jeFqo_yO3K7o_Cw@mail.gmail.com>
Subject: Re: [PATCH] docs/about: Automatically deprecate versioned machine
 types older than 6 years
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 devel@lists.libvirt.org, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Tue, 30 Apr 2024 at 07:45, Thomas Huth <thuth@redhat.com> wrote:
>
> Old machine types often have bugs or work-arounds that affect our
> possibilities to move forward with the QEMU code base (see for example
> https://gitlab.com/qemu-project/qemu/-/issues/2213 for a bug that likely
> cannot be fixed without breaking live migration with old machine types,
> or https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg04516.html or
> commit ea985d235b86). So instead of going through the process of manually
> deprecating old machine types again and again, let's rather add an entry
> that can stay, which declares that machine types older than 6 years are
> considered as deprecated automatically. Six years should be sufficient to
> support the release cycles of most Linux distributions.

Sounds like a good idea.

> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  docs/about/deprecated.rst | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 6d595de3b6..fe69e2d44c 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -220,6 +220,17 @@ is a chance the code will bitrot without anyone noticing.
>  System emulator machines
>  ------------------------
>
> +Versioned machine types older than 6 years

"more than 6 years old"

> +''''''''''''''''''''''''''''''''''''''''''
> +
> +Starting with the release of QEMU 10.0, versioned machine types older than
> +6 years

ditto

 will automatically be considered as deprecated and might be due to
> +removal without furthor notice. For example, this affects machine types like

"further"

> +pc-i440fx-X.Y, pc-q35-X.Y, pseries-X.Y, s390-ccw-virtio-X.Y or virt-X.Y where
> +X is the major number and Y is the minor number of the old QEMU version.
> +If you are still using machine types from QEMU versions older than 6 years,

ditto

> +please update your setting to use a newer versioned machine type instead.
> +
>  Arm ``virt`` machine ``dtb-kaslr-seed`` property (since 7.1)
>  ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
>

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

