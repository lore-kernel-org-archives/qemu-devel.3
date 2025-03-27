Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBEDAC3600B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 12:09:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txm26-0000Gu-Mj; Thu, 27 Mar 2025 08:08:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1txm23-0000GV-7R
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 08:08:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1txm20-0003je-4q
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 08:08:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743077291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ytR52ZsGoKKMskNDGYl79GxMTeoGnxb1II61VTEyL8E=;
 b=Lz3XpPLD19143yq6SRyNX9ZJZyLptoaGm515mwqCTdkd5y7IMZb+rZQbzW3EG948YQUNib
 R0tMiFflJwHh3QUchXKWMSPUc8ph3Wv/T3RNSnassWsuUFazOwwQRhzUo7xJpch6kkKcAV
 zam4wtn82xPmY9nB0JHuknohjgK6fVw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-aJFocHbjM2Od3wZymEl2ZQ-1; Thu, 27 Mar 2025 08:08:10 -0400
X-MC-Unique: aJFocHbjM2Od3wZymEl2ZQ-1
X-Mimecast-MFC-AGG-ID: aJFocHbjM2Od3wZymEl2ZQ_1743077290
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43ceeaf1524so4721065e9.1
 for <qemu-devel@nongnu.org>; Thu, 27 Mar 2025 05:08:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743077284; x=1743682084;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ytR52ZsGoKKMskNDGYl79GxMTeoGnxb1II61VTEyL8E=;
 b=J3+djYMCq9CU16xGiAr8hlhYTTjAr7Q1twtM/sHczUMg4VGGfhwSg8NBigqW4Aq+Zd
 W8G15QjQTZSd0NhlV0mfvorA/c3kd9zEOhxI3EjISvuzoctHM9oO90tI7+vsQTUunsxq
 NccIEkRuQS4eDXhgMznVsmksug4pfhXsogg+gdhceIPI5u+zWrj9fZnFtusAglqMCQnY
 qUEvKi3Yj3CMGGMicL/z3lRwSWPQyq2HXO2X6k0uVLQ5I4OOVlzZEbri6h6TNe4znwRn
 S3h/FMMEBGeq2rIQ/cOE+uWL3ZypNikgZFuqQCVwixRQWWOLEZNYlmzHc6mB2Ouv52oS
 qoEg==
X-Gm-Message-State: AOJu0Yzdi3vbuZlCXpJUrCmXclWAxhxu9Gs2uK6hvKmk83leJQEqICcC
 0c7kMzez5hJ11rsl72WKY4IT8aujX04yv0B/EJRIKh+VR/kDHwLdfWb2yFGjXGG3B2ozj1YsZg1
 TJb8ECb0CI/JlXxzjEophcbNQxqDO+3P+VKVjQYdkH16fccUA11eVY6O3sHnpoakCSXcs+mrqw4
 QwZ0WykwZdtIhMWfmGvUSCkWmbWQA=
X-Gm-Gg: ASbGncuHQeBypDeaekuMeR3vSml6Rz4Yiuk4zGjoWOT3CaRWKjo1OqP6zHjSpQBe6G9
 3Qq0aK8N9LIITDi0ocrsKvaktak2I/Ym+jvLVPVRVgZpBRg7gpWBwcE1bXqqEuzu912lb/kPBT+
 U=
X-Received: by 2002:a7b:c019:0:b0:439:873a:1114 with SMTP id
 5b1f17b1804b1-43d849af83amr24483985e9.6.1743077284504; 
 Thu, 27 Mar 2025 05:08:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFY6n4u9QfILk6WCLdXDKUbUwjFws+rlEWcW9zFaHQ6ZXrkhzaHsXu1ADc4y11q/l9w2wNFZV6f70LXCWNeHk0=
X-Received: by 2002:a7b:c019:0:b0:439:873a:1114 with SMTP id
 5b1f17b1804b1-43d849af83amr24483715e9.6.1743077284009; Thu, 27 Mar 2025
 05:08:04 -0700 (PDT)
MIME-Version: 1.0
References: <20250326075122.1299361-1-clg@redhat.com>
 <20250326075122.1299361-4-clg@redhat.com>
In-Reply-To: <20250326075122.1299361-4-clg@redhat.com>
From: Prasad Pandit <ppandit@redhat.com>
Date: Thu, 27 Mar 2025 17:37:47 +0530
X-Gm-Features: AQ5f1JoyMUQw38KWkltuR_HhF4F9IbwEHrvEB9PFv8ozHMTrKpAnvT2iWgVdxFE
Message-ID: <CAE8KmOxcLbYBJ+Jb_R8Orw7aAXbYGWme6eDXFjUvLL=Dbz+79A@mail.gmail.com>
Subject: Re: [PATCH for-10.1 v2 03/37] vfio: Introduce a new header file for
 external migration services
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, 26 Mar 2025 at 13:24, C=C3=A9dric Le Goater <clg@redhat.com> wrote:
> The migration core subsystem makes use of the VFIO migration API to
> collect statistics on the number of bytes transferred. These services
> are declared in "hw/vfio/vfio-common.h" which also contains VFIO
> internal declarations. Move the migration declarations into a new
> header file "hw/vfio/vfio-migration.h" to reduce the exposure of VFIO
> internals.
>
> While at it, use a 'vfio_migration_' prefix for these services.
>
> To be noted, vfio_migration_add_bytes_transferred() is a VFIO
> migration internal service which we will moved in the subsequent
> patches.

* Small nitpick:  ...we will move  OR  ...will be moved

> diff --git a/include/hw/vfio/vfio-migration.h b/include/hw/vfio/vfio-migr=
ation.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..0d4ecd33d5d8c214bb77e0652=
b4405b6e43bcafa
> --- /dev/null
> +++ b/include/hw/vfio/vfio-migration.h
> @@ -0,0 +1,16 @@
> +/*
> + * VFIO migration interface
> + *
> + * Copyright Red Hat, Inc. 2025
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_VFIO_VFIO_MIGRATION_H
> +#define HW_VFIO_VFIO_MIGRATION_H
> +
> +bool vfio_migration_active(void);
> +int64_t vfio_migration_bytes_transferred(void);
> +void vfio_migration_reset_bytes_transferred(void);
> +
> +#endif /* HW_VFIO_VFIO_MIGRATION_H */
> diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
> index 378f6f3bf01f6a4155fb424f8028cb5380f27f02..09aa57f5f890f37f7e36c857f=
d813f55b1da2fce 100644
> --- a/hw/vfio/migration-multifd.c
> +++ b/hw/vfio/migration-multifd.c
> @@ -11,6 +11,7 @@
>
>  #include "qemu/osdep.h"
>  #include "hw/vfio/vfio-common.h"
> +#include "hw/vfio/vfio-migration.h"
>  #include "migration/misc.h"
>  #include "qapi/error.h"
>  #include "qemu/bswap.h"
> @@ -575,7 +576,7 @@ vfio_save_complete_precopy_thread_config_state(VFIODe=
vice *vbasedev,
>          return false;
>      }
>
> -    vfio_mig_add_bytes_transferred(packet_len);
> +    vfio_migration_add_bytes_transferred(packet_len);
>
>      return true;
>  }
> @@ -645,7 +646,7 @@ vfio_multifd_save_complete_precopy_thread(SaveLiveCom=
pletePrecopyThreadData *d,
>              goto thread_exit;
>          }
>
> -        vfio_mig_add_bytes_transferred(packet_size);
> +        vfio_migration_add_bytes_transferred(packet_size);
>      }
>
>      if (!vfio_save_complete_precopy_thread_config_state(vbasedev,
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 8bf65b8e11094b8363692dba3084b762362c7dd6..582d65932a6c590eaecd8bf0b=
765f27d93896c72 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -17,6 +17,7 @@
>
>  #include "system/runstate.h"
>  #include "hw/vfio/vfio-common.h"
> +#include "hw/vfio/vfio-migration.h"
>  #include "migration/misc.h"
>  #include "migration/savevm.h"
>  #include "migration/vmstate.h"
> @@ -373,7 +374,7 @@ static ssize_t vfio_save_block(QEMUFile *f, VFIOMigra=
tion *migration)
>      qemu_put_be64(f, VFIO_MIG_FLAG_DEV_DATA_STATE);
>      qemu_put_be64(f, data_size);
>      qemu_put_buffer(f, migration->data_buffer, data_size);
> -    vfio_mig_add_bytes_transferred(data_size);
> +    vfio_migration_add_bytes_transferred(data_size);
>
>      trace_vfio_save_block(migration->vbasedev->name, data_size);
>
> @@ -1047,22 +1048,22 @@ static int vfio_block_migration(VFIODevice *vbase=
dev, Error *err, Error **errp)
>
>  /* ---------------------------------------------------------------------=
- */
>
> -int64_t vfio_mig_bytes_transferred(void)
> +int64_t vfio_migration_bytes_transferred(void)
>  {
>      return MIN(qatomic_read(&bytes_transferred), INT64_MAX);
>  }
>
> -void vfio_mig_reset_bytes_transferred(void)
> +void vfio_migration_reset_bytes_transferred(void)
>  {
>      qatomic_set(&bytes_transferred, 0);
>  }
>
> -void vfio_mig_add_bytes_transferred(unsigned long val)
> +void vfio_migration_add_bytes_transferred(unsigned long val)
>  {
>      qatomic_add(&bytes_transferred, val);
>  }
>
> -bool vfio_mig_active(void)
> +bool vfio_migration_active(void)
>  {
>      VFIODevice *vbasedev;
>
> diff --git a/migration/target.c b/migration/target.c
> index f5d8cfe7c2a3473f4bd3f5068145598c60973c58..12fd399f0c521c5c28535b58f=
24feab6845947fd 100644
> --- a/migration/target.c
> +++ b/migration/target.c
> @@ -11,21 +11,21 @@
>  #include CONFIG_DEVICES
>
>  #ifdef CONFIG_VFIO
> -#include "hw/vfio/vfio-common.h"
> +#include "hw/vfio/vfio-migration.h"
>  #endif
>
>  #ifdef CONFIG_VFIO
>  void migration_populate_vfio_info(MigrationInfo *info)
>  {
> -    if (vfio_mig_active()) {
> +    if (vfio_migration_active()) {
>          info->vfio =3D g_malloc0(sizeof(*info->vfio));
> -        info->vfio->transferred =3D vfio_mig_bytes_transferred();
> +        info->vfio->transferred =3D vfio_migration_bytes_transferred();
>      }
>  }
>
>  void migration_reset_vfio_bytes_transferred(void)
>  {
> -    vfio_mig_reset_bytes_transferred();
> +    vfio_migration_reset_bytes_transferred();
>  }
>  #else
>  void migration_populate_vfio_info(MigrationInfo *info)
> --

* Looks okay.
Reviewed-by:  Prasad Pandit <pjp@fedoraproject.org>

Thank you.
---
  - Prasad


