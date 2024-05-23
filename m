Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15B8AC25B79
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 14:56:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA9r1-00021Q-IL; Thu, 23 May 2024 10:55:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sA9r0-00020f-3l
 for qemu-devel@nongnu.org; Thu, 23 May 2024 10:55:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sA9qw-0003uo-3t
 for qemu-devel@nongnu.org; Thu, 23 May 2024 10:55:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716476132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=woDXXxVfoWbJVZwq6QRcPz2Jk8QlEnpoQseNmkhGRn4=;
 b=cmns7kXBaTxC+MJCLmEJKUqu3u7YkwxYtgQIxRgIuPGfMvIKn0pD4igcKMWCiQYWUe01jj
 yBsgokXGGXf84ueQGr7D7z081JjL19PLNljWR4uoOZJTSLBCgOFEX7D1ZWFojMFXOo+BKq
 N/d0TJ/c6yG8jMqwWKuniQrSHG+05J8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509--DGEydMuMnOAkUFW0_uXcA-1; Thu, 23 May 2024 10:55:31 -0400
X-MC-Unique: -DGEydMuMnOAkUFW0_uXcA-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6ab875ad0edso2675486d6.2
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 07:55:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716476130; x=1717080930;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=woDXXxVfoWbJVZwq6QRcPz2Jk8QlEnpoQseNmkhGRn4=;
 b=RfAHWiasVYyUkeQtNq/4e+zymYKN/1LwhGANGLp6aRVmIgiBF2xClxSCHV7FFbB1FK
 5pY43v47e+EGqLuQ9RArv/eFjhHOlNVAFqe20qxdUjduBRAJ2i64zLvYBRl/K0Mu7tW9
 UStWBXyZ6udP0bbPX/a8Hl4wiz99tyxCKD+UJuIq+TmNQBzVlJOh9qYOR+QkbIcqh9ns
 Kiw7HDMu5Ql73w8tOXTapkFKratkUGNcnLCZBpiD1mNPhu4VVXwTT0O+trRWWRR3PYOp
 al6WXniHJ4JC8xUw7DhqDym3HzYLf3hLyhhHnemnM+fVpGBdzCNBhBvre3URzYoi2gFQ
 o9OQ==
X-Gm-Message-State: AOJu0YyW1hl8JHfpSge+Hj91SqbKbgxdfpi6nOy/fwfOWdjewAey1TQ0
 nQaTSRpUon88HNMIoWiqgX7LksuZzP6fy63VEsnIEXAmaQsGMk/5KsFkCHih7cgtKUYf30Pcm+g
 zgmFLlBrFVhKFeU6cApm9Wlt6toSbzUl6lfyzDfJAxuPJ0dQ4s5OeG8z37xq3Yse6x4dUST0Rs1
 BWWSowf1P19rI8j0ii/Hgi748G5gh+lCvkeiD9
X-Received: by 2002:a05:6214:4991:b0:6a9:d2bb:a540 with SMTP id
 6a1803df08f44-6ab80908460mr61234726d6.54.1716476130241; 
 Thu, 23 May 2024 07:55:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzu4A+ZS0M4m02aKl7zWmJ2TKEaTxNyjOSfiVeE7y3FziRpsD69g6r5YzVKpCCnQf6Ptylkg==
X-Received: by 2002:a05:6214:4991:b0:6a9:d2bb:a540 with SMTP id
 6a1803df08f44-6ab80908460mr61234186d6.54.1716476129550; 
 Thu, 23 May 2024 07:55:29 -0700 (PDT)
Received: from step1.redhat.com (host-79-53-30-109.retail.telecomitalia.it.
 [79.53.30.109]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ab9585fc19sm4289896d6.49.2024.05.23.07.55.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 07:55:28 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Brad Smith <brad@comstyle.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Coiby Xu <Coiby.Xu@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>, slp@redhat.com,
 Eduardo Habkost <eduardo@habkost.net>, stefanha@redhat.com,
 Hanna Reitz <hreitz@redhat.com>, Raphael Norwitz <raphael@enfabrica.net>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, gmaglione@redhat.com,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v5 00/13] vhost-user: support any POSIX system (tested on
 macOS, FreeBSD, OpenBSD)
Date: Thu, 23 May 2024 16:55:09 +0200
Message-ID: <20240523145522.313012-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

v1: https://patchew.org/QEMU/20240228114759.44758-1-sgarzare@redhat.com/
v2: https://patchew.org/QEMU/20240326133936.125332-1-sgarzare@redhat.com/
v3: https://patchew.org/QEMU/20240404122330.92710-1-sgarzare@redhat.com/
v4: https://patchew.org/QEMU/20240508074457.12367-1-sgarzare@redhat.com/
v5:
- rebased on 7e1c0047015ffbd408e1aa4a5ec1abe4751dbf7e
- added some R-b/A-b/T-b tags [Daniel, Phil, Thomas, Stefan thanks!]
- added new patch to move O_DSYNC and O_DIRECT defines in osdep [Phil]
- fixed memory-backend-shm documentation in qapi/qom.json and qemu-options.hx
  [Markus]
- fixed typos in some commits description [Phil]

The vhost-user protocol is not really Linux-specific, so let's try support
QEMU's frontends and backends (including libvhost-user) in any POSIX system
with this series. The main use case is to be able to use virtio devices that
we don't have built-in in QEMU (e.g. virtiofsd, vhost-user-vsock, etc.) even
in non-Linux systems.

The first 5 patches are more like fixes discovered at runtime on macOS or
FreeBSD that could go even independently of this series.

Patches 6, 7, 8, 9, and 10 enable building of frontends and backends (including
libvhost-user) with associated code changes to succeed in compilation.

Patch 11 adds `memory-backend-shm` that uses the POSIX shm_open() API to
create shared memory which is identified by an fd that can be shared with
vhost-user backends. This is useful on those systems (like macOS) where
we don't have memfd_create() or special filesystems like "/dev/shm".

Patches 12 and 13 use `memory-backend-shm` in some vhost-user tests.

Maybe the first 5 patches can go separately, but I only discovered those
problems after testing patches 6 - 10, so I have included them in this series
for now. Please let me know if you prefer that I send them separately.

I tested this series using vhost-user-blk and QSD on macOS Sonoma 14.4
(aarch64), FreeBSD 14 (x86_64), OpenBSD 7.4 (x86_64), and Fedora 40 (x86_64)
in this way:

- Start vhost-user-blk or QSD (same commands for all systems)

  vhost-user-blk -s /tmp/vhost.socket \
    -b Fedora-Cloud-Base-39-1.5.x86_64.raw

  qemu-storage-daemon \
    --blockdev file,filename=Fedora-Cloud-Base-39-1.5.x86_64.qcow2,node-name=file \
    --blockdev qcow2,file=file,node-name=qcow2 \
    --export vhost-user-blk,addr.type=unix,addr.path=/tmp/vhost.socket,id=vub,num-queues=1,node-name=qcow2,writable=on

- macOS (aarch64): start QEMU (using hvf accelerator)

  qemu-system-aarch64 -smp 2 -cpu host -M virt,accel=hvf,memory-backend=mem \
    -drive file=./build/pc-bios/edk2-aarch64-code.fd,if=pflash,format=raw,readonly=on \
    -device virtio-net-device,netdev=net0 -netdev user,id=net0 \
    -device ramfb -device usb-ehci -device usb-kbd \
    -object memory-backend-shm,id=mem,size=512M \
    -device vhost-user-blk-pci,num-queues=1,disable-legacy=on,chardev=char0 \
    -chardev socket,id=char0,path=/tmp/vhost.socket

- FreeBSD/OpenBSD (x86_64): start QEMU (no accelerators available)

  qemu-system-x86_64 -smp 2 -M q35,memory-backend=mem \
    -object memory-backend-shm,id=mem,size="512M" \
    -device vhost-user-blk-pci,num-queues=1,chardev=char0 \
    -chardev socket,id=char0,path=/tmp/vhost.socket

- Fedora (x86_64): start QEMU (using kvm accelerator)

  qemu-system-x86_64 -smp 2 -M q35,accel=kvm,memory-backend=mem \
    -object memory-backend-shm,size="512M" \
    -device vhost-user-blk-pci,num-queues=1,chardev=char0 \
    -chardev socket,id=char0,path=/tmp/vhost.socket

Branch pushed (and CI started) at https://gitlab.com/sgarzarella/qemu/-/tree/macos-vhost-user?ref_type=heads

Thanks,
Stefano

Stefano Garzarella (13):
  libvhost-user: set msg.msg_control to NULL when it is empty
  libvhost-user: fail vu_message_write() if sendmsg() is failing
  libvhost-user: mask F_INFLIGHT_SHMFD if memfd is not supported
  vhost-user-server: do not set memory fd non-blocking
  contrib/vhost-user-blk: fix bind() using the right size of the address
  contrib/vhost-user-*: use QEMU bswap helper functions
  vhost-user: enable frontends on any POSIX system
  libvhost-user: enable it on any POSIX system
  osdep: move O_DSYNC and O_DIRECT defines from file-posix
  contrib/vhost-user-blk: enable it on any POSIX system
  hostmem: add a new memory backend based on POSIX shm_open()
  tests/qtest/vhost-user-blk-test: use memory-backend-shm
  tests/qtest/vhost-user-test: add a test case for memory-backend-shm

 docs/system/devices/vhost-user.rst        |   5 +-
 meson.build                               |   5 +-
 qapi/qom.json                             |  19 ++++
 include/qemu/osdep.h                      |  14 +++
 subprojects/libvhost-user/libvhost-user.h |   2 +-
 backends/hostmem-shm.c                    | 123 ++++++++++++++++++++++
 block/file-posix.c                        |  14 ---
 contrib/vhost-user-blk/vhost-user-blk.c   |  13 ++-
 contrib/vhost-user-input/main.c           |  16 +--
 hw/net/vhost_net.c                        |   5 +
 subprojects/libvhost-user/libvhost-user.c |  77 +++++++++++++-
 tests/qtest/vhost-user-blk-test.c         |   2 +-
 tests/qtest/vhost-user-test.c             |  23 ++++
 util/vhost-user-server.c                  |  12 +++
 backends/meson.build                      |   1 +
 hw/block/Kconfig                          |   2 +-
 qemu-options.hx                           |  16 +++
 util/meson.build                          |   4 +-
 18 files changed, 311 insertions(+), 42 deletions(-)
 create mode 100644 backends/hostmem-shm.c

-- 
2.45.1


