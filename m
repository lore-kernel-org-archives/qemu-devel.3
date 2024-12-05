Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0C3BE7716D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 13:29:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJBuF-0000Pn-SK; Thu, 05 Dec 2024 08:28:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJBuB-0000PV-Sd
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 08:28:33 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJBu9-00044P-FT
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 08:28:31 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5d122cf8e52so1428439a12.1
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 05:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733405306; x=1734010106; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZKnOJVD9Z+xSi53FsqP/mQaZd6IpveLUMFX5W/l75EY=;
 b=cihwFxTfjskn00sp85zbqdQwDXAI2cjupwnTm4kLa9jmikJmtvvt3nt9EAFHbvgmtv
 YdULr2ShGrANhGxB4k4jUi1fagyrBaDov/D3fTbeNl6Y8A58N4qTVYdajIeZESKzN78E
 Tz0LZR8mg2gCmLZ/DIX3FjtcKc9xMwU+9XJCg4zhjeJxQOOpl2R2Mw0tN1giROEM4+cw
 HliavvsTg/VdVXsbWzey4H2nOAFD0nsW+Os+6bjG6J1RUre8Cw/sktjAzobqdMYoVjqu
 Zq4NwoXWwWrmGcIeOYAO/CXyDd3Wq28FvAvP+LlknBdr1Ty51JS4NiIacLVHaEqlWYeM
 s2XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733405306; x=1734010106;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZKnOJVD9Z+xSi53FsqP/mQaZd6IpveLUMFX5W/l75EY=;
 b=vYRIr6DGHTPaYoSLku2F17A5+RO9rGQANVWX9vEJL39ztrW1hgKiWrKo46E9TMwhTK
 E9u9X0v+pzIhZCsGbAwOjGGpIGuvV282Xk7FNcIzngr0BrF2MFzknpf//0+lXzJS+alF
 LACrlco1L2V3l575VsiEGgTe/r6kbIZ/hCmWOo1q6zSVsBfRYYzRSA5F34BV8FrcdyXF
 omuZX/u6gUeEoAMA0ItWqqdlEcxiGaEmaTrycjSmszT4i6gQ34xSeSEjPXRB/IVlW7tK
 E7kCTNGZ4BABBQ0ojXhTL/fBxPCko4v09XU63YIRZL6uOyR8cxDoyI+ysOiSTPD57MSJ
 +sjg==
X-Gm-Message-State: AOJu0YzBhcB1vUtCXEVhBbS2n0rgAHbgZyIgMm5rvs4OhifGwQ8yNqVw
 LplDKYzS0mojpICWF2p2vrfeHJKeUzcW2wL1CxR6EiVuVaB2ZLhbvnjaEKrmuH6UmX64a4f+bvX
 iheAlSpKFVfTfxqrUzX4HkRsv+NcklcFBHV4BC8mdDAN/Cw2b
X-Gm-Gg: ASbGncuwSgj7k0eZKEhT6+5Q2nyMhWzM35xE73KuwYFumrTG4/Zwtuhyux0txWlEhKP
 BnIDZkAuiFIQe9aGyn02d28t3aZ7EUnlH
X-Google-Smtp-Source: AGHT+IGseNRK7o1nHytr+/YYIna5g07XNgq1YBZrOA0I5W4F8NcuJdadM+ztjOQu/NQyAJ7Tbp7GrdwnYONt/wTRKq8=
X-Received: by 2002:a05:6402:510a:b0:5d0:f9a0:7c1f with SMTP id
 4fb4d7f45d1cf-5d10cb817d3mr9923439a12.23.1733405305944; Thu, 05 Dec 2024
 05:28:25 -0800 (PST)
MIME-Version: 1.0
References: <20241203203949.483774-1-richard.henderson@linaro.org>
 <20241203203949.483774-2-richard.henderson@linaro.org>
In-Reply-To: <20241203203949.483774-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Dec 2024 13:28:15 +0000
Message-ID: <CAFEAcA_kL8gmuXZtZwnoDy1dFhdSvkmqCQ0yZJF18Jf4xNb0rg@mail.gmail.com>
Subject: Re: [PATCH 01/11] target/arm: Copy entire float_status in is_ebf
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
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

On Tue, 3 Dec 2024 at 20:39, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Now that float_status has a bunch of fp parameters,
> it is easier to copy an existing structure than create
> one from scratch.  Begin by copying the structure that
> corresponds to the FPSR and make only the adjustments
> required for BFloat16 semantics.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/vec_helper.c | 20 +++++++-------------
>  1 file changed, 7 insertions(+), 13 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

I missed this in my grep for places where we set up
a float_status I think because it's the only place where
we use a struct initializer in a way that isn't literally
 "float_status s = { ... }". But I did a wider grep and
I think this is the only place I missed like that.

thanks
-- PMM

