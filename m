Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E6F1C3ABBF
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 13:58:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCIoS-0007Ez-NW; Tue, 06 May 2025 09:58:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uCIoR-0007EF-LJ
 for qemu-devel@nongnu.org; Tue, 06 May 2025 09:58:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uCIoP-0003NR-Vb
 for qemu-devel@nongnu.org; Tue, 06 May 2025 09:58:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746539900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EHE9CbSLPtOtL1pWf3PlUAIrkM9yQwqjzTajpP0lbYM=;
 b=MAdfv8X20iLPB/AliUumeYAehqtG/rQKu8Qrb/srS/DAgTLjivl6b0b4VPFVVknoMW4xmK
 Tit97/S2pmkZhVT1zg74peRJReimNK6d3PYBDnFlat2mM4dAN9msqOCijknhFO2UqA1h+q
 5fBGDhsEWrsnjWlwyJlxBqpFxwyb6f4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-edRKkBX6PEayomjMYJJBZg-1; Tue,
 06 May 2025 09:58:17 -0400
X-MC-Unique: edRKkBX6PEayomjMYJJBZg-1
X-Mimecast-MFC-AGG-ID: edRKkBX6PEayomjMYJJBZg_1746539896
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7806718011DD; Tue,  6 May 2025 13:58:16 +0000 (UTC)
Received: from localhost (unknown [10.2.16.219])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B1C0B195608D; Tue,  6 May 2025 13:58:15 +0000 (UTC)
Date: Tue, 6 May 2025 09:58:14 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Stefan Hajnoczi <stefanha@redhat.com>, peterx@redhat.com
Subject: Re: [PULL 00/14] Migration 20250502 patches
Message-ID: <20250506135814.GA302639@fedora>
References: <20250502164141.747202-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rjmIFKMd0E5dk5iu"
Content-Disposition: inline
In-Reply-To: <20250502164141.747202-1-peterx@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--rjmIFKMd0E5dk5iu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--rjmIFKMd0E5dk5iu
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgaFXYACgkQnKSrs4Gr
c8g/kQf+Ktg2cVgDmshcudqW8WSsWKTcyxG+Fb3Ks6scJjd45CR2gVUcY6WXgTS7
eCQu99Uvbo5UKZ98TcKnrdoWQsG65vzz2IzpHbNKJj7RLvtq2g7+Gph++JmS3jpw
u5aqp6l5hYMMslsCJkhxgwtNYR+6Y/CZvjdhKyDZhcvxNDedc1F+MfZyCss1c0CH
quGunqf83NvEzG651sdHe5ENVUYoKE+mvyQ+azne+xlU1PRpp3xdm2LX1Sgm7aw2
eEB4a0MnEmNtBwMyq1yfWMoglWa1VpSIrS73wkcZgKq2JUdI3/pK3hpAlyVTLRis
GOTsDolibsXvrmNY9yNaeuNToQt3pg==
=H4ZE
-----END PGP SIGNATURE-----

--rjmIFKMd0E5dk5iu--


