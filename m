Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16B40C982E6
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 13:51:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8eQg-0000h7-QO; Mon, 21 Sep 2026 09:51:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x8eQT-0000fZ-ED
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 09:51:23 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x8eQP-0004aC-83
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 09:51:20 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LDollu1982611
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 13:51:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xGZCkUtaYFcoJk2o1TLez+CKrQoIlL0zIGYY8o070WY=; b=Uw6FAu8b7mqbL0PF
 OO9+0bUho5oF34f4cj3DzVxLLrSoOnoeHKQPOvbVAIFVN4doMpQggE39W61pxFyk
 P55/g0jqgknc3kX0NG+5KO2UV7n6GwjQUhOhAznUpNafcbcnEpzch9ZDP+VFqXHC
 jCudnXPdSUlptWOgEcRDnN3RqFrn9cv2wUClpNNSIJFE0o58OB2QqAI6Ze9D7sH2
 cYLrADyockkc836ixQYDJQCq7O/pcK5yGx99m/5IQLqw4hWs8+cl2FP2la+W5igr
 SPImNZSFOkw3xCUoYIAcB0760IrvPXS3bMFsoQIhlt7Yd4oExNH6EMJ9EIXwUBED
 u+XwJA==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtysw1jnm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 13:51:15 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-5c93c294214so1048593e0c.0
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 06:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789998675; x=1790603475; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=xGZCkUtaYFcoJk2o1TLez+CKrQoIlL0zIGYY8o070WY=;
 b=Oo3Ydc7qmRQs9UapRBvotGAWarWIYhvt9pK569d7MXmF7fWZck87SANMWRYqJR862Q
 K2/DA+eyhRN1n+eFi28BweHp5BZX1p95AxZ9hE0PrWjVmSeG4Pl+Iu7jGiXlTM5HfzKs
 e2La6nkHtsZTIxAIv3zDxAIVpw7Ul0vcCHLYf6Fk2Z4cugeHtHQXCiSD1Q1UhB6DwsuC
 f91vpy8RP/X19fPcsrI2BeWk2OCgX7pH3fPrL2oogya5dHIOB+irMICAVORPNwgIRD5Z
 vJtc1CJrwaMyj4TXR6v3DALW5i9e/Jf47OMbDvb3mDLSWN5ak1CAg4qhabbVaSrdSLnq
 U3Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789998675; x=1790603475;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xGZCkUtaYFcoJk2o1TLez+CKrQoIlL0zIGYY8o070WY=;
 b=CILotWtdlFKXL3EMhERQmu+QHWBh1bAAi92Hqkx6Pq1ydIYNRg7MXNwnrDPKOYErzy
 f/F7k8IHuTvM/XIMr9ncjBFA++Qy197UkAmXIoUWE4ht3LIO6IyLgf5tHgttpA/tMymr
 c6kMo63EbPe0ntcMrE7o15bqMI1qaZyoZoRGw3Sk3Yaffxe4OdwwiG4wYCmkeFdkaw9B
 4pdd7ZAFXKy8BhxzvU2u7NC0Ncf6r+WI1SHnCErADKMbNnGw9FgiRlHNmRJcQdfsZrXE
 aa8OYj95KR+hTAhH71AzeFwoyPUPiOUdhVF24+9lczbRJ1e/g49QXAalqYxfxsz3P5Ll
 MGiQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwJ/SPL3fJTFiXbwYOQZljwrnzdT9335WRw8LR8TllVQSZuQ0TJbfQhmYSP0xoyjewj+1FQnDlFxqy7@nongnu.org
X-Gm-Message-State: AFuF++mLRbQ+u6gWPB/pxGM7f/GcIjDFXFoqyMRBpyAHTMvfKo6HfatK
 y1Ea15K7jf665IXz4UNSH8HTCw4IZIETjBrRrK0gbXzl9XobR8Ct+zd5Ha6FBxHUwM2XQXnw+6r
 4HLle31r9OYJa26ErBMNBsUIe6/RyOSX+mtPvM2PNSMAa1gx8E2bQE8e5jQ==
X-Gm-Gg: AYBFou2OT4wgWH0GMWbr+oFLUFX0ZJZaYB56uHeXPjSka78dKij7DYpvjyaWCQlOIHt
 rDwkrZuE+5dX8+QOwY21pZ9SWGZJdtrZ+Q99GnHnzLinWIdz9blIk7DiyqfAlTWksp5s4LO7FU7
 Y3+HqGDZ24jaq3A22r9IJyRwpibYWIlYGm+/mCXKNJEIRraCW4hBceUpAuHbs6rNZHQEx5Ydk9I
 J9wJwRyrHRt39KUS9CxH7WeTQaMi0T5XzrKxqLebu28FKITpD0+2GnIBynFwYxuomrSyLglRtVb
 Ttt/P9FovwTSKp2335lY948bhQyzZszlH1PFypTXRI++axWPp4Wvm/vMNwZMhN51gIWvZfTOSVQ
 k67JE5PFteG7Dw2kPMQEt
X-Received: by 2002:a05:6122:893:b0:5c9:c60a:e9af with SMTP id
 71dfb90a1353d-5c9c60af4cdmr3049474e0c.21.1789998674950; 
 Mon, 21 Sep 2026 06:51:14 -0700 (PDT)
X-Received: by 2002:a05:6122:893:b0:5c9:c60a:e9af with SMTP id
 71dfb90a1353d-5c9c60af4cdmr3049413e0c.21.1789998674301; 
 Mon, 21 Sep 2026 06:51:14 -0700 (PDT)
Received: from [192.168.0.4] ([79.127.134.47])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4872442263fsm23680973f8f.1.2026.09.21.06.51.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2026 06:51:13 -0700 (PDT)
Message-ID: <a636e448-911e-437c-9d41-6c9187eeaa9c@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 15:51:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/11] hw/riscv: Filter for 32- or 64-bit machine types
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, daniel.barboza@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, palmer@dabbelt.com,
 alistair.francis@wdc.com
References: <20260918-hw-riscv-cpu-int-v5-0-f98c5a244636@rev.ng>
 <20260918-hw-riscv-cpu-int-v5-10-f98c5a244636@rev.ng>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260918-hw-riscv-cpu-int-v5-10-f98c5a244636@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDIwMSBTYWx0ZWRfXycc/XgQQSH23
 tBOi7wxLf4qRVlwe08sPTjsZZcfqybDRv+IfLKN9ldP07GPOOmRNeepHiMZwKNmA/mIWkysTlrE
 hXKFcXvcqmQuLO27INSuLBN/P+HtONsMtbSPyoB+BgH964XDQ2GNeLLd+LpX0WALwjA3c5GQqxO
 bksjE6//FPqP7CYvrS4KE5llyHydJjclUZ6oZnZ1tYB2oq8pntuKLhYvphOLwom2yo7mYxY8fCA
 TOGN4DlJgUUXMB249ZEKJKHeVGVDKE0hgVGU69VRGWX0PHGSRNtdr/qKQt8urDHJ1vdROCLbyCZ
 TILZC556wxvmS24m6i7XHJN2LFiyzIMaALPtS8FVB8QQb9sy+7LRAubIqC4kMssfuway+bOqQcC
 ojATquTaxv9w9ST9CvF3uDkmyziohUnyVKEyw/Sv2iC6AJ7IY68DqPrVsPPNWwyCXEQSqlm8MQM
 9d3xUAInu7tC9CzBfCA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDIwMSBTYWx0ZWRfX+cyfO9GF9h5y
 QKdbNONRJI58Uk0ETYmaqGJXVPim4rTWc9w1+gxHesj2tpuwM6mjGEW+png/QOGaHLJta1YGJH4
 sNc882i4YimfSIBSqJAb+VsRjcJ8YLA=
X-Proofpoint-ORIG-GUID: 5PXIcQpc4bUmMubZ1Vuxrsa28wq2qS2S
X-Proofpoint-GUID: 5PXIcQpc4bUmMubZ1Vuxrsa28wq2qS2S
X-Authority-Analysis: v=2.4 cv=W7etxhWk c=1 sm=1 tr=0 ts=6ab13653 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=btlkdZlGvBFwkIDmIYSHuA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=YDJjWJwHATzlH2HiSMUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210201
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

On 2026-09-18 0:05, Anton Johansson wrote:
> Filters for 32- or 64-bit machine types using TypeInfo::is_available,
> machines available for both 32-bit and 64-bit (amd-microblaze-v-generic,
> sifive-[e|u], spike, virt) leave the field unset.  For boston-aia,
> DEFINE_MACHINE() has been inlined to set is_available.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   hw/riscv/boston-aia.c      | 34 ++++++++++++++++++++--------------
>   hw/riscv/k230.c            |  3 +++
>   hw/riscv/microchip_pfsoc.c |  3 +++
>   hw/riscv/opentitan.c       |  3 +++
>   hw/riscv/shakti_c.c        |  3 +++
>   hw/riscv/tt_atlantis.c     |  3 +++
>   hw/riscv/xiangshan_kmh.c   |  3 +++
>   7 files changed, 38 insertions(+), 14 deletions(-)
> 
> diff --git a/hw/riscv/boston-aia.c b/hw/riscv/boston-aia.c
> index b90da096ea..ba16b7dbc6 100644
> --- a/hw/riscv/boston-aia.c
> +++ b/hw/riscv/boston-aia.c
> @@ -10,6 +10,7 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include "qemu/target-info.h"
>   #include "qemu/units.h"
>   
>   #include "hw/core/boards.h"
> @@ -263,18 +264,6 @@ static const MemoryRegionOps boston_platreg_ops = {
>       },
>   };
>   
> -static const TypeInfo boston_device = {
> -    .name          = TYPE_MIPS_BOSTON_AIA,
> -    .parent        = TYPE_SYS_BUS_DEVICE,
> -    .instance_size = sizeof(BostonState),
> -};
> -
> -static void boston_register_types(void)
> -{
> -    type_register_static(&boston_device);
> -}
> -type_init(boston_register_types)
> -
>   #define NUM_INSNS 6
>   static void gen_firmware(uint32_t *p)
>   {
> @@ -462,8 +451,9 @@ static void boston_mach_init(MachineState *machine)
>       }
>   }
>   
> -static void boston_mach_class_init(MachineClass *mc)
> +static void boston_mach_class_init(ObjectClass *oc, const void *data)
>   {
> +    MachineClass *mc = MACHINE_CLASS(oc);
>       mc->desc = "MIPS Boston-aia";
>       mc->init = boston_mach_init;
>       mc->block_default_type = IF_IDE;
> @@ -473,4 +463,20 @@ static void boston_mach_class_init(MachineClass *mc)
>       mc->default_cpu_type = TYPE_RISCV_CPU_MIPS_P8700;
>   }
>   
> -DEFINE_MACHINE("boston-aia", boston_mach_class_init)
> +static const TypeInfo boston_types[] = {
> +    {
> +        .name          = TYPE_MIPS_BOSTON_AIA,
> +        .parent        = TYPE_SYS_BUS_DEVICE,
> +        .instance_size = sizeof(BostonState),
> +        .is_available  = target_riscv64,

If you ever have to respin, please convert the device (not a
machine) in a preliminary patch.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> +    },
> +    {
> +        .name          = MACHINE_TYPE_NAME("boston-aia"),
> +        .parent        = TYPE_MACHINE,
> +        .class_init    = boston_mach_class_init,
> +        .instance_size = sizeof(MachineState),
> +        .is_available  = target_riscv64,
> +    },
> +};
> +
> +DEFINE_TYPES(boston_types)

