Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 599CECD6E55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 09:19:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUhke-0004Be-5f; Wed, 03 Jun 2026 05:19:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wUhkc-0004BS-So
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 05:19:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wUhka-0003zl-OW
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 05:19:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780478339;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hNyYHrbbCZHoiIKx13CWEifLF2YBnt2ZET51UM49ylQ=;
 b=Kb8CXsTzh040c4wuH8KmPdF8DJUXQcuK0+IYqv6aQF24WIRcR1Eo6dQOCaAdbS9CbFU9KN
 HUHVJYniPDlh6SW7MEpUz7EJU9pJ3aCKHSOyFZACgLyD1R9zG0PHSpWkAPD5IkVS19wY4L
 g/YZbYr3sc/TgxXAj91SreW1g1+s+8o=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-267-rlmKcTpmO3q1rjYgTrkWDg-1; Wed,
 03 Jun 2026 05:18:56 -0400
X-MC-Unique: rlmKcTpmO3q1rjYgTrkWDg-1
X-Mimecast-MFC-AGG-ID: rlmKcTpmO3q1rjYgTrkWDg_1780478335
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6991319560A1; Wed,  3 Jun 2026 09:18:54 +0000 (UTC)
Received: from redhat.com (unknown [10.44.50.34])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1D981404; Wed,  3 Jun 2026 09:18:49 +0000 (UTC)
Date: Wed, 3 Jun 2026 10:18:46 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org,
 Kyle Evans <kevans@freebsd.org>, Stacey Son <sson@freebsd.org>,
 Jessica Clarke <jrtc27@jrtc27.com>,
 =?utf-8?Q?Mika=C3=ABl?= Urankar <mikael.urankar@gmail.com>,
 Michal Meloun <mmel@freebsd.org>, Sean Bruno <sbruno@freebsd.org>,
 Karim Taha <kariem.taha2.7@gmail.com>, Alexander Kabaev <kan@freebsd.org>
Subject: Re: [PATCH v2 00/37] bsd-user: Upstream most of the remaining system
 calls
Message-ID: <ah_xdtRTzzlch5jD@redhat.com>
References: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
 <d840bb59-b30d-4955-b570-32f8d2ffc60a@oss.qualcomm.com>
 <CANCZdfqoPUt1Dd55FAZOnxoe1wUSxQGzP1Rp=zRZkY6vC6iOfg@mail.gmail.com>
 <586de8e4-428c-4e05-99d1-574f09b89f15@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <586de8e4-428c-4e05-99d1-574f09b89f15@oss.qualcomm.com>
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, May 22, 2026 at 06:19:16PM -0700, Pierrick Bouvier wrote:
> On 5/22/2026 5:40 PM, Warner Losh wrote:
> > 
> > 
> > On Fri, May 22, 2026 at 6:04 PM Pierrick Bouvier
> > <pierrick.bouvier@oss.qualcomm.com
> > <mailto:pierrick.bouvier@oss.qualcomm.com>> wrote:
> > 
> >     On 5/18/2026 2:27 PM, Warner Losh wrote:
> >     > Upstream the file, thread, socket and remaining signal system
> >     calls (too
> >     > numerous to list here).
> >     >
> >     > This series is an ambitous use of claude to help me upstream all the
> >     > remaining system calls. I've batched them together in what I think are
> >     > reasonable chunks, and had claude do the grunt work of copying the
> >     code
> >     > over and attributing the commits from our complex branching
> >     history. The
> >     > chopping up was a bit arbitrary, but I think it's good. The commit
> >     > messages may be a little weak, but may also be OK. I've also double
> >     > checked the style and made fixes upstream for them as well. Claude
> >     also
> >     > reviewed all these changes and found a few bugs that I've fixed. I've
> >     > personally read through them all and haven't found anything glaring. I
> >     > fixed all the bugs that were found, in most cases differently than
> >     > claude's suggestions.
> >     >
> >     > I've added 'Assisted-by: Claude...' to all these commits to reflect my
> >     > leaning on Claude so hard. This use falls within the 'non-
> >     creative' use
> >     > that the Qemu project has said is OK. If that's not the right thing to
> >     > do, I can remove them.
> >     >
> >     > This leaves sysctl translation, the powerpc architecture support,
> >     > coredumps and a transition to 'truss' based system call tracing. With
> >     > these changes applied we'er down from a high of about 30k lines of
> >     diffs
> >     > to only 5k (not counting genereted, but checked in files in
> >     blitz). The
> >     > changes are 8k, so maybe a bit ambitious from that perspective as
> >     well.
> >     >
> >     > There's a few lines over 80 that I've not cleaned up. Let me know if
> >     > that's a problem. The other warnings are about adding files, and
> >     there's
> >     > no new MAINTAINERS entry needed. And the 'arch dependent defines
> >     should
> >     > be avoided' are needed to cope with different FreeBSD build systems
> >     > having different system calls.
> >     >
> >     > Note, this is called out below too, but in v2 I've folded back all the
> >     > fixes based on some out-of-band feedback I recieved to do this the
> >     > normal way and the qemu project isn't interested in the fixes to
> >     fixes.
> >     >
> >     > This is a big experiment, in many ways, for me, so I'm interested in
> >     > whatever feedback you may have to make things better in the future.
> >     >
> >     > Signed-off-by: Warner Losh <imp@bsdimp.com <mailto:imp@bsdimp.com>>

snip

> >     After reviewing (what I can) two thirds of the series, I don't feel very
> >     at ease with validating the rest. Not that there is problem in itself,
> >     but it's a massive add, and I'm not sure how we can ensure it's
> >     implemented correctly without any test exercising it.
> >     It's not particular to bsd-user, linux-user does not have test for all
> >     syscalls implemented neither.
> > 
> > 
> > Yes. I'd like a low-level test like that. The upstream bsd-user has been too
> > incomplete to run real programs prior to this series. And there's still some
> > issues that remain after these system calls (which is next up on my list: I
> > think elfload needs some patches for PIE).

snip

> In the real world, seems like we don't really have another option than
> taking it, except if you're ready to spend 6 months to add tests for
> this series. I'll let other reviewers finish the work for this series.
> 
> I'm not against the pragmatic approach of taking it, and let it be
> tested on the field. It would be unfair considering how the rest of QEMU
> is not always tested.

Yep, as a general rule we have no requirement for formal functional
tests for contributions to QEMU. The expectation is that the person
submitting the code has tested that it does what they claim. Anything
beyond that is a "nice to have". Especially  for brand new features,
we don't need to worry about regressions either.

This bsd-user code has had a complex history out of tree, so it is an
unusual situation compared to most other contributions we receive.
The FreeBSD maintainers have had a long term burden carrying this out
of tree for too long but it was actually used, while we've shipped a
non-functional version upstream that no one used.

In terms of code review we can assume that this is all already peer
reviewed by multiple people in the FreeBSD community. So unless someone
in QEMU community happens to have specific FreeBSD knowledge, I don't
think we really need to review this from a functional correctness POV.
The multiple Signed-off-bys already indicate sufficient functional
review IMHO.

Rather my expectation for merge is that we're doing more of a "sanity
check" that the patches are something that looks reasonable to accept,
following the normal QEMU coding practices/styles/etc.

Some formal in tree tests would be nice, but I'd say we should focus
on getting the current out of tree backlog merged, and worry about
tests later once the burden of merging the backlog is eliminated.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


