Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED462CCA464
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 18:45:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHQS9-0007kR-BS; Thu, 15 Oct 2026 14:45:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xHQRx-0007jx-2G
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 14:45:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xHQRv-0004Ko-E6
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 14:45:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792089903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yGScKWcu5xGQg2hc4PWzT+tgT9xfmaGgK5a0U1xMNkw=;
 b=FdXyenBiGVp/059qMRiBavqk4KaSru/s0wEXi7dMlyNwuWUQG5m79QsFcWyNjlVVE/9wIo
 WMFTaXOhvWMLLcr0G6Q/ybnYJVypkqrx6YKDpNH5KWk+SndUBrX7E2vSCdxTYgmcEd8fjH
 GY2ZLGqNHrr3ub2Qy98B9pKh+FJGIPk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-lpUszEvGNBWxNsVwNeyOAA-1; Thu,
 15 Oct 2026 18:44:59 +0000
X-MC-Unique: lpUszEvGNBWxNsVwNeyOAA-1
X-Mimecast-MFC-AGG-ID: lpUszEvGNBWxNsVwNeyOAA_1792089898
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 70F241800352; Thu, 15 Oct 2026 18:44:58 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 12A8C1955F1C; Thu, 15 Oct 2026 18:44:57 +0000 (UTC)
Date: Thu, 15 Oct 2026 14:44:57 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Wesley Hershberger <wesley.hershberger@canonical.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hector Cao <hector.cao@canonical.com>,
 Alex =?iso-8859-1?Q?Ram=EDrez?= <alex.ramirez@canonical.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH v4 1/2] util/coroutine: trim sysctl's max_map_count
 newline before parsing
Message-ID: <20261015184456.GC1504100@shajnocz.csb>
References: <20261014-set-default-pool-size-v4-0-a3aff89b94f0@canonical.com>
 <20261014-set-default-pool-size-v4-1-a3aff89b94f0@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NmX0/PwJDcAuHOU/"
Content-Disposition: inline
In-Reply-To: <20261014-set-default-pool-size-v4-1-a3aff89b94f0@canonical.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--NmX0/PwJDcAuHOU/
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 04:55:45PM -0500, Wesley Hershberger wrote:
> From: Hector Cao <hector.cao@canonical.com>
>=20
> Strip trailing whitespace from max_map_count before passing it to
> qemu_strtoi(), allowing the strict full-string parse to succeed.
> Otherwise, qemu_strtoi() fails to parse the string and returns -22,
> making the global cache pool cap size set to UINT_MAX.
>=20
> Fixes: 86a637e48104 ("coroutine: cap per-thread local pool size")
> Signed-off-by: Hector Cao <hector.cao@canonical.com>
> Reviewed-by: Daniel P. Berrang=E9 <berrange@redhat.com>
> Signed-off-by: Wesley Hershberger <wesley.hershberger@canonical.com>
> ---
>  util/qemu-coroutine.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

After checking that qemu_strtoi()'s behavior was identical in
86a637e48104, I wonder how this ever worked.

Thanks for fixing this!

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--NmX0/PwJDcAuHOU/
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmrRHygACgkQnKSrs4Gr
c8iQZgf+PNFNdDXQBjXp5BAMMN73kqVGGZDkcY0yA6BytgWuveeTMYn9Jj/lMER7
dSQ4yrNsHrvq3l6LRew1kjP9RTPg4xLb/oHjk3b3Cl+o3WckXUl45o9xuPlW1ZhD
9KI7dsDIy24xuokphRmqN5Rq7EeqrZ66W3+GmSv4oag0YdKdC/4+kLxfxYKRGGYa
f7eiAHYtP3IBazcPPoODglt8z9/7lq8vU0EIdyiQyoE3UKFCMLYWbajQuXaXTLmQ
lUOq24IJeFc5rdNVNwi1u/CQrRBkjh+JUicy7OaOCcnMhcqYS5+Xop2fiApobyn1
vKrkS35OX05YF73HjkVsWErHCW1juQ==
=zGwa
-----END PGP SIGNATURE-----

--NmX0/PwJDcAuHOU/--


