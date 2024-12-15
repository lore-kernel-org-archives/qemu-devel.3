Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 506D0E7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 14:19:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNBvh-0003Xi-Iw; Mon, 16 Dec 2024 09:18:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tNBvd-0003Wm-5F
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 09:18:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tNBvb-00009X-6l
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 09:18:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734358710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZeAs8kqsw4xciRMmniVYl99YNVZa8OC6R0AcvYkLwtQ=;
 b=HOlSSPdO109drcJ/sQZirEQzASxTe3b03cRcZaTbKSic6E2cRcAGlx7HnSm6iysZTEIcpL
 q8uouTVO72fJwNXEgPzTdLkqRUR2tLv6xajfKRyXNMPtXpyCuZkbwACJC8DkL4Q7KVNRxF
 RRMO9476Ofemm8PQpjUbZ0dAQiWJPhU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-265-06nZiUWvO2Kiz7XqoxBHIw-1; Mon,
 16 Dec 2024 09:18:25 -0500
X-MC-Unique: 06nZiUWvO2Kiz7XqoxBHIw-1
X-Mimecast-MFC-AGG-ID: 06nZiUWvO2Kiz7XqoxBHIw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 924DF1956071; Mon, 16 Dec 2024 14:18:24 +0000 (UTC)
Received: from localhost (unknown [10.2.16.118])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 28BC3195606B; Mon, 16 Dec 2024 14:18:23 +0000 (UTC)
Date: Sun, 15 Dec 2024 07:33:37 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PULL 00/20] Misc HW patches for 2024-12-14
Message-ID: <20241215123337.GA496133@fedora>
References: <20241213233055.39574-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="nSBYccH3afm2Xtkj"
Content-Disposition: inline
In-Reply-To: <20241213233055.39574-1-philmd@linaro.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
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


--nSBYccH3afm2Xtkj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--nSBYccH3afm2Xtkj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmdezKEACgkQnKSrs4Gr
c8j2Rgf/cRTs+6FYbHDeaxwJq1ddANjeHufHXyLNvu2RrRJc0BJIhlNBlx088Hm/
fYw0ZTcKv8JK1xKtGpPvrxqq/4LY+byaC6IgDyVTaTmXZtWbRam/dV0YAVLDIcSe
FQuDTwGvULuZflvqhOkfd4oFcxzO97zGZhLZKSHjA1ifXZpEoaWVeDcHNUz5ylG+
s4ADMisa67r0pFwcAkT5R8pNpLlIawMcx6clDucyVaoIByByqg7j44I4XckBdu0l
dSqmiBJBbH8xqcsIHZ1EyedYRH/RvSMEvPpSIEWcHxImbJJtpssFroD8Hr+KoBkX
3RiIgdS5YtuqQyaPUPoj5xhRmhPsPQ==
=kzvw
-----END PGP SIGNATURE-----

--nSBYccH3afm2Xtkj--


