Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F441C48291
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 06:21:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWsLm-0002TR-2h; Mon, 05 Feb 2024 01:21:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rWsLk-0002St-18
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 01:21:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rWsLi-0006hE-1Q
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 01:20:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707114056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1FTy5zDdcqxx35mBArcxs91JvRr9KqrOsCMKH3wY1SM=;
 b=DT1BV5CvAJvoTgDcpgAYsLeW7u9kMULWt5TJye+6vaSa++YWJ978gAXqP7EbSLslGxkIZP
 LmMAbHr3LXEjYxxIQe8CwGXEsUy360Sir19EgENvjOoSn/ookEd/3YUAsdOVznkPLFSTkQ
 +OvkpduacE+8KGcxUd/f9cQ4/1oRd/s=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-te6JpIOWOgqbkeYA_JB1uA-1; Mon, 05 Feb 2024 01:20:54 -0500
X-MC-Unique: te6JpIOWOgqbkeYA_JB1uA-1
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-1d95551c141so1690045ad.0
 for <qemu-devel@nongnu.org>; Sun, 04 Feb 2024 22:20:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707114053; x=1707718853;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1FTy5zDdcqxx35mBArcxs91JvRr9KqrOsCMKH3wY1SM=;
 b=J2Vzd31Djx7425H7B3RWpCIYhj4tfE08+u/HSbL9HK/bDS+wHlxmsomVXtMhoEw88c
 Om1jq0Y91EX7Sr2PARLF2N6AeT/vO2T++TWRpUgtdAij+1mNP1THSDZ3k8bbl4Oce2Zd
 0QqRywGqyzHsVI+m4OsicDkb2mF6PT3IAgzNOgi3/0+FwRMcug3AbkDgFTM906fNZdXc
 dcuqx6yu7l6WFZW/RbqtmfNRso1E1MSFdQ2eClzsN+zC8aU+Qp4bsj/V58fRwhFKBFoE
 659uQncPKVETMWg3+dYSW78WfTav7le6RLkPttbEnYcaG9ZIlo4DlFpCroE2z8axyIc/
 HXlA==
X-Gm-Message-State: AOJu0Yzs3ElpTftDJdMlER3XMLB2ZAaM/uAHTYngRdRQXqd50UORHbWF
 SpQbHIq3veWYCO9rKUVYVpbfVcE6F+S1Lso5L1+JS80qXQJeyKUZ97Kwh83Ga2HAP+nAMSfRxDl
 y6w3yAVpR9HsXKHkHryYfscAXakvv5GFUbitvN+EVDaRsw05d1J52
X-Received: by 2002:a17:902:d502:b0:1d9:a825:19d1 with SMTP id
 b2-20020a170902d50200b001d9a82519d1mr3152318plg.0.1707114053132; 
 Sun, 04 Feb 2024 22:20:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEq00m5B6dL3B3u7J4wp2wxV53KfmjjFhaF6lArPDdnr7XB/5PgVxualAqkEm+hF3d3w/S2Ww==
X-Received: by 2002:a17:902:d502:b0:1d9:a825:19d1 with SMTP id
 b2-20020a170902d50200b001d9a82519d1mr3152309plg.0.1707114052701; 
 Sun, 04 Feb 2024 22:20:52 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCWTA6jQ7pNUBXhi2rXL3iRQddS4fMYjSKWRotQqDy8u/jttvbAuzuJmZHSkX3JzzGwwl8ZXh1yImGw4diQo76Q3SMw=
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 mm4-20020a1709030a0400b001d8dbb867b1sm5512329plb.179.2024.02.04.22.20.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Feb 2024 22:20:52 -0800 (PST)
Date: Mon, 5 Feb 2024 14:20:43 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Avihai Horon <avihaih@nvidia.com>
Subject: Re: [PATCH 5/5] migration/multifd: Add a synchronization point for
 channel creation
Message-ID: <ZcB-O5WiZtvGiyNR@x1n>
References: <20240202191128.1901-1-farosas@suse.de>
 <20240202191128.1901-6-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240202191128.1901-6-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.361,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, Feb 02, 2024 at 04:11:28PM -0300, Fabiano Rosas wrote:
> It is possible that one of the multifd channels fails to be created at
> multifd_new_send_channel_async() while the rest of the channel
> creation tasks are still in flight.
> 
> This could lead to multifd_save_cleanup() executing the
> qemu_thread_join() loop too early and not waiting for the threads
> which haven't been created yet, leading to the freeing of resources
> that the newly created threads will try to access and crash.
> 
> Add a synchronization point after which there will be no attempts at
> thread creation and therefore calling multifd_save_cleanup() past that
> point will ensure it properly waits for the threads.
> 
> A note about performance: Prior to this patch, if a channel took too
> long to be established, other channels could finish connecting first
> and already start taking load. Now we're bounded by the
> slowest-connecting channel.

Yes, I think this should (hopefully!) be fine.

> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/multifd.c | 67 +++++++++++++++++++++++++--------------------
>  1 file changed, 37 insertions(+), 30 deletions(-)
> 
> diff --git a/migration/multifd.c b/migration/multifd.c
> index 1851206352..888ac8b05d 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -360,6 +360,11 @@ struct {
>      MultiFDPages_t *pages;
>      /* global number of generated multifd packets */
>      uint64_t packet_num;
> +    /*
> +     * Synchronization point past which no more channels will be
> +     * created.
> +     */
> +    QemuSemaphore channels_created;
>      /* send channels ready */
>      QemuSemaphore channels_ready;
>      /*
> @@ -561,6 +566,7 @@ void multifd_save_cleanup(void)
>              error_free(local_err);
>          }
>      }
> +    qemu_sem_destroy(&multifd_send_state->channels_created);
>      qemu_sem_destroy(&multifd_send_state->channels_ready);
>      g_free(multifd_send_state->params);
>      multifd_send_state->params = NULL;
> @@ -787,13 +793,6 @@ static void multifd_tls_outgoing_handshake(QIOTask *task,
>      trace_multifd_tls_outgoing_handshake_error(ioc, error_get_pretty(err));
>  
>      migrate_set_error(migrate_get_current(), err);
> -    /*
> -     * Error happen, mark multifd_send_thread status as 'quit' although it
> -     * is not created, and then tell who pay attention to me.
> -     */
> -    p->quit = true;
> -    qemu_sem_post(&multifd_send_state->channels_ready);
> -    qemu_sem_post(&p->sem_sync);
>      error_free(err);
>  }
>  
> @@ -862,39 +861,37 @@ static bool multifd_channel_connect(MultiFDSendParams *p,
>      return true;
>  }
>  
> -static void multifd_new_send_channel_cleanup(MultiFDSendParams *p,
> -                                             QIOChannel *ioc, Error *err)
> -{
> -     migrate_set_error(migrate_get_current(), err);
> -     /* Error happen, we need to tell who pay attention to me */
> -     qemu_sem_post(&multifd_send_state->channels_ready);
> -     qemu_sem_post(&p->sem_sync);
> -     /*
> -      * Although multifd_send_thread is not created, but main migration
> -      * thread need to judge whether it is running, so we need to mark
> -      * its status.
> -      */
> -     p->quit = true;
> -     object_unref(OBJECT(ioc));
> -     error_free(err);
> -}
> -
>  static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque)
>  {
>      MultiFDSendParams *p = opaque;
>      QIOChannel *ioc = QIO_CHANNEL(qio_task_get_source(task));
>      Error *local_err = NULL;
> +    bool ret;
>  
>      trace_multifd_new_send_channel_async(p->id);
> -    if (!qio_task_propagate_error(task, &local_err)) {
> -        qio_channel_set_delay(ioc, false);
> -        if (multifd_channel_connect(p, ioc, &local_err)) {
> -            return;
> -        }
> +
> +    if (qio_task_propagate_error(task, &local_err)) {
> +        ret = false;
> +        goto out;
> +    }
> +
> +    qio_channel_set_delay(ioc, false);
> +    ret = multifd_channel_connect(p, ioc, &local_err);
> +
> +out:
> +    /*
> +     * Here we're not interested whether creation succeeded, only that
> +     * it happened at all.
> +     */
> +    qemu_sem_post(&multifd_send_state->channels_created);
> +    if (ret) {
> +        return;
>      }
>  
>      trace_multifd_new_send_channel_async_error(p->id, local_err);
> -    multifd_new_send_channel_cleanup(p, ioc, local_err);
> +    migrate_set_error(migrate_get_current(), local_err);
> +    object_unref(OBJECT(ioc));
> +    error_free(local_err);
>  }
>  
>  static void multifd_new_send_channel_create(gpointer opaque)
> @@ -918,6 +915,7 @@ bool multifd_save_setup(void)
>      multifd_send_state = g_malloc0(sizeof(*multifd_send_state));
>      multifd_send_state->params = g_new0(MultiFDSendParams, thread_count);
>      multifd_send_state->pages = multifd_pages_init(page_count);
> +    qemu_sem_init(&multifd_send_state->channels_created, 0);
>      qemu_sem_init(&multifd_send_state->channels_ready, 0);
>      qatomic_set(&multifd_send_state->exiting, 0);
>      multifd_send_state->ops = multifd_ops[migrate_multifd_compression()];
> @@ -953,6 +951,15 @@ bool multifd_save_setup(void)
>          multifd_new_send_channel_create(p);
>      }
>  
> +    /*
> +     * Wait until channel creation has started for all channels. The
> +     * creation can still fail, but no more channels will be created
> +     * past this point.
> +     */

Let me double check with you here on the TLS use case.

IIUC we still can have more channels to be created if TLS is enabled: we
notify the sem as long as the handshake thread is created, then the
handshake thread can further create the tls-armed iochannel?  However I
think I get your point, and that is fine, because if that is the case, even
though this loop can complete before tls further creates the final channel,
we'll still see tls_thread_created==true and join() that tls thread first,
then further we'll join() the next multifd thread even if a new one will
pop up, or if it failed then nothing to join besides the tls thread.

I'm not sure whether Avihai has any input, I think this can be a good idea
indeed.  there's a dependency chain on the ordering if my above
undertanding is correct; we may want to document this somewhere, perhaps
right here on the chaining of threads and how we handle that?

This may not allow a concurrent migrate_cancel to respond, but I assume
this is good enough; the migrate_cancel request is indeed at least so far
something I made up, but not a request from anyone.  We can leave that for
later and fix the race / crash first.  This seems to be a complete fix from
that regard.

> +    for (i = 0; i < thread_count; i++) {
> +        qemu_sem_wait(&multifd_send_state->channels_created);
> +    }
> +
>      for (i = 0; i < thread_count; i++) {
>          MultiFDSendParams *p = &multifd_send_state->params[i];
>  
> -- 
> 2.35.3
> 

One other note is I think this will also deserve a cc: stable? But then
it'll mean all patch 3/4 will also need to copy stable to make Michael's
life easier.

Let's also copy Dan when repost; after all he more or less owns the TLS
part.

Thanks!

-- 
Peter Xu


