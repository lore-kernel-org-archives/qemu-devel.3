Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF848CD98CE
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 14:39:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wY32P-0003nn-QS; Fri, 12 Jun 2026 10:39:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wY32O-0003nX-Pd
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 10:39:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wY32L-00024D-Cp
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 10:39:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781275147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VZju0TE/4Mx+fbTPxbsK0je3tsuAF/nvOvactB6CSfI=;
 b=AUPFThCfnvBIGjB+gOtVIwwmVhYmUdb7FSGSKkTI+S/5/q/h85cVs0wN/Q+B5JP00Nq0NN
 QHyijuJWhH7ezh33j8SyM9jBq+qA6TJI1sDphWnbPBn0zrv5x5uuxMp5guj5E37OcZ9qxC
 f6wyjUOJs+PHp5A2kLYJx5rQCNQ+VLc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-hvqTFi3hOKesoNemZ5Abmg-1; Fri,
 12 Jun 2026 10:39:04 -0400
X-MC-Unique: hvqTFi3hOKesoNemZ5Abmg-1
X-Mimecast-MFC-AGG-ID: hvqTFi3hOKesoNemZ5Abmg_1781275143
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E9A5C18601F7; Fri, 12 Jun 2026 14:39:01 +0000 (UTC)
Received: from localhost (unknown [10.2.16.134])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 65BD736917; Fri, 12 Jun 2026 14:38:59 +0000 (UTC)
Date: Fri, 12 Jun 2026 10:38:58 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jeuk Kim <jeuk20.kim@gmail.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, kwolf@redhat.com,
 hreitz@redhat.com, farosas@suse.de, lvivier@redhat.com,
 pbonzini@redhat.com, qemu-block@nongnu.org, jeuk20.kim@samsung.com,
 j-young.choi@samsung.com
Subject: Re: [PULL 0/2] ufs queue
Message-ID: <20260612143858.GA273007@fedora>
References: <cover.1781223925.git.jeuk20.kim@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="A9hRdibEVJSeF2vK"
Content-Disposition: inline
In-Reply-To: <cover.1781223925.git.jeuk20.kim@samsung.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--A9hRdibEVJSeF2vK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--A9hRdibEVJSeF2vK
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmosGgEACgkQnKSrs4Gr
c8g8tAgAx7VKdr9WxTKv+Ib/s6Fu9YFm+10mQ0sIC1nShm8KFe9+YLmVD7kgXFFd
K6vfU3PpwDjclfXb8boX3mP/REZzHUSkuAwXQBeWV5hxW1a9JJwiplC2VM6velus
xg3Z8Yqw48oJK361JF5Ilk20OH3na++EKZ8EHR0RT0swOMd6CGDeMYMojJHiZBsF
iTF+JOS6oJVZS2tZqK5ffH+S+10TjzKaMVqNIoTohs1U1EhfCAH2wY/iWUV7T+i+
xiwOxt6TlIlybumUisST8rbSjoUdm8isz+tojcrf3lXhxdc0O5JHVZETm6k7Zq9A
Xctm7L/wG5aq7bbYGJPSOSB8fL8nGg==
=aZWA
-----END PGP SIGNATURE-----

--A9hRdibEVJSeF2vK--


