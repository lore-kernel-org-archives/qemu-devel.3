Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1F55C02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 19:43:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcV05-0004PC-9N; Mon, 27 Jan 2025 14:42:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tcUzw-0004MK-MQ
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 14:42:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tcUzv-0003cY-4D
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 14:42:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738006933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jbFpEmHZcsF2z21tixjEGxHcXLsMehq8qscy4oPSfwk=;
 b=X6AAvaoUWDrZjCT8g2V2gzzjD3pdhx0s+ScRiJXWDR+xNC3kO7BVcA43PL3ry2r8Diu4E0
 lEJW0DO31WbBt+yB5ub73YJz8F846cK58quDJfUgvFZz+kQ5IOv/GPeU4ZrMLjNjKRS/6t
 fD3AD8R0Q/jBXHJxLuJxfJSdyRg+iB4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-354-avOa4RhIOieJY8jsHCkTFw-1; Mon,
 27 Jan 2025 14:42:10 -0500
X-MC-Unique: avOa4RhIOieJY8jsHCkTFw-1
X-Mimecast-MFC-AGG-ID: avOa4RhIOieJY8jsHCkTFw
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 150A019560B8; Mon, 27 Jan 2025 19:42:09 +0000 (UTC)
Received: from localhost (unknown [10.2.17.47])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 97D921800348; Mon, 27 Jan 2025 19:42:08 +0000 (UTC)
Date: Mon, 27 Jan 2025 14:42:07 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PULL 00/12] aspeed queue
Message-ID: <20250127194207.GA39648@fedora>
References: <20250127094239.636526-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="IOS1aer3GtsRQS2r"
Content-Disposition: inline
In-Reply-To: <20250127094239.636526-1-clg@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


--IOS1aer3GtsRQS2r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--IOS1aer3GtsRQS2r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmeX4Y4ACgkQnKSrs4Gr
c8i5ywf/VLRa5WiHzuRi9UUlQPkaL79T2IZ2RbtEAfagVzdWbGE4+EZhD/eqB30r
HtVZYbvjgahzcyoDN+qYqnoVXz8NU2RBThmGs7JVpNprZvKoT4RsaldJm5WfugS4
HMmPYyRzxZ/9OB8De4vlKasrSVO25fcQOAkoHP8fnngw2TXhbtNbachN9N8ustyJ
SBdgVqGMrC6OlkoX5rrHPsdPSdPl44/gh4B/MLYCUZVvSEJ/ebzrF/nga4SPoDjB
xuObpXOCJP2vFOl7r8z+zZe2xc51XTk8RFRFma0XdNNuWCPazjXAKQ6AuaEuCzda
roBr3KuX0sfPWUijjU3u3rrkgK8RjQ==
=zAsu
-----END PGP SIGNATURE-----

--IOS1aer3GtsRQS2r--


