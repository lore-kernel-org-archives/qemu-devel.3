Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 633F3CCFA1A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 13:08:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIo6M-0003Fm-3D; Tue, 11 Nov 2025 08:08:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vIo6H-00038n-7r
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 08:07:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vIo6E-0000Hx-OH
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 08:07:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762866471;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=ZFD21VI8bHg0k7TYPWDZSx1ow5767EIQaOS3VmZYUg0=;
 b=g/FKupdUFngb/Ygy+3Q5XlUDOLcosGncBkYmPe6SSpJZOVnifEzRUUvOBTLM31mvVLUcww
 +0IXzFarExl0Rz8fu9Ivivj+MsNctvqu/y8BZk+o/Gb7PDXssBb/48CbPoDb8fgWpA52/Y
 DJc5P3WerG0PkA4Dsbmz1u1K+vHe1LI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-60-ZMMIglsoOdWHKaWuaXgTtw-1; Tue,
 11 Nov 2025 08:07:49 -0500
X-MC-Unique: ZMMIglsoOdWHKaWuaXgTtw-1
X-Mimecast-MFC-AGG-ID: ZMMIglsoOdWHKaWuaXgTtw_1762866469
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8C1F818862F7
 for <qemu-devel@nongnu.org>; Tue, 11 Nov 2025 13:07:31 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.84])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C13461956056; Tue, 11 Nov 2025 13:07:28 +0000 (UTC)
Date: Tue, 11 Nov 2025 13:07:23 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: Re: Meson help
Message-ID: <aRM1C6FaMapcCeaD@redhat.com>
References: <CAFn=p-ZqLCJ2uRm4MSeewPbKyN8g+B95ELVkP9qaXdE2tObf_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFn=p-ZqLCJ2uRm4MSeewPbKyN8g+B95ELVkP9qaXdE2tObf_Q@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

On Fri, Nov 07, 2025 at 03:18:31PM -0500, John Snow wrote:
> Hiya;
> 
> I tried adding a test dep in meson to execute an ensuregroup command
> for check-functional tests; i.e.
> 
> commit ddb9ae03e1a29a036aa708016fcb747d77b1fc6d
> Author: John Snow <jsnow@redhat.com>
> Date:   Fri Nov 7 14:41:04 2025 -0500
> 
>     test: add pyvenv test deps to func tests...?
> 
> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
> index 725630d3082..dd9a1be18e7 100644
> --- a/tests/functional/meson.build
> +++ b/tests/functional/meson.build
> @@ -66,7 +66,7 @@ foreach speed : ['quick', 'thorough']
>        target_tests = get_variable('tests_' + target_base + '_' +
> sysmode + '_' + speed, [])
>      endif
> 
> -    test_deps = [roms, keymap_targets]
> +    test_deps = [roms, keymap_targets, pyvenv_test_deps]
>      test_env = environment()
>      if have_tools
>        test_env.set('QEMU_TEST_QEMU_IMG', meson.global_build_root() /
> 'qemu-img')
> 
> And then I tried removing the "check-venv" targets from
> tests/Makefile.include; but now it appears as though running "make
> check-functional" doesn't work; it doesn't invoke the ensuregroup
> hook.
> 
> What am I missing? Do I need to change the way "make check-functional"
> invokes the test suite....?
> 
> https://gitlab.com/jsnow/qemu/-/commits/python_drop_qmp

I checked out that branch, purged my local build env, and did

  ./configure --target-list=x86_64-softmmu
  make
  make check-functional

In the output displayed by the latter I saw

  changing dir to build for make "check-functional"...
  make[1]: Entering directory '/var/home/berrange/src/virt/qemu/build'
  ninja: Jobserver mode detected: rR -j20 --jobserver-auth=fifo:/tmp/GMfifo2721806
  [1/29] Generating tests/pyvenv_checktests_group with a custom command
  mkvenv: checking for qemu.qmp>=0.0.5
  mkvenv: installing qemu.qmp==0.0.5

That seems to be installing the 'checktests'  deps from pythondeps.yml
but is NOT installing the 'functests' deps from pythondeps.yml

It looks like the tests/meson.build target:

  pyvenv_checktests_group = custom_target(
      ....
  )

needs to be duplicated in tests/functional/meson.build, to process
the 'functests' deps instead of 'checktests', and them make both
'pyvenv_checktests_group' and 'pyvenv_functests_group' deps of
the functional tests.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


