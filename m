Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A73F3C54FDF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 07:24:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpL7c-0005oi-7E; Thu, 30 Jul 2026 03:24:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wpL7L-0005a1-5R
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 03:24:00 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wpL7H-0001kF-At
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 03:23:46 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66U6hcT6282081
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 07:23:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UMIKaZZ1fe4UCcsrg6mPXjQDqG10CcEO3NMyq9qbpSo=; b=MRC1rAhcOej5nOiQ
 RAlDfdB83bgwFV8esCaeE6daduNCNP7nWWE/as0HUxB8Oemx1vm07A72DThEY6+p
 Dfm4Z64/Su1RTkENTSMCai38TkgQJlckNUcOZpqcZrGf7o5f7hAorkEKpmkluX3f
 F22QkAcTPMCeG5iD/SNST8Ot9KbDs9HxfcMSVFoJ/hRJo69dthFquEva1nu7GefR
 Uto6HMTyzgRpR+7mfnCnsjp0PKmDLUIrI+HxML6u1vImqdYv2hH3/Wg9Jc7odEcI
 sD5akI0QdD3MSjjxR1fhKhsU5CpfF7I7GEXr8r+cBglw+5A7btE3rld/hqow13Vl
 JA6myA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr1kk85vc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 07:23:40 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8eeba1d9e47so22121826d6.2
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 00:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785396220; x=1786001020; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=UMIKaZZ1fe4UCcsrg6mPXjQDqG10CcEO3NMyq9qbpSo=;
 b=Ci5RIvETXX7s8QkZ3S8St0k9Y+0TnG1Z+jgodqigpsvLJ4EELTNG+65qDqQ/vd2dC/
 9NdeDOVR5UyMJ3JnzDJSbeLRoEUFTprOFA7PPNPeMwf1tQpxtzKcX1AX21vjuiIcOxGz
 kuW8ouSzMiBxa/iN79pXvB3H1l234OQdLHQ2WrixTSDmuCcxSbM8d7uzU3J3OAVK6Aku
 gOjkXfuAMFFl+BJYGOK4qGnnoL5QNfOgTM0o3bSIM1okkyt6sroX00kt+U7ptmFADYTW
 Fel+X89DW369JGrSqsUgVQoXMCs1SvLlanDeJIy4dtVUCX874xfaMU+pgZ6nvKjYXMxG
 oEyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785396220; x=1786001020;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=UMIKaZZ1fe4UCcsrg6mPXjQDqG10CcEO3NMyq9qbpSo=;
 b=FRJr7RYuwsUSB6CAEzJMIsfT4Nc+qdtYkT/hpWHjcn5kUJHxbh0jQERu/BxIzh1Pbm
 icHrTKoGVjl6EorAM9DC29LMHFxseyDm8ftoJo74AES5UOxuzLYnNAdcoFJDBIAa4kTD
 9xOfpnEnUNDM68/IDH2vOO55A8HzHvgaFKz0vQZf4xCsoS+Al0ZovUE5UukpQhh2zTxn
 waPMWyn7zsgMguiC72ehboExr5hWkC7LijnGgabRCXnMgSrVCFMfoYnyFySsvkx7etoy
 yPXG2XLlmwbupsde+4vje7ZcXEric9Hryz4az2cD5kqU154tdGZHSoqJva2eUjjoS1o+
 WBvA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoYsLz4RSqwBR+6ve/jwC3aCwphagRKRBKz1W9wPT3DplLoOZjKKqehWio5nQwywZwC8MB5ZpebiCBb@nongnu.org
X-Gm-Message-State: AOJu0Yw9WrlJDL3GOz+oz0AhbvQVDQSn7UV67bJ2gRSR8ka+/wq/Izk1
 W0XTTZ/ezd2t2tPTtNOmwpQpFw0WwJ88Z1nUNMXiPsVZf7gsl+KctcUtK9Jnka/TOJ/h91jfXO4
 SXwIWe2MlE3qxpbmith9RQxtzt0XOvO0kAjbHgt0R1FijB08Lk8/pG31ZPQ==
X-Gm-Gg: AR+sD11/0oh28sPAzLHNoib/XL9N2/xwIC07EL3cbRDXjJS65jV2Sa63hsaOonbbDGi
 rkbiXjdAVsPGgL1aFDTIyfbauDq1yYSwnpW7r3odn9vLWyYkLG+IiKWwkwIm5PAFrmJ2X/B6mdb
 Us9kUqPd3Tc5fPTJdFXFQXC5Wf8UhfuuoplnIUHC7Il/1qDUAiASeCIPlGjWuJWpvz67XpJWNuK
 wPusxZ9e1REIe7aFm5A19bomvXtfYMESmcwySG6nTYg/lTgRU+B+9nFOA+87AOxrnRiP2FqIl1s
 CfZyllLfkzc4+ypHnIVL+RUTm9AQxoZsSNoPF6rxrzwPqmZwUa1kMc5v2OIm06YvrsCWKg3yvxQ
 i1m1rRG/wxX6oF5StNrPIXQDmsVU+hn98GQJx6Diu1x2rHstzBow=
X-Received: by 2002:a05:622a:4d89:b0:51c:b6d:740b with SMTP id
 d75a77b69052e-52b384b4370mr16360961cf.34.1785396220267; 
 Thu, 30 Jul 2026 00:23:40 -0700 (PDT)
X-Received: by 2002:a05:622a:4d89:b0:51c:b6d:740b with SMTP id
 d75a77b69052e-52b384b4370mr16360811cf.34.1785396219758; 
 Thu, 30 Jul 2026 00:23:39 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-498011feca8sm37418975e9.8.2026.07.30.00.23.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jul 2026 00:23:38 -0700 (PDT)
Message-ID: <a68a21d7-8604-4413-ba7a-1d4ad02d2727@oss.qualcomm.com>
Date: Thu, 30 Jul 2026 09:23:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 01/20] hw/intc/arm_gicv3: Fix ARM_GICV3 dependency for KVM
 / WHPX
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260728123127.1711653-1-peter.maydell@linaro.org>
 <20260728123127.1711653-2-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260728123127.1711653-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=P90KQCAu c=1 sm=1 tr=0 ts=6a6afbfc cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=NHHqadiiJ61TLE7mF8oA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: BAfuEkxeYWAiQbdqtmgklE3LSKOnwuye
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA1MSBTYWx0ZWRfX68lI9U4QmpF0
 4cHXTWqg8lwulJJxOqyL6WK1Tjct/yH+nAN9boTtwea7b6TwV6jIfhNp7odcUOBaepKQwwAd9SG
 VcMcNoPAm4Stsq5/lpGRr+GgReTKZas=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA1MSBTYWx0ZWRfXx1SzNWDu6mjf
 fHsNsZIQgGVhwyXv/8c6w5QcaSzfKyYXNNn9T48g1ONweKQk8tVvXMkcJ5ekQR1/a7kg7zyZ7b8
 vDHFajMa4nI7faS9A6JEhwqefe72eUqlo5DscIuwWdPiOWWLaBdNotVEMR796lHY0wLLTs77oaX
 Dg7NZB9wa65luzr3H1fZpDOV/63m5Q060Uo2xSLSrr4LixZ0VzikmqlGasUlz7jtPEiJHIZLncb
 6UUBmZVIkBY2wahUAFcKZ6Q5Nf0O/fYufKH9MHUU6FSJjGtpVdXEMl+5x1C/AybLdGXhycx6dsQ
 IpfaE2G3vdggxb4oOLDvJ19YgeNqPZvk2sCchuGmtrl1F1b8FErcXNRaBT6Ph4/BBVmq9M9GNcS
 bIO8ZTkngW6Qy22fy8/0lmdwJ9Or3OXHWGvA/PFJdkZe8Sccc+/ZN7yfBosCIZvGjtOvz2MDr9X
 O+EXmJIMzpnuJFViLcA==
X-Proofpoint-GUID: BAfuEkxeYWAiQbdqtmgklE3LSKOnwuye
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_02,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300051
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 28/7/26 14:31, Peter Maydell wrote:
> From: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> 
> KVM and WHPX GICv3 implementations call gicv3_init_irqs_and_mmio()
> which is defined in arm_gicv3_common.c, itself build when ARM_GIC
> is selected. Both KVM and WHPX are conditional on ARM_GICV3,
> itself selecting ARM_GIC. Only build the ARM_GICV3 accelerator
> variants when ARM_GICV3 is selected.
> 
>   $ git grep -w gicv3_init_irqs_and_mmio
>   hw/intc/arm_gicv3_common.c:314:void gicv3_init_irqs_and_mmio(GICv3State *s,
>   hw/intc/arm_gicv3.c:450:    gicv3_init_irqs_and_mmio(s, gicv3_set_irq, gic_ops);
>   hw/intc/arm_gicv3_hvf.c:710:    gicv3_init_irqs_and_mmio(s, hvf_gicv3_set_irq, NULL);
>   hw/intc/arm_gicv3_kvm.c:822:    gicv3_init_irqs_and_mmio(s, kvm_arm_gicv3_set_irq, NULL);
>   hw/intc/arm_gicv3_whpx.c:186:    gicv3_init_irqs_and_mmio(s, whpx_gicv3_set_irq, NULL);
> 
> Fixes: a7bf30342e6 ("hw/intc: Initial implementation of vGICv3")
> Fixes: e4c95f78a47 ("hw, target, accel: whpx: change apic_in_platform to kernel_irqchip")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Message-id: 20260721122135.6288-2-philmd@oss.qualcomm.com
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/intc/meson.build | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/intc/meson.build b/hw/intc/meson.build
> index fac2d228f9b..377de78bb41 100644
> --- a/hw/intc/meson.build
> +++ b/hw/intc/meson.build
> @@ -45,10 +45,10 @@ specific_ss.add(when: 'CONFIG_APIC', if_true: files('apic.c', 'apic_common.c'))
>   arm_common_ss.add(when: 'CONFIG_ARM_GIC', if_true: files('arm_gicv3_cpuif_common.c'))
>   arm_common_ss.add(when: 'CONFIG_ARM_GICV3', if_true: files('arm_gicv3_cpuif.c'))
>   specific_ss.add(when: 'CONFIG_ARM_GIC_KVM', if_true: files('arm_gic_kvm.c'))
> -specific_ss.add(when: ['CONFIG_WHPX', 'TARGET_AARCH64'], if_true: files('arm_gicv3_whpx.c'))
> +specific_ss.add(when: ['CONFIG_WHPX', 'CONFIG_ARM_GICV3'], if_true: files('arm_gicv3_whpx.c'))
>   specific_ss.add(when: ['CONFIG_HVF', 'CONFIG_ARM_GICV3'], if_true: files('arm_gicv3_hvf.c'))
>   stub_ss.add(files('arm_gicv3_hvf_stub.c'))
> -specific_ss.add(when: ['CONFIG_ARM_GIC_KVM', 'TARGET_AARCH64'], if_true: files('arm_gicv3_kvm.c', 'arm_gicv3_its_kvm.c'))
> +specific_ss.add(when: ['CONFIG_ARM_GIC_KVM', 'CONFIG_ARM_GICV3'], if_true: files('arm_gicv3_kvm.c', 'arm_gicv3_its_kvm.c'))
>   arm_common_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('armv7m_nvic.c'))
>   specific_ss.add(when: 'CONFIG_GRLIB', if_true: files('grlib_irqmp.c'))
>   specific_ss.add(when: 'CONFIG_IOAPIC', if_true: files('ioapic.c'))

I'm afraid I didn't post the final full version, so this patch
lacks:

-- >8 --
diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig
index 636d00b7e88..1fec78f3bf1 100644
--- a/hw/intc/Kconfig
+++ b/hw/intc/Kconfig
@@ -23,7 +23,7 @@ config APIC

  config ARM_GIC
      bool
-    select ARM_GICV3 if TCG
+    select ARM_GICV3 if TCG || HVF || WHPX
      select ARM_GIC_KVM if KVM
      select MSI_NONBROKEN

---

Because now we are getting i.e. on macOS:

qemu-system-aarch64: unknown type 'hvf-arm-gicv3'

I apologize and will post a patch...

