Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A29CC0218F
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 20:25:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdEcQ-00045P-MQ; Wed, 29 Jan 2025 15:25:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tdEcG-00044n-Df
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 15:24:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tdEcE-00016p-NH
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 15:24:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738182289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u+ENmIyNkoUK8iFpFRpZjvJtbQqXH79JfF2qwvLNK28=;
 b=dAOZH0aC0CVi5X+7leJBb/ViI3d58IT2XG9oZd4Mxnt3FhiKnSxz8a1dqU6k0Zl+vh3xjW
 OFMFng/B0IKERKR3tULiC6aBL44WCEoUsvJtUhaFWCJE+SngAQmNGSRjrciilp43mak1HB
 8ur0MUJoMmCKAozXXYT9THCDicFgayo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-6tNwfEwePfmYxd51WjPGVA-1; Wed,
 29 Jan 2025 15:24:45 -0500
X-MC-Unique: 6tNwfEwePfmYxd51WjPGVA-1
X-Mimecast-MFC-AGG-ID: 6tNwfEwePfmYxd51WjPGVA
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7EDC91801F1C
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2025 20:24:44 +0000 (UTC)
Received: from localhost (unknown [10.2.17.72])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 05128180094D; Wed, 29 Jan 2025 20:24:43 +0000 (UTC)
Date: Wed, 29 Jan 2025 14:17:54 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL v3 00/49] i386, Rust changes for 2025-01-24
Message-ID: <20250129191754.GA193505@fedora>
References: <20250129112743.1348764-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="13Ep2rcEwXyl9kqi"
Content-Disposition: inline
In-Reply-To: <20250129112743.1348764-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
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


--13Ep2rcEwXyl9kqi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--13Ep2rcEwXyl9kqi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmeafuIACgkQnKSrs4Gr
c8iBsgf9HB1vnWdPIkWu82oJ01B/HeVfyXEJ5zecXLLtqagH2qwhKE4kQBPlPFBT
q1SAPYalpnvZW+fXlBPyqYppUKxQSc1NtOoLoDoZrOH0duAbRA84AopbEuO4YjAT
NQa/KhcsV2MqdURG1jpRCaVijggOKNKwnOdEbJ1MCIrERzn9tYn2qQ3ZL8qOOTy/
17VPzTVi1nBlYEdgjTzQDnL8AbqGcKfJIUELh4yPGWynPtiun6lWZ+TG8a3/AMnh
K3Bawiz7usN3eSJhwjHijGrRtfoc+mz9KcXGYGSfEletCeK23hjZcxiHBGCgSUI2
MsyZgCs5YSTnJiJloTnpDkvArOeXcQ==
=dhUs
-----END PGP SIGNATURE-----

--13Ep2rcEwXyl9kqi--


