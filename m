Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10C6DCD98F0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 19:29:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZvx5-0000wv-69; Wed, 17 Jun 2026 15:29:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wZvx0-0000vE-QI
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 15:29:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wZvwz-0002SN-G7
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 15:29:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781724564;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kHUk9Oi5qdq1rg4Ld/J+xR30chZlRBw8Mbznu7rVBjw=;
 b=Mr9xaNJa6xc9e/SIobL9krUZFGxoMa6XkMHDLMOEnTdotbQ/ZuaXWRtlCMDTlGGRrvTM5n
 X529MJw79eNrfEY57kJYPawJ6xrasdLEsMfr9wpPPL8SAYTLc+mTayGH8zUmEIt9sG8Ltn
 Vx2ajlWWHky15ppCnbCCrVMS6QeJXSg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-671-JuixhDFeMyyyu7AO5qIisQ-1; Wed,
 17 Jun 2026 15:29:20 -0400
X-MC-Unique: JuixhDFeMyyyu7AO5qIisQ-1
X-Mimecast-MFC-AGG-ID: JuixhDFeMyyyu7AO5qIisQ_1781724559
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 959801955E88; Wed, 17 Jun 2026 19:29:19 +0000 (UTC)
Received: from localhost (unknown [10.2.16.131])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8CE113008B3A; Wed, 17 Jun 2026 19:29:18 +0000 (UTC)
Date: Wed, 17 Jun 2026 15:29:17 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com,
 stefanha@redhat.com, pierrick.bouvier@oss.qualcomm.com
Subject: Re: [PULL 00/26] Plugins update for 2026-06-16
Message-ID: <20260617192917.GA694170@fedora>
References: <20260616184230.303038-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pNLwokebObZA6ELH"
Content-Disposition: inline
In-Reply-To: <20260616184230.303038-1-pierrick.bouvier@oss.qualcomm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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


--pNLwokebObZA6ELH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--pNLwokebObZA6ELH
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmoy9Y0ACgkQnKSrs4Gr
c8i2tAf/QF6OlNRmGc+lkXoyKW2fNDP+qZMPqNz8Ay7RP70OCIVfv3kKVZiwgaLV
z3lm3t7fV1dnZ/s3TQo16j4PNoVrRz+AZYZdj65/RlRPABSc8QVFrSrUN71FtCqm
VFPhbJ7FLhMJ9Ixlz1rlAyaWs/6cpxMe2t2zarFoQ61aLKAadjXzCLSfzpmTU75W
aPnIR9hwJAJmYdOIh1/T2fBb2qAwjF1jADsB3bB1TkM9u+HYH2DBhmu62/OJYOG6
cVjqVZJswpt9WDMcYHoapIJcOybqkTx2NTw7BN+PkRFROkBS3eU4f51jeDZxgZWi
cCQSQD9dKWWnDyJCYMgE5VJGnxpQgQ==
=XzIK
-----END PGP SIGNATURE-----

--pNLwokebObZA6ELH--


