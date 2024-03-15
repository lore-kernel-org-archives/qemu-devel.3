Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90B27C54E67
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 14:22:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl8RG-0004mW-4H; Fri, 15 Mar 2024 10:21:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rl8RE-0004mO-Ph
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 10:21:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rl8RD-00070j-1c
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 10:21:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710512494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WBai53qTNrdCK9y4hgi/dDz4OuWIbDVgIR4BCVDb2N8=;
 b=Cl0XHULKJfGsn9UP496qlrSffxfwnpqPA/7CF6u8ckAfhBDPsEk+Qfp3AxBoF6PX0uSSX7
 2E8CY/BDgx3ZvyIkHAl2H09ld4aYq/LaD+4GNzGO7rVz51aG26PT53SP6PFgLu2iiTy7wG
 mp7yBIIl1Z6XheCgIx06CBlP9jie1nU=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-syCQR9TnP2OE25LZh0IHhQ-1; Fri, 15 Mar 2024 10:21:32 -0400
X-MC-Unique: syCQR9TnP2OE25LZh0IHhQ-1
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-22233c4914dso2352646fac.3
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 07:21:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710512491; x=1711117291;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WBai53qTNrdCK9y4hgi/dDz4OuWIbDVgIR4BCVDb2N8=;
 b=q+vyBy6pRvd92M7AJ6HcvJZZgGLuQX0WeHtq6GRf8wysCophkNRSDE88acK5VLAc6C
 acvGEPkUv1mZuFK5A6FDJyaopGCJcdwOgtqH5TKFIDGzKF5q2qBnfvEv7h9WilleT2j9
 +JAGYBhmF8XW2tLCixmuCqbJFVhb//DWQ2ZpdoNl6hpDIdG+pXMLl7mRUmX2nRLRf8ow
 azloJ5gaNohVcU2v96gn/NMo4MZvfe+Un/eIQVolU/H/Kglo0wKOBQS7rUdAFxuKy7zh
 lLMQSe+7MxDaKQtgR1X18aSQaaILRHCZEyCAVe7rtzbGBl1T9AIGYx+mAZ9MmkN6rEc1
 wb9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLDlpRZnl1NpB9qVShfdceUmX2eVW2+B7TgflqRsf65bnuArbafZaJX1ztcN6GXCrvT7sCgZrKU1OfaJFKraSBbArmByU=
X-Gm-Message-State: AOJu0YwUGWc3lkYghYl5ZHsr0LoJiSrSgxw1EZlg0pXmtONqRFrj6eci
 xpTAV9pG5m1c4+uJyqCSkOPeWELqBORH+72p968iHU9nrMrHFd/bPnm7RSI9BNIoflo6I7ETAPW
 rHoWkfCRfACuoAi3gpjUO53kDs/2X7AXq+fewMkUBtJ9u/f/WaZGV
X-Received: by 2002:a05:6870:171c:b0:221:968d:4633 with SMTP id
 h28-20020a056870171c00b00221968d4633mr5358814oae.18.1710512491647; 
 Fri, 15 Mar 2024 07:21:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJbxtWONNRF5hJQhomw7gMO/Ritfo9oszmkKLI9iwljgyGbnZ4EMTWnGFPPDNXQdt1MS9xxA==
X-Received: by 2002:a05:6870:171c:b0:221:968d:4633 with SMTP id
 h28-20020a056870171c00b00221968d4633mr5358792oae.18.1710512491333; 
 Fri, 15 Mar 2024 07:21:31 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:d55d:ba01:adf2:d3ae?
 ([2a01:e0a:9e2:9000:d55d:ba01:adf2:d3ae])
 by smtp.gmail.com with ESMTPSA id
 s14-20020a0562140cae00b0069102f97e08sm2051031qvs.97.2024.03.15.07.21.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Mar 2024 07:21:30 -0700 (PDT)
Message-ID: <afcb2934-7e4f-4c49-80a6-8e67026d3bc5@redhat.com>
Date: Fri, 15 Mar 2024 15:21:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/25] migration: Add Error** argument to
 qemu_savevm_state_setup()
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>
References: <87plw44wps.fsf@suse.de>
 <1566715b-a9a5-4df6-8e64-f4f912e2ea2f@redhat.com> <87le6omw0d.fsf@suse.de>
 <9071affc-ffb5-435a-99d1-ca829703e31b@redhat.com>
 <8ba5dba7-1849-46ff-b708-a9caac66be27@redhat.com>
 <b2b52017-c4cd-43e9-a67b-2ccbb92ad99e@redhat.com> <874jdbmst4.fsf@suse.de>
 <ZfByYiL3Gl9d9u7h@x1n> <87wmq7l2xx.fsf@suse.de>
 <b9cb5c16-59a4-4cdc-9d12-6d7c2306b4ff@redhat.com> <ZfQqpK0xCwygYYho@x1n>
 <c946ae1f-3315-496e-b316-33343e43830f@redhat.com>
In-Reply-To: <c946ae1f-3315-496e-b316-33343e43830f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.933,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 3/15/24 13:20, Cédric Le Goater wrote:
> On 3/15/24 12:01, Peter Xu wrote:
>> On Fri, Mar 15, 2024 at 11:17:45AM +0100, Cédric Le Goater wrote:
>>>> migrate_set_state is also unintuitive because it ignores invalid state
>>>> transitions and we've been using that property to deal with special
>>>> states such as POSTCOPY_PAUSED and FAILED:
>>>>
>>>> - After the migration goes into POSTCOPY_PAUSED, the resumed migration's
>>>>     migrate_init() will try to set the state NONE->SETUP, which is not
>>>>     valid.
>>>>
>>>> - After save_setup fails, the migration goes into FAILED, but wait_unplug
>>>>     will try to transition SETUP->ACTIVE, which is also not valid.
>>>>
>>>
>>> I am not sure I understand what the plan is. Both solutions are problematic
>>> regarding the state transitions.
>>>
>>> Should we consider that waiting for failover devices to unplug is an internal
>>> step of the SETUP phase not transitioning to ACTIVE ?
>>
>> If to unblock this series, IIUC the simplest solution is to do what Fabiano
>> suggested, that we move qemu_savevm_wait_unplug() to be before the check of
>> setup() ret. 
> 
> The simplest is IMHO moving qemu_savevm_wait_unplug() before
> qemu_savevm_state_setup() and leave patch 10 is unchanged. See
> below the extra patch. It looks much cleaner than what we have
> today.
> 
>> In that case, the state change in qemu_savevm_wait_unplug()
>> should be benign and we should see a super small window it became ACTIVE
>> but then it should be FAILED (and IIUC the patch itself will need to use
>> ACTIVE as "old_state", not SETUP anymore).
> 
> OK. I will give it a try to compare.

Here's the alternative solution. SETUP state failures are handled after
transitioning to ACTIVE state, which is unfortunate but probably harmless.
I guess it's OK.

Thanks,

C.



Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
  migration/savevm.h    |  2 +-
  migration/migration.c | 29 +++++++++++++++++++++++++++--
  migration/savevm.c    | 26 +++++++++++++++-----------
  3 files changed, 43 insertions(+), 14 deletions(-)

diff --git a/migration/savevm.h b/migration/savevm.h
index 74669733dd63a080b765866c703234a5c4939223..9ec96a995c93a42aad621595f0ed58596c532328 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -32,7 +32,7 @@
  bool qemu_savevm_state_blocked(Error **errp);
  void qemu_savevm_non_migratable_list(strList **reasons);
  int qemu_savevm_state_prepare(Error **errp);
-void qemu_savevm_state_setup(QEMUFile *f);
+int qemu_savevm_state_setup(QEMUFile *f, Error **errp);
  bool qemu_savevm_state_guest_unplug_pending(void);
  int qemu_savevm_state_resume_prepare(MigrationState *s);
  void qemu_savevm_state_header(QEMUFile *f);
diff --git a/migration/migration.c b/migration/migration.c
index 644e073b7dcc70cb2bdaa9c975ba478952465ff4..0704ad6226df61f2f15bd81a2897f9946d601ca7 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3427,6 +3427,8 @@ static void *migration_thread(void *opaque)
      int64_t setup_start = qemu_clock_get_ms(QEMU_CLOCK_HOST);
      MigThrError thr_error;
      bool urgent = false;
+    Error *local_err = NULL;
+    int ret;
  
      thread = migration_threads_add("live_migration", qemu_get_thread_id());
  
@@ -3470,12 +3472,24 @@ static void *migration_thread(void *opaque)
      }
  
      bql_lock();
-    qemu_savevm_state_setup(s->to_dst_file);
+    ret = qemu_savevm_state_setup(s->to_dst_file, &local_err);
      bql_unlock();
  
      qemu_savevm_wait_unplug(s, MIGRATION_STATUS_SETUP,
                                 MIGRATION_STATUS_ACTIVE);
  
+    /*
+     * Handle SETUP failures after waiting for virtio-net-failover
+     * devices to unplug. This to preserve migration state transitions.
+     */
+    if (ret) {
+        migrate_set_error(s, local_err);
+        error_free(local_err);
+        migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
+                          MIGRATION_STATUS_FAILED);
+        goto out;
+    }
+
      s->setup_time = qemu_clock_get_ms(QEMU_CLOCK_HOST) - setup_start;
  
      trace_migration_thread_setup_complete();
@@ -3549,6 +3563,8 @@ static void *bg_migration_thread(void *opaque)
      MigThrError thr_error;
      QEMUFile *fb;
      bool early_fail = true;
+    Error *local_err = NULL;
+    int ret;
  
      rcu_register_thread();
      object_ref(OBJECT(s));
@@ -3582,12 +3598,20 @@ static void *bg_migration_thread(void *opaque)
  
      bql_lock();
      qemu_savevm_state_header(s->to_dst_file);
-    qemu_savevm_state_setup(s->to_dst_file);
+    ret = qemu_savevm_state_setup(s->to_dst_file, &local_err);
      bql_unlock();
  
      qemu_savevm_wait_unplug(s, MIGRATION_STATUS_SETUP,
                                 MIGRATION_STATUS_ACTIVE);
  
+    if (ret) {
+        migrate_set_error(s, local_err);
+        error_free(local_err);
+        migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
+                          MIGRATION_STATUS_FAILED);
+        goto fail_setup;
+    }
+
      s->setup_time = qemu_clock_get_ms(QEMU_CLOCK_HOST) - setup_start;
  
      trace_migration_thread_setup_complete();
@@ -3656,6 +3680,7 @@ fail:
          bql_unlock();
      }
  
+fail_setup:
      bg_migration_iteration_finish(s);
  
      qemu_fclose(fb);
diff --git a/migration/savevm.c b/migration/savevm.c
index 1a7b5cb78a912c36ae16db703afc90ef2906b61f..0eb94e61f888adba2c0732c2cb701b110814c455 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1310,11 +1310,11 @@ int qemu_savevm_state_prepare(Error **errp)
      return 0;
  }
  
-void qemu_savevm_state_setup(QEMUFile *f)
+int qemu_savevm_state_setup(QEMUFile *f, Error **errp)
  {
+    ERRP_GUARD();
      MigrationState *ms = migrate_get_current();
      SaveStateEntry *se;
-    Error *local_err = NULL;
      int ret = 0;
  
      json_writer_int64(ms->vmdesc, "page_size", qemu_target_page_size());
@@ -1323,10 +1323,9 @@ void qemu_savevm_state_setup(QEMUFile *f)
      trace_savevm_state_setup();
      QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
          if (se->vmsd && se->vmsd->early_setup) {
-            ret = vmstate_save(f, se, ms->vmdesc, &local_err);
+            ret = vmstate_save(f, se, ms->vmdesc, errp);
              if (ret) {
-                migrate_set_error(ms, local_err);
-                error_report_err(local_err);
+                migrate_set_error(ms, *errp);
                  qemu_file_set_error(f, ret);
                  break;
              }
@@ -1346,18 +1345,19 @@ void qemu_savevm_state_setup(QEMUFile *f)
          ret = se->ops->save_setup(f, se->opaque);
          save_section_footer(f, se);
          if (ret < 0) {
+            error_setg(errp, "failed to setup SaveStateEntry with id(name): "
+                       "%d(%s): %d", se->section_id, se->idstr, ret);
              qemu_file_set_error(f, ret);
              break;
          }
      }
  
      if (ret) {
-        return;
+        return ret;
      }
  
-    if (precopy_notify(PRECOPY_NOTIFY_SETUP, &local_err)) {
-        error_report_err(local_err);
-    }
+    /* TODO: Should we check that errp is set in case of failure ? */
+    return precopy_notify(PRECOPY_NOTIFY_SETUP, errp);
  }
  
  int qemu_savevm_state_resume_prepare(MigrationState *s)
@@ -1725,7 +1725,10 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
      ms->to_dst_file = f;
  
      qemu_savevm_state_header(f);
-    qemu_savevm_state_setup(f);
+    ret = qemu_savevm_state_setup(f, errp);
+    if (ret) {
+        goto cleanup;
+    }
  
      while (qemu_file_get_error(f) == 0) {
          if (qemu_savevm_state_iterate(f, false) > 0) {
@@ -1738,10 +1741,11 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
          qemu_savevm_state_complete_precopy(f, false, false);
          ret = qemu_file_get_error(f);
      }
-    qemu_savevm_state_cleanup();
      if (ret != 0) {
          error_setg_errno(errp, -ret, "Error while writing VM state");
      }
+cleanup:
+    qemu_savevm_state_cleanup();
  
      if (ret != 0) {
          status = MIGRATION_STATUS_FAILED;
-- 
2.44.0



