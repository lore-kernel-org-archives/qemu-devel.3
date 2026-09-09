Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6065C79F8C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 10:01:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4F7G-0005Rt-3B; Wed, 09 Sep 2026 06:01:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x4F75-0005Oq-JE; Wed, 09 Sep 2026 06:01:08 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x4F72-0005Yr-TT; Wed, 09 Sep 2026 06:01:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1788948033; bh=SVntUUgcopmTHWHS1E9b+KoBMuVX6MT7T3zobz7GOKo=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=Y7rayvQ6X7SHniL5Kms2EBU6Pj76qrji4JbKCIPXkSY8EdKZ9fyUZjAUQJFIdB9TJ
 nMWyCWD+eCnCoFndrYotnVjRZgz9q8mjDCMi1japXI443+nlNMrbVJnwoKmKY91nYk
 rNdRuORlzGevpRfLOpOemQhlBwuCJhJggu+8x0a4seFOG/Fnnjb7XhAJVdxxpzHgFK
 w8X9kxvtrS+cyejfVkktaYgFZq/y+wg4AzxrZb6UW9uim3xrafuodvfpuqAH5HIXbg
 54+3/50A6ECEbCnWdlFc+o5FFYQHE9oavw3UEx4knstyPG28UwCEXf+4lcVKeM0rLs
 05/jUMdiMmATQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6154D1D2D6D;
 Wed, 09 Sep 2026 13:00:33 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 1070742494E;
 Wed, 09 Sep 2026 13:01:02 +0300 (MSK)
Message-ID: <b2cf458b-4532-4580-a96e-166f810132a9@tls.msk.ru>
Date: Wed, 9 Sep 2026 13:01:01 +0300
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
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
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

>>>        target/loongarch: Fix SWI interrupt delivery via CSR_ESTAT
>>
>> Is it qemu-stable material?
>> (Currently active stable branches: 10.0, 11.0, 11.1).
> I think it should be applied to qemu-stable, currently it can apply to 11.0 and later, there is big conflict on 10.0.

It also conflicts with 11.0, due to v11.0.0-1700-gce969fa50bf
"target/loongarch: Use sys_state in cpu.c when accessing CSR registers".
I think I can apply ce969fa50bf to 11.0 too, but I don't see big value
there, - 11.0.x will have a single last update before reaching end-of-line.
So 11.1.x it is, only, for now.

Thanks,

/mjt

