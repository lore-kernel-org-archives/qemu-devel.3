Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BA45F33A78
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 14:43:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy9uY-0003al-Ah; Thu, 05 Mar 2026 09:42:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vy9uS-0003aI-74; Thu, 05 Mar 2026 09:42:41 -0500
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vy9uO-0004TY-Od; Thu, 05 Mar 2026 09:42:39 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwBHTZlZlqlpI53KBw--.767S2;
 Thu, 05 Mar 2026 22:42:33 +0800 (CST)
Received: from [192.168.31.155] (unknown [113.246.233.224])
 by mail (Coremail) with SMTP id AQAAfwAHYO1XlqlpkkAfAA--.53924S2;
 Thu, 05 Mar 2026 22:42:32 +0800 (CST)
Message-ID: <8b300682-9fb1-4f2d-a910-86d116e3af2d@phytium.com.cn>
Date: Thu, 5 Mar 2026 22:42:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 17/31] hw/arm/smmuv3: Pass sec_sid into cmdq consume path
To: eric.auger@redhat.com, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mostafa Saleh <smostafa@google.com>, Chao Liu <chao.liu.zevorn@gmail.com>
References: <20260221100250.2976287-1-tangtao1634@phytium.com.cn>
 <20260221101714.2994490-1-tangtao1634@phytium.com.cn>
 <d2eb3ef9-01f3-48cb-80c5-9e49174ab992@redhat.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <d2eb3ef9-01f3-48cb-80c5-9e49174ab992@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAfwAHYO1XlqlpkkAfAA--.53924S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAFBWmooSAF7AADsr
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxtFW3uF15KF45CFy5ArykAFb_yoW7XryxpF
 ZxG3ZxWr18tF1fZFyav3y8uF13Jw1kKr1Utr4UW3WfAw1vyr1DXrWDKw1ru3srur9rAw4f
 ZayFgan3uF12y3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622, SPF_HELO_NONE=0.001,
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

On 2026/3/3 18:14, Eric Auger wrote:
>
> On 2/21/26 11:17 AM, Tao Tang wrote:
>> Make smmuv3_cmdq_consume() security-state aware by passing sec_sid
>> from smmu_writel() call sites (CR0/GERRORN/CMDQ_PROD paths), instead
>> of hardcoding non-secure state. The related AddressSpace and MemTxAttrs
>> are also obtained based on sec_sid.
>>
>> Also move CMD_SSEC legality checking to a single early check before
>> command dispatch: secure commands are rejected on non-secure queues
>> (including future Realm queue) with CERROR_ILL. This removes duplicated
>> per-command checks in CFGI handlers.
>>
>> Finally, extend cmdq trace output with sec_sid so command processing
>> can be correlated with the correct security bank.
>>
>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>> ---
>>   hw/arm/smmuv3.c     | 50 ++++++++++++++++++++++-----------------------
>>   hw/arm/trace-events |  2 +-
>>   2 files changed, 26 insertions(+), 26 deletions(-)
>>
>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>> index e33a7babd1c..b2559e80f24 100644
>> --- a/hw/arm/smmuv3.c
>> +++ b/hw/arm/smmuv3.c
>> @@ -111,14 +111,14 @@ static void smmuv3_write_gerrorn(SMMUv3State *s, uint32_t new_gerrorn)
>>       trace_smmuv3_write_gerrorn(toggled & pending, bank->gerrorn);
>>   }
>>   
>> -static inline MemTxResult queue_read(SMMUQueue *q, Cmd *cmd)
>> +static inline MemTxResult queue_read(SMMUQueue *q, Cmd *cmd,
>> +                                     AddressSpace *as, MemTxAttrs attrs)
>>   {
>>       dma_addr_t addr = Q_CONS_ENTRY(q);
>>       MemTxResult ret;
>>       int i;
>>   
>> -    ret = dma_memory_read(&address_space_memory, addr, cmd, sizeof(Cmd),
>> -                          MEMTXATTRS_UNSPECIFIED);
>> +    ret = dma_memory_read(as, addr, cmd, sizeof(Cmd), attrs);
>>       if (ret != MEMTX_OK) {
>>           return ret;
>>       }
>> @@ -1346,14 +1346,17 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage,
>>       }
>>   }
>>   
>> -static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
>> +static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp, SMMUSecSID sec_sid)
>>   {
>>       SMMUState *bs = ARM_SMMU(s);
>>       SMMUCmdError cmd_error = SMMU_CERROR_NONE;
>> -    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
>>       SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
>>       SMMUQueue *q = &bank->cmdq;
>>       SMMUCommandType type = 0;
>> +    MemTxAttrs attrs = smmu_get_txattrs(sec_sid);
>> +    AddressSpace *as = smmu_get_address_space(bs, sec_sid);
>> +    /* Secure AddressSpace must be available, assert if not. */
>> +    g_assert(as);
> pls remove that check


I'll remove all the unnecessary assertions and check it in lower level 
instead.

>>   
>>       if (!smmuv3_cmdq_enabled(s, sec_sid)) {
>>           return 0;
>> @@ -1369,18 +1372,30 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
>>           uint32_t pending = bank->gerror ^ bank->gerrorn;
>>           Cmd cmd;
>>   
>> -        trace_smmuv3_cmdq_consume(Q_PROD(q), Q_CONS(q),
>> +        trace_smmuv3_cmdq_consume(sec_sid, Q_PROD(q), Q_CONS(q),
>>                                     Q_PROD_WRAP(q), Q_CONS_WRAP(q));
>>   
>>           if (FIELD_EX32(pending, GERROR, CMDQ_ERR)) {
>>               break;
>>           }
>>   
>> -        if (queue_read(q, &cmd) != MEMTX_OK) {
>> +        if (queue_read(q, &cmd, as, attrs) != MEMTX_OK) {
>>               cmd_error = SMMU_CERROR_ABT;
>>               break;
>>           }
>>   
>> +        /*
>> +         * Secure Command on Non-secure Command queue, including Realm Command
>> +         * queue, is not allowed. CERROR_ILL will be raised according to
>> +         * (IHI 0070G.b) 4.1.6 Common command fields, Page 168.
>> +         */
>> +        if (CMD_SSEC(&cmd)) {
>> +            if (sec_sid != SMMU_SEC_SID_S) {
> nit combine both checks


OK.

>> +                cmd_error = SMMU_CERROR_ILL;
>> +                break;
>> +            }
>> +        }
>> +
>>           type = CMD_TYPE(&cmd);
>>   
>>           trace_smmuv3_cmdq_opcode(smmu_cmd_string(type));
>> ------------------------------<snip>------------------------------
>>
>>
>>
>> ------------------------------<snip>------------------------------
>> diff --git a/hw/arm/trace-events b/hw/arm/trace-events
>> index 4e360b3c0d3..ca8485c96af 100644
>> --- a/hw/arm/trace-events
>> +++ b/hw/arm/trace-events
>> @@ -35,7 +35,7 @@ smmuv3_trigger_irq(int irq) "irq=%d"
>>   smmuv3_write_gerror(uint32_t toggled, uint32_t gerror) "toggled=0x%x, new GERROR=0x%x"
>>   smmuv3_write_gerrorn(uint32_t acked, uint32_t gerrorn) "acked=0x%x, new GERRORN=0x%x"
>>   smmuv3_unhandled_cmd(uint32_t type) "Unhandled command type=%d"
>> -smmuv3_cmdq_consume(uint32_t prod, uint32_t cons, uint8_t prod_wrap, uint8_t cons_wrap) "prod=%d cons=%d prod.wrap=%d cons.wrap=%d"
>> +smmuv3_cmdq_consume(int sec_sid, uint32_t prod, uint32_t cons, uint8_t prod_wrap, uint8_t cons_wrap) "sec_sid=%d prod=%d cons=%d prod.wrap=%d cons.wrap=%d"
>>   smmuv3_cmdq_opcode(const char *opcode) "<--- %s"
>>   smmuv3_cmdq_consume_out(uint32_t prod, uint32_t cons, uint8_t prod_wrap, uint8_t cons_wrap) "prod:%d, cons:%d, prod_wrap:%d, cons_wrap:%d "
>>   smmuv3_cmdq_consume_error(const char *cmd_name, uint8_t cmd_error) "Error on %s command execution: %d"
> Besides looks good to me
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>
> Eric

Thanks,

Tao


