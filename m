Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45CE7C982C1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 16:43:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6sjS-00060p-7Y; Wed, 16 Sep 2026 12:43:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6sjC-0005xS-Vc
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 12:43:25 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6sjA-0008P6-Ia
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 12:43:22 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49cd5462b69so7130195e9.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 09:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789576998; x=1790181798; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=cURPh13A7rpPibbmOCy1e/wvavz2IRwRodYDoxGsQ4A=;
 b=WNhHVVxxJpLieZe+R1pST/WSqn1Ug+zntYo5065+5LvSzNkps/91iWClQT32ab5dGo
 +zuwMy8OVPXHy7qlzMKvE8k7QVW+kyjzUFu1QwEqY/iJvnep9Vi81t38WqZesxKjYWn8
 kEDPSsgMhAZ5IzLpExzu1JFw2yxuN8liIVhkWb5hIks1F2Fq+8Jn57L/bXwb957oqwFJ
 6FJjaepwz4+qZ2lMzFzPvgnzIElwAxnvScjAtkqK6zVlZHp/wWO8pKy9Hq0y2BtCI2sl
 /qaqY1epxJU+K468KUDtKz3VRfpatWBtZfjpRfVS6F1L+yFajTnnoeoo0TKSeaRH8cBS
 ypCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789576998; x=1790181798;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cURPh13A7rpPibbmOCy1e/wvavz2IRwRodYDoxGsQ4A=;
 b=rt3Zs039Vz0VyZe2hvQr0nuzCXg839w31xZKoXb87nQpQW6pP0a0k+U5pAiTKdYQwZ
 TeDUEKqxW818+q2FJ2TbwKLRrLu+sjDzIPlMQ4fM3XGYO1949C8YZOc9ybxO2+jCxsyV
 L2q1DMzCeELcOxm1Qg9kPyKzaq7lyk9qmfJtP/jRGPsg8qUMP8KOwOJVXhi9Ic85eabM
 EwAhgOTi4XN4a3AoDxN05iTiervkncIfxJ0KxmFqNRC4tKeLlbsEsKZCIofoSz2WsYeR
 RFDHTqyn8KbVrwm/5Th2nwq5OvhLINUMtZlImDuojiMX09YSjHaOYQeFvQ9TWkDuLXby
 u3/g==
X-Forwarded-Encrypted: i=1;
 AKwUvByL9B6N1tU3TJUWHSWKAyAIDKt53FkXqTQHwj0vNaq1+LvOzvvLr92SwzsfC705Sv+9P2z+nnBpaHGn@nongnu.org
X-Gm-Message-State: AFuF++nCnePu7sJkwv7ndK28lNfSVYpVJya5hXIu7wyCpINxTFA8x9c2
 bAAdSSzQ5hiBdkf99Qi5g/vzJmcGXRPAEMHMetGmd6VOWj/cib1g0zPyagl2cOAk7xA=
X-Gm-Gg: AYBFou0pcm/2UECapp/IMZez5KeSQ5l9/L0usT+tYL+b+b7tyEwJbvia6gz98qRVvyH
 N85OmO07SnAqcebTnc+HkgWe1WIu4hXZYsielQ+HmCgVhIivGPAz4EWSt/SN4PSA31pYYFUYz2T
 qdb5vsTUPmoQxYV95abUChZn964n2V87HQOAaFIluoDpCKDE2dZlKWjAio29Drfw+K0tiv/ISN7
 o7mHZAQu5FxvPN3jSL3IPsph1o0dbrn+W3BvcG9vbSL0/ZVgr/hV/H9VANC9/TV8CgeVEDyLrkz
 gWyOzOlAe/amZp1RFlbxeUZVK5zkec6yuMXCPH+Ihp+LM12pRXK4giMoM5hfW2gnfvQuWn0pQQu
 C2dT1+AK0VExxJFFXs4T6zDecWMGM4irChhp/4ujCm6r5dpOfkLuFdcgg6H4I6XMZFn06QcBPIX
 diZb7kVhpqWwsJbiZNzEl6L2gmzNwMZVqW3zOEAWjtoMxpyYYWM0KFMcLLvMNX6FyyZalELjk=
X-Received: by 2002:a05:600c:8b71:b0:49c:e1f1:3dd5 with SMTP id
 5b1f17b1804b1-49eb72f3b22mr80157395e9.4.1789576998408; 
 Wed, 16 Sep 2026 09:43:18 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e847e994dsm55799355e9.2.2026.09.16.09.43.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 09:43:17 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 72A03618BA;
 Wed, 16 Sep 2026 17:43:16 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: John Snow <jsnow@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,  qemu-devel@nongnu.org
Subject: Re: [PULL v2 000/105] move check-tcg into the meson build
In-Reply-To: <CAFn=p-au47ecRqxo=FB5S=LoQqa0dPRXb1xDuCefVXXyZP+OWA@mail.gmail.com>
 (John Snow's message of "Wed, 16 Sep 2026 12:16:36 -0400")
References: <20260904150826.2331577-1-alex.bennee@linaro.org>
 <CAFEAcA9vZZmVPP3_P1xz-NX_sqWY0zrOC2LeGLTdnaK54XKQzQ@mail.gmail.com>
 <CAFn=p-bXoctWNEdERPBL-SMRPYDisban2e0-mxYjws7UVcjVzw@mail.gmail.com>
 <87tsnq9siw.fsf@draig.linaro.org>
 <CAFn=p-au47ecRqxo=FB5S=LoQqa0dPRXb1xDuCefVXXyZP+OWA@mail.gmail.com>
User-Agent: mu4e 1.14.4-pre3; emacs 30.1
Date: Wed, 16 Sep 2026 17:43:16 +0100
Message-ID: <87v78587vf.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm2-x10.google.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL=1.623 autolearn=no autolearn_force=no
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

John Snow <jsnow@redhat.com> writes:

> On Tue, Sep 15, 2026 at 4:19=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@lin=
aro.org> wrote:
>>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > On Fri, Sep 4, 2026 at 2:04=E2=80=AFPM Peter Maydell <peter.maydell@li=
naro.org> wrote:
>> >>
>> >> On Fri, 4 Sept 2026 at 16:08, Alex Benn=C3=A9e <alex.bennee@linaro.or=
g> wrote:
>> >> >
>> >> > The following changes since commit d2843fbf80260e4346c856819e8cea11=
768c9d0e:
>> >> >
>> >> >   Merge tag 'pull-riscv-to-apply-20260904' of https://github.com/al=
istair23/qemu into staging (2026-09-04 09:43:27 +0100)
>> >> >
>> >> > are available in the Git repository at:
>> >> >
>> >> >   https://gitlab.com/stsquad/qemu.git tags/pull-11.1-check-tcg-meso=
n-040926-2
>> >> >
>> >> > for you to fetch changes up to 7a485176838e6b6044e73f925d308bb4b300=
2597:
>> >> >
>> >> >   MAINTAINERS: add maintainer for tcg/tests meson infrastructure (2=
026-09-04 16:06:22 +0100)
>> >> >
>> >> > ----------------------------------------------------------------
>> >> > tests/tcg: conversion to meson
>> >> >
>> >> >   - remove unused variable from multiarch/memory
>> >> >   - standardise checking plugin output
>> >> >   - bump minimal meson to 1.6.0
>> >> >   - introduce meson plumbing for check-tcg
>> >> >   - return error code if docker probe fails
>> >> >   - add CI/self/mem test to gdbstub prot-none tests
>> >> >   - use raw opcode for fprcvt test in arm
>> >> >   - remove unused variables from gpc-test
>> >> >   - teach probe-gdb-support about mips
>> >> >   - identify or1k pc register
>> >> >   - port check-tcg logic to meson (all targets)
>> >> >   - update documentation
>> >> >   - add Pierrick as a maintainer for tests/tcg
>> >
>> > Hi, I'm having difficulties building after this PR, after eb7f0c14 in
>> > particular.
>> >
>> > I keep seeing stuff like this:
>> >
>> > FAILED: [code=3D1] tests/tcg/x86_64-softmmu-hello.test
>> > /home/jsnow/src/qemu/tests/tcg/../docker/docker.py --command podman
>> > run --run-as-current-user -w /home/jsnow/src/qemu/build -v
>> > /home/jsnow/src/qemu:/home/jsnow/src/qemu debian-amd64-cross
>> > x86_64-linux-gnu-gcc
>> > /home/jsnow/src/qemu/tests/tcg/multiarch/system/hello.c -o
>> > tests/tcg/x86_64-softmmu-hello.test -static -MMD -MF
>> > tests/tcg/x86_64-softmmu-hello.d -Wall -Werror -O0 -g
>> > -fno-strict-aliasing -nostdlib -ffreestanding -Wa,--noexecstack -I
>> > /home/jsnow/src/qemu/tests/tcg/x86_64/system/../../minilib
>> > /home/jsnow/src/qemu/tests/tcg/x86_64/system/../../minilib/printf.c
>> > ../tests/tcg/x86_64/system/boot.S -Wl,-T
>> > ../tests/tcg/x86_64/system/kernel.ld -Wl,-melf_x86_64
>> > -Wl,--no-warn-rwx-segments -Wl,--build-id=3Dnone -lgcc
>> > cc1: fatal error:
>> > /home/jsnow/src/qemu/tests/tcg/multiarch/system/hello.c: Permission
>> > denied
>> > compilation terminated.
>> > cc1: fatal error:
>> > /home/jsnow/src/qemu/tests/tcg/x86_64/system/../../minilib/printf.c:
>> > Permission denied
>> > compilation terminated.
>> > cc1: fatal error: ../tests/tcg/x86_64/system/boot.S: Permission denied
>> > compilation terminated.
>>
>> Try the v2 I've just posted. That fixed up the handling of mapping your
>> host user id into the container so there are less surprises when it
>> writes to the mapped volume.
>>
>>   https://patchew.org/QEMU/20260915201601.1207839-1-alex.bennee@linaro.o=
rg/
>>
>
> No dice there. Fully rebooted my machine just in case there were
> permission issues lingering in my session; still getting perm errors:
>
> jsnow@jsnow-thinkpadp16vgen1 ~/s/q/build (review)> cat /etc/subuid
> jsnow:100000:65536
> jsnow@jsnow-thinkpadp16vgen1 ~/s/q/build (review)> cat /etc/subgid
> jsnow:100000:65536
>
> jsnow@jsnow-thinkpadp16vgen1 ~/s/q/build (review)> ls -lahZ
> ../tests/tcg/multiarch/system/hello.c
> -rw-r--r--. 1 jsnow jsnow unconfined_u:object_r:user_home_t:s0 229 May
>  7  2025 ../tests/tcg/multiarch/system/hello.c
>
> Setting the dreaded `setenforce 0` it does seem to work, so I suppose
> the issue is that my source tree is not labeled in a way that permits
> it to be mapped into a container.
>
> I'd like to ask that we have a hello world style check that tests to
> see if it can access your source tree and, if not, proposes some
> solutions:
>
> (1) Prompt user to check that rootless podman is functioning
> correctly, check your subuid/subgid etc

Perhaps we should just run the same compile test when we detect
containers.

> (2) Prompt user to check selinux labels
> (3) Suggest that container builds can be disabled with --disable-containe=
rs
>
> Possibly even as part of configure we do a simple hello-world test and
> if it works, enable containers by default and if it does not, we
> disable them. If you pass --enable-containers and the hello world
> fails, configure exits with an error.
>
> Or some other such thing.
>
> --js

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

