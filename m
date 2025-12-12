Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1083CD4417F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 11:28:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vU1Jh-0000ny-Eg; Fri, 12 Dec 2025 06:28:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vU1Je-0000nJ-NZ
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 06:28:06 -0500
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vU1Jd-0004oC-AV
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 06:28:06 -0500
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-78c6a53187dso12445747b3.2
 for <qemu-devel@nongnu.org>; Fri, 12 Dec 2025 03:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765538884; x=1766143684; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5A9tvtqhF4HMLMh3qrPhM5DGlPTfzYv4OEKX4qNB37U=;
 b=Eg3HyNvg2nm6zH6Kwp/z62Ax1WUyyRz0fsMWs4K28TztsvsOXnnJSyW5dxOTeSQ+7k
 WZ0t4zGKJ/L8/85e5bOsGeeq88u7l7vJixoRBwA9aI6TuC85mgySbPCTpiN/l8nVT9yu
 jrsydJsbwYcCgRM46odIgxoRXie7g76WgQUmiZHZc5wTQXWaThC18bglLvYESk/gpK/L
 muP3IO7sBKt3sic7AOXpWsKj1o/Lx6hJOFDS8AFQ7+9Ck1v6uevKoIKPeg4lXdwXjGJw
 5+rsbwxiei4bihlXr+ovsPmPQBetXm6qWklMXChyTl9A6lbsqrTjYfF4RWKMj6L9Ltzk
 j24g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765538884; x=1766143684;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5A9tvtqhF4HMLMh3qrPhM5DGlPTfzYv4OEKX4qNB37U=;
 b=KcrMJ6zBAopr2rdQXBodK/ETiXDKQm8FMtKTVWGBHgp2UvzmN4Q+dJO6QYjE28KrQx
 M9nZjwamtQuPKpv1+t5sF6wKvkDPgWSM50S3fYoERAilX5I4SOd0l6q2eKs+4bB6X/YD
 4nCyBeLVL37f4WerpHO94NCLPjb+e6jO4Sz6iMHuoCkMXpqOmx2fsRedHRL4v3qs46MG
 fpGHUlQqqXs1sj+diFxKAtsRkIMzz+KOaQM/n7fxPFkQz4Swldi0QVekILUFE15Xpipf
 XRP30dAtN32pcZYrj54xOzb/HWsjZLKBeD9ptAJqMvFHnhjHV0eI5RlNZ34aksI3cmfk
 0zxQ==
X-Gm-Message-State: AOJu0YxhiDN22qxeBmMhP/T6c+BxMRPuUrTWJS6SwNVr0RfOaV8eqllW
 xeGcF42a1gqvD4rkytM/L2PE5SseFeNpjUXcgDZ8jlCz5SAaqYOVvWJJJ/Zg1Eowqrh39vqQ/4A
 rOmKaSVPOztwio7OU9rLZ4lRYgGEMtRz2gwAFyLTLxzHLDkF1lEzfMME=
X-Gm-Gg: AY/fxX5CDWeiMef9xvJ3U5ms/l4mIpTqb1vylpfS0dmcLBaZxbJNQwY48hsDN2cicTU
 QseXj30h0tZY3hDcrauHx5UnKqAe4CF3s1GOct69IVPi291HOuPqUTm+0aZ5/PsKP5iHEjIm9aM
 jhqyY4K7Ofr3EfLWZT4Ln6edmxnKvViK5hNHppWiRBVqqdS4/M1mASJGqGPMs8zs93r0p/aae1m
 TRuNRwzMDnJ5pQ9CsieLHWWB0YuO8wgI9YI323KcAkkR9FitDH9x+P2KZT7L3BCytbfQKup
X-Google-Smtp-Source: AGHT+IFS1i3bl3bNUWn05wGAeBvqDdQGWYb09SAnoaQ9zO5BP7v5OvQORHCSAL7LP3X4BcjmT3NUjoIscv/wrvEJeAg=
X-Received: by 2002:a05:690c:338a:b0:786:5379:af95 with SMTP id
 00721157ae682-78e6694fba5mr15483607b3.3.1765538884241; Fri, 12 Dec 2025
 03:28:04 -0800 (PST)
MIME-Version: 1.0
References: <20251211180132.3186564-1-alex.bennee@linaro.org>
In-Reply-To: <20251211180132.3186564-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Dec 2025 11:27:52 +0000
X-Gm-Features: AQt7F2rydNgvGHhenyEPUW_tSZEZ5-dlklw9zupeuY5_Tm5PuZZ1qpC4zRBgsm4
Message-ID: <CAFEAcA9bQmRaptjE5xDLoMKUW9aN9VvWmNF1MbrsPZj4yxd6gw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/9] for 11.0 conversion* of get_maintainers.pl to
 python
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 John Snow <jsnow@redhat.com>, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
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

On Thu, 11 Dec 2025 at 18:02, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> *incomplete
>
> I wanted to look at adding gitlab tags to MAINTAINERS and baulked
> slightly at figuring out what I would need to change in the perl
> script to cleanly handle it.
>
> While we imported the perl script from the kernel I'm fairly sure we
> don't use half the features it has and as us grey beards age out less
> people will be willing to tweak it. Consider this a proof-of-concept
> for discussion about if it is worth perusing this path.

I think it would be interesting to know if the upstream
kernel folks have any plans with get_maintainers -- they
recently did a big conversion of kernel-doc from perl
to python, for instance. I've cc'd Mauro who might know
if anything has been proposed similarly for get_maintainers.

thanks
-- PMM

