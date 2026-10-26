Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5822A606A323
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 10:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=E1dzCyF5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLHie-0008QQ-Bf; Mon, 26 Oct 2026 06:14:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xLHiA-0008EJ-L7
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 06:13:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xLHi8-0001Wm-Ql
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 06:13:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793009620;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=he6mgqS33TQnDoif1Kt4q2LF8rqUV12F5eRaK9f0MlI=;
 b=E1dzCyF56yocvC1/ZCcycyDoP2sn5PHX1Jqeposc5vPbFd/H3TWX3ZgVWNv00uaJSi/3j7
 XvNw9X89mI1a8lNLCmHnk+s7qKwuQKGDm0IHhFEdd+BooZlgUt9KpnkU7tDQ8qsBMSU+Iu
 uTS6d/htBxuOQQhYXLZFlgZmhO5QNVo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-NL7GJa1ZNVGW7CFsGlUCqg-1; Mon,
 26 Oct 2026 06:13:32 -0400
X-MC-Unique: NL7GJa1ZNVGW7CFsGlUCqg-1
X-Mimecast-MFC-AGG-ID: NL7GJa1ZNVGW7CFsGlUCqg_1793009611
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8C2E81955E80; Mon, 26 Oct 2026 10:13:30 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 53369362; Mon, 26 Oct 2026 10:13:29 +0000 (UTC)
Date: Mon, 26 Oct 2026 10:13:26 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Stefan Weil via qemu development <qemu-devel@nongnu.org>,
 Stefan Weil <sw@weilnetz.de>
Subject: Re: OSS Scanner service (Anthropic)
Message-ID: <at8nxm91RmA-hBvj@redhat.com>
References: <53658828-9693-4235-9ffa-53f391dafc81@weilnetz.de>
 <87ik2pmvet.fsf@draig.linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ik2pmvet.fsf@draig.linaro.org>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Oct 25, 2026 at 07:28:58PM +0000, Alex Bennée wrote:
> Stefan Weil via qemu development <qemu-devel@nongnu.org> writes:
> 
> > Dear all,
> >
> > citing https://github.com/anthropics/oss-scanner:
> >
> > "OSS Scanner is a service by Anthropic to scan critical open-source
> > repositories for security vulnerabilities".
> >
> > Unless QEMU maintainers already have access to the best available AI
> > models, this might be a good chance to get such access. I think that
> > QEMU matches the required criteria.
> 
> There have been offers from re-sellers but they main issue is what would
> we do with even more bugs? Are they offering to do the triage work and
> filter out the non-virt use case bugs and search for duplicated already
> in the bug tracker?
> 
> I don't doubt they can find more bugs - but do we have the maintainer
> bandwidth to deal with them? Is anyone volunteering to take on the
> fire-hose?

More bug reports to triage is a problem we absolutely do not need
to inflict on ourselves. We have no shortage of AI assisted bug
reports in our backlog right now that are being ignored due to
a severe lack of both maintainer time  and interest.


The only place I think we could fit in a new scanning capability
is in new patches on qemu-devel, such that the patch author is the
only person who will read and act on the feedback. ie so that the
project maintainers don't take on an additional burden.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


