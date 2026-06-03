Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92C07CD6E57
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 20:09:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUrqn-0000TN-1t; Wed, 03 Jun 2026 16:06:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wUrql-0000RC-Dq
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 16:06:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wUrqg-0005bK-HE
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 16:06:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780517155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y4stfI5CPH87Zgbm+s0lXLbs4AKKrkHuKxtVPhtVOX4=;
 b=Nh3qN/Ha6RwK4+gQ9lWrB+6MLMkg2qjKjn6S3AfTUEkkDV8F376do8/rGlMijk2kr+TbW1
 oRhkYRiWrr8L8OnUbcZR9XOzTuId/Zrvj6Ivup6jI84DIWqrF+aK0BBUUfQm4wCOJXeNP8
 SRVuX4QHDqR7bDUa66iixugJQlN3UX0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-969KsANCMv6nUVAkANTNlQ-1; Wed, 03 Jun 2026 16:05:53 -0400
X-MC-Unique: 969KsANCMv6nUVAkANTNlQ-1
X-Mimecast-MFC-AGG-ID: 969KsANCMv6nUVAkANTNlQ_1780517153
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-91578c374easo612722485a.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 13:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780517153; x=1781121953; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=y4stfI5CPH87Zgbm+s0lXLbs4AKKrkHuKxtVPhtVOX4=;
 b=aJ1uWUfQ81G6jPVCig1cveUESJjGKzV6yAmcio9pNrmwhLaaFllOdlyZZ7wxYT4AHP
 TjTb9d2GLE0Q6JaxZP/LJy295Kt1TswsN3Zutk5LilCg1Nni0LZ2O9ilMqaDbHCkpPRo
 oPkACwXN4r+vgu+bFZnfGkoK0W0VE3e+WQCb4KNiI6OT0XKdIx67JGev3HVQYiGeHJGJ
 XGi5OFuUtuMYSki1mAJWYfRZVJq7fdBHBAwzYCnj5Dg5i1d776AVdSHmR/TicQ/7GXN1
 Ww3i+6ZQgprSy92hO8/QrdxmaAzbU6bA/Yk9e9LmeIeyJUL7ELBn6WqjLL1voROXGnDF
 huRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780517153; x=1781121953;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y4stfI5CPH87Zgbm+s0lXLbs4AKKrkHuKxtVPhtVOX4=;
 b=NEfOieyge374aDCVeN6BzewcL/dUY/vuCjadxS1nG2rja7QrsX9z4cy5WRIhgmfBOF
 /4I/B4UHHE5DssEMcY48DaBuUtDWZcsUMdjb/5FhFRCET+faESGivg6bvuITGkZZ4Jx8
 eiINtjbNkev2kBBC+IHVpG9MEv599GoW01tQC71XvJTugkNoDh3XPMnaWPki5oKo/+mb
 p5XwFJxm3OEVTm8JR8cQts4B/JsbgkJ8ApDdPpRzFnQz6GaQI1kUGMC7J10a/cHSbuyA
 lSb7QGNn2G8FNe8jrS8ayEv1Xm5wo66Owyi9GJ8PysR6HSQokIn0aU3/T9z5xvwloJiu
 ytmA==
X-Gm-Message-State: AOJu0YxPw4yx2t6bPz+UykXIz78g+wwmkvkK9YI5O23oCwasVy8pJFhm
 BmOM0T88RVJQ35kA1NxoshjceWfomqeF0PIZs2BOk4h6bu7bz/kakSC/aZJU+nTmg7uj0bIOOQ2
 z8r3Ik2DQZmXUfjV0WmrRTVpkEje5eBql+ivRjBdmGpJHq5nxrh6adEsY
X-Gm-Gg: Acq92OHwK857Oz6xbkpy7eumhqDWixyxKPwUl1LyUTBuKs52X4MFI7732DKd+PPdcwp
 JCG0D3PFJE31CaXTBSNDSPiYIlpxRmYDOJrJgsHMofg/S1ungITG16Wqq4FqlmUVh1rcAoYw1Su
 G6sRMroEGnHlmbDtMedcR/+pWIZjLqpDWB3eMLPG+HRjH1k7A6ShNG01PFOimDhardc8dF2NgBc
 zE34ORqu1iZ+uwu5MPDKsllvy4Mpw0RVg7au4qUDUVFOM6TffeyDv/tf1EWr8fUELMp12xuAdn5
 gym5nbmQZdKaYd2CTBV4rLRcdrod0b9k7Hi49/lGvicyRaR2EJrdT6dJrzIuUnNNJbLf5LXmtEc
 YzaeNOZJ9PdqU1G1B6An6nbDD1Q==
X-Received: by 2002:a05:620a:460f:b0:915:8f76:8002 with SMTP id
 af79cd13be357-9158f7683c4mr609391585a.42.1780517153050; 
 Wed, 03 Jun 2026 13:05:53 -0700 (PDT)
X-Received: by 2002:a05:620a:460f:b0:915:8f76:8002 with SMTP id
 af79cd13be357-9158f7683c4mr609381585a.42.1780517152359; 
 Wed, 03 Jun 2026 13:05:52 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9158a3d3a0esm345489785a.40.2026.06.03.13.05.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 13:05:51 -0700 (PDT)
Date: Wed, 3 Jun 2026 16:05:49 -0400
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Maor Gottlieb <maorg@nvidia.com>
Subject: Re: [PATCH v2 02/13] migration: Run final save_query_pending at
 switchover
Message-ID: <aiCJHa-lT9Ycf6jq@x1.local>
References: <20260602092621.382-1-avihaih@nvidia.com>
 <20260602092621.382-3-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260602092621.382-3-avihaih@nvidia.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Jun 02, 2026 at 12:26:10PM +0300, Avihai Horon wrote:
> Before switchover, the source needs one last exact pending query so
> modules can flush dirty state. This is currently done ad hoc in modules
> handlers. For example, RAM syncs its dirty bitmap in its save_complete
> handler.
> 
> This should be a general concept relevant for any module, so extract it
> to migration core instead by running a final save_query_pending before
> switchover.
> 
> The final query requires special handling by modules (e.g., it's called
> with BQL locked, during VM stop), so extend save_query_pending
> SaveVMHandlers callback and qemu_savevm_query_pending() with a "final"
> flag so migration modules can tell the last pending query during
> switchover from periodic iteration queries.
> 
> Not all modules need the final query; skip it for those who don't need.
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> ---
>  include/migration/register.h   | 41 ++++++++++++++++++----------------
>  migration/savevm.h             |  3 ++-
>  hw/s390x/s390-stattrib.c       |  9 ++++++--
>  hw/vfio/migration.c            |  6 ++++-
>  migration/block-dirty-bitmap.c |  6 ++++-
>  migration/migration.c          |  7 ++++--
>  migration/ram.c                | 37 ++++++++++++++++++------------
>  migration/savevm.c             | 27 +++++++++++++++++-----
>  migration/trace-events         |  2 +-
>  9 files changed, 91 insertions(+), 47 deletions(-)
> 
> diff --git a/include/migration/register.h b/include/migration/register.h
> index 5e5e0ee432..6f632123f1 100644
> --- a/include/migration/register.h
> +++ b/include/migration/register.h
> @@ -171,6 +171,28 @@ typedef struct SaveVMHandlers {
>       */
>      bool (*is_active_iterate)(void *opaque);
>  
> +    /**
> +     * @save_query_pending
> +     *
> +     * This estimates the remaining data to transfer on the source side.
> +     *
> +     * When @exact is true, a module must report accurate results.  When
> +     * @exact is false, a module may report estimates.
> +     *
> +     * It's highly recommended that modules implement a faster version of
> +     * the query path (for example, by proper caching on the counters) if
> +     * an accurate query will be time-consuming.
> +     *
> +     * @opaque: data pointer passed to register_savevm_live()
> +     * @pending: pointer to a MigPendingData struct
> +     * @exact: set to true for an accurate (slow) query
> +     * @final: set to true for the final query during switchover. When final is
> +     * true, the query is called with BQL locked. Otherwise, it's called with
> +     * BQL unlocked.
> +     */
> +    void (*save_query_pending)(void *opaque, MigPendingData *pending,
> +                               bool exact, bool final);
> +
>      /* This runs outside the BQL in the migration case, and
>       * within the lock in the savevm case.  The callback had better only
>       * use data that is local to the migration thread or protected
> @@ -210,25 +232,6 @@ typedef struct SaveVMHandlers {
>       */
>      bool (*save_postcopy_prepare)(QEMUFile *f, void *opaque, Error **errp);
>  
> -    /**
> -     * @save_query_pending
> -     *
> -     * This estimates the remaining data to transfer on the source side.
> -     *
> -     * When @exact is true, a module must report accurate results.  When
> -     * @exact is false, a module may report estimates.
> -     *
> -     * It's highly recommended that modules implement a faster version of
> -     * the query path (for example, by proper caching on the counters) if
> -     * an accurate query will be time-consuming.
> -     *
> -     * @opaque: data pointer passed to register_savevm_live()
> -     * @pending: pointer to a MigPendingData struct
> -     * @exact: set to true for an accurate (slow) query
> -     */
> -    void (*save_query_pending)(void *opaque, MigPendingData *pending,
> -                               bool exact);
> -
>      /**
>       * @load_state
>       *
> diff --git a/migration/savevm.h b/migration/savevm.h
> index 96fdf96d4e..10b3d78a5f 100644
> --- a/migration/savevm.h
> +++ b/migration/savevm.h
> @@ -45,7 +45,8 @@ int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy);
>  void qemu_savevm_state_cleanup(void);
>  void qemu_savevm_state_complete_postcopy(QEMUFile *f);
>  int qemu_savevm_state_complete_precopy(MigrationState *s);
> -void qemu_savevm_query_pending(MigPendingData *pending, bool exact);
> +void qemu_savevm_query_pending_iter(MigPendingData *pending, bool exact);
> +void qemu_savevm_query_pending_final(MigPendingData *pending);
>  int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy);
>  bool qemu_savevm_state_postcopy_prepare(QEMUFile *f, Error **errp);
>  void qemu_savevm_state_end(QEMUFile *f);
> diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
> index c334714b31..aed0c6844d 100644
> --- a/hw/s390x/s390-stattrib.c
> +++ b/hw/s390x/s390-stattrib.c
> @@ -190,12 +190,17 @@ static int cmma_save_setup(QEMUFile *f, void *opaque, Error **errp)
>  }
>  
>  static void cmma_state_pending(void *opaque, MigPendingData *pending,
> -                               bool exact)
> +                               bool exact, bool final)
>  {
>      S390StAttribState *sas = S390_STATTRIB(opaque);
>      S390StAttribClass *sac = S390_STATTRIB_GET_CLASS(sas);
> -    long long res = sac->get_dirtycount(sas);
> +    long long res;
>  
> +    if (final) {
> +        return;
> +    }
> +
> +    res = sac->get_dirtycount(sas);
>      if (res >= 0) {
>          pending->precopy_bytes += res;
>      }
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index fb12b9717f..95072d6664 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -622,12 +622,16 @@ static void vfio_state_pending_sync(VFIODevice *vbasedev)
>  }
>  
>  static void vfio_state_pending(void *opaque, MigPendingData *pending,
> -                               bool exact)
> +                               bool exact, bool final)
>  {
>      VFIODevice *vbasedev = opaque;
>      VFIOMigration *migration = vbasedev->migration;
>      uint64_t precopy_size, stopcopy_size;
>  
> +    if (final) {
> +        return;
> +    }
> +
>      if (exact) {
>          vfio_state_pending_sync(vbasedev);
>      }
> diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
> index 7ef3759e53..66ed91de03 100644
> --- a/migration/block-dirty-bitmap.c
> +++ b/migration/block-dirty-bitmap.c
> @@ -767,12 +767,16 @@ static int dirty_bitmap_save_complete(QEMUFile *f, void *opaque)
>  }
>  
>  static void dirty_bitmap_state_pending(void *opaque, MigPendingData *data,
> -                                       bool exact)
> +                                       bool exact, bool final)
>  {
>      DBMSaveState *s = &((DBMState *)opaque)->save;
>      SaveBitmapState *dbms;
>      uint64_t pending = 0;
>  
> +    if (final) {
> +        return;
> +    }
> +
>      bql_lock();
>  
>      QSIMPLEQ_FOREACH(dbms, &s->dbms_list, entry) {
> diff --git a/migration/migration.c b/migration/migration.c
> index 7488a94206..df8ed3a9fd 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2787,12 +2787,15 @@ static bool migration_switchover_prepare(MigrationState *s)
>  static bool migration_switchover_start(MigrationState *s, Error **errp)
>  {
>      ERRP_GUARD();
> +    MigPendingData pending = {};
>  
>      if (!migration_switchover_prepare(s)) {
>          error_setg(errp, "Switchover is interrupted");
>          return false;
>      }
>  
> +    qemu_savevm_query_pending_final(&pending);

Not needed for postcopy, we can move it to migration_completion_precopy().

I'd also appreciate a short comment explaining why the final query is
needed.

> +
>      /* Inactivate disks except in COLO */
>      if (!migrate_colo()) {
>          /*
> @@ -3285,7 +3288,7 @@ static void migration_iteration_go_next(MigPendingData *pending)
>      /*
>       * Do a slow sync first before boosting the iteration count.
>       */
> -    qemu_savevm_query_pending(pending, true);
> +    qemu_savevm_query_pending_iter(pending, true);
>  
>      /*
>       * Update the dirty information for the whole system for this
> @@ -3336,7 +3339,7 @@ static MigIterateState migration_iteration_run(MigrationState *s)
>      bool complete_ready;
>  
>      /* Fast path - get the estimated amount of pending data */
> -    qemu_savevm_query_pending(&pending, false);
> +    qemu_savevm_query_pending_iter(&pending, false);
>  
>      if (in_postcopy) {
>          /*
> diff --git a/migration/ram.c b/migration/ram.c
> index fc38ffbf8a..4e3f442593 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -3376,10 +3376,6 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
>      rs->last_stage = !migration_in_colo_state();
>  
>      WITH_RCU_READ_LOCK_GUARD() {
> -        if (!migration_in_postcopy()) {
> -            migration_bitmap_sync_precopy(true);
> -        }
> -
>          ret = rdma_registration_start(f, RAM_CONTROL_FINISH);
>          if (ret < 0) {
>              qemu_file_set_error(f, ret);
> @@ -3442,25 +3438,38 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
>      return qemu_fflush(f);
>  }
>  
> -static void ram_state_pending(void *opaque, MigPendingData *pending,
> -                              bool exact)
> +static void ram_state_pending_sync(bool exact, bool final)
>  {
> -    RAMState **temp = opaque;
> -    RAMState *rs = *temp;
> -    uint64_t remaining_size;
> -
>      /*
>       * Sync is not needed either with: (1) a fast query, or (2) after
>       * postcopy has started (no new dirty will generate anymore).
>       */
> -    if (exact && !migration_in_postcopy()) {
> +    if (!exact || migration_in_postcopy()) {
> +        return;
> +    }
> +
> +    /* Final pending query is called with BQL locked */
> +    if (!final) {
>          bql_lock();
> -        WITH_RCU_READ_LOCK_GUARD() {
> -            migration_bitmap_sync_precopy(false);
> -        }
> +    }
> +
> +    WITH_RCU_READ_LOCK_GUARD() {
> +        migration_bitmap_sync_precopy(final);
> +    }
> +
> +    if (!final) {
>          bql_unlock();
>      }
> +}
> +
> +static void ram_state_pending(void *opaque, MigPendingData *pending,
> +                              bool exact, bool final)
> +{
> +    RAMState **temp = opaque;
> +    RAMState *rs = *temp;
> +    uint64_t remaining_size;
>  
> +    ram_state_pending_sync(exact, final);
>      remaining_size = rs->migration_dirty_pages * TARGET_PAGE_SIZE;
>  
>      if (migrate_postcopy_ram()) {
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 23adaf9dd9..22cb6a15c6 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1795,7 +1795,8 @@ int qemu_savevm_state_complete_precopy(MigrationState *s)
>      return qemu_fflush(f);
>  }
>  
> -void qemu_savevm_query_pending(MigPendingData *pending, bool exact)
> +static void qemu_savevm_query_pending(MigPendingData *pending, bool exact,
> +                                      bool final)
>  {
>      SaveStateEntry *se;
>  
> @@ -1808,7 +1809,7 @@ void qemu_savevm_query_pending(MigPendingData *pending, bool exact)
>          if (!qemu_savevm_state_active(se)) {
>              continue;
>          }
> -        se->ops->save_query_pending(se->opaque, pending, exact);
> +        se->ops->save_query_pending(se->opaque, pending, exact, final);
>      }
>  
>      pending->total_bytes = pending->precopy_bytes +
> @@ -1817,16 +1818,30 @@ void qemu_savevm_query_pending(MigPendingData *pending, bool exact)
>      /*
>       * Update system remaining dirty bytes whenever QEMU queries.  It will
>       * make the value to be not as accurate, but should still be pretty
> -     * close to reality when this got invoked frequently while iterating.
> +     * close to reality when this got invoked frequently while iterating.  Don't
> +     * update in final query as some modules may skip it if not needed.

IMHO this specialty isn't needed.  We can just make all modules report and
making sure we don't deadlock on bql.  AFAIU, CMMA never takes BQL, while
dirty-bitmap should conditionally take it now.

>       */
> -    mig_stats.dirty_bytes_total = pending->total_bytes;
> -
> -    trace_qemu_savevm_query_pending(exact, pending->precopy_bytes,
> +    if (!final) {
> +        mig_stats.dirty_bytes_total = pending->total_bytes;
> +    }

Then we remove this too which is counter-intuitive..

The rest looks all reasonable.

Thanks,

> +    trace_qemu_savevm_query_pending(exact, final, pending->precopy_bytes,
>                                      pending->stopcopy_bytes,
>                                      pending->postcopy_bytes,
>                                      pending->total_bytes);
>  }
>  
> +void qemu_savevm_query_pending_iter(MigPendingData *pending, bool exact)
> +{
> +    qemu_savevm_query_pending(pending, exact, false);
> +}
> +
> +void qemu_savevm_query_pending_final(MigPendingData *pending)
> +{
> +    g_assert(bql_locked());
> +
> +    qemu_savevm_query_pending(pending, true, true);
> +}
> +
>  void qemu_savevm_state_cleanup(void)
>  {
>      SaveStateEntry *se;
> diff --git a/migration/trace-events b/migration/trace-events
> index de99d976ab..1c9212d3e2 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -7,7 +7,7 @@ qemu_loadvm_state_section_partend(uint32_t section_id) "%u"
>  qemu_loadvm_state_post_main(int ret) "%d"
>  qemu_loadvm_state_section_startfull(uint32_t section_id, const char *idstr, uint32_t instance_id, uint32_t version_id) "%u(%s) %u %u"
>  qemu_savevm_send_packaged(void) ""
> -qemu_savevm_query_pending(bool exact, uint64_t precopy, uint64_t stopcopy, uint64_t postcopy, uint64_t total) "exact=%d, precopy=%"PRIu64", stopcopy=%"PRIu64", postcopy=%"PRIu64", total=%"PRIu64
> +qemu_savevm_query_pending(bool exact, bool final, uint64_t precopy, uint64_t stopcopy, uint64_t postcopy, uint64_t total) "exact=%d, final=%d, precopy=%"PRIu64", stopcopy=%"PRIu64", postcopy=%"PRIu64", total=%"PRIu64
>  loadvm_state_switchover_ack_needed(unsigned int switchover_ack_pending_num) "Switchover ack pending num=%u"
>  loadvm_state_setup(void) ""
>  loadvm_state_cleanup(void) ""
> -- 
> 2.40.1
> 

-- 
Peter Xu


