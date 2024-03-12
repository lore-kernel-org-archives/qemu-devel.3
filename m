Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02BD6C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 13:35:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk2HC-0000gu-6G; Tue, 12 Mar 2024 09:34:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rk2H3-0000fe-Jz
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 09:34:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rk2H1-0002WF-S4
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 09:34:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710250468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AN4IWX1CRIS+txcEwWE5fF5dsXs/2Q5s1zfxM0hJ/EI=;
 b=Ig42K4x26H1gz/eiU/qtD5hB89DCVDM9UVprWE4mSYqWd4T7DT63bL1XbqdLlRNaJIm8dF
 kciPIneqRF/TCMGQtiGnHJX6Rlt9uTssqNiDjNJkL2tP2d+Oo1XJCUFpFmp6jXq/oxc6Ol
 UeC1maqUws4kGTztUcrRKnuTCo1C9+Y=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-xu_OygM4Me2nUSstlEp5cQ-1; Tue, 12 Mar 2024 09:34:25 -0400
X-MC-Unique: xu_OygM4Me2nUSstlEp5cQ-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5131aa087beso3622902e87.2
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 06:34:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710250464; x=1710855264;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AN4IWX1CRIS+txcEwWE5fF5dsXs/2Q5s1zfxM0hJ/EI=;
 b=TT9BVEgKNKztdqOkzEGcOu/YyKsN0Qch4uGKcvpxLNpIDk9oxTNjhr0tb7BC67psSJ
 c3nGYgNqb7rT1frXCtKwDfgyZDHWE7NwPcoCjCpAWBxJ9WIpv0D8yBukRje8U1zmjuGN
 w6aC7OJJrhwRsg1LShksaQq/k7jz7A2o3N9KlTzsyxU/Cm5yHZLmaO9/OIxNmsReacUg
 WualOMcLJo4cOdin7T+j5OKEe8q651wbFSSLNoqybnMSH5Tm83rMz3WSzZdZiPIuE4bn
 lCbaCapF4+CivC3KzM0lflk9mhDfluJdPb/ZKYMCZ5i562egdTyjFyKK21yMPgolojsT
 cxrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVceu4DfqUfLIleXIgVPBBvyPkiCRCvJCjSHpOa8PMxBDEAmtKBq+X94RDrlJ2AYwDnAddeAaOENu/DGCPDP2sBKJocxZA=
X-Gm-Message-State: AOJu0YwZf+lsr7ibqa4hh7TlNpxP9xvHEu+/Sf23nlez53vooU+NBdAx
 ph3c4bd+mtEyN0AsbagfoIjgouuFnbcmij9eQWunnIv5L3z5OytreMaV++ixmP2YFYpT5J6i73M
 leZHCfDdG1E/mpn4G965HkDIyt0HrZPBzUm7/zNFVFGsynLu1VmSv
X-Received: by 2002:a05:6512:987:b0:513:2f96:72b5 with SMTP id
 w7-20020a056512098700b005132f9672b5mr5956213lft.33.1710250464103; 
 Tue, 12 Mar 2024 06:34:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPctuxj0Zq3Wy9XcwWpzFBpxNIvHcuXHhoegpffsPcy2BJ58E88NYZ84DUCbGDjtjUFxg7VQ==
X-Received: by 2002:a05:6512:987:b0:513:2f96:72b5 with SMTP id
 w7-20020a056512098700b005132f9672b5mr5956194lft.33.1710250463757; 
 Tue, 12 Mar 2024 06:34:23 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 m15-20020a05600c3b0f00b00413218ca719sm11712441wms.4.2024.03.12.06.34.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 06:34:23 -0700 (PDT)
Message-ID: <8ba5dba7-1849-46ff-b708-a9caac66be27@redhat.com>
Date: Tue, 12 Mar 2024 14:34:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/25] migration: Add Error** argument to
 qemu_savevm_state_setup()
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Alex Williamson
 <alex.williamson@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Prasad Pandit <pjp@fedoraproject.org>
References: <20240306133441.2351700-1-clg@redhat.com>
 <20240306133441.2351700-11-clg@redhat.com> <87plw44wps.fsf@suse.de>
 <1566715b-a9a5-4df6-8e64-f4f912e2ea2f@redhat.com> <87le6omw0d.fsf@suse.de>
 <9071affc-ffb5-435a-99d1-ca829703e31b@redhat.com>
In-Reply-To: <9071affc-ffb5-435a-99d1-ca829703e31b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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

On 3/12/24 13:32, Cédric Le Goater wrote:
> On 3/11/24 20:03, Fabiano Rosas wrote:
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
>>>>>    Changes in v4:
>>>>>    - Merged cleanup change in qemu_savevm_state()
>>>>>    Changes in v3:
>>>>>    - Set migration state to MIGRATION_STATUS_FAILED
>>>>>    - Fixed error handling to be done under lock in bg_migration_thread()
>>>>>    - Made sure an error is always set in case of failure in
>>>>>      qemu_savevm_state_setup()
>>>>>    migration/savevm.h    |  2 +-
>>>>>    migration/migration.c | 27 ++++++++++++++++++++++++---
>>>>>    migration/savevm.c    | 26 +++++++++++++++-----------
>>>>>    3 files changed, 40 insertions(+), 15 deletions(-)
>>>>>
>>>>> diff --git a/migration/savevm.h b/migration/savevm.h
>>>>> index 74669733dd63a080b765866c703234a5c4939223..9ec96a995c93a42aad621595f0ed58596c532328 100644
>>>>> --- a/migration/savevm.h
>>>>> +++ b/migration/savevm.h
>>>>> @@ -32,7 +32,7 @@
>>>>>    bool qemu_savevm_state_blocked(Error **errp);
>>>>>    void qemu_savevm_non_migratable_list(strList **reasons);
>>>>>    int qemu_savevm_state_prepare(Error **errp);
>>>>> -void qemu_savevm_state_setup(QEMUFile *f);
>>>>> +int qemu_savevm_state_setup(QEMUFile *f, Error **errp);
>>>>>    bool qemu_savevm_state_guest_unplug_pending(void);
>>>>>    int qemu_savevm_state_resume_prepare(MigrationState *s);
>>>>>    void qemu_savevm_state_header(QEMUFile *f);
>>>>> diff --git a/migration/migration.c b/migration/migration.c
>>>>> index a49fcd53ee19df1ce0182bc99d7e064968f0317b..6d1544224e96f5edfe56939a9c8395d88ef29581 100644
>>>>> --- a/migration/migration.c
>>>>> +++ b/migration/migration.c
>>>>> @@ -3408,6 +3408,8 @@ static void *migration_thread(void *opaque)
>>>>>        int64_t setup_start = qemu_clock_get_ms(QEMU_CLOCK_HOST);
>>>>>        MigThrError thr_error;
>>>>>        bool urgent = false;
>>>>> +    Error *local_err = NULL;
>>>>> +    int ret;
>>>>>        thread = migration_threads_add("live_migration", qemu_get_thread_id());
>>>>> @@ -3451,9 +3453,17 @@ static void *migration_thread(void *opaque)
>>>>>        }
>>>>>        bql_lock();
>>>>> -    qemu_savevm_state_setup(s->to_dst_file);
>>>>> +    ret = qemu_savevm_state_setup(s->to_dst_file, &local_err);
>>>>>        bql_unlock();
>>>>> +    if (ret) {
>>>>> +        migrate_set_error(s, local_err);
>>>>> +        error_free(local_err);
>>>>> +        migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
>>>>> +                          MIGRATION_STATUS_FAILED);
>>>>> +        goto out;
>>>>> +     }
>>>>> +
>>>>>        qemu_savevm_wait_unplug(s, MIGRATION_STATUS_SETUP,
>>>>>                                   MIGRATION_STATUS_ACTIVE);
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
>>>            qemu_savevm_send_colo_enable(s->to_dst_file);
>>>        }
>>> +    qemu_savevm_wait_unplug(s, MIGRATION_STATUS_SETUP,
>>> +                            MIGRATION_STATUS_SETUP);
>>> +
>>
>> Why move it all the way up here? Has moving the wait_unplug before the
>> 'if (ret)' block not worked for you?
> 
> We could be sleeping while holding the BQL. It looked wrong.

Sorry wrong answer. Yes I can try moving it before the 'if (ret)' block.
I can reproduce easily with an x86 guest running on PPC64.

Thanks,

C.


