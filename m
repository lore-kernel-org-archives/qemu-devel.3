Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7B6BC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 17:24:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1roo2z-0002cr-As; Mon, 25 Mar 2024 13:23:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1roo2x-0002cU-Q7
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 13:23:43 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1roo2w-0003R0-7f
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 13:23:43 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-566e869f631so4959062a12.0
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 10:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711387420; x=1711992220; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bxJC7Jx+mu0rY+TR3t6yE9GdKnZRDKzUQRNsRAMDHsc=;
 b=VB/dqA1uFEhkhsMYPNxmpLAZMhEfmhrxtTuEmsYF9ID5gc8PE/Y96ugNF3ntEDzNUG
 ORskJQDsdKo5dcxUqFIp5uYMqr8YrjvZAA2QnC8ex6Jb0j6FhPDuUXHuIL9pvmPZVP+T
 AaWKxXhIKrzcIQ83iTc0WhlenmPCPFfQGIsRGMVv1DLYERVogjn1qFwsm8aO64mumkME
 3/0yrDCxVD9sA2Uw+p5YX4FJGzZ2E/fShOQ00U6Jd46xt1E15KNYHzyjc4sFpOZ/JaOW
 ScxKNBUwQlHOJzDievlt+FhvmXH4FX3mrAQEaoCz9xkHPkg11oEKZakCOuTahb0D3h/7
 HV2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711387420; x=1711992220;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bxJC7Jx+mu0rY+TR3t6yE9GdKnZRDKzUQRNsRAMDHsc=;
 b=XsFVBZF+7bXpiMC8pNBXWaBp//3CHRDS9+IUceHBODFK8HxbXNStH7gcXYoNR+JHm9
 /Y6pGN0EQ2ZyS1TGuBqo8scpUE9D7O6pjjsgUh9W4iJoDGIOh54XERfx80Fp2FB4SxWE
 65u5f2v2LI/Hr/Kh+pzir9BIHa/yCj2emBCm3CyJFbYwr6ln4ZWonaqYUck+QIQC4hwc
 4TkURnyiDBqtsLFsglfEaUPog5OIGPiP/MSciy1ms1pKh1PkKfg7EeA2JO+SIVEQiPOH
 SBkKyzE0630nb+0qmQva9O7mODJMg/z9Wma75nysMuGj8aD6tBcGAK7X/Ie0UJSqjfb7
 3oaA==
X-Gm-Message-State: AOJu0YzUrKdneECwt5K/jHYDlPP7Tvjls3XDcd+DdhfW6YQxvgDFZnHf
 D5bfMAF1cpDaQcNYNNXeNrtYrvT1VB2KCvuXFVzxo05cEiMKv6bZ5e9wBohY5PMIyqykJyKbbqk
 LuUGc/h+AUUkSB5VWJ+6jFhO+oz9SWpF08kMoyw==
X-Google-Smtp-Source: AGHT+IF9x0ApcrhVLHNfGPqjgRRuwb4PTCYZ+Pfu2SNMfespyUtyvaWjcxkNfodpCDCxlHWhNUTxQ4/9vMnaoJlVD0o=
X-Received: by 2002:a50:bb2e:0:b0:56b:d158:7fbf with SMTP id
 y43-20020a50bb2e000000b0056bd1587fbfmr6062359ede.15.1711387420631; Mon, 25
 Mar 2024 10:23:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230812061540.5398-1-akihiko.odaki@daynix.com>
 <fbc4b1e3-c504-4d79-b803-a23c866361e8@daynix.com>
In-Reply-To: <fbc4b1e3-c504-4d79-b803-a23c866361e8@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 25 Mar 2024 17:23:29 +0000
Message-ID: <CAFEAcA8_HER5ipM7rbYY=JLwNPsi6AdqyJwOdD4CHq=rViD8BQ@mail.gmail.com>
Subject: Re: [PATCH] meson: Fix MESONINTROSPECT parsing
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Sat, 12 Aug 2023 at 13:10, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> On 2023/08/12 15:15, Akihiko Odaki wrote:
> > The arguments in MESONINTROSPECT are quoted with shlex.quote() so it
> > must be parsed with shlex.split().
> >
> > Fixes: cf60ccc330 ("cutils: Introduce bundle mechanism")
> > Reported-by: Michael Tokarev <mjt@tls.msk.ru>
> > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > ---
> >   scripts/symlink-install-tree.py | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/scripts/symlink-install-tree.py b/scripts/symlink-install-tree.py
> > index 8ed97e3c94..b72563895c 100644
> > --- a/scripts/symlink-install-tree.py
> > +++ b/scripts/symlink-install-tree.py
> > @@ -4,6 +4,7 @@
> >   import errno
> >   import json
> >   import os
> > +import shlex
> >   import subprocess
> >   import sys
> >
> > @@ -14,7 +15,7 @@ def destdir_join(d1: str, d2: str) -> str:
> >       return str(PurePath(d1, *PurePath(d2).parts[1:]))
> >
> >   introspect = os.environ.get('MESONINTROSPECT')
> > -out = subprocess.run([*introspect.split(' '), '--installed'],
> > +out = subprocess.run([*shlex.split(introspect), '--installed'],
> >                        stdout=subprocess.PIPE, check=True).stdout
> >   for source, dest in json.loads(out).items():
> >       bundle_dest = destdir_join('qemu-bundle', dest)
>
> Please do NOT merge this. This will break Windows builds. I'm putting
> this patch on hold.
>
> The problem is that Meson uses a different logic for escaping arguments
> in MESONINTROSPECT on Windows. I'll wait till Meson maintainers figure
> out how MESONINTROSPECT should be used. For details, see:
> https://github.com/mesonbuild/meson/pull/12115#issuecomment-1675863266

Am I correct in understanding from
https://github.com/mesonbuild/meson/pull/12807
that the eventual resolution that Meson upstream decided was
to restore the behaviour that regardless of platform the right
way to split the file is shlex.split()?

If so, then I think we should resurrect and apply this patch,
since at the moment configuring QEMU fails if, for instance,
the build tree directory name has a '~' character in it.

thanks
-- PMM

