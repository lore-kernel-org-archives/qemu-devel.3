Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 471E7C5B549
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 17:47:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKKsE-0000Sy-3b; Wed, 28 May 2025 13:47:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uKKrk-0000PX-Ja
 for qemu-devel@nongnu.org; Wed, 28 May 2025 13:47:03 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uKKri-0000Yc-RO
 for qemu-devel@nongnu.org; Wed, 28 May 2025 13:47:00 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-602346b1997so123953a12.3
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 10:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748454417; x=1749059217; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X1Rzh41I+98qG8RvMraEDnjUmI91LTpIvd0zrx4uw/Y=;
 b=JUSLy5ze+js8SG6sdZUqlQ6dOpe9LO1X2ze5TgrsbRLwkPLrl0carUeKvBLtsOpfHO
 E5zqA1XhQAZFLev3xGOJmGfiHFY9rTqBV6jwUZdXtRgIb8k0/QVE/wAAbe49IDzJn0FK
 00WPgaegwSyLtNyJn9sbgKszIyASEo5lxFsPDXzwva11wSAKZ11OahHFZfPjSyac1f7t
 sQ9qLwEY3wX5T36vEttGMiKINSMwNBsZelXtPgwNStQ8jbV5NujA10ceu57r2p/NQkSG
 Mah5tJUtTAwwV0RW6PRgHVvRq0u9BSdGxj9QBBpqd9M++/nuUC3sD153Ff/DiTkUfu++
 9OwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748454417; x=1749059217;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X1Rzh41I+98qG8RvMraEDnjUmI91LTpIvd0zrx4uw/Y=;
 b=hz9QS5hLY7+VB9jxF53st2WIoJM42kAmqJo6G25wUiO45v2Bd23N3Nz2VTVx03NQJJ
 P66CN4rRN32C4lz5yGuGZEDx4KyM2815h3HfLfP7rgjttdCM/G720D6o7Z/Ne4Le3aQ1
 aJkUnfacsLpm6+OWd85SsuIvuPsSVUnjs0uQznhVjKs15fS1U8X9bOVR6uvBVQBKoXMV
 Q16dbVL5VrNzT1aL05jO4u9RXRpiYY9bRAGuPE1urOpBwAHYZSKYFFrpuDVxCOqJNpTj
 S36OTeP5175yUpSQGZuk3KNOYsIMFa2GkJodM4OuHbBlt8JqwNKH5odAMQzIpZ1aL0ty
 aLrQ==
X-Gm-Message-State: AOJu0Ywd2i+aSSWFtaAF9/xkoyVImqfWnIXrymD8myOA0DJHkPDvqXCw
 Q4IH9AKGY67tShEKSZEKavVpE9ChG1q9ZmVZLENBWPxKJ5IhaKiZtU9Lap8v1jQeglGAHXttGgw
 CQMJFFtI2Axv0yd/r3GZErpq0/gkxyeU=
X-Gm-Gg: ASbGnctbIlyHoI/d83GeRsk2dzJGyl2cD7xLg3VeWDFLEFSbquoLaBq7LEozNUaoeyc
 1YhxikjCdsDOqK7lTwzvOO4aZVCtlu1rZ+/u77AYNiftc5zWLev3uUTjpokAXeRyKEJMmlvtfsz
 VX3h6EHrb3rqQhpJ2OXiN8ZSK/27kdIXxECnd6gxH/6g==
X-Google-Smtp-Source: AGHT+IHNo0AgVfzeDPVnmDftcmQolT0+9nhiCFYDnxpb9QrxQKaHdzHYP8dVAun7uRMhQANfPt4z4+kMZ3VFWA3gvJY=
X-Received: by 2002:a05:6402:430d:b0:602:1832:c188 with SMTP id
 4fb4d7f45d1cf-602da303499mr13792109a12.21.1748454416488; Wed, 28 May 2025
 10:46:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAJSP0QXoQBbA-HATMo0OTLOnUcvYjHiUM2nmAQj1i=ZXkbStoQ@mail.gmail.com>
 <CAFEAcA_A36=RrQ2K+kLQgwVRdT=dFJkPW4vTsQn9RZ7FJMpktQ@mail.gmail.com>
In-Reply-To: <CAFEAcA_A36=RrQ2K+kLQgwVRdT=dFJkPW4vTsQn9RZ7FJMpktQ@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 28 May 2025 13:46:44 -0400
X-Gm-Features: AX0GCFuBpvqG6_v_o1SuTZNYcsuSG9Ici9986V9xkUY5Pro-j1w8joepkn63Nu0
Message-ID: <CAJSP0QWV+fauoNAjy+DD=seG3fCAv5Ca7-WZz9dKewq47YAQag@mail.gmail.com>
Subject: Re: QEMU 10.1 release schedule
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Daniel P. Berrange" <berrange@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x530.google.com
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

On Wed, May 21, 2025 at 3:37=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Wed, 21 May 2025 at 19:30, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> >
> > Hi,
> > Daniel Berrang=C3=A9 has proposed a release schedule that looks good to=
 me.
> > The release will happen just before the KVM Forum conference.
> >
> > Please reply if you have any questions or concerns about these dates!
> >
> > - Soft freeze: 2025-07-22
> > - Hard freeze (rc0): 2025-07-29
> > - rc1: 2025-08-05
> > - rc2: 2025-08-12
> > - rc3: 2025-08-19
> > - Release or rc4: 2025-08-26
> > - Release if rc4 was needed: 2025-09-02
> >
> > https://wiki.qemu.org/Planning/10.1
>
> Personally if I were running the release this time around I
> would move everything a week earlier, to avoid the potential
> need to do a release the week of KVM Forum. (My experience is
> that "we need an rc4" is the common case.)

I was waiting to see if there were any other thoughts about the QEMU
10.1 schedule.

Let's move the schedule forward by 1 week to leave some breathing room
before KVM Forum. Thanks for the suggestion, Peter!

Stefan

