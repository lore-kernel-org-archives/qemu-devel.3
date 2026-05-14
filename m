Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A742ACD37AC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 18:23:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNaht-0005KW-IS; Thu, 14 May 2026 14:22:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wNahi-0005JV-GV
 for qemu-devel@nongnu.org; Thu, 14 May 2026 14:22:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wNahf-0002mg-UX
 for qemu-devel@nongnu.org; Thu, 14 May 2026 14:22:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778782950;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3B8Q/SNE6+lx/tzY90EIwajJRWZuuQPC6Dlsz24srVQ=;
 b=S27dxELl0BoDQm9jVWugT81s9/wqCrTFOYte2ckjQWnh29hT0S/sq8WUZAqGJbco65uxEU
 DEbzw3Q7crEIR8Z+qDUAFhtHX9aoTu3nTTuUEBhKsGFHNiHv2OfcSBAEVlrgyUpVRnaSGA
 E5ZwQckNnYFNMaXwD36Bs/krtzpgWCo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-Ng7s-wyZO6qxH44l9Gvb_Q-1; Thu,
 14 May 2026 14:22:28 -0400
X-MC-Unique: Ng7s-wyZO6qxH44l9Gvb_Q-1
X-Mimecast-MFC-AGG-ID: Ng7s-wyZO6qxH44l9Gvb_Q_1778782947
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3D897180061D; Thu, 14 May 2026 18:22:27 +0000 (UTC)
Received: from localhost (unknown [10.2.17.3])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CA0F81800264; Thu, 14 May 2026 18:22:26 +0000 (UTC)
Date: Thu, 14 May 2026 12:28:15 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com,
 stefanha@redhat.com, pierrick.bouvier@oss.qualcomm.com
Subject: Re: [PULL 0/1] Docs update for 2026-05-13
Message-ID: <20260514162815.GA1485877@fedora>
References: <20260513175807.3557565-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="aqon25rFfUGcI/xT"
Content-Disposition: inline
In-Reply-To: <20260513175807.3557565-1-pierrick.bouvier@oss.qualcomm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--aqon25rFfUGcI/xT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--aqon25rFfUGcI/xT
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmoF+B8ACgkQnKSrs4Gr
c8g3tggAoj6luV5fBJdahvdNv3bFEano9rktIO9ok0kloeAI2ar9atin3Fe54vIw
a/p7sCZ8W0kkWwIntdfFEDyklOH2l81wGWAXi10WBYj7oESW5AZVKrMQlkCwGeD5
buOuxM5O6xsWJXyRTMpa5iGVo90YGfBCp9+mbM2C9lpe6avTftta+hmk2dp+C3YH
6mkL9vQ9R1C132j8KcUbGSnoDV/8iZfefZv6dPWM+Kmyi60z2aXbzv9oZ9QEU2+e
Aj9gxZGsFq4uHfeTP8vbPKVnjJaIGYSLqjwBdWVAe/Ca5enEotjDiWCqsgeSw0Sc
mfJqlYyx4iiIu3uF7ReiP4GOAQ4g4A==
=w222
-----END PGP SIGNATURE-----

--aqon25rFfUGcI/xT--


