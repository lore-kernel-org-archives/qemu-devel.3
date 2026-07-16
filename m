Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5BC4C44515
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 17:49:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkQCg-0005ZK-0e; Thu, 16 Jul 2026 13:48:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wkQCc-0005Z2-9U
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 13:48:54 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wkQCZ-0005g8-47
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 13:48:54 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GGSqhu3301975
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 17:48:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 so15kSDDfM2d4TOWZC/pkg95UAujATPQLEeimXx42SQ=; b=pk9iBUPOyEM5e05+
 Mw+UaPT3s4dbVJ5ge1srv843+a3d3gAuThtaiYQ/1Tnlb+RJuOTK0kZf+j73Atom
 dSAKa8xGGZciYGmSkYBgQXzVBz49r/pO7I45o+Y9hdHVENNhgDE775ncDzNo/43w
 gp0u7eZ9bdL0Kr4DsECHPaHUeXOjWh2pBwuw1Lo0yRqT9MetzvNaJMMKXmI1b7Yp
 qw+fPIn+tijR88ksXmkU5DrU/Zp/lq6LlzYtfmO/8T1K0MMUZjjN7CmxeqmZE87H
 gp9D2NdPN98awZm2sAqQcuQkIx97m37eSUSkigEICyrB1jvMp+Iv6iNCSkULn2/s
 XmiV6A==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feuex2k7u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 17:48:49 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38c7e26ecabso3516301a91.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 10:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784224129; x=1784828929; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=so15kSDDfM2d4TOWZC/pkg95UAujATPQLEeimXx42SQ=;
 b=BiWCvZAStfliEKkr4dNjdr7LIE0indPl4uLAbV4aqtGFcTPD9YFV84v0A1qk7HQ2s2
 h3l+0f/77avBdSoCZKxSoL2zGVc9ekhTkJE0g2srPmK/x80rueqyYGKEMiNrYoa1vL6o
 XTOIchCObSJi7YDJQVpjWi0zi1sbrNwvidVxJFT/w+uvc+joeoe19v9AsBAsaxOwIyRy
 l5qfYV/wXV0B+wsr1nff3O06Onh5/2k43ayqUWkEqloiEPwHa9M8G/wN3bEWZIOxgMF7
 jLppwFGw2MgNCJuof9Zn1yk1P3tVYu1I+sfi3gl0qhUiSQjuliMh0xONFMkomSo4j75W
 3SZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784224129; x=1784828929;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=so15kSDDfM2d4TOWZC/pkg95UAujATPQLEeimXx42SQ=;
 b=LkU63jMYWOUG2AKWOaw8Hzr63hvSJPrNEv47qkMmmaa629HBJ+WhFBUKSMsnQhLz2B
 e3++WczgJUR68WRinJ4xgTM4Y4nvGXKbtHD1uN+pVN5ovHqeEKr5thJRoiUYNyjWQL3D
 ZvJe6Wnbe1QC1UO1skykXmXklBbDqvXaQx8kdA+cnrTcYGsr2zQcTHhby49bGkg9fkTS
 XrYmdQpsu75Icmnf3Lm2yxwAD044u/4mDUaxbmbKrfAG22aVSeHhxEuR1V6hAxzx2pAm
 //WrReyc1idcd0wRdVF/l60rEVXOcDTRrxhkhOcsy1GLahfQpO/jSuDrt0PSQln3I29O
 jp0w==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrt2/N7h1bVI3lgWpvUaVa2vnQi//D3r8TuUAI/noMu7lZOqWxT5+blos2xuwY7Z+W9borK0LyZOTIp@nongnu.org
X-Gm-Message-State: AOJu0YwmGHgfI8pFPKIjSf+Nsj6AnctdVkWBWzJ1Mwk2v4gH+DkTGR2Z
 IF7rBRCKR45NCRQug6BbMAS3iJLQ1EB5ry/MRP0hhlvxuDVgDBR7DR5skklPf4nIAQ+nR5SfFDr
 T1Gt+pcw2Gv/5Ayvb7VX/kH1xhHC3Inf6Zj9oxY9wOD6GMPBzdsuVZtbK2g==
X-Gm-Gg: AfdE7cm9RaJxCrBNru/MYx/yuESoMzqcNwD+OnybC6kmJFxr5StYe4jEotJb5OM6kI7
 xJipI54x/QBhDbAME5ntPND+coMh76VjRErzpvnXmnags4fFoaaH65QVMxM9kg6vdIr1lv5Z8xr
 gGhwAUUlrmUccLJpA7kKlOofB5b/73lGXm/QtXULKHS4mSQ6JSYZZYdOHRUREr+wpDNCRZG8t3Z
 631gnvGUYkt5ZxXYAcrR5Kr+C70YpLopNPhFQjxRcP97Z0IFVHlI9NHh7P/BsBmvpC1GVWtFFNk
 5KrqzTNpKzwCHoCG8CN9FLukLRVKvjjPciloEkQFa5IJJc4rPlXSovPI58+j1o4wJ+oP+6GCVf1
 sXFUMzupVnIyJIiU1NjMrpBvZIpUO1ThtybNlfA==
X-Received: by 2002:a17:90a:da8d:b0:38d:c834:2106 with SMTP id
 98e67ed59e1d1-38e4676ed6emr508022a91.28.1784224128421; 
 Thu, 16 Jul 2026 10:48:48 -0700 (PDT)
X-Received: by 2002:a17:90a:da8d:b0:38d:c834:2106 with SMTP id
 98e67ed59e1d1-38e4676ed6emr507989a91.28.1784224127785; 
 Thu, 16 Jul 2026 10:48:47 -0700 (PDT)
Received: from [192.168.68.105] ([152.234.123.183])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3140e6c09adsm14560803eec.20.2026.07.16.10.48.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jul 2026 10:48:47 -0700 (PDT)
Message-ID: <8b4f4583-63b0-4d0f-b349-a0177ff19318@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 14:48:43 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] hw/misc/k230_rmu: add Kendryte K230 Reset
 Management Unit model
To: jack wang <163wangjack@gmail.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
References: <20260709031237.21284-1-163wangjack@gmail.com>
 <20260709031237.21284-2-163wangjack@gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260709031237.21284-2-163wangjack@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=JeeMa0KV c=1 sm=1 tr=0 ts=6a591981 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=szoPuAicwqWYzOEwwuIrwA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=e57ZSKXAAAAA:20 a=pGLkceISAAAA:8 a=aVSNYSbkTACvUHdZQmAA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: gvsYJongJOknPtwWSgnzC1cDsPUQhDbw
X-Proofpoint-GUID: gvsYJongJOknPtwWSgnzC1cDsPUQhDbw
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE4MiBTYWx0ZWRfXzQ6B97ED6Tvk
 rxaaTadlsFRdfb77yXs5amHMLvE6Dzlx+e2aWCHq+y8YXMAslhNALm4RCkrlDXryoklfooATZzy
 LY21lpbRZXKG2NEaoUvMyohiuK9Qal4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE4MiBTYWx0ZWRfX5iBdHCGXj4bH
 KvbhhL7hy8Rb2602nNNZKriCJxDQzUynHP+sgfnTPhjBXvBqEzBOYLo777tGr8J+t94w4RT7duV
 n/IrN8mlrgHlUeRS+Svk/OS6c1zmTUXm9/XX7eKTCA8aOUo8MOJ7rKVSH6JyA5Mp0GW5/eT8MFe
 YNqNYNZjmml3/6fGlC2kBjJNF1yZ6+UL9k/D3AVtiwpN+fE4CDRiWnRswmocdfHJKgrYVDviLKO
 hJwlnYlDo8GhH19oW4czchSA7uYOim/eWTQcit/pYQuzqWOzPV5soi/tsCiXYcaOeU3q2PGIMRu
 2sWWSAVFaEs7pVI9233jgTKu+a8PCRrDFDfonWkZkIYqaM/wvxof6uOmz7NIh00945rk7Ldoo93
 nKGyOaXm4cRmmGu8gwAOyWak2DaNg01pUa5OHBwLMBnC2SrTgdHoDxDYf4JQJwtgSIzIwiepcMO
 wYkzw0+DP/n2sK/P+uQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_06,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160182
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

Hi,

On 7/9/2026 12:12 AM, jack wang wrote:
> From: Jack Wang <163wangjack@gmail.com>
> 
> Model the K230 Reset Management Unit (RMU / SYSCTL_RST) at 0x91101000.
> Its control registers gather the software-controllable reset lines of the
> SoC peripherals. The register semantics are modelled after the five reset
> types described by the Linux mainline driver drivers/reset/reset-k230.c:
> 
>    - CPU0/CPU1: high-half per-bit write-enable strobe plus a done bit (bit12)
>    - FLUSH:     the CPU register bit4, auto-cleared by hardware, no done bit
>    - HW_DONE:   no write-enable; a done bit is latched when the reset fires
>                 and acknowledged by software with write-1-to-clear
>    - SW_DONE:   plain read/write storage, no write-enable and no done bit
> 
> QEMU does not reset the target peripherals, so the model collapses the
> hardware reset latency to zero: writing a reset request bit latches the
> paired done bit and auto-clears the request bit in the same access, which
> lets the kernel's readl_poll_timeout() loops succeed on the first read.
> 
> A qtest exercises the reset defaults, write-enable gating, HW_DONE latch
> and write-1-to-clear, repeated resets, flush auto-clear and SW_DONE
> storage behaviour.


The qtest fails with this patch:

  29/352 qtest+qtest-riscv64 - qemu:qtest-riscv64/k230-rmu-test               ERROR            0.33s   killed by signal 6 SIGABRT


Error being thrown:

# starting QEMU: exec ./qemu-system-riscv64 -qtest unix:/tmp/qtest-3816689.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-3816689.qmp,id=char0 -object monitor-qmp,id=qmp0,chardev=char0 -display none -audio none -run-with exit-with-parent=on -machine k230  -accel qtest
ok 1 /riscv64/k230/rmu/reset_values
# starting QEMU: exec ./qemu-system-riscv64 -qtest unix:/tmp/qtest-3816689.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-3816689.qmp,id=char0 -object monitor-qmp,id=qmp0,chardev=char0 -display none -audio none -run-with exit-with-parent=on -machine k230  -accel qtest
**
ERROR:../tests/qtest/k230-rmu-test.c:50:test_cpu_write_enable: assertion failed (rd(qts, K230_RMU_CPU0_CTRL) == K230_RMU_CPU_DONE): (0x00000000 == 0x00001000)
not ok /riscv64/k230/rmu/cpu_we - ERROR:../tests/qtest/k230-rmu-test.c:50:test_cpu_write_enable: assertion failed (rd(qts, K230_RMU_CPU0_CTRL) == K230_RMU_CPU_DONE): (0x00000000 == 0x00001000)
Bail out!


If we apply patch 2/2 the qtest succeeds.  Which is good, but we aim for all
tests being green for all individual patches to ease our lives when bisecting
code.

You can either squash patch 2/2 into this one or move the new qtest to patch 2/2
where it'll pass.


The code LGTM aside from this bit:

> 
> Signed-off-by: Jack Wang <163wangjack@gmail.com>
> ---
>   hw/misc/Kconfig             |   3 +
>   hw/misc/k230_rmu.c          | 280 ++++++++++++++++++++++++++++++++++++
>   hw/misc/meson.build         |   1 +
>   hw/misc/trace-events        |   6 +
>   include/hw/misc/k230_rmu.h  |  76 ++++++++++
>   tests/qtest/k230-rmu-test.c | 125 ++++++++++++++++
>   tests/qtest/meson.build     |   3 +-
>   7 files changed, 493 insertions(+), 1 deletion(-)
>   create mode 100644 hw/misc/k230_rmu.c
>   create mode 100644 include/hw/misc/k230_rmu.h
>   create mode 100644 tests/qtest/k230-rmu-test.c
> 

[...]

> +static void k230_rmu_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->realize = k230_rmu_realize;
> +    device_class_set_legacy_reset(dc, k230_rmu_reset);


This is a deprecated API.  If you look at include/hw/core/qdev.h:


---
* device_class_set_legacy_reset(): set the DeviceClass::reset method
  * @dc: The device class
  * @dev_reset: the reset function
  *
  * This function sets the DeviceClass::reset method. This is widely
  * used in existing code, but new code should prefer to use the
  * Resettable API as documented in docs/devel/reset.rst.
---

I suggest reading docs/devel/reset.rst to understand which reset phases might
be applicable to this device.  Some devices implement just the phases.hold cb,
others implement enter and/or exit.  Seeing k230_rmu_reset() I think you can
get away with implementing it with just phases.hold but don't just take my word
for it.  Check out the docs and see what makes sense for this RMU.


Thanks,
Daniel


> +    dc->vmsd = &vmstate_k230_rmu;
> +    dc->desc = "K230 Reset Management Unit";
> +}
> +
> +static const TypeInfo k230_rmu_info = {
> +    .name          = TYPE_K230_RMU,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(K230RmuState),
> +    .class_init    = k230_rmu_class_init,
> +};
> +
> +static void k230_rmu_register_type(void)
> +{
> +    type_register_static(&k230_rmu_info);
> +}
> +type_init(k230_rmu_register_type)
> diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> index 23265f6035..5e1155723f 100644
> --- a/hw/misc/meson.build
> +++ b/hw/misc/meson.build
> @@ -111,6 +111,7 @@ system_ss.add(when: 'CONFIG_XLNX_VERSAL', if_true: files(
>   system_ss.add(when: 'CONFIG_XLNX_VERSAL_TRNG', if_true: files(
>     'xlnx-versal-trng.c',
>   ))
> +system_ss.add(when: 'CONFIG_K230_RMU', if_true: files('k230_rmu.c'))
>   system_ss.add(when: 'CONFIG_STM32_RCC', if_true: files('stm32_rcc.c'))
>   system_ss.add(when: 'CONFIG_STM32F2XX_SYSCFG', if_true: files('stm32f2xx_syscfg.c'))
>   system_ss.add(when: 'CONFIG_STM32F4XX_SYSCFG', if_true: files('stm32f4xx_syscfg.c'))
> diff --git a/hw/misc/trace-events b/hw/misc/trace-events
> index b88accc437..da0e32582e 100644
> --- a/hw/misc/trace-events
> +++ b/hw/misc/trace-events
> @@ -417,3 +417,9 @@ iommu_testdev_dma_read(uint64_t gva, uint32_t len) "gva=0x%" PRIx64 " len=%u"
>   iommu_testdev_dma_verify(uint32_t expected, uint32_t actual) "expected=0x%x actual=0x%x"
>   iommu_testdev_dma_result(uint32_t result) "DMA completed result=0x%x"
>   iommu_testdev_dma_armed(bool armed) "armed=%d"
> +
> +# k230_rmu.c
> +k230_rmu_read(uint64_t offset, uint32_t value) "K230 RMU read:  [0x%" PRIx64 "] -> 0x%08" PRIx32
> +k230_rmu_write(uint64_t offset, uint32_t value) "K230 RMU write: [0x%" PRIx64 "] <- 0x%08" PRIx32
> +k230_rmu_flush(uint64_t offset) "K230 RMU flush auto-clear at offset 0x%" PRIx64
> +k230_rmu_reset_device(void) "K230 RMU device reset"
> diff --git a/include/hw/misc/k230_rmu.h b/include/hw/misc/k230_rmu.h
> new file mode 100644
> index 0000000000..e6f5073c1e
> --- /dev/null
> +++ b/include/hw/misc/k230_rmu.h
> @@ -0,0 +1,76 @@
> +/*
> + * K230 Reset Management Unit (RMU / SYSCTL_RST)
> + *
> + * K230 Technical Reference Manual V0.3.1 (2024-11-18):
> + * https://github.com/revyos/external-docs/blob/master/K230/en-us/K230_Technical_Reference_Manual_V0.3.1_20241118.pdf
> + *
> + * Register semantics cross-checked against the Linux mainline driver
> + * drivers/reset/reset-k230.c (compatible "canaan,k230-rst").
> + *
> + * Copyright (c) 2026 Jack Wang <163wangjack@gmail.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_MISC_K230_RMU_H
> +#define HW_MISC_K230_RMU_H
> +
> +#include "qemu/bitops.h"
> +#include "hw/core/sysbus.h"
> +#include "qom/object.h"
> +
> +#define TYPE_K230_RMU "riscv.k230.rmu"
> +OBJECT_DECLARE_SIMPLE_TYPE(K230RmuState, K230_RMU)
> +
> +/* 1 KiB MMIO window, see K230_DEV_RMU in hw/riscv/k230.c. */
> +#define K230_RMU_MMIO_SIZE   0x1000
> +#define K230_RMU_NUM_REGS    (K230_RMU_MMIO_SIZE / 4)
> +
> +/* Control register offsets used by drivers/reset/reset-k230.c. */
> +#define K230_RMU_CPU0_CTRL     0x04
> +#define K230_RMU_CPU1_CTRL     0x0C
> +#define K230_RMU_AI_CTRL       0x14
> +#define K230_RMU_VPU_CTRL      0x1C
> +#define K230_RMU_PERI0_CTRL    0x20   /* SW_DONE bank: TIMERx, WDTx, MAILBOX   */
> +#define K230_RMU_PERI1_CTRL    0x24   /* SW_DONE bank: UARTx, I2Cx, GPIO       */
> +#define K230_RMU_HISYS_CTRL    0x2C
> +#define K230_RMU_SDIO_CTRL     0x34
> +#define K230_RMU_USB_CTRL      0x3C
> +#define K230_RMU_SPI_CTRL      0x44
> +#define K230_RMU_SEC_CTRL      0x4C
> +#define K230_RMU_DMA_CTRL      0x54
> +#define K230_RMU_DECOMP_CTRL   0x5C
> +#define K230_RMU_SRAM_CTRL     0x64   /* mixed: HW_DONE bits + SW_DONE bit1     */
> +#define K230_RMU_NONAI2D_CTRL  0x6C
> +#define K230_RMU_MCTL_CTRL     0x74
> +#define K230_RMU_ISP_CTRL      0x80   /* mixed: HW_DONE bits + SW_DONE bits     */
> +#define K230_RMU_DPU_CTRL      0x88
> +#define K230_RMU_DISP_CTRL     0x90
> +#define K230_RMU_GPU_CTRL      0x98
> +#define K230_RMU_AUDIO_CTRL    0xA4
> +#define K230_RMU_SPI2AXI_CTRL  0xA8   /* SW_DONE (active high)                  */
> +
> +/* Bit layout shared by the CPU0/CPU1 control registers. */
> +#define K230_RMU_CPU_RESET     BIT(0)    /* reset request, auto/soft cleared    */
> +#define K230_RMU_CPU_FLUSH     BIT(4)    /* L2 flush request, hw auto-clears     */
> +#define K230_RMU_CPU_DONE      BIT(12)   /* done bit, write-1-to-clear           */
> +
> +/* The high 16 bits are per-bit write-enable strobes (CPU0/CPU1 registers). */
> +#define K230_RMU_WE_SHIFT      16
> +
> +struct K230RmuState {
> +    /*< private >*/
> +    SysBusDevice parent_obj;
> +
> +    /*< public >*/
> +    MemoryRegion mmio;
> +
> +    /*
> +     * One 32-bit word per MMIO offset. Indexing by word offset keeps the
> +     * VMState description trivial. Reset requests auto-clear, so what
> +     * actually persists here is done bits and SW_DONE storage bits.
> +     */
> +    uint32_t regs[K230_RMU_NUM_REGS];
> +};
> +
> +#endif /* HW_MISC_K230_RMU_H */
> diff --git a/tests/qtest/k230-rmu-test.c b/tests/qtest/k230-rmu-test.c
> new file mode 100644
> index 0000000000..c2c862cd1d
> --- /dev/null
> +++ b/tests/qtest/k230-rmu-test.c
> @@ -0,0 +1,125 @@
> +/*
> + * QTest for the K230 Reset Management Unit.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +#include "qemu/osdep.h"
> +#include "qemu/bitops.h"
> +#include "libqtest.h"
> +#include "hw/misc/k230_rmu.h"
> +
> +#define K230_RMU_BASE 0x91101000ULL
> +
> +static inline uint32_t rd(QTestState *qts, uint64_t off)
> +{
> +    return qtest_readl(qts, K230_RMU_BASE + off);
> +}
> +static inline void wr(QTestState *qts, uint64_t off, uint32_t val)
> +{
> +    qtest_writel(qts, K230_RMU_BASE + off, val);
> +}
> +
> +/* Every known register reads back as 0 after reset. */
> +static void test_reset_values(void)
> +{
> +    QTestState *qts = qtest_init("-machine k230");
> +
> +    g_assert_cmphex(rd(qts, K230_RMU_CPU0_CTRL),  ==, 0);
> +    g_assert_cmphex(rd(qts, K230_RMU_AI_CTRL),    ==, 0);
> +    g_assert_cmphex(rd(qts, K230_RMU_HISYS_CTRL), ==, 0);
> +    g_assert_cmphex(rd(qts, K230_RMU_PERI0_CTRL), ==, 0);
> +
> +    qtest_quit(qts);
> +}
> +
> +/*
> + * CPU0: a low-half write without its strobe is ignored; with the strobe the
> + * reset request fires, latches done (bit12), and the request bit auto-clears.
> + */
> +static void test_cpu_write_enable(void)
> +{
> +    QTestState *qts = qtest_init("-machine k230");
> +
> +    /* No strobe: the low-half write is dropped, reads back as 0. */
> +    wr(qts, K230_RMU_CPU0_CTRL, K230_RMU_CPU_RESET);
> +    g_assert_cmphex(rd(qts, K230_RMU_CPU0_CTRL), ==, 0);
> +
> +    /* With strobe (bit16): request bit0 takes effect, done (bit12) latches. */
> +    wr(qts, K230_RMU_CPU0_CTRL,
> +       K230_RMU_CPU_RESET | (K230_RMU_CPU_RESET << K230_RMU_WE_SHIFT));
> +    g_assert_cmphex(rd(qts, K230_RMU_CPU0_CTRL), ==, K230_RMU_CPU_DONE);
> +
> +    qtest_quit(qts);
> +}
> +
> +/*
> + * HW_DONE: no write-enable needed. Writing HISYS request bit0 latches its
> + * done bit (bit4); writing 1 to the done bit clears it.
> + */
> +static void test_hw_done_and_w1c(void)
> +{
> +    QTestState *qts = qtest_init("-machine k230");
> +    uint32_t v;
> +
> +    wr(qts, K230_RMU_HISYS_CTRL, BIT(0));      /* no strobe */
> +    v = rd(qts, K230_RMU_HISYS_CTRL);
> +    g_assert_cmphex(v & BIT(4), ==, BIT(4));   /* done latched */
> +    g_assert_cmphex(v & BIT(0), ==, 0);        /* request bit auto-cleared */
> +
> +    wr(qts, K230_RMU_HISYS_CTRL, BIT(4));      /* write-1-to-clear */
> +    g_assert_cmphex(rd(qts, K230_RMU_HISYS_CTRL) & BIT(4), ==, 0);
> +
> +    qtest_quit(qts);
> +}
> +
> +/* Repeated resets: one HW_DONE line can be triggered again and again. */
> +static void test_repeat_reset(void)
> +{
> +    QTestState *qts = qtest_init("-machine k230");
> +
> +    for (int i = 0; i < 3; i++) {
> +        wr(qts, K230_RMU_AI_CTRL, BIT(0));                 /* request */
> +        g_assert_cmphex(rd(qts, K230_RMU_AI_CTRL) & BIT(31), ==, BIT(31));
> +        wr(qts, K230_RMU_AI_CTRL, BIT(31));                /* W1C done */
> +        g_assert_cmphex(rd(qts, K230_RMU_AI_CTRL) & BIT(31), ==, 0);
> +    }
> +
> +    qtest_quit(qts);
> +}
> +
> +/* FLUSH: the CPU0 bit4 flush request is auto-cleared, reads back as 0. */
> +static void test_flush_auto_clear(void)
> +{
> +    QTestState *qts = qtest_init("-machine k230");
> +
> +    wr(qts, K230_RMU_CPU0_CTRL,
> +       K230_RMU_CPU_FLUSH | (K230_RMU_CPU_FLUSH << K230_RMU_WE_SHIFT));
> +    g_assert_cmphex(rd(qts, K230_RMU_CPU0_CTRL) & K230_RMU_CPU_FLUSH, ==, 0);
> +
> +    qtest_quit(qts);
> +}
> +
> +/* SW_DONE: the PERI0 low half is plain storage, no strobe and no done bit. */
> +static void test_sw_done_storage(void)
> +{
> +    QTestState *qts = qtest_init("-machine k230");
> +
> +    wr(qts, K230_RMU_PERI0_CTRL, BIT(12) | BIT(13));   /* WDT0 / WDT1 reset bits */
> +    g_assert_cmphex(rd(qts, K230_RMU_PERI0_CTRL), ==, (BIT(12) | BIT(13)));
> +
> +    qtest_quit(qts);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    g_test_init(&argc, &argv, NULL);
> +
> +    qtest_add_func("/k230/rmu/reset_values",   test_reset_values);
> +    qtest_add_func("/k230/rmu/cpu_we",         test_cpu_write_enable);
> +    qtest_add_func("/k230/rmu/hw_done_w1c",    test_hw_done_and_w1c);
> +    qtest_add_func("/k230/rmu/repeat_reset",   test_repeat_reset);
> +    qtest_add_func("/k230/rmu/flush",          test_flush_auto_clear);
> +    qtest_add_func("/k230/rmu/sw_done",        test_sw_done_storage);
> +
> +    return g_test_run();
> +}
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 822e0bd286..70c9a53454 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -294,7 +294,8 @@ qtests_riscv64 = ['riscv-csr-test'] + \
>     (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') and
>      config_all_devices.has_key('CONFIG_RISCV_IOMMU') ?
>      ['iommu-riscv-test'] : []) + \
> -  (config_all_devices.has_key('CONFIG_K230') ? ['k230-wdt-test'] : [])
> +  (config_all_devices.has_key('CONFIG_K230') ? ['k230-wdt-test',
> +                                                'k230-rmu-test'] : [])
>   
>   qtests_hexagon = ['boot-serial-test']
>   


