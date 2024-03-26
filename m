Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7995CD11DD
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 12:40:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp66W-0005Vc-5s; Tue, 26 Mar 2024 08:40:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rp66R-0005UD-RF
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 08:40:32 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rp66Q-0001qt-5E
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 08:40:31 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5684db9147dso6347529a12.2
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 05:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711456827; x=1712061627; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=M3UGHtJmOYdUAhi5t1BRB9hvcswDptE9pAC7zQpBEQA=;
 b=DhthijxFdL0XZQO0vhvONRijUvsLJ2Uc3dpsSeuLGQY964vLQ6I4wBU4f1mkU6/1eT
 HATNegLLLfi3E69D9B9Y6YPAATVXhagb380LCBhpSFs00p00KlDwH7od+QHKpI6MzPlx
 3XLlNd9ZM4KiGnd4BsniRYqTkVDaH3N85gpK+ferXRvjNA1fNZUAcq3y9w6PU7ssAWaQ
 m0Xp1Hkue1qaq+A+zTbRRB2itrpcPn0Dccm0w3ocI6wq5I9qjUfARXJbEtt5ebDmQPIb
 Vp+PSZaRfeH/ODtAhNzqiHNeL3l9XNJJyQw9QDO8rQiT1PgqPxipejqQgiKBeruGF8TN
 IyWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711456827; x=1712061627;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M3UGHtJmOYdUAhi5t1BRB9hvcswDptE9pAC7zQpBEQA=;
 b=h5AOvXSlPStBE7Xs7mf6rU52R6+s/A84VIh+QxXoBaDnwWypY5PBlfTFfh9ldXBUux
 g74sAlOtHynuaFz3vm0IePvcUKlGYXJaC/C7ZgmXbYXYik5anmCuz3+IPp0ce/AgDCoO
 Lt0ng7Y8fD2/zSsD8Ob05UolenOBYeRxktg5Qskb7P/hIUL7lq1Se8pVXIN1WoS0PQRd
 ibMaIcjvjqKV/IKxOi1vBjV88I6wSRzKg6+bzZwOYzJFlNf0TjTyF5x6RbvNZhzlw/Bq
 e2Iimrcfn/ki0bTeqJ3g4FaIyqheHIRpdT5p68gDF9IxAV5mxUsLKwNJHWnNh3FBj15F
 /Tbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwdMZsyEhwcqiooA8lETr/y8+3uwnNZxm/EZp+5J4+QKmb8dSJ7Hj1+8z66Ew94PrcWc421yFlLDUJSNjUQjM0xXfjCto=
X-Gm-Message-State: AOJu0YyeB2eslsGXOQqoHCCzAgrKgjSKGyha4NOzNsy6M8xz8mK1vE9V
 JjaqpRW4UzaMavRhAPE7FfyVZAXb2bVMSYskf/TfvubuLPGqLSqmXZ+gx/N3QCMQJ01mFbQf5cT
 gEq3tIBAXZ64lsgZ+aQhVDnBjim1FC9X+L+suwQ==
X-Google-Smtp-Source: AGHT+IFxr6/Eic3/zTKR/CCsHPeSz0BOal6hN/adaX6bW0CZtZopfMP4CC30YUCnSS2g+UouMOf8ku1RA3dIsP52qTs=
X-Received: by 2002:a50:d5c5:0:b0:56b:8f6d:8a99 with SMTP id
 g5-20020a50d5c5000000b0056b8f6d8a99mr823495edj.22.1711456827553; Tue, 26 Mar
 2024 05:40:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240326-meson-v2-0-d9f9003775e9@daynix.com>
 <20240326-meson-v2-1-d9f9003775e9@daynix.com>
In-Reply-To: <20240326-meson-v2-1-d9f9003775e9@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Mar 2024 12:40:16 +0000
Message-ID: <CAFEAcA8JF35A5o-+F39sXFnkTDnPo29A7zCZgxFPt3388sVvig@mail.gmail.com>
Subject: Re: [PATCH for 9.1 v2 1/2] buildsys: Bump known good meson version to
 v1.4.0
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Beraldo Leal <bleal@redhat.com>, qemu-devel@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Tue, 26 Mar 2024 at 12:35, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> We need meson v1.4.0 to fix MESONINTROSPECT quoting on Windows:
> https://github.com/mesonbuild/meson/pull/12807
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  python/scripts/vendor.py                   |   4 ++--
>  python/wheels/meson-1.2.3-py3-none-any.whl | Bin 964928 -> 0 bytes
>  python/wheels/meson-1.4.0-py3-none-any.whl | Bin 0 -> 935471 bytes
>  pythondeps.toml                            |   2 +-
>  4 files changed, 3 insertions(+), 3 deletions(-)

> --- a/pythondeps.toml
> +++ b/pythondeps.toml
> @@ -19,7 +19,7 @@
>
>  [meson]
>  # The install key should match the version in python/wheels/
> -meson = { accepted = ">=0.63.0", installed = "1.2.3", canary = "meson" }
> +meson = { accepted = ">=0.63.0", installed = "1.4.0", canary = "meson" }

If we need 1.4.0 why does this still say we accept anything 0.63.0
or better ?

If we use shlex.split(), does that go wrong for pre-1.4.0
meson only on Windows, or is it broken for all platforms?
(i.e. could we if we wanted to make the requirement
"1.4.0 for windows, 0.63.0 for others"?)

thanks
-- PMM

