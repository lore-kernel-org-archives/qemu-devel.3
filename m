Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE3C6EC1438
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 12:53:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxPFB-0002uA-5P; Tue, 03 Mar 2026 07:52:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vxPF6-0002tw-UB
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 07:52:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vxPF0-0003CV-SK
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 07:52:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772542364;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z5d0aYAH6VDTisXvOiJxv8ZtV56kBEeWR6znnc/HMR4=;
 b=eQPsa9gocsRauF7SibaJCArWq7GE58+uqVVqQHMJZEgoG6w6khgSCUHzRZEC+RJbd2/Qvp
 bVx1zRKB+2eEhlTp7fyyCFlrfvHbovyZ5YGJLa71hQOTpqBM8RxvNfMqwceRRu1asj5aGL
 C7A2nQUEWTtEQxDM1j52RGbFmPecFf0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-313-hZpHUZ5JPUSDkM9P-Whd1w-1; Tue,
 03 Mar 2026 07:52:39 -0500
X-MC-Unique: hZpHUZ5JPUSDkM9P-Whd1w-1
X-Mimecast-MFC-AGG-ID: hZpHUZ5JPUSDkM9P-Whd1w_1772542358
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2E87C195605A; Tue,  3 Mar 2026 12:52:38 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.185])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3E89919560A3; Tue,  3 Mar 2026 12:52:36 +0000 (UTC)
Date: Tue, 3 Mar 2026 12:52:32 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Warner Losh <imp@bsdimp.com>
Cc: qemu-devel@nongnu.org, Kyle Evans <kevans@freebsd.org>,
 Stacey Son <sson@freebsd.org>
Subject: Re: [PATCH] bsd-user: Switch to SPDX-License-Expression
Message-ID: <aabZkCD-MkApTpD4@redhat.com>
References: <20260302-bsd-user-copyright-v1-1-f05587d18d4e@bsdimp.com>
 <aaahAbpycKhDzfbL@redhat.com>
 <CANCZdfoxESrbaUbXWo9g2jfaqsgaWbpNxg5CGd3xgf0MRMDMcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANCZdfoxESrbaUbXWo9g2jfaqsgaWbpNxg5CGd3xgf0MRMDMcw@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 27
X-Spam_score: 2.7
X-Spam_bar: ++
X-Spam_report: (2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141, SPF_HELO_PASS=-0.001,
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

On Tue, Mar 03, 2026 at 05:17:15AM -0700, Warner Losh wrote:
> On Tue, Mar 3, 2026 at 1:51 AM Daniel P. Berrangé <berrange@redhat.com>
> wrote:
> 
> > On Mon, Mar 02, 2026 at 09:46:06PM -0700, Warner Losh wrote:
> > > Switch all the files over to using SPDX. This also corrects various
> > > small errors in the form of the copyright messages. It adds copyright to
> > > those files that lack it. There's no functional change.
> > >
> > > Signed-off-by: Stacey Son <sson@FreeBSD.org>
> > > Signed-off-by: Warner Losh <imp@bsdimp.com>
> > > ---
> > > Since I'll be upstreaming more files from bsd-user, and since qemu now
> > > requires SPDX and prohibits boilerplate, this will make it easier. I've
> > > converted all the relevant bits in bsd-user upstream.
> >
> > Note, QEMU / checkpatch.pl only requires SDPX on *newly* authored files.
> > Existing code files, or new files whose content is copied from an
> > existing file (either inside or outside QEMU git) are exempt from this
> > and in fact required to be left without SPDX.
> >
> > The reasoning is that there is some uncertainty about the legality of
> > removing license header text from existing files due to the GPL clause
> > 1 which says
> >
> >   "keep intact all the notices that refer to this License and
> >    to the absence of any warranty;"
> >
> > I interpret that to mean we can not remove license header text from
> > files unless the person doing the removal is the exclusive copyright
> > holder, or has got recorded permission from all copyright holders
> > that apply to each file changed.
> >
> > It is confusing for people because Linux removed all their GPL header
> > text in favour of SPDX, but never provided any clear explanation of
> > why they considered that to be acceptable from the GPL compliance POV.
> >
> 
> So I have Stacey's permission to do this, and he's the only actual copyright
> holder on these files. If I messed up on any, specifically, please let me
> know.
> That's why I included his signed-off-by: he signed off on it and that he's
> legally able to make the change.

None of that was explained in the commit message, hence why I'm
raising this as review feedback.

As a sanity check I did the following to list number of contributors
besides yourself & Stacey:

$ for f in $(awk '{print $1}' <  filelist.txt) ; do echo -n "$f: " ; git log $f | grep ^Author |grep -v Stacey | grep -v Warner | sort | uniq | wc -l ; done
bsd-user/aarch64/signal.c: 0
bsd-user/aarch64/target_arch.h: 0
bsd-user/aarch64/target_arch_cpu.c: 0
bsd-user/aarch64/target_arch_cpu.h: 2
bsd-user/aarch64/target_arch_elf.h: 1
bsd-user/aarch64/target_arch_reg.h: 0
bsd-user/aarch64/target_arch_signal.h: 0
bsd-user/aarch64/target_arch_sigtramp.h: 0
bsd-user/aarch64/target_arch_sysarch.h: 0
bsd-user/aarch64/target_arch_thread.h: 0
bsd-user/aarch64/target_arch_vmparam.h: 0
bsd-user/aarch64/target_syscall.h: 0
bsd-user/arm/signal.c: 1
bsd-user/arm/target_arch.h: 2
bsd-user/arm/target_arch_cpu.c: 1
bsd-user/arm/target_arch_cpu.h: 3
bsd-user/arm/target_arch_elf.h: 3
bsd-user/arm/target_arch_reg.h: 1
bsd-user/arm/target_arch_signal.h: 1
bsd-user/arm/target_arch_sigtramp.h: 1
bsd-user/arm/target_arch_sysarch.h: 1
bsd-user/arm/target_arch_thread.h: 1
bsd-user/arm/target_arch_vmparam.h: 1
bsd-user/arm/target_syscall.h: 1
bsd-user/bsd-file.h: 3
bsd-user/bsd-mem.c: 1
bsd-user/bsd-mem.h: 5
bsd-user/bsd-proc.c: 2
bsd-user/bsd-proc.h: 4
bsd-user/bsdload.c: 5
bsd-user/elfload.c: 21
bsd-user/freebsd/os-misc.h: 2
bsd-user/freebsd/os-proc.c: 3
bsd-user/freebsd/os-proc.h: 3
bsd-user/freebsd/os-stat.c: 1
bsd-user/freebsd/os-stat.h: 3
bsd-user/freebsd/os-strace.h: 0
bsd-user/freebsd/target_os_elf.h: 2
bsd-user/freebsd/target_os_siginfo.h: 2
bsd-user/freebsd/target_os_stack.h: 3
bsd-user/freebsd/target_os_thread.h: 1
bsd-user/freebsd/target_os_user.h: 2
bsd-user/freebsd/target_os_vmparam.h: 1
bsd-user/i386/signal.c: 1
bsd-user/i386/target_arch.h: 1
bsd-user/i386/target_arch_cpu.c: 2
bsd-user/i386/target_arch_cpu.h: 3
bsd-user/i386/target_arch_elf.h: 2
bsd-user/i386/target_arch_reg.h: 1
bsd-user/i386/target_arch_signal.h: 0
bsd-user/i386/target_arch_sigtramp.h: 1
bsd-user/i386/target_arch_sysarch.h: 1
bsd-user/i386/target_arch_thread.h: 1
bsd-user/i386/target_arch_vmparam.h: 1
bsd-user/i386/target_syscall.h: 2
bsd-user/main.c: 47
bsd-user/mmap.c: 14
bsd-user/qemu-bsd.h: 1
bsd-user/qemu.h: 24
bsd-user/signal.c: 14
bsd-user/strace.c: 6
bsd-user/syscall_defs.h: 8
bsd-user/x86_64/signal.c: 1
bsd-user/x86_64/target_arch.h: 1
bsd-user/x86_64/target_arch_cpu.c: 2
bsd-user/x86_64/target_arch_cpu.h: 3
bsd-user/x86_64/target_arch_elf.h: 2
bsd-user/x86_64/target_arch_reg.h: 1
bsd-user/x86_64/target_arch_signal.h: 1
bsd-user/x86_64/target_arch_sigtramp.h: 1
bsd-user/x86_64/target_arch_sysarch.h: 1
bsd-user/x86_64/target_arch_thread.h: 2
bsd-user/x86_64/target_arch_vmparam.h: 1
bsd-user/x86_64/target_syscall.h: 3


I checked a few of the cases where only 1/2/3 other authors are
listed, the changes they made appear to be trivial and could be
considered non-copyrightable. So converting most of the files
is probably OK with just yourself & Stacey's agreement.

The big notable exceptions appear to be many of the files directly
in the bsd-user/ directory, as opposed to sub-dirs, which still
contain code dating back to the original impl of bsd-user.

> Also, I did this to reduce friction in upstreaming bsd-user which has been
> going on for 6ish years now. The SPDX rule is one more thing that slows
> that down. Rather than get an exception to the rule, I brought everything
> into compliance so it isn't yet another issue that takes more time because
> I forgot to do it for a specific patch series. The more issues I have to
> have
> on my checklist, the more the works are gummed up and the slower the
> progress is. We still have somethign like ~30k lines to go last I checked.

> 
> Also, these files have also been out of tree for over a decade. The new
> rule forces me to do what you're complaining about the Linux tree doing:
> remove GPL markings to get it into your tree. Well which is it?  Either it's
> wrong and I shouldn't have to do it for the old files.  Or what I've done
> is proper since it's uniform. Your tree is just an arbitrary repo of these
> files, and isn't special in any meaningful way. So I'm in a no-win situation
> here by your argument.

The checkpatch.pl script warnings indicate that SDPX is only required
on newly added files, and also states that this does not apply if
copying from existing code.  If you've suggestions on how we can improve
the contributor docs or checkpatch script messages to better explain this
please feel free to say

> Also, when I talk about a burdensome and cumbersome upstreaming process,
> this is yet another example. An arbitrary rule that causes friction, but
> provides
> no actual benefit. It's like the style rules: I have to arbitrarily
> reformat code that
> is like that in linux-user because this is "new code". So I spend a fair
> amount of
> time fetching different stones to obey the rules, but since now the code is
> different
> it becomes harder to track linux-user or to ever converge them. Change for
> the
> sake of compliance with an arbitrary rule that doesn't apply elsewhere (for
> whatever
> reason) is one of the death by a thousand cuts I, and others doing this
> work, have
> been suffering for far too long. It's in large measure why things aren't
> further along:
> it steals what little time I have for this and it demotivates further work
> for a while.

There's always a tradeoff in these areas between having project standards
and the burden that places on contributors to comply with the standards.
It can't really be a total free-for-all in a project of the scale that
QEMU is. In addition, caution around license compliance is a key factor
for QEMU, as a critical infrastructure component underpinning a huge
ecosystem of projects and activities.

I agree that the style formatting rules in particular are quite painful
because we never fix historic code to comply with the stated style. Most
other projects would enforce code style unconditionally across the code
base. I would very much like that situation to change.

> So, having said that, is there any specific objection to anything I've
> done? Given
> Stacey's explicit blessing of this change (you'll recall from the patch
> series I just did
> I waited until I had contacted him before I changing it there), did I mess
> up anywhere?

Two simple changes from my pov:

 * Remove the changes to the files that have copyrightable code from
   people besides yourself & Stacey. This looks to be mostly the older
   files in the root bsd-user/ directory

 * Mention in the commit message that this change is being made only
   to files where yourself & Stacey are the copyright holders.


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


