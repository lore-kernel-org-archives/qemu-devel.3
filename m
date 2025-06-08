Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 890D3C5AD49
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Jun 2025 08:23:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOBJP-0001Is-BF; Sun, 08 Jun 2025 04:23:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <oleg.tolmatcev@gmail.com>)
 id 1uOBJN-0001Ii-M0
 for qemu-devel@nongnu.org; Sun, 08 Jun 2025 04:23:25 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <oleg.tolmatcev@gmail.com>)
 id 1uOBJL-0008UE-Vr
 for qemu-devel@nongnu.org; Sun, 08 Jun 2025 04:23:25 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-54b09cb06b0so4057435e87.1
 for <qemu-devel@nongnu.org>; Sun, 08 Jun 2025 01:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749371002; x=1749975802; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qhuTqEJHVq0IQXwL1zAbw52oRmEOu1jWaD8FSlZiSfA=;
 b=F5ZFHmMokLFB+B2jgZ88KrsJdFx2txFa/WfzugA9qvN2UG5Ic3A59K49OnOq/ZwNRd
 9JijVdU6lPPxsloJRNuNQgJFV6h4r4qViEgB+UtmNvNYwuGyqSyY48ctFAAxskSwmr+Q
 VFfLZzDA6P2SAJ53sRoQGlDMsvO12oTK/VA6Dsx8kKC8Q9EHxa1+7ozD+u+Q9IXclUBf
 ANtIGo7Td7T0JOpJtGpAoxGegjJJ9/1rf5AwKN62gTuQLRspdlIu/VggTByzoAQUJmh7
 dSetyBAr7gCc2qGWiNDOjlES2IDsfFE9vF0yRHenoYh/HI1EX01XNWdZRPPZJLOI26aC
 2v2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749371002; x=1749975802;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qhuTqEJHVq0IQXwL1zAbw52oRmEOu1jWaD8FSlZiSfA=;
 b=WCPpdo4pqRSiA6ufPNC3w0/GC76S8GhJwjI7cX4Jgqrzh+qrENoJieFMS7UIIi1Z12
 asFMBzUjL5pE9izs61OFDMr8DKGZx/aRq18IZkDvCMxALsw/Oa44QDEfnR4gvBpdqUnW
 wrv9EtqWWB3Og54RzbdiQxO9sfnR37AxfVXw93o1Fqo24GPQYZxvf++Z18ZmoqqRWxJu
 BNC+nW5Dftkpn0tSJAMQpsRAPVBXQ9rAXhB/Aa9X2BMn6nKNCHjIH49adjds2rKsIzlx
 ma+6dNZs3vJ/Uu043dAyDDZNnJya5vs3Xs7+it7c0BoxqEaJ3VkF7AG4kE9iARwttG7p
 Jnkw==
X-Gm-Message-State: AOJu0Yxx4KYx1kcLlpM2F1spG6lPhRXOaHMJN4CqPXZvWKaKNhI1sBKT
 IQJA+Un0Pw0uqFVaQNnhOE82oticLGUd7keUGXOwwQbfHoFC/mdbF+g2ITCyxxMqz5YOdeR4EJW
 lFqZFPBoDfkHefTwJen8sNmkpydUhN2M=
X-Gm-Gg: ASbGncsao80EqymJuzsNPPMBcy/rek7U4IqPCFQH/2GXTUT/nzTairEcbZh0TTIWRwT
 3SztQkz+vpt9TSu3ss4KwaK8BUhUbYrDz9zMl0lkto8FIJDuaTrngddIgERkgCyduGGCqznOfqN
 p8PDnxfHl4s51fZxya3xuCWfVduf1LszV4nK0Mq22ZToxy0FjLpORkf1BYkY1BDXQT24Takj3j4
 W0=
X-Google-Smtp-Source: AGHT+IGZUWQ0kd8iWzJWV+/AI5UvZ9OzAomedCiouvo1ZEJ8iEpXIbUUhQGT0YQYPc6zn/9ZlmbRi5a+IITYSCW34Es=
X-Received: by 2002:a05:651c:b12:b0:32a:7d4a:6182 with SMTP id
 38308e7fff4ca-32adfb417c9mr23660821fa.10.1749371001513; Sun, 08 Jun 2025
 01:23:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250607094503.1307-2-oleg.tolmatcev@gmail.com>
 <878ac7c5-6729-4930-a64f-19cf0e10f7f2@linaro.org>
In-Reply-To: <878ac7c5-6729-4930-a64f-19cf0e10f7f2@linaro.org>
From: Oleg Tolmatcev <oleg.tolmatcev@gmail.com>
Date: Sun, 8 Jun 2025 10:23:09 +0200
X-Gm-Features: AX0GCFuFFU4JYzvOV1kqgLwnSioz0hfbCsjyRlYCGwGTwEDlFrUarp5RAlXMZ64
Message-ID: <CACcXsZgSdLNUovP_Cz7vAU+E=KzaJ6tLCKFhm1xQpQpKO5h=2Q@mail.gmail.com>
Subject: Re: [PATCH RESEND v3] meson: fix Windows build
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, 
 Mads Ynddal <mads@ynddal.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=oleg.tolmatcev@gmail.com; helo=mail-lf1-x12c.google.com
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

Am So., 8. Juni 2025 um 02:43 Uhr schrieb Pierrick Bouvier
<pierrick.bouvier@linaro.org>:
>
> On 6/7/25 2:45 AM, oltolm wrote:
> > Sorry, I forgot to cc the maintainers.
> >
> > The build failed when run on Windows. I replaced calls to Unix programs
> > like =C2=B4cat=C2=B4, =C2=B4sed=C2=B4 and =C2=B4true=C2=B4 with calls t=
o =C2=B4python=C2=B4. I wrapped calls to
> > =C2=B4os.path.relpath=C2=B4 in try-except because it can fail when the =
two paths
> > are on different drives. I made sure to convert the Windows paths to
> > Unix paths to prevent warnings in generated files.
> >
> > Signed-off-by: oltolm <oleg.tolmatcev@gmail.com>
> > ---
> >   contrib/plugins/meson.build         |  2 +-
> >   plugins/meson.build                 |  2 +-
> >   scripts/tracetool/__init__.py       | 15 ++++++++++++---
> >   scripts/tracetool/backend/ftrace.py |  4 +---
> >   scripts/tracetool/backend/log.py    |  4 +---
> >   scripts/tracetool/backend/syslog.py |  4 +---
> >   tests/functional/meson.build        |  4 +---
> >   tests/include/meson.build           |  2 +-
> >   tests/tcg/plugins/meson.build       |  2 +-
> >   trace/meson.build                   |  5 +++--
> >   10 files changed, 23 insertions(+), 21 deletions(-)
>
> Are you building using msys2, or another environment on Windows? I'm
> curious to know in which configuration the build is failing.
>
> In case you use msys2, maybe you're simply missing some packages. Our
> documentation explains what to install [1].
> Building out of msys2 on Windows is not recommended, as this is the only
> maintained setup (tested in our CI, and maintained as an msys2 package
> by msys2 maintainers) for this system.
>
> [1] https://www.qemu.org/docs/master/devel/build-environment.html

Yes I do use msys2, but I only use bash for the initial configuration.
Afterwards I just call meson and ninja from "cmd" not from bash.

