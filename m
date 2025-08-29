Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76466CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:49:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNCr-00009B-NF; Sat, 30 Aug 2025 11:09:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1urv66-0006YV-B4
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 05:08:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1urv5y-0004jL-O7
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 05:08:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756458508;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3LRun1w+RtPNxJXGPeXD1A1Ywizv4pgYsknnrFow5y8=;
 b=AKyQOrhT5yhnZUQIUBHYeM4ivNdPC5glV8MfBlWe9UX6faVaIGInuXGWvZne3HqF/Ak+yr
 LnsQB6TZ+aFI1TiwAjzGJSo80Fp0zl/kg9IVNYiELSovVxnu6CoZFK+V9/nNgqe7DmmeuP
 q7nKalr3mfrisyKy+HpaRo3JYueUHIw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-gMlLvIaAN66jKpI6A4pUZg-1; Fri,
 29 Aug 2025 05:08:18 -0400
X-MC-Unique: gMlLvIaAN66jKpI6A4pUZg-1
X-Mimecast-MFC-AGG-ID: gMlLvIaAN66jKpI6A4pUZg_1756458497
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 39D94195E928; Fri, 29 Aug 2025 09:08:17 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.108])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BEF7718003FC; Fri, 29 Aug 2025 09:08:15 +0000 (UTC)
Date: Fri, 29 Aug 2025 10:08:12 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 3/3] tests/functional: handle URLError when fetching assets
Message-ID: <aLFt_KcyYpd3CyYt@redhat.com>
References: <20250829083156.2570137-1-berrange@redhat.com>
 <20250829083156.2570137-4-berrange@redhat.com>
 <801f322a-6151-40ab-879a-f64e117d6d04@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <801f322a-6151-40ab-879a-f64e117d6d04@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, Aug 29, 2025 at 11:00:12AM +0200, Thomas Huth wrote:
> On 29/08/2025 10.31, Daniel P. Berrangé wrote:
> > We treat most HTTP errors as non-fatal when fetching assets,
> > but forgot to handle network level errors. This adds catching
> > of URLError so that we retry on failure, and will ultimately
> > trigger graceful skipping in the pre-cache task.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >   tests/functional/qemu_test/asset.py | 9 ++++++++-
> >   1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tests/functional/qemu_test/asset.py b/tests/functional/qemu_test/asset.py
> > index ae2bec3ea5..36f64fe2f6 100644
> > --- a/tests/functional/qemu_test/asset.py
> > +++ b/tests/functional/qemu_test/asset.py
> > @@ -15,7 +15,7 @@
> >   from time import sleep
> >   from pathlib import Path
> >   from shutil import copyfileobj
> > -from urllib.error import HTTPError
> > +from urllib.error import HTTPError, URLError
> >   class AssetError(Exception):
> >       def __init__(self, asset, msg, transient=False):
> > @@ -171,6 +171,13 @@ def fetch(self):
> >                       raise AssetError(self, "Unable to download %s: "
> >                                        "HTTP error %d" % (self.url, e.code))
> >                   continue
> > +            except URLError as e:
> > +                # This is typically a network/service level error
> > +                # eg urlopen error [Errno 110] Connection timed out>
> > +                tmp_cache_file.unlink()
> > +                self.log.error("Unable to download %s: URL error %s",
> > +                               self.url, e)
> > +                continue
> 
> Hmm, I don't think we should retry on each and every URLError. For example
> if you have a typo in the server name, you get a "Name or service not known"
> URLError, and it does not make sense to retry in that case.
> 
> Also, in case of the server being down, it takes a minute or two 'til the
> urllib gives up, so if you retry multiple times in that case, you can easily
> extend the test time by > 5 minutes (as you can see by the timestamps in the
> example in your cover letter), which is unfortunate, too (considering that
> there is also a timeout setting for the gitlab CI jobs).
> 
> I think I'd maybe rather do something like this instead, without retrying
> the download, just marking certain errors as transient:
> 
>        except URLError as e:
>            tmp_cache_file.unlink()
>            msg = str(e.reason)
>            self.log.error("Unable to download %s: URL error %s",
>                           self.url, msg)
>            raise AssetError(self, msg,
>                             transient=("Network is unreachable" in msg))
> 
> WDYT?

Ok, yes, we can do that instead.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


