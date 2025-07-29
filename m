Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A44BCC83F26
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 18:20:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugovc-0006DP-Kn; Tue, 29 Jul 2025 14:19:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1ugngA-0002C1-JG
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 12:59:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1ugng4-0006nJ-Nt
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 12:59:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753808381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lUEnZC/cl9I6SWazbvgR2NrYlCI+f8jC61djkrD95/s=;
 b=XsOMjxH1aLf74sIIGu6cDDanNhJaMcKF/yCqq9EvMvcktdwEL4i7MPKu4PY5/8zUjGCvv0
 kQb7ZtF3quoACAoDqb6d8OFZjjqvRuGenTI1GP6ibfCUUljIq1wvwsMjakrWh5nT1nwFaB
 yokI/kI8/q6C+ahvun6K1WWKdLt0kp8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-596-Do3BhKIaM-mu_q9E5isCxA-1; Tue,
 29 Jul 2025 12:59:39 -0400
X-MC-Unique: Do3BhKIaM-mu_q9E5isCxA-1
X-Mimecast-MFC-AGG-ID: Do3BhKIaM-mu_q9E5isCxA_1753808379
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DB87719560B0
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 16:59:38 +0000 (UTC)
Received: from localhost (unknown [10.2.16.185])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E19791955F21; Tue, 29 Jul 2025 16:59:37 +0000 (UTC)
Date: Tue, 29 Jul 2025 12:59:36 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PULL 0/5] vfio queue
Message-ID: <20250729165936.GA21541@fedora>
References: <20250729062633.452522-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tMs26JY0oQKbekkm"
Content-Disposition: inline
In-Reply-To: <20250729062633.452522-1-clg@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--tMs26JY0oQKbekkm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--tMs26JY0oQKbekkm
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmiI/fcACgkQnKSrs4Gr
c8hk1wf9HRUKLRYmcQ8cFg+Oh/OhQ++193FRPzKXig0u/cyDVk96TwcKwB1+TKFK
IYJFi+qUAZ3ZNFEbHQxmrF9OFifORaOanGOehvOYWT53jlfM0aDOln3Bj6cImz2Z
qCTMC0DAGcNOnPYu6OuvZrHUvLdukWRr+OI1wtgnJm59Ch/bSdkqEIU1bwIgRRQ5
Gcbw3ZGiNhIB0yMw6/x+UO0zfIy1+VeXXvL1JNxxaHyPC1/gwkpRirL0V+hgcTXJ
tMgTEpMCeuhk8dhffsRMcrmnVYK8lI+HiiPX0OVFnWvoReRzGHJ8MIViKu4fGtlC
iQW1cfGJTwJ+GOqvwSm6N5T1DvH6tQ==
=/UGx
-----END PGP SIGNATURE-----

--tMs26JY0oQKbekkm--


