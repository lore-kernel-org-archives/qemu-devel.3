Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92129606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 19:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AetqJz5A;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CZQVCS5G
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQUwn-0001gE-UD; Mon, 09 Nov 2026 14:22:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQUwe-0001cn-TF
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 14:22:21 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQUwb-0000SC-Jk
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 14:22:20 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9HHH14899581
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 19:22:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 O9syk0AvUDEnDTN4kiC+XB9P9DSwk5O2315WH4doMUw=; b=AetqJz5Avc4mv27i
 A/5zK4UYJxVpZrMmrg7WwIyrXAoBbVnQuYK+stdwcX8MbDltAyKun2uF0Oq/degn
 66+30Uy6zfg8ZBhXRCK/XNsIYF7i1v+DMb8zhLRycj8qe9N8oPtWP5fdPBtxdsza
 8jdM+I1MeK2mJpiLukg/ygEGgx7DpUkbyB1yOwMVUl0lklQxWmHLDLSJvCUuoRN/
 PPmgjhEXO6Uy0ats08vG5c9RfItB4Md4D4ubxywzisySn0C6+su9y4KU+1FZYDgl
 h2e9oiPrDq9unWDsR6xyxh0dKrNogNT/WgOZ7DsJ4lIcgAGmHkt7cjPV/JAxNEn9
 gqEhpA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hu6x2k7w7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 19:22:15 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f559420f3so135892085a.0
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 11:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794252135; x=1794856935; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=O9syk0AvUDEnDTN4kiC+XB9P9DSwk5O2315WH4doMUw=;
 b=CZQVCS5GlxROmLd5AW1XFSelmF2Qr1g/31lYntvE0CjVHJHQeL/OniVjZ7tPZ7qz92
 gzSvG/wrbcsoZUr30/VBLCILE1LK3MjXri7slboa5aNWOgq8LqUTF4h/lH8N0pFcSFjL
 8YzgWQ0BbGJCjsnb7FKbL4cteBkIGblQ4HlnhP9EEM6J+OMAWhtxUH7RKFiXZLc329Wo
 3Qn1++d4RBLcUlGd7qu4glOSX44bh5gkI1hCDZ+21jn2oXYsZVOgbdd+3ST1aCQUGdbC
 iKic2UpumNtS+LDrvaRJDITGpF9GAwlMIN5LGa7nV1R2jIJwt77cUeDzOJ8YjR+25SD6
 USFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794252135; x=1794856935;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=O9syk0AvUDEnDTN4kiC+XB9P9DSwk5O2315WH4doMUw=;
 b=mfg83BTOSmjwv4dUDgWJ7GAMeE/9d3PRa/5kRtMCrP+tjObdIUvNP+LzJOElklNEMw
 IBFQm2/LaBTYSPwBm94HhkrRSV7XEa63/b1u242UbbQ9x8SqKFPc5VFjqO4WGJAL6UmL
 iJNAfGjPH4kB5mEFheVRmHaL4TJA0y+vAn/K2qD/FKQ/YNjyc1/WnRGIkyWgoFbZACRG
 mj9gwRjiDqbMO3o8QLMQ1fmehN+A9+h7ieqnXV/yuso/Ad437LrC3srOauEGly5GcdeH
 /F7zQeDjvbMRLXCrcFJnoV4UBvqPBmTR10HXulAmJfTc18gT7KvhsYHAqcluzmL4tFiV
 sTog==
X-Forwarded-Encrypted: i=1;
 AL+hErFB8TuexDSmLISuwIEFAnjtJwCNQsbmzMC1dGdzYRYnMNWLsd2tTcCMkzV+BjI4kkx3Xj20cjPzHoPm@nongnu.org
X-Gm-Message-State: APuU4Z9axm4NUMiqpb1CqhugJ9tEN8QZvrJ/0nvn9I5nQtRLS5h65BIl
 ubRT+DrnZSwaGo46Zs3P34GByPdkC52G4sH3G2aFgLw8VGbfANMiXzkZJivzuUcHSrZbiqOfhSe
 B/PGk8+U5qVzZRbEM9VRg/9JKI8bgOWrdkjH7F5U77KTY5cEzgRWNwy7+3g==
X-Gm-Gg: AYBFou02RBOtep5cPJTiO8FsNiwE44BF/WLeJI+GgF1uu+99daZArTspZfmSYCIzJRB
 QUolsw53Y0pHstDc0FVN2Gcx/mw93DNfN4NTwo39CveqIpfu91O7yC5fu7tFdzAXvKYFAvySYpE
 G6IDViJbZHeBm3GisXrmaNINHSebMqhNuJ+Z0Z0mkbR3RlbvSmFJIABxZ3ZsUajhemP8rfM/BUj
 ZbvKCb+ROXAX+/dgQjmw50+oZdd3Qb+lqZg1AAwSQOcjzZbil2twWmhvAWQjCeCk6mVr3vu9bgZ
 IgdHIkzZf36OYIIonrRc+EeFp9vvWOQ7Ch29zD7blvxUz1mD0MWGs+tcFNPctLJ9XgzDAoBh5ql
 mRSpA8A8Z0CG43yEgY4OHuXZm/oCXeNWmaGDVCOKQwdZp5nrxQwIv7fJ846idgYDiItX0CiA6yk
 wD9sTZAFuq
X-Received: by 2002:a05:620a:608c:b0:93f:2236:a61 with SMTP id
 af79cd13be357-9479f337d9emr67853085a.61.1794252135040; 
 Mon, 09 Nov 2026 11:22:15 -0800 (PST)
X-Received: by 2002:a05:620a:608c:b0:93f:2236:a61 with SMTP id
 af79cd13be357-9479f337d9emr67848185a.61.1794252134462; 
 Mon, 09 Nov 2026 11:22:14 -0800 (PST)
Received: from [192.168.68.100] ([152.234.124.231])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9479e7a8348sm44095685a.26.2026.11.09.11.22.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 11:22:13 -0800 (PST)
Message-ID: <888f4611-ea49-43a3-aa74-d8ecd51f7bab@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 16:22:11 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/intc/aplic: Fix msicfgaddrH in split mode
To: BillXiang <xiangwencheng@lanxincomputing.com>, palmer@dabbelt.com
Cc: alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org, anup@brainfault.org
References: <20261104025308.1920474-1-xiangwencheng@lanxincomputing.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261104025308.1920474-1-xiangwencheng@lanxincomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=TMjQ2Fla c=1 sm=1 tr=0 ts=6af21d67 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=8elE1k/PHQNyZ14TNTodlQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=4BKX8IsyAAAA:8 a=EUspDBNiAAAA:8 a=vufM146OCBCyE1-xP1QA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=bflBWynC2lygM3eL1Mvi:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA3NyBTYWx0ZWRfX5RrY2pINORHL
 sCpYk2Ll6anmBTDKMrwDBV4H3KwLJiskZekJxiEebkmHj/47lzKHlO33uoNrFzrXqIU27GyfC7d
 O0PVcwlYQE0OQJMuFPmhAca1Hs+WtdCsJElxp2ahbGG1XORqGFR8dcKP/HAUiopUSuNewq5Q0CE
 +DPD47JZ7nx1iBJs/Yw2Il/Phv4164Fk/hY+nBtnjOAZ2BP7CjOUqITr0C2gJA7I5piN9qE3BxJ
 L6HMB8qNWOAZprq+raMxYeYjNKOHRGvv6rrZDvXr5fKlmo7YkaFPWKLLos475ajAW4IuvLiU1bn
 CMDtunG1QHZHQ4tUJzwVM+wv7CdKiiwYeC638B/o3OUM5e5DoTNK6j1QNQeTsMPuBU+cu4IgrCC
 KtM+pyJJB3IaJc67zPcFZtVQjjZjOfae5RhMfZ2wdZN7LQoysco9f/33w+JQdi3P1l6N3A0XFr8
 0A6eSx6CqN5ZSWR2GNQ==
X-Proofpoint-GUID: H96vjLh5JRfeeY8W2jOsyE_CRhpWat2T
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA3NyBTYWx0ZWRfX5n3C2Qk//dc8
 UV+CvWL2EXVibsl0q1YMj5zikA/e0VeSZHMvdIOcAE/upOsvonNBcWlrUA2Njd/AAMGbGPwovSi
 vahL+ZRBAfAP+ijlYNziUxo5e2RYCEY=
X-Proofpoint-ORIG-GUID: H96vjLh5JRfeeY8W2jOsyE_CRhpWat2T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090077
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/3/2026 11:53 PM, BillXiang wrote:
> Add hart_bits and guest_bits to msicfgaddrH in KVM irqchip
> split mode.
> Also remove the redundant left shift when loading
> kvm_msicfgaddrH in riscv_aplic_msi_send().
> 
> Rationale:
> static void riscv_aplic_msi_send(RISCVAPLICState *aplic,
>                                    uint32_t hart_idx, uint32_t guest_idx,
>                                    uint32_t eiid)
> {
>       uint64_t addr;
>       MemTxResult result;
>       RISCVAPLICState *aplic_m;
>       uint32_t lhxs, lhxw, hhxs, hhxw, group_idx, msicfgaddr, msicfgaddrH;
> 
>       ...
> 
>       if (aplic->kvm_splitmode) {
>           msicfgaddr = aplic->kvm_msicfgaddr;
> 1.        msicfgaddrH = ((uint64_t)aplic->kvm_msicfgaddrH << 32);
>       }
>       ...
> 
>       lhxs = (msicfgaddrH >> APLIC_xMSICFGADDRH_LHXS_SHIFT) &
>               APLIC_xMSICFGADDRH_LHXS_MASK;
>       lhxw = (msicfgaddrH >> APLIC_xMSICFGADDRH_LHXW_SHIFT) &
>               APLIC_xMSICFGADDRH_LHXW_MASK;
>       hhxs = (msicfgaddrH >> APLIC_xMSICFGADDRH_HHXS_SHIFT) &
>               APLIC_xMSICFGADDRH_HHXS_MASK;
>       hhxw = (msicfgaddrH >> APLIC_xMSICFGADDRH_HHXW_SHIFT) &
>               APLIC_xMSICFGADDRH_HHXW_MASK;
>       ...
> 
>       group_idx = hart_idx >> lhxw;
> 
>       addr = msicfgaddr;
> 2.    addr |= ((uint64_t)(msicfgaddrH & APLIC_xMSICFGADDRH_BAPPN_MASK))
> << 32;
>       addr |= ((uint64_t)(group_idx &
> APLIC_xMSICFGADDR_PPN_HHX_MASK(hhxw))) <<
>                APLIC_xMSICFGADDR_PPN_HHX_SHIFT(hhxs);
> 3.    addr |= ((uint64_t)(hart_idx &
> APLIC_xMSICFGADDR_PPN_LHX_MASK(lhxw))) <<
>                APLIC_xMSICFGADDR_PPN_LHX_SHIFT(lhxs);
> 4.    addr |= (uint64_t)(guest_idx & APLIC_xMSICFGADDR_PPN_HART(lhxs));
>       addr <<= APLIC_xMSICFGADDR_PPN_SHIFT;
>       ...
> }
> 
> Since msicfgaddrH is left-shifted at (2), the left shift at (1) is
> redundant.
> 
> At (3) and (4), hart_idx and guest_idx are masked/shifted using lhxw and
> lhxs, which are extracted from the LHXW/LHXS fields of msicfgaddrH.
> However, riscv_aplic_set_kvm_msicfgaddr() did not program the LHXW/LHXS
> fields into kvm_msicfgaddrH, so lhxs/lhxw always read as zero, and the
> hart/guest idxs were never encoded into the MSI address. Fix this by
> programming hart_bits (LHXW) and guest_bits (LHXS) into kvm_msicfgaddrH
> in riscv_aplic_set_kvm_msicfgaddr().
> 
> Signed-off-by: BillXiang <xiangwencheng@lanxincomputing.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

> Changes in v2:
> - Add rationale.
> ---
>   hw/intc/riscv_aplic.c         | 13 +++++++++----
>   hw/riscv/aia.c                |  6 +++++-
>   include/hw/intc/riscv_aplic.h |  3 ++-
>   3 files changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
> index 03a0852b8b..2b618e73df 100644
> --- a/hw/intc/riscv_aplic.c
> +++ b/hw/intc/riscv_aplic.c
> @@ -182,7 +182,8 @@ bool riscv_use_emulated_aplic(bool msimode)
>       return kvm_kernel_irqchip_split();
>   }
>   
> -void riscv_aplic_set_kvm_msicfgaddr(RISCVAPLICState *aplic, hwaddr addr)
> +void riscv_aplic_set_kvm_msicfgaddr(RISCVAPLICState *aplic, hwaddr addr,
> +                                    uint32_t hart_bits, uint32_t guest_bits)
>   {
>       if (!kvm_enabled()) {
>           return;
> @@ -191,8 +192,12 @@ void riscv_aplic_set_kvm_msicfgaddr(RISCVAPLICState *aplic, hwaddr addr)
>       if (riscv_use_emulated_aplic(aplic->msimode)) {
>           addr >>= APLIC_xMSICFGADDR_PPN_SHIFT;
>           aplic->kvm_msicfgaddr = extract64(addr, 0, 32);
> -        aplic->kvm_msicfgaddrH = extract64(addr, 32, 32) &
> -                                 APLIC_MMSICFGADDRH_VALID_MASK;
> +        aplic->kvm_msicfgaddrH =
> +            ((hart_bits & APLIC_xMSICFGADDRH_LHXW_MASK) <<
> +             APLIC_xMSICFGADDRH_LHXW_SHIFT) |
> +            ((guest_bits & APLIC_xMSICFGADDRH_LHXS_MASK) <<
> +             APLIC_xMSICFGADDRH_LHXS_SHIFT) |
> +            (extract64(addr, 32, 32) & APLIC_xMSICFGADDRH_BAPPN_MASK);
>       }
>   }
>   
> @@ -404,7 +409,7 @@ static void riscv_aplic_msi_send(RISCVAPLICState *aplic,
>   
>       if (aplic->kvm_splitmode) {
>           msicfgaddr = aplic->kvm_msicfgaddr;
> -        msicfgaddrH = ((uint64_t)aplic->kvm_msicfgaddrH << 32);
> +        msicfgaddrH = aplic->kvm_msicfgaddrH;
>       } else {
>           msicfgaddr = aplic_m->mmsicfgaddr;
>           msicfgaddrH = aplic_m->mmsicfgaddrH;
> diff --git a/hw/riscv/aia.c b/hw/riscv/aia.c
> index 56fc064533..bd608bd7a6 100644
> --- a/hw/riscv/aia.c
> +++ b/hw/riscv/aia.c
> @@ -38,6 +38,7 @@ DeviceState *riscv_create_aia(MemoryRegion *container,
>   {
>       int i;
>       hwaddr addr = 0;
> +    uint32_t hart_bits, guest_bits;
>       DeviceState *aplic_s_dev = NULL;
>       DeviceState *aplic_m_dev = NULL;
>   
> @@ -93,7 +94,10 @@ DeviceState *riscv_create_aia(MemoryRegion *container,
>                                    msimode, false, aplic_m_dev);
>   
>       if (kvm_enabled() && msimode) {
> -        riscv_aplic_set_kvm_msicfgaddr(RISCV_APLIC(aplic_s_dev), addr);
> +        hart_bits = imsic_num_bits(hart_count);
> +        guest_bits = imsic_num_bits(aia_guests + 1);
> +        riscv_aplic_set_kvm_msicfgaddr(RISCV_APLIC(aplic_s_dev), addr,
> +                                    hart_bits, guest_bits);
>       }
>   
>       return kvm_enabled() ? aplic_s_dev : aplic_m_dev;
> diff --git a/include/hw/intc/riscv_aplic.h b/include/hw/intc/riscv_aplic.h
> index 62d2b33ade..d3ee2e537a 100644
> --- a/include/hw/intc/riscv_aplic.h
> +++ b/include/hw/intc/riscv_aplic.h
> @@ -78,7 +78,8 @@ struct RISCVAPLICState {
>   void riscv_aplic_add_child(DeviceState *parent, DeviceState *child);
>   bool riscv_is_kvm_aia_aplic_imsic(bool msimode);
>   bool riscv_use_emulated_aplic(bool msimode);
> -void riscv_aplic_set_kvm_msicfgaddr(RISCVAPLICState *aplic, hwaddr addr);
> +void riscv_aplic_set_kvm_msicfgaddr(RISCVAPLICState *aplic, hwaddr addr,
> +                                    uint32_t hart_bits, uint32_t guest_bits);
>   
>   DeviceState *riscv_aplic_create(MemoryRegion *container,
>       hwaddr addr, hwaddr size, uint32_t hartid_base, uint32_t num_harts,


