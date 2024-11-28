Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CB96D3B9BD
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 04:47:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGWQs-00050g-5m; Wed, 27 Nov 2024 23:47:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tGWQq-0004w6-Nu; Wed, 27 Nov 2024 23:47:12 -0500
Received: from mail-vs1-xe31.google.com ([2607:f8b0:4864:20::e31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tGWQp-0005G6-3j; Wed, 27 Nov 2024 23:47:12 -0500
Received: by mail-vs1-xe31.google.com with SMTP id
 ada2fe7eead31-4aef56c5cf9so103458137.0; 
 Wed, 27 Nov 2024 20:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732769229; x=1733374029; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tSIbx3HdbhsA3qTAos5PpU9eba5valjXPmSUDFRjD28=;
 b=a9CmRGREbFP1tbrXOqAIqcdRcDIA3aU9l3I0XxU1o/+SCoZ5WludrIT9Xwun0iynlH
 sCGuXy/+QOaq7lNDuulx5dp0qSAOn2Va+2a7T0HSfTAVwguJD48cMyvvda09q3Z7Oftd
 m4yxpx609Bm4B4LwGWXwCiBJOi876gU/YJTqRKZezHqF56RhRYpEgkqzoKgwA3QJW+u7
 FC3aw7eP907aV/AmdTXjkD+yH1dFD1mqoYaur0HrLUSD9QbMBhFpZm8XLMsHUt97df2A
 60oaXxCcYTQ6dS892dPkAi8YiGYjagb6vRpnFY/ni7ofWWaoOv6jCjX21/fGzYOC69bN
 FuoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732769229; x=1733374029;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tSIbx3HdbhsA3qTAos5PpU9eba5valjXPmSUDFRjD28=;
 b=MvlWvtMTrz+VfqgFiF4rfZ9jiTJ3ychOC6TxEI0oL9aqdFxs0Iwy7e0Cj1O+r7V7AM
 IQohqpqPEj7cIpw4xvcuk5Jgxdjaqhdg+lrStNXQWPCJJQn5IcangRs0aZYYN5srUh7a
 mW2qrQJHm0P3nLmsQjqsK9jpLC/Apuf2DLuOl4MuGr1eDtHO+K6x6Cx58RFKuJZkoRal
 gQzUt+1K8Lg7fD6hjaGpUdIGP2RDxy8Nh8YdhjvZa7BrTnUNQQjZF/vGkxlXSIODTu42
 zC16WJFXRloGkwBba7H5116TV4k5nAq9BTVCuVdTbw9j7UxCMTI+qLYj8RvKxfnZG57r
 uOHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVw3oZdgHa8GGFg4QjLjqRzYWg+Q169uYK7Nvl1c4hn5MNMz+GWonufQq367ixr5hZ45sm//P8prvVd@nongnu.org
X-Gm-Message-State: AOJu0YyLSjb3iFRdlncD7f6T3L6lmFrDEs2VthofgyXWNiQsKZiR2j30
 vVkv1vAJRAJpRm1MOE76riPAMCzLFaSq++ydFtV6oE2bI1IjtdmqKJmdtIdxBvVCj65KZi2mtWl
 GgRrxwmxo9sYt4Ko4Ywcn7PvUGXs=
X-Gm-Gg: ASbGnctOugF3vM8Al/U1MomzsY+iZ+mmCxQeJtS9lIryzPpJkO/fTopK05QGTPYCCAJ
 KvEV23iZXzJhxPnowdo4jGDiZKQqjydGvYSJ5Ho98y6KlofNjUc9MRL0/n+jIEg==
X-Google-Smtp-Source: AGHT+IGki4MacOAyqeSaiBd71uvd/r3XhLLn1HPn1L0a/OQ5bs4+O2eKgtJyX0Cwt1KgJ7dlltilO3uPfsZm9CuAgNE=
X-Received: by 2002:a05:6102:a50:b0:4af:4ec3:cd17 with SMTP id
 ada2fe7eead31-4af4ec3ceaemr5491280137.0.1732769229528; Wed, 27 Nov 2024
 20:47:09 -0800 (PST)
MIME-Version: 1.0
References: <tencent_6FF30F7E2E640BEE260FD6523B6BA5486908@qq.com>
 <CAKmqyKMP093GyTEHdAPzaV9+O_pFSv0svQRb-31QTvn9i4fxMA@mail.gmail.com>
 <tencent_B97DED0E6971DEDD2F960CC63DFF414A2A05@qq.com>
 <CAKmqyKO6Wjknoc1sXVm6d0BGzwcuF7VBqJdg_a1gh=6zz=KZNQ@mail.gmail.com>
 <tencent_E6B51EACA466D65291C0E6BDFD34C8EADC09@qq.com>
 <CAKmqyKNOXNpfekTPNOyHyYEuCXKOewCeTSFZAHpsxuC7gUzpGQ@mail.gmail.com>
 <tencent_3335F7F1076629E3B507A48979413F43B207@qq.com>
In-Reply-To: <tencent_3335F7F1076629E3B507A48979413F43B207@qq.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 28 Nov 2024 14:46:43 +1000
Message-ID: <CAKmqyKNS3GWKpatFMchYJM31PtgjLn9YX+m_L8Nv=qXNMXhWmw@mail.gmail.com>
Subject: Re: [PATCH] include virtualization mode as part of priv
To: Yanfeng <yfliu2008@qq.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Weiwei Li <liwei1518@gmail.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e31;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe31.google.com
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

On Thu, Nov 28, 2024 at 2:27=E2=80=AFPM Yanfeng <yfliu2008@qq.com> wrote:
>
> On Thu, 2024-11-28 at 14:10 +1000, Alistair Francis wrote:
> > On Thu, Nov 28, 2024 at 2:05=E2=80=AFPM Yanfeng <yfliu2008@qq.com> wrot=
e:
> > >
> > > Alistair.
> > >
> > > My initial `git send-email" on Ubuntu 22.04 wasn't lukcy:
> > >
> > > ```shell
> > > $ git send-email
> > > git: 'send-email' is not a git command. See 'git --help'.
> > > ```
> > >
> > > I need time to find a solution.
> >
> > You will need to install git-send-email (or something like that)
>
> Yes, now the "git send-email" exists and I will see how to use it correct=
ly.
>
> >
> > >
> > > As for seperate `virt` thing, my concern is that though the V and P s=
tatus
> > > looks
> > > orthogonal, they are not so independent (e.g. `P=3D3` implies `V=3D0`=
). Having
> > > them
> > > in one `priv` register tells user that that they should be operated t=
ogether
> > > using one command.
> >
> > True, but how can a user know what bit 8 means?
>
> Good point. Can we mention it in the user document for `priv` register?

AFAIK we don't really have a place to document that. Which is why a
"virt" register would help as it's self documenting.

Alistair

>
> I used bit(8) at my first try and it worked from GDB command line. Actual=
ly I
> also tried bit(4) but found GDB command takes that bit as part of P value=
 so I
> withdrawed back to bit(8).
>
> >

