Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54007C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 17:38:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEX6a-0004H2-WC; Mon, 12 May 2025 13:38:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uEX6S-0004Dv-P3
 for qemu-devel@nongnu.org; Mon, 12 May 2025 13:38:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uEX6O-0005AW-Ns
 for qemu-devel@nongnu.org; Mon, 12 May 2025 13:38:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747071487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WqNfHmWPhUVslGpb0lYOmAAGEG75LGfExo6OBFv6M8I=;
 b=cRdHA2a/4T0iJPnG+7wbo18fo2Wu5HrkE4dEm/DJtSuOxsd59PWEdKiKPKeEuTCG8lbGbR
 rcfT1aa0d/3l3RDCTqyncMAGPAbIlH6kIN1oiIAis45TjPRGjFM8cyi2rwlA8ifLWCBuHs
 9m/DNpTCNOgmRnol4pA4R8i+FefeAeI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-94-_k0uBCvDNFi6LDt3LeonAg-1; Mon,
 12 May 2025 13:38:03 -0400
X-MC-Unique: _k0uBCvDNFi6LDt3LeonAg-1
X-Mimecast-MFC-AGG-ID: _k0uBCvDNFi6LDt3LeonAg_1747071482
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5F7FB1800261; Mon, 12 May 2025 17:38:02 +0000 (UTC)
Received: from localhost (unknown [10.2.16.161])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 605D419560A3; Mon, 12 May 2025 17:37:59 +0000 (UTC)
Date: Mon, 12 May 2025 13:37:57 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-trivial@nongnu.org
Subject: Re: [PULL v3 00/21] Trivial patches for 2025-05-07
Message-ID: <20250512173757.GA153259@fedora>
References: <20250509205629.674225-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HQGdqdBQJnBEHcZ7"
Content-Disposition: inline
In-Reply-To: <20250509205629.674225-1-mjt@tls.msk.ru>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.551,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--HQGdqdBQJnBEHcZ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--HQGdqdBQJnBEHcZ7
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgiMfUACgkQnKSrs4Gr
c8hhEgf+Nugde2/8kOXRohrgvqWOUEAqWlIA5oPWHVbhC8W3F+bJ0TQaf9oGQyqP
Naj4ovhmEYgi+WwlXYxpIn+T4a9TBmNgZMa8hCo8GqV+dgNZRhdjtARwu5/LXIcg
avJZw2EZK0gJZvsAx7ISoqIQQJSgGurow5NVikgrlcuyAfbJmsdUmOdjeDzf5J68
Vveh9cURNkGGNViIo3K3oeo/7U9Et6Xf/dNcxzTFk89uqvECZ0TRlQL8IQa5Pk8W
pzYferzja4SdSJg1L0lzNzu7WYqPj7XsosBNHWv0CnvD7dmUam9GDnUm/Zr9pq4g
vkXNrXoaC8uhuhEaxPkAplOCm/rBIA==
=5EHS
-----END PGP SIGNATURE-----

--HQGdqdBQJnBEHcZ7--


