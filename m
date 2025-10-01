Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 257F7CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 13:49:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3xBS-0007bl-72; Wed, 01 Oct 2025 09:47:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ben.dooks@codethink.co.uk>)
 id 1v3xBN-0007aj-6d; Wed, 01 Oct 2025 09:47:49 -0400
Received: from imap4.hz.codethink.co.uk ([188.40.203.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ben.dooks@codethink.co.uk>)
 id 1v3xB5-000422-2T; Wed, 01 Oct 2025 09:47:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
 Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
 Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=N107xt8JnNVKzXcfaW7rdlZsecX3tcM604TmF1cP5hI=; b=hHUZKVAIxow7pm82FLqgDFQeji
 VUyR1L+Jzy8tZflRr/hfE+5KKRCr9cs6nKsn94ta4k99hBAlzT3Yq5F5DGNF8Cv4u35ynfixz9+P0
 y+Lbkc38mzoU6ttX6AeSoaHghKVuzwbkDBD4BvByd/WlPDMEg6Xx2D+PL20Vm9HH4eggic6Gb58qZ
 ijq9pQhkLOn+2BgbuwUp9Dw5M6qfrWAEgxSOkxwmhLNhXRaTYWS/R1CXexb2JfE/fE60lCipERw3s
 8OnO45DnjMeSVClgjYvR7M02zeH74xOaAiU33SuDUvKys4jcyYycF96zdxjuJ93iqEN0fqgILMeiC
 z/U70zdQ==;
Received: from [167.98.27.226] (helo=[10.35.5.151])
 by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
 id 1v3xAc-005Yzh-9A; Wed, 01 Oct 2025 14:47:02 +0100
Message-ID: <2371c5d6-c74f-457a-819b-4baf157ddb26@codethink.co.uk>
Date: Wed, 1 Oct 2025 14:47:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/7] Add RISCV big endian support
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Roan Richmond <roan.richmond@codethink.co.uk>,
 lawrence.hunter@codethink.co.uk
Cc: felix.chong@codethink.co.uk, sagark@eecs.berkeley.edu, palmer@dabbet.com, 
 alistair.francis@wdc.com, bmeng.cn@gmail.com, qemu-riscv@nongnu.org,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20241220154616.283933-1-roan.richmond@codethink.co.uk>
 <6ad3dee0-0fe8-4368-b43f-e7f8f30ead24@canonical.com>
 <0878ebc9-f553-46b8-b2ff-b748bd45da88@ventanamicro.com>
Content-Language: en-GB
From: Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <0878ebc9-f553-46b8-b2ff-b748bd45da88@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=188.40.203.114;
 envelope-from=ben.dooks@codethink.co.uk; helo=imap4.hz.codethink.co.uk
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On 01/10/2025 12:32, Daniel Henrique Barboza wrote:
> (ccing qemu-devel ML - please send all patches to qemu-devel too)
> 
> On 9/30/25 6:46 AM, Heinrich Schuchardt wrote:
>> On 12/20/24 16:45, Roan Richmond wrote:
>>> This is part of our project to investigate big endian on RISC-V.
>>> The full information is documented on our gitlab[1] which includes
>>> source repositories, build information and project documentation.
>>>
>>> We have a minimal buildroot, qemu and kernel working on QEMU.
>>>
>>> As this is a work in progress any review or help is appreciated.
>>>
>>> [1] https://gitlab.com/CodethinkLabs/riscv_bigendian
>>>
>>> Ben Dooks (2):
>>>    target/riscv: Add big endian check for atomic ops
>>>    taregt/riscv: Add big endian checks for pagetable
>>>
>>> Lawrence Hunter (3):
>>>    target/riscv: Add SSTATUS_UBE
>>>    target/riscv: Add sfence.vma for endian change
>>>    target/riscv: Add big endian CPU target
>>
>> The RISC-V specification explicitly allows for bi-endian cpus. 
>> Shouldn't we change the existing generic RISC-V cpus to allow starting 
>> low-endian and switching the endianness at runtime instead of adding a 
>> new CPU?
> 
> 
> Mainline Linux stated that RISC-V BE support will be "discouraged" (feel 
> free to read
> yet another Linus rant in linux-riscv - we're having multiple Linus 
> rants per month).
> This means that this work investigation will require at very least a 
> custom kernel that
> mainline won't support, which will in turn make it harder for QEMU to 
> properly support
> it in boot tests via TuxBoot and so on.
> 
> This doesn't mean that we should reject this work, but we should keep BE 
> exclusive logic
> separated from the generic LE code at least for now. Point being: the 
> split BE CPU
> target, like this series is already doing, seems like the way to go.
> 
> 
> Thanks,
> 
> Daniel

I think since there are other architectures already doing run-time
selectable endian I'm going to keep this in the series. I'll be replying
to the linux-kernel portion later when I'm less inclined to be rude to
Linus.

The linux-kernel changes are not huge so we could probably keep our own
out-of-tree for a bit, but I do not want to keep putting a lot of effort
into this without anyone else being interested.

Not sure if there would be any interested from any BSD for a kernel?

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html

