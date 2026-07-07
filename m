Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 306AFC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 10:17:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh2rQ-0007ZJ-9K; Tue, 07 Jul 2026 06:17:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1wh2rN-0007Yw-MW
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 06:17:01 -0400
Received: from mout.web.de ([212.227.15.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1wh2rK-0003hT-MF
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 06:17:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1783419381; x=1784024181; i=lukasstraub2@web.de;
 bh=6RsCnvI4Fubd2e+GWdW65v482lwgXyAhN9vUVM0txAI=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=WTEthZ9n2/YXp7TiJGw8aBDj+swMj9M+9jQJSFaOG5IuvM2PT4LGyWnw2igL02ej
 PYk2RmmQ8bpkvvvsb6qciAulBL4P406LUjko7wuhnSEJ3SxmjvJC03WisXvZwvgwz
 /ZpFAZrdJjVPefu1kQztdoMrb7YTN74+HrqXcJj6n0OGs2BSZ1gRoUDpH/4swX59G
 00Ftf+ArPpkV0yRqNcv1QZ89PG5Lax6WHEg886XMy/tfOz2UmWWRVZv/r06DWP/Vp
 zdcNKk4nOVC8BbY801EbkolfPOlunn+kI6Edt/IS4/nr8e5Ap2f9okyZpX6zMYXf+
 FbQ15E3xoSEoZrDIUQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MxYXF-1x0tyv3Gi9-00r2gs; Tue, 07
 Jul 2026 12:16:20 +0200
Date: Tue, 7 Jul 2026 12:16:09 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: Avihai Horon <avihaih@nvidia.com>
Cc: <qemu-devel@nongnu.org>, Alex Williamson <alex@shazbot.org>,
 =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>, Peter Xu
 <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVk?=
 =?UTF-8?B?w6k=?= <philmd@mailo.com>, Zhao Liu <zhao1.liu@intel.com>, Halil
 Pasic <pasic@linux.ibm.com>, "Christian Borntraeger"
 <borntraeger@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>, Richard
 Henderson <richard.henderson@linaro.org>, Ilya Leoshkevich
 <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>, Eric Farman
 <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, "Cornelia
 Huck" <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>, "Vladimir
 Sementsov-Ogievskiy" <vsementsov@yandex-team.ru>, John Snow
 <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>, Maor Gottlieb
 <maorg@nvidia.com>
Subject: Re: [PATCH v5 03/16] migration: Run final save_query_pending at
 switchover
Message-ID: <20260707121609.40bfdcf2@penguin>
In-Reply-To: <20260706085211.13905-4-avihaih@nvidia.com>
References: <20260706085211.13905-1-avihaih@nvidia.com>
 <20260706085211.13905-4-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/lU3YGPAROyCCzL6BwXrI9aM";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:E6AW1MlbP1o7pftAgs2fjmtqKOAJlPEKsX6GB+n6JB74dbkWZCW
 pAMHEjq3RWOoVVbNukdR8XSff0s9qLHFF0HI3yyoP6QKNjjmymcSQobY0eS51lMUJqCNyKp
 gt7hlTOtysEsb8KMIcLYy/x84ba8McS+Bw1ZV0Z1UmaNkKG91ohXFbcvkqcHmXrTgdCRAhR
 XIUBrW9DTC+pMEHvRLG4g==
UI-OutboundReport: notjunk:1;M01:P0:Yn/33+jdgss=;hcPd0jQDUwsFGCsIvzXp09UN5Ho
 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
 =
Received-SPF: pass client-ip=212.227.15.3; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--Sig_/lU3YGPAROyCCzL6BwXrI9aM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 6 Jul 2026 11:51:58 +0300
Avihai Horon <avihaih@nvidia.com> wrote:

> Before switchover, the source needs one last exact pending query so
> modules can flush dirty state. This is currently done ad hoc in modules
> handlers. For example, RAM syncs its dirty bitmap in its save_complete
> handler.
>=20
> This should be a general concept relevant for any module, so extract it
> to migration core instead by running a final save_query_pending before
> switchover.
>=20
> The final query requires special handling by modules (e.g., it's called
> with BQL locked, during VM stop), so extend save_query_pending
> SaveVMHandlers callback and qemu_savevm_query_pending() with a "final"
> flag so migration modules can tell the last pending query during
> switchover from periodic iteration queries.
>=20
> Call final pending query also in COLO checkpoint, which needs to flush
> dirty state before the checkpoint's live state is saved. Unlike a
> regular switchover, COLO reaches completion repeatedly for every
> checkpoint, so this must be done on each one.
>=20
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>

Reviewed-by: Lukas Straub <lukasstraub2@web.de>
Tested-by: Lukas Straub <lukasstraub2@web.de> (COLO parts)

> ---
>  include/migration/register.h   | 41 ++++++++++++++++++----------------
>  migration/savevm.h             |  3 ++-
>  hw/s390x/s390-stattrib.c       |  2 +-
>  hw/vfio/migration.c            | 11 ++++++---
>  migration/block-dirty-bitmap.c | 11 ++++++---
>  migration/colo.c               | 10 +++++++++
>  migration/migration.c          | 14 ++++++++++--
>  migration/ram.c                | 40 +++++++++++++++++++--------------
>  migration/savevm.c             | 20 +++++++++++++----
>  hw/vfio/trace-events           |  2 +-
>  migration/trace-events         |  2 +-
>  11 files changed, 104 insertions(+), 52 deletions(-)
>=20
> diff --git a/include/migration/register.h b/include/migration/register.h
> index 5e5e0ee432..6f632123f1 100644
> --- a/include/migration/register.h
> +++ b/include/migration/register.h
> @@ -171,6 +171,28 @@ typedef struct SaveVMHandlers {
>       */
>      bool (*is_active_iterate)(void *opaque);
> =20
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
> +     * @final: set to true for the final query during switchover. When f=
inal is
> +     * true, the query is called with BQL locked. Otherwise, it's called=
 with
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
>      bool (*save_postcopy_prepare)(QEMUFile *f, void *opaque, Error **err=
p);
> =20
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
> index b6bb4fa977..81abd96dda 100644
> --- a/migration/savevm.h
> +++ b/migration/savevm.h
> @@ -45,7 +45,8 @@ int qemu_savevm_state_iterate(QEMUFile *f, bool postcop=
y);
>  void qemu_savevm_state_cleanup(void);
>  void qemu_savevm_state_complete_postcopy(QEMUFile *f);
>  int qemu_savevm_state_complete_precopy(MigrationState *s, Error **errp);
> -void qemu_savevm_query_pending(MigPendingData *pending, bool exact);
> +void qemu_savevm_query_pending_iter(MigPendingData *pending, bool exact);
> +void qemu_savevm_query_pending_final(MigPendingData *pending);
>  int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_pos=
tcopy);
>  bool qemu_savevm_state_postcopy_prepare(QEMUFile *f, Error **errp);
>  void qemu_savevm_state_end(QEMUFile *f);
> diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
> index c334714b31..b0f04eb30c 100644
> --- a/hw/s390x/s390-stattrib.c
> +++ b/hw/s390x/s390-stattrib.c
> @@ -190,7 +190,7 @@ static int cmma_save_setup(QEMUFile *f, void *opaque,=
 Error **errp)
>  }
> =20
>  static void cmma_state_pending(void *opaque, MigPendingData *pending,
> -                               bool exact)
> +                               bool exact, bool final)
>  {
>      S390StAttribState *sas =3D S390_STATTRIB(opaque);
>      S390StAttribClass *sac =3D S390_STATTRIB_GET_CLASS(sas);
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index fb12b9717f..195498845e 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -622,13 +622,18 @@ static void vfio_state_pending_sync(VFIODevice *vba=
sedev)
>  }
> =20
>  static void vfio_state_pending(void *opaque, MigPendingData *pending,
> -                               bool exact)
> +                               bool exact, bool final)
>  {
>      VFIODevice *vbasedev =3D opaque;
>      VFIOMigration *migration =3D vbasedev->migration;
>      uint64_t precopy_size, stopcopy_size;
> =20
> -    if (exact) {
> +    /*
> +     * The final pending query runs during switchover downtime. VFIO doe=
s not
> +     * need a fresh device pending-data query then to get the latest dir=
ty
> +     * data, so avoid the extra work and report the cached counters belo=
w.
> +     */
> +    if (exact && !final) {
>          vfio_state_pending_sync(vbasedev);
>      }
> =20
> @@ -646,7 +651,7 @@ static void vfio_state_pending(void *opaque, MigPendi=
ngData *pending,
> =20
>      trace_vfio_state_pending(vbasedev->name, migration->stopcopy_size,
>                               migration->precopy_init_size,
> -                             migration->precopy_dirty_size, exact);
> +                             migration->precopy_dirty_size, exact, final=
);
>  }
> =20
>  static bool vfio_is_active_iterate(void *opaque)
> diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitma=
p.c
> index 7ef3759e53..cba54e25cd 100644
> --- a/migration/block-dirty-bitmap.c
> +++ b/migration/block-dirty-bitmap.c
> @@ -767,13 +767,16 @@ static int dirty_bitmap_save_complete(QEMUFile *f, =
void *opaque)
>  }
> =20
>  static void dirty_bitmap_state_pending(void *opaque, MigPendingData *dat=
a,
> -                                       bool exact)
> +                                       bool exact, bool final)
>  {
>      DBMSaveState *s =3D &((DBMState *)opaque)->save;
>      SaveBitmapState *dbms;
>      uint64_t pending =3D 0;
> =20
> -    bql_lock();
> +    /* Final pending query is called with BQL locked */
> +    if (!final) {
> +        bql_lock();
> +    }
> =20
>      QSIMPLEQ_FOREACH(dbms, &s->dbms_list, entry) {
>          uint64_t gran =3D bdrv_dirty_bitmap_granularity(dbms->bitmap);
> @@ -783,7 +786,9 @@ static void dirty_bitmap_state_pending(void *opaque, =
MigPendingData *data,
>          pending +=3D DIV_ROUND_UP(sectors * BDRV_SECTOR_SIZE, gran);
>      }
> =20
> -    bql_unlock();
> +    if (!final) {
> +        bql_unlock();
> +    }
> =20
>      trace_dirty_bitmap_state_pending(pending);
> =20
> diff --git a/migration/colo.c b/migration/colo.c
> index 2d36f933cf..08632d5e4a 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -409,6 +409,7 @@ static int colo_do_checkpoint_transaction(MigrationSt=
ate *s,
>                                            QEMUFile *fb)
>  {
>      Error *local_err =3D NULL;
> +    MigPendingData pending =3D {};
>      int ret =3D -1;
> =20
>      colo_send_message(s->to_dst_file, COLO_MESSAGE_CHECKPOINT_REQUEST,
> @@ -465,6 +466,15 @@ static int colo_do_checkpoint_transaction(MigrationS=
tate *s,
>      if (migrate_auto_converge()) {
>          mig_throttle_counter_reset();
>      }
> +
> +    /*
> +     * Run the final pending query so migration modules can flush their =
dirty
> +     * state (e.g., RAM syncs its dirty bitmap) before this checkpoint's=
 live
> +     * state is saved. Unlike a regular switchover, COLO reaches complet=
ion
> +     * repeatedly for every checkpoint, so this must be done on each one.
> +     */
> +    qemu_savevm_query_pending_final(&pending);
> +
>      /*
>       * Only save VM's live state, which not including device state.
>       * TODO: We may need a timeout mechanism to prevent COLO process
> diff --git a/migration/migration.c b/migration/migration.c
> index 7e0a0bea7a..442f950c43 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2793,12 +2793,22 @@ static bool migration_switchover_prepare(Migratio=
nState *s)
>  static bool migration_switchover_start(MigrationState *s, Error **errp)
>  {
>      ERRP_GUARD();
> +    MigPendingData pending =3D {};
> =20
>      if (!migration_switchover_prepare(s)) {
>          error_setg(errp, "Switchover is interrupted");
>          return false;
>      }
> =20
> +    /*
> +     * The final query to the whole system on dirty data to make sure we
> +     * collect the latest status of the VM.  For precopy, source QEMU wi=
ll
> +     * dump all the dirty data during switchover.  For postcopy, this wi=
ll
> +     * properly update all the dirty bitmaps to finally generate the
> +     * correct discard bitmaps; see ram_postcopy_send_discard_bitmap().
> +     */
> +    qemu_savevm_query_pending_final(&pending);
> +
>      /* Inactivate disks except in COLO */
>      if (!migrate_colo()) {
>          /*
> @@ -3291,7 +3301,7 @@ static void migration_iteration_go_next(MigPendingD=
ata *pending)
>      /*
>       * Do a slow sync first before boosting the iteration count.
>       */
> -    qemu_savevm_query_pending(pending, true);
> +    qemu_savevm_query_pending_iter(pending, true);
> =20
>      /*
>       * Update the dirty information for the whole system for this
> @@ -3342,7 +3352,7 @@ static MigIterateState migration_iteration_run(Migr=
ationState *s)
>      bool complete_ready;
> =20
>      /* Fast path - get the estimated amount of pending data */
> -    qemu_savevm_query_pending(&pending, false);
> +    qemu_savevm_query_pending_iter(&pending, false);
> =20
>      if (in_postcopy) {
>          /*
> diff --git a/migration/ram.c b/migration/ram.c
> index 55aa9b47dc..8918b2f03b 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -2686,9 +2686,6 @@ void ram_postcopy_send_discard_bitmap(MigrationStat=
e *ms)
> =20
>      RCU_READ_LOCK_GUARD();
> =20
> -    /* This should be our last sync, the src is now paused */
> -    migration_bitmap_sync_precopy(true);
> -
>      /* Easiest way to make sure we don't resume in the middle of a host-=
page */
>      rs->pss[RAM_CHANNEL_PRECOPY].last_sent_block =3D NULL;
>      rs->last_seen_block =3D NULL;
> @@ -3376,10 +3373,6 @@ static int ram_save_complete(QEMUFile *f, void *op=
aque)
>      rs->last_stage =3D !migration_in_colo_state();
> =20
>      WITH_RCU_READ_LOCK_GUARD() {
> -        if (!migration_in_postcopy()) {
> -            migration_bitmap_sync_precopy(true);
> -        }
> -
>          ret =3D rdma_registration_start(f, RAM_CONTROL_FINISH);
>          if (ret < 0) {
>              qemu_file_set_error(f, ret);
> @@ -3442,25 +3435,38 @@ static int ram_save_complete(QEMUFile *f, void *o=
paque)
>      return qemu_fflush(f);
>  }
> =20
> -static void ram_state_pending(void *opaque, MigPendingData *pending,
> -                              bool exact)
> +static void ram_state_pending_sync(bool exact, bool final)
>  {
> -    RAMState **temp =3D opaque;
> -    RAMState *rs =3D *temp;
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
> +    RAMState **temp =3D opaque;
> +    RAMState *rs =3D *temp;
> +    uint64_t remaining_size;
> =20
> +    ram_state_pending_sync(exact, final);
>      remaining_size =3D rs->migration_dirty_pages * TARGET_PAGE_SIZE;
> =20
>      if (migrate_postcopy_ram()) {
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 7e2a0c2b4a..74d622583e 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1801,7 +1801,8 @@ int qemu_savevm_state_complete_precopy(MigrationSta=
te *s, Error **errp)
>      return 0;
>  }
> =20
> -void qemu_savevm_query_pending(MigPendingData *pending, bool exact)
> +static void qemu_savevm_query_pending(MigPendingData *pending, bool exac=
t,
> +                                      bool final)
>  {
>      SaveStateEntry *se;
> =20
> @@ -1814,7 +1815,7 @@ void qemu_savevm_query_pending(MigPendingData *pend=
ing, bool exact)
>          if (!qemu_savevm_state_active(se)) {
>              continue;
>          }
> -        se->ops->save_query_pending(se->opaque, pending, exact);
> +        se->ops->save_query_pending(se->opaque, pending, exact, final);
>      }
> =20
>      pending->total_bytes =3D pending->precopy_bytes +
> @@ -1826,13 +1827,24 @@ void qemu_savevm_query_pending(MigPendingData *pe=
nding, bool exact)
>       * close to reality when this got invoked frequently while iterating.
>       */
>      mig_stats.dirty_bytes_total =3D pending->total_bytes;
> -
> -    trace_qemu_savevm_query_pending(exact, pending->precopy_bytes,
> +    trace_qemu_savevm_query_pending(exact, final, pending->precopy_bytes,
>                                      pending->stopcopy_bytes,
>                                      pending->postcopy_bytes,
>                                      pending->total_bytes);
>  }
> =20
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
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index 4c28b3291c..fa2204f002 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -176,7 +176,7 @@ vfio_save_device_config_state(const char *name) " (%s=
)"
>  vfio_save_iterate(const char *name, uint64_t precopy_init_size, uint64_t=
 precopy_dirty_size) " (%s) precopy initial size %"PRIu64" precopy dirty si=
ze %"PRIu64
>  vfio_save_iterate_start(const char *name) " (%s)"
>  vfio_save_setup(const char *name, uint64_t data_buffer_size) " (%s) data=
 buffer size %"PRIu64
> -vfio_state_pending(const char *name, uint64_t stopcopy_size, uint64_t pr=
ecopy_init_size, uint64_t precopy_dirty_size, bool exact) " (%s) stopcopy s=
ize %"PRIu64" precopy initial size %"PRIu64" precopy dirty size %"PRIu64 " =
exact %d"
> +vfio_state_pending(const char *name, uint64_t stopcopy_size, uint64_t pr=
ecopy_init_size, uint64_t precopy_dirty_size, bool exact, bool final) " (%s=
) stopcopy size %"PRIu64", precopy initial size %"PRIu64", precopy dirty si=
ze %"PRIu64", exact %d, final %d"
>  vfio_vmstate_change(const char *name, int running, const char *reason, c=
onst char *dev_state) " (%s) running %d reason %s device state %s"
>  vfio_vmstate_change_prepare(const char *name, int running, const char *r=
eason, const char *dev_state) " (%s) running %d reason %s device state %s"
> =20
> diff --git a/migration/trace-events b/migration/trace-events
> index de99d976ab..1c9212d3e2 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -7,7 +7,7 @@ qemu_loadvm_state_section_partend(uint32_t section_id) "%=
u"
>  qemu_loadvm_state_post_main(int ret) "%d"
>  qemu_loadvm_state_section_startfull(uint32_t section_id, const char *ids=
tr, uint32_t instance_id, uint32_t version_id) "%u(%s) %u %u"
>  qemu_savevm_send_packaged(void) ""
> -qemu_savevm_query_pending(bool exact, uint64_t precopy, uint64_t stopcop=
y, uint64_t postcopy, uint64_t total) "exact=3D%d, precopy=3D%"PRIu64", sto=
pcopy=3D%"PRIu64", postcopy=3D%"PRIu64", total=3D%"PRIu64
> +qemu_savevm_query_pending(bool exact, bool final, uint64_t precopy, uint=
64_t stopcopy, uint64_t postcopy, uint64_t total) "exact=3D%d, final=3D%d, =
precopy=3D%"PRIu64", stopcopy=3D%"PRIu64", postcopy=3D%"PRIu64", total=3D%"=
PRIu64
>  loadvm_state_switchover_ack_needed(unsigned int switchover_ack_pending_n=
um) "Switchover ack pending num=3D%u"
>  loadvm_state_setup(void) ""
>  loadvm_state_cleanup(void) ""


--Sig_/lU3YGPAROyCCzL6BwXrI9aM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmpM0ekACgkQNasLKJxd
slhvSA/8Cmxf9gH1o0ETaZfzg/anHFA7t3AL3C/0lLVa1bkepp/9NhbsUpdZwvd2
btQVTOG4XQgfX2JJvpBfGny+aisiQpp/Zo2fTt35jidQCtHA5yWnG90hee6GmA9O
iW2sOQzW4HMadlMnzl0zba7pbzlyia5OhDN2qEuOVot2mDZ7SFciHOjlWz1dgx/r
v5EBunfapfYou2owaWm63cmuDUWyk1FjNJMg6n+5STWf5sVc0kJTK4O2IJLX/BM1
tk0lFbFV+JtdsGNTcMRUzIyoeuRSGS/QUpiKsphrDykLNY6Q93MuLUodf6CgHhKe
R8oFmK724NAwJo+aRxIqL8/5sYNYGi7DsURltfhEWdoSkVdeDKzY7vLtfLp4Eq2S
JbZHb4exPdzmWcRl3/9LBZvuuIHKJq02HuFLZ5xYboSiDClIdCAMMCWh5+AmSbeH
vwrrAG8OJ3AkImE3bLDyPyxb2vNzn6WO35lnLI1wTD4ty8rNJtHbrOAb3vrKxOvD
hKLSoeYJlpZnot/AWWBmIdCHVjyknaG5IPOQrA2lIt5IYYl80rzOK2SYot4K2XCz
8Pu1c+xjjCFA+LscmT+UCHPh4mNnscZuyM9mYYE/CMGNUDEa+iu2nWRHX3rTt3Jp
oO56nGgjAu3Hn9S3olFdCFLjUB2XyG1EkaHy7/AYXOwHiykbVfY=
=+GvL
-----END PGP SIGNATURE-----

--Sig_/lU3YGPAROyCCzL6BwXrI9aM--

