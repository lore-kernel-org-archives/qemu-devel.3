Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36303C282C5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 12:13:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp4g5-0002oa-O4; Mon, 03 Mar 2025 07:13:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tp4f2-0002ZN-Ko
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 07:12:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tp4ez-0004Qg-Mh
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 07:12:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741003956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RMoiNI3M2PIhkx/M/zkpOa8Xt0Ui4SDEg+3d8w/XEZw=;
 b=hqq56G5q7btbOjndQ3c7afdB77Q2URbKvMAYbZMAOA2vgS2IiiViwEHmGq4Sqh7baa8g5o
 P35AgDma1W/I0D57VpMQw7/fxr7UIuJb9dz+1+fJjA9SMn3XvpncRdBF/lt/6lEdGR+jVm
 oclLy/D4EJN6lNAlXM8efSWTRLM4/A4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-2-Sc8jrGh6Pj6dZirHn8v2sA-1; Mon,
 03 Mar 2025 07:12:31 -0500
X-MC-Unique: Sc8jrGh6Pj6dZirHn8v2sA-1
X-Mimecast-MFC-AGG-ID: Sc8jrGh6Pj6dZirHn8v2sA_1741003950
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8D07B1800984; Mon,  3 Mar 2025 12:12:29 +0000 (UTC)
Received: from localhost (unknown [10.2.16.61])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9632E19560AD; Mon,  3 Mar 2025 12:12:28 +0000 (UTC)
Date: Mon, 3 Mar 2025 20:12:25 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PULL 00/10] nvme queue
Message-ID: <20250303121225.GA215608@fedora>
References: <20250227093018.11262-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="GyY/sGQKXmDxGc70"
Content-Disposition: inline
In-Reply-To: <20250227093018.11262-1-its@irrelevant.dk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
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


--GyY/sGQKXmDxGc70
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--GyY/sGQKXmDxGc70
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfFnKkACgkQnKSrs4Gr
c8hCjggAtj1mbfI7a4fQfWH7BIw1Z0dH2LKxCpAOj3qT38Kg3yHf7W1+4EykQT/U
1OULDeNHI6N66454PGxpAiyOKQ6c+lXqX0E08EmDyMBSQLWzN2iGo0oO89koVchb
gn4wn5lBIKfdAOo7NWIr+8FGyO6mtN/TvZMcC1sG61J9vhLHgS3gzKAUFG0mNIil
XAHMTaym+F/FFGt0BoicBs0Rul7riVpLvDXcGLRgDnheaHbAw4Fxde9l2gKNVHuz
QkVz9kWqzEEHNzJ186y2lkdmcyVJ6aVd0Madw0B+WleUV9Ztb1SUy4KAGYOeaPc0
RRWxm51MxX04+Fv02s0ncLBjOQF7pw==
=2q8K
-----END PGP SIGNATURE-----

--GyY/sGQKXmDxGc70--


