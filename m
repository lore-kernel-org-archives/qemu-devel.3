Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BEDCCCF9E5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 14:57:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDOdJ-0003Pd-6J; Mon, 27 Oct 2025 10:55:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vDOd5-0003Nw-CU; Mon, 27 Oct 2025 10:55:29 -0400
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net ([209.97.181.73])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vDOcw-0001c3-4N; Mon, 27 Oct 2025 10:55:26 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwCnrCTEh_9oqFF2AA--.40890S2;
 Mon, 27 Oct 2025 22:55:00 +0800 (CST)
Received: from [192.168.31.222] (unknown [113.246.234.35])
 by mail (Coremail) with SMTP id AQAAfwB32OXDh_9ok0NxAA--.52332S2;
 Mon, 27 Oct 2025 22:54:59 +0800 (CST)
Message-ID: <1f585a54-99c8-44c2-9e9b-ca80f7f747aa@phytium.com.cn>
Date: Mon, 27 Oct 2025 22:54:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 1/2] hw/misc/smmu-testdev: introduce minimal SMMUv3 test
 device
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
 <20250930165340.42788-2-tangtao1634@phytium.com.cn>
 <87pladnc35.fsf@draig.linaro.org>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <87pladnc35.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwB32OXDh_9ok0NxAA--.52332S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAQBWj+ghAHuwAEso
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW3Ar4UXrW3Kw13Cry5uw1UGFg_yoWxZr1DpF
 n3XF43tF4UAF43CryIvw4jgryfXan5A3W2kryfCr93Z34vyr1vyryUK348ur95A3y8uF1x
 Ar4jqryDGw1YvFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=209.97.181.73;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmja5ljk3lje4ms43mwaa.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

On 2025/10/23 18:31, Alex Bennée wrote:
> tangtao1634 <tangtao1634@phytium.com.cn> writes:
>
>> From: Tao Tang <tangtao1634@phytium.com.cn>
>>
>> Add a tiny, test-only DMA source dedicated to exercising the SMMUv3 model.
>> The device purposefully avoids a realistic PCIe/platform implementation and
>> instead routes DMA requests straight into the SMMU, so that qtests can
>> populate STE/CD/PTE with known values and observe translation and data
>> movement deterministically, without booting any firmware or guest kernel.
>>
>> Motivation
>> ----------
>> Bringing up and regression-testing the SMMU in emulation often depends on a
>> large and flaky software stack (enumeration, drivers, PCIe fabric). For the
>> class of tests that only need to (1) program translation structures and (2)
>> trigger DMA at a precise time, that stack adds noise, slows CI, and makes
>> failures harder to attribute to the SMMU itself. A hermetic DMA source
>> keeps the surface area small and the results reproducible.
>>
>> What this device is (and is not)
>> --------------------------------
>> * It is a minimal DMA producer solely for SMMU tests.
>> * It is NOT a faithful PCIe Endpoint nor a platform device.
>> * It is NOT added to any machine by default and remains test-only.
>>
>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>> ---
>>   hw/misc/Kconfig                |   5 +
>>   hw/misc/meson.build            |   1 +
>>   hw/misc/smmu-testdev.c         | 943 +++++++++++++++++++++++++++++++++
>>   include/hw/misc/smmu-testdev.h | 402 ++++++++++++++
>>   4 files changed, 1351 insertions(+)
>>   create mode 100644 hw/misc/smmu-testdev.c
>>   create mode 100644 include/hw/misc/smmu-testdev.h
>>
>> ------------------------------<snip>------------------------------
>>
>>
>>
>> ------------------------------<snip>------------------------------
>> +/* ---- Debug helpers for printing current translation configuration ---- */
>> +static void G_GNUC_PRINTF(2, 3)
>> +smmu_testdev_debug(const SMMUTestDevState *s, const char *fmt, ...)
>> +{
>> +    va_list ap;
>> +    g_autofree char *msg = NULL;
>> +
>> +    if (!s->debug_log) {
>> +        return;
>> +    }
>> +
>> +    va_start(ap, fmt);
>> +    msg = g_strdup_vprintf(fmt, ap);
>> +    va_end(ap);
>> +
>> +    if (qemu_log_enabled()) {
>> +        qemu_log("%s", msg);
>> +    } else {
>> +        fprintf(stderr, "%s", msg);
>> +    }
>> +}
> Why are we re-inventing logging here? Either use qemu_log or probably
> better define tracepoints.
>
>> +
>> +static MemTxAttrs mk_attrs_from_space(SMMUTestDevSpace space)
>> +{
>> +    MemTxAttrs a = {0};
>> +    if (!smmu_testdev_space_supported(space)) {
>> +        g_assert_not_reached();
> Isn't this the same as just saying:
>
>    g_assert(smmu_testdev_space_supported(space));
>
> ?
>
>> +static void smmu_testdev_build_translation(SMMUTestDevState *s)
>> +{
>> +    smmu_testdev_debug(s, "smmu_testdev_build_translation: stage=%s s1_space=%s"
>> +                       " s2_space=%s\n", std_mode_to_str(s->trans_mode),
>> +                       std_space_to_str(s->s1_space),
>> +                       std_space_to_str(s->s2_space));
> tracepoint
>
>> +        if (st != 0) {
>> +            printf("Writing STE error! status: %x\n", st);
>
>    qemu_log_mask(LOG_GUEST_ERROR, ...
>
>> +    AddressSpace *as = space_to_as(bank_sp);
>> +    if (!as) {
>> +        printf("push_cfgi_cmd: space %d not supported\n", bank_sp);
> qemu_log_mask(LOG_UNIMP?
>
>> +        return;
>> +    }
>> +    int ret = address_space_write(as, entry_pa, a,
>> +                                  words, sizeof(words));
>> +    smmu_testdev_debug(s, "push_cfgi_cmd ret %d\n", ret);
> tracepoint
>
>> +
>> +    /* update PROD to trigger command handler */
>> +    uint32_t new_prod = (prod + 1) & ((1u << (log2size + 1)) - 1u);
>> +    address_space_stl_le(&address_space_memory,
>> +                         s->smmu_base + bank_off + 0x98,
>> +                         new_prod, MEMTXATTRS_UNSPECIFIED, &res);
>> +    smmu_testdev_debug(s, "last res %d\n", res);
> tracepoint but really see if it can be merged with above.
>
>> +    smmu_testdev_debug(s, "smmu_testdev_maybe_run_dma: dma_pending: %d\n",
>> +                       s->dma_pending);
> tracepoint
>
>> +
>> +    s->dma_pending = false;
>> +
>> +    if (!s->dma_len || s->dma_len > DMA_MAX_LEN) {
>> +        s->dma_result = DMA_ERR_BAD_LEN;
>> +        return;
>> +    }
>> +
>> +    g_autofree uint8_t *buf = g_malloc(s->dma_len);
>> +    MemTxResult res;
> Keep local vars at the top of the block.
>
>> +static const Property smmu_testdev_properties[] = {
>> +    DEFINE_PROP_UINT32("device", SMMUTestDevState, cfg_dev, 0),
>> +    DEFINE_PROP_UINT32("function", SMMUTestDevState, cfg_fn, 1),
>> +    DEFINE_PROP_BOOL("debug-log", SMMUTestDevState, debug_log,
>> false),
> We have tracepoints so we don't need this flag.
>
>> +/* BAR0 registers (offsets) */
>> +enum {
>> +    STD_REG_ID           = 0x00,
>> +    STD_REG_ATTR_NS      = 0x04,
>> +    STD_REG_SMMU_BASE_LO = 0x20,
>> +    STD_REG_SMMU_BASE_HI = 0x24,
>> +    STD_REG_DMA_IOVA_LO  = 0x28,
>> +    STD_REG_DMA_IOVA_HI  = 0x2C,
>> +    STD_REG_DMA_LEN      = 0x30,
>> +    STD_REG_DMA_DIR      = 0x34,
>> +    STD_REG_DMA_RESULT   = 0x38,
>> +    STD_REG_DMA_DBELL    = 0x3C,
>> +    /* Extended controls for DMA attributes/mode */
>> +    STD_REG_DMA_MODE     = 0x40,
>> +    STD_REG_DMA_ATTRS    = 0x44,
>> +    /* Translation controls */
>> +    STD_REG_TRANS_MODE   = 0x48,
>> +    STD_REG_S1_SPACE     = 0x4C,
>> +    STD_REG_S2_SPACE     = 0x50,
>> +    STD_REG_TRANS_DBELL  = 0x54,
>> +    STD_REG_TRANS_STATUS = 0x58,
>> +    /* Clear helper-built tables/descriptors (write-any to trigger) */
>> +    STD_REG_TRANS_CLEAR  = 0x5C,
>> +};
> Aren't we just duplicating the anonymous enum in smmu-testdev.c here? I
> think qtest is allowed to include qemu headers so lets just have a
> common set please.


Thank you very much for the thorough and highly constructive review of 
this patch. I've gone through all your comments, and I agree with points 
you've raised.


I will incorporate all your feedback into the next version of the 
series. To be clear, even as the broader discussion about potentially 
refactoring smmu-testdev into a more generic iommu-testdev continues, 
your review points on code quality are fundamental. I will ensure they 
are implemented regardless of which final architecture we decide upon.


To summarize the planned changes:

- Logging mechanism: I will replace the custom smmu_testdev_debug 
function and other printf calls with the standard tracepoint mechanism. 
Consequently, the debug-log device property will be removed as it will 
no longer be necessary.

- Removing duplicated codes: Move the duplicated enum into 
smmu-testdev.h which will then be included by both the device 
implementation and the qtest file.

- Code style and simplification: Simplify the g_assert checks and 
ensuring local variables are declared at the top of their respective blocks.


Thanks again for taking the time to provide such valuable and detailed 
feedback.


Best regards,

Tao



