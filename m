Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7C68CD37AC
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 21:00:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNGgw-0005U9-B6; Wed, 13 May 2026 17:00:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wNGgs-0005TO-Sn
 for qemu-devel@nongnu.org; Wed, 13 May 2026 17:00:26 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wNGgr-0003CB-1p
 for qemu-devel@nongnu.org; Wed, 13 May 2026 17:00:26 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64DJj4Dj3324691
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 21:00:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3xz8GluyAlEhB3bslZlSkBZnV4cilRlFgVB7B0yIKhU=; b=lnhp8B6eNb9qVuZx
 1ziKbzDqerXcWx5g7uvTskkAQASmCFd5Sl/pEer5feFnO4b6itz3wqJ8Ka/u2r3p
 Q3pO35QUhnfLfTliuJ7OJGCw1q5B+k2UhlZG/s965eaHYXqLGWJR3OX99Xogon7Y
 s1mxg0y3e+cp1iMEr2aKLXluAE1gNXMowS5ckar1uyhLNXmgX1YOxMer3ekiYsE0
 YFQYdc3n9nkJj4wkaABNMiOcK1Q2ISLuQnwBBxEIETudhJfHb4CjEyu1B1CMxS8B
 bmM6b0EvRigq8cr1HIdDG7bDCbrWKd7kaE1Kw088gRS6Sxa3pL5LE/stlYSOFPgm
 snpozQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4kvdbgk1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 21:00:23 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8b7e68098dcso171605426d6.3
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 14:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778706023; x=1779310823; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3xz8GluyAlEhB3bslZlSkBZnV4cilRlFgVB7B0yIKhU=;
 b=Z1e/CtUTPlUeEvBep+F6JcYdd82uRbqe5MTurZdP9+anLCX7M/cBPn1sz6xJJnK+a7
 T/5DoV3BVPNaSBuEHRVkbWqGQxk7wQHwvQHtzyo0yL25EutaDhjMBR9P6xwCZoVHmYl5
 22XhJXNfblwCPbrBGOWOvvh1tvnDS6RnZW9C204Dr3xKVlF35GJHNuivSRvxPEo70e3a
 ekQ04vdNdsmoNVtd4MnNLcf0vdgSZTx5qcfaFOYJyHaSjmN6hi4TywVjtb4EgY22p5Tk
 XFvKYRQpv5CrR5eA13P+XLTtQONNBRQVdfLQR3PZD5arLYDzETLqi7Y2FTHVK+pe4/fH
 rq0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778706023; x=1779310823;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3xz8GluyAlEhB3bslZlSkBZnV4cilRlFgVB7B0yIKhU=;
 b=pHb+lLOCkQ5kQ6HQvO1D9leCHaaNdjlCrpsosigVn69uSBFh4D3TsLtUH3tk0+beCH
 WGqQC5fnQhbZO3M3unBnhK8NysstVPDD3q3SY/7Dr+3AkXRJT6zAvEO9zyir+HWdAFk7
 NMNJPzzu5Q/p3jdOwj66ks9c1SoazKcMTmmjbfguuAnv0gsHt98WI6MWgPsW8y0dDWIM
 A6ANmGnyvfoXY3c1Icrx2BVuTyCWneEo+ntyE3A4cFU2Vv04R7WgkalaBTSPr8NdTgsd
 OGZYgFRUc0yri8y6kF/XjIe28RSbjr3Bzc130CKfi2CV3Jh3UjHgjKjkRveur+PFOV2P
 gVWw==
X-Gm-Message-State: AOJu0Yw/lgbmrXb25Zosjsn1+dHUs9B+U/w71ug7kAF1r4YRxNn2Fi6D
 56H2qPLxNR59qEyhBwX9t1xQx+7mQUHeT48v1H1mIdvQxaoqkuo4zevncwZofP+x8HJ2FrEuUHK
 iD/56J40JDu7SjMdzMKASiVrhpM529Wdqe3ewbeHRQOZGGp4rx7n3dMkASg==
X-Gm-Gg: Acq92OHSwuwHV15zqWkEPs6swqcmxMkucZxQRIVgkxqX8yvKABJF8tcShPWnoCQ/apL
 OCA/Z+8fZ6CgZsvXR3Bjp8PqRDw18WOlUpLiUo4q4xEFLvOEj04Hb5ogNawRSFLTWS4z0SO6GOY
 HySVF2c5GqSWOgiSiFnEHCI7tP/UWn/h+qaf4WDLbRw7ciJQINLUjoIzXw6GOBAhgmqBWXCFbng
 N4PNZRzsyDEHKuV1qO28hEeUrHUTNnhmWRYgVIpp9D3eb4b5Ms74Sasm6lxj8CvqbsF2e7vpnWT
 4U/TypycaaxRJAznM/ZbBd7nXCA/kMrXebw+RKQpeRwRHkP+iSSGVdY0gI4fCxHKwzRaRx7263F
 pKpYp0UGpqvd94b47VICoAgVeqSOiMcn1LzRDLQeDutDffKbCImArXfM3Nug=
X-Received: by 2002:a05:6214:238c:b0:8c4:edb4:a44a with SMTP id
 6a1803df08f44-8c7bb0cf615mr83953726d6.23.1778706021847; 
 Wed, 13 May 2026 14:00:21 -0700 (PDT)
X-Received: by 2002:a05:6214:238c:b0:8c4:edb4:a44a with SMTP id
 6a1803df08f44-8c7bb0cf615mr83950926d6.23.1778706020392; 
 Wed, 13 May 2026 14:00:20 -0700 (PDT)
Received: from [192.168.68.105] ([191.202.238.222])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8c9059ca0ffsm6724486d6.0.2026.05.13.14.00.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 May 2026 14:00:19 -0700 (PDT)
Message-ID: <a2321a69-80e6-4b97-9275-f4bfc45f4cd6@oss.qualcomm.com>
Date: Wed, 13 May 2026 18:00:17 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] target/riscv/kvm: add KVM support for Zicbop
 extension
To: Zongmin Zhou <min_halo@163.com>, alistair.francis@wdc.com,
 chao.liu.zevorn@gmail.com, liwei1518@gmail.com, palmer@dabbelt.com,
 zhiwei_liu@linux.alibaba.com
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Zongmin Zhou <zhouzongmin@kylinos.cn>
References: <cover.1778653159.git.zhouzongmin@kylinos.cn>
 <9e388aa9984ea9d3d0c85e1630c9195023938952.1778653159.git.zhouzongmin@kylinos.cn>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <9e388aa9984ea9d3d0c85e1630c9195023938952.1778653159.git.zhouzongmin@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: lpIuFWmU-0mnxhzLJbRiG9IfXmBkyu9U
X-Proofpoint-ORIG-GUID: lpIuFWmU-0mnxhzLJbRiG9IfXmBkyu9U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDIwNyBTYWx0ZWRfX2FW7Ipw7XQH6
 sSgZimu39xnSQjRaw8JGVBHNvAGzs8SbpLhz/nclxzqnMCJlPo8c4jwSDAdp7UGjrQvPZj+RpY3
 gy9buM3AkPJ7ie4k13xBiYx+5aYXQ+0rrVO3nglHAPKeZp14/PT4pdy+i83IDdcWWFATgniiq74
 BFUVWrE+Evww5XiDTGzVPQgQdEZI+v7b2qD5vzNBpli4qm4Xw5gLGDx3TKSnRsCqk/2F9TB27fh
 38LXFvleHHL1GJQYsUB3r/TA1U9dwyhfSY0LsOJAc0M8Y3xgcj5f0kjgDnYa5q87fEJd9NV+jGu
 KWunxB5QcBSAHuV+k/7Ih5m3xGIk0sOcWKvdC9u1ILw3cer2hFiEfSG2duEpUc+LxmyRkWPkRLr
 aKVGiEclBybCxWE6qp0GxHQCUVF24l/WqN+VS/H61CAuqv/HbnjdifZ+EnDp5xWJ+jQhgWSs5q9
 RLU181zKewheKWGbrwg==
X-Authority-Analysis: v=2.4 cv=Iu0utr/g c=1 sm=1 tr=0 ts=6a04e667 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=etEqFfc6qwXwpI8uT8rzbw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=mf25wqykKUA4s7fAKf4A:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0 impostorscore=0
 bulkscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130207
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 5/13/2026 4:02 AM, Zongmin Zhou wrote:
> From: Zongmin Zhou <zhouzongmin@kylinos.cn>
> 
> When the Zicbop extension is available expose it to the KVM guest.
> Also read and validate cbop_blocksize from the host via KVM interface.
> 
> Signed-off-by: Zongmin Zhou <zhouzongmin@kylinos.cn>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

> Changes in v2:
> - Removed Zicbop from legacy KVM extension reading path since
>    the extension did not exist in older kernels. (Daniel Henrique Barboza)
> 
>   target/riscv/kvm/kvm-cpu.c | 34 ++++++++++++++++++++++++++++++++--
>   1 file changed, 32 insertions(+), 2 deletions(-)
> 
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index b047ffa9c0..608495630f 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -293,6 +293,7 @@ static void kvm_cpu_csr_set_u64(RISCVCPU *cpu, KVMCPUConfig *csr_cfg,
>   
>   static KVMCPUConfig kvm_multi_ext_cfgs[] = {
>       KVM_EXT_CFG("zicbom", ext_zicbom, KVM_RISCV_ISA_EXT_ZICBOM),
> +    KVM_EXT_CFG("zicbop", ext_zicbop, KVM_RISCV_ISA_EXT_ZICBOP),
>       KVM_EXT_CFG("zicboz", ext_zicboz, KVM_RISCV_ISA_EXT_ZICBOZ),
>       KVM_EXT_CFG("ziccrse", ext_ziccrse, KVM_RISCV_ISA_EXT_ZICCRSE),
>       KVM_EXT_CFG("zicntr", ext_zicntr, KVM_RISCV_ISA_EXT_ZICNTR),
> @@ -439,6 +440,12 @@ static KVMCPUConfig kvm_cboz_blocksize = {
>       .kvm_reg_id = KVM_REG_RISCV_CONFIG_REG(zicboz_block_size)
>   };
>   
> +static KVMCPUConfig kvm_cbop_blocksize = {
> +    .name = "cbop_blocksize",
> +    .offset = CPU_CFG_OFFSET(cbop_blocksize),
> +    .kvm_reg_id = KVM_REG_RISCV_CONFIG_REG(zicbop_block_size)
> +};
> +
>   static KVMCPUConfig kvm_v_vlenb = {
>       .name = "vlenb",
>       .offset = CPU_CFG_OFFSET(vlenb),
> @@ -1293,6 +1300,10 @@ static void kvm_riscv_init_cfg(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
>           kvm_riscv_read_cbomz_blksize(cpu, kvmcpu, &kvm_cbom_blocksize);
>       }
>   
> +    if (cpu->cfg.ext_zicbop) {
> +        kvm_riscv_read_cbomz_blksize(cpu, kvmcpu, &kvm_cbop_blocksize);
> +    }
> +
>       if (cpu->cfg.ext_zicboz) {
>           kvm_riscv_read_cbomz_blksize(cpu, kvmcpu, &kvm_cboz_blocksize);
>       }
> @@ -2014,8 +2025,8 @@ void riscv_kvm_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
>       int ret;
>   
>       /* short-circuit without spinning the scratch CPU */
> -    if (!cpu->cfg.ext_zicbom && !cpu->cfg.ext_zicboz &&
> -        !riscv_has_ext(env, RVV)) {
> +    if (!cpu->cfg.ext_zicbom && !cpu->cfg.ext_zicbop &&
> +        !cpu->cfg.ext_zicboz && !riscv_has_ext(env, RVV)) {
>           return;
>       }
>   
> @@ -2062,6 +2073,25 @@ void riscv_kvm_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
>           }
>       }
>   
> +    if (cpu->cfg.ext_zicbop &&
> +        riscv_cpu_option_set(kvm_cbop_blocksize.name)) {
> +
> +        reg.id = KVM_RISCV_REG_ID_ULONG(KVM_REG_RISCV_CONFIG,
> +                                        kvm_cbop_blocksize.kvm_reg_id);
> +        reg.addr = (uint64_t)&val;
> +        ret = ioctl(kvmcpu.cpufd, KVM_GET_ONE_REG, &reg);
> +        if (ret != 0) {
> +            error_setg_errno(errp, errno, "Unable to read cbop_blocksize");
> +            return;
> +        }
> +
> +        if (cpu->cfg.cbop_blocksize != val) {
> +            error_setg(errp, "Unable to set cbop_blocksize to a different "
> +                       "value than the host (%lu)", val);
> +            return;
> +        }
> +    }
> +
>       /* Users are setting vlen, not vlenb */
>       if (riscv_has_ext(env, RVV) && riscv_cpu_option_set("vlen")) {
>           if (!kvm_v_vlenb.supported) {


