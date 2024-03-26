Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 729A7CD11DD
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 13:39:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp71r-00075l-8w; Tue, 26 Mar 2024 09:39:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rp71l-000753-MN
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 09:39:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rp71j-0004tz-SF
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 09:39:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711460383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=n8T2pb8+im5j0Z7vkwcHl/iJW8e6iRCIAHEcgLOxbA8=;
 b=CUUV2HWLvvI/gHauKqVf+KFGEINdOXPtHduUH9BfIQY0ZEXSrOrt25aZo+WaEFfTMJI7X6
 ZvYurLYM5Lcwa/Ms9ctYm12sA1dQ2BOY74Iaw7psrijtrLsJBMMJOYaxKz1QudaIL+2mrs
 NfdHsBZndXBjiLLN7RnEFcL6u+512t0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-h7KU1488MlSEhMy3Cf-0iw-1; Tue, 26 Mar 2024 09:39:41 -0400
X-MC-Unique: h7KU1488MlSEhMy3Cf-0iw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4140bf38378so39346265e9.1
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 06:39:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711460380; x=1712065180;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n8T2pb8+im5j0Z7vkwcHl/iJW8e6iRCIAHEcgLOxbA8=;
 b=xA41N3xXtIbKYgOBKQIhN16A1p569xsvdWKtPnocMdGuMvobkoxZedgEwkM13gAvAb
 EWtpmFecYKE4lIZ1oXqq6Ue10y2QNlKiSvYfLuKatqLMeta58UbX+CmYBQUWJg40QYcC
 oTReyFGRLXG3+/zCRFkPIyXAn+Bi2EwnQ5xnf0+L89y7BUrpNm+me5nNh9LASnhjwiUF
 DxA/Ge4NzRWWmGvf01E90/DzYsRBEwR+fGaC4umi8p8NTNVJM0ivuNK4V9lByGkxWSkc
 iqm1dZTh65V6xhpzKh6VEfHY06qEbJJwRt3MDS5hCEVBdn6Sg0UFQrsx91T7wSXjHGqv
 9qkg==
X-Gm-Message-State: AOJu0YyQYMD+Gv5bdNWjl4u6EoCsF6zjB11se0nMASul3HUqM4YFKpGD
 zRvJShFA0aZ0H1FHjM+ee0fnsbpeo7kRtuSffQVUA8wB4vn1HlH+JpTu1T3hXYUyzjkY7szaz9V
 r3VFM9lw1cAeoW52uiBbhSlmtR3qlUSqBH1ydZVE9+ntTXAxCPqjyk/WbA3Kb50KytPGJkJ2b/5
 9TW3Uz1m8Y2fKdG9mSYb3vEekehSJZQ1NVH2Rp
X-Received: by 2002:a7b:c3cc:0:b0:413:e19:337f with SMTP id
 t12-20020a7bc3cc000000b004130e19337fmr9400696wmj.22.1711460379905; 
 Tue, 26 Mar 2024 06:39:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvvvbBNNY5u8RsrZr8VxxVIJeIwHuaRop9c4+V42xzYM4UhvwR4YD1UiRw6EbcCCMA+Bf5Rw==
X-Received: by 2002:a7b:c3cc:0:b0:413:e19:337f with SMTP id
 t12-20020a7bc3cc000000b004130e19337fmr9400652wmj.22.1711460379421; 
 Tue, 26 Mar 2024 06:39:39 -0700 (PDT)
Received: from step1.redhat.com (host-87-12-25-33.business.telecomitalia.it.
 [87.12.25.33]) by smtp.gmail.com with ESMTPSA id
 x18-20020adfffd2000000b0034181bea3b0sm12267832wrs.3.2024.03.26.06.39.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Mar 2024 06:39:38 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, gmaglione@redhat.com,
 Eric Blake <eblake@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Hanna Reitz <hreitz@redhat.com>, stefanha@redhat.com,
 Coiby Xu <Coiby.Xu@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>, slp@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Brad Smith <brad@comstyle.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH for-9.1 v2 00/11] vhost-user: support any POSIX system (tested
 on macOS, FreeBSD, OpenBSD)
Date: Tue, 26 Mar 2024 14:39:25 +0100
Message-ID: <20240326133936.125332-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
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
v2:
  - fixed Author email and little typos in some patches
  - added memory-backend-shm (patches 9, 10, 11) [Daniel, David, Markus]
  - removed changes to memory-backend-file (ex patch 9)
  - used memory-backend-shm in tests/qtest/vhost-user-blk-test (patch 10)
  - added test case in tests/qtest/vhost-user-test (patch 11)

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
  vhost-user-server: don't abort if we can't set fd non-blocking
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
 util/vhost-user-server.c                  |   6 +-
 backends/meson.build                      |   1 +
 hw/block/Kconfig                          |   2 +-
 qemu-options.hx                           |  10 ++
 util/meson.build                          |   4 +-
 15 files changed, 280 insertions(+), 19 deletions(-)
 create mode 100644 backends/hostmem-shm.c

-- 
2.44.0


