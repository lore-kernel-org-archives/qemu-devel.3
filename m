Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A881CD5BD0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 18:12:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSIjJ-0001Mg-5a; Wed, 27 May 2026 14:11:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wSIjE-0001Lr-V5
 for qemu-devel@nongnu.org; Wed, 27 May 2026 14:11:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wSIjB-0007re-JI
 for qemu-devel@nongnu.org; Wed, 27 May 2026 14:11:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779905495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f+4NAkRwjJ+P21f7wXrEC4Or9GR8W1ZnZn9JohohLfY=;
 b=Fh8r61Pteta1WaZ/c/HTIGeW374CTtp/ZccyPDqbk54KCmfIrALu2fZryVDP6EmufqljAx
 AjzGVG9Wuw5jPHJX5orWCzjV6TfLntkeMT7EjKf9JlUtqw51lEYsiQX0gkTejIW9J0gnTH
 w1N529batFn0Ib9w2GZlL1QgfnDNlkg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-QlHVoH1bP7WpnBaP_IfuvA-1; Wed,
 27 May 2026 14:11:32 -0400
X-MC-Unique: QlHVoH1bP7WpnBaP_IfuvA-1
X-Mimecast-MFC-AGG-ID: QlHVoH1bP7WpnBaP_IfuvA_1779905491
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BDC34180047F; Wed, 27 May 2026 18:11:30 +0000 (UTC)
Received: from localhost (unknown [10.2.16.86])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CF6031955F19; Wed, 27 May 2026 18:11:29 +0000 (UTC)
Date: Wed, 27 May 2026 14:11:28 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, kwolf@redhat.com,
 hreitz@redhat.com, qemu-block@nongnu.org, qemu-stable@nongnu.org
Subject: Re: [PATCH] virtio-blk: fix short scsi inhdr host OOB write
Message-ID: <20260527181128.GA1843532@fedora>
References: <20260527160328.315585-1-physicalmtea@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Cvx06u+RvYeGGNo/"
Content-Disposition: inline
In-Reply-To: <20260527160328.315585-1-physicalmtea@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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


--Cvx06u+RvYeGGNo/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 28, 2026 at 12:03:28AM +0800, Jia Jia wrote:
> virtio_blk_handle_scsi() only validates the input/output descriptor
> counts and then unconditionally treats the second-to-last input
> descriptor as a struct virtio_scsi_inhdr.

Hi,
A fix for this is already available here and is currently under review:
https://lore.kernel.org/qemu-devel/20260526154957.1741622-1-stefanha@redhat.com/

Please review and test the fix if you have time. Thanks!

Stefan

--Cvx06u+RvYeGGNo/
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmoXM9AACgkQnKSrs4Gr
c8gYWgf+NG6LNqGK9Z3Kka34D/qZ7GLyRQd3s6fZMk3P59VTaHwUusIyy4MgX8CA
W1v15zulyqK6DU9l/Hzd8W1oUGSa2GJe64vLyDl2Z30rg/jodFlHUWMZiT7fBVP9
zIy+Vn/6wdnequGLu76BAkS5d4Wue5VVyiH9KcUgXDGblnLeuM/04nZuvL51ZodJ
DY6sIK01rK2lhJT6+zTVBzXPTSENmwEgVsZZ7i5Nk14yaZy3/v8wIlwxIP8b76/e
K8t69aS72572oLIGycjqllL3yEwUvIV5CuKPqee5yCBgDrDgRdgewebfXaIZo/+J
5irWhCdNBMy/YIWSVqqwHu5CZVuM/A==
=WGQN
-----END PGP SIGNATURE-----

--Cvx06u+RvYeGGNo/--


