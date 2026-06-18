Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D91B5CD98F8
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 14:56:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waE9f-0003JJ-UX; Thu, 18 Jun 2026 10:55:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1waE9e-0003J1-J6
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 10:55:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1waE9c-0007M5-5M
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 10:55:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781794538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UqLYR2a26ngcT6VtL/lhFvPgBF1HxtOHDnA7IXId9yo=;
 b=bcH8opMbay5FcYtTWMfPnhzN0KHnXdRaNSQVjVqDPOfbvXy4+kYC2oIB98R05kPOwADZCz
 XM4J2negkhwafSbTi0fOeFTkhnsf845JJpfEaTsGmvzjrVz7UDekxkg/2jWqxqv/kkyW0X
 tzB79tn7lGmT96brEfOojsQxDJ9qEnk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-495-py7IGNnPOfetsf5aJrV6Ag-1; Thu,
 18 Jun 2026 10:55:35 -0400
X-MC-Unique: py7IGNnPOfetsf5aJrV6Ag-1
X-Mimecast-MFC-AGG-ID: py7IGNnPOfetsf5aJrV6Ag_1781794533
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5D22F18001F9; Thu, 18 Jun 2026 14:55:33 +0000 (UTC)
Received: from localhost (unknown [10.2.16.120])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1996730001BE; Thu, 18 Jun 2026 14:55:31 +0000 (UTC)
Date: Thu, 18 Jun 2026 10:55:31 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Fam Zheng <fam@euphon.net>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Maxim Levitsky <mlevitsk@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, John Snow <jsnow@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH v7 09/13] device-core: use atomic_set on .realized property
Message-ID: <20260618145531.GB720244@fedora>
References: <20201006123904.610658-1-mlevitsk@redhat.com>
 <20201006123904.610658-10-mlevitsk@redhat.com>
 <f67389ae-4b0e-46f5-a122-d83464f192f4@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bZJ4tyrxcymaPKly"
Content-Disposition: inline
In-Reply-To: <f67389ae-4b0e-46f5-a122-d83464f192f4@oss.qualcomm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--bZJ4tyrxcymaPKly
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 18, 2026 at 11:39:11AM +0200, Philippe Mathieu-Daud=E9 wrote:
> Hi,
>=20
> Old patch committed as a23151e8cc8 (Oct 2020).
> I'm revisiting it in the context of dynamic heterogeneous machines.
>=20
> On 6/10/20 14:39, Maxim Levitsky wrote:
> > Some code might race with placement of new devices on a bus.
>=20
> So IIUC at least 2 vCPUs plug distinct devices on the same bus,
> and the problem is the bus slot assigned for the device. What is
> deciding the free slot, the guest code or QEMU?

Hi Philippe,
The issue was not about a race in slot assignment, it was about hotplug
racing with an IOThread. When the guest triggers device emulation
activity in an IOThread and the monitor thread is doing hotplug, then
there was a race condition since the IOThread does not execute under the
Big QEMU Lock.

In other words, the virtio-scsi device model must not see partially
hotplugged/unplugged devices when processing SCSI requests in an
IOThread.

>=20
> > We currently first place a (unrealized) device on the bus
> > and then realize it.
>=20
> Sound like ill design. Maybe resulting from the unclear definition
> on what "realized" means. "Guest visible"? "Wired on some bus"?

Back when everything ran inside the BQL it worked fine because device
emulation activity would not happen during hotplug. Hotplug was atomic.

IOThreads broke the BQL assumption and that's why the race condition
occurred.

>=20
> Something I tried to clarify once (now outdated):
> https://lore.kernel.org/qemu-devel/20240209123226.32576-1-philmd@linaro.o=
rg/
>=20
> A vCPU thread shouldn't poke at QOM/QDev internals. When it accesses
> a device (to check "is it out of reset?"), this is already existing
> realized.
>=20
> Actually, when the guest asks to assign the device to the bus, the
> device is already existing (from guest PoV), so must be realized.

I'm not sure I understand. The guest doesn't ask to assign a device to a
bus. QEMU assigns devices to busses. (I'm ignoring cooperative hotplug
and hot unplug workflows where the device and the driver communicate in
a multi-step process.)

>=20
> > As a workaround, users that scan the child device list, can
> > check the realized property to see if it is safe to access such a devic=
e.
> > Use an atomic write here too to aid with this.
>=20
> I'd appreciate to be pointed at real use case we fixed here, to
> better figure what could be reworked on the QBus / QDev layer in
> order to not depend anymore on this workaround.

SCSI controller emulation involves iterating over the SCSI devices on
the bus. This can run in an IOThread outside the BQL. Hotplug modifies
the bus and this needs to be done in a thread-safe way. Otherwise the
IOThread seem partially hotplugged/hot unplugged devices on the SCSI
bus.

This patch series provided a way for devices (e.g. virtio-scsi) that
face this problem to safely skip devices on their busses that are not
realized.

> > A separate discussion is what to do with devices that are unrealized:
> > It looks like for this case we only call the hotplug handler's unplug
> > callback and its up to it to unrealize the device.
>=20
> Likely the hotplugging path is what needs to be improved (I'm seeing
> a similar problem with vCPU hotplug).
>=20
> Thanks,
>=20
> Phil.
>=20
> > An atomic operation doesn't cause harm for this code path though.
> >=20
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Message-Id: <20200913160259.32145-6-mlevitsk@redhat.com>
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >   hw/core/qdev.c         | 19 ++++++++++++++++++-
> >   include/hw/qdev-core.h |  2 ++
> >   2 files changed, 20 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> > index 59e5e710b7..fc4daa36fa 100644
> > --- a/hw/core/qdev.c
> > +++ b/hw/core/qdev.c
> > @@ -946,7 +946,25 @@ static void device_set_realized(Object *obj, bool =
value, Error **errp)
> >               }
> >          }
> > +       qatomic_store_release(&dev->realized, value);
> > +
> >       } else if (!value && dev->realized) {
> > +
> > +        /*
> > +         * Change the value so that any concurrent users are aware
> > +         * that the device is going to be unrealized
> > +         *
> > +         * TODO: change .realized property to enum that states
> > +         * each phase of the device realization/unrealization
> > +         */
> > +
> > +        qatomic_set(&dev->realized, value);
> > +        /*
> > +         * Ensure that concurrent users see this update prior to
> > +         * any other changes done by unrealize.
> > +         */
> > +        smp_wmb();
> > +
> >           QLIST_FOREACH(bus, &dev->child_bus, sibling) {
> >               qbus_unrealize(bus);
> >           }
> > @@ -961,7 +979,6 @@ static void device_set_realized(Object *obj, bool v=
alue, Error **errp)
> >       }
> >       assert(local_err =3D=3D NULL);
> > -    dev->realized =3D value;
> >       return;
> >   child_realize_fail:
> > diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> > index 2c6307e3ed..868973319e 100644
> > --- a/include/hw/qdev-core.h
> > +++ b/include/hw/qdev-core.h
> > @@ -163,6 +163,8 @@ struct NamedClockList {
> >   /**
> >    * DeviceState:
> >    * @realized: Indicates whether the device has been fully constructed.
> > + *            When accessed outsize big qemu lock, must be accessed wi=
th
> > + *            atomic_load_acquire()
> >    * @reset: ResettableState for the device; handled by Resettable inte=
rface.
> >    *
> >    * This structure should not be accessed directly.  We declare it here
>=20

--bZJ4tyrxcymaPKly
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmo0BuIACgkQnKSrs4Gr
c8hw7wf8CFf00aOHekQaoeSx6Rvwdry0l29dS0FByFxUhpYxHZ9D7QFxTC/FpyNL
2duxGuXy1+Wfis7l82BXsL8938PR2eER5DGuVggrjv8Oodj3s+ty/VXg6g7xqbX1
AiRPiJyGUKmmZRMyPTbhnNFtRGO/nEiIdVdoLvK8duQ4hnIghhXWmJrNT7vRTY68
NnXHvpfOpCemQfYHd5ge/C69yaDJuP6r4VayWKi+U/jGcT2AtojiVKUPL/Rx+AmM
CciHFMqZjsFEH46Jya7zWfFI/5uJl3Jte+6OkXNxuP8GNO4XarSMQ7KYt8sljX3e
yJ0sSVvHwV5gYQimJv032KyLPxHAZQ==
=MPlQ
-----END PGP SIGNATURE-----

--bZJ4tyrxcymaPKly--


