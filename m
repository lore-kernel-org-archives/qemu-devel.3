Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42585C83027
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 09:55:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjbrq-0007m3-9m; Thu, 29 Aug 2024 05:55:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sjbrk-0007kU-OU
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 05:54:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sjbrf-000885-31
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 05:54:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724925285;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TMEhPvh0GYVd9X5QN+yTFu3LYoJYsT6cc7rKpWNz+4Q=;
 b=LbOk0Bt33H1l4ev0i5CNqg6oByHo2Dn0IA+ONcGCZ/393HtLa/6bXYPrqI/wRkJ3pap8Ec
 47iQVG8vsxmbPSsGeQeFukbevlwRnBs3WZSOKNkwRrfTAQNgeJ6mmkPoS5Xb7FEB5UJG74
 y+Ha0c8qnntgucNa7KARwt+772sWpBE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-558-jiMzjDvGMby6wpig8mP0Bg-1; Thu,
 29 Aug 2024 05:54:41 -0400
X-MC-Unique: jiMzjDvGMby6wpig8mP0Bg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A64F41955D4E; Thu, 29 Aug 2024 09:54:40 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.64])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 15D041956048; Thu, 29 Aug 2024 09:54:37 +0000 (UTC)
Date: Thu, 29 Aug 2024 10:54:34 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v4 11/35] tests/functional: Prepare the meson build
 system for the functional tests
Message-ID: <ZtBFWtVQ9qaKibTL@redhat.com>
References: <20240821082748.65853-1-thuth@redhat.com>
 <20240821082748.65853-12-thuth@redhat.com>
 <4b4018c6-4a2b-4250-bb53-be9cc5df7cb4@linaro.org>
 <b60d967a-6d87-4dfa-9ed5-da547be453a4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b60d967a-6d87-4dfa-9ed5-da547be453a4@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, Aug 26, 2024 at 10:18:44AM +0200, Thomas Huth wrote:
> On 23/08/2024 14.54, Philippe Mathieu-Daudé wrote:
> > On 21/8/24 10:27, Thomas Huth wrote:
> > > Provide a meson.build file for the upcoming python-based functional
> > > tests, and add some wrapper glue targets to the tests/Makefile.include
> > > file. We are going to use two "speed" modes for the functional tests:
> > > The "quick" tests can be run at any time (i.e. also during "make check"),
> > > while the "thorough" tests should only be run when running a
> > > "make check-functional" test run (since these tests might download
> > > additional assets from the internet).
> > > 
> > > The changes to the meson.build files are partly based on an earlier
> > > patch by Ani Sinha.
> > > 
> > > Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > > Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > > ---
> > >   tests/Makefile.include       | 11 ++++++
> > >   tests/functional/meson.build | 66 ++++++++++++++++++++++++++++++++++++
> > >   tests/meson.build            |  1 +
> > >   3 files changed, 78 insertions(+)
> > >   create mode 100644 tests/functional/meson.build
> > 
> > 
> > > +# Timeouts for individual tests that can be slow e.g. with debugging enabled
> > > +test_timeouts = {
> > > +}
> > 
> > 
> > > +    foreach test : target_tests
> > > +      test('func-@0@/@1@'.format(target_base, test),
> > > +           python,
> > > +           depends: [test_deps, test_emulator, emulator_modules],
> > > +           env: test_env,
> > > +           args: [meson.current_source_dir() / 'test_' + test + '.py'],
> > > +           protocol: 'tap',
> > > +           timeout: test_timeouts.get(test, 60),
> > > +           priority: test_timeouts.get(test, 60),
> > 
> > IIUC with Avocado the timeout was for each test_func in a TestClass.
> > Now this is only per TestClass. Hopefully I'm wrong...
> 
> I think you're right ... we might need to adjust the meson timeouts here and
> there in case they are causing problems, but that's just business as usual
> (we had to do the same when enabling the meson timeouts for the qtests for
> example).

Meson timeouts are around the lifetime of whatever child process
we tell it to execute.  So, yes, the timeout is for the .py file
as a whole, not the individual TestClass within it.

This is different from Avocado, but not a big problem. Worst case
we'll adjust some meson level timeouts, or split overly long running
.py test files into multiple test .py files.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


