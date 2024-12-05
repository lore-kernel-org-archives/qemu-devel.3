Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B243CE7716E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 21:22:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJJI7-0007j0-Sk; Thu, 05 Dec 2024 16:21:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJJI5-0007c9-Kn
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 16:21:41 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJJI4-0004vq-8A
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 16:21:41 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5cece886771so2631068a12.0
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 13:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733433699; x=1734038499; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=x69C4o0AsEFB5rGZfzox+irwukcsUU/LreIYluVLRWM=;
 b=zidHxGjxUr1yOswp1HOoFnyRZctbxRtxmEeNMbmQ3oG0F/fR8QoYhSdX+4t+lTiVW2
 YFE0E4OKkYFQ3Wu4Yc+uigbQtkzNCHOZnJJ3UI1wQM/NsBsIdM/vKwjYeF01S2p8ZvUt
 nC/MRqqDMF8qGH2ylPpK89/dg2R9Bi+FB/ZHVB0dXntKOwK8kOPxhiGXOFsvXaKoXN4+
 d2ba9/i2+vSsXOrRwnB6VM6vYnDIo3pmBLy9MgAQGJEUCSPp6yEpxsjWXRkI35MhXiRW
 ByFZAG5IebQWhZfXEz+9uekqPnngJdQkQ4RZOYIs4f4Tl7uH8KDPyIRosh7T12AM7D1s
 qAug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733433699; x=1734038499;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x69C4o0AsEFB5rGZfzox+irwukcsUU/LreIYluVLRWM=;
 b=YyvYvgKV08zpkTyfFYpOm02cLK1KrUVam2Eu2nm6Nzj1wVRLO1MQEKMXkSq8zaypbV
 MlyUedJ94YkxW1T6x5TgCjInfzZrQnjwHQqNMxeV0dbJpoyLFu//ura7TEpJeCNECpVZ
 q7GhX1amm+4ndgxhyddLW91752bTpmRPhHSK9Q7iDCTWyyoSvN5DWM1oWafzqiOJFMlZ
 3p1DEC9hEU/I5Jwv+NK6pLdjVqVijwbQ7W/JCDrZmCJsIxc2IfV1Od1m/M8WoDwij7Xf
 2STbN89Dsa3lORImCXGRv3jyLhogtUPg2+viNYvHr6X6kKtDfT85hrlYQni37/RXqauf
 63Vg==
X-Gm-Message-State: AOJu0YzLyDkNnkW+CtNPE6/HPAlTzeSTPlMaosyUjJOMMD83r1Aohf3O
 ulDSvE107lY8R+5SyI74mhAGr7ieWENtk+TkgkJWZu/RH9QDNPemR4fJ+gedLfoevBgdnZTtWpj
 fE1dJir8HVqfa3ecPDXcl58eHeqXAMsJjuYHMrg==
X-Gm-Gg: ASbGnctOdpJpbHyzivK0/GIJwKP5SguXJ3Wgeh2YNYPqyLteb7QJkXCDLMNtEleN5Cj
 BLEAc3emiyEs4mU5mCuk7ED2ClwIkqyfW
X-Google-Smtp-Source: AGHT+IERBq9M3MpFKhqYtLyKFZHN9vkSIk8fKPMx+X42HngSygvhlzjVnk3dc9HvyQqfDBED1FEBFPBF17Y3BSBP20g=
X-Received: by 2002:a05:6402:234d:b0:5d0:cfd0:8816 with SMTP id
 4fb4d7f45d1cf-5d1250094f0mr5165135a12.12.1733433698641; Thu, 05 Dec 2024
 13:21:38 -0800 (PST)
MIME-Version: 1.0
References: <20241201150607.12812-1-richard.henderson@linaro.org>
 <20241201150607.12812-23-richard.henderson@linaro.org>
In-Reply-To: <20241201150607.12812-23-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Dec 2024 21:21:27 +0000
Message-ID: <CAFEAcA-2nA_UYVt+U5hkngxxNEEUmLa6EBkt18v2=zv6PUMMnA@mail.gmail.com>
Subject: Re: [PATCH 22/67] target/arm: Convert FCMP, FCMPE, FCCMP,
 FCCMPE to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Sun, 1 Dec 2024 at 15:17, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-a64.c | 287 +++++++++++++--------------------
>  target/arm/tcg/a64.decode      |   8 +
>  2 files changed, 116 insertions(+), 179 deletions(-)


> +/* FCMP, FCMPE */
> +static bool trans_FCMP(DisasContext *s, arg_FCMP *a)
> +{
> +    int check;
> +
> +    if (a->z && a->rm != 0) {
> +        return false;

We did not check this case before, and the pseudocode in the
Arm ARM doesn't check it either (there's a comment for the rm
field that says "ignored when opc<0> == '1'").

> +    }
> +    check = fp_access_check_scalar_hsd(s, a->esz);
> +    if (check <= 0) {
> +        return check == 0;
> +    }
> +
> +    handle_fp_compare(s, a->esz, a->rn, a->rm, a->z, a->e);
> +    return true;
> +}

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

