Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACDA8C04FFE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2024 08:15:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7sjo-0004H8-SU; Fri, 17 May 2024 04:14:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s7sjl-0004Gx-Vs
 for qemu-devel@nongnu.org; Fri, 17 May 2024 04:14:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s7sjd-0001i2-KK
 for qemu-devel@nongnu.org; Fri, 17 May 2024 04:14:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715933676;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O6HjC9C89kj/K6Q2dY9mKtoSO8tEjpifIZjvaE6RY98=;
 b=XOSdG3mvtsHpiBlhz4Z6C+P96fsaVUssT73WoZGna6IcUdBT4gDyRqml/bdfnEAR5WmZD2
 Z+buaSLLo2Gij231K83jcwmaosGLyXCtG6nEBvBrCUe88vDlWjGKwSpuFokOAcYE5QVRfv
 kMoSbSebHRyhDX21ygLS9OLzlr2rEes=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-dkx-vkeiNjaKLH7Du0lOWw-1; Fri,
 17 May 2024 04:14:30 -0400
X-MC-Unique: dkx-vkeiNjaKLH7Du0lOWw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 936563801EC6;
 Fri, 17 May 2024 08:14:30 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.65])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EE2B4561A;
 Fri, 17 May 2024 08:14:29 +0000 (UTC)
Date: Fri, 17 May 2024 09:14:27 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Camilla Conte <cconte@redhat.com>, qemu-devel@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org
Subject: Re: [PATCH] gitlab-ci: Replace Docker with Kaniko
Message-ID: <ZkcR4_cQzl-LjcjC@redhat.com>
References: <20240516165410.28800-3-cconte@redhat.com>
 <ZkZPRILIqoyGbdEk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZkZPRILIqoyGbdEk@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.022,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Thu, May 16, 2024 at 07:24:04PM +0100, Daniel P. Berrangé wrote:
> On Thu, May 16, 2024 at 05:52:43PM +0100, Camilla Conte wrote:
> > Enables caching from the qemu-project repository.
> > 
> > Uses a dedicated "$NAME-cache" tag for caching, to address limitations.
> > See issue "when using --cache=true, kaniko fail to push cache layer [...]":
> > https://github.com/GoogleContainerTools/kaniko/issues/1459
> 
> After investigating, this is a result of a different design approach
> for caching in kaniko.
> 
> In docker, it can leverage any existing image as a cache source,
> reusing individual layers that were present. IOW, there's no
> difference between a cache and a final image, they're one and the
> same thing
> 
> In kaniko, the cache is a distinct object type. IIUC, it is not
> populated with the individual layers, instead it has a custom
> format for storing the cached content. Therefore the concept of
> storing the cache at the same location as the final image, is
> completely inappropriate - you can't store two completely different
> kinds of content at the same place.
> 
> That is also why you can't just "git pull" the fetch the cache
> image(s) beforehand, and also why it doesn't look like you can
> use multiple cache sources with kaniko.
> 
> None of this is inherantly a bad thing..... except when it comes
> to data storage. By using Kaniko we would, at minimum, doubling
> the amount of data storage we consume in the gitlab registry.

Double is actually just the initial case. The cache is storing layers
using docker tags, whose name appears based on a hash of the "RUN"
command.

IOW, the first time we build a container we have double the usage.
When a dockerfile is updated changing a 'RUN' command, we now have
triple the storage usage for cache. Update the RUN command again,
and we now have quadruple the storage. etc.

Kaniko does not appear to purge cache entries itself, and will rely
on something else to do the cache purging.

GitLab has support for purging old docker tags, but I'm not an
admin on the QEMU project namespace, so can't tell if it can be
enabled or not ? Many older projects have this permanently disabled
due to historical compat issues in gitlab after they introduced the
feature.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


