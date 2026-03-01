Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F387BFD006D
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2026 16:25:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwjay-0007iz-3S; Sun, 01 Mar 2026 11:24:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vwjau-0007iL-L0; Sun, 01 Mar 2026 11:24:36 -0500
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net ([209.97.181.73])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vwjar-0002zG-3u; Sun, 01 Mar 2026 11:24:36 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwC3vmIraKRpReamBw--.11708S2;
 Mon, 02 Mar 2026 00:24:11 +0800 (CST)
Received: from [192.168.31.94] (unknown [113.246.118.211])
 by mail (Coremail) with SMTP id AQAAfwBHoO0oaKRp7zEeAA--.52493S2;
 Mon, 02 Mar 2026 00:24:08 +0800 (CST)
Message-ID: <19eb51c6-b794-4ff4-8ff6-37059dc69c25@phytium.com.cn>
Date: Mon, 2 Mar 2026 00:24:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 24/31] hw/arm/smmuv3: Determine register bank from MMIO
 offset
To: Mostafa Saleh <smostafa@google.com>
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Chao Liu <chao.liu.zevorn@gmail.com>
References: <20260221100250.2976287-1-tangtao1634@phytium.com.cn>
 <20260221101830.2996354-1-tangtao1634@phytium.com.cn>
 <aaGxST56MQWlN8fJ@google.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <aaGxST56MQWlN8fJ@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwBHoO0oaKRp7zEeAA--.52493S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAABWmiCd8FiAAJsd
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW3AryfXr4rAF1xKw43uw17ZFb_yoWxtFyxpr
 Z5JF1SgF4DKF4fXF43Xa1UuFyrAws3Kr13Crn8KFyUCayjkwn7JFW8C34S9F1Dury7ZrsY
 yFW5XrW3urs8ArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=209.97.181.73;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmja5ljk3lje4ms43mwaa.icoremail.net
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188, SPF_HELO_NONE=0.001,
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

Hi Mostafa,

On 2026/2/27 PM10:59, Mostafa Saleh wrote:
> On Sat, Feb 21, 2026 at 06:18:29PM +0800, Tao Tang wrote:
>> Modify the main MMIO handlers (smmu_write_mmio, smmu_read_mmio)
>> to determine the security state of the target register based on its
>> memory-mapped offset.
>>
>> By checking if the offset is within the secure register space (>=
>> SMMU_SECURE_REG_START), the handlers can deduce the register's
>> SEC_SID (reg_sec_sid). This SID is then passed down to the register
>> access helper functions (smmu_writel, smmu_readl, etc.).
>>
>> Inside these helpers, the switch statement now operates on a masked,
>> relative offset:
>>
>>      uint32_t reg_offset = offset & 0xfff;
>>      switch (reg_offset) {
>>          ...
>>      }
>>
>> This design leverages a key feature of the SMMU specification: registers
>> with the same function across different 3 security states
>> (Non-secure, Secure, Realm) share the same relative offset. This avoids
>> significant code duplication. The reg_sec_sid passed from the MMIO
>> handler determines which security bank to operate on, while the masked
>> offset identifies the specific register within that bank.
>>
>> It is important to distinguish between the security state of the
>> register itself and the security state of the access. A
>> higher-privilege security state is permitted to access registers
>> belonging to a lower-privilege state, but the reverse is not allowed.
>> This patch lays the groundwork for enforcing such rules.
>>
>> For future compatibility with Realm states, the logic in the
>> else block corresponding to the secure offset check:
>>
>>      if (offset >= SMMU_SECURE_REG_START) {
>>          reg_sec_sid = SMMU_SEC_SID_S;
>>      } else {
>>          /* Future Realm handling */
>>      }
>>
>> will need to be expanded.
>>
>> Signed-off-by: Tao Tang<tangtao1634@phytium.com.cn>
>> ---
>>   hw/arm/smmuv3.c | 57 +++++++++++++++++++++++++++++++++----------------
>>   1 file changed, 39 insertions(+), 18 deletions(-)
>>
>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>> index 9c09ea0716e..d81485a6a46 100644
>> --- a/hw/arm/smmuv3.c
>> +++ b/hw/arm/smmuv3.c
>> @@ -1781,12 +1781,13 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp, SMMUSecSID sec_sid)
>>   }
>>   
>>   static MemTxResult smmu_writell(SMMUv3State *s, hwaddr offset,
>> -                               uint64_t data, MemTxAttrs attrs)
>> +                                uint64_t data, MemTxAttrs attrs,
>> +                                SMMUSecSID reg_sec_sid)
>>   {
>> -    SMMUSecSID reg_sec_sid = SMMU_SEC_SID_NS;
>>       SMMUv3RegBank *bank = smmuv3_bank(s, reg_sec_sid);
>> +    uint32_t reg_offset = offset & 0xfff;
> This breaks all registers above 4k?
> For example, TCU registers/PMU reside on some of this area and if SW
> writes to those this might be aliased to something as CR0, which might
> disable the SMMU and bypass some security checks. (in case it’s managed
> by the hypervisor).
>
> I believe you should check the secure offset explicitly to distinguish secure
> and non-secure.


Thanks for catching this. You’re right! I implicitly assumed that 
anything “above 4KB” in the register aperture could be safely decoded by 
masking to a 4KB-local offset, but that overlooks the fact that real 
SMMU IPs populate the *IMPLEMENTATION DEFINED* windows with meaningful 
blocks. In practice, these implementation-defined ranges appear to start 
around 0x0E00 in the main bank and 0x8E00 in the secure bank (per the 
register overview)?  So collapsing offsets with offset & 0xfff can 
easily alias accesses from those regions onto architected registers.

I’ll rework this part: explicitly decode the MMIO access by **register 
region/window**, and only canonicalize offsets in a way that preserves 
at least the 64KB page granularity.

>>   
>> -    switch (offset) {
>> +    switch (reg_offset) {
>>       case A_GERROR_IRQ_CFG0:
>>           if (!smmu_gerror_irq_cfg_writable(s, reg_sec_sid)) {
>>               /* SMMU_(*_)_IRQ_CTRL.GERROR_IRQEN == 1: IGNORED this write */
>> @@ -1851,13 +1852,14 @@ static MemTxResult smmu_writell(SMMUv3State *s, hwaddr offset,
>>   }
>>   
>>   static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
>> -                               uint64_t data, MemTxAttrs attrs)
>> +                               uint64_t data, MemTxAttrs attrs,
>> +                               SMMUSecSID reg_sec_sid)
>>   {
>>       Error *local_err = NULL;
>> -    SMMUSecSID reg_sec_sid = SMMU_SEC_SID_NS;
>>       SMMUv3RegBank *bank = smmuv3_bank(s, reg_sec_sid);
>> +    uint32_t reg_offset = offset & 0xfff;
>>   
>> -    switch (offset) {
>> +    switch (reg_offset) {
>>       case A_CR0:
>>           bank->cr[0] = data;
>>           bank->cr0ack = data & ~SMMU_CR0_RESERVED;
>> @@ -2094,16 +2096,25 @@ static MemTxResult smmu_write_mmio(void *opaque, hwaddr offset, uint64_t data,
>>       SMMUState *sys = opaque;
>>       SMMUv3State *s = ARM_SMMUV3(sys);
>>       MemTxResult r;
>> +    SMMUSecSID reg_sec_sid = SMMU_SEC_SID_NS;
>>   
>>       /* CONSTRAINED UNPREDICTABLE choice to have page0/1 be exact aliases */
>>       offset &= ~0x10000;
>>   
>> +    /*
>> +     * Realm and Non-secure share the same page-local offset layout; Secure uses
>> +     * the same layout but is mapped starting at 0x8000(SMMU_SECURE_REG_START)
>> +     */
>> +    if (offset >= SMMU_SECURE_REG_START) {
>> +        reg_sec_sid = SMMU_SEC_SID_S;
>> +    }
>> +
>>       switch (size) {
>>       case 8:
>> -        r = smmu_writell(s, offset, data, attrs);
>> +        r = smmu_writell(s, offset, data, attrs, reg_sec_sid);
>>           break;
>>       case 4:
>> -        r = smmu_writel(s, offset, data, attrs);
>> +        r = smmu_writel(s, offset, data, attrs, reg_sec_sid);
>>           break;
>>       default:
>>           r = MEMTX_ERROR;
>> @@ -2115,12 +2126,13 @@ static MemTxResult smmu_write_mmio(void *opaque, hwaddr offset, uint64_t data,
>>   }
>>   
>>   static MemTxResult smmu_readll(SMMUv3State *s, hwaddr offset,
>> -                               uint64_t *data, MemTxAttrs attrs)
>> +                               uint64_t *data, MemTxAttrs attrs,
>> +                               SMMUSecSID reg_sec_sid)
>>   {
>> -    SMMUSecSID reg_sec_sid = SMMU_SEC_SID_NS;
>>       SMMUv3RegBank *bank = smmuv3_bank(s, reg_sec_sid);
>> +    uint32_t reg_offset = offset & 0xfff;
>>   
>> -    switch (offset) {
>> +    switch (reg_offset) {
>>       case A_GERROR_IRQ_CFG0:
>>           /* SMMU_(*_)GERROR_IRQ_CFG0 BOTH check SMMU_IDR0.MSI */
>>           if (!smmu_msi_supported(s)) {
>> @@ -2149,17 +2161,22 @@ static MemTxResult smmu_readll(SMMUv3State *s, hwaddr offset,
>>   }
>>   
>>   static MemTxResult smmu_readl(SMMUv3State *s, hwaddr offset,
>> -                              uint64_t *data, MemTxAttrs attrs)
>> +                              uint64_t *data, MemTxAttrs attrs,
>> +                              SMMUSecSID reg_sec_sid)
>>   {
>> -    SMMUSecSID reg_sec_sid = SMMU_SEC_SID_NS;
>>       SMMUv3RegBank *bank = smmuv3_bank(s, reg_sec_sid);
>> +    uint32_t reg_offset = offset & 0xfff;
>>   
>> -    switch (offset) {
>> +    switch (reg_offset) {
>>       case A_IDREGS ... A_IDREGS + 0x2f:
>> -        *data = smmuv3_idreg(offset - A_IDREGS);
>> +        *data = smmuv3_idreg(reg_offset - A_IDREGS);
>>           return MEMTX_OK;
>>       case A_IDR0 ... A_IDR5:
>> -        *data = bank->idr[(offset - A_IDR0) / 4];
>> +        if (reg_sec_sid == SMMU_SEC_SID_S) {
>> +            g_assert((reg_offset - A_IDR0) / 4 < 5);
> Asserting here is too much as this can be easily triggered by guests,
> we should follow the convention of other unimplemented registers.


I'll fix it in V5.


>
> Thanks,
> Mostafa


Thanks for your time!

Tao


