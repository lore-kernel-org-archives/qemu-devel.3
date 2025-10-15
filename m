Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36312CCD18E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 13:49:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v91sI-0000r2-3d; Wed, 15 Oct 2025 09:49:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v91sG-0000qI-C9
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 09:49:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v91sD-0007GN-Im
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 09:49:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760536138;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YWhen++a79FthcvE3SnEW4XRqd9wOq/MWkhLVfspJ1s=;
 b=RdXnNoNgXZCFML5dPHx1ddxN1jz2zSnrIYDU+hxExeyTs4RnoNZQJX9pRTfBO5W7u6Zpky
 DLtNjguh+t5YzA8qMAmv084bv9ohnby58ORtCXrMhxVk6igt+40ZMasDz4EnB1taB1TEIw
 WmA8jy2mmEXOHO3J92RmAdgYat6A0MY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-280-pryIPy8-Nbm0S4xnh4k9Rw-1; Wed,
 15 Oct 2025 09:48:56 -0400
X-MC-Unique: pryIPy8-Nbm0S4xnh4k9Rw-1
X-Mimecast-MFC-AGG-ID: pryIPy8-Nbm0S4xnh4k9Rw_1760536135
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 05FBA1800637; Wed, 15 Oct 2025 13:48:55 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.51])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 250B819560AD; Wed, 15 Oct 2025 13:48:52 +0000 (UTC)
Date: Wed, 15 Oct 2025 14:48:49 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH 2/4] tests: rearrange suites for I/O tests
Message-ID: <aO-mQQ6nrLYXmPaz@redhat.com>
References: <20251008113552.747002-1-berrange@redhat.com>
 <20251008113552.747002-3-berrange@redhat.com>
 <aO4JSRfDAn6Jq7Hn@redhat.com> <aO-lVDVKWEVMeasR@redhat.com>
 <507917da-519f-431d-ab30-3b24b7173471@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <507917da-519f-431d-ab30-3b24b7173471@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Oct 15, 2025 at 03:47:26PM +0200, Thomas Huth wrote:
> On 15/10/2025 15.44, Daniel P. Berrangé wrote:
> > On Tue, Oct 14, 2025 at 10:26:49AM +0200, Kevin Wolf wrote:
> > > Am 08.10.2025 um 13:35 hat Daniel P. Berrangé geschrieben:
> > > > Currently there are 5 block formats, each classified as either quick,
> > > > slow or thorough. This classification then determines what tests we
> > > > add to meson suites. The suites are as follows
> > > > 
> > > >    * block
> > > > 
> > > >      => tests listed by 'check -g auto -n' for 'quick' formats
> > > > 
> > > >    * slow, block-slow
> > > > 
> > > >      => tests listed by 'check -n' for 'slow' formats or 'check -g auto -n'
> > > >         for 'quick' formats
> > > > 
> > > >    * thorough, block-thorough
> > > > 
> > > >      => tests listed by 'check -n' for 'thorough' formats
> > > > 
> > > > The pairs of suites 'slow' / 'block-slow' and 'thorough' / 'block-thorough'
> > > > match in terms of what tests are enabled. The only difference is whether
> > > > non-block related tests are also in the suite.
> > > > 
> > > > There are two problems with this
> > > > 
> > > >   * If a format is classified as 'quick', we don't expose any
> > > >     meson suite for running *all* tests, only the 'auto' tests.
> > > > 
> > > >     eg there is no suite to run all qcow2 tests, only 'quick'
> > > >     tests can be run via meson, even if using 'SPEED=slow' we
> > > >     still filter to only 'auto' tests.
> > > > 
> > > >   * There is no suite that allows running all tests for a given
> > > >     format.
> > > > 
> > > >     eg there is no suite to run only 'raw' tests - you can only
> > > >     use 'block-slow' which runs both raw and "auto" qcow2 tests.
> > > > 
> > > >     eg there is no suite to run only 'vpc' tests - you can only
> > > >     use 'block-thorough' which runs qed, vmdk & vpc tests.
> > > > 
> > > > This patch suggests that 'block-slow' and 'block-thorough' are
> > > > not actually compelling use cases, and should be dropped. ie it
> > > > is not expected that people need to run all VPC, VMDK and QED
> > > > tests at the same time. Instead a more useful feature is the
> > > > ability to run all tests for a given format. Further the 'auto'
> > > > filtering should only apply in the default 'block' target/suite.
> > > > 
> > > > IOW, with this patch we get the follows meson suites:
> > > > 
> > > >   * 'block' - 'auto' tests for any format listed as 'quick'
> > > >               Currently just qcow2 'auto' tests
> > > >   * 'block-$FORMAT' - ALL tests for the given $FORMAT, for each
> > > >                       of qcow2, raw, qed, vmdk & vpc
> > > >   * 'slow' - ALL tests for formats tagged with 'quick' or 'slow'
> > > >   * 'thorough' - ALL tests formats tagged with 'thorough'
> > > > 
> > > > This corresponds to the following make targets.
> > > > 
> > > >   * 'make check-block'
> > > > 
> > > >      => runs only 'auto' qcow2 tests  (unchanged)
> > > > 
> > > >   * 'make check-block SPEED=thorough'
> > > > 
> > > >      => runs all 'qed', 'vmdk', 'vpc' tests (unchanged)
> > > 
> > > Also all qcow2 and raw tests, right?
> > 
> > Sigh, I made a mistake here, this should read:
> >    * 'make check' / 'make check-block'
> >       => runs only 'auto' qcow2 tests  (unchanged)
> > 
> > The 'make check-block SPEED=thorough/slow' feature was removed
> > on the basis that running all targets at once is not that
> > useful, instead the 'check-block-$FORMAT' targets are
> > replacing it. IOW the meson 'block-slow' and 'block-through'
> > suites are gone.
> 
> Can we still run all tests (i.e. iotests, qtests, unit tests and functional
> tests in parallel) at once with a simple "make check SPEED=thorough" ? If
> not, that would be a regression for me.

Yes, the tests are still added to the 'thorough' and 'slow' meson
suites, only the 'block-thorough' and 'block-slow' suites were
removed.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


