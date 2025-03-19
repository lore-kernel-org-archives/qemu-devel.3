Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C8A2C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 12:30:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tusYq-0000Fe-RC; Wed, 19 Mar 2025 08:30:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tusYp-0000Ds-DI
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 08:30:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tusYl-00007X-O7
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 08:30:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742387409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7IZfgkn+ofF3VQXe19GIRaHwiYP1J1/SivnFMwlC2Jc=;
 b=KJlTH8AeI5IjMEXPYbgSaxfalpg8OPrUQG1HW97J/kDknUW5X8P98EcQ9YShp1KBGd4SKm
 TZ0fZGyfQZKNpN0582pZWxoqAyMn7UPp/6ryRSzYYCC69fJYKFQLNJgVaLIneVCrwJudJc
 bBMCLXwlfCj+pH5ps6tQ27Vl4P6EM+s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-aeI20-NhNxiOeLpYwGAWsA-1; Wed, 19 Mar 2025 08:30:07 -0400
X-MC-Unique: aeI20-NhNxiOeLpYwGAWsA-1
X-Mimecast-MFC-AGG-ID: aeI20-NhNxiOeLpYwGAWsA_1742387406
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43ceb011ea5so28117555e9.2
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 05:30:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742387406; x=1742992206;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7IZfgkn+ofF3VQXe19GIRaHwiYP1J1/SivnFMwlC2Jc=;
 b=cU7FnzH08XE5VXLzy9rzSLbLIZbOgVSK5V0TjpxoGQDZZlYpAYVok1m473CiTotE7M
 YL3KDe7ulSuz9gnoFxAMmvQ9NWNbLdeZHvCPYzXj/EE0WffH1yAtCx30ZsKlIFMoHZBM
 f6q8K8+49E5hNRJTJztQzYcexYAmKeyePN+1lk4z3diDGBQSOF6xFx9mZm8B/Iq0ozGL
 NOmoeerkJ2EagxYVXFGKY15TTCwLwJAj3uzN28zqIXBa37OczGJprFVdEpygGagwZ2du
 hrKtkj7bOChXYYuy1aouWgav4upmEGJIPWY2KW7nU9zosZW+xhpQvoeEySInGR7IyiM9
 DSDQ==
X-Gm-Message-State: AOJu0YyRSkVcHNd/6uzN4zBIKDJPTq/XQAulrNXFPc+npIto/yyEyyKQ
 42Zh63C4wAvghfDILBrWlPVhV5kyHl1ljUkMOrwCTw61gNita1Bl156wS2vpQuLaabra0MP6JzU
 yY3ENaHMoXXrpNAnYvPDO8p2pYT0pjsdn14eF98eMuKkuQqnT/jrDULIzn3t1Y10dBWHhMySjRj
 L5yprXoD5IoAJt7ihozWsXUnk7mxM=
X-Gm-Gg: ASbGncu/S4wGGgeJ/R4nrHDwoyFBOGKgt1eq9Ux8L5dKRgcM97hR1Als7A6E7mgcE5w
 w12n18VXhqIZeSXrqRMYxGu3A6/gklRji5iOmcct8wOvPeKeHMfpDMHAWgu+SL0TkOe1yClcKXq
 4=
X-Received: by 2002:a05:600c:5107:b0:43c:f597:d584 with SMTP id
 5b1f17b1804b1-43d43899ffcmr24375895e9.29.1742387406207; 
 Wed, 19 Mar 2025 05:30:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+tJsYAA4Z8XOZx6bzuv8Vc245y7/8n2dNPwmOJZgChJTDbMZdasxCKxHyJSo1WeeiJ7uoW7YYuk8yF/WEISY=
X-Received: by 2002:a05:600c:5107:b0:43c:f597:d584 with SMTP id
 5b1f17b1804b1-43d43899ffcmr24375295e9.29.1742387405652; Wed, 19 Mar 2025
 05:30:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250318095415.670319-1-clg@redhat.com>
 <20250318095415.670319-7-clg@redhat.com>
In-Reply-To: <20250318095415.670319-7-clg@redhat.com>
From: Prasad Pandit <ppandit@redhat.com>
Date: Wed, 19 Mar 2025 17:59:48 +0530
X-Gm-Features: AQ5f1JoN6ZojwS0xRxfkzy_F5XeULoCX0HQJ_yx4tYn7y6rSPhVZbP5BDE84Z2k
Message-ID: <CAE8KmOyy7nLFQ+6Ogr6HT7qA-ThsE7dMm1-AN5L7iHN3WVnqAw@mail.gmail.com>
Subject: Re: [PATCH for-10.1 06/32] vfio: Introduce a new header file for
 internal migration services
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, 
 Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>, 
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, 18 Mar 2025 at 15:26, C=C3=A9dric Le Goater <clg@redhat.com> wrote:
> Gather all VFIO migration related declarations into "migration.h" to
> reduce exposure of VFIO internals in "hw/vfio/vfio-common.h".
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
> ---
>  hw/vfio/migration.h           | 72 +++++++++++++++++++++++++++++++++++
>  include/hw/vfio/vfio-common.h | 54 +-------------------------
>  hw/vfio/common.c              | 17 +--------
>  hw/vfio/iommufd.c             |  1 +
>  hw/vfio/migration-multifd.c   |  1 +
>  hw/vfio/migration.c           | 17 +++++++++
>  hw/vfio/pci.c                 |  1 +
>  7 files changed, 94 insertions(+), 69 deletions(-)
>  create mode 100644 hw/vfio/migration.h
>
> diff --git a/hw/vfio/migration.h b/hw/vfio/migration.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..7ad2141d06a7c97f034db908f=
9ce19fd06f415b9
> --- /dev/null
> +++ b/hw/vfio/migration.h
> @@ -0,0 +1,72 @@
> +/*
> + * VFIO migration
> + *
> + * Copyright Red Hat, Inc. 2025
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_VFIO_MIGRATION_H
> +#define HW_VFIO_MIGRATION_H
> +
> +#ifdef CONFIG_LINUX
> +#include <linux/vfio.h>
> +#endif
> +
> +#include "qemu/notify.h"
> +
> +/*
> + * Flags to be used as unique delimiters for VFIO devices in the migrati=
on
> + * stream. These flags are composed as:
> + * 0xffffffff =3D> MSB 32-bit all 1s
> + * 0xef10     =3D> Magic ID, represents emulated (virtual) function IO
> + * 0x0000     =3D> 16-bits reserved for flags
> + *
> + * The beginning of state information is marked by _DEV_CONFIG_STATE,
> + * _DEV_SETUP_STATE, or _DEV_DATA_STATE, respectively. The end of a
> + * certain state information is marked by _END_OF_STATE.
> + */
> +#define VFIO_MIG_FLAG_END_OF_STATE      (0xffffffffef100001ULL)
> +#define VFIO_MIG_FLAG_DEV_CONFIG_STATE  (0xffffffffef100002ULL)
> +#define VFIO_MIG_FLAG_DEV_SETUP_STATE   (0xffffffffef100003ULL)
> +#define VFIO_MIG_FLAG_DEV_DATA_STATE    (0xffffffffef100004ULL)
> +#define VFIO_MIG_FLAG_DEV_INIT_DATA_SENT (0xffffffffef100005ULL)
> +
> +typedef struct VFIODevice VFIODevice;
> +typedef struct VFIOMultifd VFIOMultifd;
> +
> +typedef struct VFIOMigration {
> +    struct VFIODevice *vbasedev;
> +    VMChangeStateEntry *vm_state;
> +    NotifierWithReturn migration_state;
> +    uint32_t device_state;
> +    int data_fd;
> +    void *data_buffer;
> +    size_t data_buffer_size;
> +    uint64_t mig_flags;
> +    uint64_t precopy_init_size;
> +    uint64_t precopy_dirty_size;
> +    bool multifd_transfer;
> +    VFIOMultifd *multifd;
> +    bool initial_data_sent;
> +
> +    bool event_save_iterate_started;
> +    bool event_precopy_empty_hit;
> +} VFIOMigration;
> +
> +
> +bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp);
> +void vfio_migration_exit(VFIODevice *vbasedev);
> +bool vfio_device_state_is_running(VFIODevice *vbasedev);
> +bool vfio_device_state_is_precopy(VFIODevice *vbasedev);
> +int vfio_save_device_config_state(QEMUFile *f, void *opaque, Error **err=
p);
> +int vfio_load_device_config_state(QEMUFile *f, void *opaque);
> +
> +#ifdef CONFIG_LINUX
> +int vfio_migration_set_state(VFIODevice *vbasedev,
> +                             enum vfio_device_mig_state new_state,
> +                             enum vfio_device_mig_state recover_state,
> +                             Error **errp);
> +#endif
> +
> +#endif /* HW_VFIO_MIGRATION_H */
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.=
h
> index 0aae88131cffda1a90b8ccd0224387133c0fa83a..799e12d43747addbf444c1505=
2f629b65978322f 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -23,7 +23,6 @@
>
>  #include "exec/memory.h"
>  #include "qemu/queue.h"
> -#include "qemu/notify.h"
>  #include "ui/console.h"
>  #include "hw/display/ramfb.h"
>  #ifdef CONFIG_LINUX
> @@ -36,23 +35,6 @@
>
>  #define VFIO_MSG_PREFIX "vfio %s: "
>
> -/*
> - * Flags to be used as unique delimiters for VFIO devices in the migrati=
on
> - * stream. These flags are composed as:
> - * 0xffffffff =3D> MSB 32-bit all 1s
> - * 0xef10     =3D> Magic ID, represents emulated (virtual) function IO
> - * 0x0000     =3D> 16-bits reserved for flags
> - *
> - * The beginning of state information is marked by _DEV_CONFIG_STATE,
> - * _DEV_SETUP_STATE, or _DEV_DATA_STATE, respectively. The end of a
> - * certain state information is marked by _END_OF_STATE.
> - */
> -#define VFIO_MIG_FLAG_END_OF_STATE      (0xffffffffef100001ULL)
> -#define VFIO_MIG_FLAG_DEV_CONFIG_STATE  (0xffffffffef100002ULL)
> -#define VFIO_MIG_FLAG_DEV_SETUP_STATE   (0xffffffffef100003ULL)
> -#define VFIO_MIG_FLAG_DEV_DATA_STATE    (0xffffffffef100004ULL)
> -#define VFIO_MIG_FLAG_DEV_INIT_DATA_SENT (0xffffffffef100005ULL)
> -
>  enum {
>      VFIO_DEVICE_TYPE_PCI =3D 0,
>      VFIO_DEVICE_TYPE_PLATFORM =3D 1,
> @@ -78,27 +60,6 @@ typedef struct VFIORegion {
>      uint8_t nr; /* cache the region number for debug */
>  } VFIORegion;
>
> -typedef struct VFIOMultifd VFIOMultifd;
> -
> -typedef struct VFIOMigration {
> -    struct VFIODevice *vbasedev;
> -    VMChangeStateEntry *vm_state;
> -    NotifierWithReturn migration_state;
> -    uint32_t device_state;
> -    int data_fd;
> -    void *data_buffer;
> -    size_t data_buffer_size;
> -    uint64_t mig_flags;
> -    uint64_t precopy_init_size;
> -    uint64_t precopy_dirty_size;
> -    bool multifd_transfer;
> -    VFIOMultifd *multifd;
> -    bool initial_data_sent;
> -
> -    bool event_save_iterate_started;
> -    bool event_precopy_empty_hit;
> -} VFIOMigration;
> -
>  struct VFIOGroup;
>
>  typedef struct VFIOContainer {
> @@ -136,6 +97,7 @@ typedef struct VFIOIOMMUFDContainer {
>  OBJECT_DECLARE_SIMPLE_TYPE(VFIOIOMMUFDContainer, VFIO_IOMMU_IOMMUFD);
>
>  typedef struct VFIODeviceOps VFIODeviceOps;
> +typedef struct VFIOMigration VFIOMigration;
>
>  typedef struct VFIODevice {
>      QLIST_ENTRY(VFIODevice) next;
> @@ -290,12 +252,6 @@ extern VFIODeviceList vfio_device_list;
>  extern const MemoryListener vfio_memory_listener;
>  extern int vfio_kvm_device_fd;
>
> -bool vfio_device_state_is_running(VFIODevice *vbasedev);
> -bool vfio_device_state_is_precopy(VFIODevice *vbasedev);
> -
> -int vfio_save_device_config_state(QEMUFile *f, void *opaque, Error **err=
p);
> -int vfio_load_device_config_state(QEMUFile *f, void *opaque);
> -
>  #ifdef CONFIG_LINUX
>  int vfio_get_region_info(VFIODevice *vbasedev, int index,
>                           struct vfio_region_info **info);
> @@ -310,16 +266,8 @@ struct vfio_info_cap_header *
>  vfio_get_device_info_cap(struct vfio_device_info *info, uint16_t id);
>  struct vfio_info_cap_header *
>  vfio_get_cap(void *ptr, uint32_t cap_offset, uint16_t id);
> -
> -int vfio_migration_set_state(VFIODevice *vbasedev,
> -                             enum vfio_device_mig_state new_state,
> -                             enum vfio_device_mig_state recover_state,
> -                             Error **errp);
>  #endif
>
> -bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp);
> -void vfio_migration_exit(VFIODevice *vbasedev);
> -
>  int vfio_bitmap_alloc(VFIOBitmap *vbmap, hwaddr size);
>  bool vfio_devices_all_dirty_tracking_started(
>      const VFIOContainerBase *bcontainer);
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 0b9b071cd0490867bb6aa4ceb261350ccd6e1125..0e3746eddd1c08e98bf57a59d=
542e158487d346e 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -44,6 +44,7 @@
>  #include "migration/qemu-file.h"
>  #include "system/tcg.h"
>  #include "system/tpm.h"
> +#include "migration.h"
>
>  VFIODeviceList vfio_device_list =3D
>      QLIST_HEAD_INITIALIZER(vfio_device_list);
> @@ -72,22 +73,6 @@ static void vfio_set_migration_error(int ret)
>      }
>  }
>
> -bool vfio_device_state_is_running(VFIODevice *vbasedev)
> -{
> -    VFIOMigration *migration =3D vbasedev->migration;
> -
> -    return migration->device_state =3D=3D VFIO_DEVICE_STATE_RUNNING ||
> -           migration->device_state =3D=3D VFIO_DEVICE_STATE_RUNNING_P2P;
> -}
> -
> -bool vfio_device_state_is_precopy(VFIODevice *vbasedev)
> -{
> -    VFIOMigration *migration =3D vbasedev->migration;
> -
> -    return migration->device_state =3D=3D VFIO_DEVICE_STATE_PRE_COPY ||
> -           migration->device_state =3D=3D VFIO_DEVICE_STATE_PRE_COPY_P2P=
;
> -}
> -
>  static bool vfio_devices_all_device_dirty_tracking_started(
>      const VFIOContainerBase *bcontainer)
>  {
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 42c8412bbf50724dddb43f9b19a3aa40c8bc311d..2fb2a01ec6d29dbc284cfd983=
0c24e78ce560dd0 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -25,6 +25,7 @@
>  #include "qemu/cutils.h"
>  #include "qemu/chardev_open.h"
>  #include "pci.h"
> +#include "migration.h"
>
>  static int iommufd_cdev_map(const VFIOContainerBase *bcontainer, hwaddr =
iova,
>                              ram_addr_t size, void *vaddr, bool readonly)
> diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
> index fe84735ec2c7bd085820d25c06be558761fbe0d5..285f9a9a18dd8f0847ac5ac3f=
daa304779a2d0db 100644
> --- a/hw/vfio/migration-multifd.c
> +++ b/hw/vfio/migration-multifd.c
> @@ -22,6 +22,7 @@
>  #include "io/channel-buffer.h"
>  #include "migration/qemu-file.h"
>  #include "migration-multifd.h"
> +#include "migration.h"
>  #include "trace.h"
>
>  #define VFIO_DEVICE_STATE_CONFIG_STATE (1)
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index a1ba993ce549fce0d2a9a60ba07d4782c87c0c09..46c4cfecce25ba1146a1d8f2d=
e0d7c51425afe8e 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -31,6 +31,7 @@
>  #include "pci.h"
>  #include "trace.h"
>  #include "hw/hw.h"
> +#include "migration.h"
>
>  /*
>   * This is an arbitrary size based on migration of mlx5 devices, where t=
ypically
> @@ -1222,3 +1223,19 @@ void vfio_migration_exit(VFIODevice *vbasedev)
>
>      migrate_del_blocker(&vbasedev->migration_blocker);
>  }
> +
> +bool vfio_device_state_is_running(VFIODevice *vbasedev)
> +{
> +    VFIOMigration *migration =3D vbasedev->migration;
> +
> +    return migration->device_state =3D=3D VFIO_DEVICE_STATE_RUNNING ||
> +           migration->device_state =3D=3D VFIO_DEVICE_STATE_RUNNING_P2P;
> +}
> +
> +bool vfio_device_state_is_precopy(VFIODevice *vbasedev)
> +{
> +    VFIOMigration *migration =3D vbasedev->migration;
> +
> +    return migration->device_state =3D=3D VFIO_DEVICE_STATE_PRE_COPY ||
> +           migration->device_state =3D=3D VFIO_DEVICE_STATE_PRE_COPY_P2P=
;
> +}
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 7f1532fbed9aed2eae2c98f6fd79a9056ff1e84f..3612f6fe7d0864fe3789f4ea2=
21da01ef87d0664 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -44,6 +44,7 @@
>  #include "migration/blocker.h"
>  #include "migration/qemu-file.h"
>  #include "system/iommufd.h"
> +#include "migration.h"
>
>  #define TYPE_VFIO_PCI_NOHOTPLUG "vfio-pci-nohotplug"
>

* Change looks okay. The header name 'migration.h' is rather generic,
vfio-migration.h could be better. Looking at - #include "migration.h"
- it is not clear which migration.h is being included. There is also a
migration/migration.h header. But I'll leave that to you. (just
sharing thoughts)

Reviewed by: Prasad Pandit <pjp@fedoraproject.org>

Thank you.
---
  - Prasad


