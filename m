Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 308E3CA0EE6
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 09:12:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umqTG-0005Or-Ms; Fri, 15 Aug 2025 05:11:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1umqTD-0005OA-G9
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 05:11:31 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1umqTA-0001Ze-1N
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 05:11:31 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4c3GS62Dt7z6L5MF;
 Fri, 15 Aug 2025 17:06:14 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 31041140279;
 Fri, 15 Aug 2025 17:11:12 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 15 Aug
 2025 11:11:11 +0200
Date: Fri, 15 Aug 2025 10:11:09 +0100
To: Peter Maydell <peter.maydell@linaro.org>
CC: <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, John Snow
 <jsnow@redhat.com>, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: [PATCH for-10.2 0/8] docs: Update our kernel-doc script to the
 kernel's new Python one
Message-ID: <20250815101109.00006bcd@huawei.com>
In-Reply-To: <20250814171324.1614516-1-peter.maydell@linaro.org>
References: <20250814171324.1614516-1-peter.maydell@linaro.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 14 Aug 2025 18:13:15 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> Earlier this year, the Linux kernel's kernel-doc script was rewritten
> from the old Perl version into a shiny and hopefully more maintainable
> Python version. This commit series updates our copy of this script
> to the latest kernel version. I have tested it by comparing the
> generated HTML documentation and checking that there are no
> unexpected changes.
> 
> Luckily we are carrying very few local modifications to the Perl
> script, so this is fairly straightforward. The structure of the
> patchset is:
>  * a minor update to the kerneldoc.py Sphinx extension so it
>    will work with both old and new kernel-doc script output
>  * a fix to a doc comment markup error that I noticed while comparing
>    the HTML output from the two versions of the script
>  * import the new Python script, unmodified from the kernel's version
>    (conveniently the kernel calls it kernel-doc.py, so it doesn't
>    clash with the existing script)
>  * make the changes to that library code that correspond to the
>    two local QEMU-specific changes we carry
>  * tell sphinx to use the Python version
>  * delete the Perl script (I have put a diff of our local mods
>    to the Perl script in the commit message of this commit, for
>    posterity)
> 
> The diffstat looks big, but almost all of it is "import the
> kernel's new script that we trust and don't need to review in
> detail" and "delete the old script".

Given Mauro is somewhat active in qemu as well, +CC for information
if nothing else.

Jonathan



> 
> My immediate motivation for doing this update is that I noticed
> that the submitter of https://gitlab.com/qemu-project/qemu/-/issues/3077
> is using a Perl that complains about a construct in the perl script,
> which prompted me to check if the kernel folks had already fixed
> it, which it turned out that they had, by rewriting the whole thing :-)
> More generally, if we don't do this update, then we're effectively
> going to drift down the same path we did with checkpatch.pl, where
> we have our own version that diverges from the kernel's version
> and we have to maintain it ourselves.
> 
> We should also update the Sphinx plugin itself (i.e.
> docs/sphinx/kerneldoc.py), but because I did not need to do
> that to update the main kernel-doc script, I have left that as
> a separate todo item.
> 
> Testing
> -------
> 
> I looked at the HTML output of the old kernel-doc script versus the
> new one, using the following diff command which mechanically excludes
> a couple of "same minor change" everywhere diffs, and eyeballing the
> resulting ~150 lines of diff.
> 
> diff -w  -I '^<div class="kernelindent docutils container">$' -I '^</div>$' -I '^<p><strong>Definition</strong>' -r -u -x searchindex.js build/x86/docs-old-kerneldoc/manual build/x86/docs/manual
> 
> The HTML changes are:
> 
> (1) some paras now have ID tags, eg:
> -<p><strong>Functions operating on arrays of bits</strong></p>
> +<p id="functions-operating-on-arrays-of-bits"><strong>Functions operating on arrays of bits</strong></p>
> 
> (2) Some extra named <div>s, eg:
> +<div class="kernelindent docutils container">
>  <p><strong>Parameters</strong></p>
>  <dl class="simple">
>  <dt><code class="docutils literal notranslate"><span class="pre">long</span> <span class="pre">nr</span></code></dt><dd><p>the bit to set</p>
> @@ -144,12 +145,14 @@
>  <dt><code class="docutils literal notranslate"><span class="pre">unsigned</span> <span class="pre">long</span> <span class="pre">*addr</span></code></dt><dd><p>the address to start counting from</p>
>  </dd>
>  </dl>
> +</div>
> 
> (3) The new version correctly parses the multi-line Return: block for
> the memory_translate_iotlb() doc comment. You can see that the
> old HTML here had dt/dd markup, and it mis-renders in the HTML at
> https://www.qemu.org/docs/master/devel/memory.html#c.memory_translate_iotlb
> 
>  <p><strong>Return</strong></p>
> -<dl class="simple">
> -<dt>On success, return the MemoryRegion containing the <strong>iotlb</strong> translated</dt><dd><p>addr.  The MemoryRegion must not be
>  accessed after rcu_read_unlock.
> +<p>On success, return the MemoryRegion containing the <strong>iotlb</strong> translated
> +addr.  The MemoryRegion must not be accessed after rcu_read_unlock.
>  On failure, return NULL, setting <strong>errp</strong> with error.</p>
> -</dd>
> -</dl>
> +</div>
> 
> "Definition" sections now get output with a trailing colon:
> 
> -<p><strong>Definition</strong></p>
> +<div class="kernelindent docutils container">
> +<p><strong>Definition</strong>:</p>
> 
> This seems like it might be a bug in kernel-doc since the Parameters,
> Return, etc sections don't get the trailing colon. I don't think it's
> important enough to worry about.
> 
> thanks
> -- PMM
> 
> Peter Maydell (8):
>   docs/sphinx/kerneldoc.py: Handle new LINENO syntax
>   tests/qtest/libqtest.h: Remove stray space from doc comment
>   scripts: Import Python kerneldoc from Linux kernel
>   scripts/kernel-doc: strip QEMU_ from function definitions
>   scripts/kernel-doc: tweak for QEMU coding standards
>   scripts/kerneldoc: Switch to the Python kernel-doc script
>   scripts/kernel-doc: Delete the old Perl kernel-doc script
>   MAINTAINERS: Put kernel-doc under the "docs build machinery" section
> 
>  MAINTAINERS                     |    2 +
>  docs/conf.py                    |    4 +-
>  docs/sphinx/kerneldoc.py        |    7 +-
>  tests/qtest/libqtest.h          |    2 +-
>  .editorconfig                   |    2 +-
>  scripts/kernel-doc              | 2442 -------------------------------
>  scripts/kernel-doc.py           |  325 ++++
>  scripts/lib/kdoc/kdoc_files.py  |  291 ++++
>  scripts/lib/kdoc/kdoc_item.py   |   42 +
>  scripts/lib/kdoc/kdoc_output.py |  749 ++++++++++
>  scripts/lib/kdoc/kdoc_parser.py | 1670 +++++++++++++++++++++
>  scripts/lib/kdoc/kdoc_re.py     |  270 ++++
>  12 files changed, 3355 insertions(+), 2451 deletions(-)
>  delete mode 100755 scripts/kernel-doc
>  create mode 100755 scripts/kernel-doc.py
>  create mode 100644 scripts/lib/kdoc/kdoc_files.py
>  create mode 100644 scripts/lib/kdoc/kdoc_item.py
>  create mode 100644 scripts/lib/kdoc/kdoc_output.py
>  create mode 100644 scripts/lib/kdoc/kdoc_parser.py
>  create mode 100644 scripts/lib/kdoc/kdoc_re.py
> 


