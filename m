Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EB24D3A661
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 14:52:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5nZM-0003Zd-23; Tue, 29 Oct 2024 10:51:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <goldstein.w.n@gmail.com>)
 id 1t5nZH-0003Yd-E4
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 10:51:35 -0400
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <goldstein.w.n@gmail.com>)
 id 1t5nZE-0003kq-Va
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 10:51:35 -0400
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-5ebc03951abso2532584eaf.2
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 07:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730213491; x=1730818291; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YNo/VeP1D5zfTB/NhvsxNw52+/xpKiy+xKr64w32buc=;
 b=QrENTcJ9wTDm87Nzp/5PjahHLz0Y4Akxi0qWmo/oxzwBpKc6sK/NCxF0z6DFr45t0v
 xWVmCaJcJ4P7TZJd2ThOAjYkEc3wc7YSzMe9glucSMaueckCEKY/XzTdcENijOBfXbNy
 42awSOCijC/DEW6G03JqiEH0SOt8SCUwY4GT1NIyddp5jrolJH+bb4SJAy/T1H0otbCV
 OBw4yjKF8tJSXvT6ibbl7v6zMu/kqf9rYRYs3jN8CJLepkBVX8bIf3sHh/Hj/VSpSf1O
 8RriLYh/PZhcV7fkRYoWv15CV9P4A6TPtdA6qY9M9fE+vrKmXMArhvAYGLGhGLDS8BbI
 ZU+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730213491; x=1730818291;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YNo/VeP1D5zfTB/NhvsxNw52+/xpKiy+xKr64w32buc=;
 b=V78W3OQZ0NTeUbo9oOAOwBbRpHchwCMg72ukcUtTx7vX1IK1RSrAzLzYnuYDPj2KKl
 maQqNxGc3TRwp6M141u5sHlzCo5X5/6ydAKVNK/eVf39q/loVVlM0hWf3nQc5o0M/wcU
 olWxodfkiPAyeWxhdE0139I0IO2I0Ndwn+RxsfkL8WDZ/yMmazXQ981/KuqcXyIpdQ8R
 uKebcOB9zU4gnSMOKLPOWrI2OpbbDggXsw2Msho0tGnm5gRi1R6hz946p5QOID0vTlrO
 4BTsQe74jz2b9kMibF35TIZ0ig8JbMPgP28rC5Vk07ugB41wrYubd2EMxKO5B3MkogAJ
 mpgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEQevUeLikLcHa0iyJGkC/0AEMqFSvPBw8eVuYEdQjtSKOBjKwUmtEhM1gTu0zUhXy92yBnlBUPc/l@nongnu.org
X-Gm-Message-State: AOJu0YwjXfBZRzGxdeHMG8JRUvdbPT9mOwrhFNc1TtiHaiy8BdVC7BRD
 QaY7eAQgp9JIm2hDbnN7lzNUyEUqFqfuzd6SUDBrpz+OWO8BR4ygxHk3tyR0PsIQv2Wha7KHCfc
 K8CPKc8Yb8JLPe9qqyiMhT9RSwco=
X-Google-Smtp-Source: AGHT+IHpwcLEJ88BJkQIGLdTjvDSaosPinaEjdmr75eRnA2FjilgQpkEdGseuR0iCTDcFQ0ZyH3TtCuHMATzOipBHLM=
X-Received: by 2002:a05:6820:1ca7:b0:5eb:6a67:6255 with SMTP id
 006d021491bc7-5ec23809e29mr9412165eaf.1.1730213491451; Tue, 29 Oct 2024
 07:51:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240830223601.2796327-1-goldstein.w.n@gmail.com>
 <6109eea4230bb3aa7caf6deff526878231aa2136.camel@linux.ibm.com>
 <CAFUsyf+wYJVQHFaJZZ2mE0e3MRXMoQsr+-vk3T0qU3LYd3Dujw@mail.gmail.com>
 <731d741bb01c8157a076a3614d20732a3ea448db.camel@linux.ibm.com>
 <CAFUsyfKhLpZF1RvwVK06jud6ArPEcG7M61cKNoQVWXLRgNaaog@mail.gmail.com>
 <CAFUsyfKgw_DAfowOoFxUpHOR+Jw6hH9oV5JGNXKe0Ph=miRFxw@mail.gmail.com>
 <CAFUsyf+RZ=NzPVzC0A2-WDym7562cwk-qPyjR+UryP9=RP8Fsw@mail.gmail.com>
In-Reply-To: <CAFUsyf+RZ=NzPVzC0A2-WDym7562cwk-qPyjR+UryP9=RP8Fsw@mail.gmail.com>
From: Noah Goldstein <goldstein.w.n@gmail.com>
Date: Tue, 29 Oct 2024 09:51:20 -0500
Message-ID: <CAFUsyfKonj1nUdM0jnGm+En+FdX1KZCtL+EMJG5n5LwDOWZ_SQ@mail.gmail.com>
Subject: Re: [PATCH v1] linux-user: Add option to run `execve`d programs
 through QEMU
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: laurent@vivier.eu, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=goldstein.w.n@gmail.com; helo=mail-oo1-xc2e.google.com
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

On Tue, Oct 22, 2024 at 5:06=E2=80=AFPM Noah Goldstein <goldstein.w.n@gmail=
.com> wrote:
>
> On Fri, Oct 11, 2024 at 1:14=E2=80=AFPM Noah Goldstein <goldstein.w.n@gma=
il.com> wrote:
> >
> > On Wed, Oct 2, 2024 at 11:42=E2=80=AFAM Noah Goldstein <goldstein.w.n@g=
mail.com> wrote:
> > >
> > > On Wed, Oct 2, 2024 at 11:39=E2=80=AFAM Ilya Leoshkevich <iii@linux.i=
bm.com> wrote:
> > > >
> > > > On Wed, 2024-10-02 at 09:05 -0500, Noah Goldstein wrote:
> > > > > On Wed, Oct 2, 2024 at 3:08=E2=80=AFAM Ilya Leoshkevich <iii@linu=
x.ibm.com>
> > > > > wrote:
> > > > > >
> > > > > > On Fri, 2024-08-30 at 15:36 -0700, Noah Goldstein wrote:
> > > > > > > The new option '-qemu-children' makes it so that on `execve` =
the
> > > > > > > child
> > > > > > > process will be launch by the same `qemu` executable that is
> > > > > > > currently
> > > > > > > running along with its current commandline arguments.
> > > > > > >
> > > > > > > The motivation for the change is to make it so that plugins
> > > > > > > running
> > > > > > > through `qemu` can continue to run on children.  Why not just
> > > > > > > `binfmt`?: Plugins can be desirable regardless of
> > > > > > > system/architecture
> > > > > > > emulation, and can sometimes be useful for elf files that can=
 run
> > > > > > > natively. Enabling `binfmt` for all natively runnable elf fil=
es
> > > > > > > may
> > > > > > > not be desirable.
> > > > > >
> > > > > > Another reason to have this is that one may not have root
> > > > > > permissions
> > > > > > to configure binfmt-misc.
> > > > > >
> > > > > +1
> > > > >
> > > > > > There was a similar patch posted to the mailing list some years
> > > > > > back,
> > > > > > which I used to cherry-pick when I needed this. I'm not sure wh=
at
> > > > > > happened to that discussion though.
> > > > >
> > > > > Yes(ish):
> > > > > https://patchwork.ozlabs.org/project/qemu-devel/patch/1455515507-=
26877-1-git-send-email-petrosagg@resin.io/
> > > >
> > > > Thanks for finding this! Don't we need the shebang handling here as
> > > > well?
> > > >
> > > I don't think so. In this case we aren't making it so execve can poin=
t to
> > > some arbitrary impl, just that we propagate the current running qemu
> > > env.
> > >
> >
> > ping
> ping2
pint3
> > > > Laurent, do you per chance know why was it not accepted back
> > > > then?Unfortunately I cannot find any discussion associated with v3 =
or
> > > > v4
> > > > [1]. There were some concerns regarding v1 [2], but from what I can=
 see
> > > > they all were addressed.
> > > >
> > > > [1]
> > > > https://patchew.org/QEMU/20200730160106.16613-1-rj.bcjesus@gmail.co=
m/
> > > > [2]
> > > > https://patchwork.kernel.org/project/qemu-devel/patch/1453091602-21=
843-1-git-send-email-petrosagg@gmail.com/

