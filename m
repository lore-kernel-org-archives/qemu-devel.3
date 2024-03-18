Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E662C54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 16:04:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmFSw-0001mX-Ra; Mon, 18 Mar 2024 12:03:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rmFSp-0001la-9p
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 12:03:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rmFSn-0002OK-En
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 12:03:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710777828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PjY7HyyMwQrzb4a21TvFAWOcZSkY3a6v6XuuB6ztZFg=;
 b=XIVfEv+V9duMC+QTVS40UeAkEVz/E6vKQ/2WgTe8fYMtSmTvS8mZUPfrV25hFnaRzbdRaI
 kZdFGDzQpjnXFDKBwda3OZFYrpH8CwY3AjmdPbrQy0lndHN2iCqBc95cdBY1fmA+2k6L3q
 VGub9phGJiPIRHRSGRRICXReLOXcw5E=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-qWh7qqe5NTaMtd4OZTOBlg-1; Mon, 18 Mar 2024 12:03:46 -0400
X-MC-Unique: qWh7qqe5NTaMtd4OZTOBlg-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-513eaadf2bbso1403603e87.3
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 09:03:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710777825; x=1711382625;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PjY7HyyMwQrzb4a21TvFAWOcZSkY3a6v6XuuB6ztZFg=;
 b=oD0dnxse6N6KGxfTiITR2CDJWjKvxLvCkmhbH5KSEJZ1Lw3pdsLhcJzLegpCuZwmwB
 ZWYdvwqOlmMs5KV+Drh2nJlhVoVv2FiBdu9NZ8O2pVAoxFenmT5mmqau4YEQqiYbakUl
 PWritCmZZmMmdBj+ls8X5vueZ75PYMYwuzyegLCPhKNSuNtN09OpiV1o3BZ+Yjsgh3iT
 eWgyqHi6JgImtWd9frWY/vqCRw0hG+5IN5XPfucgrazss0kSuMSf8xu976+3EtbphehW
 w2mfYiYXbC1XUitbLsg42Gy28FkHUxTeWFvFIaKFMTZr9eax+pqQcSVkBd1U6Kmo2YKo
 /mcg==
X-Gm-Message-State: AOJu0YwNRR+I1LBb2tRAZcFew67kRIxMUWJT6JxSIYY61V8GkRrjEIG5
 3KCeXBUGM383woqh+MYxrpqH5jprlUk8QGTaTfyOX9LPe3VPXO/ji3SFGwQvhoDcQVxu0KV+kst
 NWgcJ++Cim6xK6H3MCvc+Oh1bCPQ5RJ3X2lgZDrWQw+7WbRtnQIgDuU4PjnG6
X-Received: by 2002:a19:9152:0:b0:513:cae4:c88f with SMTP id
 y18-20020a199152000000b00513cae4c88fmr8597079lfj.20.1710777824894; 
 Mon, 18 Mar 2024 09:03:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFx/MdFdTmhsRSmyl30Ecml7e6F2nniNbPs3qklOd/rdVIEnP/2fcNvj6t3/oZHIURFzxjcCQ==
X-Received: by 2002:a19:9152:0:b0:513:cae4:c88f with SMTP id
 y18-20020a199152000000b00513cae4c88fmr8597054lfj.20.1710777824423; 
 Mon, 18 Mar 2024 09:03:44 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ba12-20020a0560001c0c00b0033fc06f2d84sm5856528wrb.109.2024.03.18.09.03.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Mar 2024 09:03:43 -0700 (PDT)
Message-ID: <219088f1-ed81-40bf-aff8-0652f4b1a001@redhat.com>
Date: Mon, 18 Mar 2024 17:03:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/25] memory: Add Error** argument to the
 global_dirty_log routines
Content-Language: en-US, fr
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>, Hyman Huang <yong.huang@smartx.com>
References: <20240306133441.2351700-1-clg@redhat.com>
 <20240306133441.2351700-15-clg@redhat.com> <ZfQyRu7nt6M6uzTJ@x1n>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <ZfQyRu7nt6M6uzTJ@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
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

On 3/15/24 12:34, Peter Xu wrote:
> On Wed, Mar 06, 2024 at 02:34:29PM +0100, Cédric Le Goater wrote:
>> Now that the log_global*() handlers take an Error** parameter and
>> return a bool, do the same for memory_global_dirty_log_start() and
>> memory_global_dirty_log_stop(). The error is reported in the callers
>> for now and it will be propagated in the call stack in the next
>> changes.
>>
>> To be noted a functional change in ram_init_bitmaps(), if the dirty
>> pages logger fails to start, there is no need to synchronize the dirty
>> pages bitmaps. colo_incoming_start_dirty_log() could be modified in a
>> similar way.
>>
>> Cc: Stefano Stabellini <sstabellini@kernel.org>
>> Cc: Anthony Perard <anthony.perard@citrix.com>
>> Cc: Paul Durrant <paul@xen.org>
>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Hyman Huang <yong.huang@smartx.com>
>> Reviewed-by: Hyman Huang <yong.huang@smartx.com>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>
>>   Changes in v4:
>>
>>   - Dropped log_global_stop() and log_global_sync() changes
>>   
>>   include/exec/memory.h |  5 ++++-
>>   hw/i386/xen/xen-hvm.c |  2 +-
>>   migration/dirtyrate.c | 13 +++++++++++--
>>   migration/ram.c       | 22 ++++++++++++++++++++--
>>   system/memory.c       | 11 +++++------
>>   5 files changed, 41 insertions(+), 12 deletions(-)
>>
>> diff --git a/include/exec/memory.h b/include/exec/memory.h
>> index 5555567bc4c9fdb53e8f63487f1400980275687d..c129ee6db7162504bd72d4cfc69b5affb2cd87e8 100644
>> --- a/include/exec/memory.h
>> +++ b/include/exec/memory.h
>> @@ -2570,8 +2570,11 @@ void memory_listener_unregister(MemoryListener *listener);
>>    * memory_global_dirty_log_start: begin dirty logging for all regions
>>    *
>>    * @flags: purpose of starting dirty log, migration or dirty rate
>> + * @errp: pointer to Error*, to store an error if it happens.
>> + *
>> + * Return: true on success, else false setting @errp with error.
>>    */
>> -void memory_global_dirty_log_start(unsigned int flags);
>> +bool memory_global_dirty_log_start(unsigned int flags, Error **errp);
>>   
>>   /**
>>    * memory_global_dirty_log_stop: end dirty logging for all regions
>> diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
>> index 0608ca99f5166fd6379ee674442484e805eff9c0..57cb7df50788a6c31eff68c95e8eaa856fdebede 100644
>> --- a/hw/i386/xen/xen-hvm.c
>> +++ b/hw/i386/xen/xen-hvm.c
>> @@ -654,7 +654,7 @@ void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t length)
>>   void qmp_xen_set_global_dirty_log(bool enable, Error **errp)
>>   {
>>       if (enable) {
>> -        memory_global_dirty_log_start(GLOBAL_DIRTY_MIGRATION);
>> +        memory_global_dirty_log_start(GLOBAL_DIRTY_MIGRATION, errp);
>>       } else {
>>           memory_global_dirty_log_stop(GLOBAL_DIRTY_MIGRATION);
>>       }
>> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
>> index 1d2e85746fb7b10eb7f149976970f9a92125af8a..d02d70b7b4b86a29d4d5540ded416543536d8f98 100644
>> --- a/migration/dirtyrate.c
>> +++ b/migration/dirtyrate.c
>> @@ -90,9 +90,15 @@ static int64_t do_calculate_dirtyrate(DirtyPageRecord dirty_pages,
>>   
>>   void global_dirty_log_change(unsigned int flag, bool start)
>>   {
>> +    Error *local_err = NULL;
>> +    bool ret;
>> +
>>       bql_lock();
>>       if (start) {
>> -        memory_global_dirty_log_start(flag);
>> +        ret = memory_global_dirty_log_start(flag, &local_err);
>> +        if (!ret) {
>> +            error_report_err(local_err);
>> +        }
>>       } else {
>>           memory_global_dirty_log_stop(flag);
>>       }
>> @@ -608,9 +614,12 @@ static void calculate_dirtyrate_dirty_bitmap(struct DirtyRateConfig config)
>>   {
>>       int64_t start_time;
>>       DirtyPageRecord dirty_pages;
>> +    Error *local_err = NULL;
>>   
>>       bql_lock();
>> -    memory_global_dirty_log_start(GLOBAL_DIRTY_DIRTY_RATE);
>> +    if (!memory_global_dirty_log_start(GLOBAL_DIRTY_DIRTY_RATE, &local_err)) {
>> +        error_report_err(local_err);
>> +    }
>>   
>>       /*
>>        * 1'round of log sync may return all 1 bits with
>> diff --git a/migration/ram.c b/migration/ram.c
>> index c5149b7d717aefad7f590422af0ea4a40e7507be..397b4c0f218a66d194e44f9c5f9fe8e9885c48b6 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -2836,18 +2836,31 @@ static void migration_bitmap_clear_discarded_pages(RAMState *rs)
>>   
>>   static void ram_init_bitmaps(RAMState *rs)
>>   {
>> +    Error *local_err = NULL;
>> +    bool ret = true;
>> +
>>       qemu_mutex_lock_ramlist();
>>   
>>       WITH_RCU_READ_LOCK_GUARD() {
>>           ram_list_init_bitmaps();
>>           /* We don't use dirty log with background snapshots */
>>           if (!migrate_background_snapshot()) {
>> -            memory_global_dirty_log_start(GLOBAL_DIRTY_MIGRATION);
>> +            ret = memory_global_dirty_log_start(GLOBAL_DIRTY_MIGRATION,
>> +                                                &local_err);
>> +            if (!ret) {
>> +                error_report_err(local_err);
>> +                goto out_unlock;
> 
> Here we may need to free the bitmaps created in ram_list_init_bitmaps().
> 
> We can have a helper ram_bitmaps_destroy() for that.
> 
> One thing be careful is the new file_bmap can be created but missing in the
> ram_save_cleanup(), it's because it's freed earlier.  IMHO if we will have
> a new ram_bitmaps_destroy() we can unconditionally free file_bmap there
> too, as if it's freed early g_free() is noop.

ok. will do.


Thanks,

C.


