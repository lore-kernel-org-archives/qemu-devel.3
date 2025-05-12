Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65C56C3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 17:39:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEX6v-0004TC-26; Mon, 12 May 2025 13:38:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uEX6U-0004EH-LY
 for qemu-devel@nongnu.org; Mon, 12 May 2025 13:38:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uEX6S-0005Al-C9
 for qemu-devel@nongnu.org; Mon, 12 May 2025 13:38:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747071491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FeVzwxIbZVKa3N64C64rL0V89BaqAndy4l4l3qPpwXw=;
 b=D50ZEy1Bm+U3+utzMAjebLeVIJnf0R3NQJQp1wum3ZWGnK/Xff6lLN/1VKj047kMtCwYLC
 4KJlkK1/T5tsyR7BmO8dxsfdibcuG1wBx9pYgCRKvY/XF8n2osOq03CsvnOnVbnN2D3aIK
 ttPrf/A9333i1YeCVTDahZPxPyEz8Pg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-_zzqLplGNL250KD6GMWHiA-1; Mon,
 12 May 2025 13:38:09 -0400
X-MC-Unique: _zzqLplGNL250KD6GMWHiA-1
X-Mimecast-MFC-AGG-ID: _zzqLplGNL250KD6GMWHiA_1747071488
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 81A5A1800115; Mon, 12 May 2025 17:38:08 +0000 (UTC)
Received: from localhost (unknown [10.2.16.161])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E40591800359; Mon, 12 May 2025 17:38:07 +0000 (UTC)
Date: Mon, 12 May 2025 13:38:06 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 0/3] QTest patches for 2025-05-09
Message-ID: <20250512173806.GA153290@fedora>
References: <20250509211821.23684-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="e5TWX2Dy9QTBlMDr"
Content-Disposition: inline
In-Reply-To: <20250509211821.23684-1-farosas@suse.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.551,
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


--e5TWX2Dy9QTBlMDr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--e5TWX2Dy9QTBlMDr
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgiMf4ACgkQnKSrs4Gr
c8iXowf/Z5ejjNyBKfFu9egwARBkT/WFVZM/syqXOkG1Hny6DjqUkPjp8V7HCfaU
8A1D8iK63AOlHLg1Zs/wAYCLRP8gC9M0Wl9wEb6swZiGXHmmeP/E46PFSj+Lbcfj
jsA73S32Dq0iKXkUAf5/qPE3bFyrp5e107CL++U1foKZsXvcYb3wWYUbtUUP4RoO
fFfOz1H+eo4DLwHJ8in55N5WC0Tjo7wYOrsM2Y3lv9B0kWELunFWHAQsqZ29Kybq
3yPLHHpqMvfZ6uSgfhEK5paY0wJyEL178rzcWsob2VuzJOiQ6vgjGaw5/ihZlW/Y
0v0kPkW3ybWyETvUoxfo3tMUvLK+iw==
=gh6c
-----END PGP SIGNATURE-----

--e5TWX2Dy9QTBlMDr--


