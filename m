Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0310ECA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:49:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usND8-00014i-8U; Sat, 30 Aug 2025 11:09:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1urv27-0004tw-Ho
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 05:04:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1urv25-00047G-5I
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 05:04:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756458267;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bydH/SOrbcnE1uxnXt7t+FMDXMZaKtOFWhX1IELGV+c=;
 b=DVdI7S2eiSYHqZ9LEVhXwzT4XSu7VSCiHtp+GvQdi7MVbcXF0dty69FOTxmQ5yM7I89DoY
 2M3GCrDbWQ+tDAf5tG39Zr8kLndbVIZ1Z52x0qVNc52HtzvQxm1pwOaIteBwZfpVVQZIBS
 nbS7cxvq9KOO8oi8XNN278bSpkwk3eo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-125-OVHL-OErNDCvkiQ0eMK0Eg-1; Fri,
 29 Aug 2025 05:04:22 -0400
X-MC-Unique: OVHL-OErNDCvkiQ0eMK0Eg-1
X-Mimecast-MFC-AGG-ID: OVHL-OErNDCvkiQ0eMK0Eg_1756458261
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 29FE6180036E; Fri, 29 Aug 2025 09:04:21 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.108])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 63F7F180047F; Fri, 29 Aug 2025 09:04:19 +0000 (UTC)
Date: Fri, 29 Aug 2025 10:04:15 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 1/3] tests/functional: enable force refresh of cached
 assets
Message-ID: <aLFtD8B9yIWapvCs@redhat.com>
References: <20250829083156.2570137-1-berrange@redhat.com>
 <20250829083156.2570137-2-berrange@redhat.com>
 <5f7a13e8-3971-442d-88ac-641460d289da@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5f7a13e8-3971-442d-88ac-641460d289da@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, Aug 29, 2025 at 10:50:41AM +0200, Thomas Huth wrote:
> On 29/08/2025 10.31, Daniel P. Berrangé wrote:
> > If the 'QEMU_TEST_REFRESH_CACHE' environment variable is set, then
> > ignore any existing cached asset and download a fresh copy.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >   docs/devel/testing/functional.rst   | 3 +++
> >   tests/functional/qemu_test/asset.py | 4 ++++
> >   2 files changed, 7 insertions(+)
> > 
> > diff --git a/docs/devel/testing/functional.rst b/docs/devel/testing/functional.rst
> > index 3728bab6c0..fdeaebaadc 100644
> > --- a/docs/devel/testing/functional.rst
> > +++ b/docs/devel/testing/functional.rst
> > @@ -312,6 +312,9 @@ The cache is populated in the ``~/.cache/qemu/download`` directory by
> >   default, but the location can be changed by setting the
> >   ``QEMU_TEST_CACHE_DIR`` environment variable.
> > +To force the test suite to re-download the cache, even if still valid,
> > +set the ``QEMU_TEST_REFRESH_CACHE`` environment variable.
> > +
> >   Skipping tests
> >   --------------
> > diff --git a/tests/functional/qemu_test/asset.py b/tests/functional/qemu_test/asset.py
> > index 704b84d0ea..b5a6136d36 100644
> > --- a/tests/functional/qemu_test/asset.py
> > +++ b/tests/functional/qemu_test/asset.py
> > @@ -72,6 +72,10 @@ def _check(self, cache_file):
> >           return self.hash == hl.hexdigest()
> >       def valid(self):
> > +        if os.getenv("QEMU_TEST_REFRESH_CACHE", None) is not None:
> > +            self.log.info("Force refresh of asset %s", self.url)
> > +            return False
> > +
> 
> Do we really need this? You can also simply "rm ~/.cache/qemu/downloads"
> instead, or click on the "Clear runner caches" in the gitlab CI.

This can selectively refresh assets from a single test

  QEMU_TEST_REFRESH_CACHE=1 ./tests/functional/test_blah.py


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


