Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F6F2D65538
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 17:56:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFzna-0005kp-Ek; Tue, 26 Nov 2024 12:56:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tFznX-0005k4-Pj
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 12:56:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tFznW-0004Q7-3c
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 12:56:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732643784;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LEL7oVmzKE+UDmj7bwGkyG6hSBouL6ZagcAKhXmHeQA=;
 b=QK+XST5HIEJjm2vXeD294ZZ75trgE2i25lrwLEvjtFhj0/h7gPuMB3hWH/H9VmDdsRz0F0
 9XuQG7x/Tvme/TcE1lJcw29Pr7Bo85gGSP9ddDIGyP0rAAHrBBwtw83egzYC8cj7XmQVII
 HYoURHikrPhQlhSbYr+XGY7oDVWPOhU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-21-czEPet05Ml-AHkeiAwx-0g-1; Tue,
 26 Nov 2024 12:56:22 -0500
X-MC-Unique: czEPet05Ml-AHkeiAwx-0g-1
X-Mimecast-MFC-AGG-ID: czEPet05Ml-AHkeiAwx-0g
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 415981955E75; Tue, 26 Nov 2024 17:56:20 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.147])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 43008195E485; Tue, 26 Nov 2024 17:56:16 +0000 (UTC)
Date: Tue, 26 Nov 2024 17:56:13 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Camilla Conte <cconte@redhat.com>
Subject: Re: [PULL 15/42] tests/functional: enable pre-emptive caching of
 assets
Message-ID: <Z0YLvQWVHL_uDA1U@redhat.com>
References: <20240904103923.451847-1-thuth@redhat.com>
 <20240904103923.451847-16-thuth@redhat.com>
 <66bf4784-f1e4-479f-83db-2d4f91c10e48@linaro.org>
 <Z0YF9i2pwBkznkCD@redhat.com>
 <CAFEAcA-ematCTyj0SN2=e3mGHvp0VWjN1GV-Tu5Rkf-V721L1w@mail.gmail.com>
 <8ff5ef91-1a4b-498e-a948-37444d699f94@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8ff5ef91-1a4b-498e-a948-37444d699f94@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.931,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Nov 26, 2024 at 06:52:57PM +0100, Thomas Huth wrote:
> On 26/11/2024 18.46, Peter Maydell wrote:
> > On Tue, 26 Nov 2024 at 17:31, Daniel P. Berrangé <berrange@redhat.com> wrote:
> > > 
> > > On Tue, Nov 26, 2024 at 05:44:29PM +0100, Philippe Mathieu-Daudé wrote:
> > > > Hi,
> > > > 
> > > > On 4/9/24 12:38, Thomas Huth wrote:
> > > > fetch() can fail [*] (see previous patch, various Exceptions returned).
> > > > 
> > > > What should we do in this case? If we ignore a missing artifact,
> > > > the tests will eventually fail. Better bail out early and save
> > > > credit minutes?
> > > 
> > > We already do what you describe - 'fetch' will raise an exception
> > > which causes the precache task to fail, and the CI job gets marked
> > > as failed. We don't attempt to run tests if assets are missing.
> > > 
> > > 
> > > > > @@ -58,6 +59,12 @@ def tearDown(self):
> > > > >        def main():
> > > > >            path = os.path.basename(sys.argv[0])[:-3]
> > > > > +
> > > > > +        cache = os.environ.get("QEMU_TEST_PRECACHE", None)
> > > > > +        if cache is not None:
> > > > > +            Asset.precache_suites(path, cache)
> > > > > +            return
> > > > > +
> > > > >            tr = pycotap.TAPTestRunner(message_log = pycotap.LogMode.LogToError,
> > > > >                                       test_output_log = pycotap.LogMode.LogToError)
> > > > >            unittest.main(module = None, testRunner = tr, argv=["__dummy__", path])
> > > > 
> > > > [*] Peter reported the following CI failure:
> > > > 
> > > >    https://gitlab.com/qemu-project/qemu/-/jobs/8474928266
> > > > 
> > > > 2024-11-26 14:58:53,170 - qemu-test - ERROR - Unable to download https://apt.armbian.com/pool/main/l/linux-6.6.16/linux-image-current-sunxi_24.2.1_armhf__6.6.16-Seb3e-D6b4a-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb:
> > > 
> > > This looks to be working as intended. We failed to cache
> > > the asset, and so we stopped the job, without trying to
> > > run the tests.
> > 
> > The job ended up in state "failed", with a red X mark in
> > the gitlab UI. If we intend that not being able to fetch
> > the assets doesn't count as a test failure, that didn't
> > work here. If we do intend that fetch failures should be
> > CI failures, we need to make our process of fetching and
> > caching the images more robust, because otherwise the result
> > is flaky CI jobs.
> 
> I think we want to continue to maek failing downloads as test failures,
> otherwise we'll never notice when an asset is not available from the
> internet anymore (since SKIPs just get ignored).
> 
> What we really need is a working cache for the private CI runners to ease
> the pain when the host just has a networking hiccup.

Right, if the cache was working, once the cache is primed, then the only
time we would see a fail is if the commit introduces a /new/ URL that is
genuinely invalid.

We absolutely need the caching for runners to be fixed as a high priority
task. It also breaks our ability to use ccache, which means our pipelines
are needlessly slower than they should be.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


