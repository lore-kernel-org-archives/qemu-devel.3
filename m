Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 286CECAC5AC
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 08:30:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v23p3-0006v7-Jt; Fri, 26 Sep 2025 04:28:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1v23oy-0006mN-Pz
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 04:28:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1v23of-0004U6-NX
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 04:28:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758875303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uXG7m5KDjP1Is+bTNzxNlxebMl2kXve7KKE48SCW8rI=;
 b=UC3ccL/AKKRn0Oz4TgAPPWlxpJacZh94qzNU4tCp1S9akdPI61x6a+ci6LPd2tgpGD2Yih
 0WqEUIBvHsxdehq5d//Sxe+wP8cfMPsp2ZAi9UL0pUsFB7WoPOSzTpEYCpk41Pp8hlmlEY
 ubnGRZHo/JyfgX7yToiUDBFthXzSQq0=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-hVoT80cMOj-BXpsHk5suHg-1; Fri, 26 Sep 2025 04:28:20 -0400
X-MC-Unique: hVoT80cMOj-BXpsHk5suHg-1
X-Mimecast-MFC-AGG-ID: hVoT80cMOj-BXpsHk5suHg_1758875299
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-26985173d8eso36571115ad.1
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 01:28:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758875299; x=1759480099;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uXG7m5KDjP1Is+bTNzxNlxebMl2kXve7KKE48SCW8rI=;
 b=QnCAS6QmoT15pDo62+atiDRflXn0i/iJI+iRpWhAxSF4moPQCfoiTVhYLpwr1ktin7
 GcS/VWU8OnViSQV7SFoHfpSmswv6iJ8UHiUm9jiQzQFH/WkE7QOxLxl1cyaGDmIODlz9
 z7oUdhPizfmndRzAO1OAbQm3HkQ+eb+b5dmvPvs0JPUu/LliXxQiH6sV+DI0GR9Ip7cJ
 qLPlqs3C9oCtKA6mZ3ZC4h7uJoROvpooqt9QpwV17QBTEv0ER7g1deVMwf+865CNuAnZ
 58+/G11JmhgarHDrSttTrdnPZLraUAgoNUHwm7eEqko7mpFB+hDT48symQX8uOkIu/eF
 yoZg==
X-Gm-Message-State: AOJu0YzSMZimMypMQE3m4l5ivrGP6k/IRWIMnxLIKi89JlEdMrjLnbPc
 kio+2OlctIV/UgBGowHWUL/8txygfZWcePLVF8/qtvFTeyYSl3fFdoUP9Czvh92L+6ca0RPki0K
 2dt8isNAm6Uur+8vQdxACr8Yj8rWVnf6fZnyVU2M4wWLRifG/IStWTj/9UhNLBpVm2EwP54gqfR
 fXjjyEj5MtRP7LBrZbLD9E3sNBks1f1nieXGPm+Ug=
X-Gm-Gg: ASbGncv5F5dLmJJPKmlhhQ7IrfIoYvdgGvPc7xHZbFa2SLQa6GNwoVI6I87uYqPXk1w
 8FeCfNrrLFcA170/qgZVPF6cajK+fb7ZBnk6orlJTHpllVIoM0EOYv5xxUUHlfF0TnQdEwa+f8A
 fRjBxQE0KJKzc9/C2c
X-Received: by 2002:a17:903:b8f:b0:271:7eba:a49 with SMTP id
 d9443c01a7336-27ed49dd8bcmr72765875ad.19.1758875298799; 
 Fri, 26 Sep 2025 01:28:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/MIeHiBUDw6vvecvv8sqQyTFdnM9y1D/SSx8aO0/0sTA0FSktW3ML3qY6P9wJ0kTYgtrKG5mp3VejdRWoeF8=
X-Received: by 2002:a17:903:b8f:b0:271:7eba:a49 with SMTP id
 d9443c01a7336-27ed49dd8bcmr72765585ad.19.1758875298436; Fri, 26 Sep 2025
 01:28:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250910115420.1012191-1-aesteve@redhat.com>
In-Reply-To: <20250910115420.1012191-1-aesteve@redhat.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Fri, 26 Sep 2025 10:28:07 +0200
X-Gm-Features: AS18NWBRFOGot9vc9s-7qnpfd0h8ELIl4cGYG5Z5ZjQu-BCaQR7Fgh3_OxdyC7o
Message-ID: <CADSE00K1zU9EeHYRCXie=i=jz55YLzExXdJ5_Ng6sH2w0fySVQ@mail.gmail.com>
Subject: Re: [PATCH v8 0/7] vhost-user: Add SHMEM_MAP/UNMAP requests
To: qemu-devel@nongnu.org
Cc: stevensd@chromium.org, dbassey@redhat.com, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 mst@redhat.com, slp@redhat.com, 
 hi@alyssa.is, stefanha@redhat.com, Fabiano Rosas <farosas@suse.de>, 
 Stefano Garzarella <sgarzare@redhat.com>, jasowang@redhat.com, david@redhat.com,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Wed, Sep 10, 2025 at 1:54=E2=80=AFPM Albert Esteve <aesteve@redhat.com> =
wrote:
>
> Hi all,
>
> v7->v8
> - Unified VhostUserShmemObject and VirtioSharedMemoryMapping
> - Refined shmem_obj lifecycle by transferring ownership
> - Other small improvements
> v6->v7
> - Fixed vhost_user_shmem_object_new to use
>   memory_region_init_ram_from_fd as before
> v5->v6
> - Added intermediate QOM object to manage shared MemoryRegion lifecycle
>   with reference counting, and automatic cleanup
> - Resolved BAR conflict, change from 2 to 3 to avoid conflict with
>   `modern-pio-notify=3Don`
> - Added SHMEM_CONFIG validation in vhost-user-test
> - Changed VirtSharedMemory -> VirtioSharedMemory
> - Changed MappedMemoryRegion -> VirtioSharedMemoryMapping
> - Changed from heap-allocated MemoryRegion *mr to embedded MemoryRegion
>   mr in VirtioSharedMemory structure to eliminate memory leaks and
>   simplify cleanup
> - Fixed VirtioSharedMemory initialization and cleanup with
>   memory_region_init() and object_unparent()
> - Other minor fixes, typos, and updates.
>
> This patch series implements dynamic fd-backed memory mapping support
> for vhost-user backends, enabling backends to dynamically request memory
> mappings and unmappings during runtime through the new
> VHOST_USER_BACKEND_SHMEM_MAP/UNMAP protocol messages.
>
> This feature benefits various VIRTIO devices that require dynamic shared
> memory management, including virtiofs (for DAX mappings), virtio-gpu
> (for resource sharing), and the recently standardized virtio-media.
>
> The implementation introduces a QOM-based architecture for managing
> shared memory lifecycle:
>
> - VirtioSharedMemoryMapping: an intermediate object that manages
>   individual memory mappings by acting as generic container for regions
>   declared in any vhost-user device type
> - Dynamic Mapping: backends can request mappings via SHMEM_MAP messages,
>   with the frontend creating MemoryRegions from the provided file
>   descriptors and adding them as subregions
>
> When a SHMEM_MAP request is received, the frontend:
> 1. Creates VirtioSharedMemoryMapping to manage the mapping lifecycle
> 2. Maps the provided fd with memory_region_init_ram_from_fd()
> 3. Creates a MemoryRegion backed by the mapped memory
> 4. Adds it as a subregion of the appropiate VIRTIO Shared Memory Region
>
> The QOM reference counting ensures automatic cleanup when mappings are
> removed or the device is destroyed.
>
> This patch also includes:
> - VHOST_USER_GET_SHMEM_CONFIG: a new frontend request allowing generic
>   vhost-user devices to query shared memory configuration from backends
>   at device initialization, enabling the generic vhost-user-device
>   frontend to work with any backend regardless of specific shared memory
>   requirements.

Small bump to avoid this patch series falling too much.

>
> The implementation has been tested with rust-vmm based backends and
> includes SHMEM_CONFIG QTest validation.
>
> Albert Esteve (7):
>   vhost-user: Add VirtIO Shared Memory map request
>   vhost_user.rst: Align VhostUserMsg excerpt members
>   vhost_user.rst: Add SHMEM_MAP/_UNMAP to spec
>   vhost_user: Add frontend get_shmem_config command
>   vhost_user.rst: Add GET_SHMEM_CONFIG message
>   qmp: add shmem feature map
>   vhost-user-device: Add shared memory BAR
>
>  docs/interop/vhost-user.rst               | 101 +++++++++
>  hw/virtio/vhost-user-base.c               |  47 +++-
>  hw/virtio/vhost-user-device-pci.c         |  34 ++-
>  hw/virtio/vhost-user.c                    | 249 +++++++++++++++++++++-
>  hw/virtio/virtio-qmp.c                    |   3 +
>  hw/virtio/virtio.c                        | 198 +++++++++++++++++
>  include/hw/virtio/vhost-backend.h         |  10 +
>  include/hw/virtio/vhost-user.h            |   1 +
>  include/hw/virtio/virtio.h                | 138 ++++++++++++
>  subprojects/libvhost-user/libvhost-user.c |  70 ++++++
>  subprojects/libvhost-user/libvhost-user.h |  54 +++++
>  11 files changed, 898 insertions(+), 7 deletions(-)
>
> --
> 2.49.0
>


