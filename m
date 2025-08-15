Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFD0BCA0EE4
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 09:40:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umquV-0001Li-NU; Fri, 15 Aug 2025 05:39:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1umquU-0001LP-GX
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 05:39:42 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1umquS-0001GO-3W
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 05:39:42 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id A8AA86115D;
 Fri, 15 Aug 2025 09:39:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A645C4CEEB;
 Fri, 15 Aug 2025 09:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1755250775;
 bh=TGdFa+w1KVKeMs5+K18A+q9IwQ5KSzYyfo6mayIwcac=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=qiPRPw342EEp+SZ9cW0TA3QOlNNT6uHcN74az5gCYwWiZLjjKKp5DBeqP/TzM6Eg9
 JUnWJkuXixDY2Pu+9gUhtFLlWSU/PWJDAlknfK8OQXbwNiCaQK88Q7f1FCA2/CtrU1
 xvENgiMrWrToSVkh5ipQaYixn2PI3uBc/m/nCIDTN95rB01zKLbQ8niqbmxxMm/wrp
 9DrhfCy/hL2gkCNFRFv3iG/lFB+EQJJNP9FeytKjcSIqGbO3N6Vpna+dsmXEwRso0b
 de4k5EOd4Ll9yE4P1vhg1E01oztP+d5G0UOAPlFW4/nYbivilN1pwM0ofoFvqtMKh9
 bzhBvYYcxIU4g==
Date: Fri, 15 Aug 2025 11:39:31 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, <qemu-devel@nongnu.org>, Paolo
 Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Subject: Re: [PATCH for-10.2 0/8] docs: Update our kernel-doc script to the
 kernel's new Python one
Message-ID: <20250815113931.7f4f60e7@foz.lan>
In-Reply-To: <20250815101109.00006bcd@huawei.com>
References: <20250814171324.1614516-1-peter.maydell@linaro.org>
 <20250815101109.00006bcd@huawei.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=mchehab+huawei@kernel.org; helo=tor.source.kernel.org
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

Hi Peter/Jonathan,

Em Fri, 15 Aug 2025 10:11:09 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> escreveu:

> On Thu, 14 Aug 2025 18:13:15 +0100
> Peter Maydell <peter.maydell@linaro.org> wrote:
> 
> > Earlier this year, the Linux kernel's kernel-doc script was rewritten
> > from the old Perl version into a shiny and hopefully more maintainable
> > Python version. This commit series updates our copy of this script
> > to the latest kernel version. I have tested it by comparing the
> > generated HTML documentation and checking that there are no
> > unexpected changes.

Nice! Yeah, I had a branch here doing something similar for QEMU, 
but got sidetracked by other things and didn't have time to address
a couple of issues. I'm glad you find the time for it.

> > Luckily we are carrying very few local modifications to the Perl
> > script, so this is fairly straightforward. The structure of the
> > patchset is:
> >  * a minor update to the kerneldoc.py Sphinx extension so it
> >    will work with both old and new kernel-doc script output
> >  * a fix to a doc comment markup error that I noticed while comparing
> >    the HTML output from the two versions of the script
> >  * import the new Python script, unmodified from the kernel's version
> >    (conveniently the kernel calls it kernel-doc.py, so it doesn't
> >    clash with the existing script)

> >  * make the changes to that library code that correspond to the
> >    two local QEMU-specific changes we carry

To make it easier to maintain and keep in sync with Kernel upstream,
perhaps we can try to change Kernel upstream to make easier for QEMU
to have a class override for the kdoc parser, allowing it to just
sync with Linux upstream, while having its own set of rules on a
separate file.

A RFC on that sense is welcomed. Otherwise, I'll try to spare some
time to think on a good way for doing that.

> >  * tell sphinx to use the Python version
> >  * delete the Perl script (I have put a diff of our local mods
> >    to the Perl script in the commit message of this commit, for
> >    posterity)
> > 
> > The diffstat looks big, but almost all of it is "import the
> > kernel's new script that we trust and don't need to review in
> > detail" and "delete the old script".  

One thing that should be noticed is that Jonathan Corbet is currently
doing several cleanups at the Python script, simplifying some
regular expressions, avoiding them when str.replace() does the job
and adding comments. The end goal is to make it easier for developers
to understand and help maintaining its code.

So, it is probably worth backporting Linux upstream changes after
the end of Kernel 6.17 cycle.

> 
> Given Mauro is somewhat active in qemu as well, +CC for information
> if nothing else.
> 
> Jonathan
> 
> 
> 
> > 
> > My immediate motivation for doing this update is that I noticed
> > that the submitter of https://gitlab.com/qemu-project/qemu/-/issues/3077
> > is using a Perl that complains about a construct in the perl script,
> > which prompted me to check if the kernel folks had already fixed
> > it, which it turned out that they had, by rewriting the whole thing :-)
> > More generally, if we don't do this update, then we're effectively
> > going to drift down the same path we did with checkpatch.pl, where
> > we have our own version that diverges from the kernel's version
> > and we have to maintain it ourselves.
> > 
> > We should also update the Sphinx plugin itself (i.e.
> > docs/sphinx/kerneldoc.py), but because I did not need to do
> > that to update the main kernel-doc script, I have left that as
> > a separate todo item.

The Kernel Sphinx plugin after the change is IMHO (*) a lot cleaner
than before, and hendles better kernel-doc warnings, as they are now
using Sphinx logger class.

(*) I'm a little bit suspicious when talking about it, as I did the
    changes there too ;-)

-

Btw, one important point to notice: if you picked the latest version
of kernel-doc, it currently requires at least Python 3.6 (3.7 is the 
recommended minimal one). It does check that, silently bailing out
if Python < 3.6. 

With Python 3.6, it emits a warning, as the parameter order for
structs and functions won't match the original order, as the script
assumes 3.7+ dict behavior where the insert order is preserved.

So, at QEMU build instructions, I would add a notice asking for at 
least 3.7 to build docs.

> > 
> > Testing
> > -------
> > 
> > I looked at the HTML output of the old kernel-doc script versus the
> > new one, using the following diff command which mechanically excludes
> > a couple of "same minor change" everywhere diffs, and eyeballing the
> > resulting ~150 lines of diff.
> > 
> > diff -w  -I '^<div class="kernelindent docutils container">$' -I '^</div>$' -I '^<p><strong>Definition</strong>' -r -u -x searchindex.js build/x86/docs-old-kerneldoc/manual build/x86/docs/manual
> > 
> > The HTML changes are:
> > 
> > (1) some paras now have ID tags, eg:
> > -<p><strong>Functions operating on arrays of bits</strong></p>
> > +<p id="functions-operating-on-arrays-of-bits"><strong>Functions operating on arrays of bits</strong></p>
> > 
> > (2) Some extra named <div>s, eg:
> > +<div class="kernelindent docutils container">
> >  <p><strong>Parameters</strong></p>
> >  <dl class="simple">
> >  <dt><code class="docutils literal notranslate"><span class="pre">long</span> <span class="pre">nr</span></code></dt><dd><p>the bit to set</p>
> > @@ -144,12 +145,14 @@
> >  <dt><code class="docutils literal notranslate"><span class="pre">unsigned</span> <span class="pre">long</span> <span class="pre">*addr</span></code></dt><dd><p>the address to start counting from</p>
> >  </dd>
> >  </dl>
> > +</div>
> > 
> > (3) The new version correctly parses the multi-line Return: block for
> > the memory_translate_iotlb() doc comment. You can see that the
> > old HTML here had dt/dd markup, and it mis-renders in the HTML at
> > https://www.qemu.org/docs/master/devel/memory.html#c.memory_translate_iotlb
> > 
> >  <p><strong>Return</strong></p>
> > -<dl class="simple">
> > -<dt>On success, return the MemoryRegion containing the <strong>iotlb</strong> translated</dt><dd><p>addr.  The MemoryRegion must not be
> >  accessed after rcu_read_unlock.
> > +<p>On success, return the MemoryRegion containing the <strong>iotlb</strong> translated
> > +addr.  The MemoryRegion must not be accessed after rcu_read_unlock.
> >  On failure, return NULL, setting <strong>errp</strong> with error.</p>
> > -</dd>
> > -</dl>
> > +</div>
> > 
> > "Definition" sections now get output with a trailing colon:
> > 
> > -<p><strong>Definition</strong></p>
> > +<div class="kernelindent docutils container">
> > +<p><strong>Definition</strong>:</p>
> > 
> > This seems like it might be a bug in kernel-doc since the Parameters,
> > Return, etc sections don't get the trailing colon. I don't think it's
> > important enough to worry about.
> > 
> > thanks
> > -- PMM
> > 
> > Peter Maydell (8):
> >   docs/sphinx/kerneldoc.py: Handle new LINENO syntax
> >   tests/qtest/libqtest.h: Remove stray space from doc comment
> >   scripts: Import Python kerneldoc from Linux kernel
> >   scripts/kernel-doc: strip QEMU_ from function definitions
> >   scripts/kernel-doc: tweak for QEMU coding standards
> >   scripts/kerneldoc: Switch to the Python kernel-doc script
> >   scripts/kernel-doc: Delete the old Perl kernel-doc script
> >   MAINTAINERS: Put kernel-doc under the "docs build machinery" section

I'll review the actual patches later.

> > 
> >  MAINTAINERS                     |    2 +
> >  docs/conf.py                    |    4 +-
> >  docs/sphinx/kerneldoc.py        |    7 +-
> >  tests/qtest/libqtest.h          |    2 +-
> >  .editorconfig                   |    2 +-
> >  scripts/kernel-doc              | 2442 -------------------------------
> >  scripts/kernel-doc.py           |  325 ++++
> >  scripts/lib/kdoc/kdoc_files.py  |  291 ++++
> >  scripts/lib/kdoc/kdoc_item.py   |   42 +
> >  scripts/lib/kdoc/kdoc_output.py |  749 ++++++++++
> >  scripts/lib/kdoc/kdoc_parser.py | 1670 +++++++++++++++++++++
> >  scripts/lib/kdoc/kdoc_re.py     |  270 ++++
> >  12 files changed, 3355 insertions(+), 2451 deletions(-)
> >  delete mode 100755 scripts/kernel-doc
> >  create mode 100755 scripts/kernel-doc.py
> >  create mode 100644 scripts/lib/kdoc/kdoc_files.py
> >  create mode 100644 scripts/lib/kdoc/kdoc_item.py
> >  create mode 100644 scripts/lib/kdoc/kdoc_output.py
> >  create mode 100644 scripts/lib/kdoc/kdoc_parser.py
> >  create mode 100644 scripts/lib/kdoc/kdoc_re.py
> >   
> 



Thanks,
Mauro

