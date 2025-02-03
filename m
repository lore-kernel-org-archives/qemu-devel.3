Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6058AC02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 18:51:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tf1Xa-0001JU-Of; Mon, 03 Feb 2025 13:51:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tf1XJ-00018c-C8
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 13:51:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tf1XI-0005TP-06
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 13:51:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738608666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fTqaMtlsi0DAWxFdWwzYAg0IDV1y4Pn3cR+sSj9xGlI=;
 b=T8lLKTZleF7RMlD/o5ReLAE/rc/LP7/tOtnRmyVVzfs08hRz8r5aIh6tdJa+/XK5jlB+8g
 2xbQau7H9DjG0ANdXkqhpaONOjg5sPX/q8qsKCqGAeRNKY8n5Z+ByUCu0sRUdQaCXfys9+
 1BsrxaL40zuOMbDulfswchiigePU9T0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-MFWy9JYSOGyjjnlfrSSvDw-1; Mon,
 03 Feb 2025 13:51:03 -0500
X-MC-Unique: MFWy9JYSOGyjjnlfrSSvDw-1
X-Mimecast-MFC-AGG-ID: MFWy9JYSOGyjjnlfrSSvDw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 04C4C19560B0; Mon,  3 Feb 2025 18:51:02 +0000 (UTC)
Received: from localhost (unknown [10.2.16.131])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6BEB219560AD; Mon,  3 Feb 2025 18:51:01 +0000 (UTC)
Date: Mon, 3 Feb 2025 13:51:00 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, pkrempa@redhat.com,
 peterx@redhat.com, farosas@suse.de, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 05/15] block: Allow inactivating already inactive nodes
Message-ID: <20250203185100.GG268514@fedora>
References: <20250130171240.286878-1-kwolf@redhat.com>
 <20250130171240.286878-6-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="HwIw77EnpwgBYheE"
Content-Disposition: inline
In-Reply-To: <20250130171240.286878-6-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--HwIw77EnpwgBYheE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 30, 2025 at 06:12:36PM +0100, Kevin Wolf wrote:
> What we wanted to catch with the assertion is cases where the recursion
> finds that a child was inactive before its parent. This should never
> happen. But if the user tries to inactivate an image that is already
> inactive, that's harmless and we don't want to fail the assertion.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--HwIw77EnpwgBYheE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmehEBQACgkQnKSrs4Gr
c8hbnwgAjIM2ZOdrAGUE3ywqK74Bd5RCH7VrBUivkQ4sPqtKW1FCNiGkJc6KIk2C
Te5W4ynzqLaVm+wV1xsXMw1KYIBDsWll/Xo0HVAvr/GReRWOyU/oFNdPdKQlJY5D
GDuOBa9+RuEy/fNeIJJ2IjfZhR/jqi317g3cku3hTr3JsaS44/ea4ytA5aQKC/FN
aSBazvnWoAmsPIcpU7yGWOrty9l79R91YKZowMfRigTE7TybUz7dRWdVC392VbEX
im5uZrWASCPIjD486RxX9gTpXIMV9MRsaI5T15udxopP4wnhH61//860r20YNUZT
jWbrwuicJgJDokWquexFKgs16fguPg==
=z78I
-----END PGP SIGNATURE-----

--HwIw77EnpwgBYheE--


