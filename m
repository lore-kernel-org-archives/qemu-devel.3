Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5C6EC54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 13:01:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk1l2-0007dy-JT; Tue, 12 Mar 2024 09:01:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rk1kw-0007Av-Cg
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 09:01:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rk1ku-0003dv-Dy
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 09:01:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710248478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iQzPC0z3BctsKNNNkbLL9lLnz/Zvh1nSbVFdh3KFE3E=;
 b=LDWwTRs5CsjbZF2DrYQnH5WWfFHEGiCPJBA+X7BbSlqsXUo9pdUpSOr+z4zAskycsJL/R+
 TAIZxJZDiCQD0Lk+wib81tVmQvJnkRB/BmtK7Xww40y1qq+rmEg2oKhgWXRkJrbQkrokZV
 RmBdvD58Y8ZD0Xc8EkveGxkcAmpzc2I=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-g_BSPRslPQqvZYC2SOLUmQ-1; Tue, 12 Mar 2024 09:01:16 -0400
X-MC-Unique: g_BSPRslPQqvZYC2SOLUmQ-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6903ea40d25so37573216d6.0
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 06:01:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710248475; x=1710853275;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iQzPC0z3BctsKNNNkbLL9lLnz/Zvh1nSbVFdh3KFE3E=;
 b=F16fX3fmFMc9ZhQz3ApltJlpJSrS3cKMqq3wh2OK3tOIVKpekfTbVCTwgqEgFQ4lST
 VGi65TqthyW9760OhG3gqiw6jzNuZTsXWTjie9XKKZ0SC7qFaoE1eRYLtqa6nxN7Ccdy
 q9CaY9f3IEdCPTAdOCGl3e2MiurkHPDCsRuG2BN9tpb0YHNy40f7CJKsKueVnI2OURbE
 RhZcUQ7QByLNysJxKLP7lBbpkzgq7dCbciKEnAntYl/oGoMckFHPo+WkH3G5PkMm7lBj
 36Truz2d5Zwfv2MXPByY36GtA4rBXL2w7c9y7kwr/tf3Xa5foY5jqHINMPwMDVc1K15r
 7VtQ==
X-Gm-Message-State: AOJu0YwTinr3eJMZIH7WghBI8Qt6+nNPadD3RyFM+/3aLAdeVYFGP4cw
 IWS/o0E3lx93G8RPbnKG/Ak89DEgmSH6meGmggsEF7LDDn6gRRkCvypIw2CdeZ4Am//jeBejIuT
 jZAAd8XByU3QOE942ZZpeAgYrCuBxyw5FrW7PFtF+uNKYC//GSHQE
X-Received: by 2002:a0c:f80d:0:b0:690:c3ed:b174 with SMTP id
 r13-20020a0cf80d000000b00690c3edb174mr8277853qvn.49.1710248475010; 
 Tue, 12 Mar 2024 06:01:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1wbeCWT08wN2wJxpj1KfkXJuO+lwZC64HXiLbAuBeoNRmOzGCPrRYheVRNFBDxSL6qT7NAg==
X-Received: by 2002:a0c:f80d:0:b0:690:c3ed:b174 with SMTP id
 r13-20020a0cf80d000000b00690c3edb174mr8277831qvn.49.1710248474681; 
 Tue, 12 Mar 2024 06:01:14 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 kc19-20020a056214411300b00690d13f07f8sm2029160qvb.55.2024.03.12.06.01.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 06:01:14 -0700 (PDT)
Message-ID: <849dcde8-d20a-471c-ba59-fd1f1c60bef0@redhat.com>
Date: Tue, 12 Mar 2024 14:01:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/25] migration: Add Error** argument to
 qemu_savevm_state_setup()
Content-Language: en-US, fr
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>
References: <20240306133441.2351700-1-clg@redhat.com>
 <20240306133441.2351700-11-clg@redhat.com> <87plw44wps.fsf@suse.de>
 <1566715b-a9a5-4df6-8e64-f4f912e2ea2f@redhat.com> <87le6omw0d.fsf@suse.de>
 <Ze9lSAS2COx7s17l@x1n>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <Ze9lSAS2COx7s17l@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 3/11/24 21:10, Peter Xu wrote:
> On Mon, Mar 11, 2024 at 04:03:14PM -0300, Fabiano Rosas wrote:
>> Cédric Le Goater <clg@redhat.com> writes:
>>
>>> On 3/8/24 15:36, Fabiano Rosas wrote:
>>>> Cédric Le Goater <clg@redhat.com> writes:
>>>>
>>>>> This prepares ground for the changes coming next which add an Error**
>>>>> argument to the .save_setup() handler. Callers of qemu_savevm_state_setup()
>>>>> now handle the error and fail earlier setting the migration state from
>>>>> MIGRATION_STATUS_SETUP to MIGRATION_STATUS_FAILED.
>>>>>
>>>>> In qemu_savevm_state(), move the cleanup to preserve the error
>>>>> reported by .save_setup() handlers.
>>>>>
>>>>> Since the previous behavior was to ignore errors at this step of
>>>>> migration, this change should be examined closely to check that
>>>>> cleanups are still correctly done.
>>>>>
>>>>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>>>>> ---
>>>>>
>>>>>    Changes in v4:
>>>>>    
>>>>>    - Merged cleanup change in qemu_savevm_state()
>>>>>      
>>>>>    Changes in v3:
>>>>>    
>>>>>    - Set migration state to MIGRATION_STATUS_FAILED
>>>>>    - Fixed error handling to be done under lock in bg_migration_thread()
>>>>>    - Made sure an error is always set in case of failure in
>>>>>      qemu_savevm_state_setup()
>>>>>      
>>>>>    migration/savevm.h    |  2 +-
>>>>>    migration/migration.c | 27 ++++++++++++++++++++++++---
>>>>>    migration/savevm.c    | 26 +++++++++++++++-----------
>>>>>    3 files changed, 40 insertions(+), 15 deletions(-)
>>>>>
>>>>> diff --git a/migration/savevm.h b/migration/savevm.h
>>>>> index 74669733dd63a080b765866c703234a5c4939223..9ec96a995c93a42aad621595f0ed58596c532328 100644
>>>>> --- a/migration/savevm.h
>>>>> +++ b/migration/savevm.h
>>>>> @@ -32,7 +32,7 @@
>>>>>    bool qemu_savevm_state_blocked(Error **errp);
>>>>>    void qemu_savevm_non_migratable_list(strList **reasons);
>>>>>    int qemu_savevm_state_prepare(Error **errp);
>>>>> -void qemu_savevm_state_setup(QEMUFile *f);
>>>>> +int qemu_savevm_state_setup(QEMUFile *f, Error **errp);
>>>>>    bool qemu_savevm_state_guest_unplug_pending(void);
>>>>>    int qemu_savevm_state_resume_prepare(MigrationState *s);
>>>>>    void qemu_savevm_state_header(QEMUFile *f);
>>>>> diff --git a/migration/migration.c b/migration/migration.c
>>>>> index a49fcd53ee19df1ce0182bc99d7e064968f0317b..6d1544224e96f5edfe56939a9c8395d88ef29581 100644
>>>>> --- a/migration/migration.c
>>>>> +++ b/migration/migration.c
>>>>> @@ -3408,6 +3408,8 @@ static void *migration_thread(void *opaque)
>>>>>        int64_t setup_start = qemu_clock_get_ms(QEMU_CLOCK_HOST);
>>>>>        MigThrError thr_error;
>>>>>        bool urgent = false;
>>>>> +    Error *local_err = NULL;
>>>>> +    int ret;
>>>>>    
>>>>>        thread = migration_threads_add("live_migration", qemu_get_thread_id());
>>>>>    
>>>>> @@ -3451,9 +3453,17 @@ static void *migration_thread(void *opaque)
>>>>>        }
>>>>>    
>>>>>        bql_lock();
>>>>> -    qemu_savevm_state_setup(s->to_dst_file);
>>>>> +    ret = qemu_savevm_state_setup(s->to_dst_file, &local_err);
>>>>>        bql_unlock();
>>>>>    
>>>>> +    if (ret) {
>>>>> +        migrate_set_error(s, local_err);
>>>>> +        error_free(local_err);
>>>>> +        migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
>>>>> +                          MIGRATION_STATUS_FAILED);
>>>>> +        goto out;
>>>>> +     }
>>>>> +
>>>>>        qemu_savevm_wait_unplug(s, MIGRATION_STATUS_SETUP,
>>>>>                                   MIGRATION_STATUS_ACTIVE);
>>>>
>>>> This^ should be before the new block it seems:
>>>>
>>>> GOOD:
>>>> migrate_set_state new state setup
>>>> migrate_set_state new state wait-unplug
>>>> migrate_fd_cancel
>>>> migrate_set_state new state cancelling
>>>> migrate_fd_cleanup
>>>> migrate_set_state new state cancelled
>>>> migrate_fd_cancel
>>>> ok 1 /x86_64/failover-virtio-net/migrate/abort/wait-unplug
>>>>
>>>> BAD:
>>>> migrate_set_state new state setup
>>>> migrate_fd_cancel
>>>> migrate_set_state new state cancelling
>>>> migrate_fd_cleanup
>>>> migrate_set_state new state cancelled
>>>> qemu-system-x86_64: ram_save_setup failed: Input/output error
>>>> **
>>>> ERROR:../tests/qtest/virtio-net-failover.c:1203:test_migrate_abort_wait_unplug:
>>>> assertion failed (status == "cancelling"): ("cancelled" == "cancelling")
>>>>
>>>> Otherwise migration_iteration_finish() will schedule the cleanup BH and
>>>> that will run concurrently with migrate_fd_cancel() issued by the test
>>>> and bad things happens.
>>>
>>> This hack makes things work :
>>>
>>> @@ -3452,6 +3452,9 @@ static void *migration_thread(void *opaq
>>>            qemu_savevm_send_colo_enable(s->to_dst_file);
>>>        }
>>>    
>>> +    qemu_savevm_wait_unplug(s, MIGRATION_STATUS_SETUP,
>>> +                            MIGRATION_STATUS_SETUP);
>>> +
>>
>> Why move it all the way up here? Has moving the wait_unplug before the
>> 'if (ret)' block not worked for you?
>>
>>>        bql_lock();
>>>        ret = qemu_savevm_state_setup(s->to_dst_file, &local_err);
>>>        bql_unlock();
>>>
>>> We should fix the test instead :) Unless waiting for failover devices
>>> to unplug before the save_setup handlers and not after is ok.
>>>
>>> commit c7e0acd5a3f8 ("migration: add new migration state wait-unplug")
>>> is not clear about the justification.:
>>>
>>>       This patch adds a new migration state called wait-unplug.  It is entered
>>>       after the SETUP state if failover devices are present. It will transition
>>>       into ACTIVE once all devices were succesfully unplugged from the guest.
>>
>> This is not clear indeed, but to me it seems having the wait-unplug
>> after setup was important.
> 
> Finally got some time to read this code..
> 
> So far I didn't see an issue if it's called before the setup hooks.
> Actually it looks to me it should better do that before those hooks.
>
> IIUC what that qemu_savevm_wait_unplug() does is waiting for all the
> primary devices to be completely unplugged before moving on the migration.
> 
> Here setup() hook, or to be explicit, the primary devices' VMSDs (if ever
> existed, and if that was the concern) should have zero impact on such wait,
> because the "unplug" should also contain one step to unregister those
> vmsds; see the virtio_net_handle_migration_primary() where it has:
> 
>          if (failover_unplug_primary(n, dev)) {
>              vmstate_unregister(VMSTATE_IF(dev), qdev_get_vmsd(dev), dev);
>              ...
>          }
> 
> So qemu_savevm_wait_unplug() looks like a pure wait function to me until
> all the unplug is processed by the guest OS.  And it makes some sense to me
> to avoid calling setup() (which can start to hold resources, like in RAM we
> create bitmaps etc to prepare for migration) before such possible long halts.

I think so too now. VFIO is already sending state.

> 
> In all cases, I guess it's still too rush to figure out a plan, meanwhile
> anything proposed for either test/code changes would better get some
> reviews from either Laurent or other virtio-net guys.  I think I'll go
> ahead the pull without the 2nd batch of patches.
> 
>>
>>>
>>>
>>>> =====
>>>> PS: I guess the next level in our Freestyle Concurrency video-game is to
>>>> make migrate_fd_cancel() stop setting state and poking files and only
>>>> set a flag that's tested in the other parts of the code.
>>>
>>> Is that a new item on the TODO list?
>>
>> Yep, I'll add it to the wiki.
> 
> Sounds like a good thing, however let's be aware of the evils (that are
> always in the details..), where there can be users/tests relying on that
> "CANCELLING" state, so it can be part of the ABIs.. :-(

That's a good reason to move qemu_savevm_wait_unplug() and avoid breaking
the ABI.

Thanks,

C.



