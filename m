Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2A6606A31D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 12:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eXZ7kvcr
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMPiN-0001X5-I1; Thu, 29 Oct 2026 08:58:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xMPiL-0001Wj-9j
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 08:58:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xMPiH-0004CY-T6
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 08:58:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793278716;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=JQ0q04NoNNCNnnLywa+thDUYBJ8kmQX5rheXmRj20zg=;
 b=eXZ7kvcrYZe14GrA8/HrudNfk9hC2Wi4Rl+8Myc167UL5iY37tWsDUTrSSJYRVluXgMwZJ
 zuCq5Nh2x5Wn+2Db27T7wmFbiwJsE59fTIfN5tNVN9idXHWpPHnWrOH9gnPVzYyArCWmPE
 owSvOwbTvtREuo7Tu87Et/kvugeT/VU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-465-NUBPsBV-OCqTrNn2jWHXcQ-1; Thu,
 29 Oct 2026 08:58:34 -0400
X-MC-Unique: NUBPsBV-OCqTrNn2jWHXcQ-1
X-Mimecast-MFC-AGG-ID: NUBPsBV-OCqTrNn2jWHXcQ_1793278713
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 885A6180136B; Thu, 29 Oct 2026 12:58:33 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9B5A71971E4C; Thu, 29 Oct 2026 12:58:32 +0000 (UTC)
Date: Thu, 29 Oct 2026 12:58:29 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alistair <alistair@alistair23.me>
Cc: qemu-devel@nongnu.org
Subject: Re: QEMU Sashiko
Message-ID: <auNC9VZJrkHwH4Tm@redhat.com>
References: <bfacc761620e29347af03f3b613c6c877b4c1862.camel@alistair23.me>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bfacc761620e29347af03f3b613c6c877b4c1862.camel@alistair23.me>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 GB_FAKE_RF=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 09:32:12AM +1000, Alistair wrote:
> Hey,
> 
> Sashiko just merged initial support for QEMU [1].

snip

> So, now that Sashiko also supports QEMU there are two exciting use
> cases:
> 
> 1. Developers can run it locally to review their patches before sending
> them to the list. This can catch issues before sending patches
> 
> 2. Maintainers can run an instance to review patches. How you set this
> up depends on the maintainer and how many tokens you have. Pointing it
> at the list directly and running it for all patches might be too much,
> but some combination of manually triggering it for certain patches
> seems to work well. The Settings.toml file can be setup based on what
> you want to do.
> 
> The hope with this is to save maintainers time as Sashiko can catch
> issues without requiring much time from a maintainer.
> 
> QEMU support in Sashiko is very new, so it will take some tweaking to
> improve things, but it is at least a good starting place.
> 
> 1:
> https://github.com/sashiko-dev/sashiko/commit/e432036bba7ab10d4517385916e6c834d8176f70

This has added a large set of documents about QEMU's internals to a
3rd party repository. Is there not a way to have Sashiko acquire
all the review policies from qemu.git directly ?

IMHO, the QEMU project/maintauners really ought to own & update review
guidelines directly in our repo, especially as we're already intending
to add lots of relevant information to qemu.git for AI usage in general.


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


