Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6026CD4F24
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 13:51:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMnW0-0004RF-PK; Tue, 12 May 2026 09:51:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maqianga@uniontech.com>)
 id 1wMmr3-0003hd-S1
 for qemu-devel@nongnu.org; Tue, 12 May 2026 09:08:57 -0400
Received: from smtpbgbr2.qq.com ([54.207.22.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maqianga@uniontech.com>)
 id 1wMmqw-0000fM-Qw
 for qemu-devel@nongnu.org; Tue, 12 May 2026 09:08:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
 s=onoh2408; t=1778591308;
 bh=xAaeCrKII3ccTaEQHdTzS2fZSvTux1jDjDXKrOUltX4=;
 h=Message-ID:Date:MIME-Version:Subject:To:From;
 b=eIVsu8UgfKofchFdI//vOObGSgc7mHHND8lvFsHo1XdwxP4FxbL/FemYE81RWoBcK
 eQR0T4Bkq6SQ9ynUzFkAXQtCYtJ8BjEhG7/fLKSp5vWmskEOBzRgCr61ECBXlojtmt
 bs80Im8oMLtDTaeSNq+KBSBpEJcF1N+aEZKikEOw=
X-QQ-mid: esmtpgz16t1778591306ta16c6bbe
X-QQ-Originating-IP: v42Skv+TVBzdSCcSdsqPk+1G1vQhyloIrY2Yc2WcKXw=
Received: from [10.10.73.115] ( [123.114.60.34])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 12 May 2026 21:08:24 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15680665402890294503
Message-ID: <B42EAB532328AD11+5fe4f14e-6f4a-460b-b776-32fdf1ebcd14@uniontech.com>
Date: Tue, 12 May 2026 21:08:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/loongarch/kvm: Include missing exec/cpu-defs.h
 header
To: gaosong <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, bibo mao <maobibo@loongson.cn>
References: <20260512121954.2248026-1-maqianga@uniontech.com>
 <81f4ad66-bb0d-e2c2-66c0-74a6ec595738@loongson.cn>
Content-Language: en-US
From: Qiang Ma <maqianga@uniontech.com>
In-Reply-To: <81f4ad66-bb0d-e2c2-66c0-74a6ec595738@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MrfJYRspGRl/9nNBOR1HMnj4MZCAGu4UUmObUmkpmp7zCyhEXktmxu40
 cxkK42ZmMPPKuqMi9uVZql7iIMx5S4F4H5+eESq7HRNoAbBaeg8Wpy0Cj7BjisRZJkbl1S4
 qu1gMLdQo1Kk81FaIPpXEhJ117B8L5FTPa0MKYFLlzdUCwo9VAMl8xg2jkSVkLZKyGRkzrF
 mMCf6ttumCFA9Ccb23ZGf4QGCpyUsqQttGWJLloo6Sej4QdWBw6LArvdz3suLrr2FJ5TYGq
 i52sG+Ntow8k8dJxmlkpNpdX6s9S8G3+iagRG9ILqbZ6JIBC2HWJOTUWw7DtLCLp8pbYvam
 ZeH5EcX77q8bi0cHfXDyXnGOBGgNAp7UIT355iE72bY2L4TxCIK5k9CnQfxw5gzYQq30lVV
 sRKI46RWkuh1qwxYuQ0atWdRQyNTVMAisgJrOc+bbd5cCbRkDHrPq4sY8dp+lKvp8mp5pcQ
 pDqlO7ixxEaM8kyd3jO54WLK8NuFumo3+XQDR2YGtQV6OhF0a0Z8jOz4Ctz/W2mYP92HKPU
 K7ZEGeS5RkbP4FsPZ1s/w31KtPyNRsXwWle79aYYV2PC9Qy0Y9gHze7CZ1fG54TIQ0xUl2N
 /JuYHaYkIfE98nxcvIQ2V86+JqAUU49IvH+iu7qbPaCAgbfBbQ1vdXTsJUZtR6ls6hxuRkd
 1PZm93S+BvBV7dFlH6d2RN4qaDEzgDuK3RO+I9Ltq2+ERHlpd8w3HfDdpToxjky8nQn7tRA
 tCVu5fO4nH3lUk9qP5OKDgXrBxYbbOfLmR8jg129bD9wah/sYgbvatbJ7TphCZi+JKtnPDO
 5y7fMdAUfVjARQAvjFePLBn4dJp8VGpdVFPfTXsWr0DKCUJNu9NLU9z9G9OvoW/CrqjcrxZ
 y6wWDk+0DMIs2PQPwwYF3iDNFt77X6q4H7a0UVXFD3mu6MxOpAswPUbmjkVdBrk1IISDHnB
 xT0kTBc20keSYeq5c/1rrPHHeJJhgNI+LmxbgNziwjXFnC1nWMrjm9heWffD3K7kRBF4Q61
 JI/brrHDaKmtNRRe36f2av7Rcv3ExUi8w+aaY9uknWPQ+tHwaf
X-QQ-XMRINFO: M/715EihBoGSFUuWXW4+SrE7ti6izjf8og==
X-QQ-RECHKSPAM: 0
Received-SPF: pass client-ip=54.207.22.56; envelope-from=maqianga@uniontech.com;
 helo=smtpbgbr2.qq.com
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_MUA_MOZILLA=2.309,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 12 May 2026 09:50:52 -0400
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


在 2026/5/12 20:36, gaosong 写道:
> +Philippe,and bibo.
> 在 2026/5/12 下午8:19, Qiang Ma 写道:
>> After commit 71cab1a42d2 removed the indirect include of
>> exec/cpu-defs.h from target/loongarch/cpu.h, the TARGET_FMT_lx
>> macro is no longer visible in kvm.c, causing build failures:
>>
>>    error: expected ')' before TARGET_FMT_lx
>>
>> Add the missing #include exec/cpu-defs.h to restore the
>> TARGET_FMT_lx definition.
>>
>> Signed-off-by: Qiang Ma <maqianga@uniontech.com>
>> ---
>>   target/loongarch/kvm/kvm.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
>> index 9d844c4905..7989aec7c7 100644
>> --- a/target/loongarch/kvm/kvm.c
>> +++ b/target/loongarch/kvm/kvm.c
>> @@ -6,6 +6,7 @@
>>    */
>>     #include "qemu/osdep.h"
>> +#include "exec/cpu-defs.h"
> Simply add exec/target_long.h.
OK, Add #include "exec/target_long.h" in v2.
>
> Thanks.
> Song Gao
>>   #include <sys/ioctl.h>
>>   #include <linux/kvm.h>
>>   #include "asm-loongarch/kvm_para.h"
>
>


