Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0D89C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 12:07:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7ZtS-0000RD-Qs; Thu, 16 May 2024 08:07:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s7ZtP-0000R2-1J
 for qemu-devel@nongnu.org; Thu, 16 May 2024 08:07:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s7ZtL-0003bp-PU
 for qemu-devel@nongnu.org; Thu, 16 May 2024 08:07:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715861243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qWafOIC4yDODJ5us2+j7/jV7p2VMw+3tB/qovutmlwA=;
 b=Llnlb3HeUVIuRJg46Z4Xug3mjeSj3RkScLWPuHx3smZPkRk12UhIwqii1woqighH+0D4R9
 NGt5ZSl2UILbUQzWEcFBhm+er8XCtkFIgpYJXNHjMbk+BYk3RvCpDCjJcewqNUso6zXQeE
 Iamsz0gGyn6XWXF20L3TXB8OmFI/c7k=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-zHhoxrohOxaMpXncb9eAyw-1; Thu, 16 May 2024 08:07:21 -0400
X-MC-Unique: zHhoxrohOxaMpXncb9eAyw-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-792ff352462so182583785a.1
 for <qemu-devel@nongnu.org>; Thu, 16 May 2024 05:07:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715861241; x=1716466041;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qWafOIC4yDODJ5us2+j7/jV7p2VMw+3tB/qovutmlwA=;
 b=hfZy9E5Q71LuaJGegDI9flUJFa8r+Xqm/edmZg8J5fSRIr1MeraZ2Q1wf7PY3yu3+0
 LNtfMq79oIZYIhjs6UwwFWdaxa2HzC9UNt63b88UYzxxaEhBCUmdSjziAr7P/yPW+GhJ
 7BzFI1CeelZUsbfb1e1V/FIMLhofGaGaNhDbvn+8WAclPSh6z5bzaQ9pJGovBeeZyGId
 wSBVSUYtXb8Sq4xi85+ADP6YQfGYtfKkQivp1rSCCCxd+olxrkzUPgKYVxFSI+rcJPYX
 YVkSkcBTeA5PAEsc17UmFJtjIwNNghUW0aT4cwwRUJGPdtq5myFzjIvIKTKR7NgGkcfi
 7KKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjxQyidb/HXqk0lNZaeJWhlrMYVtw76KsnhSxA1sHcAFcWpxlyGlQRis8AeSXuk5K9dUIAXTN0cCukmI+j1fjjyQSlrPQ=
X-Gm-Message-State: AOJu0YyhpLq5BqJBDLXzHc1AHdT30AEFVza+qtFpwrPT53DZFF4eOkTy
 lz9bfCyvo5Q/iYfxIYKY+MEW0yZB34MZkMi4Sy8Bq8I9o1tPGbWAtgYJoxcI3sz+Z/T8IKPQl0s
 1BxLxOsT3Mp9deBhQ2FqSn6RE4XmBmOOopzSsYflr+3R0dQCzO+jB
X-Received: by 2002:a05:620a:5e0b:b0:792:bbdb:2520 with SMTP id
 af79cd13be357-792c75749e9mr2140169185a.9.1715861240863; 
 Thu, 16 May 2024 05:07:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtdQPT48i1firRJCUl60pGNvOyQ5isq05m5q9TAtkXXGbVB+DDT85HWnlo2JPuC9lwf6nF7A==
X-Received: by 2002:a05:620a:5e0b:b0:792:bbdb:2520 with SMTP id
 af79cd13be357-792c75749e9mr2140145685a.9.1715861236475; 
 Thu, 16 May 2024 05:07:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-792bf27779fsm792017285a.21.2024.05.16.05.07.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 May 2024 05:07:15 -0700 (PDT)
Message-ID: <8b35e770-2beb-4db8-b23f-7c322e0e8881@redhat.com>
Date: Thu, 16 May 2024 14:07:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/9] vfio/migration: Add an Error** argument to
 vfio_migration_set_state()
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20240514153130.394307-1-clg@redhat.com>
 <20240514153130.394307-5-clg@redhat.com>
 <dc729ce1-275e-4889-a7a7-7d945ee310bd@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <dc729ce1-275e-4889-a7a7-7d945ee310bd@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.022,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 5/16/24 10:18, Avihai Horon wrote:
> 
> On 14/05/2024 18:31, Cédric Le Goater wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> Add an Error** argument to vfio_migration_set_state() and adjust
>> callers, including vfio_save_setup(). The error will be propagated up
>> to qemu_savevm_state_setup() where the save_setup() handler is
>> executed.
>>
>> Modify vfio_vmstate_change_prepare() and vfio_vmstate_change() to
>> store a reported error under the migration stream if a migration is in
>> progress.
>>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> 
> With/without Eric's suggestion:
> Reviewed-by: Avihai Horon <avihaih@nvidia.com>
> 
> Two nits below though (if you respin or want to amend inline).
> 
>> ---
>>
>>   Changes in v6:
>>
>>   - Commit log improvements (Avihai)
>>   - vfio_migration_set_state() : Dropped the error_setg_errno() change
>>     when setting device in recover state fails (Avihai)
>>   - vfio_migration_state_notifier() : report local error (Avihai)
>>
>>   Changes in v5:
>>
>>   - Replaced error_setg() by error_setg_errno() in vfio_migration_set_state()
>>   - Rebased on 20c64c8a51a4 ("migration: migration_file_set_error")
>>
>>   hw/vfio/migration.c | 77 ++++++++++++++++++++++++++++-----------------
>>   1 file changed, 48 insertions(+), 29 deletions(-)
>>
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index bf2fd0759ba6e4fb103cc5c1a43edb180a3d0de4..bf11135167ebb162dd41415656bdacfa0e1ca550 100644
>> --- a/hw/vfio/migration.c
>> +++ b/hw/vfio/migration.c
>> @@ -82,7 +82,8 @@ static const char *mig_state_to_str(enum vfio_device_mig_state state)
>>
>>   static int vfio_migration_set_state(VFIODevice *vbasedev,
>>                                       enum vfio_device_mig_state new_state,
>> -                                    enum vfio_device_mig_state recover_state)
>> +                                    enum vfio_device_mig_state recover_state,
>> +                                    Error **errp)
>>   {
>>       VFIOMigration *migration = vbasedev->migration;
>>       uint64_t buf[DIV_ROUND_UP(sizeof(struct vfio_device_feature) +
>> @@ -102,18 +103,19 @@ static int vfio_migration_set_state(VFIODevice *vbasedev,
>>           ret = -errno;
>>
>>           if (recover_state == VFIO_DEVICE_STATE_ERROR) {
>> -            error_report("%s: Failed setting device state to %s, err: %s. "
>> -                         "Recover state is ERROR. Resetting device",
>> -                         vbasedev->name, mig_state_to_str(new_state),
>> -                         strerror(errno));
>> +            error_setg_errno(errp, errno,
>> +                             "%s: Failed setting device state to %s. "
>> +                             "Recover state is ERROR. Resetting device",
>> +                             vbasedev->name, mig_state_to_str(new_state));
>>
>>               goto reset_device;
>>           }
>>
>> -        error_report(
>> -            "%s: Failed setting device state to %s, err: %s. Setting device in recover state %s",
>> -                     vbasedev->name, mig_state_to_str(new_state),
>> -                     strerror(errno), mig_state_to_str(recover_state));
>> +        error_setg_errno(errp, errno,
>> +                         "%s: Failed setting device state to %s. "
>> +                         "Setting device in recover state %s",
>> +                         vbasedev->name, mig_state_to_str(new_state),
>> +                         mig_state_to_str(recover_state));
>>
>>           mig_state->device_state = recover_state;
>>           if (ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature)) {
>> @@ -137,7 +139,7 @@ static int vfio_migration_set_state(VFIODevice *vbasedev,
>>                * This can happen if the device is asynchronously reset and
>>                * terminates a data transfer.
>>                */
>> -            error_report("%s: data_fd out of sync", vbasedev->name);
>> +            error_setg(errp, "%s: data_fd out of sync", vbasedev->name);
>>               close(mig_state->data_fd);
>>
>>               return -EBADF;
>> @@ -168,10 +170,11 @@ reset_device:
>>    */
>>   static int
>>   vfio_migration_set_state_or_reset(VFIODevice *vbasedev,
>> -                                  enum vfio_device_mig_state new_state)
>> +                                  enum vfio_device_mig_state new_state,
>> +                                  Error **errp)
>>   {
>>       return vfio_migration_set_state(vbasedev, new_state,
>> -                                    VFIO_DEVICE_STATE_ERROR);
>> +                                    VFIO_DEVICE_STATE_ERROR, errp);
>>   }
>>
>>   static int vfio_load_buffer(QEMUFile *f, VFIODevice *vbasedev,
>> @@ -399,10 +402,8 @@ static int vfio_save_setup(QEMUFile *f, void *opaque, Error **errp)
>>           switch (migration->device_state) {
>>           case VFIO_DEVICE_STATE_RUNNING:
>>               ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_PRE_COPY,
>> -                                           VFIO_DEVICE_STATE_RUNNING);
>> +                                           VFIO_DEVICE_STATE_RUNNING, errp);
>>               if (ret) {
>> -                error_setg(errp, "%s: Failed to set new PRE_COPY state",
>> -                           vbasedev->name);
>>                   return ret;
>>               }
>>
>> @@ -435,13 +436,20 @@ static void vfio_save_cleanup(void *opaque)
>>   {
>>       VFIODevice *vbasedev = opaque;
>>       VFIOMigration *migration = vbasedev->migration;
>> +    Error *local_err = NULL;
>> +    int ret;
>>
>>       /*
>>        * Changing device state from STOP_COPY to STOP can take time. Do it here,
>>        * after migration has completed, so it won't increase downtime.
>>        */
>>       if (migration->device_state == VFIO_DEVICE_STATE_STOP_COPY) {
>> -        vfio_migration_set_state_or_reset(vbasedev, VFIO_DEVICE_STATE_STOP);
>> +        ret = vfio_migration_set_state_or_reset(vbasedev,
>> +                                                VFIO_DEVICE_STATE_STOP,
>> +                                                &local_err);
>> +        if (ret) {
>> +            error_report_err(local_err);
>> +        }
>>       }
>>
>>       g_free(migration->data_buffer);
>> @@ -549,11 +557,13 @@ static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
>>       VFIODevice *vbasedev = opaque;
>>       ssize_t data_size;
>>       int ret;
>> +    Error *local_err = NULL;
>>
>>       /* We reach here with device state STOP or STOP_COPY only */
>>       ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_STOP_COPY,
>> -                                   VFIO_DEVICE_STATE_STOP);
>> +                                   VFIO_DEVICE_STATE_STOP, &local_err);
>>       if (ret) {
>> +        error_report_err(local_err);
>>           return ret;
>>       }
>>
>> @@ -591,14 +601,9 @@ static void vfio_save_state(QEMUFile *f, void *opaque)
>>   static int vfio_load_setup(QEMUFile *f, void *opaque, Error **errp)
>>   {
>>       VFIODevice *vbasedev = opaque;
>> -    int ret;
>>
>> -    ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_RESUMING,
>> -                                   vbasedev->migration->device_state);
>> -    if (ret) {
>> -        error_setg(errp, "%s: Failed to set RESUMING state", vbasedev->name);
>> -    }
>> -    return ret;
>> +    return vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_RESUMING,
>> +                                    vbasedev->migration->device_state, errp);
>>   }
>>
>>   static int vfio_load_cleanup(void *opaque)
>> @@ -714,19 +719,20 @@ static void vfio_vmstate_change_prepare(void *opaque, bool running,
>>       VFIODevice *vbasedev = opaque;
>>       VFIOMigration *migration = vbasedev->migration;
>>       enum vfio_device_mig_state new_state;
>> +    Error *local_err = NULL;
>>       int ret;
>>
>>       new_state = migration->device_state == VFIO_DEVICE_STATE_PRE_COPY ?
>>                       VFIO_DEVICE_STATE_PRE_COPY_P2P :
>>                       VFIO_DEVICE_STATE_RUNNING_P2P;
>>
>> -    ret = vfio_migration_set_state_or_reset(vbasedev, new_state);
>> +    ret = vfio_migration_set_state_or_reset(vbasedev, new_state, &local_err);
>>       if (ret) {
>>           /*
>>            * Migration should be aborted in this case, but vm_state_notify()
>>            * currently does not support reporting failures.
>>            */
>> -        migration_file_set_error(ret, NULL);
>> +        migration_file_set_error(ret, local_err);
>>       }
>>
>>       trace_vfio_vmstate_change_prepare(vbasedev->name, running,
>> @@ -738,6 +744,7 @@ static void vfio_vmstate_change(void *opaque, bool running, RunState state)
>>   {
>>       VFIODevice *vbasedev = opaque;
>>       enum vfio_device_mig_state new_state;
>> +    Error *local_err = NULL;
>>       int ret;
>>
>>       if (running) {
>> @@ -750,13 +757,13 @@ static void vfio_vmstate_change(void *opaque, bool running, RunState state)
>>                   VFIO_DEVICE_STATE_STOP;
>>       }
>>
>> -    ret = vfio_migration_set_state_or_reset(vbasedev, new_state);
>> +    ret = vfio_migration_set_state_or_reset(vbasedev, new_state, &local_err);
>>       if (ret) {
>>           /*
>>            * Migration should be aborted in this case, but vm_state_notify()
>>            * currently does not support reporting failures.
>>            */
>> -        migration_file_set_error(ret, NULL);
>> +        migration_file_set_error(ret, local_err);
>>       }
>>
>>       trace_vfio_vmstate_change(vbasedev->name, running, RunState_str(state),
>> @@ -769,11 +776,23 @@ static int vfio_migration_state_notifier(NotifierWithReturn *notifier,
>>       VFIOMigration *migration = container_of(notifier, VFIOMigration,
>>                                               migration_state);
>>       VFIODevice *vbasedev = migration->vbasedev;
>> +    Error *local_err = NULL;
>> +    int ret = 0;
> 
> Nit: No need to set ret to 0.
> 
>>
>>       trace_vfio_migration_state_notifier(vbasedev->name, e->type);
>>
>>       if (e->type == MIG_EVENT_PRECOPY_FAILED) {
>> -        vfio_migration_set_state_or_reset(vbasedev, VFIO_DEVICE_STATE_RUNNING);
>> +        /*
>> +         * MigrationNotifyFunc may return an error code and an Error
>> +         * object only for MIG_EVENT_PRECOPY_SETUP. Hence, report the
>> +         * error locally and ignore the errp argument.
>> +         */
> 
> Nit: maybe rephrase to the following:
> 
> "MigrationNotifyFunc may not return an error code and an Error object for MIG_EVENT_PRECOPY_FAILED. Hence ..."
> 
> (This way, this comment will not become stale if new MIG_EVENTs that are allowed to return error are added)


ok. done. There will be a (final) v7.

Thanks,

C.


> Thanks.
> 
>> +        ret = vfio_migration_set_state_or_reset(vbasedev,
>> +                                                VFIO_DEVICE_STATE_RUNNING,
>> +                                                &local_err);
>> +        if (ret) {
>> +            error_report_err(local_err);
>> +        }
>>       }
>>       return 0;
>>   }
>> -- 
>> 2.45.0
>>
> 


