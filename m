Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF315C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 08:45:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfZWF-000611-E0; Fri, 03 Jul 2026 04:45:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wfZWD-00060Y-Bu
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 04:45:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wfZWA-00059E-1p
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 04:45:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783068300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=EqWwaHXocnRjHL6nJw1doJCTnF0D3BD68hfuDpaC2eY=;
 b=MKZfYYlvY7gLW7hLhywyma4s4z9lwvNBt/cyDjQReUTsDuapc2slhqr2eeKp6IQb46pOGx
 n0HoV3Oa8gyPf0xxd/CZjbUkrf5a7SVBR301qK11bLht1nohQKpGZOj/Xaqn1H/gYuUYwG
 WHJleBD7U7s9yekp3uWZJ1o+VTxRWiA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-hBu8MObaOA6pOAfIxTqPxQ-1; Fri, 03 Jul 2026 04:44:58 -0400
X-MC-Unique: hBu8MObaOA6pOAfIxTqPxQ-1
X-Mimecast-MFC-AGG-ID: hBu8MObaOA6pOAfIxTqPxQ_1783068297
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-4760c900cf3so31796f8f.0
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 01:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783068297; x=1783673097; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=EqWwaHXocnRjHL6nJw1doJCTnF0D3BD68hfuDpaC2eY=;
 b=aqJKT3AZV22PhJC7u/RAW1mFXRZpeG04xAJXUjHxEOcHGYTjQKNghTCQ5afv7FFqJf
 5okIpU/NniRNnGzcv7vof/77TvP0SSy9j9tzqdoUs6KnbSBoWbAmytiOdvQt6Q7RvlcP
 GA0M7y+voH9Nd9OAc1wQaD7TwWRx6HM6uoK3ydjW0UUOYwU0aFz6y4ASFiN37XmMpFdx
 Po1UetV4NPSlDp6cBNZZXORQzV9bE0Y40yjz75oUR6NjiLMhUG9p3RQeWVG3Xtots5Cf
 rkQQQq7X34A0WjzZ2n1hf7eUFlyXfIHs+JiRRiNcRzKMJQLxaWaG0MCPu5cdMht0J2sf
 MFAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783068297; x=1783673097;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EqWwaHXocnRjHL6nJw1doJCTnF0D3BD68hfuDpaC2eY=;
 b=IiS2+sv8/CLbIxSMywfMqE4zbdUqKzrtIeWm2XIPZRniBBe5uhQq0o3BITTpsVb2Ru
 Jz9WWuiOrLHbDeiHjH1aFHHPjr/bzZ/ZX4eaYqdixMl8UsarJfA9RGBO2+c1qe9Yq3z9
 apqEu0YIl99ky3OG0hoDXq2vKHyFHIFi3EicqpmkJS4i2goTPOgO3sjao2eS+zHI5K6E
 m48VmRZyGCjapjjo1QbYIrr31PTI3I3jkTxjqmEjtmvYCQq25qG+nyqI2FwELipLhIjD
 hwKGyWASw+tG7BUGOMpesSy1g12ddmkH5eTqMqigASUWBBc3rmX8OE9B84YDwHDarS7L
 1B4w==
X-Forwarded-Encrypted: i=1;
 AHgh+RpRnzxoyJ1RPxmc0FfM2nIQUupZOu3DHs3kNvbstl5SJ8ulmeNwfdOxPBowPHLZrwDnb2E7uj/axe7d@nongnu.org
X-Gm-Message-State: AOJu0YxQWL1MKD7gv/E67GFkuDq+lzrX5avBqjPVTetqbgArrRXliMcO
 JkGwg6FmUXFKtEDGul1nE4UvA4G7ELp0dTQ8nRLGcZ/CJ85MVFB/T+lPIcZcnqNwwwRuC9nU5AC
 fEeUvBavU3ef+TFnDsQC5vG6DN5oFLixOVJh3U5VWfIHnCmjsGhsLlRwTe9IaTYJz
X-Gm-Gg: AfdE7cn+9i4h5WAh0UCiv0WeLrMWTk0+MlV19aLptgeNiy/YWKM56aW8/JRm/Cvqlv+
 yQQxzPq7LdDk2Fqc55+hxHkR3lijreHPNJM4MRnLmGFIJ9DxozOgLTuCNzmDqUWSti/XP+/itux
 lRr0uHr/vik+AKMBw/n4Y1x3cS2geMhPhOo4P9EDWP/ZyGjFADAWfEN4ib0A8xy6m3zxh91U+zT
 +fmmjZgWejq3gEWiVI9wyGiMN5Ev9dRsmOQOwikuY4McFdCLbDXCrj+abeMvotNsXuGE0su/hii
 0IofwS8LdMrzvewyL3enePMKCWFRXXouvqEfsgUmKJBGnW91fY9NbgNZ96CA24Y+ajCi2ynIhy/
 krhjqTIeLQkaGzUOSawfuEUVc1/WMu9WbuUv4/KNk9R3xp206TA==
X-Received: by 2002:a05:6000:2001:b0:474:3708:c8 with SMTP id
 ffacd0b85a97d-47935807253mr4658199f8f.15.1783068296863; 
 Fri, 03 Jul 2026 01:44:56 -0700 (PDT)
X-Received: by 2002:a05:6000:2001:b0:474:3708:c8 with SMTP id
 ffacd0b85a97d-47935807253mr4658141f8f.15.1783068296191; 
 Fri, 03 Jul 2026 01:44:56 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477db8a4ad4sm17281031f8f.11.2026.07.03.01.44.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jul 2026 01:44:55 -0700 (PDT)
Message-ID: <df58c2d0-cc0c-43c2-9dd3-ea0614de7d72@redhat.com>
Date: Fri, 3 Jul 2026 10:44:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 08/23] migration: Run final save_query_pending at switchover
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@gmail.com>
Cc: Peter Xu <peterx@redhat.com>, "Jason J. Herne" <jjhern@linux.ibm.com>,
 Lukas Straub <lukasstraub2@web.de>
References: <20260630043107.1511076-1-clg@redhat.com>
 <20260630043107.1511076-9-clg@redhat.com>
 <a82ece02-d9fd-4ea4-b934-a9bc5abde663@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <a82ece02-d9fd-4ea4-b934-a9bc5abde663@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 7/3/26 10:05, Avihai Horon wrote:
> 
> On 6/30/2026 7:30 AM, Cédric Le Goater wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> From: Avihai Horon <avihaih@nvidia.com>
>>
>> Before switchover, the source needs one last exact pending query so
>> modules can flush dirty state. This is currently done ad hoc in modules
>> handlers. For example, RAM syncs its dirty bitmap in its save_complete
>> handler.
>>
>> This should be a general concept relevant for any module, so extract it
>> to migration core instead by running a final save_query_pending before
>> switchover.
>>
>> The final query requires special handling by modules (e.g., it's called
>> with BQL locked, during VM stop), so extend save_query_pending
>> SaveVMHandlers callback and qemu_savevm_query_pending() with a "final"
>> flag so migration modules can tell the last pending query during
>> switchover from periodic iteration queries.
>>
>> Reviewed-by: Peter Xu <peterx@redhat.com>
>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>> Reviewed-by: Jason J. Herne <jjhern@linux.ibm.com>
>> Link: https://lore.kernel.org/qemu-devel/20260622101214.25770-4-avihaih@nvidia.com
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   include/migration/register.h   | 41 ++++++++++++++++++----------------
>>   migration/savevm.h             |  3 ++-
>>   hw/s390x/s390-stattrib.c       |  2 +-
>>   hw/vfio/migration.c            | 11 ++++++---
>>   migration/block-dirty-bitmap.c | 11 ++++++---
>>   migration/migration.c          | 14 ++++++++++--
>>   migration/ram.c                | 40 +++++++++++++++++++--------------
>>   migration/savevm.c             | 20 +++++++++++++----
>>   hw/vfio/trace-events           |  2 +-
>>   migration/trace-events         |  2 +-
>>   10 files changed, 94 insertions(+), 52 deletions(-)
>>
>> diff --git a/include/migration/register.h b/include/migration/register.h
>> index 5e5e0ee432e537781ce78e84b2ff2d81c33e8f37..6f632123f1d0710de0556e68ba53e068a1e02640 100644
>> --- a/include/migration/register.h
>> +++ b/include/migration/register.h
>> @@ -171,6 +171,28 @@ typedef struct SaveVMHandlers {
>>        */
>>       bool (*is_active_iterate)(void *opaque);
>>
>> +    /**
>> +     * @save_query_pending
>> +     *
>> +     * This estimates the remaining data to transfer on the source side.
>> +     *
>> +     * When @exact is true, a module must report accurate results.  When
>> +     * @exact is false, a module may report estimates.
>> +     *
>> +     * It's highly recommended that modules implement a faster version of
>> +     * the query path (for example, by proper caching on the counters) if
>> +     * an accurate query will be time-consuming.
>> +     *
>> +     * @opaque: data pointer passed to register_savevm_live()
>> +     * @pending: pointer to a MigPendingData struct
>> +     * @exact: set to true for an accurate (slow) query
>> +     * @final: set to true for the final query during switchover. When final is
>> +     * true, the query is called with BQL locked. Otherwise, it's called with
>> +     * BQL unlocked.
>> +     */
>> +    void (*save_query_pending)(void *opaque, MigPendingData *pending,
>> +                               bool exact, bool final);
>> +
>>       /* This runs outside the BQL in the migration case, and
>>        * within the lock in the savevm case.  The callback had better only
>>        * use data that is local to the migration thread or protected
>> @@ -210,25 +232,6 @@ typedef struct SaveVMHandlers {
>>        */
>>       bool (*save_postcopy_prepare)(QEMUFile *f, void *opaque, Error **errp);
>>
>> -    /**
>> -     * @save_query_pending
>> -     *
>> -     * This estimates the remaining data to transfer on the source side.
>> -     *
>> -     * When @exact is true, a module must report accurate results.  When
>> -     * @exact is false, a module may report estimates.
>> -     *
>> -     * It's highly recommended that modules implement a faster version of
>> -     * the query path (for example, by proper caching on the counters) if
>> -     * an accurate query will be time-consuming.
>> -     *
>> -     * @opaque: data pointer passed to register_savevm_live()
>> -     * @pending: pointer to a MigPendingData struct
>> -     * @exact: set to true for an accurate (slow) query
>> -     */
>> -    void (*save_query_pending)(void *opaque, MigPendingData *pending,
>> -                               bool exact);
>> -
>>       /**
>>        * @load_state
>>        *
>> diff --git a/migration/savevm.h b/migration/savevm.h
>> index b6bb4fa977fae84ed121b0668cdefdf49e3d9c67..81abd96dda94c6c95cc40b3c188df23d11c19463 100644
>> --- a/migration/savevm.h
>> +++ b/migration/savevm.h
>> @@ -45,7 +45,8 @@ int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy);
>>   void qemu_savevm_state_cleanup(void);
>>   void qemu_savevm_state_complete_postcopy(QEMUFile *f);
>>   int qemu_savevm_state_complete_precopy(MigrationState *s, Error **errp);
>> -void qemu_savevm_query_pending(MigPendingData *pending, bool exact);
>> +void qemu_savevm_query_pending_iter(MigPendingData *pending, bool exact);
>> +void qemu_savevm_query_pending_final(MigPendingData *pending);
>>   int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy);
>>   bool qemu_savevm_state_postcopy_prepare(QEMUFile *f, Error **errp);
>>   void qemu_savevm_state_end(QEMUFile *f);
>> diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
>> index c334714b31ab4313e26c0cf57091a8cb21e55306..b0f04eb30c7f73e5dd91b1345d71a14cb404a4eb 100644
>> --- a/hw/s390x/s390-stattrib.c
>> +++ b/hw/s390x/s390-stattrib.c
>> @@ -190,7 +190,7 @@ static int cmma_save_setup(QEMUFile *f, void *opaque, Error **errp)
>>   }
>>
>>   static void cmma_state_pending(void *opaque, MigPendingData *pending,
>> -                               bool exact)
>> +                               bool exact, bool final)
>>   {
>>       S390StAttribState *sas = S390_STATTRIB(opaque);
>>       S390StAttribClass *sac = S390_STATTRIB_GET_CLASS(sas);
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index fb12b9717f773fdde657911517de9d74c1eb3931..195498845ed95d6a55cf68537a100b4e83221fb0 100644
>> --- a/hw/vfio/migration.c
>> +++ b/hw/vfio/migration.c
>> @@ -622,13 +622,18 @@ static void vfio_state_pending_sync(VFIODevice *vbasedev)
>>   }
>>
>>   static void vfio_state_pending(void *opaque, MigPendingData *pending,
>> -                               bool exact)
>> +                               bool exact, bool final)
>>   {
>>       VFIODevice *vbasedev = opaque;
>>       VFIOMigration *migration = vbasedev->migration;
>>       uint64_t precopy_size, stopcopy_size;
>>
>> -    if (exact) {
>> +    /*
>> +     * The final pending query runs during switchover downtime. VFIO does not
>> +     * need a fresh device pending-data query then to get the latest dirty
>> +     * data, so avoid the extra work and report the cached counters below.
>> +     */
>> +    if (exact && !final) {
>>           vfio_state_pending_sync(vbasedev);
>>       }
>>
>> @@ -646,7 +651,7 @@ static void vfio_state_pending(void *opaque, MigPendingData *pending,
>>
>>       trace_vfio_state_pending(vbasedev->name, migration->stopcopy_size,
>>                                migration->precopy_init_size,
>> -                             migration->precopy_dirty_size, exact);
>> +                             migration->precopy_dirty_size, exact, final);
>>   }
>>
>>   static bool vfio_is_active_iterate(void *opaque)
>> diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
>> index 7ef3759e5348a6907c0fb3773e2c6cbb0850632e..cba54e25cd50da924e1958bdfc23ce060784b0ac 100644
>> --- a/migration/block-dirty-bitmap.c
>> +++ b/migration/block-dirty-bitmap.c
>> @@ -767,13 +767,16 @@ static int dirty_bitmap_save_complete(QEMUFile *f, void *opaque)
>>   }
>>
>>   static void dirty_bitmap_state_pending(void *opaque, MigPendingData *data,
>> -                                       bool exact)
>> +                                       bool exact, bool final)
>>   {
>>       DBMSaveState *s = &((DBMState *)opaque)->save;
>>       SaveBitmapState *dbms;
>>       uint64_t pending = 0;
>>
>> -    bql_lock();
>> +    /* Final pending query is called with BQL locked */
>> +    if (!final) {
>> +        bql_lock();
>> +    }
>>
>>       QSIMPLEQ_FOREACH(dbms, &s->dbms_list, entry) {
>>           uint64_t gran = bdrv_dirty_bitmap_granularity(dbms->bitmap);
>> @@ -783,7 +786,9 @@ static void dirty_bitmap_state_pending(void *opaque, MigPendingData *data,
>>           pending += DIV_ROUND_UP(sectors * BDRV_SECTOR_SIZE, gran);
>>       }
>>
>> -    bql_unlock();
>> +    if (!final) {
>> +        bql_unlock();
>> +    }
>>
>>       trace_dirty_bitmap_state_pending(pending);
>>
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 0f9e891cf85c8e5074f7f9800515e244fa413fa2..ea0b236597087cc005541e1916ceabb229afab4b 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -2787,12 +2787,22 @@ static bool migration_switchover_prepare(MigrationState *s)
>>   static bool migration_switchover_start(MigrationState *s, Error **errp)
>>   {
>>       ERRP_GUARD();
>> +    MigPendingData pending = {};
>>
>>       if (!migration_switchover_prepare(s)) {
>>           error_setg(errp, "Switchover is interrupted");
>>           return false;
>>       }
>>
>> +    /*
>> +     * The final query to the whole system on dirty data to make sure we
>> +     * collect the latest status of the VM.  For precopy, source QEMU will
>> +     * dump all the dirty data during switchover.  For postcopy, this will
>> +     * properly update all the dirty bitmaps to finally generate the
>> +     * correct discard bitmaps; see ram_postcopy_send_discard_bitmap().
>> +     */
>> +    qemu_savevm_query_pending_final(&pending);
>> +
>>       /* Inactivate disks except in COLO */
>>       if (!migrate_colo()) {
>>           /*
>> @@ -3285,7 +3295,7 @@ static void migration_iteration_go_next(MigPendingData *pending)
>>       /*
>>        * Do a slow sync first before boosting the iteration count.
>>        */
>> -    qemu_savevm_query_pending(pending, true);
>> +    qemu_savevm_query_pending_iter(pending, true);
>>
>>       /*
>>        * Update the dirty information for the whole system for this
>> @@ -3336,7 +3346,7 @@ static MigIterateState migration_iteration_run(MigrationState *s)
>>       bool complete_ready;
>>
>>       /* Fast path - get the estimated amount of pending data */
>> -    qemu_savevm_query_pending(&pending, false);
>> +    qemu_savevm_query_pending_iter(&pending, false);
>>
>>       if (in_postcopy) {
>>           /*
>> diff --git a/migration/ram.c b/migration/ram.c
>> index 55aa9b47dc8ab8463fd1aeba19726a493b81b070..8918b2f03b6fbcc98532bb45ab905f9bac59384c 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -2686,9 +2686,6 @@ void ram_postcopy_send_discard_bitmap(MigrationState *ms)
>>
>>       RCU_READ_LOCK_GUARD();
>>
>> -    /* This should be our last sync, the src is now paused */
>> -    migration_bitmap_sync_precopy(true);
>> -
>>       /* Easiest way to make sure we don't resume in the middle of a host-page */
>>       rs->pss[RAM_CHANNEL_PRECOPY].last_sent_block = NULL;
>>       rs->last_seen_block = NULL;
>> @@ -3376,10 +3373,6 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
>>       rs->last_stage = !migration_in_colo_state();
>>
>>       WITH_RCU_READ_LOCK_GUARD() {
>> -        if (!migration_in_postcopy()) {
>> -            migration_bitmap_sync_precopy(true);
>> -        }
>> -
> 
> (Got some technical issues receiving QEMU ML mails that I'm not CCed to, so replying here for Stefan's mail [1])
> 
> Seems like this patch overlooked the COLO case which calls ram_save_complete() on each checkpoint and expects the RAM complete handler to sync RAM dirty bitmap.
> This patch moved this dirty sync from ram_save_complete() (the removed lines above) into a qemu_savevm_query_pending_final() called only once at migration_switchover_start().
> 
> I believe this is the root cause for the CI failure reported by Stefan, since I was able to repro this locally [2] and the diff below [3] fixed the issue [4].
> 
> I have zero knowledge in COLO so would really appreciate some feedback from Peter/COLO folks if that's a valid fix.
> 
> Thanks.
> 
> [1] https://lore.kernel.org/qemu-devel/CAJSP0QX-8L2CSX5q95Md5V6NTE_4p+K8Kr-QGbqKm2BBMtdh5Q@mail.gmail.com/
> 
> [2]
> 
> QTEST_QEMU_BINARY=./qemu-system-x86_64  ./tests/qtest/migration-test -k --full -r /x86_64/migration/colo
> [...]
> # Running /x86_64/migration/colo/plain/secondary_failover
> # Using machine type: pc-q35-11.1
> # starting QEMU: exec ./qemu-system-x86_64 -qtest unix:/tmp/qtest-1415533.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-1415533.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio
> none -run-with exit-with-parent=on -accel kvm -accel tcg -machine pc-q35-11.1, -name source,debug-threads=on -machine memory-backend=mig.mem -object memory-backend-ram,id=mig.mem,size=150M,share=off -serial
>   file:/tmp/migration-test-GF36R3/src_serial -drive if=none,id=d0,file=/tmp/migration-test-GF36R3/bootsect,format=raw -device ide-hd,drive=d0,secs=1,cyls=1,heads=1 -snapshot 2>/dev/null -accel qtest
> # starting QEMU: exec ./qemu-system-x86_64 -qtest unix:/tmp/qtest-1415533.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-1415533.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio
> none -run-with exit-with-parent=on -accel kvm -accel tcg -machine pc-q35-11.1, -name target,debug-threads=on -machine memory-backend=mig.mem -object memory-backend-ram,id=mig.mem,size=150M,share=off -serial
>   file:/tmp/migration-test-GF36R3/dest_serial -incoming defer -drive if=none,id=d0,file=/tmp/migration-test-GF36R3/bootsect,format=raw -device ide-hd,drive=d0,secs=1,cyls=1,heads=1 -snapshot 2>/dev/null  -a
> ccel qtest
> Memory content inconsistency at ea2000 first_byte = 53 last_byte = 53 current = 54 hit_edge = 0
> Memory content inconsistency at ea3000 first_byte = 53 last_byte = 53 current = 54 hit_edge = 0
> Memory content inconsistency at ea4000 first_byte = 53 last_byte = 53 current = 54 hit_edge = 0
> Memory content inconsistency at ea5000 first_byte = 53 last_byte = 53 current = 54 hit_edge = 0
> Memory content inconsistency at ea6000 first_byte = 53 last_byte = 53 current = 54 hit_edge = 0
> Memory content inconsistency at ea7000 first_byte = 53 last_byte = 53 current = 54 hit_edge = 0
> Memory content inconsistency at ea8000 first_byte = 53 last_byte = 53 current = 54 hit_edge = 0
> Memory content inconsistency at ea9000 first_byte = 53 last_byte = 53 current = 54 hit_edge = 0
> Memory content inconsistency at eaa000 first_byte = 53 last_byte = 53 current = 54 hit_edge = 0
> Memory content inconsistency at eab000 first_byte = 53 last_byte = 53 current = 54 hit_edge = 0
> and in another 13488 pages**
> ERROR:../tests/qtest/migration/framework.c:190:check_guests_ram: assertion failed: (bad == 0)
> not ok /x86_64/migration/colo/plain/secondary_failover - ERROR:../tests/qtest/migration/framework.c:190:check_guests_ram: assertion failed: (bad == 0)
> Bail out!
> 
> [3]
> 
> diff --git a/migration/colo.c b/migration/colo.c
> index 2d36f933cf..5c486c09ef 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -409,6 +409,7 @@ static int colo_do_checkpoint_transaction(MigrationState *s,
>                                             QEMUFile *fb)
>   {
>       Error *local_err = NULL;
> +    MigPendingData pending = {};
>       int ret = -1;
> 
>       colo_send_message(s->to_dst_file, COLO_MESSAGE_CHECKPOINT_REQUEST,
> @@ -465,6 +466,18 @@ static int colo_do_checkpoint_transaction(MigrationState *s,
>       if (migrate_auto_converge()) {
>           mig_throttle_counter_reset();
>       }
> +
> +    /*
> +     * Run the final pending query so migration modules can flush their dirty
> +     * state (e.g., RAM syncs its dirty bitmap) before this checkpoint's live
> +     * state is saved. Unlike a regular switchover, COLO reaches completion
> +     * repeatedly for every checkpoint, so this must be done on each one.
> +     */
> +    if (!qemu_savevm_query_pending_final(s, &pending, &local_err)) {
> +        bql_unlock();
> +        goto out;
> +    }
> +
>       /*
>        * Only save VM's live state, which not including device state.
>        * TODO: We may need a timeout mechanism to prevent COLO process
> 
> [4]
> 
> QTEST_QEMU_BINARY=./qemu-system-x86_64  ./tests/qtest/migration-test -k --full -r /x86_64/migration/colo
> [...]
> # Running /x86_64/migration/colo/plain/secondary_failover
> # Using machine type: pc-q35-11.1
> # starting QEMU: exec ./qemu-system-x86_64 -qtest unix:/tmp/qtest-1417324.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-1417324.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio
> none -run-with exit-with-parent=on -accel kvm -accel tcg -machine pc-q35-11.1, -name source,debug-threads=on -machine memory-backend=mig.mem -object memory-backend-ram,id=mig.mem,size=150M,share=off -serial
>   file:/tmp/migration-test-0TMNR3/src_serial -drive if=none,id=d0,file=/tmp/migration-test-0TMNR3/bootsect,format=raw -device ide-hd,drive=d0,secs=1,cyls=1,heads=1 -snapshot 2>/dev/null -accel qtest
> # starting QEMU: exec ./qemu-system-x86_64 -qtest unix:/tmp/qtest-1417324.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-1417324.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio
> none -run-with exit-with-parent=on -accel kvm -accel tcg -machine pc-q35-11.1, -name target,debug-threads=on -machine memory-backend=mig.mem -object memory-backend-ram,id=mig.mem,size=150M,share=off -serial
>   file:/tmp/migration-test-0TMNR3/dest_serial -incoming defer -drive if=none,id=d0,file=/tmp/migration-test-0TMNR3/bootsect,format=raw -device ide-hd,drive=d0,secs=1,cyls=1,heads=1 -snapshot 2>/dev/null  -a
> ccel qtest
> ok 2 /x86_64/migration/colo/plain/secondary_failover


The culprit appears to be patch 3:

   migration: Run final save_query_pending at switchover

I can reproduce the issue consistently with:

while [ 1 ]; do
     QTEST_QEMU_BINARY=./build/qemu-system-s390x \
         ./build/tests/qtest/migration-test \
         --full -p /s390x/migration/colo/plain/secondary_failover_checkpoint || break
done

The patch you proposed seems to fix the issue.

Could you send it as a follow-up patch? if Peter, Fabiano, Lukas
would prefer it to be integrated in the appropriate place, it
could be included in v5.


Thanks,

C.


