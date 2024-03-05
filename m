Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D73CEC54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 12:19:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhTkq-0008D4-NN; Tue, 05 Mar 2024 07:18:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1rhTkj-00083X-9l
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 07:18:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1rhTkh-0003B6-Au
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 07:18:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709641112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=12c8QEjQRjPojdJVSjK28K0zJsO6fMItylegWxv/gxE=;
 b=CKGpzkLfvaIeXhvlb2wNXJpfSzjabQf67YeRympGO6LCb4NSleVGsWQmvPnCS2qjyIulFM
 7uLlsC/tqBhYLp+yoWOqjZykU3qTWQAOr3o7dD0MaMZmRfw7JwlSwBpVEd6HCpid8EhBWz
 tf4cN5ZTzgFdSgNKazCjQFnEewtcHFY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-piLtlgF5MNKpaITRM2SlWQ-1; Tue, 05 Mar 2024 07:18:31 -0500
X-MC-Unique: piLtlgF5MNKpaITRM2SlWQ-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-55d71ec6ef3so5272331a12.0
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 04:18:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709641110; x=1710245910;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=12c8QEjQRjPojdJVSjK28K0zJsO6fMItylegWxv/gxE=;
 b=B8l7VBY0l1II8esa8pSVm+oX7SqdGyt7tYaqwVCwFJthBLbjUgyJXeLzqxM16meV7b
 4xv63psdT1crgE32g3pwns5OtUsK49MuvfUlC6VARhvjs7HJ2oMCbqIJPPvY2JTaq0Bp
 dzLB+aiT2codPLu/b8eEY2cUOoQ/3DM3kVn5hDiyQyR1SgDBVzpfuL0UluIuZjqO8R41
 DCiH7PUVxJozu+/8sjClH8hq1LqvTAZU45hEe+KRDnK643s+2C2nXJIqgK/Xbpqjwhr6
 CGby1dS0cxncglzw3fwZ1UY0ObppTzcUZvcbK0bogSCaAaUFWb3pf5pAYzqGYNjZcwGP
 eUEA==
X-Gm-Message-State: AOJu0Yy6sqlgLhqfwwLx+6/Vqt8KzMXcl2vm+GmM7plGSoDOdH4H4Rnd
 LkSLTQeZHGrUQ7+z6PFi+/zll2eNTJoCIO+wx0IbMXXYVHWka+TVIQeWOLZtDy+1UlRqLzqr6Ac
 s4mH5gmTW+Uv7FWpELeMK3/QAtHZ93L9v9rd1v08Nni8ALIw2wWq5yKKDbPlRuFcY4RJWb6wLa1
 7oCi1GjOKY65bQYm5OIA1TKaO5erE=
X-Received: by 2002:a50:c8cb:0:b0:566:a235:9355 with SMTP id
 k11-20020a50c8cb000000b00566a2359355mr8652014edh.33.1709641110143; 
 Tue, 05 Mar 2024 04:18:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEcPOPGnW9muaKglY2l01ppj3QXD/8ZLzSVGK6MZ9HaTuyyWmRQYcycoO6PIwCvTF1XC/wKBmwA/BXqFi/t3ZA=
X-Received: by 2002:a50:c8cb:0:b0:566:a235:9355 with SMTP id
 k11-20020a50c8cb000000b00566a2359355mr8652005edh.33.1709641109836; Tue, 05
 Mar 2024 04:18:29 -0800 (PST)
MIME-Version: 1.0
References: <20240130234840.53122-1-dongwon.kim@intel.com>
 <PH8PR11MB6879F0CB84091A8436C3B891FA5E2@PH8PR11MB6879.namprd11.prod.outlook.com>
In-Reply-To: <PH8PR11MB6879F0CB84091A8436C3B891FA5E2@PH8PR11MB6879.namprd11.prod.outlook.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 5 Mar 2024 16:18:18 +0400
Message-ID: <CAMxuvay8Gir6r4EWE0L=Y_YxGUxu9WS3TwNyUMe5vYX8Qt2SyA@mail.gmail.com>
Subject: Re: [PATCH 0/3] ui/gtk: introducing vc->visible
To: "Kim, Dongwon" <dongwon.kim@intel.com>, "P. Berrange,
 Daniel" <berrange@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.568,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Kim

I am uncomfortable with the series in general.

Not only we don't have the means to draw dmabuf/scanout "when
required", so resuming drawing won't work until the guest draws (this
is already a problem but you are only making it worse). And I also
think reconfiguring the guest by merely minimizing or switching
window/tabs isn't what most users would expect.

(fwiw, my personal opinion is that QEMU shouldn't provide UIs and
different clients should be able to implement different behaviours,
out of process.. that makes me relatively less motivated to break
things and be responsible)

Daniel, could you have a look too?

thanks

On Fri, Mar 1, 2024 at 4:05=E2=80=AFAM Kim, Dongwon <dongwon.kim@intel.com>=
 wrote:
>
> Hi Marc-Andr=C3=A9 Lureau,
>
> Just a reminder.. I need your help reviewing this patch series. Please ta=
ke a look at my messages at
> https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg06636.html and
> https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg06637.html
>
> Thanks!!
> DW
>
> > -----Original Message-----
> > From: qemu-devel-bounces+dongwon.kim=3Dintel.com@nongnu.org <qemu-
> > devel-bounces+dongwon.kim=3Dintel.com@nongnu.org> On Behalf Of
> > dongwon.kim@intel.com
> > Sent: Tuesday, January 30, 2024 3:49 PM
> > To: qemu-devel@nongnu.org
> > Subject: [PATCH 0/3] ui/gtk: introducing vc->visible
> >
> > From: Dongwon Kim <dongwon.kim@intel.com>
> >
> > Drawing guest display frames can't be completed while the VC is not in =
visible
> > state, which could result in timeout in both the host and the guest esp=
ecially
> > when using blob scanout. Therefore it is needed to update and track the=
 visiblity
> > status of the VC and unblock the pipeline in case when VC becomes invis=
ible (e.g.
> > windows minimization, switching among tabs) while processing a guest fr=
ame.
> >
> > First patch (0001-ui-gtk-skip...) is introducing a flag 'visible' to Vi=
rtualConsole
> > struct then set it only if the VC and its window is visible.
> >
> > Second patch (0002-ui-gtk-set-...) sets the ui size to 0 when VC is inv=
isible when
> > the tab is closed or deactivated. This notifies the guest that the asso=
ciated guest
> > display is not active anymore.
> >
> > Third patch (0003-ui-gtk-reset-visible...) adds a callback for GTK wind=
ow-state-
> > event. The flag, 'visible' is updated based on the minization status of=
 the window.
> >
> > Dongwon Kim (3):
> >   ui/gtk: skip drawing guest scanout when associated VC is invisible
> >   ui/gtk: set the ui size to 0 when invisible
> >   ui/gtk: reset visible flag when window is minimized
> >
> >  include/ui/gtk.h |  1 +
> >  ui/gtk-egl.c     |  8 +++++++
> >  ui/gtk-gl-area.c |  8 +++++++
> >  ui/gtk.c         | 62 ++++++++++++++++++++++++++++++++++++++++++++++--
> >  4 files changed, 77 insertions(+), 2 deletions(-)
> >
> > --
> > 2.34.1
> >
>


