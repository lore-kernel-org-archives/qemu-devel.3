Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F538C61CE8
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 12:00:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOb9p-0005Xr-Fw; Mon, 09 Jun 2025 07:59:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ben.dooks@codethink.co.uk>)
 id 1uOb9m-0005We-Ht; Mon, 09 Jun 2025 07:59:14 -0400
Received: from imap5.colo.codethink.co.uk ([78.40.148.171])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ben.dooks@codethink.co.uk>)
 id 1uOb9g-00059a-TL; Mon, 09 Jun 2025 07:59:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
 Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
 Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=07Uf7/Eu+cwdlBu3XfwjD0GFXdbERCDrthyjqx/xd68=; b=wNTzsOYHguXpVF+ZQAkg5NfsdJ
 UR7PWdhiLb5fRi6U1/PEyuQibQOlWrONrykS0kejrLOMbuCHxb/t71mGlH+9Lc7ICjs37dO/A7gBo
 gihFiZ7WT0i7DwBxUEU4N9ZNXDSET6dEqGyH4ojpy1ssKqWb3ucSLFqfaZgDMN28arL2FSUvYx+YC
 wgXJx+YZY/Rvc7NwyCxH3c+d4YQY4/Se6ISdCLdUwuBRHPb0d5vzLUNmQBQOhX7mJOuk0ZJlwulcq
 50DG74Spf2SmCl+oJC0o9u8zbsLL0Xfo8zJDmsRs2vvukJkhZSee6WxpY+ziwhi7xAcT+Dk4s0SA4
 enZdfW2g==;
Received: from [63.135.74.212] (helo=[192.168.1.249])
 by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
 id 1uOb9Z-00FN6k-H1; Mon, 09 Jun 2025 12:59:01 +0100
Message-ID: <5663397f-e1b6-46fa-953d-fb21d1a700df@codethink.co.uk>
Date: Mon, 9 Jun 2025 12:59:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] target/riscv: add cva6 core type
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 nazar.kazakov@codethink.co.uk, joseph.baker@codethink.co.uk,
 fran.redondo@codethink.co.uk, lawrence.hunter@codethink.co.uk,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org
References: <20250527112437.291445-1-ben.dooks@codethink.co.uk>
 <20250527112437.291445-3-ben.dooks@codethink.co.uk>
 <ef6c7b15-04a7-42cf-a89b-c2674388810f@ventanamicro.com>
 <06323162-66b9-4165-ab2e-86ec6272aca8@codethink.co.uk>
 <341224e9-d335-40ac-af98-6395b3aede84@ventanamicro.com>
Content-Language: en-GB
From: Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <341224e9-d335-40ac-af98-6395b3aede84@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=78.40.148.171;
 envelope-from=ben.dooks@codethink.co.uk; helo=imap5.colo.codethink.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 09/06/2025 12:30, Daniel Henrique Barboza wrote:
> 
> 
> On 6/9/25 7:40 AM, Ben Dooks wrote:
>> On 07/06/2025 21:17, Daniel Henrique Barboza wrote:
>>>
>>>
>>> On 5/27/25 8:24 AM, Ben Dooks wrote:
>>>> Add TYPE_RISCV_CPU_CVA6 for the CVA6 core
>>>>
>>>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>>>> ---

> The README states right at the start:
> 
> 
> "CVA6 is a 6-stage, single-issue, in-order CPU which implements the 64- 
> bit RISC-V instruction set."
> 
> 
> So this means that CVA6 is a 64-bit CPU only. This means that we want 
> the second
> option: the CPU declaration is fine, but the CVA6 board must be built 
> only for 64
> bits. In patch 1, this line:
> 
> 
>>> config CVA6
>>>      bool
>>>      default y
>>>      depends on RISCV32 || RISCV64  <------------------
> 
> 
> Should be "depends on RISCV64".


I think given the confusion, let's go with the RISCV64 for now and if
it turns out there is an 32-bit build option we can always add it in
later and change anything else around.


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html

