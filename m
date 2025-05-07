Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCDF7C3ABC0
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 07:15:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCYzB-0007b8-Ls; Wed, 07 May 2025 03:14:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uCYz9-0007Zq-7R
 for qemu-devel@nongnu.org; Wed, 07 May 2025 03:14:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uCYz6-0005G9-Te
 for qemu-devel@nongnu.org; Wed, 07 May 2025 03:14:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746602066;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VIK3ZTetIbV6SEvbC3krPO9I/vELt0WZXMOEL0x/3YQ=;
 b=JxxEMm3aC+6VZsEs2TLohUvwRfhdtNY8pkToZ6Cvg5mBD89mSJqRJyheGazWqXwUFU99+n
 50R4m5PNL7YwuWT/iNhnx6F54qh02ub29gCn/PEFBzD2mS2TExdqp4n2D5bGYXc8JfbYVw
 CDniFywtKjeUx8S0u85Rf0M8U3pyBdw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-219-6m2uYF_kMHyYc2JV19M8Bg-1; Wed,
 07 May 2025 03:14:25 -0400
X-MC-Unique: 6m2uYF_kMHyYc2JV19M8Bg-1
X-Mimecast-MFC-AGG-ID: 6m2uYF_kMHyYc2JV19M8Bg_1746602064
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1C6E819560AA; Wed,  7 May 2025 07:14:24 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.63])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A10DB1956055; Wed,  7 May 2025 07:14:21 +0000 (UTC)
Date: Wed, 7 May 2025 08:14:18 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH] meson: use thorough test setup as default
Message-ID: <aBsISp5UvOLzFhqn@redhat.com>
References: <20250503201806.3045723-1-pierrick.bouvier@linaro.org>
 <f7da46dd-0e8f-42d8-b555-300c088f605e@redhat.com>
 <91cc4370-163e-4bdd-ac1c-b0d6ea3c06cb@linaro.org>
 <aBnXXC3ldqErl8ub@redhat.com>
 <6a8d7703-e275-4566-bc38-b627cc597e9a@linaro.org>
 <e36633e2-e0de-422a-8ad3-1562e97926c6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e36633e2-e0de-422a-8ad3-1562e97926c6@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, May 06, 2025 at 07:12:53PM +0200, Thomas Huth wrote:
> On 06/05/2025 17.31, Pierrick Bouvier wrote:
> > On 5/6/25 2:33 AM, Daniel P. Berrangé wrote:
> > > On Mon, May 05, 2025 at 10:46:52AM -0700, Pierrick Bouvier wrote:
> > > > On 5/5/25 3:32 AM, Thomas Huth wrote:
> > > > > On 03/05/2025 22.18, Pierrick Bouvier wrote:
> > > > > > Allows all tests to be visible by default when using meson test
> > > > > > directly.
> > > > > > 
> > > > > > This has no impact on make check-* commands, which use SPEED=quick by
> > > > > > default (see scripts/mtest2make.py).
> > > > > > 
> > > > > > Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> > > > > > ---
> > > > > >     meson.build | 5 +++--
> > > > > >     1 file changed, 3 insertions(+), 2 deletions(-)
> > > > > > 
> > > > > > diff --git a/meson.build b/meson.build
> > > > > > index f8bf6e7bb66..57ff3f722d8 100644
> > > > > > --- a/meson.build
> > > > > > +++ b/meson.build
> > > > > > @@ -5,12 +5,13 @@ project('qemu', ['c'], meson_version: '>=1.5.0',
> > > > > >     meson.add_devenv({ 'MESON_BUILD_ROOT' : meson.project_build_root() })
> > > > > > -add_test_setup('quick', exclude_suites: ['slow',
> > > > > > 'thorough'], is_default: true,
> > > > > > +add_test_setup('quick', exclude_suites: ['slow', 'thorough'],
> > > > > >                    env: ['RUST_BACKTRACE=1'])
> > > > > >     add_test_setup('slow', exclude_suites: ['thorough'],
> > > > > >                    env: ['G_TEST_SLOW=1', 'SPEED=slow',
> > > > > > 'RUST_BACKTRACE=1'])
> > > > > >     add_test_setup('thorough',
> > > > > > -               env: ['G_TEST_SLOW=1', 'SPEED=thorough',
> > > > > > 'RUST_BACKTRACE=1'])
> > > > > > +               env: ['G_TEST_SLOW=1', 'SPEED=thorough',
> > > > > > 'RUST_BACKTRACE=1'],
> > > > > > +               is_default: true)
> > > > > 
> > > > > I'd rather not make it the default: The thorough functional
> > > > > tests download a
> > > > > lot of assets from the internet, so if someone just runs "meson test"
> > > > > without further parameters, I think we should not trigger
> > > > > these downloads in
> > > > > that case.
> > > > > 
> > > > 
> > > > $ cat tests/Makefile.include
> > > > ...
> > > > check-functional:
> > > >     @$(NINJA) precache-functional
> > > >     @QEMU_TEST_NO_DOWNLOAD=1 $(MAKE) SPEED=thorough check-func
> > > > ...
> > > > 
> > > > What's the rationale to run check-func with SPEED=thorough and
> > > > QEMU_TEST_NO_DOWNLOAD=1 with precache-functional having cached only quick
> > > > tests by default?
> > > 
> > > Are you sure about that ? The precache logic uses custom_target() in
> > > meson and so does not filters on "suites" used to define quick vs
> > > thorough tests.
> > > 
> > 
> > My bad, I missed the "foreach speed : ['quick', 'thorough']" wrapping
> > all this in tests/functional/meson.build.
> > 
> > > IOW, precache should always be downloading all assets.
> > > 
> > 
> > Then I don't understand the previous argument from Thomas to not make
> > thorough the default: "The thorough functional tests download a
> > lot of assets from the internet, so if someone just runs "meson test"
> > without further parameters, I think we should not trigger these
> > downloads in that case". It's what precache-functional is doing.
> 
> precache-functional is *only* called when you run "make check-functional",
> i.e. when you know that you want to run the functional tests that might
> download assets from the internet. It's not called when you run the normal
> "make check".

Are you sure ?  If that's the case it was *not* my intention when i
added precaching - I thought that "make check"  would call
"make check-functional" and thus trigger precaching ?

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


