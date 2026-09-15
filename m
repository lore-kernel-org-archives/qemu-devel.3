Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A50FC982C1
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 20:20:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Zdg-0002I3-Ej; Tue, 15 Sep 2026 16:20:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6Zcz-0001dG-DX
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 16:19:44 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6Zcx-0003f4-C8
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 16:19:41 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912d8239so1508615e9.0
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 13:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789503577; x=1790108377; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=1zRyLKqv0uzltUgznIO/CJOlMkgQDfQ8/jkdIWs9tcg=;
 b=okl7rKP+7ISGg1dD0P2CC4U/YU6xozm2jRu65/adarM1lM9oQtBZwVUkg1WZlFFbCX
 jtv33zJomKNqgLZ03hLrbTjvUSf5CrsXzBvRRUOQPSdI8P+vuB9MbgJXC89j34Ng2pNj
 NTkTf0RYl14MW/MtVPtQzdB1e6Cj5nd1oqftNRmb2b9/VR6wyysK0Z8E92LgQrRkGE7Q
 zQy5NQlUdgxSmga3gOws1zMfaLwkIpdY9pchQdpTSpN2ALbjTAEsKnbIxO4H1qAGA3l1
 +IhFw1iZ19NFzklJL1ECaqFi+ed1OmUo1+VSszOHrVEj+81DNKwoNKdsqE7o1TC97cb4
 9K8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789503577; x=1790108377;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1zRyLKqv0uzltUgznIO/CJOlMkgQDfQ8/jkdIWs9tcg=;
 b=hD1FIUC5zev60FR0ySFfiCCtNvRyJsJYMOZvrgEG2T2MNsvP2pT/+J8LyLPPAEy/L2
 mtYfdXVWfx1RBP7Sw1q4B4Ve3pdvfomdq8vyR7sTL49U2o6A6Wjk+AbTSgGO0Gy+ASXX
 e7bIod1XA9kAepcZUMFtTFBHM5YOVBZrsJBaPeVlCKINTCfKZ0AKZj+PkmFWbNt5fslD
 HMOUuKDFwuuCaeNwmWqE2i9/ESV5chTJLxw5k7q8NMkoPGZanT9JLMFwRQmph9mqN080
 Y+4bweiUD9YexznUhFhOuwfD9Jnakxj8iSMGWLdACIXXNQGrnFXG2h7MAp31zR6SxmpA
 1Peg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxmN6NHBW0SO5O7awu/YRI0oVj61rpFJFHVJMsU6r3WxfTxzCNXo+jyczJtjuw+IeggH/xOhbpwFF6j@nongnu.org
X-Gm-Message-State: AFuF++l8BM2LT4esjDkIJ/SYowQ8e4jF3CeRrz3w2FLObd4GzTfSqUr9
 7wF2CU1h7a/HQ3imyR/kVa6LTfvZ3rgpYM9Vx5oDsjPI216v8gpaw49P08xHojAMxQs=
X-Gm-Gg: AYBFou2xvK1gml376bCBmNijCPgJ9RSDMZ70tEALTJ807y9+ZY6x5OEfbSefw4PuaEv
 iDgFpQjuQAJUnsmCvXS+46/JTExQQrjXK0LKOfakJs5EhIbi2ODRxosafsTHrgr4fh/hfwe15BY
 33twRuwAWTfOLAvMbs0iVltAj2bgW5DYTkVwDUC7ZVtDyKOeCfYsWAiHtR1o1FIj1jmiOpnbX3U
 OuG1iaWRmEFX5tgYCWVkEzjsO/QDlneDEAmkAiiee1hMBbibMgLNXyEAMgT6vAaNtNp45u/63vt
 0sPrGy9Dp0oC8DUQXXnzrwxchSA5/eLzpU4rbZgA6AUzt+rfA4br6cyfhF4uIJPxaLCzi8wBzOQ
 cGVnR2SwWL07k8OplkOgHdg3M0YXLLyEUMn9ZxDEOSCvPK1M5Rnf7atRL6oSXqWtqSqcHQqbO3J
 veDEgwFovj9dVG4pOl8nZ4GW/yPKvlfSregZCsKfYKubFw6B+f5zvu118anuKQZmjQqhnNxLc=
X-Received: by 2002:a05:6000:1845:b0:487:931:946e with SMTP id
 ffacd0b85a97d-4870cee46a2mr125229f8f.1.1789503577544; 
 Tue, 15 Sep 2026 13:19:37 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf26c8dsm1605843f8f.14.2026.09.15.13.19.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 13:19:36 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D229A5F825;
 Tue, 15 Sep 2026 21:19:35 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: John Snow <jsnow@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,  qemu-devel@nongnu.org
Subject: Re: [PULL v2 000/105] move check-tcg into the meson build
In-Reply-To: <CAFn=p-bXoctWNEdERPBL-SMRPYDisban2e0-mxYjws7UVcjVzw@mail.gmail.com>
 (John Snow's message of "Tue, 15 Sep 2026 12:52:50 -0400")
References: <20260904150826.2331577-1-alex.bennee@linaro.org>
 <CAFEAcA9vZZmVPP3_P1xz-NX_sqWY0zrOC2LeGLTdnaK54XKQzQ@mail.gmail.com>
 <CAFn=p-bXoctWNEdERPBL-SMRPYDisban2e0-mxYjws7UVcjVzw@mail.gmail.com>
User-Agent: mu4e 1.14.4-pre3; emacs 30.1
Date: Tue, 15 Sep 2026 21:19:35 +0100
Message-ID: <87tsnq9siw.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm2-x10.google.com
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

John Snow <jsnow@redhat.com> writes:

> On Fri, Sep 4, 2026 at 2:04=E2=80=AFPM Peter Maydell <peter.maydell@linar=
o.org> wrote:
>>
>> On Fri, 4 Sept 2026 at 16:08, Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
>> >
>> > The following changes since commit d2843fbf80260e4346c856819e8cea11768=
c9d0e:
>> >
>> >   Merge tag 'pull-riscv-to-apply-20260904' of https://github.com/alist=
air23/qemu into staging (2026-09-04 09:43:27 +0100)
>> >
>> > are available in the Git repository at:
>> >
>> >   https://gitlab.com/stsquad/qemu.git tags/pull-11.1-check-tcg-meson-0=
40926-2
>> >
>> > for you to fetch changes up to 7a485176838e6b6044e73f925d308bb4b300259=
7:
>> >
>> >   MAINTAINERS: add maintainer for tcg/tests meson infrastructure (2026=
-09-04 16:06:22 +0100)
>> >
>> > ----------------------------------------------------------------
>> > tests/tcg: conversion to meson
>> >
>> >   - remove unused variable from multiarch/memory
>> >   - standardise checking plugin output
>> >   - bump minimal meson to 1.6.0
>> >   - introduce meson plumbing for check-tcg
>> >   - return error code if docker probe fails
>> >   - add CI/self/mem test to gdbstub prot-none tests
>> >   - use raw opcode for fprcvt test in arm
>> >   - remove unused variables from gpc-test
>> >   - teach probe-gdb-support about mips
>> >   - identify or1k pc register
>> >   - port check-tcg logic to meson (all targets)
>> >   - update documentation
>> >   - add Pierrick as a maintainer for tests/tcg
>
> Hi, I'm having difficulties building after this PR, after eb7f0c14 in
> particular.
>
> I keep seeing stuff like this:
>
> FAILED: [code=3D1] tests/tcg/x86_64-softmmu-hello.test
> /home/jsnow/src/qemu/tests/tcg/../docker/docker.py --command podman
> run --run-as-current-user -w /home/jsnow/src/qemu/build -v
> /home/jsnow/src/qemu:/home/jsnow/src/qemu debian-amd64-cross
> x86_64-linux-gnu-gcc
> /home/jsnow/src/qemu/tests/tcg/multiarch/system/hello.c -o
> tests/tcg/x86_64-softmmu-hello.test -static -MMD -MF
> tests/tcg/x86_64-softmmu-hello.d -Wall -Werror -O0 -g
> -fno-strict-aliasing -nostdlib -ffreestanding -Wa,--noexecstack -I
> /home/jsnow/src/qemu/tests/tcg/x86_64/system/../../minilib
> /home/jsnow/src/qemu/tests/tcg/x86_64/system/../../minilib/printf.c
> ../tests/tcg/x86_64/system/boot.S -Wl,-T
> ../tests/tcg/x86_64/system/kernel.ld -Wl,-melf_x86_64
> -Wl,--no-warn-rwx-segments -Wl,--build-id=3Dnone -lgcc
> cc1: fatal error:
> /home/jsnow/src/qemu/tests/tcg/multiarch/system/hello.c: Permission
> denied
> compilation terminated.
> cc1: fatal error:
> /home/jsnow/src/qemu/tests/tcg/x86_64/system/../../minilib/printf.c:
> Permission denied
> compilation terminated.
> cc1: fatal error: ../tests/tcg/x86_64/system/boot.S: Permission denied
> compilation terminated.

Try the v2 I've just posted. That fixed up the handling of mapping your
host user id into the container so there are less surprises when it
writes to the mapped volume.

  https://patchew.org/QEMU/20260915201601.1207839-1-alex.bennee@linaro.org/
=20=20
--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

