Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 848DEC8302F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 09:56:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWXic-0001Sm-C8; Tue, 01 Jul 2025 05:56:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWXia-0001SU-9R
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 05:56:00 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWXiY-0006vY-8E
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 05:55:59 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-708d90aa8f9so55525627b3.3
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 02:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751363757; x=1751968557; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8z0G846kkv98HmmpTnG8gyqbySyckwlmkhjrgs/A22U=;
 b=s9v77e99gEGBgTkxO4Lecb2YSRMVO2jUcgU8C+wuubty80Ci3VC2NxqLW7RrcxJyZl
 9ntrtqtIxhuxeUorI/gjragm/yul720ovEXEyJbOnubDTWEYcI73gxEussyyYUAk/l78
 THfp+VyT/GDmhdDJ/Ueka+64Uv5CgA2btp78z6wO4fFtdE+6Ia2OGh4m0wXO2RDYQDoY
 S4+gSb9n2BoGMFKFM8bpsCdGSO2QJ1BeMHgzONf9fGbJ1mZ/+EBWpBgHLaLqogb+NzHW
 XiCAvHg0f+6LfawPAozHKFn2ZmG9cTDd4u78F0p2eFwVtt90mdiM7+3mGzpZqWByneDc
 k0+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751363757; x=1751968557;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8z0G846kkv98HmmpTnG8gyqbySyckwlmkhjrgs/A22U=;
 b=qToLiWeOuuMvCz8LKdCXypXbSg5KzZwoJhb7DCtbS5u/w5g+huc3T0+P6rhBxcZzYL
 8XkMCpFfDN40eL+YqcUf1oCbyLLwtUJsbluOBQksX1hUkHjTFgdJ/ZfS+xDJmP28U6bw
 bqfcL2W5fUk2QLdfJYM4ab4imnsDcoN1KE/NKIrLhG7GmKsftvyvfDlOYWS8nxDi7Gyt
 ezGFeOKHMAEQtmEkAKDoT4pmkBI+MhpPOwM+IZZF60tbAxbtJ0VUY7i7x5xbIy/LPjU+
 RAt0FXcGDFJoPW0A+em4VtRsTH1pep6hkUOWhk56swpoX3f4yQgS6ZPbkJL8LE1lyQbz
 YivA==
X-Gm-Message-State: AOJu0YxBptJX2w5P13yP+jpNJn5HyQdMKhIG5i+GU4lOhv/0J0TtuS36
 c/Dv3KmDkJ1D81uPfyW2AdyhsvN0ZRe2VGOs8qrh+nJ7o628ede2nU26E86BBZBGS6B51TPLOpQ
 Y5aOB8OFnsJ/1VVvLbaO5G3QrOvcnq+rFHGlxDadfqQ==
X-Gm-Gg: ASbGnctu5MZZQw7V72ae30ZGpSpKSwfvGO+zuv7bdWDSd2JjbPlZn39lSnEcdt9Bug9
 80MIEF3Wx24DIEGf24fc2tR3KYf/OxGU8DaVIhVcF5A0JJj3iIKzo0ltcxadsOGWDrFnCveH59L
 NQFiwOauPJu+nbBRbRnO8Joz2PWLKQ6qcbm6TFxFHubCgZ
X-Google-Smtp-Source: AGHT+IEhKDbR82dp5Cfu/vp4vMY89S4AyhtdRYjU0RTVi8X7AVMwT9nqLWzOCbUd1tBRmTqUP3fTj9xQpyq+Su3kito=
X-Received: by 2002:a05:690c:7401:b0:712:e22d:a235 with SMTP id
 00721157ae682-715171af91amr251415377b3.17.1751363757070; Tue, 01 Jul 2025
 02:55:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250623121845.7214-1-philmd@linaro.org>
 <20250623121845.7214-13-philmd@linaro.org>
In-Reply-To: <20250623121845.7214-13-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 1 Jul 2025 10:55:44 +0100
X-Gm-Features: Ac12FXxZuvpkYlYeLubDALCRe9b49Ny7Qj6d2gQPpOSrpzaCFQmZmZpMM8bnYto
Message-ID: <CAFEAcA87+SMWdSOGBaGuNDzynaLzoFMKv3PJmbfTyd3mN_TwzQ@mail.gmail.com>
Subject: Re: [PATCH v3 12/26] target/arm: Restrict system register properties
 to system binary
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Leif Lindholm <leif.lindholm@oss.qualcomm.com>, 
 qemu-arm@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Alexander Graf <agraf@csgraf.de>, Bernhard Beschow <shentey@gmail.com>,
 John Snow <jsnow@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 kvm@vger.kernel.org, Eric Auger <eric.auger@redhat.com>, 
 Cameron Esfahani <dirty@apple.com>, Cleber Rosa <crosa@redhat.com>, 
 Radoslaw Biernacki <rad@semihalf.com>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, 23 Jun 2025 at 13:19, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Do not expose the following system-specific properties on user-mode
> binaries:
>
>  - psci-conduit
>  - cntfrq (ARM_FEATURE_GENERIC_TIMER)
>  - rvbar (ARM_FEATURE_V8)
>  - has-mpu (ARM_FEATURE_PMSA)
>  - pmsav7-dregion (ARM_FEATURE_PMSA)
>  - reset-cbar (ARM_FEATURE_CBAR)
>  - reset-hivecs (ARM_FEATURE_M)
>  - init-nsvtor (ARM_FEATURE_M)
>  - init-svtor (ARM_FEATURE_M_SECURITY)
>  - idau (ARM_FEATURE_M_SECURITY)

I guess these are user-accessible via "qemu-arm -cpu max,cntfrq=3D ..."
syntax? Makes sense to not expose them, they won't do anything
sensible.

thanks
-- PMM

