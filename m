Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88472E77180
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 09:35:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLfbY-0003i7-2F; Thu, 12 Dec 2024 04:35:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tLfbW-0003hb-Rd
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 04:35:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tLfbU-0006sA-UA
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 04:35:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733996127;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1H2CuKHGFwe8PU0fXtMReYR93FZpZUQ4Bqvm3+ByV4o=;
 b=N/4S3E+OLMxqw9wuAOSvprNDJhfmPeZjBerfUKt/TlDD+GSj4saWUsZmlCHEAlzD9WkG86
 rTIrCPgDF2e0K9X5rTokGFi4qSegCM8Q2lLQhZtgu1dXBZ2x3cyWpAp6tXvcnkUDp8KvyP
 NjdSko+ff7w1e9MXOgZTxtF2iHxB5SQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-17-1COXBa7UP0Gp4RevDOrFKg-1; Thu,
 12 Dec 2024 04:35:25 -0500
X-MC-Unique: 1COXBa7UP0Gp4RevDOrFKg-1
X-Mimecast-MFC-AGG-ID: 1COXBa7UP0Gp4RevDOrFKg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A784C195604F; Thu, 12 Dec 2024 09:35:24 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.114])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 501141956086; Thu, 12 Dec 2024 09:35:22 +0000 (UTC)
Date: Thu, 12 Dec 2024 09:35:19 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>
Subject: Re: [PATCH v2 05/31] tests/functional: drop 'tesseract_available'
 helper
Message-ID: <Z1quVwBUetdjM8fK@redhat.com>
References: <20241211172648.2893097-1-berrange@redhat.com>
 <20241211172648.2893097-6-berrange@redhat.com>
 <1ad6e5e3-a54a-4361-b31f-3b08bad5180f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1ad6e5e3-a54a-4361-b31f-3b08bad5180f@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Thu, Dec 12, 2024 at 07:57:37AM +0100, Thomas Huth wrote:
> On 11/12/2024 18.26, Daniel P. Berrangé wrote:
> > Platforms we target have new enough tesseract that it suffices to merely
> > check if the binary exists.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >   tests/functional/qemu_test/tesseract.py | 12 +-----------
> >   tests/functional/test_m68k_nextcube.py  |  8 +++-----
> >   2 files changed, 4 insertions(+), 16 deletions(-)
> > 
> > diff --git a/tests/functional/qemu_test/tesseract.py b/tests/functional/qemu_test/tesseract.py
> > index ef1833139d..1b7818090a 100644
> > --- a/tests/functional/qemu_test/tesseract.py
> > +++ b/tests/functional/qemu_test/tesseract.py
> > @@ -7,17 +7,7 @@
> >   import logging
> > -from . import has_cmd, run_cmd
> > -
> > -def tesseract_available(expected_version):
> > -    (has_tesseract, _) = has_cmd('tesseract')
> > -    if not has_tesseract:
> > -        return False
> > -    (stdout, stderr, ret) = run_cmd([ 'tesseract', '--version'])
> > -    if ret:
> > -        return False
> > -    version = stdout.split()[1]
> > -    return int(version.split('.')[0]) >= expected_version
> > +from . import run_cmd
> >   def tesseract_ocr(image_path, tesseract_args=''):
> >       console_logger = logging.getLogger('console')
> > diff --git a/tests/functional/test_m68k_nextcube.py b/tests/functional/test_m68k_nextcube.py
> > index 0124622c40..1022e8f468 100755
> > --- a/tests/functional/test_m68k_nextcube.py
> > +++ b/tests/functional/test_m68k_nextcube.py
> > @@ -13,7 +13,8 @@
> >   from qemu_test import QemuSystemTest, Asset
> >   from unittest import skipUnless
> > -from qemu_test.tesseract import tesseract_available, tesseract_ocr
> > +from qemu_test import has_cmd
> > +from qemu_test.tesseract import tesseract_ocr
> >   PIL_AVAILABLE = True
> >   try:
> > @@ -53,10 +54,7 @@ def test_bootrom_framebuffer_size(self):
> >           self.assertEqual(width, 1120)
> >           self.assertEqual(height, 832)
> > -    # Tesseract 4 adds a new OCR engine based on LSTM neural networks. The
> > -    # new version is faster and more accurate than version 3. The drawback is
> > -    # that it is still alpha-level software.
> > -    @skipUnless(tesseract_available(4), 'tesseract OCR tool not available')
> > +    @skipUnless(*has_cmd('tesseract') 'tesseract OCR tool not available')
> 
> The *has_cmd('tesseract') already provides the error message, so you've got
> to drop the 'tesseract OCR tool not available' part now, otherwise this ends
> up in an SyntaxError. You likely didn't notice since it gets replaced later
> anyway, but for bisectability, it would be good to fix it.

Opps, yes, will address it.

> 
> Anyway, this is yet another good example why we should rather get rid of
> has_cmd() ... it's too error prone, I made the same or similar mistake in
> the past already, too.
> 
>  Thomas
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


