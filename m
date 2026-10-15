Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB9B9CC6B34
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 07:18:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHFj1-0001UH-PC; Thu, 15 Oct 2026 03:18:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xHFie-0001Tr-9D
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 03:17:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xHFia-0001RE-A3
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 03:17:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792048654;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aWcwU7ghXwqpV4s637PgKen4najmWKgsN+j0T5g+eZE=;
 b=fOkVwUzDDwk4hlqwWWgNGgw+WD/ivfu72ixeE2ZN/5IAFf3GF6ADyws281yoyPhckUwUCc
 DAPPGZqGmU2QKI1kMjAzSXiJuq8NVqM1oojQ/yXhEycK8AbQp/n3e/xRvMdVEE6UKn/V6B
 rLvu7rPL+y/SqNUgOU2yDb/ZVadjan0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-65-whC83AXGMViDnPsYOr-_4w-1; Thu,
 15 Oct 2026 07:17:30 +0000
X-MC-Unique: whC83AXGMViDnPsYOr-_4w-1
X-Mimecast-MFC-AGG-ID: whC83AXGMViDnPsYOr-_4w_1792048649
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 530371956055; Thu, 15 Oct 2026 07:17:29 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A036F1956089; Thu, 15 Oct 2026 07:17:26 +0000 (UTC)
Date: Thu, 15 Oct 2026 08:17:23 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, mjt@tls.msk.ru
Subject: Re: [RFC] container images for migration-test
Message-ID: <atB-A09ZuRod1Qvo@redhat.com>
References: <8733vbtmge.fsf@suse.de> <asyX0JccFfG0ZMDp@redhat.com>
 <87jynkmaht.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87jynkmaht.fsf@suse.de>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

On Wed, Oct 14, 2026 at 02:56:46PM -0300, Fabiano Rosas wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Mon, Sep 14, 2026 at 08:58:09PM -0300, Fabiano Rosas wrote:
> >> Hi, I just wanted to share and ask for feedback on some container images
> >> I've been building as part of my testing of migration pull-requests.
> >> 
> >> From a Dockerfile from ./tests/docker/dockerfiles/ I'm producing the
> >> following:
> >> 
> >> $ docker images
> >> qemu-build-base:11.0.0                        b6efa198e93a        5.8GB
> >> qemu-rootfs-base:11.0.0                       72bcb5418f4d       4.08GB
> >> qemu:11.0.0                                   018a3f0f4dcc          2GB
> >
> > snip
> >
> >> 2) Neither the QEMU build nor the distro repos are reliable enough to
> >> allow me to just "go back in time" and rebuild at any moment, I need to
> >> keep the artifacts cached to avoid rebuilding. Otherwise it comes time
> >> to send a PR and I discover that some python piece has changed or the
> >> distro messed up the older repository.
> >
> > Yes, in general building old QEMU on new distros periodically
> > hits trouble.  If building old QEMU, better reliability is
> > achieved by using a distro release that was from the same
> > timeframe as QEMU.  Is using containers targetting such old
> > distro versions not an option ? The tests/docker/dockerfiles
> > from the old QEMU branch ought to work ?
> >
> 
> Yes, I'm doing just that. Some tweaks are needed still. For instance, my
> script has something like this:
> 
>   dockerfile="tests/docker/dockerfiles/opensuse-leap.docker"
> 
>   sed -i 's/ncurses-devel//' $dockerfile
> 
>   if [ "$tag" = "10.1.0" ]; then
>       sed -i 's/libLLVM19//' $dockerfile
>   fi

If that's needed, shouldn't we patch the QEMU stable branch ? I
would have thought that would be a problem for doing releases on
stable if the containers have bugs ?

> > How far back in time do you need/want to go for migration
> > testing ?  Is it sufficient to merely target versions for
> > which mjt is still doing active maint work, so we can
> > expect the containers to still work.
> >
> 
> I'm currently testing against the previous 3 releases. I think 2
> releases is probably enough.

I guess if we test   X -> Y and then later test Y -> Z, then
we have transitively validated X -> Z. So in theory only 1
historical release is enough, but it makes sense to test one
or two more variants just in case.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


