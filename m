Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D399C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 17:16:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7IE3-0002RG-7q; Wed, 15 May 2024 13:15:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s7IE0-0002QD-Dy
 for qemu-devel@nongnu.org; Wed, 15 May 2024 13:15:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s7IDp-0004H9-6H
 for qemu-devel@nongnu.org; Wed, 15 May 2024 13:15:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715793318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rTLnT2mhAV5A5J4BHlOuE9vq32JOZ9p08A+qPbYtwEM=;
 b=ADN0/DlrDzi1Rb9ofhM9gRZ3Vax5c3tuMB1bBKxR5bV0JJr5Gf8PbMR5qjX2o1WnVbByVq
 AKkdN82TF9XfHH9jHXmqck7DDxFk1kdAgn80laJBrx7VeStFg3vGVd/BIl7Lku6I9MURx1
 EC/ksqTVEhG4HLTA3frCp2Yo7KCcFHg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-NM7yw9oLMle4cxkegp3CfA-1; Wed, 15 May 2024 13:15:17 -0400
X-MC-Unique: NM7yw9oLMle4cxkegp3CfA-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6a0e7d77b41so96050996d6.0
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 10:15:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715793317; x=1716398117;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rTLnT2mhAV5A5J4BHlOuE9vq32JOZ9p08A+qPbYtwEM=;
 b=jnuscA5/3J0+DPsyl8QCwSDPQZHn68bJNLICF7s8GxSrdXEYN6CVcbflrWedVlxqNn
 iDfzbCiiUz8ju+GD5kQA4rYxs5qtKw38gX/3c/E/kO/npQEoJP3HNLpnzPkuelP2WLcO
 J2g42Q2yJuVZiBa4ZVbey8w48OPWb2stweKQbhyOa4DRI/PAEf6wv3lLO4tNuEuNfUHj
 v5T8o3x32S3G7Pp5U9ydMU4sgyc5M/TRBxZMacvTDBNjgxChnQsuttcwNQ/0Nycp66SP
 oRXVu7fBOWwVkYO6o8LcJGdWnbIynmxtIGUefPU7qiMh9BINT3F5ttM/hziyUGDTHa+O
 sDWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaz7DtWbgrchlUOVYjDE9Z0QB8is52pJ2EJV9hBQvYaU5XUseO3ffpPxN0MYloHFuuY45p+b2cak27XkADg5bubUdoEaE=
X-Gm-Message-State: AOJu0YwalhahiCqCceaRfPl5oK8YkH/oRe6P2SJrDSEWcZ3z71lF6sVN
 23lEt2PsbpV6sar5YbA0Dcd6HAlFsHVXO/PCkK7gNOq561qVrXCcw1CorKQb2VK6g4SAF6Nrlwg
 0BX8YlvnCXvES2E2Bknka20HlFMNnRlrbS+AKJxdSinZ7clNwMOUr
X-Received: by 2002:a05:6214:3b87:b0:69b:6c70:320a with SMTP id
 6a1803df08f44-6a328adced9mr151692726d6.27.1715793316594; 
 Wed, 15 May 2024 10:15:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGX7bc4CKExm8kc4EsU/Q90cQexjakg6TvNx4nebURA6zuOgHwc6CcgKA3bLEDCNtm4rVUnA==
X-Received: by 2002:a05:6214:3b87:b0:69b:6c70:320a with SMTP id
 6a1803df08f44-6a328adced9mr151692426d6.27.1715793316158; 
 Wed, 15 May 2024 10:15:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6a15f1857f9sm66206876d6.49.2024.05.15.10.15.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 May 2024 10:15:15 -0700 (PDT)
Message-ID: <300072b4-857d-4740-ab8f-5f10a000f5d0@redhat.com>
Date: Wed, 15 May 2024 19:15:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/9] migration: Extend migration_file_set_error() with
 Error* argument
To: Eric Auger <eauger@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Markus Armbruster <armbru@redhat.com>
References: <20240514153130.394307-1-clg@redhat.com>
 <20240514153130.394307-4-clg@redhat.com>
 <7d4c47ef-f312-4735-ab8b-1bbc841ed3a4@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <7d4c47ef-f312-4735-ab8b-1bbc841ed3a4@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.935,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 5/15/24 09:04, Eric Auger wrote:
> Hi Cédric,
> 
> On 5/14/24 17:31, Cédric Le Goater wrote:
>> Use it to update the current error of the migration stream if
>> available and if not, simply print out the error. Next changes will
>> update with an error to report.
>>
>> Reviewed-by: Avihai Horon <avihaih@nvidia.com>
>> Acked-by: Fabiano Rosas <farosas@suse.de>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>
>>   Changes in v6:
>>
>>   - Commit log improvements (Avihai)
>>   
>>   include/migration/misc.h | 2 +-
>>   hw/vfio/common.c         | 2 +-
>>   hw/vfio/migration.c      | 4 ++--
>>   migration/migration.c    | 6 ++++--
>>   4 files changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/include/migration/misc.h b/include/migration/misc.h
>> index bf7339cc1e6430226127fb6a878d06b458170858..bfadc5613bac614a316e5aed7da95d8c7845cf42 100644
>> --- a/include/migration/misc.h
>> +++ b/include/migration/misc.h
>> @@ -97,7 +97,7 @@ void migration_add_notifier_mode(NotifierWithReturn *notify,
>>   
>>   void migration_remove_notifier(NotifierWithReturn *notify);
>>   bool migration_is_running(void);
>> -void migration_file_set_error(int err);
>> +void migration_file_set_error(int ret, Error *err);
>>   
>>   /* True if incoming migration entered POSTCOPY_INCOMING_DISCARD */
>>   bool migration_in_incoming_postcopy(void);
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index b5102f54a6474a50c6366e8fbce23812d55e384e..ed5ee6349ced78b3bde68d2ee506f78ba1a9dd9c 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -150,7 +150,7 @@ bool vfio_viommu_preset(VFIODevice *vbasedev)
>>   static void vfio_set_migration_error(int err)
> nit: I would have renamed err into ret here to avoid any further confusion.

That was done in v5 :

   https://lore.kernel.org/qemu-devel/20240506092053.388578-11-clg@redhat.com/

in the last patch, that I dropped in v6 because I believe it needs more
work. I will address these last changes, including the err->ret rename,
in a followup series if that's ok with you.


Thanks,

C.




>>   {
>>       if (migration_is_setup_or_active()) {
>> -        migration_file_set_error(err);
>> +        migration_file_set_error(err, NULL);
>>       }
>>   }
>>   
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index 06ae40969b6c19037e190008e14f28be646278cd..bf2fd0759ba6e4fb103cc5c1a43edb180a3d0de4 100644
>> --- a/hw/vfio/migration.c
>> +++ b/hw/vfio/migration.c
>> @@ -726,7 +726,7 @@ static void vfio_vmstate_change_prepare(void *opaque, bool running,
>>            * Migration should be aborted in this case, but vm_state_notify()
>>            * currently does not support reporting failures.
>>            */
>> -        migration_file_set_error(ret);
>> +        migration_file_set_error(ret, NULL);
>>       }
>>   
>>       trace_vfio_vmstate_change_prepare(vbasedev->name, running,
>> @@ -756,7 +756,7 @@ static void vfio_vmstate_change(void *opaque, bool running, RunState state)
>>            * Migration should be aborted in this case, but vm_state_notify()
>>            * currently does not support reporting failures.
>>            */
>> -        migration_file_set_error(ret);
>> +        migration_file_set_error(ret, NULL);
>>       }
>>   
>>       trace_vfio_vmstate_change(vbasedev->name, running, RunState_str(state),
>> diff --git a/migration/migration.c b/migration/migration.c
>> index e88b24f1e6cbe82dad3f890c00e264d2ab6ad355..70d66a441bf04761decf91dbe57ce52c57fde58f 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -2994,13 +2994,15 @@ static MigThrError postcopy_pause(MigrationState *s)
>>       }
>>   }
>>   
>> -void migration_file_set_error(int err)
>> +void migration_file_set_error(int ret, Error *err)
>>   {
>>       MigrationState *s = current_migration;
>>   
>>       WITH_QEMU_LOCK_GUARD(&s->qemu_file_lock) {
>>           if (s->to_dst_file) {
>> -            qemu_file_set_error(s->to_dst_file, err);
>> +            qemu_file_set_error_obj(s->to_dst_file, ret, err);
>> +        } else if (err) {
>> +            error_report_err(err);
>>           }
>>       }
>>   }
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> 
> Eric
> 


