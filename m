Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7816ACD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 14:59:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRtFQ-0004JH-Mm; Tue, 26 May 2026 10:59:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wRtFM-0004FY-Ty
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:59:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wRtFK-00077m-MM
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:59:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779807544;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wJ0GeX9mF/Vr6Tb6w05BidRZ7DtLwkupZxrEsbeqyYY=;
 b=hsRCL0Be7SMoTjMF+FBBGKcL7+Nrkqj/VVSteUtAaoaSCICErmu7K6m4jn0pyLaUSAl2WN
 nB9gGQCCYhC95EcDhPtWkkSBDvgJOQDycqNJEtVb+LPpj5Cz0KaQFmw/zm3+BOtnXHoG3Q
 GqHt0cKURB8DopU0NWIK8WiOBpeEVF8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-XtNtOOXBNB-GERiK63Tcig-1; Tue,
 26 May 2026 10:59:02 -0400
X-MC-Unique: XtNtOOXBNB-GERiK63Tcig-1
X-Mimecast-MFC-AGG-ID: XtNtOOXBNB-GERiK63Tcig_1779807541
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4D4D7195608B; Tue, 26 May 2026 14:59:01 +0000 (UTC)
Received: from localhost (unknown [10.2.16.201])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B4C0B1684; Tue, 26 May 2026 14:59:00 +0000 (UTC)
Date: Tue, 26 May 2026 10:58:59 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 0/5] PPC Queue for 2026-05-23
Message-ID: <20260526145859.GA1733336@fedora>
References: <20260523162724.95229-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="73J4qC9JNIqKYBN0"
Content-Disposition: inline
In-Reply-To: <20260523162724.95229-1-harshpb@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
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


--73J4qC9JNIqKYBN0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--73J4qC9JNIqKYBN0
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmoVtTMACgkQnKSrs4Gr
c8h1+wf/Wcm4Ow75g40fPb0ufszTgphoXOwCS9jB/Aduj7K8x/7mu3tjtMxdt2Ks
oBYZj+U4IhpvDiqGyg3u/MK2ehO9wR2WRY0lt75ww4bSHbGgor4lnW+ici6O3aTS
Lt/m47deCwzuBoyXPNJlU+jOEmeVFWTQsvz+S9KIH3q+HP+WB4IiZ7yX2k1X11e0
PbzzVsNZEcDjMuqeJxOKEOpuJAssUu2es6Tv19xajGJjOY3NZ8AMQz+JB++txhlu
pKcFjKZQuFHMQIpZwAaIVVUEaDsLXHKfxBqunTzQ+cXjjmsRFIzLzham0zxsfz+f
594Dlax1ikrEwJhZfqWU2U9U2ko8Pw==
=uJ2+
-----END PGP SIGNATURE-----

--73J4qC9JNIqKYBN0--


