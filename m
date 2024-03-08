Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10331C54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 13:56:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riahm-0002cU-BY; Fri, 08 Mar 2024 08:56:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1riahS-0002Ek-0V
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 08:55:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1riahH-0002zS-AW
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 08:55:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709906138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kc/kxz6wlrJtESi2SvPeBi4ps7HsKxR0EZPbsh2Sh88=;
 b=CIJjY10yj3rR2nb892/oC2DzI9XOhEDhXhjcCgIJH86re7rSDoKkIjtVvgsAhdhWpEuV50
 AKb/U6qNdolepsuDzEBXX4R0UCRtEWT3JbRXfFPiLCKqLv3/PVPOUliwNA+lOxCAxuJPc0
 6Vy/evFJZtG7SHS6sHkaBwee1Yloq5c=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-v3p5nzebO5meyTddIkQItg-1; Fri, 08 Mar 2024 08:55:36 -0500
X-MC-Unique: v3p5nzebO5meyTddIkQItg-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-60a012e6888so16656647b3.2
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 05:55:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709906136; x=1710510936;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Kc/kxz6wlrJtESi2SvPeBi4ps7HsKxR0EZPbsh2Sh88=;
 b=PSLM69DaJjVvzuxSog4pp5hbKSA+lW3yPHjo/XjrfJbU2jjxE8e0ZjYyNJiAoLwOyD
 x6q74FSO63hosN/Bnm/A93qxDjMGzhkdSS4FmxHi2lphiC1G88q6eCjr316YiwbxyLRf
 2Xjgwrbh7NvvM9YZsMGqGgIpnFD+gqszyaMnZ2PJWcy0L37ksfsYIePV+LE3RB4/fR5Z
 tnrLvmeEasOig+ZJAN8eqyJWeLWWo+Nctw4Mwehih7Gk9fmbpMitZ85uixIa6s5tWL6z
 1qTzAM9tk+jvfu1ofcpA5pnqRqSaWJmi49rDs681p/V9Kgs02jWGPaa0jHPtdq0nU6RB
 dyeg==
X-Gm-Message-State: AOJu0YyOjFzGzsxXqjMZ2waGRN14Ah9mCwAOAc/PEC5U3xQ6vQ8/wqk6
 A6WKSwXzilfsV6E6PMwWkAnvmj6iyx+9X+q55vdrhKaDLGs1VR/QWjbnBe0se1PnyFMMhImf5ni
 rFtA7FWryuLlW9MQqFA/MR5V7syQ2ZIxZHHNpuKxIIEYD8UBFewNZ
X-Received: by 2002:a05:6902:1029:b0:dcc:4a0a:d0ba with SMTP id
 x9-20020a056902102900b00dcc4a0ad0bamr20877750ybt.63.1709906136375; 
 Fri, 08 Mar 2024 05:55:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGsA7XkuZb4yM4rkCCoYMtug8bZBpCDFrnga4PBcEAVYj8wP89WavgomnYtCvWOhVgoC/WWcg==
X-Received: by 2002:a05:6902:1029:b0:dcc:4a0a:d0ba with SMTP id
 x9-20020a056902102900b00dcc4a0ad0bamr20877728ybt.63.1709906136015; 
 Fri, 08 Mar 2024 05:55:36 -0800 (PST)
Received: from ?IPV6:2a01:cb19:853d:fa00:c28a:3e3d:34f3:3891?
 ([2a01:cb19:853d:fa00:c28a:3e3d:34f3:3891])
 by smtp.gmail.com with ESMTPSA id
 cz4-20020a05620a36c400b007883bee099fsm3150350qkb.22.2024.03.08.05.55.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Mar 2024 05:55:35 -0800 (PST)
Message-ID: <9772e612-6ecc-4a8f-aae8-86884397f39d@redhat.com>
Date: Fri, 8 Mar 2024 14:55:30 +0100
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
 <cd1ec55d-acdc-4960-8a9c-24c42ff669fa@redhat.com>
In-Reply-To: <cd1ec55d-acdc-4960-8a9c-24c42ff669fa@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 3/8/24 14:39, Cédric Le Goater wrote:
> On 3/8/24 14:14, Cédric Le Goater wrote:
>> On 3/8/24 13:56, Peter Xu wrote:
>>> On Wed, Mar 06, 2024 at 02:34:25PM +0100, Cédric Le Goater wrote:
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
>>>>   Changes in v4:
>>>>   - Merged cleanup change in qemu_savevm_state()
>>>>   Changes in v3:
>>>>   - Set migration state to MIGRATION_STATUS_FAILED
>>>>   - Fixed error handling to be done under lock in bg_migration_thread()
>>>>   - Made sure an error is always set in case of failure in
>>>>     qemu_savevm_state_setup()
>>>>   migration/savevm.h    |  2 +-
>>>>   migration/migration.c | 27 ++++++++++++++++++++++++---
>>>>   migration/savevm.c    | 26 +++++++++++++++-----------
>>>>   3 files changed, 40 insertions(+), 15 deletions(-)
>>>>
>>>> diff --git a/migration/savevm.h b/migration/savevm.h
>>>> index 74669733dd63a080b765866c703234a5c4939223..9ec96a995c93a42aad621595f0ed58596c532328 100644
>>>> --- a/migration/savevm.h
>>>> +++ b/migration/savevm.h
>>>> @@ -32,7 +32,7 @@
>>>>   bool qemu_savevm_state_blocked(Error **errp);
>>>>   void qemu_savevm_non_migratable_list(strList **reasons);
>>>>   int qemu_savevm_state_prepare(Error **errp);
>>>> -void qemu_savevm_state_setup(QEMUFile *f);
>>>> +int qemu_savevm_state_setup(QEMUFile *f, Error **errp);
>>>>   bool qemu_savevm_state_guest_unplug_pending(void);
>>>>   int qemu_savevm_state_resume_prepare(MigrationState *s);
>>>>   void qemu_savevm_state_header(QEMUFile *f);
>>>> diff --git a/migration/migration.c b/migration/migration.c
>>>> index a49fcd53ee19df1ce0182bc99d7e064968f0317b..6d1544224e96f5edfe56939a9c8395d88ef29581 100644
>>>> --- a/migration/migration.c
>>>> +++ b/migration/migration.c
>>>> @@ -3408,6 +3408,8 @@ static void *migration_thread(void *opaque)
>>>>       int64_t setup_start = qemu_clock_get_ms(QEMU_CLOCK_HOST);
>>>>       MigThrError thr_error;
>>>>       bool urgent = false;
>>>> +    Error *local_err = NULL;
>>>> +    int ret;
>>>>       thread = migration_threads_add("live_migration", qemu_get_thread_id());
>>>> @@ -3451,9 +3453,17 @@ static void *migration_thread(void *opaque)
>>>>       }
>>>>       bql_lock();
>>>> -    qemu_savevm_state_setup(s->to_dst_file);
>>>> +    ret = qemu_savevm_state_setup(s->to_dst_file, &local_err);
>>>>       bql_unlock();
>>>> +    if (ret) {
>>>> +        migrate_set_error(s, local_err);
>>>> +        error_free(local_err);
>>>> +        migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
>>>> +                          MIGRATION_STATUS_FAILED);
>>>> +        goto out;
>>>> +     }
>>>
>>> There's a small indent issue, I can fix it.
>>
>> checkpatch did report anything.
>>
>>>
>>> The bigger problem is I _think_ this will trigger a ci failure in the
>>> virtio-net-failover test:
>>>
>>> ▶ 121/464 ERROR:../tests/qtest/virtio-net-failover.c:1203:test_migrate_abort_wait_unplug: assertion failed (status == "cancelling"): ("cancelled" == "cancelling") ERROR
>>> 121/464 qemu:qtest+qtest-x86_64 / qtest-x86_64/virtio-net-failover    ERROR            4.77s   killed by signal 6 SIGABRT
>>>>>> PYTHON=/builds/peterx/qemu/build/pyvenv/bin/python3.8 G_TEST_DBUS_DAEMON=/builds/peterx/qemu/tests/dbus-vmstate-daemon.sh MALLOC_PERTURB_=161 QTEST_QEMU_IMG=./qemu-img QTEST_QEMU_STORAGE_DAEMON_BINARY=./storage-daemon/qemu-storage-daemon QTEST_QEMU_BINARY=./qemu-system-x86_64 /builds/peterx/qemu/build/tests/qtest/virtio-net-failover --tap -k
>>> ――――――――――――――――――――――――――――――――――――― ✀  ―――――――――――――――――――――――――――――――――――――
>>> stderr:
>>> qemu-system-x86_64: ram_save_setup failed: Input/output error
>>> **
>>> ERROR:../tests/qtest/virtio-net-failover.c:1203:test_migrate_abort_wait_unplug: assertion failed (status == "cancelling"): ("cancelled" == "cancelling")
>>> (test program exited with status code -6)
>>> ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
>>>
>>> I am not familiar enough with the failover code, and may not have time
>>> today to follow this up, copy Laurent.  Cedric, if you have time, please
>>> have a look. 
>>
>>
>> Sure. Weird because I usually run make check on x86_64, s390x, ppc64 and
>> aarch64. Let me check again.
> 
> I see one timeout error on s390x but not always. See below. It occurs with
> or without this patchset. the other x86_64, ppc64 arches run fine (a part
> from one io  test failing from time to time)

Ah ! I got this once on aarch64 :

  161/486 ERROR:../tests/qtest/virtio-net-failover.c:1222:test_migrate_abort_wait_unplug: 'device' should not be NULL ERROR
161/486 qemu:qtest+qtest-x86_64 / qtest-x86_64/virtio-net-failover                  ERROR            5.98s   killed by signal 6 SIGABRT
>>> G_TEST_DBUS_DAEMON=/home/legoater/work/qemu/qemu.git/tests/dbus-vmstate-daemon.sh MALLOC_PERTURB_=119 QTEST_QEMU_BINARY=./qemu-system-x86_64 QTEST_QEMU_IMG=./qemu-img PYTHON=/home/legoater/work/qemu/qemu.git/build/pyvenv/bin/python3 QTEST_QEMU_STORAGE_DAEMON_BINARY=./storage-daemon/qemu-storage-daemon /home/legoater/work/qemu/qemu.git/build/tests/qtest/virtio-net-failover --tap -k
―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― ✀  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
stderr:
qemu-system-x86_64: ram_save_setup failed: Input/output error
**
ERROR:../tests/qtest/virtio-net-failover.c:1222:test_migrate_abort_wait_unplug: 'device' should not be NULL

(test program exited with status code -6)
―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――

I couldn't reproduce yet :/

Thanks,

C.





