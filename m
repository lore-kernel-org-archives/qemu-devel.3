Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2129DC54F4D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 15:31:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wojm7-0006WZ-Ju; Tue, 28 Jul 2026 11:31:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wojm6-0006WI-Vi
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 11:31:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wojm5-0001Sv-MT
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 11:31:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785252680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0AjsPDgJzaFvb9hHYOSv/knSjF0fsed/YtJoRxMjWAE=;
 b=akYg4iW96adtxEav4AkFnYMhJBIbM/dlE73XLmTWYP9XnmlmRb9Ee9v5JI8GH+Iig/QRzf
 tIZGLqVpmdck3vmJHSG+vwZUFxIzWCkkivDLLgG6MMrrQemtTJil+sdMI01gyRhxpfCXm2
 O+cFDdiKq/6hTrrIC+nn82Qg87WcOqY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-261-Ux2R5XevP96MbyxglbkzUg-1; Tue,
 28 Jul 2026 11:31:17 -0400
X-MC-Unique: Ux2R5XevP96MbyxglbkzUg-1
X-Mimecast-MFC-AGG-ID: Ux2R5XevP96MbyxglbkzUg_1785252671
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6C47519560B2; Tue, 28 Jul 2026 15:31:11 +0000 (UTC)
Received: from localhost (unknown [10.2.16.73])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 936EE1800480; Tue, 28 Jul 2026 15:31:10 +0000 (UTC)
Date: Tue, 28 Jul 2026 11:31:09 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Helge Deller <deller@kernel.org>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Helge Deller <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>,
 Matt Turner <mattst88@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PULL 0/3] Linux user patches
Message-ID: <20260728153109.GA1311878@fedora>
References: <20260728091633.29765-1-deller@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZyfPPoaTHNz8Xj5O"
Content-Disposition: inline
In-Reply-To: <20260728091633.29765-1-deller@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
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

--ZyfPPoaTHNz8Xj5O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--ZyfPPoaTHNz8Xj5O
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmpoyz0ACgkQnKSrs4Gr
c8iowAf/VaLvP7RbIlN9EyG+CwmcDNbhEI7TilqpSzsU7F5mikDpKa+RL6/xhwJW
WrkxracljXxiHNgu3ncsqiOPYuIMpuyntpRjnN0fxIwIBZBZvUEUCVdDLCPoN3Yy
6t/zCCBSPetS8Y/7VHZjW7ymcncT69sy8L71jLIDsKyARvvqVaaH7t6bCGXxYBOi
aG2AckaYkcz3OwyIEAZksjmQ+xLN53nEZqJbTfJxTlmzLTm3tI3CPz+9ZMBOkBtm
Spoo8/t9e6XB7QUJIbX86bSYDOdPPKPXnjTd33/z5SWNYlT45W5RhGhPX41PGRog
b06hGubn4uX/09hiSc/fUxHC6cVDPA==
=BVvc
-----END PGP SIGNATURE-----

--ZyfPPoaTHNz8Xj5O--


