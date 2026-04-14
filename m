Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94E68F9D0CD
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 12:43:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCd6A-0008Am-Ef; Tue, 14 Apr 2026 08:42:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wCd69-0008AW-Nd
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 08:42:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wCd68-00030e-Bg
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 08:42:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776170551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=64C2YsslG2c/XZX4KWE47mEgBaDHV+zeHySbSFO5g8c=;
 b=XPJIT1NPcCXTnEcWWEO1gWvvJilcoKrhcpd9dWQi9LYXjNLU6PzkXFdv+a1rLUik/rInkW
 0r/KLDN0r0+AAo8Dait11ikEDdFSftR5QiTQ7FLOkEvKkuKNDAdRKKca2Ir04gRWcapFD+
 HUzdOUqeLxDVOqfImN4sL9Hex8BI6q0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-18-KqmYqaqZPyS1xAMPi1Rt1A-1; Tue,
 14 Apr 2026 08:42:26 -0400
X-MC-Unique: KqmYqaqZPyS1xAMPi1Rt1A-1
X-Mimecast-MFC-AGG-ID: KqmYqaqZPyS1xAMPi1Rt1A_1776170545
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CFD1519560B8; Tue, 14 Apr 2026 12:42:24 +0000 (UTC)
Received: from localhost (unknown [10.44.50.237])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C0C4B3000C1F; Tue, 14 Apr 2026 12:42:23 +0000 (UTC)
Date: Tue, 14 Apr 2026 08:42:21 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Klaus Jensen <its@irrelevant.dk>
Cc: mr-083 <matthieu@minio.io>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, kbusch@kernel.org, mr-083 <matthieu@min.io>,
 John Meneghini <jmeneghi@redhat.com>
Subject: Re: [PATCH 0/2] NVMe namespace hotplug and drive reconnection support
Message-ID: <20260414124221.GB111076@fedora>
References: <20260409060155.94704-1-matthieu@min.io>
 <ad0lMYOrRa-K1Ach@AALNPWKJENSEN.aal.scsc.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xAu5N7wFZwOlRHtN"
Content-Disposition: inline
In-Reply-To: <ad0lMYOrRa-K1Ach@AALNPWKJENSEN.aal.scsc.local>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--xAu5N7wFZwOlRHtN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2026 at 07:17:37PM +0200, Klaus Jensen wrote:
> On Apr  9 08:01, mr-083 wrote:
> > This series adds two features that together enable transparent NVMe disk
> > hot-swap simulation in QEMU, matching the behavior of physical NVMe
> > drives being pulled and reinserted in the same PCIe slot.
> >=20
>=20
> I don't understand this. From an NVMe perspective you can't hotplug a
> namespace. You can hotplug a PCIe-based NVM Subsystem.

Hi Klaus,
It would be great if someone with more NVMe experience than myself can
find a definite answer, but I think the Namespace List can change
asynchronously even on a NVMe PCIe controller as long as it supports
Namespace Management commands.

There are instances in the NVMe Express Base Specification 2.0b like:
- 8.3.1 Capacity Management Overview
  "a Namespace Attribute Changed event is generated for hosts other than
  the host which issued the Capacity Management command"
- 8.11 Namespace Management
  "If Namespace Attribute Notices are enabled, any controller(s) not
  processing the Namespace Management command that was attached to the
  namespace reports a Namespace Attribute Changed asynchronous event to
  the host."

I imagine this functionality would be useful in storage offload cards
(IPUs/DPUs) that present as NVMe PCIe controllers instead of as
NVMe-over-Fabrics. This makes sense when the host is not supposed to
manage the storage itself. When the card's control plane configures a
new volume, the NVMe Namespace List changes and the host is notified.

Linux and Windows NVMe PCI drivers support this according to the testing
that Matthieu and I have done.

Thanks,
Stefan

--xAu5N7wFZwOlRHtN
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmneNiwACgkQnKSrs4Gr
c8igTQgApBp5b1M7ekqyYRSyxicOF16k7484FS7e7aKbMhGKgW4kY81y8f9FKQdV
cSKAH3OR5E+uQSSN5mr0I0OZi7fahQh6TEq+v5kq/RuomEJwAcMQERX+qoFeZ81w
uZ7h2zqICUML2vieHugfb8Trk6GEwlQPL3U1Lu07ML7xOMduYV/Qj1jC/Zy1NDiA
KUfYepPe3tPMFLPmztmOZeDfSOg3VI2joFavdyZ655CAUR32PCfI47gcM1b0e9lk
PQXcn07vW6fQ68q5r11F+G+37gDAbY4X3Kw7k+mMZhBF+ynRNyfla4ygpPnCpAXu
LvawpetldV5wyrHOdIKf7kvXG+cj7g==
=gTsi
-----END PGP SIGNATURE-----

--xAu5N7wFZwOlRHtN--


