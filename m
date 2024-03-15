Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9054C54E69
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 10:18:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl4dT-0000lz-4X; Fri, 15 Mar 2024 06:17:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rl4dO-0000kK-34
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 06:17:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rl4dM-0004jH-0H
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 06:17:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710497870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IO7szWAc/F9TcU9waW1pVYbXTLxyWI1aV3IA4MALdNY=;
 b=JPb+3larIUdB9Y7EQMmIVAa7he4cd0HQdLoibv2O21Os8kqtKp13yTINBo0c6PBfgK1JQ8
 7zbJzhIbW2XgHUvm2uaZ7gSa8W5ZZQOBY2W1JRAndNs/ZMFsMGuNcJm23ieCjI0+z5At2U
 WXs7m3kPEVJWCBYCo0c9rDa6h7P3Ulg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-fllw5RfIOR-9xNLUnQzgGA-1; Fri, 15 Mar 2024 06:17:48 -0400
X-MC-Unique: fllw5RfIOR-9xNLUnQzgGA-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-558aafe9bf2so1652790a12.1
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 03:17:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710497867; x=1711102667;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IO7szWAc/F9TcU9waW1pVYbXTLxyWI1aV3IA4MALdNY=;
 b=ZNn1DE7QjLiTfM5IWHW2wvik1U14lys1dKHxEl3JMinAKTxIqCJzOVSIkF/C92Vy59
 cVl2wSEPTSmcN6+RL9aphjJUoOqrgMoyWsH2O66H2liSH5HNLqq9400Mjd9zfNQrUX8z
 14Q3G6BqDO8chGgwwW7mgEd3XV3tT6wRwPBTiJb53CjRamupxO7sXoW+yPwN0rCDMYz/
 6hksD8pc+Hqf1Ky34XPQUJexBBuFvuagV/K7swUhHHy8IlVwQWn+GXpo9/37J2OEesvZ
 tyX1j/VQrUMu/GZhB6FRpZyMiEoIQXbVusT34O6Tld/F2ue5Ek7l9znfuGgzkG7IBKUH
 ggDg==
X-Gm-Message-State: AOJu0YzQtmwczAvEBtxe6aWbSWYvsOflwHY4YJGLE24JgkIUFG+anVyQ
 jf12YiH9nrQLO/aXgvcSm4Rk7caV39DZsTtklrQRTURmPnKNqwJSRy+yQxNg+kTIRylg+p7/sjI
 iq4EQo4r/PK9fzBKzv7hi49J+aaQuIXavl7TUEEY4W9ZroNeDUJh8
X-Received: by 2002:aa7:c398:0:b0:568:1f9f:eca4 with SMTP id
 k24-20020aa7c398000000b005681f9feca4mr1949446edq.42.1710497867235; 
 Fri, 15 Mar 2024 03:17:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwaUTMy9rf2E+ZTOIWI6FJrbEjhTNqKA9rxKI6F3LJXsUkiAnHQxQTCVRhDtY3KtSBG/OOVA==
X-Received: by 2002:aa7:c398:0:b0:568:1f9f:eca4 with SMTP id
 k24-20020aa7c398000000b005681f9feca4mr1949432edq.42.1710497866911; 
 Fri, 15 Mar 2024 03:17:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:d55d:ba01:adf2:d3ae?
 ([2a01:e0a:9e2:9000:d55d:ba01:adf2:d3ae])
 by smtp.gmail.com with ESMTPSA id
 n18-20020a05640205d200b00568b6d731e1sm117872edx.4.2024.03.15.03.17.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Mar 2024 03:17:46 -0700 (PDT)
Message-ID: <b9cb5c16-59a4-4cdc-9d12-6d7c2306b4ff@redhat.com>
Date: Fri, 15 Mar 2024 11:17:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/25] migration: Add Error** argument to
 qemu_savevm_state_setup()
Content-Language: en-US, fr
To: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>
References: <20240306133441.2351700-1-clg@redhat.com>
 <20240306133441.2351700-11-clg@redhat.com> <87plw44wps.fsf@suse.de>
 <1566715b-a9a5-4df6-8e64-f4f912e2ea2f@redhat.com> <87le6omw0d.fsf@suse.de>
 <9071affc-ffb5-435a-99d1-ca829703e31b@redhat.com>
 <8ba5dba7-1849-46ff-b708-a9caac66be27@redhat.com>
 <b2b52017-c4cd-43e9-a67b-2ccbb92ad99e@redhat.com> <874jdbmst4.fsf@suse.de>
 <ZfByYiL3Gl9d9u7h@x1n> <87wmq7l2xx.fsf@suse.de>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <87wmq7l2xx.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
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

On 3/12/24 19:28, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
>> On Tue, Mar 12, 2024 at 11:24:39AM -0300, Fabiano Rosas wrote:
>>> Cédric Le Goater <clg@redhat.com> writes:
>>>
>>>> On 3/12/24 14:34, Cédric Le Goater wrote:
>>>>> On 3/12/24 13:32, Cédric Le Goater wrote:
>>>>>> On 3/11/24 20:03, Fabiano Rosas wrote:
>>>>>>> Cédric Le Goater <clg@redhat.com> writes:
>>>>>>>
>>>>>>>> On 3/8/24 15:36, Fabiano Rosas wrote:
>>>>>>>>> Cédric Le Goater <clg@redhat.com> writes:
>>>>>>>>>
>>>>>>>>>> This prepares ground for the changes coming next which add an Error**
>>>>>>>>>> argument to the .save_setup() handler. Callers of qemu_savevm_state_setup()
>>>>>>>>>> now handle the error and fail earlier setting the migration state from
>>>>>>>>>> MIGRATION_STATUS_SETUP to MIGRATION_STATUS_FAILED.
>>>>>>>>>>
>>>>>>>>>> In qemu_savevm_state(), move the cleanup to preserve the error
>>>>>>>>>> reported by .save_setup() handlers.
>>>>>>>>>>
>>>>>>>>>> Since the previous behavior was to ignore errors at this step of
>>>>>>>>>> migration, this change should be examined closely to check that
>>>>>>>>>> cleanups are still correctly done.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>>>>>>>>>> ---
>>>>>>>>>>
>>>>>>>>>>     Changes in v4:
>>>>>>>>>>     - Merged cleanup change in qemu_savevm_state()
>>>>>>>>>>     Changes in v3:
>>>>>>>>>>     - Set migration state to MIGRATION_STATUS_FAILED
>>>>>>>>>>     - Fixed error handling to be done under lock in bg_migration_thread()
>>>>>>>>>>     - Made sure an error is always set in case of failure in
>>>>>>>>>>       qemu_savevm_state_setup()
>>>>>>>>>>     migration/savevm.h    |  2 +-
>>>>>>>>>>     migration/migration.c | 27 ++++++++++++++++++++++++---
>>>>>>>>>>     migration/savevm.c    | 26 +++++++++++++++-----------
>>>>>>>>>>     3 files changed, 40 insertions(+), 15 deletions(-)
>>>>>>>>>>
>>>>>>>>>> diff --git a/migration/savevm.h b/migration/savevm.h
>>>>>>>>>> index 74669733dd63a080b765866c703234a5c4939223..9ec96a995c93a42aad621595f0ed58596c532328 100644
>>>>>>>>>> --- a/migration/savevm.h
>>>>>>>>>> +++ b/migration/savevm.h
>>>>>>>>>> @@ -32,7 +32,7 @@
>>>>>>>>>>     bool qemu_savevm_state_blocked(Error **errp);
>>>>>>>>>>     void qemu_savevm_non_migratable_list(strList **reasons);
>>>>>>>>>>     int qemu_savevm_state_prepare(Error **errp);
>>>>>>>>>> -void qemu_savevm_state_setup(QEMUFile *f);
>>>>>>>>>> +int qemu_savevm_state_setup(QEMUFile *f, Error **errp);
>>>>>>>>>>     bool qemu_savevm_state_guest_unplug_pending(void);
>>>>>>>>>>     int qemu_savevm_state_resume_prepare(MigrationState *s);
>>>>>>>>>>     void qemu_savevm_state_header(QEMUFile *f);
>>>>>>>>>> diff --git a/migration/migration.c b/migration/migration.c
>>>>>>>>>> index a49fcd53ee19df1ce0182bc99d7e064968f0317b..6d1544224e96f5edfe56939a9c8395d88ef29581 100644
>>>>>>>>>> --- a/migration/migration.c
>>>>>>>>>> +++ b/migration/migration.c
>>>>>>>>>> @@ -3408,6 +3408,8 @@ static void *migration_thread(void *opaque)
>>>>>>>>>>         int64_t setup_start = qemu_clock_get_ms(QEMU_CLOCK_HOST);
>>>>>>>>>>         MigThrError thr_error;
>>>>>>>>>>         bool urgent = false;
>>>>>>>>>> +    Error *local_err = NULL;
>>>>>>>>>> +    int ret;
>>>>>>>>>>         thread = migration_threads_add("live_migration", qemu_get_thread_id());
>>>>>>>>>> @@ -3451,9 +3453,17 @@ static void *migration_thread(void *opaque)
>>>>>>>>>>         }
>>>>>>>>>>         bql_lock();
>>>>>>>>>> -    qemu_savevm_state_setup(s->to_dst_file);
>>>>>>>>>> +    ret = qemu_savevm_state_setup(s->to_dst_file, &local_err);
>>>>>>>>>>         bql_unlock();
>>>>>>>>>> +    if (ret) {
>>>>>>>>>> +        migrate_set_error(s, local_err);
>>>>>>>>>> +        error_free(local_err);
>>>>>>>>>> +        migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
>>>>>>>>>> +                          MIGRATION_STATUS_FAILED);
>>>>>>>>>> +        goto out;
>>>>>>>>>> +     }
>>>>>>>>>> +
>>>>>>>>>>         qemu_savevm_wait_unplug(s, MIGRATION_STATUS_SETUP,
>>>>>>>>>>                                    MIGRATION_STATUS_ACTIVE);
>>>>>>>>>
>>>>>>>>> This^ should be before the new block it seems:
>>>>>>>>>
>>>>>>>>> GOOD:
>>>>>>>>> migrate_set_state new state setup
>>>>>>>>> migrate_set_state new state wait-unplug
>>>>>>>>> migrate_fd_cancel
>>>>>>>>> migrate_set_state new state cancelling
>>>>>>>>> migrate_fd_cleanup
>>>>>>>>> migrate_set_state new state cancelled
>>>>>>>>> migrate_fd_cancel
>>>>>>>>> ok 1 /x86_64/failover-virtio-net/migrate/abort/wait-unplug
>>>>>>>>>
>>>>>>>>> BAD:
>>>>>>>>> migrate_set_state new state setup
>>>>>>>>> migrate_fd_cancel
>>>>>>>>> migrate_set_state new state cancelling
>>>>>>>>> migrate_fd_cleanup
>>>>>>>>> migrate_set_state new state cancelled
>>>>>>>>> qemu-system-x86_64: ram_save_setup failed: Input/output error
>>>>>>>>> **
>>>>>>>>> ERROR:../tests/qtest/virtio-net-failover.c:1203:test_migrate_abort_wait_unplug:
>>>>>>>>> assertion failed (status == "cancelling"): ("cancelled" == "cancelling")
>>>>>>>>>
>>>>>>>>> Otherwise migration_iteration_finish() will schedule the cleanup BH and
>>>>>>>>> that will run concurrently with migrate_fd_cancel() issued by the test
>>>>>>>>> and bad things happens.
>>>>>>>>
>>>>>>>> This hack makes things work :
>>>>>>>>
>>>>>>>> @@ -3452,6 +3452,9 @@ static void *migration_thread(void *opaq
>>>>>>>>             qemu_savevm_send_colo_enable(s->to_dst_file);
>>>>>>>>         }
>>>>>>>> +    qemu_savevm_wait_unplug(s, MIGRATION_STATUS_SETUP,
>>>>>>>> +                            MIGRATION_STATUS_SETUP);
>>>>>>>> +
>>>>>>>
>>>>>>> Why move it all the way up here? Has moving the wait_unplug before the
>>>>>>> 'if (ret)' block not worked for you?
>>>>>>
>>>>>> We could be sleeping while holding the BQL. It looked wrong.
>>>>>
>>>>> Sorry wrong answer. Yes I can try moving it before the 'if (ret)' block.
>>>>> I can reproduce easily with an x86 guest running on PPC64.
>>>>
>>>> That works just the same.
>>>>
>>>> Peter, Fabiano,
>>>>
>>>> What would you prefer  ?
>>>>
>>>> 1. move qemu_savevm_wait_unplug() before qemu_savevm_state_setup(),
>>>>      means one new patch.
>>>
>>> Is there a point to this except "because we can"? Honest question, I
>>> might have missed the motivation.
>>
>> My previous point was, it avoids holding the resources (that will be
>> allocated in setup() routines) while we know we can wait for a long time.
>>
>> But then I found that the ordering is indeed needed at least if we don't
>> change migrate_set_state() first - it is the only place we set the status
>> to START (which I overlooked, sorry)...
>>
>> IMHO the function is not well designed; the state update of the next stage
>> should not reside in a function to wait for failover primary devices
>> conditionally. It's a bit of a mess.
>>
> 
> I agree. We can clean that up in 9.1.
> 
> migrate_set_state is also unintuitive because it ignores invalid state
> transitions and we've been using that property to deal with special
> states such as POSTCOPY_PAUSED and FAILED:
> 
> - After the migration goes into POSTCOPY_PAUSED, the resumed migration's
>    migrate_init() will try to set the state NONE->SETUP, which is not
>    valid.
> 
> - After save_setup fails, the migration goes into FAILED, but wait_unplug
>    will try to transition SETUP->ACTIVE, which is also not valid.
> 

I am not sure I understand what the plan is. Both solutions are problematic
regarding the state transitions.

Should we consider that waiting for failover devices to unplug is an internal
step of the SETUP phase not transitioning to ACTIVE ?

Thanks,

C.


