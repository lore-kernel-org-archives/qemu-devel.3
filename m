Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76B43C3DA42
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 08:46:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQk0h-0003lD-S5; Mon, 08 Jul 2024 04:46:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sQk0f-0003cn-Qu
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 04:46:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sQk0e-0006Ep-2Z
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 04:46:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720428365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rx9SZeFCtEz1SFh4eJiESxqoU/bkdc78MhGWflkzakE=;
 b=BH+3HXV234L8tznL/FMwvjermhwnmj4ax0CJ57tNlf+DnIoP1ESp8Ahl+ywJz48P+EnnTz
 NVgpVjmEey7vzWQjIEMUWW1NqWJDvHH5YGYMrJes4lm9MAwA1c3wuiwtUP108XKV4TADx/
 aZoSDgKOYGWn1CJbRof6JvraZKQJFko=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-YHADk5C3N6u_4yENL9oi_Q-1; Mon,
 08 Jul 2024 04:46:03 -0400
X-MC-Unique: YHADk5C3N6u_4yENL9oi_Q-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1F9FF1955EA7; Mon,  8 Jul 2024 08:46:01 +0000 (UTC)
Received: from localhost (unknown [10.39.192.131])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 20FD53000185; Mon,  8 Jul 2024 08:45:58 +0000 (UTC)
Date: Mon, 8 Jul 2024 10:45:57 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Changqi Lu <luchangqi.123@bytedance.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com,
 hreitz@redhat.com, fam@euphon.net, ronniesahlberg@gmail.com,
 pbonzini@redhat.com, pl@dlhnet.de, kbusch@kernel.org,
 its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com
Subject: Re: [PATCH v7 00/10] Support persistent reservation operations
Message-ID: <20240708084557.GG38033@dynamic-pd01.res.v6.highway.a1.net>
References: <20240705105614.3377694-1-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="4zIwEnx5092SFEL0"
Content-Disposition: inline
In-Reply-To: <20240705105614.3377694-1-luchangqi.123@bytedance.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--4zIwEnx5092SFEL0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 05, 2024 at 06:56:04PM +0800, Changqi Lu wrote:
> Hi,
>=20
> Patch v7 has been modified.
> Thanks again to Stefan for reviewing the code.
>=20
> v6->v7:
> - Add buferlen size check at SCSI layer.
> - Add pr_cap calculation in bdrv_merge_limits() function at block layer,
>   so the ugly bs->file->bs->bl.pr_cap in scsi and nvme layers was
>   changed to bs->bl.pr_cap.
> - Fix memory leak at iscsi driver, and some other spelling errors.

I have left comments. Thanks!

Stefan

--4zIwEnx5092SFEL0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmaLp0UACgkQnKSrs4Gr
c8gYvgf+Ma68Xq6fh08kfwO8dEUTnHxAluZEq0AuaZORl7WwH2SFBl6eSMEz4Es7
GANT/lm6jrJ1W55hSniNpym/Ge2uncPbt9PmeTqSwaItF7IaiR1IJxVpHFnela9G
4tPO8AjhOZ2bmcuSCMi0xkslX4QnpspEyCG0LYWCnTbRSpBcMESUoNeJ/rU12yjL
RfgRnDQHRNwHPUbFftekerrsePIHh310AKUi2J+BkGG7ca/PwtDbyXMUVQnhQ7OP
QZcShxEnt0xirO+DIl4LIbypLLVfKEV6qBQktzoqVH13xOEyvEFd+2FOW+9i2OvK
aT1RRkWKeo52pnWIGvbD1KulNqi+hw==
=fXej
-----END PGP SIGNATURE-----

--4zIwEnx5092SFEL0--


