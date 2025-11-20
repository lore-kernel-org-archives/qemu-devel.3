Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F210CF8848
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 11:52:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM3DL-0004wb-15; Thu, 20 Nov 2025 06:52:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@kernel.org>)
 id 1vM3DK-0004wJ-2G; Thu, 20 Nov 2025 06:52:38 -0500
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@kernel.org>)
 id 1vM3DI-0002IR-KS; Thu, 20 Nov 2025 06:52:37 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 64D7E6011E;
 Thu, 20 Nov 2025 11:52:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A012BC116B1;
 Thu, 20 Nov 2025 11:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1763639554;
 bh=ExA0xOkbbHbjoMcMeiczFAhHVzvri8EteI6sD6HHMFw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=c8/DIzqk0+bpWqayDGtZ3LyZSBirxIZaMzpQiFJS1lU/zWrkxrGGzZ1PzhXLj48yf
 GtNCYCKL00OS3Os1I+g78dAadnV8xfgDlr/Fih+kyhP43J+Ptgiv4AfhWFUMA8Gred
 FNkCfx9YLssEzI8kY+G3xt2dLk/8XmhlWWqJTmksSoRGkxdFnvORGEJqF+RcR5AEjW
 DgDeoPe3wAiilNdM5vqZLiZiGHDY5l3QUBPcRUUXORPgKi5clGMQfwwu0680UNsDvS
 Swr+JQe3L+rX3TmGm1rFKD6qwaQTR7M54jZk6rnG8tqop/lyIrbSvqCk4uOqWhv+wc
 bZXsvOOP+E2Lg==
Message-ID: <aea5c335-4f28-4f82-825a-229c4065eab0@kernel.org>
Date: Thu, 20 Nov 2025 12:52:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] MAINTAINERS: s390 maintainer updates
To: Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-devel@nongnu.org, 
 qemu-s390x@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
References: <20251120104602.205718-1-david@kernel.org>
 <cb7ac0cf-940a-4079-aa84-4433a4b49908@linux.ibm.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <cb7ac0cf-940a-4079-aa84-4433a4b49908@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=david@kernel.org; helo=tor.source.kernel.org
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

On 11/20/25 11:53, Christian Borntraeger wrote:
> Am 20.11.25 um 11:46 schrieb David Hildenbrand (Red Hat):
>> Unfortunately, I don't have a lot of capacity lately to take good care of
>> s390 in QEMU like I used to; and it doesn't look like that situation
>> will change. So let me convert myself to a reviewer in the s390 areas I
>> co-maintain.
>>
>> Fortunately, we still have two other maintainers for "S390 floating
>> interrupt controller", so no action needed on that front.
>>
>> For the other sections we get two new maintainers: Hendrik will
>> maintain "S390 CPU models" and Ilya will co-maintain "S390 TCG CPUs".
>>
>> Thanks Hendrik and Ilya for stepping up!
>>
>> Cc: Richard Henderson <richard.henderson@linaro.org>
>> Cc: Thomas Huth <thuth@redhat.com>
>> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
>> Cc: Ilya Leoshkevich <iii@linux.ibm.com>
>> Cc: Halil Pasic <pasic@linux.ibm.com>
>> Cc: Hendrik Brueckner <brueckner@linux.ibm.com>
>> Cc: Matthew Rosato <mjrosato@linux.ibm.com>
>> Signed-off-by: David Hildenbrand (Red Hat) <david@kernel.org>
> 
> Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> 
> Thank you for your work on s390/kvm is the past. There would be no gdb,
> nesting, cpumodel and virtio-mem support without you for s390. You did
> an awesome job.

Thanks a lot for your kind word Christian, highly appreciated!

... without you, I wouldn't even have had the opportunity to do any of 
that work and would likely not be doing the work I do today, so thanks 
to you for that as well! :)

-- 
Cheers

David

