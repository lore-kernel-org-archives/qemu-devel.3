Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF88B606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 13:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NPuIOANu
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTgBh-0006FP-Ta; Wed, 18 Nov 2026 08:59:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xTgBf-0006Au-N7
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 08:58:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xTgBd-0002zM-Cc
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 08:58:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795010336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+e9bW9rBR6xOkVOfbcCNFOC57SGMLIsOyW8IPGb8fY4=;
 b=NPuIOANu9HEg9lMPBmlSStyTrWgHSN/LyuODhjbVK5Tx1hJV8XlIs6sBNbsI5CCshZhqoE
 FCCL9Vtdy+y9x6ZMbHVjp0pFUSzWpiydE4bksODhtlM8WC19ADTNQ6MzSFpKJX63SbKnh7
 rgwwzce14IBM1z8J80/Qx+fYnEdOX8U=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-511-b3Jawdz-Ob66f9LCnA9dzA-1; Wed,
 18 Nov 2026 08:58:53 -0500
X-MC-Unique: b3Jawdz-Ob66f9LCnA9dzA-1
X-Mimecast-MFC-AGG-ID: b3Jawdz-Ob66f9LCnA9dzA_1795010332
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B99671933E24; Wed, 18 Nov 2026 13:58:33 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A6831180055C; Wed, 18 Nov 2026 13:58:30 +0000 (UTC)
Date: Wed, 18 Nov 2026 07:58:28 -0600
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-stable@nongnu.org,
 bea1e@proton.me, Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH 4/4] nbd: Add iotest exposing previous CVE fix
Message-ID: <av2uZOoMR8EPh5z9@redhat.com>
References: <20261113223742.2546619-6-eblake@redhat.com>
 <20261113223742.2546619-10-eblake@redhat.com>
 <20261117180601.GA391996@shajnocz.csb>
 <avyskW5PTOANZonw@redhat.com>
 <a9b7112d-c0d3-41f7-9cae-39462ab10a27@oss.qualcomm.com>
 <20261117220308.GA437212@shajnocz.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261117220308.GA437212@shajnocz.csb>
User-Agent: NeoMutt/20260616
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 17, 2026 at 05:03:08PM -0500, Stefan Hajnoczi wrote:
> The new policy is not in effect yet. There are maintainers who wanted to
> discuss it at QEMU Summit but we ran out of time, so it was deferred to
> the next KVM Community Call (November 24th).
> 
> If we merge this before there is a consensus, then we are overruling
> those who are not in agreement yet. I think it's too early.

Indeed, that's why I'm okay with not using patch 4 until the policy is
actually upstream, whether that's on November 24th or after 11.2 is
released.

> 
> Eric: is there a way to implement the tests in
> tests/qemu-iotests/nbd-fault-injector.py? At least that already contains
> the NBD server logic and it would just be a question of adding the
> specific server responses needed to exercise the block/nbd.c code paths.

I'll play with the idea. If I can get it working, it would be a bit
stronger than my current approach of documenting a two-line hack patch
to nbd/server.c that will trigger one instance of the behavior, in
that it would be usable in a unit test rather than requiring the
reader to take additional steps to do a one-off build.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


