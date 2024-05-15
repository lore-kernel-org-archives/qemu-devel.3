Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF767C25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 07:20:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s78wO-0005I5-M5; Wed, 15 May 2024 03:20:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1s78wM-0005Hw-9B
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:20:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1s78wJ-0003TJ-UE
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:20:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715757638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cxXu2nNdON7xWXQ0M2T24SqNN1Ff9/wcyAlNRPdtPFk=;
 b=EoMxwudqnIzwXc2Hxrg2yBycU83j2ex45S93H1vba9Qve3a8hwEDfNMT4tlGws9WEwGgkO
 vi6lnoUa/WTtmsOhH4JE6JrIU1FZGzTknOJ/ob7WtQ+GRk5mB38BcqQtYxYzERg3+MrwHV
 sNJ8P8GEfZJ+xh2iSiMGkT8qG93J8aQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-K7CAs85sMwGIf4pXvxFzPw-1; Wed, 15 May 2024 03:20:36 -0400
X-MC-Unique: K7CAs85sMwGIf4pXvxFzPw-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-69649f1894dso111520616d6.0
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 00:20:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715757635; x=1716362435;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cxXu2nNdON7xWXQ0M2T24SqNN1Ff9/wcyAlNRPdtPFk=;
 b=EdHWDf5+wPoR3mJt+aJyUHRkJ4pICgZqM4QIPkA5JVweXoOccFlal1lnjdEem/UXGR
 DSkWmQxlXOpcAjtuR9N3PsPMJoEjxGEVvOlPZj2+wHr3/FXIwXQ0kxKVAzcDVnTwYJNY
 5XXEJYKXtE+ZuYUh/m8YOfvNmTZfCrhegyMbFdlgikpMDTI2pT4xNFBwkuVcO9/8sSAE
 iFZfPtQgGNvCKV7vzjSFJM/MFuJqwLJI6Q0FotNhVGrA4KM1F5pH/QE4q6KREHDutSiW
 AI6nRey0nN4l0q+qoZ+qyBBYxs5B9beLpXAHLLPX8Owt73lXGBlQSl4TgRQPFaRgd/d0
 7o6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7ltf+6ptpaE2r6jbCLzHUGFzpDioMY/7WXRjzMBvUGJO7chiXVtMMw5xcHHdGg8uJBoE/qhKQzuID3ZzAF2xPXlDYRd4=
X-Gm-Message-State: AOJu0YxRMbDUGOEAhRIQ0KzByC44LprpTc2iXSK6xxIkuay7s2XpUjuy
 bcUizebZ8/QP2ZQ+6lae9eTBpQHBPlDNza5Uh53IV103Jsvga92/HXQKue/JfuuslxMieoxpUQU
 cNdJ75F6voCBcx4nNz003QnWMTNugKzlC33q7ZagbkBVATBuzBUyD
X-Received: by 2002:a05:6214:320c:b0:6a0:4255:b727 with SMTP id
 6a1803df08f44-6a16815228bmr157765396d6.9.1715757635527; 
 Wed, 15 May 2024 00:20:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnsrIStBKMO8C1cDJ3wr96fo39BtPKAKhvO7p4RFJqMukYWGO5RxfK1rjWlw03nKi8hwFXUA==
X-Received: by 2002:a05:6214:320c:b0:6a0:4255:b727 with SMTP id
 6a1803df08f44-6a16815228bmr157765226d6.9.1715757635117; 
 Wed, 15 May 2024 00:20:35 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6a15f1cd3b5sm61715016d6.82.2024.05.15.00.20.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 May 2024 00:20:34 -0700 (PDT)
Message-ID: <396a3c36-45a3-4749-88b3-439af8819965@redhat.com>
Date: Wed, 15 May 2024 09:20:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/9] vfio/migration: Add an Error** argument to
 vfio_migration_set_state()
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Markus Armbruster <armbru@redhat.com>
References: <20240514153130.394307-1-clg@redhat.com>
 <20240514153130.394307-5-clg@redhat.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20240514153130.394307-5-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eauger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Cédric,

On 5/14/24 17:31, Cédric Le Goater wrote:
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
>  Changes in v6:
> 
>  - Commit log improvements (Avihai) 
>  - vfio_migration_set_state() : Dropped the error_setg_errno() change
>    when setting device in recover state fails (Avihai)   
>  - vfio_migration_state_notifier() : report local error (Avihai) 
>    
>  Changes in v5:
> 
>  - Replaced error_setg() by error_setg_errno() in vfio_migration_set_state()
>  - Rebased on 20c64c8a51a4 ("migration: migration_file_set_error")
>  
>  hw/vfio/migration.c | 77 ++++++++++++++++++++++++++++-----------------
>  1 file changed, 48 insertions(+), 29 deletions(-)
> 
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index bf2fd0759ba6e4fb103cc5c1a43edb180a3d0de4..bf11135167ebb162dd41415656bdacfa0e1ca550 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -82,7 +82,8 @@ static const char *mig_state_to_str(enum vfio_device_mig_state state)
>  
>  static int vfio_migration_set_state(VFIODevice *vbasedev,
>                                      enum vfio_device_mig_state new_state,
> -                                    enum vfio_device_mig_state recover_state)
> +                                    enum vfio_device_mig_state recover_state,
> +                                    Error **errp)
>  {
>      VFIOMigration *migration = vbasedev->migration;
>      uint64_t buf[DIV_ROUND_UP(sizeof(struct vfio_device_feature) +
> @@ -102,18 +103,19 @@ static int vfio_migration_set_state(VFIODevice *vbasedev,
>          ret = -errno;
>  
>          if (recover_state == VFIO_DEVICE_STATE_ERROR) {
> -            error_report("%s: Failed setting device state to %s, err: %s. "
> -                         "Recover state is ERROR. Resetting device",
> -                         vbasedev->name, mig_state_to_str(new_state),
> -                         strerror(errno));
> +            error_setg_errno(errp, errno,
> +                             "%s: Failed setting device state to %s. "
> +                             "Recover state is ERROR. Resetting device",
> +                             vbasedev->name, mig_state_to_str(new_state));
nit: this may be simplified
with a first unconditional msg saying Failed setting device state to %s.
Recover state is %s.
and not duplicating the msg.

In the reset label you can prepend "resetting the device ..."
>  
>              goto reset_device;
>          }
>  
> -        error_report(
> -            "%s: Failed setting device state to %s, err: %s. Setting device in recover state %s",
> -                     vbasedev->name, mig_state_to_str(new_state),
> -                     strerror(errno), mig_state_to_str(recover_state));
> +        error_setg_errno(errp, errno,
> +                         "%s: Failed setting device state to %s. "
> +                         "Setting device in recover state %s",
> +                         vbasedev->name, mig_state_to_str(new_state),
> +                         mig_state_to_str(recover_state));>
>          mig_state->device_state = recover_state;
>          if (ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature)) {
in case you fail setting the device in recover state, your simply
error_report() and do not prepend any other msg in the error handle. Is
it what you want? In the positive, maybe worth a comment.
> @@ -137,7 +139,7 @@ static int vfio_migration_set_state(VFIODevice *vbasedev,
>               * This can happen if the device is asynchronously reset and
>               * terminates a data transfer.
>               */
> -            error_report("%s: data_fd out of sync", vbasedev->name);
> +            error_setg(errp, "%s: data_fd out of sync", vbasedev->name);
>              close(mig_state->data_fd);
>  
>              return -EBADF;
> @@ -168,10 +170,11 @@ reset_device:
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
> @@ -399,10 +402,8 @@ static int vfio_save_setup(QEMUFile *f, void *opaque, Error **errp)
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
> @@ -435,13 +436,20 @@ static void vfio_save_cleanup(void *opaque)
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
> @@ -549,11 +557,13 @@ static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
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
> @@ -591,14 +601,9 @@ static void vfio_save_state(QEMUFile *f, void *opaque)
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
> @@ -714,19 +719,20 @@ static void vfio_vmstate_change_prepare(void *opaque, bool running,
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
> -        migration_file_set_error(ret, NULL);
> +        migration_file_set_error(ret, local_err);
>      }
>  
>      trace_vfio_vmstate_change_prepare(vbasedev->name, running,
> @@ -738,6 +744,7 @@ static void vfio_vmstate_change(void *opaque, bool running, RunState state)
>  {
>      VFIODevice *vbasedev = opaque;
>      enum vfio_device_mig_state new_state;
> +    Error *local_err = NULL;
>      int ret;
>  
>      if (running) {
> @@ -750,13 +757,13 @@ static void vfio_vmstate_change(void *opaque, bool running, RunState state)
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
> -        migration_file_set_error(ret, NULL);
> +        migration_file_set_error(ret, local_err);
>      }
>  
>      trace_vfio_vmstate_change(vbasedev->name, running, RunState_str(state),
> @@ -769,11 +776,23 @@ static int vfio_migration_state_notifier(NotifierWithReturn *notifier,
>      VFIOMigration *migration = container_of(notifier, VFIOMigration,
>                                              migration_state);
>      VFIODevice *vbasedev = migration->vbasedev;
> +    Error *local_err = NULL;
> +    int ret = 0;
>  
>      trace_vfio_migration_state_notifier(vbasedev->name, e->type);
>  
>      if (e->type == MIG_EVENT_PRECOPY_FAILED) {
> -        vfio_migration_set_state_or_reset(vbasedev, VFIO_DEVICE_STATE_RUNNING);
> +        /*
> +         * MigrationNotifyFunc may return an error code and an Error
> +         * object only for MIG_EVENT_PRECOPY_SETUP. Hence, report the
> +         * error locally and ignore the errp argument.
> +         */
> +        ret = vfio_migration_set_state_or_reset(vbasedev,
> +                                                VFIO_DEVICE_STATE_RUNNING,
> +                                                &local_err);
> +        if (ret) {
> +            error_report_err(local_err);
> +        }
>      }
>      return 0;
>  }
Thanks

Eric


