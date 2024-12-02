Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D5DAD7830F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 11:52:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI4yL-0004Zn-Nt; Mon, 02 Dec 2024 06:52:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tI4yJ-0004ZW-I7
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 06:52:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tI4yF-0001Af-0H
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 06:52:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733140325;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sORuV3WZY7WL6bahsNX7++UjHUB5nn75ZTeY9REs9HU=;
 b=WeZcgUuq41cMTg5ADHMqWI4HzcEHDhEag5hREqnJhd7ZkQoszJEPx3hviOjJMv+WRZqNQp
 IkhO3T1GdEz2g3zMT1XKkhGTBXxlqWX8YE4Mb2bdAHeEkyOCWjdQffoacS2k4TRlBGMDxU
 FFBoXwQ0cJf9QPVp7QcJ+46R9XsV5cI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-128-iEWRvfdIOAGAXvjFxOnEdQ-1; Mon,
 02 Dec 2024 06:51:31 -0500
X-MC-Unique: iEWRvfdIOAGAXvjFxOnEdQ-1
X-Mimecast-MFC-AGG-ID: iEWRvfdIOAGAXvjFxOnEdQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 475A1195608C; Mon,  2 Dec 2024 11:51:30 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.143])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4933F195608A; Mon,  2 Dec 2024 11:51:27 +0000 (UTC)
Date: Mon, 2 Dec 2024 11:51:24 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH 07/22] tests/functional: switch to new test skip decorators
Message-ID: <Z02fPGZ_ccptEEQQ@redhat.com>
References: <20241129173120.761728-1-berrange@redhat.com>
 <20241129173120.761728-8-berrange@redhat.com>
 <9b02f469-1fc0-40ad-ad7c-34bce61865dc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9b02f469-1fc0-40ad-ad7c-34bce61865dc@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, Dec 02, 2024 at 09:57:27AM +0100, Thomas Huth wrote:
> On 29/11/2024 18.31, Daniel P. Berrangé wrote:
> > This ensures consistency of behaviour across all the tests, and requires
> > that we provide gitlab bug links when marking a test to be skipped due
> > to unreliability.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> > diff --git a/tests/functional/test_arm_aspeed.py b/tests/functional/test_arm_aspeed.py
> > index 068740a813..db872ff05e 100755
> > --- a/tests/functional/test_arm_aspeed.py
> > +++ b/tests/functional/test_arm_aspeed.py
> > @@ -13,7 +13,9 @@
> >   from qemu_test import (LinuxKernelTest, Asset,
> >                          exec_command_and_wait_for_pattern,
> > -                       interrupt_interactive_console_until_pattern, has_cmd)
> > +                       interrupt_interactive_console_until_pattern,
> > +                       skipIfMissingCommands,
> > +)
> 
> In the other files, you placed the final ")" at the end of the previous line
> instead?
> 
> > diff --git a/tests/functional/test_m68k_nextcube.py b/tests/functional/test_m68k_nextcube.py
> > index 0124622c40..82d3d335d0 100755
> > --- a/tests/functional/test_m68k_nextcube.py
> > +++ b/tests/functional/test_m68k_nextcube.py
> > @@ -10,16 +10,9 @@
> >   import os
> >   import time
> > -from qemu_test import QemuSystemTest, Asset
> > -from unittest import skipUnless
> > -
> > +from qemu_test import QemuSystemTest, Asset, skipIfMissingImports
> >   from qemu_test.tesseract import tesseract_available, tesseract_ocr
> > -
> > -PIL_AVAILABLE = True
> > -try:
> > -    from PIL import Image
> > -except ImportError:
> > -    PIL_AVAILABLE = False
> > +from unittest import skipUnless
> 
> I think you could also replace the other skipUnless() in this file nowadays:
> The version check here was only useful in the days when most distros still
> shipped Tesseract v3, but these days are gone, we don't support any of those
> distros anymore. So I think it should be fine to use skipIfMissingCommands
> here now instead.

Ah good, if we can drop that special case its nice.

> 
> Anyway, I'm also fine if we keep it for now (we still can adjust it later),
> so with at least the ")" nit fixed:
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 
> >   class NextCubeMachine(QemuSystemTest):
> > @@ -43,12 +36,13 @@ def check_bootrom_framebuffer(self, screenshot_path):
> >           self.vm.cmd('human-monitor-command',
> >                       command_line='screendump %s' % screenshot_path)
> > -    @skipUnless(PIL_AVAILABLE, 'Python PIL not installed')
> > +    @skipIfMissingImports("PIL")
> >       def test_bootrom_framebuffer_size(self):
> >           self.set_machine('next-cube')
> >           screenshot_path = os.path.join(self.workdir, "dump.ppm")
> >           self.check_bootrom_framebuffer(screenshot_path)
> > +        from PIL import Image
> >           width, height = Image.open(screenshot_path).size
> >           self.assertEqual(width, 1120)
> >           self.assertEqual(height, 832)
> ...
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


