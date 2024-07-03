Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B176C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 06:17:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOtHh-0002c3-1n; Wed, 03 Jul 2024 02:16:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1sOtHe-0002aw-FH
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 02:16:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1sOtHb-0002gR-Ht
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 02:16:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719987358;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QLSlt2ATUb/k3Krpvi4N5vqqaRrCjVDQh4056TIXvwQ=;
 b=MpxIXlvw1GIcNS891+EdA8LhJo5vdcFtJgzV6G/ubhACXLzda3J2Vo2nVGdf9Di40EGlsm
 gQJ4+Vr5H1SGASTjc3aTc76n3Cjg8jbUY7ZpR9bOLeLjYE1RQIAQ+HCjw5k0Eyo2QS4Xit
 OKzji0v79xbjHSZ9gyBG9rcvIPTuy3c=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-Tbhk2pgcNUqF9i5FyK6rxg-1; Wed, 03 Jul 2024 02:15:56 -0400
X-MC-Unique: Tbhk2pgcNUqF9i5FyK6rxg-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-44634cda251so73874501cf.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 23:15:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719987356; x=1720592156;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QLSlt2ATUb/k3Krpvi4N5vqqaRrCjVDQh4056TIXvwQ=;
 b=wsCBEXlYT7/EFNgQOiuuJ8h1NFb98NwhV5Ge8d9XZurCVOim1Zmb3wHodUA7PILLD4
 Hqkl4BDclp3u100LlGvG0EgjNB9is2Mq7JfDZFOvmqhZsza1szXVW8dPwLQBj/zxSRxk
 OMQOd3EozmPpgnFgiC+qRRPFgHqu62qaajtQk11rjvnMAevLKgf34teKJN5doSyggB0Y
 hy1PkOnF9xIH3s3UnJuKSMfGbqg6woXvlEJTH35JW+wG5Kje4louJFKt449kDXRYvUOp
 Xlg50tzTz7AdlySPsv1G7lIAXv2doHsQw17XuZDSSoCWI4lgwU/V5zAG31tEeSI0pgL3
 HQFA==
X-Gm-Message-State: AOJu0Yw+xpzK0/PAHBKMB339HkBG8q7lTlLwbEHwSNduwxL6tAG+Rlm/
 EKLJMiUQGZC5UrayaGZXZfs/SZCEgD32kOkQB/QJLlWS4j9VfxI+W7iFlxdaRx3REFTsGn0UnmE
 aTc6vDBvu+t2aM/W2dmSLPGaZwcFpylV+ki2jwIC7EONEf9wqW9kwU7CgMOT/3emK4valYpxRAv
 0PW4eOSHqsRSS++aCGVxvEPawZ698=
X-Received: by 2002:a05:622a:1a8a:b0:446:612b:db8e with SMTP id
 d75a77b69052e-44662eebe4cmr129726071cf.44.1719987356258; 
 Tue, 02 Jul 2024 23:15:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrvAu/GdcbRyY3eNMxCkG04ormej/sNUKEPvIrBPbD4gOkIWWjgrxPx71yueZLn9fdvFKbqJY9xuQ27SgvIxI=
X-Received: by 2002:a05:622a:1a8a:b0:446:612b:db8e with SMTP id
 d75a77b69052e-44662eebe4cmr129725941cf.44.1719987355921; Tue, 02 Jul 2024
 23:15:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240613150127.1361931-1-berrange@redhat.com>
 <ZoRAMXeKDObGnl4h@redhat.com>
In-Reply-To: <ZoRAMXeKDObGnl4h@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 3 Jul 2024 10:15:44 +0400
Message-ID: <CAMxuvaxKRjA=p8t_RkYT-xJag4DvnukHXhD3uS83LZ-L-OZwCQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/22] qga: clean up command source locations and
 conditionals
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Konstantin Kostiuk <kkostiuk@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Daniel

On Tue, Jul 2, 2024 at 10:00=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> Ping: for any review comments from QGA maintainers ?

Maybe you could resend for patchew to correctly handle the series.

thanks

>
> On Thu, Jun 13, 2024 at 04:01:05PM +0100, Daniel P. Berrang=C3=A9 wrote:
> > This series is a side effect of other work I started, to attempt to
> > make the QGA safe to use in confidential VMs by automatically
> > restricting the permitted commands. Since this cleanup stands on
> > its own, I'm sending it now.
> >
> > The QGA codebase has a very complicated maze of #ifdefs to create
> > stubs for the various commands that cannot be implemented on certain
> > platforms. It then has further logic to dynamically disable the stub
> > commands at runtime, except this is not consistently applied, so
> > some commands remain enabled despite being merely stubs.
> >
> > The resulting code is hard to follow, when trying to understand exactly
> > what commands are available under what circumstances, and when changing
> > impls it is easy to get the #ifdefs wrong, resulting in stubs getting
> > missed on platforms without a real impl. In some cases, we have multipl=
e
> > stubs for the same command, due to the maze of #ifdefs.
> >
> > The QAPI schema language has support for many years for expressing
> > conditions against commands when declaring them. This results in the
> > QAPI code generator omitting their implementation entirely at build
> > time. This has mutliple benefits
> >
> >  * The unsupported commands are guaranteed to not exist at runtime
> >  * No stubs need ever be defined in the code
> >  * The generated QAPI reference manual documents the build conditions
> >
> > This series is broadly split into three parts
> >
> >  * Moving tonnes of Linux only commands out of commands-posix.c
> >    into commands-linux.c to remove many #ifdefs.
> >  * Adding 'if' conditions in the QAPI schema to reflect the
> >    build conditions, removing many more #ifdefs
> >  * Sanitizing the logic for disabling/enabling commands at
> >    runtime to guarantee consistency
> >
> > Changed in v2:
> >
> >  - Make FSFreeze error reporting distinguish inability to enable
> >    VSS from user config choice
> >
> >  - Fully remove ga_command_init_blockedrpcs() methods. No more
> >    special case disabling of commands. Either they're disabled
> >    at build time, or disabled by user config, or by well defined
> >    rule ie not permitted during FS freeze.
> >
> >  - Apply rules later in startup to avoid crash from NULL config
> >    pointer
> >
> >  - Document changed error messages in commit messages
> >
> >  - Add -c / --config command line parameter
> >
> >  - Fix mistaken enabling of fsfreeze hooks on win32
> >
> >  - Remove pointless 'blockrpcs_key' variable
> >
> >  - Allow concurrent setting of allow and block lists for
> >    RPC commands
> >
> > Daniel P. Berrang=C3=A9 (22):
> >   qga: drop blocking of guest-get-memory-block-size command
> >   qga: move linux vcpu command impls to commands-linux.c
> >   qga: move linux suspend command impls to commands-linux.c
> >   qga: move linux fs/disk command impls to commands-linux.c
> >   qga: move linux disk/cpu stats command impls to commands-linux.c
> >   qga: move linux memory block command impls to commands-linux.c
> >   qga: move CONFIG_FSFREEZE/TRIM to be meson defined options
> >   qga: conditionalize schema for commands unsupported on Windows
> >   qga: conditionalize schema for commands unsupported on non-Linux POSI=
X
> >   qga: conditionalize schema for commands requiring getifaddrs
> >   qga: conditionalize schema for commands requiring linux/win32
> >   qga: conditionalize schema for commands only supported on Windows
> >   qga: conditionalize schema for commands requiring fsfreeze
> >   qga: conditionalize schema for commands requiring fstrim
> >   qga: conditionalize schema for commands requiring libudev
> >   qga: conditionalize schema for commands requiring utmpx
> >   qga: conditionalize schema for commands not supported on other UNIX
> >   qga: don't disable fsfreeze commands if vss_init fails
> >   qga: move declare of QGAConfig struct to top of file
> >   qga: remove pointless 'blockrpcs_key' variable
> >   qga: allow configuration file path via the cli
> >   qga: centralize logic for disabling/enabling commands
> >
> >  docs/interop/qemu-ga.rst |   19 +
> >  meson.build              |   16 +
> >  qga/commands-bsd.c       |   24 -
> >  qga/commands-common.h    |    9 -
> >  qga/commands-linux.c     | 1805 +++++++++++++++++++++++++++++
> >  qga/commands-posix.c     | 2373 +++-----------------------------------
> >  qga/commands-win32.c     |   78 +-
> >  qga/main.c               |  216 ++--
> >  qga/qapi-schema.json     |  153 ++-
> >  9 files changed, 2234 insertions(+), 2459 deletions(-)
> >
> > --
> > 2.45.1
> >
>
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>


