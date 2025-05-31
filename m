Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1689CC5B549
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 11:54:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uM3j7-0000xo-Nk; Mon, 02 Jun 2025 07:53:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uM3j4-0000xO-HC
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 07:53:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uM3j2-00019D-KP
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 07:53:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748865184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KUDIVic766YqA129XQb5lAkTVvWJJlS6d9Eyl1zcoMM=;
 b=Fqs5Cq91tjmSVgtZocAdN4TqZ73k1CnFXWcacK9aBuTX6EZpHzi5yBYNUHPUyX1QP656BB
 B038PNxyK0WLI79giefneZ2aCwJ1WzOSe39HymaDLRebjw4XD45cavgrMlCB0kToSrlC/+
 FkZpbHg1X7spJsdk1FXpb/39g4bLlBM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-151-gM5sqkmFMsCeoX-hYjTmkw-1; Mon,
 02 Jun 2025 07:53:03 -0400
X-MC-Unique: gM5sqkmFMsCeoX-hYjTmkw-1
X-Mimecast-MFC-AGG-ID: gM5sqkmFMsCeoX-hYjTmkw_1748865182
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 79EC71800876
 for <qemu-devel@nongnu.org>; Mon,  2 Jun 2025 11:53:02 +0000 (UTC)
Received: from localhost (unknown [10.2.16.122])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0E9E01800ECB; Mon,  2 Jun 2025 11:53:01 +0000 (UTC)
Date: Sat, 31 May 2025 19:05:36 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 0/6] NBD patches through 2025-05-29
Message-ID: <20250531230536.GA268126@fedora>
References: <20250529220228.1187563-8-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kkXOnGo/KH0vK/2y"
Content-Disposition: inline
In-Reply-To: <20250529220228.1187563-8-eblake@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_24_48=1.34,
 DKIMWL_WL_HIGH=-0.015, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--kkXOnGo/KH0vK/2y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--kkXOnGo/KH0vK/2y
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmg7i0AACgkQnKSrs4Gr
c8i4Bwf/RktUpbd0U/G9Ke+Nn9l0SQ13nnOmClqH7yPfonese8JaO/jyn/oQhgo2
k03hHlshKW4xZj+t/w92V6xQeX6ilzkJWSlldmbzJUadcF0vNttF/nz4C6saS4y6
LgGpldgfw8BJqDjPnyLIDbgL/hzYeRROwiWdXZKbGxzHjLm9LpuuMtehwBysMRIi
cPeVIAMXTXF2SAilBT4r4Pi191tWDT/BLkJcFNEoe83XB63n6MI0n2hrThZL8DWs
BWVtVNuDCZYlB5cW8hKCBSPcg588vd+K4iZ0pr2SU069N5To7snv7Khaux8yhvdY
5sb88Rm1b07LH3qZHbaDyKrBSuyHmg==
=9uei
-----END PGP SIGNATURE-----

--kkXOnGo/KH0vK/2y--


