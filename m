Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DAFDCD6E55
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 14:04:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU3G2-000770-BS; Mon, 01 Jun 2026 10:04:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wU3G1-00076m-Ba
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 10:04:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wU3Fz-0006Yz-NO
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 10:04:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780322680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WGhwT6y6+VM0qQq62yvfJPGa08dPS/KVS779J3kVsqU=;
 b=Bhal2evjOMeh0sBlP4Ssk4Y4+ziG/XlfLDCiSZDcFFQdw04YmRMG0NGSI7e5298gnvTSa8
 2z93+At5Q2LgOnH8vJE2sZf8pHiJwz5/eoaNr85G4drXyac77cKuf7A2dYBpFkRERnGLKF
 xlvNGhgWZCVyc1OEWYE2CRXqBqYW9hw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-gtXstUmjM9qxPm6p81M9Mw-1; Mon,
 01 Jun 2026 10:01:13 -0400
X-MC-Unique: gtXstUmjM9qxPm6p81M9Mw-1
X-Mimecast-MFC-AGG-ID: gtXstUmjM9qxPm6p81M9Mw_1780322472
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6AF8D1955DE3; Mon,  1 Jun 2026 14:00:59 +0000 (UTC)
Received: from localhost (unknown [10.2.16.102])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 25EE81800577; Mon,  1 Jun 2026 14:00:58 +0000 (UTC)
Date: Mon, 1 Jun 2026 10:00:58 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 0/1] loongarch queue
Message-ID: <20260601140058.GA410772@fedora>
References: <20260601092508.4054448-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="S6xsmRMFUInsRyKX"
Content-Disposition: inline
In-Reply-To: <20260601092508.4054448-1-gaosong@loongson.cn>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--S6xsmRMFUInsRyKX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--S6xsmRMFUInsRyKX
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmodkJkACgkQnKSrs4Gr
c8gkAwgAj5kxAMD33N2y6AGQphxevkfxtcpW6+qxATiMsdmvrangSe1a2PLRWbhh
uZzHIuzxOfvGOzMuObRS4+vC4pm/kxrfQg4hJMGvx772rz8yOCPknPa2869Z6BFl
emnmI0QH+VdtsMybUmIH9iEiFYN2xUPqsboRuOef/L5zVmM/dzGr17aM5HI0Xnk8
5lXlickGKvUMAQ9yO5/EAtywe5XJBglcBAv8n2Do03pG/Z7qnb9qGwZ/7b/aGYb+
h26sEd8Z9sA0uCif2Zpdj4g418JwauPUnLrsbipQbKfcEhP1CHkD4o9rYqsIb+tG
JTaivdU9QB90FsJUAAd0UbryJY+Hxw==
=Cwbo
-----END PGP SIGNATURE-----

--S6xsmRMFUInsRyKX--


