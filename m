Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 029BDC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 12:56:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXfwo-000896-2B; Fri, 04 Jul 2025 08:55:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uXfwe-00086P-Mh
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 08:55:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uXfwc-0004oq-Fg
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 08:55:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751633708;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nWpZ3thUxec//qDKk+HXX0IIu9EIOZ8dFrtcL0yYFF8=;
 b=KD8w2HakNzQ1NZF3vow2GBQnO5HXfy6dYYp1jdE6dD3crXEwaVzXPHauX3eqyqi8RUqVv6
 2fGbLmcxKeCp+H10AAnePw/eEjdNWNO7kN7C1spbn2MGO1Ozjz1fKIJ3j6MxCQfZq+/Rzn
 oEzLNDaLebRDpQeHLTbSeiIAOBuG4NI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-501-cmyiYeD7P8We4HB7ePK0_Q-1; Fri,
 04 Jul 2025 08:55:07 -0400
X-MC-Unique: cmyiYeD7P8We4HB7ePK0_Q-1
X-Mimecast-MFC-AGG-ID: cmyiYeD7P8We4HB7ePK0_Q_1751633706
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3DAC3193F05D; Fri,  4 Jul 2025 12:55:06 +0000 (UTC)
Received: from localhost (unknown [10.2.16.12])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 77EEA19560AB; Fri,  4 Jul 2025 12:55:05 +0000 (UTC)
Date: Thu, 3 Jul 2025 09:37:10 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PULL 00/15] Maintainer updates for June (gitlab, semihosting,
 plugins, virtio-gpu)
Message-ID: <20250703133710.GA76285@fedora>
References: <20250702104955.3778269-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mKOK25jiJvWA0kGT"
Content-Disposition: inline
In-Reply-To: <20250702104955.3778269-1-alex.bennee@linaro.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 25
X-Spam_score: 2.5
X-Spam_bar: ++
X-Spam_report: (2.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.218, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--mKOK25jiJvWA0kGT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--mKOK25jiJvWA0kGT
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmhmh4YACgkQnKSrs4Gr
c8hzsAf/S7zhBRYR+z/IEIkPXj/k3S2Ga5tPk7jrpZx+XTsm0OReTndNF4Z1hgeZ
awq/qe7/rIzg7oT8NtZoLm+eXD34EjXzMCeJokZ9OlYPEvgapn0ZC0nwjn72CzNo
ziwTlsTD43qh3afDDYs6FgCBOTPVAiFPKYOkJf1bbuJepO7mJjBq4dMbB+cPnkL0
cGJRabKXAzj2jbXngY5RSKNAXn9DNyKqJKQW9ISuOcOrxwA3BrBiVC0of2836FE1
K97ljhdHIyhfyL4QOjMIhN1Rz//RuZ97Dwc6g3SXWOoNmaOu3Y/ODRdM+z9Nqxg9
iRrqrnf9ty/7p4Me+Z0V0qURjJaN/A==
=E+AE
-----END PGP SIGNATURE-----

--mKOK25jiJvWA0kGT--


