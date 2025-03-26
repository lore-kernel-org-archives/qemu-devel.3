Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFCD2C36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 10:03:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txNat-0002kB-1K; Wed, 26 Mar 2025 06:02:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1txNaf-0002iI-BE
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 06:02:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1txNaa-0007fQ-IB
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 06:02:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742983342;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9vTDnSdluf85qRXIddzCVrL/jV6PVMzSH1ecbcLXjq0=;
 b=dGN8D5pOoQMHYDbcwQ1vkgKUHvKC6m3atcJRb4jE17cfpTKbJakzU1lUxguPWXI+0Gps6S
 487EkQLr8BfhxS80mNs5XHWZu3SvDPtihb++hxjiZnhh6ZDs5yTPDGV0p9y3MG7DzbmLl4
 hvI9cOKAWpM3MhfJQ3S0UdnFkOTIk9g=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-297-uc_lplQzNmCxDh9ZD5WVjA-1; Wed,
 26 Mar 2025 06:02:21 -0400
X-MC-Unique: uc_lplQzNmCxDh9ZD5WVjA-1
X-Mimecast-MFC-AGG-ID: uc_lplQzNmCxDh9ZD5WVjA_1742983340
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 36FD119373D7; Wed, 26 Mar 2025 10:02:20 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.107])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EE13B3001D0F; Wed, 26 Mar 2025 10:02:15 +0000 (UTC)
Date: Wed, 26 Mar 2025 10:02:06 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 11/15] tests/functional: Use the tuxrun kernel for the
 x86 replay test
Message-ID: <Z-PQnj6U8Iw3wgqr@redhat.com>
References: <20250325200026.344006-1-thuth@redhat.com>
 <20250325200026.344006-12-thuth@redhat.com>
 <Z-PMVMTP-Z5A_FMc@redhat.com>
 <3e312b77-6683-4d4f-a300-831c2f140e9d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3e312b77-6683-4d4f-a300-831c2f140e9d@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, Mar 26, 2025 at 10:54:53AM +0100, Thomas Huth wrote:
> On 26/03/2025 10.43, Daniel P. Berrangé wrote:
> > On Tue, Mar 25, 2025 at 09:00:19PM +0100, Thomas Huth wrote:
> > > From: Thomas Huth <thuth@redhat.com>
> > > 
> > > This way we can do a full boot in record-replay mode and
> > > should get a similar test coverage compared to the old
> > > replay test from tests/avocado/replay_linux.py. Thus remove
> > > the x86 avocado replay_linux test now.
> > > 
> > > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > > ---
> > >   tests/avocado/replay_linux.py          | 46 --------------------------
> > >   tests/functional/test_x86_64_replay.py | 43 ++++++++++++++++++------
> > >   2 files changed, 33 insertions(+), 56 deletions(-)
> > 
> > Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> > 
> > > diff --git a/tests/functional/test_x86_64_replay.py b/tests/functional/test_x86_64_replay.py
> > > index 180f23a60c5..27287d452dc 100755
> > > --- a/tests/functional/test_x86_64_replay.py
> > > +++ b/tests/functional/test_x86_64_replay.py
> > > @@ -5,30 +5,53 @@
> > >   #
> > >   # SPDX-License-Identifier: GPL-2.0-or-later
> > > -from qemu_test import Asset, skipFlakyTest
> > > +from subprocess import check_call, DEVNULL
> > > +
> > > +from qemu_test import Asset, skipFlakyTest, get_qemu_img
> > >   from replay_kernel import ReplayKernelBase
> > >   class X86Replay(ReplayKernelBase):
> > >       ASSET_KERNEL = Asset(
> > > -         ('https://archives.fedoraproject.org/pub/archive/fedora/linux'
> > > -          '/releases/29/Everything/x86_64/os/images/pxeboot/vmlinuz'),
> > > -        '8f237d84712b1b411baf3af2aeaaee10b9aae8e345ec265b87ab3a39639eb143')
> > > +        'https://storage.tuxboot.com/buildroot/20241119/x86_64/bzImage',
> > > +        'f57bfc6553bcd6e0a54aab86095bf642b33b5571d14e3af1731b18c87ed5aef8')
> > > +
> > > +    ASSET_ROOTFS = Asset(
> > > +        'https://storage.tuxboot.com/buildroot/20241119/x86_64/rootfs.ext4.zst',
> > > +        '4b8b2a99117519c5290e1202cb36eb6c7aaba92b357b5160f5970cf5fb78a751')
> > 
> > 
> > As a general question, I wonder if we want to add some logic to the
> > pre-cache job to clean up old cached files.
> 
> Yes, I also asked myself that question already. Being a "cache", there
> should also be a way to evict old files that are not used anymore.
> Maybe we could update the timestamp of the assets each time they are used,
> and when doing "make clean", we also check the cache and delete the assets
> with timestamps older than 6 months or so?

Yeah, some time based check + "touch" would be needed, so we don't
aggressively purge files cached by a dev's use a different branch
that happens to not be checked out currently.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


