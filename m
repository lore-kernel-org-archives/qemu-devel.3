Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4C44C25B4F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 07:46:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4bzF-0003CB-VW; Wed, 08 May 2024 03:45:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1s4bzE-0003BY-18
 for qemu-devel@nongnu.org; Wed, 08 May 2024 03:45:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1s4bzB-0000dl-JZ
 for qemu-devel@nongnu.org; Wed, 08 May 2024 03:45:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715154308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=q+uxvdVSfMJ8ay9061nGF0CdmJNPyfYp9/s+mWt/0b4=;
 b=CwEtQpBcQVSGCDFqUitVPoEnSk32UTznDxYc10U9YuZK0KKkM5Py2SICV5WSbU+j+rnWkl
 NfZttB0QkArJDSe7UgqbfQggMwCTOrZKeCO+KL1I7Fu8TrU4pQHkXPLsmwVLN3cEuEYdcn
 5YPmqholkchQ/ZsN2wHiuL1WUQmg+0w=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-8dpQljbyPsOfPRYLSdeTFQ-1; Wed, 08 May 2024 03:45:07 -0400
X-MC-Unique: 8dpQljbyPsOfPRYLSdeTFQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a59a5b06802so256110066b.1
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 00:45:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715154305; x=1715759105;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q+uxvdVSfMJ8ay9061nGF0CdmJNPyfYp9/s+mWt/0b4=;
 b=NZQn3R3vcO0i9UyrfapV7LpRts6jw6Hut3AIdb01cmD4woGWYf1pd8CAA386jv71Oz
 BYh3hmZ27Pq6ZptjOz6ydBwJzuiqCJLHauTpwScNZt7NlWRiDVz788NrZJtG3PRJPHxI
 i1SpeInwdxN+VFqtVPlbMYwCyhu2OuYNBrDlpTDSKuouSsKj4apRpJTaMsv0HaqcNe9v
 KbvM0TIlC+zFmbK62tsI/1RxKHdu06aT5tHQz+nxFtpJq6nTJRpIOt7j+2L/eiEeXojx
 xhGKVe9fDzbTuscK/zcOX7ZE6PjsfeL1717heKCgraST1oLO0ULDQb7TA6S6Jb3849fh
 6djA==
X-Gm-Message-State: AOJu0Yx+RoQl5LStOM03qzoGlVjJKPMDSTT/4eMG1kbXGGBLrF0hg4/5
 fhGuccbbx1KiZjwTWlkJSbJM8ugwZwuQnSI6K4ZrlJalljppHWDEVMzdBTJhBsqv34LhC3PLavl
 jOyIxx9ERbPL0azLpVcUd17/SsaDvAS/lJzZIys2zH0qYZ6OZKZ5tUzKQZngT598mVsBrxWLnHn
 RsbvaKCCyu5Zm954EpNdwbyo3zCbgeXMqqUhYm
X-Received: by 2002:a17:906:494d:b0:a59:a5c3:819e with SMTP id
 a640c23a62f3a-a59fb9490f9mr111118866b.11.1715154305157; 
 Wed, 08 May 2024 00:45:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvY3X8BEI1ytr/yUhv3FrGadf0SsUl1CbnxU3bcX4A/XLklDgKI+9nwdbmA9dnb0Lx+CWN8g==
X-Received: by 2002:a17:906:494d:b0:a59:a5c3:819e with SMTP id
 a640c23a62f3a-a59fb9490f9mr111114766b.11.1715154304653; 
 Wed, 08 May 2024 00:45:04 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-12-25-56.business.telecomitalia.it. [87.12.25.56])
 by smtp.gmail.com with ESMTPSA id
 jw24-20020a17090776b800b00a599b64c09dsm6010486ejc.128.2024.05.08.00.45.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 May 2024 00:45:03 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, slp@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Brad Smith <brad@comstyle.com>, Eduardo Habkost <eduardo@habkost.net>,
 Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>, gmaglione@redhat.com,
 Laurent Vivier <lvivier@redhat.com>, stefanha@redhat.com,
 David Hildenbrand <david@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v4 00/12] vhost-user: support any POSIX system (tested on
 macOS, FreeBSD, OpenBSD)
Date: Wed,  8 May 2024 09:44:44 +0200
Message-ID: <20240508074457.12367-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.45.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
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
v4:
  - rebased on master (commit e116b92d01c2cd75957a9f8ad1d4932292867b81)
  - added patch 6 to move using QEMU bswap helper functions in a separate
    patch (Phil)
  - fail if we find "share=off" in shm_backend_memory_alloc() (David)
  - added Phil's R-b and David's A-b

The vhost-user protocol is not really Linux-specific, so let's try support
QEMU's frontends and backends (including libvhost-user) in any POSIX system
with this series. The main use case is to be able to use virtio devices that
we don't have built-in in QEMU (e.g. virtiofsd, vhost-user-vsock, etc.) even
in non-Linux systems.

The first 5 patches are more like fixes discovered at runtime on macOS or
FreeBSD that could go even independently of this series.

Patches 6, 7, 8, and 9 enable building of frontends and backends (including
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
(aarch64), FreeBSD 14 (x86_64), OpenBSD 7.4 (x86_64), and Fedora 39 (x86_64)
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
 qapi/qom.json                             |  17 +++
 subprojects/libvhost-user/libvhost-user.h |   2 +-
 backends/hostmem-shm.c                    | 123 ++++++++++++++++++++++
 contrib/vhost-user-blk/vhost-user-blk.c   |  27 +++--
 contrib/vhost-user-input/main.c           |  16 +--
 hw/net/vhost_net.c                        |   5 +
 subprojects/libvhost-user/libvhost-user.c |  76 ++++++++++++-
 tests/qtest/vhost-user-blk-test.c         |   2 +-
 tests/qtest/vhost-user-test.c             |  23 ++++
 util/vhost-user-server.c                  |  12 +++
 backends/meson.build                      |   1 +
 hw/block/Kconfig                          |   2 +-
 qemu-options.hx                           |  13 +++
 util/meson.build                          |   4 +-
 16 files changed, 305 insertions(+), 28 deletions(-)
 create mode 100644 backends/hostmem-shm.c

-- 
2.45.0


