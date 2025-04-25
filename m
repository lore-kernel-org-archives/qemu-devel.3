Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0A8CC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 13:04:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Iie-0006I3-RT; Fri, 25 Apr 2025 09:03:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8Iid-0006Hp-IY
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 09:03:51 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8Iib-0000RT-Cx
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 09:03:51 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-39c0dfba946so1619216f8f.3
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 06:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745586227; x=1746191027; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UVOjOrqVFoTQEJptF3IjiGXCr/bFtPyRBHM2L6BvQa4=;
 b=U9E2s/4eVo5ftPpxQcTHDkV+gmfc00NFkIu4OKXJo233p1suYSsuvYKcdWUOXRZk8A
 u70LoG4x73oGz9xH2j4Sh3Ss+lXdPZlu3kgPB96sDHycijr/kpKnvG+DYVx8JSGmnF2s
 0qQj0W1ZK+FayLO4uQIrWnAdSnrsGOgPftNqvUCyjn+mboSYtYdAW75nWPm0A/WJfSZG
 6kN2xM46eJ8XuplM+y49HFkpR8/jZENniOy16LsVUKZcdQ1W584HAuBfrWXYnjAIvvcP
 KhQPfZPy6huXktv2s+XXKh8R+odxoOYeLr4rytJtaRgXyDZzOHFfkT7z6zfHoEH+tNW+
 jFOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745586227; x=1746191027;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UVOjOrqVFoTQEJptF3IjiGXCr/bFtPyRBHM2L6BvQa4=;
 b=soxp+z9KIsGLO1q81OusshON5Vbo/3jt2ER+x4VngqH+TxDJ8ZLfxI0VmEgtAV6SwP
 NQqHznpJ+GzEAmhypu0klWPLy9s/L0mV272fBVaoJ0hgjij7XZaJ2IMiKMU7QZ9hmp0q
 k8c+3Z31KFleCg19Bz58Xgalbh4Frs6vBul7ENGz/IJQ2c8H+BlKZTQTrx4S6HYts2+B
 /WFnlYu9hoTPQpXcEHU73cJzBoeZ49HefG9WVePEUE6CWh2/S5NBogDdtD892B+Yrmkn
 5Zy1JrvKd+EkJma4ekx+SKEOrbpAJ4gY1a6ckEZgZ7XIja1Q+WR0O9ynj2teYG4DgkRk
 zZHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUnRBtdOYvG7+K3zeuME0Kd/Z5yPEYhEWjjArj6rJAh5UOZP5xQNoseauFqxMKokyh71I2gU2tgnR/@nongnu.org
X-Gm-Message-State: AOJu0YwwYaWCtpbMoYppQ75fNZMzmwe3ceayxFDmVVZzn3TSraWhVrXw
 c0ENAlMSuuTaNgzC0/eJsy2IYqoQl1D9hbCNeD9ExM980C0T0+YbftPWczjqbHU=
X-Gm-Gg: ASbGncsgxDxJOv7FoZS4zzXK9qNCRccIrjh2Yj864xPOucneBCZvJ/IQDCwUTUpRj85
 ynmPXtb76k/9ovKH2Rji5xanr1y6Wa4IxYPzp7kk0yS2TlZ7PT+2KQqoOSEsP2d0R4hcrG9uvB0
 dD1DJGuyOxB/VyfzQFm/2peq1w3N1iTb+vNxZEvffBRQ0iAOC5kAK7PVoyQccyaSCmEC4faJXuy
 cqFVd+DiaDecH354C2nursW1sKPKEkaHON9Id9kE06QB4/sGd1I75lP914rT09LdC2sAcb9E7ml
 VQtkd6X/OqWFufCu6hRfqzdrZYrZCqxi30hwgx5nwmnmGzNww4fnUWR5PwiP1JEP1WBCXjOCecb
 1VW8A+wBO
X-Google-Smtp-Source: AGHT+IFVlcNAxRnpT6JGr0lLcshnn5jNjiS0WsO9kN1+DvFfzgrgRX7iRHQGbDP3FUXp/my3ndHmOQ==
X-Received: by 2002:a5d:5f8f:0:b0:39c:1424:2827 with SMTP id
 ffacd0b85a97d-3a074e1f0dfmr1911157f8f.15.1745586227493; 
 Fri, 25 Apr 2025 06:03:47 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073cc1842sm2377424f8f.54.2025.04.25.06.03.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Apr 2025 06:03:46 -0700 (PDT)
Message-ID: <57f21448-79c1-4d46-9a8e-f9109eb67dcd@linaro.org>
Date: Fri, 25 Apr 2025 15:03:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Drop support for Python 3.8
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>
References: <20250425120710.879518-1-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250425120710.879518-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

Hi Thomas,

On 25/4/25 14:07, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> Python 3.8 went "end of life" in October 2024 and Fedora 42 dropped
> this version already, so the "python" CI job is currently failing.
> Thus it's time to drop support for this Python version in QEMU, too.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   This is an alternative suggestion to:
>   https://lore.kernel.org/qemu-devel/20250422125626.72907-1-thuth@redhat.com/
> 
>   docs/about/build-platforms.rst         |  2 +-
>   configure                              | 14 +++++++-------
>   python/Makefile                        |  8 ++++----
>   python/setup.cfg                       |  7 +++----
>   python/tests/minreqs.txt               |  2 +-
>   scripts/qapi/mypy.ini                  |  2 +-
>   tests/docker/dockerfiles/python.docker |  1 -
>   7 files changed, 17 insertions(+), 19 deletions(-)


>   if test -z "${PYTHON}"; then
>       # A bare 'python' is traditionally python 2.x, but some distros
>       # have it as python 3.x, so check in both places.
> -    for binary in python3 python python3.12 python3.11 \
> -                          python3.10 python3.9 python3.8; do
> +    for binary in python3 python python3.13 python3.12 python3.11 \

The 3.13 test was missing in commit 45b14be9b63 ("python: enable testing
for 3.13"). Preferably adding in a preliminary commit, otherwise mention
in this patch description:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


> +                          python3.10 python3.9 ; do
>           if has "$binary"; then
>               python=$(command -v "$binary")
>               if check_py_version "$python"; then

