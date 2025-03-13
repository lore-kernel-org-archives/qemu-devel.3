Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5A99C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 07:05:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsccm-00023r-1n; Thu, 13 Mar 2025 03:05:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tsccU-0001pS-GE
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 03:04:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tsccR-0007bW-Lq
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 03:04:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741849477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TJMjFf7lD/4B1zTQxKyVIh9hVEJAum8WzTorSAQaNGY=;
 b=QtSU9Kn4BaABXOZRnSnpFjTQ2MlPJ1l/7hTY9Q5dImKuXTANHCAu08lApoX9RO2CX1aLks
 cs17bH6EapUc+mx0X7cxrL9PQ3QR+kN4hPiRn+dvcl6wd9qcJgoV5ETOtmsZ221xFeK6LC
 yBOcX3TpNsT59ttNak03FZ3AVBX5iCU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-265-IwJfz-olNpWBLM5P2F258g-1; Thu,
 13 Mar 2025 03:04:33 -0400
X-MC-Unique: IwJfz-olNpWBLM5P2F258g-1
X-Mimecast-MFC-AGG-ID: IwJfz-olNpWBLM5P2F258g_1741849472
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3900F180AF6D
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 07:04:32 +0000 (UTC)
Received: from localhost (unknown [10.2.16.45])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 455AD19560AB; Thu, 13 Mar 2025 07:04:30 +0000 (UTC)
Date: Thu, 13 Mar 2025 15:04:28 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com
Subject: Re: [PULL 00/61] QAPI patches patches for 2025-03-11
Message-ID: <20250313070428.GA1086096@fedora>
References: <20250311113137.1277125-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="QVb2bdFIOUIZ91Vu"
Content-Disposition: inline
In-Reply-To: <20250311113137.1277125-1-armbru@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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


--QVb2bdFIOUIZ91Vu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--QVb2bdFIOUIZ91Vu
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfSg3wACgkQnKSrs4Gr
c8hlXggAugdAc1g0+eG+dxYyIkJOZc5q9qQUQ85+4qMIIo56U/jTmYeWyGVzlYkr
FUuQNDf457jk0IWUPq9qEJd8a+jwb4QyYXkv6F0VGYqsvvsLeORRsN02+pFO9ZoE
5tcZOnWZM+svF0rvMBY/mz6Bcd+qeegnG7c8mIsc6SyAVIdh99WnmOW/d1xHQOgE
q4y6T5vHCoyfFh6Eo4QLjX9VnBlOCwm7YMtGTNug/g7kMw7XsfoeNPm4WL6zgP+B
h3PabApDh2jGrWxUjf8/4/va7m48Uk1uU8j22ZAafZbGfI9NgjOWvJV+8OBbUcT2
cTxaG5HB5H0n9c+4v/azSobiMbVapg==
=JvMp
-----END PGP SIGNATURE-----

--QVb2bdFIOUIZ91Vu--


