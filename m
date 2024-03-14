Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F4E6C54E67
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 12:58:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkkdt-0008PB-ID; Thu, 14 Mar 2024 08:57:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rkkdl-0008LY-Ul
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 08:56:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rkkdi-0007zC-OV
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 08:56:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710421006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VNyd/Y9jq2tGwnZxGaRBglxUkiwu5jr9XVwFjHma/nM=;
 b=Y/OpkQrhakPGc2eTSGY3GwPTeDci/STPJMnCKzUzWJN97dARftt1r2kaQPabb08+0z3/RC
 PiHvFW7ktrR085P8jQE7EuEcXSOTZuGI2PQ3wurW8rznOdTkUsVQE1dRsHdhqVEJf8rTGu
 zk2/w/msAh9scb6w+Hc9uC1iKCQELHM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-308-UuOhCHEVM0qsQuAl-e7FoA-1; Thu,
 14 Mar 2024 08:56:43 -0400
X-MC-Unique: UuOhCHEVM0qsQuAl-e7FoA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 776791C02162;
 Thu, 14 Mar 2024 12:56:43 +0000 (UTC)
Received: from localhost (unknown [10.39.195.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EB1F91C060D1;
 Thu, 14 Mar 2024 12:56:42 +0000 (UTC)
Date: Thu, 14 Mar 2024 08:56:41 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com,
 mtosatti@redhat.com, Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v4] linux-aio: add IO_CMD_FDSYNC command support
Message-ID: <20240314125641.GB611723@fedora>
References: <20240314111628.1508636-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="enHNHGGoJbejLXod"
Content-Disposition: inline
In-Reply-To: <20240314111628.1508636-1-ppandit@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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


--enHNHGGoJbejLXod
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 04:46:28PM +0530, Prasad Pandit wrote:
> From: Prasad Pandit <pjp@fedoraproject.org>
>=20
> Libaio defines IO_CMD_FDSYNC command to sync all outstanding
> asynchronous I/O operations, by flushing out file data to the
> disk storage.
>=20
> Enable linux-aio to submit such aio request. This helps to
> reduce latency induced via pthread_create calls by
> thread-pool (aio=3Dthreads).
>=20
> Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
> ---
>  block/file-posix.c      |  7 +++++++
>  block/linux-aio.c       | 21 ++++++++++++++++++++-
>  include/block/raw-aio.h |  1 +
>  3 files changed, 28 insertions(+), 1 deletion(-)
>=20
> v4: New boolean field to indicate if aio_fdsync is available or not.
>     It is set at file open time and checked before AIO_FLUSH call.
>   - https://lists.nongnu.org/archive/html/qemu-devel/2024-03/msg03701.html

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--enHNHGGoJbejLXod
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmXy9AkACgkQnKSrs4Gr
c8iyvwf/RhwKjZWffFYGMQ28DDyWvPv4X/OeWgjND6r9OPdZOMv7i3Oygcj+93JM
dd6H4rodiygyl4aWlD6MGCFqp/IBRKH2YmrRKj7wIdlx4o7lNY02DyMF8YbwRqqH
K6PNbYVY1MTtfD6+oGzpTszcPCMwF2WIXGRQTQ6Dmssoae0i/jFMztqJ6NPhqtu2
EFyiF1amf4biutXbFpovXOPq6Mura8RV2vAYymUU1yGOgj1KqjfokOvdHhHZNzOJ
HVv0vrNwLG/uEslImv2Vobfv31bd1KyrXpgeeyCTEe/wLf/lCVLtpD2uKLJs2Zw7
FCV66g9ZD18Jrx3yc/3axBXt0ZKgKQ==
=mVoN
-----END PGP SIGNATURE-----

--enHNHGGoJbejLXod--


