Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77B5BE77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 16:27:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNwof-0000QS-6m; Wed, 18 Dec 2024 11:22:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tNwoZ-0000JJ-Hk
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 11:22:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tNwoW-00078k-T4
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 11:22:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734538939;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ISbvBO2cPuyy0/D1z4sYC8lHZxrGOJO06X1DvBXEZMc=;
 b=ECNRx6aUvZmnZO75EkVDF/gD1fnD8wlMzkkz2BzKYGKdhzVsOK+Dwv2JhSi8344/i0RMTI
 PIkhdKisTVBU6Vym1FJxuy6azAh/qKY9ND0AAj1Lc0d3QmWcA8bTzsL/w4nLAxPZD6FT79
 YTk3TEn4lkiAyCpv5qFTydXl3FH9i5Y=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-486-tup-stqbM0GW4dzeUVKzmA-1; Wed,
 18 Dec 2024 11:22:16 -0500
X-MC-Unique: tup-stqbM0GW4dzeUVKzmA-1
X-Mimecast-MFC-AGG-ID: tup-stqbM0GW4dzeUVKzmA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AAA0119560AB; Wed, 18 Dec 2024 16:22:15 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.61])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7BDC119560AD; Wed, 18 Dec 2024 16:22:14 +0000 (UTC)
Date: Wed, 18 Dec 2024 16:22:11 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] tests/qtest/migration: Restore include for postcopy
Message-ID: <Z2L2syGHfm923PRP@redhat.com>
References: <20241217212201.23376-1-farosas@suse.de> <Z2Hxe0PyVACaKIlZ@x1n>
 <Z2KGUnQIcxZNohzi@redhat.com> <87ldwduit0.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ldwduit0.fsf@suse.de>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

On Wed, Dec 18, 2024 at 12:12:11PM -0300, Fabiano Rosas wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Tue, Dec 17, 2024 at 04:47:39PM -0500, Peter Xu wrote:
> >> On Tue, Dec 17, 2024 at 06:22:01PM -0300, Fabiano Rosas wrote:
> >> > Commit 124a3c58b8 ("tests/qtest/migration: Move ufd_version_check to
> >> > utils") moved the ufd_version_check() function to another file but
> >> > failed to bring along the <sys/syscall> include, which is necessary to
> >> > pull in <asm/unistd.h> for __NR_userfaultd.
> >> > 
> >> > Restore the missing include.
> >> 
> >> Ohhhhhhh.. so postcopy tests will always be skipped as of now?  Maybe worth
> >> explicit mention that in the commit message if so, only when you merge.
> >> 
> >> > 
> >> > While here, remove the ifdef __linux__ that's redundant and fix a
> >> > couple of typos.
> >> > 
> >> > Fixes: 124a3c58b8 ("tests/qtest/migration: Move ufd_version_check to utils")
> >> > Signed-off-by: Fabiano Rosas <farosas@suse.de>
> >> 
> >> Reviewed-by: Peter Xu <peterx@redhat.com>
> >> 
> >> Maybe we don't need to be as careful on old kernels anymore especially in
> >> tests, because userfaultfd syscall existed for ~10 years. So if we want we
> >> can start requiring __NR_userfaultfd present for __linux__, then no way to
> >> miss such spot next time.
> >
> > Yes, I think that check is obsolete, based on our supported platforms
> > list. It would suffice to just check __linux__.
> 
> This breaks the cross builds. It seems the __NR_userfaultfd was actually
> stopping several archs from reaching ufd_version_check(). Since
> <sys/ioctl.h> is under HOST_X86_64, these new instances now fail to find
> the 'ioctl' symbol:
> 
> https://gitlab.com/farosas/qemu/-/pipelines/1594332399
> 
> Of course I could just include <sys/ioctl.h> unconditionally, but the
> fact that new code is not being built means the assumption that we can
> imply __NR_userfaultfd from __linux__ alone is not correct.

I think removing __NR_userfaultfd is still correct. The problem is that
the ufd_version_check code is wrapped in a conditional that is not the
same as the conditional that pulls in ioctl.h. That pre-existing bug
should be fixed regardless, and once that's done, removing __NR_userfaultfd
wouldn't be an issue.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


