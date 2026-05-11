Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 165B9CD4840
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 17:12:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMUAZ-00071K-I5; Mon, 11 May 2026 13:11:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wMUAO-0006zm-7a
 for qemu-devel@nongnu.org; Mon, 11 May 2026 13:11:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wMUAM-0001P0-Hr
 for qemu-devel@nongnu.org; Mon, 11 May 2026 13:11:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778519497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tjZI3l0kkKy33AQihMWeqQdZf9pElFH5vx4yPwhn8XI=;
 b=KcMp62cBpTn3ztrhKQe3hK24oj9IOB2NCZVjI7Jfw1eB9f6+6l7kRxNALGhn1ZUGecXp3D
 UFMadm1XEiLi6JIvl4hzHy7gOMSlpYUKxwygUOkawnHixNEGS/knz3YwHlw9MTzUAraGWY
 tLcu7hOd7DF+hIILIUYZWLzAbf1eRqA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-27-yUUZvjbPO7GXqKfexXWecw-1; Mon,
 11 May 2026 13:11:33 -0400
X-MC-Unique: yUUZvjbPO7GXqKfexXWecw-1
X-Mimecast-MFC-AGG-ID: yUUZvjbPO7GXqKfexXWecw_1778519492
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8939F195609D; Mon, 11 May 2026 17:11:32 +0000 (UTC)
Received: from localhost (unknown [10.2.16.157])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0D81918004A3; Mon, 11 May 2026 17:11:31 +0000 (UTC)
Date: Mon, 11 May 2026 13:11:30 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, stefanha@gmail.com,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PULL v2 00/33] UI patches
Message-ID: <20260511171130.GA531897@fedora>
References: <20260509171356.1157879-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9iw2lvaszfQeyTjN"
Content-Disposition: inline
In-Reply-To: <20260509171356.1157879-1-marcandre.lureau@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--9iw2lvaszfQeyTjN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--9iw2lvaszfQeyTjN
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmoCDcIACgkQnKSrs4Gr
c8gosgf/biytWZAeeQ772CRgBwjkwN2GJH94PzenoaMq5bhtTpPrgcGye3fvz0sv
bo2XcitSjIJwfAEp5TWEz8AintvryH48BTFxozfFGXrOKXZKhoWKnlAIZicxi1Dx
SZ0AqgZz7rkWHbmDf8LCby1qsAcAWcjKfzfGqIIUpx7VZYfOvTvmW7I8vw56xGkg
AXP+4hFzyuxzUpJxIqTWMiO/wtcpblHdCmYUtTkHoH1TdrHgUGV4cwu5VLtLCFq+
Tq75CmQv4Ba7KP5gNUjrIR8dbjbaF3aYlOaVlNnATnJrLSVh0j2S3IsbdE6NHTQC
alVK05kR9lYZc0hrfV1VSHoUBYiqLA==
=6Kp3
-----END PGP SIGNATURE-----

--9iw2lvaszfQeyTjN--


