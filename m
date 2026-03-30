Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 816451061B17
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 18:21:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7HDv-0007x6-CV; Mon, 30 Mar 2026 14:20:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1w7HCQ-0007Us-Q3
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 14:18:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1w7HCN-0003zG-M7
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 14:18:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774894729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iIydZtng8ECzmjIpYUgnuGU0NcsW+MeQZRlSb76czIs=;
 b=Tq5aBOYm8KBm6G/d5iXRfvwZdv86R3P4nfKAQRVEAMUicyPjPYab4f7ZTduHLxmYexqF3T
 anF0cig/uPYObYXtURkcIO4MnKMgoxMaFf7em+Ra2wB2tM6ISELlr2dF6WbQDkq5wKuUIz
 mozak0cTDz+Od3mjV682P4THkDqEgqw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-446-xZg2FgOZNueR93ER3Fag-A-1; Mon,
 30 Mar 2026 14:18:46 -0400
X-MC-Unique: xZg2FgOZNueR93ER3Fag-A-1
X-Mimecast-MFC-AGG-ID: xZg2FgOZNueR93ER3Fag-A_1774894725
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1F86D195608B; Mon, 30 Mar 2026 18:18:45 +0000 (UTC)
Received: from localhost (unknown [10.44.32.19])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2F26A180035F; Mon, 30 Mar 2026 18:18:43 +0000 (UTC)
Date: Mon, 30 Mar 2026 14:18:42 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, pbonzini@redhat.com, gveitmic@redhat.com,
 bmarzins@redhat.com, fam@euphon.net, qemu-devel@nongnu.org
Subject: Re: [PATCH for-11.0] scsi: Don't consider LOGICAL UNIT NOT SUPPORTED
 guest recoverable
Message-ID: <20260330181842.GB179613@fedora>
References: <20260330121635.49205-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7q/HonQXlJd3QnRD"
Content-Disposition: inline
In-Reply-To: <20260330121635.49205-1-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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


--7q/HonQXlJd3QnRD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 02:16:35PM +0200, Kevin Wolf wrote:
> When commit bdf9613b introduced scsi_sense_buf_is_guest_recoverable(),
> it included LOGICAL UNIT NOT SUPPORTED in the list of guest recoverable
> sense codes. It doesn't really explain how the codes to be in the list
> were selected.
>=20
> As the LUN doesn't come from the guest, but from the block backend
> (usually the SCSI device on the host that was opened with host_device,
> but it could also be the iscsi block driver), there is really no way the
> guest could influence this.
>=20
> It seems that on some storage arrays, LOGICAL UNIT NOT SUPPORTED can
> happen during failover operations. When combined with multipath, the
> request should be retried on another path instead of being reported to
> the guest, which would offline the filesystem in response.
>=20
> Simply returning false in scsi_sense_buf_is_guest_recoverable() will
> enable the retry logic in file-posix, and will also make sure that if
> the error persists, the configured error policy is respected so that the
> VM can be stopped.
>=20
> Buglink: https://redhat.atlassian.net/browse/RHEL-158212
> Fixes: bdf9613b7f87 ('scsi: explicitly list guest-recoverable sense codes=
')
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  scsi/utils.c | 1 -
>  1 file changed, 1 deletion(-)

Paolo: Are you taking this through your SCSI tree or would you like
Peter to merge it directly?

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--7q/HonQXlJd3QnRD
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmnKvoIACgkQnKSrs4Gr
c8iEBAgAvoYifTeBnua+gZmJGdycCSrIkHtP8OhiEjeWr58YbEuB5JLI9t1/ylGr
LYQMOkfnGlphoDzb6EerA7kchZEyjkvfjSPGs7/+e9tjAKXqquAz2aPhLr0DCz3J
0u6bu/KLPhBERgWmfA3cnOSOaKrPc4zRdBE3Ek8X8ERw7WWGqfLLVExKpFQL3aeP
1d/SueyfoVH4PeVzpN0303bqvjjBS9OOhjgBLnG4kFrV3xHUOSpepVPKk0iHUGaD
+gl8s1v8TzM1aqh8Z5OPta9zcXWzMs/Z/m6Cdc6su3gekUKXoMlpCisCFYS0hEFH
kSEYXc1i0dOgtnQnkxA7lisT/HJlPQ==
=Ee2D
-----END PGP SIGNATURE-----

--7q/HonQXlJd3QnRD--


