Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFE59CD98F0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 11:35:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZoXU-0006sY-W0; Wed, 17 Jun 2026 07:34:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wZoXO-0006rO-5Q
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 07:34:30 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wZoXL-0007Z0-LB
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 07:34:29 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65H8ULeB239815
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 11:34:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zwyaTYje9gbDOiUGC+Cyk/RTLe+hVlwfL4K6YFXVYgM=; b=hdANukom33sePZ/t
 aYONcUmqEti87wjpE/ihL9jViGidcqjN4o31PftKxJpvwBpEYjowNLd4eNFgahbP
 dbUAaPYE7H/RrYw5YZ5CbDlpLPlV0rv9DSDai0DA/M1bfTJeHqaUJs7P3H1XpOV/
 TqkpyYR8F1BlcP8RkG2FYz/l5UJFvRWSMitMMW8taGzsKLZqJ5H0/ac51PHekjkb
 5b7k60lLLb4KxwXxuskzIgA2KlxqSUCzftm+AO+2NKKX+lEka0rCgpngNPz8+9qQ
 CaQSPTVf2917CleEKyNkzFoGLKvNdd2CR+/iR+xH+1hw6Mpl4zPe4vT198Qk7NbC
 Y1q4hQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eueepjtf6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 11:34:25 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-517ac42d958so103552701cf.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 04:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781696064; x=1782300864; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zwyaTYje9gbDOiUGC+Cyk/RTLe+hVlwfL4K6YFXVYgM=;
 b=ituqJg+PyWA19RInYXKPXtR+5/FEPendT1ryXXvsicoRefCuG1ocArTvyP5Q8tXpZx
 hQswSbefGGX+nQ/7szwH+gfaiOeNm08HU6ZpX0kCYeez8i/3lW48zwyBle2u6kbjhbNu
 azL6WNQjzxFT2WaMhbD0/1GjYUufeSH55hXrpkXIOxY7kV7czYsMlBoEcAVpEc78jroe
 ZhRy7DiCGaLAzruG71gkJF63+XgObn25w7yx6230Wxe+87+nXXjSwChUwLNEy1KWvKHO
 IGwMeFTnnBvF7A+1NhtPjxWs44FmjXBlqcM+rVvH11Hc3C6G9jkb2RqDdTLil2k4Qbb3
 pm0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781696064; x=1782300864;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zwyaTYje9gbDOiUGC+Cyk/RTLe+hVlwfL4K6YFXVYgM=;
 b=HrJwYwr7B3LRutDQ1soFIEywHfb5BPxrA08ClpzMdBMkvpP83Z1V5/ea1fw67+awax
 Ad5sRQnPAXcjeh+Et9Zmyh1cVq9yK5xF1/xUT2TKrgplj8sF/gEd4EYXnk+cluXj7MyH
 WPtmdIee2SY0YOmb+SMnibNlamXFcTKp/VG+/JEOdbkzfuIkkigZOTih0XpoLT93bUNP
 OIm0R9UDju+XW4Tw3F1Rg9t4WRPkIJaKjGp7hLbPdHMAIVgB64BHz6knZBLIPrxpxU0z
 g1gpiuwK4zMNBdEWn8PveoQQaVg5Wj4rs7sXr1/7aqJygqWY2uugQtoNIr4LPoskFCJb
 vdRw==
X-Forwarded-Encrypted: i=1;
 AFNElJ820VpDBxGG0uIraH/DOWs6nIWFOmC0gMJomPMW+FgjUBLZMAjfPeDy8SSHbsEruBWfcRvYSQCJ/7Vl@nongnu.org
X-Gm-Message-State: AOJu0YxLagyqonFc9k/HzDX9wCoGnsyKElSDZItKHlecsAYQpy8gBsaX
 l1/1AnYPJCLzLsGyMFiaC9UfQhMMmLREDLcnEzVqOFBiH570MqT+qsAZ9+kbbL5f0KyL93p6fwY
 Se/QrwI3XfnCjDnbWD4s1cbvJRiqCPAeHtCZJgPCl0P15l9HVWQqDNhxaZA==
X-Gm-Gg: Acq92OFOXUJ9rGsH5rAiDoEl9AUpYKSnmEk+88Q76iMenY6tqi+b3WFZQYOIqP4Ty79
 FnRBNZwN3DlXI2JRFFojzCS+ZYSOw+tF8jB/qOQ8vlZBWhsLmHkLEADhYqCv7WY6ySson19/tOp
 I5Q2o8smu8s3urs4YmxrEQOo/CjUUwuV51Rd+Xh0VUukdQOY0QyJbqKaRqt9EeT2tsSPWgP3yut
 iBMD5i1LBYqmNKne4JRVFxNm55zl8nqzBZtaiXmn575z1msmTwsVdQhfrR+P63yCNNjeDfaILAy
 NZYYRp/2n2SkTmvQiMTrT7iOKi+cBI7P7MlMZ/m6WJSgWF2tGlPHiATAqYwRTcOBt5RtI8FZ6hG
 W59trhqxhVN0vktSk+eBe+3P8R/9FsoW3aYmEHPqisvORqMI=
X-Received: by 2002:a05:622a:14c7:b0:517:580c:bcd3 with SMTP id
 d75a77b69052e-519ac2276aemr39688041cf.19.1781696064054; 
 Wed, 17 Jun 2026 04:34:24 -0700 (PDT)
X-Received: by 2002:a05:622a:14c7:b0:517:580c:bcd3 with SMTP id
 d75a77b69052e-519ac2276aemr39687501cf.19.1781696063416; 
 Wed, 17 Jun 2026 04:34:23 -0700 (PDT)
Received: from [192.168.68.103] ([177.170.117.62])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51955b271fbsm131095431cf.22.2026.06.17.04.34.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jun 2026 04:34:22 -0700 (PDT)
Message-ID: <9cc3db2f-9153-476c-91e7-82020cf60651@oss.qualcomm.com>
Date: Wed, 17 Jun 2026 08:34:19 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: raise access fault for Zicbom MMIO-like
 accesses
To: ZhengXiang Qin <qinzhengxiang@foxmail.com>, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>
References: <tencent_AFB2247001B0C72775E3DE202C43F5126107@qq.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <tencent_AFB2247001B0C72775E3DE202C43F5126107@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=AY+B2XXG c=1 sm=1 tr=0 ts=6a328641 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=gdiugJE53z4H+vvYeRBHqw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=p0WdMEafAAAA:8 a=bDN84i_9AAAA:8 a=EUspDBNiAAAA:8 a=D1X-efNntoiCHaPa3eEA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=J2PsDwZO0S0EpbpLmD-j:22
X-Proofpoint-GUID: AzT6YoTfWEmtK97XAExMDaCP3PIEbQeY
X-Proofpoint-ORIG-GUID: AzT6YoTfWEmtK97XAExMDaCP3PIEbQeY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDExMCBTYWx0ZWRfX0jJVZ4DtvD+Y
 hDIxDBn/eI33fshZFuK/YEXgu8Rv5jJkBxq6MVOe2Oh9y9xYaEp3z3SM9frtctU4MMzLIcQYkT0
 xrfSH5MJNKtv9rIsqhrskTG7I6ZTa683VbQwDTODckWeYBJkhHXecBVjoRHqAscDW0UUr7ZrDSj
 jnk1aq4bD1jbV8NZN0Uo/XGOhCM9N71f/BzU1U3BPEYWN2inHYD0kextiDDodbkRewpLTqbRP0z
 /4+/CkBi6nOZu/TZYLuAwI2KzH05k5kPIBb6pzAanTKdZP+ScoP8ypcjukGCvycU12ZpsXL7Y7+
 xkdAI3JV/bqlpLk0cbx+31qs17H3p8D2w2Hvvk+AZYWxL4YVmW7aR1qHoSqmf2YJPfg4mvslR4q
 c5X++mZPAuHxYQbjvDy2FRYRTvNE+ltta8SBwMTrehB653IvgZN+Wy8HbyRqzCEoCFZX7f2j5S2
 tPB677m3crbPfX04jtw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDExMCBTYWx0ZWRfX+BF83PJihVe8
 n8+jgqfXbrLBSrAoyvqnchf4lWTYk2gQfMAfv4rbfUoJTcPuxLOz63WBrZ2+Zkx4bpGin1yRtjG
 dKB/7G5yIzycHqe6o5vFo1nfrqIY9CA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_01,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606170110
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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



On 6/16/2026 12:33 PM, ZhengXiang Qin wrote:
> check_zicbom_access() probes the cache block with MMU_DATA_LOAD and
> returns early for any result other than TLB_INVALID_MASK.  This treats
> TLB_MMIO as a successful load access.
> 
> For Zicbom, a TLB_MMIO result does not provide a RAM host pointer for the
> cache block operation and should not be treated as a successful access.
> Raise a store/AMO access fault instead of silently completing the CBO
> instruction.
> 
> This fixes sv39_zicbom_exceptions_Smode.S, where cbo.clean/cbo.flush and
> cbo.inval access a block mapped to a physical address without PMA
> permissions.  Before this change, the CBO instruction completed and the
> following addi was executed.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3501
> Signed-off-by: ZhengXiang Qin <qinzhengxiang@foxmail.com>
> ---

Thanks for taking care of this one.

Without this patch:

$ ./build/qemu-system-riscv64 -d in_asm,int,mmu,unimp,cpu,fpu,vpu,exec,nochain \
	-D sv39_zicbom_access_fault.elf.trace.log -nographic -semihosting -icount shift=1 \
	-machine virt -cpu max,pmu-mask=0xfffffff8 \
	-bios ~/Downloads/sv39_zicbom_access_fault.elf

RVCP-SUMMARY: TEST FAILED - Test File "sv39_zicbom_exceptions_Smode.S"
RVCP: DEBUG INFORMATION FOLLOWS
RVCP: Test Info: "Mismatch during cbo.clean in Test Case 1!"
RVCP: Instruction: 0x0017a00f
RVCP: Approximate address (failure may be slightly after this): 0x0000000080000250
RVCP: Register: x12
RVCP: Bad Value:      0x0000000000000814
RVCP: Expected Value: 0x0000000000000810
RVCP: END OF DEBUG INFORMATION


With the patch, same cmd line:

$ ./build/qemu-system-riscv64 (...)

RVCP-SUMMARY: TEST PASSED - Test File "sv39_zicbom_exceptions_Smode.S"





Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Tested-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>



>   target/riscv/op_helper.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index 81873014cb..6c9bd5c102 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -218,6 +218,7 @@ static void check_zicbom_access(CPURISCVState *env,
>       void *phost;
>       int ret;
>   
> +    target_ulong fault_addr = address;
>       /* Mask off low-bits to align-down to the cache-block. */
>       address &= ~(cbomlen - 1);
>   
> @@ -235,6 +236,10 @@ static void check_zicbom_access(CPURISCVState *env,
>        */
>       ret = probe_access_flags(env, address, cbomlen, MMU_DATA_LOAD,
>                                mmu_idx, true, &phost, ra);
> +    if (ret == TLB_MMIO) {
> +        env->badaddr = fault_addr;
> +        riscv_raise_exception(env, RISCV_EXCP_STORE_AMO_ACCESS_FAULT, ra);
> +    }
>       if (ret != TLB_INVALID_MASK) {
>           /* Success: readable */
>           return;


