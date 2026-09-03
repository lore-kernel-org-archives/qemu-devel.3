Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D572C624D6
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 14:59:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x28tj-0000zZ-A1; Thu, 03 Sep 2026 10:58:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1x28th-0000z9-0L; Thu, 03 Sep 2026 10:58:37 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1x28te-0003zZ-90; Thu, 03 Sep 2026 10:58:36 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with UTF8SMTP id AQAAfwD3_xsOi5lqMlZhBQ--.49393S2; 
 Thu, 03 Sep 2026 22:58:22 +0800 (CST)
Received: from [192.168.2.11] (unknown [113.246.117.39])
 by mail (Coremail) with SMTP id AQAAf8DwfXMIi5lqg6m0AA--.61257S2;
 Thu, 03 Sep 2026 22:58:20 +0800 (CST)
Message-ID: <ba9005ea-5616-495f-b817-5d90b4ce1ca0@phytium.com.cn>
Date: Thu, 3 Sep 2026 22:58:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v5 28/28] [NOT-MERGE] hw/arm/smmuv3: temporarily enable SEL2
 bit and some other features
To: eric.auger@redhat.com, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Mostafa Saleh <smostafa@google.com>, Chao Liu <chao.liu@processmission.com>,
 Jim MacArthur <jim.macarthur@linaro.org>
References: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
 <20260813162644.2810021-2-tangtao1634@phytium.com.cn>
 <a328d6e7-fa27-4279-b0da-bd68cf73e207@redhat.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <a328d6e7-fa27-4279-b0da-bd68cf73e207@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DwfXMIi5lqg6m0AA--.61257S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAHBWqYeU0G5wAAsk
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7KFy7Jr4fJF48GFWxWw1DGFg_yoW8GFyrpF
 W7Krn0kr4xWFyagr97Jw17WFn8Aa93JrW3JrZ3Jw1UZrZ8ur1rJrWIkrsY9F1kWrZ7Gana
 gF1qvFyxJryYvrJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 2026/8/31 16:54, Eric Auger wrote:
> Hi Tao,
>
> On 8/13/26 6:26 PM, Tao Tang wrote:
>> Temporarily:
>> - enable S_IDR1.SEL2,
>> - change AIDR to 0x2 to indicate SMMUv3.2,
>> - use smaller SID size and Cmd/Evt queue size.
> Each of those changes shall be carefully justified.
>
> Weren't there any assumpion in previous patches that we supported 3.2.
> tbh I did not notice you changed it in the last patch. wrt that change
> we would need to be careful the 3.2 does not require us to implement new
> features besides secure stuff.


You are right.  The cover letter explains that this is a Hafnium 
bring-up patch, but the patch itself does not explain why each override 
is needed.

These overrides are only intended to let Hafnium reach the Secure-bank 
MMIO access test.  They do not mean that QEMU implements Secure stage 2 
or the complete SMMUv3.2 architecture. We should even drop this patch 
when we test DMA translation with iommu-testdev [1]

[1]: 
https://gitlab.com/TaoTang/qemu/-/commits/integration/secure-smmu-v5-qtest

I will document these individual constraints in the commit message and 
keep this patch outside the final mergeable series.

Best regards,
Tao


>
> Thanks
>
> Eric
>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>> ---
>>   hw/arm/smmuv3.c                | 3 ++-
>>   include/hw/arm/smmuv3-common.h | 6 +++---
>>   2 files changed, 5 insertions(+), 4 deletions(-)
>>
>>


