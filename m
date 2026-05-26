Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A9B3CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 18:53:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRwtX-0005EK-8r; Tue, 26 May 2026 14:52:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wRwtT-0005C1-Mj
 for qemu-devel@nongnu.org; Tue, 26 May 2026 14:52:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wRwtR-0006L9-S4
 for qemu-devel@nongnu.org; Tue, 26 May 2026 14:52:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779821565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EjqroSXvJPWi0XN7tCX+ZcfY7sdVKkGVMIV5cd7p2mI=;
 b=Eah7zfTbvV/qPr3wJcm/lxMuVDS6coykz4qmVL9w3B2tTeChWRjwTR/UQHfmdQzcHXq+Vk
 ACFFVtL3Bco7MThqVxsv1zdAs/6yTJ4NmVfVC5UIZ3hF7Ovrv9IptswwpwX6kitq/8l/3i
 B8F94X4hbAAH7ZsUOTLFSaUwXT1hx0Y=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-483-g0v97cwvMxCe-qALpaj2_w-1; Tue,
 26 May 2026 14:52:43 -0400
X-MC-Unique: g0v97cwvMxCe-qALpaj2_w-1
X-Mimecast-MFC-AGG-ID: g0v97cwvMxCe-qALpaj2_w_1779821562
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3F8A41800451; Tue, 26 May 2026 18:52:42 +0000 (UTC)
Received: from localhost (unknown [10.2.16.201])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D64681681; Tue, 26 May 2026 18:52:41 +0000 (UTC)
Date: Tue, 26 May 2026 14:52:40 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/54] target-arm queue
Message-ID: <20260526185240.GA1763595@fedora>
References: <20260526142850.2326589-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hF6O7rLuOG/OXFFt"
Content-Disposition: inline
In-Reply-To: <20260526142850.2326589-1-peter.maydell@linaro.org>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--hF6O7rLuOG/OXFFt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--hF6O7rLuOG/OXFFt
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmoV6/gACgkQnKSrs4Gr
c8gN9ggAoCSMOm8Hal1TkVp2JNGPT/cMoxP9KpBKuiW9iPBD+vqBr3WFViMB0Z3H
7DADtbR1/MoCWFKYzxFSo6xvWjQylYX6SKLrIf4N1ZIEkr+QW8qNWYKH+3VD7T1Z
7xXZ51mSM3xor/lBt1Xr/AL/uknMcsKkMurAt+d7QKpyvJNsg95Gn+6TnCAkR0nv
MnLEiJXb7mDfWjqsErDdlbvegddLCLcqKQXmQMMbc2bbbOGv3VZB8tjImi8bV+Y/
CYkM8RuMXAkWF6iY0HVlaTLdjefzQR4g9c0ub+bxuE/iCoHUetmGVA73om3qFIqR
C17u0u4emr5ykiVMbXsdLlh0dIU5ig==
=6LIH
-----END PGP SIGNATURE-----

--hF6O7rLuOG/OXFFt--


