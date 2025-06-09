Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEE1AC678DA
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 16:58:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOfok-00013n-9F; Mon, 09 Jun 2025 12:57:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uOfoh-00012q-Su
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 12:57:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uOfog-0005j9-Hw
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 12:57:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749488266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sSkYGFZO20tG2p+JZ1OKASLJB+XTr4OEPCly+cCkmbQ=;
 b=QvTUxJv86oRIq/A/BbSP8gDVeX2QNcjtyu72S23N5BvXt5UC5Ri59iQlA5roHdZn3ggmFh
 2GVj2aoA1tbqbw10KGVDDVY8DcYWacaykG939Tm9cN40bJUkwd7rui3aTF9++NIXj5f+q1
 PhqOrMO+ZfE8cAac/3hTKTzxhkv+e8E=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-518-PwpPDrolMgCizYiYBmGLJg-1; Mon,
 09 Jun 2025 12:57:42 -0400
X-MC-Unique: PwpPDrolMgCizYiYBmGLJg-1
X-Mimecast-MFC-AGG-ID: PwpPDrolMgCizYiYBmGLJg_1749488261
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 732E7180136B; Mon,  9 Jun 2025 16:57:41 +0000 (UTC)
Received: from localhost (unknown [10.2.16.92])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5DFB718003FC; Mon,  9 Jun 2025 16:57:40 +0000 (UTC)
Date: Mon, 9 Jun 2025 12:57:38 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Brian Song <hibriansong@gmail.com>
Subject: Re: [PATCH v2 15/21] fuse: Process requests in coroutines
Message-ID: <20250609165738.GH29452@fedora>
References: <20250604132813.359438-1-hreitz@redhat.com>
 <20250604132813.359438-16-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nFgWlxba8eIM8yc9"
Content-Disposition: inline
In-Reply-To: <20250604132813.359438-16-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--nFgWlxba8eIM8yc9
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 04, 2025 at 03:28:07PM +0200, Hanna Czenczek wrote:
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
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  block/export/fuse.c | 194 ++++++++++++++++++++++++++------------------
>  1 file changed, 113 insertions(+), 81 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--nFgWlxba8eIM8yc9
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmhHEoIACgkQnKSrs4Gr
c8gRZwf/WR5j34srJqcRZ8bpG+PeWJkywQ4aQ+L+MOqeLI39iSJq+k9feAMnlXU1
fMnxsSUo7ZKA5KJ32TWxt8MnRv81KMiSb2NmRzCWN2YxxJWyZWG01d/X6ACmoq8U
CHy4aXq5NcFgT1qvPGjo/waFZt9sJJoRtpitYXdCvvAiPGbhMHythXGeMceDzGb2
CMLNySL09S2KOLKVVlPG0GvJjvWwVTmpCQI9ZvVfa6iAuODICAyRT3CYt2Q7lhtB
4PNo0oi23xEE4og+FauBz2fxAFaZpVoZ43+7xdNXgk3DdMU1MBwJ019Scg9Y+qcC
1LzUpGTC/cMMPYdtZcXwDIia1JLDhw==
=/rZA
-----END PGP SIGNATURE-----

--nFgWlxba8eIM8yc9--


