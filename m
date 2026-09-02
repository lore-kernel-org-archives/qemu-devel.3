Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F17AAC624D0
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 11:55:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1jYI-0007Zy-Hw; Wed, 02 Sep 2026 07:54:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x1jYG-0007ZX-5w
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 07:54:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x1jYE-0004IB-QF
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 07:54:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788350085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ezt/sWGKwqisBAhESV1cl2GOKLFayu3inKaqXGM19Ys=;
 b=H3gM5sM0rMTvqKx7emr7vCWri00PbG+7OiMCgM51H/C3u3Du1PNa04P3U2W5fiKASEuF1R
 bztdCDZWZDzbZXFwgzH9D7B3UkOW2qcUjhJ+o+IicagZ7ABO18gpMJmdm6untzoQVI69Km
 bljxG7yu05fEzW7xUy49St7fVumy38w=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-IxenXDlmMmmNNHjbcZciPQ-1; Wed,
 02 Sept 2026 07:54:42 -0400
X-MC-Unique: IxenXDlmMmmNNHjbcZciPQ-1
X-Mimecast-MFC-AGG-ID: IxenXDlmMmmNNHjbcZciPQ_1788350081
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3B736180884B; Wed,  2 Sep 2026 11:54:41 +0000 (UTC)
Received: from localhost (unknown [10.2.16.27])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 692E11955F09; Wed,  2 Sep 2026 11:54:40 +0000 (UTC)
Date: Wed, 2 Sep 2026 07:54:39 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Huiba Li <lihuiba@gmail.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [RFC] block: add an overlaybd image format driver
Message-ID: <20260902115439.GA754231@fedora>
References: <CA+AFTT-iZ8wbUOkEaU_SCM0rnqRJsefkOr=CTgC6T22nz_ZFoA@mail.gmail.com>
 <CA+AFTT-8odiRzg8mcnZiEQTyTiMeK5rHUFB6an+6wFgYLtyh1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="V4Lv86iJw8wRF0DQ"
Content-Disposition: inline
In-Reply-To: <CA+AFTT-8odiRzg8mcnZiEQTyTiMeK5rHUFB6an+6wFgYLtyh1g@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--V4Lv86iJw8wRF0DQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Huiba,
One thing I noticed is that the append-only format used for the upper
write layer is not documented. I guess it's different from the read-only
LSTM format since the index won't be kept in sorted order when
appending.

Do you want to document the append-only format?

Stefan

--V4Lv86iJw8wRF0DQ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmqYDn8ACgkQnKSrs4Gr
c8hOpQf+IEAN6rk9XOtCajGExOLv7QvTFhpsy1hWZR7m2PrQZM6c9zSdr2y6fXfT
Zkkw7rGIjS06Y9LzepHh3xAVLm0g6/vDqOF6yfZn/Gdmq5XU3UogBqFtSiRxrTi5
37bJPTvj63ZyCpOtHJFwX+EYgNozZR0UXAXxEGqcHAt5SnolxPAECEZDFcCHRaEP
arADqrtYMSNXE6YzCLuGGXbIlDraTRYlYsPrPND9UsVPnHrpKdbfVMxVwhR9bJBc
e8zIZ4Ku6uusV56W6FfGj3Cpj1rc5k2wyGi87GLvb6XBoIQcQic+cgttwUvht3Ra
c2pv7J8JED34EKReqm2pwTMYTwLwvQ==
=LD76
-----END PGP SIGNATURE-----

--V4Lv86iJw8wRF0DQ--


