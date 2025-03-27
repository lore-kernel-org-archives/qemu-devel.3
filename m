Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0D28C3600B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 14:52:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txoaM-0004V4-JU; Thu, 27 Mar 2025 10:51:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1txoaK-0004UR-BT
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 10:51:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1txoaI-0007g4-8W
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 10:51:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743087113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DvkolXK7fm7twc/auj9lbJ72XiobjQJqMKxxdZzA9ro=;
 b=KNf8gAARF8jd78QQ2DiQlN3LvUEG1hUwICzpk6L2O+9sB+ozHu7rQ7Wfe6xglaRLcACQ5R
 wY78JUPXLKEVJIeUFQE8GHiADhAJ70JHoKWJr/jh84XRn6qg5jHYVUcCMV/P668GNa1AXv
 MgAJgG6WRagkYIja7j0pvEdfp9A+2ss=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-674-ZjaQ8xOjMaW8Kxz3HHg2fA-1; Thu,
 27 Mar 2025 10:51:50 -0400
X-MC-Unique: ZjaQ8xOjMaW8Kxz3HHg2fA-1
X-Mimecast-MFC-AGG-ID: ZjaQ8xOjMaW8Kxz3HHg2fA_1743087109
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BA80A1956077; Thu, 27 Mar 2025 14:51:48 +0000 (UTC)
Received: from localhost (unknown [10.2.16.93])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3B71F1800944; Thu, 27 Mar 2025 14:51:48 +0000 (UTC)
Date: Thu, 27 Mar 2025 10:51:47 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 02/15] fuse: Ensure init clean-up even with error_fatal
Message-ID: <20250327145147.GB37458@fedora>
References: <20250325160529.117543-1-hreitz@redhat.com>
 <20250325160655.119407-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="x0FwWcqk84VJTb/6"
Content-Disposition: inline
In-Reply-To: <20250325160655.119407-1-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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


--x0FwWcqk84VJTb/6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 05:06:42PM +0100, Hanna Czenczek wrote:
> When exports are created on the command line (with the storage daemon),
> errp is going to point to error_fatal.  Without ERRP_GUARD, we would
> exit immediately when *errp is set, i.e. skip the clean-up code under
> the `fail` label.  Use ERRP_GUARD so we always run that code.
>=20
> As far as I know, this has no actual impact right now[1], but it is
> still better to make this right.
>=20
> [1] Not cleaning up the mount point is the only thing I can imagine
>     would be problematic, but that is the last thing we attempt, so if
>     it fails, it will clean itself up.
>=20
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  block/export/fuse.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--x0FwWcqk84VJTb/6
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmflZgMACgkQnKSrs4Gr
c8hVuggAw/E3Tx962te52DDaawXlJHuYerFc2zYO1QzVZpVTTvmKhrI5Mq2vKso5
U5dwjvziB50K+fl/JLT+3edXSGMFGMpvJ/4dXIeFsyDITWNMr+/D2sUiWzrXzTZR
3j9EJ+k+SWrM67hY1pRfsyX7YKUwr6N5/axtKmD7g3fOMIzACrSRier4w4IVXm9i
O+21UvGEz1xWP35sCMumFL8n3svT58tzaZU4y+QFxT3yIkznE5Ovxa4Y6ohX9dAt
D/OQ68f5QGpS8yOA2BXtNzW/EVaw0ubXI3nwvfXibq90swTI5ae38bky9WFKFOVd
ab5kps0u+z7K7AuMPC8puB1CtQHA3Q==
=30yA
-----END PGP SIGNATURE-----

--x0FwWcqk84VJTb/6--


