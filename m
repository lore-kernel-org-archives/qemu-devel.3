Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24A62D1951F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 22:14:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkUqM-00010S-3J; Mon, 26 Jan 2026 17:13:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vkUqK-0000zM-PY
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 17:13:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vkUqI-0001tg-0P
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 17:13:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769465632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4MZLX2+upS/VkuwY9o1aM4nOb1OdVW5n0BMk1vtKtE4=;
 b=cKVue89oUh0mvgeoxieTEHzjBGOlil4pMPMlUN06D8I+jw5R3l5CQ2SFU1OM4vwmn+h9d2
 V1mGsv6mZouJWnh0mpd5A75CD+aW9KcgwVXbUp9WhTSAhO+whq1sXWJDaQe+PJL2m18/F3
 7qlTFPonGhcBVqTkr1odkTJv/KBachE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-MQKNEUtdPJOztUWl7GgCjw-1; Mon,
 26 Jan 2026 17:13:48 -0500
X-MC-Unique: MQKNEUtdPJOztUWl7GgCjw-1
X-Mimecast-MFC-AGG-ID: MQKNEUtdPJOztUWl7GgCjw_1769465627
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DC776180034A; Mon, 26 Jan 2026 22:13:46 +0000 (UTC)
Received: from localhost (unknown [10.2.17.0])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 38F2918004D8; Mon, 26 Jan 2026 22:13:45 +0000 (UTC)
Date: Mon, 26 Jan 2026 17:13:43 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, pkrempa@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alberto Faria <afaria@redhat.com>, Hannes Reinecke <hare@suse.de>,
 Zhao Liu <zhao1.liu@intel.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Fam Zheng <fam@euphon.net>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Qing Wang <qinwang@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH v2 4/5] scsi: save/load SCSI reservation state
Message-ID: <20260126221343.GA51466@fedora>
References: <20260126194735.46167-1-stefanha@redhat.com>
 <20260126194735.46167-5-stefanha@redhat.com>
 <aXfHu-NsoFpBbXRL@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="EJFbMGIYtMrSAM49"
Content-Disposition: inline
In-Reply-To: <aXfHu-NsoFpBbXRL@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--EJFbMGIYtMrSAM49
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 26, 2026 at 07:59:55PM +0000, Daniel P. Berrang=E9 wrote:
> On Mon, Jan 26, 2026 at 02:47:34PM -0500, Stefan Hajnoczi wrote:
> > Add a vmstate subsection to SCSIDiskState so that scsi-block devices can
> > transfer their reservation state during live migration. Upon loading the
> > subsection, the destination QEMU invokes the PERSISTENT RESERVE OUT
> > command's PREEMPT service action to atomically move the reservation from
> > the source I_T nexus to the destination I_T nexus. This results in
> > transparent live migration of SCSI reservations.
> >=20
> > This approach is incomplete since SCSI reservations are cooperative and
> > other hosts could interfere. Neither the source QEMU nor the destination
> > QEMU are aware of changes made by other hosts. The assumption is that
> > reservation is not taken over by a third host without cooperation from
> > the source host.
> >=20
> > I considered adding the vmstate subsection to SCSIDevice instead of
> > SCSIDiskState, since reservations are part of the SCSI Primary Commands
> > that other devices apart from disks could support. However, due to
> > fragility of migrating reservations, we will probably limit support to
> > scsi-block and maybe scsi-disk in the future. In the end, I think it
> > makes sense to place this within scsi-disk.c.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  include/hw/scsi/scsi.h |  1 +
> >  hw/core/machine.c      |  4 ++-
> >  hw/scsi/scsi-disk.c    | 81 ++++++++++++++++++++++++++++++++++++++++-
> >  hw/scsi/scsi-generic.c | 82 ++++++++++++++++++++++++++++++++++++++++++
> >  hw/scsi/trace-events   |  1 +
> >  5 files changed, 167 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
> > index c5ec58089b..a3e246dbd9 100644
> > --- a/include/hw/scsi/scsi.h
> > +++ b/include/hw/scsi/scsi.h
> > @@ -253,6 +253,7 @@ SCSIDevice *scsi_device_get(SCSIBus *bus, int chann=
el, int target, int lun);
> > =20
> >  /* scsi-generic.c. */
> >  extern const SCSIReqOps scsi_generic_req_ops;
> > +bool scsi_generic_pr_state_preempt(SCSIDevice *s, Error **errp);
> > =20
> >  /* scsi-disk.c */
> >  #define SCSI_DISK_QUIRK_MODE_PAGE_APPLE_VENDOR             0
> > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > index 6411e68856..16134f8ce5 100644
> > --- a/hw/core/machine.c
> > +++ b/hw/core/machine.c
> > @@ -38,7 +38,9 @@
> >  #include "hw/acpi/generic_event_device.h"
> >  #include "qemu/audio.h"
> > =20
> > -GlobalProperty hw_compat_10_2[] =3D {};
> > +GlobalProperty hw_compat_10_2[] =3D {
> > +    { "scsi-block", "migrate-pr", "off" },
> > +};
> >  const size_t hw_compat_10_2_len =3D G_N_ELEMENTS(hw_compat_10_2);
> > =20
> >  GlobalProperty hw_compat_10_1[] =3D {
> > diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> > index 76fe5f085b..8845ab1192 100644
> > --- a/hw/scsi/scsi-disk.c
> > +++ b/hw/scsi/scsi-disk.c
> > @@ -28,6 +28,7 @@
> >  #include "qemu/hw-version.h"
> >  #include "qemu/memalign.h"
> >  #include "hw/scsi/scsi.h"
> > +#include "migration/misc.h"
> >  #include "migration/qemu-file-types.h"
> >  #include "migration/vmstate.h"
> >  #include "hw/scsi/emulation.h"
> > @@ -122,6 +123,7 @@ struct SCSIDiskState {
> >       */
> >      uint16_t rotation_rate;
> >      bool migrate_emulated_scsi_request;
> > +    NotifierWithReturn migration_notifier;
> >  };
> > =20
> >  static void scsi_free_request(SCSIRequest *req)
> > @@ -2737,6 +2739,25 @@ static SCSIRequest *scsi_new_request(SCSIDevice =
*d, uint32_t tag, uint32_t lun,
> >  }
> > =20
> >  #ifdef __linux__
> > +/*
> > + * Preempt on the SCSI Persistent Reservation on the source when migra=
tion
> > + * fails because the destination may have already preempted and we nee=
d to get
> > + * the reservation back.
> > + */
> > +static int scsi_block_migration_notifier(NotifierWithReturn *notifier,
> > +                                         MigrationEvent *e, Error **er=
rp)
> > +{
> > +    if (e->type =3D=3D MIG_EVENT_PRECOPY_FAILED) {
> > +        SCSIDiskState *s =3D
> > +            container_of(notifier, SCSIDiskState, migration_notifier);
> > +        SCSIDevice *d =3D &s->qdev;
> > +
> > +        /* MIG_EVENT_PRECOPY_FAILED cannot fail, so ignore errors */
> > +        scsi_generic_pr_state_preempt(d, NULL);
>=20
> I feel like we ought to 'warn_report'  any errors related to failing
> to acquire persistent reservations.
>=20
> In the unlikely event an error occurs, whomever has to deal with
> the resulting support ticket will want to know something went wrong
> from the QEMU logs.

Good idea.

I'm also not sure how to best approach logging in general. Usually QEMU
does little logging when the VM is running, but it has become
increasingly difficult to get information out of QEMU via tracing or
monitor commands since nowadays QEMU might be running in a locked down
container. Debugging PR migration issues would be easiest if the trace
events introduced in this series were actually printfs to stderr, but
that's not traditionally how QEMU did things.

>=20
>=20
> > @@ -3209,6 +3240,46 @@ static const Property scsi_hd_properties[] =3D {
> >      DEFINE_BLOCK_CHS_PROPERTIES(SCSIDiskState, qdev.conf),
> >  };
> > =20
> > +#ifdef __linux__
> > +static bool scsi_disk_pr_state_post_load_errp(void *opaque, int versio=
n_id, Error **errp)
> > +{
> > +    SCSIDiskState *s =3D opaque;
> > +    SCSIDevice *dev =3D &s->qdev;
> > +
> > +    return scsi_generic_pr_state_preempt(dev, errp);
> > +}
>=20
> What if there are multiple SCSI disks, and on the target host
> we successful acquire the reservation for the 1st, but fail
> the second ? Are we ignoring the failure of the second, or
> are we discarding the reservation of the 1st and failing
> migration ?   Should we warn_report here too ?

Each disk is its own scsi-block device.
scsi_disk_pr_state_post_load_errp() will be invoked for each such
device. If one of these calls fails, the migration will abort and the
errp here will reported.

The rollback on the source host doesn't care which devices
succeeded/failed, it performs idempotent PREEMPT operations for all
devices so we're sure all reservations are back on the source host after
a failed migration.

>=20
> > +
> > +static bool scsi_disk_pr_state_needed(void *opaque)
> > +{
> > +    SCSIDiskState *s =3D opaque;
> > +    SCSIPRState *pr_state =3D &s->qdev.pr_state;
> > +    bool ret;
> > +
> > +    if (!s->qdev.migrate_pr) {
> > +        return false;
> > +    }
> > +
> > +    /* A reservation requires a key, so checking this field is enough =
*/
> > +    WITH_QEMU_LOCK_GUARD(&pr_state->mutex) {
> > +        ret =3D pr_state->key;
> > +    }
> > +    return ret;
> > +}
> > +
> > +static const VMStateDescription vmstate_scsi_disk_pr_state =3D {
> > +    .name =3D "scsi-disk/pr",
> > +    .version_id =3D 1,
> > +    .minimum_version_id =3D 1,
> > +    .post_load_errp =3D scsi_disk_pr_state_post_load_errp,
> > +    .needed =3D scsi_disk_pr_state_needed,
> > +    .fields =3D (const VMStateField[]) {
> > +        VMSTATE_UINT64(qdev.pr_state.key, SCSIDiskState),
> > +        VMSTATE_UINT8(qdev.pr_state.resv_type, SCSIDiskState),
> > +        VMSTATE_END_OF_LIST()
> > +    }
> > +};
> > +#endif /* __linux__ */
> > +
> >  static const VMStateDescription vmstate_scsi_disk_state =3D {
> >      .name =3D "scsi-disk",
> >      .version_id =3D 1,
> > @@ -3221,7 +3292,13 @@ static const VMStateDescription vmstate_scsi_dis=
k_state =3D {
> >          VMSTATE_BOOL(tray_open, SCSIDiskState),
> >          VMSTATE_BOOL(tray_locked, SCSIDiskState),
> >          VMSTATE_END_OF_LIST()
> > -    }
> > +    },
> > +    .subsections =3D (const VMStateDescription * const []) {
> > +#ifdef __linux__
> > +        &vmstate_scsi_disk_pr_state,
> > +#endif
> > +        NULL
> > +    },
> >  };
> > =20
> >  static void scsi_hd_class_initfn(ObjectClass *klass, const void *data)
> > @@ -3301,6 +3378,7 @@ static const Property scsi_block_properties[] =3D=
 {
> >                        -1),
> >      DEFINE_PROP_UINT32("io_timeout", SCSIDiskState, qdev.io_timeout,
> >                         DEFAULT_IO_TIMEOUT),
> > +    DEFINE_PROP_BOOL("migrate-pr", SCSIDiskState, qdev.migrate_pr, tru=
e),
> >  };
> > =20
> >  static void scsi_block_class_initfn(ObjectClass *klass, const void *da=
ta)
> > @@ -3310,6 +3388,7 @@ static void scsi_block_class_initfn(ObjectClass *=
klass, const void *data)
> >      SCSIDiskClass *sdc =3D SCSI_DISK_BASE_CLASS(klass);
> > =20
> >      sc->realize      =3D scsi_block_realize;
> > +    sc->unrealize    =3D scsi_block_unrealize;
> >      sc->alloc_req    =3D scsi_block_new_request;
> >      sc->parse_cdb    =3D scsi_block_parse_cdb;
> >      sdc->dma_readv   =3D scsi_block_dma_readv;
> > diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
> > index 392647e2b2..e44979faeb 100644
> > --- a/hw/scsi/scsi-generic.c
> > +++ b/hw/scsi/scsi-generic.c
> > @@ -419,6 +419,88 @@ static void scsi_handle_persistent_reserve_out_rep=
ly(
> >      }
> >  }
> > =20
> > +static bool scsi_generic_pr_register(SCSIDevice *s, uint64_t key, Erro=
r **errp)
> > +{
> > +    uint8_t cmd[10] =3D {};
> > +    uint8_t buf[24] =3D {};
> > +    uint64_t key_be =3D cpu_to_be64(key);
> > +    int ret;
> > +
> > +    cmd[0] =3D PERSISTENT_RESERVE_OUT;
> > +    cmd[1] =3D PRO_REGISTER;
> > +    cmd[8] =3D sizeof(buf);
> > +    memcpy(&buf[8], &key_be, sizeof(key_be));
> > +
> > +    ret =3D scsi_SG_IO(s->conf.blk, SG_DXFER_TO_DEV, cmd, sizeof(cmd),
> > +                     buf, sizeof(buf), s->io_timeout, errp);
> > +    if (ret < 0) {
> > +        error_prepend(errp, "PERSISTENT RESERVE OUT with REGISTER");
> > +        return false;
> > +    }
> > +    return true;
> > +}
> > +
> > +static bool scsi_generic_pr_preempt(SCSIDevice *s, uint64_t key, uint8=
_t resv_type, Error **errp)
> > +{
> > +    uint8_t cmd[10] =3D {};
> > +    uint8_t buf[24] =3D {};
> > +    uint64_t key_be =3D cpu_to_be64(key);
> > +    int ret;
> > +
> > +    cmd[0] =3D PERSISTENT_RESERVE_OUT;
> > +    cmd[1] =3D PRO_PREEMPT;
> > +    cmd[2] =3D resv_type & 0xf;
> > +    cmd[8] =3D sizeof(buf);
> > +    memcpy(&buf[0], &key_be, sizeof(key_be));
> > +    memcpy(&buf[8], &key_be, sizeof(key_be));
> > +
> > +    ret =3D scsi_SG_IO(s->conf.blk, SG_DXFER_TO_DEV, cmd, sizeof(cmd),
> > +                     buf, sizeof(buf), s->io_timeout, errp);
> > +    if (ret < 0) {
> > +        error_prepend(errp, "PERSISTENT RESERVE OUT with PREEMPT");
> > +        return false;
> > +    }
> > +    return true;
> > +}
> > +
> > +/* Register keys and preempt reservations after live migration */
> > +bool scsi_generic_pr_state_preempt(SCSIDevice *s, Error **errp)
> > +{
> > +    SCSIPRState *pr_state =3D &s->pr_state;
> > +    uint64_t key;
> > +    uint8_t resv_type;
> > +
> > +    WITH_QEMU_LOCK_GUARD(&pr_state->mutex) {
> > +        key =3D pr_state->key;
> > +        resv_type =3D pr_state->resv_type;
> > +    }
> > +
> > +    trace_scsi_generic_pr_state_preempt(key, resv_type);
> > +
> > +    if (key) {
> > +        if (!scsi_generic_pr_register(s, key, errp)) {
> > +            return false;
> > +        }
> > +
> > +        /*
> > +         * Two cases:
> > +         *
> > +         * 1. There is no reservation (resv_type is 0) and the other I=
_T nexus
> > +         *    will be unregistered. This is important so the source ho=
st does
> > +         *    not leak registered keys across live migration.
> > +         *
> > +         * 2. There is a reservation (resv_type is not 0) and the othe=
r I_T
> > +         *    nexus will be unregistered and its reservation is atomic=
ally
> > +         *    taken over by us. This is the scenario where a reservati=
on is
> > +         *    migrated along with the guest.
> > +         */
> > +        if (!scsi_generic_pr_preempt(s, key, resv_type, errp)) {
> > +            return false;
> > +        }
> > +    }
> > +    return true;
> > +}
> > +
> >  static void scsi_read_complete(void * opaque, int ret)
> >  {
> >      SCSIGenericReq *r =3D (SCSIGenericReq *)opaque;
> > diff --git a/hw/scsi/trace-events b/hw/scsi/trace-events
> > index ff92fff7c5..a8ac1e7f1d 100644
> > --- a/hw/scsi/trace-events
> > +++ b/hw/scsi/trace-events
> > @@ -391,3 +391,4 @@ scsi_generic_aio_sgio_command(uint32_t tag, uint8_t=
 cmd, uint32_t timeout) "gene
> >  scsi_generic_ioctl_sgio_command(uint8_t cmd, uint32_t timeout) "generi=
c ioctl sgio: cmd=3D0x%x timeout=3D%u"
> >  scsi_generic_ioctl_sgio_done(uint8_t cmd, int ret, uint8_t status, uin=
t8_t host_status) "generic ioctl sgio: cmd=3D0x%x ret=3D%d status=3D0x%x ho=
st_status=3D0x%x"
> >  scsi_generic_persistent_reserve_out_reply(uint8_t service_action, uint=
8_t resv_type, uint64_t old_key, uint64_t new_key) "persistent reserve out =
reply service_action=3D%u resv_type=3D%u old_key=3D0x%" PRIx64 " new_key=3D=
0x%" PRIx64
> > +scsi_generic_pr_state_preempt(uint64_t key, uint8_t resv_type) "key=3D=
0x%" PRIx64 " resv_type=3D%u"
> > --=20
> > 2.52.0
> >=20
> >=20
>=20
> With regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>=20

--EJFbMGIYtMrSAM49
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAml35xcACgkQnKSrs4Gr
c8j8awf/f/yj6JEZ9nlSMNfjKnO2+ux+CIE0QGWLsdHFpLFL4BGCDja5ep3kCfMI
LveLnYALFTgQ0hSW5Un10+GL3kEdbDClgj9GaFqTJIFoJfeWnymTPdcpZpCn8Qdv
fPGJgR5MdBE1VwfylZ7g87CcpXqK/JszYILpGV6Cy5nU8TwDHRAkG0SK6WHdr4Y4
QviHHoUU9maFzW0KYa0RzFauPs16ph64aI5OMxp2ZmMm/wIj8OMLDNXC9UMP7flZ
Do1pW/eBUkkQQvjkRzNWvlj8YllFZ9X+V5eVMYf50FcZhgkA2SX1ahe1gkIYSel7
pAUDwQ/TZZBv+mtgkJb9b9yJd37wfA==
=w0rP
-----END PGP SIGNATURE-----

--EJFbMGIYtMrSAM49--


