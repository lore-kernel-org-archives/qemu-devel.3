Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CABFD2F03E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 14:43:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkkH0-0003Pn-Op; Tue, 27 Jan 2026 09:42:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vkkGw-0003O7-6E
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 09:42:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vkkGu-0006P2-0o
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 09:42:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769524940;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TCBblJGIud8NQORnCxWur9UHH2Vnwrdl/q0tiekLvUE=;
 b=cD3TXs7c594EKbp2+LV9YlCHyHdOGUjGQuqBKvguw67gGfYCoFhaT5dWSG1Ce+vuAm4NUe
 WxIQu48Y6kOxLs7ejTX3V32W00UndJ3ef3RKwSq6Pc0HVwYjiC7hrTuFNIvUJ+cmevGbug
 zPjFFHpti6LXVSBlOCdswHjmOZ0JwRY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-ub5SxucLMcyoiNg1N5Yc8w-1; Tue,
 27 Jan 2026 09:42:06 -0500
X-MC-Unique: ub5SxucLMcyoiNg1N5Yc8w-1
X-Mimecast-MFC-AGG-ID: ub5SxucLMcyoiNg1N5Yc8w_1769524922
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 53C0C18002C2; Tue, 27 Jan 2026 14:42:01 +0000 (UTC)
Received: from localhost (unknown [10.2.16.224])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6EF821956095; Tue, 27 Jan 2026 14:42:00 +0000 (UTC)
Date: Tue, 27 Jan 2026 09:41:59 -0500
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
Message-ID: <20260127144159.GA69685@fedora>
References: <20260126194735.46167-1-stefanha@redhat.com>
 <20260126194735.46167-5-stefanha@redhat.com>
 <aXfHu-NsoFpBbXRL@redhat.com> <20260126221343.GA51466@fedora>
 <aXh9QKV68zIrLdLs@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="V94gc5racjN/TiCQ"
Content-Disposition: inline
In-Reply-To: <aXh9QKV68zIrLdLs@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


--V94gc5racjN/TiCQ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2026 at 08:54:24AM +0000, Daniel P. Berrang=E9 wrote:
> On Mon, Jan 26, 2026 at 05:13:43PM -0500, Stefan Hajnoczi wrote:
> > On Mon, Jan 26, 2026 at 07:59:55PM +0000, Daniel P. Berrang=E9 wrote:
> > > On Mon, Jan 26, 2026 at 02:47:34PM -0500, Stefan Hajnoczi wrote:
> > > > Add a vmstate subsection to SCSIDiskState so that scsi-block device=
s can
> > > > transfer their reservation state during live migration. Upon loadin=
g the
> > > > subsection, the destination QEMU invokes the PERSISTENT RESERVE OUT
> > > > command's PREEMPT service action to atomically move the reservation=
 from
> > > > the source I_T nexus to the destination I_T nexus. This results in
> > > > transparent live migration of SCSI reservations.
> > > >=20
> > > > This approach is incomplete since SCSI reservations are cooperative=
 and
> > > > other hosts could interfere. Neither the source QEMU nor the destin=
ation
> > > > QEMU are aware of changes made by other hosts. The assumption is th=
at
> > > > reservation is not taken over by a third host without cooperation f=
rom
> > > > the source host.
> > > >=20
> > > > I considered adding the vmstate subsection to SCSIDevice instead of
> > > > SCSIDiskState, since reservations are part of the SCSI Primary Comm=
ands
> > > > that other devices apart from disks could support. However, due to
> > > > fragility of migrating reservations, we will probably limit support=
 to
> > > > scsi-block and maybe scsi-disk in the future. In the end, I think it
> > > > makes sense to place this within scsi-disk.c.
> > > >=20
> > > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > > ---
> > > >  include/hw/scsi/scsi.h |  1 +
> > > >  hw/core/machine.c      |  4 ++-
> > > >  hw/scsi/scsi-disk.c    | 81 ++++++++++++++++++++++++++++++++++++++=
++-
> > > >  hw/scsi/scsi-generic.c | 82 ++++++++++++++++++++++++++++++++++++++=
++++
> > > >  hw/scsi/trace-events   |  1 +
> > > >  5 files changed, 167 insertions(+), 2 deletions(-)
> > > >=20
> > > > diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
> > > > index c5ec58089b..a3e246dbd9 100644
> > > > --- a/include/hw/scsi/scsi.h
> > > > +++ b/include/hw/scsi/scsi.h
> > > > @@ -253,6 +253,7 @@ SCSIDevice *scsi_device_get(SCSIBus *bus, int c=
hannel, int target, int lun);
> > > > =20
> > > >  /* scsi-generic.c. */
> > > >  extern const SCSIReqOps scsi_generic_req_ops;
> > > > +bool scsi_generic_pr_state_preempt(SCSIDevice *s, Error **errp);
> > > > =20
> > > >  /* scsi-disk.c */
> > > >  #define SCSI_DISK_QUIRK_MODE_PAGE_APPLE_VENDOR             0
> > > > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > > > index 6411e68856..16134f8ce5 100644
> > > > --- a/hw/core/machine.c
> > > > +++ b/hw/core/machine.c
> > > > @@ -38,7 +38,9 @@
> > > >  #include "hw/acpi/generic_event_device.h"
> > > >  #include "qemu/audio.h"
> > > > =20
> > > > -GlobalProperty hw_compat_10_2[] =3D {};
> > > > +GlobalProperty hw_compat_10_2[] =3D {
> > > > +    { "scsi-block", "migrate-pr", "off" },
> > > > +};
> > > >  const size_t hw_compat_10_2_len =3D G_N_ELEMENTS(hw_compat_10_2);
> > > > =20
> > > >  GlobalProperty hw_compat_10_1[] =3D {
> > > > diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> > > > index 76fe5f085b..8845ab1192 100644
> > > > --- a/hw/scsi/scsi-disk.c
> > > > +++ b/hw/scsi/scsi-disk.c
> > > > @@ -28,6 +28,7 @@
> > > >  #include "qemu/hw-version.h"
> > > >  #include "qemu/memalign.h"
> > > >  #include "hw/scsi/scsi.h"
> > > > +#include "migration/misc.h"
> > > >  #include "migration/qemu-file-types.h"
> > > >  #include "migration/vmstate.h"
> > > >  #include "hw/scsi/emulation.h"
> > > > @@ -122,6 +123,7 @@ struct SCSIDiskState {
> > > >       */
> > > >      uint16_t rotation_rate;
> > > >      bool migrate_emulated_scsi_request;
> > > > +    NotifierWithReturn migration_notifier;
> > > >  };
> > > > =20
> > > >  static void scsi_free_request(SCSIRequest *req)
> > > > @@ -2737,6 +2739,25 @@ static SCSIRequest *scsi_new_request(SCSIDev=
ice *d, uint32_t tag, uint32_t lun,
> > > >  }
> > > > =20
> > > >  #ifdef __linux__
> > > > +/*
> > > > + * Preempt on the SCSI Persistent Reservation on the source when m=
igration
> > > > + * fails because the destination may have already preempted and we=
 need to get
> > > > + * the reservation back.
> > > > + */
> > > > +static int scsi_block_migration_notifier(NotifierWithReturn *notif=
ier,
> > > > +                                         MigrationEvent *e, Error =
**errp)
> > > > +{
> > > > +    if (e->type =3D=3D MIG_EVENT_PRECOPY_FAILED) {
> > > > +        SCSIDiskState *s =3D
> > > > +            container_of(notifier, SCSIDiskState, migration_notifi=
er);
> > > > +        SCSIDevice *d =3D &s->qdev;
> > > > +
> > > > +        /* MIG_EVENT_PRECOPY_FAILED cannot fail, so ignore errors =
*/
> > > > +        scsi_generic_pr_state_preempt(d, NULL);
> > >=20
> > > I feel like we ought to 'warn_report'  any errors related to failing
> > > to acquire persistent reservations.
> > >=20
> > > In the unlikely event an error occurs, whomever has to deal with
> > > the resulting support ticket will want to know something went wrong
> > > from the QEMU logs.
> >=20
> > Good idea.
> >=20
> > I'm also not sure how to best approach logging in general. Usually QEMU
> > does little logging when the VM is running, but it has become
> > increasingly difficult to get information out of QEMU via tracing or
> > monitor commands since nowadays QEMU might be running in a locked down
> > container. Debugging PR migration issues would be easiest if the trace
> > events introduced in this series were actually printfs to stderr, but
> > that's not traditionally how QEMU did things.
>=20
> I wouldn't overthink this - just pass a locall "Error *err" object
> instead of NULL, and then warn_report_err on the result. Just needs
> to be a marker in the that something has gone wrong, which we could
> not propagate to the mgmt app in the normal manner since we have no
> error path here.

Yes, sounds good.

>=20
> Debugging /anything/ in QEMU is easiest if the trace events were
> actually prints, but that thinking leads to us enabling tracing
> all the time, everywhere which is impractical
>=20
> At the same time it is common for apps to have some level of
> "always on" debugging collected and so we perhaps do have a
> general conceptual gap in QEMU.
>=20
> If we thinking of trace events as being equiv to "DEBUG" level
> log events, would it help if we could annotate a subset of
> trace events as "INFO" level and do something with them by
> default. eg perhaps we have an ring buffer tracing target that
> collects "INFO" events continuously and can be asked to dump
> out its state in error scenarios ?

I need to research SystemTap inside container scenarios more first.
Ideally we could rely on the DTrace probes, but it needs to be easy for
users to collect information from their containers. I suspect there will
be permission problems as well as multiple steps required to just find
the container where QEMU is running, which makes this hard for users.

Stefan

--V94gc5racjN/TiCQ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAml4zrcACgkQnKSrs4Gr
c8gTyggApFaG3TLZz3pWr+OseyUdYzyte81ADwMOp5KaeFeRyMfSI8rdyzFUpXvR
Xcz5UwR7YvQeSSQWUNviHLjyaEZkwVlm9AYO1XNX1w+9St4zjpnAPu9kZVLPDqaY
XeSlFuNtACDdiPcFxbIq5u3u4dE0d3d4pTP2ewtGBJ/BJjslpPi+p/LyPldAstMf
nfD358GKsQmGQWBafeYUmCGYfLytBlorWZZc/yLlLjq6wt5AVMpM7SAZa+gL7ljH
59rNmhQJx/qUZWAy+nF64mNejR1z1hhTXK7Lj2jtpjPzU++4AiN4fI8BOkR38S8k
KpOJ2AbzCU/ciwAVGiIKXJsksI0s9A==
=bJzv
-----END PGP SIGNATURE-----

--V94gc5racjN/TiCQ--


