Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 717F5C48291
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 05:59:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWs0A-0005aH-PT; Mon, 05 Feb 2024 00:58:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rWs09-0005Zp-02; Mon, 05 Feb 2024 00:58:41 -0500
Received: from mail-vk1-xa35.google.com ([2607:f8b0:4864:20::a35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rWrzt-0002gE-Ht; Mon, 05 Feb 2024 00:58:40 -0500
Received: by mail-vk1-xa35.google.com with SMTP id
 71dfb90a1353d-4c0375d438eso76281e0c.0; 
 Sun, 04 Feb 2024 21:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707112704; x=1707717504; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OMJuhzocFI8NUI1v3ZDRv5FZncJCUf/ihnxZ7rzrDho=;
 b=l0didqchAP6GK54nmZKffc+SdCin8vdzpz6E+tWzT1Ha0x+kI2HY2VPwfnxUulnHNh
 gHoEX/NL6qXyyasG7HrqH1eZYTxJFPYZzxXZ9NnukklV75p5TqFxqamFT7E6orgsfB7Q
 RcG2KbPdVmgAyG3niq6kFZoTkYtVlj9xW7y3GUASET41vQ5fAwboWm5SXb+1V5H5V5iP
 cPDnBJPjyyt3wf9sgyO7Du+dtfiRHH+Kdvs2wrAf5R+1OibwkDDPRtojubFLFKnZFMvK
 /bCx06xvRM8q9lmpplE2lEX1NlL4SsKjuMMa+65t5ywqTjPCd4hAVZTvSHGN7gfS6uRk
 H9wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707112704; x=1707717504;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OMJuhzocFI8NUI1v3ZDRv5FZncJCUf/ihnxZ7rzrDho=;
 b=FH008YN9ImUQor5plkdf0O5HcceYrcIgg7PVCK9/eCsAE/J18FxJ4S+LFGadt3UqsS
 J/mfZTVIMfnpLlJn+dPUFo3BNDC7Hq2hSpfZqufEEGAybonOca6yVMg7CNowUkinMxcj
 WqMm5emjT0kda3ZfvaTZ8gKFDnESELynTzsPt/weLjUgKV9Yv/3pzUBTyOORlDNnBtz0
 KMY3xk4SvYvezAnYsxXvsYw/LpXzCkWFLPl1WZ8YpjSBX2rO3G8X1kZ8vJp1rzV2J0mx
 ej58TsVp7bldq8rIZ9oeFqAOSDpIq5Oi2tV3S8VQ7elWbuczZWUwuaZH2Cvmkhoe1QlJ
 VtWg==
X-Gm-Message-State: AOJu0Yw83ECD0i+gd5mnJcUdWYsoJm4APhzGNMwyjrmj9Wdxu8WHlGlG
 7wnOyiCFoPJs1oyP/P8gKH4Z6x5LinYZAkLLVdoFtTPyONbz9Miv+IpWW5EQDvCKh1qPqV5J9R0
 nQD+EMc9HjMIdWxLXU8Peq2/pP74=
X-Google-Smtp-Source: AGHT+IH8Kuoe5P4+cphobGRkbpAlOclKzF1DZVv7dCwbLyYEIXLkHWx9gzM7HtgCdEJ6+tmKe4mgOkElv9jJZEcEduQ=
X-Received: by 2002:a05:6122:380d:b0:4b7:a77b:299 with SMTP id
 em13-20020a056122380d00b004b7a77b0299mr11293771vkb.16.1707112703465; Sun, 04
 Feb 2024 21:58:23 -0800 (PST)
MIME-Version: 1.0
References: <20240110040203.1920924-1-hchauhan@ventanamicro.com>
 <e2763db2-fade-482d-b433-1bfce6acf7d3@ventanamicro.com>
 <CAKmqyKOA6OtixYoMJ_qtXj_u0t6rMdHawg0VEvq3-=mK4q6_XQ@mail.gmail.com>
 <3c091744cd4bafeb7c1d177455fa9789822e7209.camel@rivosinc.com>
 <CAKmqyKPkjBBo-2EAL25-3qACSv4c4naGT8V-F5e5as4D=WVa9g@mail.gmail.com>
 <20240122-29d7d206e9ea3ecd46fad930@orel>
 <CAKmqyKPibo3wp8mPu2+W5aGaxsPx3Ko2pcotv1H2Ddj6uhZDiw@mail.gmail.com>
 <CAAhSdy0Cw-+H0LmwXNi2qBZCrW1pQQg_GvBSrCmwGAY_sp8eGQ@mail.gmail.com>
In-Reply-To: <CAAhSdy0Cw-+H0LmwXNi2qBZCrW1pQQg_GvBSrCmwGAY_sp8eGQ@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 5 Feb 2024 15:57:57 +1000
Message-ID: <CAKmqyKMBrL-oHUmCaVVZbtZMrPcZFQC+8=2bGLETuLvPaKz3Sg@mail.gmail.com>
Subject: Re: Re: [PATCH 0/2] Export debug triggers as an extension
To: Anup Patel <anup@brainfault.org>
Cc: Andrew Jones <ajones@ventanamicro.com>,
 Rob Bradford <rbradford@rivosinc.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Himanshu Chauhan <hchauhan@ventanamicro.com>, 
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Alvin Chang <alvinga@andestech.com>,
 Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a35;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa35.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, Feb 5, 2024 at 2:50=E2=80=AFPM Anup Patel <anup@brainfault.org> wro=
te:
>
> On Mon, Feb 5, 2024 at 9:36=E2=80=AFAM Alistair Francis <alistair23@gmail=
.com> wrote:
> >
> > On Mon, Jan 22, 2024 at 7:16=E2=80=AFPM Andrew Jones <ajones@ventanamic=
ro.com> wrote:
> > >
> > > On Mon, Jan 22, 2024 at 03:42:10PM +1000, Alistair Francis wrote:
> > > > > > From memory the "debug" property is for the original debug spec=
:
> > > > > > https://github.com/riscv/riscv-debug-spec/releases/tag/task_gro=
up_vote
> > > > > >
> > > > > > That was ratified and is an official extension. AFAIK this is w=
hat is
> > > > > > in physical hardware as well.
> > > > > >
> > > > > > The actual PDF says draft though, I'm not sure what's going on =
there.
> > > > > >
> > > > > > The debug spec doesn't have a Z* name, so it's just "debug", at=
 least
> > > > > > AFAIK.
> > > > > >
> > > > > > "sdtrig" seems to be a new backwards-incompatible extension doi=
ng
> > > > > > basically the same thing. What a mess
> > > ...
> > > > >
> > > > > I've done a bit of digging and I agree things are quite messy. He=
re are
> > > > > my discoveries:
> > > > >
> > > > > The debug option and the code for triggers was added in these com=
mits:
> > > > >
> > > > > c9711bd778 target/riscv: cpu: Enable native debug feature
> > > > > 38b4e781a4 target/riscv: machine: Add debug state description
> > > > > b6092544fc target/riscv: csr: Hook debug CSR read/write
> > > > > 1acdb3b013 target/riscv: cpu: Add a config option for native debu=
g
> > > > > 95799e36c1 target/riscv: Add initial support for the Sdtrig exten=
sion
> > > > >
> > > > > In March 2022 - since the commit refers to the Sdtrig extension n=
ame
> > > > > and from the date this was an implementation not of the ratified =
0.13
> > > > > debug spec (which did not have Sdtrig as a separate extension) bu=
t
> > > > > rather a version of the in development 1.0 debug spec.
> > > >
> > > > Yeah... We used the "stable" from master. That is our mistake there=
.
> > > >
> > > > I'm pretty sure we targeted the 0.13. The "Sdtrig" was only added i=
n
> > > > the v4 as the changelog says: "mention Sdtrig extension in the comm=
it"
> > > >
> > > > >
> > > > > It's not trivial to tell if it's closer to the ratified 0.13 vers=
ion or
> > > > > the (hopefully soon to be frozen) 1.0 version.
> > > > >
> > > > > As the only part of the debug specification to be implemented is =
the
> > > > > triggers then effectively the debug option is x-sdtrig.
> > > > >
> > > > > I don't think there is any way for code running on the machine to
> > > > > identify what version of the debug is implemented - the appropria=
te
> > > > > register is only available for external debug. Once 1.0 is frozen=
 then
> > > > > the presence of Sdtrig isa string would indicate 1.0 trigger supp=
ort is
> > > > > available.
> > > > >
> > > > > According to JIRA - https://jira.riscv.org/browse/RVS-981 the deb=
ug
> > > > > specification should freeze this month.
> > > > >
> > > > > How about considering this as a solution:
> > > > >
> > > > > - Add a new x-sdtrig option that defaults to false
> > > > > - Deprecate debug option - but retain it with default on
> > > >
> > > > We can't deprecate a ratified spec. The 0.13 just seems to call it
> > > > "debug" so that's what we are stuck with
> > > >
> > > > > - Add warning if triggers are used and x-sdtrig is not enabled
> > > > > - Update the trigger implementation to match frozen spec
> > > >
> > > > We will need to support two versions, as there are two ratified spe=
cs.
> > > >
> > >
> > > We'll likely want to be allowed to deprecate ratified extensions as r=
iscv
> > > evolves. Despite best intentions, extensions may be designed and rati=
fied
> > > which ultimately fail to be of much utility, and new extensions will
> > > supersede old extensions. If QEMU keeps every extension it adds, then
> > > we'll slow progress on new extensions by maintaining old extension co=
de.
> > > The old extensions will also bitrot or waste CI resources getting tes=
ted
> > > for no reason.
> >
> > I agree that we might need to deprecate extensions.
> >
> > I'm not sure the debug extension is there though. The debug extension
> > is used in current shipping hardware and has been ratified. The Sdtrig
> > isn't even ratified yet
> > (https://lists.riscv.org/g/tech-announce/message/320)
>
> Is shipping real hardware OR ratification a requirement of
> QEMU patch acceptance ?

We will accept an extension when it is ratified. The question here is,
what if two ratified extensions conflict?

The answer to me seems that we need to support both them. *Maybe* at
some point in the future we can then drop the debug extension. That
would require the Sdtrig extension to be widely used and debug not
used (which is why I brought up shipping hardware).

Alistair

>
> Regards,
> Anup
>
> >
> > Right now I feel that we should at least wait for hardware that
> > supports Sdtrig to start to come out. Then we can look at deprecating
> > debug. Deprecating it now seems a bit premature.
> >
> > Alistair
> >
> > >
> > > I don't know the history of 'debug' and 'sdtrig', other than what I'v=
e
> > > read above, but, to me, it looks like 'debug' might be one of the fir=
st
> > > extensions which should be deprecated. Assuming we have a long enough
> > > deprecation period, then I think it's always safe to attempt a
> > > deprecation. If somebody shouts, then it can always be taken back off=
 the
> > > chopping block.
> > >
> > > Thanks,
> > > drew
> > >
> >

