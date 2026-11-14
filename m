Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C77606A32D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Nov 2026 10:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=vpUWzyTn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSBGU-0006aI-Kp; Sat, 14 Nov 2026 05:45:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSBGP-0006Zj-Tq
 for qemu-devel@nongnu.org; Sat, 14 Nov 2026 05:45:44 -0500
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSBGO-0007sB-8J
 for qemu-devel@nongnu.org; Sat, 14 Nov 2026 05:45:41 -0500
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-8b30cbfa628so17508577b3.0
 for <qemu-devel@nongnu.org>; Sat, 14 Nov 2026 02:45:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794653139; cv=none;
 d=google.com; s=arc-20260327;
 b=qJCaDg1pXSjF86rp7AbruwSprV/R6tMgBXHsRARnk5e8qf+ogSx9LbuoZlGxU62BdU
 XtXHx6nu6mxQkJA9fJ/rpqZ3aYmj1e9Qwqdoh9lgwcuqp+u8BwlSaqn2ujQB680uTxoz
 gqkUmX0EPou+cuwgkXys0iaelIXMM52S7siKiWKGifN17t4yW8TYln8swS4DbqPlK9/z
 IP5H7OxCZuguFaAZ58Pkpo0Efp4Cdow8VJioRQneMLVR5OG7Q8Zqmv/ErF11QyOIL8G6
 RBm25Xe8cshp+vr+5oZy/7wi2nbAwTxvQ7j2og0Dk5PoAcRA+zley56Sfw3mA2e8z1b9
 kZHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=mQhgN+bEJ/PhZv1zLU1AK+NRBSksnItZvWKkrjNq77c=;
 fh=cZq8+PZX9mZ0CNUlZn00efHaXK+Wru5ujmQGz4miGwk=;
 b=eCycsyEWF4SEVOZSmzA0ibkMDrxLYZgXtuejo6mF7ctz44VWBq1h0cnwSZNf4Qa2Wu
 /qtTC7lAin/VAHG/2rqGKsfCCe3p5ij8bAXJc7HG6Nma9n0PWAIzO7Hh5PaE6uCZGXBU
 62euklcsdhj83i7v4YxggnTEXEZghOmvzX8gXKx2wxr7wvIKytru912221RxZVNfwqIf
 29xgwC+F+Bf+dziB6ovUF7E1gIuTPhj7DNlUNoUIjr9XHVsuMjwye3ZBfBYWYfb+pE2D
 MvXh6El8/d3D6GILT6OqNaheH6Rxr9G3fn6oqzoT7ZEjGRPJOcs/zRWhMdiyrOAYBOBD
 osnw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794653139; x=1795257939; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=mQhgN+bEJ/PhZv1zLU1AK+NRBSksnItZvWKkrjNq77c=;
 b=vpUWzyTnqNG3rovI/0pQndI1ZwY2KP9rX01xTcJm9gLLpzLbzr6lpOCu7M3RvvolwW
 fP6nqsSVhT47TC07fxeBNGbiqMhhwLHlj+JwWyiyNpxag/j6QP/Hrv2/7AcWeBZi0gK8
 dh/UTMOYl814gwrCmKr2TMKJDkGCQM+B8HEuDjiedX7pmEK9+r0OO+bxx5SgrAkiG6MV
 ChwsxnAM9cQelsvqG89hlXYWzDWWlYeuh3rHj886ytyTECZsxsrK4WFE86NA91joF5O1
 OYyLq8m8A4XssLIesj6e1P1tXkhIpF49HC3xmK2+xr5ZKkXXUGYqkCgzuA5ybIVq6qW/
 jiWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794653139; x=1795257939;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=mQhgN+bEJ/PhZv1zLU1AK+NRBSksnItZvWKkrjNq77c=;
 b=1HoX6QY9YxIXWJVENirvyX9GqnuIrLOoP7yzWJTZT3fIoNoeqZWIxexvCZG59ic2DH
 h7YDn+4YyVto0Rng1AckMu/jDvVzWQ30fAxDu1B/xDDoPMouW7XVY4DZeuw8BRwwJHVW
 k0qjafra2xmfLeMPGPG1SZ8RBevK0EwIKIzHoQlB0oxaxwML7vGi8Nzw6rP+yrE8N4Ce
 jdhLvqIBIiTFmozTdUlPd9kZwGjUggFzil8DNmOwUtrXrHwZQVGQHDhZBFAkOJKMQb5B
 c98cOiy03MGW6N4ugW5qyCUfqxcF/YrLLzDXkGS3reokXO2YSuw3xce4xmLjK3rwLwYi
 ZgPg==
X-Gm-Message-State: APuU4Z8eShD73egU/EU9hWvVqkw2Y0xAMvtMINOzORBE8ZG8Ed88JcPT
 QiB8QaqqBAWsy0xrzvP9FV0T0gm4/OPpOAyE300gTr/+KFr/RRbTWuH7BbMWFsRX48y+0U39OE1
 L5ZGSi/QzQY4Mz+m96/qcS4NT+a3jHw37EP6jM0k1yA==
X-Gm-Gg: AYBFou3Q8wXXuhMAVsFlqDxtbbdNol1L3h2EQfW7dSpz3lsyskJkLEG0UtrGyQaHzE3
 vjzUSqvsFDiKwQvp7+6XHbb8dRmVEXos9WbJduNyv9uJ8xr9jf651gOrug4QbfNv8p83FaN1poO
 kNXbI+K3rfr73QYFw2yl+32NEE/UIy2MzNm3kLK0wlO/1EpcWdY7XsME2ME0oiZYnGco3YwKyxB
 05UWW6glwYXBHElM5//rdyqpZ9VfMeS66FqjxFXwQ3aKeGdISM51p+bPGyK9Y+nO1V7410ul3Qf
 TAHPO5COYmkYN/+P6khmo8SgbXmLMjGh3VrMsl+J8Bp24i4aIEtlgZ3vsoSRbpN6nx53gLjJhAX
 RtylA5jfBRn9DQlyE8jApWg04hD+lMmfX0bRSBdoZgDEpWO+MibgG4KzCdiRl9ivGFiVo9hgcHF
 GEJ9RW0KwaK6TvxU3uphuR7eKOvN6RdlmXXs4whouG5g==
X-Received: by 2002:a05:690e:1287:b0:67d:a096:d8b7 with SMTP id
 956f58d0204a3-67da096daffmr547457d50.3.1794653138400; Sat, 14 Nov 2026
 02:45:38 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261114-rust-single-bit-v1-1-da0172820f84@rfc1149.net>
In-Reply-To: <20261114-rust-single-bit-v1-1-da0172820f84@rfc1149.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 14 Nov 2026 10:45:26 +0000
X-Gm-Features: AclHuK845J52encpOGbgsrGP27dHbOSjqDEwDDgdmBHKAe9IAWK5eD_KFPv3G84
Message-ID: <CAFEAcA_itbkwQjXUwnmXXvP8doeUGE_uEP16XA4XeL1DWgs1+A@mail.gmail.com>
Subject: Re: [PATCH] rust/common: rename IntegerExt::bit() to single_bit()
To: Samuel Tardieu <sam@rfc1149.net>
Cc: qemu-devel@nongnu.org, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, 14 Nov 2026 at 10:02, Samuel Tardieu <sam@rfc1149.net> wrote:
>
> An experimental Rust nightly feature `get_set_bit` introduces a `bit()`
> method on integer types which checks whether a specific bit is set. This
> clashes with QEMU's `IntegerExt::bit()` associated function which
> returns an integer with one particular bit set.
>
> While the `get_set_bit` feature has no planned stabilization date yet,
> this is reported as a `unstable_name_collisions` warning when compiling
> with the `strict_rust_lints` option, and warnings are turned into errors.
> Renaming `IntegerExt::bit()` to `IntegerExt::single_bit()` prevents this.
>
> Signed-off-by: Samuel Tardieu <sam@rfc1149.net>

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4842

thanks
-- PMM

