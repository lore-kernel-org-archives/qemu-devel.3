Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6C77C83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 09:22:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubFO1-0005vX-G3; Mon, 14 Jul 2025 05:22:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1ubEmx-0000Gh-74
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 04:43:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1ubEmu-0003HJ-9t
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 04:43:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752482629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GRhLUFEqvojdLmOsG0Ejy1GkfyZq+eqUAsj94u+Dgrw=;
 b=BcqrduxPNTi1lC/axohIc01lTs6Gx/kBuEkcX3jfQHl8mOdQdoMJOetJ4H3Sg9LylG+agP
 iawp2xMm7qhlXFRVUO7fFsCRMUKhhnDQoLID/DNsd05dSneBi9A52Renj/Sczaa5qI7zbC
 tT9NTwHUCA4AgDGb1EO3mu3gYE+VW0w=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-LvmQt8zTPC6h-9QIH0IVYA-1; Mon, 14 Jul 2025 04:43:48 -0400
X-MC-Unique: LvmQt8zTPC6h-9QIH0IVYA-1
X-Mimecast-MFC-AGG-ID: LvmQt8zTPC6h-9QIH0IVYA_1752482627
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-ae6d6b8eacbso296742266b.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 01:43:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752482627; x=1753087427;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GRhLUFEqvojdLmOsG0Ejy1GkfyZq+eqUAsj94u+Dgrw=;
 b=TXc/h7ZwSZe/h6l4zVaXNC2E/x91LP0D0BBy/zGj+4s59YdkWmX6JlcAqQFaJbb4er
 pkmRQropIZPRFonp2heFI5Fta4djuiLX6JJCblk5rVtGF2ZoFfzthr9BV9UEnrZ3Sjg1
 f735J1G2fCmVdg8B4pmP7ps9lzOIoW7zKEO23aA9yL2V1aYPC3ys56L/NG/GshC30Ifc
 JnTSSYtoIbk132y1coHHaBs46fyk1NBfNsKbrkdybKRF1oSi+vhWCbvJlUeUaw93s09x
 dbOzifxw1qvNxm3cNZeimZEm5a0vHpGfJm3LdkkhKaaXOTKa0xUzYTyG3f2AVwMCa7vX
 1T+A==
X-Gm-Message-State: AOJu0Yy7KdWOSlVBLXCKwNTcwy2OLUGIOKAlIcLU5Aemb0r3QpjVQ2TR
 2RysCKbvp7hZXD7sJFJAyZRysyxAdFIdbEsZoWeUxbkHdAstirDR96W3ZHBikfe+zVglyA8np5J
 YUbGnz9ZssXDQE1vEGDvvClgDNzKJHgxHOJN2E+tR2ztA5dp4Csaof6nAYm3UAHSw89dBRnUFT+
 2c82iBBG/upaQu1SlIPKi/7ka9IPr7JAQ=
X-Gm-Gg: ASbGnctSxmV4nAV5/tshTTO4hdaqddjUd20PDR/TOXuDvynxPZnTSR5KWz3+lP0I4Xq
 Xb9owF0RTCFelN+BDSxFWukzEAJeSVjnkjgMOvQ7Zza5k2VrR8dfI1Y/9T1dAVjtfZzEfCnAlw6
 p8d5x018PgHOFE/RJlnbZaDw==
X-Received: by 2002:a17:906:478d:b0:ae6:d94f:4326 with SMTP id
 a640c23a62f3a-ae6fcb520ccmr1362644066b.57.1752482627112; 
 Mon, 14 Jul 2025 01:43:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyp6tHCDEPwymTJwFNP12fJma5TYDhuC8m6nlnf+pWF04et2UyRfdJXz40rUF9nb6cenSI9JuCqjX2X2ZgfJU=
X-Received: by 2002:a17:906:478d:b0:ae6:d94f:4326 with SMTP id
 a640c23a62f3a-ae6fcb520ccmr1362640466b.57.1752482626639; Mon, 14 Jul 2025
 01:43:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1752229731.git.pabeni@redhat.com>
In-Reply-To: <cover.1752229731.git.pabeni@redhat.com>
From: Lei Yang <leiyang@redhat.com>
Date: Mon, 14 Jul 2025 16:43:09 +0800
X-Gm-Features: Ac12FXxatr64OrUhmel8luErrVbEIm_iqCQ2G7Fi9UrLidUG2qqfbpb6ijcKDPw
Message-ID: <CAPpAL=y4e=+H2rxHwwgbGvU+x10aTDVZ7ix+2YqVC3e6hd6L7g@mail.gmail.com>
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
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leiyang@redhat.com;
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

Hi Paolo

Does the compile of this series of patches require support for a
special kernel environment? I hit a compile issue after applied you
patches:
[1440/2928] Compiling C object libsystem.a.p/hw_virtio_vhost.c.o
FAILED: libsystem.a.p/hw_virtio_vhost.c.o
cc -m64 -Ilibsystem.a.p -I. -I.. -Isubprojects/dtc/libfdt
-I../subprojects/dtc/libfdt -Isubprojects/libvduse
-I../subprojects/libvduse -Iui -Iqapi -Itrace -Iui/shader
-I/usr/include/pixman-1 -I/usr/include/glib-2.0
-I/usr/lib64/glib-2.0/include -I/usr/include/libmount
-I/usr/include/blkid -I/usr/include/sysprof-6
-I/usr/include/gio-unix-2.0 -I/usr/include/slirp
-fdiagnostics-color=3Dauto -Wall -Winvalid-pch -Werror -std=3Dgnu11 -O0 -g
-fstack-protector-strong -Wempty-body -Wendif-labels
-Wexpansion-to-defined -Wformat-security -Wformat-y2k
-Wignored-qualifiers -Wimplicit-fallthrough=3D2 -Winit-self
-Wmissing-format-attribute -Wmissing-prototypes -Wnested-externs
-Wold-style-declaration -Wold-style-definition -Wredundant-decls
-Wshadow=3Dlocal -Wstrict-prototypes -Wtype-limits -Wundef -Wvla
-Wwrite-strings -Wno-missing-include-dirs -Wno-psabi
-Wno-shift-negative-value -isystem
/mnt/tests/distribution/command/qemu/linux-headers -isystem
linux-headers -iquote . -iquote /mnt/tests/distribution/command/qemu
-iquote /mnt/tests/distribution/command/qemu/include -iquote
/mnt/tests/distribution/command/qemu/host/include/x86_64 -iquote
/mnt/tests/distribution/command/qemu/host/include/generic -iquote
/mnt/tests/distribution/command/qemu/tcg/i386 -pthread -mcx16 -msse2
-D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE
-fno-strict-aliasing -fno-common -fwrapv -ftrivial-auto-var-init=3Dzero
-fzero-call-used-regs=3Dused-gpr -fPIE -DWITH_GZFILEOP -DCONFIG_SOFTMMU
-DCOMPILING_SYSTEM_VS_USER -MD -MQ libsystem.a.p/hw_virtio_vhost.c.o
-MF libsystem.a.p/hw_virtio_vhost.c.o.d -o
libsystem.a.p/hw_virtio_vhost.c.o -c ../hw/virtio/vhost.c
../hw/virtio/vhost.c: In function =E2=80=98vhost_dev_set_features=E2=80=99:
../hw/virtio/vhost.c:38:9: error: =E2=80=98r=E2=80=99 may be used uninitial=
ized
[-Werror=3Dmaybe-uninitialized]
   38 |         error_report(fmt ": %s (%d)", ## __VA_ARGS__, \
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   39 |                      strerror(-retval), -retval); \
      |                      ~~~~~~~~~~~~~~~~~~~~~~~~~~~
../hw/virtio/vhost.c:1006:9: note: in expansion of macro =E2=80=98VHOST_OPS=
_DEBUG=E2=80=99
 1006 |         VHOST_OPS_DEBUG(r, "extended features without device suppor=
t");
      |         ^~~~~~~~~~~~~~~
../hw/virtio/vhost.c:989:9: note: =E2=80=98r=E2=80=99 was declared here
  989 |     int r;
      |         ^
cc1: all warnings being treated as errors
ninja: build stopped: subcommand failed.
make[1]: *** [Makefile:168: run-ninja] Error 1
make[1]: Leaving directory '/mnt/tests/distribution/command/qemu/build'
make[1]: Entering directory '/mnt/tests/distribution/command/qemu/build'
[1/1493] Generating subprojects/dtc/version_gen.h with a custom command
[2/1493] Generating qemu-version.h with a custom command (wrapped by
meson to capture output)
[3/1492] Compiling C object libsystem.a.p/hw_virtio_vhost.c.o
FAILED: libsystem.a.p/hw_virtio_vhost.c.o
cc -m64 -Ilibsystem.a.p -I. -I.. -Isubprojects/dtc/libfdt
-I../subprojects/dtc/libfdt -Isubprojects/libvduse
-I../subprojects/libvduse -Iui -Iqapi -Itrace -Iui/shader
-I/usr/include/pixman-1 -I/usr/include/glib-2.0
-I/usr/lib64/glib-2.0/include -I/usr/include/libmount
-I/usr/include/blkid -I/usr/include/sysprof-6
-I/usr/include/gio-unix-2.0 -I/usr/include/slirp
-fdiagnostics-color=3Dauto -Wall -Winvalid-pch -Werror -std=3Dgnu11 -O0 -g
-fstack-protector-strong -Wempty-body -Wendif-labels
-Wexpansion-to-defined -Wformat-security -Wformat-y2k
-Wignored-qualifiers -Wimplicit-fallthrough=3D2 -Winit-self
-Wmissing-format-attribute -Wmissing-prototypes -Wnested-externs
-Wold-style-declaration -Wold-style-definition -Wredundant-decls
-Wshadow=3Dlocal -Wstrict-prototypes -Wtype-limits -Wundef -Wvla
-Wwrite-strings -Wno-missing-include-dirs -Wno-psabi
-Wno-shift-negative-value -isystem
/mnt/tests/distribution/command/qemu/linux-headers -isystem
linux-headers -iquote . -iquote /mnt/tests/distribution/command/qemu
-iquote /mnt/tests/distribution/command/qemu/include -iquote
/mnt/tests/distribution/command/qemu/host/include/x86_64 -iquote
/mnt/tests/distribution/command/qemu/host/include/generic -iquote
/mnt/tests/distribution/command/qemu/tcg/i386 -pthread -mcx16 -msse2
-D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE
-fno-strict-aliasing -fno-common -fwrapv -ftrivial-auto-var-init=3Dzero
-fzero-call-used-regs=3Dused-gpr -fPIE -DWITH_GZFILEOP -DCONFIG_SOFTMMU
-DCOMPILING_SYSTEM_VS_USER -MD -MQ libsystem.a.p/hw_virtio_vhost.c.o
-MF libsystem.a.p/hw_virtio_vhost.c.o.d -o
libsystem.a.p/hw_virtio_vhost.c.o -c ../hw/virtio/vhost.c
../hw/virtio/vhost.c: In function =E2=80=98vhost_dev_set_features=E2=80=99:
../hw/virtio/vhost.c:38:9: error: =E2=80=98r=E2=80=99 may be used uninitial=
ized
[-Werror=3Dmaybe-uninitialized]
   38 |         error_report(fmt ": %s (%d)", ## __VA_ARGS__, \
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   39 |                      strerror(-retval), -retval); \
      |                      ~~~~~~~~~~~~~~~~~~~~~~~~~~~
../hw/virtio/vhost.c:1006:9: note: in expansion of macro =E2=80=98VHOST_OPS=
_DEBUG=E2=80=99
 1006 |         VHOST_OPS_DEBUG(r, "extended features without device suppor=
t");
      |         ^~~~~~~~~~~~~~~
../hw/virtio/vhost.c:989:9: note: =E2=80=98r=E2=80=99 was declared here
  989 |     int r;
      |         ^
cc1: all warnings being treated as errors
ninja: build stopped: subcommand failed.
make[1]: *** [Makefile:168: run-ninja] Error 1
make[1]: Leaving directory '/mnt/tests/distribution/command/qemu/build'

Thanks
Lei

On Fri, Jul 11, 2025 at 9:08=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> Some virtualized deployments use UDP tunnel pervasively and are impacted
> negatively by the lack of GSO support for such kind of traffic in the
> virtual NIC driver.
>
> The virtio_net specification recently introduced support for GSO over
> UDP tunnel, and the kernel side of the implementation has been merged
> into the net-next tree; this series updates the virtio implementation to
> support such a feature.
>
> Currently the qemu virtio support limits the feature space to 64 bits,
> while the virtio specification allows for a larger number of features.
> Specifically the GSO-over-UDP-tunnel-related virtio features use bits
> 65-69; the larger part of this series (patches 3-11) actually deals with
> extending the features space.
>
> The extended features are carried by fixed size uint64_t arrays,
> bringing the current maximum features number to 128.
>
> The patches use some syntactic sugar to try to minimize the otherwise
> very large code churn. Specifically the extended features are boundled
> in an union with 'legacy' features definition, allowing no changes in
> the virtio devices not needing the extended features set.
>
> The actual offload implementation is in patches 12 and 13 and boils down
> to propagating the new offload to the tun devices and the vhost backend.
>
> Finally patch 1 is a small pre-req refactor that ideally could enter the
> tree separately; it's presented here in the same series to help
> reviewers more easily getting the full picture and patch 2 is a needed
> linux headers update.
>
> Tested with basic stream transfer with all the possible permutations of
> host kernel/qemu/guest kernel with/without GSO over UDP tunnel support,
> vs snapshots creation and restore and vs migration.
>
> Sharing again as RFC as the kernel bits have not entered the Linus tree
> yet - but they should on next merge window.
>
> Paolo Abeni (13):
>   net: bundle all offloads in a single struct
>   linux-headers: Update to Linux ~v6.16-rc5 net-next
>   virtio: introduce extended features type
>   virtio: serialize extended features state
>   virtio: add support for negotiating extended features
>   virtio-pci: implement support for extended features
>   vhost: add support for negotiating extended features
>   qmp: update virtio features map to support extended features
>   vhost-backend: implement extended features support
>   vhost-net: implement extended features support
>   virtio-net: implement extended features support
>   net: implement tunnel probing
>   net: implement UDP tunnel features offloading
>
>  hw/net/e1000e_core.c                         |   5 +-
>  hw/net/igb_core.c                            |   5 +-
>  hw/net/vhost_net-stub.c                      |   8 +-
>  hw/net/vhost_net.c                           |  50 +++--
>  hw/net/virtio-net.c                          | 215 +++++++++++++------
>  hw/net/vmxnet3.c                             |  13 +-
>  hw/virtio/vhost-backend.c                    |  62 +++++-
>  hw/virtio/vhost.c                            |  73 ++++++-
>  hw/virtio/virtio-bus.c                       |  11 +-
>  hw/virtio/virtio-hmp-cmds.c                  |   3 +-
>  hw/virtio/virtio-pci.c                       | 101 ++++++++-
>  hw/virtio/virtio-qmp.c                       |  89 +++++---
>  hw/virtio/virtio-qmp.h                       |   3 +-
>  hw/virtio/virtio.c                           | 111 ++++++++--
>  include/hw/virtio/vhost-backend.h            |   6 +
>  include/hw/virtio/vhost.h                    |  36 +++-
>  include/hw/virtio/virtio-features.h          | 124 +++++++++++
>  include/hw/virtio/virtio-net.h               |   2 +-
>  include/hw/virtio/virtio-pci.h               |   6 +-
>  include/hw/virtio/virtio.h                   |  11 +-
>  include/net/net.h                            |  20 +-
>  include/net/vhost_net.h                      |  33 ++-
>  include/standard-headers/linux/ethtool.h     |   4 +-
>  include/standard-headers/linux/vhost_types.h |   5 +
>  include/standard-headers/linux/virtio_net.h  |  33 +++
>  linux-headers/asm-x86/kvm.h                  |   8 +-
>  linux-headers/linux/kvm.h                    |   4 +
>  linux-headers/linux/vhost.h                  |   7 +
>  net/net.c                                    |  17 +-
>  net/netmap.c                                 |   3 +-
>  net/tap-bsd.c                                |   8 +-
>  net/tap-linux.c                              |  38 +++-
>  net/tap-linux.h                              |   9 +
>  net/tap-solaris.c                            |   9 +-
>  net/tap-stub.c                               |   8 +-
>  net/tap.c                                    |  19 +-
>  net/tap_int.h                                |   5 +-
>  qapi/virtio.json                             |   8 +-
>  38 files changed, 945 insertions(+), 227 deletions(-)
>  create mode 100644 include/hw/virtio/virtio-features.h
>
> --
> 2.50.0
>
>


