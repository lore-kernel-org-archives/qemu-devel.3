Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 749BECA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:21:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEMtM-0000j6-UH; Wed, 07 Oct 2026 04:20:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEFg8-0004jO-MV
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 20:38:59 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEFfi-0005Qm-4Y
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 20:38:22 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6966eLI9418983
 for <qemu-devel@nongnu.org>; Tue, 6 Oct 2026 09:26:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PCSoggDW5ypxELwD6gbbnXT4bzHWg/ZJBOFyS45Kb7U=; b=ckO0j88ZR2x0+WSy
 Plwc3Lh4pcLe7uFvbjzq1P2jENnzN8r3hR9O1m0plmQOZCmtpdkhQwgX44tx4j76
 s9FK82m6rPuS9oAl1r1jBplo22j2cFjN0iiJUdUAewdaiKx6Qajht/Fl1bpT0Q2t
 z63A43cnCg5sbO34JlMmELeeQoIUj6olUbimH13ad1G/qLquZvcPVg+qyEyCmf/N
 f3OlpD9fSy9KxyLFX+9EoDq8r2W2sV+PAy7kZbjZPkRvNF8woJkg+2PQUn2UZKHs
 uGoPQL5CiA8Tpg1wObLe+Sy0k6UeQm1CK1LSlhMr7M2rCaxZK4c17K8W5hKKKeA5
 cTmaMg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4bhg4dga-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 09:26:55 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93a1de6d5c3so558270785a.3
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 02:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791278815; x=1791883615; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PCSoggDW5ypxELwD6gbbnXT4bzHWg/ZJBOFyS45Kb7U=;
 b=KpHmSJuC9vOGhjWLeZHLD2wX2Q/7rsNIrUT1+4xlSip0k2Fm2SCc0etkX+trs668HB
 RNXifOfm/r+t926kudJKBoN1mDxDziO5BxTH8MkFTnz+2jp6eQS5KcBrTCD7PCWpyB5X
 3iMR51b8U6Z4BcenNExZSLHrBKT3571nOnax8PFui1qkVNrY3dlrB6EkYfJUYuTKJl+T
 frpY6u4YIeHzRNy2+ODYVUTnfUGZr3tUM+3+1FFWAqJ31+VRJoA9Rz/zQYjSNvTbB74O
 HMb6EmODCyD0GWi9svvBZMqe/RKaBIh4EvIyZo/yEe2NK0tSk4ZPFt3K0PoYoYDbiR6B
 XKrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791278815; x=1791883615;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PCSoggDW5ypxELwD6gbbnXT4bzHWg/ZJBOFyS45Kb7U=;
 b=k1UdlK6Zv68gkl6uxPgtS5JID1xUSeEB4ncNlaxilLNbbPJb9FxxazELPDpzoLonYB
 hkzEYXwDXhlj83msw2n8UZ2UwTk4qHUfj5SAClDxVHk6B0EDVm3hlZ+G+KpdcnKXlPJI
 u0XqIDMIiJ9Z58QhWZtzqnm+aox0ks97Tew2ZMPGVZnaUAQBEOdt/obQ8Bx/D4H1fh4U
 8Z2us8XSLHkoNyAwQWYzfH/i+nJAIgzVaveFUHhSvYwrmb13q5NTwFoku2zA8TRjTOTN
 bky7fJNjmcOSdx3X5Ba8GuvFKrr0Nl/Hun9qDEL0GiunTbpCPDiDPGJVrSMrGtVjSbgX
 rzUQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxuPWXyGaxrOvWMMSgFoa4IChStRwSv5KLNb2pqt6DKYHBBP+f939D6xZUkNdJ9SFQF/wSUx31SgAXU@nongnu.org
X-Gm-Message-State: AFuF++kvl/fDxWgGfgxjDFZRzAtc3Kfv5BQmd0Q+7tFC5ufzGP0hlXEy
 O7ikvWMzTM7kr5QYg1z/hMizqVwrvwUcYl5x8V8eMzph656jNQ3AkaqxtvoApRgeZP+8hHYQWbK
 aqkDyXaDc2y2T4EoshClk/R49wKxqKFpUOIT90A/nJM4+TEHfjWq/rVQvvA==
X-Gm-Gg: AYBFou3BJiMSi0BPFw92wFY1o7b/NeVub7qIvBmPYHQwKye831uA90UlPfpStVb8Cqn
 Sn1D7KHLDnQcIn1TXpRTlCHRyw0PIKCu8te7hvwBpG6hVBMOx6+yViDnKnVmGGt3R/YRY1hYW1T
 FTiZOjA8p6NuayvTcI8AGLXXcgUOgj3j4T94Y56moufiBbTvYDI51b+XXreavAc2v1RC/t+RtQq
 t42pOx8Zw5I+HgTq5ITCzaJLPQbIBO9WG4YmIiib5uehxfhZdRuW5sWGvJwWrRu8PPgRBou9tTQ
 tvMSUtHtd3PfgFjMz2DGQGilrxraeqyakqvUNVcP82lAa1UisQkIqkARAy5HQpoHmyPZfRfXFgh
 dmlVjVpn20IFVLlqKFTFjYr6PzCWv/QR+LQ==
X-Received: by 2002:a05:620a:8088:b0:93e:6d87:4f6b with SMTP id
 af79cd13be357-93e8f4eca38mr139308485a.48.1791278815368; 
 Tue, 06 Oct 2026 02:26:55 -0700 (PDT)
X-Received: by 2002:a05:620a:8088:b0:93e:6d87:4f6b with SMTP id
 af79cd13be357-93e8f4eca38mr139306185a.48.1791278814896; 
 Tue, 06 Oct 2026 02:26:54 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c62eda863sm8238859f8f.43.2026.10.06.02.26.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Oct 2026 02:26:53 -0700 (PDT)
Message-ID: <d63caf07-24f1-4911-b0f9-f375c48b6159@oss.qualcomm.com>
Date: Tue, 6 Oct 2026 11:26:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/31] hw/arm/fsl-imx25: Derive from TYPE_SYS_BUS_DEVICE
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bin Meng <bin.meng@processmission.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>, qemu-arm@nongnu.org,
 Jason Wang <jasowangio@gmail.com>,
 Alistair Francis <alistair@alistair23.me>
References: <20261006083445.30362-1-shentey@gmail.com>
 <20261006083445.30362-13-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261006083445.30362-13-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: CqDKHW-nUOUj24eTGgQjQl_FMN8x4vEj
X-Authority-Analysis: v=2.4 cv=GMGdgeNK c=1 sm=1 tr=0 ts=6ac4bee0 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=FRSEYCzRAAAA:8 a=pGLkceISAAAA:8 a=AXrosiIxGgywjbGlx0kA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDAzNyBTYWx0ZWRfX7gNyF33YvlHN
 W8QpDNV7UbBtR9WaIQe3SWRiOLrFEXfUzVdASKUMKH/Kaq7MNn3UcXihKcMjtH1iHc8B5LdyagR
 WJPReVMsN96pyZDAXvrG/PLLfyVuaX8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDAzNyBTYWx0ZWRfX7REkm8kjUThy
 Vzb5UsPq7Y4Yq0/NIQ8KdVYvkgtTdFW2IHzsqKur4G06GYkmlmaP3SXI4D/mlXvl5Q4WhAylXof
 wgcVE+vtJEahwoNGjwV8Fdw7f03Tn1SAN68VXydZJ0J8dHOE6mhkz848O4t11TOQE8FgcYYe4oh
 XEeDKYMqrOWSHPkIu8jpX0MclWRV8fg3El5ZWevZtk75hoCK7dETe2qv51LvHrNewMMZ1B0NP9B
 4m41FyFyXzve3tNAYsYENphDj/8Ti2xV20amg9lY4dpyByjFjCh5z+9MZbSsp+woYBlVsDfIL1p
 k9unFuGBW0FqoZgAyoOB6X+aPDOSXP+mA/2TiIXAX4nDX2AFFdOQf7MAHXqLH2TUKoZ+vRmVDNu
 qjDu6t2WrTWvCjbrMyrnjdxFZ7IOyteiGxyTGyl0kheoVXARUAz8bQIlXu2Cjy53tjswCZSeVuB
 7bBWlN4K5jKqSfidd8Q==
X-Proofpoint-GUID: CqDKHW-nUOUj24eTGgQjQl_FMN8x4vEj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_02,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610060037
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

On 6/10/26 10:34, Bernhard Beschow wrote:
> Deriving from TYPE_SYS_BUS_DEVICE fixes the SoC object to be reset upon
> machine reset.
> 
> Reviewed-by: Bin Meng <bin.meng@processmission.com>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   include/hw/arm/fsl-imx25.h | 5 ++---
>   hw/arm/fsl-imx25.c         | 7 +------
>   hw/arm/imx25_pdk.c         | 2 +-
>   3 files changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/include/hw/arm/fsl-imx25.h b/include/hw/arm/fsl-imx25.h
> index b68d4334a0..4bb4d5b3e5 100644
> --- a/include/hw/arm/fsl-imx25.h
> +++ b/include/hw/arm/fsl-imx25.h
> @@ -29,6 +29,7 @@
>   #include "hw/sd/sdhci.h"
>   #include "hw/usb/chipidea.h"
>   #include "hw/watchdog/wdt_imx2.h"
> +#include "hw/core/sysbus.h"
>   #include "system/memory.h"
>   #include "target/arm/cpu.h"
>   #include "qom/object.h"
> @@ -45,10 +46,8 @@ OBJECT_DECLARE_SIMPLE_TYPE(FslIMX25State, FSL_IMX25)
>   #define FSL_IMX25_NUM_USBS 2
>   
>   struct FslIMX25State {
> -    /*< private >*/
> -    DeviceState parent_obj;
> +    SysBusDevice parent_obj;
>   
> -    /*< public >*/
>       ARMCPU         cpu;
>       IMXAVICState   avic;
>       IMX25CCMState  ccm;
> diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
> index 7f65f4ca4b..efb22359c5 100644
> --- a/hw/arm/fsl-imx25.c
> +++ b/hw/arm/fsl-imx25.c
> @@ -317,16 +317,11 @@ static void fsl_imx25_class_init(ObjectClass *oc, const void *data)
>       device_class_set_props(dc, fsl_imx25_properties);
>       dc->realize = fsl_imx25_realize;
>       dc->desc = "i.MX25 SOC";
> -    /*
> -     * Reason: uses serial_hds in realize and the imx25 board does not
> -     * support multiple CPUs
> -     */
> -    dc->user_creatable = false;

Can we explain this change?

>   }
>   
>   static const TypeInfo fsl_imx25_type_info = {
>       .name = TYPE_FSL_IMX25,
> -    .parent = TYPE_DEVICE,
> +    .parent = TYPE_SYS_BUS_DEVICE,
>       .instance_size = sizeof(FslIMX25State),
>       .instance_init = fsl_imx25_init,
>       .class_init = fsl_imx25_class_init,
> diff --git a/hw/arm/imx25_pdk.c b/hw/arm/imx25_pdk.c
> index 243c30a67e..a33050788c 100644
> --- a/hw/arm/imx25_pdk.c
> +++ b/hw/arm/imx25_pdk.c
> @@ -72,7 +72,7 @@ static void imx25_pdk_init(MachineState *machine)
>   
>       object_initialize_child(OBJECT(machine), "soc", &s->soc, TYPE_FSL_IMX25);
>   
> -    qdev_realize(DEVICE(&s->soc), NULL, &error_fatal);
> +    sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
>   
>       /* We need to initialize our memory */
>       if (machine->ram_size > (FSL_IMX25_SDRAM0_SIZE + FSL_IMX25_SDRAM1_SIZE)) {


