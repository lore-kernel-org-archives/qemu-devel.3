Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20935CD98F2
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 18:51:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbjjO-00061D-Il; Mon, 22 Jun 2026 14:50:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wbjjL-00060m-4o
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 14:50:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wbjjI-0007pG-Hf
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 14:50:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782154242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s+LaBdTsURaIYiXIdAOKLrt+EyUciil4KEPlEHePaA8=;
 b=WyrcqKZLewQ5+aXkMwrVrhAZQb1/KKe6YkwLQFQ4Frn264OhMruO/rAiqsVu5kI5dlm2sq
 5OiR78T/Z5FackGSleb5oXFQivO0UCthZhP3O30q7/5OxR252DrZsaalAUJ5ijG8yUNt0l
 OE7q4VIKA318RK2h4lUk/czErv30Kgo=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-WcQhUS4iOX2pjuifFhriag-1; Mon, 22 Jun 2026 14:50:40 -0400
X-MC-Unique: WcQhUS4iOX2pjuifFhriag-1
X-Mimecast-MFC-AGG-ID: WcQhUS4iOX2pjuifFhriag_1782154239
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8db90457124so5635126d6.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 11:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782154239; x=1782759039; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=s+LaBdTsURaIYiXIdAOKLrt+EyUciil4KEPlEHePaA8=;
 b=T0qxJzDegRZP+2JwM5Iba14ePdFX8luwxmOQJvEr4li9CSetfojXFC2HQOqNhZD8FG
 T1dp46OtOmURfsPNbi0duerSI8krFSlDAIrB7Syckg08Pua+vY22NTTX82Fu3k1gNiNu
 c40+Spy09S6935iCFBA2CYQ/7M0O+Fk0ir1QOXx5RJ9nO76OwbR1B2ZEmiQKyh/+v1Ei
 wd02IEGXGEnA8oCC9AmSE06nkAwR9acwZ4+h7DuZZ8dqja8C4mJHERfMI8R5lQ2nR2KT
 v8mfFkN5edsLypsPG1dpjwvNz2dO2QqvVi6P1cJtZjq9VVmqfxawElSYyMNyKa6h9IWB
 BHqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782154239; x=1782759039;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s+LaBdTsURaIYiXIdAOKLrt+EyUciil4KEPlEHePaA8=;
 b=Mq13ZrMqAyZzBBv8VTfKPD+L5usph8loMB8a43o4HnvBA0ihlq4a/iQgEdWtcz3r+f
 XhLMpPs2yKBq4PhQF3ZsJSN0mGwvbcVsa52/sjb0Sn5e42Gfbpuv4WLmq91beSzofI77
 09HnDiMKPsJVES4sUshG4C5OduQzicYXtJac6EAtAskMH7rh5Scar0qkvPP0kOwgLxLw
 IaH6O6/mUTXAgJk7jjgF7AIPvHi44sKJsF4IGdNF8pnWmqxOcJX/9sCDn10B1/bNicTJ
 nNv41gKkmRGn9Kw5hqQOwIpUq4D0XFUmRd3cCIZ3wq8qnJGNlwGvO6wloUbXeQiELVLI
 45mQ==
X-Gm-Message-State: AOJu0Yw26E3fR+/GIPIsl9mJh2JbGd0R63S0qT4amcHO6wnIdPXqL+34
 XtIvL8Csl7XyzeM6/p7pTLXFexQUqL8G4DgmIsL2hJwAipJmTfeb6wjzZOTltc0KjgsK0RQxXyl
 /ubopGz+ptyL8nYzLhIFVnDbmJTwUV9QxMwKAaiAjYvON4jJ74fEm54Db
X-Gm-Gg: AfdE7ckbXOjOlL1y5gCLvENovhQzu+4MMNkfcArWKyokcWp+nLA6E7Nlt8nxhYhUIXX
 DtTs5AlTi+Hyz+2FvZj7jdsOZVGqsv7Pn98QSKlrB9nDU+Iu5sh0UOXbXwI8HGKc06o66nvqLSK
 EPPBLhnppR5fwEkpTzS3pyEcZRBXYd2Ke2Xhu2A88mdNVjt2IRiBQeA0NoMNbiWf/JCCJ177yk0
 aqo+bP95gzn9ye1p2Vt1AsYb51Kq2wo7fgawTZysvhaUy7zzRlXtNN0U4T5gzdpNcI/lgvy1Tnz
 SbZBkXXtmCyOo4E2GLPA1mwTrxdVaMv9EtOtr/kLjCCBOxT4nbgaV3dxUQZyUHPq+Wgo9F0Zhxf
 bXAh3
X-Received: by 2002:a05:6214:262d:b0:8b0:33a2:2520 with SMTP id
 6a1803df08f44-8e3b645af0fmr10861296d6.10.1782154239393; 
 Mon, 22 Jun 2026 11:50:39 -0700 (PDT)
X-Received: by 2002:a05:6214:262d:b0:8b0:33a2:2520 with SMTP id
 6a1803df08f44-8e3b645af0fmr10860646d6.10.1782154238653; 
 Mon, 22 Jun 2026 11:50:38 -0700 (PDT)
Received: from x1.local ([174.91.117.157]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8df7f015805sm102991346d6.1.2026.06.22.11.50.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 11:50:38 -0700 (PDT)
Date: Mon, 22 Jun 2026 14:50:26 -0400
From: Peter Xu <peterx@redhat.com>
To: Aadeshveer Singh <aadeshveer07@gmail.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, pbonzini@redhat.com,
 philmd@mailo.com, lvivier@redhat.com, ayoub@saferwall.com
Subject: Re: [RFC PATCH 3/5] migration: add eager load thread for fast
 snapshot load
Message-ID: <ajmD8tCPuO51wKPd@x1.local>
References: <20260618032010.88755-1-aadeshveer07@gmail.com>
 <20260618032010.88755-4-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260618032010.88755-4-aadeshveer07@gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Jun 18, 2026 at 08:50:08AM +0530, Aadeshveer Singh wrote:
> In fast snapshot load a thread is needed for actively loading in pages
> along with the fault path so that the guest is not dependent on fault
> thread indefinitely.
> 
> Add postcopy_ram_eager_load_thread(), for the eager thread which
> iterates over all non ignored blocks calling ram_block_load_eager()
> each. ram_block_load_eager then iterates to load in all pages using
> postcopy_mapped_ram_load_page(), with a different channel, which takes
> care of not loading in pages already loaded by fault thread. On
> completion the thread schedules postcopy_ram_eager_load_bh() to destroy
> the incoming migration state and set states to completed/end.
> 
> Add postcopy_ram_eager_load_setup() to create the thread. Added joining
> logic in postcopy_incoming_cleanup().
> 
> Add tracepoints for entry and exit to eager load thread.
> 
> Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>
> ---
>  migration/migration.h    |  5 +++
>  migration/postcopy-ram.c | 75 ++++++++++++++++++++++++++++++++++++++++
>  migration/postcopy-ram.h |  2 ++
>  migration/trace-events   |  2 ++
>  4 files changed, 84 insertions(+)
> 
> diff --git a/migration/migration.h b/migration/migration.h
> index 841f49b215..7bb54a6584 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -42,6 +42,7 @@
>  #define  MIGRATION_THREAD_DST_FAULT         "mig/dst/fault"
>  #define  MIGRATION_THREAD_DST_LISTEN        "mig/dst/listen"
>  #define  MIGRATION_THREAD_DST_PREEMPT       "mig/dst/preempt"
> +#define  MIGRATION_THREAD_DST_EAGER         "mig/dst/eager"

The name isn't easy to digest when someone saw it the 1st time.  Maybe
"snapshot_load" / DST_SNAPSHOT_LOAD?

>  
>  struct PostcopyBlocktimeContext;
>  typedef struct ThreadPool ThreadPool;
> @@ -120,6 +121,10 @@ struct MigrationIncomingState {
>      bool           have_listen_thread;
>      QemuThread     listen_thread;
>  
> +    /* Thread to load pages eagerly in fast snapshot load case */
> +    bool have_eager_load_thread;
> +    QemuThread eager_load_thread;
> +
>      /* For the kernel to send us notifications */
>      int       userfault_fd;
>      /* To notify the fault_thread to wake, e.g., when need to quit */
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index 1ec20a07dd..0ee294a381 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -2289,9 +2289,84 @@ int postcopy_incoming_cleanup(MigrationIncomingState *mis)
>          mis->have_listen_thread = false;
>      }
>  
> +    if (mis->have_eager_load_thread) {
> +        qemu_thread_join(&mis->eager_load_thread);
> +        mis->have_eager_load_thread = false;
> +    }
> +
>      if (migrate_postcopy_ram()) {
>          rc = postcopy_ram_incoming_cleanup(mis);
>      }
>  
>      return rc;
>  }
> +
> +/*
> + * Called by postcopy_ram_eager_load_thread over all blocks to load in all the
> + * pending pages of given ram block
> + */
> +static int ram_block_load_eager(RAMBlock *rb, void *opaque)
> +{
> +    MigrationIncomingState *mis = opaque;
> +    void *host = qemu_ram_get_host_addr(rb);
> +    void *target;
> +    int ret = 0;
> +
> +    for (ram_addr_t page_loc = 0; page_loc < rb->used_length;
> +         page_loc += TARGET_PAGE_SIZE) {

I think you can directly use rb->page_size here, then huge page will also
work.

> +        target = (uint8_t *)host + page_loc;
> +        ret = postcopy_mapped_ram_load_page(mis, rb, page_loc, (uint64_t)target,
> +                                            0);

RAM_CHANNEL_PRECOPY

> +        if (ret) {
> +            break;
> +        }
> +    }
> +    return ret;
> +}
> +
> +/*
> + * Bottom half for fast snapshot load, scheduled by eager load thread
> + */
> +static void postcopy_ram_eager_load_bh(void *opaque)
> +{
> +    MigrationIncomingState *mis = opaque;
> +    postcopy_state_set(POSTCOPY_INCOMING_END);
> +    migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
> +                      MIGRATION_STATUS_COMPLETED);

If you follow what postcopy_listen_thread() does, this should be put in the
eager load thread when all things succeeded.

> +    migration_incoming_state_destroy();
> +}

IIUC we should reuse what postcopy does.

Say, you can have one prior patch making postcopy_listen_thread_bh() to be
what you want.  IIUC we can safely move these two lines into it:

    postcopy_state_set(POSTCOPY_INCOMING_END);

Then I believe you can reuse it.  Maybe when at it, rename it to
postcopy_complete_bh() so it detaches from "listen thread".

That also handles exit_on_error case, so IIUC that's also what you should
do: when any failure happens, set s->error, then set FAILED status, finally
kickoff this BH to handle the rest, so exit() will be done in the BH.

PS: on incoming side so far we still sometimes reuse MigrationState->error.
It's a historical "slight" misuse.. but let's stick with it so far; I think
the whole point is to make error visible in query-migrate if
exit_on_error=false.  It's another problem to solve in the future.

> +
> +/*
> + * Used by fast snapshot load to eagerly load in all pages of RAM and schedule
> + * cleanup after entire RAM is loaded
> + */
> +static void *postcopy_ram_eager_load_thread(void *opaque)
> +{
> +    MigrationIncomingState *mis = opaque;
> +
> +    trace_postcopy_ram_eager_load_thread_entry();
> +    rcu_register_thread();
> +    qemu_event_set(&mis->thread_sync_event);
> +
> +    if (foreach_not_ignored_block(ram_block_load_eager, mis)) {
> +        error_report("ram_block_load_eager failed");

We can set error to MigrationState here with migrate_error_propagate(), if
you would reuse the BH I mentioned above.

> +    }
> +
> +    migration_bh_schedule(postcopy_ram_eager_load_bh, mis);
> +
> +    rcu_unregister_thread();
> +    trace_postcopy_ram_eager_load_thread_exit();
> +    return NULL;
> +}
> +
> +/*
> + * Create thread for eager loading in fast snapshot load case
> + */
> +int postcopy_ram_eager_load_setup(MigrationIncomingState *mis)
> +{
> +    postcopy_thread_create(
> +        mis, &mis->eager_load_thread, MIGRATION_THREAD_DST_EAGER,
> +        postcopy_ram_eager_load_thread, QEMU_THREAD_JOINABLE);
> +    mis->have_eager_load_thread = true;
> +    return 0;
> +}

Then here this patch introduced these functions without using them.  Then
this patch will be almost not possible to do proper review because the
reviewer won't know how it will be used, and where.

IMHO you can squash this patch with the one that will use this function.

Thanks,

> diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
> index a080dd65a7..b3ba42e447 100644
> --- a/migration/postcopy-ram.h
> +++ b/migration/postcopy-ram.h
> @@ -202,4 +202,6 @@ void mark_postcopy_blocktime_begin(uintptr_t addr, uint32_t ptid,
>  int postcopy_incoming_setup(MigrationIncomingState *mis, Error **errp);
>  int postcopy_incoming_cleanup(MigrationIncomingState *mis);
>  
> +int postcopy_ram_eager_load_setup(MigrationIncomingState *mis);
> +
>  #endif
> diff --git a/migration/trace-events b/migration/trace-events
> index de99d976ab..38f11e1e9f 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -314,6 +314,8 @@ postcopy_blocktime_tid_cpu_map(int cpu, uint32_t tid) "cpu: %d, tid: %u"
>  postcopy_blocktime_begin(uint64_t addr, uint64_t time, int cpu, bool exists) "addr: 0x%" PRIx64 ", time: %" PRIu64 ", cpu: %d, exist: %d"
>  postcopy_blocktime_end(uint64_t addr, uint64_t time, int affected_cpu, int affected_non_cpus) "addr: 0x%" PRIx64 ", time: %" PRIu64 ", affected_cpus: %d, affected_non_cpus: %d"
>  postcopy_blocktime_end_one(int cpu, uint8_t left_faults) "cpu: %d, left_faults: %" PRIu8
> +postcopy_ram_eager_load_thread_entry(void) ""
> +postcopy_ram_eager_load_thread_exit(void) ""
>  
>  # exec.c
>  migration_exec_outgoing(const char *cmd) "cmd=%s"
> -- 
> 2.54.0
> 

-- 
Peter Xu


