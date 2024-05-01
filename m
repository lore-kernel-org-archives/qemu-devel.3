Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 316AFC4345F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 19:19:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2FTN-0004rJ-HI; Wed, 01 May 2024 15:18:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s2FTL-0004r4-O9
 for qemu-devel@nongnu.org; Wed, 01 May 2024 15:18:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s2FTJ-0003j0-K0
 for qemu-devel@nongnu.org; Wed, 01 May 2024 15:18:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714591108;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ocCnkkVxMdH4nNKOZS1jgM51CrXMp7dMo6yrBg1vse0=;
 b=iBLYVqvIJJfC8oVobTn8Ap+mM5EH9mhhyT41O9Hmk2YaRgfYQA0B5zubV5A/CWyF9eicV2
 JJLeDo2sM44YWpyDmxRsaseVXK7VJUldHWl7sDbar5X0j0SKNYcemibOk0yklZiLkpDu36
 kF/eyKBgXwsuE6aQqBMtir63PAyDg7g=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-ZmPZdlLZP-evouh4FmNk4g-1; Wed, 01 May 2024 15:18:25 -0400
X-MC-Unique: ZmPZdlLZP-evouh4FmNk4g-1
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-3c82cfb8913so1642576b6e.2
 for <qemu-devel@nongnu.org>; Wed, 01 May 2024 12:18:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714591104; x=1715195904;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ocCnkkVxMdH4nNKOZS1jgM51CrXMp7dMo6yrBg1vse0=;
 b=uYMz6PHAggKhu06sQxip95Amqdrk7v0CJHQYZDrvAGocXALnB5N56wkswqpmPv16i6
 kjjy3Yy88bEsXA4bqofjpvQiCp7GforkrXWGntFCgMcjr3C8NkRGYkFH2Z0snUbuYNKe
 HR8YM2OBxdaRLfvOH1gokI0uoQ6wKJxdt7XCYZXnfrSZWGs52D3NR5uLACGMzTEQkKeS
 lf7PMu/eXT0VNN/nHA8WoKEoj/brvVeRbSxJ06OdZfVJTkCNMTwK1NdL24kTevH8RcIa
 mUB3ICyshHfryoTULaIE7giqKrjVZoZ38crJ7q2+b4kPmlZmyGSBJsgKPp8VzIq2J3OI
 hjMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU60nFMInz9bIUIqKSJ5i/AHCUWXJTC1oW/RprnLvKCChZL9u3uRRcH6xrD+eidW0q0REgnwTCmKr724ho4olUd/EqWPgg=
X-Gm-Message-State: AOJu0YwhaYFmbPtanq1FBWoCarsg6ddOEGMkXV/g1Jq4jy13Intmpd0M
 QU7n/M55fsq8GJjBw2sLCsWUBchitjnXFCLaI9nXjSILPlkAUi46eaF7YoK8TH/Nn9qAh0d7eFh
 IescsZThJRB0pVAu/5a7SAUiOCdtWrCfOZLu52mlnLnQpQnkw3f9G
X-Received: by 2002:a05:6359:6107:b0:18b:3814:bf4 with SMTP id
 rz7-20020a056359610700b0018b38140bf4mr3167985rwb.3.1714591104192; 
 Wed, 01 May 2024 12:18:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOsYtCPKFZH6nOfEVHQKobghFGwHJJ+CgwR6EH8jvs1xumjgYJDbfNnBr7dimgOeyM4WWEVg==
X-Received: by 2002:a05:6359:6107:b0:18b:3814:bf4 with SMTP id
 rz7-20020a056359610700b0018b38140bf4mr3167954rwb.3.1714591103450; 
 Wed, 01 May 2024 12:18:23 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 q5-20020ad44025000000b006a0cbed1bf9sm3274099qvp.7.2024.05.01.12.18.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 12:18:23 -0700 (PDT)
Date: Wed, 1 May 2024 15:18:21 -0400
From: Peter Xu <peterx@redhat.com>
To: Hao Xiang <hao.xiang@linux.dev>
Cc: marcandre.lureau@redhat.com, farosas@suse.de, armbru@redhat.com,
 lvivier@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 09/14] migration/multifd: Prepare to introduce DSA
 acceleration on the multifd path.
Message-ID: <ZjKVfTkQPiUHEFEI@x1n>
References: <20240425022117.4035031-1-hao.xiang@linux.dev>
 <20240425022117.4035031-10-hao.xiang@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240425022117.4035031-10-hao.xiang@linux.dev>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Apr 25, 2024 at 02:21:12AM +0000, Hao Xiang wrote:
> 1. Refactor multifd_send_thread function.
> 2. Introduce the batch task structure in MultiFDSendParams.
> 
> Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
> ---
>  include/qemu/dsa.h  | 51 +++++++++++++++++++++++++++++++++++++++++++--
>  migration/multifd.c |  5 +++++
>  migration/multifd.h |  2 ++
>  util/dsa.c          | 51 ++++++++++++++++++++++++++++++++++++++-------
>  4 files changed, 99 insertions(+), 10 deletions(-)
> 
> diff --git a/include/qemu/dsa.h b/include/qemu/dsa.h
> index e002652879..0c36e93016 100644
> --- a/include/qemu/dsa.h
> +++ b/include/qemu/dsa.h
> @@ -2,6 +2,7 @@
>  #define QEMU_DSA_H
>  
>  #include "qemu/error-report.h"
> +#include "exec/cpu-common.h"
>  #include "qemu/thread.h"
>  #include "qemu/queue.h"
>  
> @@ -42,6 +43,21 @@ typedef struct dsa_batch_task {
>      QSIMPLEQ_ENTRY(dsa_batch_task) entry;
>  } dsa_batch_task;
>  
> +#endif
> +
> +struct batch_task {
> +#ifdef CONFIG_DSA_OPT
> +    /* Address of each pages in pages */
> +    ram_addr_t *addr;
> +    /* Zero page checking results */
> +    bool *results;
> +    /* Batch task DSA specific implementation */
> +    struct dsa_batch_task *dsa_batch;
> +#endif
> +};
> +
> +#ifdef CONFIG_DSA_OPT
> +
>  /**
>   * @brief Initializes DSA devices.
>   *
> @@ -74,7 +90,7 @@ void dsa_cleanup(void);
>  bool dsa_is_running(void);
>  
>  /**
> - * @brief Initializes a buffer zero batch task.
> + * @brief Initializes a buffer zero DSA batch task.
>   *
>   * @param task A pointer to the batch task to initialize.
>   * @param results A pointer to an array of zero page checking results.
> @@ -102,9 +118,26 @@ void buffer_zero_batch_task_destroy(struct dsa_batch_task *task);
>   * @return Zero if successful, otherwise non-zero.
>   */
>  int
> -buffer_is_zero_dsa_batch_async(struct dsa_batch_task *batch_task,
> +buffer_is_zero_dsa_batch_async(struct batch_task *batch_task,
>                                 const void **buf, size_t count, size_t len);
>  
> +/**
> + * @brief Initializes a general buffer zero batch task.
> + *
> + * @param batch_size The number of zero page checking tasks in the batch.
> + * @return A pointer to the general batch task initialized.
> + */
> +struct batch_task *
> +batch_task_init(int batch_size);
> +
> +/**
> + * @brief Destroys a general buffer zero batch task.
> + *
> + * @param task A pointer to the general batch task to destroy.
> + */
> +void
> +batch_task_destroy(struct batch_task *task);
> +
>  #else
>  
>  static inline bool dsa_is_running(void)
> @@ -128,6 +161,20 @@ static inline void dsa_stop(void) {}
>  
>  static inline void dsa_cleanup(void) {}
>  
> +static inline int
> +buffer_is_zero_dsa_batch_async(struct batch_task *batch_task,
> +                               const void **buf, size_t count, size_t len)
> +{
> +    exit(1);
> +}
> +
> +static inline struct batch_task *batch_task_init(int batch_size)
> +{
> +    return NULL;
> +}
> +
> +static inline void batch_task_destroy(struct batch_task *task) {}

I feel like there're too many things exported for DSA.

For example, at least buffer_is_zero_dsa_batch_async() looks like not
needed to be exported, maybe what should be exported is
zero_page_detect_dsa()?

We also should avoid accessing dsa internal fields in multifd*.c generic
code, for example, I think we should avoid things like below:

MultiFDSendParams:
    struct batch_task *batch_task;

multifd_send_setup:

    if (dsa_init(dsa_parameter)) {
        error_setg(&local_err, "multifd: Sender failed to initialize DSA.");
        error_report_err(local_err);
        return false;
    }

    dsa_start();

    ...

    for (each_thread)
        p->batch_task = batch_task_init(page_count);

This is way too ugly...

We should have one multifd_dsa_send_setup() and call it once and for all,
internally you can do whatever you want, rewalk the thread pool and init
states.

The name "batch_task" isn't clear either on being consumed by DSA.  I'd
think something like "dsa_state" better.

So instead of above like:

struct batch_task {
#ifdef CONFIG_DSA_OPT
    /* Address of each pages in pages */
    ram_addr_t *addr;
    /* Zero page checking results */
    bool *results;
    /* Batch task DSA specific implementation */
    struct dsa_batch_task *dsa_batch;
#endif
};

The fields should always be defined (say, dsa_state), then:

struct dsa_state {
    /* Address of each pages in pages */
    ram_addr_t *addr;
    /* Zero page checking results */
    bool *results;
    /* Batch task DSA specific implementation */
    struct dsa_batch_task *dsa_batch;
};

MultiFDSendParams:
    ...
#ifdef CONFIG_DSA_OPT
    struct dsa_state *dsa_state;
#endif

> +
>  #endif
>  
>  #endif
> diff --git a/migration/multifd.c b/migration/multifd.c
> index f317bff077..cfd3a92f6c 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -13,6 +13,8 @@
>  #include "qemu/osdep.h"
>  #include "qemu/cutils.h"
>  #include "qemu/rcu.h"
> +#include "qemu/dsa.h"
> +#include "qemu/memalign.h"
>  #include "exec/target_page.h"
>  #include "sysemu/sysemu.h"
>  #include "exec/ramblock.h"
> @@ -780,6 +782,8 @@ static bool multifd_send_cleanup_channel(MultiFDSendParams *p, Error **errp)
>      p->name = NULL;
>      multifd_pages_clear(p->pages);
>      p->pages = NULL;
> +    batch_task_destroy(p->batch_task);
> +    p->batch_task = NULL;

Again, please try to export as less DSA relevant functions as possible.
Here IMHO we only need one dsa_state_destroy() on multifd_send_state, do
whatever inside.

>      p->packet_len = 0;
>      g_free(p->packet);
>      p->packet = NULL;
> @@ -1172,6 +1176,7 @@ bool multifd_send_setup(void)
>          qemu_sem_init(&p->sem_sync, 0);
>          p->id = i;
>          p->pages = multifd_pages_init(page_count);
> +        p->batch_task = batch_task_init(page_count);
>  
>          if (use_packets) {
>              p->packet_len = sizeof(MultiFDPacket_t)
> diff --git a/migration/multifd.h b/migration/multifd.h
> index c9d9b09239..16e27db5e9 100644
> --- a/migration/multifd.h
> +++ b/migration/multifd.h
> @@ -135,6 +135,8 @@ typedef struct {
>       * pending_job != 0 -> multifd_channel can use it.
>       */
>      MultiFDPages_t *pages;
> +    /* Zero page checking batch task */
> +    struct batch_task *batch_task;
>  
>      /* thread local variables. No locking required */
>  
> diff --git a/util/dsa.c b/util/dsa.c
> index 5a2bf33651..4f695e58af 100644
> --- a/util/dsa.c
> +++ b/util/dsa.c
> @@ -802,7 +802,7 @@ buffer_zero_task_init_int(struct dsa_hw_desc *descriptor,
>  }
>  
>  /**
> - * @brief Initializes a buffer zero batch task.
> + * @brief Initializes a buffer zero DSA batch task.
>   *
>   * @param task A pointer to the batch task to initialize.
>   * @param results A pointer to an array of zero page checking results.
> @@ -1107,29 +1107,64 @@ void dsa_cleanup(void)
>   * @return Zero if successful, otherwise non-zero.
>   */
>  int
> -buffer_is_zero_dsa_batch_async(struct dsa_batch_task *batch_task,
> +buffer_is_zero_dsa_batch_async(struct batch_task *batch_task,
>                                 const void **buf, size_t count, size_t len)
>  {
> -    if (count <= 0 || count > batch_task->batch_size) {
> +    struct dsa_batch_task *dsa_batch = batch_task->dsa_batch;
> +
> +    if (count <= 0 || count > dsa_batch->batch_size) {
>          return -1;
>      }
>  
> -    assert(batch_task != NULL);
> +    assert(dsa_batch != NULL);
>      assert(len != 0);
>      assert(buf != NULL);
>  
>      if (count == 1) {
>          /* DSA doesn't take batch operation with only 1 task. */
> -        buffer_zero_dsa_async(batch_task, buf[0], len);
> +        buffer_zero_dsa_async(dsa_batch, buf[0], len);
>      } else {
> -        buffer_zero_dsa_batch_async(batch_task, buf, count, len);
> +        buffer_zero_dsa_batch_async(dsa_batch, buf, count, len);
>      }
>  
> -    buffer_zero_dsa_wait(batch_task);
> -    buffer_zero_cpu_fallback(batch_task);
> +    buffer_zero_dsa_wait(dsa_batch);
> +    buffer_zero_cpu_fallback(dsa_batch);
>  
>      return 0;
>  }
>  
> +/**
> + * @brief Initializes a general buffer zero batch task.
> + *
> + * @param batch_size The number of zero page checking tasks in the batch.
> + * @return A pointer to the general batch task initialized.
> + */
> +struct batch_task *
> +batch_task_init(int batch_size)
> +{
> +    struct batch_task *task = g_malloc0(sizeof(struct batch_task));
> +    task->addr = g_new0(ram_addr_t, batch_size);
> +    task->results = g_new0(bool, batch_size);
> +    task->dsa_batch = qemu_memalign(64, sizeof(struct dsa_batch_task));
> +    buffer_zero_batch_task_init(task->dsa_batch, task->results, batch_size);
> +
> +    return task;
> +}
> +
> +/**
> + * @brief Destroys a general buffer zero batch task.
> + *
> + * @param task A pointer to the general batch task to destroy.
> + */
> +void
> +batch_task_destroy(struct batch_task *task)
> +{
> +    g_free(task->addr);
> +    g_free(task->results);
> +    buffer_zero_batch_task_destroy(task->dsa_batch);
> +    qemu_vfree(task->dsa_batch);
> +    g_free(task);
> +}
> +
>  #endif
>  
> -- 
> 2.30.2
> 
> 

-- 
Peter Xu


