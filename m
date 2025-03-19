Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF9B5C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 12:13:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tusI3-0003EH-7D; Wed, 19 Mar 2025 08:12:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tusHz-0003Dg-Hu
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 08:12:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tusHw-0007S9-Oe
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 08:12:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742386367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wFrWV6/ZTryU3UJWkN0w4g7DOGi06lbLi0C/vA45Ugc=;
 b=BjjEANvEBC9zf/0J4WcwmZ9uah72sseCUCQGIc3Jxf4IOj27j1bGfprcQPb4vF5+qkvsnQ
 qK/TKc+7MalTwr0ENXl19TU+ENoDOxNcmNDyP7vF2QJ2GAn/jXsZr/7GevtyxyRbA6Vup8
 H6g6CZlxpBg3VtHW8q0EwPpoXvJCohQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-nPLl53bgPAiaj4jgoOjQug-1; Wed, 19 Mar 2025 08:12:43 -0400
X-MC-Unique: nPLl53bgPAiaj4jgoOjQug-1
X-Mimecast-MFC-AGG-ID: nPLl53bgPAiaj4jgoOjQug_1742386363
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43d08915f61so25106115e9.2
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 05:12:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742386362; x=1742991162;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wFrWV6/ZTryU3UJWkN0w4g7DOGi06lbLi0C/vA45Ugc=;
 b=pEW8e4P9N1m6NShSXEknSjo/x1AzjSDYcBWLODM9Bzkyx82B2xgE7/UACMR2aVTN2s
 egAr/LODxXaSW8Loa3ZcB+N3PHHtgy9aToGCmM6s8DuCDvsSG+whI/ym+XQA6uV92ujV
 CZggaLkjeljEYGTd8l/2DYkRZ0HHRZXyZAI6eRziB0TrUX1jsXdrimQFbVV0/1qwaPAN
 /UE9NEkuQ9BD5I6cNyhQiy+I+r4cShggwZ+NcwgDfIu+UsrosCQLn8qRhV8r/4LX+JBZ
 L7u8naI80IO9oXBdOyuERRDwV7RzxhiTjsOKlDVMO1CG84957UkU1PFW72P4jnrd6Dp1
 Lp6Q==
X-Gm-Message-State: AOJu0YwMU/a2UbBvQHA4pXVXAUpAZWQrYBTIrrJo12EhUmcTSjH1xvBK
 r6M5EeLfatVTlg2ToL8oKV6YhLio7WeY/dpr8G30dyTrG+ZfXXv6dXm27vco74Ttiz5dVxc4loS
 mjel777U4skri23GSho+kW1zXh6jF76jJLn+QtJ14wT45um4oP37/pS5ggzCDe6evC7RzaEIaOH
 sWKbqUlq2i4yt9rEvUiYKMVg5Aips=
X-Gm-Gg: ASbGnctfwkODlJrc1m5kbucbpENbSSV6JKPbeKZIe7gymiAgyjzlyoyg4A/261vEkFQ
 yxkCgmsWdkgYoSZQLdG0LxD4a2qHBA2hx/r1Be78rT16aUx+PZ/ax+r5nFN4OIXTItqiJksnwfW
 A=
X-Received: by 2002:a05:600c:5488:b0:43c:f70a:2af0 with SMTP id
 5b1f17b1804b1-43d437f360dmr27122355e9.16.1742386362420; 
 Wed, 19 Mar 2025 05:12:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEh0s9WbA0Jr80QUx/RSIoHWcg1qTXUxbPT0zFuQ31PfrdKj4cLo3h4MW62uJm4fN9mOeZDzjJdhL2mgsdADF4=
X-Received: by 2002:a05:600c:5488:b0:43c:f70a:2af0 with SMTP id
 5b1f17b1804b1-43d437f360dmr27122025e9.16.1742386361993; Wed, 19 Mar 2025
 05:12:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250318095415.670319-1-clg@redhat.com>
 <20250318095415.670319-26-clg@redhat.com>
In-Reply-To: <20250318095415.670319-26-clg@redhat.com>
From: Prasad Pandit <ppandit@redhat.com>
Date: Wed, 19 Mar 2025 17:42:25 +0530
X-Gm-Features: AQ5f1JquKl4WuvTfArd6oS66jSNhKd4ZZNIjet2HgQFh5PfVShdhlbeshi7bDHs
Message-ID: <CAE8KmOyBghHqFSmW-vbQfe1zvDkDJ8Dkq1FgUdZHXt4dGO9vLA@mail.gmail.com>
Subject: Re: [PATCH for-10.1 25/32] vfio: Move vfio_set_migration_error() into
 migration.c
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, 
 Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>, 
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, 18 Mar 2025 at 15:29, C=C3=A9dric Le Goater <clg@redhat.com> wrote:
> This routine is related to VFIO migration. It belongs to "migration.c".
> While at it, rename it to better reflect the namespace it belongs to.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
> ---
>  hw/vfio/migration.h      |  1 +
>  hw/vfio/dirty-tracking.c | 19 +++++--------------
>  hw/vfio/migration.c      |  7 +++++++
>  3 files changed, 13 insertions(+), 14 deletions(-)
>
> diff --git a/hw/vfio/migration.h b/hw/vfio/migration.h
> index 7ad2141d06a7c97f034db908f9ce19fd06f415b9..9b57d7dc1a6c6143c19e1ee85=
807d036b1363624 100644
> --- a/hw/vfio/migration.h
> +++ b/hw/vfio/migration.h
> @@ -68,5 +68,6 @@ int vfio_migration_set_state(VFIODevice *vbasedev,
>                               enum vfio_device_mig_state recover_state,
>                               Error **errp);
>  #endif
> +void vfio_migration_set_error(int ret);
>
>  #endif /* HW_VFIO_MIGRATION_H */
> diff --git a/hw/vfio/dirty-tracking.c b/hw/vfio/dirty-tracking.c
> index 441f9d9a08c06a88dda44ef143dcee5f0a89a900..447e09ed84993e3fbe1ed9b27=
a8269a9f0f46339 100644
> --- a/hw/vfio/dirty-tracking.c
> +++ b/hw/vfio/dirty-tracking.c
> @@ -35,8 +35,6 @@
>  #include "system/runstate.h"
>  #include "trace.h"
>  #include "qapi/error.h"
> -#include "migration/misc.h"
> -#include "migration/qemu-file.h"
>  #include "system/tcg.h"
>  #include "system/tpm.h"
>  #include "migration.h"
> @@ -47,13 +45,6 @@
>   * Device state interfaces
>   */
>
> -static void vfio_set_migration_error(int ret)
> -{
> -    if (migration_is_running()) {
> -        migration_file_set_error(ret, NULL);
> -    }
> -}
> -
>  static bool vfio_devices_all_device_dirty_tracking_started(
>      const VFIOContainerBase *bcontainer)
>  {
> @@ -175,7 +166,7 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, I=
OMMUTLBEntry *iotlb)
>      if (iotlb->target_as !=3D &address_space_memory) {
>          error_report("Wrong target AS \"%s\", only system memory is allo=
wed",
>                       iotlb->target_as->name ? iotlb->target_as->name : "=
none");
> -        vfio_set_migration_error(-EINVAL);
> +        vfio_migration_set_error(-EINVAL);
>          return;
>      }
>
> @@ -212,7 +203,7 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, I=
OMMUTLBEntry *iotlb)
>                           "0x%"HWADDR_PRIx") =3D %d (%s)",
>                           bcontainer, iova,
>                           iotlb->addr_mask + 1, ret, strerror(-ret));
> -            vfio_set_migration_error(ret);
> +            vfio_migration_set_error(ret);
>          }
>      }
>  out:
> @@ -995,7 +986,7 @@ static void vfio_listener_log_global_stop(MemoryListe=
ner *listener)
>          error_prepend(&local_err,
>                        "vfio: Could not stop dirty page tracking - ");
>          error_report_err(local_err);
> -        vfio_set_migration_error(ret);
> +        vfio_migration_set_error(ret);
>      }
>  }
>
> @@ -1137,7 +1128,7 @@ out_unlock:
>
>  out:
>      if (ret) {
> -        vfio_set_migration_error(ret);
> +        vfio_migration_set_error(ret);
>      }
>  }
>
> @@ -1271,7 +1262,7 @@ static void vfio_listener_log_sync(MemoryListener *=
listener,
>          ret =3D vfio_sync_dirty_bitmap(bcontainer, section, &local_err);
>          if (ret) {
>              error_report_err(local_err);
> -            vfio_set_migration_error(ret);
> +            vfio_migration_set_error(ret);
>          }
>      }
>  }
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 46c4cfecce25ba1146a1d8f2de0d7c51425afe8e..6fd825e435bde96d1008ec03d=
faba25db3b616fc 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -1239,3 +1239,10 @@ bool vfio_device_state_is_precopy(VFIODevice *vbas=
edev)
>      return migration->device_state =3D=3D VFIO_DEVICE_STATE_PRE_COPY ||
>             migration->device_state =3D=3D VFIO_DEVICE_STATE_PRE_COPY_P2P=
;
>  }
> +
> +void vfio_migration_set_error(int ret)
> +{
> +    if (migration_is_running()) {
> +        migration_file_set_error(ret, NULL);
> +    }
> +}
> --

* The change looks okay. But with the 'Error *err =3D NULL' parameter,
the error (ret) is also not passed on. Could we call
migration_file_set_error(ret, errp), instead of defining
'vfio_migration_set_error'? Because currently it accepts only one
'ret' parameter, later adding *errp to it would entail changing all
call sites.

Thank you.
---
  - Prasad


