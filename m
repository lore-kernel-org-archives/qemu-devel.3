Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35FA8C4345F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 19:26:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2FaJ-000882-P1; Wed, 01 May 2024 15:25:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s2FaE-00085M-JZ
 for qemu-devel@nongnu.org; Wed, 01 May 2024 15:25:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s2Fa8-00051u-U8
 for qemu-devel@nongnu.org; Wed, 01 May 2024 15:25:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714591531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/VtbExoasvasjJgxdXvmdISgaxetmeXMZBDigZgB0/Y=;
 b=SXDIp5sWCLbxwupkmau49DoEN+WVNCr49TemKe2frNdgQwhZXoSQbkZk94IEShX2AxobHX
 MYNx6Ddj8U0JzJKOqcwwlrxteEs1maHFKLeHzpFzcSk5A3i9UWiOwhV+56+k5lRbus2Vfy
 XsnRyVDKYVP5jLnMHEAodohVTg1/CZ0=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-CQUkb7ZTNQO04Sq_j8c3Tw-1; Wed, 01 May 2024 15:25:30 -0400
X-MC-Unique: CQUkb7ZTNQO04Sq_j8c3Tw-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-436e2928e01so4007741cf.0
 for <qemu-devel@nongnu.org>; Wed, 01 May 2024 12:25:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714591529; x=1715196329;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/VtbExoasvasjJgxdXvmdISgaxetmeXMZBDigZgB0/Y=;
 b=gG4+bc4gTyvtfNBLXWso/sNzzvZNZwdbQXQZAMGmyYZ8FjNgJEQXX3f4617iYdYk5e
 jfZOdctjTOdkTg08o1HIFsZOTceZnivNSvTA5sQ3Ukpx5hQJkbVJLepgzGEeRzpfDUp9
 as0lbQQiNGX/rDKxEGxxIOpPuBrwtdcuEjIXntDQvo6LA/RLcyegu4K0bH/M3RuYl8F8
 Ns2OLvAuPYTAnz4YGUdbkdfDWSEIdUjpV3RRcwdpd60Fhzy/AJXzsLbWhyqmSqyXf+xA
 6K4Xw60hAQMA0aP3wPkBg59r+07w4AdE++0nl6angVtEBIHwBNsU+0A8DeA5JGHv0Ls7
 y7dg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVufnjoVREnyzH1cICJV3sodv+5JBNlqpZNlGqZpN5HMioth6PbTEdepuf6QhEutUvEyocvssCpMwONj2q+buXxqCIRszM=
X-Gm-Message-State: AOJu0Yzah2/FOYBHoWIN9Aik6O7B0KhvCBaCtXjBLqeOelABPjC1eM10
 Ip6UrfBZ2jPVpC2kudf5UENl5nscKGf5qpAycGpENhULaVqD+eL2RTeGR8JsetaKj9IuGBXYilm
 yj083Gh+zBdytspFLWGzWPqSzyKthfPbvk2Yfdga4wO0zYXqNlYdA
X-Received: by 2002:a05:622a:188f:b0:439:9377:3aed with SMTP id
 v15-20020a05622a188f00b0043993773aedmr3500194qtc.3.1714591528908; 
 Wed, 01 May 2024 12:25:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFry3+QxHMzVZTaLGgmtpYSyBoqDtXibK249VZ/5Z2+Gl3dhW33sTRmtVID19D/qQWli/oNvg==
X-Received: by 2002:a05:622a:188f:b0:439:9377:3aed with SMTP id
 v15-20020a05622a188f00b0043993773aedmr3500161qtc.3.1714591528250; 
 Wed, 01 May 2024 12:25:28 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 ks15-20020ac8620f000000b0043a5edf024dsm5779489qtb.35.2024.05.01.12.25.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 12:25:27 -0700 (PDT)
Date: Wed, 1 May 2024 15:25:26 -0400
From: Peter Xu <peterx@redhat.com>
To: Hao Xiang <hao.xiang@linux.dev>
Cc: marcandre.lureau@redhat.com, farosas@suse.de, armbru@redhat.com,
 lvivier@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 10/14] migration/multifd: Enable DSA offloading in
 multifd sender path.
Message-ID: <ZjKXJr0yGdeGW-D3@x1n>
References: <20240425022117.4035031-1-hao.xiang@linux.dev>
 <20240425022117.4035031-11-hao.xiang@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240425022117.4035031-11-hao.xiang@linux.dev>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Apr 25, 2024 at 02:21:13AM +0000, Hao Xiang wrote:
> Multifd sender path gets an array of pages queued by the migration
> thread. It performs zero page checking on every page in the array.
> The pages are classfied as either a zero page or a normal page. This
> change uses Intel DSA to offload the zero page checking from CPU to
> the DSA accelerator. The sender thread submits a batch of pages to DSA
> hardware and waits for the DSA completion thread to signal for work
> completion.
> 
> Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
> ---
>  migration/multifd-zero-page.c | 99 +++++++++++++++++++++++++++++++++--
>  migration/multifd.c           | 27 +++++++++-
>  migration/multifd.h           |  1 +
>  3 files changed, 120 insertions(+), 7 deletions(-)
> 
> diff --git a/migration/multifd-zero-page.c b/migration/multifd-zero-page.c
> index e1b8370f88..4f426289e4 100644
> --- a/migration/multifd-zero-page.c
> +++ b/migration/multifd-zero-page.c
> @@ -37,25 +37,83 @@ static void swap_page_offset(ram_addr_t *pages_offset, int a, int b)
>  }
>  
>  /**
> - * multifd_send_zero_page_detect: Perform zero page detection on all pages.
> + * zero_page_detect_cpu: Perform zero page detection using CPU.
>   *
>   * Sorts normal pages before zero pages in p->pages->offset and updates
>   * p->pages->normal_num.
>   *
>   * @param p A pointer to the send params.
>   */
> -void multifd_send_zero_page_detect(MultiFDSendParams *p)
> +static void zero_page_detect_cpu(MultiFDSendParams *p)
>  {
>      MultiFDPages_t *pages = p->pages;
>      RAMBlock *rb = pages->block;
>      int i = 0;
>      int j = pages->num - 1;
>  
> -    if (!multifd_zero_page_enabled()) {
> -        pages->normal_num = pages->num;
> +    /*
> +     * Sort the page offset array by moving all normal pages to
> +     * the left and all zero pages to the right of the array.
> +     */
> +    while (i <= j) {
> +        uint64_t offset = pages->offset[i];
> +
> +        if (!buffer_is_zero(rb->host + offset, p->page_size)) {
> +            i++;
> +            continue;
> +        }
> +
> +        swap_page_offset(pages->offset, i, j);
> +        ram_release_page(rb->idstr, offset);
> +        j--;
> +    }
> +
> +    pages->normal_num = i;
> +}
> +
> +
> +#ifdef CONFIG_DSA_OPT
> +
> +static void swap_result(bool *results, int a, int b)
> +{
> +    bool temp;
> +
> +    if (a == b) {
>          return;
>      }
>  
> +    temp = results[a];
> +    results[a] = results[b];
> +    results[b] = temp;
> +}
> +
> +/**
> + * zero_page_detect_dsa: Perform zero page detection using
> + * Intel Data Streaming Accelerator (DSA).
> + *
> + * Sorts normal pages before zero pages in p->pages->offset and updates
> + * p->pages->normal_num.
> + *
> + * @param p A pointer to the send params.
> + */
> +static void zero_page_detect_dsa(MultiFDSendParams *p)
> +{
> +    MultiFDPages_t *pages = p->pages;
> +    RAMBlock *rb = pages->block;
> +    bool *results = p->batch_task->results;
> +
> +    for (int i = 0; i < p->pages->num; i++) {
> +        p->batch_task->addr[i] = (ram_addr_t)(rb->host + p->pages->offset[i]);
> +    }
> +
> +    buffer_is_zero_dsa_batch_async(p->batch_task,
> +                                   (const void **)p->batch_task->addr,
> +                                   p->pages->num,
> +                                   p->page_size);
> +
> +    int i = 0;
> +    int j = pages->num - 1;
> +
>      /*
>       * Sort the page offset array by moving all normal pages to
>       * the left and all zero pages to the right of the array.
> @@ -63,11 +121,12 @@ void multifd_send_zero_page_detect(MultiFDSendParams *p)
>      while (i <= j) {
>          uint64_t offset = pages->offset[i];
>  
> -        if (!buffer_is_zero(rb->host + offset, p->page_size)) {
> +        if (!results[i]) {
>              i++;
>              continue;
>          }
>  
> +        swap_result(results, i, j);
>          swap_page_offset(pages->offset, i, j);
>          ram_release_page(rb->idstr, offset);
>          j--;
> @@ -76,6 +135,15 @@ void multifd_send_zero_page_detect(MultiFDSendParams *p)
>      pages->normal_num = i;
>  }
>  
> +#else
> +
> +static void zero_page_detect_dsa(MultiFDSendParams *p)
> +{
> +    exit(1);
> +}
> +
> +#endif
> +
>  void multifd_recv_zero_page_process(MultiFDRecvParams *p)
>  {
>      for (int i = 0; i < p->zero_num; i++) {
> @@ -87,3 +155,24 @@ void multifd_recv_zero_page_process(MultiFDRecvParams *p)
>          }
>      }
>  }
> +
> +/**
> + * multifd_send_zero_page_detect: Perform zero page detection on all pages.
> + *
> + * @param p A pointer to the send params.
> + */
> +void multifd_send_zero_page_detect(MultiFDSendParams *p)
> +{
> +    MultiFDPages_t *pages = p->pages;
> +
> +    if (!multifd_zero_page_enabled()) {
> +        pages->normal_num = pages->num;
> +        return;
> +    }
> +
> +    if (dsa_is_running()) {
> +        zero_page_detect_dsa(p);
> +    } else {
> +        zero_page_detect_cpu(p);
> +    }
> +}
> diff --git a/migration/multifd.c b/migration/multifd.c
> index cfd3a92f6c..7316643d0a 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -818,6 +818,8 @@ void multifd_send_shutdown(void)
>  
>      multifd_send_terminate_threads();
>  
> +    dsa_cleanup();
> +
>      for (i = 0; i < migrate_multifd_channels(); i++) {
>          MultiFDSendParams *p = &multifd_send_state->params[i];
>          Error *local_err = NULL;
> @@ -1155,11 +1157,20 @@ bool multifd_send_setup(void)
>      uint32_t page_count = MULTIFD_PACKET_SIZE / qemu_target_page_size();
>      bool use_packets = multifd_use_packets();
>      uint8_t i;
> +    const char *dsa_parameter = migrate_multifd_dsa_accel();
>  
>      if (!migrate_multifd()) {
>          return true;
>      }
>  
> +    if (dsa_init(dsa_parameter)) {
> +        error_setg(&local_err, "multifd: Sender failed to initialize DSA.");
> +        error_report_err(local_err);
> +        return false;
> +    }
> +
> +    dsa_start();

Commented on this in another reply, let's condense them into a single dsa
call.  That call should also be nested into a flag to know at least dsa is
enabled:

  if (multifd_dsa_enabled()) {
     multifd_dsa_init();
  }

Multifd used to have some legacy code where it randomly call multifd_*
functions directly in generic migration code.  Not a good example to
follow there..

Also, I'd think it better if we don't introduce global vars for dsa, it
should be put under multifd_send_state (or recv_state).  So anything like
dsa_start() should always take that pointer first.

> +
>      thread_count = migrate_multifd_channels();
>      multifd_send_state = g_malloc0(sizeof(*multifd_send_state));
>      multifd_send_state->params = g_new0(MultiFDSendParams, thread_count);
> @@ -1393,6 +1404,7 @@ void multifd_recv_cleanup(void)
>              qemu_thread_join(&p->thread);
>          }
>      }
> +    dsa_cleanup();

Same here.

>      for (i = 0; i < migrate_multifd_channels(); i++) {
>          multifd_recv_cleanup_channel(&multifd_recv_state->params[i]);
>      }
> @@ -1568,6 +1580,9 @@ int multifd_recv_setup(Error **errp)
>      uint32_t page_count = MULTIFD_PACKET_SIZE / qemu_target_page_size();
>      bool use_packets = multifd_use_packets();
>      uint8_t i;
> +    const char *dsa_parameter = migrate_multifd_dsa_accel();
> +    int ret;
> +    Error *local_err = NULL;
>  
>      /*
>       * Return successfully if multiFD recv state is already initialised
> @@ -1577,6 +1592,15 @@ int multifd_recv_setup(Error **errp)
>          return 0;
>      }
>  
> +    ret = dsa_init(dsa_parameter);
> +    if (ret != 0) {
> +        error_setg(&local_err, "multifd: Receiver failed to initialize DSA.");
> +        error_propagate(errp, local_err);
> +        return ret;
> +    }
> +
> +    dsa_start();

Same here.

in the dsa case, it'll be even better if you can find a way to unify
send/recv, as IIUC they do work similarly, setup() some dsa stuff, do some
zero page detection, cleanup() some dsa stuff.  They look all the same
irrelevant of src/dst.  I think it's nice if we can merge them.

> +
>      thread_count = migrate_multifd_channels();
>      multifd_recv_state = g_malloc0(sizeof(*multifd_recv_state));
>      multifd_recv_state->params = g_new0(MultiFDRecvParams, thread_count);
> @@ -1616,13 +1640,12 @@ int multifd_recv_setup(Error **errp)
>  
>      for (i = 0; i < thread_count; i++) {
>          MultiFDRecvParams *p = &multifd_recv_state->params[i];
> -        int ret;
> -
>          ret = multifd_recv_state->ops->recv_setup(p, errp);
>          if (ret) {
>              return ret;
>          }
>      }
> +
>      return 0;
>  }
>  
> diff --git a/migration/multifd.h b/migration/multifd.h
> index 16e27db5e9..b3717fae24 100644
> --- a/migration/multifd.h
> +++ b/migration/multifd.h
> @@ -14,6 +14,7 @@
>  #define QEMU_MIGRATION_MULTIFD_H
>  
>  #include "ram.h"
> +#include "qemu/dsa.h"
>  
>  typedef struct MultiFDRecvData MultiFDRecvData;
>  
> -- 
> 2.30.2
> 
> 

-- 
Peter Xu


