Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5231CC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 10:33:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfEiv-0003hD-4D; Thu, 02 Jul 2026 06:32:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wfEi5-0003YF-I3
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 06:32:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wfEi4-0002Uj-0g
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 06:31:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782988314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NES+eFr69Uhrq6d4OqZYXsibiJ254kgUOlwJjsmedWk=;
 b=fXJA5fxVuzQQn0/ldjTUp6ksahxP3kZK8ZUxIglKFQHpvzqXKPX+40xV2S/Vf2Ajmv/kiS
 Zj83tw8nWoW4MBIeW2LPYdWeCa3w0dJ/urpzec8/BG3YXUMUTbzuyovMgeBbe0R2lFSu/3
 wk4MgH/xAcCKojgIqdNlE2j74pqHG74=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-399-IuLpcc5oMtmGSadONi6WOQ-1; Thu,
 02 Jul 2026 06:31:51 -0400
X-MC-Unique: IuLpcc5oMtmGSadONi6WOQ-1
X-Mimecast-MFC-AGG-ID: IuLpcc5oMtmGSadONi6WOQ_1782988310
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 164511944B01; Thu,  2 Jul 2026 10:31:50 +0000 (UTC)
Received: from localhost (unknown [10.2.16.24])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6B4261800592; Thu,  2 Jul 2026 10:31:49 +0000 (UTC)
Date: Thu, 2 Jul 2026 12:31:42 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/54] target-arm queue
Message-ID: <20260702103142.GA434667@fedora>
References: <20260629120032.1645265-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MhMNaUkj8JE0Me/j"
Content-Disposition: inline
In-Reply-To: <20260629120032.1645265-1-peter.maydell@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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


--MhMNaUkj8JE0Me/j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--MhMNaUkj8JE0Me/j
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmpGPg4ACgkQnKSrs4Gr
c8gDZggAmlqQIbPN0ouErXp4NytQl9cpORMByaG0+VvUR8xeDKJiWd1IS3Z6mZh5
4abSbTvkL9HcmPlogV1CWFa1xHwa53FA31Cir7gLnrY7aJ4qXTuiNNYj+nZboELi
4z9CpbPko1dFM+nrd9gfw0Lo9rwuO2xNVZKimzksnDeZHOK5kfnSJ3KG/NN6Alwc
u+vzpYNTkl0/fGBJ/X81p0/Ixvs+2eCxn9XzukxRux9KoY8xxxrtPtn16JhaMDTn
KAygxqnAv0zSL3J16HNuCqbw8IS7hVLWXu/QhYisSOLOHn70qZLIYQuoJIWE5Vy4
uInngomonMpAjQZ6LuwSENB7Qx2qAQ==
=Zh7g
-----END PGP SIGNATURE-----

--MhMNaUkj8JE0Me/j--


