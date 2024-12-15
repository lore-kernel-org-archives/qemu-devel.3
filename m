Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B387FE7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 14:19:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNBvd-0003X0-Jl; Mon, 16 Dec 2024 09:18:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tNBvb-0003Wb-R1
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 09:18:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tNBvZ-00009L-Po
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 09:18:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734358707;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XKHO3y3gISfoOCw3QJ+61MLg/Y5CFwap+RC7rzi6lxY=;
 b=JPTSbs/ofxv8DYjZ49BLcgvob8rvwpmnyL0LNyJkgXDzgp+/T2wm5SrT2SbnikUoynu6+G
 xyAsK7tL/RIp1KSvPD1Qdpp2DY+oWw7B0/4SZT7Y04+k95jkBtmyPrjZxT3k1A9hf/njdP
 ToIGeWW6lhWhwU4SENBlltgsFzHRq4g=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-407-jHqJrkCKPRyBp-S1XPilzA-1; Mon,
 16 Dec 2024 09:18:23 -0500
X-MC-Unique: jHqJrkCKPRyBp-S1XPilzA-1
X-Mimecast-MFC-AGG-ID: jHqJrkCKPRyBp-S1XPilzA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 21B3D1956079; Mon, 16 Dec 2024 14:18:22 +0000 (UTC)
Received: from localhost (unknown [10.2.16.118])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C09581956052; Mon, 16 Dec 2024 14:18:20 +0000 (UTC)
Date: Sun, 15 Dec 2024 07:33:25 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/85] target-arm queue
Message-ID: <20241215123325.GA496111@fedora>
References: <20241213173229.3308926-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="41MbaTLKdAuODUTi"
Content-Disposition: inline
In-Reply-To: <20241213173229.3308926-1-peter.maydell@linaro.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_24_48=1.34,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.13,
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


--41MbaTLKdAuODUTi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--41MbaTLKdAuODUTi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmdezJUACgkQnKSrs4Gr
c8h9Twf7BXW9fOXr+s54IE5HjXmDEm/hr8YgpVaTTzt77zfXoXtmR7E8EhsxGEb1
gn0qoJ2qMGVmiA7Z3miSxQuJAgFVRqSsGboVODpbDZ+zuj6aihoWppBdAV/UR87+
Aw9q8+wof2VnKTYugPRJtVXxMzEwrcZ/0PTSDXnMlrskW0ku87adbRGyKpx2hBAF
1MZZaJSY4t/SLqud1LP/YM3qE8S7AKczoKm5HtO+fyT1RDFH5RClP1/RypnCbhzK
UKDkEQvaU7igVyUTRnF/m56PFtVTEjSbd2et2crwCPNi8Eb9xDyNzEhY8JP7N688
tWqkObX/4biSnFlrS5p024/63ssIAw==
=oWCJ
-----END PGP SIGNATURE-----

--41MbaTLKdAuODUTi--


