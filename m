Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B901C54E67
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 14:53:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl8vc-0004Ce-4h; Fri, 15 Mar 2024 10:53:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rl8va-0004CC-8b
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 10:52:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rl8vY-0004rJ-7g
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 10:52:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710514374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A5+gGxFX8X/xix/hW5SfeH8NfnkZdkXNhhVLiDtHGSE=;
 b=JDxHmVdCdnLFFbMJ7t9SwAKNxpsy+h1pQoD30xa9/2o/cyO3Dnwf6b5KE3KhcyP0y9rrLN
 z5qM0XAxl+UCQqNVLTLbRiQ6cg/2BT8Com02Aw+Uesh5E71//kzknygZq/38X9kHHDVA7t
 pg5mflUxtPlcQuFiyrAOMoaZ+OxgWMs=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-K-8z_6f4Npm4nyljJAfn3w-1; Fri, 15 Mar 2024 10:52:53 -0400
X-MC-Unique: K-8z_6f4Npm4nyljJAfn3w-1
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-221d6a92312so664726fac.1
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 07:52:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710514373; x=1711119173;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=A5+gGxFX8X/xix/hW5SfeH8NfnkZdkXNhhVLiDtHGSE=;
 b=q9KtfJ4dQTWV2h1x3MHiAfDgC2RQ01pWOn7kmYLkRHfNYZanVteHdfiioh9X9kRjUK
 JOXX0bUjmVqqProjhubhunQOLVOq5LjM/Zq6EU8HZpgyb+V2xdiNVMRadHxb51H0iRYg
 yxRcSp11g4RA+2g1+3yUWpK5reUCY2/OI36XTC92/MuWcT50Eox0aczQGuQDe5PgfFWE
 GhDvGcaBBNqGto8wMEKvBwEA9c9TyhT0CDeoCQcuEsiLfspW5qJXQsm6aFC51djp4Wyi
 njL6U8ZLhLlAjXtofrHHC+5XnlIKucGaCdeYOjMlKtz2vZPoOKxbPih2EZd85bZbYoDY
 KCig==
X-Forwarded-Encrypted: i=1;
 AJvYcCWY6/7fOjJJs/cz4fODinjQY8vKQSdt6O99HGlWn5VhyfTW8UhQze2LMxNhyJyqBQvmFKIEyugeJ4H8+Kxoc/fQqYIfhao=
X-Gm-Message-State: AOJu0YxMKl6juvOgB0IaNliiGx6DXx0KoCpHGItOnTiUdi5W5jyyz+Y/
 Cc3yPvdHJcUjVQ2/u8/8L7Q6NLad4GhBapXs0y+hQvP0isNWYsu1bjCJuUAw1dN5Z+YJYwAFMaz
 Rwd3zhaMnD2eUo6knDjJ041gQF5LtgqZ8I+ETwTtAVPeYswFACVe3
X-Received: by 2002:a05:6870:9209:b0:222:4480:6577 with SMTP id
 e9-20020a056870920900b0022244806577mr5307255oaf.0.1710514372600; 
 Fri, 15 Mar 2024 07:52:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMEh6Ecg/8HNnB0kpEF8eIzEBvTcgRelB1198qxhhvBTNvl+YH1/C7r3HgApeQiipdVexAkA==
X-Received: by 2002:a05:6870:9209:b0:222:4480:6577 with SMTP id
 e9-20020a056870920900b0022244806577mr5307219oaf.0.1710514372175; 
 Fri, 15 Mar 2024 07:52:52 -0700 (PDT)
Received: from x1n ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 wj18-20020a05620a575200b00789e7ddf8a5sm431978qkn.17.2024.03.15.07.52.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Mar 2024 07:52:51 -0700 (PDT)
Date: Fri, 15 Mar 2024 10:52:48 -0400
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v4 10/25] migration: Add Error** argument to
 qemu_savevm_state_setup()
Message-ID: <ZfRgwKtRwMo-KQqe@x1n>
References: <9071affc-ffb5-435a-99d1-ca829703e31b@redhat.com>
 <8ba5dba7-1849-46ff-b708-a9caac66be27@redhat.com>
 <b2b52017-c4cd-43e9-a67b-2ccbb92ad99e@redhat.com>
 <874jdbmst4.fsf@suse.de> <ZfByYiL3Gl9d9u7h@x1n>
 <87wmq7l2xx.fsf@suse.de>
 <b9cb5c16-59a4-4cdc-9d12-6d7c2306b4ff@redhat.com>
 <ZfQqpK0xCwygYYho@x1n>
 <c946ae1f-3315-496e-b316-33343e43830f@redhat.com>
 <afcb2934-7e4f-4c49-80a6-8e67026d3bc5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <afcb2934-7e4f-4c49-80a6-8e67026d3bc5@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Fri, Mar 15, 2024 at 03:21:27PM +0100, Cédric Le Goater wrote:
> On 3/15/24 13:20, Cédric Le Goater wrote:
> > On 3/15/24 12:01, Peter Xu wrote:
> > > On Fri, Mar 15, 2024 at 11:17:45AM +0100, Cédric Le Goater wrote:
> > > > > migrate_set_state is also unintuitive because it ignores invalid state
> > > > > transitions and we've been using that property to deal with special
> > > > > states such as POSTCOPY_PAUSED and FAILED:
> > > > > 
> > > > > - After the migration goes into POSTCOPY_PAUSED, the resumed migration's
> > > > >     migrate_init() will try to set the state NONE->SETUP, which is not
> > > > >     valid.
> > > > > 
> > > > > - After save_setup fails, the migration goes into FAILED, but wait_unplug
> > > > >     will try to transition SETUP->ACTIVE, which is also not valid.
> > > > > 
> > > > 
> > > > I am not sure I understand what the plan is. Both solutions are problematic
> > > > regarding the state transitions.
> > > > 
> > > > Should we consider that waiting for failover devices to unplug is an internal
> > > > step of the SETUP phase not transitioning to ACTIVE ?
> > > 
> > > If to unblock this series, IIUC the simplest solution is to do what Fabiano
> > > suggested, that we move qemu_savevm_wait_unplug() to be before the check of
> > > setup() ret.
> > 
> > The simplest is IMHO moving qemu_savevm_wait_unplug() before
> > qemu_savevm_state_setup() and leave patch 10 is unchanged. See
> > below the extra patch. It looks much cleaner than what we have
> > today.
> > 
> > > In that case, the state change in qemu_savevm_wait_unplug()
> > > should be benign and we should see a super small window it became ACTIVE
> > > but then it should be FAILED (and IIUC the patch itself will need to use
> > > ACTIVE as "old_state", not SETUP anymore).
> > 
> > OK. I will give it a try to compare.
> 
> Here's the alternative solution. SETUP state failures are handled after
> transitioning to ACTIVE state, which is unfortunate but probably harmless.
> I guess it's OK.

This also looks good to me, thanks.

One trivial early comment is in this case we can introduce a helper to
cover both setup() calls and UNPLUG waits and dedup the two paths.

> 
> Thanks,
> 
> C.
> 
> 
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>  migration/savevm.h    |  2 +-
>  migration/migration.c | 29 +++++++++++++++++++++++++++--
>  migration/savevm.c    | 26 +++++++++++++++-----------
>  3 files changed, 43 insertions(+), 14 deletions(-)
> 
> diff --git a/migration/savevm.h b/migration/savevm.h
> index 74669733dd63a080b765866c703234a5c4939223..9ec96a995c93a42aad621595f0ed58596c532328 100644
> --- a/migration/savevm.h
> +++ b/migration/savevm.h
> @@ -32,7 +32,7 @@
>  bool qemu_savevm_state_blocked(Error **errp);
>  void qemu_savevm_non_migratable_list(strList **reasons);
>  int qemu_savevm_state_prepare(Error **errp);
> -void qemu_savevm_state_setup(QEMUFile *f);
> +int qemu_savevm_state_setup(QEMUFile *f, Error **errp);
>  bool qemu_savevm_state_guest_unplug_pending(void);
>  int qemu_savevm_state_resume_prepare(MigrationState *s);
>  void qemu_savevm_state_header(QEMUFile *f);
> diff --git a/migration/migration.c b/migration/migration.c
> index 644e073b7dcc70cb2bdaa9c975ba478952465ff4..0704ad6226df61f2f15bd81a2897f9946d601ca7 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -3427,6 +3427,8 @@ static void *migration_thread(void *opaque)
>      int64_t setup_start = qemu_clock_get_ms(QEMU_CLOCK_HOST);
>      MigThrError thr_error;
>      bool urgent = false;
> +    Error *local_err = NULL;
> +    int ret;
>      thread = migration_threads_add("live_migration", qemu_get_thread_id());
> @@ -3470,12 +3472,24 @@ static void *migration_thread(void *opaque)
>      }
>      bql_lock();
> -    qemu_savevm_state_setup(s->to_dst_file);
> +    ret = qemu_savevm_state_setup(s->to_dst_file, &local_err);
>      bql_unlock();
>      qemu_savevm_wait_unplug(s, MIGRATION_STATUS_SETUP,
>                                 MIGRATION_STATUS_ACTIVE);
> +    /*
> +     * Handle SETUP failures after waiting for virtio-net-failover
> +     * devices to unplug. This to preserve migration state transitions.
> +     */
> +    if (ret) {
> +        migrate_set_error(s, local_err);
> +        error_free(local_err);
> +        migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
> +                          MIGRATION_STATUS_FAILED);
> +        goto out;
> +    }
> +
>      s->setup_time = qemu_clock_get_ms(QEMU_CLOCK_HOST) - setup_start;
>      trace_migration_thread_setup_complete();
> @@ -3549,6 +3563,8 @@ static void *bg_migration_thread(void *opaque)
>      MigThrError thr_error;
>      QEMUFile *fb;
>      bool early_fail = true;
> +    Error *local_err = NULL;
> +    int ret;
>      rcu_register_thread();
>      object_ref(OBJECT(s));
> @@ -3582,12 +3598,20 @@ static void *bg_migration_thread(void *opaque)
>      bql_lock();
>      qemu_savevm_state_header(s->to_dst_file);
> -    qemu_savevm_state_setup(s->to_dst_file);
> +    ret = qemu_savevm_state_setup(s->to_dst_file, &local_err);
>      bql_unlock();
>      qemu_savevm_wait_unplug(s, MIGRATION_STATUS_SETUP,
>                                 MIGRATION_STATUS_ACTIVE);
> +    if (ret) {
> +        migrate_set_error(s, local_err);
> +        error_free(local_err);
> +        migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
> +                          MIGRATION_STATUS_FAILED);
> +        goto fail_setup;
> +    }
> +
>      s->setup_time = qemu_clock_get_ms(QEMU_CLOCK_HOST) - setup_start;
>      trace_migration_thread_setup_complete();
> @@ -3656,6 +3680,7 @@ fail:
>          bql_unlock();
>      }
> +fail_setup:
>      bg_migration_iteration_finish(s);
>      qemu_fclose(fb);
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 1a7b5cb78a912c36ae16db703afc90ef2906b61f..0eb94e61f888adba2c0732c2cb701b110814c455 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1310,11 +1310,11 @@ int qemu_savevm_state_prepare(Error **errp)
>      return 0;
>  }
> -void qemu_savevm_state_setup(QEMUFile *f)
> +int qemu_savevm_state_setup(QEMUFile *f, Error **errp)
>  {
> +    ERRP_GUARD();
>      MigrationState *ms = migrate_get_current();
>      SaveStateEntry *se;
> -    Error *local_err = NULL;
>      int ret = 0;
>      json_writer_int64(ms->vmdesc, "page_size", qemu_target_page_size());
> @@ -1323,10 +1323,9 @@ void qemu_savevm_state_setup(QEMUFile *f)
>      trace_savevm_state_setup();
>      QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
>          if (se->vmsd && se->vmsd->early_setup) {
> -            ret = vmstate_save(f, se, ms->vmdesc, &local_err);
> +            ret = vmstate_save(f, se, ms->vmdesc, errp);
>              if (ret) {
> -                migrate_set_error(ms, local_err);
> -                error_report_err(local_err);
> +                migrate_set_error(ms, *errp);
>                  qemu_file_set_error(f, ret);
>                  break;
>              }
> @@ -1346,18 +1345,19 @@ void qemu_savevm_state_setup(QEMUFile *f)
>          ret = se->ops->save_setup(f, se->opaque);
>          save_section_footer(f, se);
>          if (ret < 0) {
> +            error_setg(errp, "failed to setup SaveStateEntry with id(name): "
> +                       "%d(%s): %d", se->section_id, se->idstr, ret);
>              qemu_file_set_error(f, ret);
>              break;
>          }
>      }
>      if (ret) {
> -        return;
> +        return ret;
>      }
> -    if (precopy_notify(PRECOPY_NOTIFY_SETUP, &local_err)) {
> -        error_report_err(local_err);
> -    }
> +    /* TODO: Should we check that errp is set in case of failure ? */
> +    return precopy_notify(PRECOPY_NOTIFY_SETUP, errp);
>  }
>  int qemu_savevm_state_resume_prepare(MigrationState *s)
> @@ -1725,7 +1725,10 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
>      ms->to_dst_file = f;
>      qemu_savevm_state_header(f);
> -    qemu_savevm_state_setup(f);
> +    ret = qemu_savevm_state_setup(f, errp);
> +    if (ret) {
> +        goto cleanup;
> +    }
>      while (qemu_file_get_error(f) == 0) {
>          if (qemu_savevm_state_iterate(f, false) > 0) {
> @@ -1738,10 +1741,11 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
>          qemu_savevm_state_complete_precopy(f, false, false);
>          ret = qemu_file_get_error(f);
>      }
> -    qemu_savevm_state_cleanup();
>      if (ret != 0) {
>          error_setg_errno(errp, -ret, "Error while writing VM state");
>      }
> +cleanup:
> +    qemu_savevm_state_cleanup();
>      if (ret != 0) {
>          status = MIGRATION_STATUS_FAILED;
> -- 
> 2.44.0
> 
> 

-- 
Peter Xu


