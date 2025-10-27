Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BB31CCF9EB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 15:28:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDP7c-0006FJ-LX; Mon, 27 Oct 2025 11:27:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vDP7Z-0006Eo-FH; Mon, 27 Oct 2025 11:26:57 -0400
Received: from sgoci-sdnproxy-4.icoremail.net ([129.150.39.64])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vDP7O-0006h7-3a; Mon, 27 Oct 2025 11:26:57 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwAH6CQmj_9oTF12AA--.3142S2;
 Mon, 27 Oct 2025 23:26:30 +0800 (CST)
Received: from [192.168.31.222] (unknown [113.246.234.35])
 by mail (Coremail) with SMTP id AQAAfwBHqeYkj_9oYFdxAA--.51062S2;
 Mon, 27 Oct 2025 23:26:28 +0800 (CST)
Message-ID: <ce64f4a2-75a0-442c-a26f-7391a378e8d0@phytium.com.cn>
Date: Mon, 27 Oct 2025 23:26:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 2/2] tests/qtest: add SMMUv3 smoke test using
 smmu-testdev DMA source
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
References: <20250930165340.42788-1-tangtao1634@phytium.com.cn>
 <20250930165340.42788-3-tangtao1634@phytium.com.cn>
 <87jz0lnan1.fsf@draig.linaro.org>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <87jz0lnan1.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwBHqeYkj_9oYFdxAA--.51062S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAQBWj+ghAHuwAFsp
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW3WFykKry3uw45KFW7JF43KFg_yoW7tw45pF
 Z3KasrAF4UJr1UCr13Jw48uFykJrZ5AF17Gry5JryxZr4qvr1ktF42gFWFqF97Ar97WF18
 Zr4jqFnrur15XFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=129.150.39.64;
 envelope-from=tangtao1634@phytium.com.cn; helo=sgoci-sdnproxy-4.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hi Alex,

On 2025/10/23 19:02, Alex Bennée wrote:
> tangtao1634 <tangtao1634@phytium.com.cn> writes:
>
>> From: Tao Tang <tangtao1634@phytium.com.cn>
>>
>> Introduce a bare-metal qtest that drives the new smmu-testdev to exercise
>> the SMMUv3 emulation without guest firmware or drivers. The test programs
>> a minimal Non-Secure context (STE/CD/PTE), triggers a DMA, and asserts
>> translation results.
>>
>> Motivation
>> ----------
>> SMMU testing in emulation often requires a large software stack and a
>> realistic PCIe fabric, which adds flakiness and obscures failures. This
>> qtest keeps the surface small and deterministic by using a hermetic DMA
>> source that feeds the SMMU directly.
>>
>> What the test covers
>> --------------------
>> * Builds a Non-Secure STE/CD/PTE for a chosen stream_id/ssid.
>> * Primes source and destination host buffers.
>> * Kicks a DMA via smmu-testdev and waits for completion.
>> * Verifies translated access and payload equality.
>>
>> Non-goals and scope limits
>> --------------------------
>> * Secure bank flows are omitted because Secure SMMU support is still RFC.
>>    A local Secure test exists and can be posted once the upstream series
>>    lands.
>> * PCIe discovery, MSI/INTx, ATS/PRI, and driver bring-up are out of scope
>>    as smmu-testdev is not a realistic PCIe Endpoint nor a platform device.
>>
>> Rationale for a dedicated path
>> ------------------------------
>> Using a generic PCI or virtio device would still require driver init and a
>> richer bus model, undermining determinism for this focused purpose. This
>> qtest, paired with smmu-testdev, keeps failures attributable to the SMMU
>> translation path.
>>
>> Finally we document the smmu-testdev device in docs/specs.
>>
>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>> ---
>> ------------------------------<snip>------------------------------
>>
>>
>>
>> ------------------------------<snip>------------------------------
>> +
>> +    /* Find device by vendor/device ID to avoid slot surprises. */
>> +    dev = NULL;
> might as well init when you declare.
>
>> +    g_assert_nonnull(dev);
> surely g_assert(dev) would do.
>
>> +    const uint32_t modes[] = { 0u, 1u, 2u }; /* Stage1, Stage2, Nested stage */
>> +    const SMMUTestDevSpace spaces[] = { STD_SPACE_NONSECURE };
> top of block.


Thank you very much for your valuable feedback. Also I will refactor 
these codes with the guide of summarized plans as described in patch #1.

>
>> +    /* Use attrs-DMA path for end-to-end */
>> +    qpci_io_writel(dev, bar, STD_REG_DMA_MODE, 1);
>> +    for (size_t mi = 0; mi < sizeof(modes) / sizeof(modes[0]); mi++) {
>> +        const SMMUTestDevSpace *s1_set = NULL;
>> +        size_t s1_count = 0;
>> +        const SMMUTestDevSpace *s2_set = NULL;
>> +        size_t s2_count = 0;
>> +
>> +        switch (modes[mi]) {
>> +        case 0u:
>> +        case 1u:
>> +        case 2u:
>> +            s1_set = spaces;
>> +            s1_count = sizeof(spaces) / sizeof(spaces[0]);
>> +            s2_set = spaces;
>> +            s2_count = sizeof(spaces) / sizeof(spaces[0]);
>> +            break;
>> +        default:
>> +            g_assert_not_reached();
>> +        }
>> +
>> +        for (size_t si = 0; si < s1_count; si++) {
>> +            for (size_t sj = 0; sj < s2_count; sj++) {
>> +                qpci_io_writel(dev, bar, STD_REG_TRANS_MODE, modes[mi]);
>> +                qpci_io_writel(dev, bar, STD_REG_S1_SPACE, s1_set[si]);
>> +                qpci_io_writel(dev, bar, STD_REG_S2_SPACE, s2_set[sj]);
>> +                qpci_io_writel(dev, bar, STD_REG_TRANS_DBELL, 0x2);
>> +                qpci_io_writel(dev, bar, STD_REG_TRANS_DBELL, 0x1);
>> +
>> +                uint32_t st = qpci_io_readl(dev, bar,
>> +                                            STD_REG_TRANS_STATUS);
>> +                g_test_message("build: stage=%s s1=%s s2=%s status=0x%x",
>> +                                std_mode_to_str(modes[mi]),
>> +                                std_space_to_str(s1_set[si]),
>> +                                std_space_to_str(s2_set[sj]), st);
>> +                /* Program SMMU registers in selected control bank. */
>> +                smmu_prog_minimal(qts, s1_set[si]);
>> +
>> +                /* End-to-end DMA using tx_space per mode. */
>> +                SMMUTestDevSpace tx_space =
>> +                    (modes[mi] == 0u) ? s1_set[si] : s2_set[sj];
>> +                uint32_t dma_attrs = ((uint32_t)tx_space << 1);
>> +                qpci_io_writel(dev, bar, STD_REG_DMA_ATTRS,
>> +                                dma_attrs);
>> +                qpci_io_writel(dev, bar, STD_REG_DMA_DBELL, 1);
>> +                /* Wait for DMA completion and assert success. */
>> +                {
>> +                    uint32_t dr = poll_dma_result(dev, bar, qts);
>> +                    uint32_t exp = expected_dma_result(modes[mi],
>> +                                                        spaces[si],
>> +                                                        spaces[sj]);
>> +                    g_assert_cmpuint(dr, ==, exp);
>> +                    g_test_message("polling end. attrs=0x%x res=0x%x",
>> +                                   dma_attrs, dr);
>> +                }
>> +                /* Clear CD/STE/PTE built by the device for next round. */
>> +                qpci_io_writel(dev, bar, STD_REG_TRANS_CLEAR, 1);
>> +                g_test_message("clear cache end.");
>> +            }
>> +        }
>> +    }
> I suspect this function could be broken up a bit as new tests are added
> and functionality shared?


Sure. I've actually been thinking along the same lines. As I plan for 
future tests, I'm considering how best to organize the test cases given 
the numerous combinations of features we'll need to cover. For example, 
beyond iterating through security states and translation stages, we will 
also need to test many other parameters, such as:

- Linear vs. two-level Stream Tables

- Different Output Address Sizes (Although only support 44bits in 
current SMMU implementation)

My question to you and the wider group is, how far should we go in 
covering these combinations for an initial smoke test? The current loops 
for security state and translation stage cover the basics, but I'm 
wondering if we should aim for more complexity at this stage, or if 
that's a task for future patches. I'd be very interested to hear 
everyone's opinion on the right scope.

In any case, your suggestion to break the current test logic into 
smaller, shared functions is definitely the right first step to manage 
the structure. I will refactor the code accordingly in the next version.

Thanks again for the valuable suggestion!

Best regards,

Tao


