Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E702C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 13:39:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trzoW-0004OB-Np; Tue, 11 Mar 2025 09:38:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1trzoD-0004IW-03
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 09:38:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1trzoA-0007Xs-La
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 09:38:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741700285;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=CmH4UWqzvKXhz+3B+gkShkU3fk8fM4/nO0mchW+R/Ro=;
 b=gRymaSOqwz+DFkFKcBsJ5hspmxKRiUKkO9AuA4AQeFThMtdgT+evN9K8LeKgtLTtXtEtEf
 NAyIlta6G2j+Y7KjorHK8ZRfjVfqRIz2QVsLr7OVP7fQnijWFRQbKp40IO37JIBh88ZULr
 uNp/tyIY2qvkQM3IoXN98Rtjomd9z8k=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-297-qYhoSKNuP4K3aXJrfOAT9w-1; Tue,
 11 Mar 2025 09:38:02 -0400
X-MC-Unique: qYhoSKNuP4K3aXJrfOAT9w-1
X-Mimecast-MFC-AGG-ID: qYhoSKNuP4K3aXJrfOAT9w_1741700281
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D856E195608A; Tue, 11 Mar 2025 13:38:00 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.44])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 48DE71956094; Tue, 11 Mar 2025 13:37:59 +0000 (UTC)
Date: Tue, 11 Mar 2025 13:37:55 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Subject: Re: [RFC PATCH] tests/functional: Don't fail any precaching errors
Message-ID: <Z9A8swNn6zBm57jC@redhat.com>
References: <20250311131327.903329-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250311131327.903329-1-npiggin@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Mar 11, 2025 at 11:13:26PM +1000, Nicholas Piggin wrote:
> The NetBSD archive is currently failing part-way through downloads,
> which results in no clean HTTP error but a short transfer and checksum
> error. This is treated as fatal in the precache download, and it halts
> an entire set of tests even if some others could run.
> 
> I hacked up this patch to get a bunch of CI tests going again for ppc
> merge testing.
> 
> Don't treat any precaching failures as errors.
> This causes tests to be skipped when they try to fetch their asset.
> Some CI results before/after patching:
> 
> functional-system-fedora
> https://gitlab.com/npiggin/qemu/-/jobs/9370860490 #bad
> https://gitlab.com/npiggin/qemu/-/jobs/9373246826 #good
> 
> functional-system-debian
> https://gitlab.com/npiggin/qemu/-/jobs/9370860479 #bda
> https://gitlab.com/npiggin/qemu/-/jobs/9373246822 #good
> 
> This is making the tests skip. Is there a way to make the error more
> prominent / obvious in the output? Should they fail instead? I think
> there should be a more obvious indication of failure due to asset so
> it does not go unnoticed.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  tests/functional/qemu_test/asset.py | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/tests/functional/qemu_test/asset.py b/tests/functional/qemu_test/asset.py
> index f0730695f09..3134ccb10da 100644
> --- a/tests/functional/qemu_test/asset.py
> +++ b/tests/functional/qemu_test/asset.py
> @@ -174,14 +174,11 @@ def precache_test(test):
>                  try:
>                      asset.fetch()
>                  except HTTPError as e:
> -                    # Treat 404 as fatal, since it is highly likely to
> -                    # indicate a broken test rather than a transient
> -                    # server or networking problem
> -                    if e.code == 404:
> -                        raise
> -

Why are you removing this ? The commit above does not make any reference
to the problem being a missing URL (404 code). We want missing URLs to
be fatal so that we identify when images we rely on are deleted by their
host, as that is not a transient problem.

>                      log.debug(f"HTTP error {e.code} from {asset.url} " +
>                                "skipping asset precache")
> +                except:
> +                    log.debug(f"Error from {asset.url} " +
> +                              "skipping asset precache")

So is the bit that actually deals with the exception you show in the
jobs above.

Best practice would be for us to define an 'AssetException' and use that
in assert.py when raising exceptions, or to wrap other exceptions in cases
where we propagate exceptions. Then this code can be move tailored to
catch AssetException, instead of Exception.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


