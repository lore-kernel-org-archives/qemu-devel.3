Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BD0BCD8CAD
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 19:48:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX2Qg-0003C2-Gu; Tue, 09 Jun 2026 15:48:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wX2Qd-00037R-6I
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:48:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wX2QG-0003eA-Jb
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:47:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781034445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t00TGAhuN5WaXeC/HIjpBl3GvYNVp+Vhhtl/kVSRSR0=;
 b=HaH2nIgowNAZy6pALb33o94w4COaZYu2QBt6nnzJvL18vjSs135+2CAyjtdlXf984sSFaZ
 um9O3Xurwc5pQPkKqdlCLybR1FvlfXjK4CTHhsRrZTQZEAuexiNUlNcx+/MG37oGviJK6X
 oXrzpDjaLWy2FLw/H52zUyDXtpANlH8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-380-P6GtT3YfOhK54KypnzbKvw-1; Tue,
 09 Jun 2026 15:47:21 -0400
X-MC-Unique: P6GtT3YfOhK54KypnzbKvw-1
X-Mimecast-MFC-AGG-ID: P6GtT3YfOhK54KypnzbKvw_1781034440
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 634E91801319; Tue,  9 Jun 2026 19:47:20 +0000 (UTC)
Received: from localhost (unknown [10.2.16.141])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D1926180067A; Tue,  9 Jun 2026 19:47:19 +0000 (UTC)
Date: Tue, 9 Jun 2026 15:47:15 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/14] loongarch queue
Message-ID: <20260609194715.GA82333@fedora>
References: <20260609092824.227250-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bt9srERTQ6lgjVqk"
Content-Disposition: inline
In-Reply-To: <20260609092824.227250-1-gaosong@loongson.cn>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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


--bt9srERTQ6lgjVqk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--bt9srERTQ6lgjVqk
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmoobcIACgkQnKSrs4Gr
c8iMrgf/UhCkk+dAVovZbJrjf+LyA6GznEH/OiPbQLZHoJVQgkany94sXZJB+4v8
2+yEqYao6NnxktM9O7o6AH0JG+DXxVfvCm6fRnfSm/y9Bs8OK8E7iWmg9/H7oVDJ
1iphqFVTH3SHw3/bUTXnLM3EhYTj29aJbTyJN0AtIIGbS5IHXTDoXJFWFyyuxRQx
UY/7xYrxSvBAVNG23VbMipg4k7cUQbJGOPIieoUZY5zgjnvvXJGp9cY8y5EUwuFV
Nnz4nNufoME4l6oX2rW3t+Ut2JzPq4NdaoJAz6b2cc1Cc2WhqcWIIznal56ZqOMJ
/F04wJBO4K5H+VgBtgd/6ToqZj0EUA==
=a/CB
-----END PGP SIGNATURE-----

--bt9srERTQ6lgjVqk--


