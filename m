Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AA5AC04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 05:20:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6kZz-0006YO-D2; Tue, 14 May 2024 01:19:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s6kZx-0006Xm-As
 for qemu-devel@nongnu.org; Tue, 14 May 2024 01:19:57 -0400
Received: from mail-vs1-xe30.google.com ([2607:f8b0:4864:20::e30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s6kZv-0007mI-0r
 for qemu-devel@nongnu.org; Tue, 14 May 2024 01:19:57 -0400
Received: by mail-vs1-xe30.google.com with SMTP id
 ada2fe7eead31-481e9c27378so467540137.3
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 22:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715663993; x=1716268793; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rN9zOwcyJ7Yb+dNwXyQw2mX86BWv72oI7zOd5tO7+ro=;
 b=nVVVd5nH4yZWq3vvd2r7QVjuJ9f5GJEQePh2cueznRlUEh60dcBHUyHsYeJVr8LiU8
 4PmfxlKjQcp+vjDQ1qmsaB+hMdbYZgceGpvcU7i1Gv9Ng4ZDmL/Kz4V5YXyGEvz0prWC
 XdZnCLxyXjtpqxduhKbPDc+KOnyqiStjAV+s+Uaal/taY69DvXWIxrOuf0jKkPSGP2aP
 zrR7xYHRG3M0cOitVm+IiwTmUml9XKamL+Dxx7MIZ7SlFj91+V8UJ8aYSSLIHSYwRwRh
 jONwK0VGTybrUWwjL4/OeYa/Q1Z2arfPj6xJ381VhWX+2WdNj0v6yS5ShZUfZlfQhiIk
 o1MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715663993; x=1716268793;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rN9zOwcyJ7Yb+dNwXyQw2mX86BWv72oI7zOd5tO7+ro=;
 b=icki66pQxhFi/z0kF2DcbFV7G75CJ8OO6sSzpwRdLm/lMrQelOpJYzuHDF0F30CVTF
 Ljl+TM7c7RYEoI44WIXQkFNkhaWENX41/U6CynqeGv6pxL71X/7O5w4eXvksQvtN/aMU
 MbjnaQkh4nanb6E/rFCHKsEMflk/2ciSfFpeek9xS+Ja2xXZXWJZoZCmIUu4eplA4uQH
 I/wlDHUZ6Sa+XY2/cv/GzPVsxhQZxO+d3UcGqmFFQGS1FW/PZJHI1YXocKONNd24VJPo
 cYc+Q+FGNL3InmWhvkMLEGekVyxu3Po6VlUJ/LDp0aMMHSB55P/2qN1iRzd8IIiB0Xz9
 JS7A==
X-Gm-Message-State: AOJu0YzEVgB8cuWcZlw2ZbaVF64WZ9AbFhv7/RZbFm0f+IJvkkW222t2
 LWoaNXg+iNd/6yyUgLIcmXWYHfZTMeDvwPqZhNXDOmjIk9B8i35g7TNxAl+bTFVsDSQsyApBzE0
 Kd3pUcLhrhfq6xW4zWlLkOKO8wQw=
X-Google-Smtp-Source: AGHT+IHVnlZi4ikMaIgP0Twa8es6N0JFUavdOVJ+ouASNMTgcRPsaRYQ0N9Rwhc5ntPbDeyAY/+xOanwl4JSy96Zv3g=
X-Received: by 2002:a05:6102:32cb:b0:47e:f5a5:7f79 with SMTP id
 ada2fe7eead31-48077dce359mr11767098137.2.1715663992589; Mon, 13 May 2024
 22:19:52 -0700 (PDT)
MIME-Version: 1.0
References: <183897139.5301881.1712168206289.ref@mail.yahoo.com>
 <183897139.5301881.1712168206289@mail.yahoo.com>
In-Reply-To: <183897139.5301881.1712168206289@mail.yahoo.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 14 May 2024 15:19:26 +1000
Message-ID: <CAKmqyKO_opF60yo-MVyyq8speR7A5Ugs5Y6iMxd5Ju2Jos7rxQ@mail.gmail.com>
Subject: Re: riscv disassembler error with pmpcfg0
To: Eric DeVolder <eric_devolder@yahoo.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e30;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe30.google.com
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

On Thu, Apr 4, 2024 at 5:02=E2=80=AFAM Eric DeVolder <eric_devolder@yahoo.c=
om> wrote:
>
> I've been using QEMU8 to collect instruction information on U-Boot + Open=
SBI.
>
> I'm running QEMU in this fashion to collect the information:
>
> # qemu-system-riscv64 -plugin file=3Dqemu/build/contrib/plugins/libexeclo=
g.so -singlestep -d plugin,nochain -D execlog.txt ...
>
> When examining the instruction trace in execlog, I've noticed that the di=
sassembly for pmpcfg0 is erroneous, for example:
>
> 0, 0x5456, 0x3a002573, "csrrs                   a0,pmpcfg3,zero"
>
> the CSR encoded in the instruction above is 0x3a0, which is pmpcfg0 (whic=
h also matches the code I'm examining).
>
> For the Uboot+OpenSBI code I'm examining, pmpcfg0/3 is the only one that =
appears to have a problem.
>
> I also checked QEMU9 and it behaves as described above as well.
>
> I'm willing to provide a fix if I can get some advice/pointers on how thi=
s disassembly statement is generated...I did take a quick look but it didn'=
t appear obvious how...

Thanks for pointing this out. This should fix the issue for you:
https://patchew.org/QEMU/20240514051615.330979-1-alistair.francis@wdc.com/

Alistair

>
> Thanks,
> eric
>

