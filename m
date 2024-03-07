Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB062C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 09:05:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ri9gN-0006nI-0f; Thu, 07 Mar 2024 04:04:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1ri9g7-0006jr-4d
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 04:04:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1ri9g5-0007hn-78
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 04:04:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709802276;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G9KoXs/AdIIj6k7xcxxQYX166j+9j4JSvpO597fJrAA=;
 b=G3X4ULyz9zOLeYCpf/QEX/yjToOK934yw88AsIat7XUkTIVzgIzUsB+8GknOMsPwf2uVPK
 k6uj0T42iyhj1Xhuov1Svnalz6NNlGNyCozKP+AD/zo+ubHqZsaXYxH9HLAlTLNh9bXCMU
 ekBV/g59qgzMJuQg/Us7rXEbA7nNLFA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518--Q0tDj8yOmSECKr_HuAUmg-1; Thu, 07 Mar 2024 04:04:34 -0500
X-MC-Unique: -Q0tDj8yOmSECKr_HuAUmg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-33e43979853so376085f8f.1
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 01:04:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709802273; x=1710407073;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G9KoXs/AdIIj6k7xcxxQYX166j+9j4JSvpO597fJrAA=;
 b=TK94zkF4qqneATtaDrIruiTywkHYBSTP68fDCGJHeXRljVl5+1KYftE+NRsbM27+ky
 D1nlvfKWASmdqk+bp9YLJNgsrMO5pz7H9GgaUUg+M2cCw+Y8tIrxKFKxjTEB1JD6GcZf
 f4S1t1Jp/ek+3Vc2iOFSE/6T74NGTbyXUM7GTbVFdjfUGnZ6lwDNjxBayysEIwc9FXJl
 sY5upW6B/rYD9MSVFCcSESEeOgvETfe1nZKx5eYn+NHrhLeii2kvDK5mcmchSED4kpm/
 85Q+K+tpdRG+wrH4F4RVjl32/MWpb7pwEudNvlnA+X39d6hkGiVAipa2SmAtawAyLDtU
 I+Vg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPuKG2FwUsv9DGktJTWMjUbR4JRNhmx7h7pYmthkvWFjAGFXTWjrRZ7TsAJjY49afE8E+tbK5p2eXLYajzjHNT5S0svfw=
X-Gm-Message-State: AOJu0YzLxAO0riB08qy/uXuVK95mV1shMnHMWYuqB4kGxyshaSlWirRx
 iWPsYbRbKeZ38RV03k+xDq9MolipXAYNOMnFZBPWF+oHlP0aM0cmUdPcqubd4LHff8S5N4tGz4n
 pkkLGxq88Uf8YZ+R0p5z/AVOeO9FPJ9V34c5NoEAR9AzrIk2g1/GI
X-Received: by 2002:a05:600c:190a:b0:412:c9e7:202d with SMTP id
 j10-20020a05600c190a00b00412c9e7202dmr12272789wmq.6.1709802273401; 
 Thu, 07 Mar 2024 01:04:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHEt4Jm7av4TZ8LeM0J0vBLZhNNJuSyEuTk3n8nd+QZVzbU7RoMCqio2JitCTKMBUTaYzJqyw==
X-Received: by 2002:a05:600c:190a:b0:412:c9e7:202d with SMTP id
 j10-20020a05600c190a00b00412c9e7202dmr12272766wmq.6.1709802272991; 
 Thu, 07 Mar 2024 01:04:32 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 x3-20020a5d6503000000b0033e206a0a7asm16479827wru.26.2024.03.07.01.04.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Mar 2024 01:04:32 -0800 (PST)
Message-ID: <e930ebf3-6aa7-43be-8a24-a544361a8df5@redhat.com>
Date: Thu, 7 Mar 2024 10:04:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 19/25] vfio: Use new Error** argument in
 vfio_save_setup()
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>
References: <20240306133441.2351700-1-clg@redhat.com>
 <20240306133441.2351700-20-clg@redhat.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20240306133441.2351700-20-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eauger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.365,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Cédric,

On 3/6/24 14:34, Cédric Le Goater wrote:
> Add an Error** argument to vfio_migration_set_state() and adjust
> callers, including vfio_save_setup(). The error will be propagated up
> to qemu_savevm_state_setup() where the save_setup() handler is
> executed.
> 
> Modify vfio_vmstate_change_prepare() and vfio_vmstate_change() to
> store a reported error under the migration stream if a migration is in
> progress.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
> 
>  Changes in v3:
> 
>  - Use error_setg_errno() in vfio_save_setup() 
>  - Made sure an error is always set in case of failure in
>    vfio_load_setup()
>    
>  hw/vfio/migration.c | 67 ++++++++++++++++++++++++++-------------------
>  1 file changed, 39 insertions(+), 28 deletions(-)
> 
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index a3bb1a92ba0b9c2c585efe54cfda0b774a81dcb9..71ade14a7942358094371a86c00718f5979113ea 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -84,7 +84,8 @@ static const char *mig_state_to_str(enum vfio_device_mig_state state)
>  
>  static int vfio_migration_set_state(VFIODevice *vbasedev,
>                                      enum vfio_device_mig_state new_state,
> -                                    enum vfio_device_mig_state recover_state)
> +                                    enum vfio_device_mig_state recover_state,
> +                                    Error **errp)
>  {
>      VFIOMigration *migration = vbasedev->migration;
>      uint64_t buf[DIV_ROUND_UP(sizeof(struct vfio_device_feature) +
> @@ -104,15 +105,15 @@ static int vfio_migration_set_state(VFIODevice *vbasedev,
>          ret = -errno;
>  
>          if (recover_state == VFIO_DEVICE_STATE_ERROR) {
> -            error_report("%s: Failed setting device state to %s, err: %s. "
> -                         "Recover state is ERROR. Resetting device",
> -                         vbasedev->name, mig_state_to_str(new_state),
> -                         strerror(errno));
> +            error_setg(errp, "%s: Failed setting device state to %s, err: %s. "
> +                       "Recover state is ERROR. Resetting device",
> +                       vbasedev->name, mig_state_to_str(new_state),
> +                       strerror(errno));
you can use the error_setg_errno variant here and below.
>  
>              goto reset_device;
>          }
>  
> -        error_report(
> +        error_setg(errp,
>              "%s: Failed setting device state to %s, err: %s. Setting device in recover state %s",
>                       vbasedev->name, mig_state_to_str(new_state),
>                       strerror(errno), mig_state_to_str(recover_state));
> @@ -120,7 +121,7 @@ static int vfio_migration_set_state(VFIODevice *vbasedev,
>          mig_state->device_state = recover_state;
>          if (ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature)) {
>              ret = -errno;
> -            error_report(
> +            error_setg(errp,
>                  "%s: Failed setting device in recover state, err: %s. Resetting device",
>                           vbasedev->name, strerror(errno));
>  
> @@ -139,7 +140,7 @@ static int vfio_migration_set_state(VFIODevice *vbasedev,
>               * This can happen if the device is asynchronously reset and
>               * terminates a data transfer.
>               */
> -            error_report("%s: data_fd out of sync", vbasedev->name);
> +            error_setg(errp, "%s: data_fd out of sync", vbasedev->name);
>              close(mig_state->data_fd);
>  
>              return -EBADF;
> @@ -170,10 +171,11 @@ reset_device:
>   */
>  static int
>  vfio_migration_set_state_or_reset(VFIODevice *vbasedev,
> -                                  enum vfio_device_mig_state new_state)
> +                                  enum vfio_device_mig_state new_state,
> +                                  Error **errp)
>  {
>      return vfio_migration_set_state(vbasedev, new_state,
> -                                    VFIO_DEVICE_STATE_ERROR);
> +                                    VFIO_DEVICE_STATE_ERROR, errp);
>  }
>  
>  static int vfio_load_buffer(QEMUFile *f, VFIODevice *vbasedev,
> @@ -401,10 +403,8 @@ static int vfio_save_setup(QEMUFile *f, void *opaque, Error **errp)
>          switch (migration->device_state) {
>          case VFIO_DEVICE_STATE_RUNNING:
>              ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_PRE_COPY,
> -                                           VFIO_DEVICE_STATE_RUNNING);
> +                                           VFIO_DEVICE_STATE_RUNNING, errp);
>              if (ret) {
> -                error_setg(errp, "%s: Failed to set new PRE_COPY state",
> -                           vbasedev->name);
>                  return ret;
>              }
>  
> @@ -437,13 +437,20 @@ static void vfio_save_cleanup(void *opaque)
>  {
>      VFIODevice *vbasedev = opaque;
>      VFIOMigration *migration = vbasedev->migration;
> +    Error *local_err = NULL;
> +    int ret;
>  
>      /*
>       * Changing device state from STOP_COPY to STOP can take time. Do it here,
>       * after migration has completed, so it won't increase downtime.
>       */
>      if (migration->device_state == VFIO_DEVICE_STATE_STOP_COPY) {
> -        vfio_migration_set_state_or_reset(vbasedev, VFIO_DEVICE_STATE_STOP);
> +        ret = vfio_migration_set_state_or_reset(vbasedev,
> +                                                VFIO_DEVICE_STATE_STOP,
> +                                                &local_err);
> +        if (ret) {
> +            error_report_err(local_err);
> +        }
>      }
>  
>      g_free(migration->data_buffer);
> @@ -549,11 +556,13 @@ static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
>      VFIODevice *vbasedev = opaque;
>      ssize_t data_size;
>      int ret;
> +    Error *local_err = NULL;
>  
>      /* We reach here with device state STOP or STOP_COPY only */
>      ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_STOP_COPY,
> -                                   VFIO_DEVICE_STATE_STOP);
> +                                   VFIO_DEVICE_STATE_STOP, &local_err);
>      if (ret) {
> +        error_report_err(local_err);
>          return ret;
>      }
>  
> @@ -591,14 +600,9 @@ static void vfio_save_state(QEMUFile *f, void *opaque)
>  static int vfio_load_setup(QEMUFile *f, void *opaque, Error **errp)
>  {
>      VFIODevice *vbasedev = opaque;
> -    int ret;
>  
> -    ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_RESUMING,
> -                                   vbasedev->migration->device_state);
> -    if (ret) {
> -        error_setg(errp, "%s: Failed to set RESUMING state", vbasedev->name);
> -    }
> -    return ret;
> +    return vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_RESUMING,
> +                                    vbasedev->migration->device_state, errp);
>  }
>  
>  static int vfio_load_cleanup(void *opaque)
> @@ -714,20 +718,22 @@ static void vfio_vmstate_change_prepare(void *opaque, bool running,
>      VFIODevice *vbasedev = opaque;
>      VFIOMigration *migration = vbasedev->migration;
>      enum vfio_device_mig_state new_state;
> +    Error *local_err = NULL;
>      int ret;
>  
>      new_state = migration->device_state == VFIO_DEVICE_STATE_PRE_COPY ?
>                      VFIO_DEVICE_STATE_PRE_COPY_P2P :
>                      VFIO_DEVICE_STATE_RUNNING_P2P;
>  
> -    ret = vfio_migration_set_state_or_reset(vbasedev, new_state);
> +    ret = vfio_migration_set_state_or_reset(vbasedev, new_state, &local_err);
>      if (ret) {
>          /*
>           * Migration should be aborted in this case, but vm_state_notify()
>           * currently does not support reporting failures.
>           */
if ret and we do not enter the condition below, we may leak the
local_err. Same below.

Eric
>          if (migrate_get_current()->to_dst_file) {
> -            qemu_file_set_error(migrate_get_current()->to_dst_file, ret);
> +            qemu_file_set_error_obj(migrate_get_current()->to_dst_file, ret,
> +                                    local_err);
>          }
>      }
>  
> @@ -740,6 +746,7 @@ static void vfio_vmstate_change(void *opaque, bool running, RunState state)
>  {
>      VFIODevice *vbasedev = opaque;
>      enum vfio_device_mig_state new_state;
> +    Error *local_err = NULL;
>      int ret;
>  
>      if (running) {
> @@ -752,14 +759,15 @@ static void vfio_vmstate_change(void *opaque, bool running, RunState state)
>                  VFIO_DEVICE_STATE_STOP;
>      }
>  
> -    ret = vfio_migration_set_state_or_reset(vbasedev, new_state);
> +    ret = vfio_migration_set_state_or_reset(vbasedev, new_state, &local_err);
>      if (ret) {
>          /*
>           * Migration should be aborted in this case, but vm_state_notify()
>           * currently does not support reporting failures.
>           */
>          if (migrate_get_current()->to_dst_file) {
> -            qemu_file_set_error(migrate_get_current()->to_dst_file, ret);
> +            qemu_file_set_error_obj(migrate_get_current()->to_dst_file, ret,
> +                                    local_err);
>          }
>      }
>  
> @@ -773,13 +781,16 @@ static int vfio_migration_state_notifier(NotifierWithReturn *notifier,
>      VFIOMigration *migration = container_of(notifier, VFIOMigration,
>                                              migration_state);
>      VFIODevice *vbasedev = migration->vbasedev;
> +    int ret = 0;
>  
>      trace_vfio_migration_state_notifier(vbasedev->name, e->type);
>  
>      if (e->type == MIG_EVENT_PRECOPY_FAILED) {
> -        vfio_migration_set_state_or_reset(vbasedev, VFIO_DEVICE_STATE_RUNNING);
> +        ret = vfio_migration_set_state_or_reset(vbasedev,
> +                                                VFIO_DEVICE_STATE_RUNNING,
> +                                                errp);
>      }
> -    return 0;
> +    return ret;
>  }
>  
>  static void vfio_migration_free(VFIODevice *vbasedev)


