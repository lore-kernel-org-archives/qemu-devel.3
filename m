Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45C7CC52D7C
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 18:08:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdZRx-0002I7-1Y; Mon, 12 Aug 2024 14:07:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sdZRv-0002Gt-A1
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 14:07:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sdZRs-0003PN-AM
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 14:07:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723486034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QD0HNZ6kq9AKfGA5CsRRcaN5eG1tb8p00PVRDFiXyCQ=;
 b=fjULiN5wuKCYAqZ8ws9jhDKOYM/HMcezdBdLBq6UnGq7u0NQ+gNM/iPrMnE3wp0rZSkHs0
 9QEWcOow813vXDOkdQIuo7LzLh6gJJrHVrAyaUJKn7CdpQwaz7Zr8KM+x4ebk+JJS/HkEo
 qTo3u6qx6Dd6Lxdi/IKk0wYhzZi+BoE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-599-Ag0t2VxrMhWzoW-wc-0H1A-1; Mon,
 12 Aug 2024 14:07:09 -0400
X-MC-Unique: Ag0t2VxrMhWzoW-wc-0H1A-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A754518EB226; Mon, 12 Aug 2024 18:07:08 +0000 (UTC)
Received: from localhost (unknown [10.2.16.252])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B615E1955F66; Mon, 12 Aug 2024 18:07:07 +0000 (UTC)
Date: Mon, 12 Aug 2024 14:07:06 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, pkrempa@redhat.com,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH v2 1/2] qdev-monitor: avoid QemuOpts in QMP device_add
Message-ID: <20240812180706.GB69160@fedora.redhat.com>
References: <20240801140552.1021693-1-stefanha@redhat.com>
 <20240801140552.1021693-2-stefanha@redhat.com>
 <875xsj73qn.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="zq57n4DBoUh452BA"
Content-Disposition: inline
In-Reply-To: <875xsj73qn.fsf@pond.sub.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


--zq57n4DBoUh452BA
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 02, 2024 at 10:01:20AM +0200, Markus Armbruster wrote:
> Stefan Hajnoczi <stefanha@redhat.com> writes:
>=20
> > The QMP device_add monitor command converts the QDict arguments to
> > QemuOpts and then back again to QDict. This process only supports scalar
> > types. Device properties like virtio-blk-pci's iothread-vq-mapping (an
> > array of objects) are silently dropped by qemu_opts_from_qdict() during
> > the QemuOpts conversion even though QAPI is capable of validating them.
> > As a result, hotplugging virtio-blk-pci devices with the
> > iothread-vq-mapping property does not work as expected (the property is
> > ignored).
> >
> > Get rid of the QemuOpts conversion in qmp_device_add() and call
> > qdev_device_add_from_qdict() with from_json=3Dtrue. Using the QMP
> > command's QDict arguments directly allows non-scalar properties.
> >
> > The HMP is also adjusted since qmp_device_add()'s now expects properly
> > typed JSON arguments and cannot be used from HMP anymore. Move the code
> > that was previously in qmp_device_add() (with QemuOpts conversion and
> > from_json=3Dfalse) into hmp_device_add() so that its behavior is
> > unchanged.
> >
> > This patch changes the behavior of QMP device_add but not HMP
> > device_add. QMP clients that sent incorrectly typed device_add QMP
> > commands no longer work. This is a breaking change but clients should be
> > using the correct types already. See the netdev_add QAPIfication in
> > commit db2a380c8457 for similar reasoning and object-add in commit
> > 9151e59a8b6e. Unlike those commits, we continue to rely on 'gen': false
> > for the time being.
> >
> > Move the drain_call_rcu() invocation into qdev_device_add_from_qdict()
> > so all callers benefit from it automatically. This avoids code
> > duplication.
> >
> > Markus helped me figure this out and even provided a draft patch. The
> > code ended up very close to what he suggested.
> >
> > Suggested-by: Markus Armbruster <armbru@redhat.com>
> > Cc: Daniel P. Berrang=E9 <berrange@redhat.com>
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  system/qdev-monitor.c | 56 ++++++++++++++++++++++---------------------
> >  1 file changed, 29 insertions(+), 27 deletions(-)
> >
> > diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
> > index 6af6ef7d66..8a756b1a91 100644
> > --- a/system/qdev-monitor.c
> > +++ b/system/qdev-monitor.c
> > @@ -725,6 +725,17 @@ err_del_dev:
> >      if (dev) {
> >          object_unparent(OBJECT(dev));
> >          object_unref(OBJECT(dev));
> > +
> > +        /*
> > +         * Drain all pending RCU callbacks. This is done because
> > +         * some bus related operations can delay a device removal
> > +         * (in this case this can happen if device is added and then
> > +         * removed due to a configuration error)
> > +         * to a RCU callback, but user might expect that this interface
> > +         * will finish its job completely once qmp command returns res=
ult
> > +         * to the user
> > +         */
> > +        drain_call_rcu();
> >      }
> >      return NULL;
> >  }
>=20
> Moving this from qmp_device_add() adds RCU draining to call chains not
> going through qmp_device_add().
>=20
> Can adding it hurt?  I guess it can't.
>=20
> Can it fix bugs?  I don't know.
>=20
> Let's review the callers of qdev_device_add_from_qdict():
>=20
> * qdev_device_add()
>=20
>   - called from qmp_device_add()
>=20
>     No change.
>=20
>   - called from device_init_func() called from qemu_create_cli_devices()
>=20
>     See below.
>=20
>   - called from usbback_portid_add() called from usbback_process_port()
>     called from usbback_backend_changed()
>=20
>     =B7 called from usbback_init()
>=20
>     =B7 called as XenDevOps method backend_changed()
>=20
>     This is Xen.  We now drain pending RCU callbacks.  Impact?  Beats
>     me.
>=20
> * qemu_create_cli_devices() called from qmp_x_exit_preconfig()
>=20
>   - as QMP command with -preconfig, phase must be
>     PHASE_MACHINE_INITIALIZED
>=20
>   - called from qemu_init() without -preconfig
>=20
>   We now drain pending RCU callbacks.  Can any be pending at this
>   early point?  If not, the change is a no-op.
>=20
> * failover_add_primary() called from virtio_net_set_features() called as
>   VirtioDeviceClass method set_features()
>=20
>   This is virtio-net failover.  We now drain pending RCU callbacks.
>   Impact?  Beats me.
>=20
> My gut feeling is "improvement, possibly even a bug fix".  It deserves
> its own commit, doesn't it?

I thought I'd checked it, but now that I have reviewed the functions you
looked at, I no longer think it's safe to move drain_call_rcu() into
qdev_device_add_from_qdict(). drain_call_rcu() drops the BQL and must
not be called from non-reentrant multi-threaded code paths.

For example, if drain_call_rcu() is called from device emulation code
then another vCPU thread could execute that same device's emulation code
while the BQL is dropped. That's usually unsafe because most device
emulation code only expects to run in one thread at any given time
thanks to the BQL.

Here are the cases:
- qemu_create_cli_devices: safe because this happens before device
  emulation runs in vCPU threads
- Xen: safe because there are no vCPU threads when QEMU just provides
  device emulation in a normal Xen system. But I'm not sure if usbback
  can also be used in a QEMU's Xen HVM guest mode where KVM handles
  vCPUs, it might be a problem there.
- virtio_net_set_features() -> failover_add_primary() is unsafe. Another
  vCPU thread could enter virtio-net emulation code while the thread
  running virtio_net_set_features() drops the lock.

I think it's better to duplicate drain_call_rcu() into hmp_device_add()
than to risk breaking the other code paths.

Stefan

--zq57n4DBoUh452BA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAma6T0oACgkQnKSrs4Gr
c8gWbggAhCA0FnL70uvtDj6/uPNgOogyjbKBbr5D/rkWsFv94mX27ayIujkFr/p6
SxLx/odR/F9jT95GNbDZOcXqK8f279KjBRpEyEYIQe20w8i5ZLWsdREv180EfmdQ
rh3U1ux91ZzcG6p30EwUyAbSbRj6LugotDANcwIB59pKJHMmh6uTK1qRNdR/vROu
AKEPEayuQcghmJhruspj63RMbtuWIVMFs/6PruoOHskprha439c0oTU/yna3HeMU
nISoLFMkQEu+GGZ2KLfm+8cww6bKIF4Tt8IS1UmaEeiweP4HCS6ddAEiVklvyc1j
NHX6Tp8/hsB3YHb16tvlg1kL5nDRXw==
=jqWs
-----END PGP SIGNATURE-----

--zq57n4DBoUh452BA--


