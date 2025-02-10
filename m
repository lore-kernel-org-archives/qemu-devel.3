Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 738ADC02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 18:21:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thYPR-0004I4-8q; Mon, 10 Feb 2025 13:21:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1thYPP-0004Hn-A2
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 13:21:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1thYPM-0003pZ-IG
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 13:21:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739211680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CSVtQBlNjp1xug5OAioujypCY6WfEQK33x9g0EfjLKg=;
 b=Vg3a76i0Ct9lGkARFVbsppksuTJFBnHhAhWMZ0js4tVIVWGMoi0Sdtyp8TuhchTMKZpG8e
 askTjw0Eq+icBL4LY28bX2+6OVPPYMRWEOOxRlNegIyTfu8ZJcWMCBCIKynOn0Ghf/l4XR
 qNOamcNcD/M50r8HFN0DQzVlmqWVMPI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-453-yWnS32AWNOWDwkhP3Lnycg-1; Mon,
 10 Feb 2025 13:21:15 -0500
X-MC-Unique: yWnS32AWNOWDwkhP3Lnycg-1
X-Mimecast-MFC-AGG-ID: yWnS32AWNOWDwkhP3Lnycg
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 05F961955DB8; Mon, 10 Feb 2025 18:21:13 +0000 (UTC)
Received: from localhost (unknown [10.2.16.124])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 894451800570; Mon, 10 Feb 2025 18:21:12 +0000 (UTC)
Date: Mon, 10 Feb 2025 13:21:11 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 0/9] meson: Disallow 64-bit on 32-bit emulation
Message-ID: <20250210182111.GA118315@fedora>
References: <20250208205725.568631-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="jD5u1vPp34skQbpd"
Content-Disposition: inline
In-Reply-To: <20250208205725.568631-1-richard.henderson@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.388,
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


--jD5u1vPp34skQbpd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--jD5u1vPp34skQbpd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmeqQ5cACgkQnKSrs4Gr
c8iDMQgAm7IKMwz79gjebsSuEswdc1Q8B5+Y1uqmLjMWP6BmD4E5DSQcpqlWVj2A
ZggGA9gi+qZtRGaGJ3/iCgYAhMP4DA9q0oIRhxIteMWY1IOwL6oGd/8BWy0O+Jik
hEIxe0bMC1LhdWOT/U531ErWfVcUKqVqVkSmAirwNn93KZ/J1ovyaZFEy8NSPIqz
c9P3RF79yU8kw/9fiJnyrMKxf5N5oldpRokejSueqFCh7iKQbp1DcgwYy01Rs7Yc
mOAK6lR3MYLxdLtH5LavQtQ2opV3Oo8SiuUEM0UpJCkGhJyQJWS5G1XwyYO7vMuM
43/4FuBAHELxXlx8WoOFzrxUgxCtcg==
=tFou
-----END PGP SIGNATURE-----

--jD5u1vPp34skQbpd--


