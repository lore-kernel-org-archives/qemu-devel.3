Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FB52C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 05:05:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgxzO-0007e8-S1; Tue, 07 Jul 2026 01:05:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wgxz1-0007VS-T1
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 01:04:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wgxyy-0003p8-4r
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 01:04:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783400670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6P50k1ISLmrCjGEHaQlmD89U2KeS9HCLJfWqpeIbNno=;
 b=EfeWm0JTjr5RUfIF/FTEL4efmHVVTzncFLo97tH5YxsVJ/ccG/cKATtfpzSic6uqijdhar
 03+LmnwbSZdWEwSTorn5uhmKLOuAY4+16psAH1OpXkf8Q7d3SIhId7F9nvkYt5aJdlTr4k
 9u9AICQZgsMjNdDmtdMR921Y0KsjJpo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-533-MpG2yWMQOyKmGmv_Llw_UA-1; Tue,
 07 Jul 2026 01:04:26 -0400
X-MC-Unique: MpG2yWMQOyKmGmv_Llw_UA-1
X-Mimecast-MFC-AGG-ID: MpG2yWMQOyKmGmv_Llw_UA_1783400666
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F30151955BE3; Tue,  7 Jul 2026 05:04:25 +0000 (UTC)
Received: from localhost (unknown [10.2.16.35])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6A5541955F71; Tue,  7 Jul 2026 05:04:25 +0000 (UTC)
Date: Tue, 7 Jul 2026 07:04:24 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 0/8] PPC PR for 11.1 Soft-freeze
Message-ID: <20260707050424.GA524558@fedora>
References: <20260706082451.59299-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4OcapBMRDzm40S+T"
Content-Disposition: inline
In-Reply-To: <20260706082451.59299-1-harshpb@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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


--4OcapBMRDzm40S+T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--4OcapBMRDzm40S+T
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmpMiNgACgkQnKSrs4Gr
c8h3jggAxWi3OOxZg2A7XzZ7oHHEsXNrX8NJH9wKt1PV4BP7N+Y/kGvEovRPpA0R
g83f3vcnn6/A6zjVpGGZbISwnK48T+b2W5gsOdDEvJDaGW47JV0i+3wr7AzDIiRf
WnjFtylRXW2xYvYndzGAYDpxLrNv5D19wo2XEWaCjRrctrSiI0KneWcyvIO0+Zid
re5bMX1MnzabPkVjhLQ5d9YUWPnLp0rS+Mya6HHVC4kH7niqpxBYVPZIddCOQjSK
Vo65g2SkK7sTUj1UsSGsho6klJMFgw0dPOehvnQYepSn+M8JzZMy1MHBcUe3TuKT
pid3Fz45Gj3lpNJmcxcHN+Q29OhR8g==
=iWMq
-----END PGP SIGNATURE-----

--4OcapBMRDzm40S+T--


