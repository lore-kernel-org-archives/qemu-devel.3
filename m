Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07844CA101F
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 21:09:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwS3v-00074D-Gz; Wed, 10 Sep 2025 17:09:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uwS3p-00073Z-NI
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 17:09:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uwS3n-0008Am-JW
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 17:09:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757538536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=6cBGv79YrVWvumPtnlSmjNZOYOdQO/Y+5wwAzk0Uu3M=;
 b=fUTX5EHpFHt79Dv0qKs15TeVbO7SfIaX3+T8Pp35+QphGQ32tPJTgYEpeYABRzDO25Bo69
 7WCb5Io18qSaFBAUFXQ5OTzE1E0a4AwcaATgMCV8d7RvakhaImEN1Y5BIuJIbrGEutOVZP
 CcwzvX1JTVQnP82OqkBkiyfuL5885Fg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-462-flUhwU8kOGCRLs9IAb2_xg-1; Wed,
 10 Sep 2025 17:08:52 -0400
X-MC-Unique: flUhwU8kOGCRLs9IAb2_xg-1
X-Mimecast-MFC-AGG-ID: flUhwU8kOGCRLs9IAb2_xg_1757538531
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9AD4619560B2; Wed, 10 Sep 2025 21:08:51 +0000 (UTC)
Received: from localhost (unknown [10.2.17.66])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DCAEC300018D; Wed, 10 Sep 2025 21:08:50 +0000 (UTC)
Date: Wed, 10 Sep 2025 17:08:49 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: qemu-devel@nongnu.org, pkrempa@redhat.com
Subject: swtpm persistent state snapshots by copying .permall file
Message-ID: <20250910210849.GA379545@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Tzd5fyKc8GlxbRGe"
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--Tzd5fyKc8GlxbRGe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Stefan,
I am investigating QEMU devices with persistent state like swtpm for a
specific snapshot use case. The VM is paused while disk images and other
persistent state files are snapshotted. This creates a crash-consistent
snapshot similar to booting after power failure on a real machine. No
RAM or volatile device state is collected.

My concern is how to ensure the swtpm's persistent state is captured as
consistently as possible, but I'm not very familiar with the code. I
wanted to run the following by you:

- Using --tpmstate dir= will write the persistent state to a new
  temporary file and then atomically replace the old .permall file using
  rename(2).

- If the VM is paused and a copy of the .permall file is taken, then
  this copy is consistent. It may not reflect any in-progress changes
  being written into a new temporary file, but that doesn't matter from
  the snapshot point of view since the VM is paused and it hasn't seen
  the completion of in-progress TPM operations.

- The .volatilestate and .savestate files do not need to be captured in
  the snapshot since the goal is just to achieve crash consistency.

Does this sound reasonable or have I missed something?

Thanks,
Stefan

--Tzd5fyKc8GlxbRGe
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmjB6OEACgkQnKSrs4Gr
c8hdbgf9En0jHNYVfkPn6ua5/SFVFoR9LnzK282I5RYqpmBEBYGszBerQUyrz6CM
P8w6j/bKbfOUTkIZ3LsVmT7S5/IKIVUgdWSYVULWw4077IFeINAHuqzSy/iudqNT
G6V27JQ6mz0rII5re9/lb+RdDhOi7J76LCL/0I/zFEvZMDQ4S+y0oGJIHB+hG7S8
LCtgCo+2aADaCblof/dAxfAP0nzHc6AyuK50G5ohewGE9ltse/FVkTASHZR/89dm
OX3OSS3Zoszu3nxcYnKCV3vcmFcVu8clxAfc1xyvdPYkerq1+A4VEbvNru6zjgh7
HOqpj4sliSPRD/q/H42EEq0DaDmOBw==
=29tE
-----END PGP SIGNATURE-----

--Tzd5fyKc8GlxbRGe--


