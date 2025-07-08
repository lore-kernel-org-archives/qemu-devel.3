Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27BFEC83F17
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Jul 2025 07:11:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaqrL-0006RO-Dv; Sun, 13 Jul 2025 03:10:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uaqnO-0001nl-VR
 for qemu-devel@nongnu.org; Sun, 13 Jul 2025 03:07:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uaqnM-00077s-Qi
 for qemu-devel@nongnu.org; Sun, 13 Jul 2025 03:06:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752390403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qBovIcWaGMRcAx9aWN20JDGY5eiu+TAvOfGwvgeP22w=;
 b=fFJXAXSZx1gzfRic44iFKLm3H/qXDFYQwLLkigOsJjl5vUE9YCtYX6Q1bf6MA1yZWwju/0
 7H2qsyS/WfL2hFnK1BzopqGKHIK4GkFNnQ353+RG2IvgXIoIdpD4JQ8dIEA/th2SuvmsbE
 2udALEJAVlS05qMQ9bzgm13qj4U28xg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-jdngPufvMp-jTPWkwbXWEQ-1; Sun,
 13 Jul 2025 03:06:32 -0400
X-MC-Unique: jdngPufvMp-jTPWkwbXWEQ-1
X-Mimecast-MFC-AGG-ID: jdngPufvMp-jTPWkwbXWEQ_1752390391
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 388D018011CD; Sun, 13 Jul 2025 07:06:27 +0000 (UTC)
Received: from localhost (unknown [10.2.16.7])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 13A1219560A3; Sun, 13 Jul 2025 07:06:25 +0000 (UTC)
Date: Tue, 8 Jul 2025 03:25:56 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 000/119] target-arm queue
Message-ID: <20250708072556.GA115480@fedora>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/wLdDNDUIWIikVX1"
Content-Disposition: inline
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 13
X-Spam_score: 1.3
X-Spam_bar: +
X-Spam_report: (1.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
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


--/wLdDNDUIWIikVX1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--/wLdDNDUIWIikVX1
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmhsyAQACgkQnKSrs4Gr
c8jpwAf+MVauD+WyFkd4RfWtmhjOayZJ24BXfqe+4blBG30zxVjvmwNrCOsqh4mb
OhkzupDPEeOvb009nX3ebuMnN/NY0JOJDdblBtUxjegwOk+PvfIQdK7Qd9G9pc5a
4Jq1yPXDUWHbbORKv4BPOdcSpPbn+2WAR4SD/BJRn93LmaBBEkPC3O5Ci0JBytsc
r19DJfU1FgFKFZ9IokLsA5ET0Lb6RUROeNk1zxAuG1zVWhX/f7cCm6k36VLN6vzr
FXE95Gg3foTjJ66CmcIicgdDRTig8oR56V4fD3K1admTBx/jgbkXj5l6lQtdgXJJ
izVdPhfG4E9Rc+jZxk5iGod3jfCcZA==
=6Tvq
-----END PGP SIGNATURE-----

--/wLdDNDUIWIikVX1--


