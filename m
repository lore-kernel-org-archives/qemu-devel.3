Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B63D8CF6D2D
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 15:11:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sw10O-00027x-CO; Wed, 02 Oct 2024 11:11:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <goldstein.w.n@gmail.com>)
 id 1sw10K-00027b-V3
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 11:11:05 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <goldstein.w.n@gmail.com>)
 id 1sw10F-0003w7-I6
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 11:11:01 -0400
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-712422564aaso449236a34.0
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2024 08:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727881858; x=1728486658; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KfExAwxfr24Vzg/kY3Ftxp0xpjfKo2CH9Xir9C5j1ZU=;
 b=gj5xiccAKrQh4g+K2dn7NDRiEQGYbtCtbs4b+JqTzqO6QcxplvFkgvMAPBG6CQVnp1
 CiaTTWUAi3G9eN8M2IFp5oOTAQNhmACquHW7YMaTqgk4ZNZHWudocJOzA3MUeY3YxsUt
 3MZdGpqlZx+/fvUoqtp2xQCscO2iheYPqAhwqQujH3oY5Cga5CY+O1kabvHYRVjoXj/f
 aYnO5atANFZGtm09xuoG1ASgO+bEKdaNmHfu8gqcJ43Cy/zYwLV3dYAdxbCx1I48Dr0E
 EEh5mEtVv4yunNg8YAxzGdMJAz4PBf6nHRgskzU9X+Ir6lAaPHRGfDT4UUXClzK1AFqU
 bC2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727881858; x=1728486658;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KfExAwxfr24Vzg/kY3Ftxp0xpjfKo2CH9Xir9C5j1ZU=;
 b=oBh2wdZRvT5Epb4ece9UFqELagYzbaorAVbhQ5a6xUi6vaFwYsmU5YdScHSUs4nCPj
 ZsIUhasw7yCgD961euAG2+CC82Qht68nCzs1VJJJRljkvo+XecrwlS5CM6tQZTqo7/vV
 4DZhY3YmVFPCkH9SGpNv3u+IABtqox9Ay7OyJwDVxxyXIeAUVwDPesxGsURixfdTo971
 Jmslimg+s3CPQFpwEiRVvMwRY+IngkStwGOc0T+fqHFd5TUSNin+Q3/hHd0U27MdhFO7
 iBBEnlUR2bRSVr2Csk2x+4uoucfStTpR41PKRxkM20sIHIs59W6hTpHUrm7CvKtx3IIA
 IM4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUagNLTeYoEbnCy4a3qNs/XkEASyXmZP08VS2xs+uFtUEVVyqd3K/0PKfZr7goI4oEAkMblg/4nPZ6p@nongnu.org
X-Gm-Message-State: AOJu0YwJmrCFpcghT5VD6xVQLQLThm3KqrSl+MFMNd1fx5vq9cdsRLBt
 N56tBCjUE4ljNIwRnPvi6+UCNKQojCMCzzWZSKB4qmVqYx3wHpdxuNB3rwx8N1eCMITgsRpueUh
 SsSCZx9k3mWZE5bdYkaGtPC0JDBL91/fl
X-Google-Smtp-Source: AGHT+IHe6G3oFKHsUZv44hPSyJN6ZfYg3dYS3k4EMyvKyOh5Xa+ikub9owuMMtW5p/Sh7BR/5+HhOcF/jUQl+B3Jls4=
X-Received: by 2002:a05:6870:548c:b0:277:ca34:27e9 with SMTP id
 586e51a60fabf-287875fe0ffmr1916078fac.6.1727881857756; Wed, 02 Oct 2024
 08:10:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240830223601.2796327-1-goldstein.w.n@gmail.com>
 <6109eea4230bb3aa7caf6deff526878231aa2136.camel@linux.ibm.com>
 <1251d17b-71f4-4630-b71f-990860bd9366@vivier.eu>
 <4d6c668781d12b8cd0c1fd18fbc4ef2abcf74806.camel@linux.ibm.com>
 <CAFUsyf++kWARZRJ0MriagYaoyJoJyKaHM09cQULiFECJ=bc4Uw@mail.gmail.com>
 <693ff38ebf2982d47cc419a406703e9e91dc79fd.camel@linux.ibm.com>
In-Reply-To: <693ff38ebf2982d47cc419a406703e9e91dc79fd.camel@linux.ibm.com>
From: Noah Goldstein <goldstein.w.n@gmail.com>
Date: Wed, 2 Oct 2024 10:10:46 -0500
Message-ID: <CAFUsyfKddfkryMX3Jn+2uDrteHDDgdzrQ3A4k5oXNpHq2FG_Gw@mail.gmail.com>
Subject: Re: [PATCH v1] linux-user: Add option to run `execve`d programs
 through QEMU
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=goldstein.w.n@gmail.com; helo=mail-ot1-x330.google.com
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

On Wed, Oct 2, 2024 at 9:53=E2=80=AFAM Ilya Leoshkevich <iii@linux.ibm.com>=
 wrote:
>
> On Wed, 2024-10-02 at 09:44 -0500, Noah Goldstein wrote:
> > On Wed, Oct 2, 2024 at 9:38=E2=80=AFAM Ilya Leoshkevich <iii@linux.ibm.=
com>
> > wrote:
> > >
> > > On Wed, 2024-10-02 at 16:08 +0200, Laurent Vivier wrote:
> > > > Le 02/10/2024 =C3=A0 10:08, Ilya Leoshkevich a =C3=A9crit :
> > > > > On Fri, 2024-08-30 at 15:36 -0700, Noah Goldstein wrote:
> > > > > > The new option '-qemu-children' makes it so that on `execve`
> > > > > > the
> > > > > > child
> > > > > > process will be launch by the same `qemu` executable that is
> > > > > > currently
> > > > > > running along with its current commandline arguments.
> > > > > >
> > > > > > The motivation for the change is to make it so that plugins
> > > > > > running
> > > > > > through `qemu` can continue to run on children.  Why not just
> > > > > > `binfmt`?: Plugins can be desirable regardless of
> > > > > > system/architecture
> > > > > > emulation, and can sometimes be useful for elf files that can
> > > > > > run
> > > > > > natively. Enabling `binfmt` for all natively runnable elf
> > > > > > files
> > > > > > may
> > > > > > not be desirable.
> > > > >
> > > > > Another reason to have this is that one may not have root
> > > > > permissions
> > > > > to configure binfmt-misc.
> > > >
> > > > A little note on that: binfmt_misc is now part of the user
> > > > namespace
> > > > (since linux v6.7), so you can
> > > > configure binfmt_misc as a non root user in a given namepace.
> > > >
> > > > There is helper to use it with unshare from util-linux, you can
> > > > do
> > > > things like that:
> > > >
> > > >    With 'F' flag, load the interpreter from the initial
> > > > namespace:
> > > >
> > > >      $ /bin/qemu-m68k-static --version
> > > >      qemu-m68k version 8.2.2 (qemu-8.2.2-1.fc40)
> > > >      Copyright (c) 2003-2023 Fabrice Bellard and the QEMU Project
> > > > developers
> > > >      $ unshare --map-root-user --fork --pid
> > > > --load-interp=3D":qemu-
> > > > m68k:M::\\x7fELF\\x01\\x02\\x01\\x00\\x00\\x00\\x00\\x00\\x00\\x0
> > > > 0\\x
> > > > 00\\x00\\x00\\x02\\x00\\x04:\\xff\\xff\\xff\\xff\\xff\\xff\\xfe\\
> > > > x00\
> > > > \xff\\xff\\xff\\xff\\xff\\xff\\xff\\xff\\xff\\xfe\\xff\\xff:/bin/
> > > > qemu
> > > > -m68k-static:OCF"
> > > > --root=3Dchroot/m68k/sid
> > > >      # QEMU_VERSION=3D ls
> > > >      qemu-m68k version 8.2.2 (qemu-8.2.2-1.fc40)
> > > >      Copyright (c) 2003-2023 Fabrice Bellard and the QEMU Project
> > > > developers
> > > >      # /qemu-m68k  --version
> > > >      qemu-m68k version 8.0.50 (v8.0.0-340-gb1cff5e2da95)
> > > >      Copyright (c) 2003-2022 Fabrice Bellard and the QEMU Project
> > > > developers
> > > >
> > > >    Without 'F' flag, from inside the namespace:
> > > >
> > > >      $ unshare --map-root-user --fork --pid
> > > > --load-interp=3D":qemu-
> > > > m68k:M::\\x7fELF\\x01\\x02\\x01\\x00\\x00\\x00\\x00\\x00\\x00\\x0
> > > > 0\\x
> > > > 00\\x00\\x00\\x02\\x00\\x04:\\xff\\xff\\xff\\xff\\xff\\xff\\xfe\\
> > > > x00\
> > > > \xff\\xff\\xff\\xff\\xff\\xff\\xff\\xff\\xff\\xfe\\xff\\xff:/qemu
> > > > -
> > > > m68k:OC"
> > > > --root=3Dchroot/m68k/sid
> > > >      # QEMU_VERSION=3D ls
> > > >      qemu-m68k version 8.0.50 (v8.0.0-340-gb1cff5e2da95)
> > > >      Copyright (c) 2003-2022 Fabrice Bellard and the QEMU Project
> > > > developers
> > > >      # /qemu-m68k  --version
> > > >      qemu-m68k version 8.0.50 (v8.0.0-340-gb1cff5e2da95)
> > > >      Copyright (c) 2003-2022 Fabrice Bellard and the QEMU Project
> > > > developers
> > > >
> > > > Thanks,
> > > > Laurent
> > > >
> > >
> > > Thanks for posting this, I wasn't aware of this feature and it
> > > looks
> > > really useful.
> > >
> > > IIUC it also resolves the main problem this patch is dealing with:
> >
> > I might misunderstand, but I don't think it does in the sense
> > that it still might not be desirable to use the same qemu flags
> > for the entire class of executables.
> >
> > I.e the original motivating case was wanting to attach
> > some plugins to a process and its children and AFAICT
> > binfmt still doesn't give that level of control.
>
> I think if you start a process in a user namespace, which has a
> binfmt_misc handler for a certain class of binaries, then this handler
> will affect only this process and its children, and not the rest of the
> system.

It won't also affect other binaries in the user namespace?

>
> > >   Enabling `binfmt` for all natively runnable elf files may
> > >   not be desirable.
>

