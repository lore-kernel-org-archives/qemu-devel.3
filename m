Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1259BC87FD2
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 13:04:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujHK4-0006Jx-Om; Tue, 05 Aug 2025 09:03:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1ujHJz-0006Ec-OS
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 09:03:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1ujHJx-0004Yj-I8
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 09:03:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754398991;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b3cbKttpW5N/MTWv46oJ4DjxCzOzUyw7NpMbStmlBrs=;
 b=VAQCih9PXog3LoVndge66bjawVLJDcWAa0xOMGHdPTfO9/p6Bz5p4p+kUO5ZcjXtdh6/1e
 aMNVsXzeIU66IJz5Is6/F+EP0dKMijIyepGkOh/aBj5Tf5ix6R7UIZ3CR0xBNpeJGrWtnA
 UIdwHgTkGRCFOUk/QvkrqrYb6hwG6UM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-596-rLOO0TORPOOtedDObjnTPA-1; Tue,
 05 Aug 2025 09:03:08 -0400
X-MC-Unique: rLOO0TORPOOtedDObjnTPA-1
X-Mimecast-MFC-AGG-ID: rLOO0TORPOOtedDObjnTPA_1754398987
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1E020196E06E; Tue,  5 Aug 2025 13:03:07 +0000 (UTC)
Received: from localhost (unknown [10.2.16.139])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8EB34180035E; Tue,  5 Aug 2025 13:03:06 +0000 (UTC)
Date: Mon, 4 Aug 2025 21:27:23 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PULL 0/4] aspeed queue
Message-ID: <20250805012723.GA240229@fedora>
References: <20250804110108.2414355-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="EraCSd+N7RSG1SzU"
Content-Disposition: inline
In-Reply-To: <20250804110108.2414355-1-clg@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 28
X-Spam_score: 2.8
X-Spam_bar: ++
X-Spam_report: (2.8 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--EraCSd+N7RSG1SzU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--EraCSd+N7RSG1SzU
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmiRXfsACgkQnKSrs4Gr
c8gHLgf9Gq0yuxvOjYBuJW6EySQPzqNZit1IcQPQZpGmXU8bdW9CmQ8sJEivdsan
c7t9l6eVL4EZ2cN5VBBS+digPyUIK/xDL6JNP22E0Q6REkdOTWndbciWK6QeUhYK
0u4hzGESUEH4jfTM4i7tuHNFS3XApvSxvbDZ0cUj8rQly7eooDtmkq+VW2Lc0Iwf
mqPYQPpz9M+kxYQ9hmGWCT1r4a6kpWp2KjXX8gq8IMoTQJ3TGe19+BzVFuprSuDE
OYJmlg+pgaYm57bKb4X36glxKLaK/AqeFyRYw8pu1YhO2oUN7sZTQZb6lZBTIPmv
p3CuX6RKElpVm7EkPfC/P9YaiEMclg==
=222F
-----END PGP SIGNATURE-----

--EraCSd+N7RSG1SzU--


