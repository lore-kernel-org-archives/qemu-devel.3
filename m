Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EC35CD5BDE
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 08:46:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wS9tW-0006AC-Qb; Wed, 27 May 2026 04:45:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wS9tP-00068K-QU
 for qemu-devel@nongnu.org; Wed, 27 May 2026 04:45:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wS9sy-0005yO-LS
 for qemu-devel@nongnu.org; Wed, 27 May 2026 04:45:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779871307;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X6XldLN8mMQINy3kBPIlfBZjWtuorD+ZJNS/2Vg1HDU=;
 b=Sk6OnluOu5ELHt8uY8lVD/ALaXvc2apMVuwz2sAGhwhU2Z2raWSK5eNTz5ohmEJXtsXI0v
 uY4AcaXYXdOBBMPf8QuhL2uOlGDJvqyvk5Y8PeKbIoFIR+Eh+P0Dyf8VCL5l7ENzTawP1e
 vwKJLTCdry/wPjdtZ2qaqdTLjpdhCh4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-31-MNvs62IbPVKfaanasWM5tA-1; Wed,
 27 May 2026 04:41:42 -0400
X-MC-Unique: MNvs62IbPVKfaanasWM5tA-1
X-Mimecast-MFC-AGG-ID: MNvs62IbPVKfaanasWM5tA_1779871301
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2476719560AB; Wed, 27 May 2026 08:41:41 +0000 (UTC)
Received: from redhat.com (unknown [10.44.48.98])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 191F61800347; Wed, 27 May 2026 08:41:38 +0000 (UTC)
Date: Wed, 27 May 2026 10:41:36 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Warner Losh <imp@bsdimp.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 stefanha@redhat.com
Subject: Re: on ai generated and code provenance
Message-ID: <ahauQKLOU1tzDtbb@redhat.com>
References: <20260524083329-mutt-send-email-mst@kernel.org>
 <ahXbxzB4C_lr6b0N@redhat.com>
 <20260526140231-mutt-send-email-mst@kernel.org>
 <ahXtqyuIa4XqkMHb@redhat.com>
 <20260526152526-mutt-send-email-mst@kernel.org>
 <CANCZdfonroZmdRRpPdHzTKR_m8qyVdSG14gXB-K3BTuv=Qgw9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANCZdfonroZmdRRpPdHzTKR_m8qyVdSG14gXB-K3BTuv=Qgw9g@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Am 26.05.2026 um 21:52 hat Warner Losh geschrieben:
> On Tue, May 26, 2026 at 1:32 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> 
> > On Tue, May 26, 2026 at 08:59:55PM +0200, Kevin Wolf wrote:
> > > So yes, trivial patches is another obvious starting point. The challenge
> > > there is defining the line where a patch stops being trivial. So I'm not
> > > completely sure if making this distinction in a policy is a good idea;
> > > maybe practically speaking it has to be all or nothing in terms of
> > > creativity (for lack of a better word).
> >
> > Let the maintainers decide?
> >
> > Or we can enumerate things:
> > - fixing tool (compiler/checkpatch/smatch) errors/warnings in obvious ways
> > (e.g. suggested by the
> >   tools itself, such as initializing an uninitialized variable)
> > - propagating API changes (e.g. rebasing a patch after an API change)
> > - anything that could be done by a perl/sed/coccinelle script
> > - adding or fixing code comments
> >
> 
> Those are good examples. Perhaps the following words are good place to start
> to frame what I've seen expressed here:
> 
> The QEMU Project currently may accept limited uses of AI that produce
> high quality patches that are limited in the creative content added.
> While maintainers will ultimately decide, changes like the following
> fall within this policy
> 1. Fixing obvious warnings in the obvious ways suggested by the tool
> 2. Tree wide API changes, and other similar mechanical changes done
>    today with perl/python/sed/coccinelle

As I said in the paragraph you quoted below, I don't think we should
encourage using AI for tasks that a deterministic tool could do. If you
can use a deterministic tool like sed or Coccinelle for the job, you
should. I know that writing Coccinelle spatches can be challenging; that
is the part that you can ask AI to help with. (Perl and Python follow
the same logic as long as the script is simple, but obviously you have
to stop when the helper script becomes almost as complex as the change
itself.)

Letting AI perform the change directly instead may be an acceptable
shortcut for a one-man hobby project that nobody else will ever look at,
but in the context of a community project like QEMU in which your
changes have to be reviewed and understood by others, it matters a lot
that the output of the tool is reproducible. Otherwise, you're creating
unnecessary work for others, and that isn't acceptable.

So maybe we should even explicitly mention a recommendation like the
following:

    If you can use a deterministic tool, don't use AI instead. If you
    don't know how to use the deterministic tool, use the AI to tell you
    how to use it instead of trying to replace it.

> 3. Limited, small changes to fix bugs or add a small new feature whose
>    scope is less than about 100 lines and the originator can explain
>    them all or the meta issues about the patch.

Not sure if mentioning a number of lines is wise. 100 lines can be
mostly boilerplate and simple sequential code or they can be a deeply
nested complex algorithm.

> Maintainers are free to accept or reject changes outside these
> guidelines, but please check with the maintainers before sending to
> keep the load from AI content to something they can manage. Large and
> Very Large patches, especailly ones that have not been deeply
> analyised and tested by humans, should be avoided.
> 
> Though maybe the list of 'exceptions' needs work. But the basic
> framing is that we will accept some, high quality patches. Maintainers
> have some discression for larger pieces to a point, and we still don't
> want to drown in AI slop.

Yes, if we decide that we do want to make patch complexity/creative
expression/whatever you may call it part of the criteria, then having a
list like this looks like a possible approach. The details of what
exactly should be in it would certainly lead to more discussion, though.

Kevin

> Warner
> 
> 
> >
> > > As an aside, personally, I'm not convinced that AI can be a "better
> > > sed". If it's really about mechanical changes, I think the resulting
> > > patch is much more reviewable if the agent doesn't modify the code, but
> > > just generate the sed command line or the Coccinelle patch and that is
> > > included in the commit message. Reviewers can then just review that and
> > > then reproduce the result themselves for comparison. This is impossible
> > > with AI prompts and agents do tend to forget an instance of something to
> > > replace here and there, so you do have to review the result carefully.
> > >
> > > But none of these "better sed" problems need to handled in an AI policy.
> > > If a patch is hard to review, the maintainer will already reject it on
> > > those grounds.
> >
> > Absolutely.


