Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDDEECCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 13:21:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vApoa-0002Bg-2m; Mon, 20 Oct 2025 09:20:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vApoZ-0002BX-BB
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 09:20:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vApoW-0008BJ-J7
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 09:20:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760966438;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IpnF960+6CGuLH1X6v40Yed840a6YV3pFrj7DZy6r/U=;
 b=cPvizTuthCpGEDs2LFxUzbJPG11z88C5U61J178xKM/TDmPRM2b9N6dyyND5iYpieMA4nX
 juCTkSscoPhr2ViyOn7h0beOA9qIM0rlkOiGlim7jfAPJiSoZXWKdBlAuVgHglvQirzFBl
 c3bnohniI5SpVccVTfcY5gykYqfG/CI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-407-5fex-ADhM9aOYjkOAcX2SQ-1; Mon,
 20 Oct 2025 09:20:34 -0400
X-MC-Unique: 5fex-ADhM9aOYjkOAcX2SQ-1
X-Mimecast-MFC-AGG-ID: 5fex-ADhM9aOYjkOAcX2SQ_1760966433
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0356618089A7; Mon, 20 Oct 2025 13:20:33 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.161])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E47361800577; Mon, 20 Oct 2025 13:20:30 +0000 (UTC)
Date: Mon, 20 Oct 2025 14:20:27 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Yonggang Luo <luoyonggang@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] gitlab-ci: Decrease the size of the compiler cache
Message-ID: <aPY3G18F212idDgd@redhat.com>
References: <20251020085431.23968-1-thuth@redhat.com>
 <aPX-6dp65xXGtxja@redhat.com>
 <22f12636-bfcf-47b6-9c61-9fd120bafdb4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <22f12636-bfcf-47b6-9c61-9fd120bafdb4@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Mon, Oct 20, 2025 at 03:18:33PM +0200, Thomas Huth wrote:
> On 20/10/2025 11.20, Daniel P. Berrangé wrote:
> > On Mon, Oct 20, 2025 at 10:54:31AM +0200, Thomas Huth wrote:
> > > From: Thomas Huth <thuth@redhat.com>
> > > 
> > > Uploading the cache from the runner takes a long time in the MSYS2
> > > job, mostly due to the size of the compiler cache.
> > > However, looking at runs with a non-initialized cache, and by doing
> > > a "du -sh ." in the build directory, it seems like a build only
> > > takes about 236 MiB of data, so the compiler cache with 500 MiB
> > > certainly contains a lot of stale files. Thus decrease the size of
> > > the ccache to a more reasonable value to speed up the MSYS2 job in
> > > our CI (and add a "du -sh" at the end to have a reference for the
> > > required cache size in the future).
> > > 
> > > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > > ---
> > >   Looking at the latest runs in the CI, our recent attempt to decrease
> > >   the cache size by cleaning the pacman cache did not help much:
> > >   https://gitlab.com/qemu-project/qemu/-/jobs/11747329283
> > >   ... that run contains the "pacman -Sc" command, but the "Saving cache
> > >   for successful job" step at the end still takes close to 20 minutes.
> > >   So we likely have to shrink the compiler cache, too. In this run here:
> > >   https://gitlab.com/thuth/qemu/-/jobs/11770708859#L1769
> > >   I added a "du -sh" and you can see that the build directory only
> > >   takes 236 MB there. So a ccache with the size of 250M should be
> > >   sufficient for the MSYS2 job.
> > 
> > FWIW, in my fork I see
> > 
> > Cacheable calls:   638 / 647 (98.61%)
> >    Hits:            629 / 638 (98.59%)
> >      Direct:        629 / 629 (100.0%)
> >      Preprocessed:    0 / 629 ( 0.00%)
> >    Misses:            9 / 638 ( 1.41%)
> > Uncacheable calls:   9 / 647 ( 1.39%)
> > Local storage:
> >    Cache size (GB): 0.1 / 0.5 (29.54%)
> >    Hits:            629 / 638 (98.59%)
> >    Misses:            9 / 638 ( 1.41%)
> > 
> > IOW, even ~160 MB is sufficient for 99% cache hit, so 250 MB is
> > about 2/3rds spare headroom.
> 
> Good point. So 250 MB will likely still waste time with unnecessary uploads.
> 
> Some few MBs headroom likely still make sense in case we compile more code
> in the future, so maybe we should use something like 180 MB for the cache
> size?

Yeah, 180 MB, and we can look at cache hit rate every now & then
to see if we're exceeding it.

> > I wonder if we shouldn't recursively list the msys64 cache as a debug
> > aid ?
> 
> I agree, we likely should at least temporarily add that to debug the issue.
> Do you want to send a patch, or want me to do it?

I'll let you.

> > >   .gitlab-ci.d/windows.yml | 3 ++-
> > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/.gitlab-ci.d/windows.yml b/.gitlab-ci.d/windows.yml
> > > index 6e1135d8b86..e2fef543899 100644
> > > --- a/.gitlab-ci.d/windows.yml
> > > +++ b/.gitlab-ci.d/windows.yml
> > > @@ -94,7 +94,7 @@ msys2-64bit:
> > >     - $env:MSYS = 'winsymlinks:native' # Enable native Windows symlink
> > >     - $env:CCACHE_BASEDIR = "$env:CI_PROJECT_DIR"
> > >     - $env:CCACHE_DIR = "$env:CCACHE_BASEDIR/ccache"
> > > -  - $env:CCACHE_MAXSIZE = "500M"
> > > +  - $env:CCACHE_MAXSIZE = "250M"
> > >     - $env:CCACHE_DEPEND = 1 # cache misses are too expensive with preprocessor mode
> > >     - $env:CC = "ccache gcc"
> > >     - mkdir build
> > > @@ -103,5 +103,6 @@ msys2-64bit:
> > >     - ..\msys64\usr\bin\bash -lc "../configure $CONFIGURE_ARGS"
> > >     - ..\msys64\usr\bin\bash -lc "make -j$env:JOBS"
> > >     - ..\msys64\usr\bin\bash -lc "make check MTESTARGS='$TEST_ARGS' || { cat meson-logs/testlog.txt; exit 1; } ;"
> > > +  - ..\msys64\usr\bin\bash -lc "du -sh ."
> > 
> > Do we want to keep this in the final commit ?
> > > We have ccache size printed, and we could do with msys64/var/cache
> > size being printed at least.
> 
> Well, the cache can collect stale garbage, as you can currently see in the
> CI jobs of the qemu-project, but the build folder should give you a very
> clear picture of how many MiBs of object code are really necessary, so I'd
> prefer to keep it (at least for a while).

Ok

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


