Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C736C3ABBF
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 13:58:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCIos-000858-Vs; Tue, 06 May 2025 09:58:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uCIor-00083q-N3
 for qemu-devel@nongnu.org; Tue, 06 May 2025 09:58:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uCIoo-0003Ol-CX
 for qemu-devel@nongnu.org; Tue, 06 May 2025 09:58:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746539925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xYflSMwKMeHDfXDoqwyJiaq67TOvlshTEy4qa9GuWpY=;
 b=g93C7uMNn46AC5NN3fDMRY6lA/hisOvhsjbD7rGivAQNS2MDUbl9mZO78HtoX0Ra/SGaYt
 ciN/flq0HDI/W+F/oiIUBrePcilA5ZvK9AnUmkSc26uqgwDWfnXq4jbbAvKs6XOmHy+Wx+
 XZfsDje8hhvk+z7jUnqQ+jfebFMu0n8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-nQ3LUOD3PQWIfKmw1KF8Ig-1; Tue,
 06 May 2025 09:58:44 -0400
X-MC-Unique: nQ3LUOD3PQWIfKmw1KF8Ig-1
X-Mimecast-MFC-AGG-ID: nQ3LUOD3PQWIfKmw1KF8Ig_1746539923
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A331B1800996; Tue,  6 May 2025 13:58:42 +0000 (UTC)
Received: from localhost (unknown [10.2.16.219])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C30881800352; Tue,  6 May 2025 13:58:41 +0000 (UTC)
Date: Tue, 6 May 2025 09:58:40 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PULL 00/23] aspeed queue
Message-ID: <20250506135840.GA302893@fedora>
References: <20250505090635.778785-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+GmUTu3m/F2o5KBc"
Content-Disposition: inline
In-Reply-To: <20250505090635.778785-1-clg@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


--+GmUTu3m/F2o5KBc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--+GmUTu3m/F2o5KBc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgaFZAACgkQnKSrs4Gr
c8hvSAgAuu9Ia4OVqt7JASIZUPeVdAJh1UlM6UPB2BKkEPj072DAfScQRT1wzq+U
gs0mT4Bw6GYvssLbDuqyP79NtXJ+QaPb5kqwvkZuvsBhLY0OOxvkbFmHD9cHcTZk
B6qMQ4PcCsfqyf8pJK9KC/5H6eJQlGRd/NzwEJr8h5bvH1/HxBb/zLV9gm0sV7Qv
fxW6yJnKwmoTr95Bqp42t5PUBoid5WR4Vxdm1zB9dcTm+zV+LEaLicTYVTBQW83f
i8MO84fGN7apjlmvgq4/Jvtb6g5euz3CnQ3O1VY1OxK2Ett/nQ/rvrvNuSCWFrrA
EiEeITXYGtdNhUw/kBMDrd+bDJeiCg==
=Mc6F
-----END PGP SIGNATURE-----

--+GmUTu3m/F2o5KBc--


