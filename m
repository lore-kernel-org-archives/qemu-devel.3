Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DE28C54E71
	for <qemu-devel@archiver.kernel.org>; Sat, 24 May 2025 08:47:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIkWT-0003aY-80; Sat, 24 May 2025 04:46:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <oleg.tolmatcev@gmail.com>)
 id 1uIkWR-0003Z5-0I
 for qemu-devel@nongnu.org; Sat, 24 May 2025 04:46:27 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <oleg.tolmatcev@gmail.com>)
 id 1uIkWM-0006al-Ph
 for qemu-devel@nongnu.org; Sat, 24 May 2025 04:46:24 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-551eb58b707so779452e87.0
 for <qemu-devel@nongnu.org>; Sat, 24 May 2025 01:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748076379; x=1748681179; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Y7x6duzkL2zmJbXYlWpGD++TMeuRVrhHMc3TFITH0pI=;
 b=SFBR6PDLG8/iSwcpwtivL39C9wUw+t7nscK0oEU+YztznVSGHHRWhi+lvRl8mm04lk
 H7CBMAZYs9/vIRuMIAu2hYxiMabz1T+dO5i/1JasWY+hEnS9BLPS1CMP9mJI3EqC7yxa
 I/z0qqoUI+Lg9kUJKG29XEOPTWJAiDdIGjLNgEnZGlIGD4mKWPyiSKDw5gAW4FxEQYEZ
 vIWNUqTW0wETSvF2e4z3KuAbPxoURTB54U/+EPz/MbRebD1BHpeZEd0/tIBH2XWBYdWf
 VkU6eNQ4iD3K4LKOBqVWrQWp44KOKyG4TCNmW8FrFQJAJeRvcGMB0UsKVtagG5bk90tz
 TkuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748076379; x=1748681179;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y7x6duzkL2zmJbXYlWpGD++TMeuRVrhHMc3TFITH0pI=;
 b=kTfR3eHK0v+mXjy8SkryrTM0L7IucZEwfnufSFhb/0vBDmk1xqLoXeq6+pCzTKeAwl
 PnwmW/bWSj4I5o4my4RjmupIEDzHDCyrKvN1jNZmH6Uhvlw61btkX/BD8YRZ4w2DgMsv
 wIGLuZ9AEVSJwLTLZMzmLsTtDEMVMemD/p49OfYpk1vyehswTFcnLlih9BMPGcoUhbwP
 hqLGtc3YweMysLEIf7S2nzwpno5gk45/zdNLSR4rgEVpdeYjFtMPXcQ9Tbszo7qjRvUB
 hVuUx9UFK8b0lPImWDlY020AtWsxyEiHSuE+kouR4fCM4OpC9XG5IaodvSiJvZgw2sj9
 3WKg==
X-Gm-Message-State: AOJu0YzklMfi64tToRM/IOg6M1gzRMSlc5geze568GnVlxj07vcksDeJ
 pvweH3GHUW0/TN2cCpFniRp1IncMqF/dAF8p/cTExMvO0tSquSnk0mArhQllIak9JR2eH2tFyOn
 mLK+V0y6ARSrUyfTx/xSZ9k3nqfTU2MoV1R5z
X-Gm-Gg: ASbGncs6qQJaQQBGOkEbzGPY0+2Ff5px5lkZaUsvOxc98I7iGN1py9HzDGtSR7x83FV
 VbJAHJS0ZTcSOsyTbVA1uIQRPET2XgUFrrjNLqN8yxj7CAvhK6usmkN2gBzmi3foCdExLocU451
 uGMvGjuI4WAJ0nmVRKBTPdAzFRMP+YqYGbKRsNsoLPqsS7zRt0w67x++RBL9Cx8bUe
X-Google-Smtp-Source: AGHT+IFjmGJB2XIZPSQTftHgf4wr5N7KnH0B0FcUmrLr6eYUFzeuhLa34VjTcJLul1qlkJeHfRVu8x8i0h3OZVPxKsw=
X-Received: by 2002:a05:6512:3ba6:b0:54d:6aa1:8f5a with SMTP id
 2adb3069b0e04-5521c7b9dcamr553345e87.13.1748076379176; Sat, 24 May 2025
 01:46:19 -0700 (PDT)
MIME-Version: 1.0
References: <20250523195703.168-2-oleg.tolmatcev@gmail.com>
 <250a2a35-478f-4b3e-a517-27a0cd4fb51e@redhat.com>
In-Reply-To: <250a2a35-478f-4b3e-a517-27a0cd4fb51e@redhat.com>
From: Oleg Tolmatcev <oleg.tolmatcev@gmail.com>
Date: Sat, 24 May 2025 10:46:07 +0200
X-Gm-Features: AX0GCFsD3YoV1jRiCCACkJPOxxFnc7TGubrqP3wqLYeNAlbufnXD4CTbVKW3nmM
Message-ID: <CACcXsZgADRbNG7XLcHQsH=9sU5Q6sGirqPTmQ4EKu5s0rfBh1w@mail.gmail.com>
Subject: Re: [PATCH] meson: fix Windows build
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=oleg.tolmatcev@gmail.com; helo=mail-lf1-x134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Am Fr., 23. Mai 2025 um 23:28 Uhr schrieb Paolo Bonzini <pbonzini@redhat.com>:
>
> Thanks for the patch!  The Windows build configurations that we support
> currently are cross-building from Linux and native build with MSYS2.
> MSYS2 is sufficiently POSIX-like, and also has a nice package manager.
>
> Can you share how you set up your build environment, and especially
> where you get all the dependencies?  Generally we'd prefer to have it
> covered in CI to avoid that it breaks again.

I use MSYS2, but I only use `bash` it to run `configure` initially and
afterwards I use `cmd.exe` for running Meson and Ninja.

> Some more comments below.
>
> >   import os.path
> > +from pathlib import PurePath
> >
> >   from tracetool import out
> >
> > @@ -30,6 +31,12 @@ def generate_h(event, group):
> >       if len(event.args) > 0:
> >           argnames = ", " + argnames
> >
> > +    try:
> > +        event_filename = os.path.relpath(event.filename)
> > +    except ValueError:
> > +        event_filename = event.filename
>
> Can this actually happen during the build?  (Same for other backends)

I only tested with the `log` backend.

[18/1577] Generating trace/trace-crypto.h with a custom command
FAILED: trace/trace-crypto.h
"C:\msys64\mingw64\bin\python.exe" "C:/src/qemu/scripts/tracetool.py"
"--backend=log" "--group=crypto" "--format=h"
"C:/src/qemu/crypto/trace-events" "trace/trace-crypto.h"
Traceback (most recent call last):
  File "C:/src/qemu/scripts/tracetool.py", line 140, in <module>
    main(sys.argv)
  File "C:/src/qemu/scripts/tracetool.py", line 134, in main
    tracetool.generate(events, arg_group, arg_format, arg_backends,
  File "C:\src\qemu\scripts\tracetool\__init__.py", line 449, in generate
    tracetool.format.generate(events, format, backend, group)
  File "C:\src\qemu\scripts\tracetool\format\__init__.py", line 84, in generate
    func(events, backend, group)
  File "C:\src\qemu\scripts\tracetool\format\h.py", line 70, in generate
    backend.generate(e, group)
  File "C:\src\qemu\scripts\tracetool\backend\__init__.py", line 119,
in generate
    self._run_function("generate_%s", event, group)
  File "C:\src\qemu\scripts\tracetool\backend\__init__.py", line 113,
in _run_function
    func(*args, **kwargs)
  File "C:\src\qemu\scripts\tracetool\backend\log.py", line 58, in generate_h
    event_filename=os.path.relpath(event.filename),
                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "<frozen ntpath>", line 808, in relpath
ValueError: path is on mount 'C:', start on mount 'E:'

> > diff --git a/tests/functional/meson.build b/tests/functional/meson.build
> > index 52b4706cf..2e3bd4057 100644
> > --- a/tests/functional/meson.build
> > +++ b/tests/functional/meson.build
> > @@ -413,4 +413,4 @@ endforeach
> >
> >   run_target('precache-functional',
> >              depends: precache_all,
> > -           command: ['true'])
> > +           command: [python, '-c', ''])
>
> I wonder if this can be replaced with alias_target() too; and also the
> pre-existing code suggests that alias_target needs at least one target,
> but is that really true?
>
> So, maybe all or most uses of 'true' can just go away.

I could replace this one with `alias_target()`, but it does need at
least one dependency so I could not replace the others.

Best regards
Oleg Tolmatcev

