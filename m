Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72921CFB43F
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 07:53:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxiXZ-0000wN-Ir; Mon, 07 Oct 2024 03:52:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierre@freepascal.org>)
 id 1sxiXV-0000w2-7X
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 03:52:22 -0400
Received: from mail.freepascal.org ([178.33.235.90])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pierre@freepascal.org>) id 1sxiXT-00007T-Gt
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 03:52:20 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.freepascal.org (Postfix) with ESMTP id 217A4182445
 for <qemu-devel@nongnu.org>; Mon,  7 Oct 2024 07:52:15 +0000 (UTC)
Received: from mail.freepascal.org ([127.0.0.1])
 by localhost (idefixng.freepascal.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WC3xplVbN4VO for <qemu-devel@nongnu.org>;
 Mon,  7 Oct 2024 07:52:15 +0000 (UTC)
Received: from [192.168.50.107] (gw-ics.u-strasbg.fr [130.79.210.225])
 by mail.freepascal.org (Postfix) with ESMTPSA id EC8A0182434
 for <qemu-devel@nongnu.org>; Mon,  7 Oct 2024 07:52:14 +0000 (UTC)
Message-ID: <d2071e32-c35b-4cd1-a93e-a117c27a9ec1@freepascal.org>
Date: Mon, 7 Oct 2024 09:52:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/25] misc: Use explicit endian LD/ST API
To: qemu-devel@nongnu.org
References: <20241004163042.85922-1-philmd@linaro.org>
 <5a1606e1-649f-4bda-83e9-aff8c9dfd9f4@linaro.org>
Content-Language: en-US, fr
From: Pierre Muller <pierre@freepascal.org>
Autocrypt: addr=pierre@freepascal.org; keydata=
 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
 ahNt36rlsL9b9LfAbQgrNA4CfCLEAw==
In-Reply-To: <5a1606e1-649f-4bda-83e9-aff8c9dfd9f4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.33.235.90; envelope-from=pierre@freepascal.org;
 helo=mail.freepascal.org
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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
Reply-To: Pierre Muller <pierre@freepascal.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



Le 05/10/2024 à 03:39, Richard Henderson a écrit :
> On 10/4/24 09:30, Philippe Mathieu-Daudé wrote:
>> Philippe Mathieu-Daudé (25):
>>     gdbstub/helpers: Have ldtul_p() definition use ldn_p()
>>     target/hexagon: Replace ldtul_p() -> ldl_p()
>>     target/alpha: Replace ldtul_p() -> ldq_p()
>>     target/s390x: Replace ldtul_p() -> ldq_p()
>>     gdbstub/helpers: Introduce ldtul_$endian_p() helpers
>>     target/alpha: Use explicit little-endian LD/ST API
>>     target/hexagon: Use explicit little-endian LD/ST API
>>     hw/i386: Use explicit little-endian LD/ST API
>>     target/i386: Use explicit little-endian LD/ST API
>>     target/avr: Use explicit little-endian LD/ST API
>>     linux-user/i386: Use explicit little-endian LD/ST API
>>     target/loongarch: Use explicit little-endian LD/ST API
>>     target/sh4: Use explicit little-endian LD/ST API
>>     target/tricore: Use explicit little-endian LD/ST API
>>     target/rx: Use explicit little-endian LD/ST API
>>     target/riscv: Use explicit little-endian LD/ST API
>>     hw/m68k: Use explicit big-endian LD/ST API
>>     target/m68k: Use explicit big-endian LD/ST API
>>     hw/sparc: Use explicit big-endian LD/ST API
>>     target/sparc: Use explicit big-endian LD/ST API
>>     target/hppa: Use explicit big-endian LD/ST API
>>     hw/s390x: Use explicit big-endian LD/ST API
>>     target/s390x: Use explicit big-endian LD/ST API
>>     target/openrisc: Use explicit big-endian LD/ST API
>>     hw/ppc/e500: Use explicit big-endian LD/ST API
> 
> The sh4, rx, and riscv targets *can* support multiple endianness.
> 
> While we removed sh4eb for system mode, we still support sh4eb-linux-user, and therefore
> the target/sh4 patch affecting gdbstub is wrong.
> 
> RX sets endianness via a pin sampled at reset; if we ever implement this, it would be via
> a property on the cpu.  RISCV sets endianness via a couple of bits in MSTATUS; system mode
> would always use little-endian, but riscv64eb-user isn't out of the question.
> 
> While we have never supported rx or riscv in big-endian, but there's no reason that we
> can't, and those target/ patches make things harder. Since target/ will *always* have
> TARGET_BIG_ENDIAN available, I don't see that we're saving anything there.

   Isn't this also true for the sparc CPU?
At least llvm seems to think so:

$ ssh gcc421  /usr/bin/llvm-mc-18 --version
Debian LLVM version 18.1.8
   Optimized build.

   Registered Targets:
     aarch64    - AArch64 (little endian)
....
     sparc      - Sparc
     sparcel    - Sparc LE
     sparcv9    - Sparc V9
     systemz    - SystemZ


Pierre Muller

