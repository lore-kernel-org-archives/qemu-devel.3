Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42662606A326
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 10:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=cNtyfD+O
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNotL-0004Lu-Ke; Mon, 02 Nov 2026 05:03:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNotG-0004LB-4l
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 05:03:49 -0500
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNotE-0004T8-DB
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 05:03:45 -0500
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-8ac8a2ac52bso30228767b3.0
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 02:03:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793613823; cv=none;
 d=google.com; s=arc-20260327;
 b=jw/a8FUdMEHwyiQwXv8KqFaQlRtwT2ihIkr63PAEtUZnNEzpydRqkO/Fj+7GYeSlbK
 aingUI4YO1l2H3lGM7+6vSS85UdaYUjaD8Qiugv2o9/cSyis0+oW7kvJEqk+v6q1NNM8
 b6BeDxKK/nNneoqyJC8Bzc8bZlj5YB0B0fLrsqgQgklGYL7eNldDbebLx41fy9uzJJSZ
 Aa1Iuef1uFR+s0PPbSE3OPN4turU7rSV7c9Xwaf5fKZ3Tnk+WwNrkrF+k1b5q0sbBrJt
 Ctdt0Jy62xG+5L7kdJrYJqpDZLn0qaWMRvV6JKiuMuU/2i0RRdBVhuOSzTZH/hKZnrXj
 TMOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=3PCeyUgACBxkxGIdjbwMbxKtQcw67ovdML6Bm60fRd4=;
 fh=ikMnCkeOFDczlmlrj35Nqs3WCGpjSjzFMkMvSNdb+rA=;
 b=eRkC+yBFntEPLEg6vvPL6YxAP0YtAQTtjIuIm7XgkDTMt84gWQZmJus8wFNR9TbKQB
 Cn4erY99laK6RJcV9CMU+QlVTHQU9R4yBfJ8pAceMstcmnVzq6qsh+ghUvXAaSnSzLrj
 gickP1+z0F7yZYDZW2ObPpf4OakBV+CNqdehZrVm5eU29V4DUQ08AUIg89y6BUQCAHpc
 nK1J29B6sHSRY7sIRn4QclzxIBU/+l++hylgg/382WwwBvs9JmIpAZ0mBdP/+mQIZqIQ
 IWcVaGjPW1sLMmXUI8Am7ApLH12jTVjLqX0iHYsfzgO3LYBwzA1VAr8WwuqQ4ez6twtd
 ggZg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793613823; x=1794218623; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=3PCeyUgACBxkxGIdjbwMbxKtQcw67ovdML6Bm60fRd4=;
 b=cNtyfD+OrsCN9yw5zzo8BxZqeW/5Qo0kSCzqE2bhdKJxihuTFPYDAx7si6PapneD2n
 GfRY3kCbj38VSlu782Ozd9hPDFZjM/D5CczUgWGbnyDGcKs0Ku2ML1snFxb4Po6X4TKc
 nx6Z3mN5yIczW8r3ynQLTC7JFjZieSBj4UY9HjKCIrFxcIELMlJwdSQTlkuPdEdnO3iu
 uZYjL3siNCHXvSnQ9p5eOs7hwGVb3LXEECKQGuOTVw9PbTIVQcCJtyTJw8Cw7dawSLf1
 M5P1wlnlRXn0RYNRNOpJ7PTvZde7TeONg/ACfi2RdW7g1yPbcGdW1RA/CeKzVA2LaxPR
 8rcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793613823; x=1794218623;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=3PCeyUgACBxkxGIdjbwMbxKtQcw67ovdML6Bm60fRd4=;
 b=09K3czWewgkjksMoFINgbmTeja5v4Fhhes+m+CjUD4zMXwUB7KYDZKMAuBIMRaGLPK
 Xa6vELjBXUn2g2MDCplzcDKZyLSGH7A1GZ3EY3WjteDJERbkqoNTfxE9p7vJc9toiLw3
 xzvEGzbPtEoHicLJVW6aN/NLlsqHmn+5MJ1/y83vC3GRcAi0GBNJClz2vHnwC5dD8Ako
 JQQkaZBfYWB0EPK1z2cME85U77lFNc9QJyV1lu4xz79VDoE5KxUv/E9zWZBrC+coht5N
 xRfjI+P+YlCIXnlZUbJVN5v3w7AtE14FjfMAoMjerbme7+HzJkdIeNCgBBj+HAtLFfq4
 A7xQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwfIB7GYlpowTvtdVETEOJPQkRDMTrXCNcbqQ9219NjYDJb+4j+1qAWAgGET39ZulpfmqHPBDsl2izw@nongnu.org
X-Gm-Message-State: APuU4Z+eBsX49h34YI1E5R+g4ZsdWo4Byq26iVv5pT9DdJlQ1KhiVbJ+
 mmjpaimlozezWLi3AVxZq1b9LCBrJpiK1cHO2LttV8bCdxRzYqHZetIaxzkO7Yme4pBprUWBS+p
 lrLHMfRhKzIWvXE5K35dw6rpql5CLvPT1W+RTmDZ+UQ==
X-Gm-Gg: AYBFou0POiZJkW1D5Ikm2JR7mhuQDHm6coU+c9AswwvfQ1QczdKRfqLc7EitK+Ijz7P
 eVmt4qtJ5/w4LI/3qClp6bo/wmD3e4pargdv8GEjVmgDY+GD7t832YdBllUNg59ur4Gt8EWmWWq
 vCRqWJpQP/cCMp89M4yUxEKYehahzU3JOBLXzQO1nmF9Jikviqq7WWlHkYM/jzKAN7AdfQs5o4G
 NXQmSiG2e8vju9ZUJDwA4T2ZxJ0c67dVDaL+OKvAQYDLjKixCEeDiXqdcD/5SEpkqf9uy6KF2nl
 rcc/PID0czXiebGBMTRmfjFBrHRvwd1DqoQcDiYMMzGxVVt2/qqdcUVKg0nY9au3ja4d9+y6SgS
 EC1BGBsznqK5+59ep0sbxhTHHWnBaWad7ldmx5sUfpGJhLX3fKtGpwU+66/5WqLspftvM8SDQH4
 RwIjmLIRp3SDvVuVtBrdnI
X-Received: by 2002:a05:690c:6e84:b0:887:b388:9911 with SMTP id
 00721157ae682-8b2b66ce121mr70477897b3.8.1793613822903; Mon, 02 Nov 2026
 02:03:42 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261030143435.57230-1-sebott@redhat.com>
In-Reply-To: <20261030143435.57230-1-sebott@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Nov 2026 10:03:31 +0000
X-Gm-Features: AclHuK-ntKtbrUXsA6sy08LZBiwA6VtDa1QqbGDeYu0mVRQrRnRISWbkHGj_j_0
Message-ID: <CAFEAcA8aRV9TSQZ_Czj+5cZ7=frq7uQG4yuk9H414wBUKiyxtA@mail.gmail.com>
Subject: Re: [PATCH 0/2] target/arm/cpu64: migration tolerance for PMMIR_EL1
To: Sebastian Ott <sebott@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 30 Oct 2026 at 14:34, Sebastian Ott <sebott@redhat.com> wrote:
>
> PMMIR_EL1 is exposed from Linux v7.3 onwards. Backward migration
> to an older kernel would fail without cpreg migration tolerance
> definition for this register. Fix a couple of typos while at it.
>
> Sebastian Ott (2):
>   target/arm/cpu64: fix typos in kvm_arm_set_cpreg_mig_tolerances()
>   target/arm/cpu64: Define cpreg migration tolerance for PMMIR_EL1
>
>  target/arm/cpu64.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>



Applied to target-arm.next, thanks.

-- PMM

