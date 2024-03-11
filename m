Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0465C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 18:16:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjkBr-0003Xu-4Z; Mon, 11 Mar 2024 14:15:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rjkBf-0003VQ-OX
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 14:15:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rjkBd-0006Xl-BQ
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 14:15:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710180944;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6x7+8IruUfceTskkCHbWcTN68o1VCaihkMBIQ66jSjE=;
 b=HL5fxL4Qp+AttQqvVb/fdzttzoM4hLuyUKjpzbkm5fNxvJieWXJxnP2gHnx05ADFb746ss
 FXvWK/AEHIynxK/pXSTL2Jy5xPDVQnltecvpO+/8iWjRsctTH7wEOfygZj2xU3Nsfs58O6
 0bG3JRmGRTVpdDKzGFRyzPzVl7lY1as=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-PWCpOgDzOYKOOpMiaRXWQw-1; Mon, 11 Mar 2024 14:15:43 -0400
X-MC-Unique: PWCpOgDzOYKOOpMiaRXWQw-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7886fc6fc74so104666285a.1
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 11:15:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710180943; x=1710785743;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6x7+8IruUfceTskkCHbWcTN68o1VCaihkMBIQ66jSjE=;
 b=LRlqBK5MI4sdqSS35Uz2b1nVsbkTQKA9iAF8FLbvsxPYoNQ+o+VF1y7bwT4SdjGpSp
 /tfJacsgfaB8WrJ6FKGCUhma8IPAwu0PCXdZab4Tjq6epQEozsmfoM6e0N+v+wBtWeMV
 YgmxaGT4rIiPWUcrinUCB1is9WYdKdtomtD4fxkkEfpCC7/3jRDPtK8opRRfWviEByNc
 2e438tTxq5Z03l8prj/UF0HV4mbHtOK34j/CVYDksyyIznIix3MMVXgXbL4sO3SBgqSf
 vOK0xCjZ+f8FEXaQ3lEDVtpLlZbDZZGJH82K9EpGPAWUZL8zY8U5dqf9zJCyEn7oydlr
 Z6Rg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSY/i2ej2dGFTO+5RhFAfXtCD1SAfEMdHsvZsxXnXttaKqC6fpTFbMfFUBNSGzjQLyHvVMpa/9mhjn5pUn/BXO9j+b2hk=
X-Gm-Message-State: AOJu0YxyM21UV+KbnqkqOgSORW3YhZBhMM2jcHn4e/jNcd4mTZhqvB4p
 2MCSKcK/JMOeqP3i+YoHGNuXM6amNV/62nCxO6Uq9ZxbQeQ0AMGvKoknOY9/7MKRuAGqA6H7ars
 T8EVhqgvOE+HAcgc2bpKHOrMfHy6rADbSRJHFrVzS89L0Xum7cfy9
X-Received: by 2002:ac8:5fcf:0:b0:42e:fd4d:8245 with SMTP id
 k15-20020ac85fcf000000b0042efd4d8245mr8998844qta.27.1710180942703; 
 Mon, 11 Mar 2024 11:15:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6IaN+EutbhImwzsi42MiiZp3cY7KH0qpq4B358cppja+G6HbGv3PTYbPuKyfuRAgpHwEgSQ==
X-Received: by 2002:ac8:5fcf:0:b0:42e:fd4d:8245 with SMTP id
 k15-20020ac85fcf000000b0042efd4d8245mr8998818qta.27.1710180942103; 
 Mon, 11 Mar 2024 11:15:42 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 kc2-20020a05622a44c200b0042ed9576bcesm2926273qtb.11.2024.03.11.11.15.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Mar 2024 11:15:41 -0700 (PDT)
Message-ID: <1566715b-a9a5-4df6-8e64-f4f912e2ea2f@redhat.com>
Date: Mon, 11 Mar 2024 19:15:39 +0100
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
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <87plw44wps.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
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

On 3/8/24 15:36, Fabiano Rosas wrote:
> Cédric Le Goater <clg@redhat.com> writes:
> 
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
>> +
>>       qemu_savevm_wait_unplug(s, MIGRATION_STATUS_SETUP,
>>                                  MIGRATION_STATUS_ACTIVE);
> 
> This^ should be before the new block it seems:
> 
> GOOD:
> migrate_set_state new state setup
> migrate_set_state new state wait-unplug
> migrate_fd_cancel
> migrate_set_state new state cancelling
> migrate_fd_cleanup
> migrate_set_state new state cancelled
> migrate_fd_cancel
> ok 1 /x86_64/failover-virtio-net/migrate/abort/wait-unplug
> 
> BAD:
> migrate_set_state new state setup
> migrate_fd_cancel
> migrate_set_state new state cancelling
> migrate_fd_cleanup
> migrate_set_state new state cancelled
> qemu-system-x86_64: ram_save_setup failed: Input/output error
> **
> ERROR:../tests/qtest/virtio-net-failover.c:1203:test_migrate_abort_wait_unplug:
> assertion failed (status == "cancelling"): ("cancelled" == "cancelling")
> 
> Otherwise migration_iteration_finish() will schedule the cleanup BH and
> that will run concurrently with migrate_fd_cancel() issued by the test
> and bad things happens.

This hack makes things work :

@@ -3452,6 +3452,9 @@ static void *migration_thread(void *opaq
          qemu_savevm_send_colo_enable(s->to_dst_file);
      }
  
+    qemu_savevm_wait_unplug(s, MIGRATION_STATUS_SETUP,
+                            MIGRATION_STATUS_SETUP);
+
      bql_lock();
      ret = qemu_savevm_state_setup(s->to_dst_file, &local_err);
      bql_unlock();

We should fix the test instead :) Unless waiting for failover devices
to unplug before the save_setup handlers and not after is ok.

commit c7e0acd5a3f8 ("migration: add new migration state wait-unplug")
is not clear about the justification.:

     This patch adds a new migration state called wait-unplug.  It is entered
     after the SETUP state if failover devices are present. It will transition
     into ACTIVE once all devices were succesfully unplugged from the guest.


> =====
> PS: I guess the next level in our Freestyle Concurrency video-game is to
> make migrate_fd_cancel() stop setting state and poking files and only
> set a flag that's tested in the other parts of the code.

Is that a new item on the TODO list?

Thanks,

C.


> 
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
> 


