Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6531CD3427
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 18:27:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKKTZ-0002gz-0y; Tue, 05 May 2026 14:26:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wKKTQ-0002gU-Mu
 for qemu-devel@nongnu.org; Tue, 05 May 2026 14:26:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wKKTP-00070I-9S
 for qemu-devel@nongnu.org; Tue, 05 May 2026 14:26:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778005582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IZ/7ETElDn3XwmueGLPOWECCcWtV3rsTO9l0eXEP2U0=;
 b=Mn2hJPClTzwzATafb8Jmx8oAQyWsji2uWIAJj+kbnfsFV0Uf8ouTQxb6v+RnnoVpY7QzcZ
 rO3DynWV/97oN+74hhnDZPGvV7fOaoGLAPHMlWtLz6Q8nzRLnMcjt+XLk9e22RF/KPLYh5
 7ccbig7VlQhISuyRqq14o+5FI9c5fck=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-573-UBaiG0UWPI-8EyTf1Vif6A-1; Tue,
 05 May 2026 14:26:18 -0400
X-MC-Unique: UBaiG0UWPI-8EyTf1Vif6A-1
X-Mimecast-MFC-AGG-ID: UBaiG0UWPI-8EyTf1Vif6A_1778005577
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 71C3019560B4
 for <qemu-devel@nongnu.org>; Tue,  5 May 2026 18:26:17 +0000 (UTC)
Received: from localhost (unknown [10.2.17.31])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AF71A19560A6; Tue,  5 May 2026 18:26:16 +0000 (UTC)
Date: Tue, 5 May 2026 14:26:15 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com
Subject: Re: [PULL 0/5] Miscellaneous patches for 2026-05-05
Message-ID: <20260505182615.GA44003@fedora>
References: <20260505115036.1170186-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="y5oCkeK6kQPTDM3m"
Content-Disposition: inline
In-Reply-To: <20260505115036.1170186-1-armbru@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--y5oCkeK6kQPTDM3m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--y5oCkeK6kQPTDM3m
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmn6NkcACgkQnKSrs4Gr
c8h9FAgAstUWgw2qqDDtwqDSrWRtCXHMIdkCy4c/31+DSnVweksYczU3sygbM8pF
FS3ICFfIUKsrT54+PajK/QoXXtW2IFWhsYj8qd+kCHDt64MHDIDnvpdHgCo/NRsh
6qsHTuqUs8Y9dvdMXBjnJW7O7nyUnC1mC6FWPiOyQQ86lY5AEKKw+cwsZ3a9aF72
2lLDr6ub69KkNbx+16V8nCYHNRO7Eht7jTMk3Fv+jk/mu0QTtuTN8ZK7ViaoakgG
fMF3Zw4rVU1DoRqpvqNATYjV6US58HInHyGUxXnjmsSDsNsMzncXFe8C2eFhDilD
nWB/Cyl5QossWqbi6JB2dz8fE8IciA==
=/nSW
-----END PGP SIGNATURE-----

--y5oCkeK6kQPTDM3m--


