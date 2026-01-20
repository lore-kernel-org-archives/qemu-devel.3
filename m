Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3D5ED2ECF7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 13:03:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viBNe-0007lC-CQ; Tue, 20 Jan 2026 08:02:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1viBNZ-0007iv-Mb
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 08:02:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1viBNX-0006nj-Jr
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 08:02:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768914156;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=i419UmedxJNwi47NzOOqrMze/NGg8Cf+MF4NiNXDjlo=;
 b=i1UjFlNYV8hB9CCZlTW+r8Ioh3nMY7NXZw8lXhTcCH3HTtwOfUp9eWFiuWRPVnt4tS5+6N
 DHzKXJz2kaFfqO+KqgVLsoAr7MjDMuaT1wbLsJBU1e0Qt05elVj18TaU+Y+pfCZXrdZZgE
 maprXKOESOhI+hJcc7VKcDnvTLrh6kw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-418-TSXepZFKO2-dGLnq9fslag-1; Tue,
 20 Jan 2026 08:02:34 -0500
X-MC-Unique: TSXepZFKO2-dGLnq9fslag-1
X-Mimecast-MFC-AGG-ID: TSXepZFKO2-dGLnq9fslag_1768914153
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8E5541800378; Tue, 20 Jan 2026 13:02:33 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.89])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EFB5C19560AB; Tue, 20 Jan 2026 13:02:31 +0000 (UTC)
Date: Tue, 20 Jan 2026 13:02:28 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH] scripts: Allow sha512 in clean_functional_cache.py, too
Message-ID: <aW985Eq4d70yEPpH@redhat.com>
References: <20260120121849.131604-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260120121849.131604-1-thuth@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.087,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

On Tue, Jan 20, 2026 at 01:18:49PM +0100, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> The functional testing frameworks also supports assets that are
> identified by their sha512 checksum (instead of only using sha25),
> and at least one of the tests (tests/functional/ppc64/test_fadump.py)
> is already using such a checksum, so adjust the clean_functional_cache
> script to support these checksums, too.

I wrote this code to match what we had in Avocado, but now I'm really
struggling to justify why we should choose different checksum algorithms
per asset. With only 1 test diverging from sha256, I'd rather we just
dropped sha512 support 

> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  scripts/clean_functional_cache.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/clean_functional_cache.py b/scripts/clean_functional_cache.py
> index c3370ffbb87..f0342b4b438 100755
> --- a/scripts/clean_functional_cache.py
> +++ b/scripts/clean_functional_cache.py
> @@ -24,8 +24,8 @@
>  os.chdir(cache_dir)
>  
>  for file in cache_dir.iterdir():
> -    # Only consider the files that use a sha256 as filename:
> -    if len(file.name) != 64:
> +    # Only consider the files that use a sha256 or sha512 as filename:
> +    if len(file.name) != 64 and len(file.name) != 128:
>          continue
>  
>      try:
> -- 
> 2.52.0
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


