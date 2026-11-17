Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1659D606A32A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 20:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NyeccDvU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTPTG-0005aH-9A; Tue, 17 Nov 2026 15:08:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xTPTD-0005ZW-M3
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 15:07:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xTPTB-0006MB-AZ
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 15:07:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794946076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OLhSypA3dNpyR6u5+cKPFQM4muPa2DlrPiIEbxuei00=;
 b=NyeccDvUfzcKG+jP29AGkT0OpJd+r5E8gUToANk54pHW+4Q8rlgXDhE6vn7YtQNwV83DtF
 rYtdqTVjBLZP+A2YXx/SI9WSecYfBvE53oKKhCSjvtYBzcr46wfLmWWuW67yx+wAcftc4Y
 yBCJSAPc/fahHWPfL4DxRTc3sFtGAMY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-275-u7Y5mzi1NrK6UARuIHPObw-1; Tue,
 17 Nov 2026 15:07:52 -0500
X-MC-Unique: u7Y5mzi1NrK6UARuIHPObw-1
X-Mimecast-MFC-AGG-ID: u7Y5mzi1NrK6UARuIHPObw_1794946071
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0690519560AD; Tue, 17 Nov 2026 20:07:51 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 52BB718004FC; Tue, 17 Nov 2026 20:07:46 +0000 (UTC)
Date: Tue, 17 Nov 2026 14:07:43 -0600
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-stable@nongnu.org, 
 bea1e@proton.me, Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH 4/4] nbd: Add iotest exposing previous CVE fix
Message-ID: <avyskW5PTOANZonw@redhat.com>
References: <20261113223742.2546619-6-eblake@redhat.com>
 <20261113223742.2546619-10-eblake@redhat.com>
 <20261117180601.GA391996@shajnocz.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261117180601.GA391996@shajnocz.csb>
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
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 17, 2026 at 01:06:01PM -0500, Stefan Hajnoczi wrote:
> On Fri, Nov 13, 2026 at 04:34:52PM -0600, Eric Blake wrote:
> > Feifan Qian posted a sample script generated with the help of AI that
> > created a known-broken NBD server that intentionally replies to a
> > structured read with only a subset of bytes, to expose the leak of
> > heap data from qemu as an NBD client into an emulated IDE drive. Take
> > the idea of that test, but simplify it into a qemu-io test (much
> > lighter-weight NBD client, and easier access to see what bytes the NBD
> > client code is passing on) that more closely resembles paradigms in my
> > recent nbd-robustness iotest.  Also, expand the test to cover multiple
> > scenarios: in addition to the original test demonstrating a prefix of
> > 20 bytes with unwritten tail, I expanded it to cover out-of-order
> > replies, a hole-only reply, and a completely empty reply.
> > 
> > Reported-by: Feifan Qian <bea1e@proton.me>
> > Based-on: https://gitlab.com/qemu-project/qemu/-/work_items/3815
> > AI-used-for: tests
> 
> QEMU's current AI policy forbids AI-generated code.

This tag is based on the ongoing discussion about AGENTS.md and
code-provenance.rst:

https://lists.gnu.org/archive/html/qemu-devel/2026-09/msg09158.html
https://lists.gnu.org/archive/html/qemu-devel/2026-10/msg00110.html
(and elsewhere)

At present, as of commit 1915e810d, use of AI-assisted unit tests is
still not approved for upstream.  And it appears that I started
writing this patch before that AGENTS.md change landed, because with
that patch in place, my LLM should have tried harder to dissuade me
from posting.

I agree that my starting point of Feifan's reproduction script, which
already documented AI assistance, already puts this patch on shaky
ground, no matter how much or little else I further did with an LLM
while polishing it into a more complete test (while I can attest to
understanding every line of this patch and am not blindly trusting AI
output, I genuinely cannot state that the patch is free from AI
influence, despite the differences between here and the original
reproduction script on gitlab).  Therefore, I agree that this patch
cannot be applied until that discussion results in an upstream patch.

I don't know of any other easy way to prove that the CVE is fixed;
nbdkit does not support out-of-order structured read replies, and
intentionally writing a known-non-compliant NBD server is grunt
work. In the past, when fixing NBD protocol corner cases in QEMU, I
have resorted to including reproduction instructions that could not be
easily automated into unit tests to instead occur as part of the
commit message in the form of a quoted patch that could be applied to
QEMU - certainly not as automatable, but still strengthens the power
of the git log (see commit 6e280648, for an example), and something I
am capable of doing without LLM assistance.  For the sake of getting
the CVE fix into the 11.2 release, I could repeat that framework:
amend patch 3/4 to call out more detailed instructions on how to patch
QEMU into behaving as a triggering known-broken server, do a pull
request on just 1-3, and omit patch 4/4 entirely (saving it for a
future day when our LLM policy is relaxed).

> 
> > Signed-off-by: Eric Blake <eblake@redhat.com>
> > ---
> >  .../tests/nbd-structured-read-gaps            | 215 ++++++++++++++++++
> >  .../tests/nbd-structured-read-gaps.out        |   5 +
> >  2 files changed, 220 insertions(+)
> >  create mode 100755 tests/qemu-iotests/tests/nbd-structured-read-gaps
> >  create mode 100644 tests/qemu-iotests/tests/nbd-structured-read-gaps.out
> > 
> > diff --git a/tests/qemu-iotests/tests/nbd-structured-read-gaps b/tests/qemu-iotests/tests/nbd-structured-read-gaps
> > new file mode 100755
> > index 00000000000..9f8b3b8b20b
> > --- /dev/null
> > +++ b/tests/qemu-iotests/tests/nbd-structured-read-gaps
> > @@ -0,0 +1,215 @@
> > +#!/usr/bin/env python3
> > +# group: rw quick
> 
> Does this run in CI without the "auto" group?

Huh. It looks like I based my template on a copy-and-paste of
tests/qemu-nbd-snapshots (lacks "auto") rather than tests/nbd-commands
or tests/nbd-robustness (include "auto"). I agree that "auto" makes
sense here; the test completes in less than half a second.  Not sure
if that means qemu-nbd-snapshots should be updated as a separate
patch.

But that doesn't matter for 11.2, since this patch needs to be
excluded until LLM policy changes, and my proposed workaround does not
affect the qemu-iotests directory at this time.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


