Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88795C3600B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 15:39:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txpJS-0004Qv-8r; Thu, 27 Mar 2025 11:38:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1txpJO-0004QR-An
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 11:38:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1txpJM-0006Dp-0z
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 11:38:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743089906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FhP7LBXhTt0aR54ewGJMaC1+3k2h3bw95s2ftcPYILU=;
 b=YYt/pO+78dQZnC/h30nprR/XUrxyaMZ0RTnYf7C0UFbVW9Wc60iz4RQ4iuY+nfX1nG1uiy
 6fWaFKLraPWA1xSsrTRA7eiB3+ryy3g6yandgFm6MZeLIk+t01geRMTbiRNvlJ/Sa0siuP
 lXuQbQrP+GjUdjUVEISHb48LjWhfH+Y=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-78-Y4wEprQwN9W1c2iH23UgvA-1; Thu,
 27 Mar 2025 11:38:25 -0400
X-MC-Unique: Y4wEprQwN9W1c2iH23UgvA-1
X-Mimecast-MFC-AGG-ID: Y4wEprQwN9W1c2iH23UgvA_1743089904
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 416C418001E6; Thu, 27 Mar 2025 15:38:23 +0000 (UTC)
Received: from localhost (unknown [10.2.16.93])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B2AA6180B48E; Thu, 27 Mar 2025 15:38:21 +0000 (UTC)
Date: Thu, 27 Mar 2025 11:38:20 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 13/15] fuse: Process requests in coroutines
Message-ID: <20250327153820.GM37458@fedora>
References: <20250325160529.117543-1-hreitz@redhat.com>
 <20250325160655.119407-12-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="XuI8pq8DmKd0G47M"
Content-Disposition: inline
In-Reply-To: <20250325160655.119407-12-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--XuI8pq8DmKd0G47M
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 05:06:53PM +0100, Hanna Czenczek wrote:
> Make fuse_process_request() a coroutine_fn (fuse_co_process_request())
> and have read_from_fuse_fd() launch it inside of a newly created
> coroutine instead of running it synchronously.  This way, we can process
> requests in parallel.
>=20
> These are the benchmark results, compared to (a) the original results
> with libfuse, and (b) the results after switching away from libfuse
> (i.e. before this patch):
>=20
> file:                  (vs. libfuse / vs. no libfuse)
>   read:
>     seq aio:   120.6k =B11.1k (+ 53 % / + 58 %)
>     rand aio:  113.3k =B15.9k (+188 % / +325 %)
>     seq sync:   52.4k =B10.4k (+ 61 % / + 10 %)
>     rand sync:  10.4k =B10.4k (+  6 % / +  3 %)
>   write:
>     seq aio:    79.8k =B10.8k (+ 29 % / + 37 %)
>     rand aio:   79.0k =B10.6k (+ 29 % / + 36 %)
>     seq sync:   41.5k =B10.3k (+ 49 % / + 15 %)
>     rand sync:  41.4k =B10.2k (+ 50 % / + 15 %)
> null:
>   read:
>     seq aio:   266.1k =B11.5k (+ 24 % / -  1 %)
>     rand aio:  264.1k =B12.5k (+ 24 % / =B1  0 %)
>     seq sync:  135.6k =B13.2k (+ 50 % / +  1 %)
>     rand sync: 134.7k =B13.0k (+ 50 % / +  2 %)
>   write:
>     seq aio:   281.0k =B11.8k (+ 38 % / +  2 %)
>     rand aio:  288.1k =B16.1k (+ 43 % / +  6 %)
>     seq sync:  142.2k =B13.1k (+ 65 % / +  9 %)
>     rand sync: 141.1k =B12.9k (+ 66 % / + 11 %)
>=20
> So for non-AIO cases (and the null driver, which does not yield), there
> is little change; but for file AIO, results greatly improve, resolving
> the performance issue we saw before (when switching away from libfuse).
>=20
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  block/export/fuse.c | 209 ++++++++++++++++++++++++++------------------
>  1 file changed, 126 insertions(+), 83 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--XuI8pq8DmKd0G47M
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmflcOwACgkQnKSrs4Gr
c8gzrwf/WyxmJcPhZ/8gRVjCu9yoWoCaRntuazXJ/+a5MDUk0yMZFvpowj59AgnJ
0mLHWJ3dhKemrACiogYJX1Noe1be+bLNbVnJFXnoVeouzPaIGWW9EHqJDXhLG4zV
OjVinQdkqkMU6uOUQwStQAmXBen7KXkWwNwc3IwK5mDakB9ituXma7Fbn4tv15vq
zdSFtEUFxl0HYJ59bUWa1yXco/yX+ty1rUXeqqqkjUXM1C6kWQgkv3CdSV5arJkI
G7NDwDkJD6V3yniPU3WKDlP6scX94W04zF97aAI11voZmQhKQVNaQHjPJgyYOCYs
z3S/UkztNlBARgftOpC/aqKiGfEEow==
=W0rS
-----END PGP SIGNATURE-----

--XuI8pq8DmKd0G47M--


