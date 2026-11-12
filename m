Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70B2606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 19:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Q5r9ay7b
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRaSs-00080w-Mj; Thu, 12 Nov 2026 14:28:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xRaSm-0007n4-BM
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 14:28:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xRaSj-0001mz-Dj
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 14:28:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794511675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6Ln+3rHXhe96toXBsJ9VSd5cB5abaXVyNWYtmM1nLY0=;
 b=Q5r9ay7bQq14bSU00CgLnyOu5We2xSFUk//KJkOxdaGIIqEtt5aLv7qc7Ca9mPAbtkkh4P
 SA5J9I5qUxvbiLjQuzoGQnvHPznCmVky0SOAcLVBeBJFx1FMY6rW4GwA0sjxBQh/KJKYnN
 RJsYdkOvTaqXTUlBLQFxJpissfR9T/c=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-19-3ZiMLRK2PdqMIzKx9hCaTQ-1; Thu,
 12 Nov 2026 14:27:52 -0500
X-MC-Unique: 3ZiMLRK2PdqMIzKx9hCaTQ-1
X-Mimecast-MFC-AGG-ID: 3ZiMLRK2PdqMIzKx9hCaTQ_1794511671
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1DD0618004DB; Thu, 12 Nov 2026 19:27:51 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3D1FB18004F7; Thu, 12 Nov 2026 19:27:49 +0000 (UTC)
Date: Thu, 12 Nov 2026 13:27:46 -0600
From: Eric Blake <eblake@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>, 
 guillaume.vincke@ovhcloud.com, armbru@redhat.com
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 0/8] NBD patches through 2026-11-10
Message-ID: <avYRrN7--EID31IM@redhat.com>
References: <20261111035200.1751734-10-eblake@redhat.com>
 <820539b6-d161-43ff-8889-cb40c1ecc6f2@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <820539b6-d161-43ff-8889-cb40c1ecc6f2@linaro.org>
User-Agent: NeoMutt/20260616
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 12, 2026 at 11:16:24AM -0700, Richard Henderson wrote:
> On 11/10/26 19:51, Eric Blake wrote:
> > The following changes since commit 723622bedb0b423de7d1c61ebbe6e7a71934949c:
> > 

> > A few bug fixes:
> > - Guillaume Vincke: improve connection retry if NBD client hangs up quickly
> > - Eric Blake: fix two low-severity CVEs with non-compliant NBD clients
> 
> New failure:
> 
> https://gitlab.com/qemu-project/qemu/-/jobs/17979973534#L298
> 
> 137/150 block-qcow2-optional+block-slow - qemu:io-qcow2-nbd-stale-connection
> FAIL             2.37s exit status 1
> 
> {"error": {"class": "GenericError", "desc": "write failed: Input/output
> error"}}

Shoot - looks like this hit the CI timeout despite our best efforts,
which is why Guillaume is working on a second series for making the
test more robust [1], although our initial take was that it is really
late in the 11.2 cycle to be adding a new x-debug- QMP command. I can
respin the pull request to drop the test and/or give it a longer
timeout so it is less likely to be flaky in CI.

[1] https://lists.gnu.org/archive/html/qemu-devel/2026-11/msg01941.html

Markus, what are your thoughts on a QMP addition this late into 11.2
so that the test in 2/8 can be stable? I'm torn on whether the NBD bug
in 1/8 is severe enough to need to go in 11.2.0 proper, or whether the
bug is weak enough that it is safer to wait until 11.2.1 via the
qemu-stable process.  Patches 3-8 fix CVEs, so they definitely belong
in 11.2.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


