Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97A43C44508
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 06:52:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjtTN-0002wf-Fq; Wed, 15 Jul 2026 02:52:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wjtTM-0002wD-W4
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 02:52:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wjtTL-0003sd-OW
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 02:52:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784098319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vMTVFGlv5u1av3kZPchu9NKGhxXO2WqAOayP1q/xZGg=;
 b=TYrNza7fdwNNeLacwX2qxNgVJeh2J5/sXKVri/TOwoWwx7ETNbo2LrUEpx3JIJ8HCHTI6r
 yfk5tA90p5zhSu9J9OMc7yB0IKqTrRVzXEDIU57kKGzth/BrsGS8szKxLgY7Er93p7ekzF
 oDgggN18NEDzlMbi2XJDynjln8Y1q5M=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-8UaOCpNyMPGf0K0HPRx-GQ-1; Wed,
 15 Jul 2026 02:51:55 -0400
X-MC-Unique: 8UaOCpNyMPGf0K0HPRx-GQ-1
X-Mimecast-MFC-AGG-ID: 8UaOCpNyMPGf0K0HPRx-GQ_1784098314
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7FA391955F61; Wed, 15 Jul 2026 06:51:54 +0000 (UTC)
Received: from localhost (unknown [10.2.16.8])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EE157423; Wed, 15 Jul 2026 06:51:53 +0000 (UTC)
Date: Tue, 14 Jul 2026 20:23:52 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: alistair23@gmail.com
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PULL 0/4] riscv-to-apply queue
Message-ID: <20260714192352.GA706358@fedora>
References: <20260714040758.28332-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zwcwNRjCst1w8vx4"
Content-Disposition: inline
In-Reply-To: <20260714040758.28332-1-alistair.francis@wdc.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=stefanha@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 28
X-Spam_score: 2.8
X-Spam_bar: ++
X-Spam_report: (2.8 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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


--zwcwNRjCst1w8vx4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--zwcwNRjCst1w8vx4
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmpWjMgACgkQnKSrs4Gr
c8g7KQf+Kxc5hJ0xT+4x4N4XDsG/Nwrh6vh+ZzrHAXWyHVJcamULmiMWSliMVSZr
KLbXlDSfJce6NW/2kwhoFXO6gM9hsFUXcZHmbVgTNPbi8dCyDdVM60c2DvEixL/7
v+RgKWItTZ0fp11fg3UG2vLX8r6FXvlWTKH7sKlmMi3yQMpq4eGhQ9ilfjTqUUAj
mdSVGi3GwG78v4d6K3qM02BF/vPYONf2R3qPTewvKy6iWBvnSWhSWVufNzcS+OfZ
lFV/kBOCvrBDC+pjcM7qZm4+OEG6B0mVLj0Ld8MGtKUHnAoAs4iggF35wN1A+B4H
i3d9oE2j7iqQfJ3u2eqKoy5eUs52eQ==
=T/dt
-----END PGP SIGNATURE-----

--zwcwNRjCst1w8vx4--


