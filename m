Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08382D15DAE
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 16:38:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQpqv-0008Pn-D7; Wed, 03 Dec 2025 11:37:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1vQpqt-0008NR-VG; Wed, 03 Dec 2025 11:37:15 -0500
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1vQpqs-000260-9W; Wed, 03 Dec 2025 11:37:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=bzv5RPM8CkIs/xc+4YXMZc6XdBEmqY1qLlvQzfXaVr0=; b=bNZTg2NNHLBgZOeO
 qboKJ9paNYEHJ3WrpBRSvHamk+2CISt0klefQua5PEOYBs+9fz5ktNrAhw8JY3C6JY/KLnO6AfB3D
 FFAxsYu/U+KZH9Qx+Yzze6M9vbP1llT7tKSA80yYA922jMOtcs/g5U1WnAosGjkC3q6NHPacSwSHl
 ya6GNtpEN5x/iPxL0jtJREOetstFuRW+/pFC16avkJT+HqFhoPGTRO1DYE87OYrardNyNqptTfpFO
 6aSjuuu5C1aScBYJF6czib//JBGP2A3rfy/n0TFiOgAeeSAgAINxHdZUB9lfeeoHhzoyvm8h3Eve9
 Sxv3xbw6Ils2dqqsYA==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1vQpqp-00000007rtA-1bHR;
 Wed, 03 Dec 2025 16:37:11 +0000
Date: Wed, 3 Dec 2025 16:37:11 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 qemu-trivial@nongnu.org, mjt@tls.msk.ru, laurent@vivier.eu,
 thuth@redhat.com, pbonzini@redhat.com, jak@jak-linux.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] qemu-options.hx: Document -M as -machine alias
Message-ID: <aTBnN6Q72QX3cW55@gallifrey>
References: <20251203131511.153460-1-dave@treblig.org>
 <87a4zzu230.fsf@draig.linaro.org> <aTBCLbDbpXgkTLHr@gallifrey>
 <CAFEAcA-Uy0UQwGEK+f95BJmDripg1-8vhzPF5qRSY40=duhRUQ@mail.gmail.com>
 <aTBjTzbaX0befChO@gallifrey>
 <CAFEAcA-y5ucBTOgngim5cpuKbFYXajOz0zEeT2S0rC3wnMPSrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAFEAcA-y5ucBTOgngim5cpuKbFYXajOz0zEeT2S0rC3wnMPSrw@mail.gmail.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.48+deb13-amd64 (x86_64)
X-Uptime: 16:36:13 up 37 days, 16:12,  3 users,  load average: 0.00, 0.00, 0.00
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

* Peter Maydell (peter.maydell@linaro.org) wrote:
> On Wed, 3 Dec 2025 at 16:20, Dr. David Alan Gilbert <dave@treblig.org> wrote:
> >
> > * Peter Maydell (peter.maydell@linaro.org) wrote:
> > > Surprisingly, this and -h/--help are our only two options where
> > > we provide a short synonym. I note that this handling of -M
> > > is not consistent with how we document -h/--help, where we
> > > print both on a single line:
> > > -h or -help     display this help and exit
> > >
> > > But it would be trickier to fit that in for -machine and
> > > perhaps confusing given the suboptions.
> >
> > Right, that's one of the two reasons I kept it separate.
> > The other reason, is that I couldn't figure out how '-help' and '-h'
> > both got defined - why is the second DEF(...) not needed?
> 
> A piece of delicious fudge lurking in system/vl.c: we have
> this hardcoded entry in the qemu_options[] array before
> the ones that are generated via the macro-magic from
> qemu-options.hx:
> 
>     { "h", 0, QEMU_OPTION_h, QEMU_ARCH_ALL },
> 
> So we recognize -h on the command line and turn it into
> QEMU_OPTION_h, the same as -help, but it doesn't result in
> anything in the documentation (we leave that up to the
> strings and RST in the DEF("help"...) section).

Hah ok!  I guess that fudge could be removed and make it the
same way -M works.

Dave

> thanks
> -- PMM
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

