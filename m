Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73FA5C3ABBF
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 13:58:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCIoa-0007OS-F8; Tue, 06 May 2025 09:58:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uCIoY-0007OF-Uk
 for qemu-devel@nongnu.org; Tue, 06 May 2025 09:58:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uCIoX-0003Nt-FW
 for qemu-devel@nongnu.org; Tue, 06 May 2025 09:58:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746539908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9iDXO9FY3mH2jBbGCclYsnaNkm8StWo6D/6jZ7K9Nys=;
 b=BW+LAZciSC/7KgfARPFlUDuTvn2TKytrjW5gPPVbLJ3pm+HqoVYBjuipj3uLrpU64Ti8xP
 M1iSefEU4rksSIAfyYxKdF+h/6xzR5qQ85yEN2VPDQepb/1BSvRXQUR0qUvpObwaAgwWhn
 BARangcA+Xic4JJL9zFb3+0Tl/zdG6c=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-536-GdyDVB2QPVWQgXg9H1FeLQ-1; Tue,
 06 May 2025 09:58:27 -0400
X-MC-Unique: GdyDVB2QPVWQgXg9H1FeLQ-1
X-Mimecast-MFC-AGG-ID: GdyDVB2QPVWQgXg9H1FeLQ_1746539907
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E4D471955BD7
 for <qemu-devel@nongnu.org>; Tue,  6 May 2025 13:58:26 +0000 (UTC)
Received: from localhost (unknown [10.2.16.219])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 692A130001AB; Tue,  6 May 2025 13:58:26 +0000 (UTC)
Date: Tue, 6 May 2025 09:58:25 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/13] Rust, i386 changes for 2025-05-03
Message-ID: <20250506135825.GA302704@fedora>
References: <20250503075858.277375-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cZBd8KG2bjXp8ivk"
Content-Disposition: inline
In-Reply-To: <20250503075858.277375-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--cZBd8KG2bjXp8ivk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--cZBd8KG2bjXp8ivk
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgaFYAACgkQnKSrs4Gr
c8gA3wf0DxMRxCRfLuZQTIwxQFpcn0GMR/FLcTAFM0wGZzA3AnEI3NhCnbgDntec
P0bmRXY2TKXtF+baqYuJoYe+MNSauitt9uKWjUEtYFHwyp3tBC8ietmSaSZlVrxr
C/UUx1ruJg3y6TRq+du4VG2mRZTXVIKPI/aod9/lIEMUqnLOutBIH1WMGnyBENjD
DEIzA4ZhlzRzic3P98rB/TibTOZFh5Olp5/nJqf5ggIfDFY5YEnng3MygNiqgMYG
sDH9blW7SrGiU0q0xCLcGrIDNNIbqbI5Nz021ss8NapAtX4mBdFbau1ae6nipXR6
NjsH6xP8oaXYBh/HVwzxvtfDuwmR
=10rA
-----END PGP SIGNATURE-----

--cZBd8KG2bjXp8ivk--


