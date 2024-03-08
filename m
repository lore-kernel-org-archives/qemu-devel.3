Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DD3AC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 13:40:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riaS4-00057d-7R; Fri, 08 Mar 2024 08:39:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1riaS3-00057H-ED
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 08:39:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1riaS1-0006dl-EE
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 08:39:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709905192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3/nzcf36H9h1M1ZVBO7XyYPyUTqK4LaY1YkD/FOK3pY=;
 b=Y9M08xHV0YiNJ6yiClFSyralM75ew5bCXSXOjTIVGCPF/RgNxQa/TkFtnw1cQjEPPAaey8
 e8XG7WiiSRPKQUjXY7Z4HQ8EohtKUKd00MXKqRzz5UoVG4As/JT1rP67i2IWp50Yx+Q43x
 Xav/Ttq0yP2IEuQy5j2iRUNlwtmunvo=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-3WHtUFQfMmyeZ1IcrF_BSg-1; Fri, 08 Mar 2024 08:39:50 -0500
X-MC-Unique: 3WHtUFQfMmyeZ1IcrF_BSg-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-51325a4d003so2318388e87.3
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 05:39:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709905189; x=1710509989;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3/nzcf36H9h1M1ZVBO7XyYPyUTqK4LaY1YkD/FOK3pY=;
 b=gS6r4Ozh65um/gJ7lwq7m9IoEMKAnR2lThxiyeg5MgXIk2eJGsckrvl3xETH9lp9fh
 +ZgXH06/SPse4qY/BUraXfVeiedwTm0bfnPwbGyHND2IM9VrpeIFKjDn8iAlCICqaTsS
 hzemMAUn48H+UCM2uGMiyOH1NJlySmC1u+QUg+mwzuRH53RvZst5HjAcal1F7rNNXYj4
 TeAPjz/wG1fTYWEWoUWSj0dGqsx6rQbimn6gCkW3Aohq06XJxi1BRVlaIF9oHBgQxfn8
 2vywUDiU2GEBE3mZymow+8Oom7ExES9o+VCDJ5GE8Fb81UEWxMrQotGmYwih7L6xP7rA
 90bA==
X-Gm-Message-State: AOJu0YwhCa0spO4yk/PAtcepDobFyyyR84gbvMtLhaqYRIl+NGX3Rgx0
 7lmzp88u8zssTjlKsEPJs71YjwJN0smgRFZokDQHggSBoUw2MFIRwG4VTaP/da8/VmNep3XEvBW
 uqo8b86zqChmn2YlcOq/+YWlVR+pprKZHBQHUWjaykuWZjphATEkd
X-Received: by 2002:ac2:4e08:0:b0:513:8a5b:e3c7 with SMTP id
 e8-20020ac24e08000000b005138a5be3c7mr2390151lfr.0.1709905189420; 
 Fri, 08 Mar 2024 05:39:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHVBkLTJ4XrXXMMUnhdbvNNEZz8VzU1ChMQhY/9MGCI3ZYww4HWNPYFQnec5hwuV+5vMKb5ng==
X-Received: by 2002:ac2:4e08:0:b0:513:8a5b:e3c7 with SMTP id
 e8-20020ac24e08000000b005138a5be3c7mr2390134lfr.0.1709905189037; 
 Fri, 08 Mar 2024 05:39:49 -0800 (PST)
Received: from ?IPV6:2a01:cb19:853d:fa00:c28a:3e3d:34f3:3891?
 ([2a01:cb19:853d:fa00:c28a:3e3d:34f3:3891])
 by smtp.gmail.com with ESMTPSA id
 bu16-20020a056000079000b0033dc3f3d689sm23150895wrb.93.2024.03.08.05.39.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Mar 2024 05:39:48 -0800 (PST)
Message-ID: <cd1ec55d-acdc-4960-8a9c-24c42ff669fa@redhat.com>
Date: Fri, 8 Mar 2024 14:39:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/25] migration: Add Error** argument to
 qemu_savevm_state_setup()
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
To: Peter Xu <peterx@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>
References: <20240306133441.2351700-1-clg@redhat.com>
 <20240306133441.2351700-11-clg@redhat.com> <ZesLDCwh3r_pV2r3@x1n>
 <deec998e-cab5-4aff-8582-86031778b089@redhat.com>
In-Reply-To: <deec998e-cab5-4aff-8582-86031778b089@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.572,
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

On 3/8/24 14:14, Cédric Le Goater wrote:
> On 3/8/24 13:56, Peter Xu wrote:
>> On Wed, Mar 06, 2024 at 02:34:25PM +0100, Cédric Le Goater wrote:
>>> This prepares ground for the changes coming next which add an Error**
>>> argument to the .save_setup() handler. Callers of qemu_savevm_state_setup()
>>> now handle the error and fail earlier setting the migration state from
>>> MIGRATION_STATUS_SETUP to MIGRATION_STATUS_FAILED.
>>>
>>> In qemu_savevm_state(), move the cleanup to preserve the error
>>> reported by .save_setup() handlers.
>>>
>>> Since the previous behavior was to ignore errors at this step of
>>> migration, this change should be examined closely to check that
>>> cleanups are still correctly done.
>>>
>>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>>> ---
>>>
>>>   Changes in v4:
>>>   - Merged cleanup change in qemu_savevm_state()
>>>   Changes in v3:
>>>   - Set migration state to MIGRATION_STATUS_FAILED
>>>   - Fixed error handling to be done under lock in bg_migration_thread()
>>>   - Made sure an error is always set in case of failure in
>>>     qemu_savevm_state_setup()
>>>   migration/savevm.h    |  2 +-
>>>   migration/migration.c | 27 ++++++++++++++++++++++++---
>>>   migration/savevm.c    | 26 +++++++++++++++-----------
>>>   3 files changed, 40 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/migration/savevm.h b/migration/savevm.h
>>> index 74669733dd63a080b765866c703234a5c4939223..9ec96a995c93a42aad621595f0ed58596c532328 100644
>>> --- a/migration/savevm.h
>>> +++ b/migration/savevm.h
>>> @@ -32,7 +32,7 @@
>>>   bool qemu_savevm_state_blocked(Error **errp);
>>>   void qemu_savevm_non_migratable_list(strList **reasons);
>>>   int qemu_savevm_state_prepare(Error **errp);
>>> -void qemu_savevm_state_setup(QEMUFile *f);
>>> +int qemu_savevm_state_setup(QEMUFile *f, Error **errp);
>>>   bool qemu_savevm_state_guest_unplug_pending(void);
>>>   int qemu_savevm_state_resume_prepare(MigrationState *s);
>>>   void qemu_savevm_state_header(QEMUFile *f);
>>> diff --git a/migration/migration.c b/migration/migration.c
>>> index a49fcd53ee19df1ce0182bc99d7e064968f0317b..6d1544224e96f5edfe56939a9c8395d88ef29581 100644
>>> --- a/migration/migration.c
>>> +++ b/migration/migration.c
>>> @@ -3408,6 +3408,8 @@ static void *migration_thread(void *opaque)
>>>       int64_t setup_start = qemu_clock_get_ms(QEMU_CLOCK_HOST);
>>>       MigThrError thr_error;
>>>       bool urgent = false;
>>> +    Error *local_err = NULL;
>>> +    int ret;
>>>       thread = migration_threads_add("live_migration", qemu_get_thread_id());
>>> @@ -3451,9 +3453,17 @@ static void *migration_thread(void *opaque)
>>>       }
>>>       bql_lock();
>>> -    qemu_savevm_state_setup(s->to_dst_file);
>>> +    ret = qemu_savevm_state_setup(s->to_dst_file, &local_err);
>>>       bql_unlock();
>>> +    if (ret) {
>>> +        migrate_set_error(s, local_err);
>>> +        error_free(local_err);
>>> +        migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
>>> +                          MIGRATION_STATUS_FAILED);
>>> +        goto out;
>>> +     }
>>
>> There's a small indent issue, I can fix it.
> 
> checkpatch did report anything.
> 
>>
>> The bigger problem is I _think_ this will trigger a ci failure in the
>> virtio-net-failover test:
>>
>> ▶ 121/464 ERROR:../tests/qtest/virtio-net-failover.c:1203:test_migrate_abort_wait_unplug: assertion failed (status == "cancelling"): ("cancelled" == "cancelling") ERROR
>> 121/464 qemu:qtest+qtest-x86_64 / qtest-x86_64/virtio-net-failover    ERROR            4.77s   killed by signal 6 SIGABRT
>>>>> PYTHON=/builds/peterx/qemu/build/pyvenv/bin/python3.8 G_TEST_DBUS_DAEMON=/builds/peterx/qemu/tests/dbus-vmstate-daemon.sh MALLOC_PERTURB_=161 QTEST_QEMU_IMG=./qemu-img QTEST_QEMU_STORAGE_DAEMON_BINARY=./storage-daemon/qemu-storage-daemon QTEST_QEMU_BINARY=./qemu-system-x86_64 /builds/peterx/qemu/build/tests/qtest/virtio-net-failover --tap -k
>> ――――――――――――――――――――――――――――――――――――― ✀  ―――――――――――――――――――――――――――――――――――――
>> stderr:
>> qemu-system-x86_64: ram_save_setup failed: Input/output error
>> **
>> ERROR:../tests/qtest/virtio-net-failover.c:1203:test_migrate_abort_wait_unplug: assertion failed (status == "cancelling"): ("cancelled" == "cancelling")
>> (test program exited with status code -6)
>> ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
>>
>> I am not familiar enough with the failover code, and may not have time
>> today to follow this up, copy Laurent.  Cedric, if you have time, please
>> have a look. 
> 
> 
> Sure. Weird because I usually run make check on x86_64, s390x, ppc64 and
> aarch64. Let me check again.

I see one timeout error on s390x but not always. See below. It occurs with
or without this patchset. the other x86_64, ppc64 arches run fine (a part
from one io  test failing from time to time)

Thanks,

C.






# Start of compress tests
# Running /s390x/migration/postcopy/recovery/compress/plain
# Using machine type: s390-ccw-virtio-9.0
# starting QEMU: exec ./qemu-system-s390x -qtest unix:/tmp/qtest-3064311.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-3064311.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -accel kvm -accel tcg -machine s390-ccw-virtio-9.0, -name source,debug-threads=on -m 128M -serial file:/tmp/migration-test-TO8BK2/src_serial -bios /tmp/migration-test-TO8BK2/bootsect    2>/dev/null -accel qtest
# starting QEMU: exec ./qemu-system-s390x -qtest unix:/tmp/qtest-3064311.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-3064311.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -accel kvm -accel tcg -machine s390-ccw-virtio-9.0, -name target,debug-threads=on -m 128M -serial file:/tmp/migration-test-TO8BK2/dest_serial -incoming defer -bios /tmp/migration-test-TO8BK2/bootsect    2>/dev/null -accel qtest

**
ERROR:../tests/qtest/migration-helpers.c:205:wait_for_migration_status: assertion failed: (g_test_timer_elapsed() < MIGRATION_STATUS_WAIT_TIMEOUT)
Bail out! ERROR:../tests/qtest/migration-helpers.c:205:wait_for_migration_status: assertion failed: (g_test_timer_elapsed() < MIGRATION_STATUS_WAIT_TIMEOUT)
../tests/qtest/libqtest.c:204: kill_qemu() detected QEMU death from signal 9 (Killed)
Aborted (core dumped)


