Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BDD7F0182F
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 13:31:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyVGO-00039Z-DI; Fri, 06 Mar 2026 08:30:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vyVGJ-00037s-Q4; Fri, 06 Mar 2026 08:30:39 -0500
Received: from sgoci-sdnproxy-4.icoremail.net ([129.150.39.64])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vyVGG-0004Q6-I5; Fri, 06 Mar 2026 08:30:39 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwDnPNDw1qppOcS0AA--.38013S2;
 Fri, 06 Mar 2026 21:30:24 +0800 (CST)
Received: from [192.168.31.155] (unknown [113.246.232.19])
 by mail (Coremail) with SMTP id AQAAfwCH3erg1qppyYQfAA--.39450S2;
 Fri, 06 Mar 2026 21:30:16 +0800 (CST)
Message-ID: <1b6a1849-6cec-4c09-aad4-3e5f33ec768e@phytium.com.cn>
Date: Fri, 6 Mar 2026 21:30:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Tao Tang <tangtao1634@phytium.com.cn>
Subject: Re: [RFC v4 28/31] hw/arm/smmuv3: Select sec-sid from PCI property
 and validate SECURE_IMPL
To: eric.auger@redhat.com, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mostafa Saleh <smostafa@google.com>, Chao Liu <chao.liu.zevorn@gmail.com>
References: <20260221100250.2976287-1-tangtao1634@phytium.com.cn>
 <20260221101907.2997408-1-tangtao1634@phytium.com.cn>
 <ac35d3e8-c1a6-4f2b-9a96-88f802299bae@redhat.com>
In-Reply-To: <ac35d3e8-c1a6-4f2b-9a96-88f802299bae@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwCH3erg1qppyYQfAA--.39450S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAGBWmp8qEJhgAAse
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxWFyfKryxJFWrAFy5CF48JFb_yoW5tw4rpF
 W8C3Z5Kr4DKFyxtan7Jw4UCa4SvayxJa15Xr98GrnxAF45W34SvFWI9ryF9r9rAr48ua4j
 qayjyrWkuw4DArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=129.150.39.64;
 envelope-from=tangtao1634@phytium.com.cn; helo=sgoci-sdnproxy-4.icoremail.net
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2026/3/3 18:47, Eric Auger wrote:
> On 2/21/26 11:19 AM, Tao Tang wrote:
>> Parse each PCI device's sec-sid property during SMMU device initialization
>> and cache it in SMMUDevice::sec_sid. Support "non-secure" and "secure",
>> default to non-secure when unspecified, and reject invalid values with an
>> explicit error. Use sdev->sec_sid in smmuv3_translate() to select the
>> register bank instead of hardcoding the non-secure context.
>>
>> Keep sec-sid parsing in smmu-common, and add a SMMUv3-specific validation
>> hook to enforce architectural constraints: fail fast when sec-sid=secure
>> while SMMU_S_IDR1.SECURE_IMPL is 0 or secure AS is not available.
>>
>> Typically, SEC_SID is a system-defined attribute (e.g. sideband or tied-off)
>> rather than something a PCIe endpoint can freely toggle in pre-RME scenario.
>> So this PCI sec-sid property is used as a static platform/testing knob to
>> drive the SMMU bank selection.
>>
>> For future RME-DA + TDISP, this will need to become dynamic: the effective
>> state for PCIe requests is derived from PCIe IDE/TDISP T/XT
>> (e.g. SEC_SID = (XT || T) ? Realm : Non-secure), so we'll switch from a
>> static property to a runtime per-device state update when that plumbing
>> is added.
> When a translation is triggered, address_space_translate_iommu passes attrs.
> MemTxAttrs.secure bit should tell you whether the translation is
> requested in secure mode.
> Shouldn't we pass that information the smmuv3 translate function()?
>
> In address_space_translate_iommu I see:
> if (imrc->attrs_to_index) {
>     iommu_idx = imrc->attrs_to_index(iommu_mr, attrs);
> }
>
> iotlb = imrc->translate(iommu_mr, addr, is_write ?
>                            IOMMU_WO : IOMMU_RO, iommu_idx);


Thanks for pointing this out.

I agree that per-transaction request intent should eventually come from 
MemTxAttrs or attrs_to_index().

However, the current producer side is not yet in a state where 
transaction attrs alone can replace stream-level security wiring: many 
PCI DMA paths still use MEMTXATTRS_UNSPECIFIED, and space cannot be 
consumed safely without an explicit validity signal. For example, an 
incorrect zero-initialized or otherwise unspecified .space value cannot 
be treated as authoritative by itself as Pierrick mentioned in this thread:

https://lore.kernel.org/qemu-devel/dbc4d33e-3477-4f39-a745-4fdc0866fc08@linaro.org/

In the current codebase, this can easily blur the distinction between 
“explicitly Secure” and “not specified at all”, especially for legacy or 
non-Arm-aware producers. So I think there are really two separate 
concerns here:

1. the per-transaction intent (which should indeed come from MemTxAttrs 
/ attrs_to_index()); and
2. the stream-level capability / wiring, i.e. whether this SID is 
allowed to reach the Secure programming interface in the first place.

My concern with the current patch is not that attrs-based routing is the 
wrong long-term direction, but that today transaction attrs are not yet 
propagated consistently enough to replace a stream-level model entirely.

So for now, I think a static sec-sid property is still useful as a 
platform knob, until producer-side propagation becomes reliable enough. 
Once that is in place, I agree that the bank selection should ultimately 
be driven through the standard per-transaction attrs path. How do you 
think about it?


Best regards,

Tao


