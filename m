Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 851C0EA794D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 01:15:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnnyC-0005oP-HM; Wed, 04 Feb 2026 20:15:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1vnnyB-0005hu-87
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 20:15:43 -0500
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1vnny8-0003eM-JM
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 20:15:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=WE4JzyZWLqvyCLbos5SjtMuecIp4MuU+rHKP0bYJTis=; b=jV0AcD2RHJWVcMGL
 4GU+iQDl4TXR5N148QPTuAPk5qi8edo6V6uB4t2f3Tf77UVYWsZTIuK4bx1ycw6aET0ajk1am7A4l
 UcFGmHI1qG4owgoAVS1yacs69Oc+D3Hzzsj1fdFTmhqL9wbY7cSSuas6wawzcmBGl+mErVu9rH4kY
 hKbZiKAzKkdkyEQ1rZPTwVuixCxjHNzFx4TZiqeQ40LSdFQmQ/OKRQO3UR8tkmdo0WCEEtWXRkT16
 4NiZBkpp7Ru8Xp4RUTdZm4fWLLJB31yV/5aDsEqI4euyQIdIp5whcoua/wrosIlut1wrvSQctKgnO
 Pvdx9JbOoxQAKbETxw==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1vnny3-00000001qop-1LjW;
 Thu, 05 Feb 2026 01:15:35 +0000
Date: Thu, 5 Feb 2026 01:15:35 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Markus Armbruster <armbru@redhat.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>,
 Helge Deller <deller@gmx.de>, Oliver Steffen <osteffen@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, German Maglione <gmaglione@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alex Bennee <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: Modern HMP
Message-ID: <aYPvN5fphSObsvGR@gallifrey>
References: <CAJSP0QVXXX7GV5W4nj7kP35x_4gbF2nG1G1jdh9Q=XgSx=nX3A@mail.gmail.com>
 <CAMxuvaz8hm1dc6XdsbK99Ng5sOBNxwWg_-UJdBhyptwgUYjcrw@mail.gmail.com>
 <871pjigf6z.fsf_-_@pond.sub.org> <aXH1ECZ1Nchui9ED@redhat.com>
 <87ikctg8a8.fsf@pond.sub.org> <aXIWLi656H8VbrPE@redhat.com>
 <87ikctk5ss.fsf@suse.de> <aXJJkd8g0AGZ3EVv@redhat.com>
 <aX-boauFX2Ju7x8Z@gallifrey> <875x8d0w32.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <875x8d0w32.fsf@pond.sub.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.48+deb13-amd64 (x86_64)
X-Uptime: 00:28:17 up 101 days, 4 min,  3 users,  load average: 0.04, 0.01,
 0.00
User-Agent: Mutt/2.2.13 (2024-03-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

* Markus Armbruster (armbru@redhat.com) wrote:
> "Dr. David Alan Gilbert" <dave@treblig.org> writes:
> 
> > * Daniel P. Berrangé (berrange@redhat.com) wrote:
> >> On Thu, Jan 22, 2026 at 12:47:47PM -0300, Fabiano Rosas wrote:
> >> > One question I have is what exactly gets (eventually) removed from QEMU
> >> > and what benefits we expect from it. Is it the entire "manual"
> >> > interaction that's undesirable? Or just that to maintain HMP there is a
> >> > certain amount of duplication? Or even the less-than-perfect
> >> > readline/completion aspects?
> >> 
> >> Over time we've been gradually separating our human targetted code from
> >> our machine targetted code, whether that's command line argument parsing,
> >> or monitor parsing. Maintaining two ways todo the same thing is always
> >> going to be a maint burden, and in QEMU it has been especially burdensome
> >> as they were parallel impls in many cases, rather than one being exclusively
> >> built on top of the other.
> >> 
> >> Even today we still get contributors sending patches which only impl
> >> HMP code and not QMP code. Separating HMP fully from QMP so that it
> >> was mandatory to create QMP first gets contributors going down the
> >> right path, and should reduce the burden on maint.
> >
> > Having a separate HMP isn't a bad idea - but it does need some idea of
> > how to make it easy for contributors to add stuff that's just for debug
> > or for the dev.   For HMP the bar is very low; if it's useful to the
> > dev, why not (unless it's copying something that's already in the QMP interface
> > in a different way);  but although the x- stuff in theory lets
> > you add something via QMP, in practice it's quite hard to get it through
> > review without a lot of QMP design bikeshedding.
> 
> I think this description has become less accurate than it used to be :)
> 
> A long time ago, we started with "QMP is a stable, structured interface
> for machines, HMP is a plain text interface for humans, and layered on
> top of QMP."  Layered on top means HMP commands wrap around QMP
> commands.  Ensures that QMP is obviously complete.  Without such a
> layering, we'd have to verify completeness by inspection.  Impractical
> given the size and complexity of the interfaces involved.
> 
> Trouble is there are things in HMP that make no sense in QMP.  For
> instance, HMP command 'cpu' sets the monitor's default CPU, which
> certain HMP commands use.  To wrap 'cpu' around a QMP command, we'd have
> to drag the concept "default CPU" into QMP where it's not wanted.

That's just state; that's easy!

> So we retreated from "all", and permitted exceptions for commands that
> make no sense in QMP.
> 
> We then found out the hard & expensive way that designing a QMP command
> with its stable, structured interface is often a lot harder than
> cobbling together an HMP command.  It's not just avoidable social
> problems ("bikeshedding"); designing stable interfaces is just hard.
> Sometimes the extra effort is worthwhile.  Sometimes it's not, e.g. when
> all we really want is print something to aid a human with debugging.

Right.

> So we retreated from "all" some more, and permitted exceptions for
> commands meant exclusively for human use, typically debugging and
> development aids.
> 
> This effectifely redefined the meaning of "complete": instead of "QMP
> can do everything HMP can do and more", it's now "... except for certain
> development and debugging aids and maybe other stuff".
> 
> To keep "maybe other stuff" under control, we required (and still
> require) an *argument* for adding functionality just to HMP.
> 
> This turned out to be differently bothersome.  Having to review HMP
> changes for QMP bypasses is bothersome, and bound to miss things at
> least occasionally.  Having to ask for an argument is bothersome.
> Constructing one is bothersome.

Well, it's not too bad as long as the arguments are only asked to be
reasonable rather than bulletproof.

> To reduce the bother, we retreated from another QMP ideal: the
> structured interface.  Permit QMP commands to return just text when the
> command is meant just for humans.  Such commands must be unstable.
> Possible because we had retreated from "all of QMP is stable" meanwhile.
> 
> How does this work?  Instead of adding an HMP-only command, add a QMP
> command that returns QAPI type HumanReadableText, and a trivial HMP
> command that wraps around it.  Slightly more work, but no interface
> design.

Yes, I've seen that - and as long as that continues it's OK;
although it does feel weird in a few ways; it seems more work
to implement than just being able to print, but I do worry
what happens with commands with a lot of output.   It also gets
weirder when you have to parameterise it, because you get the parameter
parsing in one place influencing the separate formatting.

> The QMP command addition is much more visible to the QAPI/QMP
> maintainers than an HMP-only command would be.  This helps avoid missing
> things.
> 
> We still want an argument why a structured interface isn't needed.  But
> we can be much more lenient there: if it turns out to be needed, we can
> just add it, and drop the unstructured interface.  Remember, it's
> unstable.
> 
> Hope this helps.

Yeh, it's just something to be watchful of.

I did see you suggesting for Rust for it; which would work - although
given it wouldn't be performance sensitive, Python would seem reasonable.

Dave

Dave

-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

