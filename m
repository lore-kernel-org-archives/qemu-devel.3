Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A8C4C02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 16:30:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tadcJ-0004Ee-Cq; Wed, 22 Jan 2025 11:30:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tadcG-0004Dk-QH
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 11:30:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tadcE-00061U-Ff
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 11:30:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737563405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=btR3MJM2DEWzFjmowVl6zkGGsSnQRStWFAvTog0Uj2w=;
 b=NpKhA+vN9+TR5P44jCqFRFcQ7g7o6c4qsjxIOWmcW/8pj3pY2a282kWQdzdsHm8JInrzMU
 ksCxmwRdGShgQWtSd2b7aX+EmIjuvnJE0nrvr+pV3lFwBS53ipY+vTiDADJ9VuVOHAxdfO
 JOYcXj/OXgLN/S9ahr+ygdizC611o9M=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-433-n1a0zezvOEaGdD2C1455aQ-1; Wed,
 22 Jan 2025 11:30:03 -0500
X-MC-Unique: n1a0zezvOEaGdD2C1455aQ-1
X-Mimecast-MFC-AGG-ID: n1a0zezvOEaGdD2C1455aQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5417B1953944
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2025 16:30:02 +0000 (UTC)
Received: from localhost (unknown [10.2.16.37])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AC28A195E3DE; Wed, 22 Jan 2025 16:30:01 +0000 (UTC)
Date: Wed, 22 Jan 2025 11:30:00 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PULL v2 0/9] s390x and test patches 2025-01-21
Message-ID: <20250122163000.GA183250@fedora>
References: <20250122080151.1400422-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="TuJjUFoARTHL+Amn"
Content-Disposition: inline
In-Reply-To: <20250122080151.1400422-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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


--TuJjUFoARTHL+Amn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--TuJjUFoARTHL+Amn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmeRHQgACgkQnKSrs4Gr
c8gTeggAg0cFN3G7Dm8fsTUKbnGAvxyv2O+TqtMLp20L9LeOFUgtpk1AaZVa6MkL
pqojV8zN6unspKdJ883MtcuvvmS+v9XlzV+5kwvxvnGorPzJIKVanKXcwL85o2Pf
9k9r6GQuEwpnpZOvDM2gKwJweeG2X4KzIfjm8e9J5/eA3ngfDmx7fLbHv0BCuBKM
buMZGPwsNgYbM/nmlfUAvb96Z0c/xzQxKQoBTBqrSLnUNml3veYeIVr7tqJixTlY
kIRYQFfs+1C1MmQcJREWmFlARfArBx/rkmX8OIvYyRilSeA1Wa8XBsXnitjONgPY
sYOw8txTHqHkV7QqhaNXdAOfJ190jg==
=tmPK
-----END PGP SIGNATURE-----

--TuJjUFoARTHL+Amn--


