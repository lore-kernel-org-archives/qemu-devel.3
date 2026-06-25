Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD92CCDE00B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 20:27:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcqeq-00044X-31; Thu, 25 Jun 2026 16:26:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wcqel-00043Z-1R
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 16:26:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wcqei-0007gZ-TW
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 16:26:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782419195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ntP+9RylI7k2+ZrktVAq8eV0XZbz4oT972ZiYCDHsAI=;
 b=Bx/q5XGwBRQN7u1oyFpWtZkSTiXUDBoL6HGgwgqEztgWe6X22XbQNnD0+qdz2LX4HQ2QHU
 Bhl0ryYVqtvAj/gnPBZj2MZn10JmRoC2g1OPeU8zIAvaZ30cdUvBRzzzSowAZmEWKOSz3R
 /yMDtzYhZTUVDSYg6i2n6Yrh9DTBz7c=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-YkWYhdZTPMC9YzOBoIC5KA-1; Thu,
 25 Jun 2026 16:26:34 -0400
X-MC-Unique: YkWYhdZTPMC9YzOBoIC5KA-1
X-Mimecast-MFC-AGG-ID: YkWYhdZTPMC9YzOBoIC5KA_1782419193
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EB2B5197750A; Thu, 25 Jun 2026 20:26:32 +0000 (UTC)
Received: from localhost (unknown [10.2.16.255])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6172B195608D; Thu, 25 Jun 2026 20:26:32 +0000 (UTC)
Date: Thu, 25 Jun 2026 16:26:31 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PULL 00/18] Next patches
Message-ID: <20260625202631.GA264961@fedora>
References: <20260623124759.125399-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ii/x5Yc5gqR3/Xqk"
Content-Disposition: inline
In-Reply-To: <20260623124759.125399-1-peterx@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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


--ii/x5Yc5gqR3/Xqk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--ii/x5Yc5gqR3/Xqk
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmo9jvYACgkQnKSrs4Gr
c8ghIAgAqIlmPll8c7qExuOujtbE7dR2usW3tR7n4os9qEhJl9bsMp6cUj/UiCR7
fGIxT6t503PxUlN404+MQSHqQO+dn6e+RV+fubfHDnfHuH0J744wy4hpkRpxtOH9
/Hvpr1Fmzjx9rAmzKG78QGG5+ntJvlKunSclbnIwGrMWJ1/YDblMVuVE80jQ3wL8
EwzPGX+kfB7RzHtcsFmPxJgrmJpG8o+zyGchMKuacZ3FGaHrvgp5abWhK9wHBnCP
yNssP3lftWOYtj9DNHUb9U+MKo4GK5LXvPcoIy7IwhLU7CywSBJsfIfexSm1UzAo
vwyT1aubY2NNT9Bztz9hkoS6D/LcjQ==
=CX1/
-----END PGP SIGNATURE-----

--ii/x5Yc5gqR3/Xqk--


