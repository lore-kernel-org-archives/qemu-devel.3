Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8467FC02196
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 14:16:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1texDT-0000XA-0O; Mon, 03 Feb 2025 09:14:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1texDQ-0000WV-Ov
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 09:14:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1texDP-0007wh-86
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 09:14:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738592057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QxobTZ3LTqL3QMnhOGVkKUiolT3jTd9K1CRIxadQ4Rw=;
 b=dx7zUNEbWi+x97ZzGpkzyEI7Od9j8XbZW6geqtkyepiBjS4RGyKuO+IRBEyBkIE4QEwX1a
 9qRG03VFmtZNjc2gTFqoRQcLUlE2FJjQoqQOlShQoEGzW+n/IkpXe6D7GJKI6M7ugZFBni
 fElDzP34yRR0cdC5DxD3UJcTBzwZrO8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-210-i0CfgaUvP4mfjCofBB7nZA-1; Mon,
 03 Feb 2025 09:14:14 -0500
X-MC-Unique: i0CfgaUvP4mfjCofBB7nZA-1
X-Mimecast-MFC-AGG-ID: i0CfgaUvP4mfjCofBB7nZA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EC271195608D; Mon,  3 Feb 2025 14:14:13 +0000 (UTC)
Received: from localhost (unknown [10.2.16.93])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6F9971956094; Mon,  3 Feb 2025 14:14:13 +0000 (UTC)
Date: Sun, 2 Feb 2025 12:49:34 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PULL 00/36] Misc HW patches for 2025-01-31
Message-ID: <20250202174934.GA62465@fedora>
References: <20250131210520.85874-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="DjvQHI6LFsGeH93d"
Content-Disposition: inline
In-Reply-To: <20250131210520.85874-1-philmd@linaro.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--DjvQHI6LFsGeH93d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--DjvQHI6LFsGeH93d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmefsC4ACgkQnKSrs4Gr
c8iRWwf+Jx7T310WU76pdWqKRxejFG6eFGOGoJlTz/PdILinQBNc6K30m3d6Q4Ax
4WLNfWBKTwz+skoU9kb0A5SePsAdoN/CSr759FTXrJ6E1aJ/FhJP/WSrAjSgRcYC
O+hZ7IMXwgsRtwYJKHVl4HzbzS2PsenTykvfqcpd/lvKyqN9UYLfPxEhNXJUBa+Y
zpjde6Ac08amh7Do6hKYUAOFMxwqrk6/bRYZ8dwbhzMC5avg7Ye7WEPHocq1qKCO
67zhvV2bpNDxw63xBdlRBchrARUcoL5EijfmD/BAfNAK5z7aAa9ulEkJQ9JtrAnc
vqfY+mffri97tONQC8hEWTtmSbro0A==
=xT5w
-----END PGP SIGNATURE-----

--DjvQHI6LFsGeH93d--


