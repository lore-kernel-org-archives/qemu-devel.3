Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4786CCD1292
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 08:01:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtjwB-0006dY-Mb; Mon, 08 Apr 2024 04:01:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rtjw9-0006dL-1Y
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 04:01:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rtjw6-0005qc-VX
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 04:01:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712563262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TlkHyuFcO5E6Q/ir20m9VIDfGFAulH/CUk3DBwe+8aA=;
 b=bI7YaYH/q2bID0W+46TNE5n2kr7kzrUwq6cnx5nsMII7vP/gZyaPIvypPckhnVpwBHoUOM
 TNziXVWlnmWtWd8NR8QEYzvdsSRxEMQrovCtOmBAJXq/sF56TSfEeo5/XIdCjrCU61Llal
 c+rO+Xf7tzO1H9l4KgMXqKddyyQLZuw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-fI1ANuC3NvSPu3IQElsKwA-1; Mon, 08 Apr 2024 04:01:01 -0400
X-MC-Unique: fI1ANuC3NvSPu3IQElsKwA-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6963cd45fddso91614176d6.1
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 01:01:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712563260; x=1713168060;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TlkHyuFcO5E6Q/ir20m9VIDfGFAulH/CUk3DBwe+8aA=;
 b=uIT17yB/VUQL9AYf0Pg6wcSCcAjqSPqqvgwu1EgFbDJLCFxfi2eGPfW3kuSCXTvWBw
 Ak4KRJ7PGRJOyMPQybFqPkqZyV0r50YXj0eGIpvzqu7YCW4LqQucrFN7eh0aBBjFxYDO
 7UgBVtqqA0Ayt7KLkVPy/dknPEWju3WnQgZOnutzzucUfoHOM63F/llOSfdeITbUBgqp
 aE6AFraq4HjTl5CI0eefmPKVS35xUC8IbkGyc4c5HEKQm/xew5tVk0jSy0i8ByJZLR0T
 ZLa5FJTDXSt6o4x+vfUu6ZN9cKcMAJ91+69AvlER5DwEK2R1DcupyBaJjXfTDiiz0qrE
 GVgw==
X-Gm-Message-State: AOJu0Yy8zEF2IVmv7f4u7Fv+a+jCDkPazpx73dAwdaAf1TI7Mrnmto32
 JZ4T+63WxP9SILBYpZEKBZnGVLXR34XgV/hI2V3wtsKAbwWeO1T3PY1ktHXxaLm+eYaRloJs8E/
 IAgoekYxuuY/OuaBfaPdjmBIBwflat2kVh7tJh0ULqPhZ/9eCNmjljKFRsHmUWSnr/dFsdNGIEj
 adxV0PwgwBTk5kxyWFPPsvEefx/CZUVHHwUlNQ
X-Received: by 2002:a05:6214:1c48:b0:696:4771:9b57 with SMTP id
 if8-20020a0562141c4800b0069647719b57mr14552792qvb.23.1712563260196; 
 Mon, 08 Apr 2024 01:01:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGX6QLx3WRF+ZhnKo/9yUXYMeEa5tD/MBl9xXXJRg/EgV2l42p4gEyaWq4yMtLpLz6i4ISHcA==
X-Received: by 2002:a05:6214:1c48:b0:696:4771:9b57 with SMTP id
 if8-20020a0562141c4800b0069647719b57mr14552744qvb.23.1712563259711; 
 Mon, 08 Apr 2024 01:00:59 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.101.253])
 by smtp.gmail.com with ESMTPSA id
 s4-20020ad44b24000000b0069b0cdd780bsm1724492qvw.16.2024.04.08.01.00.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 01:00:59 -0700 (PDT)
Date: Mon, 8 Apr 2024 10:00:46 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: Coiby Xu <Coiby.Xu@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 qemu-block@nongnu.org,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, 
 slp@redhat.com, Eduardo Habkost <eduardo@habkost.net>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Raphael Norwitz <raphael@enfabrica.net>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Brad Smith <brad@comstyle.com>, stefanha@redhat.com, 
 Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, David Hildenbrand <david@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, gmaglione@redhat.com,
 Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH for-9.1 v3 00/11] vhost-user: support any POSIX system
 (tested on macOS, FreeBSD, OpenBSD)
Message-ID: <kmnh4tebmmo35ve3a23tbeh74cyc4x3py4dqosexakn2eokoz4@lairz633qsui>
References: <20240404122330.92710-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240404122330.92710-1-sgarzare@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.355,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

FYI I'll be on PTO till May 2nd, I'll send the v4 when I'm back ASAP.

Thanks,
Stefano

On Thu, Apr 04, 2024 at 02:23:19PM +0200, Stefano Garzarella wrote:
>v1: https://patchew.org/QEMU/20240228114759.44758-1-sgarzare@redhat.com/
>v2: https://patchew.org/QEMU/20240326133936.125332-1-sgarzare@redhat.com/
>v3:
>  - rebased on v9.0.0-rc2
>  - patch 4: avoiding setting fd non-blocking for messages where we
>    have memory fd (Eric)
>  - patch 9: enriched commit message and documentation to highlight that we
>    want to mimic memfd (David)
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
>Patches 6, 7, and 8 enable building of frontends and backends (including
>libvhost-user) with associated code changes to succeed in compilation.
>
>Patch 9 adds `memory-backend-shm` that uses the POSIX shm_open() API to
>create shared memory which is identified by an fd that can be shared with
>vhost-user backends. This is useful on those systems (like macOS) where
>we don't have memfd_create() or special filesystems like "/dev/shm".
>
>Patches 10 and 11 use `memory-backend-shm` in some vhost-user tests.
>
>Maybe the first 5 patches can go separately, but I only discovered those
>problems after testing patches 6 - 9, so I have included them in this series
>for now. Please let me know if you prefer that I send them separately.
>
>I tested this series using vhost-user-blk and QSD on macOS Sonoma 14.4
>(aarch64), FreeBSD 14 (x86_64), OpenBSD 7.4 (x86_64), and Fedora 39 (x86_64)
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
>Thanks,
>Stefano
>
>Stefano Garzarella (11):
>  libvhost-user: set msg.msg_control to NULL when it is empty
>  libvhost-user: fail vu_message_write() if sendmsg() is failing
>  libvhost-user: mask F_INFLIGHT_SHMFD if memfd is not supported
>  vhost-user-server: do not set memory fd non-blocking
>  contrib/vhost-user-blk: fix bind() using the right size of the address
>  vhost-user: enable frontends on any POSIX system
>  libvhost-user: enable it on any POSIX system
>  contrib/vhost-user-blk: enable it on any POSIX system
>  hostmem: add a new memory backend based on POSIX shm_open()
>  tests/qtest/vhost-user-blk-test: use memory-backend-shm
>  tests/qtest/vhost-user-test: add a test case for memory-backend-shm
>
> docs/system/devices/vhost-user.rst        |   5 +-
> meson.build                               |   5 +-
> qapi/qom.json                             |  17 ++++
> subprojects/libvhost-user/libvhost-user.h |   2 +-
> backends/hostmem-shm.c                    | 118 ++++++++++++++++++++++
> contrib/vhost-user-blk/vhost-user-blk.c   |  23 ++++-
> hw/net/vhost_net.c                        |   5 +
> subprojects/libvhost-user/libvhost-user.c |  76 +++++++++++++-
> tests/qtest/vhost-user-blk-test.c         |   2 +-
> tests/qtest/vhost-user-test.c             |  23 +++++
> util/vhost-user-server.c                  |  12 +++
> backends/meson.build                      |   1 +
> hw/block/Kconfig                          |   2 +-
> qemu-options.hx                           |  11 ++
> util/meson.build                          |   4 +-
> 15 files changed, 288 insertions(+), 18 deletions(-)
> create mode 100644 backends/hostmem-shm.c
>
>-- 
>2.44.0
>


