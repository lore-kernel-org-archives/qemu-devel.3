Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4AD2CD98CE
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 12:57:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXeyP-0000Py-VB; Thu, 11 Jun 2026 08:57:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wXexp-0000EF-22
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 08:56:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wXexn-0006Vv-Ee
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 08:56:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781182610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aJtOKsJe3PYaQeYAmFYIztx+XMBk1K+RRTKeZtlwpkM=;
 b=fq492TXqc2FtqBTSdXdiWIuV/HwNw8cIeFN6Z0zuDybggjp0PMEEYXUM40r8awuejZfLLd
 Ryqa1g2NyatijO+5ZsRp/F1IDgtENI2yiBm7RnYkii//JBbwNgFqSgriP1T7o4yqHClgbs
 PKoycWv0H6Ro1USbm+xHFoHCF2yKebw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-548-Y6y7HrguNO2R8NjItsmQMQ-1; Thu,
 11 Jun 2026 08:56:49 -0400
X-MC-Unique: Y6y7HrguNO2R8NjItsmQMQ-1
X-Mimecast-MFC-AGG-ID: Y6y7HrguNO2R8NjItsmQMQ_1781182608
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0918919560B8; Thu, 11 Jun 2026 12:56:48 +0000 (UTC)
Received: from localhost (unknown [10.2.16.137])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9258B1766; Thu, 11 Jun 2026 12:56:47 +0000 (UTC)
Date: Wed, 10 Jun 2026 20:55:11 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, kwolf@redhat.com, stefanha@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PULL v2 0/8] Block layer patches
Message-ID: <20260611005511.GA171934@fedora>
References: <20260610101730.42427-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xAlI+5ilH2nR4iDj"
Content-Disposition: inline
In-Reply-To: <20260610101730.42427-1-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 18
X-Spam_score: 1.8
X-Spam_bar: +
X-Spam_report: (1.8 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.445, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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


--xAlI+5ilH2nR4iDj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--xAlI+5ilH2nR4iDj
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmoqB24ACgkQnKSrs4Gr
c8j6cgf/U7H61RnPhqWTjzQseOJki+LBJcnTFzCWhgCipspv5JSSDV2qdkDiATSw
IoOu30GjBtuEwn8tumoaPvLHbuZKjckjU04jRZavTk1o73dtLk37Ref5Saa/WIAO
9ZGBSI9ZQtXCutnGlvrX767MAevSm6XblibkPsVNou9QJlc3250dT3PWQ32i8ucc
9roenHynijVLbQA782AYaNeUE8fedREGDXPAHeR6lLftjmerTk6rT4NHYRoJn90C
kUC8zL7OiJpzUnLn6xpcxC09z+oeT16KZ8llBCVao8wHkw8l56m4gNI0CQOOEnfH
56RRo68rXelAGqWMQcNIp43CQKk0Pw==
=BKv6
-----END PGP SIGNATURE-----

--xAlI+5ilH2nR4iDj--


