Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30F59C3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 15:37:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCKLw-00006C-CG; Tue, 06 May 2025 11:37:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uCKLp-0008Ts-19
 for qemu-devel@nongnu.org; Tue, 06 May 2025 11:36:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uCKLi-0003D9-Eq
 for qemu-devel@nongnu.org; Tue, 06 May 2025 11:36:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746545808;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=96bZDLLUZyMAKNMcjbTS0YYUpzKPQTKHCZi27DkR36A=;
 b=Hx86H81FiDJjLdoPiI38JN/cs+mVYJAqOKIPBuNTRTbpLeuEMLRTsVa4zU4HVtz+7DhC1k
 JsnGu1pBDNVioPZuYKbO9t3gHH9xHyexenn10zVsaOXTCUyttyTp8I0mOVP2cf2Y4KsdSv
 O59mImdFueAlza6a7Klsf4ZVyXhQXVg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-478-Ib0I_XqRO1Shtcwlxtjk0A-1; Tue,
 06 May 2025 11:36:45 -0400
X-MC-Unique: Ib0I_XqRO1Shtcwlxtjk0A-1
X-Mimecast-MFC-AGG-ID: Ib0I_XqRO1Shtcwlxtjk0A_1746545804
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AE19E195607B; Tue,  6 May 2025 15:36:43 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.127])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 58D2E1956094; Tue,  6 May 2025 15:36:41 +0000 (UTC)
Date: Tue, 6 May 2025 16:36:38 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH] meson: use thorough test setup as default
Message-ID: <aBoshvkclnEMrOnU@redhat.com>
References: <20250503201806.3045723-1-pierrick.bouvier@linaro.org>
 <f7da46dd-0e8f-42d8-b555-300c088f605e@redhat.com>
 <91cc4370-163e-4bdd-ac1c-b0d6ea3c06cb@linaro.org>
 <aBnXXC3ldqErl8ub@redhat.com>
 <6a8d7703-e275-4566-bc38-b627cc597e9a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6a8d7703-e275-4566-bc38-b627cc597e9a@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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

On Tue, May 06, 2025 at 08:31:07AM -0700, Pierrick Bouvier wrote:
> On 5/6/25 2:33 AM, Daniel P. Berrangé wrote:
> > On Mon, May 05, 2025 at 10:46:52AM -0700, Pierrick Bouvier wrote:
> > > On 5/5/25 3:32 AM, Thomas Huth wrote:
> > > > On 03/05/2025 22.18, Pierrick Bouvier wrote:
> > > > > Allows all tests to be visible by default when using meson test
> > > > > directly.
> > > > > 
> > > > > This has no impact on make check-* commands, which use SPEED=quick by
> > > > > default (see scripts/mtest2make.py).
> > > > > 
> > > > > Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> > > > > ---
> > > > >     meson.build | 5 +++--
> > > > >     1 file changed, 3 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/meson.build b/meson.build
> > > > > index f8bf6e7bb66..57ff3f722d8 100644
> > > > > --- a/meson.build
> > > > > +++ b/meson.build
> > > > > @@ -5,12 +5,13 @@ project('qemu', ['c'], meson_version: '>=1.5.0',
> > > > >     meson.add_devenv({ 'MESON_BUILD_ROOT' : meson.project_build_root() })
> > > > > -add_test_setup('quick', exclude_suites: ['slow', 'thorough'], is_default: true,
> > > > > +add_test_setup('quick', exclude_suites: ['slow', 'thorough'],
> > > > >                    env: ['RUST_BACKTRACE=1'])
> > > > >     add_test_setup('slow', exclude_suites: ['thorough'],
> > > > >                    env: ['G_TEST_SLOW=1', 'SPEED=slow', 'RUST_BACKTRACE=1'])
> > > > >     add_test_setup('thorough',
> > > > > -               env: ['G_TEST_SLOW=1', 'SPEED=thorough', 'RUST_BACKTRACE=1'])
> > > > > +               env: ['G_TEST_SLOW=1', 'SPEED=thorough', 'RUST_BACKTRACE=1'],
> > > > > +               is_default: true)
> > > > 
> > > > I'd rather not make it the default: The thorough functional tests download a
> > > > lot of assets from the internet, so if someone just runs "meson test"
> > > > without further parameters, I think we should not trigger these downloads in
> > > > that case.
> > > > 
> > > 
> > > $ cat tests/Makefile.include
> > > ...
> > > check-functional:
> > > 	@$(NINJA) precache-functional
> > > 	@QEMU_TEST_NO_DOWNLOAD=1 $(MAKE) SPEED=thorough check-func
> > > ...
> > > 
> > > What's the rationale to run check-func with SPEED=thorough and
> > > QEMU_TEST_NO_DOWNLOAD=1 with precache-functional having cached only quick
> > > tests by default?
> > 
> > Are you sure about that ? The precache logic uses custom_target() in
> > meson and so does not filters on "suites" used to define quick vs
> > thorough tests.
> > 
> 
> My bad, I missed the "foreach speed : ['quick', 'thorough']" wrapping all
> this in tests/functional/meson.build.
> 
> > IOW, precache should always be downloading all assets.
> > 
> 
> Then I don't understand the previous argument from Thomas to not make
> thorough the default: "The thorough functional tests download a
> lot of assets from the internet, so if someone just runs "meson test"
> without further parameters, I think we should not trigger these downloads in
> that case". It's what precache-functional is doing.

I guess even without the download overhead, the tests using real VMs are
going to be slower overall as they're doing more work to bring up a full
OS install ? I have not quantified that difference though, and whether
it is really due to the type of images being used, or whether it is just
a perception from the fact that we'd be simply running more tests overall.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


