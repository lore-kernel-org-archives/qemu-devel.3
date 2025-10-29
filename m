Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9A53CCF9EB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 10:57:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE3rb-0003cZ-50; Wed, 29 Oct 2025 06:57:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vE3rS-0003S2-Tu
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 06:57:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vE3rO-0002d0-Ul
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 06:57:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761735413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jdw1Tb7yRD/1Q/aZ4tkoIv03n98uU4SeCVf2cT4WUx8=;
 b=ap4fL6+aw1seM5f2DhdxYuw3FkEV/8PrOtIaiXhKHwFhCsoTpBIrR4TacQxQoDrAbvR9P5
 enmytWZx3jYVoNMmkIQ31WaN2Eva0Ig+cp8rPGRZYVZUAYTnV0AUcp7Hdj3M/iQgMzUyYp
 9aKTXu07ZERKhJm3MKPerErWiSF3DbU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-i3rFeD7NNICyZysdtpZMJA-1; Wed,
 29 Oct 2025 06:56:49 -0400
X-MC-Unique: i3rFeD7NNICyZysdtpZMJA-1
X-Mimecast-MFC-AGG-ID: i3rFeD7NNICyZysdtpZMJA_1761735409
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D854919560BA; Wed, 29 Oct 2025 10:56:48 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.204])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 580E01800452; Wed, 29 Oct 2025 10:56:47 +0000 (UTC)
Date: Wed, 29 Oct 2025 11:56:44 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: =?iso-8859-1?Q?Cl=E9ment?= Chigot <chigot@adacore.com>
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, qemu-block@nongnu.org
Subject: Re: [PATCH 1/5] vvfat: introduce no-mbr option
Message-ID: <aQHy7ERcW289V9E1@redhat.com>
References: <20250903075721.77623-1-chigot@adacore.com>
 <20250903075721.77623-2-chigot@adacore.com>
 <aPpyAzn7abZZ5WNv@redhat.com>
 <CAJ307Egx3tcg6BLpZFV+7PcbiqMp6pADTz0nPTPLppFodifYyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ307Egx3tcg6BLpZFV+7PcbiqMp6pADTz0nPTPLppFodifYyw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Am 29.10.2025 um 09:37 hat Clément Chigot geschrieben:
> On Thu, Oct 23, 2025 at 8:21 PM Kevin Wolf <kwolf@redhat.com> wrote:
> >
> > Am 03.09.2025 um 09:57 hat Clément Chigot geschrieben:
> > > This option when set prevents a master boot record (MBR) to be
> > > initialized. This is mandatory as some operating system don't recognized
> > > mounted disks if a MBR is present.
> > >
> > > Signed-off-by: Clément Chigot <chigot@adacore.com>
> >
> > Can we actually give an example of such an OS in the commit message?
> >
> > > ---
> > >  block/vvfat.c | 16 +++++++++++++++-
> > >  1 file changed, 15 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/block/vvfat.c b/block/vvfat.c
> > > index 814796d918..0220dd828b 100644
> > > --- a/block/vvfat.c
> > > +++ b/block/vvfat.c
> > > @@ -1082,6 +1082,11 @@ static QemuOptsList runtime_opts = {
> > >              .type = QEMU_OPT_BOOL,
> > >              .help = "Make the image writable",
> > >          },
> > > +        {
> > > +            .name = "no-mbr",
> > > +            .type = QEMU_OPT_BOOL,
> > > +            .help = "Do not add a Master Boot Record on this disk",
> > > +        },
> >
> > Let's keep option names positive to avoid double negations like
> > 'no-mbr=false'. We can have an 'mbr' option that defaults to true. Or in
> > fact, maybe calling it 'partitioned' would be easier to understand.
> >
> > You need to update BlockdevOptionsVVFAT in qapi/block-core.json, too, to
> > make the new option work with -blockdev. You should update the
> > description for @floppy there, too, because it says that hard disks are
> > always partitioned.
> >
> > It should also be added to vvfat_strong_runtime_opts because the value
> > of this option changes the data that the guest sees.
> 
> Just to keep you updated, I've seen your comments. I'm just waiting to
> see where the discussion of patch 5 leads before pushing v2.

Yes, that makes sense. So this means that for all the other patches, you
agree with my comments and it's clear to you what to change in v2?

Kevin


