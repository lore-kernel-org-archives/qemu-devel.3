Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDFF7CD1284
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 12:24:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsM89-0000Rv-VO; Thu, 04 Apr 2024 08:23:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rsM88-0000RD-Iv
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 08:23:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rsM86-0000wp-LS
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 08:23:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712233421;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=LNV1PCTN5GCJl2MvUD8nUfDJ3d0IVmd15bYC7q0NeUA=;
 b=PcV1rmTuwfhvyd7P+LilxkgAV6KKNyQO71u2+io+GOj40TB8ON9OKLVYIlb41CrtKIArFk
 V09U2DrFo8pSviJeQMoAidcX6qU32LihB8S8qdxhvWqxs/l2t4yd8QZ7Vom0yxjCMc0jR6
 RI80zNi24dx/Pp5rM7NoqJq/SyE1PhY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-0y-eHu-8MZGWw8FsWqopIg-1; Thu, 04 Apr 2024 08:23:40 -0400
X-MC-Unique: 0y-eHu-8MZGWw8FsWqopIg-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-56e214bc952so288336a12.2
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 05:23:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712233418; x=1712838218;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LNV1PCTN5GCJl2MvUD8nUfDJ3d0IVmd15bYC7q0NeUA=;
 b=H/u825GxdaxebDGU+PvXyjawbaFcG9GkXoxrfU+NrT6Qhtugw3hTFmfKyr1XNrzBhY
 9Ip+qZ9VjvbM4Ef+T9F8OvWrHzHTnbjEvi1uBQsiPgSPBJI2P9nq4bQ4lcnFm1HaZu6d
 Qkrvwqa5fRU2GJeWhDzYKCumce/JylHRNKFqeO6TGkFE6Sl28qVvbFBOxS9+jyZ8GPq9
 sVIOD8TenQ4/XOXheghH3OrAn30BdaUbtscdEL0s5TYTZTnj+EaUuLBvkm2J+HzoXvIA
 8+VjoX/BqbvxUCu8gW4alWcIACdk2sdQz38kcXFTXEi0Hu9wSdSqMUhcn4CR8MwIF4zX
 aVjw==
X-Gm-Message-State: AOJu0YwH0aMk62g3m2qKfUpQuXp7OmKetRJ3ry/bJs7czEVevn4R2bmP
 IGKGdiWHsXfAV8LqEsy5ghXKBv5FhPLzNOIJ1cu2s8vVLLiuMCBPA4XjPia1SYG3DHUnnjz7dpr
 0x4YwCuFtDabZfaLcs035NwB+4w6owbVpMVt5q2NpAIFZLrqVJuvrtl2YsitjUohTblyZcWCTES
 SsSHGjY24l8IuAnbzDbHVlvNSOB3zKgUXCQ84c
X-Received: by 2002:a50:d7d8:0:b0:568:9cfe:1974 with SMTP id
 m24-20020a50d7d8000000b005689cfe1974mr1529195edj.18.1712233418431; 
 Thu, 04 Apr 2024 05:23:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+GPLxmU+alhrLlFhX1gX5RXUqwdWb1opMoFA88WNi1P64TUC7HvUhHqIavfDOzOZ3s8sbcg==
X-Received: by 2002:a50:d7d8:0:b0:568:9cfe:1974 with SMTP id
 m24-20020a50d7d8000000b005689cfe1974mr1529152edj.18.1712233417869; 
 Thu, 04 Apr 2024 05:23:37 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-12-25-33.business.telecomitalia.it. [87.12.25.33])
 by smtp.gmail.com with ESMTPSA id
 k7-20020aa7c047000000b0056c443ce781sm9163199edo.85.2024.04.04.05.23.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Apr 2024 05:23:36 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: Coiby Xu <Coiby.Xu@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 slp@redhat.com, Eduardo Habkost <eduardo@habkost.net>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Raphael Norwitz <raphael@enfabrica.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Brad Smith <brad@comstyle.com>, stefanha@redhat.com,
 Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, David Hildenbrand <david@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, gmaglione@redhat.com,
 Jason Wang <jasowang@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH for-9.1 v3 00/11] vhost-user: support any POSIX system (tested
 on macOS, FreeBSD, OpenBSD)
Date: Thu,  4 Apr 2024 14:23:19 +0200
Message-ID: <20240404122330.92710-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
v3:
  - rebased on v9.0.0-rc2
  - patch 4: avoiding setting fd non-blocking for messages where we
    have memory fd (Eric)
  - patch 9: enriched commit message and documentation to highlight that we
    want to mimic memfd (David)

The vhost-user protocol is not really Linux-specific, so let's try support
QEMU's frontends and backends (including libvhost-user) in any POSIX system
with this series. The main use case is to be able to use virtio devices that
we don't have built-in in QEMU (e.g. virtiofsd, vhost-user-vsock, etc.) even
in non-Linux systems.

The first 5 patches are more like fixes discovered at runtime on macOS or
FreeBSD that could go even independently of this series.

Patches 6, 7, and 8 enable building of frontends and backends (including
libvhost-user) with associated code changes to succeed in compilation.

Patch 9 adds `memory-backend-shm` that uses the POSIX shm_open() API to
create shared memory which is identified by an fd that can be shared with
vhost-user backends. This is useful on those systems (like macOS) where
we don't have memfd_create() or special filesystems like "/dev/shm".

Patches 10 and 11 use `memory-backend-shm` in some vhost-user tests.

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

Stefano Garzarella (11):
  libvhost-user: set msg.msg_control to NULL when it is empty
  libvhost-user: fail vu_message_write() if sendmsg() is failing
  libvhost-user: mask F_INFLIGHT_SHMFD if memfd is not supported
  vhost-user-server: do not set memory fd non-blocking
  contrib/vhost-user-blk: fix bind() using the right size of the address
  vhost-user: enable frontends on any POSIX system
  libvhost-user: enable it on any POSIX system
  contrib/vhost-user-blk: enable it on any POSIX system
  hostmem: add a new memory backend based on POSIX shm_open()
  tests/qtest/vhost-user-blk-test: use memory-backend-shm
  tests/qtest/vhost-user-test: add a test case for memory-backend-shm

 docs/system/devices/vhost-user.rst        |   5 +-
 meson.build                               |   5 +-
 qapi/qom.json                             |  17 ++++
 subprojects/libvhost-user/libvhost-user.h |   2 +-
 backends/hostmem-shm.c                    | 118 ++++++++++++++++++++++
 contrib/vhost-user-blk/vhost-user-blk.c   |  23 ++++-
 hw/net/vhost_net.c                        |   5 +
 subprojects/libvhost-user/libvhost-user.c |  76 +++++++++++++-
 tests/qtest/vhost-user-blk-test.c         |   2 +-
 tests/qtest/vhost-user-test.c             |  23 +++++
 util/vhost-user-server.c                  |  12 +++
 backends/meson.build                      |   1 +
 hw/block/Kconfig                          |   2 +-
 qemu-options.hx                           |  11 ++
 util/meson.build                          |   4 +-
 15 files changed, 288 insertions(+), 18 deletions(-)
 create mode 100644 backends/hostmem-shm.c

-- 
2.44.0


