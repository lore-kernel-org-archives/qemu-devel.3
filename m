Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81AD2C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 15:09:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x293i-00040a-CD; Thu, 03 Sep 2026 11:08:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x293c-0003sg-LH
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 11:08:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x293a-0005yE-Lq
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 11:08:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788448129;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KDJ99I4p8h4jmU+b08lmPHs5F4IlfAgMzBEcxDOx4Mw=;
 b=M75gA5fl9LOZr9xk6YHiG1v5Wr5vsnjZ+vMIY8NSSRbGbKdHVU9Wg+shVbl3KN+C1IR2ri
 dXzDqczp1IkgnPDM9ZWp6ria58NueQejRTQojfr3UAPbf4out3kr0xMjnvZGi0VVHAjuCH
 /WU3jjNq+SNCWEIbt1WdQRm7TPeiEhk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-d1LBqYjKPq6St-EuevwXkQ-1; Thu,
 03 Sep 2026 11:08:45 -0400
X-MC-Unique: d1LBqYjKPq6St-EuevwXkQ-1
X-Mimecast-MFC-AGG-ID: d1LBqYjKPq6St-EuevwXkQ_1788448124
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 33FB3195FDCA; Thu,  3 Sep 2026 15:08:44 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9FFAC1955F08; Thu,  3 Sep 2026 15:08:43 +0000 (UTC)
Date: Thu, 3 Sep 2026 11:08:42 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 "Denis V . Lunev" <den@openvz.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 8/9] block/accounting: Move latency_ns override down
Message-ID: <20260903150842.GF825275@fedora>
References: <20260831135206.126184-1-hreitz@redhat.com>
 <20260831135206.126184-9-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Qbc8asqZL6BCVZcw"
Content-Disposition: inline
In-Reply-To: <20260831135206.126184-9-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
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

--Qbc8asqZL6BCVZcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 03:52:04PM +0200, Hanna Czenczek wrote:
> I am not quite sure why `latency_ns` is overridden by a fixed value in
> qtest mode because personally, I find it much better if I can
> individually change requests' latency by modifying the qtest clock.

It looks like tests/qemu-iotests/136 relies on a hardcoded constant so
it can check min/max/avg against known values.

>=20
> But I'm not going to change existing behavior for the histogram and
> such, so I will just move this override after the latency has been
> evaluated regarding a potential BLOCK_IO_DELAY event.

That's fine if you aren't taking the same testing approach as
tests/qemu-iotests/136. I think the benefit of hardcoding the value for
testing is that it would become possible to trigger the latency
threshold without worrying about timing in the test environment.

>=20
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  block/accounting.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/block/accounting.c b/block/accounting.c
> index debf1924455..223becd2e04 100644
> --- a/block/accounting.c
> +++ b/block/accounting.c
> @@ -271,10 +271,6 @@ static void block_account_one_io(BlockAcctStats *sta=
ts, BlockAcctCookie *cookie,
>      int64_t time_ns =3D qemu_clock_get_ns(clock_type);
>      int64_t latency_ns =3D time_ns - cookie->start_time_ns;
> =20
> -    if (qtest_enabled()) {
> -        latency_ns =3D qtest_latency_ns;
> -    }
> -
>      assert(cookie->type < BLOCK_MAX_IOTYPE);
> =20
>      if (cookie->type =3D=3D BLOCK_ACCT_NONE) {
> @@ -292,6 +288,10 @@ static void block_account_one_io(BlockAcctStats *sta=
ts, BlockAcctCookie *cookie,
>                                         cookie->bytes);
>      }
> =20
> +    if (qtest_enabled()) {
> +        latency_ns =3D qtest_latency_ns;
> +    }
> +
>      WITH_QEMU_LOCK_GUARD(&stats->lock) {
>          if (failed) {
>              stats->failed_ops[cookie->type]++;
> --=20
> 2.55.0
>=20

--Qbc8asqZL6BCVZcw
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmqZjXoACgkQnKSrs4Gr
c8hSVAf/WYQ2MXBZyE5HjRaIg7FDHsoa7bSoHMazoufxJe7FFu83RskDuws8Y3hA
vEcoJ24N5hNomTA21i+uSMA6bL54UYZuwyP0IAV3H31AFwC+pYjlDY9Fd9CxqR9n
dI+fB5n122pKtObxcg+c6Dd35oWqCQlBQx5qK8uFNJsO98syFgAkIZrKnz7D+qSR
+V3iqOdMKrenGgQo/k3bn0gdM22uNjvli8fytdFcJQG8RVZkrIF1m5Eloagy4vI0
RoFhZQ8eN8Pf+OHRrQjY9p6bA+KzxdIXBTB5vRvNjRxt4zXveQRoZ4fnt/swQ7Wa
2Wt4oxzi4VisRvx1dDbT4+y2ZwPAVA==
=00jh
-----END PGP SIGNATURE-----

--Qbc8asqZL6BCVZcw--


