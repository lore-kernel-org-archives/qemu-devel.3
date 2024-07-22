Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00BEAC3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 19:56:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVz83-0008Fe-S1; Mon, 22 Jul 2024 15:55:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sVz82-0008DJ-Ad
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 15:55:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sVz7z-0008PA-ST
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 15:55:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721678122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X0LPyGE72j3SD3ifOQnfTtPrPDbVPiGVFnnJfHe16f0=;
 b=TfqMgLgg5PHBPLUtbOoA+fZKODsCzFnQZ756zyCVStldlAxrqCDC3H3gqPnrijiaBU5W0Z
 gIwoKS3Qz+4HDpHk0gh7BNyYKaOkRi3mO+Jow3igMDYTjRzks/j4ACHPB4cNjME/LDcM5N
 BHTCJQrE0cV39OEMtRAkK070Xylo5jE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-T2qae29xPr6vAX8nreg2sQ-1; Mon, 22 Jul 2024 15:55:20 -0400
X-MC-Unique: T2qae29xPr6vAX8nreg2sQ-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6b798c6b850so14025596d6.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 12:55:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721678120; x=1722282920;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X0LPyGE72j3SD3ifOQnfTtPrPDbVPiGVFnnJfHe16f0=;
 b=b8knjJe21egj5ew4kGE15nAG8rgVf1EQUkzZArn+uqTiEP0etWHAwzZ7s1XG3yFLZC
 myLbyKKstKREILen5Pg6W3DSqnEbZ2LWASiCt7qIX9NluAd62REd099vvg3WF38+4m2U
 Z85NTY/WXxaYXctPHK7GGeGY0ucRfQZltFCKzvWwmsV3kklG6QMA4NMaLwVxn8U/e5Mb
 Fn+mv7QFbPvzyq37jIEb5V9JEe1ZgQtTAZLZbrNfcR8mNlU2eDZBgGeCOkbulpmbzlD7
 UImpn/+YRbK9ZvHOjeBdHU7szTJtbujcE4OEidscDAVQHEPWvA3ReoUshzemCohH1E0a
 O83Q==
X-Gm-Message-State: AOJu0YyZJr1y3O+TJplMBavy/J+Iyn14gqcJd+whSoh875HBrd8d7zgC
 8/oSfMejyojgXiMi0gbU1xNaiOD+YV1luy2g3geWryLlypBIZTCVDhX+TeUCIQvLaNob3/BbHnI
 rJdNddqzizvX/aXHzVGQn+C7Hw19L1422XF7gxp1R99dPNEnsgFqj
X-Received: by 2002:a05:6214:5f09:b0:6b5:ec9a:41ef with SMTP id
 6a1803df08f44-6b94f02af18mr63335206d6.2.1721678119823; 
 Mon, 22 Jul 2024 12:55:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+zfnB1PwQNJKw0DCSIO9oPi9vWSXET/7PgZAYuxh+QPlT+uYoxLdVb0ll2LgWmhS1QghTgg==
X-Received: by 2002:a05:6214:5f09:b0:6b5:ec9a:41ef with SMTP id
 6a1803df08f44-6b94f02af18mr63335056d6.2.1721678119312; 
 Mon, 22 Jul 2024 12:55:19 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b7ac7f15d3sm38572496d6.67.2024.07.22.12.55.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 12:55:17 -0700 (PDT)
Date: Mon, 22 Jul 2024 15:55:14 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [RFC PATCH v2 9/9] migration/multifd: Replace
 multifd_send_state->pages with client data
Message-ID: <Zp65Iqiz_rRleE_Q@x1n>
References: <20240722175914.24022-1-farosas@suse.de>
 <20240722175914.24022-10-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240722175914.24022-10-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Jul 22, 2024 at 02:59:14PM -0300, Fabiano Rosas wrote:
> Multifd currently has a simple scheduling mechanism that distributes
> work to the various channels by keeping storage space within each
> channel and an extra space that is given to the client. Each time the
> client fills the space with data and calls into multifd, that space is
> given to the next idle channel and a free storage space is taken from
> the channel and given to client for the next iteration.
> 
> This means we always need (#multifd_channels + 1) memory slots to
> operate multifd.
> 
> This is fine, except that the presence of this one extra memory slot
> doesn't allow different types of payloads to be processed at the same
> time in different channels, i.e. the data type of
> multifd_send_state->pages needs to be the same as p->pages.
> 
> For each new data type different from MultiFDPage_t that is to be
> handled, this logic would need to be duplicated by adding new fields
> to multifd_send_state, to the channels and to multifd_send_pages().
> 
> Fix this situation by moving the extra slot into the client and using
> only the generic type MultiFDSendData in the multifd core.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/multifd.c | 58 ++++++++++++++++++++++++++++-----------------
>  migration/multifd.h |  2 ++
>  migration/ram.c     |  1 +
>  3 files changed, 39 insertions(+), 22 deletions(-)
> 
> diff --git a/migration/multifd.c b/migration/multifd.c
> index 4394ca6ade..0a85951d58 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -49,7 +49,6 @@ typedef struct {
>  
>  struct {
>      MultiFDSendParams *params;
> -    MultiFDSendData *data;
>      /*
>       * Global number of generated multifd packets.
>       *
> @@ -97,6 +96,8 @@ struct {
>      MultiFDMethods *ops;
>  } *multifd_recv_state;
>  
> +/* TODO: move these to multifd-ram.c */
> +static MultiFDSendData *multifd_ram_send;
>  static size_t multifd_ram_payload_size(void)
>  {
>      uint32_t n = MULTIFD_PACKET_SIZE / qemu_target_page_size();
> @@ -118,6 +119,14 @@ static MultiFDSendData *multifd_send_data_alloc(void)
>      return g_malloc0(sizeof(MultiFDPayloadType) + max_payload_size);
>  }
>  
> +void multifd_ram_save_setup(void)
> +{
> +    uint32_t n = MULTIFD_PACKET_SIZE / qemu_target_page_size();
> +
> +    multifd_ram_send = multifd_send_data_alloc();
> +    multifd_ram_send->u.ram.allocated = n;

IIUC this line won't help, as the type is still NONE.. We may need to reset
this in multifd_pages_reset() even if it's a constant to RAM code.

Side note: looks like multifd_ram_send is leaked across the patch.

> +}
> +
>  static bool multifd_use_packets(void)
>  {
>      return !migrate_mapped_ram();
> @@ -620,7 +629,7 @@ static void multifd_send_kick_main(MultiFDSendParams *p)
>   *
>   * Returns true if succeed, false otherwise.
>   */
> -static bool multifd_send_pages(void)
> +static bool multifd_send(MultiFDSendData **send_data)
>  {
>      int i;
>      static int next_channel;
> @@ -661,11 +670,16 @@ static bool multifd_send_pages(void)
>       */
>      smp_mb_acquire();
>  
> -    assert(!p->data->u.ram.num);
> +    assert(multifd_payload_empty(p->data));
>  
> -    tmp = multifd_send_state->data;
> -    multifd_send_state->data = p->data;
> +    /*
> +     * Swap the pointers. The channel gets the client data for
> +     * transferring and the client gets back an unused data slot.
> +     */
> +    tmp = *send_data;
> +    *send_data = p->data;
>      p->data = tmp;
> +
>      /*
>       * Making sure p->data is setup before marking pending_job=true. Pairs
>       * with the qatomic_load_acquire() in multifd_send_thread().
> @@ -697,7 +711,12 @@ bool multifd_queue_page(RAMBlock *block, ram_addr_t offset)
>      MultiFDPages_t *pages;
>  
>  retry:
> -    pages = &multifd_send_state->data->u.ram;
> +    pages = &multifd_ram_send->u.ram;
> +
> +    if (multifd_payload_empty(multifd_ram_send)) {
> +        multifd_pages_reset(pages);
> +        multifd_set_payload_type(multifd_ram_send, MULTIFD_PAYLOAD_RAM);
> +    }
>  
>      /* If the queue is empty, we can already enqueue now */
>      if (multifd_queue_empty(pages)) {
> @@ -715,7 +734,7 @@ retry:
>       * After flush, always retry.
>       */
>      if (pages->block != block || multifd_queue_full(pages)) {
> -        if (!multifd_send_pages()) {
> +        if (!multifd_send(&multifd_ram_send)) {
>              return false;
>          }
>          goto retry;
> @@ -833,6 +852,8 @@ static bool multifd_send_cleanup_channel(MultiFDSendParams *p, Error **errp)
>      g_free(p->packet);
>      p->packet = NULL;
>      multifd_send_state->ops->send_cleanup(p, errp);
> +    g_free(p->data);
> +    p->data = NULL;

These two lines look superfluous.

>  
>      return *errp == NULL;
>  }
> @@ -845,8 +866,6 @@ static void multifd_send_cleanup_state(void)
>      qemu_sem_destroy(&multifd_send_state->channels_ready);
>      g_free(multifd_send_state->params);
>      multifd_send_state->params = NULL;
> -    g_free(multifd_send_state->data);
> -    multifd_send_state->data = NULL;
>      g_free(multifd_send_state);
>      multifd_send_state = NULL;
>  }
> @@ -895,15 +914,14 @@ int multifd_send_sync_main(void)
>  {
>      int i;
>      bool flush_zero_copy;
> -    MultiFDPages_t *pages;
>  
>      if (!migrate_multifd()) {
>          return 0;
>      }
> -    pages = &multifd_send_state->data->u.ram;
> -    if (pages->num) {
> -        if (!multifd_send_pages()) {
> -            error_report("%s: multifd_send_pages fail", __func__);
> +
> +    if (!multifd_payload_empty(multifd_ram_send)) {
> +        if (!multifd_send(&multifd_ram_send)) {
> +            error_report("%s: multifd_send fail", __func__);
>              return -1;
>          }
>      }
> @@ -977,13 +995,11 @@ static void *multifd_send_thread(void *opaque)
>  
>          /*
>           * Read pending_job flag before p->data.  Pairs with the
> -         * qatomic_store_release() in multifd_send_pages().
> +         * qatomic_store_release() in multifd_send().
>           */
>          if (qatomic_load_acquire(&p->pending_job)) {
> -            MultiFDPages_t *pages = &p->data->u.ram;
> -
>              p->iovs_num = 0;
> -            assert(pages->num);
> +            assert(!multifd_payload_empty(p->data));
>  
>              ret = multifd_send_state->ops->send_prepare(p, &local_err);
>              if (ret != 0) {
> @@ -1006,13 +1022,13 @@ static void *multifd_send_thread(void *opaque)
>              stat64_add(&mig_stats.multifd_bytes,
>                         p->next_packet_size + p->packet_len);
>  
> -            multifd_pages_reset(pages);
>              p->next_packet_size = 0;
> +            multifd_set_payload_type(p->data, MULTIFD_PAYLOAD_NONE);
>  
>              /*
>               * Making sure p->data is published before saying "we're
>               * free".  Pairs with the smp_mb_acquire() in
> -             * multifd_send_pages().
> +             * multifd_send().
>               */
>              qatomic_store_release(&p->pending_job, false);
>          } else {
> @@ -1206,8 +1222,6 @@ bool multifd_send_setup(void)
>      thread_count = migrate_multifd_channels();
>      multifd_send_state = g_malloc0(sizeof(*multifd_send_state));
>      multifd_send_state->params = g_new0(MultiFDSendParams, thread_count);
> -    multifd_send_state->data = multifd_send_data_alloc();
> -    multifd_send_state->data->u.ram.allocated = page_count;
>      qemu_sem_init(&multifd_send_state->channels_created, 0);
>      qemu_sem_init(&multifd_send_state->channels_ready, 0);
>      qatomic_set(&multifd_send_state->exiting, 0);
> diff --git a/migration/multifd.h b/migration/multifd.h
> index c9c01579a0..04c000f435 100644
> --- a/migration/multifd.h
> +++ b/migration/multifd.h
> @@ -113,6 +113,8 @@ static inline void multifd_set_payload_type(MultiFDSendData *data,
>      data->type = type;
>  }
>  
> +void multifd_ram_save_setup(void);
> +
>  typedef struct {
>      /* Fields are only written at creating/deletion time */
>      /* No lock required for them, they are read only */
> diff --git a/migration/ram.c b/migration/ram.c
> index edec1a2d07..2b90396b3c 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -3058,6 +3058,7 @@ static int ram_save_setup(QEMUFile *f, void *opaque, Error **errp)
>      migration_ops = g_malloc0(sizeof(MigrationOps));
>  
>      if (migrate_multifd()) {
> +        multifd_ram_save_setup();
>          migration_ops->ram_save_target_page = ram_save_target_page_multifd;
>      } else {
>          migration_ops->ram_save_target_page = ram_save_target_page_legacy;
> -- 
> 2.35.3
> 

-- 
Peter Xu


