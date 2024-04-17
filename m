Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEAE0C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 18:17:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rx9q5-0004sN-N2; Wed, 17 Apr 2024 14:16:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1rx9q4-0004s7-5I
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 14:16:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1rx9q2-0000Qg-3H
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 14:16:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713377812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=whN/SOtxL59c758CBfb/TJDKEHv75PJbgsx8eW6jrqE=;
 b=X0eDD4VOa13ytDOktKom8eWOxiyhgndrl62bsgUhPaCInOkMwKovztV5JRn3oGmRh54l9h
 xvzJ6mMJgdGYnWkLcfoY1EkbFlxIoyD1+LbAzneUBE3JG5MXsKLGTZK5cB6i4aIZwMTRwj
 26pRWwxiundK37bIVjWVLQbq+Myv7OY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-wkOyS59TPQaIln04MMAaJw-1; Wed, 17 Apr 2024 14:16:51 -0400
X-MC-Unique: wkOyS59TPQaIln04MMAaJw-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-56e34264982so2313819a12.3
 for <qemu-devel@nongnu.org>; Wed, 17 Apr 2024 11:16:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713377810; x=1713982610;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=whN/SOtxL59c758CBfb/TJDKEHv75PJbgsx8eW6jrqE=;
 b=VlOTVkXcnNK7PpJ3A7irFT3xVC4CEBhGdYDBGWJ1EU0WVrdhXgR4L8S5uoPyf/OF30
 BZmLVOgYzcJdcCOMhvHG2mUAwVCBoRmrKRKo62grFvizu1Q3TnNPwhjF0yFjpitni99u
 YHuUigQ5ELJutyxu0mJkQyDLzujB1IyynBkrezPkK6/BH1yNbyqC5mCM2p94ndGudXjR
 R2Hy9wf324ZTR5vpcDnMBgQwUhYH+Dy2r3ujM+fE0yWRtpFi9WOMaqpRoIVSRaJVtoJe
 p08l+jafks8eiTBjE+xdnKIb3aJryHIhtL9xYAVnDH3oBjiIdOPmUbmgjtVQvO/m3Xo3
 Oxzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8M58NoYYbnNaJW5WUqZ16PZhjI+JxCOGlqoL6F1u7tUGDjW1uoR4UfB9NO6btgBwai49CWYvBMVKOdwJalusyhrUzmBk=
X-Gm-Message-State: AOJu0Yw7uczJUH7HhJ84a1Otwu6XxOS+RXUiA2elxCrKeV3ChBPg0fch
 L0Xg4SWN8KP4R29Didr8NEJwheqkEw7DHjAgZ2e1oNfQA+o6wID6BWNaRmSUzdYxQDU+PkAvB2p
 B4z74h+8KzBQdbzR2P5ft60dvFia9hXFaPZ36EXccgpRyuJELtoFSdsUbmAS7CaclSVY179quij
 NIruWp1Lp6EX4ucm3zs4jOM11c1bQ=
X-Received: by 2002:a50:9ea6:0:b0:56e:57f9:8c83 with SMTP id
 a35-20020a509ea6000000b0056e57f98c83mr328566edf.19.1713377809984; 
 Wed, 17 Apr 2024 11:16:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEC6P4zCg7CoyXiCe1OGJQI3F1tg3a2p8iEJzZOmCcA5bAxtsLsZ9c3BngyyNu5KbLyOFVAf+bGjt6hK3xBl60=
X-Received: by 2002:a50:9ea6:0:b0:56e:57f9:8c83 with SMTP id
 a35-20020a509ea6000000b0056e57f98c83mr328550edf.19.1713377809642; Wed, 17 Apr
 2024 11:16:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240417040954.55641-1-dongwon.kim@intel.com>
 <20240417040954.55641-2-dongwon.kim@intel.com>
 <Zh-s1wqWU8c0GHS8@redhat.com>
 <PH8PR11MB6879490376E2A6F9A4831643FA0F2@PH8PR11MB6879.namprd11.prod.outlook.com>
In-Reply-To: <PH8PR11MB6879490376E2A6F9A4831643FA0F2@PH8PR11MB6879.namprd11.prod.outlook.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 17 Apr 2024 22:16:37 +0400
Message-ID: <CAMxuvay5-368Qe=DD4VU1h=AADh9iMgnj7p9ZtA2OR-6AWDzQQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] ui/console: Introduce dpy_gl_qemu_dmabuf_get_..()
 helpers
To: "Kim, Dongwon" <dongwon.kim@intel.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.719,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Apr 17, 2024 at 9:06=E2=80=AFPM Kim, Dongwon <dongwon.kim@intel.com=
> wrote:
>
> Hi Daniel,
>
> > -----Original Message-----
> > From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > Sent: Wednesday, April 17, 2024 4:05 AM
> > To: Kim, Dongwon <dongwon.kim@intel.com>
> > Cc: qemu-devel@nongnu.org; marcandre.lureau@redhat.com
> > Subject: Re: [PATCH v6 1/3] ui/console: Introduce
> > dpy_gl_qemu_dmabuf_get_..() helpers
> >
> > On Tue, Apr 16, 2024 at 09:09:52PM -0700, dongwon.kim@intel.com wrote:
> > > From: Dongwon Kim <dongwon.kim@intel.com>
> > >
> > > This commit introduces dpy_gl_qemu_dmabuf_get_... helpers to extract
> > > specific fields from the QemuDmaBuf struct. It also updates all
> > > instances where fields within the QemuDmaBuf struct are directly
> > > accessed, replacing them with calls to these new helper functions.
> > >
> > > v6: fix typos in helper names in ui/spice-display.c
> > >
> > > Suggested-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > > Cc: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > > Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
> > > Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
> > > ---
> > >  include/ui/console.h            |  17 +++++
> > >  hw/display/vhost-user-gpu.c     |   6 +-
> > >  hw/display/virtio-gpu-udmabuf.c |   7 +-
> > >  hw/vfio/display.c               |  15 +++--
> > >  ui/console.c                    | 116 ++++++++++++++++++++++++++++++=
+-
> > >  ui/dbus-console.c               |   9 ++-
> > >  ui/dbus-listener.c              |  43 +++++++-----
> > >  ui/egl-headless.c               |  23 +++++--
> > >  ui/egl-helpers.c                |  47 +++++++------
> > >  ui/gtk-egl.c                    |  48 ++++++++-----
> > >  ui/gtk-gl-area.c                |  37 ++++++----
> > >  ui/gtk.c                        |   6 +-
> > >  ui/spice-display.c              |  50 ++++++++------
> > >  13 files changed, 316 insertions(+), 108 deletions(-)
> > >
> > > diff --git a/include/ui/console.h b/include/ui/console.h index
> > > 0bc7a00ac0..6292943a82 100644
> > > --- a/include/ui/console.h
> > > +++ b/include/ui/console.h
> > > @@ -358,6 +358,23 @@ void dpy_gl_cursor_dmabuf(QemuConsole *con,
> > QemuDmaBuf *dmabuf,
> > >                            bool have_hot, uint32_t hot_x, uint32_t
> > > hot_y);  void dpy_gl_cursor_position(QemuConsole *con,
> > >                              uint32_t pos_x, uint32_t pos_y);
> > > +
> > > +int32_t dpy_gl_qemu_dmabuf_get_fd(QemuDmaBuf *dmabuf); uint32_t
> > > +dpy_gl_qemu_dmabuf_get_width(QemuDmaBuf *dmabuf); uint32_t
> > > +dpy_gl_qemu_dmabuf_get_height(QemuDmaBuf *dmabuf); uint32_t
> > > +dpy_gl_qemu_dmabuf_get_stride(QemuDmaBuf *dmabuf); uint32_t
> > > +dpy_gl_qemu_dmabuf_get_fourcc(QemuDmaBuf *dmabuf); uint64_t
> > > +dpy_gl_qemu_dmabuf_get_modifier(QemuDmaBuf *dmabuf); uint32_t
> > > +dpy_gl_qemu_dmabuf_get_texture(QemuDmaBuf *dmabuf); uint32_t
> > > +dpy_gl_qemu_dmabuf_get_x(QemuDmaBuf *dmabuf); uint32_t
> > > +dpy_gl_qemu_dmabuf_get_y(QemuDmaBuf *dmabuf); uint32_t
> > > +dpy_gl_qemu_dmabuf_get_backing_width(QemuDmaBuf *dmabuf);
> > uint32_t
> > > +dpy_gl_qemu_dmabuf_get_backing_height(QemuDmaBuf *dmabuf); bool
> > > +dpy_gl_qemu_dmabuf_get_y0_top(QemuDmaBuf *dmabuf); void
> > > +*dpy_gl_qemu_dmabuf_get_sync(QemuDmaBuf *dmabuf); int32_t
> > > +dpy_gl_qemu_dmabuf_get_fence_fd(QemuDmaBuf *dmabuf); bool
> > > +dpy_gl_qemu_dmabuf_get_allow_fences(QemuDmaBuf *dmabuf); bool
> > > +dpy_gl_qemu_dmabuf_get_draw_submitted(QemuDmaBuf *dmabuf);
> >
> > IMHO these method names don't need a "dpy_gl_" prefix on them. Since
> > they're accessors for the "QemuDmaBuf" struct, I think its sufficient t=
o just
> > have "qemu_dmabuf_" as the name prefix, making names more compact.
> >
> > The console.{h,c} files are a bit of a dumping ground for UI code. Whil=
e
> > QemuDmaBuf was just a struct with direct field access that's OK.
> >
> > With turning this into a more of an object with accessors, I think it w=
ould also
> > be desirable to move the struct definition and all its methods into sep=
arate
> > ui/dmabuf.{c,h} files, so its fully self-contained.
>
> [Kim, Dongwon] I am ok with changing function names and create
> separate c and h for dmabuf helpers as you suggested. But I would
> like to hear Marc-Andr=C3=A9's opinion about this suggestion before I mak=
e
> such changes.
>
> Marc-Andr=C3=A9, do you have any thought on Daniel's suggestion?

Sure, I was about to ask the same. Anything we can do to slim
ui/console.c helps :)


