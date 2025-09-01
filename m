Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33211CA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 14:55:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut5vv-0004pT-2w; Mon, 01 Sep 2025 10:54:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1ut5vt-0004pH-Sg
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 10:54:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1ut5vr-0000rU-PK
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 10:54:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756738493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2IfSXl4ZTB8ea4bS5GZ8wRVHQADG+0PcZ+L058WN+J8=;
 b=CkdLdbS+F1DFN19NAUMv8pC3SDEXB7Vta2yKfMSn5t4qHFQiJnNAvmDNeeWja1fEcP60Dg
 JlEJygNAZdagVnC75luWk/GGOkUHnJfCgAnrwKpAdJVALg09mlO3XH35BXeakA0bhXAOQo
 hkCxtkkAV+sbzw6LQakQTLGYmyElSEU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-sgzO5J03NlCndO_AnSu2ng-1; Mon, 01 Sep 2025 10:54:49 -0400
X-MC-Unique: sgzO5J03NlCndO_AnSu2ng-1
X-Mimecast-MFC-AGG-ID: sgzO5J03NlCndO_AnSu2ng_1756738489
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-7131866cdceso37340716d6.1
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 07:54:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756738489; x=1757343289;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2IfSXl4ZTB8ea4bS5GZ8wRVHQADG+0PcZ+L058WN+J8=;
 b=bU6FK6eE8sa95laexPoD3dfRQxfxP4IhFWVyhZkBj7SLzLez1dvD8G2LUqNu8Pn8Lz
 o82WSMrA64B/Lv5pFWsDOQCnAMS2pK0+J48GM7X0GYW5uvXL+LK8o79BmpTGmspwbNoJ
 hub1qaBpPtimZDNII7QYJSXlI+2kA1QDWokV8OS86jaojZmqQWuLSkuZxwPgRmDfCUGV
 B83c3/1GSyugjTm1U0p08wE3qtnSlLkQKepED8M0PtfetyGsDE04reMCXjWTNMPMqAuV
 tl8xSsju20da1bsJAKuwlIiR6PU+TZ+oJ4wz3v7JrBa2IdzPzJ5AVR9O3RnHodBYhXnq
 JQvw==
X-Gm-Message-State: AOJu0YwM60w9ymUArLZjs0bQmO6F3aXSPSYQ5t9kJqS6g32FozcHiBmM
 Xcczhg4H5KlyZKehevL2QfyDeJvrajGGMyB2rNMN4h6ejH1CwKRPUB4NsDjQkF5u/1gNo8IjEv2
 4wbPo9fpMo3LcubUNtv7d8mXbYe1SOwMhJTEpHUQJftv1wK2N7oYbp8Xk
X-Gm-Gg: ASbGnctdY3c8MNPiIoKf3B4f1pmqtfIpsS2+7ysu9Cysc/iq6l0yLbGMGxtkP0yXrGR
 gSr8D0zY8srd75syVrtOQto/WDx1LZFlJuwhnRwARd6syvO8pmq7r6g0f3MB8jD7leojCVHTL1s
 R2k7GPaYEXBYS5DekgIxFQWLQdIoDvn2IHAvoxCkllXmAw5pHAX8n+Mx5w+6f7swOYK9SnIGmYg
 bZi3IZ68mDCzzhILMA/y3zDxu7piQWLkmS4J1XfG3aDFL68C1sP15ro3cIBQH9FbCJoj4xitBN5
 OcC9WT293NL5tFFxHH/o6KNR86nyUfmSE9gZ7XP3zDeuN72Y7cpntBeZ+273ogP0qXY9Yj78ndL
 icKfzumHNbfUvPQs=
X-Received: by 2002:a05:6214:2246:b0:70d:c4f1:cd7d with SMTP id
 6a1803df08f44-70fac901b9dmr86621306d6.56.1756738489170; 
 Mon, 01 Sep 2025 07:54:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDBxQBl2BYMMjAz02xHdB03X7RhnH4O4r6HFkYh8BfkU5E0GPwGcExA1w7V/FSCcPX4H3maw==
X-Received: by 2002:a05:6214:2246:b0:70d:c4f1:cd7d with SMTP id
 6a1803df08f44-70fac901b9dmr86620956d6.56.1756738488673; 
 Mon, 01 Sep 2025 07:54:48 -0700 (PDT)
Received: from sgarzare-redhat (host-79-45-205-118.retail.telecomitalia.it.
 [79.45.205.118]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-70fb289a993sm40950116d6.55.2025.09.01.07.54.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 07:54:47 -0700 (PDT)
Date: Mon, 1 Sep 2025 16:54:38 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v5 00/13] virtio: introduce support for GSO over UDP tunnel
Message-ID: <ybw72ypxjtiuhaz7m5kvwuqau5vrobpt3zpcskgk7ug4v33ohu@hbajn7dn3ka5>
References: <cover.1755080613.git.pabeni@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <cover.1755080613.git.pabeni@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Aug 13, 2025 at 12:28:13PM +0200, Paolo Abeni wrote:
>Some virtualized deployments use UDP tunnel pervasively and are impacted
>negatively by the lack of GSO support for such kind of traffic in the
>virtual NIC driver.
>
>The virtio_net specification recently introduced support for GSO over
>UDP tunnel, and the kernel side of the implementation has been merged
>into the net-next tree; this series updates the virtio implementation to
>support such a feature.
>
>Currently the qemu virtio support limits the feature space to 64 bits,
>while the virtio specification allows for a larger number of features.
>Specifically the GSO-over-UDP-tunnel-related virtio features use bits
>65-69; the larger part of this series (patches 4-12) actually deals with
>extending the features space.
>
>The extended features are carried by fixed size uint64_t arrays,
>bringing the current maximum features number to 128.
>
>The patches use some syntactic sugar to try to minimize the otherwise
>very large code churn. Specifically the extended features are boundled
>in an union with 'legacy' features definition, allowing no changes in
>the virtio devices not needing the extended features set.
>
>The actual offload implementation is in patches 13 and 14 and boils down
>to propagating the new offload to the tun devices and the vhost backend.
>
>Patch 1 is a small pre-req refactor that ideally could enter the
>tree separately; it's presented here in the same series to help
>reviewers more easily getting the full picture, patch 2 updates to
>linux headers update script to deal with annotations recently introduce
>in the kernel and patch 3 is a needed linux headers update.
>
>Tested with basic stream transfer with all the possible permutations of
>host kernel/qemu/guest kernel with/without GSO over UDP tunnel support,
>vs snapshots creation and restore and vs migration.
>
>The new features are disabled by default to avoid compatibilty issues.
>They could be enabled after that hw_compat_10_1 will be added, together
>with the related compatiblity entries.

Okay, this should avoid any migration issue for now, but IIUC you will 
enable it in a followup patch, right?

So for this series:

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

>
>Based-on: 9d71108d7de139dd4f4e6efe6837cabb32bf5616.1755078918.git.pabeni@redhat.com
>---
>v4 -> v5:
>  - more sparse cleanup
>  - dropped RFC tag
>  - disable the new features by default
>
>v4: https://lists.gnu.org/archive/html/qemu-devel/2025-07/msg05513.html
>
>v3 -> v4:
>  - more sparse cleanups
>  - fix build failures on a couple of targets
>v3: https://lists.gnu.org/archive/html/qemu-devel/2025-07/msg04872.html
>
>v2 -> v3:
>  - consolidated suffixes for new fields to '_ex'
>  - avoid pre/post load trickery and relay on reset zeroing the features
>  - cleaned-up virtio store implementation deduplicating a bit of code
>  - many more cleanups, see the individual patches changelog for the
>    details
>  - I left patch 1 unmodified, still some hope we could live with that;)
>v2: https://lists.gnu.org/archive/html/qemu-devel/2025-07/msg03000.html
>
>Paolo Abeni (13):
>  linux-headers: deal with counted_by annotation
>  linux-headers: Update to Linux v6.17-rc1
>  virtio: introduce extended features type
>  virtio: serialize extended features state
>  virtio: add support for negotiating extended features
>  virtio-pci: implement support for extended features
>  vhost: add support for negotiating extended features
>  qmp: update virtio features map to support extended features
>  vhost-backend: implement extended features support
>  vhost-net: implement extended features support
>  virtio-net: implement extended features support
>  net: implement tunnel probing
>  net: implement UDP tunnel features offloading
>
> hw/net/vhost_net-stub.c                       |   8 +-
> hw/net/vhost_net.c                            |  45 ++--
> hw/net/virtio-net.c                           | 215 ++++++++++++------
> hw/virtio/vhost-backend.c                     |  62 ++++-
> hw/virtio/vhost.c                             |  68 ++++--
> hw/virtio/virtio-bus.c                        |  11 +-
> hw/virtio/virtio-hmp-cmds.c                   |   3 +-
> hw/virtio/virtio-pci.c                        |  74 +++++-
> hw/virtio/virtio-qmp.c                        |  91 +++++---
> hw/virtio/virtio-qmp.h                        |   3 +-
> hw/virtio/virtio.c                            | 100 +++++---
> include/hw/virtio/vhost-backend.h             |   6 +
> include/hw/virtio/vhost.h                     |  56 ++++-
> include/hw/virtio/virtio-features.h           | 127 +++++++++++
> include/hw/virtio/virtio-net.h                |   2 +-
> include/hw/virtio/virtio-pci.h                |   2 +-
> include/hw/virtio/virtio.h                    |  11 +-
> include/net/net.h                             |   5 +
> include/net/vhost_net.h                       |  33 ++-
> include/standard-headers/drm/drm_fourcc.h     |  56 ++++-
> include/standard-headers/linux/ethtool.h      |   4 +-
> .../linux/input-event-codes.h                 |   8 +
> include/standard-headers/linux/input.h        |   1 +
> include/standard-headers/linux/pci_regs.h     |   9 +
> include/standard-headers/linux/vhost_types.h  |   5 +
> include/standard-headers/linux/virtio_net.h   |  33 +++
> linux-headers/LICENSES/preferred/GPL-2.0      |  10 +-
> linux-headers/asm-arm64/unistd_64.h           |   2 +
> linux-headers/asm-generic/unistd.h            |   8 +-
> linux-headers/asm-loongarch/unistd_64.h       |   2 +
> linux-headers/asm-mips/unistd_n32.h           |   2 +
> linux-headers/asm-mips/unistd_n64.h           |   2 +
> linux-headers/asm-mips/unistd_o32.h           |   2 +
> linux-headers/asm-powerpc/kvm.h               |  13 --
> linux-headers/asm-powerpc/unistd_32.h         |   2 +
> linux-headers/asm-powerpc/unistd_64.h         |   2 +
> linux-headers/asm-riscv/kvm.h                 |   1 +
> linux-headers/asm-riscv/unistd_32.h           |   2 +
> linux-headers/asm-riscv/unistd_64.h           |   2 +
> linux-headers/asm-s390/unistd_32.h            |   2 +
> linux-headers/asm-s390/unistd_64.h            |   2 +
> linux-headers/asm-x86/unistd_32.h             |   2 +
> linux-headers/asm-x86/unistd_64.h             |   2 +
> linux-headers/asm-x86/unistd_x32.h            |   2 +
> linux-headers/linux/iommufd.h                 | 154 ++++++++++++-
> linux-headers/linux/kvm.h                     |   2 +
> linux-headers/linux/vfio.h                    |  12 +-
> linux-headers/linux/vhost.h                   |  35 +++
> net/net.c                                     |  12 +-
> net/tap-bsd.c                                 |   5 +
> net/tap-linux.c                               |  17 ++
> net/tap-linux.h                               |   9 +
> net/tap-solaris.c                             |   5 +
> net/tap-stub.c                                |   5 +
> net/tap.c                                     |  13 ++
> net/tap_int.h                                 |   1 +
> qapi/virtio.json                              |   9 +-
> scripts/update-linux-headers.sh               |   1 +
> 58 files changed, 1136 insertions(+), 242 deletions(-)
> create mode 100644 include/hw/virtio/virtio-features.h
>
>-- 
>2.50.1
>


