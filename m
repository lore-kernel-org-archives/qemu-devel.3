Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 422E0C4452B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 19:59:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmGcg-0000FX-IC; Tue, 21 Jul 2026 15:59:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wmGcd-0000Ez-KS
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 15:59:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wmGcb-0000le-GP
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 15:59:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784663959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yldkUtNX7BFqZhqPXZRADUpkmh+RnrUtVOJAITcmWFg=;
 b=OiA/WLTe+Byl+VA5cCXnigSe36rcoGzqfeO5bCNb3ndh8IJzFzwdbPY4r6FWttKBJ4CrM+
 EusPcopAe1FF5QtaKpwLURMBjr4ZCp5LCzsmTbMLZbRzcrr3Jiepma2CikubHP/o2Y5BD3
 AMI6HUSe0UiEOaej/kf3qTaWZky4dxY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-399-6F9icZ75MYy1eh8y2JxJOA-1; Tue,
 21 Jul 2026 15:59:16 -0400
X-MC-Unique: 6F9icZ75MYy1eh8y2JxJOA-1
X-Mimecast-MFC-AGG-ID: 6F9icZ75MYy1eh8y2JxJOA_1784663954
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7DA4A1977508; Tue, 21 Jul 2026 19:59:14 +0000 (UTC)
Received: from localhost (unknown [10.2.16.155])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B76B41800769; Tue, 21 Jul 2026 19:59:13 +0000 (UTC)
Date: Tue, 21 Jul 2026 15:59:12 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com,
 stefanha@redhat.com, pierrick.bouvier@oss.qualcomm.com
Subject: Re: [PULL 0/1] docs: fix sphinx build failure
Message-ID: <20260721195912.GA265886@fedora>
References: <20260721165211.36903-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="a/rY0aekW0UxKBIy"
Content-Disposition: inline
In-Reply-To: <20260721165211.36903-1-pierrick.bouvier@oss.qualcomm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=stefanha@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

--a/rY0aekW0UxKBIy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--a/rY0aekW0UxKBIy
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmpfz5AACgkQnKSrs4Gr
c8hnGggAqUr5ZGB+uZ+adb3rzxRK8YmOz0wRCj5gIJFQcYtp79FMVJUxkcdU44pE
dGqC5Z1JXyszAaUKlzmcyncmORiwJULSid2oSz2/z/eTN4C0aTv0w/+BQQ9gBx0r
058kcSUSJ0vEkWJ05j/3fm5FggEjgEae4dADzwi30JWxIzS80yFRHuTkKQWFN/6V
oLgjtHM4sWYL4yQU6Im885kHqfEE09v/WzkQoAXf+348xbDUozIHM9dru4TutuEB
f+lAcQHIdXoewQ/nSXMqpF426ZF/ncS7Ebx7YAmuE8qAFhGYNcZjPwuYrtKtXIUu
Vn0D8BEYq6sOYvPQTYLT4fm6bdtUTg==
=cLIA
-----END PGP SIGNATURE-----

--a/rY0aekW0UxKBIy--


