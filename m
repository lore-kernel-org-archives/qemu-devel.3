Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F2EBCCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 17:45:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7H9a-000421-Vn; Fri, 10 Oct 2025 13:43:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v7H9T-0003qu-2L
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 13:43:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v7H9M-0007mH-3T
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 13:43:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760118204;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/18YaFIQVuCbEF7pBmW9yAM6E4nzTXdGihiMT21Ls/U=;
 b=cSs7nQpvLMH79A/Er3nJqJ4UJ1jmhbetDd74KjPFNenAEuHMDLI5A8ZwBSIRu7SA8A/fIe
 cynBzgXFHRgoVGFyM1R0urbEPEk3muTc91K8IOU6cPMkpBcKf7wFrhInRzyadVoVMlpw59
 paO7DLI0Vxco0FfZLO4jzTzuAoh3Bq8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-79-uXcaowtXNsWqR4MkOckgNQ-1; Fri,
 10 Oct 2025 13:43:20 -0400
X-MC-Unique: uXcaowtXNsWqR4MkOckgNQ-1
X-Mimecast-MFC-AGG-ID: uXcaowtXNsWqR4MkOckgNQ_1760118198
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A46831800366; Fri, 10 Oct 2025 17:43:18 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.177])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 066401955F22; Fri, 10 Oct 2025 17:43:15 +0000 (UTC)
Date: Fri, 10 Oct 2025 18:43:12 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Yonggang Luo <luoyonggang@gmail.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Thomas Huth <thuth@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH] gitlab: purge msys pacman cache
Message-ID: <aOlFsILuVDwO_ISY@redhat.com>
References: <20251010160545.144760-1-berrange@redhat.com>
 <CAFEAcA-9WfE_vNKewpe=05bLs+mi8tQSN-3cYnAWwC0ErfQBmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA-9WfE_vNKewpe=05bLs+mi8tQSN-3cYnAWwC0ErfQBmA@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, Oct 10, 2025 at 06:23:22PM +0100, Peter Maydell wrote:
> On Fri, 10 Oct 2025 at 17:05, Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > For the Windows msys2 CI job we install many packages using pacman
> > and use the GitLab cache to preserve the pacman cache across CI
> > runs. While metadata still needs downloading, this avoids pacman
> > re-downloading packages from msys2 if they have not changed.
> >
> > The problem is that pacman never automatically purges anything
> > from its package cache. Thus the GitLab cache is growing without
> > bound and packing/unpacking the cache is consuming an increasing
> > amount of time in the CI job.
> >
> > If we run 'pacman -Sc' /after/ installing our desired package set,
> > it will purge any cached downloaded packages that are not matching
> > any installed package.
> >
> > This will (currently) cap the pacman download cache at approx
> > 256 MB.
> >
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  .gitlab-ci.d/windows.yml | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > See a test job with this change, plus a find across the msys
> > pacman cache, showing the cleanup effects....
> >
> > Before cleanup:
> >
> >   https://gitlab.com/berrange/qemu/-/jobs/11679136531#L34
> >
> > After cleanup:
> >
> >   https://gitlab.com/berrange/qemu/-/jobs/11679136531#L1126
> >
> > diff --git a/.gitlab-ci.d/windows.yml b/.gitlab-ci.d/windows.yml
> > index 1e6a01bd9a..6e1135d8b8 100644
> > --- a/.gitlab-ci.d/windows.yml
> > +++ b/.gitlab-ci.d/windows.yml
> > @@ -87,6 +87,7 @@ msys2-64bit:
> >        mingw-w64-x86_64-pkgconf
> >        mingw-w64-x86_64-python
> >        mingw-w64-x86_64-zstd"
> > +  - .\msys64\usr\bin\bash -lc "pacman -Sc --noconfirm"
> >    - Write-Output "Running build at $(Get-Date -Format u)"
> >    - $env:JOBS = $(.\msys64\usr\bin\bash -lc nproc)
> >    - $env:CHERE_INVOKING = 'yes'  # Preserve the current working directory
> > --
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> 
> Hopefully this will make the CI job take less time (for the
> record, currently in the main CI run it takes about 70 minutes,
> of which 10 minutes is "unpack the cache" at the start and
> 20 minutes is "repack the cache" at the end).

Based on how long it takes to pack/unpack the cache in my job, I'd
be expecting approx a 25 minute win.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


