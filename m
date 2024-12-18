Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CB11E77183
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 08:24:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNpKy-0006h7-IV; Wed, 18 Dec 2024 03:23:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tNpKs-0006go-MV
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 03:23:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tNpKq-0002kN-RJ
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 03:23:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734510189;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=CMG0BuNFUSNQu+0OpuDh9un1TA3STho6EeJwGU16lmY=;
 b=Ji8aXemWgZcKsixq/s+98VCovuTSZQnP8wxb0imvF6InF0CIGE0dF9rnbR2LI4mX/Y2oQD
 YvelJTgCvOMd/7XXY2LGg5uIxbP0lEWQ4jO2uFgPdowSCOJ3uWxAjnpyO51ggWyfSzkjdS
 ziJ8Wxpt/+0mBm6lI6FK7cWBnDjKyZY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-JIQA4E7fMrqkojuoL_Z7SA-1; Wed,
 18 Dec 2024 03:23:05 -0500
X-MC-Unique: JIQA4E7fMrqkojuoL_Z7SA-1
X-Mimecast-MFC-AGG-ID: JIQA4E7fMrqkojuoL_Z7SA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BEE871955DCD; Wed, 18 Dec 2024 08:23:04 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.61])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9B3DB300F9B5; Wed, 18 Dec 2024 08:23:02 +0000 (UTC)
Date: Wed, 18 Dec 2024 08:22:58 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Subject: Re: [PATCH] tests/qtest/migration: Restore include for postcopy
Message-ID: <Z2KGUnQIcxZNohzi@redhat.com>
References: <20241217212201.23376-1-farosas@suse.de>
 <Z2Hxe0PyVACaKIlZ@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z2Hxe0PyVACaKIlZ@x1n>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

On Tue, Dec 17, 2024 at 04:47:39PM -0500, Peter Xu wrote:
> On Tue, Dec 17, 2024 at 06:22:01PM -0300, Fabiano Rosas wrote:
> > Commit 124a3c58b8 ("tests/qtest/migration: Move ufd_version_check to
> > utils") moved the ufd_version_check() function to another file but
> > failed to bring along the <sys/syscall> include, which is necessary to
> > pull in <asm/unistd.h> for __NR_userfaultd.
> > 
> > Restore the missing include.
> 
> Ohhhhhhh.. so postcopy tests will always be skipped as of now?  Maybe worth
> explicit mention that in the commit message if so, only when you merge.
> 
> > 
> > While here, remove the ifdef __linux__ that's redundant and fix a
> > couple of typos.
> > 
> > Fixes: 124a3c58b8 ("tests/qtest/migration: Move ufd_version_check to utils")
> > Signed-off-by: Fabiano Rosas <farosas@suse.de>
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>
> 
> Maybe we don't need to be as careful on old kernels anymore especially in
> tests, because userfaultfd syscall existed for ~10 years. So if we want we
> can start requiring __NR_userfaultfd present for __linux__, then no way to
> miss such spot next time.

Yes, I think that check is obsolete, based on our supported platforms
list. It would suffice to just check __linux__.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


