Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C8FDC982C1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 08:20:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x77LQ-0007qd-V0; Thu, 17 Sep 2026 04:19:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x77LO-0007lz-EK; Thu, 17 Sep 2026 04:19:46 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x77LL-00029U-MD; Thu, 17 Sep 2026 04:19:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1789633129; bh=ZCJh5GikR8hCaA7RtWhd/Ifg37KVii/gWBI6ZYNOGEI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=diC2SyOey3dCan8rExES9Kt1S1eeGjjzBjLR1DUEdy/1dRf8orichaNjKIUw/rzgm
 zhdhZH2z6BKrGGHXgaLYyN2iF7rv8og+J1oCSdCprt4SgHlPX42VLa0bb1LS/T7rd7
 eS2B0iRMfBVqH8+KoWsQgdsPJWMHxAhTxRdc7ymhi7Y5KhmBO7wQsX4ohvfUtY1Uiz
 6gzjEZAYoBNj+XZbh0BG/SYCTn05MYr3OreN7ifL6/+60qZHlxqYSna/VD+MGSHNsR
 7HTEEHFN/Lo+m7h1I51Ppcp3oODmZ0qY0d3XWfMbcVQNQs3+3F41B+y6Vopwdmy7ZE
 4RZDpZhCMCFeQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 110181D5D58;
 Thu, 17 Sep 2026 11:18:49 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 87A3E42ABDA;
 Thu, 17 Sep 2026 11:19:33 +0300 (MSK)
Message-ID: <67bb79bf-a28a-49ac-8115-81945ea581ac@tls.msk.ru>
Date: Thu, 17 Sep 2026 11:19:33 +0300
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH v5 08/15] hw/riscv/virt.c: fix aclint soc/mtimer nodename
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 qemu-stable@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>
References: <20260828203918.350131-1-daniel.barboza@oss.qualcomm.com>
 <20260828203918.350131-9-daniel.barboza@oss.qualcomm.com>
 <725cf200-8a28-4fc9-8d96-4d705213505d@tls.msk.ru>
 <8594dca6-0af0-41a1-878b-1e7847b5f043@oss.qualcomm.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <8594dca6-0af0-41a1-878b-1e7847b5f043@oss.qualcomm.com>
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

On 9/16/26 20:10, Daniel Henrique Barboza wrote:
...>> I'm dropping this patch from the stable series for now, it is definitely
>> wrong.
> 
> It is ok to drop this.  This is a FDT issue that has been around for several
> years at this point and no one noticed.
> 
> In case you want to port it anyway the right fix would be this:
> 
> name = g_strdup_printf("/soc/mtimer@%lx", addr + RISCV_ACLINT_DEFAULT_MTIME);
> 
> This would fix the FDT nodename without messing with the format string.
HECK.  Now this is interesting.

I was so focused on the format string change, I haven't even noticed the
main part of this change - the RISCV_ACLINT_DEFAULT_MTIME addition.
This shows how my attention, which were trained on programming stuff for
decades, can be scarce - in a 2-line change I haven't noticed the second
line, despite looking at it multiple times.  What a mess and what a shame.. :)

Thanks, that makes perfect sense.

/mjt

