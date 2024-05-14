Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25D5DC25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 01:16:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6glk-00040G-IY; Mon, 13 May 2024 21:15:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mgalaxy@akamai.com>)
 id 1s6glL-0003uu-Om
 for qemu-devel@nongnu.org; Mon, 13 May 2024 21:15:28 -0400
Received: from mx0b-00190b01.pphosted.com ([2620:100:9005:57f::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mgalaxy@akamai.com>)
 id 1s6glJ-0004Dr-8g
 for qemu-devel@nongnu.org; Mon, 13 May 2024 21:15:27 -0400
Received: from pps.filterd (m0122330.ppops.net [127.0.0.1])
 by mx0b-00190b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44DJTJrJ010746;
 Tue, 14 May 2024 02:15:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 jan2016.eng; bh=+ITBOHQAQH0L8Y1PdnAde6ZemZd6yREmVM8kqA3Wc1M=; b=
 UzpjFJtR2P9kcKhRys17qyUnzPhxPq/PS3KYGrUNNx+IEdbrJw5Ph6j4PhID5pxJ
 6iMbkWjN4i04P4NRoQndVwe6WGAsvREDXoY20dZsfTHA/tKZESFefCrboQ06Bpfw
 7liwHSHa5anhQUJ/y3UTwu5p8S61I4MOC551naPL6z6jlaY511Du4e5bFqLlpDhm
 R4JQ+YQQnNAaohh3HRa9u4+037+Zjchsu5zTudIXlTtRPv4zKlw1WXT3c9vSBqp0
 USp2CV6Sb9qhFoN04CX9mco5rDzjTP7pZfgop/Xnrr/V84faFvkZ3wQS5citz5g2
 KLaJw60ZvXU2jE249KMl2A==
Received: from prod-mail-ppoint1 (prod-mail-ppoint1.akamai.com [184.51.33.18]
 (may be forged))
 by mx0b-00190b01.pphosted.com (PPS) with ESMTPS id 3y20b45344-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 May 2024 02:15:21 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint1.akamai.com [127.0.0.1])
 by prod-mail-ppoint1.akamai.com (8.17.1.19/8.17.1.19) with ESMTP id
 44DJkT6C026042; Mon, 13 May 2024 21:15:20 -0400
Received: from prod-mail-relay10.akamai.com ([172.27.118.251])
 by prod-mail-ppoint1.akamai.com (PPS) with ESMTP id 3y240xy370-1;
 Mon, 13 May 2024 21:15:20 -0400
Received: from [100.64.0.1] (prod-aoa-csiteclt14.bos01.corp.akamai.com
 [172.27.97.51])
 by prod-mail-relay10.akamai.com (Postfix) with ESMTP id 7AEC264EF1;
 Tue, 14 May 2024 01:15:18 +0000 (GMT)
Message-ID: <d6176480-d87c-492b-8a0c-04bf81a4f59a@akamai.com>
Date: Mon, 13 May 2024 20:15:17 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: CPR/liveupdate: test results using prior bug fix
To: Steven Sistare <steven.sistare@oracle.com>, peterx@redhat.com,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Eric Blake <eblake@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Hunt, Joshua" <johunt@akamai.com>
References: <20240228051315.400759-1-peterx@redhat.com>
 <20240228051315.400759-21-peterx@redhat.com>
 <f855963e-b7dd-4ce8-89dc-dfaa87e896c4@akamai.com>
 <82c69792-061d-460f-9db6-88fc8f9df5af@oracle.com>
Content-Language: en-US
From: Michael Galaxy <mgalaxy@akamai.com>
In-Reply-To: <82c69792-061d-460f-9db6-88fc8f9df5af@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-13_17,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405140006
X-Proofpoint-ORIG-GUID: EDaZFLUPYnKhkxsOgna4oiWaJ5pOnGZq
X-Proofpoint-GUID: EDaZFLUPYnKhkxsOgna4oiWaJ5pOnGZq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-13_17,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 bulkscore=0 suspectscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405010000
 definitions=main-2405140007
Received-SPF: pass client-ip=2620:100:9005:57f::1;
 envelope-from=mgalaxy@akamai.com; helo=mx0b-00190b01.pphosted.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi Steve,

Thanks for the response.

It looks like literally *just today* 8.2.4 was released. I'll go check 
it out.

- Michael

On 5/13/24 15:10, Steven Sistare wrote:
> Hi Michael,
>   No surprise here, I did see some of the same failure messages and they
> prompted me to submit the fix.  They are all symptoms of "the 
> possibility of
> ram and device state being out of sync" as mentioned in the commit.
>
> I am not familiar with the process for maintaining old releases for qemu.
> Perhaps someone on this list can comment on 8.2.3.
>
> - Steve
>
> On 5/13/2024 2:22 PM, Michael Galaxy wrote:
>> Hi Steve,
>>
>> We found that this specific change in particular ("migration: stop vm 
>> for cpr") fixes a bug that we've identified in testing back-to-back 
>> live updates in a lab environment.
>>
>> More specifically, *without* this change (which is not available in 
>> 8.2.2, but *is* available in 9.0.0) causes the metadata save file to 
>> be corrupted when doing live updates one after another. Typically we 
>> see a corrupted save file somewhere in between 20 and 30 live updates 
>> and while doing a git bisect, we found that this change makes the 
>> problem go away.
>>
>> Were you aware? Is there any plan in place to cherry pick this for 
>> 8.2.3, perhaps or a plan to release 8.2.3 at some point?
>>
>> Here are some examples of how the bug manifests in different 
>> locations of the QEMU metadata save file:
>>
>> 2024-04-26T13:28:53Z qemu-system-x86_64: Failed to load mtrr_var:base
>> 2024-04-26T13:28:53Z qemu-system-x86_64: Failed to load cpu:env.mtrr_var
>> 2024-04-26T13:28:53Z qemu-system-x86_64: error while loading state 
>> for instance 0x1b of device 'cpu'
>> 2024-04-26T13:28:53Z qemu-system-x86_64: load of migration failed: 
>> Input/output error
>>
>> And another:
>>
>> 2024-04-17T16:09:47Z qemu-system-x86_64: check_section_footer: Read 
>> section footer failed: -5
>> 2024-04-17T16:09:47Z qemu-system-x86_64: load of migration failed: 
>> Invalid argument
>>
>> And another:
>>
>> 2024-04-30T21:53:29Z qemu-system-x86_64: Unable to read ID string for 
>> section 163
>> 2024-04-30T21:53:29Z qemu-system-x86_64: load of migration failed: 
>> Invalid argument
>>
>> And another:
>>
>> 2024-05-01T16:01:44Z qemu-system-x86_64: Unable to read ID string for 
>> section 164
>> 2024-05-01T16:01:44Z qemu-system-x86_64: load of migration failed: 
>> Invalid argument
>>
>> As you can see, they occur quite randomly, but generally it takes at 
>> least 20-30+ live updates before the problem occurs.
>>
>> - Michael
>>
>> On 2/27/24 23:13, peterx@redhat.com wrote:
>>> From: Steve Sistare<steven.sistare@oracle.com>
>>>
>>> When migration for cpr is initiated, stop the vm and set state
>>> RUN_STATE_FINISH_MIGRATE before ram is saved.  This eliminates the
>>> possibility of ram and device state being out of sync, and guarantees
>>> that a guest in the suspended state remains suspended, because qmp_cont
>>> rejects a cont command in the RUN_STATE_FINISH_MIGRATE state.
>>>
>>> Signed-off-by: Steve Sistare<steven.sistare@oracle.com>
>>> Reviewed-by: Peter Xu<peterx@redhat.com>
>>> Link:https://urldefense.com/v3/__https://lore.kernel.org/r/1708622920-68779-11-git-send-email-steven.sistare@oracle.com__;!!GjvTz_vk!QLsFOCX-x2U9bzAo98SdidKlomHrmf_t0UmQKtgudoIcaDVoAJOPm39ZqaNP_nT5I8QqVfSgwhDZmg$ 
>>> Signed-off-by: Peter Xu<peterx@redhat.com>
>>> ---
>>>   include/migration/misc.h |  1 +
>>>   migration/migration.h    |  2 --
>>>   migration/migration.c    | 51 
>>> ++++++++++++++++++++++++----------------
>>>   3 files changed, 32 insertions(+), 22 deletions(-)
>>>
>>> diff --git a/include/migration/misc.h b/include/migration/misc.h
>>> index e4933b815b..5d1aa593ed 100644
>>> --- a/include/migration/misc.h
>>> +++ b/include/migration/misc.h
>>> @@ -60,6 +60,7 @@ void migration_object_init(void);
>>>   void migration_shutdown(void);
>>>   bool migration_is_idle(void);
>>>   bool migration_is_active(MigrationState *);
>>> +bool migrate_mode_is_cpr(MigrationState *);
>>>     typedef enum MigrationEventType {
>>>       MIG_EVENT_PRECOPY_SETUP,
>>> diff --git a/migration/migration.h b/migration/migration.h
>>> index aef8afbe1f..65c0b61cbd 100644
>>> --- a/migration/migration.h
>>> +++ b/migration/migration.h
>>> @@ -541,6 +541,4 @@ int migration_rp_wait(MigrationState *s);
>>>    */
>>>   void migration_rp_kick(MigrationState *s);
>>>   -int migration_stop_vm(RunState state);
>>> -
>>>   #endif
>>> diff --git a/migration/migration.c b/migration/migration.c
>>> index 37c836b0b0..90a90947fb 100644
>>> --- a/migration/migration.c
>>> +++ b/migration/migration.c
>>> @@ -167,11 +167,19 @@ static gint 
>>> page_request_addr_cmp(gconstpointer ap, gconstpointer bp)
>>>       return (a > b) - (a < b);
>>>   }
>>>   -int migration_stop_vm(RunState state)
>>> +static int migration_stop_vm(MigrationState *s, RunState state)
>>>   {
>>> -    int ret = vm_stop_force_state(state);
>>> +    int ret;
>>> +
>>> +    migration_downtime_start(s);
>>> +
>>> +    s->vm_old_state = runstate_get();
>>> +    global_state_store();
>>> +
>>> +    ret = vm_stop_force_state(state);
>>>         trace_vmstate_downtime_checkpoint("src-vm-stopped");
>>> +    trace_migration_completion_vm_stop(ret);
>>>         return ret;
>>>   }
>>> @@ -1602,6 +1610,11 @@ bool migration_is_active(MigrationState *s)
>>>               s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE);
>>>   }
>>>   +bool migrate_mode_is_cpr(MigrationState *s)
>>> +{
>>> +    return s->parameters.mode == MIG_MODE_CPR_REBOOT;
>>> +}
>>> +
>>>   int migrate_init(MigrationState *s, Error **errp)
>>>   {
>>>       int ret;
>>> @@ -2454,10 +2467,7 @@ static int postcopy_start(MigrationState *ms, 
>>> Error **errp)
>>>       bql_lock();
>>>       trace_postcopy_start_set_run();
>>>   -    migration_downtime_start(ms);
>>> -
>>> -    global_state_store();
>>> -    ret = migration_stop_vm(RUN_STATE_FINISH_MIGRATE);
>>> +    ret = migration_stop_vm(ms, RUN_STATE_FINISH_MIGRATE);
>>>       if (ret < 0) {
>>>           goto fail;
>>>       }
>>> @@ -2652,15 +2662,12 @@ static int 
>>> migration_completion_precopy(MigrationState *s,
>>>       int ret;
>>>         bql_lock();
>>> -    migration_downtime_start(s);
>>> -
>>> -    s->vm_old_state = runstate_get();
>>> -    global_state_store();
>>>   -    ret = migration_stop_vm(RUN_STATE_FINISH_MIGRATE);
>>> -    trace_migration_completion_vm_stop(ret);
>>> -    if (ret < 0) {
>>> -        goto out_unlock;
>>> +    if (!migrate_mode_is_cpr(s)) {
>>> +        ret = migration_stop_vm(s, RUN_STATE_FINISH_MIGRATE);
>>> +        if (ret < 0) {
>>> +            goto out_unlock;
>>> +        }
>>>       }
>>>         ret = migration_maybe_pause(s, current_active_state,
>>> @@ -3500,15 +3507,10 @@ static void *bg_migration_thread(void *opaque)
>>>       s->setup_time = qemu_clock_get_ms(QEMU_CLOCK_HOST) - setup_start;
>>>         trace_migration_thread_setup_complete();
>>> -    migration_downtime_start(s);
>>>         bql_lock();
>>>   -    s->vm_old_state = runstate_get();
>>> -
>>> -    global_state_store();
>>> -    /* Forcibly stop VM before saving state of vCPUs and devices */
>>> -    if (migration_stop_vm(RUN_STATE_PAUSED)) {
>>> +    if (migration_stop_vm(s, RUN_STATE_PAUSED)) {
>>>           goto fail;
>>>       }
>>>       /*
>>> @@ -3584,6 +3586,7 @@ void migrate_fd_connect(MigrationState *s, 
>>> Error *error_in)
>>>       Error *local_err = NULL;
>>>       uint64_t rate_limit;
>>>       bool resume = s->state == MIGRATION_STATUS_POSTCOPY_PAUSED;
>>> +    int ret;
>>>         /*
>>>        * If there's a previous error, free it and prepare for 
>>> another one.
>>> @@ -3655,6 +3658,14 @@ void migrate_fd_connect(MigrationState *s, 
>>> Error *error_in)
>>>           return;
>>>       }
>>>   +    if (migrate_mode_is_cpr(s)) {
>>> +        ret = migration_stop_vm(s, RUN_STATE_FINISH_MIGRATE);
>>> +        if (ret < 0) {
>>> +            error_setg(&local_err, "migration_stop_vm failed, error 
>>> %d", -ret);
>>> +            goto fail;
>>> +        }
>>> +    }
>>> +
>>>       if (migrate_background_snapshot()) {
>>>           qemu_thread_create(&s->thread, "bg_snapshot",
>>>                   bg_migration_thread, s, QEMU_THREAD_JOINABLE);

