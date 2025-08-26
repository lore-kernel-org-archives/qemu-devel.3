Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B8EBCA0EFA
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 08:47:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqpK1-0000hL-Dr; Tue, 26 Aug 2025 04:46:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uqpJx-0000gq-KQ
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 04:46:26 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uqpJs-0001UL-Om
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 04:46:25 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-61c26f3cf0dso5850258a12.1
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 01:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756197975; x=1756802775; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GPWo4WjJyUa+1NvTRqYOLCOUGA3LO9vWWcJIDiicRyw=;
 b=IqaVErNKZE98GTyEc7fteTeMB1DyGXxSJ9Hl8BdZcwJGpXa4Hej+yfnSnGX+HPP+vV
 qSA+lFGC80tovi6jP69WQBpDUW7c9bxnfd7897/zqE4Dotfs/0dNmY7ATNfag2E0nwLg
 2eUpB52nkOJzTJVrHWI4tiUEDLvTKrdrZNo/7r4EkID2dTk5wzb1fcEJcqp10OI9eFXI
 IzLmnFBNTytoVcTJtabnatC6EbCePk04G81liRj7jWbiDczqD7RjUERZGgIJp5HUm+QC
 m/8gJzUMhucbP0i39ICQJJnTCMC3D03cqeG2vQfG0DaIt27GIj6XrxQuQhXTSqt2i/AZ
 5zuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756197975; x=1756802775;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GPWo4WjJyUa+1NvTRqYOLCOUGA3LO9vWWcJIDiicRyw=;
 b=wAYcUmnRqTSqs8uNGuFPb6E59PIiiJFT9tLU2U+EemAfOrlxxFpYIGEd/lZz7Ee9dh
 zKFnbGO9FurvflZSfmzjUCABx/M+0croDjsEvGaercIIZtyx8dIJrDzMhszWEKaXfPDw
 dwyz29pQnL9zUKnCqSEyj5AAm10vZGcKEqGPcl8SZhSVZFhSoq4qT/BAmxBgofIgTpUy
 CnjN2Fm8MfXVU1v9MbjxTNnpB6fU5ndI2pT5z1YckzZXfw2LBzhBbfLoIwFUsLdgAZxJ
 1N7+BneZ3bjFB5ooHpwObg2Knkf1EC8O6/y7fQQYs/FdrtP+f7FAuNrcMOd8WtJBqtCg
 Z8iQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZ0nIPZcolJqMKQrPuOv8ufsd7aiswnJqI7x6oz3G2Zu3t0c0RihNfH6ET0lEEPz4ZvAQ5mezM/XDE@nongnu.org
X-Gm-Message-State: AOJu0YyvyBxCk5UdagVEkcW6w/8JoVXBrPeX9py2RJG24NTg6tG8HV4W
 /nfo13oOcwvOvqX2tIjyu3aFU8/6D2ktEYk55Ofs2QKvnfMyPrm0VXJn2g3wt9T6w+fuU1h9oZw
 X2umF5vWlnHpqyqlF/yv9gFPQer05nL9pVXUXIwh1Wg==
X-Gm-Gg: ASbGncufUmcy9NYlKNmWtGEwNtWq5dmdInI2VcxNw6ckChJEuSa00kwgb2CESTbrrbl
 6h2JU8tyFFCT797AEmzgCVojNucAFz2wbg4bpaqbX5t3ZPR+VjbnVM/wSszi6tSnXWSVBkAAnrP
 /dMXOSQ5HbHjuH3N7g2lw2inf6bdTH3ESKEPJjsoLaTlq5p/8EWaDI4cfAKeOG1GsD1Ec4iB7kC
 /SBY47s
X-Google-Smtp-Source: AGHT+IGmoRCtrzOe8ND7lh01ZtopBB5FuED3WtYe0KW+FToofD9QWalQyRP9/FGXhzn1A5PZ0g+OvCIhX7meYW9maZs=
X-Received: by 2002:a05:6402:2787:b0:61c:5264:ad97 with SMTP id
 4fb4d7f45d1cf-61c5264b027mr7144519a12.30.1756197975511; Tue, 26 Aug 2025
 01:46:15 -0700 (PDT)
MIME-Version: 1.0
References: <20250819143916.4138035-1-gustavo.romero@linaro.org>
 <53b6e23f-5328-42c6-9c58-97ddbf3e5b29@redhat.com>
 <a1105fed-dbd8-4223-b771-180ab12e3f77@linaro.org>
 <8326014d-114e-47df-89fc-632eb5683632@redhat.com>
 <87tt1u1oas.fsf@draig.linaro.org>
In-Reply-To: <87tt1u1oas.fsf@draig.linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 26 Aug 2025 11:45:49 +0300
X-Gm-Features: Ac12FXy2ixjYjO8F0bCouJoDW43OlqusgC9ZZCtAcuxs_X6CrlFFAJRVdvXupPI
Message-ID: <CAAjaMXaS9dGGo7EpvFQtTrFy819G+SW-cgom5gQ_bA_zqUE7ag@mail.gmail.com>
Subject: Re: [PATCH 0/4] tests/functional: Adapt reverse_debugging to run w/o
 Avocado
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org, 1844144@gmail.com, Jan Richter <jarichte@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x529.google.com
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

On Tue, Aug 26, 2025 at 11:28=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee@lina=
ro.org> wrote:
>
> Thomas Huth <thuth@redhat.com> writes:
>
> > On 25/08/2025 16.04, Gustavo Romero wrote:
> >> Hello, Thomas!
> >> On 8/25/25 07:29, Thomas Huth wrote:
> >>> On 19/08/2025 16.39, Gustavo Romero wrote:
> >>>> The goal of this series is to remove Avocado as a dependency for run=
ning
> >>>> the reverse_debugging functional test.
> >>>>
> >>>> This test, the last one I=E2=80=99m aware of that relies on Avocado,=
 requires it
> >>>> because of the need for GDB to test reverse stepping and continue.
> > ...
> >>> I gave it a try, but this did not work for me, the test was not run
> >>> at all anymore. Are there any patches needed on top?
> >> hmm that's odd. I'm able to run it with 'make check-functional' and
> >> with 'meson test'...
> >> This is how I'm running it (let me know if I'm missing something):
> > ...
> >> gromero@gromero0:/mnt/git/qemu_$
> >> gromero@gromero0:/mnt/git/qemu_/build$ ../configure
> >> --target-list=3Daarch64- softmmu --disable-docs
> >> gromero@gromero0:/mnt/git/qemu_/build$ make -j 32
> >> gromero@gromero0:/mnt/git/qemu_/build$ time make -j 15  check-function=
al
> >> [1/2] Generating tests/functional/func-precache-aarch64-
> >> aarch64_reverse_debug with a custom command (wrapped by meson to set
> >> env)
> >> 2025-08-25 12:50:04,215 - qemu-test - INFO - Attempting to cache
> >> '/home/ gromero/.cache/qemu/
> >> download/7e1430b81c26bdd0da025eeb8fbd77b5dc961da4364af26e771bd39f379cb=
bf7'
> >> 2025-08-25 12:50:04,225 - qemu-test - DEBUG - Using cached asset
> >> /home/ gromero/.cache/qemu/
> >> download/7e1430b81c26bdd0da025eeb8fbd77b5dc961da4364af26e771bd39f379cb=
bf7
> >> for
> >> https://archives.fedoraproject.org/pub/archive/fedora/linux/releases/2=
9/
> >> Everything/aarch64/os/images/pxeboot/vmlinuz
> >> GDB CMD: /usr/bin/gdb-multiarch -q -n -batch -ex 'set pagination
> >> off' -ex 'set confirm off' -ex "py
> >> sys.argv=3D['/mnt/git/qemu_/tests/functional/
> >> test_aarch64_reverse_debug.py']" -x /mnt/git/qemu_/tests/functional/
> >> test_aarch64_reverse_debug.py
> >> [0/1] Running external command precache-functional (wrapped by meson
> >> to set env)
> >> make[1]: Entering directory '/mnt/git/qemu_/build'
> >> [1/6] Generating qemu-version.h with a custom command (wrapped by
> >> meson to capture output)
> >> /mnt/git/qemu_/build/pyvenv/bin/meson test  --no-rebuild -t 1
> >> --setup thorough  --num-processes 10 --print-errorlogs  --suite
> >> func  --suite func- quick  --suite func-thorough
> >>   1/27 qemu:func-thorough+func-aarch64-thorough+thorough /
> >> func-aarch64- aarch64_virt_gpu                   SKIP
> >> 1.95s   0 subtests passed
> >
> > I tried a couple of times now, and finally realized that it's the
> > "gdb-multiarch" binary that is missing on Fedora. And as far as I can
> > see, there is also no package that provides this on Fedora? So if we
> > go ahead with your patches, this test will only run on certain distros
> > that provide this binary.
>
> I've mentioned in another review comment we should use the same gdb as
> set/detected from configure as we do for the check-tcg tests.


FWIW you can pass your own binary and command flags to
https://github.com/cs01/pygdbmi

It uses subprocess and wraps all stdout/stderr of gdb, like avocado.
So you can call it from the functional test directly.

