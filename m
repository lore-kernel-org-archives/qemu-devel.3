Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA71FC369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 21:19:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u83yZ-0004EV-EI; Thu, 24 Apr 2025 17:19:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u83yX-0004EG-Mg
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 17:19:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u83yV-0002DA-MB
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 17:19:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745529553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XqkW2sbKTPKbnVmqdr4mKc9z/u33gxpDJ5EEo51Adec=;
 b=CWWXWXDcl2VFAlc+KZDVvaR112sTbj+SmYm3RatJWybw/ix8sYEA/y9KDWcG9r6U8qNgC+
 ftQc6cI4oTFeC9LLwpq5Z2ZL0crq6muQdFEOx/E0hjdHEHiKR3iJVPDIL0cfKXqkVf/LHH
 IfoYAJ8CzOtNlbXJ2laHtzp7IgmFKCo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-3-4Sn4RzFQNqSfr1NcOJRgYw-1; Thu,
 24 Apr 2025 17:19:11 -0400
X-MC-Unique: 4Sn4RzFQNqSfr1NcOJRgYw-1
X-Mimecast-MFC-AGG-ID: 4Sn4RzFQNqSfr1NcOJRgYw_1745529551
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E320E19560B4; Thu, 24 Apr 2025 21:19:10 +0000 (UTC)
Received: from localhost (unknown [10.2.16.253])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6158A1956095; Thu, 24 Apr 2025 21:19:10 +0000 (UTC)
Date: Thu, 24 Apr 2025 17:19:08 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 000/148] single-binary patch queue
Message-ID: <20250424211908.GA457771@fedora>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3JHPtjP84c3QITYP"
Content-Disposition: inline
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.84,
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


--3JHPtjP84c3QITYP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--3JHPtjP84c3QITYP
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgKqswACgkQnKSrs4Gr
c8iL5Qf/S7JXIy1Fwg9d6mij6fvRnXX9KvOjxPASnEctcFz53HiW0+Z2k3531+3G
MT1TUzsY/qBkynUxfFg9BxV2uyI5dvIv+IkzyPdg2Wlepi+lcZkva/m7UV9bxjER
BLrrYgFdpr2OG9FIeZNXtIVWoatggWuvClbCWw8UFBWkUVOzijk/TAcDkIuEYRCN
dzjrxJSueLNHV8orZc5/UwJEyL34Y7JM00HH+2CXQbv269o1dL2yTWR2Q5j4VLYZ
pm79GVA8X205VDUufueNYXvRLJw3oYbrjFViFnEnolIZOM2KqG4TPGV2o+aouLSk
8/imHIPAQ+ws2mQxJeWDmwwi0WPc2g==
=6R6N
-----END PGP SIGNATURE-----

--3JHPtjP84c3QITYP--


