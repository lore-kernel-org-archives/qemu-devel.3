Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FCC1CE8D6B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 15:13:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL0v6-0004nQ-2z; Mon, 17 Nov 2025 10:13:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlugg@mlugg.co.uk>)
 id 1vL0uz-0004m0-GB; Mon, 17 Nov 2025 10:13:25 -0500
Received: from mlugg.co.uk ([104.238.170.239] helo=mail.mlugg.co.uk)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlugg@mlugg.co.uk>)
 id 1vL0ux-00010f-AK; Mon, 17 Nov 2025 10:13:25 -0500
Received: from [IPV6:2001:8b0:abc0:29bf:bb12:7589:aee2:20c3]
 (3.c.0.2.2.e.e.a.9.8.5.7.2.1.b.b.f.b.9.2.0.c.b.a.0.b.8.0.1.0.0.2.ip6.arpa
 [IPv6:2001:8b0:abc0:29bf:bb12:7589:aee2:20c3])
 by mail.mlugg.co.uk (Postfix) with ESMTPSA id 94C0E359B5;
 Mon, 17 Nov 2025 15:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mlugg.co.uk; s=20200703;
 t=1763392400; h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UXL6tD5GXHkZFzWOCXalEvnkUSXAM0OvORACpddAs4s=;
 b=Xw7zPoCYSOUKy3L820gk4OkOvkjs9pLGm1mKpE8aBbIfnXh9rdHf5TV4kyO7tZSNklqzaB
 092jdON/19/ItfARAvM8N4N4TIvKBU6FInHJc88TyJGZq/NneLl82WPezpE4y9qF8ISP+4
 gvmlXQHKPvRmK1hGp5Pd/tBhF/oG3W8=
Message-ID: <cd467137-e2ad-48e8-b8fd-c395586aa06f@mlugg.co.uk>
Date: Mon, 17 Nov 2025 15:13:20 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] tests: add tcg coverage for fixed mremap bugs
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, laurent@vivier.eu, qemu-stable@nongnu.org
References: <20251011200337.30258-1-mlugg@mlugg.co.uk>
 <20251011200337.30258-5-mlugg@mlugg.co.uk>
 <CAFEAcA_mLnE5kEBMkpq1fNNq00ivND7wvRyBpxfxWpNSYd=PAA@mail.gmail.com>
Content-Language: en-US
From: Matthew Lugg <mlugg@mlugg.co.uk>
In-Reply-To: <CAFEAcA_mLnE5kEBMkpq1fNNq00ivND7wvRyBpxfxWpNSYd=PAA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=104.238.170.239; envelope-from=mlugg@mlugg.co.uk;
 helo=mail.mlugg.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 10/20/25 16:26, Peter Maydell wrote:
>> +#define _GNU_SOURCE
> 
> Why do we need to define this now ?

'mremap' isn't POSIX, so on Linux at least is only exposed if 
_GNU_SOURCE is defined.
  >> -    fprintf(stderr, "FAILED at %s:%d\n", __FILE__, __LINE__); \
>> +    fprintf(stderr, " FAILED at %s:%d\n", __FILE__, __LINE__); \
> 
> I think that this is trying to fix a cosmetic bug in
> the printing of error messages: the tests each print
> some line without a newline, like:
>    fprintf(stdout, "%s addr=%p", __func__, (void *)addr);
> and then for the passing case we add a space and complete the line:
>    fprintf(stdout, " passed\n");
> 
> but this fail_unless() macro is not adding the space, so
> presumably we print something awkward like
> check_invalid_mmaps addr=0x12435468FAILED at ...
> 
> But we should separate out this trivial cleanup from
> the patch adding a new test case.
> 
>> [snip]
> 
> Can we leave the printfs for the existing test cases alone?
> You can add a new one for your new subcase:
>         fprintf(stdout, "%s mremap addr=%p", __func__, addr);

Sorry about all of this---I got quite confused by the printing logic in 
this file, mainly because AFAICT it's pretty buggy. For instance, the 
old prints in 'check_invalid_mmaps' would have caused output something 
like this:

   check_invalid_mmap addr=0x1234check_invalid_mmap addr=0x1234 passed

I agree that this is a separate issue though, so I'll put all of the 
printing logic back how it was and add a matching fprintf for my new 
subcase. I'll leave the cleanup here to someone else.

>> @@ -496,6 +532,7 @@ int main(int argc, char **argv)
>>          check_file_fixed_eof_mmaps();
>>          check_file_unfixed_eof_mmaps();
>>          check_invalid_mmaps();
>> +    check_shrink_mmaps();
> 
> I was going to complain about indent on this line, but the
> problem seems to be that the file is incorrectly
> indented with hardcoded tabs for parts of it.

Oops! I mostly work in a language where my editor config forces space 
indentation, so occasionally forget to set space indentation when I do 
need to. Will correct (and double-check indentation in the rest of the 
series) in the next revision.

Thanks for the feedback!

-- 
Matthew

