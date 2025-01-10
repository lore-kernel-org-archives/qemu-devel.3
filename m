Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B48FCE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 16:34:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWHxW-0001Bo-Qs; Fri, 10 Jan 2025 11:34:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tWHxS-0001BD-Aj
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 11:34:02 -0500
Received: from mail-yb1-xb30.google.com ([2607:f8b0:4864:20::b30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tWHxP-0000Hx-6Q
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 11:34:00 -0500
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e3fd6cd9ef7so5656155276.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 08:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736526837; x=1737131637; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9QkFzvLXENhdg677ICuQLwSEYKTcmCSdb4mz1Xb7oPI=;
 b=WiYqfc8WLqsdhnMzJ79kRiUfxxYQ558pLqAM6jYx5wXQkmtYq6t8P9HXmzXUw3fiRl
 JO8MtEnwnMoR48AWS0vtusU8cAQ6SHOJzonNZZp/D7HQSO3I8/RRWsAvveEoAPzRk/Av
 j7r+gg50s1qtvdCRAFZ+XQ7oaMZWKP/6/qhmyM/2rLmzYAYY3dmpQG4/b13tUr5if3DB
 goXJn5OcnymwLS9fbGOmXO/KvFqhKp3aB/7kT4ovqIiJ79CLVGc0gFoMHYdOZR/IS2Ab
 dA6hMmo9H2wOQmzpgy6KUol6XgcdHEip7FxToxRB3f/klWVQNfplzZiWaZnDUCzwdZUc
 PaiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736526837; x=1737131637;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9QkFzvLXENhdg677ICuQLwSEYKTcmCSdb4mz1Xb7oPI=;
 b=i2bY3SfQ4n2ubKc1/N17L9mlvsbiqXWdSLs1O1u3CcoQlGiE3rwUK0JuSN61sHayGr
 J97R+DCrh+1UteciUhWQeulRkj9qJu2/g/IbThBBR2//uQZ3Gfub+09kLIGNVFrd4cUZ
 W/71zruF+LitXCQMNzexN4BHMhEBNP2bp8/H15mqFK3xWcD7KdIdbTKdGkUEXFDiyudI
 SFbGMv2z/lwho8j3wttNTq7F0olqRTCIZZKoumBhpwqZmMQvLWARVPkcitpjIWbWRlZy
 mLwlKTZe0NiqcH5uGnl5CXAyPivMYa4kfBU7AR+sb+iwD71iRH5KrSTI2Ocq39WGokgW
 Dg5g==
X-Gm-Message-State: AOJu0YyKsPvo5MDBYd6hprTXebgHdiVHK3XXbBXusjimBQKM+YYMzk3r
 DjMAJPJjacWcJpuGf7nV+v6CkvS9tHNiVdrHzerNP+QeU7tOxPZxw8dmK1JfZHhqgJaFCTN1ifz
 kK3bgSW26U0GACOHMZWWG+73tGixdRRkpooQK4g==
X-Gm-Gg: ASbGncvuhSRd9vnFXCMVsE/aPwBKJ413G44rFei/MWArnY1nKpV+Us3PzRnrjlYxg5A
 bwPSGPQoUYGSA+ShKMY9FOjyHGJHXlALN3bO71DA=
X-Google-Smtp-Source: AGHT+IH/irRGCdXYPspo956NxC7stTgc3w70S3x0Zt+tkFuuVtkOtsInSr7N3TFZMAoZBKp4i8bEWQhdmsCb6R9zQK8=
X-Received: by 2002:a05:690c:d07:b0:6ef:f05a:ba6c with SMTP id
 00721157ae682-6f543f2a7camr63286187b3.13.1736526837266; Fri, 10 Jan 2025
 08:33:57 -0800 (PST)
MIME-Version: 1.0
References: <20241223093051.45648-1-j@getutm.app>
 <20241223093051.45648-4-j@getutm.app>
In-Reply-To: <20241223093051.45648-4-j@getutm.app>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Jan 2025 16:33:46 +0000
X-Gm-Features: AbW1kvbXoLybWB2N2sdhWyKt04OyjhCuDkoxwVt_wV532vQHi4LUOZFtLhV9Dvg
Message-ID: <CAFEAcA_HX+AGjO2ZaBsjQKi2d=5AO4V3p33fDG4NzsZ3J-D4QQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] hw/arm/virt: handle hvf with unknown max IPA size
To: Joelle van Dyne <j@getutm.app>
Cc: qemu-devel@nongnu.org, "open list:Virt" <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b30;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb30.google.com
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

On Mon, 23 Dec 2024 at 09:30, Joelle van Dyne <j@getutm.app> wrote:
>
> When it is not possible to determine the max IPA bit size, the helper
> function will return 0. We do not try to set up the memmap in this case
> and instead fall back to the default in machvirt_init().
>
> Signed-off-by: Joelle van Dyne <j@getutm.app>
> ---
>  hw/arm/virt.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index f9b3380815..8c431e24b3 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -3053,6 +3053,11 @@ static int virt_hvf_get_physical_address_range(MachineState *ms)
>      int default_ipa_size = hvf_arm_get_default_ipa_bit_size();
>      int max_ipa_size = hvf_arm_get_max_ipa_bit_size();
>
> +    /* Unknown max ipa size, we'll let the caller figure it out */
> +    if (max_ipa_size == 0) {
> +        return 0;
> +    }

When can this happen? There are other places where we call
hvf_arm_get_max_ipa_bit_size() and assume it's valid.
The implementation calls assert_hvf_ok(ret), so if it
returns at all then we ought to have got a valid IPA size
from macos...

thanks
-- PMM

