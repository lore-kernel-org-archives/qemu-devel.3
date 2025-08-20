Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FE51CA0EDC
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 13:34:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoiwy-0000e3-TA; Wed, 20 Aug 2025 09:34:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uoiwx-0000dM-TB
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 09:33:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uoiwu-0005Ou-Ez
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 09:33:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755696834;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LkHaAWokt3SG+lmggr9/bgCZDZNGB6MpymynMjKSjis=;
 b=aObg2nbWaKw+9HGqIs9UZQK1z944u2guUQjunxWom0xGPu8yrGniFwsH/BJE4kaXZa3Cqm
 d/y0FSr3+zu1nbbLGVaVF4f3iG9Vkp6w5bSU0UeMmPHA8X4H1OD/tS/2A3KxnFCt9EVFza
 /QE2TNh7LK5weYYtinQ1QAx6xPQ8hFg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-lWv8fvdQP5OtnhfMaLLmXg-1; Wed,
 20 Aug 2025 09:33:51 -0400
X-MC-Unique: lWv8fvdQP5OtnhfMaLLmXg-1
X-Mimecast-MFC-AGG-ID: lWv8fvdQP5OtnhfMaLLmXg_1755696830
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 33CF31954B13; Wed, 20 Aug 2025 13:33:50 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.164])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E64CC180044F; Wed, 20 Aug 2025 13:33:47 +0000 (UTC)
Date: Wed, 20 Aug 2025 14:33:44 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PULL 0/2] Python patches
Message-ID: <aKXOuFYHLi_I1KLB@redhat.com>
References: <20250820045816.1142190-1-jsnow@redhat.com>
 <CAFn=p-bSh9kr2OOv0vq8H+quuUSww5NeV8LYBy2MKr-b82P2kA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFn=p-bSh9kr2OOv0vq8H+quuUSww5NeV8LYBy2MKr-b82P2kA@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Aug 20, 2025 at 01:01:06AM -0400, John Snow wrote:
> On Wed, Aug 20, 2025 at 12:58 AM John Snow <jsnow@redhat.com> wrote:
> >
> > The following changes since commit 5836af0783213b9355a6bbf85d9e6bc4c9c9363f:
> >
> >   Merge tag 'uefi-20250812-pull-request' of https://gitlab.com/kraxel/qemu into staging (2025-08-13 15:19:29 -0400)
> >
> > are available in the Git repository at:
> >
> >   https://gitlab.com/jsnow/qemu.git tags/python-pull-request
> >
> > for you to fetch changes up to 16398e73cd13c7d9f284d8ec4a440778fc2e3f9a:
> >
> >   python: avoid deprecation warning with get_event_loop (2025-08-20 00:55:27 -0400)
> >
> > ----------------------------------------------------------------
> > Python pull request
> >
> > Necessary for Python 3.14 support for iotests, releasing October 7th
> >
> > ----------------------------------------------------------------
> >
> > Daniel P. Berrangé (1):
> >   python: avoid deprecation warning with get_event_loop
> >
> > Richard W.M. Jones (1):
> >   python: Replace asyncio.get_event_loop for Python 3.14
> >
> >  python/qemu/qmp/legacy.py  | 10 +++++++++-
> >  python/qemu/qmp/qmp_tui.py |  2 +-
> >  python/tests/protocol.py   |  2 +-
> >  3 files changed, 11 insertions(+), 3 deletions(-)
> >
> > --
> > 2.50.1
> >
> 
> Dan: I wasn't sure if you were suggesting these to be pulled *right
> away*, but just in case that is what you meant, I sent this PR for
> what I think is the minimum necessary to avoid iotests croaking when
> 3.14 drops in October. Let me know if we need to make any other
> adjustments here and I will follow up in the morning.

Only the 1st patch is important for the 10.1.0 release - the 2nd patch
doesn't take effect until the rest of my py series that explicitly
turns on warnings for iotests/functional tests.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


