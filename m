Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E849CCD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 11:18:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXGwB-0000jN-VF; Wed, 10 Jun 2026 07:17:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wXGwA-0000iv-0t
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 07:17:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wXGw8-0007TR-97
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 07:17:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781090250;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JOa7c7rV0I5WUwK1Qothjc/fSkhHYYMl40+wtGAdDM0=;
 b=WeZ9YHTZkv1f9jc09LRR1Zr6oTo/tYYwoY3WqRDdahpu1YzXiV34g9Wzy7OFZnXRiwn455
 2xgLArepzomuqAX4vkxK9vsrpXHEs5ytEBplv1W/6V+gQwe1PiPBpenvfdAQ5JfFP1Y4qx
 5gcHDCmYQ6DC8b508wd+0MsU9B5VTZM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-1FsgB4RdMl6EeiWtSJXRfw-1; Wed,
 10 Jun 2026 07:17:26 -0400
X-MC-Unique: 1FsgB4RdMl6EeiWtSJXRfw-1
X-Mimecast-MFC-AGG-ID: 1FsgB4RdMl6EeiWtSJXRfw_1781090245
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8D3F81955F2D; Wed, 10 Jun 2026 11:17:24 +0000 (UTC)
Received: from redhat.com (unknown [10.44.50.112])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 09A2A27A; Wed, 10 Jun 2026 11:17:21 +0000 (UTC)
Date: Wed, 10 Jun 2026 12:17:18 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 qemu-block@nongnu.org, stefanha@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PULL 0/8] Block layer patches
Message-ID: <ailHvv4_bSZDQfUD@redhat.com>
References: <20260608165207.307488-1-kwolf@redhat.com>
 <CAJSP0QXjj32djLOFPNg2jKjNN6eB7VvRXVfz3XiNkWYjR0-S2A@mail.gmail.com>
 <aik5Ox9cX_5FQbO4@redhat.com>
 <3982600a-61a1-406a-b1b9-246ae6d9a606@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3982600a-61a1-406a-b1b9-246ae6d9a606@proxmox.com>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jun 10, 2026 at 12:18:48PM +0200, Fiona Ebner wrote:
> Am 10.06.26 um 12:14 PM schrieb Kevin Wolf:
> > Am 09.06.2026 um 19:44 hat Stefan Hajnoczi geschrieben:
> >> On Mon, Jun 8, 2026 at 12:52 PM Kevin Wolf <kwolf@redhat.com> wrote:
> >>>
> >>> The following changes since commit cc329c491768b2d91eb0b0984f3baa0bf805776d:
> >>>
> >>>   Merge tag 'block-pull-request' of https://gitlab.com/stefanha/qemu into staging (2026-06-08 09:30:30 -0400)
> >>>
> >>> are available in the Git repository at:
> >>>
> >>>   https://repo.or.cz/qemu/kevin.git tags/for-upstream
> >>>
> >>> for you to fetch changes up to 296b66d05bac7eb2b86600febdbd2bd8d410f026:
> >>>
> >>>   qed: Don't try to flush during incoming migration (2026-06-08 17:00:47 +0200)
> >>>
> >>> ----------------------------------------------------------------
> >>> Block layer patches
> >>>
> >>> - qcow2: Fix data loss on zero write with detect-zeroes=unmap
> >>> - qemu-img bitmap: add sub-command --remove-all
> >>> - export/fuse: set FUSE_DIRECT_IO_ALLOW_MMAP flag to fix regression
> >>
> >> Hi Fiona and Kevin,
> >> Please take a look at the CI failure below. If the root cause is in
> >> this pull request, please send a new revision with fixed patches or
> >> without the patches that cause the failure. Thanks!
> > 
> > Yes, it's a new test case introduced in this series that doesn't work
> > with the luks driver. I just declared luks unsupported for the test for
> > now and pushed a v2 (will send the new cover letter in a moment, too).
> 
> Sorry and thanks! I'll need to remember to check with luks in the future.

You just got unlucky with the new expanded CI testing introduced when
my pull request was merged a few days ago.  Previously gitlab CI only
tested qcow2 and raw, and so compat with other drivers was "best effort"
after the fact.

Now the gitlab CI runs I/O tests across 10 drivers, so it needs to
work before merge, which is something contributors didn't need to
think about before now.

If you push a branch to your gitlab fork and trigger CI, you'll see
the results in the "block" job in the pipeline results. 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


