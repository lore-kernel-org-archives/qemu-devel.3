Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40190CD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 18:53:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRwtR-00059x-KF; Tue, 26 May 2026 14:52:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wRwtJ-00056U-6E
 for qemu-devel@nongnu.org; Tue, 26 May 2026 14:52:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wRwtG-00067S-Vu
 for qemu-devel@nongnu.org; Tue, 26 May 2026 14:52:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779821554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JlNTAmPRz26GeyAJmHnlw1SONuEwQ3SyWPZ0YacXfP4=;
 b=ZvLJ0dNgXd7HbIPjA1X3pGPLpSeeQLLPr5/0KMav69HMzLDyG+5S6YTBiQNr9Av9YTzoy9
 TrUo6V3yShu+85H3tgsfgNZwGqMwhtMdrUd7YNZFZGF/uqeRTH19lax8C5wIeDsZL0n/i7
 WAot12UwGDQP3HPyNd2w/DDQ2ETAz48=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-466-qEPZkNzsM3meMTtgIcY-2g-1; Tue,
 26 May 2026 14:52:30 -0400
X-MC-Unique: qEPZkNzsM3meMTtgIcY-2g-1
X-Mimecast-MFC-AGG-ID: qEPZkNzsM3meMTtgIcY-2g_1779821550
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C2A9B195608A; Tue, 26 May 2026 18:52:29 +0000 (UTC)
Received: from localhost (unknown [10.2.16.201])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6EAD319560AB; Tue, 26 May 2026 18:52:29 +0000 (UTC)
Date: Tue, 26 May 2026 14:52:28 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PULL 00/37] aspeed queue
Message-ID: <20260526185228.GA1763534@fedora>
References: <20260526081848.651835-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5isN/EwWN5WlY8C8"
Content-Disposition: inline
In-Reply-To: <20260526081848.651835-1-clg@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--5isN/EwWN5WlY8C8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--5isN/EwWN5WlY8C8
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmoV6+wACgkQnKSrs4Gr
c8htoQf/TDJ8kRLmP9Cp7PtDrlIau0JF5zuVxaR/bmdYgmLnrbF5N0dEQX8SGlB9
P706ZqbBzfWMj0VF4bUW8TQtBomTqItsLFx0lgGL+6z6Gex0WMBJZpgQfYoGlMMW
gDGs5EDCXmwESt8VNDmgY57nCRrcvrImY0CjVuKWyUIwzVYP0w7hc6mKgCvjdwhn
FvQQgEk5xuYXpdvin7mpb5IA6ZtgFD+AtjNYyONgDsltSJFTLBMQcDYVRqvQRs0R
jJsZhSGLrgJi9GBSPJGZzTC1dDzraa3Wjg3ZVY0pwhnvX7Fo0hk8Ul45jdDSHshj
MV6BXO5Mw3Q6J8BIoxmo+K6ZwYPD+A==
=NgOh
-----END PGP SIGNATURE-----

--5isN/EwWN5WlY8C8--


