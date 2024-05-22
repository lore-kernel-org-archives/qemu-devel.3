Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9D71C25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 10:47:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9jUl-0006xu-T4; Wed, 22 May 2024 06:46:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s9jUk-0006xe-7b
 for qemu-devel@nongnu.org; Wed, 22 May 2024 06:46:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s9jUg-0002c8-7N
 for qemu-devel@nongnu.org; Wed, 22 May 2024 06:46:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716374808;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/vrNWhv3di+AZTlhGSGrdutmlKZ4lTvIbzE9ckgMDyg=;
 b=VRaE0b2ikVNxVxn9EEsH99Ulg14rljgqJ187j0R+CYqoQ3B/n4+8/6AeLyPIDsULKLvNq2
 /VZ5nEtaBZiork7vjJ7G+D5zVOQbizmQuchPetZhl3IULDOh4F+fTgbiD0C/SGQciX2Rh4
 mV61XDgFJs6CAJWjIY4bP5WxsHyslSo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-TQ0hVMbiM1yoMyGDgOirkg-1; Wed, 22 May 2024 06:46:44 -0400
X-MC-Unique: TQ0hVMbiM1yoMyGDgOirkg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6000B101A525;
 Wed, 22 May 2024 10:46:44 +0000 (UTC)
Received: from redhat.com (dhcp-17-234.lcy.redhat.com [10.42.17.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 58DB640C6CB4;
 Wed, 22 May 2024 10:46:43 +0000 (UTC)
Date: Wed, 22 May 2024 11:46:40 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Camilla Conte <cconte@redhat.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, alex.bennee@linaro.org
Subject: Re: [PATCH] gitlab-ci: Replace Docker with Kaniko
Message-ID: <Zk3NEOD_PrQr2Q2z@redhat.com>
References: <20240516165410.28800-3-cconte@redhat.com>
 <ZkZPRILIqoyGbdEk@redhat.com> <ZkcR4_cQzl-LjcjC@redhat.com>
 <CACPOWh0ZLNMtkPT6Q9KJPGwVzqGxoE+n=gZ=d6_3Ke6Ndtya5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACPOWh0ZLNMtkPT6Q9KJPGwVzqGxoE+n=gZ=d6_3Ke6Ndtya5Q@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
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

On Mon, May 20, 2024 at 05:56:46PM +0100, Camilla Conte wrote:
> On Fri, May 17, 2024 at 9:14 AM Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > On Thu, May 16, 2024 at 07:24:04PM +0100, Daniel P. Berrangé wrote:
> > > On Thu, May 16, 2024 at 05:52:43PM +0100, Camilla Conte wrote:
> > > > Enables caching from the qemu-project repository.
> > > >
> > > > Uses a dedicated "$NAME-cache" tag for caching, to address limitations.
> > > > See issue "when using --cache=true, kaniko fail to push cache layer [...]":
> > > > https://github.com/GoogleContainerTools/kaniko/issues/1459
> > >
> > > After investigating, this is a result of a different design approach
> > > for caching in kaniko.
> > >
> > > In docker, it can leverage any existing image as a cache source,
> > > reusing individual layers that were present. IOW, there's no
> > > difference between a cache and a final image, they're one and the
> > > same thing
> > >
> > > In kaniko, the cache is a distinct object type. IIUC, it is not
> > > populated with the individual layers, instead it has a custom
> > > format for storing the cached content. Therefore the concept of
> > > storing the cache at the same location as the final image, is
> > > completely inappropriate - you can't store two completely different
> > > kinds of content at the same place.
> > >
> > > That is also why you can't just "git pull" the fetch the cache
> > > image(s) beforehand, and also why it doesn't look like you can
> > > use multiple cache sources with kaniko.
> > >
> > > None of this is inherantly a bad thing..... except when it comes
> > > to data storage. By using Kaniko we would, at minimum, doubling
> > > the amount of data storage we consume in the gitlab registry.
> >
> > Double is actually just the initial case. The cache is storing layers
> > using docker tags, whose name appears based on a hash of the "RUN"
> > command.
> >
> > IOW, the first time we build a container we have double the usage.
> > When a dockerfile is updated changing a 'RUN' command, we now have
> > triple the storage usage for cache. Update the RUN command again,
> > and we now have quadruple the storage. etc.
> >
> > Kaniko does not appear to purge cache entries itself, and will rely
> > on something else to do the cache purging.
> >
> > GitLab has support for purging old docker tags, but I'm not an
> > admin on the QEMU project namespace, so can't tell if it can be
> > enabled or not ? Many older projects have this permanently disabled
> > due to historical compat issues in gitlab after they introduced the
> > feature.
> 
> I'm pretty sure purging can be enabled. Gitlab itself proposes this
> with a "set up cleanup" link on the registry page (1).
> Can you recall what issues they were experiencing?

Looks like they may have finally fixed the issue in gitlab. They have
previously blocked cleanup on all repositories older than a certain
date

> If this is the only issue blocking Kaniko adoption, and we can't solve
> it by enabling the cleanup, I can write an additional step at the end
> of the container build to explicitly remove old cache tags.

Cleanup stops the container usage growing without bound, but switching
to Kaniko will still double our long term storage usage which is pretty
undesirable IMHO.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


