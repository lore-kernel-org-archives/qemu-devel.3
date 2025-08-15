Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3275CCA0EE4
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 10:34:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umrlM-00085v-O8; Fri, 15 Aug 2025 06:34:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1umrlK-00085Y-Ku
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 06:34:18 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1umrlI-0003QQ-7j
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 06:34:18 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id BE5F445911;
 Fri, 15 Aug 2025 10:34:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D8F1C4CEEB;
 Fri, 15 Aug 2025 10:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1755254049;
 bh=HYKstvQciL22/qXrFs7W/LFuH7a8hosoCmEj0kpalWE=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=qCMMKwiG1P/QBlzMIvBHpebkSNRWQ4m89GT7SqMszHmU92dX5ScXHET/c3HPWpGfV
 c+jX2otZyxlxma1FWb5YVQqOwMgjYrQCbofpEOgTYOVl4gixQLrEOlzG9C20ph9niB
 wlWgwHMBIvGKEAllkFkbaaQ26Qqzb0UUiJu0spt9fEZ17sQh1phyBDu37J0Ngmxl03
 LBQUF5DYiT/tfJ/Cq3ToFgawlnfBQdvQxRtGrD61/3fviZvEkFMFefRi670GUYJUMo
 MdBbA06294vAhDPfCi2WCCFI5St69wRouT9CQl49Y21tIKqvHDSHL/ugsCz0Q54icU
 dIlBlIFvxQa/A==
Date: Fri, 15 Aug 2025 12:34:05 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, John Snow
 <jsnow@redhat.com>
Subject: Re: [PATCH for-10.2 5/8] scripts/kernel-doc: tweak for QEMU coding
 standards
Message-ID: <20250815123405.535077e5@foz.lan>
In-Reply-To: <20250814171324.1614516-6-peter.maydell@linaro.org>
References: <20250814171324.1614516-1-peter.maydell@linaro.org>
 <20250814171324.1614516-6-peter.maydell@linaro.org>
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

Em Thu, 14 Aug 2025 18:13:20 +0100
Peter Maydell <peter.maydell@linaro.org> escreveu:

> This commit makes the equivalent changes to the Python script that we
> had for the old Perl script in commit 4cf41794411f ("docs: tweak
> kernel-doc for QEMU coding standards").  To repeat the rationale from
> that commit:
> 
>     Surprisingly, QEMU does have a pretty consistent doc comment style and
>     it is not very different from the Linux kernel's.  Of the documentation
>     "sigils", only "#" separates the QEMU doc comment style from Linux's,
>     and it has 200+ instances vs. 6 for the kernel's '&struct foo' (all in
>     accel/tcg/translate-all.c), so it's clear that the two standards are
>     different in this respect.  In addition, our structs are typedefed and
>     recognized by CamelCase names.
> 
> Note that in 4cf41794411f we used '(?!)' as our type_fallback regex;
> this is strictly not quite a replacement for the upstream
> '\&([_\w]+)', because the latter includes a group that can later be
> matched with \1, and the former does not.  The old perl script did
> not care about this, but the python version does, so we must include
> the extra set of brackets to ensure we have a group.
> 
> This commit does not include all the same changes that 4cf41794411f
> did.  Of the missing pieces, some had already gone in an earlier
> kernel-doc update; the parts we still had but do not include here are:
> 
>     @@ -2057,7 +2060,7 @@
>          }
>          elsif (/$doc_decl/o) {
>             $identifier = $1;
>     -       if (/\s*([\w\s]+?)(\(\))?\s*-/) {
>     +       if (/\s*([\w\s]+?)(\s*-|:)/) {
>                 $identifier = $1;
>             }
> 
>     @@ -2067,7 +2070,7 @@
>             $contents = "";
>             $section = $section_default;
>             $new_start_line = $. + 1;
>     -       if (/-(.*)/) {
>     +       if (/[-:](.*)/) {
>                 # strip leading/trailing/multiple spaces
>                 $descr= $1;
>                 $descr =~ s/^\s*//;
> 
> The second of these is already in the upstream version: the line r =
> KernRe("[-:](.*)") in process_name() matches the regex we have. 

Yes. If I recall correctly, we added this one to solve some issues on a 
couple of files that were full of ":" as separator. They violate what
is documented as a valid kernel-doc markup, but it didn't hurt adding 
support for such variant.

> The
> first change has been refactored into the doc_begin_data and
> doc_begin_func changes.  Since the output HTML for QEMU's
> documentation has no relevant changes with the new kerneldoc, we
> assume that this too has been handled upstream.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

LGTM, but see my notes below.

Anyway:

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

> ---
>  scripts/lib/kdoc/kdoc_output.py | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/scripts/lib/kdoc/kdoc_output.py b/scripts/lib/kdoc/kdoc_output.py
> index ea8914537ba..39fa872dfca 100644
> --- a/scripts/lib/kdoc/kdoc_output.py
> +++ b/scripts/lib/kdoc/kdoc_output.py
> @@ -38,12 +38,12 @@
>  type_fp_param2 = KernRe(r"\@(\w+->\S+)\(\)", cache=False)
>  
>  type_env = KernRe(r"(\$\w+)", cache=False)
> -type_enum = KernRe(r"\&(enum\s*([_\w]+))", cache=False)
> -type_struct = KernRe(r"\&(struct\s*([_\w]+))", cache=False)
> -type_typedef = KernRe(r"\&(typedef\s*([_\w]+))", cache=False)
> -type_union = KernRe(r"\&(union\s*([_\w]+))", cache=False)
> -type_member = KernRe(r"\&([_\w]+)(\.|->)([_\w]+)", cache=False)
> -type_fallback = KernRe(r"\&([_\w]+)", cache=False)

> +type_enum = KernRe(r"#(enum\s*([_\w]+))", cache=False)
> +type_struct = KernRe(r"#(struct\s*([_\w]+))", cache=False)
> +type_typedef = KernRe(r"#(([A-Z][_\w]*))", cache=False)
> +type_union = KernRe(r"#(union\s*([_\w]+))", cache=False)
> +type_member = KernRe(r"#([_\w]+)(\.|->)([_\w]+)", cache=False)
> +type_fallback = KernRe(r"((?!))", cache=False) # this never matches
>  type_member_func = type_member + KernRe(r"\(\)", cache=False)

That seems something that a class override would address it better.

Basically, you can do something like:


	type_enum = KernRe(r"#(enum\s*([_\w]+))", cache=False)
	type_struct = KernRe(r"#(struct\s*([_\w]+))", cache=False)
	type_typedef = KernRe(r"#(([A-Z][_\w]*))", cache=False)
	type_union = KernRe(r"#(union\s*([_\w]+))", cache=False)
	type_member = KernRe(r"#([_\w]+)(\.|->)([_\w]+)", cache=False)
	type_fallback = KernRe(r"((?!))", cache=False) # this never matches
	...

	(either keep the other types or add a __init__ that would append
         or replace only the above elements)

	class QemuRestFormat(RestFormatOutput):
	     highlights = [
	        (type_constant, r"``\1``"),
	        (type_constant2, r"``\1``"),

	        # Note: need to escape () to avoid func matching later
	        (type_member_func, r":c:type:`\1\2\3\\(\\) <\1>`"),
	        (type_member, r":c:type:`\1\2\3 <\1>`"),
	        (type_fp_param, r"**\1\\(\\)**"),
	        (type_fp_param2, r"**\1\\(\\)**"),
	        (type_func, r"\1()"),
	        (type_enum, r":c:type:`\1 <\2>`"),
	        (type_struct, r":c:type:`\1 <\2>`"),
	        (type_typedef, r":c:type:`\1 <\2>`"),
	        (type_union, r":c:type:`\1 <\2>`"),
	
	        # in rst this can refer to any type
	        (type_fallback, r":c:type:`\1`"),
	        (type_param_ref, r"**\1\2**")
	    ]

Where the above will be the QEMU-specific regexes.

Then, when creating a KernelFiles() instance at kerneldoc.py Sphinx
extension:

	def setup_kfiles(app):
            global kfiles

	    out_style = QemuRestFormat()
            kfiles = KernelFiles(out_style=out_style, logger=logger)

keeping the remaining code of the Kernel version of kerneldoc.py.

Thanks,
Mauro

