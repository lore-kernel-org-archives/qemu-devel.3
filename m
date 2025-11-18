Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A0ADCEE351
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 19:53:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLRkj-0007XR-OQ; Tue, 18 Nov 2025 14:52:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@kernel.org>) id 1vLRkd-0007RR-5N
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 14:52:32 -0500
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@kernel.org>) id 1vLRkb-0005TQ-Fm
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 14:52:30 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 5EA3160017;
 Tue, 18 Nov 2025 19:52:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B076C16AAE;
 Tue, 18 Nov 2025 19:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1763495544;
 bh=kxRcSL4xSZf4abmyjZUEkuuxZ7hFWG01dItgk6l3hdg=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=CWhm1+jo803pHZIpus0KY92Gi+5GtFSdFyxF5nxjXg7AUZFPbG7g882a837hFhDds
 rJxEweFryHupT4014xI7Gjwh6Xemt77yGLRKFao09XrmU74CSSiJMsUspZ5SHb19sP
 OwwqbYo+7y0Kg1/ePpg8aHKvXbOW2Vq82wriIQZVAzw6tAwZXQcUxCeHjiytJhMf/g
 a/SnB+z7VRN7S11THeu/W0+SwS2mx94J4XkvHcouy3XvEEio0kh+7lH7Ax2jLWkext
 nUaUaWBE3nwSdefEOqPBrpMiIr4wjWCZfL6/Plq9R/dMHrzbNMBNUm276VMvCMty8I
 nQRsBqXVeOMww==
Message-ID: <3e41ffed-34cc-4a3f-a6bc-af0b8e5ab2fd@kernel.org>
Date: Tue, 18 Nov 2025 20:52:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Update David Hildenbrand's email address
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20251103103947.384401-1-david@kernel.org>
 <eff54689-b1a3-41f2-bcad-a62941aa9fc1@linaro.org>
 <ce6a1c5e-04ee-4961-b47d-a79195a97982@linaro.org>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <ce6a1c5e-04ee-4961-b47d-a79195a97982@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 18.11.25 19:56, Philippe Mathieu-Daudé wrote:
> On 18/11/25 19:09, Philippe Mathieu-Daudé wrote:
>> On 3/11/25 11:39, David Hildenbrand wrote:
>>> From: "David Hildenbrand (Red Hat)" <david@kernel.org>
>>>
>>> Switch to kernel.org email address as I will be leaving Red Hat. The
>>> old address will remain active until end of January 2026, so performing
>>> the change now should make sure that most mails will reach me.
>>>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> Signed-off-by: David Hildenbrand (Red Hat) <david@kernel.org>
>>> ---
>>>    .mailmap    |  1 +
>>>    MAINTAINERS | 18 +++++++++---------
>>>    2 files changed, 10 insertions(+), 9 deletions(-)
>>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>
> 
> Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> and queued :)

Thanks!

-- 
Cheers

David

