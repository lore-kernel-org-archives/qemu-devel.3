Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDFCACAC59F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 02:05:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uz41c-0003Ca-TV; Wed, 17 Sep 2025 22:05:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1uz41b-0003CA-Ag; Wed, 17 Sep 2025 22:05:31 -0400
Received: from [115.124.30.124] (helo=out30-124.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1uz41X-0004Rk-C7; Wed, 17 Sep 2025 22:05:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1758161118; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=9kfgXtxNOvskYElUqhZx5h6amZ5gbVi3Xi/+VO0CsZM=;
 b=IRUiiv1zmIqv33vuB4YJZ7dTVa9oOYHUaS+0n62q9BIPGhPKe13g+ZpfslaIj7KUOvPyhsd3rDndyxIJEVdDsIscO0hzV3sTOugQb4KouqwUjvID4BeikTPv6nXwkKIvScwW36Cn42611Ajv7Akt1N16Luo65C4WzWEaNAG2BdE=
Received: from 30.166.64.213(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WoE2LlU_1758161117 cluster:ay36) by smtp.aliyun-inc.com;
 Thu, 18 Sep 2025 10:05:18 +0800
Message-ID: <a891478d-0fc4-428f-b0ca-ae48fe133821@linux.alibaba.com>
Date: Thu, 18 Sep 2025 10:05:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 5/5] target/riscv: Enable SMMPT extension
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, Huang Tao <eric.huang@linux.alibaba.com>,
 TANG Tiancheng <lyndra@linux.alibaba.com>
References: <20250909132533.32205-1-zhiwei_liu@linux.alibaba.com>
 <20250909132533.32205-6-zhiwei_liu@linux.alibaba.com>
 <c8c84363-2430-4e07-9bb0-b5e7ea2c51cf@ventanamicro.com>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <c8c84363-2430-4e07-9bb0-b5e7ea2c51cf@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.124 (deferred)
Received-SPF: pass client-ip=115.124.30.124;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-124.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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


On 9/17/25 7:41 PM, Daniel Henrique Barboza wrote:
>
>
> On 9/9/25 10:25 AM, LIU Zhiwei wrote:
>> Co-authored-by: Huang Tao <eric.huang@linux.alibaba.com>
>> Co-authored-by: TANG Tiancheng <lyndra@linux.alibaba.com>
>> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
>> ---
>>   target/riscv/cpu.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>> index d055ddf462..eea0942cf5 100644
>> --- a/target/riscv/cpu.c
>> +++ b/target/riscv/cpu.c
>> @@ -204,7 +204,9 @@ const RISCVIsaExtData isa_edata_arr[] = {
>>       ISA_EXT_DATA_ENTRY(smdbltrp, PRIV_VERSION_1_13_0, ext_smdbltrp),
>>       ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
>>       ISA_EXT_DATA_ENTRY(smrnmi, PRIV_VERSION_1_12_0, ext_smrnmi),
>> +    ISA_EXT_DATA_ENTRY(smsdid, PRIV_VERSION_1_13_0, ext_smsdid),
>>       ISA_EXT_DATA_ENTRY(smmpm, PRIV_VERSION_1_13_0, ext_smmpm),
>> +    ISA_EXT_DATA_ENTRY(smmpt, PRIV_VERSION_1_13_0, ext_smmpt),
>
> smmpt should be before smsdid. 
OK. I miss it.  I will also make it a experiment extension.

Thanks,

Zhiwei

> The ordering of Z extensions has that weird priority
> ordering, but S extensions should be ordered alphabetically.
>
> Yes, there are some extensions that are already out of order (smmpm, 
> smnpm ...). We'll
> have to patch them back to order in a separated patch, but for now 
> let's not add to the
> problem hehe
>
>
> Thanks,
>
> Daniel
>
>>       ISA_EXT_DATA_ENTRY(smnpm, PRIV_VERSION_1_13_0, ext_smnpm),
>>       ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
>>       ISA_EXT_DATA_ENTRY(ssaia, PRIV_VERSION_1_12_0, ext_ssaia),
>> @@ -1279,6 +1281,8 @@ const RISCVCPUMultiExtConfig 
>> riscv_cpu_extensions[] = {
>>       MULTI_EXT_CFG_BOOL("smmpm", ext_smmpm, false),
>>       MULTI_EXT_CFG_BOOL("smnpm", ext_smnpm, false),
>>       MULTI_EXT_CFG_BOOL("smstateen", ext_smstateen, false),
>> +    MULTI_EXT_CFG_BOOL("smsdid", ext_smsdid, false),
>> +    MULTI_EXT_CFG_BOOL("smmpt", ext_smmpt, false),
>>       MULTI_EXT_CFG_BOOL("ssaia", ext_ssaia, false),
>>       MULTI_EXT_CFG_BOOL("ssdbltrp", ext_ssdbltrp, false),
>>       MULTI_EXT_CFG_BOOL("svade", ext_svade, false),
>

