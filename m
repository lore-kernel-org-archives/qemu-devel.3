Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 386D1C48291
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 04:51:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWqwL-0001Ah-Iq; Sun, 04 Feb 2024 23:50:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anup@brainfault.org>)
 id 1rWqwK-0001AO-8l
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 23:50:40 -0500
Received: from mail-il1-x132.google.com ([2607:f8b0:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anup@brainfault.org>)
 id 1rWqwI-0008IE-78
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 23:50:40 -0500
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-363c7d490d1so1603065ab.0
 for <qemu-devel@nongnu.org>; Sun, 04 Feb 2024 20:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1707108636; x=1707713436;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lu3xR5f+yVe75PC42yvnjqgCGBcSktlzjbl+O67ib3s=;
 b=ffvFqs9JTwo/7EHlqgto2ORl2MF/GtIAvdM1AHezW1ROxmxYB97D40hQhqgfoQKb6s
 Jb12maP8/oV12AgB0XfJWuKuoFCKF1y4wlUb8nEtmcmE0bkL2G6iRJbUMCsIuM+t0SGn
 IdhByY39FuF0wa4nVormkSIst55zrSLFr0OtsrSJgJ/stzyJ6Licxc92ihv2iRsx3kBF
 fCcw2MuhJh2lOJbeLr/6LdlTrR+L9gsRjQCwahUI0fUuRtNpifQxBUEtLqBJ6n44ARfL
 lBWQNv46H9vvChs4X3P4FgoYqsOAq/qAXt5Wsi5LUxRdfcR1CCH32acGRAnItCU4ZuHi
 8IiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707108636; x=1707713436;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lu3xR5f+yVe75PC42yvnjqgCGBcSktlzjbl+O67ib3s=;
 b=P1jP85+SW605ejVNWX8QL+pI7BiT8puCW7doKam5HwT0yEBlPhbLElejq9iSQqKglv
 Aslov+avec3R+gkp6nN1N4gfftoqc9GlXjb4iFottECy6hoEVApH0oiIAxUw4UFRcqPZ
 3E8uvx8uIk1UQLYXH9SAZxdwlrmWF029yTd7TprvIohPjvDdt0gbfboZASf3M6lZSnYf
 yEGXcFrqXzRJJEYBsc3+MOVkONbUuXRyZw6xuNoFrJBMiXSI/JXsesV3PfAHMVpXCEV2
 6soAEotjKTrB4Y+NQP+MN750TXUfltObZ1XiWhvuG8oILbt+Oij1GT+SZNg1FCe/fdJw
 +rjQ==
X-Gm-Message-State: AOJu0Yz5JoWzdKl5XWurqt1UgbB+Mj/ZTxPu+WfchG8xKS2wl1OyXtuN
 52GYe5oxsrM5n4vX8d0YRwphQqzoerbuR+t6ws3+qzOkpzpIN02RfdO9nM9S3fD7UmlaeCXXbPz
 mi0dd9JfNZICFKlbWFZqMaX345NTkCyH1KUEp2w==
X-Google-Smtp-Source: AGHT+IEViTM7SM2C7O0rMmgwjvyai7Gk9RSAIlIJyBMuUqa9lgSyydsoUtLC5OV7IW7TxhyuqZPhy48/n8fjG5vVuV4=
X-Received: by 2002:a92:c564:0:b0:363:bbd1:e472 with SMTP id
 b4-20020a92c564000000b00363bbd1e472mr8686109ilj.0.1707108636333; Sun, 04 Feb
 2024 20:50:36 -0800 (PST)
MIME-Version: 1.0
References: <20240110040203.1920924-1-hchauhan@ventanamicro.com>
 <e2763db2-fade-482d-b433-1bfce6acf7d3@ventanamicro.com>
 <CAKmqyKOA6OtixYoMJ_qtXj_u0t6rMdHawg0VEvq3-=mK4q6_XQ@mail.gmail.com>
 <3c091744cd4bafeb7c1d177455fa9789822e7209.camel@rivosinc.com>
 <CAKmqyKPkjBBo-2EAL25-3qACSv4c4naGT8V-F5e5as4D=WVa9g@mail.gmail.com>
 <20240122-29d7d206e9ea3ecd46fad930@orel>
 <CAKmqyKPibo3wp8mPu2+W5aGaxsPx3Ko2pcotv1H2Ddj6uhZDiw@mail.gmail.com>
In-Reply-To: <CAKmqyKPibo3wp8mPu2+W5aGaxsPx3Ko2pcotv1H2Ddj6uhZDiw@mail.gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Mon, 5 Feb 2024 10:20:24 +0530
Message-ID: <CAAhSdy0Cw-+H0LmwXNi2qBZCrW1pQQg_GvBSrCmwGAY_sp8eGQ@mail.gmail.com>
Subject: Re: Re: [PATCH 0/2] Export debug triggers as an extension
To: Alistair Francis <alistair23@gmail.com>
Cc: Andrew Jones <ajones@ventanamicro.com>,
 Rob Bradford <rbradford@rivosinc.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Himanshu Chauhan <hchauhan@ventanamicro.com>, 
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Alvin Chang <alvinga@andestech.com>,
 Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2607:f8b0:4864:20::132;
 envelope-from=anup@brainfault.org; helo=mail-il1-x132.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, Feb 5, 2024 at 9:36=E2=80=AFAM Alistair Francis <alistair23@gmail.c=
om> wrote:
>
> On Mon, Jan 22, 2024 at 7:16=E2=80=AFPM Andrew Jones <ajones@ventanamicro=
.com> wrote:
> >
> > On Mon, Jan 22, 2024 at 03:42:10PM +1000, Alistair Francis wrote:
> > > > > From memory the "debug" property is for the original debug spec:
> > > > > https://github.com/riscv/riscv-debug-spec/releases/tag/task_group=
_vote
> > > > >
> > > > > That was ratified and is an official extension. AFAIK this is wha=
t is
> > > > > in physical hardware as well.
> > > > >
> > > > > The actual PDF says draft though, I'm not sure what's going on th=
ere.
> > > > >
> > > > > The debug spec doesn't have a Z* name, so it's just "debug", at l=
east
> > > > > AFAIK.
> > > > >
> > > > > "sdtrig" seems to be a new backwards-incompatible extension doing
> > > > > basically the same thing. What a mess
> > ...
> > > >
> > > > I've done a bit of digging and I agree things are quite messy. Here=
 are
> > > > my discoveries:
> > > >
> > > > The debug option and the code for triggers was added in these commi=
ts:
> > > >
> > > > c9711bd778 target/riscv: cpu: Enable native debug feature
> > > > 38b4e781a4 target/riscv: machine: Add debug state description
> > > > b6092544fc target/riscv: csr: Hook debug CSR read/write
> > > > 1acdb3b013 target/riscv: cpu: Add a config option for native debug
> > > > 95799e36c1 target/riscv: Add initial support for the Sdtrig extensi=
on
> > > >
> > > > In March 2022 - since the commit refers to the Sdtrig extension nam=
e
> > > > and from the date this was an implementation not of the ratified 0.=
13
> > > > debug spec (which did not have Sdtrig as a separate extension) but
> > > > rather a version of the in development 1.0 debug spec.
> > >
> > > Yeah... We used the "stable" from master. That is our mistake there.
> > >
> > > I'm pretty sure we targeted the 0.13. The "Sdtrig" was only added in
> > > the v4 as the changelog says: "mention Sdtrig extension in the commit=
"
> > >
> > > >
> > > > It's not trivial to tell if it's closer to the ratified 0.13 versio=
n or
> > > > the (hopefully soon to be frozen) 1.0 version.
> > > >
> > > > As the only part of the debug specification to be implemented is th=
e
> > > > triggers then effectively the debug option is x-sdtrig.
> > > >
> > > > I don't think there is any way for code running on the machine to
> > > > identify what version of the debug is implemented - the appropriate
> > > > register is only available for external debug. Once 1.0 is frozen t=
hen
> > > > the presence of Sdtrig isa string would indicate 1.0 trigger suppor=
t is
> > > > available.
> > > >
> > > > According to JIRA - https://jira.riscv.org/browse/RVS-981 the debug
> > > > specification should freeze this month.
> > > >
> > > > How about considering this as a solution:
> > > >
> > > > - Add a new x-sdtrig option that defaults to false
> > > > - Deprecate debug option - but retain it with default on
> > >
> > > We can't deprecate a ratified spec. The 0.13 just seems to call it
> > > "debug" so that's what we are stuck with
> > >
> > > > - Add warning if triggers are used and x-sdtrig is not enabled
> > > > - Update the trigger implementation to match frozen spec
> > >
> > > We will need to support two versions, as there are two ratified specs=
.
> > >
> >
> > We'll likely want to be allowed to deprecate ratified extensions as ris=
cv
> > evolves. Despite best intentions, extensions may be designed and ratifi=
ed
> > which ultimately fail to be of much utility, and new extensions will
> > supersede old extensions. If QEMU keeps every extension it adds, then
> > we'll slow progress on new extensions by maintaining old extension code=
.
> > The old extensions will also bitrot or waste CI resources getting teste=
d
> > for no reason.
>
> I agree that we might need to deprecate extensions.
>
> I'm not sure the debug extension is there though. The debug extension
> is used in current shipping hardware and has been ratified. The Sdtrig
> isn't even ratified yet
> (https://lists.riscv.org/g/tech-announce/message/320)

Is shipping real hardware OR ratification a requirement of
QEMU patch acceptance ?

Regards,
Anup

>
> Right now I feel that we should at least wait for hardware that
> supports Sdtrig to start to come out. Then we can look at deprecating
> debug. Deprecating it now seems a bit premature.
>
> Alistair
>
> >
> > I don't know the history of 'debug' and 'sdtrig', other than what I've
> > read above, but, to me, it looks like 'debug' might be one of the first
> > extensions which should be deprecated. Assuming we have a long enough
> > deprecation period, then I think it's always safe to attempt a
> > deprecation. If somebody shouts, then it can always be taken back off t=
he
> > chopping block.
> >
> > Thanks,
> > drew
> >
>

