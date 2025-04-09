Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00D37C36002
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 12:45:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2UnS-0004d2-JE; Wed, 09 Apr 2025 08:44:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u2UnR-0004ct-DC
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 08:44:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u2UnP-0004Bf-NX
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 08:44:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744202685;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0XOyOeck+McN+DtEqJ2XFLh19liltgl/g49v/gDlJ2c=;
 b=KG7iuG5AFkO99IxjErNHtnU34hPErlK2K/EV1fygXfNU6KSefkEEfBYelbtlbjWwx/f2JD
 V4Nlt0eFwAp+cvZYuwTxNSZewT4jKGcs/ABuZgGbpHtJurjbGIj2nuaEUCRiIZ5hxnq65Z
 +urf+aHPqbtJFTj2byB2QwD61Vrtpjg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-437-E52ec1ItN16gCoQxwhnQtA-1; Wed,
 09 Apr 2025 08:44:43 -0400
X-MC-Unique: E52ec1ItN16gCoQxwhnQtA-1
X-Mimecast-MFC-AGG-ID: E52ec1ItN16gCoQxwhnQtA_1744202682
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 647521801A12; Wed,  9 Apr 2025 12:44:42 +0000 (UTC)
Received: from localhost (unknown [10.2.16.77])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CADFD180B488; Wed,  9 Apr 2025 12:44:41 +0000 (UTC)
Date: Wed, 9 Apr 2025 04:31:08 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org, stefanha@gmail.com
Subject: Re: [PULL 0/2] loongarch bug fix for 10.0
Message-ID: <20250409083108.GA24040@fedora>
References: <20250408064122.1917691-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="wiwoHpVz/v/ku+DI"
Content-Disposition: inline
In-Reply-To: <20250408064122.1917691-1-gaosong@loongson.cn>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIMWL_WL_HIGH=-0.505, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--wiwoHpVz/v/ku+DI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--wiwoHpVz/v/ku+DI
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmf2MEsACgkQnKSrs4Gr
c8iNwwf/WDOVyhVHrVV5FXRtImnTtqW0T+eB6N1HEz5V/RBFrHw+WTXg53pxMvqM
AtF7nRWtZ0QZt/Iy+0tcl1rWOGAl+WEH7imDs48flbyRr62yYDwlwMax+jLSaXSi
tknemK0CoiZt6GoDYYUPJlz1K88LI4IRrsZkP+vv9pWk1oWgYQysddlTPEmSPDTh
j8W/7RFmiDwLTBp32q0gMO0uaFIvEGE5SQJINHL8eQny0ULUqHphSYv7mgAhyxpM
XE0AhV4umMuFkRJU8lMVdvnxvM1R2GkAoickEYTrvx63vYlj50VoM+asHOBz8eP+
cyWWmb0Kbdt6N6sehjPW1/w0jp7d6g==
=bsNG
-----END PGP SIGNATURE-----

--wiwoHpVz/v/ku+DI--


