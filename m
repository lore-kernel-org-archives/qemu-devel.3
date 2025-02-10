Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FC3AC02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 18:21:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thYP5-0004FF-TN; Mon, 10 Feb 2025 13:21:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1thYP4-0004F5-Ea
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 13:21:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1thYP0-0003mj-8c
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 13:21:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739211660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H943quE2KSldMmBK9sZ8G13QMhPsTd9IFvhwZerl22A=;
 b=K8fzQpwCGxJJ6YrIHErGSwZMm27z9WHEqgdKUdbJrvmo2lmadhkhWNU5daEMfJp+49PhOo
 0Lx/vDnKWM04+2LyOdwUR63gVVkgCukItr3RdZP3/xbBiKRWwREFCk2son7yH9ijtzoJjG
 lc3J4XwfbuXpLm/hKuFMbli8X3m8Edk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-Lpk0Ka74OkyO_kDSnJzMiQ-1; Mon,
 10 Feb 2025 13:20:56 -0500
X-MC-Unique: Lpk0Ka74OkyO_kDSnJzMiQ-1
X-Mimecast-MFC-AGG-ID: Lpk0Ka74OkyO_kDSnJzMiQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C7CBC19560AA
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 18:20:55 +0000 (UTC)
Received: from localhost (unknown [10.2.16.124])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BCB821955BCB; Mon, 10 Feb 2025 18:20:54 +0000 (UTC)
Date: Mon, 10 Feb 2025 13:20:53 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com
Subject: Re: [PULL v2 0/8] QAPI patches patches for 2025-02-10
Message-ID: <20250210182053.GA118264@fedora>
References: <20250210150106.3924507-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="gI9+W+yB6FINchyj"
Content-Disposition: inline
In-Reply-To: <20250210150106.3924507-1-armbru@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.388,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


--gI9+W+yB6FINchyj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--gI9+W+yB6FINchyj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmeqQ4UACgkQnKSrs4Gr
c8iY3Af+JBPKXAScEtIFkQmHH21QKyd2dyHH+V3yXw/iFigaLKvL+9DPeI0baHb1
bUjqydzf8dZYJOMldU4t5yjHPJB/LpBAMAgTRXgagdN0UNL45qnKRyd9dOTY1EQP
hPBe7dUXTJ4V3sbmBxoD3XAB1ksPArAcYPDlSGQ/o9KIsPuaUTydpHdPxcSsbyuI
FoklwGHKLSj78k24bddd+vnkg8yxT+R8t77JUaGERKrXhHpUFLxP9B78Pw4M6W9f
8nm/pEXV4TxDs7T0FLr/gCdrD/NImyCbsjxh2q8VHrTneIiIDOM/5x3HO/hjw8IP
H4uStbBWdQFk64Wtcs2QBmJkFfHm5w==
=IHEf
-----END PGP SIGNATURE-----

--gI9+W+yB6FINchyj--


