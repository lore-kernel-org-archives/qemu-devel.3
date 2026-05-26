Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 677D3CD5BD0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 14:59:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRtFW-0004Kp-IT; Tue, 26 May 2026 10:59:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wRtFQ-0004Je-Pq
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:59:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wRtFP-0007Bv-8N
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:59:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779807550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=El+R9E8eicrc4PVOYvQ1sBUFJMGxi4UWHRpbI+UEb90=;
 b=goTRBDUBWLZ7jS+nW5Qs+7AgBpazHgtibYNasv/vTPDEehczLZ6QVHQY8tj/7+OGzl7lKr
 hkkxN3BGYNm/66OcCcrSyfY71ArRhsEQKBdu41DStTmjVm8wicsJnONt2gS7KsJQE53em7
 graXd7MEdbZnOGaQae83QgibGtLmvOc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-262-0bhfSiv-NQWop8Zn34lYfg-1; Tue,
 26 May 2026 10:59:06 -0400
X-MC-Unique: 0bhfSiv-NQWop8Zn34lYfg-1
X-Mimecast-MFC-AGG-ID: 0bhfSiv-NQWop8Zn34lYfg_1779807545
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F347518002DD; Tue, 26 May 2026 14:59:04 +0000 (UTC)
Received: from localhost (unknown [10.2.16.201])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F3D091800762; Tue, 26 May 2026 14:59:03 +0000 (UTC)
Date: Tue, 26 May 2026 10:59:03 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Helge Deller <deller@kernel.org>
Cc: qemu-devel@nongnu.org, Matt Turner <mattst88@gmail.com>,
 Helge Deller <deller@gmx.de>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PULL 0/6] Linux user next patches
Message-ID: <20260526145903.GA1733370@fedora>
References: <20260524131909.162990-1-deller@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mhDf98umOo/CIb0a"
Content-Disposition: inline
In-Reply-To: <20260524131909.162990-1-deller@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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


--mhDf98umOo/CIb0a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--mhDf98umOo/CIb0a
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmoVtTcACgkQnKSrs4Gr
c8g8Pwf/RiOX9SNkzd0Q1mmCjTtVOV+YryGihXBafcwJxMgPKOMMPSY+SRo82SVS
AoB/iv/fHovWQx+82Xym2UGIJ+7ek60NXgFHFdCBwN9ZjeIkIGSIVXCkewB/Kr1t
IunOYmxcOG/EW+NnwPqfvUJrmEC3bMDl63LaZ9VC+oORBBRymqtqEOisI5RFvBSX
eEnLiyJP+2q4lscQnFbfvV1mulQqa/xZNgMSdFJMkDcHWbtJ7b+Pr9acMyU48BzU
uof+8N57FX3Cvx3/OqBfoJX1ds2cmicoEF71djUuvus2lSK+8j6X8UdBETtmkVye
4WstfRqL5wUhlACcM9mJgbW31JJCDw==
=zUID
-----END PGP SIGNATURE-----

--mhDf98umOo/CIb0a--


