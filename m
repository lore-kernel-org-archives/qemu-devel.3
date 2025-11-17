Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73723CE8D6B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 15:31:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL1C3-0002xs-7S; Mon, 17 Nov 2025 10:31:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlugg@mlugg.co.uk>)
 id 1vL1Bm-0002vp-Pe; Mon, 17 Nov 2025 10:30:48 -0500
Received: from mlugg.co.uk ([2001:19f0:7401:8244:5400:ff:fe24:ff33]
 helo=mail.mlugg.co.uk) by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlugg@mlugg.co.uk>)
 id 1vL1Bk-0004a7-MC; Mon, 17 Nov 2025 10:30:46 -0500
Received: from [IPV6:2001:8b0:abc0:29bf:bb12:7589:aee2:20c3]
 (3.c.0.2.2.e.e.a.9.8.5.7.2.1.b.b.f.b.9.2.0.c.b.a.0.b.8.0.1.0.0.2.ip6.arpa
 [IPv6:2001:8b0:abc0:29bf:bb12:7589:aee2:20c3])
 by mail.mlugg.co.uk (Postfix) with ESMTPSA id A7DB3359B5;
 Mon, 17 Nov 2025 15:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mlugg.co.uk; s=20200703;
 t=1763393441; h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CUR/V2qp7L5o8RGDvogyRpXfLVrJBT8DaCoQs0PTed8=;
 b=jRtyB/hS9JDY7Eu1FnEsbUlesOFBXHSdFBQR6s7UQiIP2w3zcc23D5QpEpGghCmLXnpNjN
 4y9fxWMZBzBzwfEHwdV2uYwSA0+A9SxlcsLpcMuuwFG7XXLQDA4tYazvNwx3mKO13dmE8Y
 /ejjBhIi+Ng0ED2vlfnxCn8BL3+LbRQ=
Message-ID: <255ff28a-4892-4703-ac0a-a560fd344d76@mlugg.co.uk>
Date: Mon, 17 Nov 2025 15:30:41 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] tests: add tcg coverage for fixed mremap bugs
From: Matthew Lugg <mlugg@mlugg.co.uk>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, laurent@vivier.eu, qemu-stable@nongnu.org
References: <20251011200337.30258-1-mlugg@mlugg.co.uk>
 <20251011200337.30258-5-mlugg@mlugg.co.uk>
 <CAFEAcA_mLnE5kEBMkpq1fNNq00ivND7wvRyBpxfxWpNSYd=PAA@mail.gmail.com>
 <cd467137-e2ad-48e8-b8fd-c395586aa06f@mlugg.co.uk>
Content-Language: en-US
In-Reply-To: <cd467137-e2ad-48e8-b8fd-c395586aa06f@mlugg.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:19f0:7401:8244:5400:ff:fe24:ff33;
 envelope-from=mlugg@mlugg.co.uk; helo=mail.mlugg.co.uk
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

On 11/17/25 15:13, Matthew Lugg wrote:
> On 10/20/25 16:26, Peter Maydell wrote:
>> I was going to complain about indent on this line, but the
>> problem seems to be that the file is incorrectly
>> indented with hardcoded tabs for parts of it.
> 
> Oops! I mostly work in a language where my editor config forces space 
> indentation, so occasionally forget to set space indentation when I do 
> need to. Will correct (and double-check indentation in the rest of the 
> series) in the next revision.

While working on this commit I just realised that you meant that 
*existing* parts of the file were indented with hard tabs (causing the 
apparent mismatch in the patch). Because there are quite a few hard tabs 
in the file, I'll leave them as-is to avoid a big whitespace diff, but 
will keep my added line correctly space-indented, as in the original 
patch. You (or whoever is involved in the final merge) can of course add 
a patch to fix the existing whitespace if you want.

