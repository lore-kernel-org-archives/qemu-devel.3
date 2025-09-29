Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23719CAC5B5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 10:40:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3BI4-0000nS-Qp; Mon, 29 Sep 2025 06:39:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1v3BHy-0000gx-LO; Mon, 29 Sep 2025 06:39:26 -0400
Received: from sgoci-sdnproxy-4.icoremail.net ([129.150.39.64])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1v3BHo-000472-Gd; Mon, 29 Sep 2025 06:39:26 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwCHj8+_YdpoyaBgCQ--.4S2;
 Mon, 29 Sep 2025 18:38:55 +0800 (CST)
Received: from [10.31.62.13] (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwCH7Om7Ydpofb0uAA--.1126S2;
 Mon, 29 Sep 2025 18:38:51 +0800 (CST)
Message-ID: <b98f1981-3866-46c7-833a-e4790415b3cc@phytium.com.cn>
Date: Mon, 29 Sep 2025 18:38:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/14] hw/arm/smmuv3: Make Configuration Cache
 security-state aware
To: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>
References: <20250925162618.191242-1-tangtao1634@phytium.com.cn>
 <20250925162618.191242-8-tangtao1634@phytium.com.cn>
 <4b90afba-d708-4628-a087-c16829ee0512@redhat.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <4b90afba-d708-4628-a087-c16829ee0512@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAfwCH7Om7Ydpofb0uAA--.1126S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAIBWjZjscLhAAAs7
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7trWDtw15Cw4UKr4xKr48Zwb_yoW8Zr48pF
 WFqa1jyws7WF13Xrn7Jr48KF1xu395Xr4fJrZ8Gr1v9F1DZryUtrWS9345CaykJrZxZF42
 q3y0gFy5Gwn8AFJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=129.150.39.64;
 envelope-from=tangtao1634@phytium.com.cn; helo=sgoci-sdnproxy-4.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Eric,

On 2025/9/29 17:55, Eric Auger wrote:
>
> On 9/25/25 6:26 PM, Tao Tang wrote:
>> This patch adapts the Configuration Cache (STE/CD caches) to support
>> multiple security states.
>>
>> The cache key, previously just the SMMUDevice, is now a composite key
>> of the SMMUDevice and the security index (sec_idx). This allows for
>> separate cache entries for the same device when operating in different
>> security states, preventing aliasing between secure and non-secure
>> configurations.
>>
>> The configuration cache invalidation functions have been refactored to
>> correctly handle multiple security states, ensuring that invalidation
>> commands operate on the appropriate cache entries.
>>
>> Finally, checks have been added to the stream table's MMIO read/write
>> logic to verify if the stream table is writable. This ensures that the
>> Configuration Cache management is compliant with the architecture.
> I think this patch shall be split too. I would suggest
>
> - In a preliminary patch, add txattrs and as new members in SMMUTransCfg
> + the related changes (smmu_get_ste, smmu_get_cd, smmu_find_ste.
> smmuv3_translate. Add their init in smmuv3_get_config while leaving the
> current key as is.
> - In a second patch, manage the new config key
> - then there are a bunch of changes which does not relate to
> configuration cache: smmu_writell, smmu_writel and
> smmu_strtab_base_writable. I think this can go in a separate patch.
>
> What do you think?
>
> Eric
>


Thank you for the detailed feedback and for taking the time to suggest a 
clear path forward.

You are absolutely right. I see now that this patch indeed mixes several 
distinct logical changes especially the mix of smmu_write/read and 
configuration cache maybe confused, and your suggestion to split it is 
the correct approach. It will certainly make the changes much easier to 
review and less error-prone.

I will do this in v3 series.

Thanks,
Tao



