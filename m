Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA352C3ABBC
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 14:12:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDORh-0006nd-W2; Fri, 09 May 2025 10:11:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uDORf-0006g7-V9
 for qemu-devel@nongnu.org; Fri, 09 May 2025 10:11:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uDORd-0005dx-Nc
 for qemu-devel@nongnu.org; Fri, 09 May 2025 10:11:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746799878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=efuDjg0LxzMu8ynXSKiF4YlyRbK9qI2h/E8tncXRmYk=;
 b=SbyrqKry/obpTiXYX74rqEPmvPSDmCTE68NrBBLFyMpNe+vfYvp2jNTG49KOGIyFlScm5D
 DTqXtH7wpCW4yjZkZQevYZX0mCcJESHzdjn6Uq+FgCUzjcPzYz1dLpJdsWEl3ImvK8+LIB
 Ttm5O3I9KtkCTpIpUCEdLAv92ok8M84=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-465-Npl_6RVPOJuOLeDOL6ge-Q-1; Fri,
 09 May 2025 10:11:16 -0400
X-MC-Unique: Npl_6RVPOJuOLeDOL6ge-Q-1
X-Mimecast-MFC-AGG-ID: Npl_6RVPOJuOLeDOL6ge-Q_1746799876
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EAF66195608B
 for <qemu-devel@nongnu.org>; Fri,  9 May 2025 14:11:15 +0000 (UTC)
Received: from localhost (unknown [10.2.16.167])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4D632180049D; Fri,  9 May 2025 14:11:15 +0000 (UTC)
Date: Fri, 9 May 2025 10:11:14 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/30] Rust, wasm changes for 2025-05-06
Message-ID: <20250509141114.GA82864@fedora>
References: <20250506152927.222671-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6rikCRuf1DllEkB0"
Content-Disposition: inline
In-Reply-To: <20250506152927.222671-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.413,
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


--6rikCRuf1DllEkB0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--6rikCRuf1DllEkB0
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgeDQEACgkQnKSrs4Gr
c8i3lwf+M5M1M6NFG0k6biagYsJZNh4oQdnZx0gxZMBY3aEW+QTjRL6uSWKBn9Yq
20JOrLj5YZZVMGQjDpYMOYqcNjWKugY3t7RGeimOuLOmQs5gYs3qqUSKajkYv2cy
5J1WzUmkK7ERZcjAR9nUABTps09Hj485GrLtdPD8KBqqCSyJAIsGqtOLRSQ3Q7W7
3nRyP/yRWKvtFT5th2Z7jqJFjnDQX/UBGshzsXiBXj6HRIkl3FWn563vD0ynbTAN
3Z8qdq2eBzcHSSJtISEuDo89Y1+qZwzk/gp8kd7B7UcY59eldaVjP1d+xymsTunq
rVPuPPm5Uj++HiKxEWTlp+BQ/GKJuw==
=zOmY
-----END PGP SIGNATURE-----

--6rikCRuf1DllEkB0--


