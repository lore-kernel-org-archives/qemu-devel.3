Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23DCDD17123
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 18:14:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2wul-00069Y-I9; Mon, 21 Oct 2024 14:13:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1t2wuk-00068n-2a
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 14:13:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1t2wuh-0000QV-6w
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 14:13:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729534432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=09e+oKX4J9p9oc+3JTGgsrN94apU+rKFWMy73eYLAHo=;
 b=RQugsPeqs5lxucTM48GTtbjKfBqX3iJs8kPe3LafXef/MWUysxMuvEtFWK37rHiaCx3zrj
 ynIVAoa35EfBNHnPkQcd5RnEU9HX5imC3KZEUVHm91xXuCEXI6buX8jLBxctZvaUBdA3hb
 ascDwRSg1xcrf1m5tz48Heh7QeYZhKw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-114-fI-70tQANdyapfd8t-og-g-1; Mon,
 21 Oct 2024 14:13:50 -0400
X-MC-Unique: fI-70tQANdyapfd8t-og-g-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 78125195423A; Mon, 21 Oct 2024 18:13:49 +0000 (UTC)
Received: from localhost (unknown [10.2.144.110])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B861419560A2; Mon, 21 Oct 2024 18:13:48 +0000 (UTC)
Date: Mon, 21 Oct 2024 14:13:42 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Sam Li <faithilikerun@gmail.com>,
 qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 dmitry.fomichev@wdc.com, qemu-block@nongnu.org
Subject: Re: [PATCH v2] block/file-posix: optimize append write
Message-ID: <20241021181342.GA293227@fedora.redhat.com>
References: <20241004104123.236457-1-faithilikerun@gmail.com>
 <ZxJynt-0ySt3DG7W@redhat.com>
 <94067926-de2b-41d4-b401-540eb91d887c@kernel.org>
 <ZxY2JBaJW1FO9tsl@redhat.com>
 <c9e227e2-8cbe-4504-8271-6934f60be4e3@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="kIoluX7md+q1fd+s"
Content-Disposition: inline
In-Reply-To: <c9e227e2-8cbe-4504-8271-6934f60be4e3@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--kIoluX7md+q1fd+s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 09:32:50PM +0900, Damien Le Moal wrote:
> On 10/21/24 20:08, Kevin Wolf wrote:
> > Am 20.10.2024 um 03:03 hat Damien Le Moal geschrieben:
> >> On 10/18/24 23:37, Kevin Wolf wrote:
> >>> Am 04.10.2024 um 12:41 hat Sam Li geschrieben:
> >>>> When the file-posix driver emulates append write, it holds the lock
> >>>> whenever accessing wp, which limits the IO queue depth to one.
> >>>>
> >>>> The write IO flow can be optimized to allow concurrent writes. The l=
ock
> >>>> is held in two cases:
> >>>> 1. Assumed that the write IO succeeds, update the wp before issuing =
the
> >>>> write.
> >>>> 2. If the write IO fails, report that zone and use the reported value
> >>>> as the current wp.
> >>>
> >>> What happens with the concurrent writes that started later and may not
> >>> have completed yet? Can we really just reset to the reported value
> >>> before all other requests have completed, too?
> >>
> >> Yes, because if one write fails, we know that the following writes
> >> will fail too as they will not be aligned to the write pointer. These
> >> subsequent failed writes will again trigger the report zones and
> >> update, but that is fine. All of them have failed and the report will
> >> give the same wp again.
> >>
> >> This is a typical pattern with zoned block device: if one write fails
> >> in a zone, the user has to expect failures for all other writes issued
> >> to the same zone, do a report zone to get the wp and restart writing
> >> from there.
> >=20
> > Ok, that makes sense. Can we be sure that requests are handled in the
> > order they were submitted, though? That is, if the failed request is
> > resubmitted, could the already pending next one still succeed if it's
> > overtaken by the resubmitted request? Not sure if this would even cause
> > a probem, but is it a case we have to consider?
>=20
> A zoned device will always handle writes in the order they were submitted=
 (per
> zone) and that is true for emulated devices as well as real ones.

Is there serialization code in the kernel so that zoned devices behind
multi-path keep requests ordered?

Normally I don't assume any ordering between concurrent requests to a
block device, so I'm surprised that it's safe to submit multiple writes.

Stefan

--kIoluX7md+q1fd+s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmcWmdYACgkQnKSrs4Gr
c8ho9gf/VWxd+0UAwWHQuMk/IRkUJtVgxLduj+RxN6S1OZZ5xo+VUfWVU2yQqxxv
TCe/tN788Y5i8oqdqefc4k7Bpp14WZjVMecfX3n/n6jLrlwt7qsXES7rSJUsPpXQ
t45Ty0xuCofi4kAHdDgUKvES+mALyyShdG61cqL+2MC05p7RrpuheiRxl3k9CvnU
vWXFK1hkoeGuNDefNFATPBLo+Hmu5sRN9CInTNVzTN5Mze23jHP085trYNNM2+dz
r0WQFPE2TJCDi+0HbdAeJSl1L/0aSV2zKS3f6CZUIN+wpNM9TJzYUE35+486dze9
nJ3wQmKi5fZSw+fAJB7a+SLixhLXCQ==
=CuVZ
-----END PGP SIGNATURE-----

--kIoluX7md+q1fd+s--


