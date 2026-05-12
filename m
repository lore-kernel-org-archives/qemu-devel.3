Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01394CD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 11:24:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMlDN-00040w-Pp; Tue, 12 May 2026 07:23:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wMlDM-00040L-1z
 for qemu-devel@nongnu.org; Tue, 12 May 2026 07:23:52 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wMlDK-00087z-3s
 for qemu-devel@nongnu.org; Tue, 12 May 2026 07:23:51 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64CB6oiO2121537
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 11:23:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sw1L9OrRhHWMsyK/5qqSyeFD4tfSif8ciFyhCF5V4LI=; b=O4sCpTmXuksGNu39
 3eVHnwxG2tCbliLqQzxvvHMMIqcjfmmaLWcD6XXx5mj86IvGiu/dYpfP7T8iS+AX
 Tv5r41zmdCa3cgEWkmQyvXBghdzGZh/xrnCFmNSobCZ6mMw+CE6nVXnaReNfyp4w
 upHOSJndlw/cTTtp4CrDoadNBM6Ag/rAZuAvcd2zzE59z20JT8kVvIbpav4E2W16
 HB0nigziHiXvfgufKkSbh2l+j4NW5VXc84k1ort/3ix290bX5NbsxRDTuP54Nxf7
 fapRKL7JM7E8b15ba7Wm20opmua6WrpVIWpERRbaPfvGWQWKc1vwbJLchsLwSB1G
 LL0ckg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nv2ajtd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 11:23:47 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8b513f57611so25540546d6.2
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 04:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778585027; x=1779189827; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sw1L9OrRhHWMsyK/5qqSyeFD4tfSif8ciFyhCF5V4LI=;
 b=XG0NlBGGxZW7sm2laA8dE4ueIr/GLHYpwxOlhXwbVfUDD/SQVBpwWJvLsoaEi6OSxD
 XdhDAWoPmAgPKSD/ryplPy4eo7i/cDS0xVBOZ9EOqcx6CvHJfL34WRGEkZYu4MB1Yt6d
 j159YhMLzpXyp571DNi0UYGUiKaELjnv8bbfshjoV0HCzkHA4V35hfTR1egVDLgNi6B2
 DxNK/MwdiY1+tjRcRUaFE5rg1S8Y80PP6vIuYLxGIW1wSrrSISo+h+58s8+hPN3H5xfv
 uN0xSpSOGv20dFIw5y5xzP1ujd7NPBCilVYVl1N7c8rCFhidOBuN0qSgJk132tAMm4D/
 SLkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778585027; x=1779189827;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sw1L9OrRhHWMsyK/5qqSyeFD4tfSif8ciFyhCF5V4LI=;
 b=AA8XhN4J74R82oyxOPmBoDZyw/zbAW5V6EBNT9oPkyZVY7lCM0zH+ZimziVGilLapZ
 ySdfsEUYNDCA4x78/caBlahTqXRC1RipQl4RC64f0uSK+y9sbXLurwdzZKQPfaWoBjRJ
 VGH7MgUNVNBNhRCik0P03TGF0YUBeKxyp2YLZVptyu2CZcSV/yQoDCoceZYO/7KiSwNa
 msiLpWR//xnK1or8E8DdSujERG8mO7eq1SVuvyYba6Wl5Aw/R4PkYzxwc3MRH7q5pEJE
 u3iJq8UEebUnUSZyBfNujRi7qe+aqh907CM5GEbYhAwGkEer7KZPK8+NRnqSCVmM3g53
 72Uw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/h4x993eZ053LNy+vt4H0xkp6NCGZ+4cEwqdQ1qftGw+nrUeaFU9gZCJHx91Fi/H8tFvUH1cwEVXXx@nongnu.org
X-Gm-Message-State: AOJu0YwUi+IL/DKP3N69TgHq6KVDJpy6PgAVQgNOmhZ9pRYmB5EiPHv7
 cgsGnptsjcL/WeJLD5eA/yxbWKma0WuP+HysAWQe83FWNpPwSRw3oFEIg3kJBtKWGjnqJMZDvl6
 V/ExFPvdND2Q7A59uu0CwRNCSogA3qCGFcHPrSL4E7kEMR3iAt0pbeD3E+A==
X-Gm-Gg: Acq92OG5yUzrEZJB8YgBbgFcRista9D+L8foQVl/HTqwGLZ9G4vKifyXOPjhXQWecux
 KaifeLtLdQD3z/CQKA9ONJ8GFXDwh8UEN5SrnEBcl52TNFpmoZ8F2h0+nzSMNBsr6fa8TK8XtTa
 x6gX6+2p5bN2bT7YtZN8t2MN3uiMPWn1iDgCaHzYQ0DfFqCa5wyWhHTad0VtUU0MyfFaIESCGol
 8XMCZe9eerc7o94h2l1+T4paB0loCyD7dR0IbC/VnDi67k61krii0gYdBjexKYiw1WWVE0zkVWU
 8bZd7l9cogLKP7rabzLMRw2wwoIS2/JwDsIb+MAY7vSgVtTQiTg7JQkYVqaS2n82oiLk/HMQ89X
 f6CdIQuT6Q3FoulqHI7W3Fpxa0eu71CjPocnt/gT5FPucuLBPxHT0GiPLPMg=
X-Received: by 2002:a05:6214:8087:b0:8c2:b36d:4fc1 with SMTP id
 6a1803df08f44-8c2b36d5203mr172658836d6.14.1778585027007; 
 Tue, 12 May 2026 04:23:47 -0700 (PDT)
X-Received: by 2002:a05:6214:8087:b0:8c2:b36d:4fc1 with SMTP id
 6a1803df08f44-8c2b36d5203mr172657306d6.14.1778585025025; 
 Tue, 12 May 2026 04:23:45 -0700 (PDT)
Received: from [192.168.68.106] ([191.202.238.222])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8bf39c7e30bsm122385236d6.25.2026.05.12.04.23.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2026 04:23:44 -0700 (PDT)
Message-ID: <47e3e0b2-6c6c-45a5-944f-affa05cf9174@oss.qualcomm.com>
Date: Tue, 12 May 2026 08:23:41 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/riscv/kvm: add KVM support for Zicbop extension
To: Zongmin Zhou <min_halo@163.com>, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Zongmin Zhou <zhouzongmin@kylinos.cn>
References: <cover.1778551633.git.zhouzongmin@kylinos.cn>
 <bb6271546f870f3ee3cbeafdf0eb065925bb384d.1778551633.git.zhouzongmin@kylinos.cn>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <bb6271546f870f3ee3cbeafdf0eb065925bb384d.1778551633.git.zhouzongmin@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: cMPzPDa7WYkWfUg3u056HtfmMIcVBNwk
X-Authority-Analysis: v=2.4 cv=Mv9iLWae c=1 sm=1 tr=0 ts=6a030dc3 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=etEqFfc6qwXwpI8uT8rzbw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=eR8HKELFxlaAjunT1vAA:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: cMPzPDa7WYkWfUg3u056HtfmMIcVBNwk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDExNyBTYWx0ZWRfX5XNCdJQ5Hy0x
 IS990O4ZK7wBR3skhrSI+FaWtMlTpU/v/fq/4rtw2WuI828xQIjIGRkY/qUeJBA4Vfwn+CVV3Z2
 LfLVCadXXt0ov06GRyqs03Nzbnnz9Lr03Gf/i+7n1m3nqzvU3Mef+i0FGgTA3t6gwveMW8b8V+D
 M5CNzOUDB3rknQLWG8agcRIGY/DG6R1Ve+I3k1hYHiWn1GIiEc/3DNPsPwsXG3poAseFZP0ppV6
 LwFMt9urhE+8th//w+eqgb/qnD/HlJDoNUH/pxHkGXnkSvq6IqecKiZUOuM12YSF6lXQCT2igCf
 F6Bmea3LWq2EEidhslPq+lNzLKJHtbbNuTpc5lMhLERQa+hkhtduRrIxE9LpbIElb25RuXVhjtz
 +sjrMPcpRKuMZoWjvTHR4P4FfFTUrXPAW8OXyBzS/CW0DjyQwh2NybPNOgzAmm+dkmrr40KaDcB
 S/HEsu2UjeYbFOyA1aA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120117
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



On 5/11/2026 11:25 PM, Zongmin Zhou wrote:
> From: Zongmin Zhou <zhouzongmin@kylinos.cn>
> 
> When the Zicbop extension is available expose it to the KVM guest.
> Also read and validate cbop_blocksize from the host via KVM interface.
> 
> Signed-off-by: Zongmin Zhou <zhouzongmin@kylinos.cn>
> ---
>   target/riscv/kvm/kvm-cpu.c | 38 ++++++++++++++++++++++++++++++++++++--
>   1 file changed, 36 insertions(+), 2 deletions(-)
> 
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index b047ffa9c0..a46737f934 100644
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
> @@ -1114,6 +1121,10 @@ static void kvm_riscv_read_multiext_legacy(RISCVCPU *cpu,
>           kvm_riscv_read_cbomz_blksize(cpu, kvmcpu, &kvm_cbom_blocksize);
>       }
>   
> +    if (cpu->cfg.ext_zicbop) {
> +        kvm_riscv_read_cbomz_blksize(cpu, kvmcpu, &kvm_cbop_blocksize);
> +    }
> +

We don't need to add any new KVM regs/properties to kvm_riscv_read_multiext_legacy().
This is a legacy function aimed at kernels < 6.6 that doesn't support KVM_GET_REG_LIST.
There's no scenario where this function needs to read zicbop because
KVM_RISCV_ISA_EXT_ZICBOP didn't exist back then.

Patch LGTM otherwise.  Thanks,

Daniel


>       if (cpu->cfg.ext_zicboz) {
>           kvm_riscv_read_cbomz_blksize(cpu, kvmcpu, &kvm_cboz_blocksize);
>       }
> @@ -1293,6 +1304,10 @@ static void kvm_riscv_init_cfg(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
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
> @@ -2014,8 +2029,8 @@ void riscv_kvm_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
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
> @@ -2062,6 +2077,25 @@ void riscv_kvm_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
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


