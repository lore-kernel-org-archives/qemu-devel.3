Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFEECC282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 12:31:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tu9cO-0000io-VR; Mon, 17 Mar 2025 08:30:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tu9c6-0000gO-MK
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 08:30:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tu9c4-0005Ts-Kx
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 08:30:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742214634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MtV0U7M06v0EMP4sZiAS8CUle8jscDt+mYWLXYbueBw=;
 b=GTdkECQUtGh68uikDk8DHjBno9PxUU1r7gW6/8sGvmNA7t7k2kbETeSDLOG91ManVlQMJV
 h1iXpahMraEKSrHNOqg5jhmhLftVjvN02gnss7Mc1BoFoScJuWCsn4Ymx7k1sTsGgUZsq/
 SeW2W8glX3Szbt/RRHSm/F+bVPeNjYg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-HnADsDNtOc--oM2Xz6PH6g-1; Mon, 17 Mar 2025 08:30:33 -0400
X-MC-Unique: HnADsDNtOc--oM2Xz6PH6g-1
X-Mimecast-MFC-AGG-ID: HnADsDNtOc--oM2Xz6PH6g_1742214632
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3914bc0cc4aso2536403f8f.3
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 05:30:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742214632; x=1742819432;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MtV0U7M06v0EMP4sZiAS8CUle8jscDt+mYWLXYbueBw=;
 b=SRwsGGkNlMOTFGou7GPLDFqNLpm5CdQ4cT34viOBsAam59EJDsMkvf/GYphDpoLu+v
 iu42VN3zJO8JzQisZ3KCAfcFXeEMdNQ6jdDz/x6dkNtdwaitOC8C/0+Noog2MD1LUY0Z
 hCo1GLUDLp3yKHryKmhexW0wt+/qztKTyDnVDaJkLZCmO6czlPpW0PdH3Y1eUvuhplJ+
 w9JW7KlzJ3bIepBP6VgmRHzIc6pxTyilYOMhysVhODMyOebInaWdpo2ydPouU/xwoQWE
 /xweRkvpquucH2oqHrIZW2zGJYnSH/TFRGFEvdB9ezS5ESgDeGWsCRikY+1vgbQgdfel
 aPmg==
X-Gm-Message-State: AOJu0Yy9igbPOPdiCpT4js0y5i5TVFQeqGMUQmlpMjWA5A67PCh3H8HD
 Y+elQYTeOgbMG6nLLxx8MQr1Q4XBsL7+HzI3iIBQGo7b8Oe2IvxU9MOPDw9rYH7U4ZGo22RdOjc
 E4xbcVFfph3j9v+UG/QddTgB7CqFZ1mE/BjCkqNicr0WG0qlIb6J5VCulEDpcnAqyv1FMgBVjEM
 GxiBeDL6yF4DiWfeELJal/AHgHWG4O5DSRPq2m3A==
X-Gm-Gg: ASbGncsGLxRXR3KWki7ZSu9teV5zHJU3WBk/ju4DIlEJjQyOJ0A3jNr2gVcd3JzuNez
 NjNFLwB3FXw75yXNMl7gRBxzOS06hZumOioRi93rFVngDj7NLtdaOpXnLUYUfewtWXN8JmHgNpc
 k=
X-Received: by 2002:a5d:5f84:0:b0:391:3fa7:bf77 with SMTP id
 ffacd0b85a97d-3971e3a54cbmr15337885f8f.31.1742214631801; 
 Mon, 17 Mar 2025 05:30:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpFcawllQbxT4wPvpCnmUS6hHrR6O7723AvHN66zN83vo1TDXS21ko9v2YwHv1kbgHN0HY8G6mnrNcwMO1I54=
X-Received: by 2002:a5d:5f84:0:b0:391:3fa7:bf77 with SMTP id
 ffacd0b85a97d-3971e3a54cbmr15337851f8f.31.1742214631391; Mon, 17 Mar 2025
 05:30:31 -0700 (PDT)
MIME-Version: 1.0
References: <Z8G9Wj3DWSgdLkNQ@x1.local>
 <CAE8KmOxenqyqOxEFozgP1gBZPtneEqcbop9F_f+VW3ukPfw37A@mail.gmail.com>
 <Z8XBowkG72G-l3L4@x1.local>
 <CAE8KmOyssf_2RYBw2LLpxP2Z5bmtyU==Qs+4HWp=mOVb9o82-g@mail.gmail.com>
 <Z8cPnxqOvp1hFpx8@x1.local>
 <CAE8KmOw1CCQUt0wyELVhy5j-CfwVuA2XNsecW=y6rwJv7dempw@mail.gmail.com>
 <Z8hJeneeuKqD1i8Q@x1.local>
 <CAE8KmOyKiEt9t0vUwVyqD7tx01vkm+NHA1p1tmQnJ9mKY0Za7w@mail.gmail.com>
 <Z8t3uKo54T_Xls_O@x1.local>
 <CAE8KmOwdLk4oZg8TAt0z6rd27f0MpbSS54TWNDshZFU7WPxk-Q@mail.gmail.com>
 <Z9M7MYUPqHFIQPuV@x1.local>
In-Reply-To: <Z9M7MYUPqHFIQPuV@x1.local>
From: Prasad Pandit <ppandit@redhat.com>
Date: Mon, 17 Mar 2025 18:00:14 +0530
X-Gm-Features: AQ5f1Jr0DnM_rWjbTuSGe0OmiVh7Q-P0JNrFTi-m-GY2xQOCqFcc0VAuHfzF5Ts
Message-ID: <CAE8KmOwcgvZekToHbznDWAidXM2L_4Aoszz6j19bSC4U8f4oRg@mail.gmail.com>
Subject: Re: [PATCH v7 5/5] migration: add MULTIFD_RECV_SYNC migration command
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, berrange@redhat.com, 
 Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.335,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi,

On Fri, 14 Mar 2025 at 01:40, Peter Xu <peterx@redhat.com> wrote:
>+        save_section_header(f, se, QEMU_VM_SECTION_PART);
> +        ram_save_zero_page(f, se->opaque);
>I'll stop requesting a why here...

* Earlier in this thread you mentioned 'We need a header'. I took it
as a 'RAM page' header, not save_section_header(). Section type
(QEMU_VM_COMMAND) was sent by qemu_savevm_command_send() as well.

> but I think this is another example that even if all the tests pass it may not be correct.

* This is also an example of - communication is hard.

> From f9343dfc777ef04168443e86a1fa3922296ea563 Mon Sep 17 00:00:00 2001
> From: Peter Xu <peterx@redhat.com>
> Date: Thu, 13 Mar 2025 15:34:10 -0400
> Subject: [PATCH 1/2] migration: Add save_postcopy_prepare() savevm handler
>
> Add a savevm handler for a module to opt-in sending extra sections right
> before postcopy starts, and before VM is stopped.
>
> RAM will start to use this new savevm handler in the next patch to do flush
> and sync for multifd pages.
>
> Note that we choose to do it before VM stopped because the current only
> potential user is not sensitive to VM status, so doing it before VM is
> stopped is preferred to enlarge any postcopy downtime.
>
> It is still a bit unfortunate that we need to introduce such a new savevm
> handler just for the only use case, however it's so far the cleanest.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/migration/register.h | 15 +++++++++++++++
>  migration/savevm.h           |  1 +
>  migration/migration.c        |  4 ++++
>  migration/savevm.c           | 33 +++++++++++++++++++++++++++++++++
>  4 files changed, 53 insertions(+)
>
> diff --git a/include/migration/register.h b/include/migration/register.h
> index c041ce32f2..b79dc81b8d 100644
> --- a/include/migration/register.h
> +++ b/include/migration/register.h
> @@ -189,6 +189,21 @@ typedef struct SaveVMHandlers {
>
>      /* This runs outside the BQL!  */
>
> +    /**
> +     * @save_postcopy_prepare
> +     *
> +     * This hook will be invoked on the source side right before switching
> +     * to postcopy (before VM stopped).
> +     *
> +     * @f:      QEMUFile where to send the data
> +     * @opaque: Data pointer passed to register_savevm_live()
> +     * @errp:   Error** used to report error message
> +     *
> +     * Returns: true if succeeded, false if error occured.  When false is
> +     * returned, @errp must be set.
> +     */
> +    bool (*save_postcopy_prepare)(QEMUFile *f, void *opaque, Error **errp);
> +
>      /**
>       * @state_pending_estimate
>       *
> diff --git a/migration/savevm.h b/migration/savevm.h
> index 138c39a7f9..2d5e9c7166 100644
> --- a/migration/savevm.h
> +++ b/migration/savevm.h
> @@ -45,6 +45,7 @@ void qemu_savevm_state_pending_exact(uint64_t *must_precopy,
>  void qemu_savevm_state_pending_estimate(uint64_t *must_precopy,
>                                          uint64_t *can_postcopy);
>  int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy);
> +bool qemu_savevm_state_postcopy_prepare(QEMUFile *f, Error **errp);
>  void qemu_savevm_send_ping(QEMUFile *f, uint32_t value);
>  void qemu_savevm_send_open_return_path(QEMUFile *f);
>  int qemu_savevm_send_packaged(QEMUFile *f, const uint8_t *buf, size_t len);
> diff --git a/migration/migration.c b/migration/migration.c
> index d46e776e24..212f6b4145 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2707,6 +2707,10 @@ static int postcopy_start(MigrationState *ms, Error **errp)
>          }
>      }
>
> +    if (!qemu_savevm_state_postcopy_prepare(ms->to_dst_file, errp)) {
> +        return -1;
> +    }
> +
>      trace_postcopy_start();
>      bql_lock();
>      trace_postcopy_start_set_run();
> diff --git a/migration/savevm.c b/migration/savevm.c
> index ce158c3512..23ef4c7dc9 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1523,6 +1523,39 @@ void qemu_savevm_state_complete_postcopy(QEMUFile *f)
>      qemu_fflush(f);
>  }
>
> +bool qemu_savevm_state_postcopy_prepare(QEMUFile *f, Error **errp)
> +{
> +    SaveStateEntry *se;
> +    bool ret;
> +
> +    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
> +        if (!se->ops || !se->ops->save_postcopy_prepare) {
> +            continue;
> +        }
> +
> +        if (se->ops->is_active) {
> +            if (!se->ops->is_active(se->opaque)) {
> +                continue;
> +            }
> +        }
> +
> +        trace_savevm_section_start(se->idstr, se->section_id);
> +
> +        save_section_header(f, se, QEMU_VM_SECTION_PART);
> +        ret = se->ops->save_postcopy_prepare(f, se->opaque, errp);
> +        save_section_footer(f, se);
> +
> +        trace_savevm_section_end(se->idstr, se->section_id, ret);
> +
> +        if (!ret) {
> +            assert(*errp);
> +            return false;
> +        }
> +    }
> +
> +    return true;
> +}
> +
>  int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy)
>  {
>      int64_t start_ts_each, end_ts_each;
> --
> 2.47.0
>
>
> From 299e1cdd9b28802f361ed012673825685e30f965 Mon Sep 17 00:00:00 2001
> From: Peter Xu <peterx@redhat.com>
> Date: Thu, 13 Mar 2025 15:56:01 -0400
> Subject: [PATCH 2/2] migration/ram: Implement save_postcopy_prepare()
>
> Implement save_postcopy_prepare(), preparing for the enablement of both
> multifd and postcopy.
>
> Please see the rich comment for the rationals.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/ram.c | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>
> diff --git a/migration/ram.c b/migration/ram.c
> index 424df6d9f1..119e7d3ac2 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -4420,6 +4420,42 @@ static int ram_resume_prepare(MigrationState *s, void *opaque)
>      return 0;
>  }
>
> +static bool ram_save_postcopy_prepare(QEMUFile *f, void *opaque, Error **errp)
> +{
> +    int ret;
> +
> +    if (migrate_multifd()) {
> +        /*
> +         * When multifd is enabled, source QEMU needs to make sure all the
> +         * pages queued before postcopy starts to be flushed.
> +         *
> +         * Meanwhile, the load of these pages must happen before switching
> +         * to postcopy.  It's because loading of guest pages (so far) in
> +         * multifd recv threads is still non-atomic, so the load cannot
> +         * happen with vCPUs running on destination side.
> +         *
> +         * This flush and sync will guarantee those pages loaded _before_
> +         * postcopy starts on destination. The rational is, this happens
> +         * before VM stops (and before source QEMU sends all the rest of
> +         * the postcopy messages).  So when the destination QEMU received
> +         * the postcopy messages, it must have received the sync message on
> +         * the main channel (either RAM_SAVE_FLAG_MULTIFD_FLUSH, or
> +         * RAM_SAVE_FLAG_EOS), and such message should have guaranteed all
> +         * previous guest pages queued in the multifd channels to be
> +         * completely loaded.
> +         */
> +        ret = multifd_ram_flush_and_sync(f);
> +        if (ret < 0) {
> +            error_setg(errp, "%s: multifd flush and sync failed", __func__);
> +            return false;
> +        }
> +    }
> +
> +    qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
> +
> +    return true;
> +}
> +
>  void postcopy_preempt_shutdown_file(MigrationState *s)
>  {
>      qemu_put_be64(s->postcopy_qemufile_src, RAM_SAVE_FLAG_EOS);
> @@ -4439,6 +4475,7 @@ static SaveVMHandlers savevm_ram_handlers = {
>      .load_setup = ram_load_setup,
>      .load_cleanup = ram_load_cleanup,
>      .resume_prepare = ram_resume_prepare,
> +    .save_postcopy_prepare = ram_save_postcopy_prepare,
>  };
>
>  static void ram_mig_ram_block_resized(RAMBlockNotifier *n, void *host,
> --
> 2.47.0

* I get the infrastructural changes that they'll help to take
'section' specific action before postcopy starts. It's not clear how
tying flush and sync with a RAM section helps; because on the
destination side 'section' is only used to call
se->ops->load_state()->ram_load->ram_load_precopy()->multifd_recv_sync_main().

* To confirm:
    -  Benefit of this approach is that 'flush and sync' works via
vmstate_load -> se->ops->load_state() -> ram_load ->
ram_load_precopy() sequence?

* Thank you for the patches, I'll send a revised patchset including them.

Thank you.
---
  - Prasad


