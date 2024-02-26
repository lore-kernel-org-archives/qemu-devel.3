Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DCD1C5478C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 05:59:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reU0E-0000ak-00; Mon, 26 Feb 2024 00:58:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1reU0D-0000aW-1Y
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 00:58:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1reU0A-0008Qm-Mp
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 00:58:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708927089;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KtpBRqc66n8FE6aL+pHXIDqlhX7JEs/Y0Pz4sZI0nj8=;
 b=Mq4iECNG0qNytRlxSC5M7/F6Y+JHHgMce1JBCN9nPHrX2TYuxUezXioQXn0P8gsfDXVDbm
 FSLX9F7zAg/uC3HpeYFSsGYdcF8zHGvD4P3M/bhojLjc7TbRK+q6AxkcmeLqSeES254pez
 /q+/kyzLS8AD9xbO2bRduzdWWXzS6H0=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-bKg3O1e_MwC3hfUGXHT-sw-1; Mon, 26 Feb 2024 00:58:07 -0500
X-MC-Unique: bKg3O1e_MwC3hfUGXHT-sw-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-1dc44987075so1635505ad.1
 for <qemu-devel@nongnu.org>; Sun, 25 Feb 2024 21:58:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708927086; x=1709531886;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KtpBRqc66n8FE6aL+pHXIDqlhX7JEs/Y0Pz4sZI0nj8=;
 b=aMlhK1LYJZ+W/n4giya6x753hFE4dxhcPeumEBsl+yVrYs3vOJvfdD1pMZDK9HRGxD
 P0ikF2sd7YngWQc1Q6tSAVlZ8i9BX8wxcD5BdELSwc6m7VRbjzemM+SO0y6rf45L+CFS
 wnrNrw+rr4IW0GZas0DY2kjVfTiw7KX2j6sEd5lJdzenaEnQjSSKwYJWZth7Y+pzPX3B
 4OkcjCOF7/XhYl4YU4ii9sNUE/TfhOLVgNVAAwE7QRAi0P22uOrJUNd8eyCjAUhKauxm
 QBP8UaeQvr+nXUStczlB1LYo82E48Ye1uhTP+IIkfHYHRBn+s31yt80sw4QIiXi7YuIr
 /fow==
X-Gm-Message-State: AOJu0YzHrcfL796mTGFyc2ofmJd2/TnDEx39TYnEFStCargZAVsIBjFt
 tdDHs5r9CDxj14R1IPqmrZX5Ipy/8NcMbVu9YxlbQP3z5z7nK0WIuJ/Ex1shUhw4jL+MsoQBbJN
 21zhxWIUBkDtQ30Fw13bDcaXuJVhemYdueOHTYNzdycebMnJiL+Z3
X-Received: by 2002:a17:902:eb4c:b0:1dc:3c:fb67 with SMTP id
 i12-20020a170902eb4c00b001dc003cfb67mr6982957pli.5.1708927086264; 
 Sun, 25 Feb 2024 21:58:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGI8dk9zEbnKNXnJdrRotUMnaP51H2zgVuqGSm07A1X58W/3L5PNP4UHAj6y+v+2NAfRMF7rg==
X-Received: by 2002:a17:902:eb4c:b0:1dc:3c:fb67 with SMTP id
 i12-20020a170902eb4c00b001dc003cfb67mr6982944pli.5.1708927085767; 
 Sun, 25 Feb 2024 21:58:05 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 n10-20020a1709026a8a00b001da11733477sm3098647plk.75.2024.02.25.21.58.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Feb 2024 21:58:05 -0800 (PST)
Date: Mon, 26 Feb 2024 13:57:59 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH v4 18/34] migration/multifd: Allow multifd without packets
Message-ID: <ZdwoZ1loLIAMgbFw@x1n>
References: <20240220224138.24759-1-farosas@suse.de>
 <20240220224138.24759-19-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240220224138.24759-19-farosas@suse.de>
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

On Tue, Feb 20, 2024 at 07:41:22PM -0300, Fabiano Rosas wrote:
> For the upcoming support to the new 'fixed-ram' migration stream
> format, we cannot use multifd packets because each write into the
> ramblock section in the migration file is expected to contain only the
> guest pages. They are written at their respective offsets relative to
> the ramblock section header.
> 
> There is no space for the packet information and the expected gains
> from the new approach come partly from being able to write the pages
> sequentially without extraneous data in between.
> 
> The new format also simply doesn't need the packets and all necessary
> information can be taken from the standard migration headers with some
> (future) changes to multifd code.
> 
> Use the presence of the fixed-ram capability to decide whether to send
> packets.
> 
> This only moves code under multifd_use_packets(), it has no effect for
> now as fixed-ram cannot yet be enabled with multifd.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Mostly good to me, but since we'll probably need at least one more round, I
left some more comments.

> ---
>  migration/multifd.c | 188 +++++++++++++++++++++++++++-----------------
>  1 file changed, 117 insertions(+), 71 deletions(-)
> 
> diff --git a/migration/multifd.c b/migration/multifd.c
> index 5a38cb222f..0a5279314d 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -92,6 +92,11 @@ struct {
>      MultiFDMethods *ops;
>  } *multifd_recv_state;
>  
> +static bool multifd_use_packets(void)
> +{
> +    return !migrate_fixed_ram();
> +}
> +
>  /* Multifd without compression */
>  
>  /**
> @@ -136,10 +141,11 @@ static void nocomp_send_cleanup(MultiFDSendParams *p, Error **errp)
>  static int nocomp_send_prepare(MultiFDSendParams *p, Error **errp)
>  {
>      bool use_zero_copy_send = migrate_zero_copy_send();
> +    bool use_packets = multifd_use_packets();
>      MultiFDPages_t *pages = p->pages;
>      int ret;
>  
> -    if (!use_zero_copy_send) {
> +    if (!use_zero_copy_send && use_packets) {
>          /*
>           * Only !zerocopy needs the header in IOV; zerocopy will
>           * send it separately.
> @@ -156,14 +162,16 @@ static int nocomp_send_prepare(MultiFDSendParams *p, Error **errp)
>      p->next_packet_size = pages->num * p->page_size;
>      p->flags |= MULTIFD_FLAG_NOCOMP;

These two shouldn't be needed by fixed-ram, either?

IIUC only the IOV prepare and future zero page detections may be needed for
fixed-ram in nocomp_send_prepare(). Perhaps something like this would be
clearer?

static void nocomp_send_prepare_iovs(MultiFDSendParams *p)
{
    MultiFDPages_t *pages = p->pages;
    int i;

    for (i = 0; i < pages->num; i++) {
        p->iov[p->iovs_num].iov_base = pages->block->host + pages->offset[i];
        p->iov[p->iovs_num].iov_len = p->page_size;
        p->iovs_num++;
    }
}

static int nocomp_send_prepare(MultiFDSendParams *p, Error **errp)
{
    bool use_zero_copy_send = migrate_zero_copy_send();
    MultiFDPages_t *pages = p->pages;
    int ret;

    if (!multifd_use_packet()) {
        nocomp_send_prepare_iovs(p);
        return true;
    }

    if (!use_zero_copy_send) {
        /*
         * Only !zerocopy needs the header in IOV; zerocopy will
         * send it separately.
         */
        multifd_send_prepare_header(p);
    }

    nocomp_send_prepare_iovs(p);
    ...
}

Then in the future we can also put zero page detection logic into this new
nocomp_send_prepare_iovs(), iiuc.

>  
> -    multifd_send_fill_packet(p);
> +    if (use_packets) {
> +        multifd_send_fill_packet(p);
>  
> -    if (use_zero_copy_send) {
> -        /* Send header first, without zerocopy */
> -        ret = qio_channel_write_all(p->c, (void *)p->packet,
> -                                    p->packet_len, errp);
> -        if (ret != 0) {
> -            return -1;
> +        if (use_zero_copy_send) {
> +            /* Send header first, without zerocopy */
> +            ret = qio_channel_write_all(p->c, (void *)p->packet,
> +                                        p->packet_len, errp);
> +            if (ret != 0) {
> +                return -1;
> +            }
>          }
>      }
>  
> @@ -215,11 +223,16 @@ static int nocomp_recv(MultiFDRecvParams *p, Error **errp)
>                     p->id, flags, MULTIFD_FLAG_NOCOMP);
>          return -1;
>      }
> -    for (int i = 0; i < p->normal_num; i++) {
> -        p->iov[i].iov_base = p->host + p->normal[i];
> -        p->iov[i].iov_len = p->page_size;
> +
> +    if (multifd_use_packets()) {
> +        for (int i = 0; i < p->normal_num; i++) {
> +            p->iov[i].iov_base = p->host + p->normal[i];
> +            p->iov[i].iov_len = p->page_size;
> +        }
> +        return qio_channel_readv_all(p->c, p->iov, p->normal_num, errp);
>      }
> -    return qio_channel_readv_all(p->c, p->iov, p->normal_num, errp);
> +
> +    return 0;
>  }
>  
>  static MultiFDMethods multifd_nocomp_ops = {
> @@ -799,15 +812,18 @@ static void *multifd_send_thread(void *opaque)
>      MigrationThread *thread = NULL;
>      Error *local_err = NULL;
>      int ret = 0;
> +    bool use_packets = multifd_use_packets();
>  
>      thread = migration_threads_add(p->name, qemu_get_thread_id());
>  
>      trace_multifd_send_thread_start(p->id);
>      rcu_register_thread();
>  
> -    if (multifd_send_initial_packet(p, &local_err) < 0) {
> -        ret = -1;
> -        goto out;
> +    if (use_packets) {
> +        if (multifd_send_initial_packet(p, &local_err) < 0) {
> +            ret = -1;
> +            goto out;
> +        }
>      }
>  
>      while (true) {
> @@ -858,16 +874,20 @@ static void *multifd_send_thread(void *opaque)
>               * it doesn't require explicit memory barriers.
>               */
>              assert(qatomic_read(&p->pending_sync));
> -            p->flags = MULTIFD_FLAG_SYNC;
> -            multifd_send_fill_packet(p);
> -            ret = qio_channel_write_all(p->c, (void *)p->packet,
> -                                        p->packet_len, &local_err);
> -            if (ret != 0) {
> -                break;
> +
> +            if (use_packets) {
> +                p->flags = MULTIFD_FLAG_SYNC;
> +                multifd_send_fill_packet(p);
> +                ret = qio_channel_write_all(p->c, (void *)p->packet,
> +                                            p->packet_len, &local_err);
> +                if (ret != 0) {
> +                    break;
> +                }
> +                /* p->next_packet_size will always be zero for a SYNC packet */
> +                stat64_add(&mig_stats.multifd_bytes, p->packet_len);
> +                p->flags = 0;
>              }
> -            /* p->next_packet_size will always be zero for a SYNC packet */
> -            stat64_add(&mig_stats.multifd_bytes, p->packet_len);
> -            p->flags = 0;
> +
>              qatomic_set(&p->pending_sync, false);
>              qemu_sem_post(&p->sem_sync);
>          }
> @@ -1016,6 +1036,7 @@ bool multifd_send_setup(void)
>      Error *local_err = NULL;
>      int thread_count, ret = 0;
>      uint32_t page_count = MULTIFD_PACKET_SIZE / qemu_target_page_size();
> +    bool use_packets = multifd_use_packets();
>      uint8_t i;
>  
>      if (!migrate_multifd()) {
> @@ -1038,27 +1059,35 @@ bool multifd_send_setup(void)
>          qemu_sem_init(&p->sem_sync, 0);
>          p->id = i;
>          p->pages = multifd_pages_init(page_count);
> -        p->packet_len = sizeof(MultiFDPacket_t)
> -                      + sizeof(uint64_t) * page_count;
> -        p->packet = g_malloc0(p->packet_len);
> -        p->packet->magic = cpu_to_be32(MULTIFD_MAGIC);
> -        p->packet->version = cpu_to_be32(MULTIFD_VERSION);
> +
> +        if (use_packets) {
> +            p->packet_len = sizeof(MultiFDPacket_t)
> +                          + sizeof(uint64_t) * page_count;
> +            p->packet = g_malloc0(p->packet_len);
> +            p->packet->magic = cpu_to_be32(MULTIFD_MAGIC);
> +            p->packet->version = cpu_to_be32(MULTIFD_VERSION);
> +
> +            /* We need one extra place for the packet header */
> +            p->iov = g_new0(struct iovec, page_count + 1);
> +        } else {
> +            p->iov = g_new0(struct iovec, page_count);
> +        }
>          p->name = g_strdup_printf("multifdsend_%d", i);
> -        /* We need one extra place for the packet header */
> -        p->iov = g_new0(struct iovec, page_count + 1);
>          p->page_size = qemu_target_page_size();
>          p->page_count = page_count;
>          p->write_flags = 0;
>          multifd_new_send_channel_create(p);
>      }
>  
> -    /*
> -     * Wait until channel creation has started for all channels. The
> -     * creation can still fail, but no more channels will be created
> -     * past this point.
> -     */
> -    for (i = 0; i < thread_count; i++) {
> -        qemu_sem_wait(&multifd_send_state->channels_created);
> +    if (use_packets) {
> +        /*
> +         * Wait until channel creation has started for all channels. The
> +         * creation can still fail, but no more channels will be created
> +         * past this point.
> +         */
> +        for (i = 0; i < thread_count; i++) {
> +            qemu_sem_wait(&multifd_send_state->channels_created);
> +        }
>      }

If so we may need a document for channels_created explaining that it's only
used in "packet-typed" multifd migrations.  And it's always not obvious when
reading this chunk to understand why the thread management can be relevant
to "packet" mode or not.

Instead of doing so, IMHO it's much cleaner we leave it be, then post the
channels_created in your new file_send_channel_create() instead - even if we
know it's synchronous, we keep the channels_created semantics simple.

>  
>      for (i = 0; i < thread_count; i++) {
> @@ -1108,7 +1137,9 @@ static void multifd_recv_terminate_threads(Error *err)
>           * multifd_recv_thread may hung at MULTIFD_FLAG_SYNC handle code,
>           * however try to wakeup it without harm in cleanup phase.
>           */
> -        qemu_sem_post(&p->sem_sync);
> +        if (multifd_use_packets()) {
> +            qemu_sem_post(&p->sem_sync);
> +        }
>  
>          /*
>           * We could arrive here for two reasons:
> @@ -1182,7 +1213,7 @@ void multifd_recv_sync_main(void)
>  {
>      int i;
>  
> -    if (!migrate_multifd()) {
> +    if (!migrate_multifd() || !multifd_use_packets()) {
>          return;
>      }
>      for (i = 0; i < migrate_multifd_channels(); i++) {
> @@ -1209,13 +1240,14 @@ static void *multifd_recv_thread(void *opaque)
>  {
>      MultiFDRecvParams *p = opaque;
>      Error *local_err = NULL;
> +    bool use_packets = multifd_use_packets();
>      int ret;
>  
>      trace_multifd_recv_thread_start(p->id);
>      rcu_register_thread();
>  
>      while (true) {
> -        uint32_t flags;
> +        uint32_t flags = 0;
>          bool has_data = false;
>          p->normal_num = 0;
>  
> @@ -1223,25 +1255,27 @@ static void *multifd_recv_thread(void *opaque)
>              break;
>          }
>  
> -        ret = qio_channel_read_all_eof(p->c, (void *)p->packet,
> -                                       p->packet_len, &local_err);
> -        if (ret == 0 || ret == -1) {   /* 0: EOF  -1: Error */
> -            break;
> -        }
> +        if (use_packets) {
> +            ret = qio_channel_read_all_eof(p->c, (void *)p->packet,
> +                                           p->packet_len, &local_err);
> +            if (ret == 0 || ret == -1) {   /* 0: EOF  -1: Error */
> +                break;
> +            }
>  
> -        qemu_mutex_lock(&p->mutex);
> -        ret = multifd_recv_unfill_packet(p, &local_err);
> -        if (ret) {
> +            qemu_mutex_lock(&p->mutex);
> +            ret = multifd_recv_unfill_packet(p, &local_err);
> +            if (ret) {
> +                qemu_mutex_unlock(&p->mutex);
> +                break;
> +            }
> +
> +            flags = p->flags;
> +            /* recv methods don't know how to handle the SYNC flag */
> +            p->flags &= ~MULTIFD_FLAG_SYNC;
> +            has_data = !!p->normal_num;
>              qemu_mutex_unlock(&p->mutex);
> -            break;
>          }
>  
> -        flags = p->flags;
> -        /* recv methods don't know how to handle the SYNC flag */
> -        p->flags &= ~MULTIFD_FLAG_SYNC;
> -        has_data = !!p->normal_num;
> -        qemu_mutex_unlock(&p->mutex);
> -
>          if (has_data) {
>              ret = multifd_recv_state->ops->recv(p, &local_err);
>              if (ret != 0) {
> @@ -1249,9 +1283,11 @@ static void *multifd_recv_thread(void *opaque)
>              }
>          }
>  
> -        if (flags & MULTIFD_FLAG_SYNC) {
> -            qemu_sem_post(&multifd_recv_state->sem_sync);
> -            qemu_sem_wait(&p->sem_sync);
> +        if (use_packets) {
> +            if (flags & MULTIFD_FLAG_SYNC) {
> +                qemu_sem_post(&multifd_recv_state->sem_sync);
> +                qemu_sem_wait(&p->sem_sync);
> +            }

Some comment explaining why this is only used in packet mode would be nice.

>          }
>      }
>  
> @@ -1270,6 +1306,7 @@ int multifd_recv_setup(Error **errp)
>  {
>      int thread_count;
>      uint32_t page_count = MULTIFD_PACKET_SIZE / qemu_target_page_size();
> +    bool use_packets = multifd_use_packets();
>      uint8_t i;
>  
>      /*
> @@ -1294,9 +1331,12 @@ int multifd_recv_setup(Error **errp)
>          qemu_mutex_init(&p->mutex);
>          qemu_sem_init(&p->sem_sync, 0);
>          p->id = i;
> -        p->packet_len = sizeof(MultiFDPacket_t)
> -                      + sizeof(uint64_t) * page_count;
> -        p->packet = g_malloc0(p->packet_len);
> +
> +        if (use_packets) {
> +            p->packet_len = sizeof(MultiFDPacket_t)
> +                + sizeof(uint64_t) * page_count;
> +            p->packet = g_malloc0(p->packet_len);
> +        }
>          p->name = g_strdup_printf("multifdrecv_%d", i);
>          p->iov = g_new0(struct iovec, page_count);
>          p->normal = g_new0(ram_addr_t, page_count);
> @@ -1340,18 +1380,24 @@ void multifd_recv_new_channel(QIOChannel *ioc, Error **errp)
>  {
>      MultiFDRecvParams *p;
>      Error *local_err = NULL;
> +    bool use_packets = multifd_use_packets();
>      int id;
>  
> -    id = multifd_recv_initial_packet(ioc, &local_err);
> -    if (id < 0) {
> -        multifd_recv_terminate_threads(local_err);
> -        error_propagate_prepend(errp, local_err,
> -                                "failed to receive packet"
> -                                " via multifd channel %d: ",
> -                                qatomic_read(&multifd_recv_state->count));
> -        return;
> +    if (use_packets) {
> +        id = multifd_recv_initial_packet(ioc, &local_err);
> +        if (id < 0) {
> +            multifd_recv_terminate_threads(local_err);
> +            error_propagate_prepend(errp, local_err,
> +                                    "failed to receive packet"
> +                                    " via multifd channel %d: ",
> +                                    qatomic_read(&multifd_recv_state->count));
> +            return;
> +        }
> +        trace_multifd_recv_new_channel(id);
> +    } else {
> +        /* next patch gives this a meaningful value */
> +        id = 0;
>      }
> -    trace_multifd_recv_new_channel(id);
>  
>      p = &multifd_recv_state->params[id];
>      if (p->c != NULL) {
> -- 
> 2.35.3
> 

-- 
Peter Xu


