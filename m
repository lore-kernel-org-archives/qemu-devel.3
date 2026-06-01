Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B00D8CD5BD1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 14:01:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU3CK-0004tV-Nv; Mon, 01 Jun 2026 10:00:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wU3CI-0004sz-8I
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 10:00:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wU3CG-0005hc-Vz
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 10:00:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780322452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EiQxrAITzjsyx3PXCB4Tf9GFB89yaakYeWYjQ5R0oWk=;
 b=J6VNlCPolYnhOpyR04yaAAGE6MneDGNm/3XEUAdSHwf5bCHowPRw942iWTY3m74a5Uk6XN
 PXr7pDMK9XFVY/27JGGpPPAphs29Wl8Dj4zhZBoC9Tswlngn1hD+iDs44vLJNBqU10PmeH
 u6nOmQWXlKYNOT+LjQ40tGT7HA+OwAc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-425-39SdTr4fNlWzT3vmdAUcDg-1; Mon,
 01 Jun 2026 10:00:50 -0400
X-MC-Unique: 39SdTr4fNlWzT3vmdAUcDg-1
X-Mimecast-MFC-AGG-ID: 39SdTr4fNlWzT3vmdAUcDg_1780322449
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 951FB1955F00; Mon,  1 Jun 2026 14:00:49 +0000 (UTC)
Received: from localhost (unknown [10.2.16.102])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DD1101800267; Mon,  1 Jun 2026 14:00:48 +0000 (UTC)
Date: Mon, 1 Jun 2026 10:00:47 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, brian.cain@oss.qualcomm.com
Subject: Re: [PULL 0/2] hex queue
Message-ID: <20260601140047.GA410727@fedora>
References: <20260529235749.879787-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FBser8CWp0VN6qsk"
Content-Disposition: inline
In-Reply-To: <20260529235749.879787-1-brian.cain@oss.qualcomm.com>
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


--FBser8CWp0VN6qsk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--FBser8CWp0VN6qsk
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmodkI8ACgkQnKSrs4Gr
c8iuzAgAhIt56v6oaCBJ1/xPFT0wJST7d6xdAh2WdHOrUkm1tf7q+I9Yig2L+BtT
gy3MpF2yRIl+2/+qMXvP55b7erjmOREvGK+sE2sZhcOpUHYtvFwQ7B7uuyG8NL+o
pI1mRn6E3eNkcN4whH4hODe0m0GrTek1FcMO6pmnNRHnY/e5uVrq8KfkMnDm73Yh
FxcOMwV5xvZtYqB3VZYHsi0PAi7iKY3iD2IGNBz51DW3ordl3xBT59mqT8JUpKrD
y4P2HrSg3FnTzqM8GuAYvTE1ZB+siiqneyQmf6fOkALbN+0TtG+cx2MqxJkVyTJn
9sax/+tDJIOco02yFEvaIiGC95/xJQ==
=ELgS
-----END PGP SIGNATURE-----

--FBser8CWp0VN6qsk--


