Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A14ACCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 09:55:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v79p5-0006AF-IM; Fri, 10 Oct 2025 05:54:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v79p3-00069x-0K
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 05:54:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v79os-0000HF-CN
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 05:54:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760090028;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7LJrPUijFoFApN5f+UiTkSQu9DWkD/jQJVQbentyGwo=;
 b=GqYKIJYSn4RD7/fTpKYo7J5F2M1Uv3cZkazOnsq67KeemBiQ/jW6HXhD468gTBwJ/njByg
 rqCrlOAV+Fzal//iV+O6R4HAOE+tda9T9bYLvZ8kQxuNv35xAON2vTkIxbVImWpevtnytN
 BIUOAyrIfSMXRpVLrR1EarYk3arWXik=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-lwXYzCd4PvGTVkN9Z32Njw-1; Fri,
 10 Oct 2025 05:53:47 -0400
X-MC-Unique: lwXYzCd4PvGTVkN9Z32Njw-1
X-Mimecast-MFC-AGG-ID: lwXYzCd4PvGTVkN9Z32Njw_1760090026
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3C22519560AA; Fri, 10 Oct 2025 09:53:46 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.177])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C1A04180035E; Fri, 10 Oct 2025 09:53:43 +0000 (UTC)
Date: Fri, 10 Oct 2025 10:53:38 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 1/2] tests/functional: Set current time stamp of assets
 when using them
Message-ID: <aOjXokhfml2QZzJc@redhat.com>
References: <20251010093244.807544-1-thuth@redhat.com>
 <20251010093244.807544-2-thuth@redhat.com>
 <aOjUPd5pu1C0sDaf@redhat.com>
 <906535c5-515d-4960-b633-63b137f5f635@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <906535c5-515d-4960-b633-63b137f5f635@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Oct 10, 2025 at 11:46:44AM +0200, Thomas Huth wrote:
> On 10/10/2025 11.39, Daniel P. Berrangé wrote:
> > On Fri, Oct 10, 2025 at 11:32:42AM +0200, Thomas Huth wrote:
> > > From: Thomas Huth <thuth@redhat.com>
> > > 
> > > We are going to remove obsolete assets from the cache, so keep
> > > the time stamps of the assets that we use up-to-date to have a way
> > > to detect stale assets later.
> > > 
> > > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > > ---
> > >   tests/functional/qemu_test/asset.py | 8 ++++++++
> > >   1 file changed, 8 insertions(+)
> > > 
> > > diff --git a/tests/functional/qemu_test/asset.py b/tests/functional/qemu_test/asset.py
> > > index 2971a989d1e..251953ed99f 100644
> > > --- a/tests/functional/qemu_test/asset.py
> > > +++ b/tests/functional/qemu_test/asset.py
> > > @@ -10,6 +10,7 @@
> > >   import os
> > >   import stat
> > >   import sys
> > > +import time
> > >   import unittest
> > >   import urllib.request
> > >   from time import sleep
> > > @@ -113,6 +114,11 @@ def _wait_for_other_download(self, tmp_cache_file):
> > >           self.log.debug("Time out while waiting for %s!", tmp_cache_file)
> > >           raise
> > > +    def _save_time_stamp(self):
> > > +        with open(self.cache_file.with_suffix(".stamp"), 'w',
> > > +                  encoding='utf-8') as fh:
> > > +            fh.write(f"{int(time.time())}")
> > 
> > Rather than creating a parallel timestamp file, it feels like we could
> > just call  'os.utime(self.cache_file)' which will set atime + mtime
> > to the current timestamp, which we can check later with os.stat().
> 
> That was my first idea, too (sorry, I should maybe have mentioned it in the
> patch description), but it does not work: In the gitlab CI runners, the
> files get re-initialized from the runners cache each time the functional
> test job is started, so the atime and mtime is always close to the the
> current date there --> we would never expire files in the gitlab CI that
> way.

Oh well, I had assumed gitlab would preserve timestamps when taring/untaring
files for the cache :-(


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


