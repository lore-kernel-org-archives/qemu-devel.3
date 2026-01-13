Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FA62D2D0E0
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 12:04:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfcpn-0002K9-No; Tue, 13 Jan 2026 06:45:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vfcpg-0002B7-Kz
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 06:45:10 -0500
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vfcpe-0004Xj-GX
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 06:45:08 -0500
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-6481bd1763bso1718573d50.3
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 03:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768304704; x=1768909504; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=x5kDEZsBFQj58k4xDgqxo80bH9wUMwtSGK2v0IwCw+Q=;
 b=BZDuXtxGZ94GkOBQyBDmE27zZbXnEjB9YkbsdVTyWKcr2tjgDdKlXSsepgAekC1vmc
 rzfX6Qj5MlwbzXJqLxhca5B9gkFRBB2BubCcSQ6HC7/Z9ohWKsZUES42UvEJSG5oPZT6
 ypyTDcUwtPWSUZ8M/23YUqXRffIjfRIn1fpTSWbvp6pqbsd+3B+ZvJiKZU/E4wcdBBKY
 EmS/V7c6cigglGwOHFkX5KTXQeuozS6LEKQVaAgTAIRdtQu+TZiZteIjYHA23dQiQezP
 yw9UFVdoWMPXQydc7hr6Tj0PdzuDY/9RRndv/7QrnVbZ+bZqfkEDBqkib8UCD7OQHkTe
 0RIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768304704; x=1768909504;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x5kDEZsBFQj58k4xDgqxo80bH9wUMwtSGK2v0IwCw+Q=;
 b=tdlfdGABW92A5FGMFdWFiUioi0kcAQwt5qVhVvKqT/bL9mOs/xNuSK/n8oO07M6sET
 5bVGUxEcrjLMmgB4MGDXtFBXEOzHDh3rUqQ37z0Tzrd9JzXmPYmCCcUwt6yviEuE+Cz2
 uXV4bM/srzpR1MXgttuAvQmdyzR7r3Gr6cSntw7KiHGgFawmUDYVzOAifheLyXklgmwn
 QkSdJ7FOfCBySq/P0xkbE77f3nlNKdfpLNJ/EsMy9fgnnZYswU2GWH4tTmpsuT4mMqDF
 tRBkdbSNEbWoTg9h+HDWyEe/6+mxu28cd2iID77B1Wuzp9cv/znnoMlvVANU0Hm9+ibV
 6RIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3Fx1BcQlu51MKSy6qWGwb6iPTdwEPMRwmev9dB80Ar1Mdx+SukgZH5u8glnwM+1PIQ2eFDRF5ZP/Q@nongnu.org
X-Gm-Message-State: AOJu0YxqoNtMwauv58MOqHc2TZLa0ayJG24LsOdo3w1Nl2D6MvSdxvXk
 nCkBjUd+/l+xlkjx8FCZceG+/kUBX9cnPxO5ApsxA+Ft72X13hSMYxq2SWQTTyJ5qm1FVZ6+vUA
 UMXf9Xn6YbpiwdrfZQlAtfYpda3kdL/RrPocn2Id3jA==
X-Gm-Gg: AY/fxX440OaxRX92lzNLyXK5d2hezGqiQXD3PS0c/Q3BhWe+as2e0HlVx2GTxrLUcuA
 BOIpbaQI5wbYi1A1xEae/yTeOMMLd4o6l0GD12ZO0vWUm6RgdjkK65yv3ftWUApIHqP6yVF9CHx
 82nSP3Z1HfPSDFDIjet/NbXMs4Si6JDkNB7eVVO9kZ3zreAet2u5gr26eMvtZKORqzTC8PeXyPX
 EDDE3uakrhB/ML1OUuF13wxBmL5AwDmnXer7mAGdlCXVNGjeIJy2Segr1XuDBZ/XNpxH70a3hld
 HLCzvpEOVMg0RY4VZH9KglimXjhgUFWtsw==
X-Google-Smtp-Source: AGHT+IFLRixFDSddg7EmQ2fBtNlahjHJyXttItSrP/bg2svxQdAfgVWbRGhDFcktB+Nu4OFTD+v2f8sS8l7slPHfB5I=
X-Received: by 2002:a05:690e:1202:b0:645:54a9:11b6 with SMTP id
 956f58d0204a3-64716c67c2bmr18278694d50.52.1768304703557; Tue, 13 Jan 2026
 03:45:03 -0800 (PST)
MIME-Version: 1.0
References: <cover.1767716928.git.mchehab+huawei@kernel.org>
In-Reply-To: <cover.1767716928.git.mchehab+huawei@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Jan 2026 11:44:51 +0000
X-Gm-Features: AZwV_Qjn_uomAbjDzC7FqJqaUHy-GWOaZMHxNy3xOaFVTEcDja82UYRRJbNjGQE
Message-ID: <CAFEAcA_TMuZG8VJMs2JZ49Xq+wVxcq_7UGOMF+2FUe0k7AUgwA@mail.gmail.com>
Subject: Re: [PATCH 0/1] Sync kernel-doc.py with Linux upstream
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 John Snow <jsnow@redhat.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, qemu-arm@nongnu.org, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 6 Jan 2026 at 16:38, Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> Hi Peter/John,
>
> There were several updates at kernel-doc upstream fixing bugs,
> doing cleanups and a couple of improvements.
>
> Better to keep QEMU in sync with such changes.
>
> Worth mentioning that we did some changes on Linux at the
> kernel-doc.py script itself, to avoid Kernel build to crash
> with too old Python versions, as there docs build is a
> separate target, and python >= 3.6 is a new requirement
> there.
>
> On kernel, if python < 3.6, it will simply ignore docs
> build (emitting a warning).
>
> I opted to not backport such changes, but if you prefer
> doing that, I can do that on a v2.
> ---
>
> For now, I opted to keep kernel-doc libraries at the same
> directory as before - e.g. at scripts/lib/kdoc. On Linux,
> we ended moving it to tools/lib/python/kdoc. It could make
> sense to move it on QEMU too, as it makes a little bit
> easier to keep things in sync.
>
> What do you think?

Hi; thanks for doing this backport. I checked that the output
with this patch applied is still the same as with the old
kernel-doc, and eyeballed the diffs between our kernel-doc
and the Linux version, to confirm that we have kept our two
minor QEMU-specific modifications and haven't missed anything
from Linux's version that we ought to have. So:

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

On your two questions:

(1) As Dan says, QEMU already enforces a new enough
Python version, so we don't need to handle 3.6. I think
the main thing driving a choice to backport or not those
changes would be simply keeping in sync with Linux's
version of the script so we don't diverge. We want to
make future re-syncing of the script as easy as possible.

(2) Regarding the location of the kernel-doc libraries:
we seem to have two things here, possibly in tension:
 - we don't want to gratuitously diverge from Linux
 - QEMU's directory hierarchy is not the kernel's

In particular, I'm not sure tools/ is where we would
naturally put python libraries used during the build
process. Maybe that would be python/ for us, but I defer
to John or another Python expert on that.

Hopefully this would not be a major divergence because it
would just be "our python path happens to be different
from the one the kernel uses, but the actual python code
just imports the modules by name and doesn't need to know
their specific path" ?

Personally I am OK with our taking this patch as-is
and dealing with the above questions (or not) as a
followon thing, if nobody has any objections to that
approach.

thanks
-- PMM

