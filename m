Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66E4EC30653
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 15:07:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP1ZW-0005Vf-7d; Wed, 03 Jul 2024 11:07:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sP1ZT-0005SU-9a; Wed, 03 Jul 2024 11:06:59 -0400
Received: from out30-99.freemail.mail.aliyun.com ([115.124.30.99])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sP1ZP-0003Oz-T3; Wed, 03 Jul 2024 11:06:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1720019207; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=WwPcUZkUvwUvwprhPQwEl2G47ISRPmErCVga3TvGLtw=;
 b=GM+DC0foruUCW0W4kCoF48eJVKMmKhZsXSvWmXpJS4QktLdqIMYbTu3IlTYPkeQdJDlIJSnqpQY164T0wjUwRMJePTzLSuk45Vp+Bmzpsb2c1ymFF3m6i/9ldb1osauWLlXL5c4DJifKdKhliFu11rFARgNMlzH3x0W7/dzVflI=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R181e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033032014031;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W9ndwBX_1720019204; 
Received: from 30.32.68.10(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0W9ndwBX_1720019204) by smtp.aliyun-inc.com;
 Wed, 03 Jul 2024 23:06:45 +0800
Message-ID: <f4aec564-10ad-46cd-98f6-479e28cb73f2@linux.alibaba.com>
Date: Wed, 3 Jul 2024 23:05:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] target/riscv: Expose RV32 cpu to RV64 QEMU
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
References: <20240703123449.1108-1-zhiwei_liu@linux.alibaba.com>
 <41c74f3c-eaac-47aa-ae63-b89f6b322d96@linaro.org>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <41c74f3c-eaac-47aa-ae63-b89f6b322d96@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.99;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-99.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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


On 2024/7/3 21:08, Philippe Mathieu-Daudé wrote:
> Hi,
>
> On 3/7/24 14:34, LIU Zhiwei wrote:
>> From: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
>>
>> This patch set aims to expose 32-bit RISC-V cpu to RV64 QEMU. Thus
>> qemu-system-riscv64 can directly boot a RV32 Linux.
>>
>> This patch set has been tested with 6.9.0 Linux Image.
>> And add an avocado test in tests/avocado.
>>
>> v2:
>>    Remove the line that was inadvertently left in PATCH v1 4/6.
>>    Add an avocado test.
>>
>> v1:
>> https://mail.gnu.org/archive/html/qemu-riscv/2024-06/msg00501.html
>>
>> TANG Tiancheng (7):
>>    target/riscv: Add fw_dynamic_info32 for booting RV32 OpenSBI
>>    target/riscv: Adjust PMP size for no-MMU RV64 QEMU running RV32
>>    target/riscv: Correct SXL return value for RV32 in RV64 QEMU
>>    target/riscv: Detect sxl to set bit width for RV32 in RV64
>>    target/riscv: Correct mcause/scause bit width for RV32 in RV64 QEMU
>>    target/riscv: Enable RV32 CPU support in RV64 QEMU
>>    tests/avocado: Add an avocado test for riscv64
>
> On what is that based? It fails when applying:

Sorry. I forgot to rebase it to the master branch. And there is a riscv 
PR recently, which makes it fail to apply on the master branch.
Thanks for pointing it out.

The v3 patch set is here:
https://lists.gnu.org/archive/html/qemu-riscv/2024-07/msg00069.html

Thanks,
Zhiwei

>
> Applying: target/riscv: Add fw_dynamic_info32 for booting RV32 OpenSBI
> Applying: target/riscv: Adjust PMP size for no-MMU RV64 QEMU running RV32
> Applying: target/riscv: Correct SXL return value for RV32 in RV64 QEMU
> Applying: target/riscv: Detect sxl to set bit width for RV32 in RV64
> Applying: target/riscv: Correct mcause/scause bit width for RV32 in 
> RV64 QEMU
> Applying: target/riscv: Enable RV32 CPU support in RV64 QEMU
> Patch failed at 0006 target/riscv: Enable RV32 CPU support in RV64 QEMU
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
> error: patch failed: configs/targets/riscv64-softmmu.mak:1
> error: configs/targets/riscv64-softmmu.mak: patch does not apply
> hint: Use 'git am --show-current-patch=diff' to see the failed patch

