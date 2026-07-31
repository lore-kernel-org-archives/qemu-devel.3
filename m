Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BA74C55172
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 22:26:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpvg9-0004ru-Cx; Fri, 31 Jul 2026 18:26:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wpvg3-0004rF-2p
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 18:26:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wpvg1-0003Ip-Kr
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 18:26:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785536759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=40yh/1PkPr92iTHWcuTkFWSbiaJt3uPUEzmHb2EodHQ=;
 b=I5D9WCXlMeGWW6Cl/zCdyxGxafHQWqWRWuiD6cx0+ZRkX8cZRKlIcgIhY4iGkbZYw923N3
 vaiGFQjZ7aJUZ/14VHS6qOfxNVCVEdaaL7+uplDPIsvUwWFJDjv3Hspsd5AjoIOQSpdEcJ
 /l6DE2mnhV+w8ZRLlbYysad/5BKUf7k=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-443-EbTYcXJ9OI6U-YtUCuqGWw-1; Fri,
 31 Jul 2026 18:25:57 -0400
X-MC-Unique: EbTYcXJ9OI6U-YtUCuqGWw-1
X-Mimecast-MFC-AGG-ID: EbTYcXJ9OI6U-YtUCuqGWw_1785536756
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1922618004A9; Fri, 31 Jul 2026 22:25:56 +0000 (UTC)
Received: from localhost (unknown [10.2.16.31])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9A6491800480; Fri, 31 Jul 2026 22:25:55 +0000 (UTC)
Date: Fri, 31 Jul 2026 18:25:54 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 0/4] target-arm queue
Message-ID: <20260731222554.GA85749@fedora>
References: <20260731162024.3097467-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nEKTnS2+wraf5hTc"
Content-Disposition: inline
In-Reply-To: <20260731162024.3097467-1-peter.maydell@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--nEKTnS2+wraf5hTc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--nEKTnS2+wraf5hTc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmptIPIACgkQnKSrs4Gr
c8hwQQgAvrpuPfgBLcRt5QzTckJkCLm9Q7FjxMHAtvnMTyC1ugBmmNk26AZ2PxZb
sDnRfQ8OEpaV6H3Y7r93jDI2rGhoP0MlW2Pyd+Pd0wieUAvRxe2od0nnsKk4CLEa
53jMSxMc8rxRIRJqw/dBtRWF5Exz4dGEG2GGpV0ewq/h/TNKDyLYJo9uram8JFGB
WRlIV6oZaSCvJGVqs0oAHrA+CDKJZPa7gHp6KYnxgZDr7qthMGJ9wJvbL03AxGKI
w5k9aZxz4nMUOZdBXxDsXx5NXVvXudVSpz84mzc3p4sB59DYL92ZQZtS+xkXbbzE
k67ZgwrQ3kQIiOLXwFYqIvrfUfqPWw==
=hQ7K
-----END PGP SIGNATURE-----

--nEKTnS2+wraf5hTc--


