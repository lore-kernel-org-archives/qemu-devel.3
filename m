Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F382E77199
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 14:02:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVt6j-000394-0U; Thu, 09 Jan 2025 09:01:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tVt6h-00038w-MY
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 09:01:55 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tVt6f-0006di-N6
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 09:01:55 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-aae81f4fdc4so207173866b.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 06:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736431312; x=1737036112; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xa3ERALZA/1laSbhnkzjbN2X9sCxzl4VZ/y6FQ2maxM=;
 b=OhKeDQnqX5q+tI7VO/wSWO+jCvEdZfoUVypGMHxZvA8YdCWzgpXbwUCuyNFs9B1jzS
 1qmTGk0LTQoAMiMPwOx9hIEKSRofRxt6sC9Hifs1MGQtwEqxtGT8DDyj7wIVopCKwSyr
 pWIYmulB+sn2yNNGPMmQG246czYVmPKjAOuprelU3rbar9MheeN+JHkUeXCD9S3wyj3u
 VVqK03V62OYElYrQHvfwOkbAZ+CQ8qp/xidCUsn4hQ1vnt4Mc59+3eZEVc0yg2C4uXV1
 8TCoYuf4DMX4JY5Yr36ZBqKZ7Aj91FZ/SofrTPK6MUxVkUBeGf1gDpNLuDhOegZq1G2d
 oNWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736431312; x=1737036112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xa3ERALZA/1laSbhnkzjbN2X9sCxzl4VZ/y6FQ2maxM=;
 b=cN51JIPUXimcFivWSvInCn7V9c/0H55PfK7dVaFKpXU9fI/5CwqJ9qhTWrWlRFslXY
 Ofz5kaVejU+dWHseTxm0McVa1L69pYtpG7FScb6jUXuV8B+KXr6MF57r6bHGgGNzZWur
 zzi3IfCHoN7KGefGkghHWi0edL9aFPxASDjQfKe1z6348yGUwB8OL+sGc5JQ2vV8b99q
 aoe7bBm1+i7Upm98tU3Xy2/fgECFVXO9VneWjykeBja+ZRZZnViVyHvrrcHs8hI+oyWo
 lhK6CNqfs2FUkj82cWRyA7/EGTCTlaovgHXkRQV4RJJLVnhTzNo4flQib0An2U8mL9sY
 HvXw==
X-Gm-Message-State: AOJu0YySaMENsJ3KR4jJh3e2jJ4Sn1Ufv476lWXmZ+ApMJLmW0oTc037
 yKQKAWM6ysMfk76qOopJ7OPcXEyFzUIVEDXAf63VrM5nBV2DptXksvz8CRPEq4nTOyRbMqfwDZD
 0CFHEiKGJqnodWDynkqM99g2ASHfccw==
X-Gm-Gg: ASbGncstmIhz+HPV/3M46HDoT+JuDSmSxYjtFjNvfXEqLeQfaJ4XGbKFEL15yDs3Rae
 VksdnDvBbDWsR+U8tzKP7Iu1oKsTT9t9bZKoC
X-Google-Smtp-Source: AGHT+IEeIbi9EjIHyiw9ERix767KfXmnLsYT5iAwCdupK60o62Lfer+gO0RwLLzYU5I4NTjYFX6H1NtMRWLz455JGFM=
X-Received: by 2002:a17:907:6022:b0:ab2:b6e2:fcc8 with SMTP id
 a640c23a62f3a-ab2b6e2ff0dmr446718266b.10.1736431309718; Thu, 09 Jan 2025
 06:01:49 -0800 (PST)
MIME-Version: 1.0
References: <20250108111023.156073-1-dwmw2@infradead.org>
 <CAJSP0QUyq6RfYPPV2EXthMaLr82Z9htEohaP4f+P=MLUF=JCWg@mail.gmail.com>
 <de33977443334962bf85d1f7968d2609ac35d6a5.camel@infradead.org>
In-Reply-To: <de33977443334962bf85d1f7968d2609ac35d6a5.camel@infradead.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 9 Jan 2025 09:01:37 -0500
X-Gm-Features: AbW1kvZxWAUfqKUDeyJvlb0MFUdmRpZQ-vpwLFyZTu3rgv6-JBkO-Qsqdqi0TSQ
Message-ID: <CAJSP0QXmJ2RdYuwHWPjMSXrTKzLAu-sa_eDFOsuJhG9ztr_LyQ@mail.gmail.com>
Subject: Re: [PULL 0/1] vmclock queue
To: David Woodhouse <dwmw2@infradead.org>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Peter Hilber <quic_philber@quicinc.com>, 
 "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>, paul <paul@xen.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=stefanha@gmail.com; helo=mail-ej1-x636.google.com
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

On Thu, 9 Jan 2025 at 08:18, David Woodhouse <dwmw2@infradead.org> wrote:
>
> On Thu, 2025-01-09 at 07:52 -0500, Stefan Hajnoczi wrote:
> > On Wed, 8 Jan 2025 at 06:11, David Woodhouse <dwmw2@infradead.org>
> > wrote:
> > >
> > > From: David Woodhouse <dwmw@amazon.co.uk>
> > >
> > > The following changes since commit
> > > 6528013b5f5ba6bb3934b7f5fe57a3110680530f:
> > >
> > >   Merge tag 'qga-pull-2025-01-06' of
> > > https://github.com/kostyanf14/qemu into staging (2025-01-06
> > > 09:39:02 -0500)
> > >
> > > are available in the Git repository at:
> > >
> > >   git://git.infradead.org/users/dwmw2/qemu.git tags/pull-vmclock-
> > > 20250108
> > >
> > > for you to fetch changes up to
> > > 6502ea82b26dc28c83fbc9c766af7a408a8ca827:
> > >
> > >   hw/acpi: Add vmclock device (2025-01-07 16:22:04 +0000)
> > >
> > > ----------------------------------------------------------------
> > > Add vmclock device
> > >
> > > ----------------------------------------------------------------
> > > David Woodhouse (1):
> > >       hw/acpi: Add vmclock device
> > >
> > >  hw/acpi/Kconfig                              |   5 +
> > >  hw/acpi/meson.build                          |   1 +
> > >  hw/acpi/vmclock.c                            | 179 +++++++++++++++++=
+++++++++
> > >  hw/i386/Kconfig                              |   1 +
> > >  hw/i386/acpi-build.c                         |  10 +-
> > >  include/hw/acpi/vmclock.h                    |  34 +++++
> > >  include/standard-headers/linux/vmclock-abi.h | 182 +++++++++++++++++=
++++++++++
> > >  scripts/update-linux-headers.sh              |   1 +
> > >  8 files changed, 412 insertions(+), 1 deletion(-)
> > >  create mode 100644 hw/acpi/vmclock.c
> > >  create mode 100644 include/hw/acpi/vmclock.h
> > >  create mode 100644 include/standard-headers/linux/vmclock-abi.h
> >
> > On IRC you mentioned that you'd like me to pick up this pull request.
> > If the ACPI subsystem maintainers don't want to take this through
> > their tree then let's set up pull request handling for vmclock:
> >
> > 1. Add a MAINTAINERS file entry for vmclock covering the new files
> > (e.g. hw/acpi/vmclock.c) with yourself as maintainer.
>
> Looks like Michael has taken it now; thanks.
>
> > 2. Send pull requests with a GPG-signed tag (git tag --sign) and
> > ensure that the repo URL in the email is https:// (the tooling rejects
> > unencrypted http:// and git:// repo URLs).
>
> You mean *or* rather than *and* in that sentence, right? Because if
> it's GPG-signed, then I can send it to you over carrier pigeon and you
> can validate it; the transport is irrelevant.
>
> If you really did mean 'and'... is this a new bug in the tooling? Last
> time I used Peter's make-pullreq script, it worked fine=C2=B9.

You're right, both are not required together for security. I still ask
for both because we historically had some submaintainers without GPG
keys and didn't want them to use unencrypted git:// or http:// URLs.
It's easier if everyone does both so I don't have to check whether
we've followed the right process depending on their GPG key status. I
think QEMU submaintainers have now fully transitioned to GPG keys, so
we could probably drop the https:// requirement.

If it's not too much trouble to use https:// then that would be easiest.

>
> Obviously it doesn't matter for *this* one now Michael has picked it
> up, but I sent another pull request today with some Xen emulation
> fixes=C2=B2.
>
> =C2=B9 https://lore.kernel.org/all/CAFEAcA9sjovBLdV1NsUnDGPs9hX1XYn7szbet=
Q-crtZ84VO4dQ@mail.gmail.com/
> =C2=B2 https://lore.kernel.org/qemu-devel/20250109104837.2532259-1-dwmw2@=
infradead.org/

