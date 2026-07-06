Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DB20C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 08:35:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgemq-0000UN-9Q; Mon, 06 Jul 2026 04:34:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wgemW-0000T2-25
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 04:34:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wgemT-0001YE-SD
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 04:34:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783326859;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8UmRhaam1+7TH55HktysOnOATyaFD2mWte7lzI5Bizc=;
 b=FMwbpTgJCZBgvcE0r1v2iOceQVaCOC681sa3c81wT1KRxl7fnjsPQ/V45nOKtLCOljGPkV
 HMUI2pXVBNhUkM27h/rjnflHG86wz29CvRYdHMrybi1aQdu7ztIcaDzI+DOIzYMDZN+cuX
 CoFKhvO2fBSHUfL8Uo4bcoL+R5oF4rM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-694-PelmYhZ4MU-cpJKKsNVAww-1; Mon,
 06 Jul 2026 04:34:16 -0400
X-MC-Unique: PelmYhZ4MU-cpJKKsNVAww-1
X-Mimecast-MFC-AGG-ID: PelmYhZ4MU-cpJKKsNVAww_1783326855
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F2E9D1955F10; Mon,  6 Jul 2026 08:34:14 +0000 (UTC)
Received: from redhat.com (unknown [10.44.48.165])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 36C8E1956096; Mon,  6 Jul 2026 08:34:12 +0000 (UTC)
Date: Mon, 6 Jul 2026 09:34:09 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>
Subject: Re: docker-image-debian-all-test-cross errors
Message-ID: <aktogcyff5Xinh5X@redhat.com>
References: <4b08f4e2-2274-409a-86d8-469c73e21579@linaro.org>
 <7e3536cd-8f02-420c-a85d-3cc027fcd660@ilande.co.uk>
 <f5df268a-cc86-4a8a-aa5b-91c005244a2a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f5df268a-cc86-4a8a-aa5b-91c005244a2a@linaro.org>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Sat, Jul 04, 2026 at 09:41:34PM -0700, Richard Henderson wrote:
> On 7/4/26 14:41, Mark Cave-Ayland wrote:
> > On 04/07/2026 22:20, Richard Henderson wrote:
> > 
> > > Has anyone else been seeing
> > > 
> > > Error: Failed to fetch
> > > http://deb.debian.org/debian/pool/main/d/dpkg/libdpkg-
> > > perl_1.22.21_all.deb  404  Not Found [IP: 151.101.22.132 80]
> > > Error: Failed to fetch
> > > http://deb.debian.org/debian/pool/main/d/dpkg/dpkg-
> > > dev_1.22.21_all.deb  404  Not Found [IP: 151.101.22.132 80]
> > > Error: Failed to fetch
> > > http://deb.debian.org/debian/pool/main/p/python3.13/
> > > libpython3.13_3.13.5-2_amd64.deb  404 Not Found [IP: 151.101.22.132
> > > 80]
> > > Error: Failed to fetch
> > > http://deb.debian.org/debian/pool/main/g/glibc/libc6-
> > > i386_2.41-12_amd64.deb  404  Not Found [IP: 151.101.22.132 80]
> > > Error: Unable to fetch some archives, maybe run apt-get update or try with --fix- missing?
> > > Error: building at STEP "RUN DEBIAN_FRONTEND=noninteractive
> > > eatmydata   apt install - y --no-install-recommends   clang 
> > > dpkg-dev  gdb-multiarch  libclang-rt-dev": while running runtime:
> > > exit status 100
> > > make: *** [/home/rth/qemu/src/tests/docker/Makefile.include:43:
> > > docker-image-debian- all-test-cross] Error 100
> > > 
> > > This has been consistently failing for me for a couple of weeks...
> > > 
> > > r~
> > 
> > I wonder if docker build has cached the existing layers, and since
> > apt-get update only runs in the first part of the Dockerfile then the
> > subsequent layers try to access an old base image?
> > 
> > Does running "docker builder prune" (possibly with --all) help at all?
> > That should purge the cache and force docker to rebuild all the layers
> > again.
> 
> No, it doesn't.

Note QEMU will preferentially to use 'podman' if both docker and
podman are installed. So 'docker builder prune' might be purging
the wrong cache.  Try 'podman builder prune', or manually run
"podman pull docker.io/library/debian:13-slim" to force refresh
the base image.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


