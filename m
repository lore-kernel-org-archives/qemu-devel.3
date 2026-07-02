Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93207C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 10:33:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfEiy-0003kA-KY; Thu, 02 Jul 2026 06:32:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wfEiD-0003ab-Od
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 06:32:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wfEiA-0002Vt-4m
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 06:32:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782988321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kXtlN5mvrWlCRPQcGkTREJoMrAIag3wB6+58gAdDSgo=;
 b=JEMefAqadAuxzpfn9nmxkLVm7cPAF0519vlgqP5oLzvWR0GxsSJD6+lgvMEZ0bHfh323zz
 mrAsiPVjJSLa48kylPnEV1kv0bYRO2QmqSynDOXZNPiYmDRVxT702RucPTmRlVxzPTyI27
 sDOa+erH9SI81XHcp+6Gs1N5ITYDyiE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-98-0WudlK4WOQqmKgwACa_Acw-1; Thu,
 02 Jul 2026 06:31:58 -0400
X-MC-Unique: 0WudlK4WOQqmKgwACa_Acw-1
X-Mimecast-MFC-AGG-ID: 0WudlK4WOQqmKgwACa_Acw_1782988316
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9B4381953957; Thu,  2 Jul 2026 10:31:56 +0000 (UTC)
Received: from localhost (unknown [10.2.16.24])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 756E53189; Thu,  2 Jul 2026 10:31:55 +0000 (UTC)
Date: Thu, 2 Jul 2026 12:31:53 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jeuk Kim <jeuk20.kim@gmail.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, kwolf@redhat.com,
 hreitz@redhat.com, qemu-block@nongnu.org, jeuk20.kim@samsung.com,
 j-young.choi@samsung.com
Subject: Re: [PULL 0/2] ufs queue
Message-ID: <20260702103153.GA434717@fedora>
References: <cover.1782882742.git.jeuk20.kim@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TJqm501eDKipZh2u"
Content-Disposition: inline
In-Reply-To: <cover.1782882742.git.jeuk20.kim@samsung.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--TJqm501eDKipZh2u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--TJqm501eDKipZh2u
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmpGPhkACgkQnKSrs4Gr
c8j80ggAvleE+hz5978KZuVcQAWg4D6t08n/krgoQgKTnK55uiY3w0FymAOcyzdN
eIircyn0bun+x0Hjh9fApwWbWnKHC5pmaqcKbEcwysgSefQngN8YBII03q/cVo1e
7gr0MdIwNKJaP0zSklZXPJOnwQUNjlNviqUuXzLDmOngD1VnQ9FMEsf01DXqp4Yb
Qfil2vHK0g1m+TNE4LowfLcot93KLY8x31WAfLwJmR2vdOajam/0srKN6F6jkUdj
pOuhAsq16V18bmJncw0A4jouSvgN7sdnoz9AnzRIm/QLHxwtgPtlzirOfH8lTmHX
pqdn9a0YJJejVqB4AOvFzrBdqFYJew==
=PFm9
-----END PGP SIGNATURE-----

--TJqm501eDKipZh2u--


