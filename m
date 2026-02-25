Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78BC1F55434
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 00:25:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv2iS-0002DX-MG; Tue, 24 Feb 2026 19:25:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vv2iR-00029h-CE
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 19:25:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vv2iP-0008N7-WF
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 19:25:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771979120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wn4xe1fnrnr73RGe7QCcL8GJaGLNM7PKBOpcbty7yVs=;
 b=Il5ZJVJ9802CJpxUaTXHBrDu4PLZR96PqOlQXKW0hpEefad4+mUcmFc9mE4Bc5/P6V6bPj
 tYJv0IFtTJySjSO7q0FkC/5W330cTBTOmbvCuk6L0FnPqUhNXUGvc286eVp7m56VGEZfY0
 +KLvHARFaplbDoG7fb+nKcsKPF7lHww=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-225-Uve2-d9HOIWGbsEFqlV4CA-1; Tue,
 24 Feb 2026 19:25:16 -0500
X-MC-Unique: Uve2-d9HOIWGbsEFqlV4CA-1
X-Mimecast-MFC-AGG-ID: Uve2-d9HOIWGbsEFqlV4CA_1771979114
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3EE071956067; Wed, 25 Feb 2026 00:25:14 +0000 (UTC)
Received: from localhost (unknown [10.2.16.120])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7A07019560A2; Wed, 25 Feb 2026 00:25:12 +0000 (UTC)
Date: Wed, 25 Feb 2026 08:25:09 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, richard.henderson@linaro.org,
 BALATON Zoltan <balaton@eik.bme.hu>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 0/3] hw/virtio/virtio-access.h: remove target specific code
Message-ID: <20260225002509.GA1592944@fedora>
References: <20260212234602.338131-1-pierrick.bouvier@linaro.org>
 <967c35ff-0630-4ca7-847e-04a918c93e7d@linaro.org>
 <20260224134436-mutt-send-email-mst@kernel.org>
 <c8e97ad8-e54c-4134-a7d8-cbc91f7f4bae@linaro.org>
 <7e01d12e-d66e-4a06-90aa-b9547fb6d34b@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qcAQieCXI+NI7GtB"
Content-Disposition: inline
In-Reply-To: <7e01d12e-d66e-4a06-90aa-b9547fb6d34b@linaro.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
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


--qcAQieCXI+NI7GtB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2026 at 08:36:36PM +0100, Philippe Mathieu-Daud=E9 wrote:
> Hi Stefan,
>=20
> On 24/2/26 20:21, Pierrick Bouvier wrote:
> > On 2/24/26 11:07 AM, Michael S. Tsirkin wrote:
> > > On Tue, Feb 24, 2026 at 07:33:14PM +0100, Philippe Mathieu-Daud=E9 wr=
ote:
> > > > Hi Pierrick,
> > > >=20
> > > > On 13/2/26 00:45, Pierrick Bouvier wrote:
> > > > > This series eliminates some target specifics in hw/virtio
> > > > > and replace them with
> > > > > runtime functions where needed, to be able to link virtio
> > > > > code in single-binary.
> > > > > After a first try on a series [0] doing this change and
> > > > > making all virtio files
> > > > > common, Richard asked to refactor this part, thus this
> > > > > independent series.
> > > >=20
> > > > > Pierrick Bouvier (3):
> > > > > =A0=A0=A0 hw/virtio: add virtio_vdev_is_{modern, legacy}
> > > > > =A0=A0=A0 hw/virtio: rename virtio_is_big_endian to virtio_vdev_i=
s_big_endian
> > > > > =A0=A0=A0 hw/virtio: remove virtio_access_is_big_endian
> > > >=20
> > > > Patch #2 has been merged as commit 6325407f67d.
> > > >=20
> > > > Since we don't have feedback from the maintainers Cc'ed, I took
> > > > the liberty to rebase your series, trying to address Zoltan's
> > > > concerns on patch #1.
> > >=20
> > >=20
> > > So as I said, main use-case where we would worry about perf is
> > > virtio storage. So it's mostly for storage guys to ack.
> > > Did not get Stefan's feedback yet on whether he is happy.
>=20
> Are you available to discuss this topic during our next community
> call (Tue March 3, 2pm UTC)?

If this revision of the patch series still has the same performance in
the cover letter, then I'm happy. I'll be on vacation next week and
can't make the community call.

Acked-by: Stefan Hajnoczi <stefanha@redhat.com>

--qcAQieCXI+NI7GtB
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmmeQWUACgkQnKSrs4Gr
c8ihiwf/Y+chnPy2k12j+6bOSRkbK1emR9xjKGJNvhbzwzE5VJS/yG/segYgNFM1
s0qHLnqRq4uLml/fjyBsxdF917zkadgDrT7Uwsy4L2l/yEBBiTPwwTOOQF7Lib1V
n0PvDyiNpVSIqTNwz15OXSLWkaqEytWf7YTxFWj3nzxJN9EykPiaAAa/V2QhUqUD
gcC24tQW3bHm0Y5SEVaVDHgQXoexTvwEnzTF6cVWfI9851DaOi/SeBSImp/AI9OH
xL2Si6fcuyvfzHTn+cG8xziWRITPxH0j/Fyy1SQ3DHFDuOn9vXxn0+vG9iqUOtXz
aIyUEE2oA+FTRMY+Krh9fDmFV0oJPg==
=pruy
-----END PGP SIGNATURE-----

--qcAQieCXI+NI7GtB--


