Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3903C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 07:43:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riUsx-0006fC-6J; Fri, 08 Mar 2024 02:43:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1riUst-0006es-94
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 02:43:15 -0500
Received: from mail-ua1-x929.google.com ([2607:f8b0:4864:20::929])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1riUsr-0008AE-Al
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 02:43:15 -0500
Received: by mail-ua1-x929.google.com with SMTP id
 a1e0cc1a2514c-7da728b0597so772743241.1
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 23:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709883792; x=1710488592; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oeRPDzM+AkFwhAOnHUPqqiyx4CWHyjqCVbwRFQO3FyY=;
 b=FblCDwg17XxTaw/v0cy0gGz3kw07ZnOZT+G+UsZCex0qbMt/PO2kFlRZouNcPq86N0
 7t4P642AHp/jiXZWz7URO5bTx7ATl1zPNxU4+kf4Cc1rHX/5BT8t8HSaVbRPFQG1ADBd
 Ovi5UgK7nDCQeS0UsS3HrvT1RoUX7g1S3z8ubSZ5+f/yMp2PqVdWgm337MJWdhLIkwM0
 Yv9VQPfWKUc4bNBOMzMc4vl/ZZulp0m+z/jabphDK6U30VKXXXLJHyNbDszEi+lh9eGR
 qK6CiNujRVXyNC0iK/C2GSP2dDkfe7hgZ15a7IPuN4JLivLzE1Fio1eP4E2IY13ATUts
 7Fvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709883792; x=1710488592;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oeRPDzM+AkFwhAOnHUPqqiyx4CWHyjqCVbwRFQO3FyY=;
 b=nHaL7x9H7F54HRBGBq3ac1/Qsz13ZkaBHTDhca5KAMTh63VWWFF4dElEQQwHUvSJ9F
 P3PY6xWq0aWdUJRgXxlFNc74jw47/uFiT7LWnQG0PJ7ESzXc+N85otFerD2dxKRNG8cZ
 YZ/qo/TawLL9e+B6BYTe5jMjwQiMW2iKP5YCU1JkXIaDUs2Q/itbL1pbP+cuiG6AYuHL
 iWrVApV8vxIhmwaV9JL59L8cu+9veCLPG+kqQsbaVi4Y17g0aLu6iEiPR8T3YujoFjcj
 kAqivIuuwkNvPPQRAAwXc7HkwXPV5NiAKWOiRbITBgLBSZ9rtPZTbLceORYI4qIMBGzP
 XNfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJs5zjCrXIpvFGJ8nQuyRq+83rc6yt9MZQeqdtkBC+3w9LFjDcGdQ4oEWMtyGcDydDivGPfnTzKbjfYUA3vhnedp1YRos=
X-Gm-Message-State: AOJu0Yw+vz4vGr512exhK0Hj0eRQhm/vFVFUleBSMAvDASXzeod2Ca1H
 li8gMGm7fLHC5lyq8JiJn0Y7kNpgcYDP0tM9UoesSItlENT4Fa2QkeMJUpLsRJj0euk6kxbL0ve
 fzb0p4TE4YmyUmthq+9PwHrWhGik=
X-Google-Smtp-Source: AGHT+IFQJzLNvjM04EsCcXtvZVQIXjJUjruXfoA66+g0kPtG8qnK8Q9PRG+ngeZWAsmnMMu78TdxGQ17L62Kjdp/D/w=
X-Received: by 2002:a67:ee93:0:b0:472:cc97:cd29 with SMTP id
 n19-20020a67ee93000000b00472cc97cd29mr9825049vsp.32.1709883791689; Thu, 07
 Mar 2024 23:43:11 -0800 (PST)
MIME-Version: 1.0
References: <20240130234840.53122-1-dongwon.kim@intel.com>
 <PH8PR11MB6879F0CB84091A8436C3B891FA5E2@PH8PR11MB6879.namprd11.prod.outlook.com>
 <CAMxuvay8Gir6r4EWE0L=Y_YxGUxu9WS3TwNyUMe5vYX8Qt2SyA@mail.gmail.com>
 <PH8PR11MB68793A3B7706245CE4F0E972FA272@PH8PR11MB6879.namprd11.prod.outlook.com>
In-Reply-To: <PH8PR11MB68793A3B7706245CE4F0E972FA272@PH8PR11MB6879.namprd11.prod.outlook.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 8 Mar 2024 11:43:00 +0400
Message-ID: <CAJ+F1CL=n6VVq4fQPBaTyve2dZOGqq4_CzkBNmkvur_W3UYkOw@mail.gmail.com>
Subject: Re: [PATCH 0/3] ui/gtk: introducing vc->visible
To: "Kim, Dongwon" <dongwon.kim@intel.com>
Cc: "P. Berrange, Daniel" <berrange@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::929;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ua1-x929.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi

On Fri, Mar 8, 2024 at 4:59=E2=80=AFAM Kim, Dongwon <dongwon.kim@intel.com>=
 wrote:
>
> Hi Marc-Andr=C3=A9,
>
> > -----Original Message-----
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > Sent: Tuesday, March 5, 2024 4:18 AM
> > To: Kim, Dongwon <dongwon.kim@intel.com>; P. Berrange, Daniel
> > <berrange@redhat.com>
> > Cc: qemu-devel@nongnu.org
> > Subject: Re: [PATCH 0/3] ui/gtk: introducing vc->visible
> >
> > Hi Kim
> >
> > I am uncomfortable with the series in general.
> >
> > Not only we don't have the means to draw dmabuf/scanout "when required"=
, so
> > resuming drawing won't work until the guest draws (this is already a pr=
oblem but
> [Kim, Dongwon] Yes, this is right. The display won't be updated until the=
re is a new frame submitted.
> > you are only making it worse). And I also think reconfiguring the guest=
 by merely
> > minimizing or switching window/tabs isn't what most users would expect.
> [Kim, Dongwon] I understand your concern. Then what do you suggest I need=
 to do or look into to avoid the situation where the host rendering of the =
guest frame is scheduled but pending due to tab switching or minimization o=
f window as the guest (virtio-gpu drv) is waiting for the response to move =
on to the next frame? Do you think the frame update should just continue on=
 the host side regardless of visibility of the window? (If this is the stan=
dard expectation, then one of our Linux configuration - Yocto + ICE WM has =
some bug in it.)
>


Given that we can't pause/resume the drawing, I think it's best to
always draw regardless of the visibility. If GTK doesn't draw when
minimized or hidden, we should find a way to "force" that.


> >
> > (fwiw, my personal opinion is that QEMU shouldn't provide UIs and diffe=
rent
> > clients should be able to implement different behaviours, out of proces=
s.. that
> > makes me relatively less motivated to break things and be responsible)
> >
> > Daniel, could you have a look too?
> >
> > thanks
> >
> > On Fri, Mar 1, 2024 at 4:05=E2=80=AFAM Kim, Dongwon <dongwon.kim@intel.=
com>
> > wrote:
> > >
> > > Hi Marc-Andr=C3=A9 Lureau,
> > >
> > > Just a reminder.. I need your help reviewing this patch series. Pleas=
e
> > > take a look at my messages at
> > > https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg06636.html
> > > and
> > > https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg06637.html
> > >
> > > Thanks!!
> > > DW
> > >
> > > > -----Original Message-----
> > > > From: qemu-devel-bounces+dongwon.kim=3Dintel.com@nongnu.org <qemu-
> > > > devel-bounces+dongwon.kim=3Dintel.com@nongnu.org> On Behalf Of
> > > > dongwon.kim@intel.com
> > > > Sent: Tuesday, January 30, 2024 3:49 PM
> > > > To: qemu-devel@nongnu.org
> > > > Subject: [PATCH 0/3] ui/gtk: introducing vc->visible
> > > >
> > > > From: Dongwon Kim <dongwon.kim@intel.com>
> > > >
> > > > Drawing guest display frames can't be completed while the VC is not
> > > > in visible state, which could result in timeout in both the host an=
d
> > > > the guest especially when using blob scanout. Therefore it is neede=
d
> > > > to update and track the visiblity status of the VC and unblock the =
pipeline in
> > case when VC becomes invisible (e.g.
> > > > windows minimization, switching among tabs) while processing a gues=
t
> > frame.
> > > >
> > > > First patch (0001-ui-gtk-skip...) is introducing a flag 'visible' t=
o
> > > > VirtualConsole struct then set it only if the VC and its window is =
visible.
> > > >
> > > > Second patch (0002-ui-gtk-set-...) sets the ui size to 0 when VC is
> > > > invisible when the tab is closed or deactivated. This notifies the
> > > > guest that the associated guest display is not active anymore.
> > > >
> > > > Third patch (0003-ui-gtk-reset-visible...) adds a callback for GTK
> > > > window-state- event. The flag, 'visible' is updated based on the mi=
nization
> > status of the window.
> > > >
> > > > Dongwon Kim (3):
> > > >   ui/gtk: skip drawing guest scanout when associated VC is invisibl=
e
> > > >   ui/gtk: set the ui size to 0 when invisible
> > > >   ui/gtk: reset visible flag when window is minimized
> > > >
> > > >  include/ui/gtk.h |  1 +
> > > >  ui/gtk-egl.c     |  8 +++++++
> > > >  ui/gtk-gl-area.c |  8 +++++++
> > > >  ui/gtk.c         | 62 ++++++++++++++++++++++++++++++++++++++++++++=
++--
> > > >  4 files changed, 77 insertions(+), 2 deletions(-)
> > > >
> > > > --
> > > > 2.34.1
> > > >
> > >
>


--=20
Marc-Andr=C3=A9 Lureau

