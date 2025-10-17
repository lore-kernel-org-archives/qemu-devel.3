Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 247E5CCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 07:00:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9eQr-0004in-Hj; Fri, 17 Oct 2025 02:59:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1v9eQo-0004iY-Hl
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 02:59:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1v9eQk-0005u9-3W
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 02:59:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760684351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U5+Ch12t0YIkXlLvQthmbPPTbAI4uhvsQ0mijGRHD90=;
 b=FwboAoDW0szAbS0S4WEF8KLMBYLTwMsXBRUDSyZ6mXxv4eZE0Zt5ncjCnRkTVfkcTCFkls
 ky1LYJOnciL3CLAvkiXI7OvwSMavYhg1oeOVU5aMVJL/5kywS19ITD8cLJ5mxI7gbfwMQw
 NQ7OLjc9FKwNS+s9SDNso6ulpUNKCqk=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-n-OUQoTyP5yysZhZf5qILA-1; Fri, 17 Oct 2025 02:59:09 -0400
X-MC-Unique: n-OUQoTyP5yysZhZf5qILA-1
X-Mimecast-MFC-AGG-ID: n-OUQoTyP5yysZhZf5qILA_1760684349
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-28973df6a90so16899815ad.2
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 23:59:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760684349; x=1761289149;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U5+Ch12t0YIkXlLvQthmbPPTbAI4uhvsQ0mijGRHD90=;
 b=ebgskQOzFZT+BXpbU7kE0qE/pesnta3dH4q18kdIhv/kYPPLK0d+8h6Z+XNRcNoTpi
 0/R7WZFLHd6alCbfc39p9y93UYbvn4zO5i3rLTWJGZjdISCQ7PXRlreIxmuAGD+6GQGk
 FmehneJ3SprKeimpiJWmiQrd23P2ba0sfSEpCKa2zRjm/d5eGlzPn9Q8ocWkF2yjNQaY
 4aGrMrxJor/oJsM1faNO3dG+vSfS2Xe1OLlwUV2W/wBHCvzmyp0bqB3qswmePcI8udsG
 9gbl63fKxBNYdWgo19Ji/SZHW1WjDmPvYy1tOM9Qa6MzXEgeXYrcx8cVQ0mWdVZhuoI9
 GNow==
X-Gm-Message-State: AOJu0YwJigFNAncadp0t3iege2BfKu8BO0LUAxLpKOu+0vka5wAliSko
 5LYTz15TcVFDta87OrAxGs8swcIpzOlv7z5GQU7AQbtSVuw8M7Odnerv0ty2RVq+xH7UoQ7Vqvu
 UAAsi9GMuyC65NCFBfAoxpp8UTX1U5QCnGRsIOUHbzvlD0UmYM3GDtMhf/t0QJn03OvogEfujh4
 97pg3AU4gYQqxwXKxYw/m+ZeHelkkRSUA=
X-Gm-Gg: ASbGnctlNbdX/rLXo9Bb7CeB9g6gqb6JVR1/3cUmpEJIjl5SY0LPqmAIxnz/DYtP59l
 Rye6roQoSc8MM9t9X292e1oNmQLTreGcsnXFwpRJDOEr7nKUBGbQhuUTZi3RobXBWgRm3iXpeR0
 /sAUfUkjrgeCu2b98UcbNpIVdoAswH/hAaHqM4yjzIJAuCyPI0h2w=
X-Received: by 2002:a17:902:e544:b0:249:37ad:ad03 with SMTP id
 d9443c01a7336-290cba4ebdamr30514885ad.34.1760684348771; 
 Thu, 16 Oct 2025 23:59:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5KL+s41TSDAIZW7kABhSH6tDY/z/Sz1TCNfgS/PeEDeHuUlYxy+W1gQ0TTip5pKgyXLSIBwQSA1sl15GSo3Q=
X-Received: by 2002:a17:902:e544:b0:249:37ad:ad03 with SMTP id
 d9443c01a7336-290cba4ebdamr30514315ad.34.1760684348021; Thu, 16 Oct 2025
 23:59:08 -0700 (PDT)
MIME-Version: 1.0
References: <20251016143827.1850397-1-aesteve@redhat.com>
 <20251016143827.1850397-2-aesteve@redhat.com>
 <CADSE00Ln3fjBhhs5W2YXiM7M6u6kg2=5r6Nx+d03bkinsX15BA@mail.gmail.com>
 <20251016183139.GB1179082@fedora>
In-Reply-To: <20251016183139.GB1179082@fedora>
From: Albert Esteve <aesteve@redhat.com>
Date: Fri, 17 Oct 2025 08:58:55 +0200
X-Gm-Features: AS18NWDwHjfUIPbWPBvQsK3o1GZ3mgcXbOqtHY5l4OEI_G-bRBznx89amcK8yP8
Message-ID: <CADSE00JegVPuSeopfyHTSyerywOy=1zFjs04TYnaPXBDC_LuTQ@mail.gmail.com>
Subject: Re: [PATCH v10 1/7] vhost-user: Add VirtIO Shared Memory map request
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 hi@alyssa.is, david@redhat.com, jasowang@redhat.com, dbassey@redhat.com, 
 stevensd@chromium.org, Stefano Garzarella <sgarzare@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, slp@redhat.com, manos.pitsidianakis@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Oct 16, 2025 at 8:31=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:
>
> On Thu, Oct 16, 2025 at 05:18:45PM +0200, Albert Esteve wrote:
> > On Thu, Oct 16, 2025 at 4:38=E2=80=AFPM Albert Esteve <aesteve@redhat.c=
om> wrote:
> > > @@ -1836,6 +2054,19 @@ static gboolean backend_read(QIOChannel *ioc, =
GIOCondition condition,
> > >          ret =3D vhost_user_backend_handle_shared_object_lookup(dev->=
opaque, ioc,
> > >                                                               &hdr, &=
payload);
> > >          break;
> > > +    case VHOST_USER_BACKEND_SHMEM_MAP:
> > > +        /* Handler manages its own response, check error and close c=
onnection */
> > > +        if (vhost_user_backend_handle_shmem_map(dev, ioc, &hdr, &pay=
load,
> > > +                                                fd ? fd[0] : -1) < 0=
) {
> > > +            goto err;
> > > +        }
> > > +        break;
> > > +    case VHOST_USER_BACKEND_SHMEM_UNMAP:
> > > +        /* Handler manages its own response, check error and close c=
onnection */
> > > +        if (vhost_user_backend_handle_shmem_unmap(dev, ioc, &hdr, &p=
ayload) < 0) {
> > > +            goto err;
> > > +        }
> > > +        break;
> >
> > Once this patch lands:
> > https://lists.gnu.org/archive/html/qemu-devel/2025-10/msg03932.html
> > These two handlers will need a `reply_ack =3D false;` before being
> > invoked. What's the best way to proceed in this case?
> >
> > If I can chose, I'd prefer to integrate this one first and then I can
> > rebase the one I linked and set the reply_ack where needed.
>
> You can rebase ahead of time and add "Based-on: <message-id>" to the
> cover letter so the maintainer knows there is a dependency between the
> patch series.
>
> https://www.qemu.org/docs/master/devel/submitting-a-patch.html#id35
>
> When sending the series that depends on another series, be careful to
> specify only the commit range from the end of the other series so that
> you don't include all the commits from the other series. That way
> reviewers aren't distracted by a bunch of other commits that are not
> part of this series.
>
> Summarizing:
> 1. Rebase your other series on this one.
> 2. Carefully send a new revision of your other series with only its
>    commits (not the commits from this series) and add "Based-on:
>    <message-id>" referencing this patch series by its Message-Id.

Perfect. I will do that for the other patch then. Thank you!

>
> Stefan


