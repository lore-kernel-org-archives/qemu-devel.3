Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D8F0C25B75
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 11:33:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6TvS-00046z-CO; Mon, 13 May 2024 07:33:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s6TvQ-00046Q-Gh; Mon, 13 May 2024 07:33:00 -0400
Received: from mail-vk1-xa2d.google.com ([2607:f8b0:4864:20::a2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s6TvO-00012U-Ui; Mon, 13 May 2024 07:33:00 -0400
Received: by mail-vk1-xa2d.google.com with SMTP id
 71dfb90a1353d-4df8ea40b2bso1075823e0c.2; 
 Mon, 13 May 2024 04:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715599977; x=1716204777; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3UCmsAklbjkrXrfaLN1GWoavHyDOe8fN2qEcy/vKB3s=;
 b=aGW6m1Ffq+1+PM8s+URioi00Rv8Aa3Y6qBBNbjcQagXcfoadyYhqySVZE9NByR2oMG
 zMfP2nOMWK+NVEiVJum71MNgnNGwB8Kf6giGRZLZzyoYKZ+DLKaA0Yk00WFL22nzPmwV
 JRYVoz21qUFmVXl7DiFFyHl8D+16ZPj5gjSs3QvvX/+xvNMENTISMMMTWIV1fqcDzygY
 MLLZ1Uxj/1rXrBl+wFfUrx6/YW1lyG07heYfOoZptX70RcMudeWWEjZ7LcB7ZKgzy7Vk
 MZ5pVRZwPSnGzQb8pc8YtQQqHeuTVfdgpQOU2+HYMNDnP6KmPNfx/s48u2mc9pYJBnOx
 1WTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715599977; x=1716204777;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3UCmsAklbjkrXrfaLN1GWoavHyDOe8fN2qEcy/vKB3s=;
 b=hwcsAvcqfRPjZ8IYbKfeaoJAs7x8l1CQlQKKa/fhb3lIMT3fjOmVnvhzKL6D3h8Hit
 5QOO25VPZkkS9+2MF3WE5EJNweftFZB998aG+zv2P663BppiuRpvJqlppnj6XNINEG+s
 OlqxepkRztfEeCimQtGl2dAMmJQsVAQ+AsoTkdSMecfMNS+7+ck7yr3wzBGos8ybYHtg
 pwtTwGHwuiYvhVR/7H8D4HbXEIhhafUpBgccstQFR07EJYi53Xdu9k+rilFEnWflFK4x
 IJgXTeDfKFNRJ09epytqb7SQ2XSBN0rHmme1PuMSdnykw9kLlKlanraf+If+PZndYT31
 D10g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVw2d8YvJIExmoWCFvngEAWJun4m41SjGEBCGEpj576BB3Sqm1lHZ35CFY+3zKs7ulqV4ik8WhtNQFY7AaK/vGVB95JwJY5jR+hmg3cB8JRwyZBcvuygNE3qhH/Dg==
X-Gm-Message-State: AOJu0Yz7CKajj13Qcw+vJpfW4AqsqNKjcz6RHJrAfcEdyjW8lFnhmdSs
 fpTdVuX89Tku8ZJHy25tCjL61kV6Q0yOBL0RjsTMBJNRGU8e37oYCaOvi7Rlw/Yf6NJBqVgFxwY
 y2spBjFq58uKvRScSFYgF6TdA39U=
X-Google-Smtp-Source: AGHT+IFtwaIOSuBCL5aHpB24FshUNDU5t9s9Wjjz4AOw3szmVFNrNTROzpuonsUnEMpSv8pSUQg8lBnjIEKn1ID8jws=
X-Received: by 2002:a05:6122:1699:b0:4df:1a28:5e3c with SMTP id
 71dfb90a1353d-4df88138a64mr7796813e0c.0.1715599977400; Mon, 13 May 2024
 04:32:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240511101053.1875596-1-me@deliversmonkey.space>
 <b732f7bd-53d2-4c66-9821-a5bd589f6c56@gmail.com>
 <CAKmqyKM+2jhFdAL=3Z0De03hBFR6cn2xtVm3FrkPvn=U8tJLpg@mail.gmail.com>
 <CAFukJ-CfsChuYbpdUP9EOPEEn0s=jdBmp9aV691U8By68HV6Aw@mail.gmail.com>
 <CAKmqyKOQLTYm7F8NBeoSmL1B6icfPzuH-ZHPXhz+wJLrjJyd6w@mail.gmail.com>
In-Reply-To: <CAKmqyKOQLTYm7F8NBeoSmL1B6icfPzuH-ZHPXhz+wJLrjJyd6w@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 13 May 2024 21:32:30 +1000
Message-ID: <CAKmqyKMtJPGXs+rXFzfN7jqYTMbKBQ2SYVYoQ5kONT-FKkp=9g@mail.gmail.com>
Subject: Re: [PATCH v9 0/6] Pointer Masking update for Zjpm v1.0
To: Alexey Baturo <baturo.alexey@gmail.com>
Cc: liwei <liwei1518@gmail.com>, richard.henderson@linaro.org, 
 space.monkey.delivers@gmail.com, palmer@dabbelt.com, Alistair.Francis@wdc.com, 
 sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de, 
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2d;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2d.google.com
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

On Mon, May 13, 2024 at 9:14=E2=80=AFPM Alistair Francis <alistair23@gmail.=
com> wrote:
>
> On Mon, May 13, 2024 at 9:05=E2=80=AFPM Alexey Baturo <baturo.alexey@gmai=
l.com> wrote:
> >
> > Hi,
> >
> > > Hi, any change from v0.8 to v1.0?
> > Not in the patches that were sent. I'd still suggest applying a step-by=
-step approach with cleaning up old code and establishing the new mechanism=
s first and then updating the code to match the spec 100%. Also I heard Mar=
tin has some arch compliance tests for J-ext somewhere.
>
> The cover letter says that this implements version 1.0 of the spec,
> this sounds like it doesn't.
>
> Also, it's better to make the changes on top of the current code.
> Instead of constantly removing and re-adding the code. Which is then
> hard to review. Especially as I'm guessing there isn't a huge
> difference between v0.8 and v1.0.
>
> > @Alistair Francis @liwei does this approach sound reasonable to you?
> >
> > >Also, this needs another rebase
> > Sure, no problem at all. I'll rebase and re-send them later today.

Sorry, it did apply correctly! That was my mistake.

But this series generates a warning. Do you mind fixing that and
addressing the other comments/concerns

Alistair

>
> Thanks. Can you be very clear which version of the spec you have
> developed and tested against as well.
>
> Alistair

