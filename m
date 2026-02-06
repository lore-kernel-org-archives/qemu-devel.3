Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7599AEE20A8
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 13:59:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voMLs-0003Ul-EP; Fri, 06 Feb 2026 08:58:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1voMLq-0003UT-U8
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 08:58:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1voMLo-0005B3-C2
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 08:58:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770386302;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qHv0EUYft3Ik2gQFGaAFHulKwh3pL5WQRGErMxBHBNE=;
 b=IC1IonWUQXbC9u1LpVTLltY5wsDl56bpuICQz3aqmBxCO2XE5DWzV8MRt5/YHf2RWclFdy
 oiCNfjbZ3YeFQPqerwjbLB2F+4fMOhCl0+2ungxzGwd0l4wdD2NhOzLD642AfdfqxI+DwI
 /98mST2SpCL8VoOZbSS6viMei2/9MsI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-694-TEvu48uPO6KPXkRbREVqfA-1; Fri,
 06 Feb 2026 08:58:19 -0500
X-MC-Unique: TEvu48uPO6KPXkRbREVqfA-1
X-Mimecast-MFC-AGG-ID: TEvu48uPO6KPXkRbREVqfA_1770386298
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F17C81800282; Fri,  6 Feb 2026 13:58:17 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.75])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9D69A19373D8; Fri,  6 Feb 2026 13:58:15 +0000 (UTC)
Date: Fri, 6 Feb 2026 13:58:11 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH 2/4] tests/docker: allow display of docker output
Message-ID: <aYXzc5LL4FH73xhX@redhat.com>
References: <20260107130145.1495219-1-berrange@redhat.com>
 <20260107130145.1495219-3-berrange@redhat.com>
 <5ca70c9c-8cfe-4733-9f85-20adb3a4446f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5ca70c9c-8cfe-4733-9f85-20adb3a4446f@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Feb 06, 2026 at 02:48:34PM +0100, Thomas Huth wrote:
> On 07/01/2026 14.01, Daniel P. Berrangé wrote:
> > The --quiet command is used with docker unless V=1 is passed to make,
> > and as a result stdout from docker is never visible by default, making
> > it hard to diagnose failures building / running containers.
> > 
> > Meanwhile passing V=1 is undesirable as that makes the entire build
> > system verbose.
> > 
> > Introduce a $(DOCKER_V) make variable which is initialized from $(V)
> > 
> > It is thus possible to display docker output without also enabling
> > make verbose output.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >   tests/docker/Makefile.include | 18 +++++++++++-------
> >   1 file changed, 11 insertions(+), 7 deletions(-)
> > 
> > diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
> > index 7d4582b6a8..d58a280333 100644
> > --- a/tests/docker/Makefile.include
> > +++ b/tests/docker/Makefile.include
> > @@ -40,14 +40,14 @@ docker-qemu-src: $(DOCKER_SRC_COPY)
> >   docker-image-%: $(DOCKER_FILES_DIR)/%.docker
> >   	  $(call quiet-command,			\
> >   		DOCKER_BUILDKIT=1 $(RUNC) build		\
> > -		$(if $V,,--quiet)			\
> > +		$(if $(DOCKER_V),,--quiet)		\
> 
> Hmm, do we maybe want a
> 
> DOCKER_V ?= $(V)
> 
> earlier in this file, so that DOCKER_V gets enabled when running in normal
> verbose mode, too?

I was on the fence about it. V=1 is traditionally focused on details of the
commands being executed, rather than their output, but I don't mind much
either way. 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


