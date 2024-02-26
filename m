Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D23B7C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 06:59:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reUxA-0007oP-Fu; Mon, 26 Feb 2024 01:59:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1reUx6-0007oB-Nq
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 01:59:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1reUx3-0002JC-VL
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 01:59:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708930741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bMMXzzl3GTlsHIobaIcgB1oPOaJDhOOcHR2gXPPjJhs=;
 b=ikptMrkYBYerE9wuKulAOKRpl+pI4ffwpS+EIgBCLrfLi/RcYc26DGBZ79EkMOOIKv48Qp
 k0JEC1DvgsxeGFxKYk1iM3c6tSIcli0Jqu813E/8JvkwxU1ugxwZjCVzCXDRe4gXgbzMol
 UxVN2F5UrXYPThRCgZyZDT/bnulV/fg=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-q6phpe-1PCWw3IiSAxaieg-1; Mon, 26 Feb 2024 01:58:59 -0500
X-MC-Unique: q6phpe-1PCWw3IiSAxaieg-1
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-1da0dd1dec4so10311945ad.1
 for <qemu-devel@nongnu.org>; Sun, 25 Feb 2024 22:58:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708930738; x=1709535538;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bMMXzzl3GTlsHIobaIcgB1oPOaJDhOOcHR2gXPPjJhs=;
 b=JpXT+xekEztMBXJQej56R60ebRNC8BVVwIWNaM3wiY7GAdYGZNfI9LMQ/zPj5yrUpg
 eKaDPd5XeKfiFMiNyywGFz/FEy+Av8hKVUKmdO3HJE4GhRWoxAe8aNzNJ9F4wkyMli2x
 UhpVoc9DMpsb0lyNZK1cuGqDVyo3MKtcznQR+NTzvqUtFM1zNlOgAMnxuNlunlEkGlhV
 dxUl9RFUEO2S4DkAYw4ObaelrlYkEogKivN1/gfO4X7Ne1/tdHymYN8w2nqci8n8ArWA
 BnSZeBn6u46jBEtvaWb4pjJvw3gAmiWVI9dw869oawrPqVt/CC4ultd0wSi889/TwyLE
 HaZg==
X-Gm-Message-State: AOJu0Yyx7quUda3T/8iMywW19JRijbSLh1c+TCWaObZYe1pgXqAiJpRv
 tfiayT8Vuc0z6LUrBWinYBXVWVOXdSYLuGEW7hH7x/u2WLLDwy7SDHEcx/73niRKdGUeT05I7Ek
 3x5Uf6Ekh71QmhN8Hr5rSFoW7wXWM/tq1cRZozUYfCDMlyO1K9Xy6
X-Received: by 2002:a17:902:ee45:b0:1dc:51ac:88ef with SMTP id
 5-20020a170902ee4500b001dc51ac88efmr6883523plo.6.1708930738250; 
 Sun, 25 Feb 2024 22:58:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3s4i5A377NLcj0odmJZaaiJBt1HabexobipTNBC9ID/ZhahLpGw+tZ2HqeWOfxwAyRIOHiA==
X-Received: by 2002:a17:902:ee45:b0:1dc:51ac:88ef with SMTP id
 5-20020a170902ee4500b001dc51ac88efmr6883511plo.6.1708930737805; 
 Sun, 25 Feb 2024 22:58:57 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 w19-20020a170902d3d300b001d911dd145esm3181808plb.219.2024.02.25.22.58.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Feb 2024 22:58:57 -0800 (PST)
Date: Mon, 26 Feb 2024 14:58:50 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH v4 19/34] migration/multifd: Allow receiving pages
 without packets
Message-ID: <Zdw2qilH4DVdmmjB@x1n>
References: <20240220224138.24759-1-farosas@suse.de>
 <20240220224138.24759-20-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240220224138.24759-20-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.097,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Tue, Feb 20, 2024 at 07:41:23PM -0300, Fabiano Rosas wrote:
> Currently multifd does not need to have knowledge of pages on the
> receiving side because all the information needed is within the
> packets that come in the stream.
> 
> We're about to add support to fixed-ram migration, which cannot use
> packets because it expects the ramblock section in the migration file
> to contain only the guest pages data.
> 
> Add a data structure to transfer pages between the ram migration code
> and the multifd receiving threads.
> 
> We don't want to reuse MultiFDPages_t for two reasons:
> 
> a) multifd threads don't really need to know about the data they're
>    receiving.
> 
> b) the receiving side has to be stopped to load the pages, which means
>    we can experiment with larger granularities than page size when
>    transferring data.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
> @Peter: a 'quit' flag cannot be used instead of pending_job. The
> receiving thread needs know there's no more data coming. If the
> migration thread sets a 'quit' flag, the multifd thread would see the
> flag right away and exit.

Hmm.. isn't this exactly what we want?  I'll comment for this inline below.

> The only way is to clear pending_job on the
> thread and spin once more.
> ---
>  migration/file.c    |   1 +
>  migration/multifd.c | 122 +++++++++++++++++++++++++++++++++++++++++---
>  migration/multifd.h |  15 ++++++
>  3 files changed, 131 insertions(+), 7 deletions(-)
> 
> diff --git a/migration/file.c b/migration/file.c
> index 5d4975f43e..22d052a71f 100644
> --- a/migration/file.c
> +++ b/migration/file.c
> @@ -6,6 +6,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "exec/ramblock.h"
>  #include "qemu/cutils.h"
>  #include "qapi/error.h"
>  #include "channel.h"
> diff --git a/migration/multifd.c b/migration/multifd.c
> index 0a5279314d..45a0c7aaa8 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -81,9 +81,15 @@ struct {
>  
>  struct {
>      MultiFDRecvParams *params;
> +    MultiFDRecvData *data;
>      /* number of created threads */
>      int count;
> -    /* syncs main thread and channels */
> +    /*
> +     * For sockets: this is posted once for each MULTIFD_FLAG_SYNC flag.
> +     *
> +     * For files: this is only posted at the end of the file load to mark
> +     *            completion of the load process.
> +     */
>      QemuSemaphore sem_sync;
>      /* global number of generated multifd packets */
>      uint64_t packet_num;
> @@ -1110,6 +1116,53 @@ bool multifd_send_setup(void)
>      return true;
>  }
>  
> +bool multifd_recv(void)
> +{
> +    int i;
> +    static int next_recv_channel;
> +    MultiFDRecvParams *p = NULL;
> +    MultiFDRecvData *data = multifd_recv_state->data;

[1]

> +
> +    /*
> +     * next_channel can remain from a previous migration that was
> +     * using more channels, so ensure it doesn't overflow if the
> +     * limit is lower now.
> +     */
> +    next_recv_channel %= migrate_multifd_channels();
> +    for (i = next_recv_channel;; i = (i + 1) % migrate_multifd_channels()) {
> +        if (multifd_recv_should_exit()) {
> +            return false;
> +        }
> +
> +        p = &multifd_recv_state->params[i];
> +
> +        /*
> +         * Safe to read atomically without a lock because the flag is
> +         * only set by this function below. Reading an old value of
> +         * true is not an issue because it would only send us looking
> +         * for the next idle channel.
> +         */
> +        if (qatomic_read(&p->pending_job) == false) {
> +            next_recv_channel = (i + 1) % migrate_multifd_channels();
> +            break;
> +        }
> +    }

IIUC you'll need an smp_mb_acquire() here.  The ordering of "reading
pending_job" and below must be guaranteed, similar to the sender side.

> +
> +    assert(!p->data->size);
> +    multifd_recv_state->data = p->data;

[2]

> +    p->data = data;
> +
> +    qatomic_set(&p->pending_job, true);

Then here:

       qatomic_store_release(&p->pending_job, true);

Please consider add comment above all acquire/releases pairs like sender
too.

> +    qemu_sem_post(&p->sem);
> +
> +    return true;
> +}
> +
> +MultiFDRecvData *multifd_get_recv_data(void)
> +{
> +    return multifd_recv_state->data;
> +}

Can also use it above [1].

I'm thinking maybe we can do something like:

#define  MULTIFD_RECV_DATA_GLOBAL  (multifd_recv_state->data)

Then we can also use it at [2], and replace multifd_get_recv_data()?

> +
>  static void multifd_recv_terminate_threads(Error *err)
>  {
>      int i;
> @@ -1134,11 +1187,26 @@ static void multifd_recv_terminate_threads(Error *err)
>          MultiFDRecvParams *p = &multifd_recv_state->params[i];
>  
>          /*
> -         * multifd_recv_thread may hung at MULTIFD_FLAG_SYNC handle code,
> -         * however try to wakeup it without harm in cleanup phase.
> +         * The migration thread and channels interact differently
> +         * depending on the presence of packets.
>           */
>          if (multifd_use_packets()) {
> +            /*
> +             * The channel receives as long as there are packets. When
> +             * packets end (i.e. MULTIFD_FLAG_SYNC is reached), the
> +             * channel waits for the migration thread to sync. If the
> +             * sync never happens, do it here.
> +             */
>              qemu_sem_post(&p->sem_sync);
> +        } else {
> +            /*
> +             * The channel waits for the migration thread to give it
> +             * work. When the migration thread runs out of work, it
> +             * releases the channel and waits for any pending work to
> +             * finish. If we reach here (e.g. due to error) before the
> +             * work runs out, release the channel.
> +             */
> +            qemu_sem_post(&p->sem);
>          }
>  
>          /*
> @@ -1167,6 +1235,7 @@ static void multifd_recv_cleanup_channel(MultiFDRecvParams *p)
>      p->c = NULL;
>      qemu_mutex_destroy(&p->mutex);
>      qemu_sem_destroy(&p->sem_sync);
> +    qemu_sem_destroy(&p->sem);
>      g_free(p->name);
>      p->name = NULL;
>      p->packet_len = 0;
> @@ -1184,6 +1253,8 @@ static void multifd_recv_cleanup_state(void)
>      qemu_sem_destroy(&multifd_recv_state->sem_sync);
>      g_free(multifd_recv_state->params);
>      multifd_recv_state->params = NULL;
> +    g_free(multifd_recv_state->data);
> +    multifd_recv_state->data = NULL;
>      g_free(multifd_recv_state);
>      multifd_recv_state = NULL;
>  }
> @@ -1251,11 +1322,11 @@ static void *multifd_recv_thread(void *opaque)
>          bool has_data = false;
>          p->normal_num = 0;
>  
> -        if (multifd_recv_should_exit()) {
> -            break;
> -        }
> -
>          if (use_packets) {
> +            if (multifd_recv_should_exit()) {
> +                break;
> +            }
> +
>              ret = qio_channel_read_all_eof(p->c, (void *)p->packet,
>                                             p->packet_len, &local_err);
>              if (ret == 0 || ret == -1) {   /* 0: EOF  -1: Error */
> @@ -1274,6 +1345,26 @@ static void *multifd_recv_thread(void *opaque)
>              p->flags &= ~MULTIFD_FLAG_SYNC;
>              has_data = !!p->normal_num;
>              qemu_mutex_unlock(&p->mutex);
> +        } else {
> +            /*
> +             * No packets, so we need to wait for the vmstate code to
> +             * give us work.
> +             */
> +            qemu_sem_wait(&p->sem);
> +
> +            if (multifd_recv_should_exit()) {
> +                break;
> +            }
> +
> +            /*
> +             * Migration thread did not send work, break and signal
> +             * sem_sync so it knows we're not lagging behind.
> +             */
> +            if (!qatomic_read(&p->pending_job)) {
> +                break;
> +            }

In reality, this _must_ be true when reaching here, right?  Since AFAIU
recv side p->sem is posted only in two conditions:

  1) when there is work (pending_job==true)
  2) when terminating threads (multifd_recv_should_exit==true)

Then if 2) is checked above, I assume 1) must be the case here?

> +
> +            has_data = !!p->data->size;
>          }
>  
>          if (has_data) {
> @@ -1288,9 +1379,17 @@ static void *multifd_recv_thread(void *opaque)
>                  qemu_sem_post(&multifd_recv_state->sem_sync);
>                  qemu_sem_wait(&p->sem_sync);
>              }
> +        } else {
> +            p->total_normal_pages += p->data->size / qemu_target_page_size();
> +            p->data->size = 0;
> +            qatomic_set(&p->pending_job, false);

I think it needs to be:

  qatomic_store_release(&p->pending_job, false);

?

So as to guarantee when the other side sees pending_job==false, size must
already have been reset.

>          }
>      }
>  
> +    if (!use_packets) {
> +        qemu_sem_post(&p->sem_sync);
> +    }
> +
>      if (local_err) {
>          multifd_recv_terminate_threads(local_err);
>          error_free(local_err);
> @@ -1320,6 +1419,10 @@ int multifd_recv_setup(Error **errp)
>      thread_count = migrate_multifd_channels();
>      multifd_recv_state = g_malloc0(sizeof(*multifd_recv_state));
>      multifd_recv_state->params = g_new0(MultiFDRecvParams, thread_count);
> +
> +    multifd_recv_state->data = g_new0(MultiFDRecvData, 1);
> +    multifd_recv_state->data->size = 0;
> +
>      qatomic_set(&multifd_recv_state->count, 0);
>      qatomic_set(&multifd_recv_state->exiting, 0);
>      qemu_sem_init(&multifd_recv_state->sem_sync, 0);
> @@ -1330,8 +1433,13 @@ int multifd_recv_setup(Error **errp)
>  
>          qemu_mutex_init(&p->mutex);
>          qemu_sem_init(&p->sem_sync, 0);
> +        qemu_sem_init(&p->sem, 0);
> +        p->pending_job = false;
>          p->id = i;
>  
> +        p->data = g_new0(MultiFDRecvData, 1);
> +        p->data->size = 0;
> +
>          if (use_packets) {
>              p->packet_len = sizeof(MultiFDPacket_t)
>                  + sizeof(uint64_t) * page_count;
> diff --git a/migration/multifd.h b/migration/multifd.h
> index 9a6a7a72df..19188815a3 100644
> --- a/migration/multifd.h
> +++ b/migration/multifd.h
> @@ -13,6 +13,8 @@
>  #ifndef QEMU_MIGRATION_MULTIFD_H
>  #define QEMU_MIGRATION_MULTIFD_H
>  
> +typedef struct MultiFDRecvData MultiFDRecvData;
> +
>  bool multifd_send_setup(void);
>  void multifd_send_shutdown(void);
>  int multifd_recv_setup(Error **errp);
> @@ -23,6 +25,8 @@ void multifd_recv_new_channel(QIOChannel *ioc, Error **errp);
>  void multifd_recv_sync_main(void);
>  int multifd_send_sync_main(void);
>  bool multifd_queue_page(RAMBlock *block, ram_addr_t offset);
> +bool multifd_recv(void);
> +MultiFDRecvData *multifd_get_recv_data(void);
>  
>  /* Multifd Compression flags */
>  #define MULTIFD_FLAG_SYNC (1 << 0)
> @@ -63,6 +67,13 @@ typedef struct {
>      RAMBlock *block;
>  } MultiFDPages_t;
>  
> +struct MultiFDRecvData {
> +    void *opaque;
> +    size_t size;
> +    /* for preadv */
> +    off_t file_offset;
> +};
> +
>  typedef struct {
>      /* Fields are only written at creating/deletion time */
>      /* No lock required for them, they are read only */
> @@ -154,6 +165,8 @@ typedef struct {
>  
>      /* syncs main thread and channels */
>      QemuSemaphore sem_sync;
> +    /* sem where to wait for more work */
> +    QemuSemaphore sem;
>  
>      /* this mutex protects the following parameters */
>      QemuMutex mutex;
> @@ -163,6 +176,8 @@ typedef struct {
>      uint32_t flags;
>      /* global number of generated multifd packets */
>      uint64_t packet_num;
> +    int pending_job;
> +    MultiFDRecvData *data;
>  
>      /* thread local variables. No locking required */
>  
> -- 
> 2.35.3
> 

-- 
Peter Xu


