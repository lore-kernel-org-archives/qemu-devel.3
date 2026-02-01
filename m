Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8DF0E65296
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Feb 2026 18:30:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmcCw-0008AQ-3U; Sun, 01 Feb 2026 13:30:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1vmcCu-000853-EW
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 13:30:00 -0500
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1vmcCs-0006JY-Ep
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 13:30:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=pgPtNcSzNF/zPIvJDvRpWF3W2Scxdp/0c7R2KRW9haE=; b=qo9ZmCh6zbjFTpbq
 Xc2hfzSdLKdPrUPMzSI3oknE3z1Fe4N0GHRK/XCtGR/K8EvoTVRrxo8juUtz4rW3xBjCWeg9bYJ4i
 jOjpIfzM3hBDCj9hqByEd9RbpGbMNfaGJgBauwgytpOyuQ21fSrmu9suzdF/7vQYg6AW7NZkUZ1zU
 +XBQafZqK2rnRTvC5EWZITAXfvFGf7xJgjY5qC1eE05LPcadkylZ7oOgJeY46J1G2b8s6+DpTN2It
 JICWyOHxsGTUPNwgtknzrgDqanjEZuljskFDCARinkoNPvpKl+9YKw9oHMchbEqE0lqyPvjfgwyKw
 h4TpoKkI5kzUbyvmlg==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1vmcCn-0000000137z-2Bd0;
 Sun, 01 Feb 2026 18:29:53 +0000
Date: Sun, 1 Feb 2026 18:29:53 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, Markus Armbruster <armbru@redhat.com>,
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
Message-ID: <aX-boauFX2Ju7x8Z@gallifrey>
References: <CAJSP0QVXXX7GV5W4nj7kP35x_4gbF2nG1G1jdh9Q=XgSx=nX3A@mail.gmail.com>
 <CAMxuvaz8hm1dc6XdsbK99Ng5sOBNxwWg_-UJdBhyptwgUYjcrw@mail.gmail.com>
 <871pjigf6z.fsf_-_@pond.sub.org> <aXH1ECZ1Nchui9ED@redhat.com>
 <87ikctg8a8.fsf@pond.sub.org> <aXIWLi656H8VbrPE@redhat.com>
 <87ikctk5ss.fsf@suse.de> <aXJJkd8g0AGZ3EVv@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aXJJkd8g0AGZ3EVv@redhat.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.48+deb13-amd64 (x86_64)
X-Uptime: 18:25:58 up 97 days, 18:02,  4 users,  load average: 0.00, 0.01, 0.00
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

* Daniel P. Berrangé (berrange@redhat.com) wrote:
> On Thu, Jan 22, 2026 at 12:47:47PM -0300, Fabiano Rosas wrote:
> > One question I have is what exactly gets (eventually) removed from QEMU
> > and what benefits we expect from it. Is it the entire "manual"
> > interaction that's undesirable? Or just that to maintain HMP there is a
> > certain amount of duplication? Or even the less-than-perfect
> > readline/completion aspects?
> 
> Over time we've been gradually separating our human targetted code from
> our machine targetted code, whether that's command line argument parsing,
> or monitor parsing. Maintaining two ways todo the same thing is always
> going to be a maint burden, and in QEMU it has been especially burdensome
> as they were parallel impls in many cases, rather than one being exclusively
> built on top of the other.
> 
> Even today we still get contributors sending patches which only impl
> HMP code and not QMP code. Separating HMP fully from QMP so that it
> was mandatory to create QMP first gets contributors going down the
> right path, and should reduce the burden on maint.

Having a separate HMP isn't a bad idea - but it does need some idea of
how to make it easy for contributors to add stuff that's just for debug
or for the dev.   For HMP the bar is very low; if it's useful to the
dev, why not (unless it's copying something that's already in the QMP interface
in a different way);  but although the x- stuff in theory lets
you add something via QMP, in practice it's quite hard to get it through
review without a lot of QMP design bikeshedding.

Dave

-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

