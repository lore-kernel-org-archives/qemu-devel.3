Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F29EC2BA18
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 00:51:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKSUw-0007Oo-9P; Thu, 20 Jun 2024 20:51:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wzssyqa@gmail.com>) id 1sKSUu-0007OT-4k
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 20:51:24 -0400
Received: from mail-yb1-f182.google.com ([209.85.219.182])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wzssyqa@gmail.com>) id 1sKSUs-0007pA-Ey
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 20:51:23 -0400
Received: by mail-yb1-f182.google.com with SMTP id
 3f1490d57ef6-dff305df675so1691080276.1
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 17:51:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718931081; x=1719535881;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6PJpxSuIgeoQ0RrXALbIzl4nASGVHq4DerIIWlI2R3c=;
 b=UU8E3HLwVW76fti6yiHHW0c7aLm1//Un3hXJxqpdEgZyDT1KIbAs1hlaXg1X8DomBi
 aDRIXwjFSaBKvyKTIgmctLg7QwwvJ2DT2FpsFjfO4O83gqTuf/c+kvSvddCOmHs4HJna
 QrT/FNOfYacrnDGe+Bsgs7xwJ1oVkeg06Pwnd9uSNB9tstRe879ESVOrBgr+vvLntQej
 ac5DQ86N7dgVJkS4/JjkbvL8kKXSzsb7xYiR/98IX3YHEt6A3ke3arp+drIV35lOJYPn
 mfszrLs2DxqMxcrq75ZE168YlmyH3WkG4tm+HHNe/x29vjsFF19r3K9BZe9HRq+YsQl3
 PKwQ==
X-Gm-Message-State: AOJu0Yzqjq2F0F4meD1MVf7rwfbQoqkSM/BftW92vmpKNn2IHg015dF6
 reScfo/aWxwSgoxEPEgR2Ji3XPuTQRdrfg/ENLcRKtUaVHY6QBW5laSrEXAUT1Saut5Vpbr5wws
 AGuRc3MMEDlbhdYGk1qFidsQXSu8=
X-Google-Smtp-Source: AGHT+IGhTlQSzE6Vu+zliRai37+6g9uuEzLxbYk+BvXEvk/0pAH3tAlGcqagYmOLHQiXnZbcCT2SedSy192ruCoQZ4I=
X-Received: by 2002:a25:e004:0:b0:dff:29fc:3094 with SMTP id
 3f1490d57ef6-e02be2302e1mr7123013276.63.1718931081048; Thu, 20 Jun 2024
 17:51:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240620234633.74447-1-syq@debian.org>
 <alpine.DEB.2.21.2406210124020.43454@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2406210124020.43454@angie.orcam.me.uk>
From: YunQiang Su <syq@debian.org>
Date: Fri, 21 Jun 2024 08:51:09 +0800
Message-ID: <CAKcpw6Vc9QkHWGxJmJwipaqEnGJZsPof7k25i9e1trtCTDVc=A@mail.gmail.com>
Subject: Re: [PATCH] mips: pass code of conditional trap
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: qemu-devel@nongnu.org, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.219.182; envelope-from=wzssyqa@gmail.com;
 helo=mail-yb1-f182.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Maciej W. Rozycki <macro@orcam.me.uk> =E4=BA=8E2024=E5=B9=B46=E6=9C=8821=E6=
=97=A5=E5=91=A8=E4=BA=94 08:41=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, 21 Jun 2024, YunQiang Su wrote:
>
> > Linux and We use the code of conditional trap instructions to emit
> > signals other than simple SIGTRAP.  Currently, code 6 (overflow),
> > 7 (div by zero) are supported. It means that if code 7 is used with
> > a conditional trap instruction, a SIGFPE instead of SIGTRAP will emit.
> >
> > But when `gen_trap` we didn't pass the code as we use `generate_excepti=
on`,
> > which has no info about the code.  Let's introduce a new function
> > `generate_exception_code` for it.
>
>  I haven't touched this stuff for ages, but AFAICT the code is already
> passed where applicable via the environment for `do_tr_or_bp' to handle,
> so I can't understand why your change is needed.
>

The error_code in env is always zero, as we need to set it here.

>  What problem are you trying to solve?
>

See the talk in GCC mailing list about testsuite/ubsan/overflow-div-3.c
Qemu emits SIGTRAP instead of SIGFPE, due to it didn't initialize the
code of conditional trap to env.

>   Maciej

