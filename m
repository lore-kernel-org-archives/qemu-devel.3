Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E65DF364A7
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 17:11:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAsuK-0002dq-U8; Thu, 09 Apr 2026 13:11:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1wAsuJ-0002dh-TL
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 13:11:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1wAsuH-0007m2-0O
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 13:11:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775754664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+h7jpKdhCTn6mHuXqflXQE1DgwiNoIkqxn9rj7Bxf10=;
 b=C6vQT26l69FwHvfZaq0JNwF76HwwkoXtlTRl/kGy9GR2ghI8c7PF2VnApwPAFh0KVZwa0j
 nfAFa7OU6noFD87qILhshpKjppSDeebSrisdusHzYOUMug/NQu3AL9srROMGAiEJ/kHKID
 GFu7phHnH+YH1ff2VlUTyHOMOsD4qwI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-NJckk-rWOamcIv9Z1w1cWg-1; Thu, 09 Apr 2026 13:11:02 -0400
X-MC-Unique: NJckk-rWOamcIv9Z1w1cWg-1
X-Mimecast-MFC-AGG-ID: NJckk-rWOamcIv9Z1w1cWg_1775754661
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-488c2764f83so9818735e9.2
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 10:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775754661; x=1776359461; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+h7jpKdhCTn6mHuXqflXQE1DgwiNoIkqxn9rj7Bxf10=;
 b=qlok91z1Ky+YeKFA2jO/KwQ4ChdKSiFvjOZQXZK2o4D+RZouPdXV7U7PvmnvlrVdPr
 bx8Fm2AZgWiIkjNK8f+WFd45QV8fyyQF+1leT78w9A7cqpGEDB9gUIKN1afmIXHNpEBS
 A/EkIc9ZX7n23413Fxu/w48fcFT9v21Co9/8Ufj1jGObScYypXe26da2JJ8CWw+7t/Tu
 2XH7MaoM/znR189Kmo2lzfvFSvAuN078JzRAmbfR8dpI55NiijD4vZtyJiF9c8KL0yR8
 EwIzdpzeb5yp7UUqzl/k+FckSrLjy+wgxuXh12lgfMzWY/0Eyfodf/r2v6cYCFTemPjS
 79ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775754661; x=1776359461;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+h7jpKdhCTn6mHuXqflXQE1DgwiNoIkqxn9rj7Bxf10=;
 b=NLwHcXNhuCogAF/uaK0+7ESnEOCXafAgNE3S8zZ2IaWah14PQueEDt/JI4zzydTL0p
 yWJwp/5fkyhUiPEfzCigi8UobXHgQsnlDvwHXkV7J8ECy1Vr7lEKuNaZWrxfcI5suKkO
 j2jN1TnuApEsRf9uBSTHb694mUFpyixa3DDPCqKb80l3tTMS7Qw1d0T6Ia2OnP22tvg2
 qg1uRRhAoRub0OJr7Nf9S/H41IU1Mn8u5ZHkAOawyighscrkOou4nYOTxubuRrrsXLGM
 8Ggdfms8aFg1pz5MoFGlpr+55E6dogkPyqhnoqCyJmZy98l/NvuLiEDGCCu6yGKsXwAP
 cj0w==
X-Gm-Message-State: AOJu0YxGd1tZXb7ZlYuZ/S11yFoQ2dPDF+tA7JJIXxOLmhxXX/NfhCqi
 CTinDm1L2t/qM5H8psNF2sy2Xog1sAGhSfo/tMGZh512hRgON2kWly3CxydIE76uQoc/5OaxauP
 p1zHgXbuoLeAizbeXBU/AOVUAAjBxQ+yFy5ggnLRn5Uw93tYGcvKEFKRWaL1wR47OVqs=
X-Gm-Gg: AeBDieswUQ3FEABYlDqzn2ZfHWlvFGos5o1cC4oweuLF1H7wPb0PKZ60Bo2nblpvVZd
 3nFnxvjLOgn12MHUebW9OfqGM43/q4v2/9MCqRG3Te3PCEqp2TK7Bj/ETViWv+Oa7m5JAdZswU+
 WGpPCucWMn/f5DP+AMy+6mIQxmRlkIwjr0/GBAUru0zlLPM8A1gMCvbwSWraJmsqhuSsa2zYaj+
 h5xFXWAXsCABYBT+0AbDUmjg5etuwJ4e5syLmhReqAv0SPO1HLg6s9bnnToEzUC4bAUQMX0BAu6
 vh/nkZgoHU+HU+wStobzGkl3qUOSXhq3T7QQ08YmgwJarpOY/R6+RmmEHbhZSnD73mdYnrYw64K
 anUT874oY/PaQ0K18kDeUyjs23YQoroBQ2f1h9DA=
X-Received: by 2002:a05:600c:4688:b0:488:b187:d8ed with SMTP id
 5b1f17b1804b1-488b187e4admr221060505e9.2.1775754660505; 
 Thu, 09 Apr 2026 10:11:00 -0700 (PDT)
X-Received: by 2002:a05:600c:4688:b0:488:b187:d8ed with SMTP id
 5b1f17b1804b1-488b187e4admr221059775e9.2.1775754659919; 
 Thu, 09 Apr 2026 10:10:59 -0700 (PDT)
Received: from fedora (nat-88-212-17-233.antik.sk. [88.212.17.233])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d5b56d1asm4104515e9.15.2026.04.09.10.10.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 10:10:59 -0700 (PDT)
Date: Thu, 9 Apr 2026 19:10:56 +0200
From: Juraj Marcin <jmarcin@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, 
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, 
 Zhiyi Guo <zhguo@redhat.com>, Prasad Pandit <ppandit@redhat.com>, 
 Avihai Horon <avihaih@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>, 
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Joao Martins <joao.m.martins@oracle.com>, Markus Armbruster <armbru@redhat.com>,
 Alex Williamson <alex@shazbot.org>, Halil Pasic <pasic@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, 
 David Hildenbrand <david@kernel.org>, Cornelia Huck <cohuck@redhat.com>, 
 Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, 
 John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 04/14] migration/treewide: Merge
 @state_pending_{exact|estimate} APIs
Message-ID: <adfdUBTJweN-V-ZP@fedora>
References: <20260408165559.157108-1-peterx@redhat.com>
 <20260408165559.157108-5-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408165559.157108-5-peterx@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hi Peter,

On 2026-04-08 12:55, Peter Xu wrote:
> These two APIs are a slight duplication.  For example, there're a few users
> that directly pass in the same function.
> 
> It might also be error prone to provide two hooks, so that it's easier to
> happen one module report different things via the two hooks.
> 
> In reality, they should always report the same thing, only about whether we
> should use a fast-path when the slow path might be too slow, as QEMU may
> query these information quite frequently during migration process.
> 
> Merge it into one API, provide a bool showing if the query is an exact
> query or not.  No functional change intended.
> 
> Export qemu_savevm_query_pending().  We should use the new API here
> provided when there're new users to do the query.  This will happen very
> soon.
> 
> Cc: Halil Pasic <pasic@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Jason Herne <jjherne@linux.ibm.com>
> Cc: Eric Farman <farman@linux.ibm.com>
> Cc: Matthew Rosato <mjrosato@linux.ibm.com>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Ilya Leoshkevich <iii@linux.ibm.com>
> Cc: David Hildenbrand <david@kernel.org>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Eric Blake <eblake@redhat.com>
> Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> Cc: John Snow <jsnow@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  docs/devel/migration/main.rst  |  9 ++----
>  docs/devel/migration/vfio.rst  |  9 ++----
>  include/migration/register.h   | 52 +++++++++++-----------------------
>  migration/savevm.h             |  3 ++
>  hw/s390x/s390-stattrib.c       |  9 +++---
>  hw/vfio/migration.c            | 48 ++++++++++++++-----------------
>  migration/block-dirty-bitmap.c | 10 +++----
>  migration/ram.c                | 33 +++++++--------------
>  migration/savevm.c             | 42 +++++++++++++--------------
>  hw/vfio/trace-events           |  3 +-
>  10 files changed, 84 insertions(+), 134 deletions(-)
> 
> diff --git a/docs/devel/migration/main.rst b/docs/devel/migration/main.rst
> index 234d280249..e6a6ca3681 100644
> --- a/docs/devel/migration/main.rst
> +++ b/docs/devel/migration/main.rst
> @@ -515,13 +515,8 @@ An iterative device must provide:
>    - A ``load_setup`` function that initialises the data structures on the
>      destination.
>  
> -  - A ``state_pending_exact`` function that indicates how much more
> -    data we must save.  The core migration code will use this to
> -    determine when to pause the CPUs and complete the migration.
> -
> -  - A ``state_pending_estimate`` function that indicates how much more
> -    data we must save.  When the estimated amount is smaller than the
> -    threshold, we call ``state_pending_exact``.
> +  - A ``save_query_pending`` function that indicates how much more
> +    data we must save.
>  
>    - A ``save_live_iterate`` function should send a chunk of data until
>      the point that stream bandwidth limits tell it to stop.  Each call
> diff --git a/docs/devel/migration/vfio.rst b/docs/devel/migration/vfio.rst
> index 0790e5031d..33768c877c 100644
> --- a/docs/devel/migration/vfio.rst
> +++ b/docs/devel/migration/vfio.rst
> @@ -50,13 +50,8 @@ VFIO implements the device hooks for the iterative approach as follows:
>  * A ``load_setup`` function that sets the VFIO device on the destination in
>    _RESUMING state.
>  
> -* A ``state_pending_estimate`` function that reports an estimate of the
> -  remaining pre-copy data that the vendor driver has yet to save for the VFIO
> -  device.
> -
> -* A ``state_pending_exact`` function that reads pending_bytes from the vendor
> -  driver, which indicates the amount of data that the vendor driver has yet to
> -  save for the VFIO device.
> +* A ``save_query_pending`` function that reports the remaining pre-copy
> +  data that the vendor driver has yet to save for the VFIO device.
>  
>  * An ``is_active_iterate`` function that indicates ``save_live_iterate`` is
>    active only when the VFIO device is in pre-copy states.
> diff --git a/include/migration/register.h b/include/migration/register.h
> index d0f37f5f43..aba3c9af2f 100644
> --- a/include/migration/register.h
> +++ b/include/migration/register.h
> @@ -16,6 +16,13 @@
>  
>  #include "hw/core/vmstate-if.h"
>  
> +typedef struct MigPendingData {
> +    /* Amount of pending bytes can be transferred in precopy or stopcopy */
> +    uint64_t precopy_bytes;
> +    /* Amount of pending bytes can be transferred in postcopy */
> +    uint64_t postcopy_bytes;
> +} MigPendingData;
> +
>  /**
>   * struct SaveVMHandlers: handler structure to finely control
>   * migration of complex subsystems and devices, such as RAM, block and
> @@ -197,46 +204,19 @@ typedef struct SaveVMHandlers {
>      bool (*save_postcopy_prepare)(QEMUFile *f, void *opaque, Error **errp);
>  
>      /**
> -     * @state_pending_estimate
> -     *
> -     * This estimates the remaining data to transfer
> -     *
> -     * Sum of @can_postcopy and @must_postcopy is the whole amount of
> -     * pending data.
> -     *
> -     * @opaque: data pointer passed to register_savevm_live()
> -     * @must_precopy: amount of data that must be migrated in precopy
> -     *                or in stopped state, i.e. that must be migrated
> -     *                before target start.
> -     * @can_postcopy: amount of data that can be migrated in postcopy
> -     *                or in stopped state, i.e. after target start.
> -     *                Some can also be migrated during precopy (RAM).
> -     *                Some must be migrated after source stops
> -     *                (block-dirty-bitmap)
> -     */
> -    void (*state_pending_estimate)(void *opaque, uint64_t *must_precopy,
> -                                   uint64_t *can_postcopy);
> -
> -    /**
> -     * @state_pending_exact
> -     *
> -     * This calculates the exact remaining data to transfer
> +     * @save_query_pending
>       *
> -     * Sum of @can_postcopy and @must_postcopy is the whole amount of
> -     * pending data.
> +     * This estimates the remaining data to transfer on the source side.
> +     * It's highly suggested that the module should implement both fastpath
> +     * and slowpath version of it when it can be slow (for more information
> +     * please check pending->fastpath field).

There is no pending->fastpath field anymore.

>       *
>       * @opaque: data pointer passed to register_savevm_live()
> -     * @must_precopy: amount of data that must be migrated in precopy
> -     *                or in stopped state, i.e. that must be migrated
> -     *                before target start.
> -     * @can_postcopy: amount of data that can be migrated in postcopy
> -     *                or in stopped state, i.e. after target start.
> -     *                Some can also be migrated during precopy (RAM).
> -     *                Some must be migrated after source stops
> -     *                (block-dirty-bitmap)
> +     * @pending: pointer to a MigPendingData struct
> +     * @exact: set true for an accurate (slow) query
>       */
> -    void (*state_pending_exact)(void *opaque, uint64_t *must_precopy,
> -                                uint64_t *can_postcopy);
> +    void (*save_query_pending)(void *opaque, MigPendingData *pending,
> +                               bool exact);
>  
>      /**
>       * @load_state
> diff --git a/migration/savevm.h b/migration/savevm.h
> index b3d1e8a13c..e4efd243f3 100644
> --- a/migration/savevm.h
> +++ b/migration/savevm.h
> @@ -14,6 +14,8 @@
>  #ifndef MIGRATION_SAVEVM_H
>  #define MIGRATION_SAVEVM_H
>  
> +#include "migration/register.h"
> +
>  #define QEMU_VM_FILE_MAGIC           0x5145564d
>  #define QEMU_VM_FILE_VERSION_COMPAT  0x00000002
>  #define QEMU_VM_FILE_VERSION         0x00000003
> @@ -43,6 +45,7 @@ int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy);
>  void qemu_savevm_state_cleanup(void);
>  void qemu_savevm_state_complete_postcopy(QEMUFile *f);
>  int qemu_savevm_state_complete_precopy(MigrationState *s);
> +void qemu_savevm_query_pending(MigPendingData *pending, bool exact);
>  void qemu_savevm_state_pending_exact(uint64_t *must_precopy,
>                                       uint64_t *can_postcopy);
>  void qemu_savevm_state_pending_estimate(uint64_t *must_precopy,
> diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
> index d808ece3b9..a22469a9e9 100644
> --- a/hw/s390x/s390-stattrib.c
> +++ b/hw/s390x/s390-stattrib.c
> @@ -187,15 +187,15 @@ static int cmma_save_setup(QEMUFile *f, void *opaque, Error **errp)
>      return 0;
>  }
>  
> -static void cmma_state_pending(void *opaque, uint64_t *must_precopy,
> -                               uint64_t *can_postcopy)
> +static void cmma_state_pending(void *opaque, MigPendingData *pending,
> +                               bool exact)
>  {
>      S390StAttribState *sas = S390_STATTRIB(opaque);
>      S390StAttribClass *sac = S390_STATTRIB_GET_CLASS(sas);
>      long long res = sac->get_dirtycount(sas);
>  
>      if (res >= 0) {
> -        *must_precopy += res;
> +        pending->precopy_bytes += res;
>      }
>  }
>  
> @@ -340,8 +340,7 @@ static SaveVMHandlers savevm_s390_stattrib_handlers = {
>      .save_setup = cmma_save_setup,
>      .save_live_iterate = cmma_save_iterate,
>      .save_complete = cmma_save_complete,
> -    .state_pending_exact = cmma_state_pending,
> -    .state_pending_estimate = cmma_state_pending,
> +    .save_query_pending = cmma_state_pending,
>      .save_cleanup = cmma_save_cleanup,
>      .load_state = cmma_load,
>      .is_active = cmma_active,
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 5d5fca09bd..1e999f0040 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -571,42 +571,39 @@ static void vfio_save_cleanup(void *opaque)
>      trace_vfio_save_cleanup(vbasedev->name);
>  }
>  
> -static void vfio_state_pending_estimate(void *opaque, uint64_t *must_precopy,
> -                                        uint64_t *can_postcopy)
> +static void vfio_state_pending_sync(VFIODevice *vbasedev)
>  {
> -    VFIODevice *vbasedev = opaque;
>      VFIOMigration *migration = vbasedev->migration;
>  
> -    if (!vfio_device_state_is_precopy(vbasedev)) {
> -        return;
> -    }
> -
> -    *must_precopy +=
> -        migration->precopy_init_size + migration->precopy_dirty_size;
> +    vfio_query_stop_copy_size(vbasedev);
>  
> -    trace_vfio_state_pending_estimate(vbasedev->name, *must_precopy,
> -                                      *can_postcopy,
> -                                      migration->precopy_init_size,
> -                                      migration->precopy_dirty_size);
> +    if (vfio_device_state_is_precopy(vbasedev)) {
> +        vfio_query_precopy_size(migration);
> +    }
>  }
>  
> -static void vfio_state_pending_exact(void *opaque, uint64_t *must_precopy,
> -                                     uint64_t *can_postcopy)
> +static void vfio_state_pending(void *opaque, MigPendingData *pending,
> +                               bool exact)
>  {
>      VFIODevice *vbasedev = opaque;
>      VFIOMigration *migration = vbasedev->migration;
> +    uint64_t remain;
>  
> -    vfio_query_stop_copy_size(vbasedev);
> -    *must_precopy += migration->stopcopy_size;
> -
> -    if (vfio_device_state_is_precopy(vbasedev)) {
> -        vfio_query_precopy_size(migration);
> +    if (exact) {
> +        vfio_state_pending_sync(vbasedev);
> +        remain = migration->stopcopy_size;
> +    } else {
> +        if (!vfio_device_state_is_precopy(vbasedev)) {
> +            return;
> +        }
> +        remain = migration->precopy_init_size + migration->precopy_dirty_size;
>      }
>  
> -    trace_vfio_state_pending_exact(vbasedev->name, *must_precopy, *can_postcopy,
> -                                   migration->stopcopy_size,
> -                                   migration->precopy_init_size,
> -                                   migration->precopy_dirty_size);
> +    pending->precopy_bytes += remain;
> +
> +    trace_vfio_state_pending(vbasedev->name, migration->stopcopy_size,
> +                             migration->precopy_init_size,
> +                             migration->precopy_dirty_size);
>  }
>  
>  static bool vfio_is_active_iterate(void *opaque)
> @@ -851,8 +848,7 @@ static const SaveVMHandlers savevm_vfio_handlers = {
>      .save_prepare = vfio_save_prepare,
>      .save_setup = vfio_save_setup,
>      .save_cleanup = vfio_save_cleanup,
> -    .state_pending_estimate = vfio_state_pending_estimate,
> -    .state_pending_exact = vfio_state_pending_exact,
> +    .save_query_pending = vfio_state_pending,
>      .is_active_iterate = vfio_is_active_iterate,
>      .save_live_iterate = vfio_save_iterate,
>      .save_complete = vfio_save_complete_precopy,
> diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
> index a061aad817..15d417013c 100644
> --- a/migration/block-dirty-bitmap.c
> +++ b/migration/block-dirty-bitmap.c
> @@ -766,9 +766,8 @@ static int dirty_bitmap_save_complete(QEMUFile *f, void *opaque)
>      return 0;
>  }
>  
> -static void dirty_bitmap_state_pending(void *opaque,
> -                                       uint64_t *must_precopy,
> -                                       uint64_t *can_postcopy)
> +static void dirty_bitmap_state_pending(void *opaque, MigPendingData *data,
> +                                       bool exact)
>  {
>      DBMSaveState *s = &((DBMState *)opaque)->save;
>      SaveBitmapState *dbms;
> @@ -788,7 +787,7 @@ static void dirty_bitmap_state_pending(void *opaque,
>  
>      trace_dirty_bitmap_state_pending(pending);
>  
> -    *can_postcopy += pending;
> +    data->postcopy_bytes += pending;
>  }
>  
>  /* First occurrence of this bitmap. It should be created if doesn't exist */
> @@ -1250,8 +1249,7 @@ static SaveVMHandlers savevm_dirty_bitmap_handlers = {
>      .save_setup = dirty_bitmap_save_setup,
>      .save_complete = dirty_bitmap_save_complete,
>      .has_postcopy = dirty_bitmap_has_postcopy,
> -    .state_pending_exact = dirty_bitmap_state_pending,
> -    .state_pending_estimate = dirty_bitmap_state_pending,
> +    .save_query_pending = dirty_bitmap_state_pending,
>      .save_live_iterate = dirty_bitmap_save_iterate,
>      .is_active_iterate = dirty_bitmap_is_active_iterate,
>      .load_state = dirty_bitmap_load,
> diff --git a/migration/ram.c b/migration/ram.c
> index 979751f61b..e5b7217bf5 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -3443,30 +3443,18 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
>      return qemu_fflush(f);
>  }
>  
> -static void ram_state_pending_estimate(void *opaque, uint64_t *must_precopy,
> -                                       uint64_t *can_postcopy)
> -{
> -    RAMState **temp = opaque;
> -    RAMState *rs = *temp;
> -
> -    uint64_t remaining_size = rs->migration_dirty_pages * TARGET_PAGE_SIZE;
> -
> -    if (migrate_postcopy_ram()) {
> -        /* We can do postcopy, and all the data is postcopiable */
> -        *can_postcopy += remaining_size;
> -    } else {
> -        *must_precopy += remaining_size;
> -    }
> -}
> -
> -static void ram_state_pending_exact(void *opaque, uint64_t *must_precopy,
> -                                    uint64_t *can_postcopy)
> +static void ram_state_pending(void *opaque, MigPendingData *pending,
> +                              bool exact)
>  {
>      RAMState **temp = opaque;
>      RAMState *rs = *temp;
>      uint64_t remaining_size;
>  
> -    if (!migration_in_postcopy()) {
> +    /*
> +     * Sync is not needed either with: (1) a fast query, or (2) after
> +     * postcopy has started (no new dirty will generate anymore).
> +     */
> +    if (exact && !migration_in_postcopy()) {
>          bql_lock();
>          WITH_RCU_READ_LOCK_GUARD() {
>              migration_bitmap_sync_precopy(false);
> @@ -3478,9 +3466,9 @@ static void ram_state_pending_exact(void *opaque, uint64_t *must_precopy,
>  
>      if (migrate_postcopy_ram()) {
>          /* We can do postcopy, and all the data is postcopiable */
> -        *can_postcopy += remaining_size;
> +        pending->postcopy_bytes += remaining_size;
>      } else {
> -        *must_precopy += remaining_size;
> +        pending->precopy_bytes += remaining_size;
>      }
>  }
>  
> @@ -4703,8 +4691,7 @@ static SaveVMHandlers savevm_ram_handlers = {
>      .save_live_iterate = ram_save_iterate,
>      .save_complete = ram_save_complete,
>      .has_postcopy = ram_has_postcopy,
> -    .state_pending_exact = ram_state_pending_exact,
> -    .state_pending_estimate = ram_state_pending_estimate,
> +    .save_query_pending = ram_state_pending,
>      .load_state = ram_load,
>      .save_cleanup = ram_save_cleanup,
>      .load_setup = ram_load_setup,
> diff --git a/migration/savevm.c b/migration/savevm.c
> index dd58f2a705..392d840955 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1762,46 +1762,44 @@ int qemu_savevm_state_complete_precopy(MigrationState *s)
>      return qemu_fflush(f);
>  }
>  
> -/* Give an estimate of the amount left to be transferred,
> - * the result is split into the amount for units that can and
> - * for units that can't do postcopy.
> - */
> -void qemu_savevm_state_pending_estimate(uint64_t *must_precopy,
> -                                        uint64_t *can_postcopy)
> +void qemu_savevm_query_pending(MigPendingData *pending, bool exact)
>  {
>      SaveStateEntry *se;
>  
> -    *must_precopy = 0;
> -    *can_postcopy = 0;
> +    pending->precopy_bytes = 0;
> +    pending->postcopy_bytes = 0;
>  
>      QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
> -        if (!se->ops || !se->ops->state_pending_estimate) {
> +        if (!se->ops || !se->ops->save_query_pending) {
>              continue;
>          }
>          if (!qemu_savevm_state_active(se)) {
>              continue;
>          }
> -        se->ops->state_pending_estimate(se->opaque, must_precopy, can_postcopy);
> +        se->ops->save_query_pending(se->opaque, pending, exact);
>      }
>  }
>  
> +void qemu_savevm_state_pending_estimate(uint64_t *must_precopy,
> +                                        uint64_t *can_postcopy)
> +{
> +    MigPendingData pending;
> +
> +    qemu_savevm_query_pending(&pending, false);
> +
> +    *must_precopy = pending.precopy_bytes;
> +    *can_postcopy = pending.postcopy_bytes;
> +}
> +
>  void qemu_savevm_state_pending_exact(uint64_t *must_precopy,
>                                       uint64_t *can_postcopy)
>  {
> -    SaveStateEntry *se;
> +    MigPendingData pending;
>  
> -    *must_precopy = 0;
> -    *can_postcopy = 0;
> +    qemu_savevm_query_pending(&pending, true);
>  
> -    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
> -        if (!se->ops || !se->ops->state_pending_exact) {
> -            continue;
> -        }
> -        if (!qemu_savevm_state_active(se)) {
> -            continue;
> -        }
> -        se->ops->state_pending_exact(se->opaque, must_precopy, can_postcopy);
> -    }
> +    *must_precopy = pending.precopy_bytes;
> +    *can_postcopy = pending.postcopy_bytes;
>  }
>  
>  void qemu_savevm_state_cleanup(void)
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index 846e3625c5..7cf5a9eb2d 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -173,8 +173,7 @@ vfio_save_device_config_state(const char *name) " (%s)"
>  vfio_save_iterate(const char *name, uint64_t precopy_init_size, uint64_t precopy_dirty_size) " (%s) precopy initial size %"PRIu64" precopy dirty size %"PRIu64
>  vfio_save_iterate_start(const char *name) " (%s)"
>  vfio_save_setup(const char *name, uint64_t data_buffer_size) " (%s) data buffer size %"PRIu64
> -vfio_state_pending_estimate(const char *name, uint64_t precopy, uint64_t postcopy, uint64_t precopy_init_size, uint64_t precopy_dirty_size) " (%s) precopy %"PRIu64" postcopy %"PRIu64" precopy initial size %"PRIu64" precopy dirty size %"PRIu64
> -vfio_state_pending_exact(const char *name, uint64_t precopy, uint64_t postcopy, uint64_t stopcopy_size, uint64_t precopy_init_size, uint64_t precopy_dirty_size) " (%s) precopy %"PRIu64" postcopy %"PRIu64" stopcopy size %"PRIu64" precopy initial size %"PRIu64" precopy dirty size %"PRIu64
> +vfio_state_pending(const char *name, uint64_t stopcopy_size, uint64_t precopy_init_size, uint64_t precopy_dirty_size) " (%s) stopcopy size %"PRIu64" precopy initial size %"PRIu64" precopy dirty size %"PRIu64
>  vfio_vmstate_change(const char *name, int running, const char *reason, const char *dev_state) " (%s) running %d reason %s device state %s"
>  vfio_vmstate_change_prepare(const char *name, int running, const char *reason, const char *dev_state) " (%s) running %d reason %s device state %s"
>  
> -- 
> 2.53.0
> 

Apart from that one comment above, it looks good to me!

Reviewed-by: Juraj Marcin <jmarcin@redhat.com>


