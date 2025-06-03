Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D97C6C5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 08:03:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMMbh-0006mx-Ks; Tue, 03 Jun 2025 04:02:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liujingqi@lanxincomputing.com>)
 id 1uMMba-0006ln-Bv
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 04:02:42 -0400
Received: from sg-1-23.ptr.blmpb.com ([118.26.132.23])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liujingqi@lanxincomputing.com>)
 id 1uMMbV-0004XL-0h
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 04:02:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1748937745;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=q/mmO4mWauBeFH+weps+XVhR72n4lkubEVs6dR5/2U4=;
 b=EjUpUI7ac6h4JmLzrF3jI1ivzJo55aHYwJJMnzIcQ8t6XlPLp7Fe8a/iIOcIF/yaoPn8lv
 2XGOyYkzjQDsCBDFeeI4wMc6sVcmCZNlliuSNeWk1MTD7AzzEh+lQc+b4hYajIsAK9OGhv
 eaD+Fv7JQ9nXnk/oAQNAwlecWf1MlRZY8GhGHPId1nTtnZs8d/oE89+Cwt+Q7Kd3cyN6Qx
 E7Hzl/1KQjl7vmUqtf3W2abbjZ6oFXy8/YEY/o1plEacBrOcxsX9cpsFrS7bRdgdUmA7FG
 VckIb9bAcAgIq1yjzO3LAnwiO88+T/4wLHgt63LkRjeVa+Ok7NUXuPDiaaKaLQ==
Content-Language: en-US
X-Lms-Return-Path: <lba+2683eac0f+26e5e3+nongnu.org+liujingqi@lanxincomputing.com>
Date: Tue, 3 Jun 2025 16:02:21 +0800
Received: from [127.0.0.1] ([180.165.23.184]) by smtp.feishu.cn with ESMTPS;
 Tue, 03 Jun 2025 16:02:22 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/riscv/riscv-iommu: Fix PPN field of
 Translation-reponse register
X-Original-From: Nutty Liu <liujingqi@lanxincomputing.com>
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <CAKmqyKPKLHk97s-eVGANq7hYfny1g-WgFQA32eoNo9UYLC9ixA@mail.gmail.com>
From: "Nutty Liu" <liujingqi@lanxincomputing.com>
Message-Id: <7d398658-71f2-4c79-9779-947f79b55ca8@lanxincomputing.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
References: <20250529092632.4367-1-liujingqi@lanxincomputing.com>
 <CAKmqyKPKLHk97s-eVGANq7hYfny1g-WgFQA32eoNo9UYLC9ixA@mail.gmail.com>
To: "Alistair Francis" <alistair23@gmail.com>
Cc: "Palmer Dabbelt" <palmer@dabbelt.com>, 
 "Alistair Francis" <alistair.francis@wdc.com>, 
 "Weiwei Li" <liwei1518@gmail.com>, 
 "Daniel Henrique Barboza" <dbarboza@ventanamicro.com>, 
 "Liu Zhiwei" <zhiwei_liu@linux.alibaba.com>, 
 "Tomasz Jeznach" <tjeznach@rivosinc.com>, 
 "Richard Henderson" <richard.henderson@linaro.org>, 
 <qemu-riscv@nongnu.org>, <qemu-devel@nongnu.org>
Received-SPF: pass client-ip=118.26.132.23;
 envelope-from=liujingqi@lanxincomputing.com; helo=sg-1-23.ptr.blmpb.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Alistair,

Thanks for your review.

(Sorry, just resend this email due to the incorrect line break in the
previous reply email.)

On 6/2/2025 1:11 PM, Alistair Francis wrote:
> On Thu, May 29, 2025 at 10:52=E2=80=AFPM Nutty Liu
> <liujingqi@lanxincomputing.com> wrote:
>> The original implementation incorrectly performed a bitwise AND
>> operation between the PPN of iova and PPN Mask, leading to an
>> incorrect PPN field in Translation-reponse register.
>>
>> The PPN of iova should be set entirely in the PPN field of
>> Translation-reponse register.
>>
>> Signed-off-by: Nutty Liu <liujingqi@lanxincomputing.com>
>> ---
>>   hw/riscv/riscv-iommu.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
>> index a877e5da84..f529a6a3d7 100644
>> --- a/hw/riscv/riscv-iommu.c
>> +++ b/hw/riscv/riscv-iommu.c
>> @@ -1935,8 +1935,7 @@ static void riscv_iommu_process_dbg(RISCVIOMMUStat=
e *s)
>>               iova =3D RISCV_IOMMU_TR_RESPONSE_FAULT | (((uint64_t) faul=
t) << 10);
>>           } else {
>>               iova =3D iotlb.translated_addr & ~iotlb.addr_mask;
>> -            iova >>=3D TARGET_PAGE_BITS;
>> -            iova &=3D RISCV_IOMMU_TR_RESPONSE_PPN;
>> +            iova =3D set_field(0, RISCV_IOMMU_TR_RESPONSE_PPN, PPN_DOWN=
(iova));
> I don't see how this is different.
>
> PPN_DOWN(iova)
> is the same as
> iova >> TARGET_PAGE_BITS

Yes. The results of above operations are the same.

>
> and
>
> set_field(0, RISCV_IOMMU_TR_RESPONSE_PPN, PPN_DOWN(iova))
> should just return
> (0 & ~RISCV_IOMMU_TR_RESPONSE_PPN) |
>      (RISCV_IOMMU_TR_RESPONSE_PPN & PPN_DOWN(iova))

It's not correct.
Let me show the definitions of the related macros as follows.

1) The definition of 'set_field' in 'target/riscv/cpu_bits.h' is as below:

     #define set_field(reg, mask, val) (((reg) & ~(uint64_t)(mask)) | \
                                       (((uint64_t)(val) * ((mask) & ~((mas=
k) << 1))) & \
                                       (uint64_t)(mask)))

2) The definition of 'RISCV_IOMMU_TR_RESPONSE_PPN' in 'hw/riscv/riscv-iommu=
-bits.h' is as follows:

     #define RISCV_IOMMU_PPN_FIELD GENMASK_ULL(53, 10)
     #define RISCV_IOMMU_TR_RESPONSE_PPN RISCV_IOMMU_PPN_FIELD

So the 'RISCV_IOMMU_TR_RESPONSE_PPN' is 0x3ffffffffffc00.


Let me give you an example as follows.

With the original implementation,
1) Assume: iova =3D 0x12345678;

2) iova >>=3D TARGET_PAGE_BITS;
The result is as follows:
 =C2=A0 iova =3D 0x12345;

It's the same as PPN_DOWN(iova).
This is the correct value of PPN.

3) iova &=3D RISCV_IOMMU_TR_RESPONSE_PPN;
After substituting with 'iova =3D 0x12345', the result is as follows:
   =C2=A0iova =3D 0x12345 & 0x3ffffffffffc00;
The final 'iova' is as follows:
     iova =3D 0x12000;
This 'iova' will be set to Translation-reponse register finally by thebelow=
 sentence.
   =C2=A0riscv_iommu_reg_set64(s, RISCV_IOMMU_REG_TR_RESPONSE, iova);

Then the value of Translation-reponse register will be set to '0x12000'.
The PPN field is between bit 10 and bit 53.
So the PPN is 0x48 which is calculated by '0x12000 >> 10 =3D 0x48'.

It's incorrect. Actually the PPN field should be 0x12345.

It should be calculated as follows:
     iova =3D (iova << 10) & RISCV_IOMMU_TR_RESPONSE_PPN;
After substituting with 'iova =3D 0x12345', and the result is as follows:
     iova =3D (0x12345 << 10) & 0x3ffffffffffc00 =3D 0x48D1400
The correct value of Translation-reponse register should be '0x48D1400'.

4) With the new implementation,
     iova =3D set_field(0, RISCV_IOMMU_TR_RESPONSE_PPN, PPN_DOWN(iova));

It will set the bit 10 to bit 53 of 'iova' to PPN_DOWN(iova).
After substituting with 'iova =3D 0x12345', the final 'iova' is as follows:
     iova =3D 0x48D1400;
And then the correct 'iova' will be set to Translation-reponse register.

> Can you describe the issue with the original implementation and why
> this fixes it in the commit message?

Hope the above description and the example can help you understand.

Nutty,
Thanks

>
> Alistair
>
>>               /* We do not support superpages (> 4kbs) for now */
>>               iova &=3D ~RISCV_IOMMU_TR_RESPONSE_S;
>> --
>> 2.49.0.windows.1
>>

