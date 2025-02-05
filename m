Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2E49C02192
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 16:54:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfifA-0000JM-Go; Wed, 05 Feb 2025 11:54:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tfif6-0000Iw-66
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 11:54:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tfiet-0002Xj-0J
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 11:53:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738774430;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7izgGCa92l3jcZwawcjC/V+QVD2ml2u1pDQ/sIamhps=;
 b=F1F4YARzvDHDxcp4n37l+prHpj4ysU81qCQUAV433LWdBcVzHYWYPz7aIG6Jjy6TZdEp1p
 DB5YeYPQyS2AZUxykFTmkqbUAMaYEV0kuHlr9x4tG/fscdnN5ZMCQohzrnOxRoaXy8Ghxp
 5sIQC5/71B4ltW/prJ994zfV1+J13sM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-475-rKNxX0QINnaPb2B0S--YDg-1; Wed,
 05 Feb 2025 11:53:46 -0500
X-MC-Unique: rKNxX0QINnaPb2B0S--YDg-1
X-Mimecast-MFC-AGG-ID: rKNxX0QINnaPb2B0S--YDg
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A60A919560A7; Wed,  5 Feb 2025 16:53:45 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.26])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C18E31800878; Wed,  5 Feb 2025 16:53:43 +0000 (UTC)
Date: Wed, 5 Feb 2025 16:53:40 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 5/5] tests/functional: skip mem addr test on 32-bit hosts
Message-ID: <Z6OXlPu0fw_S9iy6@redhat.com>
References: <20250205155946.2811296-1-berrange@redhat.com>
 <20250205155946.2811296-6-berrange@redhat.com>
 <9edd3138-3411-4459-96c3-d48c30e197e0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9edd3138-3411-4459-96c3-d48c30e197e0@linaro.org>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, Feb 05, 2025 at 05:40:48PM +0100, Philippe Mathieu-Daudé wrote:
> On 5/2/25 16:59, Daniel P. Berrangé wrote:
> > The test_mem_addr_space is validating handling of QEMU with various
> > memory address settings. All of the test cases are setting 'maxmem'
> > to a value that exceeds the 32-bit address space, so these must all
> > be skipped on 32-bit hosts.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >   tests/functional/qemu_test/__init__.py   |  2 +-
> >   tests/functional/qemu_test/decorators.py | 12 ++++++++++++
> >   tests/functional/test_mem_addr_space.py  | 17 ++++++++++++++++-
> >   3 files changed, 29 insertions(+), 2 deletions(-)
> 
> 
> > diff --git a/tests/functional/qemu_test/decorators.py b/tests/functional/qemu_test/decorators.py
> > index 1651eb739a..d3a8cf0483 100644
> > --- a/tests/functional/qemu_test/decorators.py
> > +++ b/tests/functional/qemu_test/decorators.py
> > @@ -5,6 +5,7 @@
> >   import importlib
> >   import os
> >   import platform
> > +import sys
> >   from unittest import skipUnless
> >   from .cmd import which
> > @@ -118,3 +119,14 @@ def skipIfMissingImports(*args):
> >       return skipUnless(has_imports, 'required import(s) "%s" not installed' %
> >                                      ", ".join(args))
> > +
> > +'''
> > +Decorator to skip execution of a test on 32-bit targets
> > +Example:
> > +
> > +  @skipIf32BitTarget()
> > +'''
> > +def skipIf32BitTarget():
> > +    enoughBits = sys.maxsize > 2**32
> > +    return skipUnless(enoughBits,
> > +                      'Test requires a host with 64-bit address space')
> 
> skipIf32BitHost?

I don't mind either way.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


