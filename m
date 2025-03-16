Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 982ECC282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 12:14:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tu9MB-0001p8-TW; Mon, 17 Mar 2025 08:14:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tu9Kp-0001US-Pl
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 08:12:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tu9Kb-0002jd-Ti
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 08:12:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742213539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n9khgmQx0sukAUXxqgTbP8B7qoh4UqoGoniiWmYck4c=;
 b=gKMoKGsZpJKU+qGiUNEnItLqP3fRJDbebJW9Z0Q5e+XJF+eYIluB9iYz8D44PnTTGpGNQO
 QDL7oPzyWpJh6FzFPX0RCtszZJOOA5dsfyvbEB/cn/U79MhH9icsrl3MYDhYEw/nTMTrkw
 HC3rNiMR7/OwOMIE1tYEDQ1nOCn1nq4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-147-5KGOA1DeNyGFvgMXS5MJ6g-1; Mon,
 17 Mar 2025 08:12:17 -0400
X-MC-Unique: 5KGOA1DeNyGFvgMXS5MJ6g-1
X-Mimecast-MFC-AGG-ID: 5KGOA1DeNyGFvgMXS5MJ6g_1742213536
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C71A2195605A; Mon, 17 Mar 2025 12:12:15 +0000 (UTC)
Received: from localhost (unknown [10.2.16.82])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7B46330001A2; Mon, 17 Mar 2025 12:12:14 +0000 (UTC)
Date: Sun, 16 Mar 2025 06:10:06 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/17] target-arm queue
Message-ID: <20250316101006.GA1182083@fedora>
References: <20250314131637.371866-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="LUkuKtPnjVMYGxU5"
Content-Disposition: inline
In-Reply-To: <20250314131637.371866-1-peter.maydell@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_24_48=1.34,
 DKIMWL_WL_HIGH=-0.335, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--LUkuKtPnjVMYGxU5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--LUkuKtPnjVMYGxU5
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfWo34ACgkQnKSrs4Gr
c8h4kwf+KYVMatt0PRfOJasemfi+gGPR8dYF9F+QbfqjkDXMQHYVMMpGxku1KBK4
I0Xa0dL1cFcjK840U7f+Xe6jvjGSYuJ+E9/dhvS+JzuB1AT9ArFhrRBufV9h+1zJ
X7FngFzfKTeZaJ3GHJu43rS6gTpKnrgY4GZwC4K0hjgJdgYE++SWg43Hd7gmt4BD
O94uCrXH/Qw7SEghNXem10WOFUr/13uOBKT4BbrGXemoiuiGor2/8krpJ/hXTsSg
5OQm57hm5G7NQqt1SD0aBqa0dLuIGoSlu/RJ0HKBSzFrs9FVWWFa0ZhMDMGvJwtW
yHSRbuu/AUn3dvwK8nNABgXHHi3WNg==
=peHm
-----END PGP SIGNATURE-----

--LUkuKtPnjVMYGxU5--


