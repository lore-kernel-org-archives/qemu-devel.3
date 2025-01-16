Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51389C02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 15:38:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYRwc-0008RF-T8; Thu, 16 Jan 2025 10:38:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tYRwb-0008Qx-6g
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 10:38:05 -0500
Received: from mail-yb1-xb33.google.com ([2607:f8b0:4864:20::b33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tYRwZ-0003ob-FU
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 10:38:04 -0500
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e53ef7462b6so1796330276.3
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 07:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737041882; x=1737646682; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=N8gI4Kd23GMMy2alKO7+e1+aylMJ0yDvYzx+TXuj6L8=;
 b=lcMrL9kiC43vRvUqWAQMVYX/xiezmKAQpRMKsX6lGBKPZ7h/cG4SWlqOU4f3Fb+MNO
 KgFWeniWJYO45H3405bu7NLsgAag/YijyvRy1a1zUfbv0jrzj/W+/52z4WCrLpeFEiLv
 S952BO13XFsQwbbuQL9kMbsA/1Qmbe+36jcO8enSowshbo9DdjjzgOaci2UE2XgZVA51
 aeJqwRL3YlKbmans7Eab2N41mxUs9bFP0XxOKoBr01B46dPf+hK9dYlb9Gydj7TtdHLG
 CdeKubwbR7oXGOdT8ZXN9vzpa2hgw94fDRAIvboONC3XdpBkR6kBTXGTJxiM/uBMDfyB
 K8aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737041882; x=1737646682;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N8gI4Kd23GMMy2alKO7+e1+aylMJ0yDvYzx+TXuj6L8=;
 b=NMMu0307rgt+TrNxX82arNGK8Ov0QwXzmduEm4Pw9Vo7IqFjbf57tCdLVlDPKs2jIj
 rm0EvmZcrKuh1B6Uq9+WKjspr6vUwMIM5S0LBXM0WXgL1k4bE+1HsC0lt3cMOUK/hBtg
 1TLz6mdVQ3Wk4AgZuEhd3zmJ+bD3gJLzaD3dAbi5ItXv/Ub4n4oLQq13jm0IgSnznbX6
 HESbl6/GHkYtOcvPjJ2Be7iGTPxaAtFfc0F5jI34elTvVma2KMEafhFUEYyTmSZVgU7P
 FYOegw0YghdJEpFnyRX/t96STyuZrAukBxRBE3D6Cdpyew5n3kXsGf1JrNYauFfKpMsY
 OeIg==
X-Gm-Message-State: AOJu0Yx9vIK01bc7xUQGgEII1pi0nbT1GSiEp6SeMOKgftts+ChiSjjX
 t1bpvJh1y7LiGXOmtCEv45vHuGbUC3Zc8XcCTujkGAEiZx5rc7onk8FnVQU7anAo7BGCRvQl3D/
 55ffjZK6KtvrOQWzoUSkvsFzb4qN7bNfaRn0DoA==
X-Gm-Gg: ASbGncvq+fWLznwz2l5+BNmUNIM1Zql6azma9G3ILwvue5zD1t//7xX2jTyTIfFUiUR
 3I1qTBY2QTY1GSjbh3roN7590xN3peVXb44HIwWc=
X-Google-Smtp-Source: AGHT+IEnUxoNS98D0AwX8IFuaxG1CUzO8PGEZ5StOGuPKkZfHXO0PikxX2KNinFd1rCtHrqpYYL4rjkcxp07SV2HdWs=
X-Received: by 2002:a05:690c:7013:b0:6ef:48ac:9d21 with SMTP id
 00721157ae682-6f53125e6damr295535857b3.24.1737041882364; Thu, 16 Jan 2025
 07:38:02 -0800 (PST)
MIME-Version: 1.0
References: <20250116112536.4117889-1-peter.maydell@linaro.org>
 <20250116112536.4117889-2-peter.maydell@linaro.org>
 <7f645bf5-3d57-4803-a937-f8e558391e8d@linaro.org>
In-Reply-To: <7f645bf5-3d57-4803-a937-f8e558391e8d@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Jan 2025 15:37:50 +0000
X-Gm-Features: AbW1kvaJiyQEhVcLHqBNBH4q_BzyqAo0c0t7kWu6nfmvnAf6TR9i9Ho9T0ZEoSo
Message-ID: <CAFEAcA82PzzhiaK34E74oy9OekJQ+385-KcWubGPzaRP+p4FxA@mail.gmail.com>
Subject: Re: [PATCH 1/2] target/i386: Do not raise Invalid for 0 * Inf + QNaN
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b33;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb33.google.com
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

On Thu, 16 Jan 2025 at 15:22, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 1/16/25 03:25, Peter Maydell wrote:
> > In commit 8adcff4ae7 ("fpu: handle raising Invalid for infzero in
> > pick_nan_muladd") we changed the handling of 0 * Inf + QNaN to always
> > raise the Invalid exception regardless of target architecture.  (This
> > was a change affecting hppa, i386, sh4 and tricore.) However, this
> > was incorrect for i386, which documents in the SDM section 14.5.2
> > that for the 0 * Inf + NaN case that it will only raise the Invalid
> > exception when the input is an SNaN.  (This is permitted by the IEEE
> > 754-2008 specification, which documents that whether we raise Invalid
> > for 0 * Inf + QNaN is implementation defined.)
> >
> > Adjust the softfloat pick_nan_muladd code to allow the target to
> > suppress the raising of Invalid for the inf * zero + NaN case (as an
> > extra flag orthogonal to its choice for when to use the default NaN),
> > and enable that for x86.
> >
> > We do not revert here the behaviour change for hppa, sh4 or tricore:
> >   * The sh4 manual is clear that it should signal Invalid
> >   * The tricore manual is a bit vague but doesn't say it shouldn't
> >   * The hppa manual doesn't talk about fused multiply-add corner
> >     cases at all
> >
> > Cc: qemu-stable@nongnu.org
> > Fixes: 8adcff4ae7 (""fpu: handle raising Invalid for infzero in pick_nan_muladd")
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >   include/fpu/softfloat-types.h | 16 +++++++++++++---
> >   target/i386/tcg/fpu_helper.c  |  5 ++++-
> >   fpu/softfloat-parts.c.inc     |  5 +++--
> >   3 files changed, 20 insertions(+), 6 deletions(-)
> >
> > diff --git a/include/fpu/softfloat-types.h b/include/fpu/softfloat-types.h
> > index 9d37cdfaa8e..c51b2a5b3de 100644
> > --- a/include/fpu/softfloat-types.h
> > +++ b/include/fpu/softfloat-types.h
> > @@ -278,11 +278,21 @@ typedef enum __attribute__((__packed__)) {
> >       /* No propagation rule specified */
> >       float_infzeronan_none = 0,
> >       /* Result is never the default NaN (so always the input NaN) */
> > -    float_infzeronan_dnan_never,
> > +    float_infzeronan_dnan_never = 1,
> >       /* Result is always the default NaN */
> > -    float_infzeronan_dnan_always,
> > +    float_infzeronan_dnan_always = 2,
> >       /* Result is the default NaN if the input NaN is quiet */
> > -    float_infzeronan_dnan_if_qnan,
> > +    float_infzeronan_dnan_if_qnan = 3,
> > +    /*
> > +     * Don't raise Invalid for 0 * Inf + NaN. Default is to raise.
> > +     * IEEE 754-2008 section 7.2 makes it implementation defined whether
> > +     * 0 * Inf + QNaN raises Invalid or not. Note that 0 * Inf + SNaN will
> > +     * raise the Invalid flag for the SNaN anyway.
> > +     *
> > +     * This is a flag which can be ORed in with any of the above
> > +     * DNaN behaviour options.
> > +     */
> > +    float_infzeronan_suppress_invalid = (1 << 7),
>
> Why 128 and not 4?

I wanted to leave space for adding possible future
values to the dnan options without having to renumber
the suppress_invalid flag. So I put it at the top of
an 8 bit value. But I can use 4 if you prefer.

thanks
-- PMM

