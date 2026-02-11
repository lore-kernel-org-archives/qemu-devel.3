Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 934BBEEA845
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 18:54:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqboz-00041J-5C; Thu, 12 Feb 2026 13:53:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vqbou-0003yP-3k
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 13:53:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vqbos-0004BJ-P3
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 13:53:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770922422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kSQNnP8pXC2aL6eNODoUaBtyNSnB+bTBA5bHzdA7SOo=;
 b=XQaxtBGGPRDgaKEotYLmhJbukS3oMvkk4b3VveBCxdNXJUBzSEqmBBetmzcGlGggbm7yg+
 zE0NY92H5Hn6uasamGjPRaCPAJv8mq+4257l5O0a82rQOu8hlMCfLQ/WbGrAaBoy9Oxr9K
 ImAILw5aj6V3rFoyTg9IBK8BGD0ASic=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-602-kxkq-jFKPT2fZjwquP80Yw-1; Thu,
 12 Feb 2026 13:53:36 -0500
X-MC-Unique: kxkq-jFKPT2fZjwquP80Yw-1
X-Mimecast-MFC-AGG-ID: kxkq-jFKPT2fZjwquP80Yw_1770922415
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3805218002CE; Thu, 12 Feb 2026 18:53:35 +0000 (UTC)
Received: from localhost (unknown [10.2.17.121])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E05A31800465; Thu, 12 Feb 2026 18:53:34 +0000 (UTC)
Date: Wed, 11 Feb 2026 16:52:59 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Brian Song <hibriansong@gmail.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, hreitz@redhat.com,
 kwolf@redhat.com, eblake@redhat.com, armbru@redhat.com,
 fam@euphon.net, bernd@bsbernd.com
Subject: Re: [Patch v4 5/6] fuse: safe termination for io_uring
Message-ID: <20260211215259.GE234157@fedora>
References: <20260207120901.17222-1-hibriansong@gmail.com>
 <20260207120901.17222-6-hibriansong@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="56Yn4uv8zz9398hM"
Content-Disposition: inline
In-Reply-To: <20260207120901.17222-6-hibriansong@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


--56Yn4uv8zz9398hM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 07, 2026 at 08:08:59PM +0800, Brian Song wrote:
> When a termination signal is received, the storage-export-daemon stops
> the export, exits the main loop (main_loop_wait), and begins resource
> cleanup. However, some FUSE_IO_URING_CMD_COMMIT_AND_FETCH SQEs may
> remain pending in the kernel, waiting for incoming FUSE requests.
>=20
> Currently, there is no way to manually cancel these pending CQEs in the
> kernel. As a result, after export termination, the related data
> structures might be deleted before the pending CQEs return, causing the
> CQE handler to be invoked after it has been freed, which may lead to a
> segfault.
>=20
> As a workaround, when submitting an SQE to the kernel, we increment the
> block reference (blk_exp_ref) to prevent the CQE handler from being
> deleted during export termination. Once the CQE is received, we
> decrement the reference (blk_exp_unref).
>=20
> However, this introduces a new issue: if no new FUSE requests arrive,
> the pending SQEs held by the kernel will never complete. Consequently,
> the export reference count never drops to zero, preventing the export
> from shutting down cleanly.
>=20
> To resolve this, we schedule a Bottom Half (BH) for each FUSE queue
> during the export shutdown phase. The BH closes the fuse_fd to prevent
> race conditions, while the session is unmounted during the remainder of
> the shutdown sequence. This explicitly aborts all pending SQEs in the
> kernel, forcing the corresponding CQEs to return. This triggers the
> release of held references, allowing the export to be freed safely.
>=20
> Suggested-by: Kevin Wolf <kwolf@redhat.com>
> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Brian Song <hibriansong@gmail.com>
> ---
>  block/export/fuse.c | 100 +++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 90 insertions(+), 10 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--56Yn4uv8zz9398hM
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmmM+jsACgkQnKSrs4Gr
c8gfXAgAkYVuKNcUBefillbWDO5kCv069QWbZysmr58hj99qVntDY/ResEbcM+UU
wYW/1e4CaKaEHVHvpKnOWHlukKTmiKrHZyPK/8zv/C2WcbftbxstCvHzDBgZv/Dx
rhczrWm9I3k7N4Ir9kBeoE/gAoEG1yxXjifFaBYKz7oZcDzT7DdGEoU5xNFlbJOc
UwQz1xda5aoxXfDZ2gLUAN9K5tSq3cWAQ6wqvLoHSFclilTO1mCBhjjH6yanIkdV
da952XKcw6wDDTjbVJWNpp7axLbkIZ3UDNYYO8LmBegFNBk7axHxU5QjgNUsd8bu
SRC3wd0y8XTG2lh5BifJuLXxUtqYDg==
=luYl
-----END PGP SIGNATURE-----

--56Yn4uv8zz9398hM--


