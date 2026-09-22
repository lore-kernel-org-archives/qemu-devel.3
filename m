Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB0A7C982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 16:55:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x93mD-0002Fc-Ko; Tue, 22 Sep 2026 12:55:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x93lQ-0000on-QY
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 12:54:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x93lM-0002wG-Rq
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 12:54:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790096074;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=lkCQAeK7IEEO9iP5LA3uhiRp8OqiYKMEdHk2QKMfdyE=;
 b=P8cnkYO4QYCFxBsV+dEo15GVSBHVUmHne19mcX31+HwGOq2cvq/TNlAUOmsxwE6ihiaqKa
 Y8nG8I6+qZakfK7zxjAt0IB4JJRvSm67cIbwszdZhUWc4lVJYs4od3x1nuRvsROqKAkc7r
 8Uqqq2dD9JGqwRULbnJDtEYPKGsoTiw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-365-bzvj2fjgPiOzcusuz-_oTA-1; Tue,
 22 Sep 2026 12:54:32 -0400
X-MC-Unique: bzvj2fjgPiOzcusuz-_oTA-1
X-Mimecast-MFC-AGG-ID: bzvj2fjgPiOzcusuz-_oTA_1790096070
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E94C2195C247; Tue, 22 Sep 2026 16:54:29 +0000 (UTC)
Received: from redhat.com (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5738130001B9; Tue, 22 Sep 2026 16:54:28 +0000 (UTC)
Date: Tue, 22 Sep 2026 17:54:25 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: Re: [PATCH 2/7] tests/docker/dockerfiles: refresh images
Message-ID: <arKywfq6YHXxN8Ch@redhat.com>
References: <20260921231458.3369-1-pierrick.bouvier@oss.qualcomm.com>
 <20260921231458.3369-3-pierrick.bouvier@oss.qualcomm.com>
 <4207d4f8-a452-417f-b240-77cef59b7d54@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4207d4f8-a452-417f-b240-77cef59b7d54@oss.qualcomm.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Sep 22, 2026 at 09:15:02AM -0700, Pierrick Bouvier wrote:
> On 9/21/2026 4:14 PM, Pierrick Bouvier wrote:
> > latest update of libvirt-ci changed packages, but images were not
> > refreshed.
> > 
> > Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> > ---
> >  tests/docker/dockerfiles/debian.docker     | 1 -
> >  tests/docker/dockerfiles/ubuntu2404.docker | 1 -
> >  2 files changed, 2 deletions(-)
> > 
> > diff --git a/tests/docker/dockerfiles/debian.docker b/tests/docker/dockerfiles/debian.docker
> > index 77869f71546..2d03ff03c8d 100644
> > --- a/tests/docker/dockerfiles/debian.docker
> > +++ b/tests/docker/dockerfiles/debian.docker
> > @@ -73,7 +73,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
> >                        libpcre2-dev \
> >                        libpipewire-0.3-dev \
> >                        libpixman-1-dev \
> > -                      libpmem-dev \
> >                        libpng-dev \
> >                        libpulse-dev \
> >                        librbd-dev \
> > diff --git a/tests/docker/dockerfiles/ubuntu2404.docker b/tests/docker/dockerfiles/ubuntu2404.docker
> > index bb8f4e4e53f..440699a5005 100644
> > --- a/tests/docker/dockerfiles/ubuntu2404.docker
> > +++ b/tests/docker/dockerfiles/ubuntu2404.docker
> > @@ -73,7 +73,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
> >                        libpcre2-dev \
> >                        libpipewire-0.3-dev \
> >                        libpixman-1-dev \
> > -                      libpmem-dev \
> >                        libpng-dev \
> >                        libpulse-dev \
> >                        librbd-dev \
> 
> Dropping this patch, as it's incorrect.
> In libvirt-ci, libpmem-dev is a dependency of targets debian-13 and
> ubuntu2404, so not sure why it removes it here. Seems like a bug in
> libvirt-ci itself.

Most likely you ran invoked lcitool from an aarch64 host OS, so it
filtered out libpmem-dev which is only valid on x86_64 targets.
The non-cross containers we have defined here are assumed to be
for x86_64 targets.

We should change the tests/lcitool/refresh script in QEMU to pass
'--host-arch x86_64' to lcitool, rather than defaulting to the
developers' machine's arch.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


