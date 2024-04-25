Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69441C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 07:55:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rztwv-0003R4-MN; Thu, 25 Apr 2024 03:55:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rztwt-0003Qq-RR
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 03:55:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rztwr-0007br-UC
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 03:55:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714031716;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q40HlLHFPulnOaw8gmy5mKlt/x82mzuHQEWXkFvDwLE=;
 b=eBzHD+yntuH1UwtehuTUJ3SIPjCZ//ZJH3yP7/tqfZ+vc1XEU3YnM42GIFMX4UBxAdxOLl
 q4WIToVBZ0O1/8RKJzPbSec8vTkOa3i8sxSWDwTWtGcvnwaOx8okUwA1/eptVTToR+Sb34
 yel/laFt79VAnnYoRb2ASX5GeRNNdz4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-AaYmRy4cOau71j6v8jBtYw-1; Thu, 25 Apr 2024 03:55:12 -0400
X-MC-Unique: AaYmRy4cOau71j6v8jBtYw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 94679804C61;
 Thu, 25 Apr 2024 07:55:12 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.102])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A36B61C0F136;
 Thu, 25 Apr 2024 07:55:11 +0000 (UTC)
Date: Thu, 25 Apr 2024 08:55:09 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>
Subject: Re: [PULL 00/17] CI job updates, header cleanups and other misc
 patches
Message-ID: <ZioMUCj57Ad9qR8k@redhat.com>
References: <20240424075735.248041-1-thuth@redhat.com>
 <d4b2c78e-c8d4-465c-a47e-53aa49efeb06@linaro.org>
 <91090e7f-4972-4473-8378-402c43116dba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <91090e7f-4972-4473-8378-402c43116dba@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.668,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Apr 25, 2024 at 07:11:41AM +0200, Thomas Huth wrote:
> On 24/04/2024 18.21, Richard Henderson wrote:
> > On 4/24/24 00:57, Thomas Huth wrote:
> > > The following changes since commit 13b1e9667737132440f4d500c31cb69320c6b15a:
> > > 
> > >    Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into
> > > staging (2024-04-23 17:35:57 -0700)
> > > 
> > > are available in the Git repository at:
> > > 
> > >    https://gitlab.com/thuth/qemu.git tags/pull-request-2024-04-24
> > > 
> > > for you to fetch changes up to 8f29bab03ea22694a127ee33edeb4ce99eeb124e:
> > > 
> > >    target/s390x: Remove KVM stubs in cpu_models.h (2024-04-24 09:45:02 +0200)
> > > 
> > > ----------------------------------------------------------------
> > > * Update OpenBSD CI image to 7.5
> > > * Update/remove Ubuntu 20.04 CI jobs
> > > * Update CentOS 8 CI jobs to CentOS 9
> > > * Some clean-ups and improvements to travis.yml
> > > * Minor test fixes
> > > * s390x header clean-ups
> > > * Doc updates
> > 
> > This introduces a failure in the migration-compat-x86_64 job:
> > 
> > https://gitlab.com/qemu-project/qemu/-/jobs/6707154868
> 
> It wasn't failing for me:
> 
>  https://gitlab.com/thuth/qemu/-/jobs/6702058896
> 
> And according to the diffstat of my pull request, it's only touching test
> files, docs, and s390x stuff, so I somehow fail to see how it could
> influence x86 migration at a first glance. It also looks like the job is
> running on opensuse, and not on CentOS or Ubuntu, so it should likely not be
> influenced by the changes in this PR.
> 
> Could you please hit the re-run button of that job? If it then passes, we're
> likely rather facing an intermitted failure that might have been introduced
> earlier already...

The specific job that's failiing is the multifd cancellation test.
This is exactly the kind of functional area of migration where
non-deterministic failures are likely to appear. So one for the
migration maintainers to look at most likely.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


