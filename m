Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9961AC624D0
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 18:28:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1TCw-00065t-Cv; Tue, 01 Sep 2026 14:27:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x1TCv-00065a-JV
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 14:27:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x1TCu-00038C-5D
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 14:27:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788287258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NFQkN3YEjLI4b/71QHKH2bkOWr89GAt4V/mRB5z1SMY=;
 b=HrvQZC5Wr6lS8mGr4ZeRkwSmapTB/3IBbMo4T9wDQ8vg6YE1TZMVIyyyxPyXWhaRQn6rye
 UZCZV/MZW59m2tI/vv8bBBnvngGH8qqni53Pj/B4N0hKfKQ8PLzgkpqwGHMLx47pG72W60
 p86eY9sWHko56on9faEl2lAw5LazOXc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-74-NH_OFg_oNv27RF1iHZSFpQ-1; Tue,
 01 Sept 2026 14:27:34 -0400
X-MC-Unique: NH_OFg_oNv27RF1iHZSFpQ-1
X-Mimecast-MFC-AGG-ID: NH_OFg_oNv27RF1iHZSFpQ_1788287252
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 507AD195605B; Tue,  1 Sep 2026 18:27:32 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 258A97E2; Tue,  1 Sep 2026 18:27:30 +0000 (UTC)
Date: Tue, 1 Sep 2026 14:27:29 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: pbonzini@redhat.com, zhao1.liu@intel.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Daniil Tatianin <d-tatianin@yandex-team.ru>
Subject: Re: [PATCH] tests/../test_hotplug_blk: drop unused nic
Message-ID: <20260901182729.GA616149@fedora>
References: <20260629201332.1001055-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tmWrJegY+ojGSrXu"
Content-Disposition: inline
In-Reply-To: <20260629201332.1001055-1-vsementsov@yandex-team.ru>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--tmWrJegY+ojGSrXu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2026 at 11:13:32PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> From: Daniil Tatianin <d-tatianin@yandex-team.ru>
>=20
> The test doesn't need any networking, so drop the net card.
> Also the test will break if at some moment q35 aliase refers
> to machine type with default virtio-net nic, which will clash with
> virtio-blk in the test, and
>=20
>    self.wait_for_console_pattern('virtio_blk virtio0: [vda]')
>=20
> will not work.
>=20
> Let's make the test a bit more resistant to experiments with
> machine type.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  tests/functional/x86_64/test_hotplug_blk.py | 1 +
>  1 file changed, 1 insertion(+)

Thanks, applied to my block tree:
https://gitlab.com/stefanha/qemu/commits/block

Stefan

--tmWrJegY+ojGSrXu
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmqXGREACgkQnKSrs4Gr
c8gZDggAosLDbYoqAaIRTNRaDzpCbpUC9gCScn2y46Cv3cW+0oQXu371GhhNzGil
8/DpgLrFCC7PZ750ygOkOt0bcepdRz/uINhF2nX0+gnrWR7yuLycOUIUzEuTGET5
EaagpQtapY4qWsoslAQVNNiFH5e76yTvSUDU+HtQUxVrVw5p6v3LmJAoh/teEpjx
eL9jGUG1FG72kbrTSVBRNHA3mRgPUHVT9l3BtDzWWFeHK0ctHSlNM+14MYpOb0Ol
+nbH2P1sZvxlG2+WbfzzSFZwxgU816qkF418IarAG2qKBwaWuLTB/zIi9VfO6TRJ
wlLNO/HZ5rqTnuoMFQ6+nLS9TCpdIw==
=ggx6
-----END PGP SIGNATURE-----

--tmWrJegY+ojGSrXu--


