Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC6A1CD13D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 17:36:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIVJQ-0003Lt-Ut; Thu, 30 Apr 2026 13:36:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wIVJ1-0003EL-NA
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:36:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wIVIz-00008Y-MR
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:36:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777570565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m3g3RzdF0a6J2659XqBPkIlbYc8YLlXd1zHug93vGig=;
 b=YV3Nmpyx+m+GYWYjrDyoLmlIQm5NRDt7LTCQatpP/lUt3xzINe1fm1mYJdIltsnYhiovHF
 AL/tcTRdXhukDImJNXTmlJVvALg6+t8YgRwZm+s1jg4gjMe9K3L6JB6d0pXtqlU0Voo0Po
 NMx6pb0rbpLMLmeFMRjTjNasp+AZYoE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-110-NxCXsYc-Or2uzEWgM8QCMg-1; Thu,
 30 Apr 2026 13:36:01 -0400
X-MC-Unique: NxCXsYc-Or2uzEWgM8QCMg-1
X-Mimecast-MFC-AGG-ID: NxCXsYc-Or2uzEWgM8QCMg_1777570560
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3DEAF19560A1; Thu, 30 Apr 2026 17:36:00 +0000 (UTC)
Received: from localhost (unknown [10.2.17.34])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D2CA01800347; Thu, 30 Apr 2026 17:35:59 +0000 (UTC)
Date: Thu, 30 Apr 2026 13:35:59 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Helge Deller <deller@kernel.org>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PULL 0/4] Linux user next patches
Message-ID: <20260430173559.GA31894@fedora>
References: <20260430071922.15341-1-deller@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="UV4J65YMkhPFGwMi"
Content-Disposition: inline
In-Reply-To: <20260430071922.15341-1-deller@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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


--UV4J65YMkhPFGwMi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--UV4J65YMkhPFGwMi
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmnzkv4ACgkQnKSrs4Gr
c8hgkQf9F+goY8vltHjuDpY2dcQ8nG+aZiKR0+y9gt3mQ0+RPRSnC7SUvLeI7h6V
eGcd0isF9+OMeBQA5uNz0TybhE4QaJ8gyTA+if8KW4l7tDqjCRWKt2MMrjTh7ZeR
rg5AvN2u2uld5Envyr7n4m+4JDfxUUKRBsGAsWKXpAf8ts/8KjHhqtClPS8Phl+7
9JdEJmFTzO/Bl1ujqeFjBzemDEdz+tnCHPqbvgFCZyIthFAccscn8I2iPdhtJ0wR
6f5AgreLsgoIy2kq/nW57nzvwtOrjB8P+6qQoTOndRYVieYQQddDZo+j41cxO2ry
vfIju5WBu+rXtOgH6j8+8jQmUGor8A==
=t5nq
-----END PGP SIGNATURE-----

--UV4J65YMkhPFGwMi--


