Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FAF606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 18:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kgROA807;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ULtB2VA3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJaqi-00079S-Ce; Wed, 21 Oct 2026 14:15:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xJaqS-0006w4-61
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 14:15:25 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xJaqP-0008LY-C4
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 14:15:23 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LHpH8X2415598
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 18:15:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cS1BtsvyyYqE4NW9AJlViTsvQpuH2ej3S8uzgU2953U=; b=kgROA807YcSjGqBe
 etZM9vEDz6bCN2v4qJsVVXlDVUD67tKaWOIg82JMrQqWM2YNRKRdBudwe1Jt9oVU
 3QhGsUiQmQ8s+U/0yXuIUslpEEKRwgaeLtpidPgFmn8Zk7coEO66Gs8741hXfKND
 YjHSnTXNgzQfWn1K4QeX8f1PnffWhhx2t9viS6egJQZpXVhk8eTzsG/fu/iAYGM0
 S1xb7+qKdIfgsudCgd+8wWG/bLbtmHlA0Iz3scEMKPKhqghZoMNVP90k8tHcgIzF
 nIvwyNMJT6gV4YMXsO3yOuH2gH2wdbWO16hg4SotNnWDIiT5overkwdhoKlVlI6X
 tciFuQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heuhuj0d1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 18:15:19 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-91b861c0618so17643666d6.0
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 11:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792606518; x=1793211318; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cS1BtsvyyYqE4NW9AJlViTsvQpuH2ej3S8uzgU2953U=;
 b=ULtB2VA3Evz+fBPOkIFTxb2WvuUgRG8Q53sEpxjlQen1IY5+7bkQxaFLfjiRcl0u+e
 ob8BsDHQvHZGILyDR5qhLRJpPEoSaNuvSsOTvtYowOeT7s0Ge9rgVrGfnVqzxvtENfat
 TpFzA208E6URl5YpZhpMyR8x944hynNTyewIumB4PxAHnwNvje5EiMEGsIZUvi1JK6nV
 1I/ds4nrn0luQTphKNsWx97/rbGzS3YTY7AwkWKosRbEEpGgG1fyMNNtXuUBswqTrCYM
 K6vdZcWpro71OBeDD7eIcLLk0RfTP35W10U9bt9wV9LhoaLjhYpywS4kAIp1eDpxShyf
 mmcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792606518; x=1793211318;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cS1BtsvyyYqE4NW9AJlViTsvQpuH2ej3S8uzgU2953U=;
 b=FPLKQ+sCDBEkrsDBHIdH6R8pHWmw3arMZsUrLF36RaVTlk33wrjps/OkxjW99ARB9x
 WlRnMEmPjxQ6npCXWzuHP/vvEshS1gYE4pbQGrDgGRlJ3b+nwEvNrQRa4TNeNa4VUXik
 7b+r7FirUi7XRp7nDxpTZ5fRnvv4vUYLMCs3o7Z6V4zEnYy9lFBVixqfqrsQHoWM2k2b
 S9loyK48oz7ekwxZhYSx5oJrtoLqTj/nHP02ZVMC5ZOzAsIesp2thBn2pwH9G90PvCQx
 hAKMEUqZ/aT/EqKhk82Exk6tXtNKdDfAvE8x/B7asqSy6B1LsAIfNJZn+QVjNR2xK5SR
 B0Iw==
X-Forwarded-Encrypted: i=1;
 AKwUvByTDCT2WkwpJJazhGg6ZI95hIhmlmuCx5QFBMgDdNXKxZD4qRhC3dTbq65XxGWjD0K8IBwpw9cIQ7R5@nongnu.org
X-Gm-Message-State: AFq9FYIsdvhJXxC9N4Qv3RfvfbO/m6n5pWrPFV53Lrr8pdp4vh0G5caa
 8LAkyUPnivLTiANe7ZHHhxjOfvZ5PjtvfZWF0DIUVl4nnp1ANn2Lu8XTIlKdtzNIfn9cwR+wcjY
 uiKKCgUeGRG+bHso/3+0WJZms70YmfxZfhBstSjbYJlmW1ChkpwleSGKJkQ==
X-Gm-Gg: AYBFou2ibHkdgb4TlID8pJkFAuI9pATsVybLrGYX0zbyqEqwZ1So4O9lobYrPYz/JuY
 Coy4g7d+I6QtvnzKHiUBnA1/rfiI6zP6sxVTXBPWY7FeiZU2LTdeKr6Ihkv21irAqNh8xsefJTP
 J9vUGVLOvAjlszSB+aiPeD46mhVqVr4zhMcgKEA/Zj7EUvbx5XfCupzmJYHjjKBtQ1Ci3MbTHhz
 dZ0EoFOPPyvLyRB3yvE3ZSxmWEcQKJk4LMocKMUJDIbcyHpnEhvVDZIEAs6rQZCchbBHtsvNaek
 J9cg0czwiNt+tQSEAj9xEIQ2tCVncmjh1pkxv6wRl0hR5AJUt5hJ5S0O5iBTYaaRLz/LQyeBgT9
 FBSBEwTufeq34K8Z5zZ4EdbzxKl6M1RaxM5foGD+ZFc/wW78VXmR7L0HO9xcrHnpUncB6PT4A
X-Received: by 2002:a05:6214:240d:b0:91b:88fe:a426 with SMTP id
 6a1803df08f44-91c12d0ee58mr50635506d6.0.1792606517351; 
 Wed, 21 Oct 2026 11:15:17 -0700 (PDT)
X-Received: by 2002:a05:6214:240d:b0:91b:88fe:a426 with SMTP id
 6a1803df08f44-91c12d0ee58mr50634576d6.0.1792606516695; 
 Wed, 21 Oct 2026 11:15:16 -0700 (PDT)
Received: from [192.168.68.101] (200-204-190-237.dsl.telesp.net.br.
 [200.204.190.237]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91c10c0f838sm30382806d6.32.2026.10.21.11.15.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2026 11:15:16 -0700 (PDT)
Message-ID: <0c32b74a-ed4b-4ab8-86d1-129f35d5862b@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 15:15:12 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] target/riscv/kvm: Detect SBI STA extension support
To: Wang Yechao <wang.yechao255@zte.com.cn>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>
Cc: Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
References: <20261017145211.219258-1-wang.yechao255@zte.com.cn>
 <20261017145211.219258-2-wang.yechao255@zte.com.cn>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261017145211.219258-2-wang.yechao255@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=d4JgWhjE c=1 sm=1 tr=0 ts=6ad90137 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=QmVDPCq3bE4LYXGvZ20s0w==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=1RTuLK3dAAAA:8 a=EUspDBNiAAAA:8 a=wf5jhZewy8u8kOt9vRIA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=kRpfLKi8w9umh8uBmg1i:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA3MiBTYWx0ZWRfX2HdjKVZIHTKc
 5i7vTi0AFe272dSy1/dbdQweEcn8dNBni2fHcTLanOCJ052F/0eO7T7ZeZ/ZS1Kp9xUPfOnEdrK
 PLQ7+BstknU3oYMT0ll/+svijL+7S54=
X-Proofpoint-GUID: P0cF29_ADPgQMvnRIeutPocrdTLI7yXS
X-Proofpoint-ORIG-GUID: P0cF29_ADPgQMvnRIeutPocrdTLI7yXS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA3MiBTYWx0ZWRfX8ChtQsoDbfoY
 VPRKRSssPqZNbajN8swSahRXuPh8VF86BKYkGImSf3vb6M+gMGqpWqS1b4r8IJ4p2eow58pS1U9
 gsuk9FGcDmnGyhJYpF5rgLRFUDz4uo93tL4LMdNjN/bmz985P5OIPiAIRWfz81BSAJ0icn1Uekp
 GrCIwG3ojgHykPbcxGsJ3kjQkSWURRq4Vcl/oIWvSUM8Q7u6RH3t7o2/eXgT+KrJQuIcRf7E0Oy
 6SXH/aP9jqmHAN+AEa6AZhrxDaZ2PYmzd+SLQIpNZJ2beYYlLZm29Ns4X6Da8MXFH/cYtHF4lkf
 /He2xuQLFqlZi9gXj+eoTHSaUD5ZgsPeSHYaoy0Gn5CUXPtjtUML8bCFgHsZTm4U8pkda4nyBBZ
 jC/GNDcWDVOAWi1N1NWho/pmDyiDLmca9wQufSiSMD+kcyeKLLjBn0SwLXx9m1cJ/Csk3CAGNUn
 xqI1bupCo4MFD5OKaTg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210072
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/17/2026 11:51 AM, Wang Yechao wrote:
> Probe for the SBI STA extension by searching for a one-reg id built
> from KVM_REG_RISCV_SBI_EXT and KVM_RISCV_SBI_EXT_STA in the register
> list returned by KVM, following the existing SBI DBCN pattern, and
> record the result in kvm_sbi_sta.supported.
> 
> This patch only adds capability detection; nothing consumes
> kvm_sbi_sta.supported yet. The register synchronization that uses it
> is added by a subsequent patch.
> 
> Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/kvm/kvm-cpu.c | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
> 
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index c085b22b23..8ab43432dd 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -473,6 +473,12 @@ static KVMCPUConfig kvm_sbi_dbcn = {
>                     KVM_REG_RISCV_SBI_EXT | KVM_RISCV_SBI_EXT_DBCN
>   };
>   
> +static KVMCPUConfig kvm_sbi_sta = {
> +    .name = "sbi_sta",
> +    .kvm_reg_id = KVM_REG_RISCV | KVM_REG_SIZE_U64 |
> +                  KVM_REG_RISCV_SBI_EXT | KVM_RISCV_SBI_EXT_STA
> +};
> +
>   static void kvm_riscv_update_cpu_cfg_isa_ext(RISCVCPU *cpu, CPUState *cs)
>   {
>       uint64_t id, reg;
> @@ -1233,6 +1239,19 @@ static void kvm_riscv_check_sbi_dbcn_support(RISCVCPU *cpu,
>       }
>   }
>   
> +static void kvm_riscv_check_sbi_sta_support(RISCVCPU *cpu,
> +                                            struct kvm_reg_list *reglist)
> +{
> +    struct kvm_reg_list *reg_search;
> +
> +    reg_search = bsearch(&kvm_sbi_sta.kvm_reg_id, reglist->reg, reglist->n,
> +                         sizeof(uint64_t), uint64_cmp);
> +
> +    if (reg_search) {
> +        kvm_sbi_sta.supported = true;
> +    }
> +}
> +
>   static void kvm_riscv_read_vlenb(RISCVCPU *cpu, KVMScratchCPU *kvmcpu,
>                                    struct kvm_reg_list *reglist)
>   {
> @@ -1365,6 +1384,7 @@ static void kvm_riscv_init_cfg(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
>       }
>   
>       kvm_riscv_check_sbi_dbcn_support(cpu, reglist);
> +    kvm_riscv_check_sbi_sta_support(cpu, reglist);
>       kvm_riscv_read_csr_cfg(reglist);
>   }
>   


