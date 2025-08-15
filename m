Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84592CA0ED1
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 11:15:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umsOC-0001pY-Fm; Fri, 15 Aug 2025 07:14:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1umsMt-0001JL-2J
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 07:13:08 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1umsMd-0000no-EI
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 07:13:06 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 42B9843E62;
 Fri, 15 Aug 2025 11:12:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB4CBC4CEF0;
 Fri, 15 Aug 2025 11:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1755256368;
 bh=m3XEMV/3A7O75M2frhQVoFUGUtIYI4gpzH4lfQS6aH0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=jMCzz3ttGi8wAlgob3Mrtk3rLupUrLdu2Aw92XCriYiQ168ldMgafpAt5xkF3WrJg
 8elUXQaEp/uwlOJjEOjPjG+LwGzHwjuedIE8ArG9reXdCI7S9AmSfkc5NYu1H2d0TB
 dFrn1V+eE8N6Y/wR30GL1Z+HUv2ZG+9tvhyf+Pd1M2BrAlXqY1yVOl5fslO0HmYshL
 6PBrnEkbXKVMSLW5FJXpBNkouBRzMK0xnAlFvU7UuVVnKHYR4nuLq9hE7QO+fMdB/4
 Vpm8EaSQlvzaOLEarYnhywJkSMl80gBPDfA4wYgv54SQiq6kHnSYfZsRtTY0Mp2v4U
 Shs8R/TCqGUJQ==
Date: Fri, 15 Aug 2025 13:12:43 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Subject: Re: [PATCH for-10.2 0/8] docs: Update our kernel-doc script to the
 kernel's new Python one
Message-ID: <20250815131243.35476966@foz.lan>
In-Reply-To: <CAFEAcA8Kck0ktFOK659rrrFvSkuc7WM_PEgPtEZAjXdgHtQ+5Q@mail.gmail.com>
References: <20250814171324.1614516-1-peter.maydell@linaro.org>
 <20250815101109.00006bcd@huawei.com>
 <20250815113931.7f4f60e7@foz.lan>
 <CAFEAcA8Kck0ktFOK659rrrFvSkuc7WM_PEgPtEZAjXdgHtQ+5Q@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=mchehab+huawei@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Em Fri, 15 Aug 2025 11:10:05 +0100
Peter Maydell <peter.maydell@linaro.org> escreveu:

> On Fri, 15 Aug 2025 at 10:39, Mauro Carvalho Chehab
> <mchehab+huawei@kernel.org> wrote:
> >
> > Hi Peter/Jonathan,
> >
> > Em Fri, 15 Aug 2025 10:11:09 +0100
> > Jonathan Cameron <Jonathan.Cameron@huawei.com> escreveu:
> >  
> > > On Thu, 14 Aug 2025 18:13:15 +0100
> > > Peter Maydell <peter.maydell@linaro.org> wrote:
> > >  
> > > > Earlier this year, the Linux kernel's kernel-doc script was rewritten
> > > > from the old Perl version into a shiny and hopefully more maintainable
> > > > Python version. This commit series updates our copy of this script
> > > > to the latest kernel version. I have tested it by comparing the
> > > > generated HTML documentation and checking that there are no
> > > > unexpected changes.  
> >
> > Nice! Yeah, I had a branch here doing something similar for QEMU,
> > but got sidetracked by other things and didn't have time to address
> > a couple of issues. I'm glad you find the time for it.
> >  
> > > > Luckily we are carrying very few local modifications to the Perl
> > > > script, so this is fairly straightforward. The structure of the
> > > > patchset is:
> > > >  * a minor update to the kerneldoc.py Sphinx extension so it
> > > >    will work with both old and new kernel-doc script output
> > > >  * a fix to a doc comment markup error that I noticed while comparing
> > > >    the HTML output from the two versions of the script
> > > >  * import the new Python script, unmodified from the kernel's version
> > > >    (conveniently the kernel calls it kernel-doc.py, so it doesn't
> > > >    clash with the existing script)  
> >  
> > > >  * make the changes to that library code that correspond to the
> > > >    two local QEMU-specific changes we carry  
> >
> > To make it easier to maintain and keep in sync with Kernel upstream,
> > perhaps we can try to change Kernel upstream to make easier for QEMU
> > to have a class override for the kdoc parser, allowing it to just
> > sync with Linux upstream, while having its own set of rules on a
> > separate file.  
> 
> Mmm, this would certainly be nice, but at least so far we haven't
> needed to make extensive changes, luckily (you can see how small
> our local adjustments are here).

I just reviewed the series. IMO, if you create a class override for
RestOutput, as I suggested, there will be just a single line
of difference:

	            (r"QEMU_[A-Z_]+ +", "", 0),

Not sure about others, but, from my side, I don't mind picking a
patch like that at Kernel upstream, if it doesn't cause any
regressions there (unlikely, but I didn't check).

> > > >  * tell sphinx to use the Python version
> > > >  * delete the Perl script (I have put a diff of our local mods
> > > >    to the Perl script in the commit message of this commit, for
> > > >    posterity)
> > > >
> > > > The diffstat looks big, but almost all of it is "import the
> > > > kernel's new script that we trust and don't need to review in
> > > > detail" and "delete the old script".  
> >
> > One thing that should be noticed is that Jonathan Corbet is currently
> > doing several cleanups at the Python script, simplifying some
> > regular expressions, avoiding them when str.replace() does the job
> > and adding comments. The end goal is to make it easier for developers
> > to understand and help maintaining its code.
> >
> > So, it is probably worth backporting Linux upstream changes after
> > the end of Kernel 6.17 cycle.  
> 
> Thanks for the heads-up on that one. A further sync should
> be straightforward after this one, I expect.

Yeah, it sounds so.

> > > > We should also update the Sphinx plugin itself (i.e.
> > > > docs/sphinx/kerneldoc.py), but because I did not need to do
> > > > that to update the main kernel-doc script, I have left that as
> > > > a separate todo item.  
> >
> > The Kernel Sphinx plugin after the change is IMHO (*) a lot cleaner
> > than before, and hendles better kernel-doc warnings, as they are now
> > using Sphinx logger class.  
> 
> Also as much as anything else it's just nice for us not to
> diverge if we can avoid it.
> 
> Incidentally, I'm curious if the kernel docs see problems
> with docutils 0.22 -- we had a report about problems there,
> at least some of which seem to be because the way kerneldoc.py
> adds its rST output is triggering the new docutils to complain
> if the added code doesn't have a consistent title style
> hierarchy: https://sourceforge.net/p/docutils/bugs/508/
> (It looks like they're trying to address this on the docutils side;
> we might or might not adjust on our side too by fixing up the
> title styles if that's not too awkward for us.)

I did test building only from 0.17 up to 0.21.2. It worked fine
for all of them. Now, 0.22 was released on 2025-07-29. I didn't
test it yet, nor I'm aware of anyone complaining about it on
Kernel MLs yet.

Btw, I wrote an upstream script to test building docs with different
Sphinx and docutils versions.

It is under:
	scripts/test_doc_build.py

It probably makes sense to port it to QEMU and add it to CI. Most of
the logic is independent from the Kernel. The only part that would
require adjustments is the logic at _handle_version() that creates
make commands to clean docs and build html.

> 
> > Btw, one important point to notice: if you picked the latest version
> > of kernel-doc, it currently requires at least Python 3.6 (3.7 is the
> > recommended minimal one). It does check that, silently bailing out
> > if Python < 3.6.  
> 
> QEMU already requires Python 3.9 or better; our configure checks:
> 
> check_py_version() {
>     # We require python >= 3.9.
>     # NB: a True python conditional creates a non-zero return code (Failure)
>     "$1" -c 'import sys; sys.exit(sys.version_info < (3,9))'
> }

Great!

> Thanks for the confirmation that the kernel is being more
> conservative on python requirements than we are; I did
> wonder about this but merely assumed you probably were
> rather than specifically checking :-)

Heh, an early change on 6.17 cycle incidentally made it requiring
3.9 ;-)

We ended changing it to preserve 3.7+ support, as we wanted to
ensure it would build with OpenSuse Leap.

> On this minor output change:
> 
> > > > "Definition" sections now get output with a trailing colon:
> > > >
> > > > -<p><strong>Definition</strong></p>
> > > > +<div class="kernelindent docutils container">
> > > > +<p><strong>Definition</strong>:</p>
> > > >
> > > > This seems like it might be a bug in kernel-doc since the Parameters,
> > > > Return, etc sections don't get the trailing colon. I don't think it's
> > > > important enough to worry about.  
> 
> is the extra colon intentional, or do you agree that it's
> a bug? You can see it in the kernel docs output at e.g.
> https://docs.kernel.org/core-api/workqueue.html#c.workqueue_attrs
> 
> where in the documentation of struct workqueue_attrs,
> "Definition:" gets a kernel but the corresponding "Members"
> and "Description" don't. 

This one predates kernel-doc.py, as it exists at the Perl version:

	$ grep Definition scripts/kernel-doc.pl
	    print $lineprefix . "**Definition**::\n\n";

It seems this was added on this upstream commit:

commit eaf710ceb5ae284778a87c0d0f2348c19e3e4751
Author: Jonathan Corbet <corbet@lwn.net>
Date:   Fri Sep 30 11:52:09 2022 -0600

    docs: improve the HTML formatting of kerneldoc comments
    
    Make a few changes to cause functions documented by kerneldoc to stand out
    better in the rendered documentation.  Specifically, change kernel-doc to
    put the description section into a ".. container::" section, then add a bit
    of CSS to indent that section relative to the function prototype (or struct
    or enum definition).  Tweak a few other CSS parameters while in the
    neighborhood to improve the formatting.
    
    Acked-by: Mauro Carvalho Chehab <mchehab@kernel.org>
    Signed-off-by: Jonathan Corbet <corbet@lwn.net>

While I don't matter much about that, IMO the best would be to drop
the extra ":" at the end.

Feel free to submit a Kernel patch upstream dropping it from 
scripts/lib/kdoc/kdoc_output.py.

> (Also "Description" is out-dented
> there when it probably should not be, but that's separate.)

Yeah, indenting Description makes sense to me. 

Thanks,
Mauro

