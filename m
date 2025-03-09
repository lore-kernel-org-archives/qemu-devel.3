Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A39E2C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 03:57:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trUGI-0001lS-NP; Sun, 09 Mar 2025 23:57:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1trUGC-0001gV-PR
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 23:57:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1trUGB-00042L-1d
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 23:57:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741579017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DiLc3V26vSFmPHOdQzpXBXEJ4iSeWGW/VjTZAzC7gEs=;
 b=hpVdH6CP5TszjIySGhqu5Nwj8DObSZ/d8yLmfAFLzxMiHGjaOLwrrT3k/2RsCsvZeoIpJ3
 lTyzmK1ECmI8R1lH+3DYSyC5YBNIsx0/9EkeKE5WiA8YiUz73Nj9+Za4o7+jYnhyBojtCS
 axpBtpSncNH9+Pwbp0VurPyoMzJZpUY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-184-SDOoJAMiOHi3Te9OwRil5w-1; Sun,
 09 Mar 2025 23:56:53 -0400
X-MC-Unique: SDOoJAMiOHi3Te9OwRil5w-1
X-Mimecast-MFC-AGG-ID: SDOoJAMiOHi3Te9OwRil5w_1741579012
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CD5B51955D66; Mon, 10 Mar 2025 03:56:51 +0000 (UTC)
Received: from localhost (unknown [10.2.16.40])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7156F1956094; Mon, 10 Mar 2025 03:56:48 +0000 (UTC)
Date: Sun, 9 Mar 2025 08:41:17 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org, stefanha@gmail.com, maobibo@loongson.cn
Subject: Re: [PULL 0/2] loongarch tcg queue
Message-ID: <20250309004117.GA50535@fedora>
References: <20250307021934.1080115-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="pZif3rZp7KhvmLIZ"
Content-Disposition: inline
In-Reply-To: <20250307021934.1080115-1-gaosong@loongson.cn>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_24_48=1.34,
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


--pZif3rZp7KhvmLIZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--pZif3rZp7KhvmLIZ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfM46wACgkQnKSrs4Gr
c8hpXAf/eHU964c4FiF1SbrdQA+DGSN+MFJC8p4NikjP74wK1FrmwMCPwB41ppKE
81qoC8VcT1cRNdQFg+bqWMBAug7gLosz0vpTYh+Cfv2tmpTqzjy+T9bFdDaIm3oY
IthYbT+oO0mzWXDrIdM7Xjoiq/xBO8mgiVjcmC3ryrNIRyz0ZGRt1Wopm6cklHS9
INQ5BQx7pB0/Gzx76DAeMve1kniksohwszBVrFmWhtMpoGRd9X74VrX5lUxViDiN
WAXviE3ElUfsAVgb1WkKEUwtccNStAHqcxrs5ZdiuRK/QdRFFIjticHubs8/ps0V
z8IZUQVg9ZYgtsnujVm4ylIdGZ4O0w==
=EMko
-----END PGP SIGNATURE-----

--pZif3rZp7KhvmLIZ--


