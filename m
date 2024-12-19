Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB0DFE77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 20:06:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOMmm-0003M0-NI; Thu, 19 Dec 2024 15:06:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tOMmk-0003LY-Mv
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 15:06:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tOMmi-0007Ge-9f
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 15:06:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734638770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to; bh=WIccNZJXqBcp5yc3q4m0z9Pl3gunPsUqzwIf6f0ownY=;
 b=R8iwfc6SV9xFe8cxQWa25MuTIWGEJ14KxAyMaI3dr3PHsnhn/GEeW/lqSA/Ja5P0cTOdLe
 0IkdujCsiqnhtfnVT1T449vaB61RWmHcsz1yG1vfJpDYeoxGS4Y9PCWz74yBRipp6MmYYp
 b0HHQbLEO2PAFr4GY5q1ublW6IAL+V0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-bp-SQ3l4PIOAnwM6yc7ojQ-1; Thu,
 19 Dec 2024 15:06:09 -0500
X-MC-Unique: bp-SQ3l4PIOAnwM6yc7ojQ-1
X-Mimecast-MFC-AGG-ID: bp-SQ3l4PIOAnwM6yc7ojQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 65B7E1955F41
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 20:06:08 +0000 (UTC)
Received: from localhost (unknown [10.2.16.70])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B640319560A2; Thu, 19 Dec 2024 20:06:07 +0000 (UTC)
Date: Thu, 19 Dec 2024 15:06:06 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL v2 00/42] Rust, qdev, target/i386 changes for 2024-12-19
Message-ID: <20241219200606.GA723061@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="PqpypDKGA2BBqe9K"
Content-Disposition: inline
In-Reply-To: <c22ccbb1-9fdc-410c-85c0-ffa91de16b09@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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


--PqpypDKGA2BBqe9K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Paolo,
Will there be a v3? It wasn't clear to me from Richard and your replies
to v2 whether another revision is needed.

Thanks,
Stefan

--PqpypDKGA2BBqe9K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmdkfK4ACgkQnKSrs4Gr
c8jaEwf9Hmo3iyoLoMDLiDTgkKD1GmJVZRN0wauVhh3RjpP5NU03Id6NPGovuYDn
owUfNX1kJpvxpP+Qa+hOcTAy9zY2eDUzzmljrSChJaiyn89S6ubyrrl0gezgSCMv
3QSB08Y1sjPvOLdz+IVvLuHH7a6XdNyacbAmlnUv/VAWert6CH7H/42jfo9IhgaT
N1aRNGIJyWc9wxTJsHRfBZoCELKkxDtuyfePhsKUExNpKku6qM1tHvGN+SluykbP
QDQn2owTIH7PWcEbRSbh95BfPNqnXTaSiNVgvpmAeEhDfySJK/tJfD6EHoW8tqhD
wUEE0WuW6y4wPnf//6/2ViuXea53+Q==
=0mp+
-----END PGP SIGNATURE-----

--PqpypDKGA2BBqe9K--


