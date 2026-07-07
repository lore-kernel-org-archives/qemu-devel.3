Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 057C8C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 10:17:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh2s0-0007c2-Qv; Tue, 07 Jul 2026 06:17:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1wh2rz-0007bt-BJ
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 06:17:39 -0400
Received: from mout.web.de ([217.72.192.78])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1wh2rw-0003kc-3o
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 06:17:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1783419450; x=1784024250; i=lukasstraub2@web.de;
 bh=zSS82LstDRR6tX5Oq347Uc3tfO0zUGHLKrAnI0U+ZIQ=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=m0ZBxzTkruj4UFzJuowvGa0Wl2J+TUK7BkyBNEU4ycQEC3oUFZ1vRSPQ2MpJ7WmQ
 R5oH1X7hYo8Rrp9NY5BCGci6gS+Jtd0/z+xE/bQti2z/7qOTgtaOG+Ov52VVWMagw
 wL1ALuOmbbvmbViYUGTyhyBusZq4P1JfryXG7rThxdramdKRhJ2NsqXI9AMrRYXxw
 akOCL5JAcW+MgufiAKYzpHbYNH54FaD8BreF0MIrxm7oF196FiZBPAk6gQ97XVUAc
 sSmRBDxNKRRrb3L+egWlnxlo9sl9TbNNtYNvh5sD9vZ9xunR296eUlbJCJwuP9WXz
 14aSK+DgzSNQJcjy8A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MsrhK-1wwFOs0O5o-00uGVO; Tue, 07
 Jul 2026 12:17:30 +0200
Date: Tue, 7 Jul 2026 12:17:27 +0200
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
Subject: Re: [PATCH v5 07/16] migration: Make switchover-ack re-usable
Message-ID: <20260707121727.58689396@penguin>
In-Reply-To: <20260706085211.13905-8-avihaih@nvidia.com>
References: <20260706085211.13905-1-avihaih@nvidia.com>
 <20260706085211.13905-8-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/CSJ8HxZJPLpX/Vv1oKO=DgC";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:JFx1DBbbDVM3NJdGElpW7SrNUiZ7aJQt3gG6WikEM/cdkYViYYx
 gcaXdNmHL8TIYiHyQpyl5a14trjB1cBi8JEyCNkkf0ThLZg+Rls6jQQDSNk4NqC4geTl6Lb
 WpaIWkzZYBveuAa97L2wwWqAQv8Pked9dHluiXA+pcC6aer/TWcZRTjvtc8MKNZrTbD0951
 EecUoJ7n0ZmU9/7lf+HMA==
UI-OutboundReport: notjunk:1;M01:P0:iZNkvJLXJik=;Vqqg9lEkbLZeSLm0DrPMYlN87rE
 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
 DTgyAvOpyv5Feq4p7afxJ
Received-SPF: pass client-ip=217.72.192.78; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--Sig_/CSJ8HxZJPLpX/Vv1oKO=DgC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 6 Jul 2026 11:52:02 +0300
Avihai Horon <avihaih@nvidia.com> wrote:

> Switchover-ack is a mechanism to synchronize between source and
> destination QEMU during migration to prevent the source from switching
> over prematurely.
>=20
> VFIO uses switchover-ack to ensure switchover happens only after
> destination side has loaded the precopy initial bytes. This is important
> for VFIO, as otherwise downtime could be impacted and be higher.
>=20
> In its current state, switchover-ack is a one-time mechanism, meaning
> that switchover is acked only once and past that another ACK cannot be
> requested again. This was sufficient until now, as VFIO precopy initial
> bytes was defined to be monotonically decreasing. Thus, when precopy
> initial bytes reached zero for all VFIO devices, a single ACK would be
> sent and its validity would hold.
>=20
> However, now the new VFIO_PRECOPY_INFO_REINIT feature allows precopy
> initial bytes to be re-initialized during precopy. Specifically, it
> means that initial bytes can grow after reaching zero, which would
> invalidate a previously sent switchover ACK.
>=20
> To solve this, make switchover-ack reusable and allow devices to request
> switchover ACKs when needed via the save_query_pending SaveVMHandler.
>=20
> Since now switchover ACK can be requested for a specific device and in
> different times, make switchover ACK per-device (instead of a single ACK
> for all devices) and let source side do the pending ACKs accounting.
>=20
> Keep the legacy switchover-ack mechanism for backward compatibility and
> turn it on by a compatibility property for older machines. Enable the
> property until VFIO implements the new switchover-ack.
>=20
> Acked-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>

For the COLO parts:
Reviewed-by: Lukas Straub <lukasstraub2@web.de>
Tested-by: Lukas Straub <lukasstraub2@web.de>

> ---
>  qapi/migration.json                | 14 ++++----
>  include/migration/client-options.h |  1 +
>  include/migration/register.h       |  2 ++
>  migration/migration.h              | 32 ++++++++++++++++--
>  migration/savevm.h                 |  6 ++--
>  migration/colo.c                   |  2 +-
>  migration/migration.c              | 37 ++++++++++++++-------
>  migration/options.c                | 10 ++++++
>  migration/savevm.c                 | 53 +++++++++++++++++++++++-------
>  migration/trace-events             |  5 +--
>  10 files changed, 124 insertions(+), 38 deletions(-)
>=20
> diff --git a/qapi/migration.json b/qapi/migration.json
> index e8756308cf..d2f42c4b0f 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -508,14 +508,12 @@
>  #     (since 7.1)
>  #
>  # @switchover-ack: If enabled, migration will not stop the source VM
> -#     and complete the migration until an ACK is received from the
> -#     destination that it's OK to do so.  Exactly when this ACK is
> -#     sent depends on the migrated devices that use this feature.  For
> -#     example, a device can use it to make sure some of its data is
> -#     sent and loaded in the destination before doing switchover.
> -#     This can reduce downtime if devices that support this capability
> -#     are present.  'return-path' capability must be enabled to use
> -#     it.  (since 8.1)
> +#     and complete the migration until the destination has
> +#     acknowledged that it is OK to switchover.  The acknowledgement
> +#     may depend, for example, on some device's data being loaded in
> +#     the destination before doing switchover.  This can reduce
> +#     downtime if devices that support this capability are present.
> +#     Capability @return-path must be enabled to use it.  (since 8.1)
>  #
>  # @dirty-limit: If enabled, migration will throttle vCPUs as needed to
>  #     keep their dirty page rate within @vcpu-dirty-limit.  This can
> diff --git a/include/migration/client-options.h b/include/migration/clien=
t-options.h
> index 289c9d7762..78b1daa1a6 100644
> --- a/include/migration/client-options.h
> +++ b/include/migration/client-options.h
> @@ -13,6 +13,7 @@
> =20
>  /* properties */
>  bool migrate_send_switchover_start(void);
> +bool migrate_switchover_ack_legacy(void);
> =20
>  /* capabilities */
> =20
> diff --git a/include/migration/register.h b/include/migration/register.h
> index a61c4236d2..5825eb30cb 100644
> --- a/include/migration/register.h
> +++ b/include/migration/register.h
> @@ -23,6 +23,8 @@ typedef struct MigPendingData {
>      uint64_t postcopy_bytes;
>      /* Amount of pending bytes can be transferred only in stopcopy */
>      uint64_t stopcopy_bytes;
> +    /* Number of new pending switchover ACKs */
> +    uint32_t switchover_ack_pending;
>      /*
>       * Total pending data, modules do not need to update this field, it
>       * will be automatically calculated by migration core API.
> diff --git a/migration/migration.h b/migration/migration.h
> index 570349d858..44bce199cd 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -487,6 +487,29 @@ struct MigrationState {
>       */
>      uint8_t clear_bitmap_shift;
> =20
> +    /*
> +     * This decides whether to use legacy switchover-ack or new switchov=
er-ack.
> +     * The main difference between them is that the former allows acknow=
ledging
> +     * switchover only once while the latter multiple times.
> +     *
> +     * In legacy, the destination keeps track of a pending ACKs counter.=
 As
> +     * migration progresses, the devices on the destination acknowledge
> +     * switchover, decreasing the counter. When the counter reaches zero=
, a
> +     * single ACK message is sent to the source via the return path, ind=
icating
> +     * that it's OK to switchover.
> +     *
> +     * In new switchover-ack, the source is the one that keeps track of a
> +     * pending ACKs counter. As migration progresses, the destination se=
nds ACK
> +     * message per-device via the return path, which decrements the sour=
ce
> +     * counter. When the counter reaches zero, it's OK to switchover. Du=
ring
> +     * precopy, source-side devices may request additional ACKs, which i=
ncrement
> +     * the counter again.
> +     *
> +     * In both legacy and new schemes, we rely on per-device protocol to=
 request
> +     * switchover ACK from the destination-side counterpart.
> +     */
> +    bool switchover_ack_legacy;
> +
>      /*
>       * This save hostname when out-going migration starts
>       */
> @@ -496,10 +519,13 @@ struct MigrationState {
>      JSONWriter *vmdesc;
> =20
>      /*
> -     * Indicates whether an ACK from the destination that it's OK to do
> -     * switchover has been received.
> +     * Indicates the number of pending ACKs from the destination. The va=
lue may
> +     * increase or decrease during precopy as new ACKs are requested or
> +     * received. When zero is reached, it's OK to switchover. In legacy
> +     * switchover-ack, it's initialized to 1 and decreased to zero upon =
ACK.
>       */
> -    bool switchover_acked;
> +    uint32_t switchover_ack_pending_num;
> +
>      /* Is this a rdma migration */
>      bool rdma_migration;
> =20
> diff --git a/migration/savevm.h b/migration/savevm.h
> index 44424be347..fb92d3bc85 100644
> --- a/migration/savevm.h
> +++ b/migration/savevm.h
> @@ -45,8 +45,10 @@ int qemu_savevm_state_iterate(QEMUFile *f, bool postco=
py);
>  void qemu_savevm_state_cleanup(void);
>  void qemu_savevm_state_complete_postcopy(QEMUFile *f);
>  int qemu_savevm_state_complete_precopy(MigrationState *s, Error **errp);
> -void qemu_savevm_query_pending_iter(MigPendingData *pending, bool exact);
> -void qemu_savevm_query_pending_final(MigPendingData *pending);
> +void qemu_savevm_query_pending_iter(MigrationState *s, MigPendingData *p=
ending,
> +                                    bool exact);
> +void qemu_savevm_query_pending_final(MigrationState *s,
> +                                     MigPendingData *pending);
>  int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_pos=
tcopy);
>  bool qemu_savevm_state_postcopy_prepare(QEMUFile *f, Error **errp);
>  void qemu_savevm_state_end(QEMUFile *f);
> diff --git a/migration/colo.c b/migration/colo.c
> index 08632d5e4a..0cef0f6b0e 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -473,7 +473,7 @@ static int colo_do_checkpoint_transaction(MigrationSt=
ate *s,
>       * state is saved. Unlike a regular switchover, COLO reaches complet=
ion
>       * repeatedly for every checkpoint, so this must be done on each one.
>       */
> -    qemu_savevm_query_pending_final(&pending);
> +    qemu_savevm_query_pending_final(s, &pending);
> =20
>      /*
>       * Only save VM's live state, which not including device state.
> diff --git a/migration/migration.c b/migration/migration.c
> index 1d3387da0f..2b625da114 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1713,7 +1713,9 @@ int migrate_init(MigrationState *s, Error **errp)
>      s->vm_old_state =3D -1;
>      s->iteration_initial_bytes =3D 0;
>      s->threshold_size =3D 0;
> -    s->switchover_acked =3D false;
> +    /* Legacy switchover-ack sends a single ACK for all devices */
> +    qatomic_set(&s->switchover_ack_pending_num,
> +                migrate_switchover_ack_legacy() ? 1 : 0);
>      s->rdma_migration =3D false;
> =20
>      /*
> @@ -2207,7 +2209,7 @@ void migration_request_switchover_ack_legacy(const =
char *requester)
>  {
>      MigrationIncomingState *mis =3D migration_incoming_get_current();
> =20
> -    if (!migrate_switchover_ack()) {
> +    if (!migrate_switchover_ack() || !migrate_switchover_ack_legacy()) {
>          return;
>      }
> =20
> @@ -2463,9 +2465,18 @@ static void *source_return_path_thread(void *opaqu=
e)
>              break;
> =20
>          case MIG_RP_MSG_SWITCHOVER_ACK:
> -            ms->switchover_acked =3D true;
> -            trace_source_return_path_thread_switchover_acked();
> +        {
> +            uint32_t pending_num;
> +
> +            pending_num =3D qatomic_dec_fetch(&ms->switchover_ack_pendin=
g_num);
> +            trace_source_return_path_thread_switchover_acked(pending_num=
);
> +            if (pending_num =3D=3D UINT32_MAX) {
> +                error_setg(&err, "Switchover ack pending num underflowed=
");
> +                goto out;
> +            }
> +
>              break;
> +        }
> =20
>          default:
>              break;
> @@ -2822,7 +2833,7 @@ static bool migration_switchover_start(MigrationSta=
te *s, Error **errp)
>       * properly update all the dirty bitmaps to finally generate the
>       * correct discard bitmaps; see ram_postcopy_send_discard_bitmap().
>       */
> -    qemu_savevm_query_pending_final(&pending);
> +    qemu_savevm_query_pending_final(s, &pending);
> =20
>      /* Inactivate disks except in COLO */
>      if (!migrate_colo()) {
> @@ -3272,7 +3283,7 @@ static bool migration_can_switchover(MigrationState=
 *s)
>          return true;
>      }
> =20
> -    return s->switchover_acked;
> +    return qatomic_read(&s->switchover_ack_pending_num) =3D=3D 0;
>  }
> =20
>  /* Migration thread iteration status */
> @@ -3311,12 +3322,13 @@ static bool migration_iteration_next_ready(Migrat=
ionState *s,
>      return false;
>  }
> =20
> -static void migration_iteration_go_next(MigPendingData *pending)
> +static void migration_iteration_go_next(MigrationState *s,
> +                                        MigPendingData *pending)
>  {
>      /*
>       * Do a slow sync first before boosting the iteration count.
>       */
> -    qemu_savevm_query_pending_iter(pending, true);
> +    qemu_savevm_query_pending_iter(s, pending, true);
> =20
>      /*
>       * Update the dirty information for the whole system for this
> @@ -3362,12 +3374,12 @@ static MigIterateState migration_iteration_run(Mi=
grationState *s)
>      Error *local_err =3D NULL;
>      bool in_postcopy =3D (s->state =3D=3D MIGRATION_STATUS_POSTCOPY_DEVI=
CE ||
>                          s->state =3D=3D MIGRATION_STATUS_POSTCOPY_ACTIVE=
);
> -    bool can_switchover =3D migration_can_switchover(s);
> +    bool can_switchover;
>      MigPendingData pending =3D { };
>      bool complete_ready;
> =20
>      /* Fast path - get the estimated amount of pending data */
> -    qemu_savevm_query_pending_iter(&pending, false);
> +    qemu_savevm_query_pending_iter(s, &pending, false);
> =20
>      if (in_postcopy) {
>          /*
> @@ -3408,9 +3420,12 @@ static MigIterateState migration_iteration_run(Mig=
rationState *s)
>           * during postcopy phase.
>           */
>          if (migration_iteration_next_ready(s, &pending)) {
> -            migration_iteration_go_next(&pending);
> +            migration_iteration_go_next(s, &pending);
>          }
> =20
> +        /* Check can switchover after qemu_savevm_query_pending() */
> +        can_switchover =3D migration_can_switchover(s);
> +
>          /* Should we switch to postcopy now? */
>          if (can_switchover && postcopy_should_start(s, &pending)) {
>              if (postcopy_start(s, &local_err)) {
> diff --git a/migration/options.c b/migration/options.c
> index 5cbfd29099..4c9b25372e 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -110,6 +110,9 @@ const Property migration_properties[] =3D {
>                       preempt_pre_7_2, false),
>      DEFINE_PROP_BOOL("multifd-clean-tls-termination", MigrationState,
>                       multifd_clean_tls_termination, true),
> +    /* Use legacy until VFIO implements new switchover-ack */
> +    DEFINE_PROP_BOOL("switchover-ack-legacy", MigrationState,
> +                     switchover_ack_legacy, true),
> =20
>      /* Migration parameters */
>      DEFINE_PROP_UINT8("x-throttle-trigger-threshold", MigrationState,
> @@ -467,6 +470,13 @@ bool migrate_rdma(void)
>      return s->rdma_migration;
>  }
> =20
> +bool migrate_switchover_ack_legacy(void)
> +{
> +    MigrationState *s =3D migrate_get_current();
> +
> +    return s->switchover_ack_legacy;
> +}
> +
>  typedef enum WriteTrackingSupport {
>      WT_SUPPORT_UNKNOWN =3D 0,
>      WT_SUPPORT_ABSENT,
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 804c76e3bd..1f6e696c50 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1801,7 +1801,8 @@ int qemu_savevm_state_complete_precopy(MigrationSta=
te *s, Error **errp)
>      return 0;
>  }
> =20
> -static void qemu_savevm_query_pending(MigPendingData *pending, bool exac=
t,
> +static void qemu_savevm_query_pending(MigrationState *s,
> +                                      MigPendingData *pending, bool exac=
t,
>                                        bool final)
>  {
>      SaveStateEntry *se;
> @@ -1827,22 +1828,35 @@ static void qemu_savevm_query_pending(MigPendingD=
ata *pending, bool exact,
>       * close to reality when this got invoked frequently while iterating.
>       */
>      mig_stats.dirty_bytes_total =3D pending->total_bytes;
> -    trace_qemu_savevm_query_pending(exact, final, pending->precopy_bytes,
> -                                    pending->stopcopy_bytes,
> -                                    pending->postcopy_bytes,
> -                                    pending->total_bytes);
> +
> +    if (migrate_switchover_ack() && !migrate_switchover_ack_legacy() &&
> +        pending->switchover_ack_pending) {
> +        /*
> +         * NOTE: Currently we rely on per-device protocol to request swi=
tchover
> +         * ACK from the device on the destination side.
> +         */
> +        qatomic_add(&s->switchover_ack_pending_num,
> +                    pending->switchover_ack_pending);
> +    }
> +
> +    trace_qemu_savevm_query_pending(
> +        exact, final, pending->precopy_bytes, pending->stopcopy_bytes,
> +        pending->postcopy_bytes, pending->total_bytes,
> +        pending->switchover_ack_pending,
> +        qatomic_read(&s->switchover_ack_pending_num));
>  }
> =20
> -void qemu_savevm_query_pending_iter(MigPendingData *pending, bool exact)
> +void qemu_savevm_query_pending_iter(MigrationState *s, MigPendingData *p=
ending,
> +                                    bool exact)
>  {
> -    qemu_savevm_query_pending(pending, exact, false);
> +    qemu_savevm_query_pending(s, pending, exact, false);
>  }
> =20
> -void qemu_savevm_query_pending_final(MigPendingData *pending)
> +void qemu_savevm_query_pending_final(MigrationState *s, MigPendingData *=
pending)
>  {
>      g_assert(bql_locked());
> =20
> -    qemu_savevm_query_pending(pending, true, true);
> +    qemu_savevm_query_pending(s, pending, true, true);
>  }
> =20
>  void qemu_savevm_state_cleanup(void)
> @@ -2487,7 +2501,7 @@ static int loadvm_switchover_ack_no_users_legacy(Mi=
grationIncomingState *mis,
>  {
>      int ret;
> =20
> -    if (!migrate_switchover_ack()) {
> +    if (!migrate_switchover_ack() || !migrate_switchover_ack_legacy()) {
>          return 0;
>      }
> =20
> @@ -3169,7 +3183,7 @@ int qemu_load_device_state(QEMUFile *f, Error **err=
p)
>      return 0;
>  }
> =20
> -int qemu_loadvm_approve_switchover(const char *approver)
> +static int qemu_loadvm_approve_switchover_legacy(const char *approver)
>  {
>      MigrationIncomingState *mis =3D migration_incoming_get_current();
> =20
> @@ -3188,6 +3202,23 @@ int qemu_loadvm_approve_switchover(const char *app=
rover)
>      return migrate_send_rp_switchover_ack(mis);
>  }
> =20
> +int qemu_loadvm_approve_switchover(const char *approver)
> +{
> +    MigrationIncomingState *mis =3D migration_incoming_get_current();
> +
> +    if (!migrate_switchover_ack()) {
> +        return 0;
> +    }
> +
> +    if (migrate_switchover_ack_legacy()) {
> +        return qemu_loadvm_approve_switchover_legacy(approver);
> +    }
> +
> +    trace_loadvm_approve_switchover(approver);
> +
> +    return migrate_send_rp_switchover_ack(mis);
> +}
> +
>  bool qemu_loadvm_load_state_buffer(const char *idstr, uint32_t instance_=
id,
>                                     char *buf, size_t len, Error **errp)
>  {
> diff --git a/migration/trace-events b/migration/trace-events
> index a6b8c31ee1..f5339f4193 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -7,7 +7,7 @@ qemu_loadvm_state_section_partend(uint32_t section_id) "%=
u"
>  qemu_loadvm_state_post_main(int ret) "%d"
>  qemu_loadvm_state_section_startfull(uint32_t section_id, const char *ids=
tr, uint32_t instance_id, uint32_t version_id) "%u(%s) %u %u"
>  qemu_savevm_send_packaged(void) ""
> -qemu_savevm_query_pending(bool exact, bool final, uint64_t precopy, uint=
64_t stopcopy, uint64_t postcopy, uint64_t total) "exact=3D%d, final=3D%d, =
precopy=3D%"PRIu64", stopcopy=3D%"PRIu64", postcopy=3D%"PRIu64", total=3D%"=
PRIu64
> +qemu_savevm_query_pending(bool exact, bool final, uint64_t precopy, uint=
64_t stopcopy, uint64_t postcopy, uint64_t total, uint32_t switchover_ack_p=
ending, uint32_t total_switchover_ack_pending) "exact=3D%d, final=3D%d, pre=
copy=3D%"PRIu64", stopcopy=3D%"PRIu64", postcopy=3D%"PRIu64", total=3D%"PRI=
u64", collected switchover ack pending=3D%"PRIu32", total switchover ack pe=
nding=3D%"PRIu32
>  loadvm_state_setup(void) ""
>  loadvm_state_cleanup(void) ""
>  loadvm_handle_cmd_packaged(unsigned int length) "%u"
> @@ -24,6 +24,7 @@ loadvm_postcopy_ram_handle_discard_header(const char *r=
amid, uint16_t len) "%s:
>  loadvm_process_command(const char *s, uint16_t len) "com=3D%s len=3D%d"
>  loadvm_process_command_ping(uint32_t val) "0x%x"
>  loadvm_approve_switchover_legacy(const char *approver, unsigned int swit=
chover_ack_pending_num_legacy) "Approver %s, switchover_ack_pending_num_leg=
acy %u"
> +loadvm_approve_switchover(const char *approver) "Approver %s"
>  postcopy_ram_listen_thread_exit(void) ""
>  postcopy_ram_listen_thread_start(void) ""
>  qemu_savevm_send_postcopy_advise(void) ""
> @@ -189,7 +190,7 @@ source_return_path_thread_loop_top(void) ""
>  source_return_path_thread_pong(uint32_t val) "0x%x"
>  source_return_path_thread_shut(uint32_t val) "0x%x"
>  source_return_path_thread_resume_ack(uint32_t v) "%"PRIu32
> -source_return_path_thread_switchover_acked(void) ""
> +source_return_path_thread_switchover_acked(uint32_t pending_num) "switch=
over_ack_pending_num %" PRIu32
>  source_return_path_thread_postcopy_package_loaded(void) ""
>  migration_thread_low_pending(uint64_t pending) "%" PRIu64
>  migrate_transferred(uint64_t transferred, uint64_t time_spent, uint64_t =
bandwidth, uint64_t avail_bw, uint64_t size) "transferred %" PRIu64 " time_=
spent %" PRIu64 " bandwidth %" PRIu64 " switchover_bw %" PRIu64 " max_size =
%" PRId64


--Sig_/CSJ8HxZJPLpX/Vv1oKO=DgC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmpM0jcACgkQNasLKJxd
sli2JA/+K+q7ltgbmOnIOVGIvFnBt4jRNEOIoICz37tbq3gxI0kOaysYQRBIEbLW
NEmIfHDR0QhkyVaKB7gWxAkHJSxQBu3UbEl4N4uWGqtUd8Kk2FCSFAZhfmsyg8Xt
KvpPjTz++8FVdXi8pkGM9VbCjZdDOlLOHvEGBB5E8GQUaXaZ/Hn5nc6Z+VzubG/p
PNHLOekZXXE/phiJ130EKTunDNYSZiGT2Nu0XPooGpS3lQdpEzV1d1AR1oJbLKmU
V9YcNY4ZkZnE6TqluGE1JZn99BN5/jmqALMRVnpyEyeH/BPyDTZcujVdB1W0fmE+
c8jCSLn2YSje2kzCWiCMt3C2wE8jySTkD0p1r0t6LF2bSJ65acmXX58w1SAFUD6a
uONiGv1mLRHqsyXaaGoIQyUvOwl7ofE29cSZlcf31UR3moonTlZSyPMR8GbebAMg
Ymxscm42jV74UuIgXvGyRhC/Xz4EOIqtNVW7BDbm71fFR4IxzlKdMMGI6gTGWfc3
sRDSz3VE8w73nX2H69W2OiYUhs/1TPlEodoeMUpaZvVjflqlGtgxi9x3pf0aB5nA
5T04hJZjVEDWQa7lrQHphF8YEOSEQXKZ7nrj3Fo+3dm2hiszWhe/pzrUy3COoXke
892PYFuE6mrAVXE10prQ3PI6VVvx1QGvXdmlL3n77fKsRSKwkZ8=
=8HJ+
-----END PGP SIGNATURE-----

--Sig_/CSJ8HxZJPLpX/Vv1oKO=DgC--

