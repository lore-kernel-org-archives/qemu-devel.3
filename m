Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA972CFA468
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Nov 2025 08:17:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMMKg-0007bP-2z; Fri, 21 Nov 2025 03:17:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@kernel.org>)
 id 1vMMKa-0007Yz-3v; Fri, 21 Nov 2025 03:17:24 -0500
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@kernel.org>)
 id 1vMMKY-0004UI-6G; Fri, 21 Nov 2025 03:17:23 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id E3D0360225;
 Fri, 21 Nov 2025 08:17:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B604C113D0;
 Fri, 21 Nov 2025 08:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1763713038;
 bh=XOHN5JVsLO5OxDzIloXtT+r7pwk2KC8RMCKn/h6vKDg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=tLdLljGRKRoN/z2cQfC9r12upDgNWUd1b2vhHN0PHXGXS5xKdRr/kdyrxea6t6lLD
 a3tdTR+k8LVEBWPbbqRVMf4cPvtaIgua8gPubCVrZQRMEWunW9HG0DfhPxcX6GSCXs
 USFSZFsNwZO+PWj0vY+MBCat623sq+dKIBcnqFc7/mfLQ25iM0MKEP9GOlpTsYNhof
 IvVqPvqFKA1UgBvaBUIPa/4GpgZ3E/o1Bh/T3pICaYVWTsY76wTkGwxNPeSk5QSMEZ
 4wy4SAaRjsD/kPVm6W1GalOGBIrKeRs+O/qWAl278w5RE+gmJQq6/4fqRoymICyBqv
 K8LNkAAxjJwUQ==
Message-ID: <32bd7a2e-5030-4170-846c-b9c01cde6bc9@kernel.org>
Date: Fri, 21 Nov 2025 09:17:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] MAINTAINERS: s390 maintainer updates
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
References: <20251120104602.205718-1-david@kernel.org>
 <5ef76d62-ff82-4766-9ce2-dd2c3e21c8d4@redhat.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <5ef76d62-ff82-4766-9ce2-dd2c3e21c8d4@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=david@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 11/21/25 08:34, Thomas Huth wrote:
> On 20/11/2025 11.46, David Hildenbrand (Red Hat) wrote:
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
>> ---
>>    MAINTAINERS | 9 +++++----
>>    1 file changed, 5 insertions(+), 4 deletions(-)
> 
> Thank you so much again for your past work, David!

Also thanks to your for your kind words (including the ones in the 
offline discussion before this patch :) )!!
-- 
Cheers

David

