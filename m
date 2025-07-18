Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15B94C83F1A
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Jul 2025 12:36:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udTH8-0004tq-0H; Sun, 20 Jul 2025 08:36:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1udTH6-0004ta-6W
 for qemu-devel@nongnu.org; Sun, 20 Jul 2025 08:36:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1udTH4-0007UC-1b
 for qemu-devel@nongnu.org; Sun, 20 Jul 2025 08:36:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753014970;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KvoOC6a6CeEUoSAXi+tBsAoRipKxMqriaa46nfj+YyY=;
 b=WPBLY9WKh4Aqbf4f/sr/f5+oNMHv2zvRpL+g0VIWc53rArkM+kILYYcECqtg/SXJAgq+u0
 hcdXhw3C0hYkyI9dWFvEHP4on/tNZuNJ3nPyAPo3hmmuCBHWls/A1oQs8ubLvUXiQG+D6r
 MUJOF42md1hslPtN6/vJiUal1gIVUYg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-4gqL9U9hMz-ZVstwlM951w-1; Sun,
 20 Jul 2025 08:36:08 -0400
X-MC-Unique: 4gqL9U9hMz-ZVstwlM951w-1
X-Mimecast-MFC-AGG-ID: 4gqL9U9hMz-ZVstwlM951w_1753014967
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7E3C719560B6
 for <qemu-devel@nongnu.org>; Sun, 20 Jul 2025 12:36:07 +0000 (UTC)
Received: from localhost (unknown [10.2.16.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 10BAE19560B3; Sun, 20 Jul 2025 12:36:06 +0000 (UTC)
Date: Fri, 18 Jul 2025 15:57:41 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 0/6] Mostly target/i386 patches for QEMU 10.1 hard freeze
Message-ID: <20250718195741.GA9102@fedora>
References: <20250717160700.357384-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MOZyLAGE/gwycK96"
Content-Disposition: inline
In-Reply-To: <20250717160700.357384-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_24_48=1.34,
 DKIMWL_WL_HIGH=-0.088, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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


--MOZyLAGE/gwycK96
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--MOZyLAGE/gwycK96
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmh6pzQACgkQnKSrs4Gr
c8j7vwgAgTz9PemPI6jZ/roEz066iGbtkOscNE5aIIcapVsEigGTRAFuaXj3+/N2
IjwMhbIdRmUdpeiGTGfkTXpDDGr3R55mAQ9qz4zDGnpqmn/8XcbkapHR9YO39AyP
SVQfN55zxi529zt5GXiDrKi+7EcPypS0piewfdonl+5YkOYtn58y5OUobEdX5WHC
1iqM0sAtn0TBVds606txt/bmgZ2oKjTMvo17ItrQ1dr9vr1XdhjEFAR8gMmZ5ER8
OYI+tpiYYhL1mvJoRdEgCIWhxFLivGZ3idy44xbqa5IF8uCMiyp1KJXInjoapsGD
8cAdRB0lq1IUeqKP+zfgz5A9BmF77A==
=3gYj
-----END PGP SIGNATURE-----

--MOZyLAGE/gwycK96--


