Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3EE9C982EE
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 13:37:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8eCp-0002qT-3f; Mon, 21 Sep 2026 09:37:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x8eCl-0002pu-UE
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 09:37:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x8eCk-0002jQ-JF
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 09:37:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789997829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U4Qaihsv/LQxkwU6Mb/RinRTsBtPHo9D6UnJWwHZNg0=;
 b=dDPWZIsws7/AovgmJg6cpVlwxhtGpO52hUNfTYx/ZAJoh3/kFP19pkHpkxaoYyTaVykvQ+
 vzl4rtJs6VeRq23dBd75OYbugYhBILDpzHdBcUIdNrJApWtP9Q+Rewk/cekde1eyHTRxtO
 L9R7qD9i9++aXMZw3uecbtO2gyTi44A=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-531-_QGy74ItPOq6zcngJl4RFQ-1; Mon,
 21 Sep 2026 09:37:06 -0400
X-MC-Unique: _QGy74ItPOq6zcngJl4RFQ-1
X-Mimecast-MFC-AGG-ID: _QGy74ItPOq6zcngJl4RFQ_1789997823
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 78B83197702F; Mon, 21 Sep 2026 13:37:03 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9AA89300106D; Mon, 21 Sep 2026 13:37:02 +0000 (UTC)
Date: Wed, 16 Sep 2026 15:38:07 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 'Daniel P =?iso-8859-1?Q?=2E_Berrang=E9'?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Subject: Re: [PATCH V17 06/13] virtio: track IOThread references for thread
 pinning
Message-ID: <20260916193807.GC162769@fedora>
References: <20260915101655.3216101-1-zhangckid@gmail.com>
 <20260915101655.3216101-7-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HA+gJPPKhssuMP7U"
Content-Disposition: inline
In-Reply-To: <20260915101655.3216101-7-zhangckid@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 46
X-Spam_score: 4.6
X-Spam_bar: ++++
X-Spam_report: (4.6 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--HA+gJPPKhssuMP7U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 06:16:48PM +0800, Zhang Chen wrote:
> Use the virtio device canonical QOM path as the holder when virtio-blk
> and virtio-scsi acquire an IOThread AioContext.
>=20
> Replace the raw object references with the holder-aware
> acquire/release helpers so the users are visible through IOThread
> introspection.
>=20
> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> ---
>  hw/block/virtio-blk.c           | 23 +++++++++++++----------
>  hw/scsi/virtio-scsi-dataplane.c | 23 +++++++++++++----------
>  2 files changed, 26 insertions(+), 20 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--HA+gJPPKhssuMP7U
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmqq8B8ACgkQnKSrs4Gr
c8jU6Af/ZRgF/CN1QYmDSEpWTYNq5EFPAisHEmWeGnpUlof/c7z93jjXtngrOqLI
Cw57vNg5H06rj6ikmcwh+cJL8xsMcdA390V1NCtAjKEt/65wq2n4cs3cvpwFHzTQ
VjINW7RtbJ8EtHPjVs0byoQGKBNgYS9m0H3MVQztYzV6jZvc8KxaiTzXIgzhyfX0
Q87IIxnibCnlVkB3Ye17rWuiFFlEXyeUue4wWz+DL0PpOn1FDjnHWaktmXG4Bd3h
H3vepX9xlI9qJ62K7SMW/PD4Ut2bgrRYHapxy81r4yoQ6NSFmEjDup1XJPpXszy1
M5OjMCSFxeJvyHkmbs0unqyj91G4ow==
=8aOe
-----END PGP SIGNATURE-----

--HA+gJPPKhssuMP7U--


