Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10FECC28B2F
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 04:49:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tswyo-0006BJ-2L; Fri, 14 Mar 2025 00:49:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tswy6-0005ta-5R
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 00:48:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tswy4-0001DU-Jq
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 00:48:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741927695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a42nZUN+lj04CK/WOPPpW+CNmf9jXvvX0G8oHOF00ZY=;
 b=OhjLWpTmqSBDR7f9hw0ttRIgF95q019Y5UWL214qQqWb0TXWPhKz4YLRdA4pFycZFfj5Y+
 RuO+JdXARPhbdpWtswNp3e4+/Bwq4Qb0ZoBtwYol/Hk3ZyIqgPnCLqVXApF/2bP8Mh8A+N
 q+n9aOXMlHLzRmXLJfL6ww5mI6YvXCk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-503-rCywYpC4O4eqkGdD-BYIzg-1; Fri,
 14 Mar 2025 00:48:11 -0400
X-MC-Unique: rCywYpC4O4eqkGdD-BYIzg-1
X-Mimecast-MFC-AGG-ID: rCywYpC4O4eqkGdD-BYIzg_1741927690
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8755E195609F
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 04:48:10 +0000 (UTC)
Received: from localhost (unknown [10.2.16.3])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 74F2218001DE; Fri, 14 Mar 2025 04:48:09 +0000 (UTC)
Date: Fri, 14 Mar 2025 12:46:46 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PULL 0/8] Fixes for functional tests
Message-ID: <20250314044646.GA1118229@fedora>
References: <20250313080132.1467625-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="7ifJxwHVnXnluOgw"
Content-Disposition: inline
In-Reply-To: <20250313080132.1467625-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
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


--7ifJxwHVnXnluOgw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--7ifJxwHVnXnluOgw
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfTtLYACgkQnKSrs4Gr
c8iFlQf/Y1VR9YKKts25btjffbmlttU10JKeA/+VYkm6QTOSn7I9TopF6gVrn+og
2nVLQK7TbjZEBx3Net+CjTZ8yO3OywcNLMpjEuiEnJHUhxvQWH6f1VL2V5AKT3Hu
8LYQmC7qfsicR+oyQ2BZSjlnS+kMAlwf8CGMjv8rxRyPI8ps+VmR9RqQEPp4Q+qQ
jcxP9l6uy7HrI+FoGKzv+iDIQIFaJTM6If4qMwayXXrjzISFVzDXlf7snnOk/bxF
zo/TdrIPS3tst0qZEOQ6KRHtXtFx8qncsWwE5va7aRCTbwkFe6gvUNP+XbtpYFTQ
eFvaoZVQKCW1yASFmI6G0RaoagA6Qg==
=2/MT
-----END PGP SIGNATURE-----

--7ifJxwHVnXnluOgw--


