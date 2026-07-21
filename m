Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2194C44532
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 16:03:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmCuQ-0003Z6-8z; Tue, 21 Jul 2026 12:01:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wmCu2-0003OO-9f
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 12:01:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wmCty-0005Oh-2p
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 12:01:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784649659;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nxcm+sMjz8hSTK13qElBnUVfPOnULd83ZVf7BP4V9dA=;
 b=b/4+fMEnSjZM4vmWRyO+WaPycYCvnjLWpkArl4Zc8VPN9EFVRzdF2JTcYQvz1a26qJoO0W
 DJRMEkbhyZoejgJgfBsuid0f6s1xs96eflTUJn/orWP+6fMN7GA5axYAEZU3Hqu3YuPFjX
 dqOKAlKCSfh3CLv0icoDx2aAAEMXB5k=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-q5_LDp-GOwiBbLgmFHB6bQ-1; Tue,
 21 Jul 2026 12:00:55 -0400
X-MC-Unique: q5_LDp-GOwiBbLgmFHB6bQ-1
X-Mimecast-MFC-AGG-ID: q5_LDp-GOwiBbLgmFHB6bQ_1784649654
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 43BF31800634; Tue, 21 Jul 2026 16:00:54 +0000 (UTC)
Received: from localhost (unknown [10.2.16.155])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 955233004190; Tue, 21 Jul 2026 16:00:53 +0000 (UTC)
Date: Tue, 21 Jul 2026 12:00:52 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com,
 stefanha@redhat.com, pierrick.bouvier@oss.qualcomm.com
Subject: Re: [PULL 0/3] Plugins fixes 2026-07-20
Message-ID: <20260721160052.GA208550@fedora>
References: <20260720200447.2145622-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2e5F4sZzgu4/mMcZ"
Content-Disposition: inline
In-Reply-To: <20260720200447.2145622-1-pierrick.bouvier@oss.qualcomm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=stefanha@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

--2e5F4sZzgu4/mMcZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--2e5F4sZzgu4/mMcZ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmpfl7QACgkQnKSrs4Gr
c8gnZAgAqMIxsIREK4tn+ackEUJjCR3WuzD7/DTB9i64RwT2Stno+OHEaDPKMvQS
hPQcl4/L7mdP6DQ79ZGp5n5XUor5g0GuvvIb0fR98/DLuoXCvCoBXeN8tXs88iaP
Jf0t8g6C2QYLod2qGKL/qVMTVT9JGuiMxO6dIuknYUDFRVigm32WBk6m0lcjP709
NHfH/yq2QdaXvMFIqGi+yzPBR9dLsVPhlNATlZMYFRh6MnIVxPDy+wjiYMFrGN97
eCL0anL4UuBXkj/hzxIIq2OxmlXSopYvDEp0VM5DRJ9qAmly2Fw3MUOrcml3QZnz
3VcIKMh0fg02IM/Eo/zO8jVotm5BMw==
=5L82
-----END PGP SIGNATURE-----

--2e5F4sZzgu4/mMcZ--


