Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 414D4D1CDAD
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 08:05:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t39sH-0001dZ-B7; Tue, 22 Oct 2024 04:04:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t39sG-0001dJ-4f
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 04:04:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t39sD-000634-Nx
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 04:04:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729584252;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bhdxh6lDsyheP3yaPsSJ/hJOUx8Ncl/eNpfrjsOT7XY=;
 b=ikjNX9EUIVdOR2nlx9zGWxepIN861gJLWUrfhxgOb28/Kn1QzFdJ14V06wrW84H1piHLlc
 rYgFBqaAYSrLNN0RLHVcySEGfDvN8jbw5MLNW5Smd1r08m6mSLli7ZzyKnigaXeV9bKr7f
 qDZFwrDJZ4urgErpBAL5K6HP07TnK78=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-183-MBLTbxFIP8q0IDFk1FSpBQ-1; Tue,
 22 Oct 2024 04:04:08 -0400
X-MC-Unique: MBLTbxFIP8q0IDFk1FSpBQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BADE41955EAD; Tue, 22 Oct 2024 08:04:06 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.59])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4F8EF19560A2; Tue, 22 Oct 2024 08:04:02 +0000 (UTC)
Date: Tue, 22 Oct 2024 09:03:58 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Longpeng <longpeng2@huawei.com>
Subject: Re: [PATCH] gitlab: enable afalg tests in fedora system test
Message-ID: <Zxdcbl-kaTRggFeJ@redhat.com>
References: <20241021170236.1443887-1-berrange@redhat.com>
 <ea8e87e4-eade-4926-8c0c-b583a605f270@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ea8e87e4-eade-4926-8c0c-b583a605f270@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.699,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, Oct 22, 2024 at 07:31:49AM +0200, Thomas Huth wrote:
> On 21/10/2024 19.02, Daniel P. Berrangé wrote:
> > The AF_ALG crypto integration for Linux is not being tested in
> > any CI scenario. It always requires an explicit configure time
> > flag to be passed to turn it on. The Fedora system test is
> > arbitrarily picked as the place to test it.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >   .gitlab-ci.d/buildtest.yml | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > This is to detect the situation Markus found here:
> > 
> >    https://lists.nongnu.org/archive/html/qemu-devel/2024-10/msg03040.html
> > 
> > diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
> > index 01e8470a69..f0cbdf1992 100644
> > --- a/.gitlab-ci.d/buildtest.yml
> > +++ b/.gitlab-ci.d/buildtest.yml
> > @@ -115,7 +115,7 @@ build-system-fedora:
> >       job: amd64-fedora-container
> >     variables:
> >       IMAGE: fedora
> > -    CONFIGURE_ARGS: --disable-gcrypt --enable-nettle --enable-docs
> > +    CONFIGURE_ARGS: --disable-gcrypt --enable-nettle --enable-docs --enable-crypto-afalg
> >       TARGETS: microblaze-softmmu mips-softmmu
> >         xtensa-softmmu m68k-softmmu riscv32-softmmu ppc-softmmu sparc64-softmmu
> >       MAKE_CHECK_ARGS: check-build
> 
> Is there a reason for this feature being disabled by default? Who is using
> it if it is disabled by default? Should we maybe rather enable it by default
> instead?

afalg isn't something you want to use in general. It performs worse than
the userspace crypto in many cases, especially for small buffers where the
context switch overhead kills.

It is potentially interesting if you have hardware crypto accelerator and
your guest workload also wants virtio-crypto.

Having it as a compile time option is not ideal, but it was the least
effort tradeoff.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


