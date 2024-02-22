Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1971C54788
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 12:22:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd84k-0000Jb-D1; Thu, 22 Feb 2024 07:21:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rd84h-0000Ic-OT
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 07:21:16 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rd84f-0006yh-TJ
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 07:21:15 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4127190ad83so18853135e9.0
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 04:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708604471; x=1709209271; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W0ALu00v8uWfNsXL8fQeBc2mNygRWWP+Z5x+qSONn74=;
 b=EY4mtoES5aN5w8fIwVo09cnBIPR4eVbLhtYazvwg+2stqGyugKCGlOYRuaLI11Acqf
 QINqqXXaNEAHq2xp0/UCXEQCrMHKzeiQopS9HCG4ReKlO1mp9m05BgbsjEEidOYP16T2
 96FIxHtLWg7i4W6+RS0bqN+l+pvLCE3aX5/SMA/iWwXb2hURKH+P6DY/3eC/SQChIGxC
 9TY8Lu7Uxsa5GtsYC2bqqL1pqGwIgewvngpLPQK39k53w4BUeBzQrWSSaHmjBTvW7tfS
 dD/W4ECXDBQCwbH36TE6Won3fMli7jmxyBHWSnBMa3aWzA2UDcdyXwNSRXZU1oEo0Fbk
 dikw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708604471; x=1709209271;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W0ALu00v8uWfNsXL8fQeBc2mNygRWWP+Z5x+qSONn74=;
 b=vvAfyb92tf1LJ38DVR56ayinRUz3MH6E/2QeQfHg/kxCLd/uypyd6c5Aw1NI/Tk1T1
 Uy1PkEh8Qj91V+JD1i9lLQaLHaIoeToXJfp25fYCBy0FTK/VnfKIDIg/R6BcLXbQYjrz
 16sUHUTV54ta57k0nUBT3D2rXTL6f+rc3d14b9wQlrWOn8D20YPixnKv43U2Qg3phUkf
 8ZM16E1xNqOJFAUy3s2JP8EmdoeUWAFfo26IvAbXnGMvZItnBP/ZFEX2iUeyOtUI5wr+
 l55lyJmYcGiz3zSobRvn7Qn6H70pflfA+lhkEdm7eGgX8a4bCKnjAzYY4a3oX/GKT9Hr
 +NeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8wQoDH6RTWF+QcCrcckoc/pNcxIwlrx0SXV25SGBzz/VVMXMfU5/VL3pnuY0DwoVB8Wg5c/Ut8mMGr2C5ZVG003Sq/O8=
X-Gm-Message-State: AOJu0Yx8qGX02s4Jb77oNiRuSyv5ktEcZe1XiU3Q1x9UAehrFBJ1yoHX
 APeFkUm/W51L9wBh7uQwX2MLXs5gyEqYYCruIIWZHmmViC/W+e0HSLvzfoAtRfs=
X-Google-Smtp-Source: AGHT+IFYf6rG9Uty6Cgk4/CoiLweZkop+tDARL1INohhi5SV64TGleKbloVZ2flVGh5uoCGombQ9PA==
X-Received: by 2002:a05:600c:4fc4:b0:411:d822:d81b with SMTP id
 o4-20020a05600c4fc400b00411d822d81bmr17396001wmq.2.1708604471485; 
 Thu, 22 Feb 2024 04:21:11 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 v21-20020a05600c445500b0041266f5b041sm13506746wmn.34.2024.02.22.04.21.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 04:21:11 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BD5515F89B;
 Thu, 22 Feb 2024 12:21:10 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org,
 Thomas Huth <thuth@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Yonggang Luo <luoyonggang@gmail.com>
Subject: Re: [PATCH 2/3] .gitlab-ci.d: Drop cross-win32-system job
In-Reply-To: <CAFEAcA_1zEQ-bT8bE=74FC24fz7HYN6j8ZLZVaDn7C47vraNAQ@mail.gmail.com>
 (Peter Maydell's message of "Thu, 22 Feb 2024 11:44:00 +0000")
References: <20240220174412.155885-1-peter.maydell@linaro.org>
 <20240220174412.155885-3-peter.maydell@linaro.org>
 <3a4a6505-662a-448e-9196-f3be819b51a0@linaro.org>
 <CAFEAcA_1zEQ-bT8bE=74FC24fz7HYN6j8ZLZVaDn7C47vraNAQ@mail.gmail.com>
User-Agent: mu4e 1.11.28; emacs 29.1
Date: Thu, 22 Feb 2024 12:21:10 +0000
Message-ID: <87v86g8zbd.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Tue, 20 Feb 2024 at 18:46, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.=
org> wrote:
>>
>> On 20/2/24 18:44, Peter Maydell wrote:
>> > We don't support 32-bit Windows any more, so we don't need to defend it
>> > with this CI job.
>> >
>> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> > ---
>> >   .gitlab-ci.d/container-cross.yml              |   5 -
>> >   .gitlab-ci.d/crossbuilds.yml                  |  14 ---
>> >   .../dockerfiles/fedora-win32-cross.docker     | 111 ----------------=
--
>> >   tests/lcitool/refresh                         |   5 -
>> >   4 files changed, 135 deletions(-)
>> >   delete mode 100644 tests/docker/dockerfiles/fedora-win32-cross.docker
>>
>>
>> > diff --git a/.gitlab-ci.d/crossbuilds.yml b/.gitlab-ci.d/crossbuilds.y=
ml
>> > index d19d98cde05..987ba9694ba 100644
>> > --- a/.gitlab-ci.d/crossbuilds.yml
>> > +++ b/.gitlab-ci.d/crossbuilds.yml
>> > @@ -159,20 +159,6 @@ cross-mips64el-kvm-only:
>> >       IMAGE: debian-mips64el-cross
>> >       EXTRA_CONFIGURE_OPTS: --disable-tcg --target-list=3Dmips64el-sof=
tmmu
>> >
>> > -cross-win32-system:
>> > -  extends: .cross_system_build_job
>> > -  needs:
>> > -    job: win32-fedora-cross-container
>> > -  variables:
>> > -    IMAGE: fedora-win32-cross
>> > -    EXTRA_CONFIGURE_OPTS: --enable-fdt=3Dinternal
>> > -    CROSS_SKIP_TARGETS: alpha-softmmu avr-softmmu hppa-softmmu m68k-s=
oftmmu
>> > -                        microblazeel-softmmu mips64el-softmmu nios2-s=
oftmmu
>>
>> Thomas, is it possible to add mips64el-softmmu to the cross-win64-system
>> job or is it already at the timeout limit?
>
> This is a skip, i.e. exclude, list, not an include list. So dropping
> this job is not removing mips64el-softmmu from coverage.
> The Windows build coverage we lose will be the targets we
> are skipping in the cross-win64-system job and weren't
> skipping here:
>  or1k-softmmu rx-softmmu sh4eb-softmmu sparc64-softmmu
>  tricore-softmmu xtensaeb-softmmu
>
> which then fall into the same bucket as
>    alpha-softmmu avr-softmmu hppa-softmmu m68k-softmmu
>    microblazeel-softmmu nios2-softmmu
>
> which are already not built in either cross-win*-system job.
>
> Is there a reason why we aren't covering those in Windows
> builds?

I think it came down to the Windows builds being particularly prone to
timing out and these targets being fairly niche. Do we really expect to
catch build failures here that the other more featured targets wont?

BTW this is in addition to the default set of targets we skip for
crossbuilds:

    - ../configure --enable-werror --disable-docs --enable-fdt=3Dsystem
        --disable-user $QEMU_CONFIGURE_OPTS $EXTRA_CONFIGURE_OPTS
        --target-list-exclude=3D"arm-softmmu cris-softmmu
          i386-softmmu microblaze-softmmu mips-softmmu mipsel-softmmu
          mips64-softmmu ppc-softmmu riscv32-softmmu sh4-softmmu
          sparc-softmmu xtensa-softmmu $CROSS_SKIP_TARGETS"

>
> thanks
> -- PMM

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

