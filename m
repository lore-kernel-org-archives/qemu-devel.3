Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41A36C83F21
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Jul 2025 07:11:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaqre-00077Q-Ki; Sun, 13 Jul 2025 03:11:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uaqnm-0001vb-6q
 for qemu-devel@nongnu.org; Sun, 13 Jul 2025 03:07:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uaqnk-0007KL-EP
 for qemu-devel@nongnu.org; Sun, 13 Jul 2025 03:07:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752390427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a48EztLHoYdBeShKuhzvF/z88RrVXhsBeU5GaaUiLDw=;
 b=jLK+poKvr3+zV1OcT3zr85NyO5FDq4uBB5JbzXlJpp2eiEke9+7u6KV9fHJsJfEZyNoeN7
 kcDAth2XZgmhzZTHFm0PYlYlnp6Zih7w5nE6bY6UTXFln1YfrysZJksHEZqxktTQVn9bAN
 hGTfqJFJpfugn4Yh+fwk8+l7GCYx5M8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-310-WiHHatwgMdy0NOPMrhhQoA-1; Sun,
 13 Jul 2025 03:07:05 -0400
X-MC-Unique: WiHHatwgMdy0NOPMrhhQoA-1
X-Mimecast-MFC-AGG-ID: WiHHatwgMdy0NOPMrhhQoA_1752390424
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 94EAB18001D6; Sun, 13 Jul 2025 07:07:04 +0000 (UTC)
Received: from localhost (unknown [10.2.16.7])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E67661956094; Sun, 13 Jul 2025 07:07:02 +0000 (UTC)
Date: Sun, 13 Jul 2025 03:06:59 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 0/9] tcg/linux-user/fpu patch queue
Message-ID: <20250713070659.GA204804@fedora>
References: <20250711172254.229201-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="taAnwvoj4rCBuY6k"
Content-Disposition: inline
In-Reply-To: <20250711172254.229201-1-richard.henderson@linaro.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


--taAnwvoj4rCBuY6k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--taAnwvoj4rCBuY6k
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmhzWxMACgkQnKSrs4Gr
c8h1dwf8CNVEG5ZroUE2RWQxjKCWBdxUaZ5yo5Cj5Iafw818MC4jhgFV+MtgpLYu
79HXbvdc5fYeriexmFzRuajgOQOJiFlBMwkcFRyNlil6vl/FwJdOmFd6h1wdpBvQ
m0rL48WTs1Z213YAoVNXadkvldQGWsRFspB0SRYsx+XUero2nx7h4sa7hT8LpVda
OG4yRHExREVrnqg4+47dSR/nPDrLkfFd0FtHrArEQFq1BDP6ESl8zVPzfn50cvlj
FP+3ajcrmDwI1w6akHlqt/ZFngjvvP1XoS6dkbz55gpCPTDGXZ8BZCGUAStOWIE2
n+aQfRk1OjWG4D3TAkT53d6FrJd0TA==
=ynKi
-----END PGP SIGNATURE-----

--taAnwvoj4rCBuY6k--


