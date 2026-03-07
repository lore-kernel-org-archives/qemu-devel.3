Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFD68FC9EFE
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 14:38:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vysnN-0000Ov-K7; Sat, 07 Mar 2026 09:38:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+db73df.54ef4-qemu-devel=nongnu.org@0x65c.net>)
 id 1vysnK-0000OW-8x
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 09:38:18 -0500
Received: from v54.v54282eed.euw1.send.eu.mailgun.net ([185.250.239.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+db73df.54ef4-qemu-devel=nongnu.org@0x65c.net>)
 id 1vysnI-00024M-4k
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 09:38:17 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=0x65c.net; q=dns/txt;
 s=email; t=1772894291; x=1772901491; 
 h=Content-Transfer-Encoding: Content-Type: Cc: To: To: Subject: Subject:
 Message-ID: Date: From: From: In-Reply-To: References: MIME-Version: Sender:
 Sender; bh=CIVRvzFrGJ3K76JB2kzzqQK67OQrknAET6ym9EvIvWY=;
 b=NYddC4EwfIN1Sfpa2tvqEq87XIG/8SrrzkzveMYua3ixwLxLt0RvCGJh9b+oTPzgp+n/DUN9NSjXwD67e/CU3Ek4aDqRAFEEhdskPSNpksoY+6H7OHyK6jEzVuL+wTNNdL2FDBJGyfW9F5OswpEwiC45t+d2UXQvMObqO0t8pRcblEJLQxWmSaFvHuoXfKh5Xwm6+SWFJZ9rFyR4pN/QJOqzr35o8PuWBm13L0c5v32TbEGlGwnfjJH7FwvOfLJ2KrqLx4bZTKI49zwq6Sl0GV9gJfc1Hbf/vpsZjMIiktHCWG7/+JBOJYMXS7vL59tTXNQaapQ0wE55h7XndEAs/Q==
X-Mailgun-Sid: WyJiNjdhNCIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjU0ZWY0Il0=
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com
 [209.85.128.175]) by
 820e6a982281072c0d8054a8b0ebf264f6462bee9871bbd6a674b9b471d2980c with SMTP id
 69ac385389b476602e40a6dc (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Sat, 07 Mar 2026 14:38:11 GMT
X-Mailgun-Sending-Ip: 185.250.239.4
Received: by mail-yw1-f175.google.com with SMTP id
 00721157ae682-7986e0553b0so86941417b3.2
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2026 06:38:10 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUBgAtP2Y8ZtTGlyh+5a1sEH1Jo9r9EytLbLSNB7aQtHDtKM6HXM7HgDQB3Rb3h1s0xfRVGx7nIen2O@nongnu.org
X-Gm-Message-State: AOJu0YzYIJMmjS190bOw01oat+e8FPg/InhKGbHar6hX1/tMdM4egR3f
 Bsn+K/vytfQw51WEolUXadiqHMxNUbKTrbH/sgutPyIYmiRM0LMRbfzB5HwYkwPWjsX5AMyhuPk
 oN/DenpVX9+BCrjSibeeAUAQK4k/9g3c=
X-Received: by 2002:a05:690c:6604:b0:796:6da9:bfa3 with SMTP id
 00721157ae682-798dd6706a6mr51622457b3.7.1772894290114; Sat, 07 Mar 2026
 06:38:10 -0800 (PST)
MIME-Version: 1.0
References: <aNLIHOwcGB47qbUY@redhat.com>
 <20250924093138.559872-1-alessandro@0x65c.net>
 <20250924093138.559872-2-alessandro@0x65c.net> <aNO7J7Y6wsk1-wyw@redhat.com>
 <CAFEAcA9oKbFi7hBvKcz_v_xWtHaPz4n3Q_cVEai1F1kZnr5PiA@mail.gmail.com>
In-Reply-To: <CAFEAcA9oKbFi7hBvKcz_v_xWtHaPz4n3Q_cVEai1F1kZnr5PiA@mail.gmail.com>
From: Alessandro Ratti <alessandro@0x65c.net>
Date: Sat, 7 Mar 2026 15:37:58 +0100
X-Gmail-Original-Message-ID: <CAKiXHKdSL+vRs+9BDFwWew0p1rooYSSQZCUYMcjuWVjgkkjxcQ@mail.gmail.com>
X-Gm-Features: AaiRm52GglpfxEV060oqFFR1xl5JNJCIgSgPBCocxkA_qN719mRtp6uX7C8HATw
Message-ID: <CAKiXHKdSL+vRs+9BDFwWew0p1rooYSSQZCUYMcjuWVjgkkjxcQ@mail.gmail.com>
Subject: Re: [PATCH v3] virtio: improve virtqueue mapping error messages
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 alex.bennee@linaro.org, armbru@redhat.com, mst@redhat.com, 
 qemu-devel@nongnu.org, Alessandro Ratti <alessandroratti@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=185.250.239.4;
 envelope-from=bounce+db73df.54ef4-qemu-devel=nongnu.org@0x65c.net;
 helo=v54.v54282eed.euw1.send.eu.mailgun.net
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, 7 Mar 2026 at 14:39, Peter Maydell <peter.maydell@linaro.org> wrote=
:
>
> On Wed, 24 Sept 2025 at 10:37, Daniel P. Berrang=C3=A9 <berrange@redhat.c=
om> wrote:
> >
> > On Wed, Sep 24, 2025 at 11:14:04AM +0200, Alessandro Ratti wrote:
> > > Improve error reporting when virtqueue ring mapping fails by includin=
g a
> > > device identifier in the error message.
> > >
> > > Introduce a helper qdev_get_printable_name() in qdev-core, which retu=
rns
> > > either:
> > >
> > >  - the device ID, if explicitly provided (e.g. -device ...,id=3Dfoo)
> > >  - the QOM path from qdev_get_dev_path(dev) otherwise
> > >  - "<unknown device>" as a fallback when no identifier is present
> > >
> > > This makes it easier to identify which device triggered the error in
> > > multi-device setups or when debugging complex guest configurations.
> > >
> > > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/230
> > > Buglink: https://bugs.launchpad.net/qemu/+bug/1919021
> > >
> > > Suggested-by: Markus Armbruster <armbru@redhat.com>
> > > Signed-off-by: Alessandro Ratti <alessandro@0x65c.net>
> > > ---
> > >  hw/core/qdev.c         | 29 +++++++++++++++++++++++++++++
> > >  hw/virtio/virtio.c     | 15 ++++++++++++---
> > >  include/hw/qdev-core.h |  1 +
> > >  3 files changed, 42 insertions(+), 3 deletions(-)
> >
> > Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>
> Hi; I just found this commit (now e209d4d7a31b9) in the course
> of finding a memory leak in it. I'm about to send patches to fix
> that, but in the meantime:
>
> We now have two different functions for "give me a nice string
> that I can use in an error message about this device":
>
>  * qdev_get_human_name(), used only in hw/block/block.c
>  * qdev_get_printable_name(), used only in hw/virtio/virtio.c
>
> Can we please have *one* function for this purpose?
>
> I see from the thread that the criticism of qdev_get_human_name()
> is that "it often returns opaque paths like
>
>    /machine/peripheral-anon/device[0]/virtio-backend
>
> which are less informative in user-facing logs compared to PCI IDs or
> user-specified names".
>
> So could we instead make block.c use qdev_get_printable_name(), and
> remove qdev_get_human_name() ? It also is using the result only
> to construct an error string for the user.
>

Hi Peter,

Thank you for catching the memory leak and for the feedback on the API desi=
gn.

You're right that having two similar functions is confusing and unnecessari=
ly
duplicates functionality. I agree that consolidating to a single function m=
akes
sense.

I can send a follow-up patch to:

1. Replace the usage of qdev_get_human_name() in hw/block/block.c with
   qdev_get_printable_name()
2. Remove qdev_get_human_name() entirely
3. Fix the memory leak in qdev_get_printable_name() (unless you already hav=
e
   a patch ready to send)

Alternatively, if you prefer to handle the consolidation as part of your
memory leak fix series, please feel free to do so - just let me know.

Thank you for your time and for improving the code.

Best regards,
Alessandro

