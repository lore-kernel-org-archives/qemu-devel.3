Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15697C5478C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 11:48:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfIQK-0002DC-HE; Wed, 28 Feb 2024 06:48:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rfIQ3-0001xI-Rt
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:48:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rfIPx-0002iU-Ae
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:48:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709120887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=BXPvZYGOhLWhC4Y9yW5OYZI7C8hPCevKDeLYnOM7TZ0=;
 b=EslrXjeQa9AMhTSe360/xQ2WFVmHpDSyMbze6RbmTAmhi4v2c7MVimP3Fg5MI019ky/oRP
 g9cOUE/svaDxPLQY84ZZI+zMLpldVsHbSZ10Y+bhwEhLM128vGmrbb+iyh8H78+f039ieq
 yQxpztNCWeflSJOofP83ItrD3nKsdoQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-zTRokmotMby1rmS1Bg58Ew-1; Wed, 28 Feb 2024 06:48:06 -0500
X-MC-Unique: zTRokmotMby1rmS1Bg58Ew-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-787a18ce7e2so526545085a.1
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 03:48:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709120886; x=1709725686;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BXPvZYGOhLWhC4Y9yW5OYZI7C8hPCevKDeLYnOM7TZ0=;
 b=dqjM0bblbZhZgnmhtg8pyhTt7OMOhq0kSEqY5+pgMUuZzcwdCrgfsgM1d663RGDAtI
 LZDVwm9WBk+usdOinAHL9Kx/uYk7V7KI1RqPVD2cWIcpFftqus1lPVci2GccT9BMTAKb
 MIdDzYbZuuS9JJ0fIpdS3Z3bPKodJTY+9XJIXQSDiUkVkzFJK4T3XOS1IVr9gp5f4Qqv
 weH9iVFrL00/jHmrli+o5lF6I7/m9/bPC47Q38SzAUF5HDNgacudcSXuL20xrcHQa+WS
 0y/9IYlEVLEz1DcMxk8EofqCijRFoX6ICjyrnOiYNQZcWBMxJRGCDYmp1Mb+5X+gnYMe
 DuPA==
X-Gm-Message-State: AOJu0YzWohI4W8mOt+G7NBLhD0lJxoUHdCrCR8HDoFLFFTGTd8Hx/mDJ
 9s9VilslGx0CnZrmWpgKrnGNXGiu1Dv1jGsuntz4+qGkXaz+df6gg2v9M05loRk0MX9xzsFj1fl
 KMrTHBvivU1u3TmHU5kGiZog5PFhn58NVLRXdH4fCkjI531TFWbgmICp24Jma3BSgWKPPpRW8v1
 MADGJU2m5YXI1wkzA3Cny9cj4qNVgPa6Ck/8rK
X-Received: by 2002:a37:c40c:0:b0:787:9e79:6f5c with SMTP id
 d12-20020a37c40c000000b007879e796f5cmr4669608qki.49.1709120885986; 
 Wed, 28 Feb 2024 03:48:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEe5FfDKl78yC+rFIJrYjtmi95q3FezM55EHfUsXTzEvvlRYSgC7k3ekw6Qfsq6DorYzBqnLQ==
X-Received: by 2002:a37:c40c:0:b0:787:9e79:6f5c with SMTP id
 d12-20020a37c40c000000b007879e796f5cmr4669574qki.49.1709120885589; 
 Wed, 28 Feb 2024 03:48:05 -0800 (PST)
Received: from step1.redhat.com (host-82-57-51-64.retail.telecomitalia.it.
 [82.57.51.64]) by smtp.gmail.com with ESMTPSA id
 b12-20020a05620a0f8c00b00787c1102df8sm4492315qkn.127.2024.02.28.03.48.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 03:48:04 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Coiby Xu <Coiby.Xu@gmail.com>, slp@redhat.com,
 Eduardo Habkost <eduardo@habkost.net>, Hanna Reitz <hreitz@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>, Kevin Wolf <kwolf@redhat.com>,
 David Hildenbrand <david@redhat.com>, stefanha@redhat.com,
 gmaglione@redhat.com, Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH 0/9] vhost-user: support any POSIX system (tested on macOS and
 FreeBSD)
Date: Wed, 28 Feb 2024 12:47:50 +0100
Message-ID: <20240228114759.44758-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The vhost-user protocol is not really Linux-specific, so let's try support
QEMU's frontends and backends (including libvhost-user) in any POSIX system
with this series. The main use case is to be able to use virtio devices that
we don't have built-in in QEMU (e.g. virtiofsd, vhost-user-vsock, etc.) even
in non-Linux systems.

The first 5 patches are more like fixes discovered at runtime on macOS or
FreeBSD that could go even independently of this series.

Patches 6, 7, and 8 enable building of frontends and backends (including
libvhost-user) with associated code changes to succeed in compilation.

The latest patch (9) adds support for the POSIX shm_open() API to create
shared memory which is identified by an fd that can be shared with vhost-user
backends. This is useful on those systems (like macOS) where we don't have
memfd_create() or special filesystems like "/dev/shm".

I put the whole series in RFC because I have some questions especially in
patch 6 and 9, but in general any comment/suggestion/test are really welcome.

Maybe the first 5 patches can go separately, but I only discovered those
problems after testing patches 6 - 9, so I have included them in this series
for now. Please let me know if you prefer that I send them separately.

For now I tested this series using vhost-user-blk and QSD on
macOS Sonoma 14.3.1 (aarch64), FreeBSD 14 (x86_64), and Fedora 39 (x86_64)
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
    -object memory-backend-file,mem-path="/mem0",shm=on,share=on,id=mem,size=512M \
    -device vhost-user-blk-pci,num-queues=1,disable-legacy=on,chardev=char0 \
    -chardev socket,id=char0,path=/tmp/vhost.socket

- FreeBSD (x86_64): start QEMU (no accelerators available)

  qemu-system-x86_64 -smp 2 -M q35,memory-backend=mem \
    -object memory-backend-file,mem-path="/mem0",shm=on,share=on,id=mem,size="512M" \
    -device vhost-user-blk-pci,num-queues=1,chardev=char0 \
    -chardev socket,id=char0,path=/tmp/vhost.socket

- Fedora (x86_64): start QEMU (using kvm accelerator)

  qemu-system-x86_64 -smp 2 -M q35,accel=kvm,memory-backend=mem \
    -object memory-backend-file,mem-path="/mem0",shm=on,share=on,id=mem,size="512M" \
    -device vhost-user-blk-pci,num-queues=1,chardev=char0 \
    -chardev socket,id=char0,path=/tmp/vhost.socket

Thanks,
Stefano

Stefano Garzarella (9):
  libvhost-user: set msg.msg_control to NULL when it is empty
  libvhost-user: fail vu_message_write() if sendmsg() is failing
  libvhost-user: mask F_INFLIGHT_SHMFD if memfd is not supported
  vhost-user-server: don't abort if we can't set fd non-blocking
  contrib/vhost-user-blk: fix bind() using the right size of the address
  vhost-user: enable frontends on any POSIX system
  libvhost-user: enable it on any POSIX system
  contrib/vhost-user-blk: enabled it on any POSIX system
  hostmem-file: support POSIX shm_open()

 meson.build                               |  5 +-
 qapi/qom.json                             |  4 ++
 subprojects/libvhost-user/libvhost-user.h |  2 +-
 backends/hostmem-file.c                   | 57 ++++++++++++++++-
 contrib/vhost-user-blk/vhost-user-blk.c   | 23 +++++--
 hw/net/vhost_net.c                        |  8 ++-
 subprojects/libvhost-user/libvhost-user.c | 76 ++++++++++++++++++++++-
 util/vhost-user-server.c                  |  6 +-
 backends/meson.build                      |  2 +-
 hw/block/Kconfig                          |  2 +-
 qemu-options.hx                           | 10 ++-
 util/meson.build                          |  4 +-
 12 files changed, 179 insertions(+), 20 deletions(-)

-- 
2.43.2


