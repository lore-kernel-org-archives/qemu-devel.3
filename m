Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E7F2CD6E60
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 17:24:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUSq3-0005Fm-Cm; Tue, 02 Jun 2026 13:23:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wUSq2-0005FW-3S
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 13:23:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wUSq0-0002aH-OH
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 13:23:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780421015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eMHf+SrTht43JeciZBo/IlkaN/thRLIHo1Z4jyxZjIc=;
 b=PqVmMT6wYctjltGlZrUKIajNTnSwlBtxtJjBTqNBZjA1ft3MGn8JatTSCsWk+k89lepBHT
 wiRKXu6KhB0c+h3d7pPEzIcND81o/hMNAeDjiIwnMlelrUCKXeyMqI3dj8pe+cNOjwz7en
 fEPdJ5qvGq0JcvClJ7DRDw4cFkeMhGQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-kasF5kWrOfKxVdMwV8iVcw-1; Tue,
 02 Jun 2026 13:23:33 -0400
X-MC-Unique: kasF5kWrOfKxVdMwV8iVcw-1
X-Mimecast-MFC-AGG-ID: kasF5kWrOfKxVdMwV8iVcw_1780421012
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 398161956089; Tue,  2 Jun 2026 17:23:32 +0000 (UTC)
Received: from localhost (unknown [10.2.16.102])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A1C191955F43; Tue,  2 Jun 2026 17:23:31 +0000 (UTC)
Date: Tue, 2 Jun 2026 13:23:30 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PULL v1 00/16] Merge tpm 2026/06/01 v1
Message-ID: <20260602172330.GA908818@fedora>
References: <20260601215410.517009-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LQZvWih4NVIDRUoM"
Content-Disposition: inline
In-Reply-To: <20260601215410.517009-1-stefanb@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--LQZvWih4NVIDRUoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--LQZvWih4NVIDRUoM
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmofEZIACgkQnKSrs4Gr
c8jfLgf+PfrA8zRYErUBfWo1n/XnOIoP18k732N2+lCW3bSmtWtshS+QpEtF+EBW
u/fJ0GYtR2nhT5Ponh0ahQ725j2B+OK7YsFwhzg66q+9lRCbYr5rFcCly7ZF1JWP
fTTyJptE/ykWFUgsVBQ0UW5D4P3NyxeOD2cVaR1gdQ1uH3ma6w/+9r+8szxLSB39
dR/+3NEm7Cf8VMyZ07SCybSCQSKyaKe9vrqhvnSpmGawwTZtOLxDjs3OPkY621Am
o50f6V5B2Z2nev5yMVB6ruLLofn/KccjyG5Vht4j7yDBR7AA8OzF74HgioMXyfuB
HOuFrh60V8JYwtx7yjS+ClCCx+DN2Q==
=EKN0
-----END PGP SIGNATURE-----

--LQZvWih4NVIDRUoM--


