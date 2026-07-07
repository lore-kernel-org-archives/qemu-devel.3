Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82F95C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 05:05:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgxzH-0007XW-7j; Tue, 07 Jul 2026 01:04:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wgxyy-0007Tn-Bq
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 01:04:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wgxyv-0003lt-Sh
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 01:04:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783400659;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=86SHfv5mFJwrHof0itbyh0zJSHvjHCWxX+wy6lAwGiE=;
 b=CyxgksoLuYzebPinjJjWLlevw9i8SCub0tkg0AEexR00LEdSYeuatp0wYFA07Q2/woVaAC
 F4eBTJmM2JU2dJzRbqP4L/oy5PPQyaweyW1bcgmMpkUvkD5zCDLQKZHng97aeyf7dnhK4z
 osVLS5CSeUP2aVnVmqLAruwOKj4ceK0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-112-8HYyv_cnNMyc0Kf6vLBw9Q-1; Tue,
 07 Jul 2026 01:04:15 -0400
X-MC-Unique: 8HYyv_cnNMyc0Kf6vLBw9Q-1
X-Mimecast-MFC-AGG-ID: 8HYyv_cnNMyc0Kf6vLBw9Q_1783400654
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CF1291955D59; Tue,  7 Jul 2026 05:04:13 +0000 (UTC)
Received: from localhost (unknown [10.2.16.35])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2218C1955F71; Tue,  7 Jul 2026 05:04:12 +0000 (UTC)
Date: Tue, 7 Jul 2026 07:04:11 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Helge Deller <deller@kernel.org>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PULL 0/4] Hppa fixes for v11.1 patches
Message-ID: <20260707050411.GA524510@fedora>
References: <20260705154749.7368-1-deller@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="17pME/84AqCpxKRN"
Content-Disposition: inline
In-Reply-To: <20260705154749.7368-1-deller@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--17pME/84AqCpxKRN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--17pME/84AqCpxKRN
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmpMiMsACgkQnKSrs4Gr
c8jpQAf/c7on07T6FApf4f1C9vcXfOR8bNFx+u1KWcI5EqiZssW2zrdr64eVQSRQ
PZmF59aeVeKsRXNzZs8M27+xDdIDrHmVy6Hc89LGIzMrpe80RIemjodM2sYX3hCQ
I69xW2xWaXLPkuwcluYbTtq/7KHvIMt08327ZJWSCKHKMjXq5axBJHM/sv0wm6nx
/rZXLSAFIVbn0nIt3Q8kn3ycJpDviozh4sE5O5SVeNioRobJN8PdlscwSpt8nVs0
eAPUOAylJpywGskPhVKj9GDZ4+wl9g5x1kpaA2McQqxxP3fBVIEaOVmb+jfvSCZA
lww4HorOzD90ZyTTd7xgIUslZ5SAsQ==
=N0UI
-----END PGP SIGNATURE-----

--17pME/84AqCpxKRN--


