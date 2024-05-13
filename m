Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77ECAC25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 11:15:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6Te4-00083g-HA; Mon, 13 May 2024 07:15:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s6Te2-000837-Pv; Mon, 13 May 2024 07:15:02 -0400
Received: from mail-vk1-xa2e.google.com ([2607:f8b0:4864:20::a2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s6Tdz-0004LE-S6; Mon, 13 May 2024 07:15:01 -0400
Received: by mail-vk1-xa2e.google.com with SMTP id
 71dfb90a1353d-4df9b81502eso362360e0c.2; 
 Mon, 13 May 2024 04:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715598897; x=1716203697; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XR9Y+a9710vayQt1L+rUG4XQ/YnCznuafE2d2UE1+ww=;
 b=Kbk0ldHCqgtf+NgVj3aqQdvtuQsWeHvxUfui7ok2g8V7Xm1if5ayCVBlBf2qC/A3Wl
 IVkL+HOy+K3ORofBtsAHHy6H3+ToCXlNy9Mja7JZ4Io9WsZY2feig0s8kPjJyJ+kuyay
 g7Fr3h6SIDf1KEAZirtGRzJ1BdPu6MoM9wf/3AsbR5MLV/URN1mcw2RPfYFd3cQTiM0p
 Pu2bSFNh2SFn9Vgcx8jioIkwxJG1BeR3hr8l1N2wkBsxosKeJEomGKsrr5YRCf0Si0DC
 VW7J17iaRi0gIQsCOnMBpkAYJVk1kaw/ag0UEd/bKvuRS5diqYbx2Q1XIpX54SEVpo4H
 Le0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715598897; x=1716203697;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XR9Y+a9710vayQt1L+rUG4XQ/YnCznuafE2d2UE1+ww=;
 b=bMPd41mnwp6Pn3Pg2tcEPPSW3Wy7DaIFGrqWvfDXLifb0YddLameZK7mJEUzkuXcxJ
 fhKQqPqsWmRtR3XAJ1F1dBR2cx6Q3G5Mb6xNlowGpDT4QmCNKAOajECF4gK0CMgcRoU1
 T09hl0ot80fj8G0yhGW1xbxTBZJl8hE8o/hqg0Mgu6chXLiYBKodAXicfpGhzaX8o4xN
 hX3kzzBjHTy1I4PV10JxtTSWN2S8OkuE7Bc4/JyncnmkPikQTWgcFbNIE+1PVcxPsHkh
 tjrY0R8y1jfBdCgyZakda6QfLkRhaDCYuzstnrGEdKhxXQ8BDLGMJSnQr62osfAjAiYw
 LsHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4BtF6W18uxG8PBRgTry470p/WVyMLzRrwvQSR+21hMnIv13+Mo2F7f6QiOPJ/JkRp66Lffbkp1+iwWByxZHxVtBAsa1EaYAbiIIoMZRp5DHz7RjK6cX+PmZKqbw==
X-Gm-Message-State: AOJu0Yytyzep4E1WZojqmfczPaYUG09p5TVdstkTHDMKKTRbJV8B9HEw
 hHsbbNESGw3sLIdLxkLOTiJYcdT3arujZHpZCETitBj7s906spJoLuR76q33z+w9uKf4eQHsK2M
 H+aruuxU2+1Ks9P0umiU1CILpSIc=
X-Google-Smtp-Source: AGHT+IFj8NbQbxPiGwxR2818Eu1FXQTzrSIyOc+646Q1LftWFQgJ4mz6bcrkh5b5cweGfriYUk91vEDnI7lPY565C70=
X-Received: by 2002:a05:6122:17a0:b0:4d4:2fc1:b252 with SMTP id
 71dfb90a1353d-4df882a780amr7382649e0c.6.1715598897077; Mon, 13 May 2024
 04:14:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240511101053.1875596-1-me@deliversmonkey.space>
 <b732f7bd-53d2-4c66-9821-a5bd589f6c56@gmail.com>
 <CAKmqyKM+2jhFdAL=3Z0De03hBFR6cn2xtVm3FrkPvn=U8tJLpg@mail.gmail.com>
 <CAFukJ-CfsChuYbpdUP9EOPEEn0s=jdBmp9aV691U8By68HV6Aw@mail.gmail.com>
In-Reply-To: <CAFukJ-CfsChuYbpdUP9EOPEEn0s=jdBmp9aV691U8By68HV6Aw@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 13 May 2024 21:14:30 +1000
Message-ID: <CAKmqyKOQLTYm7F8NBeoSmL1B6icfPzuH-ZHPXhz+wJLrjJyd6w@mail.gmail.com>
Subject: Re: [PATCH v9 0/6] Pointer Masking update for Zjpm v1.0
To: Alexey Baturo <baturo.alexey@gmail.com>
Cc: liwei <liwei1518@gmail.com>, richard.henderson@linaro.org, 
 space.monkey.delivers@gmail.com, palmer@dabbelt.com, Alistair.Francis@wdc.com, 
 sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de, 
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2e;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2e.google.com
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

On Mon, May 13, 2024 at 9:05=E2=80=AFPM Alexey Baturo <baturo.alexey@gmail.=
com> wrote:
>
> Hi,
>
> > Hi, any change from v0.8 to v1.0?
> Not in the patches that were sent. I'd still suggest applying a step-by-s=
tep approach with cleaning up old code and establishing the new mechanisms =
first and then updating the code to match the spec 100%. Also I heard Marti=
n has some arch compliance tests for J-ext somewhere.

The cover letter says that this implements version 1.0 of the spec,
this sounds like it doesn't.

Also, it's better to make the changes on top of the current code.
Instead of constantly removing and re-adding the code. Which is then
hard to review. Especially as I'm guessing there isn't a huge
difference between v0.8 and v1.0.

> @Alistair Francis @liwei does this approach sound reasonable to you?
>
> >Also, this needs another rebase
> Sure, no problem at all. I'll rebase and re-send them later today.

Thanks. Can you be very clear which version of the spec you have
developed and tested against as well.

Alistair

>
> Thanks
>
> =D0=BF=D0=BD, 13 =D0=BC=D0=B0=D1=8F 2024=E2=80=AF=D0=B3. =D0=B2 13:25, Al=
istair Francis <alistair23@gmail.com>:
>>
>> On Sun, May 12, 2024 at 12:44=E2=80=AFAM liwei <liwei1518@gmail.com> wro=
te:
>> >
>> >
>> > On 2024/5/11 18:10, Alexey Baturo wrote:
>> > > From: Alexey Baturo <baturo.alexey@gmail.com>
>> > >
>> > > Hi,
>> > >
>> > > It looks like Pointer Masking spec has reached v1.0 and been frozen,
>> > > rebasing on riscv-to-apply.next branch and resubmitting patches.
>> >
>> > Hi, any change from v0.8 to v1.0?
>>
>> Good question.
>>
>> Also, this needs another rebase. Sorry, it seems to always have
>> conflicts. If you re-send I'll apply it right away
>>
>> Alistair
>>
>> >
>> > Regards,
>> >
>> > Weiwei Li
>> >
>> > >
>> > > Thanks.
>> > >
>> > > [v8]:
>> > > Rebasing patches on current qemu branch and resubmitting them.
>> > >
>> > >
>> > > [v7]:
>> > > I'm terribly sorry, but previous rebase went wrong and somehow I mis=
sed it.
>> > > This time I double-checked rebased version.
>> > > This patch series is properly rebased on https://github.com/alistair=
23/qemu/tree/riscv-to-apply.next
>> > >
>> > > [v6]:
>> > > This patch series is rebased on https://github.com/alistair23/qemu/t=
ree/riscv-to-apply.next
>> > >
>> > > [v5]:
>> > > This patch series targets Zjpm v0.8 extension.
>> > > The spec itself could be found here: https://github.com/riscv/riscv-=
j-extension/blob/8088461d8d66a7676872b61c908cbeb7cf5c5d1d/zjpm-spec.pdf
>> > > This patch series is updated after the suggested comments:
>> > > - add "x-" to the extension names to indicate experimental
>> > >
>> > > [v4]:
>> > > Patch series updated after the suggested comments:
>> > > - removed J-letter extension as it's unused
>> > > - renamed and fixed function to detect if address should be sign-ext=
ended
>> > > - zeroed unused context variables and moved computation logic to ano=
ther patch
>> > > - bumped pointer masking version_id and minimum_version_id by 1
>> > >
>> > > [v3]:
>> > > There patches are updated after Richard's comments:
>> > > - moved new tb flags to the end
>> > > - used tcg_gen_(s)extract to get the final address
>> > > - properly handle CONFIG_USER_ONLY
>> > >
>> > > [v2]:
>> > > As per Richard's suggestion I made pmm field part of tb_flags.
>> > > It allowed to get rid of global variable to store pmlen.
>> > > Also it allowed to simplify all the machinery around it.
>> > >
>> > > [v1]:
>> > > It looks like Zjpm v0.8 is almost frozen and we don't expect it chan=
ge drastically anymore.
>> > > Compared to the original implementation with explicit base and mask =
CSRs, we now only have
>> > > several fixed options for number of masked bits which are set using =
existing CSRs.
>> > > The changes have been tested with handwritten assembly tests and LLV=
M HWASAN
>> > > test suite.
>> > >
>> > > Alexey Baturo (6):
>> > >    target/riscv: Remove obsolete pointer masking  extension code.
>> > >    target/riscv: Add new CSR fields for S{sn,mn,m}pm extensions as p=
art
>> > >      of Zjpm v0.8
>> > >    target/riscv: Add helper functions to calculate current number of
>> > >      masked bits for pointer masking
>> > >    target/riscv: Add pointer masking tb flags
>> > >    target/riscv: Update address modify functions to take into accoun=
t
>> > >      pointer masking
>> > >    target/riscv: Enable updates for pointer masking variables and th=
us
>> > >      enable pointer masking extension
>> > >
>> > >   target/riscv/cpu.c           |  21 +--
>> > >   target/riscv/cpu.h           |  46 +++--
>> > >   target/riscv/cpu_bits.h      |  90 +---------
>> > >   target/riscv/cpu_cfg.h       |   3 +
>> > >   target/riscv/cpu_helper.c    |  97 +++++-----
>> > >   target/riscv/csr.c           | 337 ++-----------------------------=
----
>> > >   target/riscv/machine.c       |  20 +--
>> > >   target/riscv/pmp.c           |  13 +-
>> > >   target/riscv/pmp.h           |  11 +-
>> > >   target/riscv/tcg/tcg-cpu.c   |   5 +-
>> > >   target/riscv/translate.c     |  46 ++---
>> > >   target/riscv/vector_helper.c |  15 +-
>> > >   12 files changed, 158 insertions(+), 546 deletions(-)
>> > >
>> >

