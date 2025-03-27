Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0C64C36011
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 14:56:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txoeO-0007vn-Ns; Thu, 27 Mar 2025 10:56:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1txoeJ-0007v4-Ih
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 10:56:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1txoeH-0000eg-M9
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 10:56:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743087361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7N7pMyJR7S8KAwwy9MdE1OgaSnSeHGEvc6SKaZul1g4=;
 b=ZU8Xs9viT/NEcGz2h2CDqzV1oc1//5fD4fvQNhGx09yquJj79dlg1jkzq1J3muC82HDGBo
 6MpmGNwCbfiBIQhRZIvMuV957dojbWkdruba8oa8leKgAfdW9VG8e+0bT/9J9v3hIZQnFj
 RPpVJmkq9HfRxZTWdcAOzbpybMFR5/U=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-7uJPAX4xMl2k4kNq2xcGIA-1; Thu,
 27 Mar 2025 10:55:56 -0400
X-MC-Unique: 7uJPAX4xMl2k4kNq2xcGIA-1
X-Mimecast-MFC-AGG-ID: 7uJPAX4xMl2k4kNq2xcGIA_1743087355
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B6C8E1800260; Thu, 27 Mar 2025 14:55:55 +0000 (UTC)
Received: from localhost (unknown [10.2.16.93])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 31F1C30001A1; Thu, 27 Mar 2025 14:55:54 +0000 (UTC)
Date: Thu, 27 Mar 2025 10:55:48 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 05/15] fuse: Change setup_... to mount_fuse_export()
Message-ID: <20250327145548.GE37458@fedora>
References: <20250325160529.117543-1-hreitz@redhat.com>
 <20250325160655.119407-4-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="nwtuiJ3FMYssKClH"
Content-Disposition: inline
In-Reply-To: <20250325160655.119407-4-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--nwtuiJ3FMYssKClH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 05:06:45PM +0100, Hanna Czenczek wrote:
> There is no clear separation between what should go into
> setup_fuse_export() and what should stay in fuse_export_create().
>=20
> Make it clear that setup_fuse_export() is for mounting only.  Rename it,
> and move everything that has nothing to do with mounting up into
> fuse_export_create().
>=20
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  block/export/fuse.c | 49 ++++++++++++++++++++-------------------------
>  1 file changed, 22 insertions(+), 27 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--nwtuiJ3FMYssKClH
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmflZvQACgkQnKSrs4Gr
c8gMDwf+ISpNu4uerSyyOix+Akm5z3Lc7hEwg5iexvWB7TXL3eO+qODtH3ZktI57
q6KuEC4709oWWn3WMnhj1MBINEAuk13Dgxg9zC/QNw64eLXyOVBvzj1+vjcgMQfl
U5ml2GKqAN7znCwwNtyQO0iSQq+TDgnXbmWsCS4ojpX+aRGd66Gl5T7w3BT5ZFwq
//xXPxittd6Pr8XkYG8rrW9We6liraDEK1OPBp0OyD8tZg7yVXzPylOL9RwZ3m/j
B8M13nLD6ybu9oHpKGZ5K1wtUsLVZlnAVsi5vuDMUEOPW3/mz7NcbRlHF/QDO2XZ
RjGfxwGxa6+T7K02jBWGPy7ue2LlCQ==
=TdVA
-----END PGP SIGNATURE-----

--nwtuiJ3FMYssKClH--


