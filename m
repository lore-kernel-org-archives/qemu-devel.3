Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 413EEC48297
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 14:50:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZXcl-0004M5-Kn; Mon, 12 Feb 2024 09:49:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rZXck-0004Li-8V
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 09:49:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rZXcf-0001oW-Oz
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 09:49:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707749366;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F6Bo4/8HWe4sc+9mGtWxRF3NhIpnIgzZtTCkzlq8cqw=;
 b=Gb/NOr52WsYQAMdcKoycE7N9gEwbvBIN6Qdnytl/kVxohgbJljjzkwERj8u83IJVW0D6Z5
 EMcUvUJTWrBbQwKudPKOWro/wEPD7HOSP3McaDuSiL/KDcAlWAy5X2Yrmh7lfhxVvqUS2m
 Sa2hG6nRvcipLZEi6ERkL3bw4W37nmA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-FBIPKbu4NY-IYwPG9VhBow-1; Mon, 12 Feb 2024 09:49:24 -0500
X-MC-Unique: FBIPKbu4NY-IYwPG9VhBow-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7831aaa797aso621540885a.1
 for <qemu-devel@nongnu.org>; Mon, 12 Feb 2024 06:49:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707749364; x=1708354164;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F6Bo4/8HWe4sc+9mGtWxRF3NhIpnIgzZtTCkzlq8cqw=;
 b=wttj/FBSAKIS4X9yJR49dmA2ucBLMt97mnU7Y7CJfLfIdAcEeOd+0WHLNmMw1aGN4o
 gcEH3Rp/1+U8hRjHhz0BYX2LiDvFP/uN0S3aYopugVXmlgIPC9SpmUwHPMvit62IhKsT
 6hOBc9W4b6GiEEFSQkC81QGbnumcq5S6Q9RQt+ai66OyT4vlMcXTREFRpQV/IF/s/hZm
 vVIR8hjODjkg/wOdWN6s/RivEkrObpo2oHr4DvFX7mpXET4l/LkJixCxXQKV8j++rCpC
 ywQPizjvtoZotsevmPsFU7Lf2Pc162Wr2rVdCBorJNiTXJUCY6TmilTIruIfn+UY7gH8
 nMBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCURjMESt4jZ+L5bxpq7qOIjFT0AaaGXBZAswEZDFLUN8r2SP2TC9ahLv373ueB/pohezKndTiZ3zZHVxi+yW81lglmQDeo=
X-Gm-Message-State: AOJu0YwE9q5dJjo8OO4W/oRUWm1BBKCZ0vGGKA+vVwzSmNiebUkw/CAA
 N0/6ihgiy8bmcgGRHSSVxcZLQHTx5EOhoU3uYS6QISLrgDUuzV0UW+PnXAqToeJMbloYaVNXzZ0
 0t45A0Lod9kxDM0ams45Rh+Fmd4blT2pX/OfR3igxXGiugpxRDg3v
X-Received: by 2002:a05:620a:562a:b0:785:469c:3ef5 with SMTP id
 vv10-20020a05620a562a00b00785469c3ef5mr13798689qkn.13.1707749363866; 
 Mon, 12 Feb 2024 06:49:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEykYLXdHc5B4t+dwgKAAajXls6C/8pOGoCfF815Nj/wIpBz50FtH36BcWiEXTGtOUaKOsp2A==
X-Received: by 2002:a05:620a:562a:b0:785:469c:3ef5 with SMTP id
 vv10-20020a05620a562a00b00785469c3ef5mr13798663qkn.13.1707749363557; 
 Mon, 12 Feb 2024 06:49:23 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUd6kfIsvXGa6e+pDxHb/UlzhO+j0AC6osCo2VjUYcxxdUMocxSXaATDj6cP57vOIhY63yVGKyLVMbXTxMAmt7PRr0L8a6N2FR4uI4XDWuihNcv8J+uP8KIMQBTZ+ceHeky4fojCkqPOKMp51M628GGxZE=
Received: from ?IPV6:2a01:cb19:853d:fa00:c28a:3e3d:34f3:3891?
 ([2a01:cb19:853d:fa00:c28a:3e3d:34f3:3891])
 by smtp.gmail.com with ESMTPSA id
 o2-20020a05620a110200b00785d6b12faesm797646qkk.98.2024.02.12.06.49.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Feb 2024 06:49:23 -0800 (PST)
Message-ID: <2052b1e4-608d-4b44-a67c-e1d90e194f81@redhat.com>
Date: Mon, 12 Feb 2024 15:49:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/14] migration: Add Error** argument to .save_setup()
 handler
Content-Language: en-US
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20240207133347.1115903-1-clg@redhat.com>
 <20240207133347.1115903-2-clg@redhat.com>
 <5addf455-c0e0-4aa6-8970-c8050a194783@nvidia.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <5addf455-c0e0-4aa6-8970-c8050a194783@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.774,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2/12/24 09:36, Avihai Horon wrote:
> Hi, Cedric
> 
> On 07/02/2024 15:33, Cédric Le Goater wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> The purpose is to record a potential error in the migration stream if
>> qemu_savevm_state_setup() fails. Most of the current .save_setup()
>> handlers can be modified to use the Error argument instead of managing
>> their own and calling locally error_report(). The following patches
>> will introduce such changes for VFIO first.
>>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   include/migration/register.h   | 2 +-
>>   hw/ppc/spapr.c                 | 2 +-
>>   hw/s390x/s390-stattrib.c       | 2 +-
>>   hw/vfio/migration.c            | 2 +-
>>   migration/block-dirty-bitmap.c | 2 +-
>>   migration/block.c              | 2 +-
>>   migration/ram.c                | 2 +-
>>   migration/savevm.c             | 4 ++--
>>   8 files changed, 9 insertions(+), 9 deletions(-)
>>
>> diff --git a/include/migration/register.h b/include/migration/register.h
>> index 9ab1f79512c605f0c88a45b560c57486fa054441..831600a00eae4efd0464b60925d65de4d9dbcff8 100644
>> --- a/include/migration/register.h
>> +++ b/include/migration/register.h
>> @@ -25,7 +25,7 @@ typedef struct SaveVMHandlers {
>>        * used to perform early checks.
>>        */
>>       int (*save_prepare)(void *opaque, Error **errp);
>> -    int (*save_setup)(QEMUFile *f, void *opaque);
>> +    int (*save_setup)(QEMUFile *f, void *opaque, Error **errp);
>>       void (*save_cleanup)(void *opaque);
>>       int (*save_live_complete_postcopy)(QEMUFile *f, void *opaque);
>>       int (*save_live_complete_precopy)(QEMUFile *f, void *opaque);
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index 0d72d286d80f0435122593555f79fae4d90acf81..a1b0aa02582ad2d68a13476c1859b18143da7bb8 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -2142,7 +2142,7 @@ static const VMStateDescription vmstate_spapr = {
>>       }
>>   };
>>
>> -static int htab_save_setup(QEMUFile *f, void *opaque)
>> +static int htab_save_setup(QEMUFile *f, void *opaque, Error **errp)
>>   {
>>       SpaprMachineState *spapr = opaque;
>>
>> diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
>> index c483b62a9b5f71772639fc180bdad15ecb6711cb..c934df424a555d83d2198f5ddfc0cbe0ea98e9ec 100644
>> --- a/hw/s390x/s390-stattrib.c
>> +++ b/hw/s390x/s390-stattrib.c
>> @@ -166,7 +166,7 @@ static int cmma_load(QEMUFile *f, void *opaque, int version_id)
>>       return ret;
>>   }
>>
>> -static int cmma_save_setup(QEMUFile *f, void *opaque)
>> +static int cmma_save_setup(QEMUFile *f, void *opaque, Error **errp)
>>   {
>>       S390StAttribState *sas = S390_STATTRIB(opaque);
>>       S390StAttribClass *sac = S390_STATTRIB_GET_CLASS(sas);
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index 70e6b1a709f9b67e4c9eb41033d76347275cac42..8bcb4bc73cd5ba5338e3ffa4d907d0e6bfbb9485 100644
>> --- a/hw/vfio/migration.c
>> +++ b/hw/vfio/migration.c
>> @@ -378,7 +378,7 @@ static int vfio_save_prepare(void *opaque, Error **errp)
>>       return 0;
>>   }
>>
>> -static int vfio_save_setup(QEMUFile *f, void *opaque)
>> +static int vfio_save_setup(QEMUFile *f, void *opaque, Error **errp)
>>   {
>>       VFIODevice *vbasedev = opaque;
>>       VFIOMigration *migration = vbasedev->migration;
>> diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
>> index 2708abf3d762de774ed294d3fdb8e56690d2974c..16f84e6c57c2403a8c2d6319f4e7b6360dade28c 100644
>> --- a/migration/block-dirty-bitmap.c
>> +++ b/migration/block-dirty-bitmap.c
>> @@ -1213,7 +1213,7 @@ fail:
>>       return ret;
>>   }
>>
>> -static int dirty_bitmap_save_setup(QEMUFile *f, void *opaque)
>> +static int dirty_bitmap_save_setup(QEMUFile *f, void *opaque, Error **errp)
>>   {
>>       DBMSaveState *s = &((DBMState *)opaque)->save;
>>       SaveBitmapState *dbms = NULL;
>> diff --git a/migration/block.c b/migration/block.c
>> index 8c6ebafacc1ffe930d1d4f19d968817b14852c69..df15319ceab66201b043f15eac1b0a7d6522b60c 100644
>> --- a/migration/block.c
>> +++ b/migration/block.c
>> @@ -708,7 +708,7 @@ static void block_migration_cleanup(void *opaque)
>>       blk_mig_unlock();
>>   }
>>
>> -static int block_save_setup(QEMUFile *f, void *opaque)
>> +static int block_save_setup(QEMUFile *f, void *opaque, Error **errp)
>>   {
>>       int ret;
>>
>> diff --git a/migration/ram.c b/migration/ram.c
>> index d5b7cd5ac2f31aabf4a248b966153401c48912cf..136c237f4079f68d4e578cf1c72eec2efc815bc8 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -2931,7 +2931,7 @@ void qemu_guest_free_page_hint(void *addr, size_t len)
>>    * @f: QEMUFile where to send the data
>>    * @opaque: RAMState pointer
>>    */
>> -static int ram_save_setup(QEMUFile *f, void *opaque)
>> +static int ram_save_setup(QEMUFile *f, void *opaque, Error **errp)
>>   {
>>       RAMState **rsp = opaque;
>>       RAMBlock *block;
>> diff --git a/migration/savevm.c b/migration/savevm.c
>> index d612c8a9020b204d5d078d5df85f0e6449c27645..f2ae799bad13e631bccf733a34c3a8fd22e8dd48 100644
>> --- a/migration/savevm.c
>> +++ b/migration/savevm.c
>> @@ -1342,10 +1342,10 @@ void qemu_savevm_state_setup(QEMUFile *f)
>>           }
>>           save_section_header(f, se, QEMU_VM_SECTION_START);
>>
>> -        ret = se->ops->save_setup(f, se->opaque);
>> +        ret = se->ops->save_setup(f, se->opaque, &local_err);
>>           save_section_footer(f, se);
>>           if (ret < 0) {
>> -            qemu_file_set_error(f, ret);
>> +            qemu_file_set_error_obj(f, ret, local_err);
> 
> Should we set local_err = NULL? 

possibly, yes.

> Because it is re-used a few lines after this, by precopy_notify().

I wonder why is precopy_notify(PRECOPY_NOTIFY_SETUP) even called when
there was an error in one of the save_setup() handlers. It probably
shouldn't and qemu_savevm_state_setup() should return at the first
error in the loop. This is something that could have been overlooked
by commit bd2270608fa0 "migration/ram.c: add a notifier chain for
precopy" because qemu_savevm_state_setup() does not have a return
value. Probably because the callers rely on qemu_file_get_error()
to know if something wrong happened.

Also, the only user of PRECOPY_NOTIFY_SETUP is virtio-balloon and
nothing is done. PrecopyNotifyData has an errp attribute which is
unused.

> 
> BTW, I think that if we add Error** parameter to functions we must make sure all their error flows set errp as well.
> According to Error API:
> * - On success, the function should not touch *errp.  On failure, it
> *   should set a new error, e.g. with error_setg(errp, ...), or
> *   propagate an existing one, e.g. with error_propagate(errp, ...).
> 
> For example, a caller that handles errors by printing them with error_report_err() would crash when trying to access NULL error object (if some error path didn't set errp).

One of the underlying goal is to avoid and remove all error_report_err()
calls to propagate the error up the call stack.

> If you agree, we should check it throughout the series.

I do agree and this is a can of worms ! I haven't quite found my way
around yet.

Thanks for your inputs,

C.


