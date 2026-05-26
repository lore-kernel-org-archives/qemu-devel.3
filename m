Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11D8FCD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 18:53:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRwtO-00057I-NK; Tue, 26 May 2026 14:52:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wRwtC-00054Y-LS
 for qemu-devel@nongnu.org; Tue, 26 May 2026 14:52:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wRwt9-00062G-8j
 for qemu-devel@nongnu.org; Tue, 26 May 2026 14:52:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779821546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e/vPTxrySstgA82LoYcVn00ZGGl38HuSEHyofzcgA3A=;
 b=MVJHBrxBhnUPIU/R6y7zIK26cZLxyvW30njx20ODCd6FTYNB80esCCVBhgJ0RL+OB682mp
 5xbG3aX12znDltZFO2JYBdryNm3zYXkREjw8ftrnh+OL37MPly3adB09NZc0VvLH66krab
 MGPoGD6/lUqDl3YUe1F/7NZ6aml+Zio=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-544-o2WEU_rdOMCDqCsA0h4i0Q-1; Tue,
 26 May 2026 14:52:22 -0400
X-MC-Unique: o2WEU_rdOMCDqCsA0h4i0Q-1
X-Mimecast-MFC-AGG-ID: o2WEU_rdOMCDqCsA0h4i0Q_1779821541
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 47A71180034A; Tue, 26 May 2026 18:52:21 +0000 (UTC)
Received: from localhost (unknown [10.2.16.201])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D747B30001BB; Tue, 26 May 2026 18:52:20 +0000 (UTC)
Date: Tue, 26 May 2026 14:52:19 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PULL 0/1] Block patches
Message-ID: <20260526185219.GA1763486@fedora>
References: <20260525151811.1643855-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="daEG3bZdaLbgJX1V"
Content-Disposition: inline
In-Reply-To: <20260525151811.1643855-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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


--daEG3bZdaLbgJX1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--daEG3bZdaLbgJX1V
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmoV6+MACgkQnKSrs4Gr
c8i/bQf/d4K0SetItvdB4fk+QEKXyrUmd/EuCVx+nwJHme6ggdskbNMae7zQcUuU
zACQ3saFjcnyBHQGr1rHinmJ/p7n6pX5xcwVTRZF5+rDbZ/6aGEnCyTltegNwYBQ
ccJJHT4EHa78Q3jhVchXTgbPxuBqR1l0f5FVZBBc4vmMXQfaBJnq9QtbVYzD3AHz
1h8AE1Yr/gQQ8zDPPFVeBqfdq3tR2Hyv8RdWed6v3yV0qlCUNILF2QbeZBR67yj5
PnLjY5d6Nh8pFQ3CykJNSah/zksdqxUSYahfsScdEtSc4BonbpyRYhM8/FpLd1av
E8TWkAl7KWMtG9CfzabZfsmMY3VjYg==
=IM/g
-----END PGP SIGNATURE-----

--daEG3bZdaLbgJX1V--


