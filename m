Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72BB8CA9ED2
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 08:19:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGBFE-0008Au-84; Mon, 12 Oct 2026 04:18:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xGBF8-0008A0-0S
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 04:18:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xGBF5-0007hd-5E
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 04:18:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791793121;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=j98UjrZjGxroq8F40OWv85k12KN5ST6ORaoCWzOJotU=;
 b=Bh1qlQQ7uM1LpapHORtwPJJ3kCwrh7A4bqkD2lVnBNUd1IlKKNesEdAyJ8hFZ1grwfTPgi
 NdDbtxcN9O7HXIZ/ahZecyi5GjrJ46Hjf8k1UPX9w1pUTWLiArmgi6FGMK2ha09sbvwEAC
 Y+MSe7Hege+KMdteCmHuRPyuL1ptDeA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-127-b3e3wBmWOzS46CLrh0Lhjw-1; Mon,
 12 Oct 2026 08:18:36 +0000
X-MC-Unique: b3e3wBmWOzS46CLrh0Lhjw-1
X-Mimecast-MFC-AGG-ID: b3e3wBmWOzS46CLrh0Lhjw_1791793109
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 01B5C1955DA6; Mon, 12 Oct 2026 08:18:29 +0000 (UTC)
Received: from redhat.com (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B49D118002B6; Mon, 12 Oct 2026 08:18:27 +0000 (UTC)
Date: Mon, 12 Oct 2026 09:18:24 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, mjt@tls.msk.ru
Subject: Re: [RFC] container images for migration-test
Message-ID: <asyX0JccFfG0ZMDp@redhat.com>
References: <8733vbtmge.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8733vbtmge.fsf@suse.de>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Sep 14, 2026 at 08:58:09PM -0300, Fabiano Rosas wrote:
> Hi, I just wanted to share and ask for feedback on some container images
> I've been building as part of my testing of migration pull-requests.
> 
> From a Dockerfile from ./tests/docker/dockerfiles/ I'm producing the
> following:
> 
> $ docker images
> qemu-build-base:11.0.0                        b6efa198e93a        5.8GB
> qemu-rootfs-base:11.0.0                       72bcb5418f4d       4.08GB
> qemu:11.0.0                                   018a3f0f4dcc          2GB

snip

> 2) Neither the QEMU build nor the distro repos are reliable enough to
> allow me to just "go back in time" and rebuild at any moment, I need to
> keep the artifacts cached to avoid rebuilding. Otherwise it comes time
> to send a PR and I discover that some python piece has changed or the
> distro messed up the older repository.

Yes, in general building old QEMU on new distros periodically
hits trouble.  If building old QEMU, better reliability is
achieved by using a distro release that was from the same
timeframe as QEMU.  Is using containers targetting such old
distro versions not an option ? The tests/docker/dockerfiles
from the old QEMU branch ought to work ?

Our stable release branches have the same needs, and their
CI is using the container images from the old branches.

How far back in time do you need/want to go for migration
testing ?  Is it sufficient to merely target versions for
which mjt is still doing active maint work, so we can
expect the containers to still work.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


