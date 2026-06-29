Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34830C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 18:29:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weGih-0002Gj-GA; Mon, 29 Jun 2026 14:28:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1weGig-0002Fw-B5
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 14:28:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1weGie-0003ka-TK
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 14:28:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782757712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Gk2r5ZHFNNttfjPr4Zfy1WjC/C+7+imZsDG0uoGg3Ok=;
 b=OkFuD4smmUuAW+y02M4EgRuo64jE8byo4i3F6hytnK5SqRuodVNs93BOjisi82CGE91Q0t
 9q+0SIMtbktLzREyiaEdkuVNpM+Z2HQ+YXEUAjaj5+c2ZIo5+f/lugOgbWcArQ4Wum23NI
 avApflYH1cDBsNSmJysMSmUiWUXGM74=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-37-nXXWqSDnOneMvzfwzBsp6w-1; Mon,
 29 Jun 2026 14:28:28 -0400
X-MC-Unique: nXXWqSDnOneMvzfwzBsp6w-1
X-Mimecast-MFC-AGG-ID: nXXWqSDnOneMvzfwzBsp6w_1782757707
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 227061955F03; Mon, 29 Jun 2026 18:28:27 +0000 (UTC)
Received: from localhost (unknown [10.2.16.195])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1987B765; Mon, 29 Jun 2026 18:28:24 +0000 (UTC)
Date: Mon, 29 Jun 2026 20:28:18 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, peter.maydell@linaro.org,
 brian.cain@oss.qualcomm.com
Subject: Re: [PULL v5 00/77] hex queue
Message-ID: <20260629182818.GA383234@fedora>
References: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XXUtrCkv4dTOLLUm"
Content-Disposition: inline
In-Reply-To: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--XXUtrCkv4dTOLLUm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--XXUtrCkv4dTOLLUm
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmpCuUIACgkQnKSrs4Gr
c8iyngf/fCKly/rSR9JN4TOr4lL0o4lbHpjbsZn97q5wSMaOjctLXNxqmjfVDiX8
ZaTWKiQ8k+gPbPuvxAUtcwCnvWOjaKH613tLlGwy2nimXkwMwXmMqVMfvF716Cul
8tT6jfhimpIGTxI8l1y0tgTpF9p2oQBHKKoFCn4yYSvild/joK2CVdDxpba+UV+s
ojCAFOW5VQ1FNSv/Ch+EyQfNsapNNB1PK+SK/MdcwYpLRD/O3FQUBdC4B9QH7kBy
gbCBjxMF2dyHMZOGTDkRIla6O6kdX3UrYM4M35Z5+pm8Je0e6J658i7f31DyCJAz
m1/WuZqZX7bAXocs8joGzDj+kUW+Tw==
=MEe/
-----END PGP SIGNATURE-----

--XXUtrCkv4dTOLLUm--


