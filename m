Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC2ADE7718B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 16:49:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOJh4-0000TN-14; Thu, 19 Dec 2024 11:48:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tOJgz-0000Rm-Ae
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 11:48:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tOJgx-0000nH-TG
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 11:48:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734626881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0lSUcArOxb8rYOAL6QbXEPWAf1fOy0fYBsZ6EFPpUZQ=;
 b=BLH8ixn1stIuSeFt1E0FpqxXDQ7HtisY7/Xc7RcvXhwkg2ghR+0pXYTP3101K0z8J2yTJd
 9/Feyihv4+IyMKLu/ryB2sbByxVit79/uY674u5TykVR6rudylnmH0XeX+YUgBYD5Mdg/x
 +A5nUnT0foReD/ze8EilT6YnANDgZrU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-38-932t8XnJOU6EjQq3SIrvsg-1; Thu,
 19 Dec 2024 11:48:00 -0500
X-MC-Unique: 932t8XnJOU6EjQq3SIrvsg-1
X-Mimecast-MFC-AGG-ID: 932t8XnJOU6EjQq3SIrvsg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E8EDE1956095
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 16:47:58 +0000 (UTC)
Received: from localhost (unknown [10.2.16.70])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2A6CF195608A; Thu, 19 Dec 2024 16:47:57 +0000 (UTC)
Date: Thu, 19 Dec 2024 07:29:54 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PULL 00/38] Functional test improvements, and disallow libnfs v6
Message-ID: <20241219122954.GA692692@fedora>
References: <20241218110958.226932-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="WhW7IzWbjht509eA"
Content-Disposition: inline
In-Reply-To: <20241218110958.226932-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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


--WhW7IzWbjht509eA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--WhW7IzWbjht509eA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmdkEcIACgkQnKSrs4Gr
c8jfHgf/aDxgHHDLyMak5rdPgi1g067Os0X2ro6zhatO9DzW0l1wvBEXf1KKFRPp
2H4hLUtvNMMOtlWUZCy77U/kJYpx4+dYmRN93g95W1/Y0tI/zisTvC0JflKRz6k4
2V8HlUETJmE2yPG2JYQ2DRoM4tFF3HZQmG8E0ZGL2rsB76xz3oPpvCre8Nfbtu2g
HQFlb+Z+n/I4in9Y5mRhrUU/2p0mykbox3k+y66Ivhh8Lw2blI34voSerhOViEbo
oBKKfVyyyO3aw/E1d4RmEGJhInuTQTarOjxs9ELvQuA7F7qEpaj3lraYC02CyqvE
cPefo0pMBRibpS8Ms1plc/UKguNpzw==
=PG/f
-----END PGP SIGNATURE-----

--WhW7IzWbjht509eA--


