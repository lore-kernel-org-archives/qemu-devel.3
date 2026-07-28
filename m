Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5BC1C54F54
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 15:31:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wojmH-0006dI-JE; Tue, 28 Jul 2026 11:31:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wojmF-0006aE-UY
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 11:31:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wojmE-0001U6-Gv
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 11:31:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785252689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ltx1OPG96qcmiS8hL6YLJHjyxDpJP7/lUjaMYLaPiCk=;
 b=Ouxd6O2Mvs21fCBE/SPZZ1vBBbYPukEZOBJxVYw2hMrfOSAzEV7A+kZotRM83epMgIG77a
 pMsNFAwpUeSqp3kn8Mwprg8KkhfYKL4LtEn+oUWUm/OelS2XLPeOSNAOblP0k/fKgb23cB
 29ZaYKIn/iTY/sqRPpYBjhzPY8earwE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-386-08_f6lXqP0ezRprk2tQsUw-1; Tue,
 28 Jul 2026 11:31:24 -0400
X-MC-Unique: 08_f6lXqP0ezRprk2tQsUw-1
X-Mimecast-MFC-AGG-ID: 08_f6lXqP0ezRprk2tQsUw_1785252683
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6704F1800352; Tue, 28 Jul 2026 15:31:23 +0000 (UTC)
Received: from localhost (unknown [10.2.16.73])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 03564180044F; Tue, 28 Jul 2026 15:31:22 +0000 (UTC)
Date: Tue, 28 Jul 2026 11:31:22 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 0/6] Misc HW patches for 2026-07-28
Message-ID: <20260728153121.GA1311930@fedora>
References: <20260728094055.12684-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dFh+2eBJoTvHfD3G"
Content-Disposition: inline
In-Reply-To: <20260728094055.12684-1-philmd@oss.qualcomm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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

--dFh+2eBJoTvHfD3G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--dFh+2eBJoTvHfD3G
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmpoy0kACgkQnKSrs4Gr
c8iPmAf9HNMDsfoLJroVPDvq1WZLiLqU4V84ch5J6E1wiqfnQb/0XKO6Qo/UARef
Lp9WfmInhSXpH7KBYbUwXO/DAkhTfXLbt/rGOO8XcAJa1MPqe/gZuLEsXqr37lSp
NrWLPxAmp0/RutSB7huCrWHbqGKf+qQTSHgvNOj9gk6aB2Ll+G8hDXGHAz1jTgg5
5hBClqOr2LYPl4un9Y/aqgTEkyfcnwJcf/Abd2wDhV9Hha0D6lXhivl6sA/qzHP3
yew2t+0cQrhNU68z9cchcVV+382nOsy94hfbZWnrdsxH/sACCaJVUbQAj7bmw5Z3
gvSDOdMhR39iCQB6CCFuzoX1dC042g==
=ieqc
-----END PGP SIGNATURE-----

--dFh+2eBJoTvHfD3G--


