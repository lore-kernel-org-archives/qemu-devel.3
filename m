Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42D76C27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 10:36:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJ9iZ-0006Ir-8g; Mon, 17 Jun 2024 06:36:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sJ9iX-0006IR-7R
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 06:36:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sJ9iT-0001xm-GD
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 06:36:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718620559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2NZm3T3pm/+wZBQZUgaDCJvueCDQViw6YpyBJxifKyM=;
 b=amlWJcHaTWbnZHE+KfjZ355W3FFdx/yk04FnfbNihhZBHKpOFxKriMWFlX8vOPGcUhT1AP
 t3BfinvyTxVCDhF4H77GTsYSlnZolQDJ1Dt8VcsuacZKmocPaCEBJNcRfzh4yi/L8esujr
 LNlHZAZoUR+SASRXfbWtnUbaQBt67H4=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-3zDKaqWJPVCgXA_cLF-OmA-1; Mon, 17 Jun 2024 06:35:58 -0400
X-MC-Unique: 3zDKaqWJPVCgXA_cLF-OmA-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2ec01fa1a72so32185711fa.2
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 03:35:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718620556; x=1719225356;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2NZm3T3pm/+wZBQZUgaDCJvueCDQViw6YpyBJxifKyM=;
 b=iTww/MGGm7iECM1Rz1WujbVV27sTyUGKrDQsQ9RnIWwGk3csmIkge2GwOc3V/8Oajv
 d8MTWigjuxvCzo7ndaGtJiIVfiOWaxEgegAtrKR+DwYYkLM7qgTvLrJeLGpeCbE/qkkT
 sqtntM8Fxzf263o5wLQaYRIUYxlZ37Xd81NaKi3xk7bl+5gYhpC+0cZOpel7FFO3fVoK
 Tg92ToFitc/ltZDkO2L7/WP4glDzsl8hYYCStUdeeweA5lzIzhKJM9uyQzENx0HM7bYh
 3Ob9T+mERgMPxs6ygewNsoKUuLskB94ldEp+H6BEQiWIpI3k4UNdNTjU/nzQnm/DKnu+
 Q9Eg==
X-Gm-Message-State: AOJu0YzV0gRkXTBBfJ0H0pe3NYvYeGyeuqOFOpzokdqAp5h/7QiGvArV
 gTjBx9KDrbNBA+Mt1uuXC/4y0JVDKBxgX7SQoVu1pzqftKGDMvUoptN+9iOyL0YP24xHqZLeQo4
 SdlJdHmvpsJTvszK+SLLlX6IPA4DJkYibYuChFGU2Lhz9lOCV2fNL
X-Received: by 2002:a2e:874f:0:b0:2e7:3224:9f51 with SMTP id
 38308e7fff4ca-2ec0e5c5843mr50295391fa.18.1718620555764; 
 Mon, 17 Jun 2024 03:35:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfwDsfhnO58S5iQqq5pN8GS1tL9tvG2ZGI545JUR9FP0dsWCiiX4jyOnXzr9/pJPLxShlzfQ==
X-Received: by 2002:a2e:874f:0:b0:2e7:3224:9f51 with SMTP id
 38308e7fff4ca-2ec0e5c5843mr50295171fa.18.1718620554981; 
 Mon, 17 Jun 2024 03:35:54 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.179.196])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-423047e28b7sm129892925e9.44.2024.06.17.03.35.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 03:35:54 -0700 (PDT)
Date: Mon, 17 Jun 2024 12:35:47 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: mst@redhat.com
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Hanna Reitz <hreitz@redhat.com>, Brad Smith <brad@comstyle.com>, 
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, gmaglione@redhat.com, stefanha@redhat.com,
 Coiby Xu <Coiby.Xu@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 slp@redhat.com, 
 Igor Mammedov <imammedo@redhat.com>, Raphael Norwitz <raphael@enfabrica.net>, 
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 David Hildenbrand <david@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH RESEND v7 00/12] vhost-user: support any POSIX system
 (tested on macOS, FreeBSD, OpenBSD)
Message-ID: <rx5hvcffqzmixgmlroko7t6qvjciifr77nvpwrakpl5oovw3ec@mihi4k5nhse6>
References: <20240612130140.63004-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240612130140.63004-1-sgarzare@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Hi Michael,

On Wed, Jun 12, 2024 at 03:01:28PM GMT, Stefano Garzarella wrote:
>This series should be in a good shape, in which tree should we queue it?
>@Micheal would your tree be okay?

Markus suggested a small change to patch 10, so do you want me to resend 
the whole series, or is it okay to resend just the last 3 patches (which 
are also the ones that depend on the other patch queued by Markus)?

In the last case I would ask you to queue up the first 9 patches of this 
series if that is okay with you.

Thanks,
Stefano

>
>Thanks,
>Stefano
>
>Changelog
>
>v1: https://patchew.org/QEMU/20240228114759.44758-1-sgarzare@redhat.com/
>v2: https://patchew.org/QEMU/20240326133936.125332-1-sgarzare@redhat.com/
>v3: https://patchew.org/QEMU/20240404122330.92710-1-sgarzare@redhat.com/
>v4: https://patchew.org/QEMU/20240508074457.12367-1-sgarzare@redhat.com/
>v5: https://patchew.org/QEMU/20240523145522.313012-1-sgarzare@redhat.com/
>v6: https://patchew.org/QEMU/20240528103543.145412-1-sgarzare@redhat.com/
>v7:
>- rebased on https://patchew.org/QEMU/20240611130231.83152-1-sgarzare@redhat.com/
>  That patch is queued by Markus and only Patch 10 of this series depends on it.
>- changed default value documentation for @share [Markus]
>- used `memory-backend-shm` instead of `shm` and wrapped to 70 columns
>  [Markus]
>- added 'if': 'CONFIG_POSIX' to MemoryBackendShmProperties [Markus]
>
>Description
>
>The vhost-user protocol is not really Linux-specific, so let's try support
>QEMU's frontends and backends (including libvhost-user) in any POSIX system
>with this series. The main use case is to be able to use virtio devices that
>we don't have built-in in QEMU (e.g. virtiofsd, vhost-user-vsock, etc.) even
>in non-Linux systems.
>
>The first 5 patches are more like fixes discovered at runtime on macOS or
>FreeBSD that could go even independently of this series.
>
>Patches 6, 7, 8, 9 enable building of frontends and backends (including
>libvhost-user) with associated code changes to succeed in compilation.
>
>Patch 10 adds `memory-backend-shm` that uses the POSIX shm_open() API to
>create shared memory which is identified by an fd that can be shared with
>vhost-user backends. This is useful on those systems (like macOS) where
>we don't have memfd_create() or special filesystems like "/dev/shm".
>
>Patches 11 and 12 use `memory-backend-shm` in some vhost-user tests.
>
>Maybe the first 5 patches can go separately, but I only discovered those
>problems after testing patches 6 - 9, so I have included them in this series
>for now. Please let me know if you prefer that I send them separately.
>
>I tested this series using vhost-user-blk and QSD on macOS Sonoma 14.4
>(aarch64), FreeBSD 14 (x86_64), OpenBSD 7.4 (x86_64), and Fedora 40 (x86_64)
>in this way:
>
>- Start vhost-user-blk or QSD (same commands for all systems)
>
>  vhost-user-blk -s /tmp/vhost.socket \
>    -b Fedora-Cloud-Base-39-1.5.x86_64.raw
>
>  qemu-storage-daemon \
>    --blockdev file,filename=Fedora-Cloud-Base-39-1.5.x86_64.qcow2,node-name=file \
>    --blockdev qcow2,file=file,node-name=qcow2 \
>    --export vhost-user-blk,addr.type=unix,addr.path=/tmp/vhost.socket,id=vub,num-queues=1,node-name=qcow2,writable=on
>
>- macOS (aarch64): start QEMU (using hvf accelerator)
>
>  qemu-system-aarch64 -smp 2 -cpu host -M virt,accel=hvf,memory-backend=mem \
>    -drive file=./build/pc-bios/edk2-aarch64-code.fd,if=pflash,format=raw,readonly=on \
>    -device virtio-net-device,netdev=net0 -netdev user,id=net0 \
>    -device ramfb -device usb-ehci -device usb-kbd \
>    -object memory-backend-shm,id=mem,size=512M \
>    -device vhost-user-blk-pci,num-queues=1,disable-legacy=on,chardev=char0 \
>    -chardev socket,id=char0,path=/tmp/vhost.socket
>
>- FreeBSD/OpenBSD (x86_64): start QEMU (no accelerators available)
>
>  qemu-system-x86_64 -smp 2 -M q35,memory-backend=mem \
>    -object memory-backend-shm,id=mem,size="512M" \
>    -device vhost-user-blk-pci,num-queues=1,chardev=char0 \
>    -chardev socket,id=char0,path=/tmp/vhost.socket
>
>- Fedora (x86_64): start QEMU (using kvm accelerator)
>
>  qemu-system-x86_64 -smp 2 -M q35,accel=kvm,memory-backend=mem \
>    -object memory-backend-shm,size="512M" \
>    -device vhost-user-blk-pci,num-queues=1,chardev=char0 \
>    -chardev socket,id=char0,path=/tmp/vhost.socket
>
>Branch pushed (and CI started) at https://gitlab.com/sgarzarella/qemu/-/tree/macos-vhost-user?ref_type=heads
>
>Based-on: 20240611130231.83152-1-sgarzare@redhat.com
>
>Stefano Garzarella (12):
>  libvhost-user: set msg.msg_control to NULL when it is empty
>  libvhost-user: fail vu_message_write() if sendmsg() is failing
>  libvhost-user: mask F_INFLIGHT_SHMFD if memfd is not supported
>  vhost-user-server: do not set memory fd non-blocking
>  contrib/vhost-user-blk: fix bind() using the right size of the address
>  contrib/vhost-user-*: use QEMU bswap helper functions
>  vhost-user: enable frontends on any POSIX system
>  libvhost-user: enable it on any POSIX system
>  contrib/vhost-user-blk: enable it on any POSIX system
>  hostmem: add a new memory backend based on POSIX shm_open()
>  tests/qtest/vhost-user-blk-test: use memory-backend-shm
>  tests/qtest/vhost-user-test: add a test case for memory-backend-shm
>
> docs/system/devices/vhost-user.rst        |   5 +-
> meson.build                               |   5 +-
> qapi/qom.json                             |  24 ++++-
> subprojects/libvhost-user/libvhost-user.h |   2 +-
> backends/hostmem-shm.c                    | 123 ++++++++++++++++++++++
> contrib/vhost-user-blk/vhost-user-blk.c   |  27 +++--
> contrib/vhost-user-input/main.c           |  16 +--
> hw/net/vhost_net.c                        |   5 +
> subprojects/libvhost-user/libvhost-user.c |  77 +++++++++++++-
> tests/qtest/vhost-user-blk-test.c         |   2 +-
> tests/qtest/vhost-user-test.c             |  23 ++++
> util/vhost-user-server.c                  |  12 +++
> backends/meson.build                      |   1 +
> hw/block/Kconfig                          |   2 +-
> qemu-options.hx                           |  16 +++
> util/meson.build                          |   4 +-
> 16 files changed, 314 insertions(+), 30 deletions(-)
> create mode 100644 backends/hostmem-shm.c
>
>
>base-commit: 60b54b67c63d8f076152e0f7dccf39854dfc6a77
>prerequisite-patch-id: 9a9fc9901c4fffc060dbc8a5cfe421ab592afb5a
>prerequisite-patch-id: 5ebb17e9220273c9962df7be30a60fee638a9ad9
>prerequisite-patch-id: 28507635bdac7fefb17ea3ff024292b46c1bc324
>prerequisite-patch-id: a05519b87d25c56641814798f978cdf08cd32074
>prerequisite-patch-id: ff3b4b9981df39b041afa017b1fc638416d14611
>prerequisite-patch-id: 5f441be8ccdec01c02658eedec89ca2aa3ad3c5c
>prerequisite-patch-id: 120307d86e36e3343a4f83f450ab2ae361e259cc
>prerequisite-patch-id: 16f58ef94a15fad5a389a8f9e3305281dc87ffee
>prerequisite-patch-id: d2ce57b4e7adf084a8a156679fa27fdc5fdc71e1
>prerequisite-patch-id: 99dc1b8acda26b05ebc2396822126026189f887a
>prerequisite-patch-id: a8c454b7ac4d8025a61dbc3fa6ea3d16f6ef1273
>prerequisite-patch-id: 72ced5e768ed91e1e07cb86fa1428f2c769ec1e4
>prerequisite-patch-id: 5c615ec5a46fbe357527e6e196d6402413aa3121
>prerequisite-patch-id: cf2fb177a9188fe727b41db633b7cb108e0ce19d
>prerequisite-patch-id: ff35dae9c2a37074e5f179384b874b7ca9c66f67
>prerequisite-patch-id: 49ace634cfb082c705d2d7caf808db8339cd5431
>prerequisite-patch-id: 6936e66cb455833fb93303a12fbe3014d121d12f
>prerequisite-patch-id: 82f332c9e3d048258061fe64fb143d7a65afae90
>prerequisite-patch-id: 2c333aaf540376d5267aa51e40879c2f06b8d725
>prerequisite-patch-id: e650380ae0cf23e7ce2fc9848447ce5d92fd87e3
>prerequisite-patch-id: 5eeb7624da657a6b009224cd76f1a5c5e59ffb90
>prerequisite-patch-id: 1d1e52bf8c672cddb4f23b1094bceafbdf7d1e79
>prerequisite-patch-id: aa6d84776bf01bdb08bf99f8ae79af888a2d60b1
>prerequisite-patch-id: 22803721bed02010687685974c2053bc3aea5f25
>prerequisite-patch-id: 62c529f53b8be1d152e8953a11584207dfaaa2d5
>prerequisite-patch-id: a809b81f773fe4ac106f0348e1b7edf83f2d63d6
>prerequisite-patch-id: 945bf0f99292a8d28a9e0cd718f3fdad64b62825
>prerequisite-patch-id: 4d05eee85d0be89df4d07d1f09e812eba9b74e06
>prerequisite-patch-id: ab615369f2d516af998be14bf21a51dffa1a6f78
>prerequisite-patch-id: bfdcb5ec094ccc56cfdc5df83b01b3f9fb9e8236
>prerequisite-patch-id: e66fd32c22960ed55bb3035015459cc1426d8a12
>prerequisite-patch-id: 71ff9a225aa34939a7df81d3ede6e0f1982c68af
>prerequisite-patch-id: 8de2dd32abb1cefa8b6a0119632248bc0cbcd92a
>prerequisite-patch-id: f01631beae528e69d3bfc9ebde4bb92150ab1233
>prerequisite-patch-id: eeb9531ea111f9f8685b07335c5e18be46106200
>prerequisite-patch-id: cda491052a6d7531b979f7957afc4a4963ceb2ff
>prerequisite-patch-id: e50341e39150230a9c5e56196684a6460f53dfe3
>prerequisite-patch-id: 544277c70903004bbc92a00490a012c7ef0eb32a
>prerequisite-patch-id: f14700246a64393535a86e76689c2818e5e4ad93
>prerequisite-patch-id: f4ad30bb909d1adf71a5bd1c4becff8c50bfb98c
>prerequisite-patch-id: d50f547244f73607e998b0cd4827c76beed0cdaf
>prerequisite-patch-id: 2cf516a30811cd3358a3bf3201a994c00d2ffdaf
>prerequisite-patch-id: 12b253a5446c6612052cb9ffc4eb73cf9d7397b6
>prerequisite-patch-id: 99589144e70280249ad93dec099355b72fb17562
>prerequisite-patch-id: b4c8cea48d4e1a05dd3a664d9ce3be8d10dcfe94
>prerequisite-patch-id: 5250f1b544a1b1ef45f41cf5d2afd8868e9bd009
>prerequisite-patch-id: 5805e8bada7d1365397d4eccd21eacb7c663d32b
>prerequisite-patch-id: 2490efee88fd07a21a6c6424c53263ce8d41eacd
>prerequisite-patch-id: ae68d3b89bd040a8618d7d9cc777f2cb9cf49592
>prerequisite-patch-id: 20cbd7c15e4fec4f42d02367f17f3376e130c7ff
>prerequisite-patch-id: 28c5aaacb3dd831aa527d607d76d6a79c5449a47
>prerequisite-patch-id: ac7fd2d45fd55dfc15fffabe11af48cb13570a82
>prerequisite-patch-id: dc8cf815eaa73c51ab0c96effdf19058a81e362a
>prerequisite-patch-id: 31ac16391a89f067f49e88cf377999156957fbd3
>prerequisite-patch-id: 8967950672a400e14db223c2c3c9a4d6f8a97657
>prerequisite-patch-id: 76f488f6b3597db046e22abad4fdba9ee4aa86ce
>prerequisite-patch-id: 214eb68a3b9cfcf70a679b03642f984dcd8b1382
>prerequisite-patch-id: 353e5a76c80369929234d462dd9ca7de7be4b4d5
>prerequisite-patch-id: 123f2b6686681035df59de5c27c921b28dfe5d1e
>prerequisite-patch-id: b95550fd5354b38fa03a40b48a3cd7eb34b0ab84
>prerequisite-patch-id: 98241a724cf500988a15d42b06f8bc0cb2a78033
>prerequisite-patch-id: d21276a22abffa24ab2a4337da24c87ca95d7623
>prerequisite-patch-id: 9c84ca842fa29e9681a33a95109e27570740b5c8
>prerequisite-patch-id: 5283d3a2a1ffa1baa0d48c2d4f266f0f683a0848
>prerequisite-patch-id: d1a494ce416f68a02e0ce338ca283dbb79596e18
>prerequisite-patch-id: 1926ebf42d3c65cbacb078fa3d82e655c6be8ee8
>prerequisite-patch-id: bf36bbe5cc1e9c86cd185abdcfbde3d6dc594dfe
>prerequisite-patch-id: e107e54e357e0cd59c0f18b1770ba52b7ac4eace
>prerequisite-patch-id: 3afae9bc90cc00b0adb57d2e27f2058bd91b9645
>prerequisite-patch-id: 2b7f2115bbc92c93f8142a1f4c566e0e55bc3555
>prerequisite-patch-id: 174920d507fffc8c031cf54ee60eca524f163d86
>prerequisite-patch-id: 8737a3ef34016f65515700564bc13ba73cdeebbe
>prerequisite-patch-id: 31870935f04e20695ab2b5bfdadf8027f488b0b7
>prerequisite-patch-id: cce2037bbe515f81e6ef08fc5ba451b4d2f52772
>prerequisite-patch-id: 1c1bfc8091083b7ea5e7761d33cd06b7de1e1648
>prerequisite-patch-id: 0f452b4b91fd6c5bab43d200d6b7c486f6a11601
>prerequisite-patch-id: ae494add09825423eee3f384f691d0aae5c90dd0
>prerequisite-patch-id: 98d93e4be44f7a67c69038aae8853d3fcb5a30c2
>prerequisite-patch-id: 13e31112ffce5b06132400ed3b2b909153fa315f
>prerequisite-patch-id: 0307e4f37006b980facc17c1b1ae2f4e88d1ae70
>prerequisite-patch-id: c816b09178a7da605db814b8bd709c4c6469b79b
>prerequisite-patch-id: 51975fe45e8f34c2b2d98875ca38540547e8092e
>prerequisite-patch-id: aa52dbcce9f511159a945a8428cebdb47f6d2e5a
>prerequisite-patch-id: 3b6f78114524f15d324913faab386c490ca9a639
>prerequisite-patch-id: 5ec7691a9f185056510d02b1639c883900790724
>prerequisite-patch-id: 042323eae4f8df09fec1552ed838e78208f2ffc4
>prerequisite-patch-id: a83017b0771353507a62b7ff3cc7d3821b7a8829
>prerequisite-patch-id: e51ff22a2e53b7162bca3f356290b91d56509410
>prerequisite-patch-id: 191aadac60a85235ec8f8f603b5fc78e71e09ba6
>prerequisite-patch-id: 264cd9d6fee6c01e186735a491c25d73d2d2ccfd
>prerequisite-patch-id: 28c4a0a1f19cb803ce47b446ae898e736cf349f8
>prerequisite-patch-id: ee39ed191f6a43ede1f07f48dc48669d46905978
>prerequisite-patch-id: 720968ff9cdf1f44f53731135602321f3e210480
>prerequisite-patch-id: 8ed9604ed5dac7170bffb6882efc6c417c4d65a7
>prerequisite-patch-id: 192d3211b55d6f4287ecab6c5109b898060f69c8
>prerequisite-patch-id: 4ac42fedd9329d613472228507d083864af68bbc
>prerequisite-patch-id: e346cb412c2204035fa969fe0e904bc6ad1d9514
>prerequisite-patch-id: 291b46176175ceb2efedfbc38e5d2628b0250c30
>prerequisite-patch-id: feb328077708dcb80ea294fcfcad9c806f249cfd
>prerequisite-patch-id: 3976fb2af88ec7d5e333abe8c369bf25439aa2c8
>prerequisite-patch-id: d8082299e2d7a86b47596d795c0e646ea05a5b05
>prerequisite-patch-id: a752941597c7ab406776a111f64e13ae40619b17
>prerequisite-patch-id: a40acdf9d4de5b3861fc9a17a5e525c81f7dab92
>prerequisite-patch-id: 4701d35560942a67da3b329d5c4e585c7a33bf0d
>prerequisite-patch-id: fa7a331b8da2cb04250621e2d8d1f25c452141f9
>prerequisite-patch-id: df4aa2ca4ffd76c05f247d2656c34d19f3b9ff90
>prerequisite-patch-id: ccc28d2ed350195cd6be446243622d202e623a79
>prerequisite-patch-id: 8263f731797748b03b7fb7ef1a01903064bd788a
>prerequisite-patch-id: 2db725a2c16c2b5cb52b72ff745acd5437de43de
>prerequisite-patch-id: 21c8bb8c06095924c3f628c25364b52d7f85dd61
>prerequisite-patch-id: 33da128d7377476cac289f4aad2ee7026ded9d22
>prerequisite-patch-id: 72958afa3f270df306503ea76c99f82576411577
>prerequisite-patch-id: d0a9c278a42f8d5ff776ded9c9b7b6401ee68bd4
>prerequisite-patch-id: ee203ba6198f3cd58c7e2453a187188e17c1a771
>prerequisite-patch-id: 34270cb4f7d4ab25a52ec462f929c9b151311cfd
>prerequisite-patch-id: e6d5e3fb8443903dc12abfc70cfbfc6216f92b58
>prerequisite-patch-id: ba8141a6db6840731fd3c2c2d9c7799a4d64b30b
>prerequisite-patch-id: 148f96b283476ff929a73ff80c997ec54a2cd7bb
>prerequisite-patch-id: 76547bebb2e1af1448d3011be914fa10dabaa6af
>prerequisite-patch-id: bf1672295d4993d81010fe2c6902c7d7bb19b0da
>prerequisite-patch-id: 1a875992089d4e66bb9ee777c312b0af0edbf489
>prerequisite-patch-id: 99da94291e43c47aa732a7d63aa7d78e7bfbde3f
>prerequisite-patch-id: b0d74d49170c14dc8194da2b0592c1121f1c6f4c
>prerequisite-patch-id: ba102a6b1c37ec107549c99dfc57fcf8cb869cbb
>prerequisite-patch-id: eb208c0cab6ef242bca1c84a3bbf4f26193774b6
>prerequisite-patch-id: b3ee7ef1d506dc31053da887cd4a5bf17e3a6d5d
>prerequisite-patch-id: bf27b97f9d95c916bfa853aca516c8dd8b9c5563
>prerequisite-patch-id: 5b41c20998ef383435b47a020a00836d4d0e634d
>prerequisite-patch-id: d764b6d898e4f000c2df684c48a69c8f0bb85b79
>prerequisite-patch-id: f293a5d68945e18d767b36588275d684cb3db956
>prerequisite-patch-id: 796d32031f9c633cfe2a20d3c3a75483364e456e
>prerequisite-patch-id: 933c6406d9ef46e8a7c9495fab82d6b6567a63d0
>prerequisite-patch-id: d21b052281968b985478c6271ed7a473faef032a
>prerequisite-patch-id: 84a70fa3a4bd6adba1ffe40d16b7357ee15b19d7
>prerequisite-patch-id: ca524c79a7b38aca87d5b48ef7081fa4723d0dcd
>prerequisite-patch-id: 334386ed13ccae8d5b91d92fa26ab5a12eb21ba5
>prerequisite-patch-id: 654ea7846358b392019b2352df95fd041e7fbdfb
>prerequisite-patch-id: 85ea7e867427f02af595ab231d4ead0d0b96eafe
>prerequisite-patch-id: 863fd007b0dcf130dd8c483084174cdd575090a2
>prerequisite-patch-id: ed2fc3452b918176a886ab90198afe51de9a378e
>prerequisite-patch-id: 8ecc772fb5444a3d3ac4a01a2f6702f6bf4d3a67
>prerequisite-patch-id: f251620c7644d907b5969c498416e2e877dbf4fd
>prerequisite-patch-id: fc77785ed434654231bba2dd92e1f1f8e944ff91
>prerequisite-patch-id: 876d400010bb989161ef7832c605104cdd329506
>prerequisite-patch-id: 6360e6e080ec33819b7b4ab385f872f0a905df84
>prerequisite-patch-id: 63b3a982300f6162a699ccf9eda870bd095d2fa6
>prerequisite-patch-id: cf995e99b76839a0cf2cf972d46ab941e0958dc3
>prerequisite-patch-id: ba81cb349a62ca84e5160a5c1d0243cfa9fb9972
>prerequisite-patch-id: 44afe78f0171c6e0541a12fffd99564c9f383673
>prerequisite-patch-id: a5531d8b703351da2492f9b02d3a451c22390687
>prerequisite-patch-id: 647d5122058b6ec4fb2d1ec243fce1290fb1df6a
>prerequisite-patch-id: ef1d0fdf1376b2aa632640af321989ffb7bc9813
>prerequisite-patch-id: 694d221c4af600e99cc8b290b335bee24a5629f1
>prerequisite-patch-id: fe4b5cf7c1ba87cdf8d7223504066c14fe55fd16
>prerequisite-patch-id: ae6b64ec1e4d50b7ff3ea475b92ee385185ccd13
>prerequisite-patch-id: 950f3f75abe12f17ffbcac13b12088f2b743d42c
>prerequisite-patch-id: 7bd9d4248fc59f1b9331fd20caae0488294385cf
>prerequisite-patch-id: e70bca29f4bf73da1257739cdb395f5f1a4da2c1
>prerequisite-patch-id: 3bdd14c80b47219f2886e53582f709a9f4ea6543
>prerequisite-patch-id: 6b492458231efa88be4bb51f505ba6b50fbe9f36
>prerequisite-patch-id: 93b3062dce77cecded38d7a231f160376dfa5253
>prerequisite-patch-id: dfa5abe5d310ce14cff0643d4ae4b250406bd3bd
>prerequisite-patch-id: e3fdc9a5451c12806c75dee7101f5f2a9eb2ff3b
>prerequisite-patch-id: b2d7be382b5b140efecab2973acfc654d76660dd
>prerequisite-patch-id: e5d7a954a747fe55b3334c0c89c345489fb84cd3
>prerequisite-patch-id: c8a74c8f490278f64915c349fb6ced3edc76a745
>prerequisite-patch-id: c436dab92e25eb0bb8c3294a4d2c59767fcdc74e
>prerequisite-patch-id: d03e86390b906eaa2b5f02075b3a5e841420475c
>prerequisite-patch-id: 5dbe45c5d6f35b9129f78497910c602fa0c05345
>prerequisite-patch-id: bf67fec728a3d2fc46eb1d3966e0f09feb0176c6
>prerequisite-patch-id: 4ef531d42ae7fa2d30eda7158c379e3ce407b8b0
>prerequisite-patch-id: 6de7f90a59151643092efed9914e7b163e4986e4
>prerequisite-patch-id: 10fea080f442ea04266471c41b557113ab3878c5
>prerequisite-patch-id: 13b3bdcbc4ba37ce007ea01f3b97a4715f1cb8e5
>prerequisite-patch-id: fa5f17e9c80fcce3c8b6af0f8e04ed7b7d5c0950
>prerequisite-patch-id: 12288d0b49669bc96fe7bb60fcead783d07e54f2
>prerequisite-patch-id: 668e845a011ea725f44f6eb220b186dbe865fa8b
>prerequisite-patch-id: d263a533dd33046dbb89564881bb098c758cbace
>prerequisite-patch-id: 15ce2f23b5eeedead09ee93ec6230812a1897f03
>prerequisite-patch-id: cb5e32bc00b44593548803fafea49846b1fbfd8e
>prerequisite-patch-id: 5825adf8d34d9bc9a01bb99ebe2857acc4e48837
>prerequisite-patch-id: 446316f606e1ebe5d1a36eb6faa01e7abe5b01b3
>prerequisite-patch-id: 1b971ad81ad8161c7e21a2298dfd90c361f59d81
>prerequisite-patch-id: a0fd852eacce6e62bbcd0599bc2c6b9e352c22cf
>prerequisite-patch-id: c69fc3623449b73cffce9539c9d91d23ecc28d27
>prerequisite-patch-id: 20225ef0715ae31057ded54abfdf08476b65c820
>prerequisite-patch-id: ad105361da70c94743ce2b4096cb6694c8f9e93d
>prerequisite-patch-id: 33ef5e8d08adc16123fecada7496ce2b21121b4e
>prerequisite-patch-id: 49143535f99193c3f9d3ec1baa99609396e16726
>prerequisite-patch-id: f1c195757737eed5c657b8d4c932e746eb8b6828
>prerequisite-patch-id: 00873bc529c5e2ab8832e960eac08f43d7e118d3
>prerequisite-patch-id: dbe80915cb9510677723f8b6532de4c0aafb00d0
>prerequisite-patch-id: a0ece85dd85953f4438536e084e584746edef3fe
>prerequisite-patch-id: 93310291d1d191198af70417214e4e3bf230fdf1
>prerequisite-patch-id: 2178db95d1976bd335bdc606b2ea88881e7f1a0e
>prerequisite-patch-id: 0fb9c8a496e46d8d93107842afe6476135a370d4
>prerequisite-patch-id: 446e52dde62004604489532b8b3586374ab40469
>prerequisite-patch-id: dcf23bf3e4d1ca6193b1420797e92d6ca94eb1b5
>prerequisite-patch-id: 648e39344d2f5a28175b429ec1d1725cd7b40832
>prerequisite-patch-id: 08c9c5bfcc7fc59c4742e51dac3aece772746154
>prerequisite-patch-id: 994d7a671c227b1980fd199372a9133322bd33b6
>prerequisite-patch-id: 9104f3c2d6cd2fb741285fe50380b8542e9a0fc9
>prerequisite-patch-id: 32f9dcae093841a2f6d24a7deaa760e4ba8f586a
>prerequisite-patch-id: f5cd20074b9b9a9ab7bdb4f1cfb4dfb5b102b3f1
>prerequisite-patch-id: 07420c53830a4739100b1973056238007a0eb53f
>prerequisite-patch-id: 4a32cb11838b1156ccf521ba0b4262366a72694b
>prerequisite-patch-id: c5c9fbdd46c675766887185be4490629a1b82c85
>prerequisite-patch-id: d058aeab00e2d92b9d2c5c84e7b48a383da227f8
>prerequisite-patch-id: 12777e32c096e913b2d02d0284c0cefd060db1be
>prerequisite-patch-id: 68464d97360fcd8829d3875fa9b40106f15b142e
>prerequisite-patch-id: f4ba0d65afdc7571042935aadf23c5169357a0c6
>prerequisite-patch-id: 43e3b7cec0c1efed8c177164260f8493de379b6d
>prerequisite-patch-id: bfc849fb32943cac2ac4e6cc667eea84a17fde45
>prerequisite-patch-id: 9abb71281e3353e80a4a8d7723491300fb10e46b
>prerequisite-patch-id: e5c8890c24836f032661e7df14884f272b45d405
>prerequisite-patch-id: b7cfe3cdbd106e8f365fb9843de9fabc249c1f7e
>prerequisite-patch-id: afe882e31560b8b926a04a5a303507600b8a785e
>prerequisite-patch-id: ffa937e7c83d5faa0ae05d191705c5b46dfcc1cd
>prerequisite-patch-id: b3824302e7c466aa04ffdb422b51b224cc4ff0a0
>prerequisite-patch-id: ec5d99103698e4fb07060015e2892b9615bf3655
>prerequisite-patch-id: 0c9e5a2c64d1c90b5b3063b722effb9a181d7dc1
>prerequisite-patch-id: 54b8048952f276cd567fbe3c1ec5ede6cc17c3fe
>prerequisite-patch-id: 02e0153fab34c940fa24da7e0cf18e22e0841969
>prerequisite-patch-id: 35a9ae0cae72e6d2addb5312861fd9e7f8b0e016
>prerequisite-patch-id: 81283fc449a77c52ab57948ab1c20232b3a27d0f
>prerequisite-patch-id: e9b9541587266d037f795861c8b92258f7906b3f
>prerequisite-patch-id: 93c9a26aa7078b3e7fa5df1f43286a1ada03e47a
>prerequisite-patch-id: 5dd8ba31312b3497fca5791014d622cc7afa05d2
>prerequisite-patch-id: df6f2698dae60d1d077c112f6164634be36f234f
>prerequisite-patch-id: a42f61db594dcb2c9c4c6ad98dda4e0a26e8dc9f
>prerequisite-patch-id: 17ba0a295e091e160f75cb2fa0f34d641792ab3a
>prerequisite-patch-id: b3f512b793c45f450f38ee61fd2b323175a815e7
>prerequisite-patch-id: 17e4374126de232483d0aac726703306a2acb978
>prerequisite-patch-id: a7c52145f8eb9a4e21c0d4880da9d54ffad81bed
>prerequisite-patch-id: 2caedc3297049beaf7641b3def7953556969e188
>prerequisite-patch-id: 19df4b2ca9b8e5083294c4cb7589549438b173aa
>prerequisite-patch-id: 50a7404e844005954ccab0df31fe26867eb46eb9
>prerequisite-patch-id: b51538406699bc501c805a0c66ae6c6469d74e0f
>prerequisite-patch-id: e23c6afe110917b26a34a7dced94499c3e35d590
>prerequisite-patch-id: eb4117091c76d31b7bf0775cbc3355f141c7718e
>prerequisite-patch-id: faf9846d8f602d1a7898b2f94c18cbb863bf1fb5
>prerequisite-patch-id: d6957b911681be1659bf9c42a5e58a3ff4a71ea6
>prerequisite-patch-id: 1b83e7539f4ad605203cb87354e6bc305ef8d00b
>prerequisite-patch-id: a9663fc20ea645469b513ef26f06562e7925aa27
>prerequisite-patch-id: 37af00c7de96e5d0db554ca26ab50377646e5bb5
>prerequisite-patch-id: 15ef726f868b61b4218c70f1fd69f12b8503d77e
>prerequisite-patch-id: 01a098895ef542664e5baf90a2eaa1075076cc3b
>prerequisite-patch-id: defd3d558483dfc1ae9ca63d021859b68f625916
>prerequisite-patch-id: 77c67fa6c48e58bab2006a456ac084a3c8c724cd
>prerequisite-patch-id: 7cbb84ce26b8c4cec4ecd6ab812d72ee835b4276
>prerequisite-patch-id: 5b9f9bed5455f11c483e640e03ac106c9a675303
>prerequisite-patch-id: 981c6f7198106174847ffa91e5561d9729eab29c
>prerequisite-patch-id: 527f4972d02f6395f20ff71fe347e7df4e9c5d49
>prerequisite-patch-id: acb9e9e7d35626830f55a48b71d9ddfa21a6f3f8
>prerequisite-patch-id: 598773c3926246bc50817560f4a71f97516c1b5e
>prerequisite-patch-id: 0253f84e39294c8fde5ae91ae3ff522ab3151a14
>prerequisite-patch-id: 910a61665db49fb6f6135cb4880c8701e3825b2f
>prerequisite-patch-id: 3c9674434cffd43b72b67be4301074a8e52f97d2
>prerequisite-patch-id: 77f3f0ddd291120c16eaa640b8a86c1f4c84f863
>prerequisite-patch-id: 095942e7b63211b760365ce5362847687abc8317
>prerequisite-patch-id: 786c61f9545c93d3d4cbe4484c74bf8a85753e50
>prerequisite-patch-id: 15aa2a5ef635f2bb858be24b4e8f1bd4e0608b39
>prerequisite-patch-id: 2f627bc5310387d732355acaf926780554d48f7c
>prerequisite-patch-id: c7adf0cf40acd38ab738eaf97eced4f369affffa
>prerequisite-patch-id: ecc4536e360c90ab9e3609cdd0b73758a4fd9942
>prerequisite-patch-id: e53fb0c690bb8c1997f3357d48370e954aa2e7fa
>prerequisite-patch-id: d1f3151facfc2531c41e016aad471447c0a15099
>prerequisite-patch-id: 909c62f4b9102124ba9a41ea666e226b107ff952
>prerequisite-patch-id: 8d9a45c57f4c31589952ba09599292dc4072450d
>prerequisite-patch-id: a7d209b97b24756aa91aadb198f4cf3bfe914042
>prerequisite-patch-id: b533e83b2b68b34b68f47d0dcde10060bd257d24
>prerequisite-patch-id: b60b37b3f83c3eb0d3c3f283b3c659fd3acd434d
>prerequisite-patch-id: 0ed5b5d4ad29ebec38f8a1bc5c41e1bf46dc450a
>prerequisite-patch-id: 48e300f8fa939c1f9112845dbe8c757eff617a92
>prerequisite-patch-id: 595ed3348f76d24968ea65f7c68caa63bad6122f
>prerequisite-patch-id: bf23bb87b969450461566899549cfcc4d0dde6df
>prerequisite-patch-id: c89c9b274b83db5de08c6f5c35a018879d7b60cd
>prerequisite-patch-id: 4f4336258b77ac72ed58b33f33ad4daa15524383
>prerequisite-patch-id: 767d34e16bc46ca88cf30de1e55dee7e8b696a44
>prerequisite-patch-id: 69d14aed9c5bf5b8ead291df5006b9f2609661e1
>prerequisite-patch-id: 2d35e97beadf421452a107e318a47c2283bb4bd3
>prerequisite-patch-id: 9e99f28f8fdf94856cf237ec291b3e522e940dd2
>prerequisite-patch-id: b5579698d05839390237f31dc1759379c57ede1b
>prerequisite-patch-id: cf988ff1ccb26e98a8d791cdd1f8ec12ea9ab2e9
>prerequisite-patch-id: 7ba5de8045696070d6e71dd2b4a12ab01163debf
>prerequisite-patch-id: 7efcc80df72d0cce93237cfb1ce66766b06543ea
>prerequisite-patch-id: ce53af57a0cae525a1d0f30c2b40dd1a2328aa99
>prerequisite-patch-id: bb8ee7752839c14c6057a25ab992f467a75cd3d0
>prerequisite-patch-id: 2816ba27dbf4433edac47a9bb90679e1d82700d0
>prerequisite-patch-id: 970c7622f790ab8dd7c90c3c69d652db72fef28c
>prerequisite-patch-id: 370561873e809f871cf74ac039af3106afaa07ea
>prerequisite-patch-id: 7829b94aaf5bc7ec3b82ab2d006c0a560dc2b283
>prerequisite-patch-id: ab561297c603ec94a616f26384fa40bbbb2c0cd6
>prerequisite-patch-id: 871c2d1e0a36574cdd253af5bf017dbf274e2607
>prerequisite-patch-id: a7c9f42a40fc04413862800a3aed7e9fe4f3b328
>prerequisite-patch-id: dd48f9c1f61db071fa540687e8326744f695e957
>prerequisite-patch-id: 1f3326fcbb083425e5e58fab821a96fb0786d8bc
>prerequisite-patch-id: 3a23986302dbbefb2f3310251ace36e852e04139
>prerequisite-patch-id: ecd17f6471d32a1ca7469ff9f0df3ce6f52cc958
>prerequisite-patch-id: e426a207bac31cb79213dccc046eef660bd2f11b
>prerequisite-patch-id: f2a25fd554a2e7c2a3b8a3e512c1eb88e7de7c83
>prerequisite-patch-id: 75c6065974585cec7ba7f506a74e07a69aaaf995
>prerequisite-patch-id: 6a80ed64de5fe92527365fed6581cac20485682f
>prerequisite-patch-id: 4a219d25c3480355952531465d9ac813eac60334
>prerequisite-patch-id: a1c9c86e5c395916846f061917d54fc978eb6e3c
>prerequisite-patch-id: 3348fee15eaeacc7fcb676ca6184a4993ee3150c
>prerequisite-patch-id: 36584017836685b4f8405dc14c8b534f19c8e554
>prerequisite-patch-id: cbfb2f0adefe9b0c701c5fc451091cd1bd28f272
>prerequisite-patch-id: 16548fc5b18667ab7fd4b08d17b310638e1b78ed
>prerequisite-patch-id: c459e5f956e9575a51c7e57304b496518220c16b
>prerequisite-patch-id: 27d900837c8a09f066ef8e0e63a18884ee371145
>prerequisite-patch-id: a4fc936692ddae3e94669cb6eda99f159ed9a33b
>prerequisite-patch-id: 64f547f1428e499be930e9f6520b05e8a72f4693
>prerequisite-patch-id: 22be676197ddd497d0f2ec236dfbaebe5ba734a0
>prerequisite-patch-id: 09d9a99d0b4d0f6aa82d14e011f4b0b60abc113c
>prerequisite-patch-id: 03bb62f06f97e7a923d24535c9ab3da741004f0e
>prerequisite-patch-id: cca12a59062e5b76474927f67533dddea4ae765c
>prerequisite-patch-id: 49d677a267b652f1b48734acde10ff32ec5c24f9
>prerequisite-patch-id: 71f6ba630e9ee4132972b3771db2f01bf1937ae8
>prerequisite-patch-id: c7eaf24675afaafa12a90eb3467cb64de70889cd
>prerequisite-patch-id: 8c3650c0a209d28ebfd6dd49e25b3612bc68aa72
>prerequisite-patch-id: fa7b9795a7c043df333d355b77fd4b5372160cc1
>prerequisite-patch-id: 91ede923e60281453861a3369a2a036c9cc7edb1
>prerequisite-patch-id: 416208989c3537275b0a6423eae1c35c7c3568c9
>prerequisite-patch-id: 3d11956e5b0d23d5803fa2ce0c6af70331e7a59f
>prerequisite-patch-id: 2d0849956881d251f6727c1c500964da9cfe7a4d
>prerequisite-patch-id: f5e9996d677d3f271a228e13cc474b8a4a228a7d
>prerequisite-patch-id: 81202dd5649a9c71d60bd5fa2d420fc92d6dbb93
>prerequisite-patch-id: eec909f2cce1ee6dbfdb2566cceef8330a89ded1
>prerequisite-patch-id: c32d7469a6a94d7338ce33bf02b10dac9fd58905
>prerequisite-patch-id: cee3b16546f89a21cf1bd042759a93fc4395f5e7
>prerequisite-patch-id: 44f84ab816894c29dd9f1df568ca2a540dc2082f
>prerequisite-patch-id: 81497b1cb79924649beb9115a348d46566ef2250
>prerequisite-patch-id: 57ea7a0039178014fed7ba520e16282c37db2008
>prerequisite-patch-id: 19f051ac20b3d54d5cb31f4020ce1097b1127806
>prerequisite-patch-id: 36e27eb139331cfd31bcb1b1c7cf8bda40b3219e
>prerequisite-patch-id: dc1c0934f5853b39cbcd29d46080b8a089c55711
>prerequisite-patch-id: 03bce6f0056238e30d6d7e2351f84eed2cc80116
>prerequisite-patch-id: 1b37177237d6b93dfd3fde8bc183b4cb60431a0a
>prerequisite-patch-id: 0d14ebba6a55ace8d69bbf1f28d547919453612f
>prerequisite-patch-id: 63fe96d6f0f90faf3f073bf0754f03e2449f7a0f
>prerequisite-patch-id: 440f07af20c96a28130d59af3c4d5017f4589f7c
>prerequisite-patch-id: 0f6ab7fe9c2f8f690cfc999e3379dd7c3698acdf
>prerequisite-patch-id: 0b6074cf8c6e4c30f39d1cc37bf0b743e92106d8
>prerequisite-patch-id: 92a86bd2b713849bd81203e038ba26e2c34a0b48
>prerequisite-patch-id: 696c0c463867740835b94a5653cf220a544bbd6d
>prerequisite-patch-id: 022f8972e319c4d6eea41b44af08fc30b8430194
>prerequisite-patch-id: a7094d414ca2489cd7b2e9368251f20743aa0cbc
>prerequisite-patch-id: 1ac6a9e24eac0091848dc06f0a97bb302b329616
>prerequisite-patch-id: f2c360e3d3575a5e633e1b7be99523779b7edbb4
>prerequisite-patch-id: c3e190a3aaeec9f11b881fd395f3542902288d4e
>prerequisite-patch-id: 4b9dc3072903e653d687b08827cc4feef3fe42a2
>prerequisite-patch-id: 4be7d02682f4bb15aaa70d9944f0074fdf0b55b0
>prerequisite-patch-id: 540cca782c7ada1b555e9aff154b23215b9deeb1
>prerequisite-patch-id: 9d2fd7bc54256c3905069ab17a7676621dbc4824
>prerequisite-patch-id: 7c77b8c2e4e29169d4db27154b61efda0f3a60f7
>prerequisite-patch-id: 63e0bd09888cdd1688018a5444faea5585b615eb
>prerequisite-patch-id: 63bda4bbdff01a9af8b2a899f3f399f64821e8e5
>prerequisite-patch-id: f2f5b845fbd96a556d6d6beb6f9dc62f66c551ba
>prerequisite-patch-id: 2bfd3ff17c27c9fd0c6e2f62f94ae94ca3be2c2f
>prerequisite-patch-id: 6dcbf1f29f7bdb2d090df3fa2386f84bdabb134c
>prerequisite-patch-id: aee978ee331aade69dfb15f34d3a49d1e1456010
>prerequisite-patch-id: 508da75a30876b4308fa195bfc195d423e8b6926
>prerequisite-patch-id: c0dd414a118e4a4928227cc99d4fa9950ac13e1a
>prerequisite-patch-id: b44e5bd8ebee1347e6a1bbc509567a9c7131c670
>prerequisite-patch-id: 4b1976720172be748bfabb9ce1b3df2be5740ccb
>prerequisite-patch-id: e085ee46525358621a3cdbb764f9c261df2189b9
>prerequisite-patch-id: cf6c9acae8563614effe680f66358e22fbee16df
>prerequisite-patch-id: d35a7c3f4d491c8e2fa99d13a24e96b0ffd20fe3
>prerequisite-patch-id: 252042c9bb537434faac9b6a3b1a5916c87bff3c
>prerequisite-patch-id: fdf66e6c9bb9ecd2686f343fb7d7199c122c20a8
>prerequisite-patch-id: 706b9dd63b1a5af07deba0c9c424ce90f0c3089f
>prerequisite-patch-id: 9d0dda91fae4a3236f64f69e9e705b03b82ccfd1
>prerequisite-patch-id: daffab6f9c0b0ff08bed4418650dc1e237714750
>prerequisite-patch-id: 92e5fe246b5aee161ab4d59169e03f453005c0bc
>prerequisite-patch-id: 1808e67c0e60e02490a86c1d863f72883f769d57
>-- 
>2.45.2
>


