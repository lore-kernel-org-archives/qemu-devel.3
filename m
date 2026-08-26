Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79DACC5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 17:17:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzHFL-0006Pr-Rv; Wed, 26 Aug 2026 13:17:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzHFH-0006OY-CT
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 13:17:03 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzHFE-0008K7-W1
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 13:17:03 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QGuhrs2548605
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 17:16:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Tcgd9/KQi8HXXCH2Boxe4SOW3xZn848yrkNm1heB+ww=; b=LAavTr0KoGtoLUUa
 yfzvN7MZu0Kx88aJQiuYMV5s8cQBpjvp3Qq7Dan9USQ1r+vbVf3wYmLUiGfPJ35o
 JmbtTFR35GoVsY0jL5cBCT/ZmYn0jAHkYRMS1qqDISvb6qD7usgdtQ3WSOooKszy
 2Ciwo3Ll5gbDGPwGCh3f6zU8L/BZcV9ZBAyWs0pZwbu5ttjLID3mLvkkAAKYbMrN
 o6YtQntqeqknrvidCG+IkoLjHi0rq2OCP3IoVp/AWQ5gspudkRXVD+QMhNmXXTkf
 NdcZ6jBIF0tQdrAhogkWJ7ryfaKECARRlvkX+7x1c9GG5BFWaqLVNJZrLqZoO7nC
 d9qZDw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9uq1tcbv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 17:16:58 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-52cd0374265so21327881cf.1
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 10:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787764618; x=1788369418; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Tcgd9/KQi8HXXCH2Boxe4SOW3xZn848yrkNm1heB+ww=;
 b=CC8YvnWkb5Q4qNYGDWKfQKTxP7LxRm3jItxzPKJe5YEeOAlp4OLo029aX4uM/Bdt00
 moOYQu9WYQjvSZyO11LsBSdvhwjnrEeVi9v51J+YmFeoERrMxuQAGh0Y/VxiKJc7Zb2z
 3w0Jn6g4omx57HQZ8R6ZKO6eAisTOvEpF/Czg5oqKgC8WlzLN+do2i/BhPNuqrpOCuYh
 566JJnQILKFXHYhDRSS1FjEqAOU3EA8ElayUkp7n8TZTcqzO7yhlRLFx1QXijj9f9kfl
 DbhA6cYYtz5myK4D3R3jzjtVPB2p5jV2p6xr2JeNc+tjaDFgV05UbuIYWdOW1nWGPpcM
 dSNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787764618; x=1788369418;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Tcgd9/KQi8HXXCH2Boxe4SOW3xZn848yrkNm1heB+ww=;
 b=UfHu6Gv4JQmfBd/HlGkUSg5hUi0nw+wAqZXnj2UR0WXLOG5edenc5ntItCNKSzg1AP
 ueHRqUdFLZeroYC0WzNWwxTX9HHSPzz6ZVnhOfYI9SbRod4xTPSXgZ5SW7KDtL0gGRp9
 X9XrNfp9rzWq640KfVKamLHCIsobIOvn8tCJpmtGW29SnICD1cFVQJa9MmCuBK0bDe+1
 G/vQ2mVkQLo4f5nKeQpS1WCv/RDsNZLux6XRi4mAai8aM6r4aMSHUafIEClJMH4Vyl1W
 6dK2rCcY2WQ/6lMa5xu7BC/cT8iieXV4/R9ThHsfuwKLgGwRSft6aFKmnTlBoLLwAzlb
 7k2g==
X-Forwarded-Encrypted: i=1;
 AHgh+RoZUdRtj5CLO1hMoqaJAXwHARXGgL2kiwwR85cR4zKIDBgtImfFUayii1escQM82l7FooCrxg2i3Xn6@nongnu.org
X-Gm-Message-State: AFuF++nAeOUAiE45jruNkezw/V07XICeTcuNrRdXTsAxDtlHNmItoCMt
 Xnl3BayfhldnkNHlTMNylH4JvrbteE8B0o7WuluDsuMc3Pv3mNoc5nTKZvsmUMrl1UsqMpgdD2b
 pEdnKCajux3haDZpP3itM4ZFrYjBvSN0+56nK2K1mnoUrtn2VT2bDnpM/NxgXbTtbhg==
X-Gm-Gg: AR+sD13Geqq587+9sVl9v5+Hg7nEuL24LHDd2y8yStgEwT6X71VCNvrWFqdKwjiZN3p
 Hotk4Bcw6qx9dPG9X0olRR+aC1grENLAIN3Bp8NIooi9khvo1EBzJxoAhdE1SvY5cu36omCb6GF
 4uZoTcmcLky8Zpxz9Ky/fV1RaxMliCmNV8MByOoLoPhYf+Ap/eu+BKPTuxB2g9+ypPQLBnPFJW6
 ZeljJOgXrMaDNET37z7QZ7f1QBGDRAcfoLbre/3iV28dZXfgBrtBwGkbScEK0/3nOaaxVezciWd
 Jot/7f567FuCiPiFolPboqGlPk9aHKUymvDspFwKTpt1STuAZX5D5uAW20hH8or9iX+LbGFrVw7
 HnNfYs7TgjWkfwDkTgQARErTajc3A7mV2VeMuCtLRo/I=
X-Received: by 2002:a05:622a:58cb:b0:51b:60f1:689a with SMTP id
 d75a77b69052e-52e422db063mr99383801cf.7.1787764617780; 
 Wed, 26 Aug 2026 10:16:57 -0700 (PDT)
X-Received: by 2002:a05:622a:58cb:b0:51b:60f1:689a with SMTP id
 d75a77b69052e-52e422db063mr99382561cf.7.1787764617087; 
 Wed, 26 Aug 2026 10:16:57 -0700 (PDT)
Received: from [10.254.188.74] (134.171.88.92.rev.sfr.net. [92.88.171.134])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a9e96bdsm436939866b.55.2026.08.26.10.16.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 10:16:56 -0700 (PDT)
Message-ID: <524dfcb8-155d-4a29-a759-41e3891183f0@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 19:16:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/13] hw/riscv/device-common, virt.c: add
 gpex_pcie_init()
Content-Language: en-US
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>
References: <20260826164814.44335-1-daniel.barboza@oss.qualcomm.com>
 <20260826164814.44335-13-daniel.barboza@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260826164814.44335-13-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: xxvw_xljy0rga-FOwbs_Ktg4JYJI-7gi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE0NCBTYWx0ZWRfX3t/xh2/KbhQZ
 flYwOElB2NZm9l7L46az/xRAs9nBn2t5EQVq85UWs5uSQ2/fbmTinCUiKFxfliN3eQWnyWJ0Kq6
 gJdp/+9hxfTCYP6OG2BqGyrUmXTW8kABKkkZJ62q/OwEAqek66dzP2U7tx7JLq2J2SfRq8Eov0+
 wgPQuhoAzQsfWuGK+nIuW9iFMsGN2mWiKAmpyDv08+mcpXvcQO8Nml2YXZrvUeAbGtOJh+n7kM8
 kZBrH9d/QngXqJvkxZQ5coV9hHT9YVFoLnmPoqYM2aSmKFtBNJqxJwucFX0Xeypx6aj5a/KJ1ZZ
 ZuXNOjLmTw1nFNR6ynw0is/CG53g2dRkF22hFDpsr2zY5HA8pZuwop333s47ZA0FCMDQy2Yhldk
 h6H7BHqSI5Y8XVjWKtj1SGhMKgwmYJyZjblu3hkRu7NsK3UQGW+3QXFcKNB/IqqHU0WBGsTPnHX
 VUfh/CxYwv5yKe6wo7g==
X-Authority-Analysis: v=2.4 cv=Y77IdBeN c=1 sm=1 tr=0 ts=6a8f1f8a cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=o1isufRNksZXpKP+aqnsag==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=Md5pTmsaoyhSHvOzhqMA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: xxvw_xljy0rga-FOwbs_Ktg4JYJI-7gi
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE0NCBTYWx0ZWRfX9PnZIdLuXc+e
 V0MdS2grM+FGm90sGiuExEjpXqOK4/JGOeKQkqEakVxTljaH5ssVGnebow648QA8AJnj3HgQcjn
 0kZFLDAtbk7fLVIPqdnIMAMaNwZmsnM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_05,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260144
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 26/8/26 18:48, Daniel Henrique Barboza wrote:
> The GPEX_HOST initialization in 'virt' can be moved to device-common.c
> and be re-used later for other boards, namely the future
> 'riscv-server-ref' emulation.
> 
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> ---
>   hw/riscv/device-common.c         | 76 +++++++++++++++++++++++++++++++
>   hw/riscv/virt.c                  | 77 ++------------------------------
>   include/hw/riscv/device-common.h |  7 +++
>   3 files changed, 87 insertions(+), 73 deletions(-)


> diff --git a/include/hw/riscv/device-common.h b/include/hw/riscv/device-common.h
> index 1cdb8ab5cc..77760e082c 100644
> --- a/include/hw/riscv/device-common.h
> +++ b/include/hw/riscv/device-common.h
> @@ -22,4 +22,11 @@ PFlashCFI01 *riscv_flash_create(Object *parent, const char *name,
>                                   int flash_sector_size);
>   void riscv_init_flash_map(PFlashCFI01 *flash, hwaddr base, hwaddr size,
>                             MemoryRegion *sysmem, int flash_sector_size);
> +DeviceState *gpex_pcie_init(MemoryRegion *sys_mem,

'riscv_' prefix please.

> +                            DeviceState *irqchip,
> +                            const MemMapEntry *pcie_ecam_mem,
> +                            const MemMapEntry *pcie_mmio_mem,
> +                            const MemMapEntry *high_pcie_mmio_mem,
> +                            const MemMapEntry *pcie_pio_mem,
> +                            int pcie_irq);
>   #endif


