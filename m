Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77C05FF886F
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 12:44:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJseZ-00025H-I7; Mon, 04 May 2026 08:44:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wJseY-000251-DN
 for qemu-devel@nongnu.org; Mon, 04 May 2026 08:44:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wJseW-0002Wm-Uy
 for qemu-devel@nongnu.org; Mon, 04 May 2026 08:44:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777898639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ygIaxIpdW1lZBeSvI9ZBxPbiENTPgPkCiWpu4BkwgSU=;
 b=hxBE4o62dDgKj8wLABEYjZ+sLnai8KklrKCqtDN5yTlw5C4KI75dQ5qrqyHPP2TFKYQaGv
 MMbnTuAJIlqRT43FRIGlHLMzuoj2CsDB+Imd6FnLAGwU4Y4rrCwMt/Xi1JvqZ8KPdckrgL
 jmBefuZE+rlYADvSR/2Rw7/voiRaJOQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-298-umW5DShOPUihWgVSFynENQ-1; Mon,
 04 May 2026 08:43:58 -0400
X-MC-Unique: umW5DShOPUihWgVSFynENQ-1
X-Mimecast-MFC-AGG-ID: umW5DShOPUihWgVSFynENQ_1777898637
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 691561800578
 for <qemu-devel@nongnu.org>; Mon,  4 May 2026 12:43:57 +0000 (UTC)
Received: from localhost (unknown [10.2.16.109])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EAF061955D84; Mon,  4 May 2026 12:43:56 +0000 (UTC)
Date: Sat, 2 May 2026 06:49:28 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/58] Misc patches for 2026-04-30
Message-ID: <20260502104928.GA81652@fedora>
References: <20260430172204.1006673-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/WvrENw8DzX5vKCY"
Content-Disposition: inline
In-Reply-To: <20260430172204.1006673-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
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


--/WvrENw8DzX5vKCY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--/WvrENw8DzX5vKCY
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmn11rgACgkQnKSrs4Gr
c8gNiQf+IB0GEtRDhDGP4mBZUqwzMzwOn9DRTWrDXYgfNGYRcdmyohe992oYA9tc
8QsV0zONHmhLgn6/DkIgAiny51hlW7mHn+o2wFzJtk56eg8Ib05iyHKfWIoIUupl
a593a8I5WQ9CZMsx31LrpYSWlDyc7NsEGC7DKaHpUqre9ej4albuLh3AQXSws02F
9a1Q+eyANIo2ItsGAeem0Vg4K1MeR7hGIwbjLsTlAHSiWOKfjcbwrMX5fShVQ6mV
AZtQC2JHsReu9n3TONJzT1u/UhYlGtk6pJzQsNEVf39xwxeWJyqAlKc0XteFTXY8
6OsmZSN+2aGDuBjlpE6fGoDHvahHzg==
=JjTk
-----END PGP SIGNATURE-----

--/WvrENw8DzX5vKCY--


