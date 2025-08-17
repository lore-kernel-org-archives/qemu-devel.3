Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCB78CA0EDC
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Aug 2025 13:46:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1undha-0004EO-OM; Sun, 17 Aug 2025 09:45:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1undha-0004E8-8K
 for qemu-devel@nongnu.org; Sun, 17 Aug 2025 09:45:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1undhY-0006lM-LQ
 for qemu-devel@nongnu.org; Sun, 17 Aug 2025 09:45:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755438335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pdS7C5/ALLrtUj1xLBFiSX0AcMh+JJHEF8e0q3zKdJ0=;
 b=K/nuScfl4bquKFZtjKeEumxDoqSe+zWGP8iOtV/TwLfgiwqo8ohVDoaVEKvE5zzB7XFA6U
 FYlzp1pGJU5OqjAyK4RWeOFENvu66i77lncCLI7U5WBPOjkgHpBROL/Q7SAm7FiGgpccDz
 AxFzNvc4Et4fx3t3+HXC3EfO6EyOowc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-453-d-7hCml7OzCHzA8r-JNOTg-1; Sun,
 17 Aug 2025 09:45:31 -0400
X-MC-Unique: d-7hCml7OzCHzA8r-JNOTg-1
X-Mimecast-MFC-AGG-ID: d-7hCml7OzCHzA8r-JNOTg_1755438330
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 322E3195608E; Sun, 17 Aug 2025 13:45:30 +0000 (UTC)
Received: from localhost (unknown [10.2.16.33])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E3A9E30001A6; Sun, 17 Aug 2025 13:45:28 +0000 (UTC)
Date: Sun, 17 Aug 2025 09:45:27 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Zhi Song <hibriansong@gmail.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com,
 bernd@bsbernd.com, fam@euphon.net, hreitz@redhat.com, kwolf@redhat.com
Subject: Re: [RFC PATCH 0/3] block/export: Add FUSE-over-io_uring for Storage
 Exports
Message-ID: <20250817134527.GA321129@fedora>
References: <20250815034619.51980-1-hizhisong@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mrsZwHIpGfgDsQLC"
Content-Disposition: inline
In-Reply-To: <20250815034619.51980-1-hizhisong@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--mrsZwHIpGfgDsQLC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 14, 2025 at 11:46:16PM -0400, Zhi Song wrote:
> Due to kernel limitations, when the FUSE-over-io_uring option is
> enabled,
> you must create and assign nr_cpu IOThreads. For example:

While it would be nice for the kernel to support a more flexible queue
mapping policy, userspace can work around this.

I think Kevin suggested creating the number of FUSE queues required by
the kernel and configuring them across the user's IOThreads. That way
the number of IOThreads can be smaller than the number of FUSE queues.

Stefan

--mrsZwHIpGfgDsQLC
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmih3PcACgkQnKSrs4Gr
c8ikiQf/XFVFWRLUl3oHfpUgQqJKFGm0H6tOPb//ZM6f7gC2NCBaJ6S2ntcPprV8
6foUR3gpjvFxxBGDrT+yPmU3qGu3ZPRSYK9obG9tf18/A4cp7Mpi77Wqn29FBmS6
+So1EeE6K4ulLKRzzR4EPfAWefmjrSxwGKwDwD1UyOmD1NxGYB9INa4/N/gyLWb8
Tc9vDEmmmxhqrimnw6DrCqsqWYWrJnslX6lGrrsFSOatT9xHWQ6Brk2FHoZRheo7
C+Q+s/mRJHBD5DtvErTL3igZy8P0gg1DTFEDkrjpPTERD6TisaY8WfNyRgzeZ3LI
t4pX9fBkXPDYikZGOgtvGqYYpBw1Hw==
=icji
-----END PGP SIGNATURE-----

--mrsZwHIpGfgDsQLC--


