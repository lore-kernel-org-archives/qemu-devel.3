Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 845F5C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 13:14:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ria3A-0002Xx-M6; Fri, 08 Mar 2024 08:14:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ria38-0002Xl-1t
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 08:14:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ria35-0007bD-Vf
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 08:14:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709903647;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sx6/WbHa0+8z+D6kYcQTPV7lUcS8fuJktOyHRi6J4MM=;
 b=GpgYBWLCGS0N3ZPlJN7AFwdEMLFfjSh6brRCbONzGK2gsomu9+BpDvZeEjaiK+PZJGjfia
 0ytob63tTxMKnzS01K3HC9nfcguq5Z8b7MzOb7WGh02gHNAeLMYbnOaWt021wUUU5pITFd
 OEpFgO0yJd4yfHZm3N9YsV49C/5aB5E=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-MF16t89VPFOupeL__nfS0g-1; Fri, 08 Mar 2024 08:14:05 -0500
X-MC-Unique: MF16t89VPFOupeL__nfS0g-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-412d433bba5so3998455e9.0
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 05:14:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709903645; x=1710508445;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sx6/WbHa0+8z+D6kYcQTPV7lUcS8fuJktOyHRi6J4MM=;
 b=lrzm2fVY+y/+mQxqrAfxetgSyo/5o8jgzdCCsEHqSda6de1AIjPsDcqIpJ/NGypxne
 HIZqFUJR8Q5b3gL0uBX5GheMdebMaWBS5amDBPyiDawmorbsfq1gkzym4j10n5KOwoI+
 IZn6u5sNb4DsCnHEsr6XC5FxWL7JYUMu1X/NY+NsasSzaV4Bn+QxvJCMi8mw4lq7Xfyi
 t2JDITG53Q+/3cT2kFLyc0QG1QoZEZNSoCQQMv0MLSWp7qhjuV1Vr/mmAHTCMHDs5Vea
 Fcg+a877uOBMXNLY2HyiMx2zrCKKp9ciuFBd//qZF/TC0Bp6Ikr3PlHB+5pk1x82rVNj
 ZyFg==
X-Gm-Message-State: AOJu0YydqizUUjRajhs07q0sjOHp7HpK72OWlv0cY5b+xB3wr+s7O7hz
 pqs1Mmrksel6nc0vYDHmOrNhQUOkIpvoJLFSTOOvJ5gzrc3Wg8uUrKJURFHT4X3ovxbFjPc7Wpg
 CrxYW3n9STWgdbXBYwNsXmcdckXx20ht25nAZBnlrx1+Wb8pz9eRV
X-Received: by 2002:a05:600c:19cf:b0:413:128a:403 with SMTP id
 u15-20020a05600c19cf00b00413128a0403mr3291821wmq.1.1709903644677; 
 Fri, 08 Mar 2024 05:14:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGIr6Seg2e9dhM2fLX+Pn9wCeIMJm4xzN+GlmxN7ulDHFg+iinSQ92dqUNITfM994T/bEl6qQ==
X-Received: by 2002:a05:600c:19cf:b0:413:128a:403 with SMTP id
 u15-20020a05600c19cf00b00413128a0403mr3291797wmq.1.1709903644205; 
 Fri, 08 Mar 2024 05:14:04 -0800 (PST)
Received: from ?IPV6:2a01:cb19:853d:fa00:c28a:3e3d:34f3:3891?
 ([2a01:cb19:853d:fa00:c28a:3e3d:34f3:3891])
 by smtp.gmail.com with ESMTPSA id
 t10-20020a05600c450a00b004131388d948sm3802611wmo.0.2024.03.08.05.14.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Mar 2024 05:14:03 -0800 (PST)
Message-ID: <deec998e-cab5-4aff-8582-86031778b089@redhat.com>
Date: Fri, 8 Mar 2024 14:14:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/25] migration: Add Error** argument to
 qemu_savevm_state_setup()
Content-Language: en-US, fr
To: Peter Xu <peterx@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>
References: <20240306133441.2351700-1-clg@redhat.com>
 <20240306133441.2351700-11-clg@redhat.com> <ZesLDCwh3r_pV2r3@x1n>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <ZesLDCwh3r_pV2r3@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.572,
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

On 3/8/24 13:56, Peter Xu wrote:
> On Wed, Mar 06, 2024 at 02:34:25PM +0100, Cédric Le Goater wrote:
>> This prepares ground for the changes coming next which add an Error**
>> argument to the .save_setup() handler. Callers of qemu_savevm_state_setup()
>> now handle the error and fail earlier setting the migration state from
>> MIGRATION_STATUS_SETUP to MIGRATION_STATUS_FAILED.
>>
>> In qemu_savevm_state(), move the cleanup to preserve the error
>> reported by .save_setup() handlers.
>>
>> Since the previous behavior was to ignore errors at this step of
>> migration, this change should be examined closely to check that
>> cleanups are still correctly done.
>>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>
>>   Changes in v4:
>>   
>>   - Merged cleanup change in qemu_savevm_state()
>>     
>>   Changes in v3:
>>   
>>   - Set migration state to MIGRATION_STATUS_FAILED
>>   - Fixed error handling to be done under lock in bg_migration_thread()
>>   - Made sure an error is always set in case of failure in
>>     qemu_savevm_state_setup()
>>     
>>   migration/savevm.h    |  2 +-
>>   migration/migration.c | 27 ++++++++++++++++++++++++---
>>   migration/savevm.c    | 26 +++++++++++++++-----------
>>   3 files changed, 40 insertions(+), 15 deletions(-)
>>
>> diff --git a/migration/savevm.h b/migration/savevm.h
>> index 74669733dd63a080b765866c703234a5c4939223..9ec96a995c93a42aad621595f0ed58596c532328 100644
>> --- a/migration/savevm.h
>> +++ b/migration/savevm.h
>> @@ -32,7 +32,7 @@
>>   bool qemu_savevm_state_blocked(Error **errp);
>>   void qemu_savevm_non_migratable_list(strList **reasons);
>>   int qemu_savevm_state_prepare(Error **errp);
>> -void qemu_savevm_state_setup(QEMUFile *f);
>> +int qemu_savevm_state_setup(QEMUFile *f, Error **errp);
>>   bool qemu_savevm_state_guest_unplug_pending(void);
>>   int qemu_savevm_state_resume_prepare(MigrationState *s);
>>   void qemu_savevm_state_header(QEMUFile *f);
>> diff --git a/migration/migration.c b/migration/migration.c
>> index a49fcd53ee19df1ce0182bc99d7e064968f0317b..6d1544224e96f5edfe56939a9c8395d88ef29581 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -3408,6 +3408,8 @@ static void *migration_thread(void *opaque)
>>       int64_t setup_start = qemu_clock_get_ms(QEMU_CLOCK_HOST);
>>       MigThrError thr_error;
>>       bool urgent = false;
>> +    Error *local_err = NULL;
>> +    int ret;
>>   
>>       thread = migration_threads_add("live_migration", qemu_get_thread_id());
>>   
>> @@ -3451,9 +3453,17 @@ static void *migration_thread(void *opaque)
>>       }
>>   
>>       bql_lock();
>> -    qemu_savevm_state_setup(s->to_dst_file);
>> +    ret = qemu_savevm_state_setup(s->to_dst_file, &local_err);
>>       bql_unlock();
>>   
>> +    if (ret) {
>> +        migrate_set_error(s, local_err);
>> +        error_free(local_err);
>> +        migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
>> +                          MIGRATION_STATUS_FAILED);
>> +        goto out;
>> +     }
> 
> There's a small indent issue, I can fix it.

checkpatch did report anything.

> 
> The bigger problem is I _think_ this will trigger a ci failure in the
> virtio-net-failover test:
> 
> ▶ 121/464 ERROR:../tests/qtest/virtio-net-failover.c:1203:test_migrate_abort_wait_unplug: assertion failed (status == "cancelling"): ("cancelled" == "cancelling") ERROR
> 121/464 qemu:qtest+qtest-x86_64 / qtest-x86_64/virtio-net-failover    ERROR            4.77s   killed by signal 6 SIGABRT
>>>> PYTHON=/builds/peterx/qemu/build/pyvenv/bin/python3.8 G_TEST_DBUS_DAEMON=/builds/peterx/qemu/tests/dbus-vmstate-daemon.sh MALLOC_PERTURB_=161 QTEST_QEMU_IMG=./qemu-img QTEST_QEMU_STORAGE_DAEMON_BINARY=./storage-daemon/qemu-storage-daemon QTEST_QEMU_BINARY=./qemu-system-x86_64 /builds/peterx/qemu/build/tests/qtest/virtio-net-failover --tap -k
> ――――――――――――――――――――――――――――――――――――― ✀  ―――――――――――――――――――――――――――――――――――――
> stderr:
> qemu-system-x86_64: ram_save_setup failed: Input/output error
> **
> ERROR:../tests/qtest/virtio-net-failover.c:1203:test_migrate_abort_wait_unplug: assertion failed (status == "cancelling"): ("cancelled" == "cancelling")
> (test program exited with status code -6)
> ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
> 
> I am not familiar enough with the failover code, and may not have time
> today to follow this up, copy Laurent.  Cedric, if you have time, please
> have a look.  


Sure. Weird because I usually run make check on x86_64, s390x, ppc64 and
aarch64. Let me check again.


Thanks,

C.



> I'll give it a shot on Monday to find a solution, otherwise
> we may need to postpone some of the patches to 9.1.
> 
> Thanks,
> 
>> +
>>       qemu_savevm_wait_unplug(s, MIGRATION_STATUS_SETUP,
>>                                  MIGRATION_STATUS_ACTIVE);
>>   
>> @@ -3530,6 +3540,9 @@ static void *bg_migration_thread(void *opaque)
>>       MigThrError thr_error;
>>       QEMUFile *fb;
>>       bool early_fail = true;
>> +    bool setup_fail = true;
>> +    Error *local_err = NULL;
>> +    int ret;
>>   
>>       rcu_register_thread();
>>       object_ref(OBJECT(s));
>> @@ -3563,9 +3576,16 @@ static void *bg_migration_thread(void *opaque)
>>   
>>       bql_lock();
>>       qemu_savevm_state_header(s->to_dst_file);
>> -    qemu_savevm_state_setup(s->to_dst_file);
>> +    ret = qemu_savevm_state_setup(s->to_dst_file, &local_err);
>> +    if (ret) {
>> +        migrate_set_error(s, local_err);
>> +        error_free(local_err);
>> +        goto fail;
>> +    }
>>       bql_unlock();
>>   
>> +    setup_fail = false;
>> +
>>       qemu_savevm_wait_unplug(s, MIGRATION_STATUS_SETUP,
>>                                  MIGRATION_STATUS_ACTIVE);
>>   
>> @@ -3632,7 +3652,8 @@ static void *bg_migration_thread(void *opaque)
>>   
>>   fail:
>>       if (early_fail) {
>> -        migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
>> +        migrate_set_state(&s->state,
>> +                setup_fail ? MIGRATION_STATUS_SETUP : MIGRATION_STATUS_ACTIVE,
>>                   MIGRATION_STATUS_FAILED);
>>           bql_unlock();
>>       }
>> diff --git a/migration/savevm.c b/migration/savevm.c
>> index ee31ffb5e88cea723039c754c30ce2c8a0ef35f3..63fdbb5ad7d4dbfaef1d2094350bf302cc677602 100644
>> --- a/migration/savevm.c
>> +++ b/migration/savevm.c
>> @@ -1310,11 +1310,11 @@ int qemu_savevm_state_prepare(Error **errp)
>>       return 0;
>>   }
>>   
>> -void qemu_savevm_state_setup(QEMUFile *f)
>> +int qemu_savevm_state_setup(QEMUFile *f, Error **errp)
>>   {
>> +    ERRP_GUARD();
>>       MigrationState *ms = migrate_get_current();
>>       SaveStateEntry *se;
>> -    Error *local_err = NULL;
>>       int ret = 0;
>>   
>>       json_writer_int64(ms->vmdesc, "page_size", qemu_target_page_size());
>> @@ -1323,10 +1323,9 @@ void qemu_savevm_state_setup(QEMUFile *f)
>>       trace_savevm_state_setup();
>>       QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
>>           if (se->vmsd && se->vmsd->early_setup) {
>> -            ret = vmstate_save(f, se, ms->vmdesc, &local_err);
>> +            ret = vmstate_save(f, se, ms->vmdesc, errp);
>>               if (ret) {
>> -                migrate_set_error(ms, local_err);
>> -                error_report_err(local_err);
>> +                migrate_set_error(ms, *errp);
>>                   qemu_file_set_error(f, ret);
>>                   break;
>>               }
>> @@ -1346,18 +1345,19 @@ void qemu_savevm_state_setup(QEMUFile *f)
>>           ret = se->ops->save_setup(f, se->opaque);
>>           save_section_footer(f, se);
>>           if (ret < 0) {
>> +            error_setg(errp, "failed to setup SaveStateEntry with id(name): "
>> +                       "%d(%s): %d", se->section_id, se->idstr, ret);
>>               qemu_file_set_error(f, ret);
>>               break;
>>           }
>>       }
>>   
>>       if (ret) {
>> -        return;
>> +        return ret;
>>       }
>>   
>> -    if (precopy_notify(PRECOPY_NOTIFY_SETUP, &local_err)) {
>> -        error_report_err(local_err);
>> -    }
>> +    /* TODO: Should we check that errp is set in case of failure ? */
>> +    return precopy_notify(PRECOPY_NOTIFY_SETUP, errp);
>>   }
>>   
>>   int qemu_savevm_state_resume_prepare(MigrationState *s)
>> @@ -1728,7 +1728,10 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
>>       ms->to_dst_file = f;
>>   
>>       qemu_savevm_state_header(f);
>> -    qemu_savevm_state_setup(f);
>> +    ret = qemu_savevm_state_setup(f, errp);
>> +    if (ret) {
>> +        goto cleanup;
>> +    }
>>   
>>       while (qemu_file_get_error(f) == 0) {
>>           if (qemu_savevm_state_iterate(f, false) > 0) {
>> @@ -1741,10 +1744,11 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
>>           qemu_savevm_state_complete_precopy(f, false, false);
>>           ret = qemu_file_get_error(f);
>>       }
>> -    qemu_savevm_state_cleanup();
>>       if (ret != 0) {
>>           error_setg_errno(errp, -ret, "Error while writing VM state");
>>       }
>> +cleanup:
>> +    qemu_savevm_state_cleanup();
>>   
>>       if (ret != 0) {
>>           status = MIGRATION_STATUS_FAILED;
>> -- 
>> 2.44.0
>>
> 


