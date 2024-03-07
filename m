Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C773CC54E4A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 13:39:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riDx7-0001Ug-V9; Thu, 07 Mar 2024 08:38:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1riDuw-00014c-7C
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 08:36:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1riDuK-0000tD-5g
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 08:36:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709818534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ja8wC2kqYBmHMDND7ygUpD1JAQe3oGCLKQ2Wd/tFXAA=;
 b=RCNbl1Hh9cgt4h+NU7FS9PBkf+DlflXIuzoNTfSaOSqQrPHI3L2psbOR/quKvER2ZnTDPh
 4z1KZ1/o3dqPm85fiOLWxfQbSnCbNrjymC6cIXnYBteweHLi13uMlOk++uWz2yq2AQMMh1
 1XSqkTRFtddOfJU+/+OR5+tIYj8/gvY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-zV-d9P6OP9uO-Sw-Dn4JBg-1; Thu, 07 Mar 2024 08:35:31 -0500
X-MC-Unique: zV-d9P6OP9uO-Sw-Dn4JBg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-412f18b75faso5254225e9.0
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 05:35:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709818530; x=1710423330;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ja8wC2kqYBmHMDND7ygUpD1JAQe3oGCLKQ2Wd/tFXAA=;
 b=hhl8uyVczxPMaF3IqL86Dt7Zj/byfLITGTKjUNarKCI0b/N1XZP/JfO4cobYZWsyf/
 apZKvuYgQh8JpBDbu1XVNGIlxRqd85PLmxOm3giAoeKsnaU3iUw2lhO/fVXwvynjhIM+
 zSzPDFqxztTR+1VFRf07HKyhnLzfS9sJ0JgAks5UNL1OFY4sR0KivKviC3UDwSP9EAQf
 6dXJrci7QIa3NYObXBOFp/cVv2h7iMM6B6hGpNle9gbcBO8E9XRGaJC8q3h/gZOWWsj7
 3fiIGQY9asXPRuEyoAQSINPYuHi8Yp5a8ExUnB6KpF0q6qZhcvIgHBZ6Ej4f5xb5JD/u
 z4bw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPWlBbI4+FwnimQ5CSogr3i7IITMWslpR0A7685zNEl3CHW3ChwaNZXB3+29Ydh+PT9vv8iApqpdm8HlHLwp2/VLRZmFo=
X-Gm-Message-State: AOJu0YytVkY62eUDwmgOeklSXISveAhosir+x0SdxOflL7ZzePb7xLUT
 zwqKF5m8UpIKdDBPRQeCd1+lPpOkBjEPQY9JY5eCeFYtfKXUhuFsyheUZCZ12likZqxJx44OssR
 7IIWkC+ZYE0Eq8no+79IpXSjM1/wB4PNm13dBtWsn62/VTwRzui2W
X-Received: by 2002:a05:600c:1d87:b0:412:e7d6:4464 with SMTP id
 p7-20020a05600c1d8700b00412e7d64464mr7915623wms.32.1709818530158; 
 Thu, 07 Mar 2024 05:35:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEmG532LPCmxtbGtuIa70MdZtJjZskpnJ/24/thsdATxocH66KqF0DylOl0Y88DKh3qzQS1wQ==
X-Received: by 2002:a05:600c:1d87:b0:412:e7d6:4464 with SMTP id
 p7-20020a05600c1d8700b00412e7d64464mr7915608wms.32.1709818529765; 
 Thu, 07 Mar 2024 05:35:29 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 fj5-20020a05600c0c8500b00412b56aa46bsm2727229wmb.13.2024.03.07.05.35.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Mar 2024 05:35:28 -0800 (PST)
Message-ID: <c3331b76-a900-4196-83a1-3d634791f11d@redhat.com>
Date: Thu, 7 Mar 2024 14:35:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 19/25] vfio: Use new Error** argument in
 vfio_save_setup()
Content-Language: en-US, fr
To: Eric Auger <eauger@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>
References: <20240306133441.2351700-1-clg@redhat.com>
 <20240306133441.2351700-20-clg@redhat.com>
 <e930ebf3-6aa7-43be-8a24-a544361a8df5@redhat.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <e930ebf3-6aa7-43be-8a24-a544361a8df5@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.583,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 3/7/24 10:04, Eric Auger wrote:
> Hi Cédric,
> 
> On 3/6/24 14:34, Cédric Le Goater wrote:
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
>> ---
>>
>>   Changes in v3:
>>
>>   - Use error_setg_errno() in vfio_save_setup()
>>   - Made sure an error is always set in case of failure in
>>     vfio_load_setup()
>>     
>>   hw/vfio/migration.c | 67 ++++++++++++++++++++++++++-------------------
>>   1 file changed, 39 insertions(+), 28 deletions(-)
>>
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index a3bb1a92ba0b9c2c585efe54cfda0b774a81dcb9..71ade14a7942358094371a86c00718f5979113ea 100644
>> --- a/hw/vfio/migration.c
>> +++ b/hw/vfio/migration.c
>> @@ -84,7 +84,8 @@ static const char *mig_state_to_str(enum vfio_device_mig_state state)
>>   
>>   static int vfio_migration_set_state(VFIODevice *vbasedev,
>>                                       enum vfio_device_mig_state new_state,
>> -                                    enum vfio_device_mig_state recover_state)
>> +                                    enum vfio_device_mig_state recover_state,
>> +                                    Error **errp)
>>   {
>>       VFIOMigration *migration = vbasedev->migration;
>>       uint64_t buf[DIV_ROUND_UP(sizeof(struct vfio_device_feature) +
>> @@ -104,15 +105,15 @@ static int vfio_migration_set_state(VFIODevice *vbasedev,
>>           ret = -errno;
>>   
>>           if (recover_state == VFIO_DEVICE_STATE_ERROR) {
>> -            error_report("%s: Failed setting device state to %s, err: %s. "
>> -                         "Recover state is ERROR. Resetting device",
>> -                         vbasedev->name, mig_state_to_str(new_state),
>> -                         strerror(errno));
>> +            error_setg(errp, "%s: Failed setting device state to %s, err: %s. "
>> +                       "Recover state is ERROR. Resetting device",
>> +                       vbasedev->name, mig_state_to_str(new_state),
>> +                       strerror(errno));
> you can use the error_setg_errno variant here and below.

sure.


>>   
>>               goto reset_device;
>>           }
>>   
>> -        error_report(
>> +        error_setg(errp,
>>               "%s: Failed setting device state to %s, err: %s. Setting device in recover state %s",
>>                        vbasedev->name, mig_state_to_str(new_state),
>>                        strerror(errno), mig_state_to_str(recover_state));
>> @@ -120,7 +121,7 @@ static int vfio_migration_set_state(VFIODevice *vbasedev,
>>           mig_state->device_state = recover_state;
>>           if (ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature)) {
>>               ret = -errno;
>> -            error_report(
>> +            error_setg(errp,
>>                   "%s: Failed setting device in recover state, err: %s. Resetting device",
>>                            vbasedev->name, strerror(errno));
>>   
>> @@ -139,7 +140,7 @@ static int vfio_migration_set_state(VFIODevice *vbasedev,
>>                * This can happen if the device is asynchronously reset and
>>                * terminates a data transfer.
>>                */
>> -            error_report("%s: data_fd out of sync", vbasedev->name);
>> +            error_setg(errp, "%s: data_fd out of sync", vbasedev->name);
>>               close(mig_state->data_fd);
>>   
>>               return -EBADF;
>> @@ -170,10 +171,11 @@ reset_device:
>>    */
>>   static int
>>   vfio_migration_set_state_or_reset(VFIODevice *vbasedev,
>> -                                  enum vfio_device_mig_state new_state)
>> +                                  enum vfio_device_mig_state new_state,
>> +                                  Error **errp)
>>   {
>>       return vfio_migration_set_state(vbasedev, new_state,
>> -                                    VFIO_DEVICE_STATE_ERROR);
>> +                                    VFIO_DEVICE_STATE_ERROR, errp);
>>   }
>>   
>>   static int vfio_load_buffer(QEMUFile *f, VFIODevice *vbasedev,
>> @@ -401,10 +403,8 @@ static int vfio_save_setup(QEMUFile *f, void *opaque, Error **errp)
>>           switch (migration->device_state) {
>>           case VFIO_DEVICE_STATE_RUNNING:
>>               ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_PRE_COPY,
>> -                                           VFIO_DEVICE_STATE_RUNNING);
>> +                                           VFIO_DEVICE_STATE_RUNNING, errp);
>>               if (ret) {
>> -                error_setg(errp, "%s: Failed to set new PRE_COPY state",
>> -                           vbasedev->name);
>>                   return ret;
>>               }
>>   
>> @@ -437,13 +437,20 @@ static void vfio_save_cleanup(void *opaque)
>>   {
>>       VFIODevice *vbasedev = opaque;
>>       VFIOMigration *migration = vbasedev->migration;
>> +    Error *local_err = NULL;
>> +    int ret;
>>   
>>       /*
>>        * Changing device state from STOP_COPY to STOP can take time. Do it here,
>>        * after migration has completed, so it won't increase downtime.
>>        */
>>       if (migration->device_state == VFIO_DEVICE_STATE_STOP_COPY) {
>> -        vfio_migration_set_state_or_reset(vbasedev, VFIO_DEVICE_STATE_STOP);
>> +        ret = vfio_migration_set_state_or_reset(vbasedev,
>> +                                                VFIO_DEVICE_STATE_STOP,
>> +                                                &local_err);
>> +        if (ret) {
>> +            error_report_err(local_err);
>> +        }
>>       }
>>   
>>       g_free(migration->data_buffer);
>> @@ -549,11 +556,13 @@ static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
>>       VFIODevice *vbasedev = opaque;
>>       ssize_t data_size;
>>       int ret;
>> +    Error *local_err = NULL;
>>   
>>       /* We reach here with device state STOP or STOP_COPY only */
>>       ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_STOP_COPY,
>> -                                   VFIO_DEVICE_STATE_STOP);
>> +                                   VFIO_DEVICE_STATE_STOP, &local_err);
>>       if (ret) {
>> +        error_report_err(local_err);
>>           return ret;
>>       }
>>   
>> @@ -591,14 +600,9 @@ static void vfio_save_state(QEMUFile *f, void *opaque)
>>   static int vfio_load_setup(QEMUFile *f, void *opaque, Error **errp)
>>   {
>>       VFIODevice *vbasedev = opaque;
>> -    int ret;
>>   
>> -    ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_RESUMING,
>> -                                   vbasedev->migration->device_state);
>> -    if (ret) {
>> -        error_setg(errp, "%s: Failed to set RESUMING state", vbasedev->name);
>> -    }
>> -    return ret;
>> +    return vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_RESUMING,
>> +                                    vbasedev->migration->device_state, errp);
>>   }
>>   
>>   static int vfio_load_cleanup(void *opaque)
>> @@ -714,20 +718,22 @@ static void vfio_vmstate_change_prepare(void *opaque, bool running,
>>       VFIODevice *vbasedev = opaque;
>>       VFIOMigration *migration = vbasedev->migration;
>>       enum vfio_device_mig_state new_state;
>> +    Error *local_err = NULL;
>>       int ret;
>>   
>>       new_state = migration->device_state == VFIO_DEVICE_STATE_PRE_COPY ?
>>                       VFIO_DEVICE_STATE_PRE_COPY_P2P :
>>                       VFIO_DEVICE_STATE_RUNNING_P2P;
>>   
>> -    ret = vfio_migration_set_state_or_reset(vbasedev, new_state);
>> +    ret = vfio_migration_set_state_or_reset(vbasedev, new_state, &local_err);
>>       if (ret) {
>>           /*
>>            * Migration should be aborted in this case, but vm_state_notify()
>>            * currently does not support reporting failures.
>>            */
> if ret and we do not enter the condition below, we may leak the
> local_err. Same below.

yes. I will export and use vfio_set_migration_error() from common.c instead.


Thanks,

C.




> 
> Eric
>>           if (migrate_get_current()->to_dst_file) {
>> -            qemu_file_set_error(migrate_get_current()->to_dst_file, ret);
>> +            qemu_file_set_error_obj(migrate_get_current()->to_dst_file, ret,
>> +                                    local_err);
>>           }
>>       }
>>   
>> @@ -740,6 +746,7 @@ static void vfio_vmstate_change(void *opaque, bool running, RunState state)
>>   {
>>       VFIODevice *vbasedev = opaque;
>>       enum vfio_device_mig_state new_state;
>> +    Error *local_err = NULL;
>>       int ret;
>>   
>>       if (running) {
>> @@ -752,14 +759,15 @@ static void vfio_vmstate_change(void *opaque, bool running, RunState state)
>>                   VFIO_DEVICE_STATE_STOP;
>>       }
>>   
>> -    ret = vfio_migration_set_state_or_reset(vbasedev, new_state);
>> +    ret = vfio_migration_set_state_or_reset(vbasedev, new_state, &local_err);
>>       if (ret) {
>>           /*
>>            * Migration should be aborted in this case, but vm_state_notify()
>>            * currently does not support reporting failures.
>>            */
>>           if (migrate_get_current()->to_dst_file) {
>> -            qemu_file_set_error(migrate_get_current()->to_dst_file, ret);
>> +            qemu_file_set_error_obj(migrate_get_current()->to_dst_file, ret,
>> +                                    local_err);
>>           }
>>       }
>>   
>> @@ -773,13 +781,16 @@ static int vfio_migration_state_notifier(NotifierWithReturn *notifier,
>>       VFIOMigration *migration = container_of(notifier, VFIOMigration,
>>                                               migration_state);
>>       VFIODevice *vbasedev = migration->vbasedev;
>> +    int ret = 0;
>>   
>>       trace_vfio_migration_state_notifier(vbasedev->name, e->type);
>>   
>>       if (e->type == MIG_EVENT_PRECOPY_FAILED) {
>> -        vfio_migration_set_state_or_reset(vbasedev, VFIO_DEVICE_STATE_RUNNING);
>> +        ret = vfio_migration_set_state_or_reset(vbasedev,
>> +                                                VFIO_DEVICE_STATE_RUNNING,
>> +                                                errp);
>>       }
>> -    return 0;
>> +    return ret;
>>   }
>>   
>>   static void vfio_migration_free(VFIODevice *vbasedev)
> 


