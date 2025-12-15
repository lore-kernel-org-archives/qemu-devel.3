Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6ACED5B840
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 15:33:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVAZR-0002CM-Js; Mon, 15 Dec 2025 10:33:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vVAZQ-0002Bs-EV
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 10:33:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vVAZO-00065z-DX
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 10:33:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765812785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=muuCnsEt1ahbEERE9nG15ghGtLQMjBjx8VNtp39aiv4=;
 b=bTDIWAt4vsbUILGubB0+oqEMSgl0+bQvUqiwq0O0BuGIvJQEycmAN98sYPrpN47OyP1QTz
 QqARJO0vzOLyv2AfufYZ/zUtpgSieyQAe0EHqmUoGeqPZ+Yi3/7My8TiHyJCT3RZnqe2fU
 XCecRo+w3g3Awfi1xYPAs8cNXY7kBZA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-Nmx9Vs9uMmKweSxWt1aMsw-1; Mon,
 15 Dec 2025 10:33:03 -0500
X-MC-Unique: Nmx9Vs9uMmKweSxWt1aMsw-1
X-Mimecast-MFC-AGG-ID: Nmx9Vs9uMmKweSxWt1aMsw_1765812781
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D758C1955D8A; Mon, 15 Dec 2025 15:33:00 +0000 (UTC)
Received: from localhost (unknown [10.2.16.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2DB5D19560B4; Mon, 15 Dec 2025 15:33:00 +0000 (UTC)
Date: Mon, 15 Dec 2025 10:32:59 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, thuth@redhat.com, peterx@redhat.com,
 farosas@suse.de, qemu-devel@nongnu.org, qemu-stable@nongnu.org
Subject: Re: [PATCH] block: Fix BDS use after free during shutdown
Message-ID: <20251215153259.GA33712@fedora>
References: <20251215150714.130214-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9ZEFa8DlZvaFm1By"
Content-Disposition: inline
In-Reply-To: <20251215150714.130214-1-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--9ZEFa8DlZvaFm1By
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 15, 2025 at 04:07:14PM +0100, Kevin Wolf wrote:
> During shutdown, blockdev_close_all_bdrv_states() drops any block node
> references that are still owned by the monitor (i.e. the user). However,
> in doing so, it forgot to also remove the node from monitor_bdrv_states
> (which qmp_blockdev_del() correctly does), which means that later calls
> of bdrv_first()/bdrv_next() will still return the (now stale) pointer to
> the node.
>=20
> Usually there is no such call after this point, but in some cases it can
> happen. In the reported case, there was an ongoing migration, and the
> migration thread wasn't shut down yet: migration_shutdown() called by
> qemu_cleanup() doesn't actually wait for the migration to be shut down,
> but may just move it to MIGRATION_STATUS_CANCELLING. The next time
> migration_iteration_finish() runs, it sees the status and tries to
> re-activate all block devices that migration may have previously
> inactivated. This is where bdrv_first()/bdrv_next() get called and the
> access to the already freed node happens.
>=20
> It is debatable if migration_shutdown() should really return before
> migration has settled, but leaving a dangling pointer in the list of
> monitor-owned block nodes is clearly a bug either way and fixing it
> solves the immediate problem, so fix it.
>=20
> Cc: qemu-stable@nongnu.org
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  blockdev.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--9ZEFa8DlZvaFm1By
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmlAKisACgkQnKSrs4Gr
c8hU6gf8CJW2zDezw8VPem0UNJWw5sPMLphufOoeQ+UaEkFlSmSeI20xEBohuFC4
rcWN/T3c95bxhovewbnnSRwJ4QHPqbGD8qthHy7T4KGPo/EOXjXcHgR9F+wPbuDz
skEMUVQLoAuCPJcLHgiR4qgcKOudX7icujUmXWzrHCOI59FQA22DM9e70wk9IAbG
5f7YSWVb7tr6vOIKW0446ikEITe36BoUUC5f2/J5OSGs/7RCj1WRilrd6WTWpPNw
9O6RBuzOEfNLleePkD7OaRBaYvshzlIGeCVp9zEEVZDH8J5l1/Q4YnGaAYpMUkQc
BWY3+ul6GpzmYTXGkM2LZg437E8tIg==
=zbc2
-----END PGP SIGNATURE-----

--9ZEFa8DlZvaFm1By--


