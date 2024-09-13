Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B541DFA3755
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 14:06:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp6vi-0006Do-FR; Fri, 13 Sep 2024 10:05:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sp6vf-0006D5-Aw
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 10:05:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sp6vd-0000E2-L3
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 10:05:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726236340;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=I4GXT4ARceORrLct4ze+iAWuIeQJADysdXSXJzG4FlU=;
 b=i1+YxPpPXtZlS13FjPK4/cqKG7he8KsHToHBZuomip5sdGwXBX/G/oSvZ/f8OevuUrs/YP
 WHlLrJchT/hYe8R6931PdB9/eMc+XWWQKPd6JLc9u9SJOKqwsDtx9JfgVIiFwAbS4QDP5I
 J+yod4iw6x/J3+QBCl5VAl32bn3PGg8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-zUV5UQrTP2e2ONWyCEc7Tw-1; Fri,
 13 Sep 2024 10:05:38 -0400
X-MC-Unique: zUV5UQrTP2e2ONWyCEc7Tw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9D6B11955F3E; Fri, 13 Sep 2024 14:05:37 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.224])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 61EFF19560AA; Fri, 13 Sep 2024 14:05:36 +0000 (UTC)
Date: Fri, 13 Sep 2024 15:05:33 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v2] .gitlab-ci.d/crossbuilds.yml: Force 'make check'
 single-threaded for cross-i686-tci
Message-ID: <ZuRGrUiawzKk7lXG@redhat.com>
References: <20240912151003.2045031-1-peter.maydell@linaro.org>
 <CAFEAcA-ZuE4B1frfnkpS6yxu_YiTastZ9S_b=4_8zGigRtDeNg@mail.gmail.com>
 <CAFEAcA9sUcspOwWU-huyza4Rp=vw=5wArXBSnV-KDVYm5=8u_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA9sUcspOwWU-huyza4Rp=vw=5wArXBSnV-KDVYm5=8u_g@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.147,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Sep 13, 2024 at 02:31:34PM +0100, Peter Maydell wrote:
> On Fri, 13 Sept 2024 at 13:24, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > On Thu, 12 Sept 2024 at 16:10, Peter Maydell <peter.maydell@linaro.org> wrote:
> > >
> > > The cross-i686-tci CI job is persistently flaky with various tests
> > > hitting timeouts.  One theory for why this is happening is that we're
> > > running too many tests in parallel and so sometimes a test gets
> > > starved of CPU and isn't able to complete within the timeout.
> > >
> > > (The environment this CI job runs in seems to cause us to default
> > > to a parallelism of 9 in the main CI.)
> > >
> > > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > > ---
> > > If this works we might be able to wind this up to -j2 or -j3,
> > > and/or consider whether other CI jobs need something similar.
> >
> > I gave this a try, but unfortunately the result seems to be
> > that the whole job times out:
> > https://gitlab.com/qemu-project/qemu/-/jobs/7818441897
> 
> ...but then this simple retry passed with a runtime of 47 mins:
> 
> https://gitlab.com/qemu-project/qemu/-/jobs/7819225200
> 
> I'm tempted to commit this as-is, and see whether it helps.
> If it doesn't I can always back it off to -j2, and if it does
> generate a lot of full-job-timeouts it's only me it's annoying.

Anyone know how many vCPUs our k8s runners have ?

The gitlab runners that contributor forks use will have 2
vCPUs. So our current make -j$(nproc+1)  will be effectively
-j3 already in pipelines for forks. IOW, we intentionally
slightly over-commit CPUs right now. Backing off to just
-j$(nproc)  may be better than hardcoding -j1/-j2, so that
it takes account of different runner sizes ?


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


