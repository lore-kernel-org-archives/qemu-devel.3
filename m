Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF880C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 11:37:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvFD9-0001ip-RP; Fri, 12 Apr 2024 07:36:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rvFD8-0001iJ-A2
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 07:36:50 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rvFD6-0002ak-MH
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 07:36:50 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-56845954ffeso925962a12.2
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 04:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712921806; x=1713526606; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xlMSl6AZxnSBBoc0mH7VbIptvRJGyRHmkjbLnzCBIa8=;
 b=EYb1HF4Aev5dHJG6evPa+DTfPRjjg+eac4fcU9XRC/YFBnRXU1KBe5ctT9uZmraGD0
 Zxc9CsFop6QscdL4LKVKSXNNr/Dny42b26ZyKZPPqQBKvTLi9nq6PkBxde2yMd2HscAE
 Cl4AH9Y7yOR600iZjbTO0Xr/iQGfPmN02MsnHpsunQ4eQQooCz4RHkhBZavtPezpCJPL
 l2ZDSofrwesJeN4+0+jojLmHjU9P/EKYpz5xKR6RJKVcSKsbfXgenLYT3mHKB6yho/6g
 pGxSd3xYwfF8OG/4l+2np2Dj4PfKL47q18TA8S6V1zlK67lYYMiMb1Yr7Nf8oFUw/XCe
 WH5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712921806; x=1713526606;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xlMSl6AZxnSBBoc0mH7VbIptvRJGyRHmkjbLnzCBIa8=;
 b=j1bFE+kFRpxy3E+KWyE6TReqlvJ/r4tXhBm3yxvsbUm1/IJKMlCURoSqshXTXomcqC
 IHrk6sHyS8WpWN1YlgVuWSJwoIoFVizdF5/9ot2R3xmRYmCAbFXS8zdmm8Qu9ORJwtj8
 rnsNSAcwKs4XGIlxuVocYgfdSE4hw7ceytqnQw0odayLc9JgmFBvxNdZsCJWaSusBUAC
 04IkscGRNhru3A3WTGB5U6ufL9ePFdVJz9rfhtA4032RAffmJ7iCGYieoqMqXUzCzS6w
 173GTHfCy7fRRT139H9ZMLGhVJinUBwZRW5fv/+s8fzaR98zR5h9gPA3KF8QyBpNU6LN
 LLNw==
X-Gm-Message-State: AOJu0Yw5QYeoFPHJbW/exYSskIYDGN1HYfoaWmBvGh1kApiaHEMRdZXD
 QvxCx8AxI/+xDgUB0OWgKPjwUg0tq+MYdh52ibknvkLN4cVNjmBAphYdIf8UoX+u+SL7QLDFAFH
 ug+lesbGLMm3cMnhGT4xbS5391/W/5JnGdejfeWNHqIRCvx8I
X-Google-Smtp-Source: AGHT+IEsmza4/8ALqGLoUH0Ya9EYpg22xwYlX4FhRZuAd9BvuTTHg7PsYdrpcH6ATBTmy7ojfQM6S/suuS42dTWAH2k=
X-Received: by 2002:a50:9e84:0:b0:56d:f979:8d82 with SMTP id
 a4-20020a509e84000000b0056df9798d82mr1586037edf.25.1712921806372; Fri, 12 Apr
 2024 04:36:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220620175235.60881-1-richard.henderson@linaro.org>
 <20220620175235.60881-18-richard.henderson@linaro.org>
In-Reply-To: <20220620175235.60881-18-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Apr 2024 12:36:35 +0100
Message-ID: <CAFEAcA8pQ9dZXh1sghqGmuVRubFkn2HQpRnzDSGQpkUSKGg+jA@mail.gmail.com>
Subject: Re: [PATCH v3 17/51] target/arm: Add cpu properties for SME
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Mon, 20 Jun 2022 at 19:08, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Mirror the properties for SVE.  The main difference is
> that any arbitrary set of powers of 2 may be supported,
> and not the stricter constraints that apply to SVE.

> +SME CPU Property Examples
> +-------------------------
> +
> +  1) Disable SME::
> +
> +     $ qemu-system-aarch64 -M virt -cpu max,sme=off
> +
> +  2) Implicitly enable all vector lengths for the ``max`` CPU type::
> +
> +     $ qemu-system-aarch64 -M virt -cpu max
> +
> +  3) Only enable the 256-bit vector length::
> +
> +     $ qemu-system-aarch64 -M virt -cpu max,sme256=on
> +
> +  3) Enable the 256-bit and 1024-bit vector lengths::
> +
> +     $ qemu-system-aarch64 -M virt -cpu max,sme256=on,sme1024=on
> +
> +  4) Disable the 512-bit vector length.  This results in all the other
> +     lengths supported by ``max`` defaulting to enabled
> +     (128, 256, 1024 and 2048)::
> +
> +     $ qemu-system-aarch64 -M virt -cpu max,sve512=off
> +

I just noticed this while I was trying to understand the
SME and SVE property documentation -- the example 4 here
is in the SME property examples section, but it's changing
sve512, not sme512. Is that an error, or intentional? (If the
latter, the explanation could be enlarged upon to say that
it's changing behaviour of the SME vector length by adjusting
the SVE vector length.)

Also, the documentation for the SVE properties uses this
same command line, but it describes the effects differently:

# Disable the 512-bit vector length and all larger vector lengths,
# since 512 is a power-of-two. This results in all the smaller,
# uninitialized lengths (128, 256, and 384) defaulting to enabled:
#
# $ qemu-system-aarch64 -M virt -cpu max,sve512=off

In the SME section we say that all other lengths default
to enabled, but in the SVE section we say that the
smaller lengths default to enabled but the longer
lengths are disabled. Is:
 * the SVE part wrong?
 * the SME part wrong?
 * the behaviour deliberately different for SVE and SME
   vector lengths? (If so, we should say so explicitly to
   highlight that to users).

thanks
-- PMM

