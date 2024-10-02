Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B9ECF6D2C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 14:45:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sw0bH-0001uY-SE; Wed, 02 Oct 2024 10:45:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <goldstein.w.n@gmail.com>)
 id 1sw0bC-0001sv-Bb
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 10:45:06 -0400
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <goldstein.w.n@gmail.com>)
 id 1sw0bA-0000xd-Fd
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 10:45:06 -0400
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-2879a491707so262991fac.2
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2024 07:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727880302; x=1728485102; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ep1zGGP0GZuI2pQx89aT1goB13eODYaikmCouEVJ5HA=;
 b=XQFwJQgeLsRG5i680A88o9xIFC4OPxs443JVCAc05gGSpGjQE7nMMwOMoYQBrP6KaJ
 IOISx2uHy+a7EzUk5Puw2zp/NFHNMSrxfJ8nt4sqVh0LxOZG3wQL+3tDcdHN7dBSq4fQ
 lhkKJ0fBcTWecx9ZEWKjvAzLF7cOz8TUUIwJcmthFelBsi152zLqqdg03R5ExmdpLSlt
 2JeGbW5Y5XD6lyfllbd0WJivhieRFJ5IguQ5dvyQk38kn9iMHw6YK00Kl5HeWf/ghMmz
 TLYri1HPbjCD9qTs8xueUg8qrhDSiph4P/168YCVFeWLyUDQL4/9jJbXE2LEBzhVaubi
 hVtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727880302; x=1728485102;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ep1zGGP0GZuI2pQx89aT1goB13eODYaikmCouEVJ5HA=;
 b=X4LlBja3TqaZtYf+aF5rvuvzzcMou1dUZu/knOI8DUxrVPJDSo5S5grFVtaiUXBRqS
 3y+BPasz4xecU5WqOP4MWkyAIVf/neJdetaXdfSdIdCead7GYbJUnRNbxxMTwOJyI4SR
 osqx/xPkvIOWm9KuUJT2Me34haYfHe+cONWcVDsNtZYeWiQQ5kDfWsdA+2sDnCXvPtG5
 c5sdiUbfBfzD7Sx8mqkG8iMJIr+AvkCh9vutfw7MrVc1Sy9Vh0JQp9T8N8wNPzzZonXK
 XWOrcpGTXAgHRB96FN8HwL0a91ki+8euZtZnU3MTp+3+nhK1ThEd6kHSQZEUkkGucrGF
 dxgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfI4/va5ES368NmISvQVxSFzOCxKTvGT3sjguiPKXxhSEulQZSkzoj8J4ma+09XFO+1Q0sBreUWqPW@nongnu.org
X-Gm-Message-State: AOJu0Yza5UoxLQeMUIH/ItPPTQBHJKK0gh+UAyEskRJ9bjfMHTIqXTzq
 u1oLlnpPuMEBZUspV/Ip16Q9+T9ipfBzpNOwi+xy6ulEJEp2zHoL1/E9hHoPOhiePxpmpaQKrkZ
 g4/PjgIZR0Zk44pEe5O/d4iGdj0Q=
X-Google-Smtp-Source: AGHT+IEg/Z+hGzyNMjKdyePMgF3KbHm1o66+0rSGFW2rOEW+cGPHv1ZR2MHYzepqQ4NydMIGV653SBznI/G/P9Xs/Pc=
X-Received: by 2002:a05:6870:9724:b0:278:64e:c5ef with SMTP id
 586e51a60fabf-28788f2a871mr2232087fac.37.1727880302484; Wed, 02 Oct 2024
 07:45:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240830223601.2796327-1-goldstein.w.n@gmail.com>
 <6109eea4230bb3aa7caf6deff526878231aa2136.camel@linux.ibm.com>
 <1251d17b-71f4-4630-b71f-990860bd9366@vivier.eu>
 <4d6c668781d12b8cd0c1fd18fbc4ef2abcf74806.camel@linux.ibm.com>
In-Reply-To: <4d6c668781d12b8cd0c1fd18fbc4ef2abcf74806.camel@linux.ibm.com>
From: Noah Goldstein <goldstein.w.n@gmail.com>
Date: Wed, 2 Oct 2024 09:44:51 -0500
Message-ID: <CAFUsyf++kWARZRJ0MriagYaoyJoJyKaHM09cQULiFECJ=bc4Uw@mail.gmail.com>
Subject: Re: [PATCH v1] linux-user: Add option to run `execve`d programs
 through QEMU
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=goldstein.w.n@gmail.com; helo=mail-oa1-x31.google.com
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

On Wed, Oct 2, 2024 at 9:38=E2=80=AFAM Ilya Leoshkevich <iii@linux.ibm.com>=
 wrote:
>
> On Wed, 2024-10-02 at 16:08 +0200, Laurent Vivier wrote:
> > Le 02/10/2024 =C3=A0 10:08, Ilya Leoshkevich a =C3=A9crit :
> > > On Fri, 2024-08-30 at 15:36 -0700, Noah Goldstein wrote:
> > > > The new option '-qemu-children' makes it so that on `execve` the
> > > > child
> > > > process will be launch by the same `qemu` executable that is
> > > > currently
> > > > running along with its current commandline arguments.
> > > >
> > > > The motivation for the change is to make it so that plugins
> > > > running
> > > > through `qemu` can continue to run on children.  Why not just
> > > > `binfmt`?: Plugins can be desirable regardless of
> > > > system/architecture
> > > > emulation, and can sometimes be useful for elf files that can run
> > > > natively. Enabling `binfmt` for all natively runnable elf files
> > > > may
> > > > not be desirable.
> > >
> > > Another reason to have this is that one may not have root
> > > permissions
> > > to configure binfmt-misc.
> >
> > A little note on that: binfmt_misc is now part of the user namespace
> > (since linux v6.7), so you can
> > configure binfmt_misc as a non root user in a given namepace.
> >
> > There is helper to use it with unshare from util-linux, you can do
> > things like that:
> >
> >    With 'F' flag, load the interpreter from the initial namespace:
> >
> >      $ /bin/qemu-m68k-static --version
> >      qemu-m68k version 8.2.2 (qemu-8.2.2-1.fc40)
> >      Copyright (c) 2003-2023 Fabrice Bellard and the QEMU Project
> > developers
> >      $ unshare --map-root-user --fork --pid
> > --load-interp=3D":qemu-
> > m68k:M::\\x7fELF\\x01\\x02\\x01\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x
> > 00\\x00\\x00\\x02\\x00\\x04:\\xff\\xff\\xff\\xff\\xff\\xff\\xfe\\x00\
> > \xff\\xff\\xff\\xff\\xff\\xff\\xff\\xff\\xff\\xfe\\xff\\xff:/bin/qemu
> > -m68k-static:OCF"
> > --root=3Dchroot/m68k/sid
> >      # QEMU_VERSION=3D ls
> >      qemu-m68k version 8.2.2 (qemu-8.2.2-1.fc40)
> >      Copyright (c) 2003-2023 Fabrice Bellard and the QEMU Project
> > developers
> >      # /qemu-m68k  --version
> >      qemu-m68k version 8.0.50 (v8.0.0-340-gb1cff5e2da95)
> >      Copyright (c) 2003-2022 Fabrice Bellard and the QEMU Project
> > developers
> >
> >    Without 'F' flag, from inside the namespace:
> >
> >      $ unshare --map-root-user --fork --pid
> > --load-interp=3D":qemu-
> > m68k:M::\\x7fELF\\x01\\x02\\x01\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x
> > 00\\x00\\x00\\x02\\x00\\x04:\\xff\\xff\\xff\\xff\\xff\\xff\\xfe\\x00\
> > \xff\\xff\\xff\\xff\\xff\\xff\\xff\\xff\\xff\\xfe\\xff\\xff:/qemu-
> > m68k:OC"
> > --root=3Dchroot/m68k/sid
> >      # QEMU_VERSION=3D ls
> >      qemu-m68k version 8.0.50 (v8.0.0-340-gb1cff5e2da95)
> >      Copyright (c) 2003-2022 Fabrice Bellard and the QEMU Project
> > developers
> >      # /qemu-m68k  --version
> >      qemu-m68k version 8.0.50 (v8.0.0-340-gb1cff5e2da95)
> >      Copyright (c) 2003-2022 Fabrice Bellard and the QEMU Project
> > developers
> >
> > Thanks,
> > Laurent
> >
>
> Thanks for posting this, I wasn't aware of this feature and it looks
> really useful.
>
> IIUC it also resolves the main problem this patch is dealing with:

I might misunderstand, but I don't think it does in the sense
that it still might not be desirable to use the same qemu flags
for the entire class of executables.

I.e the original motivating case was wanting to attach
some plugins to a process and its children and AFAICT
binfmt still doesn't give that level of control.
>
>   Enabling `binfmt` for all natively runnable elf files may
>   not be desirable.

