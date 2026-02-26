Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86A7AFD8FCE
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 15:49:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvdcM-0003zX-Bj; Thu, 26 Feb 2026 10:49:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vvdcF-0003yv-SV
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 10:49:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vvdcD-0001Zy-SQ
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 10:49:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772120963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ltNQFNFDhmIpnzgwQc89kpsX+dmi1OvqchNER0cfibc=;
 b=fG3jpoysSOOjuz0WFj9RcBjTMC51sgsO40/dQ6rEPw4q7xF6jF2fhytBmqo7+TMa/FdPk4
 2WLFUfAZ1XXf1RHG+shu390i8UNOQ/RhAdWh1bT0nDdL7lMotxbSEM5kNBof7CY7jBbOpp
 6q7ypp9qy9wioMVX4r+bH/jqvqvn7Ks=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-7zcF3nwgOuKpt2_4zeyf0A-1; Thu, 26 Feb 2026 10:49:21 -0500
X-MC-Unique: 7zcF3nwgOuKpt2_4zeyf0A-1
X-Mimecast-MFC-AGG-ID: 7zcF3nwgOuKpt2_4zeyf0A_1772120961
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-89718626897so104421866d6.1
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 07:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772120961; x=1772725761; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ltNQFNFDhmIpnzgwQc89kpsX+dmi1OvqchNER0cfibc=;
 b=JORJGt6IgjR2FkUO4QcAVyyurrK+Ct51w9N94Z04M6NoKPQKJRuQxmGw5nD8c+/uR0
 B4XE000WobZ7qWC0kyo3rJexd9QbVzVaR64zvfU2DFuo8fzQO9w6YPQ1qnygGg0+hjJU
 Okr/s90T5xJC06fqVH3gs4KyWnluDInidZWeKS8wReyetxB5eNRIuATOwsm5OsUlCQdN
 KV5ubPZkwZ2aic1fIF7vQZzjcMrFP7Dl1MJ1d44cBmK+GPsLMdo8GwGNR8LtAD5/7YjH
 rPMDNc6hPeuc0wiYbbaWZxdRGYfvYNlCVLyVmAOPKXW90zgvKt7i6XYfgmdNEth1gD+L
 7oxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772120961; x=1772725761;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ltNQFNFDhmIpnzgwQc89kpsX+dmi1OvqchNER0cfibc=;
 b=dy4SqVN5lGooGCbZyO3itmSLnj5I3ZXcCx7WwDSyDmyMDBsN4sSxBS9fdX50DxlX+A
 iXKPrHk7ahSIV8QZxfxMmrUlYh3URe0eUbJm8x1d5vXueKy3P/xSA7QJtgwSJ3RkKsU2
 RwGzcp7UH1Pz9+sWhq5VJJoey8NtQF4c8uFyOaELG+Q2BL/E8U9J2fTIPyJ1hut4y5rv
 +vYMcPFxmOpNF6Ll82U4sBAbpwLqX/Hz9Xe/UBf54mC/MTrR/dsAlNII6OYJrzzTUl6Z
 b3N1BTtaL0KJ35qrJezdO9fQCF7XTmBE9M7OtuuPt+EM6yjn8D0N7aYWuZ3fHPlezMFb
 2GGA==
X-Gm-Message-State: AOJu0Yy0P+rJ9svAmZptbe1wekCEt5iGc33GQWKNofBGtavL31XLV0NB
 z6IKW0KBGxuqujnLmcdPBKoV9VqNzZfvI+wox5PWCdDlD/qscd5VLZwc2wLpKNTW+bwtnXdM4Fd
 w18FAroclakMqu2qxY5sdhuY3TsrjiLPVvrvCaA03ZvkW7FrB9UMp8S0rIrs22x43
X-Gm-Gg: ATEYQzyOvb2u0BwzuXPbf4epV25/PSB1plR4LKqItUkUQqm5Zd/yFPH1FPmowLiSyiq
 TajDl+CBSsvLkqMZhA6/qvYb8Y2lkwy6dv50DCpGODi/G2ZunQTt6bVBRzzVdV3+jS2YxzJjrHT
 v3QsLNRyj4TAm8NDhAARCNGxSBw6ooqzvn/Uo8aMMq65RmNst9rusqPC+MtS62o2DQHYAh4t8qD
 9Al1OH5u9oPO1dOvAGegOwaaOA2WXUk61ke3umXVPe5dDOALqUVLXAq2iiJ1KWGYGMzXS7wqwO+
 o1tXCrC7QiGoZPqgGNlhIFjZS1H1M075IbCepuydjTyRgfFT4xC2roXtwHYJZ+EkfIV1UBpShO3
 od/7xTd2pCObsmg==
X-Received: by 2002:a05:6214:27cc:b0:899:bee4:745f with SMTP id
 6a1803df08f44-899c15108e3mr65487096d6.26.1772120960581; 
 Thu, 26 Feb 2026 07:49:20 -0800 (PST)
X-Received: by 2002:a05:6214:27cc:b0:899:bee4:745f with SMTP id
 6a1803df08f44-899c15108e3mr65486576d6.26.1772120959998; 
 Thu, 26 Feb 2026 07:49:19 -0800 (PST)
Received: from x1.local ([174.91.117.149]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf6f9261sm231582485a.26.2026.02.26.07.49.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 07:49:19 -0800 (PST)
Date: Thu, 26 Feb 2026 10:49:07 -0500
From: Peter Xu <peterx@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhang Chen <zhangckid@gmail.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH v10 19/19] migration: Always open
 s->rp_state.from_dst_file on the source
Message-ID: <aaBrc4bMxUHhgpH8@x1.local>
References: <20260220-colo_unit_test_multifd-v10-0-bfe67d422ef1@web.de>
 <20260220-colo_unit_test_multifd-v10-19-bfe67d422ef1@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260220-colo_unit_test_multifd-v10-19-bfe67d422ef1@web.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.306, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.668,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Feb 20, 2026 at 08:51:41PM +0100, Lukas Straub wrote:
> qemu_file_get_return_path() can not fail (See also commit 3f9d6e77b)
> so always open the return path socket on the source. This allows
> us to reuse the return path in other parts like colo. Also take
> the proper locks in colo while we're at it.
> 
> This fixes a crash due to a race between migrate_cancel() and
> the colo thread shutting down.
> 
> Before, the rp socket is opened just before the rp thread is started
> and closed after it terminates and postcopy fast path is closed.
> Now it's the same, only the rp socket stays open until migration_cleanup().
> 
> If there is a rp thread, the rp socket is shut down at the end of migration,
> but the file is still open. COLO is not compatible with postcopy, so this is
> safe as no one else uses the rp socket after this point.
> 
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> ---
>  migration/colo.c      | 29 ++++++-------------
>  migration/migration.c | 77 ++++++++++++++++++++++++---------------------------
>  2 files changed, 44 insertions(+), 62 deletions(-)
> 
> diff --git a/migration/colo.c b/migration/colo.c
> index ce02c71d8857d470be434bdf3a9cacad3baab0d5..0dee33f1145b81af276cf318e2984deae9ae0527 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -173,11 +173,13 @@ static void primary_vm_do_failover(void)
>       * The s->rp_state.from_dst_file and s->to_dst_file may use the
>       * same fd, but we still shutdown the fd for twice, it is harmless.
>       */
> -    if (s->to_dst_file) {
> -        qemu_file_shutdown(s->to_dst_file);
> -    }
> -    if (s->rp_state.from_dst_file) {
> -        qemu_file_shutdown(s->rp_state.from_dst_file);
> +    WITH_QEMU_LOCK_GUARD(&s->qemu_file_lock) {
> +        if (s->to_dst_file) {
> +            qemu_file_shutdown(s->to_dst_file);
> +        }
> +        if (s->rp_state.from_dst_file) {
> +            qemu_file_shutdown(s->rp_state.from_dst_file);
> +        }

Nit: these "start to take mutex for..." changes should belong to a separate
patch.

>      }
>  
>      old_state = failover_set_state(FAILOVER_STATUS_ACTIVE,
> @@ -537,6 +539,7 @@ static void colo_process_checkpoint(MigrationState *s)
>      Error *local_err = NULL;
>      int ret;
>  
> +    assert(s->rp_state.from_dst_file);
>      if (get_colo_mode() != COLO_MODE_PRIMARY) {
>          error_report("COLO mode must be COLO_MODE_PRIMARY");
>          return;
> @@ -544,12 +547,6 @@ static void colo_process_checkpoint(MigrationState *s)
>  
>      failover_init_state();
>  
> -    s->rp_state.from_dst_file = qemu_file_get_return_path(s->to_dst_file);
> -    if (!s->rp_state.from_dst_file) {
> -        error_report("Open QEMUFile from_dst_file failed");
> -        goto out;
> -    }
> -
>      packets_compare_notifier.notify = colo_compare_notify_checkpoint;
>      colo_compare_register_notifier(&packets_compare_notifier);
>  
> @@ -634,16 +631,6 @@ out:
>      colo_compare_unregister_notifier(&packets_compare_notifier);
>      timer_free(s->colo_delay_timer);
>      qemu_event_destroy(&s->colo_checkpoint_event);
> -
> -    /*
> -     * Must be called after failover BH is completed,
> -     * Or the failover BH may shutdown the wrong fd that
> -     * re-used by other threads after we release here.
> -     */
> -    if (s->rp_state.from_dst_file) {
> -        qemu_fclose(s->rp_state.from_dst_file);
> -        s->rp_state.from_dst_file = NULL;
> -    }
>  }
>  
>  void migrate_start_colo_process(MigrationState *s)
> diff --git a/migration/migration.c b/migration/migration.c
> index f36d42ef657bdf26d78ca642d77a9b76e1c0c174..8caa56940beef12de33a799695cf486c8fbd471c 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -97,7 +97,7 @@ static GSList *migration_blockers[MIG_MODE__MAX];
>  
>  static bool migration_object_check(MigrationState *ms, Error **errp);
>  static bool migration_switchover_start(MigrationState *s, Error **errp);
> -static bool close_return_path_on_source(MigrationState *s);
> +static bool stop_return_path_thread_on_source(MigrationState *s);
>  static void migration_completion_end(MigrationState *s);
>  
>  static void migration_downtime_start(MigrationState *s)
> @@ -1278,7 +1278,7 @@ static void migration_cleanup(MigrationState *s)
>      cpr_state_close();
>      cpr_transfer_source_destroy(s);
>  
> -    close_return_path_on_source(s);
> +    stop_return_path_thread_on_source(s);
>  
>      if (s->migration_thread_running) {
>          bql_unlock();
> @@ -1307,6 +1307,14 @@ static void migration_cleanup(MigrationState *s)
>          qemu_fclose(tmp);
>      }
>  
> +    WITH_QEMU_LOCK_GUARD(&s->qemu_file_lock) {
> +        tmp = s->rp_state.from_dst_file;
> +        s->rp_state.from_dst_file = NULL;
> +    }
> +    if (tmp) {
> +        qemu_fclose(tmp);
> +    }
> +
>      assert(!migration_is_active());
>  
>      if (s->state == MIGRATION_STATUS_CANCELLING) {
> @@ -2187,38 +2195,6 @@ static bool migrate_handle_rp_resume_ack(MigrationState *s,
>      return true;
>  }
>  
> -/*
> - * Release ms->rp_state.from_dst_file (and postcopy_qemufile_src if
> - * existed) in a safe way.
> - */
> -static void migration_release_dst_files(MigrationState *ms)
> -{
> -    QEMUFile *file = NULL;
> -
> -    WITH_QEMU_LOCK_GUARD(&ms->qemu_file_lock) {
> -        /*
> -         * Reset the from_dst_file pointer first before releasing it, as we
> -         * can't block within lock section
> -         */
> -        file = ms->rp_state.from_dst_file;
> -        ms->rp_state.from_dst_file = NULL;
> -    }
> -
> -    /*
> -     * Do the same to postcopy fast path socket too if there is.  No
> -     * locking needed because this qemufile should only be managed by
> -     * return path thread.
> -     */
> -    if (ms->postcopy_qemufile_src) {
> -        migration_ioc_unregister_yank_from_file(ms->postcopy_qemufile_src);
> -        qemu_file_shutdown(ms->postcopy_qemufile_src);
> -        qemu_fclose(ms->postcopy_qemufile_src);
> -        ms->postcopy_qemufile_src = NULL;
> -    }
> -
> -    qemu_fclose(file);
> -}
> -
>  /*
>   * Handles messages sent on the return path towards the source VM
>   *
> @@ -2388,9 +2364,9 @@ out:
>      return NULL;
>  }
>  
> -static void open_return_path_on_source(MigrationState *ms)
> +static void start_return_path_thread_on_source(MigrationState *ms)

Changing this seems OK, but I'm totally confused why you deleted
migration_release_dst_files().  That's the helper to properly close the two
possible qemufiles that rp thread uses.  IIUC you can keep it then use it
in either postcopy_pause() or migration_cleanup() directly.

Then you need to remove the chunk [1] below, making the function only do
"stop" but not close.

>  {
> -    ms->rp_state.from_dst_file = qemu_file_get_return_path(ms->to_dst_file);
> +    assert(ms->rp_state.from_dst_file);

I don't see why this change is a must, to open from_dst_file earlier.  Can
we keep it as before, or would you justify it in a separate patch?

>  
>      trace_open_return_path_on_source();
>  
> @@ -2402,7 +2378,7 @@ static void open_return_path_on_source(MigrationState *ms)
>  }
>  
>  /* Return true if error detected, or false otherwise */
> -static bool close_return_path_on_source(MigrationState *ms)
> +static bool stop_return_path_thread_on_source(MigrationState *ms)
>  {
>      if (!ms->rp_state.rp_thread_created) {
>          return false;
> @@ -2424,7 +2400,17 @@ static bool close_return_path_on_source(MigrationState *ms)
>  
>      qemu_thread_join(&ms->rp_state.rp_thread);
>      ms->rp_state.rp_thread_created = false;
> -    migration_release_dst_files(ms);
> +    /*
> +     * Close the postcopy fast path socket if there is one.
> +     * No locking needed because this qemufile should only be managed by
> +     * return path thread which we just stopped.
> +     */
> +    if (ms->postcopy_qemufile_src) {
> +        migration_ioc_unregister_yank_from_file(ms->postcopy_qemufile_src);
> +        qemu_file_shutdown(ms->postcopy_qemufile_src);
> +        qemu_fclose(ms->postcopy_qemufile_src);
> +        ms->postcopy_qemufile_src = NULL;
> +    }

[1]

>      trace_migration_return_path_end_after();
>  
>      /* Return path will persist the error in MigrationState when quit */
> @@ -2787,7 +2773,7 @@ static void migration_completion(MigrationState *s)
>          goto fail;
>      }
>  
> -    if (close_return_path_on_source(s)) {
> +    if (stop_return_path_thread_on_source(s)) {
>          goto fail;
>      }
>  
> @@ -2941,7 +2927,15 @@ static MigThrError postcopy_pause(MigrationState *s)
>           * path and just wait for the thread to finish. It will be
>           * re-created when we resume.
>           */
> -        close_return_path_on_source(s);
> +        stop_return_path_thread_on_source(s);
> +        QEMUFile *rp_file;
> +        WITH_QEMU_LOCK_GUARD(&s->qemu_file_lock) {
> +            rp_file = s->rp_state.from_dst_file;
> +            s->rp_state.from_dst_file = NULL;
> +        }
> +        if (rp_file) {
> +            qemu_fclose(rp_file);
> +        }

Open-code this is going backwards.  Please see if we can reuse
migration_release_dst_files() at least.

Thanks,

>  
>          /*
>           * Current channel is possibly broken. Release it.  Note that this is
> @@ -3758,6 +3752,7 @@ void migration_start_outgoing(MigrationState *s)
>      if (!qemu_file_set_blocking(s->to_dst_file, true, &local_err)) {
>          goto fail;
>      }
> +    s->rp_state.from_dst_file = qemu_file_get_return_path(s->to_dst_file);
>  
>      /*
>       * Open the return path. For postcopy, it is used exclusively. For
> @@ -3765,7 +3760,7 @@ void migration_start_outgoing(MigrationState *s)
>       * QEMU uses the return path.
>       */
>      if (migrate_postcopy_ram() || migrate_return_path()) {
> -        open_return_path_on_source(s);
> +        start_return_path_thread_on_source(s);
>      }
>  
>      /*
> 
> -- 
> 2.39.5
> 

-- 
Peter Xu


