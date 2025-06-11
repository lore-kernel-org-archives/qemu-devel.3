Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DCA6C71141
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 18:23:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPQ6h-0006DX-WE; Wed, 11 Jun 2025 14:23:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uPQ6K-0005p9-6c
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 14:23:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uPQ6I-0000r6-Hy
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 14:23:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749666181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PsmPaWd9TCs50v7Ol4Owp4VCKULemOr5JU+xUL9x3Hk=;
 b=IGCxDDWMxSwyW5wv/t9ERk9tNJJ+X04VV3OjdxITUZ/MLzB8jleEbqAIJEaNIFafgrE2W8
 7E7V+ocQqw+hRNY/Bzw7OoIKLTZemwnJWDHfCF6Du58o9fkFCPOVPusQAtdjxLFKI4nJbS
 XJKeME0lHdAB3maKbvum8GvdDzan5aU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-76-6sdtbpDbO9q2z5WHmPJmtw-1; Wed,
 11 Jun 2025 14:23:00 -0400
X-MC-Unique: 6sdtbpDbO9q2z5WHmPJmtw-1
X-Mimecast-MFC-AGG-ID: 6sdtbpDbO9q2z5WHmPJmtw_1749666178
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7925C180B5F2
 for <qemu-devel@nongnu.org>; Wed, 11 Jun 2025 18:22:48 +0000 (UTC)
Received: from localhost (unknown [10.2.16.122])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 89596195609D; Wed, 11 Jun 2025 18:22:47 +0000 (UTC)
Date: Wed, 11 Jun 2025 14:22:46 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PULL 00/10] Misc patches (functional tests, travis.yml,
 MAINTAINERS, ...)
Message-ID: <20250611182246.GA198778@fedora>
References: <20250611125846.125918-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Re/KSLSGUQUKm7ar"
Content-Disposition: inline
In-Reply-To: <20250611125846.125918-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
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


--Re/KSLSGUQUKm7ar
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--Re/KSLSGUQUKm7ar
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmhJyXUACgkQnKSrs4Gr
c8j2Pwf+O/ovuhyXtbcjm5fOWg3KnBeDvGkizsp4sRtqg+v6fJE806wJ5d29i9+Q
USYAQpd4qXxjm6GSjQgy7yNFUoC6XWFTc0jcq7RMqRU/pyeURTbrt2hiBuidlvHX
4/9gF2jw6XZn202x9Kpis0OHG3I/9MW4k8Fe7s6O9SvjwJsL67VYyXA01dgMY/1/
2GFWRqRxp+AYpeatwNM8brriubBPDysvm8P2k4TShjEQxLRLvrhYph2lD8lHGyHW
uAz4wE71IEhuzHs+/wtW6lHAsjxoP1z16w+Jpv6+2YfBhW9ItIR+yK2MycHvmRTc
XhkqMlKz0sgJrgmfc2Mud0lfaxCyVg==
=Ms6g
-----END PGP SIGNATURE-----

--Re/KSLSGUQUKm7ar--


