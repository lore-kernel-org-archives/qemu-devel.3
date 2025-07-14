Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF44FC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 09:22:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubFNR-0005FC-JH; Mon, 14 Jul 2025 05:21:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1ubFC2-0005LC-EU
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 05:09:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1ubFC0-0007Ub-Bj
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 05:09:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752484185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VYAahEFsu1YjaAsH0kAZkyaJ37ljMI1GGfFqPH8qPh4=;
 b=c/aBguOQEuoQ6WY8uBdi/cakWZZV9OLTgXWEiKepeciJilZNvvjeFFKW5AU00cxLosia64
 ymEYyOhTI8SE/FTGi5GkXV1sl/vSDAwoxfdTsnTLZXzuXHOko3n92OpNJ2ehqdCHsV6/WZ
 HAHggENqfEwsZ9FEgi03s90bXJmaoPA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-T79eqSMcOziamfowHsM0Tw-1; Mon, 14 Jul 2025 05:09:42 -0400
X-MC-Unique: T79eqSMcOziamfowHsM0Tw-1
X-Mimecast-MFC-AGG-ID: T79eqSMcOziamfowHsM0Tw_1752484182
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-acb94dbd01fso401664866b.1
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 02:09:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752484181; x=1753088981;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VYAahEFsu1YjaAsH0kAZkyaJ37ljMI1GGfFqPH8qPh4=;
 b=EpsGAgxaeBxiuXg5vuY3dwUpZz5UwKneguinIqicaerVWz8fl6B8d6D++nshsLX8nO
 3HQIYahf+D3yNQxwG0zljiST/nCKlDMQHIPLeSYnKHFbwD8IXdiiSdQgF6NUPJ32sKjM
 rwdKrGG+0dIfFfiFvlgQxL2YDQgnTm2U9zqdnPGNMLXnWPSfChv8zONw+ZLe3Lv6s7Wa
 FoXEreG1SCgqWTB7fUzIvwRjFK+B0zCQJm52lOznFGjtwBQYLkVmzLtApotjD4dj7MEV
 gJgmV70jfeCu1+ZWB4Ei3QmavOKlqWGciFMAPEhEglrWTWdFKMa42GsMGLyKvrqlVyrm
 bO4A==
X-Gm-Message-State: AOJu0YzmKWTQczTn4U+0zmKzXP0mqqciyl4/i5fW4bFuny8dqgMahF2E
 Kj1vWxqFtk1niquJ7eDJnBDubZc6sXBBr59dCMpfsRGEtEtpXnPQX4hllaMUqt+d6xrMaK+FyTm
 WQXXTmFAaRG++R9fTgHfqaROHg5cm91wuLDk5f0kzL0mXpp7xT3PSb0rTj/+btwRPNvP/kd+KXw
 FXcTzWsjSv4fDuKvmc4nSx10W6rCTOUco=
X-Gm-Gg: ASbGncvk9jXCqfDMwk2chT4k2L50+Q1gmvz89vNLfalfoIBr77DwClUz3lrw06fpMjM
 tG0G1X0jxLe3XT2wUyQiR1oXtK1AISjuiwkY7yaNVhqRpJw3egEgX8CThBXyULRF3JWyxu+ojtS
 ZFLCdWtx3NpqmShUQ42H9Svw==
X-Received: by 2002:a17:907:928c:b0:ae3:67c7:54a6 with SMTP id
 a640c23a62f3a-ae6fc1204bcmr1201989266b.34.1752484181400; 
 Mon, 14 Jul 2025 02:09:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNGBUwv/aiEvCa1RxRFbJbCehc94t0sATx8zkIESSdwr5uhJxus3IYPQcvCzUWH2iVkLv5Hk9Ny0KHdI5O9f8=
X-Received: by 2002:a17:907:928c:b0:ae3:67c7:54a6 with SMTP id
 a640c23a62f3a-ae6fc1204bcmr1201986866b.34.1752484180940; Mon, 14 Jul 2025
 02:09:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1752229731.git.pabeni@redhat.com>
 <CAPpAL=y4e=+H2rxHwwgbGvU+x10aTDVZ7ix+2YqVC3e6hd6L7g@mail.gmail.com>
 <b745cfee-5e29-431a-8a3d-070c47e3f0a3@redhat.com>
In-Reply-To: <b745cfee-5e29-431a-8a3d-070c47e3f0a3@redhat.com>
From: Lei Yang <leiyang@redhat.com>
Date: Mon, 14 Jul 2025 17:09:03 +0800
X-Gm-Features: Ac12FXxhyQRKX4WxuMyNz5ss6U4wn9FTUq40s1TfdmsWZMa_uJqbL9A9zKVVstk
Message-ID: <CAPpAL=xBfCXgT13k+h4oLsuEdm-FQ0_VO47kcgx050B40-oVOw@mail.gmail.com>
Subject: Re: [PATCH RFC v2 00/13] virtio: introduce support for GSO over UDP
 tunnel
To: Paolo Abeni <pabeni@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, 
 Luigi Rizzo <lrizzo@google.com>, Giuseppe Lettieri <g.lettieri@iet.unipi.it>, 
 Vincenzo Maffione <v.maffione@gmail.com>, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leiyang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Jul 14, 2025 at 5:05=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 7/14/25 10:43 AM, Lei Yang wrote:
> > Does the compile of this series of patches require support for a
> > special kernel environment? I hit a compile issue after applied you
> > patches:
> > [1440/2928] Compiling C object libsystem.a.p/hw_virtio_vhost.c.o
> > FAILED: libsystem.a.p/hw_virtio_vhost.c.o
> > cc -m64 -Ilibsystem.a.p -I. -I.. -Isubprojects/dtc/libfdt
> > -I../subprojects/dtc/libfdt -Isubprojects/libvduse
> > -I../subprojects/libvduse -Iui -Iqapi -Itrace -Iui/shader
> > -I/usr/include/pixman-1 -I/usr/include/glib-2.0
> > -I/usr/lib64/glib-2.0/include -I/usr/include/libmount
> > -I/usr/include/blkid -I/usr/include/sysprof-6
> > -I/usr/include/gio-unix-2.0 -I/usr/include/slirp
> > -fdiagnostics-color=3Dauto -Wall -Winvalid-pch -Werror -std=3Dgnu11 -O0=
 -g
> > -fstack-protector-strong -Wempty-body -Wendif-labels
> > -Wexpansion-to-defined -Wformat-security -Wformat-y2k
> > -Wignored-qualifiers -Wimplicit-fallthrough=3D2 -Winit-self
> > -Wmissing-format-attribute -Wmissing-prototypes -Wnested-externs
> > -Wold-style-declaration -Wold-style-definition -Wredundant-decls
> > -Wshadow=3Dlocal -Wstrict-prototypes -Wtype-limits -Wundef -Wvla
> > -Wwrite-strings -Wno-missing-include-dirs -Wno-psabi
> > -Wno-shift-negative-value -isystem
> > /mnt/tests/distribution/command/qemu/linux-headers -isystem
> > linux-headers -iquote . -iquote /mnt/tests/distribution/command/qemu
> > -iquote /mnt/tests/distribution/command/qemu/include -iquote
> > /mnt/tests/distribution/command/qemu/host/include/x86_64 -iquote
> > /mnt/tests/distribution/command/qemu/host/include/generic -iquote
> > /mnt/tests/distribution/command/qemu/tcg/i386 -pthread -mcx16 -msse2
> > -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE
> > -fno-strict-aliasing -fno-common -fwrapv -ftrivial-auto-var-init=3Dzero
> > -fzero-call-used-regs=3Dused-gpr -fPIE -DWITH_GZFILEOP -DCONFIG_SOFTMMU
> > -DCOMPILING_SYSTEM_VS_USER -MD -MQ libsystem.a.p/hw_virtio_vhost.c.o
> > -MF libsystem.a.p/hw_virtio_vhost.c.o.d -o
> > libsystem.a.p/hw_virtio_vhost.c.o -c ../hw/virtio/vhost.c
> > ../hw/virtio/vhost.c: In function =E2=80=98vhost_dev_set_features=E2=80=
=99:
> > ../hw/virtio/vhost.c:38:9: error: =E2=80=98r=E2=80=99 may be used unini=
tialized
> > [-Werror=3Dmaybe-uninitialized]
> >    38 |         error_report(fmt ": %s (%d)", ## __VA_ARGS__, \
> >       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >    39 |                      strerror(-retval), -retval); \
> >       |                      ~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > ../hw/virtio/vhost.c:1006:9: note: in expansion of macro =E2=80=98VHOST=
_OPS_DEBUG=E2=80=99
> >  1006 |         VHOST_OPS_DEBUG(r, "extended features without device su=
pport");
> >       |         ^~~~~~~~~~~~~~~
> > ../hw/virtio/vhost.c:989:9: note: =E2=80=98r=E2=80=99 was declared here
> >   989 |     int r;
> >       |         ^
> > cc1: all warnings being treated as errors
> > ninja: build stopped: subcommand failed.
> > make[1]: *** [Makefile:168: run-ninja] Error 1
> > make[1]: Leaving directory '/mnt/tests/distribution/command/qemu/build'
> > make[1]: Entering directory '/mnt/tests/distribution/command/qemu/build=
'
> > [1/1493] Generating subprojects/dtc/version_gen.h with a custom command
> > [2/1493] Generating qemu-version.h with a custom command (wrapped by
> > meson to capture output)
> > [3/1492] Compiling C object libsystem.a.p/hw_virtio_vhost.c.o
> > FAILED: libsystem.a.p/hw_virtio_vhost.c.o
> > cc -m64 -Ilibsystem.a.p -I. -I.. -Isubprojects/dtc/libfdt
> > -I../subprojects/dtc/libfdt -Isubprojects/libvduse
> > -I../subprojects/libvduse -Iui -Iqapi -Itrace -Iui/shader
> > -I/usr/include/pixman-1 -I/usr/include/glib-2.0
> > -I/usr/lib64/glib-2.0/include -I/usr/include/libmount
> > -I/usr/include/blkid -I/usr/include/sysprof-6
> > -I/usr/include/gio-unix-2.0 -I/usr/include/slirp
> > -fdiagnostics-color=3Dauto -Wall -Winvalid-pch -Werror -std=3Dgnu11 -O0=
 -g
> > -fstack-protector-strong -Wempty-body -Wendif-labels
> > -Wexpansion-to-defined -Wformat-security -Wformat-y2k
> > -Wignored-qualifiers -Wimplicit-fallthrough=3D2 -Winit-self
> > -Wmissing-format-attribute -Wmissing-prototypes -Wnested-externs
> > -Wold-style-declaration -Wold-style-definition -Wredundant-decls
> > -Wshadow=3Dlocal -Wstrict-prototypes -Wtype-limits -Wundef -Wvla
> > -Wwrite-strings -Wno-missing-include-dirs -Wno-psabi
> > -Wno-shift-negative-value -isystem
> > /mnt/tests/distribution/command/qemu/linux-headers -isystem
> > linux-headers -iquote . -iquote /mnt/tests/distribution/command/qemu
> > -iquote /mnt/tests/distribution/command/qemu/include -iquote
> > /mnt/tests/distribution/command/qemu/host/include/x86_64 -iquote
> > /mnt/tests/distribution/command/qemu/host/include/generic -iquote
> > /mnt/tests/distribution/command/qemu/tcg/i386 -pthread -mcx16 -msse2
> > -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE
> > -fno-strict-aliasing -fno-common -fwrapv -ftrivial-auto-var-init=3Dzero
> > -fzero-call-used-regs=3Dused-gpr -fPIE -DWITH_GZFILEOP -DCONFIG_SOFTMMU
> > -DCOMPILING_SYSTEM_VS_USER -MD -MQ libsystem.a.p/hw_virtio_vhost.c.o
> > -MF libsystem.a.p/hw_virtio_vhost.c.o.d -o
> > libsystem.a.p/hw_virtio_vhost.c.o -c ../hw/virtio/vhost.c
> > ../hw/virtio/vhost.c: In function =E2=80=98vhost_dev_set_features=E2=80=
=99:
> > ../hw/virtio/vhost.c:38:9: error: =E2=80=98r=E2=80=99 may be used unini=
tialized
> > [-Werror=3Dmaybe-uninitialized]
> >    38 |         error_report(fmt ": %s (%d)", ## __VA_ARGS__, \
> >       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >    39 |                      strerror(-retval), -retval); \
> >       |                      ~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > ../hw/virtio/vhost.c:1006:9: note: in expansion of macro =E2=80=98VHOST=
_OPS_DEBUG=E2=80=99
> >  1006 |         VHOST_OPS_DEBUG(r, "extended features without device su=
pport");
> >       |         ^~~~~~~~~~~~~~~
> > ../hw/virtio/vhost.c:989:9: note: =E2=80=98r=E2=80=99 was declared here
> >   989 |     int r;
> >       |         ^
> > cc1: all warnings being treated as errors
> > ninja: build stopped: subcommand failed.
> > make[1]: *** [Makefile:168: run-ninja] Error 1
> > make[1]: Leaving directory '/mnt/tests/distribution/command/qemu/build'
>
> Thank you for reporting the problem.
>
> No special kernel requirement to build the series, the above is just a
> gross mistake on my side in patch 7/13. If you want to test the series,
> please apply incrementally the following diff.
>
> What baffles me is that gcc 14.3.1 and 11.5.0 are not raising the
> warning (that looks legit/correct) here.
>
> I'll fix the above in the next revision.
>
> Note that you need a running kernel based on current net-next tree in
> both the hypervisor and the guest to actually leverage the new feature.

Ok, I will test this series again and update the test results.

Thanks
Lei
>
> Thanks,
>
> Paolo
> ---
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 2eee9b0886..c4eab5ce08 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -1003,8 +1003,8 @@ static int vhost_dev_set_features(struct vhost_dev
> *dev,
>
>      if (virtio_features_use_extended(features) &&
>          !dev->vhost_ops->vhost_set_features_ex) {
> -        VHOST_OPS_DEBUG(r, "extended features without device support");
>          r =3D -EINVAL;
> +        VHOST_OPS_DEBUG(r, "extended features without device support");
>          goto out;
>      }
>


