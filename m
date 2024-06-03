Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A038CC25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 11:26:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE5oa-0003nw-FN; Mon, 03 Jun 2024 07:25:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sE5oW-0003nO-LE
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 07:25:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sE5oL-0008SU-Jf
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 07:25:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717413906;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=VpxaUYanePWybCmHmCISxh3BIJxJ7U75sAdwr8dPEu0=;
 b=bcskyn/1a/pTqxx/SqSdwXTcR5VnTk8/0ps9V37PYzOo1bVFW5O35Dsa57B4m/2IngqENL
 iATndTPM2LHnpdBCAlnTnNgFsrW9oxWY/1jsG2zzh8J2dpqTR6mfswSQ0Lv4V5KJUAk0fi
 rcfUsDqboGL29yGfgyzT/X6turr5ssI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-492-iVpraRUPMrOUle1pf6foEQ-1; Mon,
 03 Jun 2024 07:25:04 -0400
X-MC-Unique: iVpraRUPMrOUle1pf6foEQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 725353C025AC;
 Mon,  3 Jun 2024 11:25:04 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E3B2A5622;
 Mon,  3 Jun 2024 11:25:03 +0000 (UTC)
Date: Mon, 3 Jun 2024 12:25:01 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Subject: Re: qemu CI & ccache: cache size is too small
Message-ID: <Zl2oDX0AvGacRns5@redhat.com>
References: <4ccbaa65-41cf-4317-9dfb-2c9ab17296d0@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4ccbaa65-41cf-4317-9dfb-2c9ab17296d0@tls.msk.ru>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, May 27, 2024 at 01:49:41PM +0300, Michael Tokarev wrote:
> Hi!
> 
> Noticed today that a rebuild of basically the same tree (a few commits apart)
> in CI result in just 11% hit rate of ccache:
> 
> https://gitlab.com/mjt0k/qemu/-/jobs/6947445337#L5054
> 
> while it should be near 100%.  What's interesting in there is:
> 
> 1) cache size is close to max cache size,
> and more important,
> 2) cleanups performed 78
> 
> so it has to remove old entries before it finished the build.
> 
> So effectively, our ccache usage is an extra burden, not help.

I think this ends up being different per job. If I try the
'build-system-fedora' job, for example, I get a 99% cache
hit rate, and 0.2 GB usage of cache storage

https://gitlab.com/berrange/qemu/-/jobs/6876054586

$ ccache --show-stats
Cacheable calls:   3018 / 3208 (94.08%)
  Hits:              49 / 3018 ( 1.62%)
    Direct:           0 /   49 ( 0.00%)
    Preprocessed:    49 /   49 (100.0%)
  Misses:          2969 / 3018 (98.38%)
Uncacheable calls:  190 / 3208 ( 5.92%)
Local storage:
  Cache size (GB):  0.2 /  0.5 (30.55%)
  Hits:              49 / 3018 ( 1.62%)
  Misses:          2969 / 3018 (98.38%)

If I compare the jobs, the big differences are the target lists:

  CentOS: '--target-list=ppc64-softmmu or1k-softmmu s390x-softmmu x86_64-softmmu rx-softmmu sh4-softmmu'

  Fedora: '--target-list=microblaze-softmmu mips-softmmu xtensa-softmmu m68k-softmmu riscv32-softmmu ppc-softmmu sparc64-softmmu'

And  then a few minor things:

  CentOS: '--disable-nettle' '--enable-gcrypt' '--enable-vfio-user-server' '--enable-modules' '--enable-trace-backends=dtrace'

  Fedora: '--disable-gcrypt' '--enable-nettle'

the crypto won't make a diffeernce to caching. Modules ought not to make a
difference either, as that's just moving some .o files from the exe to a
so, not adding many more exes.

The trace backends will add quite a few .o files, but I'm not sure that
will impact cache.

IOW, I bet the target list has the big difference on the amount of data
that needs to be cached, to explain the different cache usage.

I wonder what the picture looks like for cache hits / cache disk usage
across all the other jobs. Is CentOS an outlier or is FEdora an outlier?

We do want cache to be in the 90+% mark if possible as it has a big impact
on build time.



> I should be increased at least, I think.  But it's actually difficult
> to say really, - is the cache shared between all builds or is it unique
> for each build config?  Because if it the former, it shouldn't even
> work since different ccache versions use different format of the files
> in cache.

It is unique per job per buildtest-template.yml:

  cache:
    paths:
      - ccache
    key: "$CI_JOB_NAME"
    when: always


> What's unique in my pipeline run - I ran just a single build job
> in two pipelines, nothing more.

In my test I ran a job, then re-ran it in the same pipeline.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


