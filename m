Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3A8EC282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 12:14:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tu9LU-0001iM-R4; Mon, 17 Mar 2025 08:13:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tu9Kh-0001RW-5O
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 08:12:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tu9KW-0002j0-4g
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 08:12:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742213536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=npIf0dyo6VG8MghpTlIGYQPDvkUkxfTZOZRxhGp1LDI=;
 b=Vj4vvjo7JoPZE0D4lnLt/f1UOZAEcjkB8MGWMtaAc6fGvVsv6LcuIsAHL492YkhLTgO+E0
 ccdC9WxSUCmOy55hWWLbU/pCHP9b2bo/ebtqZVzQkfNb4wH3jNKe1LFUVPKAf+3qnsdIBp
 wJpOMMCvsJR7Qj9bnHRcXRqTplhFk3Y=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-461-pBqfD_dLPOquXNFTG0kWxw-1; Mon,
 17 Mar 2025 08:12:15 -0400
X-MC-Unique: pBqfD_dLPOquXNFTG0kWxw-1
X-Mimecast-MFC-AGG-ID: pBqfD_dLPOquXNFTG0kWxw_1742213534
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5381519560B3
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 12:12:13 +0000 (UTC)
Received: from localhost (unknown [10.2.16.82])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5E1AD1955BED; Mon, 17 Mar 2025 12:12:11 +0000 (UTC)
Date: Sun, 16 Mar 2025 06:09:55 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com
Subject: Re: [PULL 00/12] QAPI patches patches for 2025-03-14
Message-ID: <20250316100955.GA1182058@fedora>
References: <20250314101038.2408751-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ZQLvZbBa621Y0bIQ"
Content-Disposition: inline
In-Reply-To: <20250314101038.2408751-1-armbru@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_24_48=1.34,
 DKIMWL_WL_HIGH=-0.335, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--ZQLvZbBa621Y0bIQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--ZQLvZbBa621Y0bIQ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfWo3MACgkQnKSrs4Gr
c8gKHQgAg33tR4Or2aY9xRMu5wSP3GJgIB/1lEkbMzSsLp0F7d2thEqw6EKuKdAD
4RMSbd4bs86P/nGRfKp2in/H01jg9SCpH0viLE0RaOkoYohEjFTO+zfHLnwwWKAL
fUenjlLJossCgNEhLoOPd+vpI1vLvuEvdkUpbnxxj8IcezjMOHG0P6CuiQ8QnIuw
mDrPubakh6MxW3+Z/fuF9cMDjqwpbXeIKHUMylEmAxhFR4HTVPTNWyDBT6/EpReK
zH2IZgTqPCBWkpUOMeQ4nQs9cUNeBc1wMfW8Jju8u7ERQ1JiQJVbtKaqUyEG7gTN
LsB19ObfqySq214oMerIWkCG5cYtuA==
=BAxE
-----END PGP SIGNATURE-----

--ZQLvZbBa621Y0bIQ--


