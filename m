Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B300CC5AC7A
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 17:05:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsNzx-0002CG-3a; Fri, 07 Aug 2026 13:04:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wsNzv-0002Bd-SM
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 13:04:43 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wsNzt-00086k-OP
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 13:04:43 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 677GOX3s1807698
 for <qemu-devel@nongnu.org>; Fri, 7 Aug 2026 17:04:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /K49fWhUG5C7CDZ7wHyE2cppMAagHt5oCBaoFqVeF/g=; b=fWS2qMuCF/9SzME9
 34n/qOXTsbuKhBmdLm33T1DFhcq0ATFCvjUqGiq9Xo5BI8IqjncTsPJFvF38J2hh
 CdfZkBN2Yp5aOP1eRFWSZdeqPaiakVRs/WQB47v7b3fabzs1QLfH9eKx2x2dryrg
 VkBTr1XOcQj5xdCriJF1reuWLw+Yd8Ac7PCEtzfv0cr8kPuXYdhMJcFDv09rxaYS
 DwvliobEo76B/V3y0ILKa60fxDKk3ERB6gyLYrR4o7TpitboXCAJEvjfmtStgA+o
 x/z3DT7SMLN8RQ1rf3uuVHC5Z2EajFPrfjUEesWx5tuDzCDa3eFC/S26aO0YpVsP
 Mm9edw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwgewgu2b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 17:04:39 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92ac0a54110so388271885a.2
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 10:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786122279; x=1786727079; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/K49fWhUG5C7CDZ7wHyE2cppMAagHt5oCBaoFqVeF/g=;
 b=jdeUbl+4C/Logqzs4lppHNQqrmTw7wazeijBa/QX6sCeCRJa8EwamdtFrlxUW9X10w
 /IrYi3k4gJ0UsHi6CvMvosdx7FwS/YbI+mljPXoh9tUMAN0lvdhzh1mfd0xiiiNkVbj7
 D4biUsnm1BRYBbZqg9Dp3lyzPZJ0+RyWKhT53ZA3CcS7MPOXAlRiCIZEMeQqTzk+WOfI
 RAI3mXaMrazVG+aMHQLjDjD3zgaLf/5J6aCTE6JghiPeoZmzS1MxFg1DbfBgjznGx8Qn
 7lKV4If70u5171mlwCz73fzXq8uKuYkXCnzCgNTnO022debWQijyuZyOazG2VsNC56Ja
 Xdog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786122279; x=1786727079;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/K49fWhUG5C7CDZ7wHyE2cppMAagHt5oCBaoFqVeF/g=;
 b=YwAwiTKbOncJyHjK/tiKyvN/7LyD71QVKxoqjgLCNlz4S0c4SFx3ZiOLaHAVR96BI3
 ISqe5UpB9Qs12eyQg8/ZjluXu18cy+kYZJutlldzq+WffxJBHc2PVj5QHFEueyISkRg8
 qzID2E7R0YJn0K6kbGjZ9RjVrDwyeVpU87dw58aGG/fSzj2ae3BZTSibZ+7epY8M983D
 GDDtr7dugqArhSMFWqe/WYVhgWOni+bY/uuQ29Pc6r/fmMc3Hsl+HYghhOD/qQocyQ0d
 EIZcH02UWw3V9Tb8d/qCjxYTW7RrwozALBOnillPpxJ0L1am0fB8VPYB/+qCezqdq1mQ
 NrVQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RowGK4f88b/sVRJuCbwBlRlrd7g97Uu3GtpGRyt3qtHESeK91J8dgQ8vh3cdMoJZcwh5vSAQiiz2WPY@nongnu.org
X-Gm-Message-State: AOJu0YyoO4wIDMo2JMbd2MsyTdxEYPSaWzrkslCmA63ZylW3b/JJiffC
 mC69XsRQpILynGAaL3u0ZvBZEX8+8/TS2UW4wRfElkI5a9/LMb0fpmtBXCCC+yHFymXdTqv0wTE
 KS0OWnc/W9ak3VmYattKfsaIaUIOJRerYfpmJmhTsLIjCz8wG1eAZe1sTNg==
X-Gm-Gg: AR+sD10kBkzHJ8eUZK8OnSyxIeYKS+HDH8itfjQFJg2iRhOId1mVSOqLifH0ehUvi2Q
 vD8Wv156KV5KRdFVHIgzBpnkEOIMNz9xKuHrUZtjSA35Ej3527ajCRI9obG2X3Qh7uZSopj6/kR
 DD5C3I78TXPTMnqdThDHcov8WidgoOXWC5uahKBULRl0KKxDw8EgZt9LPUZerOkCZhtYNKqpPwK
 cLibAK2XHm6S5wwfdCmN5hjdXz6IK1IkkhGt/Lb8yjZqjDL8JP1J7oJwSfqGxU0pKmgIjoPl7MY
 3vXhiDpiGSm5Rbfi4ov3SO2ix95yXDLNI3ETyKB6ncPcFPAlPiUNddFalLAZeX3Xda/tKjtm9cs
 vMwwuihLO53EsMDEVoohhUZ7i0jECAhus2Tr8
X-Received: by 2002:a05:620a:254f:b0:92e:e3eb:de54 with SMTP id
 af79cd13be357-93648ff04cbmr2543585785a.11.1786122278793; 
 Fri, 07 Aug 2026 10:04:38 -0700 (PDT)
X-Received: by 2002:a05:620a:254f:b0:92e:e3eb:de54 with SMTP id
 af79cd13be357-93648ff04cbmr2543572185a.11.1786122278168; 
 Fri, 07 Aug 2026 10:04:38 -0700 (PDT)
Received: from [192.168.68.104] ([187.11.154.152])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9366e229848sm190889585a.24.2026.08.07.10.04.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Aug 2026 10:04:37 -0700 (PDT)
Message-ID: <6eb6dbac-17a6-4acb-b65f-58f7f9ec5344@oss.qualcomm.com>
Date: Fri, 7 Aug 2026 14:04:34 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 1/2] target/riscv/kvm: Synchronize privilege mode
To: Xie Bo <xb@ultrarisc.com>, qemu-devel@nongnu.org
Cc: ajones@ventanamicro.com, qemu-riscv@nongnu.org, alistair23@gmail.com,
 pbonzini@redhat.com, anup@brainfault.org, alistair.francis@wdc.com,
 rkrcmar@ventanamicro.com, palmer@dabbelt.com
References: <20250915070811.3422578-1-xb@ultrarisc.com>
 <20260730051926.7322-1-xb@ultrarisc.com>
 <20260730051926.7322-2-xb@ultrarisc.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260730051926.7322-2-xb@ultrarisc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDEzMyBTYWx0ZWRfX6YPUeMpQ6nuZ
 EAjqBSN1xyeYJ/Gv7YNs/Ul4NCclTGzHrdpfefv43sB0cTK6YUzTvd7/gphw9Xf8sF/zqkKEFKQ
 TXsV7rEg+TkNIqfrjDs/Vfy69ijNqLw=
X-Authority-Analysis: v=2.4 cv=N5cZ0W9B c=1 sm=1 tr=0 ts=6a761027 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=iMfxv9gflPUPBcmW7/Gq5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=Lx1EvxgrAAAA:8 a=EUspDBNiAAAA:8 a=_1-xPEPxSuS7R4OLlL0A:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=ZFi1QaP_tuf8dODdgmj-:22
X-Proofpoint-GUID: aA50dkTCTvEZ1ZiShW-fAqK7RzhW8ARl
X-Proofpoint-ORIG-GUID: aA50dkTCTvEZ1ZiShW-fAqK7RzhW8ARl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDEzMyBTYWx0ZWRfX8EyCSCs6REOa
 FNB1zBu7/YLIRuLljAWI+fj5g4pbMql+yHqzXa6LA7C1dgVnD201mE8GfxjB9WMba9AKwEN3Et0
 pQR5asYfvYMzXBmlxiNJob6j6BLfSg1dU6MKGRi+B7/5G3g4TpagjaQ9SRwLRDvsS+DtzqEdM73
 +IKcbqfbWPhEsgYzew7td3gmfX27TcCSotMFJx0bi8D/sEuC15SEQnXiuTmiIKBMdcC5EQpZC5T
 jeNjcU/KEcrjEoPdn3Mrc4QilBOX09DJ6fqiz1xWowGC9R+wcZWCwEMCnYH7aAPFVMNVzj8wk8C
 ihbf4tUfwGaqpiUHsM/HmoB4qUTz+zsXQHVfpWpJbkHh7Pf6URVnXLvUkY0lvZIpHXE3ASpjU9m
 KvdZ5coMEC95U5W0X7CuyQruC/CuX+fRCYbvk4Z++yQZcPTxnNVtfxqefQf/u8a2ywNKfJUsnSV
 4AMu9m+iHj3oyuGbdmA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608070133
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



On 7/30/2026 2:19 AM, Xie Bo wrote:
> The KVM core register synchronization currently omits the vCPU privilege
> mode. As a result, env.priv can be stale when the migration stream is saved
> and the destination can restore the vCPU in the wrong mode.
> 
> Read and write the KVM core mode register together with the other core
> registers. The generic RISC-V CPU VMState already carries env.priv, so no
> migration format change is required.
> 
> Signed-off-by: Xie Bo <xb@ultrarisc.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/kvm/kvm-cpu.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index 495cb42dc8..8218832fbe 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -603,6 +603,12 @@ static int kvm_riscv_get_regs_core(CPUState *cs)
>       }
>       env->pc = reg;
>   
> +    ret = kvm_get_one_reg(cs, RISCV_CORE_REG(mode), &reg);
> +    if (ret) {
> +        return ret;
> +    }
> +    env->priv = reg;
> +
>       for (i = 1; i < 32; i++) {
>           uint64_t id = KVM_RISCV_REG_ID_ULONG(KVM_REG_RISCV_CORE, i);
>           ret = kvm_get_one_reg(cs, id, &reg);
> @@ -628,6 +634,12 @@ static int kvm_riscv_put_regs_core(CPUState *cs)
>           return ret;
>       }
>   
> +    reg = env->priv;
> +    ret = kvm_set_one_reg(cs, RISCV_CORE_REG(mode), &reg);
> +    if (ret) {
> +        return ret;
> +    }
> +
>       for (i = 1; i < 32; i++) {
>           uint64_t id = KVM_RISCV_REG_ID_ULONG(KVM_REG_RISCV_CORE, i);
>           reg = env->gpr[i];


