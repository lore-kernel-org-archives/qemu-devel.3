Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EE18EF9014
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 13:43:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy8yc-0006qj-Eo; Thu, 05 Mar 2026 08:42:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vy8yV-0006pq-Qb; Thu, 05 Mar 2026 08:42:48 -0500
Received: from zg8tmtu5ljy1ljeznc42.icoremail.net ([159.65.134.6])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vy8yS-0003vB-Tr; Thu, 05 Mar 2026 08:42:47 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwDXrERGiKlpWXuwAA--.3026S2;
 Thu, 05 Mar 2026 21:42:30 +0800 (CST)
Received: from [192.168.31.155] (unknown [113.246.233.224])
 by mail (Coremail) with SMTP id AQAAfwCnAO47iKlpUD4fAA--.53812S2;
 Thu, 05 Mar 2026 21:42:26 +0800 (CST)
Message-ID: <71c284dd-d290-4a3e-9aea-bb09e3c1936f@phytium.com.cn>
Date: Thu, 5 Mar 2026 21:42:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 10/31] hw/arm/smmu-common: Key configuration cache on
 SMMUDevice and SEC_SID
To: eric.auger@redhat.com, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mostafa Saleh <smostafa@google.com>, Chao Liu <chao.liu.zevorn@gmail.com>
References: <20260221100250.2976287-1-tangtao1634@phytium.com.cn>
 <20260221101437.2990803-1-tangtao1634@phytium.com.cn>
 <395c0640-c3bc-4f3e-9898-052fdbe68195@redhat.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <395c0640-c3bc-4f3e-9898-052fdbe68195@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwCnAO47iKlpUD4fAA--.53812S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAFBWmooSAF7AABsp
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7uryDtw48Wr1xZr18Gw15urg_yoW8tF1UpF
 W2g3W5AF1kGFyxCay3Xr4UWFy5ZrZ3Gr47JrsxGw1rCFn0yF1Fvr12ywn0kF98ur4kWF12
 v3yYvF4fCr1UAaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=159.65.134.6;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtu5ljy1ljeznc42.icoremail.net
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2026/3/3 00:54, Eric Auger wrote:
> Hi Tao,
>
> On 2/21/26 11:14 AM, Tao Tang wrote:
>> Adapt the configuration cache to support multiple security states by
>> introducing a composite key, SMMUConfigKey. This key combines the
>> SMMUDevice with SEC_SID, preventing aliasing between Secure and
>> Non-secure configurations for the same device, also the future Realm and
>> Root configurations.
> Looking at 27/31, the sec_sid of a device looks rather static, set by a
> property. However here you mention risk of aliasing between non secure
> and secure for a given sdev
>
> Please could you clarify?


You’re right. In the current RFC the PCI sec-sid is effectively static, 
via a device property, so a given sdev does not dynamically switch 
between Secure and Non-secure at runtime.

What I meant in this commit was not that this series already implements 
such dynamic switching. My intent with keying the cache by (SMMUDevice, 
SEC_SID) was to make the cache identity reflect the full security 
context of the translation/configuration, rather than implicitly 
depending on today’s PCI-side representation.

So for this RFC, the practical effect is mainly to keep the SMMU 
internal cache model aligned with the architectural security context, 
while avoiding baking the current static PCI representation into the 
cache design.

The commit message wording there was too broad, especially the “active 
in more than one security world” part. I’ll tighten that in the next 
revision.

Thanks,
Tao


>
> Thanks
>
> Eric
>> The cache lookup, insertion, and invalidation mechanisms are updated
>> to use this new keying infrastructure. This change is critical for
>> ensuring correct translation when a device is active in more than one
>> security world.
>>
>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>> Link: https://lore.kernel.org/qemu-devel/a9a840a6-c65f-4352-9a49-ddd1b5483f43@redhat.com/
>> ---
>>   hw/arm/smmu-common.c         | 45 ++++++++++++++++++++++++++++++++++--
>>   hw/arm/smmuv3.c              | 13 +++++++----
>>   include/hw/arm/smmu-common.h |  7 ++++++
>>   3 files changed, 58 insertions(+), 7 deletions(-)


