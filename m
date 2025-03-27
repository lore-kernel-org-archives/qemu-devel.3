Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5C0BC3600B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 12:13:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txm6z-0001Xo-Qc; Thu, 27 Mar 2025 08:13:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1txm6i-0001Pp-8z
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 08:13:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1txm6b-0004et-Ky
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 08:13:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743077584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N7CbRHkBPwZNkdj6ARdrWWlfFj91T4WWExy3UXgtJBw=;
 b=cmcnpR7ghJLdLsF7/iXKHeF7FJUbrtA7wMKgU5SvGGWEQxG3Xai1MsSmgvCkZ2jcvy/rAI
 CnQE+UgbPdTxBW+niGlOotL5p8BeeP1iD+8M1V+/2+0tcbWu5QRrsTcRug6SIbXssWxUYk
 eBIIDZeZFHAkb5xmpjoSqEbiBmSdZiU=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-qyFVowtaMEKahN6MMKj0sA-1; Thu, 27 Mar 2025 08:13:02 -0400
X-MC-Unique: qyFVowtaMEKahN6MMKj0sA-1
X-Mimecast-MFC-AGG-ID: qyFVowtaMEKahN6MMKj0sA_1743077582
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-72b991fee31so649332a34.3
 for <qemu-devel@nongnu.org>; Thu, 27 Mar 2025 05:13:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743077582; x=1743682382;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N7CbRHkBPwZNkdj6ARdrWWlfFj91T4WWExy3UXgtJBw=;
 b=OtJb3w57hf/lJa+dsPtlFQcnvO+Cj18IZcYeLFsPduQYasGYuOqYyBlQUICrqhuYO6
 TTpyDfJ3Y6MqqEc73rF/7wTYWLr8vXPpS2XM9SOKVkkkvi1GPdCPyMnVtNAvQLIRwRfV
 ILZmZv/YofRjiaLDlkSaLvFr1lee6TPsimFoFTLGGZcIPW6Tb9grsLIQmU47hV+ZhCoD
 CFCXpmOY+pdlGbZ6jg6/WK1p/Zj0I/56wGD2BHUfUoOTHdKVX4IooiLZaKtQCw44RTXK
 zX1t0jidKzfqTDZoN9LvwI/LaHXt8UCanCu3qaYRPbalf/WrhUY8uSm+6303ndlrCDfR
 d+Yw==
X-Gm-Message-State: AOJu0Yy5+/YZjrY5qr5Xdo0BhPaw0aGkEC5CbVzKq1ybWZ90hntNHVcN
 6WzsYhD34rXkJcVz/IGbWNS7bE7HidUcA56v5WjRzLrcaAbySFtIfKSISuwM2KhjtB+jLa2mHoL
 eXk5zYKWNmhEtYiEdBXQ6CKTfxHK4Bw+YkEfpdfj8GbeXlqMXBZEJjDDJT+PaNfsyifRSJ+vmwn
 jPuY5/LL5aeACfq/rcc9cG3iexuOs=
X-Gm-Gg: ASbGncszBAiXuCqg08ZPRSDhIfGCYNB9negnSgy2UeII2ifMQAs6/XhNESDHFbHuFCY
 d1kT1WMUSXYOfNZIYRjIzSsuGBuLyA6JSsalkGAs2w9TC/D5yQQeZhkKSv4Nq5QpbOMivzfvekE
 w=
X-Received: by 2002:a05:6830:4490:b0:72b:9506:8db6 with SMTP id
 46e09a7af769-72c4c92ba87mr1981704a34.6.1743077581717; 
 Thu, 27 Mar 2025 05:13:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE68FQUv8H12I54H+/dCxFuh6KcSts72sxIesrej4jBNPAjTiDylFQ9iumhrtdRFG18CvSf1ihXamrNVyk96UE=
X-Received: by 2002:a05:6830:4490:b0:72b:9506:8db6 with SMTP id
 46e09a7af769-72c4c92ba87mr1981681a34.6.1743077581292; Thu, 27 Mar 2025
 05:13:01 -0700 (PDT)
MIME-Version: 1.0
References: <20250326075122.1299361-1-clg@redhat.com>
 <20250326075122.1299361-8-clg@redhat.com>
In-Reply-To: <20250326075122.1299361-8-clg@redhat.com>
From: Prasad Pandit <ppandit@redhat.com>
Date: Thu, 27 Mar 2025 17:42:44 +0530
X-Gm-Features: AQ5f1JqTG04iwUyNvq4SYyakHh_priLJQPWm6WBH7bnSZQCZMQXbhnF9lX0FL90
Message-ID: <CAE8KmOym3R-KNzq+evhbE1aj+x-W7m4wZt=kpONoQ95+wkF1NQ@mail.gmail.com>
Subject: Re: [PATCH for-10.1 v2 07/37] vfio: Move
 vfio_device_state_is_running/precopy() into migration.c
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, 
 Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>, 
 Zhenzhong Duan <zhenzhong.duan@intel.com>, John Levon <john.levon@nutanix.com>,
 Joao Martins <joao.m.martins@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Wed, 26 Mar 2025 at 13:22, C=C3=A9dric Le Goater <clg@redhat.com> wrote:
> These routines are migration related. Move their declaration and
> implementation under the migration files.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
> ---
>  hw/vfio/vfio-migration-internal.h |  2 ++
>  include/hw/vfio/vfio-common.h     |  3 ---
>  hw/vfio/common.c                  | 16 ----------------
>  hw/vfio/migration.c               | 16 ++++++++++++++++
>  4 files changed, 18 insertions(+), 19 deletions(-)
>
> diff --git a/hw/vfio/vfio-migration-internal.h b/hw/vfio/vfio-migration-i=
nternal.h
> index ab6a1bad9b513aa61557905e72e5c6b264372276..a8b456b239df8a54ab96daf56=
b5f778b3ffbfa5e 100644
> --- a/hw/vfio/vfio-migration-internal.h
> +++ b/hw/vfio/vfio-migration-internal.h
> @@ -57,6 +57,8 @@ typedef struct VFIOMigration {
>
>  bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp);
>  void vfio_migration_exit(VFIODevice *vbasedev);
> +bool vfio_device_state_is_running(VFIODevice *vbasedev);
> +bool vfio_device_state_is_precopy(VFIODevice *vbasedev);
>  int vfio_save_device_config_state(QEMUFile *f, void *opaque, Error **err=
p);
>  int vfio_load_device_config_state(QEMUFile *f, void *opaque);
>
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.=
h
> index 920ad154b4f82b9c244b5b9e8da44f7583e5ead0..799e12d43747addbf444c1505=
2f629b65978322f 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -252,9 +252,6 @@ extern VFIODeviceList vfio_device_list;
>  extern const MemoryListener vfio_memory_listener;
>  extern int vfio_kvm_device_fd;
>
> -bool vfio_device_state_is_running(VFIODevice *vbasedev);
> -bool vfio_device_state_is_precopy(VFIODevice *vbasedev);
> -
>  #ifdef CONFIG_LINUX
>  int vfio_get_region_info(VFIODevice *vbasedev, int index,
>                           struct vfio_region_info **info);
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 9bbd798e3e9e0b7a7620d4b1f34f1ef5e8ac42c1..33f7191c7fec76bb3f46b96e2=
5dc1872808ccc8c 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -67,22 +67,6 @@ int vfio_kvm_device_fd =3D -1;
>   */
>
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
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 2a72a8e07542096276cc7c386359ad375e7d24c8..8d69de3c80eaedf9bf4b8bc9b=
25f6d722ae619b2 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -1223,3 +1223,19 @@ void vfio_migration_exit(VFIODevice *vbasedev)
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
> --

* Looks okay.
Reviewed-by:  Prasad Pandit <pjp@fedoraproject.org>

Thank you.
---
  - Prasad


