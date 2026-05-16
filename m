Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86043CD4F52
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 12:33:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOx92-00040C-Ta; Mon, 18 May 2026 08:32:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wOx8m-0003vz-6d
 for qemu-devel@nongnu.org; Mon, 18 May 2026 08:32:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wOx8k-0004oa-Ig
 for qemu-devel@nongnu.org; Mon, 18 May 2026 08:32:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779107529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kkc2barDAnRYOpF5yiaM2/dDaiAzyJOsobVutlSoXIw=;
 b=KRzdu8GoJjf3vaiokrwJwasQpCZuw/IHE3cYtg3xoxR0nghMN7tk61iOIiTMlxR24ahmM7
 fE0vveEg7DhBZW9CPLPbm1ktZBk5fX+VMWfTXGPVqV2X2jMEHIMwnomH8FkzFV6vkoMfL/
 ns3+LY3bT2iUE5GJAqaRnLuqCBUxXw8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-RqFyj7nENPS02fHVgc1YFQ-1; Mon,
 18 May 2026 08:32:04 -0400
X-MC-Unique: RqFyj7nENPS02fHVgc1YFQ-1
X-Mimecast-MFC-AGG-ID: RqFyj7nENPS02fHVgc1YFQ_1779107523
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EA0611956055; Mon, 18 May 2026 12:32:02 +0000 (UTC)
Received: from localhost (unknown [10.2.16.101])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0772D30002DD; Mon, 18 May 2026 12:32:01 +0000 (UTC)
Date: Sat, 16 May 2026 19:25:02 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com,
 stefanha@redhat.com, pierrick.bouvier@oss.qualcomm.com
Subject: Re: [PULL 0/5] Target-info update for 2026-05-14
Message-ID: <20260516232502.GA39079@fedora>
References: <20260514195427.1706609-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+sXPbwu5nmtTGJlu"
Content-Disposition: inline
In-Reply-To: <20260514195427.1706609-1-pierrick.bouvier@oss.qualcomm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_24_48=1.34,
 DKIMWL_WL_HIGH=-0.445, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--+sXPbwu5nmtTGJlu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--+sXPbwu5nmtTGJlu
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmoI/M4ACgkQnKSrs4Gr
c8g7eAf/RqrdfFTa9Jbsaoo80tDpjMPzzFjFw43ALTvick3Ay6IVqQU6+yoScehf
6b4tNJl2v7sDI/+twmTbyNxKXpk5gYRqfopSrhCC2tzL+DmJy2iEH142rQMU9GLH
boaMxdZwkyelPRo10PVWB7eYDDT6ku+5kTGT+MTa7l8Gq7yaEAPJkaEsVdpkjgPf
er4BGZOF7P/zMEMzY/L3GgAEpx4Jc9j6V9wO44GCxDJEJBBE9YR6orNrMK5FllzD
lw8bomeysCA+vQSupCoKM4Lec9ceVkx1NPAuQWW/D9mCHmTHNSNAYY0VQQq2JZ52
ZHz7U3dBFD6ziqOZsvRbBDayON99Ng==
=ghu2
-----END PGP SIGNATURE-----

--+sXPbwu5nmtTGJlu--


