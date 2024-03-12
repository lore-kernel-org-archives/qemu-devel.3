Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4339EC54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 12:32:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk1J4-0001Ul-UD; Tue, 12 Mar 2024 08:32:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rk1Iy-0001Gr-5z
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 08:32:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rk1It-00069R-Uk
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 08:32:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710246743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oa71ivuTld0npOJudca7JNxQS7W9WZZaKwvtEms0YPw=;
 b=jBlJIcpe6Bt3bEvznUs5gMaOKJdaO4Xt3zSLrglj18I3biBWl5m7Or6iV+8XFRi7kfpqwG
 kZdZBcR5gbdyRv3EWLJoJiVVJZWzbz6jmF7QyxPxtY1z7qOfahrwc9h3+7GXIREQu9eHss
 s4/i39CWJGM/YbBcy1JHmsOlN/8pMIU=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-XyYCvAn-PU6f7BxoqYA5WQ-1; Tue, 12 Mar 2024 08:32:21 -0400
X-MC-Unique: XyYCvAn-PU6f7BxoqYA5WQ-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5131aa087beso3562834e87.2
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 05:32:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710246740; x=1710851540;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oa71ivuTld0npOJudca7JNxQS7W9WZZaKwvtEms0YPw=;
 b=DHsAOEaoUrxk2RF4pgi/gGG95ChKQoWyfJZ1Nz95Bv31dDBvrbOREsMA/iGeYPm0PI
 yljsMeLUHAiIo939qY0nspdBHtr4a5QGyYIWuTguBZzBG/H+IsxJJD9Irf0LwlAZPeee
 ofhy5Hh8ZCmuhA2ilIUcNcRlDDbcRUnqx+P9X15i1pKMHOo8kNRD7juyNcfMyFYxlilx
 nz3kzhiiJy8Af0p8S63skb2fI+CjDKwA8CL0CUJvbJq9Xam9hW8cQ6b8rmWImPhodpOI
 61TagYdiK45iiepAyso9FVKO3unfymKVbnkZuEEU862FFK8x5Siulhe2vESKiT59OeIK
 YEjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmNjXugKe7Y2+79/Mbml1E97fL7MNLeEVm1gqLat3KCgWkVB1NbO+d0lQLsETv19VgZ6jyiq1J8w7fjOqH9hHREeQss5M=
X-Gm-Message-State: AOJu0YwKU82OICe9SX1YxLDBX3LfNPV9Mb494zgE5QQOv9yuGj6/EmBZ
 XzTN7m/69XoxhOd3EKEQJuac+Nvz/odAk21bleUQt3I2u1jwSPfmjh07K0g9+cqNlGUyQUmO+l6
 7c7cKSVVwwYZykKd5J8+pbbwt/pDj9Fa9c1WhDSWao0BXXC8slvzD
X-Received: by 2002:a05:6512:1110:b0:513:c408:b2af with SMTP id
 l16-20020a056512111000b00513c408b2afmr640849lfg.46.1710246739840; 
 Tue, 12 Mar 2024 05:32:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHvKt6g8T3EAjOJ1yr3MIC610gPXgcYhO/IBH2dWpBM+xcHkTZyLf0CLE5uGKxpLq+4wG2vQ==
X-Received: by 2002:a05:6512:1110:b0:513:c408:b2af with SMTP id
 l16-20020a056512111000b00513c408b2afmr640831lfg.46.1710246739474; 
 Tue, 12 Mar 2024 05:32:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 f15-20020a05600c4e8f00b00412ea52b102sm19228774wmq.34.2024.03.12.05.32.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 05:32:18 -0700 (PDT)
Message-ID: <9071affc-ffb5-435a-99d1-ca829703e31b@redhat.com>
Date: Tue, 12 Mar 2024 13:32:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/25] migration: Add Error** argument to
 qemu_savevm_state_setup()
Content-Language: en-US, fr
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Alex Williamson
 <alex.williamson@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Prasad Pandit <pjp@fedoraproject.org>
References: <20240306133441.2351700-1-clg@redhat.com>
 <20240306133441.2351700-11-clg@redhat.com> <87plw44wps.fsf@suse.de>
 <1566715b-a9a5-4df6-8e64-f4f912e2ea2f@redhat.com> <87le6omw0d.fsf@suse.de>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <87le6omw0d.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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

On 3/11/24 20:03, Fabiano Rosas wrote:
> Cédric Le Goater <clg@redhat.com> writes:
> 
>> On 3/8/24 15:36, Fabiano Rosas wrote:
>>> Cédric Le Goater <clg@redhat.com> writes:
>>>
>>>> This prepares ground for the changes coming next which add an Error**
>>>> argument to the .save_setup() handler. Callers of qemu_savevm_state_setup()
>>>> now handle the error and fail earlier setting the migration state from
>>>> MIGRATION_STATUS_SETUP to MIGRATION_STATUS_FAILED.
>>>>
>>>> In qemu_savevm_state(), move the cleanup to preserve the error
>>>> reported by .save_setup() handlers.
>>>>
>>>> Since the previous behavior was to ignore errors at this step of
>>>> migration, this change should be examined closely to check that
>>>> cleanups are still correctly done.
>>>>
>>>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>>>> ---
>>>>
>>>>    Changes in v4:
>>>>    
>>>>    - Merged cleanup change in qemu_savevm_state()
>>>>      
>>>>    Changes in v3:
>>>>    
>>>>    - Set migration state to MIGRATION_STATUS_FAILED
>>>>    - Fixed error handling to be done under lock in bg_migration_thread()
>>>>    - Made sure an error is always set in case of failure in
>>>>      qemu_savevm_state_setup()
>>>>      
>>>>    migration/savevm.h    |  2 +-
>>>>    migration/migration.c | 27 ++++++++++++++++++++++++---
>>>>    migration/savevm.c    | 26 +++++++++++++++-----------
>>>>    3 files changed, 40 insertions(+), 15 deletions(-)
>>>>
>>>> diff --git a/migration/savevm.h b/migration/savevm.h
>>>> index 74669733dd63a080b765866c703234a5c4939223..9ec96a995c93a42aad621595f0ed58596c532328 100644
>>>> --- a/migration/savevm.h
>>>> +++ b/migration/savevm.h
>>>> @@ -32,7 +32,7 @@
>>>>    bool qemu_savevm_state_blocked(Error **errp);
>>>>    void qemu_savevm_non_migratable_list(strList **reasons);
>>>>    int qemu_savevm_state_prepare(Error **errp);
>>>> -void qemu_savevm_state_setup(QEMUFile *f);
>>>> +int qemu_savevm_state_setup(QEMUFile *f, Error **errp);
>>>>    bool qemu_savevm_state_guest_unplug_pending(void);
>>>>    int qemu_savevm_state_resume_prepare(MigrationState *s);
>>>>    void qemu_savevm_state_header(QEMUFile *f);
>>>> diff --git a/migration/migration.c b/migration/migration.c
>>>> index a49fcd53ee19df1ce0182bc99d7e064968f0317b..6d1544224e96f5edfe56939a9c8395d88ef29581 100644
>>>> --- a/migration/migration.c
>>>> +++ b/migration/migration.c
>>>> @@ -3408,6 +3408,8 @@ static void *migration_thread(void *opaque)
>>>>        int64_t setup_start = qemu_clock_get_ms(QEMU_CLOCK_HOST);
>>>>        MigThrError thr_error;
>>>>        bool urgent = false;
>>>> +    Error *local_err = NULL;
>>>> +    int ret;
>>>>    
>>>>        thread = migration_threads_add("live_migration", qemu_get_thread_id());
>>>>    
>>>> @@ -3451,9 +3453,17 @@ static void *migration_thread(void *opaque)
>>>>        }
>>>>    
>>>>        bql_lock();
>>>> -    qemu_savevm_state_setup(s->to_dst_file);
>>>> +    ret = qemu_savevm_state_setup(s->to_dst_file, &local_err);
>>>>        bql_unlock();
>>>>    
>>>> +    if (ret) {
>>>> +        migrate_set_error(s, local_err);
>>>> +        error_free(local_err);
>>>> +        migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
>>>> +                          MIGRATION_STATUS_FAILED);
>>>> +        goto out;
>>>> +     }
>>>> +
>>>>        qemu_savevm_wait_unplug(s, MIGRATION_STATUS_SETUP,
>>>>                                   MIGRATION_STATUS_ACTIVE);
>>>
>>> This^ should be before the new block it seems:
>>>
>>> GOOD:
>>> migrate_set_state new state setup
>>> migrate_set_state new state wait-unplug
>>> migrate_fd_cancel
>>> migrate_set_state new state cancelling
>>> migrate_fd_cleanup
>>> migrate_set_state new state cancelled
>>> migrate_fd_cancel
>>> ok 1 /x86_64/failover-virtio-net/migrate/abort/wait-unplug
>>>
>>> BAD:
>>> migrate_set_state new state setup
>>> migrate_fd_cancel
>>> migrate_set_state new state cancelling
>>> migrate_fd_cleanup
>>> migrate_set_state new state cancelled
>>> qemu-system-x86_64: ram_save_setup failed: Input/output error
>>> **
>>> ERROR:../tests/qtest/virtio-net-failover.c:1203:test_migrate_abort_wait_unplug:
>>> assertion failed (status == "cancelling"): ("cancelled" == "cancelling")
>>>
>>> Otherwise migration_iteration_finish() will schedule the cleanup BH and
>>> that will run concurrently with migrate_fd_cancel() issued by the test
>>> and bad things happens.
>>
>> This hack makes things work :
>>
>> @@ -3452,6 +3452,9 @@ static void *migration_thread(void *opaq
>>            qemu_savevm_send_colo_enable(s->to_dst_file);
>>        }
>>    
>> +    qemu_savevm_wait_unplug(s, MIGRATION_STATUS_SETUP,
>> +                            MIGRATION_STATUS_SETUP);
>> +
> 
> Why move it all the way up here? Has moving the wait_unplug before the
> 'if (ret)' block not worked for you?

We could be sleeping while holding the BQL. It looked wrong.


Thanks,

C.


> 
>>        bql_lock();
>>        ret = qemu_savevm_state_setup(s->to_dst_file, &local_err);
>>        bql_unlock();
>>
>> We should fix the test instead :) Unless waiting for failover devices
>> to unplug before the save_setup handlers and not after is ok.
>>
>> commit c7e0acd5a3f8 ("migration: add new migration state wait-unplug")
>> is not clear about the justification.:
>>
>>       This patch adds a new migration state called wait-unplug.  It is entered
>>       after the SETUP state if failover devices are present. It will transition
>>       into ACTIVE once all devices were succesfully unplugged from the guest.
> 
> This is not clear indeed, but to me it seems having the wait-unplug
> after setup was important.
> 
>>
>>
>>> =====
>>> PS: I guess the next level in our Freestyle Concurrency video-game is to
>>> make migrate_fd_cancel() stop setting state and poking files and only
>>> set a flag that's tested in the other parts of the code.
>>
>> Is that a new item on the TODO list?
> 
> Yep, I'll add it to the wiki.
> 


