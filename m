Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0999D4A619
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 10:01:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vggdu-0003jb-Ox; Fri, 16 Jan 2026 05:01:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vggdp-0003hr-0H; Fri, 16 Jan 2026 05:01:17 -0500
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net ([209.97.181.73])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vggdm-0001yj-Ts; Fri, 16 Jan 2026 05:01:16 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwDn72NhDGppVjzgBQ--.36S2;
 Fri, 16 Jan 2026 18:01:05 +0800 (CST)
Received: from [10.31.62.13] (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwBHoe5bDGppeCEUAA--.21105S2;
 Fri, 16 Jan 2026 18:00:59 +0800 (CST)
Message-ID: <f30d6462-acfd-4691-afc1-7ad84faeb76a@phytium.com.cn>
Date: Fri, 16 Jan 2026 18:00:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v8 6/7] tests/qtest/libqos: Add SMMUv3 helper library
To: eric.auger@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
References: <20251224034647.2596434-1-tangtao1634@phytium.com.cn>
 <20251224034647.2596434-7-tangtao1634@phytium.com.cn>
 <a03abf43-60b9-4e80-be5c-f87dccf17dde@redhat.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <a03abf43-60b9-4e80-be5c-f87dccf17dde@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwBHoe5bDGppeCEUAA--.21105S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQARBWlpSgQE7AABsy
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7CFykGFyktw4rKryDtw1xuFg_yoW8XFyDpF
 nxJFsrtFyUJr18GrnrJr13AFyUJw4rtw18Ar18Gr1rJrn0yryUJw4UXr10gryUJrWjyr1j
 yr1UWFn8Jr1UJrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=209.97.181.73;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmja5ljk3lje4ms43mwaa.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Hi Eric,

On 2026/1/16 02:30, Eric Auger wrote:
> Hi Tao,
>
> On 12/24/25 4:46 AM, Tao Tang wrote:
>> Introduce qos-smmuv3, a reusable library for SMMUv3-related qtest
>> operations. This module encapsulates common tasks like:
>> ------------------------------<snip>------------------------------
>>
>>
>>
>> ------------------------------<snip>------------------------------
>> +
>> +#include "qemu/osdep.h"
>> +#include "hw/arm/smmuv3-common.h"
> In file included from ../tests/qtest/libqos/qos-smmuv3.c:16:
> /home/augere/UPSTREAM/qemu/include/hw/arm/smmuv3-common.h:14:10: fatal
> error: hw/registerfields.h: No such file or directory
>     14 | #include "hw/registerfields.h"
>        |          ^~~~~~~~~~~~~~~~~~~~~
>
> This needs a rebase after the move to header files I am afraid

Thanks for the hint. I'll rebase it in V9.


>> ------------------------------<snip>------------------------------
>>
>>
>>
>> ------------------------------<snip>------------------------------
>> +
>> +#ifndef QTEST_LIBQOS_SMMUV3_H
>> +#define QTEST_LIBQOS_SMMUV3_H
>> +
>> +#include "hw/misc/iommu-testdev.h"
>> +
>> +/*
>> + * SMMU MMIO register base. We hardcode this as base_memmap is 'static const'
>> + * in hw/arm/virt.c and not directly accessible here.
> this is not true anymore with -device arm-smmuv3. So you can explicitly
> state that will only work with machine wide vsmmu


OK. I'll explicitly state it here and other related places.


Best regards,

Tao


