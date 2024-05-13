Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40C62C25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 11:06:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6TV4-0005Oa-5i; Mon, 13 May 2024 07:05:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1s6TV2-0005OA-QK; Mon, 13 May 2024 07:05:44 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1s6TUy-0002Om-QX; Mon, 13 May 2024 07:05:44 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a5a5cb0e6b7so279673066b.1; 
 Mon, 13 May 2024 04:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715598330; x=1716203130; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=T2ZMIfbXE5sbws/smhBy+qO/nK3Z5P4xAu+rQRfgcr0=;
 b=aVUo31P4HtDmOmAHX1zIZRBJ/3u8uBGpvqx+/8t056zB4PcV4sBaZkJREzDr3D6Nb1
 aDUAck2w4ctzxsf7+TdrI/1r3T3dtj8J0Vh3DqWx7TS+9PLUMBdf03dpXTYcG2XK8PUh
 1sJ95/E8ZfQgTRUcjdCRSSwzZZeC+wDF9A8ON9hVn5rO+rbyqIfpKBZuntoQQwfL6dfC
 rH5DP3MDDiMNXZApDHSDjaLJSlf0EH+MBppvtJnBcqDt0jM7lbXKop6694y8rs0Z4pTN
 z+FCr7CL5sQa3q8qai0QpmaaP6HfY9RRNRakJJM+HrTLgE/7ts/oLq8zNtO/Ow6BYpD/
 9MuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715598330; x=1716203130;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T2ZMIfbXE5sbws/smhBy+qO/nK3Z5P4xAu+rQRfgcr0=;
 b=owBMNeXJorBAp5KX7ibzdRYW+v2ch2ECJPH1P3x1U1TRH/9thX+PYJn6KB6FLRZTfq
 HKET+Odrsts6yOxKip4zoSQdtmAQPnBJrsxZT7ycoT+BlHKDY/lN/x4wBcVn+wnE89Jp
 PmzSxGT5Xe1/c2+c0uISRO30SXdG8bibg5PaQb9tINsUhhWDIaER/GOAOUEkiHwgVdiI
 tChoFvI1cZvgLGgJVHjY4GYs3eNdStgi3UxWShrslCfyRgqvPmfXT685FKyN7tcpPeWK
 tC5p2WqdsY9z9/ggN+HoYnMLHWWDWFZlNX1CVDvjRXNUtyAfI8CiqNd3fb69mdaQU8jr
 cSiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWk70u98MLig4GHcALhOdpWI6qr3/gArFkKla38E5jxiJ58qgntbw8AQo/5K6Oupc+o+HQQiSqYigZqCJ6WSgRVa4xcz0VWEyaJXt5s7zsvwy/ttYOmn7HYHrztbQ==
X-Gm-Message-State: AOJu0YyH5Xyb3aNu2zOHaXzmdur9YcDzaJcu+4N1lNBQG5bbN7w0R7S7
 hMoRZ0W6S39yROcfoom6KYRw5vxAI8yNIdpUbT2xoNi+ew5WzbZhZYQeKjJN5/O93fDjAKimW/l
 j9If3T0zANcII1ovtGQvK9V7RtQo=
X-Google-Smtp-Source: AGHT+IHNDWa37GwQhYvMSlJ9vs7hTtk7IRXFMLuz1xmDb78O/C880pUh3m6jX5bP2COtbFno9fImCDiEdLorApfogmw=
X-Received: by 2002:a50:9559:0:b0:56e:de1:f427 with SMTP id
 4fb4d7f45d1cf-5734d5eb54cmr5954413a12.25.1715598330101; Mon, 13 May 2024
 04:05:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240511101053.1875596-1-me@deliversmonkey.space>
 <b732f7bd-53d2-4c66-9821-a5bd589f6c56@gmail.com>
 <CAKmqyKM+2jhFdAL=3Z0De03hBFR6cn2xtVm3FrkPvn=U8tJLpg@mail.gmail.com>
In-Reply-To: <CAKmqyKM+2jhFdAL=3Z0De03hBFR6cn2xtVm3FrkPvn=U8tJLpg@mail.gmail.com>
From: Alexey Baturo <baturo.alexey@gmail.com>
Date: Mon, 13 May 2024 14:05:18 +0300
Message-ID: <CAFukJ-CfsChuYbpdUP9EOPEEn0s=jdBmp9aV691U8By68HV6Aw@mail.gmail.com>
Subject: Re: [PATCH v9 0/6] Pointer Masking update for Zjpm v1.0
To: Alistair Francis <alistair23@gmail.com>
Cc: liwei <liwei1518@gmail.com>, richard.henderson@linaro.org, 
 space.monkey.delivers@gmail.com, palmer@dabbelt.com, Alistair.Francis@wdc.com, 
 sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de, 
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000000b0bf3061853ddde"
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=baturo.alexey@gmail.com; helo=mail-ej1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--0000000000000b0bf3061853ddde
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

> Hi, any change from v0.8 to v1.0?
Not in the patches that were sent. I'd still suggest applying a
step-by-step approach with cleaning up old code and establishing the new
mechanisms first and then updating the code to match the spec 100%. Also I
heard Martin has some arch compliance tests for J-ext somewhere.
@Alistair Francis <alistair23@gmail.com> @liwei does this approach sound
reasonable to you?

>Also, this needs another rebase
Sure, no problem at all. I'll rebase and re-send them later today.

Thanks

=D0=BF=D0=BD, 13 =D0=BC=D0=B0=D1=8F 2024=E2=80=AF=D0=B3. =D0=B2 13:25, Alis=
tair Francis <alistair23@gmail.com>:

> On Sun, May 12, 2024 at 12:44=E2=80=AFAM liwei <liwei1518@gmail.com> wrot=
e:
> >
> >
> > On 2024/5/11 18:10, Alexey Baturo wrote:
> > > From: Alexey Baturo <baturo.alexey@gmail.com>
> > >
> > > Hi,
> > >
> > > It looks like Pointer Masking spec has reached v1.0 and been frozen,
> > > rebasing on riscv-to-apply.next branch and resubmitting patches.
> >
> > Hi, any change from v0.8 to v1.0?
>
> Good question.
>
> Also, this needs another rebase. Sorry, it seems to always have
> conflicts. If you re-send I'll apply it right away
>
> Alistair
>
> >
> > Regards,
> >
> > Weiwei Li
> >
> > >
> > > Thanks.
> > >
> > > [v8]:
> > > Rebasing patches on current qemu branch and resubmitting them.
> > >
> > >
> > > [v7]:
> > > I'm terribly sorry, but previous rebase went wrong and somehow I
> missed it.
> > > This time I double-checked rebased version.
> > > This patch series is properly rebased on
> https://github.com/alistair23/qemu/tree/riscv-to-apply.next
> > >
> > > [v6]:
> > > This patch series is rebased on
> https://github.com/alistair23/qemu/tree/riscv-to-apply.next
> > >
> > > [v5]:
> > > This patch series targets Zjpm v0.8 extension.
> > > The spec itself could be found here:
> https://github.com/riscv/riscv-j-extension/blob/8088461d8d66a7676872b61c9=
08cbeb7cf5c5d1d/zjpm-spec.pdf
> > > This patch series is updated after the suggested comments:
> > > - add "x-" to the extension names to indicate experimental
> > >
> > > [v4]:
> > > Patch series updated after the suggested comments:
> > > - removed J-letter extension as it's unused
> > > - renamed and fixed function to detect if address should be
> sign-extended
> > > - zeroed unused context variables and moved computation logic to
> another patch
> > > - bumped pointer masking version_id and minimum_version_id by 1
> > >
> > > [v3]:
> > > There patches are updated after Richard's comments:
> > > - moved new tb flags to the end
> > > - used tcg_gen_(s)extract to get the final address
> > > - properly handle CONFIG_USER_ONLY
> > >
> > > [v2]:
> > > As per Richard's suggestion I made pmm field part of tb_flags.
> > > It allowed to get rid of global variable to store pmlen.
> > > Also it allowed to simplify all the machinery around it.
> > >
> > > [v1]:
> > > It looks like Zjpm v0.8 is almost frozen and we don't expect it chang=
e
> drastically anymore.
> > > Compared to the original implementation with explicit base and mask
> CSRs, we now only have
> > > several fixed options for number of masked bits which are set using
> existing CSRs.
> > > The changes have been tested with handwritten assembly tests and LLVM
> HWASAN
> > > test suite.
> > >
> > > Alexey Baturo (6):
> > >    target/riscv: Remove obsolete pointer masking  extension code.
> > >    target/riscv: Add new CSR fields for S{sn,mn,m}pm extensions as pa=
rt
> > >      of Zjpm v0.8
> > >    target/riscv: Add helper functions to calculate current number of
> > >      masked bits for pointer masking
> > >    target/riscv: Add pointer masking tb flags
> > >    target/riscv: Update address modify functions to take into account
> > >      pointer masking
> > >    target/riscv: Enable updates for pointer masking variables and thu=
s
> > >      enable pointer masking extension
> > >
> > >   target/riscv/cpu.c           |  21 +--
> > >   target/riscv/cpu.h           |  46 +++--
> > >   target/riscv/cpu_bits.h      |  90 +---------
> > >   target/riscv/cpu_cfg.h       |   3 +
> > >   target/riscv/cpu_helper.c    |  97 +++++-----
> > >   target/riscv/csr.c           | 337
> ++---------------------------------
> > >   target/riscv/machine.c       |  20 +--
> > >   target/riscv/pmp.c           |  13 +-
> > >   target/riscv/pmp.h           |  11 +-
> > >   target/riscv/tcg/tcg-cpu.c   |   5 +-
> > >   target/riscv/translate.c     |  46 ++---
> > >   target/riscv/vector_helper.c |  15 +-
> > >   12 files changed, 158 insertions(+), 546 deletions(-)
> > >
> >
>

--0000000000000b0bf3061853ddde
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div>&gt; Hi, any change from v0.8 to v1.0?<d=
iv>Not in the patches that were sent. I&#39;d still suggest applying a step=
-by-step approach with cleaning up old code and establishing the new mechan=
isms first and then updating the code to match the spec 100%. Also I heard =
Martin has some arch compliance tests for J-ext somewhere.<div><a class=3D"=
gmail_plusreply" id=3D"plusReplyChip-0" href=3D"mailto:alistair23@gmail.com=
" tabindex=3D"-1">@Alistair Francis</a>=C2=A0@liwei does this approach soun=
d reasonable to you?</div><div><br></div><div>&gt;Also, this needs another =
rebase<br></div></div><div>Sure, no problem at all. I&#39;ll rebase and re-=
send them later today.</div><div><br></div><div>Thanks</div></div><br><div =
class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">=D0=BF=D0=BD, 1=
3 =D0=BC=D0=B0=D1=8F 2024=E2=80=AF=D0=B3. =D0=B2 13:25, Alistair Francis &l=
t;<a href=3D"mailto:alistair23@gmail.com">alistair23@gmail.com</a>&gt;:<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">On Sun, May 12, 202=
4 at 12:44=E2=80=AFAM liwei &lt;<a href=3D"mailto:liwei1518@gmail.com" targ=
et=3D"_blank">liwei1518@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt;<br>
&gt; On 2024/5/11 18:10, Alexey Baturo wrote:<br>
&gt; &gt; From: Alexey Baturo &lt;<a href=3D"mailto:baturo.alexey@gmail.com=
" target=3D"_blank">baturo.alexey@gmail.com</a>&gt;<br>
&gt; &gt;<br>
&gt; &gt; Hi,<br>
&gt; &gt;<br>
&gt; &gt; It looks like Pointer Masking spec has reached v1.0 and been froz=
en,<br>
&gt; &gt; rebasing on riscv-to-apply.next branch and resubmitting patches.<=
br>
&gt;<br>
&gt; Hi, any change from v0.8 to v1.0?<br>
<br>
Good question.<br>
<br>
Also, this needs another rebase. Sorry, it seems to always have<br>
conflicts. If you re-send I&#39;ll apply it right away<br>
<br>
Alistair<br>
<br>
&gt;<br>
&gt; Regards,<br>
&gt;<br>
&gt; Weiwei Li<br>
&gt;<br>
&gt; &gt;<br>
&gt; &gt; Thanks.<br>
&gt; &gt;<br>
&gt; &gt; [v8]:<br>
&gt; &gt; Rebasing patches on current qemu branch and resubmitting them.<br=
>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; [v7]:<br>
&gt; &gt; I&#39;m terribly sorry, but previous rebase went wrong and someho=
w I missed it.<br>
&gt; &gt; This time I double-checked rebased version.<br>
&gt; &gt; This patch series is properly rebased on <a href=3D"https://githu=
b.com/alistair23/qemu/tree/riscv-to-apply.next" rel=3D"noreferrer" target=
=3D"_blank">https://github.com/alistair23/qemu/tree/riscv-to-apply.next</a>=
<br>
&gt; &gt;<br>
&gt; &gt; [v6]:<br>
&gt; &gt; This patch series is rebased on <a href=3D"https://github.com/ali=
stair23/qemu/tree/riscv-to-apply.next" rel=3D"noreferrer" target=3D"_blank"=
>https://github.com/alistair23/qemu/tree/riscv-to-apply.next</a><br>
&gt; &gt;<br>
&gt; &gt; [v5]:<br>
&gt; &gt; This patch series targets Zjpm v0.8 extension.<br>
&gt; &gt; The spec itself could be found here: <a href=3D"https://github.co=
m/riscv/riscv-j-extension/blob/8088461d8d66a7676872b61c908cbeb7cf5c5d1d/zjp=
m-spec.pdf" rel=3D"noreferrer" target=3D"_blank">https://github.com/riscv/r=
iscv-j-extension/blob/8088461d8d66a7676872b61c908cbeb7cf5c5d1d/zjpm-spec.pd=
f</a><br>
&gt; &gt; This patch series is updated after the suggested comments:<br>
&gt; &gt; - add &quot;x-&quot; to the extension names to indicate experimen=
tal<br>
&gt; &gt;<br>
&gt; &gt; [v4]:<br>
&gt; &gt; Patch series updated after the suggested comments:<br>
&gt; &gt; - removed J-letter extension as it&#39;s unused<br>
&gt; &gt; - renamed and fixed function to detect if address should be sign-=
extended<br>
&gt; &gt; - zeroed unused context variables and moved computation logic to =
another patch<br>
&gt; &gt; - bumped pointer masking version_id and minimum_version_id by 1<b=
r>
&gt; &gt;<br>
&gt; &gt; [v3]:<br>
&gt; &gt; There patches are updated after Richard&#39;s comments:<br>
&gt; &gt; - moved new tb flags to the end<br>
&gt; &gt; - used tcg_gen_(s)extract to get the final address<br>
&gt; &gt; - properly handle CONFIG_USER_ONLY<br>
&gt; &gt;<br>
&gt; &gt; [v2]:<br>
&gt; &gt; As per Richard&#39;s suggestion I made pmm field part of tb_flags=
.<br>
&gt; &gt; It allowed to get rid of global variable to store pmlen.<br>
&gt; &gt; Also it allowed to simplify all the machinery around it.<br>
&gt; &gt;<br>
&gt; &gt; [v1]:<br>
&gt; &gt; It looks like Zjpm v0.8 is almost frozen and we don&#39;t expect =
it change drastically anymore.<br>
&gt; &gt; Compared to the original implementation with explicit base and ma=
sk CSRs, we now only have<br>
&gt; &gt; several fixed options for number of masked bits which are set usi=
ng existing CSRs.<br>
&gt; &gt; The changes have been tested with handwritten assembly tests and =
LLVM HWASAN<br>
&gt; &gt; test suite.<br>
&gt; &gt;<br>
&gt; &gt; Alexey Baturo (6):<br>
&gt; &gt;=C2=A0 =C2=A0 target/riscv: Remove obsolete pointer masking=C2=A0 =
extension code.<br>
&gt; &gt;=C2=A0 =C2=A0 target/riscv: Add new CSR fields for S{sn,mn,m}pm ex=
tensions as part<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 of Zjpm v0.8<br>
&gt; &gt;=C2=A0 =C2=A0 target/riscv: Add helper functions to calculate curr=
ent number of<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 masked bits for pointer masking<br>
&gt; &gt;=C2=A0 =C2=A0 target/riscv: Add pointer masking tb flags<br>
&gt; &gt;=C2=A0 =C2=A0 target/riscv: Update address modify functions to tak=
e into account<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 pointer masking<br>
&gt; &gt;=C2=A0 =C2=A0 target/riscv: Enable updates for pointer masking var=
iables and thus<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 enable pointer masking extension<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0target/riscv/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 21 +--<br>
&gt; &gt;=C2=A0 =C2=A0target/riscv/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 46 +++--<br>
&gt; &gt;=C2=A0 =C2=A0target/riscv/cpu_bits.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 9=
0 +---------<br>
&gt; &gt;=C2=A0 =C2=A0target/riscv/cpu_cfg.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 =C2=A03 +<br>
&gt; &gt;=C2=A0 =C2=A0target/riscv/cpu_helper.c=C2=A0 =C2=A0 |=C2=A0 97 +++=
++-----<br>
&gt; &gt;=C2=A0 =C2=A0target/riscv/csr.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| 337 ++---------------------------------<br>
&gt; &gt;=C2=A0 =C2=A0target/riscv/machine.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 20 +--<br>
&gt; &gt;=C2=A0 =C2=A0target/riscv/pmp.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 13 +-<br>
&gt; &gt;=C2=A0 =C2=A0target/riscv/pmp.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 11 +-<br>
&gt; &gt;=C2=A0 =C2=A0target/riscv/tcg/tcg-cpu.c=C2=A0 =C2=A0|=C2=A0 =C2=A0=
5 +-<br>
&gt; &gt;=C2=A0 =C2=A0target/riscv/translate.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 4=
6 ++---<br>
&gt; &gt;=C2=A0 =C2=A0target/riscv/vector_helper.c |=C2=A0 15 +-<br>
&gt; &gt;=C2=A0 =C2=A012 files changed, 158 insertions(+), 546 deletions(-)=
<br>
&gt; &gt;<br>
&gt;<br>
</blockquote></div>

--0000000000000b0bf3061853ddde--

