Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C53AC79F89
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 07:15:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3TZ8-0006so-TE; Mon, 07 Sep 2026 03:14:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x3TZ2-0006sR-UQ; Mon, 07 Sep 2026 03:14:52 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x3TZ0-0000uR-Cp; Mon, 07 Sep 2026 03:14:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1788765247; bh=2XZXmTQZQPuJfjX94JvpeAf2PdtOh5rdLxejPUGdx9c=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=x3ivDoYQONPDE1gEsEt3tJfKsG74MvJ7XbuNZLa19Ad69QwA1NwIBqWpCO/szEHa2
 rQAtTXzFwSP2orBd5Xs1/z9awRet6h6hEwSzNjAcIAM9sJB918zqbRQ7mBb0PRbKBe
 sxHJ6bC6fsb+5WGLW708jcJHjeY2CABcIrukWC/eS/UCiyqu1z1MD6s0EV2BQhUdAC
 1oEMfQcZeQKRE7OHm5BviGcJE4ZDusMf98YHK0nBbymxRitwxCq1CaxtN7ipyDDyFs
 5K9/GnL42/d79Ejc4/eMlmHDFG3rSr8SEbNDNw/nzl814GuG3mLHmNyJVBB1akWtnx
 MxBXn6BpDOZmg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id DA7BA1D232B;
 Mon, 07 Sep 2026 10:14:07 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 54E7B422784;
 Mon, 07 Sep 2026 10:14:32 +0300 (MSK)
Message-ID: <f1a35d39-3746-4d64-b576-5d86df13f6ab@tls.msk.ru>
Date: Mon, 7 Sep 2026 10:14:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/3] loongarch queue
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 qemu-devel@nongnu.org
Cc: QEMU Stable <qemu-stable@nongnu.org>
References: <20260827012811.1008381-1-gaosong@loongson.cn>
 <ea555c0f-1e4e-4bd0-8aad-a8c0b27b9c17@tls.msk.ru>
 <54dfc7c2-ef9c-695d-f481-dfe6bd7f5e85@loongson.cn>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <54dfc7c2-ef9c-695d-f481-dfe6bd7f5e85@loongson.cn>
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 8/28/26 04:58, Bibo Mao wrote:
> On 2026/8/28 上午1:25, Michael Tokarev wrote:
>> On 8/27/26 04:28, Song Gao wrote:
>>
>>> Bibo Mao (3):
>>>        hw/loongarch/boot: Check memory boundary in init_boot_rom()
>>>        hw/loongarch/virt: Add bootargs and initrd to device-tree
>>>        target/loongarch: Fix SWI interrupt delivery via CSR_ESTAT
>>
>> Is it qemu-stable material?
>> (Currently active stable branches: 10.0, 11.0, 11.1).
> I think it should be applied to qemu-stable, currently it can apply to 11.0 and later, there is big conflict on 10.0.

I'm sorry for not being explicit here.

My question was about this whole pull request, not about this
particular change :)

Should I pick all 3 or just one (or two)? :)

Thanks,

/mjt

