Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36973D30003
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 12:42:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1mIU-0006Gp-J3; Fri, 18 Oct 2024 08:41:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t1mIS-0006GU-Sy
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 08:41:37 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t1mIQ-0007rE-Rz
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 08:41:36 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-539ee1acb86so2801464e87.0
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2024 05:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729255292; x=1729860092; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CQ/mNoIwFz1SZmgxrkTP1X4SI9RzweB+wVUXqI/M+rk=;
 b=OqvHJ8V2XpCEENgm//TPZrn9CjvDUPldeqo61PWaxleXQYPk6iUtMQ6Qhu737OG9yu
 o4akKTER1QZFrXr9EUhzueJ9AqpwRZfXZHukgB1UdmyJIJeINx1fMb84eAvMYziI4eTf
 V+SD5NjpmRYpu3r9WmQTykBxqzxOfgBp0aAK4ruhq1cNnPsnWTmYii8NfPb1yZA+KQ/2
 QVgk6gOB3Io5k7BVdZfi/QDqlfM4Fbyma09AsgeF7QJ3Uy3hnnsYXfKjEJjlHwNfmsrB
 ZnO+Yekl06NNo/+Zf8tUL6onuvvJiuvbvRH2n3UzwcRZsFWFcvPEJxrfdoVCBZ4cqJ4k
 AkcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729255292; x=1729860092;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CQ/mNoIwFz1SZmgxrkTP1X4SI9RzweB+wVUXqI/M+rk=;
 b=q/UrAvdc0DHzVvyGtXGthzC/o0s+BsbibgpzQNW8jLz7ZXXt8T3FPD8g2kMiNOHOQS
 bSbzCzYZR5VQ8OA3IcD4pFWNEGt6I82fJrs9hGcrxQIdP/R0y3MwNIYAceuRYyM5LriA
 /E7F2DjOeORlYttKdCj7+BC1iGF0oenZFlqK2rYYx36nsNPQaEVXnBDFQJ5wzZoBprJ5
 GLz3ZNwipramOFQDdrpQ03e5UEfQIt1ferpYATBze0hz88GOdu+QoUAFcX1y7bVtFFaI
 yahrw/Fpkf98AiCghXIHX5W0XqjKTlxVbEvGomqveI1h4wec4Bhr7mqYVstGArR+b1iX
 +7og==
X-Forwarded-Encrypted: i=1;
 AJvYcCXT9BSEdzjTqgzBQAoav7cmj8MCtRAnN46eUP56VcOYhmaqoaMnivHVFRoNM2E2GWVp8AAlgVMPhn4p@nongnu.org
X-Gm-Message-State: AOJu0YwPVLVVwWhsEon6F7UGkzfhP7KTT0nC4Qj/JQa+Z3EL2VZeCnHF
 vZb00tf894QONa49K+DAa01wVmf0tzsOO4qpAJyDs+yF2cIv2lqn3rdJsgyeA/nVyK8QmeTQjzc
 x8AHqAUaW266aasT8uNvFKFRhTFeziDAsrZk3kg==
X-Google-Smtp-Source: AGHT+IFdtXHiSOIoQagEKCkhTbwyRdrWhGRbs4xh0oYSmYNkF756KxSi8vxsKernQN+ciMO57isz5x8Y/DT8iSYxRaA=
X-Received: by 2002:a05:6512:3b23:b0:539:9645:97ab with SMTP id
 2adb3069b0e04-53a1522dc42mr1529617e87.33.1729255292352; Fri, 18 Oct 2024
 05:41:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240327-meson-v3-0-7e6cdef1be8a@daynix.com>
In-Reply-To: <20240327-meson-v3-0-7e6cdef1be8a@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Oct 2024 13:41:20 +0100
Message-ID: <CAFEAcA_xee9sTVDa0juZG=TnsPrHxkH-15u4C-Xo0cXgs0Ghtg@mail.gmail.com>
Subject: Re: [PATCH for 9.1 v3 0/2] meson: Fix MESONINTROSPECT parsing
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Beraldo Leal <bleal@redhat.com>, qemu-devel@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12d.google.com
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

On Wed, 27 Mar 2024 at 01:50, Akihiko Odaki <akihiko.odaki@daynix.com> wrot=
e:
>
> The arguments in MESONINTROSPECT are quoted with shlex.quote() so it
> must be parsed with shlex.split().
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>
> To: Beraldo Leal <bleal@redhat.com>
> To: Peter Maydell <peter.maydell@linaro.org>
> Cc: qemu-devel@nongnu.org
> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Cleber Rosa <crosa@redhat.com>
> Cc: John Snow <jsnow@redhat.com>
> Cc: Michael Tokarev <mjt@tls.msk.ru>
>
> Changes in v3:
> - Ensured meson>=3D1.4.0 on Windows.
> - Link to v2: https://lore.kernel.org/r/20240326-meson-v2-0-d9f9003775e9@=
daynix.com
>
> Changes in v2:
> - Added patch "buildsys: Bump known good meson version to v1.4.0".
> - Link to v1: https://lore.kernel.org/r/20230812061540.5398-1-akihiko.oda=
ki@daynix.com
>
> ---
> Akihiko Odaki (2):
>       buildsys: Bump known good meson version to v1.4.0
>       meson: Fix MESONINTROSPECT parsing
>
>  configure                                  |   5 +++++
>  python/scripts/vendor.py                   |   4 ++--
>  python/wheels/meson-1.2.3-py3-none-any.whl | Bin 964928 -> 0 bytes
>  python/wheels/meson-1.4.0-py3-none-any.whl | Bin 0 -> 935471 bytes
>  pythondeps.toml                            |   2 +-
>  scripts/symlink-install-tree.py            |   3 ++-
>  6 files changed, 10 insertions(+), 4 deletions(-)

I've just had a report of somebody running into this
"if you have a ~ in your build dir then symlink-install-tree
breaks" bug, and realized we never applied this series.

We've just required rust 1.5.0 (commit 07f0d32641e0) because
we need it for the Rust support, so we don't need patch 1
here any more or the windows-specific bits in patch 2.
So I think we can just update the symlink-install-tree script
now, which ironically is what v1 of this patchset did :-)
(Though if we cared about fixing this in the stable
branches that would be more awkward.)

-- PMM

