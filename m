Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6455D3517F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 19:13:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w810Z-0003RK-3t; Wed, 01 Apr 2026 15:13:43 -0400
Received: from [2001:470:142:3::10] (helo=eggs.gnu.org)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1w80Sp-0005sr-9p
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 14:38:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1w80LL-00043h-RO
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 14:31:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775068266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5qPEIJ870NSeuHpii3DCPuBaCM6n8ZznzPXviE/dGVA=;
 b=CCgzCYPx6zcvFBEWWiQfWfpv6M0FKB1mA5CDYZN6hnUWpCdOwOkRc2+7QNid2WwSUgevJ6
 osDol2PYwO6GtIAqm508sFDDYur4EIZaUJ5ZBCt494vHQeKtBzzoAFRihpsein4Q1/Bu1l
 DzxRpf0g/s24HXtHvehAhceXsUaFvBs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-660-sHOs8MCKMn6QMlAcSrdfXw-1; Wed,
 01 Apr 2026 14:31:03 -0400
X-MC-Unique: sHOs8MCKMn6QMlAcSrdfXw-1
X-Mimecast-MFC-AGG-ID: sHOs8MCKMn6QMlAcSrdfXw_1775068261
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7B4C31955D86; Wed,  1 Apr 2026 18:31:00 +0000 (UTC)
Received: from localhost (unknown [10.44.32.12])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 520DF1800671; Wed,  1 Apr 2026 18:30:58 +0000 (UTC)
Date: Wed, 1 Apr 2026 14:30:57 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH 3/3] scsi: register again after PREEMPT without reservation
Message-ID: <20260401183057.GA400282@fedora>
References: <20260401171927.396672-1-stefanha@redhat.com>
 <20260401171927.396672-4-stefanha@redhat.com>
 <31ba8b4f-972c-4ec5-8366-8e668fef6a64@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CNROKYCfByVZmHfY"
Content-Disposition: inline
In-Reply-To: <31ba8b4f-972c-4ec5-8366-8e668fef6a64@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 27
X-Spam_score: 2.7
X-Spam_bar: ++
X-Spam_report: (2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--CNROKYCfByVZmHfY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 01, 2026 at 07:34:40PM +0200, Paolo Bonzini wrote:
> On 4/1/26 19:19, Stefan Hajnoczi wrote:
> > The SCSI specification says PREEMPT without a reservation removes all
> > registrations with the given key. Try to register again after PREEMPT
> > since our key will have been removed.
> >=20
> > In practice some SCSI targets keep the calling I_T nexus' registration
> > instead of removing it. Therefore we need to handle both the
> > spec-compliant and the non-compliant behavior.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >   hw/scsi/scsi-generic.c | 10 ++++++++++
> >   1 file changed, 10 insertions(+)
> >=20
> > diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
> > index 349dea6bdd..5182f9236d 100644
> > --- a/hw/scsi/scsi-generic.c
> > +++ b/hw/scsi/scsi-generic.c
> > @@ -513,6 +513,16 @@ bool scsi_generic_pr_state_preempt(SCSIDevice *s, =
Error **errp)
> >           if (!scsi_generic_pr_preempt(s, key, resv_type, errp)) {
> >               return false;
> >           }
> > +
> > +        /*
> > +         * Some SCSI targets, like the Linux LIO target, remove our
> > +         * registration when preempting without a reservation (resv_ty=
pe is 0).
> > +         * Try to register again but ignore the error since a RESERVAT=
ION
> > +         * CONFLICT is expected if our registration remained in place.
> > +         */
> > +        if (resv_type =3D=3D 0) {
> > +            scsi_generic_pr_register(s, key, NULL);
> > +        }
>=20
> Hi Stefan,
>=20
> I'm replying here for both patch 2 and patch 3.
>=20
> Can this happen after the previous patch?  (Also it's conflicting to say =
 in
> patch 2 that LIO rejects PREEMPT, but also in this one that LIO unregiste=
rs
> the key).

Yes. Both patches are needed.

The first patch gets LIO to process the PREEMPT. Before LIO would just
fail the command.

But once LIO processes the PREEMPT, we hit the next problem: PREEMPT
completes but our registration has been removed. So now we need to
register again after PREEMPT.

> And for patch 2, is a RELEASE needed after issuing PREEMPT with an
> artificial PR_TYPE_WRITE_EXCLUSIVE?

No, because PREEMPT will not acquire a reservation when there is no
reservation holder with the given key. PREEMPT will only remove
registrations in that case.

Stefan

--CNROKYCfByVZmHfY
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmnNZGAACgkQnKSrs4Gr
c8hH6Af/YQR75T1W/Znf/aJU/IiJC+ZcKhLk9E1c+Z3rlkjCXyyEVY4D1400UjWg
hFRbsLgOTPURWdd2a6Sk4fTY+1yq7+zaakBu0Ay1tvKS12A/HKeQFbr6B145/tTa
X2vh7znzi/+/g4koy1jN+oPgUo4MQ+nHpEEWWx6x6j1zZfSu0nLe+SQaVTf0rNYz
9FA46LIXkT76v6wCXaocIAX90Rc1hDzerA2jhBCkORXV5Ii2ifH72bhRD66AKAoN
qdbBFt7NIFaM+ZyKQbgsDzv5b/d/XBy4lhmgdnNYGhAZdoDPEdDsn0NurreJu4AH
wnBlBM3QxJ5vdp5ZhlzwOoqRBDNAzg==
=Z74T
-----END PGP SIGNATURE-----

--CNROKYCfByVZmHfY--


