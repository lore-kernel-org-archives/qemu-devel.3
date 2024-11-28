Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35639D6D25F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 04:12:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGVre-0005VF-Gb; Wed, 27 Nov 2024 23:10:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tGVrc-0005Up-7s; Wed, 27 Nov 2024 23:10:48 -0500
Received: from mail-ua1-x92d.google.com ([2607:f8b0:4864:20::92d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tGVra-0008Sv-Gs; Wed, 27 Nov 2024 23:10:48 -0500
Received: by mail-ua1-x92d.google.com with SMTP id
 a1e0cc1a2514c-85700f9cdd6so83230241.1; 
 Wed, 27 Nov 2024 20:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732767045; x=1733371845; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OvwETGxHHPabbWHbeybLTQw6ekkmN+BAnjikE+lmtZc=;
 b=GfDwU5/ZdrmpKyO3R2fpI679JwdUZQI+b7HUkWn51yMWiOrjxR6WDrIcPDG1zj0g7M
 FmBxVzUJBGCg6DXmxNgghfdtwhgWZCS+uDeckeTAvUF2EPYp3xQEebwYG0Nomg7baWco
 bem2C2StDyLdf9+kcwBx6GIzmNceOPieOo91//1F0UfrBZc4rZ11XDjp3yWNZ/CH4xfF
 P3IcXqEytMve8XOUdZKf9E6H2xmZxQHgDxInqddbHQV9zR0tejLv16YzWhlM3lTkukLv
 Ylqdaiwzf0C/aZ8Xt36ZGSJQHzXGKous6sETDa5IOp5MyYcM26ul6mU1a9dHZQ87ghi6
 NFWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732767045; x=1733371845;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OvwETGxHHPabbWHbeybLTQw6ekkmN+BAnjikE+lmtZc=;
 b=ZVHe+nSVR2zgrp5PALiqlmLB8OCNevkWgn1dSF3fY4WUEc+PdBD+WCGQA4CQlxS7y3
 2Nf+kSkto9+8TzrYTdDRBVdqyhtWTIK+ZKRX9+ZtEQiRkGOX5FHf8Jcash3R78EXofZm
 Zd9nPOUOxTzJhLXxpI0i61mOfIERyLmHg7063eieTYY8Ca98V9Est0OMB1WGGs/hO+oK
 q8RKnixU0Jrlid4Hngh6E83z8ZWbqb6m7LhpNIsiVGkYuo5tdvSVHwpUAuSHcchdeWAF
 XsDHXCHZzCGCgrfU9huDmovcGXdHnniAJIWb0v3dwQsC5/PR+3Gpyh6i+QwxYYdr6IaM
 D0Cg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVn7e/5cZcatwtNzDOJ6/qOrjESUVJp+8qqA+7diqbwFLS3K/Uusi3JhdCGoQ5i4d8lY9vVLD0BOAhb@nongnu.org
X-Gm-Message-State: AOJu0YzflAzUoG//0nGNq/GOKwsaSL5V/RF1o1Ykt5icUtgEGxfEc82c
 xzehvKYMXboaOqYoUg6YVyevLl7t5WwUbUXpxijfM2tDemJkzSCHdVwvVnId4HSUKzVPoVexp8z
 srLKXPxgMogcDLFOYNHdpsUV9ofw=
X-Gm-Gg: ASbGncvOZMmOrsDmkKy7JRHj9Jpg7vQCSkVFOtkvoD1Xjj5rhlCclg8CZ8Oj4yd5RUb
 bNwoZcwQgajvmxO6PMFUp/xSUcU0uWKKMB+M6mIXhhi1i+916EbrKm0eIHjOPmQ==
X-Google-Smtp-Source: AGHT+IFnLYRS5FFtZPRx2bln8i55Zf4mulpWTVcnpFWmYJgN/dTDt5RCPcTZhL0Y04k+i5Un7E5LTE35eiXyy+KWxSI=
X-Received: by 2002:a05:6102:5e7:b0:4af:4902:153e with SMTP id
 ada2fe7eead31-4af4902166amr4631113137.9.1732767045023; Wed, 27 Nov 2024
 20:10:45 -0800 (PST)
MIME-Version: 1.0
References: <tencent_6FF30F7E2E640BEE260FD6523B6BA5486908@qq.com>
 <CAKmqyKMP093GyTEHdAPzaV9+O_pFSv0svQRb-31QTvn9i4fxMA@mail.gmail.com>
 <tencent_B97DED0E6971DEDD2F960CC63DFF414A2A05@qq.com>
 <CAKmqyKO6Wjknoc1sXVm6d0BGzwcuF7VBqJdg_a1gh=6zz=KZNQ@mail.gmail.com>
 <tencent_E6B51EACA466D65291C0E6BDFD34C8EADC09@qq.com>
In-Reply-To: <tencent_E6B51EACA466D65291C0E6BDFD34C8EADC09@qq.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 28 Nov 2024 14:10:19 +1000
Message-ID: <CAKmqyKNOXNpfekTPNOyHyYEuCXKOewCeTSFZAHpsxuC7gUzpGQ@mail.gmail.com>
Subject: Re: [PATCH] include virtualization mode as part of priv
To: Yanfeng <yfliu2008@qq.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Weiwei Li <liwei1518@gmail.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92d;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Thu, Nov 28, 2024 at 2:05=E2=80=AFPM Yanfeng <yfliu2008@qq.com> wrote:
>
> Alistair.
>
> My initial `git send-email" on Ubuntu 22.04 wasn't lukcy:
>
> ```shell
> $ git send-email
> git: 'send-email' is not a git command. See 'git --help'.
> ```
>
> I need time to find a solution.

You will need to install git-send-email (or something like that)

>
> As for seperate `virt` thing, my concern is that though the V and P statu=
s looks
> orthogonal, they are not so independent (e.g. `P=3D3` implies `V=3D0`). H=
aving them
> in one `priv` register tells user that that they should be operated toget=
her
> using one command.

True, but how can a user know what bit 8 means?

Alistair

>
> On Thu, 2024-11-28 at 12:43 +1000, Alistair Francis wrote:
> > On Thu, Nov 28, 2024 at 11:43=E2=80=AFAM Yanfeng <yfliu2008@qq.com> wro=
te:
> > >
> > > On Thu, 2024-11-28 at 10:39 +1000, Alistair Francis wrote:
> > > > On Thu, Nov 28, 2024 at 12:09=E2=80=AFAM Yanfeng <yfliu2008@qq.com>=
 wrote:
> > > > >
> > > > >
> > > > > When debugging hypervisor extension based programs, it is conveni=
ent to
> > > > > see
> > > > > the
> > > > > current virtualization mode from GDB debugger.
> > > > >
> > > > > This patch shares the virtualization mode as part of the existing=
 "priv"
> > > > > virtual
> > > > > register, or more specifically via bit(8).
> > > >
> > > > Interesting concept. This seems fine to me, I don't think this will
> > > > break any existing user.
> > > >
> > > > Another option though is to add a "virt" virtual register, which mi=
ght
> > > > be easier for people to figure out as it isn't obvious from GDB wha=
t
> > > > bit 8 means. That might be a better approach as then it's really cl=
ear
> > > > what the register means.
> > > >
> > > > >
> > > > >
> > > > > > From 0d82561b11e1c2835f14ba5460cfff52f0087530 Mon Sep 17 00:00:=
00 2001
> > > > > From: Yanfeng Liu <yfliu2008@qq.com>
> > > > > Date: Mon, 18 Nov 2024 08:03:15 +0800
> > > > > Subject: [PATCH] riscv/gdb: share virt mode via priv register
> > > >
> > > > It seems like something strange happened when you submitted the pat=
ch.
> > > > Can you fix this up?
> > > >
> > > I prepared a patch file via the following steps:
> > >
> > >  - Did  `git format-patch --stdout -1 > /tmp/patch`,
> > >  - Pasted the /tmp/patch content to email composer window,
> > >  - Filled in email receipts, subject line and a few lines before the =
patch
> > > context in composer window.
> >
> > You should use `git send-email` instead, see the QEMU documentation
> > for more details:
> > https://www.qemu.org/docs/master/devel/submitting-a-patch.html#submitti=
ng-your-patches
> >
> > >
> > > I am wondering if the lines added before the formatted patch content =
in last
> > > step caused trouble?
> > > When resending email, should I use [patch v2] in subject line? I gues=
s it is
> > > unnecessary as it is the same patch.
> >
> > Ideally I think a "virt" virtual register would be a better approach,
> > so if you could do that instead and send a v2 that would be great :)
> >
> > Alistair
>

