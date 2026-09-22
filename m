Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E74C6C98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 17:44:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x94Xl-0001HT-PH; Tue, 22 Sep 2026 13:44:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x94Xk-0001HG-2l
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 13:44:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x94Xi-0007vK-5v
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 13:44:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790099073;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YwxwtvbEyg/6LxbJYDBBQ6UR4FrVJ0pzeDTfGC0TqHw=;
 b=CTXV6JiRo6TVhm865uVNawdbt6c2zO20ROcsY5+W7LCMSi/vUe1HJeugvFZLJWp4aJvljN
 6lsln2xBElHY7ZgJ02jvHmH+uw9rT6ik/58YFYSqwdKCNzxNjvBJmEKjl3Xj32qU+4S6Ho
 wu5ajYGTr4Zbs6C7NY5OrhQDnF5CNMI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-264-JdA38L9bOXOntrL_80Cslw-1; Tue,
 22 Sep 2026 13:44:31 -0400
X-MC-Unique: JdA38L9bOXOntrL_80Cslw-1
X-Mimecast-MFC-AGG-ID: JdA38L9bOXOntrL_80Cslw_1790099070
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B36191944AA6; Tue, 22 Sep 2026 17:44:29 +0000 (UTC)
Received: from redhat.com (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 241F91956095; Tue, 22 Sep 2026 17:44:27 +0000 (UTC)
Date: Tue, 22 Sep 2026 18:44:24 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: Re: [PATCH 2/7] tests/docker/dockerfiles: refresh images
Message-ID: <arK-ePCi4xU_4sXo@redhat.com>
References: <20260921231458.3369-1-pierrick.bouvier@oss.qualcomm.com>
 <20260921231458.3369-3-pierrick.bouvier@oss.qualcomm.com>
 <4207d4f8-a452-417f-b240-77cef59b7d54@oss.qualcomm.com>
 <arKywfq6YHXxN8Ch@redhat.com>
 <039cb46b-90ba-40e6-bdb3-9812add2fc44@oss.qualcomm.com>
 <arK8UOJtGSxYpNtf@redhat.com>
 <f2df6883-ee78-48b1-bd03-9b7d41ac2b60@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f2df6883-ee78-48b1-bd03-9b7d41ac2b60@oss.qualcomm.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

On Tue, Sep 22, 2026 at 10:41:38AM -0700, Pierrick Bouvier wrote:
> On 9/22/2026 10:35 AM, Daniel P. Berrangé wrote:
> > On Tue, Sep 22, 2026 at 10:16:27AM -0700, Pierrick Bouvier wrote:
> >> On 9/22/2026 9:54 AM, Daniel P. Berrangé wrote:
> >>> On Tue, Sep 22, 2026 at 09:15:02AM -0700, Pierrick Bouvier wrote:
> >>>> On 9/21/2026 4:14 PM, Pierrick Bouvier wrote:
> >>>>> latest update of libvirt-ci changed packages, but images were not
> >>>>> refreshed.
> >>>>>
> >>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> >>>>> ---
> >>>>>  tests/docker/dockerfiles/debian.docker     | 1 -
> >>>>>  tests/docker/dockerfiles/ubuntu2404.docker | 1 -
> >>>>>  2 files changed, 2 deletions(-)
> >>>>>
> >>>>> diff --git a/tests/docker/dockerfiles/debian.docker b/tests/docker/dockerfiles/debian.docker
> >>>>> index 77869f71546..2d03ff03c8d 100644
> >>>>> --- a/tests/docker/dockerfiles/debian.docker
> >>>>> +++ b/tests/docker/dockerfiles/debian.docker
> >>>>> @@ -73,7 +73,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
> >>>>>                        libpcre2-dev \
> >>>>>                        libpipewire-0.3-dev \
> >>>>>                        libpixman-1-dev \
> >>>>> -                      libpmem-dev \
> >>>>>                        libpng-dev \
> >>>>>                        libpulse-dev \
> >>>>>                        librbd-dev \
> >>>>> diff --git a/tests/docker/dockerfiles/ubuntu2404.docker b/tests/docker/dockerfiles/ubuntu2404.docker
> >>>>> index bb8f4e4e53f..440699a5005 100644
> >>>>> --- a/tests/docker/dockerfiles/ubuntu2404.docker
> >>>>> +++ b/tests/docker/dockerfiles/ubuntu2404.docker
> >>>>> @@ -73,7 +73,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
> >>>>>                        libpcre2-dev \
> >>>>>                        libpipewire-0.3-dev \
> >>>>>                        libpixman-1-dev \
> >>>>> -                      libpmem-dev \
> >>>>>                        libpng-dev \
> >>>>>                        libpulse-dev \
> >>>>>                        librbd-dev \
> >>>>
> >>>> Dropping this patch, as it's incorrect.
> >>>> In libvirt-ci, libpmem-dev is a dependency of targets debian-13 and
> >>>> ubuntu2404, so not sure why it removes it here. Seems like a bug in
> >>>> libvirt-ci itself.
> >>>
> >>> Most likely you ran invoked lcitool from an aarch64 host OS, so it
> >>> filtered out libpmem-dev which is only valid on x86_64 targets.
> >>> The non-cross containers we have defined here are assumed to be
> >>> for x86_64 targets.
> >>>
> >>> We should change the tests/lcitool/refresh script in QEMU to pass
> >>> '--host-arch x86_64' to lcitool, rather than defaulting to the
> >>> developers' machine's arch.
> >>>
> >>
> >> Thanks for the sharing the reason, I'll add this option.
> >>
> >> Out of curiosity, what's the reason to differentiate generation based on
> >> host arch?
> >> Wouldn't that be better to be explicit if you want to generate an arch
> >> specific Dockerfile (and use FROM docker.io/arch/... instead of
> >> docker.io/library)?
> > 
> > I'm not familiar with docker.io/arch/ but this all just grew up
> > organically over time, and since most usage was x86_64 host based
> > there  was not much need to think about other scenarios.
> >
> 
> Basically, it's (official) docker images per arch, following docker
> platform naming:
> - docker.io/amd64
> - docker.io/aarch64
> 
> https://github.com/docker-library/official-images#architectures-other-than-amd64
> 
> Advantage is that image are provided for a specific platform, which
> avoid some of the issue multi plaform images have.
> 
> For instance, on aarch64 host:
> $ podman run --platform linux/amd64 docker.io/library/debian:latest true
> $ podman run docker.io/library/debian:latest true
> WARNING: image platform (linux/amd64) does not match the expected
> platform (linux/arm64)
> # podman/docker now select the amd64 version by default, which can break
> build of other containers. It's a design issue with docker cli IMHO.
> 
> > If we want the tests/docker/dockerfiles to be portable to non-x86
> > hosts, then we'd need to either have many dockerfiles there for
> > each arch, or drop packages that are arch specific from the
> > install list.
> >
> 
> I'll add the --host-arch x86_64 option to lcitool as recommended, which
> should be enough for our need.

Hmm, I think we also need '--arch x86_64' passed to 'docker build' for
similar reasons, since the dockerfile input to the build has an
arch specific list of packages.


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


