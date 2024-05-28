Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13D69C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 10:38:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBuBs-0004PO-87; Tue, 28 May 2024 06:36:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sBuBR-0004G6-EQ
 for qemu-devel@nongnu.org; Tue, 28 May 2024 06:35:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sBuBM-00089c-8E
 for qemu-devel@nongnu.org; Tue, 28 May 2024 06:35:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716892550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=NINVpEAN3xpAzrNMjB4rMbb6O/WYqXEwKaFMu+PqnuQ=;
 b=LIYauNCWsXpGy/rFxbNUVsQqhOcYXS8AaPFSxxkrKCxhpYulAbt25nR3QtVDQppNJSDxPt
 xrpLLGV1Si56ZI5xkMWYhV64aHsJhRlP9iKvSnW63Un8XAKLK4Tjwq87wWg/H1MYVR/eFG
 zdLKPDv3t3PHoLt8zERbg7hHjVY82xw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-3C_YuilSP46PMZO8hzoSpw-1; Tue, 28 May 2024 06:35:48 -0400
X-MC-Unique: 3C_YuilSP46PMZO8hzoSpw-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-354f34e0ab0so356549f8f.3
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 03:35:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716892547; x=1717497347;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NINVpEAN3xpAzrNMjB4rMbb6O/WYqXEwKaFMu+PqnuQ=;
 b=O2XXfH1zkV3VDAO6AQBU7HETEsQPxX23at3V6D4C3ym7spt1GsOC0AWPFwkIA7bpeW
 cQfjDURGXZCc4hhr6w/tcU4F0J1W6YgOLoWWzrv3YEhvg82z7mZHb/g/UAmWsB8aRtzB
 dm4hOkm1h9wJwydaa31fOg+XY4lLU3EQnsD9ik0hS2AWGwmoD7ezzb3NU+u5m/Zp5Uzk
 nWS7btywrlu7BGkaVr7HM/6eLdcYnAvqnz4bQ0I2LN6DZHvlRGrjWGcwrM95j6FtJszC
 hm3FmuJoBBxCGO+yOw84QEJ6Uqmh8G4KFjVLhy85N3QM5lIf9a0TjhGqXbJloBQA2Iaq
 nh9g==
X-Gm-Message-State: AOJu0YwbVfJLnyfKenw9gPhJ+CtibeSbcr5uorEaz/JcD2if69s2XwN7
 2DFk+52T4H0ZZZvRt/ko4Oo60ghW7VG9uWRdO5EOf43Vr9kU/nxRMFH/S7rpUNZvHMwmypSy7sa
 DzvjtZbaQ58TicQCJk+2SySAc/s/W7WVl9zxra3Bvqe5IAUeVG8uSi3wQ2+vQA811lEyar9DZFN
 mM9PvnNMFVOu5nXcgscwtu5JUnFAPdV0lE+xuQ
X-Received: by 2002:a5d:4ec2:0:b0:354:be7c:954 with SMTP id
 ffacd0b85a97d-35526c6ade8mr7824563f8f.15.1716892546919; 
 Tue, 28 May 2024 03:35:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENSHkmjk0acdbE3w5dCZy9glmAYEz8pEFg0GmZhReZ+LIgowvGqrlod1A2WRWXa7IysOtJWA==
X-Received: by 2002:a5d:4ec2:0:b0:354:be7c:954 with SMTP id
 ffacd0b85a97d-35526c6ade8mr7824519f8f.15.1716892546319; 
 Tue, 28 May 2024 03:35:46 -0700 (PDT)
Received: from step1.redhat.com (host-79-53-30-109.retail.telecomitalia.it.
 [79.53.30.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3557a08a8d4sm11422116f8f.35.2024.05.28.03.35.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 03:35:45 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: slp@redhat.com, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Igor Mammedov <imammedo@redhat.com>, Brad Smith <brad@comstyle.com>,
 gmaglione@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Coiby Xu <Coiby.Xu@gmail.com>, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>, Thomas Huth <thuth@redhat.com>,
 stefanha@redhat.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v6 00/12] vhost-user: support any POSIX system (tested on
 macOS, FreeBSD, OpenBSD)
Date: Tue, 28 May 2024 12:35:31 +0200
Message-ID: <20240528103543.145412-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
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

v1: https://patchew.org/QEMU/20240228114759.44758-1-sgarzare@redhat.com/
v2: https://patchew.org/QEMU/20240326133936.125332-1-sgarzare@redhat.com/
v3: https://patchew.org/QEMU/20240404122330.92710-1-sgarzare@redhat.com/
v4: https://patchew.org/QEMU/20240508074457.12367-1-sgarzare@redhat.com/
v5: https://patchew.org/QEMU/20240523145522.313012-1-sgarzare@redhat.com/
v6:
- rebased on 60b54b67c63d8f076152e0f7dccf39854dfc6a77
- added David R-b tags [thanks!]
- patch 9 (was split in 9 & 10 in v5): reverted v5 changes since we can't
  move O_DSYNC and O_DIRECT in osdep [Daniel, failing tests on Windows]
- patch 11: removed `share=on` since it's the default [David]
- the series is now fully acked/reviewed

The vhost-user protocol is not really Linux-specific, so let's try support
QEMU's frontends and backends (including libvhost-user) in any POSIX system
with this series. The main use case is to be able to use virtio devices that
we don't have built-in in QEMU (e.g. virtiofsd, vhost-user-vsock, etc.) even
in non-Linux systems.

The first 5 patches are more like fixes discovered at runtime on macOS or
FreeBSD that could go even independently of this series.

Patches 6, 7, 8, 9 enable building of frontends and backends (including
libvhost-user) with associated code changes to succeed in compilation.

Patch 10 adds `memory-backend-shm` that uses the POSIX shm_open() API to
create shared memory which is identified by an fd that can be shared with
vhost-user backends. This is useful on those systems (like macOS) where
we don't have memfd_create() or special filesystems like "/dev/shm".

Patches 11 and 12 use `memory-backend-shm` in some vhost-user tests.

Maybe the first 5 patches can go separately, but I only discovered those
problems after testing patches 6 - 9, so I have included them in this series
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

Stefano Garzarella (12):
  libvhost-user: set msg.msg_control to NULL when it is empty
  libvhost-user: fail vu_message_write() if sendmsg() is failing
  libvhost-user: mask F_INFLIGHT_SHMFD if memfd is not supported
  vhost-user-server: do not set memory fd non-blocking
  contrib/vhost-user-blk: fix bind() using the right size of the address
  contrib/vhost-user-*: use QEMU bswap helper functions
  vhost-user: enable frontends on any POSIX system
  libvhost-user: enable it on any POSIX system
  contrib/vhost-user-blk: enable it on any POSIX system
  hostmem: add a new memory backend based on POSIX shm_open()
  tests/qtest/vhost-user-blk-test: use memory-backend-shm
  tests/qtest/vhost-user-test: add a test case for memory-backend-shm

 docs/system/devices/vhost-user.rst        |   5 +-
 meson.build                               |   5 +-
 qapi/qom.json                             |  19 ++++
 subprojects/libvhost-user/libvhost-user.h |   2 +-
 backends/hostmem-shm.c                    | 123 ++++++++++++++++++++++
 contrib/vhost-user-blk/vhost-user-blk.c   |  27 +++--
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
 16 files changed, 311 insertions(+), 28 deletions(-)
 create mode 100644 backends/hostmem-shm.c

-- 
2.45.1


