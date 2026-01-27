Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9048D2FED7
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 18:48:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vko6f-0004Mn-5k; Tue, 27 Jan 2026 13:48:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vko6S-0003li-8V
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:47:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vko6Q-000892-2b
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:47:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769539668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=AK0SOcTwOBP7HCWx6uYeN0NOm4pFd+9ohruDS0MOAv0=;
 b=V8PbpqvafOIQGYajYU7D+hgJD+DbEFAYTC/hzUGGl1VLyHc2OZI/Vhc/A02AFFKeJ/ZliI
 4Oa9TUECqaf9Z98NAtjySNjyfagC28fsOW27l0g4UIPq4i8eX4EUXt7wZOeSSrJb5xwVR4
 GLHNOGZHfjK8moD4MqVhpI2YTE1i8b8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-207-CVRFwiwlP_-F-PUZObnLRg-1; Tue,
 27 Jan 2026 13:47:46 -0500
X-MC-Unique: CVRFwiwlP_-F-PUZObnLRg-1
X-Mimecast-MFC-AGG-ID: CVRFwiwlP_-F-PUZObnLRg_1769539665
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 810DE1944B0C; Tue, 27 Jan 2026 18:47:45 +0000 (UTC)
Received: from localhost (unknown [10.2.16.97])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 14E5F30001A2; Tue, 27 Jan 2026 18:47:44 +0000 (UTC)
Date: Tue, 27 Jan 2026 13:47:43 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Benjamin Marzinski <bmarzins@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hannes Reinecke <hare@suse.de>, afaria@redhat.com, qemu-devel@nongnu.org
Subject: Moving from qemu-pr-helper and libmpathpersist to <linux/pr.h>
Message-ID: <20260127184743.GA77765@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="n0gLNTJmku2kkML0"
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


--n0gLNTJmku2kkML0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Benjamin and Paolo,
I would like to discuss changes to DM-Multipath and qemu-pr-helper to
handle SCSI Persistent Reservations in QEMU without privileged code.

SCSI Persistent Reservations support in QEMU is built on the
qemu-pr-helper daemon that performs PERSISTENT RESERVATION IN and
PERSISTENT RESERVATION OUT commands on behalf of the guest. The
qemu-pr-helper process provides privilege separation for ioctl(SG_IO)'s
CAP_SYS_RAWIO and libmpathpersist's root privileges since the main QEMU
process should not have those privileges.

There are issues with the current approach:
- Privileged code is a security attack surface.
- A bunch of code is required for privilege separation and for management
  tools to set up qemu-pr-helper with access to multipathd.
- The interface is SCSI-specific and does not support NVMe.

Several of us have pondered a different approach that I will summarize
here. The <linux/pr.h> ioctl interface provides an alternative to
ioctl(SG_IO) without the CAP_SYS_RAWIO requirement. It supports both
SCSI and NVMe. Since privileges are not required, there would be no need
for the qemu-pr-helper daemon anymore.

The blocker is that <linux/pr.h> is not usable in multipath
environments. The Linux DM-Multipath driver has an incomplete ioctl
implementation that falls short of what libmpathpersist and multipathd
do in userspace. Kernel changes are necessary to fix this.

My suggestion is to implement <linux/pr.h> via upcalls from DM-Multipath
to multipathd. That way applications like QEMU can consistently use
<linux/pr.h> across block device types and no longer have to go through
the privileged libmpathpersist interface.

Once DM-Multipath support <linux/pr.h> is functional, the main QEMU
process can directly invoke the ioctls. qemu-pr-helper will no longer be
needed, eliminating privileged code and simplifying the setup required
by management tools such as libvirt and KubeVirt.

The only loss in functionality that I have identified when switching to
<linux/pr.h> is that qemu-pr-helper supports SCSI TransportIDs for the
PERSISTENT RESERVATION OUT command. This is not supported by
<linux/pr.h>, but I'm not sure how this even works today since the guest
sees a virtual SCSI bus and is unaware of the physical bus or HBA. So
maybe that was never used in the first place?

Does this plan sound good to you?

Benjamin: I can work on the DM-Multipath upcalls if you are busy.

Thanks,
Stefan

--n0gLNTJmku2kkML0
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAml5CE8ACgkQnKSrs4Gr
c8jhRAf/a2wAhQfnrGTVPIlcOLGh71hdfH2MWWedmhNvgpKuG/EdCQ3a0Tyb6xno
9OF1TiseTDcZhn/jjzSouBc6I4z71kMRcbgRFLhewCGuTWrXFegPABiSXid2z0kt
4k4w/+HMECggWZbfO4XrOC4h7fm+rub+sdq/vi6PjBWE+UEHjCbkgdiptr2bBIlu
oyiW5fdZuvNT3j49jDHetJBKzOmUAIxewZ6K+oN71iwINIWZotE6iaWzQ4hcRqAS
jXiCF0wdWcOHBRK8oVohaXA62mlvuIbC2pd4HQjJ+EEBsd9bbBwNBWyRG8lhC/Fq
2vLhLIZrZTDYzsbw6icmXn53jv+KUw==
=WZvA
-----END PGP SIGNATURE-----

--n0gLNTJmku2kkML0--


