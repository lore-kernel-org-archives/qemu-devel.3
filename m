Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E037CCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 09:21:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAm4e-0005Ni-7S; Mon, 20 Oct 2025 05:21:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vAm4Z-0005NQ-6j
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 05:21:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vAm4V-0006av-KD
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 05:20:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760952051;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=PmjvDPuE1H6ZPCE6uWR3s5XS9Yeu8TcPutCr0BqztjI=;
 b=gmhXjN1tQ5hWHUVMXFJFvv+embo8LFCrSFUlB3FBHLj6pXH5rknfsru+Aj4z9uibOTT8pg
 QqAsy12TyieB50xZ0aa8HBbF+abDViNnM259oq7jUkMfnm4xZH4VI+V9DJqjXeT/ZCzOeg
 T7Zlhh4ic+Lg1SiPeFOKo3TXHFOZbxY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-1-R1athjHINOisAUPL8JVCXg-1; Mon,
 20 Oct 2025 05:20:47 -0400
X-MC-Unique: R1athjHINOisAUPL8JVCXg-1
X-Mimecast-MFC-AGG-ID: R1athjHINOisAUPL8JVCXg_1760952046
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3E14A18001D1; Mon, 20 Oct 2025 09:20:46 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.161])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 981CA180044F; Mon, 20 Oct 2025 09:20:44 +0000 (UTC)
Date: Mon, 20 Oct 2025 10:20:41 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Yonggang Luo <luoyonggang@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] gitlab-ci: Decrease the size of the compiler cache
Message-ID: <aPX-6dp65xXGtxja@redhat.com>
References: <20251020085431.23968-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251020085431.23968-1-thuth@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, Oct 20, 2025 at 10:54:31AM +0200, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> Uploading the cache from the runner takes a long time in the MSYS2
> job, mostly due to the size of the compiler cache.
> However, looking at runs with a non-initialized cache, and by doing
> a "du -sh ." in the build directory, it seems like a build only
> takes about 236 MiB of data, so the compiler cache with 500 MiB
> certainly contains a lot of stale files. Thus decrease the size of
> the ccache to a more reasonable value to speed up the MSYS2 job in
> our CI (and add a "du -sh" at the end to have a reference for the
> required cache size in the future).
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  Looking at the latest runs in the CI, our recent attempt to decrease
>  the cache size by cleaning the pacman cache did not help much:
>  https://gitlab.com/qemu-project/qemu/-/jobs/11747329283
>  ... that run contains the "pacman -Sc" command, but the "Saving cache
>  for successful job" step at the end still takes close to 20 minutes.
>  So we likely have to shrink the compiler cache, too. In this run here:
>  https://gitlab.com/thuth/qemu/-/jobs/11770708859#L1769
>  I added a "du -sh" and you can see that the build directory only
>  takes 236 MB there. So a ccache with the size of 250M should be
>  sufficient for the MSYS2 job.

FWIW, in my fork I see

Cacheable calls:   638 / 647 (98.61%)
  Hits:            629 / 638 (98.59%)
    Direct:        629 / 629 (100.0%)
    Preprocessed:    0 / 629 ( 0.00%)
  Misses:            9 / 638 ( 1.41%)
Uncacheable calls:   9 / 647 ( 1.39%)
Local storage:
  Cache size (GB): 0.1 / 0.5 (29.54%)
  Hits:            629 / 638 (98.59%)
  Misses:            9 / 638 ( 1.41%)

IOW, even ~160 MB is sufficient for 99% cache hit, so 250 MB is
about 2/3rds spare headroom.

If I look at the saving cache part in my fork job I see:

  msys64/var/cache: found 284 matching artifact files and directories 
  ccache: found 12825 matching artifact files and directories 

while in QEMU job I see

  msys64/var/cache: found 342 matching artifact files and directories 
  ccache: found 46881 matching artifact files and directories 

so the ccache usage is almost x4 bigger in terms of # of files, so
that does likely account for a good portion of the time.

I'm surprised the msys64/var/cache is still bigger than my fork though,
as I would have expected them to be basically the same.

I wonder if we shouldn't recursively list the msys64 cache as a debug
aid ?

>  .gitlab-ci.d/windows.yml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/.gitlab-ci.d/windows.yml b/.gitlab-ci.d/windows.yml
> index 6e1135d8b86..e2fef543899 100644
> --- a/.gitlab-ci.d/windows.yml
> +++ b/.gitlab-ci.d/windows.yml
> @@ -94,7 +94,7 @@ msys2-64bit:
>    - $env:MSYS = 'winsymlinks:native' # Enable native Windows symlink
>    - $env:CCACHE_BASEDIR = "$env:CI_PROJECT_DIR"
>    - $env:CCACHE_DIR = "$env:CCACHE_BASEDIR/ccache"
> -  - $env:CCACHE_MAXSIZE = "500M"
> +  - $env:CCACHE_MAXSIZE = "250M"
>    - $env:CCACHE_DEPEND = 1 # cache misses are too expensive with preprocessor mode
>    - $env:CC = "ccache gcc"
>    - mkdir build
> @@ -103,5 +103,6 @@ msys2-64bit:
>    - ..\msys64\usr\bin\bash -lc "../configure $CONFIGURE_ARGS"
>    - ..\msys64\usr\bin\bash -lc "make -j$env:JOBS"
>    - ..\msys64\usr\bin\bash -lc "make check MTESTARGS='$TEST_ARGS' || { cat meson-logs/testlog.txt; exit 1; } ;"
> +  - ..\msys64\usr\bin\bash -lc "du -sh ."

Do we want to keep this in the final commit ?

We have ccache size printed, and we could do with msys64/var/cache
size being printed at least.

>    - ..\msys64\usr\bin\bash -lc "ccache --show-stats"
>    - Write-Output "Finished build at $(Get-Date -Format u)"

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


