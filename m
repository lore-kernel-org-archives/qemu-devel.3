Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F917D41D74
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 03:23:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vUz9n-00079J-0c; Sun, 14 Dec 2025 22:21:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vUz9k-00078d-Sh; Sun, 14 Dec 2025 22:21:52 -0500
Received: from sgoci-sdnproxy-4.icoremail.net ([129.150.39.64])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vUz9h-0003hr-Ks; Sun, 14 Dec 2025 22:21:52 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwCnrCS_fj9p+lR_AQ--.16447S2;
 Mon, 15 Dec 2025 11:21:35 +0800 (CST)
Received: from [10.31.62.13] (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwD3T+22fj9pTwgMAA--.22979S2;
 Mon, 15 Dec 2025 11:21:27 +0800 (CST)
Message-ID: <84882a17-0ba1-4503-9c92-d8fa4ab48caa@phytium.com.cn>
Date: Mon, 15 Dec 2025 11:21:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v6 2/4] hw/misc: Introduce iommu-testdev for bare-metal
 IOMMU testing
To: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
References: <20251206155203.3015881-1-tangtao1634@phytium.com.cn>
 <20251206155203.3015881-3-tangtao1634@phytium.com.cn>
 <87y0n7ra1m.fsf@suse.de>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <87y0n7ra1m.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwD3T+22fj9pTwgMAA--.22979S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAFBWk-GiAB6wAAsH
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxZFy5Xr4UZr43uF4rGr43GFg_yoW5WF15pa
 sxGa43tF18Ar47CF4Sqw1rJa4agF1ktF17Kr17tr1FqryjyFy8trWUK348K397JrZ5ZF17
 Zr4DKw15Gw4ayrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
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

Hi Fabiano,

On 2025/12/12 23:31, Fabiano Rosas wrote:
> Tao Tang <tangtao1634@phytium.com.cn> writes:
>
>> Add a minimal PCI test device designed to exercise IOMMU translation
>> (such as ARM SMMUv3) without requiring guest firmware or OS. The device
>> provides MMIO registers to configure and trigger DMA operations with
>> controllable attributes (security state, address space), enabling
>> deterministic IOMMU testing.
>>
>> Key features:
>> - Bare-metal IOMMU testing via simple MMIO interface
>> - Configurable DMA attributes for security states and address spaces
>> - Write-then-read verification pattern with automatic result checking
>>
>> The device performs a deterministic DMA test pattern: write a known
>> value (0x88888888) to a configured IOVA, read it back, and verify data
>> integrity. Results are reported through a dedicated result register,
>> eliminating the need for complex interrupt handling or driver
>> infrastructure in tests.
>>
>> This is purely a test device and not intended for production use or
>> machine realism. It complements existing test infrastructure like
>> pci-testdev but focuses specifically on IOMMU translation path
>> validation.
>>
>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>   docs/specs/index.rst            |   1 +
>>   docs/specs/iommu-testdev.rst    | 109 +++++++++++++
>>   hw/misc/Kconfig                 |   5 +
>>   hw/misc/iommu-testdev.c         | 278 ++++++++++++++++++++++++++++++++
>>   hw/misc/meson.build             |   1 +
>>   hw/misc/trace-events            |  10 ++
>>   include/hw/misc/iommu-testdev.h |  70 ++++++++
>>   7 files changed, 474 insertions(+)
>>   create mode 100644 docs/specs/iommu-testdev.rst
>>   create mode 100644 hw/misc/iommu-testdev.c
>>   create mode 100644 include/hw/misc/iommu-testdev.h
>> ------------------------------<snip>------------------------------
>>
>>
>>
>> ------------------------------<snip>------------------------------
>> +
>> +/* DMA result/status values shared with tests */
>> +#define ITD_DMA_RESULT_IDLE   0xffffffffu
>> +#define ITD_DMA_RESULT_BUSY   0xfffffffeu
>> +#define ITD_DMA_ERR_BAD_LEN   0xdead0001u
>> +#define ITD_DMA_ERR_TX_FAIL   0xdead0002u
>> +#define ITD_DMA_ERR_RD_FAIL   0xdead0003u
>> +#define ITD_DMA_ERR_MISMATCH  0xdead0004u
>> +#define ITD_DMA_ERR_NOT_ARMED 0xdead0005u
>> +
>> +#define ITD_DMA_WRITE_VAL     0x88888888u
> Is this intended to read the same regardless of endianness? It would
> mask possible endianness bugs.

Thanks for catching this.

It was something I typed quickly, and I did overlook endianness at the 
time. I’ll change it to 0x12345678 in the next revision.


Best regard,

Tao


>
> For the rest of the patch:
>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>


