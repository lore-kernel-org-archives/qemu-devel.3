Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3D99CD13D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 17:36:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIVJB-0003It-H2; Thu, 30 Apr 2026 13:36:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wIVIn-0003Bo-OD
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:35:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wIVIk-0008Vg-Cf
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:35:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777570547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ca4LW7Q3DuKq6bbHJoickoqkrwoyDkif5yXJPDuJqys=;
 b=PoyDRD7iIOzAZ0dOPD2CWXqz/pHsvt8HHwR+es23XAPAbqLpYlCjL9qYBWuhIzz1DTXiEr
 /shoSSaxdShAhTyTfaZhLzbUTsSvcQ5KH2iLK81zc3udSgbtZuD6PAWmbyNL5QiureuCOY
 p1xxw1CXtWlTlxCjd5rBpBWEL2TDq+4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-50-j0KrYg17PZ-1y1rb_0S8dw-1; Thu,
 30 Apr 2026 13:35:45 -0400
X-MC-Unique: j0KrYg17PZ-1y1rb_0S8dw-1
X-Mimecast-MFC-AGG-ID: j0KrYg17PZ-1y1rb_0S8dw_1777570544
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 79AA41800451; Thu, 30 Apr 2026 17:35:43 +0000 (UTC)
Received: from localhost (unknown [10.2.17.34])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 27BB31800446; Thu, 30 Apr 2026 17:35:42 +0000 (UTC)
Date: Thu, 30 Apr 2026 13:35:42 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/13] PPC PR for 11.1 (2026-04-29)
Message-ID: <20260430173542.GA31778@fedora>
References: <20260429183310.12455-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5YpiAkz3of6cFqRB"
Content-Disposition: inline
In-Reply-To: <20260429183310.12455-1-harshpb@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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


--5YpiAkz3of6cFqRB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--5YpiAkz3of6cFqRB
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmnzku4ACgkQnKSrs4Gr
c8jliAf/dd/Xe6nWWU2SffT7gVkQiYZfUiHBDcFQpNUvPLN34zwlU3miCPNiT4vR
JvE5Z6aUivRTPhXY0ss7EW55trdgGFfpxqQyvZWvoQhby/bS6f4dTf/KOz68WNkf
ICV8DczHXdcYhYh9biv/p7N9IDmzmade2f9mtJ08KN7ss0DFHejvrzAKnALBHZZp
9rybhkcO3LtTzPgu5H6XbmjMTnCMvbq1IIk5sEho0y6I73vGQPY8WJAK8xWK/8wp
N0vLU7ebdc/UM44v9zmKTwq0bHsY5XJbaWhbvPXxInFs80jwvOx+Ixg6dvLdHFZA
CIY54bVXuDITZWpmcLvhCWLNsVF1jA==
=M93X
-----END PGP SIGNATURE-----

--5YpiAkz3of6cFqRB--


