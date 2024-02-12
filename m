Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8CEFC48297
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 17:54:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZaVb-0000UA-HC; Mon, 12 Feb 2024 12:54:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rZaVa-0000U2-M3
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 12:54:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rZaVW-00047x-8j
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 12:54:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707760455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zR2HqGtVPAwVKm/OLRYE9VVtr5m3pb31kgtJDnSolWE=;
 b=hN1TYaUgoxlzQn+eYYYfU9y9zMNj8IR6madQUpUh4BU2abN46idWK4TrcjGXkv59o7jmvD
 VG2s90Png9nUY42fzgiDdF1Fi52L7M8CxJs0akIt+VHquDOc7urelZyi/ydrtIVpmtNgIf
 2/KFzYX/9jJwKN1UBftCz8W8uXuOV/k=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-GaVluo8HMgO4ckn9cmNQgA-1; Mon, 12 Feb 2024 12:54:13 -0500
X-MC-Unique: GaVluo8HMgO4ckn9cmNQgA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-33b0991ccb6so1747232f8f.1
 for <qemu-devel@nongnu.org>; Mon, 12 Feb 2024 09:54:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707760452; x=1708365252;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zR2HqGtVPAwVKm/OLRYE9VVtr5m3pb31kgtJDnSolWE=;
 b=km+J3n5ibvNQfag6UauP0lG9hZ6oAJ3brmtM9k94j/0PWxGT+soKjDyz8xIOc7xWX4
 1sE2e3whu7xPeWXi/YLIS3SS8YfxoxU45zdf6IpLqINKnxUqxQzylEN1/c6m5pkCl0Xb
 oNq/pZoyOAvW+BCbQ6R6geu9o1rk5rE03h+mfMXIbVcWcSErjpk8l8WMXYkrJN+4sD4a
 qok814H7ti2kywtoSZhG2j1XBzzDR3W+KrsgdUu6grg7FOtRy1+b5r9IAFsyJDQ11+wr
 nH92357SV6KwVT5kl/VW6dTUgfEZ/t4rX7OcAR9Zpklam+Ngu9YhBVR3XFH3wSf6nWhr
 csJA==
X-Gm-Message-State: AOJu0YwIY9FqVGkNGTNyGW6NNbREt89rVjhLFVpq0/hpYfHFHgYheHdR
 mRjale5mzr/+uN6p+K8h683qhEQFIfkKm/FhTA3Vce8IoIAW3Zc+4kkPfZqS5VuA1nVfwfZvTG1
 fJF1Zcuc/qGjC1ZJ7KiPZp0oTZzX9fdStPnu6fPB+1NeWZZN4CUS1
X-Received: by 2002:a5d:62c9:0:b0:33b:51b2:ad24 with SMTP id
 o9-20020a5d62c9000000b0033b51b2ad24mr5127473wrv.37.1707760452308; 
 Mon, 12 Feb 2024 09:54:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEOKW4fjQqk6omZccKQxrUROGRP+wnAlRsxzM9PpRyfwjmwxuxsdKBhXhqfOK6B9m+atoKhxw==
X-Received: by 2002:a5d:62c9:0:b0:33b:51b2:ad24 with SMTP id
 o9-20020a5d62c9000000b0033b51b2ad24mr5127463wrv.37.1707760451992; 
 Mon, 12 Feb 2024 09:54:11 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVW1EduIIYjggcOICC04k11lj5NmyoLR30qDq7L9n3W+3zL5VmXfl9ZDO+q5ntAIKsOwqz0KeQ5UTyvhQuuNHpdckW+GiGwYszvcIrrAIundYs2EqDdZ8t2Tuap4vrSnt9VM0fZAcnZzjbRZ2dVKIhnkKA=
Received: from ?IPV6:2a01:cb19:853d:fa00:c28a:3e3d:34f3:3891?
 ([2a01:cb19:853d:fa00:c28a:3e3d:34f3:3891])
 by smtp.gmail.com with ESMTPSA id
 f14-20020a056000128e00b0033b50e0d493sm7382494wrx.59.2024.02.12.09.54.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Feb 2024 09:54:11 -0800 (PST)
Message-ID: <01f3e1e5-75e0-474f-91fc-27d20a4c96ed@redhat.com>
Date: Mon, 12 Feb 2024 18:54:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/14] vfio: Use new Error** argument in vfio_save_setup()
Content-Language: en-US
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20240207133347.1115903-1-clg@redhat.com>
 <20240207133347.1115903-9-clg@redhat.com>
 <589c8a79-4266-41c9-a019-ce1d55d7fab9@nvidia.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <589c8a79-4266-41c9-a019-ce1d55d7fab9@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.774,
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

On 2/12/24 10:17, Avihai Horon wrote:
> Hi Cedric,
> 
> On 07/02/2024 15:33, Cédric Le Goater wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> Add an Error** argument to vfio_migration_set_state() and adjust
>> callers, including vfio_save_setup(). The error will be propagated up
>> to qemu_savevm_state_setup() where the save_setup() handler is
>> executed.
>>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   hw/vfio/migration.c | 62 +++++++++++++++++++++++++++++----------------
>>   1 file changed, 40 insertions(+), 22 deletions(-)
>>
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index 2dfbe671f6f45aa530c7341177bb532d8292cecd..2e0a79967cc97f44d9be5575c3cfe18c9f349dab 100644
>> --- a/hw/vfio/migration.c
>> +++ b/hw/vfio/migration.c
>> @@ -84,7 +84,8 @@ static const char *mig_state_to_str(enum vfio_device_mig_state state)
>>
>>   static int vfio_migration_set_state(VFIODevice *vbasedev,
>>                                       enum vfio_device_mig_state new_state,
>> -                                    enum vfio_device_mig_state recover_state)
>> +                                    enum vfio_device_mig_state recover_state,
>> +                                    Error **errp)
>>   {
>>       VFIOMigration *migration = vbasedev->migration;
>>       uint64_t buf[DIV_ROUND_UP(sizeof(struct vfio_device_feature) +
>> @@ -104,15 +105,15 @@ static int vfio_migration_set_state(VFIODevice *vbasedev,
>>           ret = -errno;
>>
>>           if (recover_state == VFIO_DEVICE_STATE_ERROR) {
>> -            error_report("%s: Failed setting device state to %s, err: %s. "
>> -                         "Recover state is ERROR. Resetting device",
>> -                         vbasedev->name, mig_state_to_str(new_state),
>> -                         strerror(errno));
>> +            error_setg(errp, "%s: Failed setting device state to %s, err: %s. "
>> +                       "Recover state is ERROR. Resetting device",
>> +                       vbasedev->name, mig_state_to_str(new_state),
>> +                       strerror(errno));
>>
>>               goto reset_device;
>>           }
>>
>> -        error_report(
>> +        error_setg(errp,
>>               "%s: Failed setting device state to %s, err: %s. Setting device in recover state %s",
>>                        vbasedev->name, mig_state_to_str(new_state),
>>                        strerror(errno), mig_state_to_str(recover_state));
>> @@ -120,7 +121,7 @@ static int vfio_migration_set_state(VFIODevice *vbasedev,
>>           mig_state->device_state = recover_state;
>>           if (ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature)) {
>>               ret = -errno;
>> -            error_report(
>> +            error_setg(errp,
>>                   "%s: Failed setting device in recover state, err: %s. Resetting device",
>>                            vbasedev->name, strerror(errno));
> 
> I think here we will assert because errp is already set.
> 
> Adding an error_append() API would be useful here I guess.

yes.

> Otherwise, we need to move the first error_setg() below, to before we return from a successful recover state change, and construct the error message differently (e.g., provide a full error message for the recover state fail case containing also the first error).
> 
> Do you have other ideas?

Errors for :

     if (ioctl(vbasedev->fd, VFIO_DEVICE_RESET)) {

should be treated as the others with and error_append() and not
hw_error(). This needs a rework before any new changes.

I also wonder why we have twice :

     migration->device_state = recover_state;

It looks redundant. The ioctl VFIO_DEVICE_FEATURE should leave the
state unmodified.

Thanks,

C.



