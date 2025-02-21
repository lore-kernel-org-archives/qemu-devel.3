Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64FB8C021B3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 23:34:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlcWf-0007bT-3A; Fri, 21 Feb 2025 18:33:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tlcWd-0007bK-K4
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 18:33:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tlcWc-0005jC-2L
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 18:33:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740180819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GiAUKEvgH6k8Wokd9pJol1Gu2A/GcQYfaFh3XOl8gsI=;
 b=SVOjradm/RIkKoZ/PsseVpoouY9pHEYBnXtfYIonwOsesVbOPgKqrWA94+zX7w4pKr9KWk
 rdh0XgOKgLXniGpGelWrOLBAsUZ1WQ0mt9AJXg9ng19uSyXzNUd4FxvNl9b3t9MtJMX4ZE
 t/xsEp/23qZ7C4ENpF13sRqB4Koum1w=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-317-8LOi4I81MqO-d_CZ-vUtyg-1; Fri,
 21 Feb 2025 18:33:36 -0500
X-MC-Unique: 8LOi4I81MqO-d_CZ-vUtyg-1
X-Mimecast-MFC-AGG-ID: 8LOi4I81MqO-d_CZ-vUtyg_1740180814
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8F4D319373DC; Fri, 21 Feb 2025 23:33:33 +0000 (UTC)
Received: from localhost (unknown [10.2.16.7])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0317819560A3; Fri, 21 Feb 2025 23:33:31 +0000 (UTC)
Date: Sat, 22 Feb 2025 05:02:41 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/41] target-arm queue
Message-ID: <20250221210241.GA11425@fedora>
References: <20250220162123.626941-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="dYAuIiwd96Tzt6yr"
Content-Disposition: inline
In-Reply-To: <20250220162123.626941-1-peter.maydell@linaro.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.424,
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


--dYAuIiwd96Tzt6yr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--dYAuIiwd96Tzt6yr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAme46fAACgkQnKSrs4Gr
c8jr8wf4qlnktavvV703Ki7i13RqIkesMb13KEuAzEsP5n3J7OdgaT/Qk555ePLI
9YQc+gjSae6bn/1Xi7EW1wLw6fVDc+/p9ijTYVx4n4IlQDqyuHpYb4ZTtqfh1xK8
B1V4+/fG+8LhWP7v+FzuKh1vuJC6BGsCKtVPl1HJBCWdPREco6+zDoZqv3g/XqL2
J6j9wcB06G3dou5McCxzICOCu7WT6uMKY7YNa58CqoQH8b6100L2dsaAPoZfzQCO
q+b4FZT6/v6tjXLDE7rsWPg9b/MQwK5fTqhXhODqcQxbCz8e8xLn12wC3e8eImgz
Zo+boX73xE/tlFNzAxXbDyTT9Ydn
=mXxv
-----END PGP SIGNATURE-----

--dYAuIiwd96Tzt6yr--


