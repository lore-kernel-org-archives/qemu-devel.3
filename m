Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6BF4C5AD49
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 22:27:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMDcN-0004ku-5r; Mon, 02 Jun 2025 18:26:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uMDcK-0004iw-Ms
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 18:26:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uMDcI-0003vK-QH
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 18:26:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748903206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qh+Uem8Gh1IIjx32twzmNBo+hbLhov/EKtVSRs5rKXQ=;
 b=SIVVAtl52E3Tbmh1J3ZIpXd5i9zTCxYo+Eu7du64AKLKs5gG/+nDCD06/Uo3utlVwog/9r
 wGQAazyDfOowpa+1sm337JsQnZz7Jq5BIYrtmxdpFjb564a2LjeBswMpRpzAcU8PL+Es9T
 7DF/UkdpiKQFhy+uot3kyGGOHVUhkGU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-76-c7FM-ithM06VClFPYpV1VA-1; Mon,
 02 Jun 2025 18:26:44 -0400
X-MC-Unique: c7FM-ithM06VClFPYpV1VA-1
X-Mimecast-MFC-AGG-ID: c7FM-ithM06VClFPYpV1VA_1748903203
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3141A19560AD; Mon,  2 Jun 2025 22:26:43 +0000 (UTC)
Received: from localhost (unknown [10.2.16.84])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 967FF19560AB; Mon,  2 Jun 2025 22:26:42 +0000 (UTC)
Date: Mon, 2 Jun 2025 16:43:23 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 00/31] virtio,pci,pc: features, fixes, tests
Message-ID: <20250602204323.GA319562@fedora>
References: <cover.1748791463.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cV6os5DVb+yUIKCR"
Content-Disposition: inline
In-Reply-To: <cover.1748791463.git.mst@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.015,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


--cV6os5DVb+yUIKCR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--cV6os5DVb+yUIKCR
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmg+DOsACgkQnKSrs4Gr
c8hO2wf9FK89hFVHqJJMApLmmWdGT/HZ4BoTP9o1nU89xicB1SdvjHKvbPuWniAE
1c2SqM9hUsTFpgPW9ySyv8DVSKX94RIHEbevX+VgcfUSu/pOQLzfLwcQ68yDksNf
BgkGwZe2OMIOS13sg89qvnDJkjS0+1zWJ3OmJkKwd8joUqZcPi96r/Gv4FsvvP+M
xgIj4+bn1VuXxTWRDDaH2LieXzs/m54mkSDGVQg+1WglX9UHXP5yjLtTW9mUmLun
9kQX23EeQS24msoJbyo0Sbkv0PbeATm2huPa0OM6BcGSCh5VOqykYFHqwD+a1uTV
oi0M2Z1a90tBxqFTwbAm37gctR+e0w==
=fq+3
-----END PGP SIGNATURE-----

--cV6os5DVb+yUIKCR--


