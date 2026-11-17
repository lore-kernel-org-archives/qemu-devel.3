Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5679E606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 22:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Gvl8zxkm
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTRH4-0004gU-8V; Tue, 17 Nov 2026 17:03:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xTRGt-0004eM-QA
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 17:03:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xTRGo-00025i-1n
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 17:03:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794952995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LoxaZZNoBK6s6TfOz/xNIDDiOVzm7hO+85YiRkgtFF0=;
 b=Gvl8zxkmTI4MaLfXVFHUxSkhfbfBoDHWzy3bMVQqHrLyRY8hxevMqh0NZxw2pmba8UnEy9
 W4hMYlJwThynpesiHap1k9JpAsp/UxmXd6vNsUnI5cXPiRM71VQJwZ9M/+wTZmCvz29wFa
 MPfAgEKLH6dIkhhi20yp1kX/2GGa8+4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-625-y1B8SXeIPXSWlcrHiSvStw-1; Tue,
 17 Nov 2026 17:03:12 -0500
X-MC-Unique: y1B8SXeIPXSWlcrHiSvStw-1
X-Mimecast-MFC-AGG-ID: y1B8SXeIPXSWlcrHiSvStw_1794952991
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 09DEE195609E; Tue, 17 Nov 2026 22:03:10 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EDA241956087; Tue, 17 Nov 2026 22:03:08 +0000 (UTC)
Date: Tue, 17 Nov 2026 17:03:08 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, qemu-stable@nongnu.org, bea1e@proton.me,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH 4/4] nbd: Add iotest exposing previous CVE fix
Message-ID: <20261117220308.GA437212@shajnocz.csb>
References: <20261113223742.2546619-6-eblake@redhat.com>
 <20261113223742.2546619-10-eblake@redhat.com>
 <20261117180601.GA391996@shajnocz.csb>
 <avyskW5PTOANZonw@redhat.com>
 <a9b7112d-c0d3-41f7-9cae-39462ab10a27@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a9b7112d-c0d3-41f7-9cae-39462ab10a27@oss.qualcomm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 17, 2026 at 09:51:12PM +0100, Philippe Mathieu-Daudé wrote:
> On 17/11/26 21:07, Eric Blake wrote:
> > On Tue, Nov 17, 2026 at 01:06:01PM -0500, Stefan Hajnoczi wrote:
> > > On Fri, Nov 13, 2026 at 04:34:52PM -0600, Eric Blake wrote:
> > > > Feifan Qian posted a sample script generated with the help of AI that
> > > > created a known-broken NBD server that intentionally replies to a
> > > > structured read with only a subset of bytes, to expose the leak of
> > > > heap data from qemu as an NBD client into an emulated IDE drive. Take
> > > > the idea of that test, but simplify it into a qemu-io test (much
> > > > lighter-weight NBD client, and easier access to see what bytes the NBD
> > > > client code is passing on) that more closely resembles paradigms in my
> > > > recent nbd-robustness iotest.  Also, expand the test to cover multiple
> > > > scenarios: in addition to the original test demonstrating a prefix of
> > > > 20 bytes with unwritten tail, I expanded it to cover out-of-order
> > > > replies, a hole-only reply, and a completely empty reply.
> > > > 
> > > > Reported-by: Feifan Qian <bea1e@proton.me>
> > > > Based-on: https://gitlab.com/qemu-project/qemu/-/work_items/3815
> > > > AI-used-for: tests
> > > 
> > > QEMU's current AI policy forbids AI-generated code.
> 
> OTOH nobody disagreed with latest policy sent by Paolo
> (https://lore.kernel.org/qemu-devel/20260930085433.830743-1-pbonzini@redhat.com/)
> and Paolo said he'd get it merge during a community call
> (Tuesday, 5 or 6 weeks ago?) so personally I consider it accepted
> and being processed, only delayed. I hope this isn't a problem.

The new policy is not in effect yet. There are maintainers who wanted to
discuss it at QEMU Summit but we ran out of time, so it was deferred to
the next KVM Community Call (November 24th).

If we merge this before there is a consensus, then we are overruling
those who are not in agreement yet. I think it's too early.

Eric: is there a way to implement the tests in
tests/qemu-iotests/nbd-fault-injector.py? At least that already contains
the NBD server logic and it would just be a question of adding the
specific server responses needed to exercise the block/nbd.c code paths.

Stefan


