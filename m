Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DA34C47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 06:15:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rV3s0-0004kg-AI; Wed, 31 Jan 2024 01:14:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1rV3ry-0004kU-Te; Wed, 31 Jan 2024 01:14:46 -0500
Received: from out30-110.freemail.mail.aliyun.com ([115.124.30.110])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1rV3rv-0002lq-4j; Wed, 31 Jan 2024 01:14:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1706681672; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=QM/wah5+N/MxTiDJz0YZVA6C2sV0Mlw54+B4gUHv7+s=;
 b=k/VVaXgiYhjS+Y6wqGvR1A+09l84QlkrYVEwDcijNdjPB9tzSPxGRcSg2f+e8noBhov7BrYvak+3e36qo4qw5K34oDIhY2tEFKTC3+oYDeG2jxo2B3zRQMfq6Z++PdRUMuNYLRwoy4HP9Di+wmtmL6KKN+o2L2uZscxOBtNo7vE=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R151e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046050;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=11; SR=0;
 TI=SMTPD_---0W.iKLlU_1706681670; 
Received: from 30.198.0.179(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0W.iKLlU_1706681670) by smtp.aliyun-inc.com;
 Wed, 31 Jan 2024 14:14:30 +0800
Message-ID: <167bf0fb-468a-410a-b624-e39cd069693b@linux.alibaba.com>
Date: Wed, 31 Jan 2024 14:14:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/riscv: Register vendors CSR
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: Alistair.Francis@wdc.com, palmer@dabbelt.com, bin.meng@windriver.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com, qemu-riscv@nongnu.org,
 christoph.muellner@vrull.eu, bjorn@kernel.org
References: <20240130111159.532-1-zhiwei_liu@linux.alibaba.com>
 <20240130111159.532-2-zhiwei_liu@linux.alibaba.com>
 <74250471-0866-4513-9587-5da41ce0e7b9@linaro.org>
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <74250471-0866-4513-9587-5da41ce0e7b9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.110;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-110.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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


On 2024/1/31 13:06, Richard Henderson wrote:
> On 1/30/24 21:11, LIU Zhiwei wrote:
>> +/* This stub just works for making vendors array not empty */
>> +riscv_csr_operations stub_csr_ops[CSR_TABLE_SIZE];
>> +static inline bool never_p(const RISCVCPUConfig *cfg)
>> +{
>> +    return false;
>> +}
>> +
>> +void riscv_tcg_cpu_register_vendor_csr(RISCVCPU *cpu)
>> +{
>> +    static const struct {
>> +        bool (*guard_func)(const RISCVCPUConfig *);
>> +        riscv_csr_operations *csr_ops;
>> +    } vendors[] = {
>> +        { never_p, stub_csr_ops },
>> +    };
>> +    for (size_t i = 0; i < ARRAY_SIZE(vendors); ++i) {
>
> Presumably you did this to avoid a Werror for "i < 0", since i is 
> unsigned.
Yes. That's the gcc complains.
>
> It would be better to either use "int i"
OK
> , or
>
>   for (size_t i = 0, n = ARRAY_SIZE(vendors); i < n; ++i)
>
> either of which will not Werror.
This works.  I don't know why it works, because n is 0 and never changes.
>
> Especially considering the size of stub_csr_ops.

Do you mean we should remove the stub_csr_ops? I don't know how to 
relate your two solving ways to stub_csr_ops.

Thanks,
Zhiwei

>
> r~
>

