Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CCDEC47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 11:51:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfITJ-0002Jr-PF; Wed, 28 Feb 2024 06:51:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rfITE-0002H0-5o
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:51:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rfITC-0004do-DH
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:51:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709121089;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W4e+t0o6V0jdtfmIXye7cHCq9n4R1J5CLWq3Jm4x+Vc=;
 b=GHL9glofMZcI/amL3uuTJ8FBip4Y8JBvkKH55hjbdgufUcKAdAyN8Y7obvUHC6crqIHQB9
 7EuGtMrukCKZzr5z7TsLROweP3J6E8zhSQ82zi3hmL3zHEwlZz4o5pcaFFkhdriS4atpt3
 JLBHYg3JGs/l06tH5qUUFopY1xKnPQI=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-iXieX4h_OoGZ9rJG2Luhvg-1; Wed, 28 Feb 2024 06:51:28 -0500
X-MC-Unique: iXieX4h_OoGZ9rJG2Luhvg-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-60804b369c7so58085587b3.2
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 03:51:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709121088; x=1709725888;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W4e+t0o6V0jdtfmIXye7cHCq9n4R1J5CLWq3Jm4x+Vc=;
 b=gJ6mVaED5EFMAFw8S12jk+IRnXMTeakgFpX42e9MV57KiWCsGSGIV20vnKYamODJvL
 YezO+87qCIcCTiFsT59HCwwus0USV4TBVTtfICEw4p3XbPUU9wEUIs3135khCfiLnKqq
 fd33V64vhoAR2JUItT/qP8lZ6ayBiTIkvsVIChLCxIzliqsJAYhXzIv0XnPL86bebyU7
 lNSLJq1S7l3cwb8zkT/+AybBgxcfYYry1w5ncS8uHUxy8T4/H5h0xM8ECeFvUWiz27XW
 8FnC9SvJJlt9y5CcrO8eSAOstxh6d6eQ+TqqoRSn++/4P68rJ600HRjSghXxbCU2wByy
 fiug==
X-Gm-Message-State: AOJu0YyJoJIJ9XqUUvYde88s2tJeOj6YDBVWm6OZSXetPO451hNaH7Vn
 bwVTtY947EszxurH1+MW+8gurrYXGjIg5uA/o18pHo5vfx4NCmSrTc5qOPow9gO1tImyxEUDTWb
 bZG7KxDlblIHfAV7I1MhyItyva7Wl60GATiEsR4KTrK9rp8p0vIglOkgupzM/vr/OtYnKlpEQJj
 //OxD2Ljnd2qScaaDX+hb1ZImK2PhEVhviHytYSg==
X-Received: by 2002:a81:dc06:0:b0:609:2333:9579 with SMTP id
 h6-20020a81dc06000000b0060923339579mr5021751ywj.4.1709121087892; 
 Wed, 28 Feb 2024 03:51:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGKpZOoZIJTvHgNLuNKy6ghL7VelPtksGeWf7xtMZmfev9TMDwp2ZlY5jKN3E1gqWFWVmwUNqIkQ68cn+/+xiU=
X-Received: by 2002:a81:dc06:0:b0:609:2333:9579 with SMTP id
 h6-20020a81dc06000000b0060923339579mr5021720ywj.4.1709121087572; Wed, 28 Feb
 2024 03:51:27 -0800 (PST)
MIME-Version: 1.0
References: <20240228114759.44758-1-sgarzare@redhat.com>
In-Reply-To: <20240228114759.44758-1-sgarzare@redhat.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Wed, 28 Feb 2024 12:51:16 +0100
Message-ID: <CAGxU2F79465w97vY8G51MEe5e+-wRHNB2AyuPYG_tVEOhuOOnQ@mail.gmail.com>
Subject: Re: [PATCH 0/9] vhost-user: support any POSIX system (tested on macOS
 and FreeBSD)
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Coiby Xu <Coiby.Xu@gmail.com>, 
 slp@redhat.com, Eduardo Habkost <eduardo@habkost.net>,
 Hanna Reitz <hreitz@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Raphael Norwitz <raphael@enfabrica.net>, 
 Kevin Wolf <kwolf@redhat.com>, David Hildenbrand <david@redhat.com>,
 stefanha@redhat.com, gmaglione@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

I just noticed that I forgot to add RFC tag and fix Author to match
SOB in some patches, sorry!

Stefano

On Wed, Feb 28, 2024 at 12:48=E2=80=AFPM Stefano Garzarella <sgarzare@redha=
t.com> wrote:
>
> The vhost-user protocol is not really Linux-specific, so let's try suppor=
t
> QEMU's frontends and backends (including libvhost-user) in any POSIX syst=
em
> with this series. The main use case is to be able to use virtio devices t=
hat
> we don't have built-in in QEMU (e.g. virtiofsd, vhost-user-vsock, etc.) e=
ven
> in non-Linux systems.
>
> The first 5 patches are more like fixes discovered at runtime on macOS or
> FreeBSD that could go even independently of this series.
>
> Patches 6, 7, and 8 enable building of frontends and backends (including
> libvhost-user) with associated code changes to succeed in compilation.
>
> The latest patch (9) adds support for the POSIX shm_open() API to create
> shared memory which is identified by an fd that can be shared with vhost-=
user
> backends. This is useful on those systems (like macOS) where we don't hav=
e
> memfd_create() or special filesystems like "/dev/shm".
>
> I put the whole series in RFC because I have some questions especially in
> patch 6 and 9, but in general any comment/suggestion/test are really welc=
ome.
>
> Maybe the first 5 patches can go separately, but I only discovered those
> problems after testing patches 6 - 9, so I have included them in this ser=
ies
> for now. Please let me know if you prefer that I send them separately.
>
> For now I tested this series using vhost-user-blk and QSD on
> macOS Sonoma 14.3.1 (aarch64), FreeBSD 14 (x86_64), and Fedora 39 (x86_64=
)
> in this way:
>
> - Start vhost-user-blk or QSD (same commands for all systems)
>
>   vhost-user-blk -s /tmp/vhost.socket \
>     -b Fedora-Cloud-Base-39-1.5.x86_64.raw
>
>   qemu-storage-daemon \
>     --blockdev file,filename=3DFedora-Cloud-Base-39-1.5.x86_64.qcow2,node=
-name=3Dfile \
>     --blockdev qcow2,file=3Dfile,node-name=3Dqcow2 \
>     --export vhost-user-blk,addr.type=3Dunix,addr.path=3D/tmp/vhost.socke=
t,id=3Dvub,num-queues=3D1,node-name=3Dqcow2,writable=3Don
>
> - macOS (aarch64): start QEMU (using hvf accelerator)
>
>   qemu-system-aarch64 -smp 2 -cpu host -M virt,accel=3Dhvf,memory-backend=
=3Dmem \
>     -drive file=3D./build/pc-bios/edk2-aarch64-code.fd,if=3Dpflash,format=
=3Draw,readonly=3Don \
>     -device virtio-net-device,netdev=3Dnet0 -netdev user,id=3Dnet0 \
>     -device ramfb -device usb-ehci -device usb-kbd \
>     -object memory-backend-file,mem-path=3D"/mem0",shm=3Don,share=3Don,id=
=3Dmem,size=3D512M \
>     -device vhost-user-blk-pci,num-queues=3D1,disable-legacy=3Don,chardev=
=3Dchar0 \
>     -chardev socket,id=3Dchar0,path=3D/tmp/vhost.socket
>
> - FreeBSD (x86_64): start QEMU (no accelerators available)
>
>   qemu-system-x86_64 -smp 2 -M q35,memory-backend=3Dmem \
>     -object memory-backend-file,mem-path=3D"/mem0",shm=3Don,share=3Don,id=
=3Dmem,size=3D"512M" \
>     -device vhost-user-blk-pci,num-queues=3D1,chardev=3Dchar0 \
>     -chardev socket,id=3Dchar0,path=3D/tmp/vhost.socket
>
> - Fedora (x86_64): start QEMU (using kvm accelerator)
>
>   qemu-system-x86_64 -smp 2 -M q35,accel=3Dkvm,memory-backend=3Dmem \
>     -object memory-backend-file,mem-path=3D"/mem0",shm=3Don,share=3Don,id=
=3Dmem,size=3D"512M" \
>     -device vhost-user-blk-pci,num-queues=3D1,chardev=3Dchar0 \
>     -chardev socket,id=3Dchar0,path=3D/tmp/vhost.socket
>
> Thanks,
> Stefano
>
> Stefano Garzarella (9):
>   libvhost-user: set msg.msg_control to NULL when it is empty
>   libvhost-user: fail vu_message_write() if sendmsg() is failing
>   libvhost-user: mask F_INFLIGHT_SHMFD if memfd is not supported
>   vhost-user-server: don't abort if we can't set fd non-blocking
>   contrib/vhost-user-blk: fix bind() using the right size of the address
>   vhost-user: enable frontends on any POSIX system
>   libvhost-user: enable it on any POSIX system
>   contrib/vhost-user-blk: enabled it on any POSIX system
>   hostmem-file: support POSIX shm_open()
>
>  meson.build                               |  5 +-
>  qapi/qom.json                             |  4 ++
>  subprojects/libvhost-user/libvhost-user.h |  2 +-
>  backends/hostmem-file.c                   | 57 ++++++++++++++++-
>  contrib/vhost-user-blk/vhost-user-blk.c   | 23 +++++--
>  hw/net/vhost_net.c                        |  8 ++-
>  subprojects/libvhost-user/libvhost-user.c | 76 ++++++++++++++++++++++-
>  util/vhost-user-server.c                  |  6 +-
>  backends/meson.build                      |  2 +-
>  hw/block/Kconfig                          |  2 +-
>  qemu-options.hx                           | 10 ++-
>  util/meson.build                          |  4 +-
>  12 files changed, 179 insertions(+), 20 deletions(-)
>
> --
> 2.43.2
>


