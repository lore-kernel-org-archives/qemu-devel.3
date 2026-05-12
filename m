Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E72CCD37BE
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 02:36:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMcyX-0005fo-6O; Mon, 11 May 2026 22:36:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1wMcyV-0005fa-NM; Mon, 11 May 2026 22:35:59 -0400
Received: from out30-99.freemail.mail.aliyun.com ([115.124.30.99])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1wMcyT-0005jz-9p; Mon, 11 May 2026 22:35:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1778553350; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=BSaZ5LCSP7KGgGyAqTiB0yXgQsCSRDk2IIFTsVZqB8Q=;
 b=O2mLdyUChr05WubS/CbqLpFRL8avfev5vDn+zqrQFp8mURdbTZ386ICOu9Y1LK0qTiQvmwgorNaZUTFUy4sFYM94RY/joFcfbA0I3g7HUyf+DMPYitNPZMNJIUNofSO8ZX2g6ahgiciy0U5r9mHkQGtY7e6BL9BqXZrnW30P/08=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R291e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037033178;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=10; SR=0;
 TI=SMTPD_---0X2op7Vx_1778553349; 
Received: from 30.166.64.212(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0X2op7Vx_1778553349 cluster:ay36) by smtp.aliyun-inc.com;
 Tue, 12 May 2026 10:35:50 +0800
Message-ID: <e63a3a55-7492-43e5-93c1-1b2fcbb77ec5@linux.alibaba.com>
Date: Tue, 12 May 2026 10:35:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/6] target/riscv: Enable SMMPT extension
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, chao.liu.zevorn@gmail.com, palmer@dabbelt.com,
 alistair23@gmail.com, liwei1518@gmail.com,
 Huang Tao <eric.huang@linux.alibaba.com>,
 TANG Tiancheng <lyndra@linux.alibaba.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
References: <20260408140635.42546-1-zhiwei_liu@linux.alibaba.com>
 <20260408140635.42546-7-zhiwei_liu@linux.alibaba.com>
 <44bde277-c357-4507-9456-7cc8f6dcdbdb@oss.qualcomm.com>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <44bde277-c357-4507-9456-7cc8f6dcdbdb@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.99;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-99.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

Hi Daniel,

On 4/30/26 5:32 PM, Daniel Henrique Barboza wrote:
> Hi Zhiwei,
>
>
> It was brought to my attention that, as per spec 0.49, smmpt is dependent
> on smsdid.  In other words, using our current implicit rules framework,
> enabling smmpt would also enable smsdid.  I checked myself, and on
> doc version 0.49, start of Chapter 4:
>
> https://github.com/riscv/riscv-smmtt/releases/tag/v0.49
>
> "The following MPT extensions are defined:
>
> • Smmpt34 - Page-based 34-bit memory protection system (RV32 only)
> • Smmpt43 - Page-based 43-bit memory protection system (RV64 only)
> • Smmpt52 - Page-based 52-bit memory protection system (RV64 only)
> • Smmpt64 - Page-based 64-bit memory protection system (RV64 only)
>
> These MPT extensions depend on Smsdid. "
>
>
> Given that a v6 is going to happen anyway might as well change this patch
> to add this implicit rule too.

Yes. I have added this implicit rule in v6 patch set.

Thanks,
Zhiwei

>
>
> Cheers,
> Daniel
>
>
> On 4/8/2026 11:06 AM, LIU Zhiwei wrote:
>> Co-authored-by: Huang Tao <eric.huang@linux.alibaba.com>
>> Co-authored-by: TANG Tiancheng <lyndra@linux.alibaba.com>
>> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
>> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> ---
>>   target/riscv/cpu.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>> index cb4ccd001d..1e49465eeb 100644
>> --- a/target/riscv/cpu.c
>> +++ b/target/riscv/cpu.c
>> @@ -225,8 +225,10 @@ const RISCVIsaExtData isa_edata_arr[] = {
>>       ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
>>       ISA_EXT_DATA_ENTRY(smpmpmt, PRIV_VERSION_1_12_0, ext_smpmpmt),
>>       ISA_EXT_DATA_ENTRY(smmpm, PRIV_VERSION_1_13_0, ext_smmpm),
>> +    ISA_EXT_DATA_ENTRY(smmpt, PRIV_VERSION_1_13_0, ext_smmpt),
>>       ISA_EXT_DATA_ENTRY(smnpm, PRIV_VERSION_1_13_0, ext_smnpm),
>>       ISA_EXT_DATA_ENTRY(smrnmi, PRIV_VERSION_1_12_0, ext_smrnmi),
>> +    ISA_EXT_DATA_ENTRY(smsdid, PRIV_VERSION_1_13_0, ext_smsdid),
>>       ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
>>       ISA_EXT_DATA_ENTRY(ssaia, PRIV_VERSION_1_12_0, ext_ssaia),
>>       ISA_EXT_DATA_ENTRY(ssccfg, PRIV_VERSION_1_13_0, ext_ssccfg),
>> @@ -1379,6 +1381,8 @@ const RISCVCPUMultiExtConfig 
>> riscv_cpu_vendor_exts[] = {
>>     /* These are experimental so mark with 'x-' */
>>   const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
>> +    MULTI_EXT_CFG_BOOL("x-smmpt", ext_smmpt, false),
>> +    MULTI_EXT_CFG_BOOL("x-smsdid", ext_smsdid, false),
>>       MULTI_EXT_CFG_BOOL("x-svukte", ext_svukte, false),
>>         { },
>

