Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E566C369C9
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 20:46:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5W7r-0002Bf-DP; Thu, 17 Apr 2025 16:46:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u5W7p-0002Af-EW
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 16:46:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u5W7n-0006FH-OS
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 16:46:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744922777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jlpXXKdzjLVvpDsV/dlrDh9QsS3qMHIROT5s4rUfUos=;
 b=YEeMgnd7Fs7nVtE2jmMlqrxMY+bCRjxsckObCMRFIO+DxM4+W9g+k7PjQRyus3L7uFWrxD
 unPQ6jR0C8rwNUkb+YOP8JcbmHCQqVssu7x4DHHj7wbvhCliPOOVD1B4vwSL54whJKEB5U
 d2eOHFKalXyYUs06BPtgh8N3pkYoApQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-673-Xrp2czjXMamJ912J9MceXQ-1; Thu,
 17 Apr 2025 16:46:12 -0400
X-MC-Unique: Xrp2czjXMamJ912J9MceXQ-1
X-Mimecast-MFC-AGG-ID: Xrp2czjXMamJ912J9MceXQ_1744922771
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 540FF19560AF; Thu, 17 Apr 2025 20:46:11 +0000 (UTC)
Received: from localhost (unknown [10.2.16.64])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8AF2C19560A3; Thu, 17 Apr 2025 20:46:10 +0000 (UTC)
Date: Thu, 17 Apr 2025 16:46:09 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, vsementsov@yandex-team.ru,
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v2 07/11] mirror: Skip pre-zeroing destination if it is
 already zero
Message-ID: <20250417204609.GF85491@fedora>
References: <20250417184133.105746-13-eblake@redhat.com>
 <20250417184133.105746-20-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2A1SEVfFaOye7/5i"
Content-Disposition: inline
In-Reply-To: <20250417184133.105746-20-eblake@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


--2A1SEVfFaOye7/5i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2025 at 01:39:12PM -0500, Eric Blake wrote:
> When doing a sync=3Dfull mirroring, QMP drive-mirror requests full
> zeroing if it did not just create the destination, and blockdev-mirror
> requests full zeroing unconditionally.  This is because during a full
> sync, we must ensure that the portions of the disk that are not
> otherwise touched by the source still read as zero upon completion.
>=20
> However, in mirror_dirty_init(), we were blindly assuming that if the
> destination allows punching holes, we should pre-zero the entire
> image; and if it does not allow punching holes, then treat the entire
> source as dirty rather than mirroring just the allocated portions of
> the source.  Without the ability to punch holes, this results in the
> destination file being fully allocated; and even when punching holes
> is supported, it causes duplicate I/O to the portions of the
> destination corresponding to chunks of the source that are allocated
> but read as zero.
>=20
> Smarter is to avoid the pre-zeroing pass over the destination if it
> can be proved the destination already reads as zero.  Note that a
> later patch will then further improve things to skip writing to the
> destination for parts of the image where the source is zero; but even
> with just this patch, it is possible to see a difference for any BDS
> that can quickly report that it already reads as zero.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  block/mirror.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--2A1SEVfFaOye7/5i
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgBaJEACgkQnKSrs4Gr
c8g/OQf/YJhf0HwRBIMQgYIKiFosqHoiLDxm9zIbyg224JGdJWVSDzX/1AtVODaD
dQF/Np+ibppUsNw1LK+AZoKMoo2x7wFYIHvneZ9bMtB0P2dcZFX7txWyLAFYSoyx
QfHBODN1749u6bKxfGSGmOOQwaVAFnTG9bOU3LYq88BDI2lBpfrqCSFEWVeMbkWH
XYDFRlEQaUTmfzY2RFGBJUA8RNEMz76n2L7JsbNs6qQLBK5vxjuPjLCkG95rzMa5
IAKZFDJBLbM1ggE7tH6pR2LHK7WmmlSaOPRU3FaNF01sEuJ/wuJPOhUnli7qNTAz
gzJN8NwfzVzYlDguINxWilxfr65zLw==
=rKK4
-----END PGP SIGNATURE-----

--2A1SEVfFaOye7/5i--


