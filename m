Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CFB7C9830B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 14:46:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9ODk-0004EP-Ju; Wed, 23 Sep 2026 10:45:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9ODg-0004DQ-2M
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 10:45:12 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9ODe-0000sf-Dt
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 10:45:11 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NDL8qa177336
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 14:45:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZoSkz7NbOCdwTIo/YUHO8vlqoq6+6FsxxGnJIVi1Fps=; b=pIgTxcXAC3GCER61
 UNCqPFwTHYCHIwdD3oCz8eiKh/pAQROQdoKqwvxiFmApoIt3gEC6ltgsiNs5JPVE
 yEh5oNYYyQkEDj+Zs2sAYFoXLuAGZzeKcCIBPhH8oTOT2snx5hk50/MMkCj4f+K9
 SaXT4qM5GmxRec6ImJMOOxlUoIh4Y/5kMRkg+1pWMrBmyXbNA4VArahAnv7fZIvk
 PHgvDUXuPKIBeEUC8n4WYloDYxlTs6ejiYSATqXO4rue7vByJzeWfyVdcJPDQ4U8
 nzhXShFxWZ2yldo1eMdBUXp4X+QQJm3EZhwIttlzCcFxMpj37GaOpN0r+5suml6e
 SnQYtw==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvfjxrcfy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 14:45:08 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-9806535f8ffso1897917241.1
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 07:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790174708; x=1790779508; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZoSkz7NbOCdwTIo/YUHO8vlqoq6+6FsxxGnJIVi1Fps=;
 b=NRWDpuD9HLg5WU/nNh+LDd0JTboxb4lbJ+B1gxrff2i6E3ZBPh9u5nQft/1FHwkday
 DdUem5RzsXMqtgDbfewTnkvXjKtHvpEWE2vms/kInXNUuuTwOAD4JVMXgY2Afq3qp+mK
 GPHmtDbDFStUyDVqKNtkqwwVMXf55fIqTzMNQs51BhFv6Kdg4DIqxO9WCkH38CFSM0GJ
 GuM0f+rgS7k/Gzn8oI0Y88mQAxaw7frOLGWoz/DW1Db3XrLHWOMDbcqT8uiVGmeArGq5
 pVLRAr0iiHjlVBaHhmdAL5yOQnAFIHZdlOfde66NjDy7YxCpjxtdwMwOO+wGkhns03MW
 jBXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790174708; x=1790779508;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZoSkz7NbOCdwTIo/YUHO8vlqoq6+6FsxxGnJIVi1Fps=;
 b=MjPuxAV4VOijmiNE3PsaLmoil78VEt1JPghrSvpJfE51r+xRuZziRe/9oXLdR/Tjmh
 n/XOX6FWsQdZIYTI+PHPJ2iCFwbvW1fvRTijmdMN7CD88W9ps97JNq2gVNqD8C8JFM15
 Hb0udpyrVlMKLLsKHIfUiG9azm3nejH3UNybeRUIthnT5PfTlFhEy0HfCTm9RA3aQKKz
 tIDMoAVqRIqExwpB2KMesgw0kZ3ccgsdtDusYshro3Z9scKYJUAQkBv1/c36dTLWoN7R
 9PXDbc4zeRJARnsDLtFJfQlmM7VZ+0F8JAzV88xkxGd6IlfoRB7jOXud/UkgOxYtZLs0
 TuUA==
X-Forwarded-Encrypted: i=1;
 AKwUvByZqzSXwyCL7/6QlU+5Ya/O0cV2HB2iNMhdASMDle3SFoVmFCaIZCA78diixUEhF7jVLqbG6GZyHfSf@nongnu.org
X-Gm-Message-State: AFuF++nyeAr2v60oiTuNAU8fcVC8h5cnXfTnfZy9AczoVZ4PFd4rBdrx
 45VqUAzV4Yfx+ior81q5pXciYU2KiyOqOtoA3H+IsgdKUUNBf+TOa41dp/pKCdtqT6mlXk8ZLFv
 /RoGPbkt30kBPNbo4J/pWJ0aCqtP/iLVTTOKGvXmKWq+z7fzTikhYlPO+vw==
X-Gm-Gg: AYBFou2gpHJ1DdXullJETKelrhqy7YM03TYoEJibDiB7Bmdcejt75GnUY4V3fcjt+gl
 TkXOzpburCKGLjUqA2qLgyJ/Broi5hu/Bf32B+JSG7F3jHkS+QbbZXua/OxQBdb+5r+414DCKtH
 7fHclBbmS18vY58oh6b6MTnablmdjpxBseZprNjom+q2l7C+YVq7XQqpaGIk+RixLjyCLpI7EGi
 YxZndsoPVQdqmaKEyyHSDXyFbPnqxuVde40ccuiBfT93gOOQeKeJtYLk/GwKglaQYRTXVxDGOpl
 crU8/cFnVc0RD8zij1gIoNQyrWopP7Q2sqdX17TgT9V86ssl80lwZ9TBl3pCxirjwT7gt3eNzit
 KO41h4ac6DJZfhz7GJeNe5UK2dAK2D8yDErpbf83+XePvYQQ=
X-Received: by 2002:a05:6102:8192:10b0:785:6b42:b7b0 with SMTP id
 ada2fe7eead31-7aa9df8e032mr5120192137.4.1790174707657; 
 Wed, 23 Sep 2026 07:45:07 -0700 (PDT)
X-Received: by 2002:a05:6102:8192:10b0:785:6b42:b7b0 with SMTP id
 ada2fe7eead31-7aa9df8e032mr5120171137.4.1790174707146; 
 Wed, 23 Sep 2026 07:45:07 -0700 (PDT)
Received: from [10.21.17.122] (161.170.88.92.rev.sfr.net. [92.88.170.161])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fde1e2b82sm75602835e9.12.2026.09.23.07.45.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2026 07:45:06 -0700 (PDT)
Message-ID: <2a44f44e-b07a-42b9-aed2-f2c609d78353@oss.qualcomm.com>
Date: Wed, 23 Sep 2026 16:45:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/6] target/riscv: Split interrupt logic from
 riscv_cpu_update_mip.
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: Rajnesh Kanwal <rkanwal@rivosinc.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liweiwei@iscas.ac.cn,
 zhiwei_liu@linux.alibaba.com, atishp@rivosinc.com, apatel@ventanamicro.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Bin Meng <bin.meng@processmission.com>
References: <20231016111736.28721-1-rkanwal@rivosinc.com>
 <20231016111736.28721-5-rkanwal@rivosinc.com>
 <3ae1ecd6-e4ee-4e4a-a341-925fd14dc2b8@oss.qualcomm.com>
In-Reply-To: <3ae1ecd6-e4ee-4e4a-a341-925fd14dc2b8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: u1D0LL74tqfoNosRjtLL1Em9_7ir4RBr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA1OCBTYWx0ZWRfX8XV4VdXqCToE
 ERbELx0MIoekUG0up24x0oP3myaHPLMJW6y9JbiQFOYuu+mMxugCqd5uZYnE/ByE2hZBWXpg4bW
 hJ0DiLNMAQTEU2NqKKK+1y280e8+5BsRTNUa+CxjYePXG4q56S6tqma6k7UQFVBnj/9MYnKjyk4
 6gRZ64hpgE7PQyk8PRbGy3AdIGS2AsM5KjcbaZIxFhXRhqTVGIfTIgeo55d+wRw/jgseSS2Hs5z
 NTpnsN+pzyMhcTnEJskf27L5edcLp/puAlyfwHePsQ2DOLms8oi8o5DX24LdGHFFXr4XP5WV6Ev
 FAGJ2bO4PfIxK40c34zUJi/KNk6OZykiyK3OiU3Vrtc3Xxd/hD/FMe9ApCWWNZ6GOEqcXW9VOkw
 zFoO+X9Wqs5ht42W82Cg9GC5Lvt6uDCFJgmzXfrZh1MyL1qZQg7ILsnkeZMwHuKZeybQz6EsmzA
 LMss8+nxLlK4Jpo9IGg==
X-Proofpoint-GUID: u1D0LL74tqfoNosRjtLL1Em9_7ir4RBr
X-Authority-Analysis: v=2.4 cv=NLpAaE6g c=1 sm=1 tr=0 ts=6ab3e5f4 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=XFFLIW5kwC1urAZS/mNkYQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=h0uksLzaAAAA:8 a=JF9118EUAAAA:8 a=EKYOHlaN6AYWZJuNelgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=o1xkdb1NAhiiM49bd1HK:22 a=MSi_79tMYmZZG2gvAgS0:22
 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA1OCBTYWx0ZWRfX2sJdLcoItjbB
 aRiHo26ACM7hOInC4DELDZoi+T9ToaCnx7RV6LWAV1IyEi3JxxAVyCXuJiZWKeCJ030f/IQR9dy
 qkBm6lQU3uIUnLBS6icDOHOwwZemEBk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230058
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 23/9/26 11:23, Philippe Mathieu-DaudÃ© wrote:
> Hi,
> 
> (now committed as 1ebad505f3d5108513bf150b901344caceb3a7c1)
> 
> On 16/10/23 13:17, Rajnesh Kanwal wrote:
>> This is to allow virtual interrupts to be inserted into S and VS
>> modes. Given virtual interrupts will be maintained in separate
>> mvip and hvip CSRs, riscv_cpu_update_mip will no longer be in the
>> path and interrupts need to be triggered for these cases from
>> rmw_hvip64 and rmw_mvip64 functions.
>>
>> Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
>> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>> ---
>>   target/riscv/cpu.h        |  1 +
>>   target/riscv/cpu_helper.c | 25 ++++++++++++++++++-------
>>   2 files changed, 19 insertions(+), 7 deletions(-)


>> +uint64_t riscv_cpu_update_mip(CPURISCVState *env, uint64_t mask, 
>> uint64_t value)
>> +{
>> +    uint64_t old = env->mip;
>> +
>> +    /* No need to update mip for VSTIP */
>> +    mask = ((mask == MIP_VSTIP) && env->vstime_irq) ? 0 : mask;
> 
> If mask == 0 do we still want to call the riscv_cpu_interrupt() logic?
> 
> IIUC this is the point of masking, if no change no need to update MIP
> and evaluate other fields.
> 
>> +
>> +    QEMU_IOTHREAD_LOCK_GUARD();
>> +
>> +    env->mip = (env->mip & ~mask) | (value & mask);
>> +
>> +    riscv_cpu_interrupt(env);
>>       return old;
>>   }
> 
> IOW as of commit 7074591d795:
> 
> -- >8 --
> @@ -580,6 +581,9 @@ uint64_t riscv_cpu_update_mip(CPURISCVState *env, 
> uint64_t mask, uint64_t value)
> 
>       /* No need to update mip for VSTIP */
>       mask = ((mask == MIP_VSTIP) && env->vstime_irq) ? 0 : mask;
> +    if (!mask) {
> +        return old;
> +    }
> 
>       BQL_LOCK_GUARD();
> 
> ---

I'll post as proper patch.

