Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 384BBE77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 13:20:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJYFV-0003eV-6H; Fri, 06 Dec 2024 08:20:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJYFL-0003Yg-NI
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 08:19:52 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJYFK-00089I-8X
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 08:19:51 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5d3d2a30afcso432280a12.3
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 05:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733491188; x=1734095988; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=J8W6Yx1kiMK6OyXVZVjPdT943ho4eigo5ojsBCAKRe4=;
 b=sDic+n8E+F2uaN73pvWcKjCLXCTH9ehtsnkZAlC3Qo1Go5rDxJc2TqVADh6sy3SKnY
 k8MjNYbUK3O/yweIKnp4zNJdhlLxYR/QzTRE73OKg6XR28VDGP/iXN7uJUifMxe6DatF
 C6b+S+gMCTFEKnKotiv/6W9XnmTBvk/IpU12hFxoW7zubmxN2il3aDdYgB1r5qSSZQu6
 2x4SRR85huYshk77J+ZWHdoxOIdReqdqRFtNlkwTSmNfC6giE+iys8w/cm0FbnelomlE
 2uJRuxlVFRMVlhE+Lbjx0c8LzdUcLfBH4TS2LKyk836mh+sxcIorfiVBXtScztQ7adQ9
 0+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733491188; x=1734095988;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J8W6Yx1kiMK6OyXVZVjPdT943ho4eigo5ojsBCAKRe4=;
 b=hvSPsd2a+BlCfrj6eZ0sGbcQu//J2pDi5C0d8eCN/oAYifLh+5k8pIUz9pK5+21eX7
 NFRs1lYNNS5XNvB6Ot/UbNOp7l3NexZ4sFg4X58NqW6kza8CW8u9pPpWm8vTlxOnxjSv
 GEalbzE2VX6jUphuQZ6Mwm4SO/ELgATlb2FCW4x4UvcvXcMIivXbRfD1QDDnhyasbd9V
 an3QYExgsyEe1TkKWrhOSuHv1kgI3l2wOCdTAaV0jxZk6a5Z6sfDSnALhHLa19GajXQg
 tR4mhHNJs7vKnFDcjFcw9ozGvFdJVLRDCcukHM/sL+XMjgXuSVBIRgvkEpGWB25qWKm1
 pNsg==
X-Gm-Message-State: AOJu0YySyOo2jDB/JoAreLnisF13wZdLc339BNMtB2zNhqPtoV18zAAs
 efD0AMuKMuqSzzrMCGH6P+xeAdr5dYep5ZueaMyq/HKzfe7a0xRT8iDVp1ueL6rNFldInm2pxvJ
 kOaf2lESHCVTMzNcOcxHzR9CY9o3ZK5Mzu6TMqQ==
X-Gm-Gg: ASbGncsyMKZMYxNegzsAALYh+ypBc4q7R/YE3q+Paqs7mWBQmGdJm6Bw21xuPPZUpyY
 ewbqKADkzo6r2uekDhMa+oo+fgVKaqrAu
X-Google-Smtp-Source: AGHT+IEj1ErTBb+fCLDXyG/0x8QArRILHncsgPB3J16vKswDQqPMBubQSWSrE+IXkiVrqO3S6uT/JdDdtOWBd45u3Qc=
X-Received: by 2002:a05:6402:3906:b0:5cf:924f:9968 with SMTP id
 4fb4d7f45d1cf-5d3be661c03mr2503267a12.2.1733491187651; Fri, 06 Dec 2024
 05:19:47 -0800 (PST)
MIME-Version: 1.0
References: <20241201150607.12812-1-richard.henderson@linaro.org>
 <20241201150607.12812-27-richard.henderson@linaro.org>
In-Reply-To: <20241201150607.12812-27-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Dec 2024 13:19:36 +0000
Message-ID: <CAFEAcA8ZXozpg8pJMmmDdpF6_FuoVr0JA=Ay=UXkBGbnZvKMeg@mail.gmail.com>
Subject: Re: [PATCH 26/67] target/arm: Convert FSQRT (scalar) to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Sun, 1 Dec 2024 at 15:14, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-a64.c | 70 +++++++++++++++++++++++++++++-----
>  target/arm/tcg/a64.decode      |  1 +
>  2 files changed, 61 insertions(+), 10 deletions(-)

Other than the missing code in the old decoder mentioned
on the comments on the earlier patch,
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

