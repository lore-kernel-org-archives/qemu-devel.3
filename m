Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1108BCD4851
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 05:55:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN2YA-0008MW-FF; Wed, 13 May 2026 01:54:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <min_halo@163.com>)
 id 1wN2Y7-0008Lr-PT; Wed, 13 May 2026 01:54:28 -0400
Received: from m16.mail.163.com ([220.197.31.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <min_halo@163.com>)
 id 1wN2Y0-0005Kd-SE; Wed, 13 May 2026 01:54:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
 Content-Type; bh=jUPVGmhFWdyxiTcKHOnSCx39LbLZgoAKAjbgPL/oDgs=;
 b=MgexGCC83hqKmK16Lt0PwETREsK6D/DMzS0TGNaCmhNdv5WfjBSKDQ4AN/vsBw
 uSOj4ez5IZ6QviP/MwX8oSI6kv2PeCknmAh0U7N3I3oFCrNOl1W55fZCZ1Kz05s2
 83/ho1kx/xNul5lXuPBHFrXkyLIBaVAyIT3VVYp8glL5Q=
Received: from [10.42.12.46] (unknown [])
 by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id
 _____wBnFtzxEQRqRzY1BA--.4558S2; 
 Wed, 13 May 2026 13:53:55 +0800 (CST)
Message-ID: <3829993f-6116-4d52-8ea2-fa2b5d6f5c2b@163.com>
Date: Wed, 13 May 2026 13:53:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/riscv/kvm: add KVM support for Zicbop extension
Content-Language: en-US
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Zongmin Zhou <zhouzongmin@kylinos.cn>
References: <cover.1778551633.git.zhouzongmin@kylinos.cn>
 <bb6271546f870f3ee3cbeafdf0eb065925bb384d.1778551633.git.zhouzongmin@kylinos.cn>
 <47e3e0b2-6c6c-45a5-944f-affa05cf9174@oss.qualcomm.com>
From: Zongmin Zhou <min_halo@163.com>
In-Reply-To: <47e3e0b2-6c6c-45a5-944f-affa05cf9174@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wBnFtzxEQRqRzY1BA--.4558S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAF4kuw1DZr1ftr1kKw47XFb_yoWrCry8pr
 47JF45CFy5Zrn7C3y3Zr1DXr1Sgw4kKa1kC3yIg3WUXrWqyr97WryDKay3ur4ktF1xZrsY
 vF4vgr97urs8JaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zReVbkUUUUU=
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: pplqsxxdorqiywtou0bp/xtbC8xQdyGoEEfQOrAAA3b
Received-SPF: pass client-ip=220.197.31.3; envelope-from=min_halo@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 2026/5/12 19:23, Daniel Henrique Barboza wrote:
>
>
> On 5/11/2026 11:25 PM, Zongmin Zhou wrote:
>> From: Zongmin Zhou <zhouzongmin@kylinos.cn>
>>
>> When the Zicbop extension is available expose it to the KVM guest.
>> Also read and validate cbop_blocksize from the host via KVM interface.
>>
>> Signed-off-by: Zongmin Zhou <zhouzongmin@kylinos.cn>
>> ---
>>   target/riscv/kvm/kvm-cpu.c | 38 ++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 36 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
>> index b047ffa9c0..a46737f934 100644
>> --- a/target/riscv/kvm/kvm-cpu.c
>> +++ b/target/riscv/kvm/kvm-cpu.c
>> @@ -293,6 +293,7 @@ static void kvm_cpu_csr_set_u64(RISCVCPU *cpu, 
>> KVMCPUConfig *csr_cfg,
>>     static KVMCPUConfig kvm_multi_ext_cfgs[] = {
>>       KVM_EXT_CFG("zicbom", ext_zicbom, KVM_RISCV_ISA_EXT_ZICBOM),
>> +    KVM_EXT_CFG("zicbop", ext_zicbop, KVM_RISCV_ISA_EXT_ZICBOP),
>>       KVM_EXT_CFG("zicboz", ext_zicboz, KVM_RISCV_ISA_EXT_ZICBOZ),
>>       KVM_EXT_CFG("ziccrse", ext_ziccrse, KVM_RISCV_ISA_EXT_ZICCRSE),
>>       KVM_EXT_CFG("zicntr", ext_zicntr, KVM_RISCV_ISA_EXT_ZICNTR),
>> @@ -439,6 +440,12 @@ static KVMCPUConfig kvm_cboz_blocksize = {
>>       .kvm_reg_id = KVM_REG_RISCV_CONFIG_REG(zicboz_block_size)
>>   };
>>   +static KVMCPUConfig kvm_cbop_blocksize = {
>> +    .name = "cbop_blocksize",
>> +    .offset = CPU_CFG_OFFSET(cbop_blocksize),
>> +    .kvm_reg_id = KVM_REG_RISCV_CONFIG_REG(zicbop_block_size)
>> +};
>> +
>>   static KVMCPUConfig kvm_v_vlenb = {
>>       .name = "vlenb",
>>       .offset = CPU_CFG_OFFSET(vlenb),
>> @@ -1114,6 +1121,10 @@ static void 
>> kvm_riscv_read_multiext_legacy(RISCVCPU *cpu,
>>           kvm_riscv_read_cbomz_blksize(cpu, kvmcpu, 
>> &kvm_cbom_blocksize);
>>       }
>>   +    if (cpu->cfg.ext_zicbop) {
>> +        kvm_riscv_read_cbomz_blksize(cpu, kvmcpu, &kvm_cbop_blocksize);
>> +    }
>> +
>
> We don't need to add any new KVM regs/properties to 
> kvm_riscv_read_multiext_legacy().
> This is a legacy function aimed at kernels < 6.6 that doesn't support 
> KVM_GET_REG_LIST.
> There's no scenario where this function needs to read zicbop because
> KVM_RISCV_ISA_EXT_ZICBOP didn't exist back then.
>
> Patch LGTM otherwise.  Thanks,
>
Thanks for your review.

I'll remove the changes in |kvm_riscv_read_multiext_legacy()| as 
suggested and send a v2 shortly.

Best regards.

Zongmin

> Daniel
>
>
>>       if (cpu->cfg.ext_zicboz) {
>>           kvm_riscv_read_cbomz_blksize(cpu, kvmcpu, 
>> &kvm_cboz_blocksize);
>>       }
>> @@ -1293,6 +1304,10 @@ static void kvm_riscv_init_cfg(RISCVCPU *cpu, 
>> KVMScratchCPU *kvmcpu)
>>           kvm_riscv_read_cbomz_blksize(cpu, kvmcpu, 
>> &kvm_cbom_blocksize);
>>       }
>>   +    if (cpu->cfg.ext_zicbop) {
>> +        kvm_riscv_read_cbomz_blksize(cpu, kvmcpu, &kvm_cbop_blocksize);
>> +    }
>> +
>>       if (cpu->cfg.ext_zicboz) {
>>           kvm_riscv_read_cbomz_blksize(cpu, kvmcpu, 
>> &kvm_cboz_blocksize);
>>       }
>> @@ -2014,8 +2029,8 @@ void riscv_kvm_cpu_finalize_features(RISCVCPU 
>> *cpu, Error **errp)
>>       int ret;
>>         /* short-circuit without spinning the scratch CPU */
>> -    if (!cpu->cfg.ext_zicbom && !cpu->cfg.ext_zicboz &&
>> -        !riscv_has_ext(env, RVV)) {
>> +    if (!cpu->cfg.ext_zicbom && !cpu->cfg.ext_zicbop &&
>> +        !cpu->cfg.ext_zicboz && !riscv_has_ext(env, RVV)) {
>>           return;
>>       }
>>   @@ -2062,6 +2077,25 @@ void 
>> riscv_kvm_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
>>           }
>>       }
>>   +    if (cpu->cfg.ext_zicbop &&
>> +        riscv_cpu_option_set(kvm_cbop_blocksize.name)) {
>> +
>> +        reg.id = KVM_RISCV_REG_ID_ULONG(KVM_REG_RISCV_CONFIG,
>> + kvm_cbop_blocksize.kvm_reg_id);
>> +        reg.addr = (uint64_t)&val;
>> +        ret = ioctl(kvmcpu.cpufd, KVM_GET_ONE_REG, &reg);
>> +        if (ret != 0) {
>> +            error_setg_errno(errp, errno, "Unable to read 
>> cbop_blocksize");
>> +            return;
>> +        }
>> +
>> +        if (cpu->cfg.cbop_blocksize != val) {
>> +            error_setg(errp, "Unable to set cbop_blocksize to a 
>> different "
>> +                       "value than the host (%lu)", val);
>> +            return;
>> +        }
>> +    }
>> +
>>       /* Users are setting vlen, not vlenb */
>>       if (riscv_has_ext(env, RVV) && riscv_cpu_option_set("vlen")) {
>>           if (!kvm_v_vlenb.supported) {


