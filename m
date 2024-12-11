Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 008D7E77180
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:49:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPi4-0002Uy-OB; Wed, 11 Dec 2024 11:37:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lc00631@tecorigin.com>)
 id 1tLPhv-0001uq-U8; Wed, 11 Dec 2024 11:37:04 -0500
Received: from out28-97.mail.aliyun.com ([115.124.28.97])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lc00631@tecorigin.com>)
 id 1tLPhn-0002IU-6c; Wed, 11 Dec 2024 11:37:03 -0500
Received: from 192.168.8.102(mailfrom:lc00631@tecorigin.com
 fp:SMTPD_---.abVS0Qr_1733934994 cluster:ay29) by smtp.aliyun-inc.com;
 Thu, 12 Dec 2024 00:36:45 +0800
Message-ID: <0484b168-97b1-46bd-b266-5d440d9d3518@tecorigin.com>
Date: Thu, 12 Dec 2024 00:36:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] target/riscv: add VILL field for vtype register
 macro definition
To: Richard Henderson <richard.henderson@linaro.org>, bmeng.cn@gmail.com,
 liwei1518@gmail.com, palmer@dabbelt.com, alistair.francis@wdc.com
Cc: dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org, zqz00548@tecorigin.com
References: <cover.1733930699.git.lc00631@tecorigin.com>
 <87f12c20620026268bc49cd030e6ce8f26e718c4.1733930699.git.lc00631@tecorigin.com>
 <115a3d3d-a303-4e7d-88fd-de1a291db540@linaro.org>
From: Chao Liu <lc00631@tecorigin.com>
In-Reply-To: <115a3d3d-a303-4e7d-88fd-de1a291db540@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.28.97; envelope-from=lc00631@tecorigin.com;
 helo=out28-97.mail.aliyun.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

On 2024/12/11 23:55, Richard Henderson wrote:

> On 12/11/24 09:48, Chao Liu wrote:
>> Signed-off-by: Chao Liu <lc00631@tecorigin.com>
>> ---
>>   target/riscv/cpu.h | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
>> index 284b112821..0d74ee4581 100644
>> --- a/target/riscv/cpu.h
>> +++ b/target/riscv/cpu.h
>> @@ -170,7 +170,8 @@ FIELD(VTYPE, VSEW, 3, 3)
>>   FIELD(VTYPE, VTA, 6, 1)
>>   FIELD(VTYPE, VMA, 7, 1)
>>   FIELD(VTYPE, VEDIV, 8, 2)
>> -FIELD(VTYPE, RESERVED, 10, sizeof(target_ulong) * 8 - 11)
>> +FIELD(VTYPE, RESERVED, 10, sizeof(target_ulong) * 8 - 12)
>> +FIELD(VTYPE, VILL, sizeof(target_ulong) * 8 - 1, 1)
>
> Still incorrect, for the same reason.
>
> We support execution of rv32 cpus with qemu-system-riscv64, where 
> sizeof(target_ulong) is always 8.  We support SXL/UXL, which changes 
> the behaviour at runtime.
>
> And, really, why do you want to add a define that is never used?
>
>
> r~

Thank you for your reply, I have understood it now.

Initially, by reading the RISC-V architecture manual and the QEMU source 
code, I noticed that the definition of vtype.vill was missing.

After your explanation, I reviewed the source code again and found that 
QEMU defines the vill field within the CPURISCVState. According to 
MXL_RV64 and MXL_RV32, when reading vtype, vill is incorporated into it.

Therefore, there is no need to add this definition, as it is not 
actually being used.

However, I still have one question:

since the goal is to enable qemu-system-riscv64 to support RV32, it 
seems somewhat unreasonable to have vtype.RESERVED fixed at 
"sizeof(target_ulong) * 8 - 12" and let the compiler calculate its bit 
width. The vtype.RESERVED field is [11:62] under RV64 and [11:30] under 
RV32.

Currently, it is used in the following context:

//target/riscv/vector_helper.c:34
target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
                             target_ulong s2)
{
     ...
     target_ulong reserved = s2 &
MAKE_64BIT_MASK(R_VTYPE_RESERVED_SHIFT,
           xlen - 1 - R_VTYPE_RESERVED_SHIFT);
     ...

Regards,
Chao


