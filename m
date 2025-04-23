Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 602DFC369D3
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 17:59:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7eMD-0005Oa-3t; Wed, 23 Apr 2025 13:58:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u7eM9-0005Ni-Ih
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 13:57:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u7eM7-0005A1-D0
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 13:57:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745431073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lZF3JrLoinA6kQYv4KNuFKki0HyqbR5eUS/Npo8VZlg=;
 b=iTM/sAH7KAGwr05Fij+49+5yyno+FnkkxSg8Pb4oS68Exu2xnWYYFVWE6fIWyEtIa3zQIY
 WaDfwGldt4Z2EnFkUa3t5y7vvd/tEi5xcRF1wMkz9y0nhPs7uLRMGIlyDhsolzm5q0riTn
 2R+IGMZbuodTTZebpIGTMthOX27l+0I=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-f8OMNhmdNYu0Vs2A-YTFWw-1; Wed,
 23 Apr 2025 13:57:50 -0400
X-MC-Unique: f8OMNhmdNYu0Vs2A-YTFWw-1
X-Mimecast-MFC-AGG-ID: f8OMNhmdNYu0Vs2A-YTFWw_1745431070
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 20EA119560A7; Wed, 23 Apr 2025 17:57:49 +0000 (UTC)
Received: from localhost (dhcp-2-16-89.telco5g.eng.rdu2.redhat.com
 [10.2.16.89])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6F13A30001A2; Wed, 23 Apr 2025 17:57:48 +0000 (UTC)
Date: Wed, 23 Apr 2025 13:57:47 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 0/9] target/avr: Increase TARGET_PAGE_BITS to 10
Message-ID: <20250423175747.GA353610@fedora>
References: <20250422211124.305724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RIYtxL8ZKv0IDA3A"
Content-Disposition: inline
In-Reply-To: <20250422211124.305724-1-richard.henderson@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--RIYtxL8ZKv0IDA3A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--RIYtxL8ZKv0IDA3A
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgJKhsACgkQnKSrs4Gr
c8gNgQgAvDplT7PQKH3AYUGqkYIbhHBkETZ15jcfpk+mt2MSoZAjS9xZfgLC0Md/
W2updXvYXf4G2hDj9HxX1AQ/VSQolFf1hWoDqWr5Jj8lVefTahiWk14HQGeaxKS5
05rUJ3JRLmoGcgC50DjcYT5Tjj609M7G7QbRSptQIgGpEeozxlf9mhSomTGxUTc3
DBof+adCqZrNLPd9wWcXkn8IezHKSBv1JY+Xy/uwRULHHP/inn8wCMz7IyTQ8GYa
P5oPiBfRzFwAxIXMro077yoa13baM6J6KcQGLIaHEbFDk8z3rxuXfoc1BMN0mrsl
tWBXRvQypAOf4J3ylysSLrrDfp5Xfw==
=aMZN
-----END PGP SIGNATURE-----

--RIYtxL8ZKv0IDA3A--


