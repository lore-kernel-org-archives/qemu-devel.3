Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124AC606A324
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 13:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=OPu3F+sc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU2Gg-0007JE-0n; Thu, 19 Nov 2026 08:33:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1xU2GW-0007HY-Q7
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 08:33:28 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1xU2GV-0004Og-7Y
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 08:33:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795095205; bh=Ia4xDRJ+gmNVJBFkArAQUeKUUD/MM6/vye8rK7QLKbs=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=OPu3F+sc3YD1rzn1IjU8wWYVpLhwX3jLOBiIwvY4a+zwVa+L9PXg62k1W1+fFYT4n
 hIxbuwPE/B/Nl24FP9paFtH2b6KcbKEx8tHnHokX49BIH4Px6SPGuByZRB4BxXg6IP
 y7OSVDMFigq39CCq3B6ScEFE6RzRIRloinUaAVlJu7DTicP1YRwHvmCcWXUPJ0nXq9
 dMvi3PK+h7Dae0hL8WSH9qurSZP2mHSZWyqwBgdWlG8bss8wgxW6ADOcwGt8Om58ye
 8LLuUluRCArspNK5HWaQVlkronpY9sC0r1Gl8ofalvP1LZY4sAPLWBXlSO7BvW7qXB
 i7Y5i2RYigAOQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9A5181E7F84;
 Thu, 19 Nov 2026 16:33:25 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 884B3461910;
 Thu, 19 Nov 2026 16:33:25 +0300 (MSK)
Message-ID: <9625a8d1-d74b-4f85-b27e-8ba2bfa64185@tls.msk.ru>
Date: Thu, 19 Nov 2026 16:33:25 +0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 for-11.2] hostmem: allow building without KVM support
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: David Hildenbrand <david@kernel.org>, Igor Mammedov
 <imammedo@redhat.com>, Peter Xu <peterx@redhat.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Fabiano Rosas <farosas@suse.de>
References: <20261119113309.1205353-1-mjt@tls.msk.ru>
 <18e8c852-9870-4232-aae7-66db4672fdd9@oss.qualcomm.com>
 <2fc4fb7c-7d8b-4af9-8ab2-6ce3682acd13@tls.msk.ru>
 <eda18b65-ad5e-4985-843a-bbadc5e7f390@oss.qualcomm.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <eda18b65-ad5e-4985-843a-bbadc5e7f390@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/19/26 14:54, Philippe Mathieu-Daudé wrote:
> On 2026-11-19 12:46, Michael Tokarev wrote:

>> Sure I can add
>>
>> #ifndef GUEST_MEMFD_FLAG_MMAP  (if you prefer not to use #ifndef CONFIG_KVM)
>> # define GUEST_MEMFD_FLAG_MMAP 0
>> # define GUEST_MEMFD_FLAG_INIT_SHARED 0
>> #endif
>>
>> but it much uglier and less understandable than #ifndef CONFIG_KVM.
> 
> As you prefer. That would be the first accelerator check in backends/,
> I'm not sure we want it (then they are hard to remove):
Well, sure, -- what would be the better way here?

I don't have particular preferences, I just want this bug to be fixed
(without sacrificing the future development ofc).

Thanks,

/mjt

