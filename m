Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EE1CC3600B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 12:18:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txmBc-0003er-4D; Thu, 27 Mar 2025 08:18:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1txmBa-0003eO-C1
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 08:18:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1txmBX-0005Fg-GH
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 08:18:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743077889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aJHGyZAuI5hmU0L/PqpJ3U+MazVctMbq6YQd8Gl9yHg=;
 b=ijv1G3bFywmmq/C6rfAEqavTejCBzmuUpBSV7hnkUygPJEHnh8PAe9Zh5zhi+A6+VbbhiX
 DQFoG2NTCncj5N94K2McuucO8PfbUyUET+jopdJeRPRcrShbPjdzPMNCN8w/XJdWRW1uL4
 XPCNcujkQaSfV1EWNOtjm0bOHK73eB0=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-LwSxe5fyN4GoCs3jHZRlBQ-1; Thu, 27 Mar 2025 08:16:57 -0400
X-MC-Unique: LwSxe5fyN4GoCs3jHZRlBQ-1
X-Mimecast-MFC-AGG-ID: LwSxe5fyN4GoCs3jHZRlBQ_1743077816
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-6017ee6038aso1690898eaf.1
 for <qemu-devel@nongnu.org>; Thu, 27 Mar 2025 05:16:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743077815; x=1743682615;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aJHGyZAuI5hmU0L/PqpJ3U+MazVctMbq6YQd8Gl9yHg=;
 b=qXnTFz+u6NwCcXWJijP6X5uyzAke0ru8R3YTFykKpKWRFHP5BZHi3YWuk9hnAqnP89
 StmZYrv2L2fEmI6cElf21mhLc30wfj+DQoDkzhzEnA/kadQO/9Lu9077Ao8qxRZkQvpX
 urkmbmW8MyMV7wHBXVkWlqyrWVEF7yowNRNBDalJn1VhZ9LF17XAPIO8pf/byHlsEBks
 j0vcuF7T9REgScjs+LTOjzWR6BzrlTaoZgNvJ0ARFwwKjUC5I/JX8/kja+YTURK5YoBy
 JsvcI3x1C463AspUT0+YnzZJfdoDyUkLLOT4Lq0m+BzQ02pW52SPJuKRchjpytVZKFZl
 fmBA==
X-Gm-Message-State: AOJu0YxXcp50zz/POGdq5NU4pjYTsPc+gLwqWmeXK7Q4gPgCv+zl3Dey
 L1zsfLiAHWR0+r+41eCn/MeTwnNcVoFGf9xSPQQQVrKiSpMum43l9LZucLkGx/kL5C6M9r/k44t
 kX+TowBn0FE7zE9qFEenoM7/N+OFxElkSbSQ4SDXoY2vfgYEhA8Q9AGcDCHNS25P//H0B3Pmyvy
 sa7S+CiPpi8KRgy8vIo2Ogm1V4WQ2OKYbJpZffHA==
X-Gm-Gg: ASbGnctH+1utuZdIoCPv6bjW8m8dDXGRbkRRqdx9owrip12tLd8Wxj5+B87gHUITRyn
 5hY7zHVjgyiYVnpF88dlykOTGPmH3EUxBUUjRXr9tSO5O4ITdegLQbsWNtENwcZ4C3Jebop3NeC
 E=
X-Received: by 2002:a05:6870:610f:b0:2c1:2262:7941 with SMTP id
 586e51a60fabf-2c846950819mr2115257fac.16.1743077815280; 
 Thu, 27 Mar 2025 05:16:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqN6apSj/PBheYkQ1Pjze6bNVdl2JxR+V6z9gjfYFi8koFCjvpB7cO7l4Ad7R1YbbWbQHD56aGxo9HjazwD3g=
X-Received: by 2002:a05:6870:610f:b0:2c1:2262:7941 with SMTP id
 586e51a60fabf-2c846950819mr2115228fac.16.1743077814776; Thu, 27 Mar 2025
 05:16:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250326075122.1299361-1-clg@redhat.com>
 <20250326075122.1299361-7-clg@redhat.com>
In-Reply-To: <20250326075122.1299361-7-clg@redhat.com>
From: Prasad Pandit <ppandit@redhat.com>
Date: Thu, 27 Mar 2025 17:46:37 +0530
X-Gm-Features: AQ5f1Jq1C7WppYSpvqZWMB-Ihw08HTC6kb1Qv3KfdXFpIvznLhagEamlB15_kEE
Message-ID: <CAE8KmOwd2DMoA1i878BuVvPV4vwvoN5EKQQESYSsxpsDSxVvzw@mail.gmail.com>
Subject: Re: [PATCH for-10.1 v2 06/37] vfio: Introduce a new header file for
 internal migration services
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, 
 Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>, 
 Zhenzhong Duan <zhenzhong.duan@intel.com>, John Levon <john.levon@nutanix.com>,
 Joao Martins <joao.m.martins@oracle.com>, Kirti Wankhede <kwankhede@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Wed, 26 Mar 2025 at 13:32, C=C3=A9dric Le Goater <clg@redhat.com> wrote:
> Gather all VFIO migration related declarations into
> "vfio-migration-internal.h" to reduce exposure of VFIO internals in
> "hw/vfio/vfio-common.h".
>
> Cc: Kirti Wankhede <kwankhede@nvidia.com>
> Cc: Avihai Horon <avihaih@nvidia.com>
> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
> ---
>  hw/vfio/vfio-migration-internal.h | 72 +++++++++++++++++++++++++++++++
>  include/hw/vfio/vfio-common.h     | 52 +---------------------
>  hw/vfio/common.c                  |  1 +
>  hw/vfio/migration-multifd.c       |  1 +
>  hw/vfio/migration.c               |  1 +
>  hw/vfio/pci.c                     |  1 +
>  6 files changed, 77 insertions(+), 51 deletions(-)
>  create mode 100644 hw/vfio/vfio-migration-internal.h
>
> diff --git a/hw/vfio/vfio-migration-internal.h b/hw/vfio/vfio-migration-i=
nternal.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..ab6a1bad9b513aa61557905e7=
2e5c6b264372276
> --- /dev/null
> +++ b/hw/vfio/vfio-migration-internal.h
> @@ -0,0 +1,72 @@
> +/*
> + * VFIO migration
> + *
> + * Copyright Red Hat, Inc. 2025
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_VFIO_VFIO_MIGRATION_INTERNAL_H
> +#define HW_VFIO_VFIO_MIGRATION_INTERNAL_H
> +
> +#ifdef CONFIG_LINUX
> +#include <linux/vfio.h>
> +#endif
> +
> +#include "qemu/typedefs.h"
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
> +bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp);
> +void vfio_migration_exit(VFIODevice *vbasedev);
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
> +void vfio_migration_add_bytes_transferred(unsigned long val);
> +
> +#endif /* HW_VFIO_VFIO_MIGRATION_INTERNAL_H */
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.=
h
> index 8bb206d755adab4efee32a173c920d9aa4833685..920ad154b4f82b9c244b5b9e8=
da44f7583e5ead0 100644
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
> @@ -290,13 +252,9 @@ extern VFIODeviceList vfio_device_list;
>  extern const MemoryListener vfio_memory_listener;
>  extern int vfio_kvm_device_fd;
>
> -void vfio_migration_add_bytes_transferred(unsigned long val);
>  bool vfio_device_state_is_running(VFIODevice *vbasedev);
>  bool vfio_device_state_is_precopy(VFIODevice *vbasedev);
>
> -int vfio_save_device_config_state(QEMUFile *f, void *opaque, Error **err=
p);
> -int vfio_load_device_config_state(QEMUFile *f, void *opaque);
> -
>  #ifdef CONFIG_LINUX
>  int vfio_get_region_info(VFIODevice *vbasedev, int index,
>                           struct vfio_region_info **info);
> @@ -311,16 +269,8 @@ struct vfio_info_cap_header *
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
> index a4ec60e018df7dc9bbbeac27120907b0f7bf2f83..9bbd798e3e9e0b7a7620d4b1f=
34f1ef5e8ac42c1 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -44,6 +44,7 @@
>  #include "migration/qemu-file.h"
>  #include "system/tcg.h"
>  #include "system/tpm.h"
> +#include "vfio-migration-internal.h"
>
>  VFIODeviceList vfio_device_list =3D
>      QLIST_HEAD_INITIALIZER(vfio_device_list);
> diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
> index 09aa57f5f890f37f7e36c857fd813f55b1da2fce..1eba74beb0f207804e9c80935=
eacb0de19589b85 100644
> --- a/hw/vfio/migration-multifd.c
> +++ b/hw/vfio/migration-multifd.c
> @@ -22,6 +22,7 @@
>  #include "io/channel-buffer.h"
>  #include "migration/qemu-file.h"
>  #include "migration-multifd.h"
> +#include "vfio-migration-internal.h"
>  #include "trace.h"
>
>  #define VFIO_DEVICE_STATE_CONFIG_STATE (1)
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 96d294794bc3056baa3b0b4e23488402db5de797..2a72a8e07542096276cc7c386=
359ad375e7d24c8 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -31,6 +31,7 @@
>  #include "pci.h"
>  #include "trace.h"
>  #include "hw/hw.h"
> +#include "vfio-migration-internal.h"
>
>  /*
>   * This is an arbitrary size based on migration of mlx5 devices, where t=
ypically
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 7f1532fbed9aed2eae2c98f6fd79a9056ff1e84f..158deca06cb240622a254f505=
9c47873e5fcc7de 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -44,6 +44,7 @@
>  #include "migration/blocker.h"
>  #include "migration/qemu-file.h"
>  #include "system/iommufd.h"
> +#include "vfio-migration-internal.h"
>
>  #define TYPE_VFIO_PCI_NOHOTPLUG "vfio-pci-nohotplug"
>
> --

* Looks okay.
Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>

Thank you.
---
  - Prasad


