Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C54B1C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 07:04:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsccL-0001eW-K2; Thu, 13 Mar 2025 03:04:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tsccE-0001Uz-Q3
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 03:04:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tsccC-0007Td-VE
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 03:04:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741849463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dPJudP4ycrpkt8PHyYB2668iwl7v7F+Vfgjcoza7dDU=;
 b=ZYe53AJQf6381q3tZ7kEA/uQq947Z+ZJBEONUzX30HEoPAR2nEqA9O/a3LWJe2NBa1hBMp
 Fjaxvz9qjU7WcfZOU475x2ojtn+JjxhseuJSxDNlb6s86LbvWKQLTwfoLUWjuYT2RjcGq+
 XrJSVBGHCKPTH+AJdBKJnDhdSOHb5ZY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-507-w-HB26E9P4-EWUYAUQwC-A-1; Thu,
 13 Mar 2025 03:04:18 -0400
X-MC-Unique: w-HB26E9P4-EWUYAUQwC-A-1
X-Mimecast-MFC-AGG-ID: w-HB26E9P4-EWUYAUQwC-A_1741849457
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CB9F0180AB1C; Thu, 13 Mar 2025 07:04:17 +0000 (UTC)
Received: from localhost (unknown [10.2.16.45])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0EE3419560AB; Thu, 13 Mar 2025 07:04:16 +0000 (UTC)
Date: Thu, 13 Mar 2025 15:04:14 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 qemu-devel@nongnu.org
Subject: Re: [PULL SUBSYSTEM qemu-pnv] ppc/pnv: Update skiboot firmware image
Message-ID: <20250313070414.GA1086072@fedora>
References: <20250311080142.897437-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="QZKnqlNXXVRQuiV8"
Content-Disposition: inline
In-Reply-To: <20250311080142.897437-1-npiggin@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--QZKnqlNXXVRQuiV8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--QZKnqlNXXVRQuiV8
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfSg24ACgkQnKSrs4Gr
c8gVtwgAkhP1wNRrCTrnxMuIc+59Mgw63SGCflzHPBHSffTHQeyfzMhI7cyZhhh7
VoUlESzpkHM9igysNJ2EmFuT2xIniWxtI/rsjPs2T22I+BST2WBZkjtolwdJnIyp
tcQ5MVQiHEpW6JeW16Lj8DzOF8vcLc/cKDM0bYnbOOtjXypFWaVDnUVfEuyrSu+c
HVB7D3w8Sgr4/vE+YaCsYIKDWHt0FxSldDmHTce4I2a9jiQ/PoB/aJd/HvUxX06i
jQpizT0Uk+cLCGMJpZWNr+eHi0X5aO7ESkH9qPVQaabHU571W4HfFLMlV916Za09
SoaPKP4wyeexiiWJTbdGMpPQkbInXg==
=5dtk
-----END PGP SIGNATURE-----

--QZKnqlNXXVRQuiV8--


