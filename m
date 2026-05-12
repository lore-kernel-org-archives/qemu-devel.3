Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09105CD4846
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 02:35:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMcxc-00055Z-6E; Mon, 11 May 2026 22:35:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1wMcxa-00054o-5H; Mon, 11 May 2026 22:35:02 -0400
Received: from out30-98.freemail.mail.aliyun.com ([115.124.30.98])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1wMcxW-0004eh-VF; Mon, 11 May 2026 22:35:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1778553293; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=2NBQSnr/vRs8EHgE52FUwTu+v0RGTF7V/hm/6lE4IeM=;
 b=HcvnnIF4VuqkgWsykfPABVM0k889CaKcI7Xs/9bBpKDulrvb6AyBW8sYeIXZ/1QF92D7pvbymPeApLG6qv3z/mjiGLcqSkbeI5D3m75bZTZKLaKibR1WsovmQaKOiqYe3DxZGL+/nLHdEIxo2qJhb1sLyMdQn2j1tgrBv9nsIt0=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R131e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033045133197;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=10; SR=0;
 TI=SMTPD_---0X2ooMfn_1778553292; 
Received: from 30.166.64.212(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0X2ooMfn_1778553292 cluster:ay36) by smtp.aliyun-inc.com;
 Tue, 12 May 2026 10:34:52 +0800
Message-ID: <d97eb9de-2e35-4e80-a53a-0f50c6e04a32@linux.alibaba.com>
Date: Tue, 12 May 2026 10:34:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/6] target/riscv: Enable SMMPT extension
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, chao.liu.zevorn@gmail.com,
 palmer@dabbelt.com, daniel.barboza@oss.qualcomm.com, liwei1518@gmail.com,
 Huang Tao <eric.huang@linux.alibaba.com>,
 TANG Tiancheng <lyndra@linux.alibaba.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
References: <20260408140635.42546-1-zhiwei_liu@linux.alibaba.com>
 <20260408140635.42546-7-zhiwei_liu@linux.alibaba.com>
 <CAKmqyKMryrNgfo8bp-FOj1F0B63WLv1Shsjwj=euptjVr7auVQ@mail.gmail.com>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <CAKmqyKMryrNgfo8bp-FOj1F0B63WLv1Shsjwj=euptjVr7auVQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.98;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-98.freemail.mail.aliyun.com
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

Hi Alistaire

On 4/10/26 9:46 AM, Alistair Francis wrote:
> On Thu, Apr 9, 2026 at 12:09 AM LIU Zhiwei <zhiwei_liu@linux.alibaba.com> wrote:
>
> Can we add a link in this commit to the spec version please?

OK. Done in v6 patch set.

Thanks,
Zhiwei

>
> Alistair
>
>> Co-authored-by: Huang Tao <eric.huang@linux.alibaba.com>
>> Co-authored-by: TANG Tiancheng <lyndra@linux.alibaba.com>
>> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
>> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> ---
>>   target/riscv/cpu.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>> index cb4ccd001d..1e49465eeb 100644
>> --- a/target/riscv/cpu.c
>> +++ b/target/riscv/cpu.c
>> @@ -225,8 +225,10 @@ const RISCVIsaExtData isa_edata_arr[] = {
>>       ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
>>       ISA_EXT_DATA_ENTRY(smpmpmt, PRIV_VERSION_1_12_0, ext_smpmpmt),
>>       ISA_EXT_DATA_ENTRY(smmpm, PRIV_VERSION_1_13_0, ext_smmpm),
>> +    ISA_EXT_DATA_ENTRY(smmpt, PRIV_VERSION_1_13_0, ext_smmpt),
>>       ISA_EXT_DATA_ENTRY(smnpm, PRIV_VERSION_1_13_0, ext_smnpm),
>>       ISA_EXT_DATA_ENTRY(smrnmi, PRIV_VERSION_1_12_0, ext_smrnmi),
>> +    ISA_EXT_DATA_ENTRY(smsdid, PRIV_VERSION_1_13_0, ext_smsdid),
>>       ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
>>       ISA_EXT_DATA_ENTRY(ssaia, PRIV_VERSION_1_12_0, ext_ssaia),
>>       ISA_EXT_DATA_ENTRY(ssccfg, PRIV_VERSION_1_13_0, ext_ssccfg),
>> @@ -1379,6 +1381,8 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] = {
>>
>>   /* These are experimental so mark with 'x-' */
>>   const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
>> +    MULTI_EXT_CFG_BOOL("x-smmpt", ext_smmpt, false),
>> +    MULTI_EXT_CFG_BOOL("x-smsdid", ext_smsdid, false),
>>       MULTI_EXT_CFG_BOOL("x-svukte", ext_svukte, false),
>>
>>       { },
>> --
>> 2.43.0
>>

