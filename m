Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88F05C982ED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 13:38:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8eCx-0002sy-Cz; Mon, 21 Sep 2026 09:37:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x8eCv-0002sK-JU
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 09:37:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x8eCu-0002ki-4N
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 09:37:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789997839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vomg8sAeIJzAXNhPi5H5uGdzXk+6GxFmVaATcyHVvfI=;
 b=EhLqrgZ142pr/EFfjqPZqDzk7XKuD42HPgOalc7bwWQWX3rciVU1nRm/XvyI9tORU7dTwD
 J8ILIM/zD74LRXLfunsy/vBFFJtjPKLBKKPDwe/WORcs1HccV0ufUYLQnX86YRrSIHWDyY
 f5RDJK8rN1Jr/a+/LmzcBpfgBl06oQ8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-394-OHugS8wUOEytgZUuh24b4A-1; Mon,
 21 Sep 2026 09:37:17 -0400
X-MC-Unique: OHugS8wUOEytgZUuh24b4A-1
X-Mimecast-MFC-AGG-ID: OHugS8wUOEytgZUuh24b4A_1789997835
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5745E180B5EA; Mon, 21 Sep 2026 13:37:15 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F134019539A7; Mon, 21 Sep 2026 13:37:14 +0000 (UTC)
Date: Thu, 17 Sep 2026 10:41:22 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jeuk Kim <jeuk20.kim@samsung.com>, Jeuk Kim <jeuk20.kim@gmail.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Jinyoung Choi <j-young.choi@samsung.com>,
 Stanley Jhu <stanleyjhu@google.com>
Subject: Re: [PATCH v3] hw/ufs: Reset controller and MCQ state on HCE
 transition to 0
Message-ID: <20260917144122.GJ162769@fedora>
References: <20260902081610.2290123-1-stanleyjhu@google.com>
 <21bbbab6-192b-4243-980e-4167b450c478@gmail.com>
 <18d61b20acd45382.3137322e31362e3131332e313435.ea6a.0000sendgmr@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/rY4opRV9JhUY5xx"
Content-Disposition: inline
In-Reply-To: <18d61b20acd45382.3137322e31362e3131332e313435.ea6a.0000sendgmr@google.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_48_96=1,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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

--/rY4opRV9JhUY5xx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 12:22:09PM +0000, Stanley Jhu wrote:
> On Thu, Sep 03, 2026 at 03:06:42PM +0900, Jeuk Kim wrote:
> > Thank you for your contribution.
>=20
> > Reviewed-by: Jeuk Kim <jeuk20.kim@samsung.com>
>=20
> Hi Jeuk, Stefan, and all,
>=20
> Gentle ping on this patch. It has held Reviewed-by from Jeuk for two
> weeks:
> https://lore.kernel.org/qemu-devel/20260902081610.2290123-1-stanleyjhu@go=
ogle.com/
>=20
> Could this please be queued for the next UFS or block pull request?

Jeuk: Are you planning to send a UFS pull request?

Stefan

--/rY4opRV9JhUY5xx
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmqr/BIACgkQnKSrs4Gr
c8iyqgf/fLjGoMTEvPaUchfS+UHI8W81er8sTZuah5poh+9szSIjngrfmQvoQD/k
nlNDcyuDTEONJjuEZ+efxrrXNfvxVkFLmqURmTn2X+Bg+jNY47o0gENR+n49WchO
GL2b+K4VaNIwNUn6L4LJgWn3I6u1KxRcxZ7Xltg7w4C3Q8ohp15eAhGkb42waHoY
+YKEr5TFuuMjr20dYVQmKMEeYPgH6L+/mCR066kbksJAQa1AEev8QvKjyecholA8
4gVSyHAryqsO1h+prXOQyi+gW4nlsb4ysJjQbUYX9zuYI9g62df2aO/EAwozO3jA
RVvKBFP5B1h1LJEFZkx2FbTIvQhF/A==
=LQIv
-----END PGP SIGNATURE-----

--/rY4opRV9JhUY5xx--


