Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4642CCA0ED3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2024 06:08:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sl0Dl-0006uT-2i; Mon, 02 Sep 2024 02:07:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=3a9v=QA=kaod.org=clg@ozlabs.org>)
 id 1sl0Dj-0006sx-7Y; Mon, 02 Sep 2024 02:07:23 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=3a9v=QA=kaod.org=clg@ozlabs.org>)
 id 1sl0Dg-0005eh-Bm; Mon, 02 Sep 2024 02:07:22 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Wxyvd3vdJz4x9G;
 Mon,  2 Sep 2024 16:07:09 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Wxyvb1HMYz4x9F;
 Mon,  2 Sep 2024 16:07:06 +1000 (AEST)
Message-ID: <85157261-6b91-4503-8423-e690079a1c5c@kaod.org>
Date: Mon, 2 Sep 2024 08:07:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/13] pnv/xive: Update PIPR when updating CPPR
To: Mike Kowal <kowal@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 milesg@linux.ibm.com
References: <20240801203008.11224-1-kowal@linux.ibm.com>
 <20240801203008.11224-12-kowal@linux.ibm.com>
 <5dad962a-0815-40b8-b62a-d0c67612fa5f@kaod.org>
 <16bbfc74-e7c0-41b6-a91f-c2d121296986@linux.ibm.com>
 <cd6dee9a-8a98-49c8-832d-692a55dba909@kaod.org>
 <6527910d-aa34-4abb-a57f-e5c1789d059c@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <6527910d-aa34-4abb-a57f-e5c1789d059c@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=3a9v=QA=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 8/30/24 19:06, Mike Kowal wrote:
> 
> On 8/30/2024 3:25 AM, Cédric Le Goater wrote:
>> On 8/29/24 22:35, Mike Kowal wrote:
>>>
>>> On 8/29/2024 7:29 AM, Cédric Le Goater wrote:
>>>> On 8/1/24 22:30, Michael Kowal wrote:
>>>>> From: Glenn Miles <milesg@linux.vnet.ibm.com>
>>>>>
>>>>> Current code was updating the PIPR inside the xive_tctx_accept() function
>>>>> instead of the xive_tctx_set_cppr function, which is where the HW would
>>>>> have it updated.
>>>>
>>>> Did you confirm with the HW designer ?
>>>>
>>>> AFAIR, the PIPR is constructed from the IPB and the later is it updated
>>>> the better. However, if now, both PIPR (HW and Pool) are required to
>>>> identify the ctx to notify, I agree set_cppr() needs a change but what
>>>> about xive_tctx_ipb_update() which is called when an interrupt
>>>> needs a resend ?
>>>
>>>
>>> This was fix to a bug and matches what  is specified in the XIVE2 architecture document CPPR flows (MMIO CPPR xxx processing).
>>
>> ok. I was also wondering if this was fixing a bug. Do you think this
>> is the correct commit id ?
>>
>>  cdd4de68edb6 ("ppc/xive: notify the CPU when the interrupt priority is more privileged")
>>
>> If so, could you please add a Fixes tags ?
>>
>> Thanks,
>>
>> C.
>>
> 
> Many of these parts have been changed multiple time for different things.   I am not sure which commit this fixes.  

I use 'tig blame <file>' to dig change history.

> I am upstreaming other peoples work  that was done over the last couple of years so it hard to tell.  Also,  the original xive support was only complete enough to support Linux.   Much of this I would consider 'new development' expanding XIVE support for Power VM.   If you think it should still have a fixes-tag, I will add it.

I think this is the right commit, please add it.

Could you also add your self as a Reviewer ?

Thanks,

C.

