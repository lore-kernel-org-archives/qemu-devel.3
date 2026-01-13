Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 568D4D29DE2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 08:36:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfZgz-0003i2-7w; Tue, 13 Jan 2026 03:23:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vfZgq-0003hU-QG
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 03:23:49 -0500
Received: from mail-qt1-x835.google.com ([2607:f8b0:4864:20::835])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vfZgm-0006Qf-JK
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 03:23:48 -0500
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-4ffc5fa443dso39325601cf.2
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 00:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768292619; x=1768897419; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z2+iOThE2nnNIq/6uanHOCwaWTvCKLRowNUz3BaKNZE=;
 b=irqKf8b4Zm8rp+4HFOsNGvCdV0dkDDRDw3YUm3oQpF9tUKypy/btobgoE3hesx7z4q
 /fe2TS+Tu4iPz0hNsqyzCHu6tQzmYJBKIf/wF8rUmzvGC6cBlngwY00MYsBe9wVy8opd
 N9bRB2oq6bnJ7UsC9iEgYl1usgW5kqgmMJLp5LHHsX6ACJzmmSXYh7e/KmZwawlvF+Fx
 XZizJBol1ZatWQyPtUV+Hm04GjDVG7g4nc+TsVqAu3Nnj1ZYzz3Oq2nkGkIjV4OmQceZ
 QIjzodQC9QBxPSvc7ykYsH32Fm3a8xMmeioV+Admp573kY56NCPkZabyZ6eevrU6+DLJ
 qeag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768292619; x=1768897419;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Z2+iOThE2nnNIq/6uanHOCwaWTvCKLRowNUz3BaKNZE=;
 b=kkjfz0xJYeUmJ5FkRxG8/g7x3RW8YQp8+u6Qo8ictGXywbaybalswt4BUGlO5K/wRv
 OcY2jvZ7fbxNw79q7jVKvXK6+PiDWQ2+UHjpl77uaXr19h4PVpCLQphXEY2NXPnB4PLG
 II5PlJHYTRB+TxyfSWC+Zmz3EHyy/coXzO3DeNbM30gJj3qVEZB8fRRsL4hxxrw2EDwi
 KN2Drkah01Zs0e7+P3RPwC8xFQJiw0lBc4CXMMCRixX8AUPUVG84dWz8eX8EbQk/ms4l
 VA/wES98ZHCTGdqqwcqVFbYJaTFrp+874WsPRrcYL0sHzvo3FoHyy/L0yLu3DS1p6lBs
 LWpw==
X-Gm-Message-State: AOJu0Yxa3y7dSMI5sOWv3Ph05yYjgqp3IRdGyT8VFalYvrIdO+6Q2ekn
 wdFRaGlTve6XHw4Dwa0lLC8j8ltWN6+39m1G0cgM4ibgP2rzg9YA33kurlGZC/YgQP/wo6uj5kN
 s7pSDzT4C8fj1DpOa64ITmp29/wFbofE=
X-Gm-Gg: AY/fxX6lc2wJaPbk+0iEtddC/uOoRRes7/06DvfaN+IaQhhYZv1N25Rgh7WW2YiT69c
 bu0GvcMcfIT2otdLBxO1u903PStf2kcxowYzDJG7t8quwJ8rNjm/Gb9/pUnL+357OYD1dZtfu+2
 nZ04yG97R1ey4UllyHv1Y89fu00GIWn8VZeO158mQDVb9BiOy1+g2zN83lo88Dg0X/TnAOzBIrh
 rq+lYge7JsKT4elzK+AIR+qyytNup8BYZYIzwirZtieRhy0FEAe+eqv8WioE7y5L7tMdLz9ctqN
 jWFDPxTa8Dqd5wrTlcLTCzPv91w=
X-Google-Smtp-Source: AGHT+IGCTef4q4Ah4jNadY6WPWYlN3dYOFOBksbdLSZ/jfchJ1rb6uSUfPidYr5Y1Xpg608rNK8XN2AZU2GNV74xZw4=
X-Received: by 2002:a05:622a:1811:b0:4ee:213b:3391 with SMTP id
 d75a77b69052e-4ffb482f716mr297131191cf.20.1768292619487; Tue, 13 Jan 2026
 00:23:39 -0800 (PST)
MIME-Version: 1.0
References: <20260112230127.99125-1-yodel.eldar@yodel.dev>
 <20260112230127.99125-2-yodel.eldar@yodel.dev>
In-Reply-To: <20260112230127.99125-2-yodel.eldar@yodel.dev>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 13 Jan 2026 12:23:27 +0400
X-Gm-Features: AZwV_QhamLfij3JdOa_NqNWKWFLOEq5ssRr-oPApLoHTMD6OlNfb-aKKqa7McCE
Message-ID: <CAJ+F1C+T06nv=_tZoA0LqOVsSSd7gRHDD9Ffpy7c-Y29To0xiA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/3] tests/vhost-user-bridge: Move to
 contrib/vhost-user-bridge/
To: Yodel Eldar <yodel.eldar@yodel.dev>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::835;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x835.google.com
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

On Tue, Jan 13, 2026 at 3:03=E2=80=AFAM Yodel Eldar <yodel.eldar@yodel.dev>=
 wrote:
>
> After the introduction of vhost-user-bridge and libvhost-user, we
> formed the convention of placing vhost-user daemons in eponymous subdirs
> of contrib/. Follow this convention.
>
> Create a contrib/vhost-user-bridge/ directory and move vhost-user-bridge
> into it. Extract its build target definition from tests/meson.build into
> the new directory, and include its subdir in the root-level meson.build.
>
> Add a section about it in the "vhost-user daemons in contrib" document.
>
> Signed-off-by: Yodel Eldar <yodel.eldar@yodel.dev>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  contrib/vhost-user-bridge/meson.build         |  4 ++
>  .../vhost-user-bridge}/vhost-user-bridge.c    |  0
>  .../devices/virtio/vhost-user-contrib.rst     | 39 +++++++++++++++++++
>  meson.build                                   |  1 +
>  tests/meson.build                             |  6 ---
>  5 files changed, 44 insertions(+), 6 deletions(-)
>  create mode 100644 contrib/vhost-user-bridge/meson.build
>  rename {tests =3D> contrib/vhost-user-bridge}/vhost-user-bridge.c (100%)
>
> diff --git a/contrib/vhost-user-bridge/meson.build b/contrib/vhost-user-b=
ridge/meson.build
> new file mode 100644
> index 0000000000..aa58c1df20
> --- /dev/null
> +++ b/contrib/vhost-user-bridge/meson.build
> @@ -0,0 +1,4 @@
> +if have_tools and have_vhost_user and host_os =3D=3D 'linux'
> +  executable('vhost-user-bridge', files('vhost-user-bridge.c'),
> +             dependencies: [qemuutil, vhost_user], install: false)
> +endif
> diff --git a/tests/vhost-user-bridge.c b/contrib/vhost-user-bridge/vhost-=
user-bridge.c
> similarity index 100%
> rename from tests/vhost-user-bridge.c
> rename to contrib/vhost-user-bridge/vhost-user-bridge.c
> diff --git a/docs/system/devices/virtio/vhost-user-contrib.rst b/docs/sys=
tem/devices/virtio/vhost-user-contrib.rst
> index 48d04d2ade..660d29a700 100644
> --- a/docs/system/devices/virtio/vhost-user-contrib.rst
> +++ b/docs/system/devices/virtio/vhost-user-contrib.rst
> @@ -85,3 +85,42 @@ vhost-user-scsi - SCSI controller
>
>  The vhost-user-scsi daemon can proxy iSCSI devices onto a virtualized
>  SCSI controller.
> +
> +.. _vhost_user_bridge:
> +
> +vhost-user-bridge - Network bridge
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The vhost-user-bridge daemon serves as a development tool for testing re=
al
> +internet traffic by providing a networking backend, i.e. server, for the
> +vhost-user protocol.
> +
> +Example
> +-------
> +For a single QEMU instance that both runs the user-mode net stack (slirp=
) and
> +serves as a vhost-user protocol frontend, i.e. client, simultaneously:
> +
> +First, start vhost-user-bridge:
> +
> +::
> +
> +  $ vhost-user-bridge -u /tmp/vubr.sock \
> +                      -l 127.0.0.1:4444 \
> +                      -r 127.0.0.1:5555
> +
> +Then, invoke QEMU:
> +
> +::
> +
> +  $ qemu-system-x86_64 \
> +        -m 4G \
> +        -object memory-backend-memfd,id=3Dmem0,size=3D4G,share=3Don,prea=
lloc=3Don \
> +        -numa node,memdev=3Dmem0 \
> +        -chardev socket,id=3Dchar0,path=3D/tmp/vubr.sock \
> +        -netdev vhost-user,id=3Dvhost0,chardev=3Dchar0,vhostforce=3Don \
> +        -device virtio-net-pci,netdev=3Dvhost0 \
> +        -netdev socket,id=3Dudp0,udp=3Dlocalhost:4444,localaddr=3Dlocalh=
ost:5555 \
> +        -netdev user,id=3Duser0 \
> +        -netdev hubport,id=3Dhub0,hubid=3D0,netdev=3Dudp0 \
> +        -netdev hubport,id=3Dhub1,hubid=3D0,netdev=3Duser0 \
> +        ...
> diff --git a/meson.build b/meson.build
> index db87358d62..a4e8a9b7b5 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -4546,6 +4546,7 @@ if have_tools
>      subdir('contrib/vhost-user-gpu')
>      subdir('contrib/vhost-user-input')
>      subdir('contrib/vhost-user-scsi')
> +    subdir('contrib/vhost-user-bridge')
>    endif
>
>    if host_os =3D=3D 'linux'
> diff --git a/tests/meson.build b/tests/meson.build
> index cbe7916241..87861b2857 100644
> --- a/tests/meson.build
> +++ b/tests/meson.build
> @@ -70,12 +70,6 @@ test_deps =3D {
>    'test-qht-par': qht_bench,
>  }
>
> -if have_tools and have_vhost_user and host_os =3D=3D 'linux'
> -  executable('vhost-user-bridge',
> -             sources: files('vhost-user-bridge.c'),
> -             dependencies: [qemuutil, vhost_user])
> -endif
> -
>  subdir('decode')
>
>  if 'CONFIG_TCG' in config_all_accel
> --
> 2.52.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

