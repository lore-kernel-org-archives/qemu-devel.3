Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55BE2C4451B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 08:00:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wliue-0007wm-TL; Mon, 20 Jul 2026 03:59:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wliuV-0007rU-M9
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 03:59:36 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wliuS-00072w-TU
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 03:59:35 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66K76Qi11712940
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 07:59:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /FJJnALZ90nRcM6xb1lEXesLXBRoShEBJ5XfWq//F8k=; b=hbhTUyNUnuguSP1b
 fODaBED11/jMYFPASZ5Yqsj1N6igjUVvoGvNQLrUVeujOhpEm7yN8AQqdZeZURjv
 pOxgwjMNDbLNrN3AvVAsuQkPXWSD/rsZQ+ab6BBpyrpc69nm1moLv3Vg02Sk9n+P
 eAaov8aDZtFBqv9isbDxgykIHqxY8tXJYagekN26jpZBFpFlB96Tw6vAmh5Z7srq
 4u8kKpYnfuCCgmqFldIQ8446Cri82lexk+huyBLSEppZNMECPWyCn9ySa2jJC66X
 w/SkQDx/ZMNAtXTCz96yrZyI1RqhxYxuyC09sER5F6BYHYZYv/tnYGrAT7NzKdFX
 okBYtw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhf0c068c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 07:59:31 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c1a97644aso264773911cf.2
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 00:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784534370; x=1785139170; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/FJJnALZ90nRcM6xb1lEXesLXBRoShEBJ5XfWq//F8k=;
 b=aN75MlWuiAFt54fscoMeV0HALbFu1z55vxY52Qe4EsOQr6DRUqBkp9PqWzV5wG/+M9
 Z88JlkcXHrF7mqB1XdZ0OZ9mgaoA2Njnh7U91NHayDdZhLlzTpNL+BM+1iBc5kQ7DVBJ
 2SijD8TaDPInfM8fd2eUiilQe5t8ZZnK0apcodZWDEc4NPDpPvoSxlT9vIQ342wEDaeP
 g+JNAPvIkSr0ONoQHg6wc3m4BFmnrjJQwf6N9H8iaOB+jvI7db665Xi6wrSDHYU01xQ6
 rFj/D2RlZyauRI9TZcKzAllf7OXOVBDJhrXZLr+KSVpxhSvdjdyQBAR7Wr8kAyqR4P3D
 +1tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784534370; x=1785139170;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/FJJnALZ90nRcM6xb1lEXesLXBRoShEBJ5XfWq//F8k=;
 b=P6ztQsWrMMINOkS9l8xWovKfNnTviFeFrlqpqcqBxohFlGWYb2zhN5LhDi+pmbHfNO
 0yHdnutrtDwTGXMqX0Wcd3sLc4EkCVhEvGmIxuHs/eL0UmSCrNcOcpZgFNKzZ9QR45+Q
 6zZXbfeAvHomH8xuZKpTxzmZ3hZNesG5a91VuVhOsssvonCsWebLWq5XdfY4kX+GVuhk
 NOGQiKQe+yzS3cVZt8V981nXO3QK8sXTactvW0FeRxzRE/KMJNhqYg2GxCJK8OPOsRZ0
 62jIB6PE2dHqE98/bVELUnhmfDxbDAKQYn1ZbaOsC7yAkbw0/o5qLF0ZfmiKBc1tIUxt
 1tAA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp2hQJRBloaupmvJ7pmAyGCpIFvv2s9Ear4HoedH68kqQNWOCka8X1RhutFRCh8NTzqBld8mZziaIxR@nongnu.org
X-Gm-Message-State: AOJu0Ywi/qOVFg437p5Qdo4nkn/ekXcDuzvhzznVAX48ee+MNWd0y45S
 twCjxyqaxPHgata0eSGseyO2AK51vheajMas7CGQ7PYbSy6/NmqhcSuzJeYyEtieoNUMCAMK3Eo
 6vX2oEK4mG0A/C66MqplErdMk275HgwxgdwXM2+194xViWL1RGj/Wg9quOg==
X-Gm-Gg: AfdE7cmqqGXy5LdC3E4Co8wLmVerorscT0ilIrZZyZXG5fyinN0UATA9HNec12ccet0
 uChOBrZ4503SO2Ph8bLACM6ZySrQEGVF38gR3v3ZX06dyNigZHuObrp44u7QHroMkAEmmsEWkay
 eN+TnqKmKy1puccv7mbYqnyiPVGnaAmAU3DZRGqMdD7GjuLE65kmeR1M+wthfLiLIpFAmZ5f0/K
 enRdg0oYwv04iJ2kKIyZJliySvNG1wtwmr49SZC9lurAWfzSVhhxXwCOehkPfOPRmz3iHu3P0Mx
 QJ9/yLnztZE3MOG4/UCdjcwIKoNx7wjFPxRER25eks1+MfhK7kWd6z0TbPCTvV75mM5StG3eYr0
 Sy5lByPliKiLE7lvlktX9yY9e1Bo2G7+2aJZK+MAduIs72hLkwtE=
X-Received: by 2002:a05:622a:1a9c:b0:51b:fe47:b3a4 with SMTP id
 d75a77b69052e-5213e28e228mr132249121cf.46.1784534370518; 
 Mon, 20 Jul 2026 00:59:30 -0700 (PDT)
X-Received: by 2002:a05:622a:1a9c:b0:51b:fe47:b3a4 with SMTP id
 d75a77b69052e-5213e28e228mr132248991cf.46.1784534370102; 
 Mon, 20 Jul 2026 00:59:30 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49558cb8433sm73278965e9.2.2026.07.20.00.59.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 00:59:28 -0700 (PDT)
Message-ID: <a16c336c-e899-4243-aa15-13a0681930f9@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 09:59:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] hw/hexagon: connect l2vic device
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@oss.qualcomm.com, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 peter.maydell@linaro.org, matheus.bernardino@oss.qualcomm.com,
 ltaylorsimpson@gmail.com, Thomas Huth <th.huth+qemu@posteo.eu>,
 Laurent Vivier <lvivier@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
References: <20260715185701.1287176-1-brian.cain@oss.qualcomm.com>
 <20260715185701.1287176-6-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260715185701.1287176-6-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=HeYkiCE8 c=1 sm=1 tr=0 ts=6a5dd563 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=fARxdbHzVQyMdUbhcZUA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: aOv83LpFshn8-aY6X6TOE30YLPY4WTBz
X-Proofpoint-ORIG-GUID: aOv83LpFshn8-aY6X6TOE30YLPY4WTBz
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA4NyBTYWx0ZWRfX5ZjprPI5WGIm
 sF8XHo85h2MGKQHGtCYVFbG3PA65E1+Wyb45eY0AQgTVPsP2k8ya0gCb/YFx/ayA3F0T0x2ZrdA
 EN+QnKvS5/cTeuImWSupa3/BVC/Se4Q=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA4NyBTYWx0ZWRfX7+V739hgzGUs
 cfuG9AYwzNMdC23fXu9q2IW7CAxQDm9WoAzxLmAPvmzG+QfVROi0I2Oas6xYoGF8703PwhaDtHR
 uU1hw7cbSuZass5DqYWBVcxdwk7YAGNRe1e6OwsvM1CiIj6rgKDcoAnBwqIAe7jGiGGj1l0Ax2U
 yk1V3k//xv0AF5oAjsGQ2XIs2dRJVAN84DDxYfrityqR8pgHZkerJ2oyfz4ExPy4Xi2vGwzCMGu
 BJR6z0GNUZR7ajsbpdhsrDz23v2MIqSDbF1Zr8DUumyrThCqSwDqrBfUZ8Yf+q6S6ANiVj2pR0M
 uXN2IYaaHINlA3E8Dv27PfZw1qVqXA92E7yqvq33XxqFD27v0FQBrmbfWKvhsvwXNTgDGAojElR
 Ml8oDHVTZaQxr/lyrr5kdM3MOVA27CjVJ9+cdc8IczS30V5cJMyM8YDeH8UWMYevYX+hN5Q8bQ0
 5IhdKX4dIyYQP2Ga9EQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200087
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

On 15/7/26 20:56, Brian Cain wrote:
> Instantiate the L2VIC device in both machine models, map its slow and
> MMIO regions, and link it to each CPU via the "l2vic" property.

"slow and MMIO" description is not clear to me.

> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   include/hw/hexagon/hexagon.h           |  1 +
>   include/hw/hexagon/hexagon_globalreg.h |  4 +++
>   hw/hexagon/hexagon_dsp.c               | 20 +++++++++++++
>   hw/hexagon/hexagon_globalreg.c         | 41 ++++++++++++++++++++++----
>   hw/hexagon/virt.c                      | 22 ++++++++++++++
>   5 files changed, 83 insertions(+), 5 deletions(-)
> 
> diff --git a/include/hw/hexagon/hexagon.h b/include/hw/hexagon/hexagon.h
> index 1034b09c2ac..6753ae32cde 100644
> --- a/include/hw/hexagon/hexagon.h
> +++ b/include/hw/hexagon/hexagon.h
> @@ -156,6 +156,7 @@ struct HexagonCommonMachineState {
>   
>       MemoryRegion ram;
>       MemoryRegion cfgtable_rom;
> +    DeviceState *l2vic_dev;

s/_dev//

>   };
>   
>   #endif
> diff --git a/include/hw/hexagon/hexagon_globalreg.h b/include/hw/hexagon/hexagon_globalreg.h
> index 950099808fd..397dc6854c9 100644
> --- a/include/hw/hexagon/hexagon_globalreg.h
> +++ b/include/hw/hexagon/hexagon_globalreg.h
> @@ -10,6 +10,7 @@
>   
>   #include "hw/core/qdev.h"
>   #include "hw/core/sysbus.h"
> +#include "hw/intc/hex-l2vic.h"
>   #include "qom/object.h"
>   #include "target/hexagon/cpu.h"
>   
> @@ -22,6 +23,9 @@ struct HexagonGlobalRegState {
>       /* Array of system registers */
>       uint32_t regs[NUM_SREGS];
>   
> +    /* L2VIC interface used to back the VID/VID1 registers */
> +    HexL2VicInterface *l2vic;
> +
>       /* Global performance cycle counter base */
>       uint64_t g_pcycle_base;
>   
> diff --git a/hw/hexagon/hexagon_dsp.c b/hw/hexagon/hexagon_dsp.c
> index aa493993229..4cf88627c8f 100644
> --- a/hw/hexagon/hexagon_dsp.c
> +++ b/hw/hexagon/hexagon_dsp.c
> @@ -16,6 +16,7 @@
>   #include "hw/hexagon/hexagon.h"
>   #include "hw/hexagon/hexagon_globalreg.h"
>   #include "hw/hexagon/hexagon_tlb.h"
> +#include "hw/intc/hex-l2vic.h"
>   #include "hw/core/loader.h"
>   #include "qapi/error.h"
>   #include "qemu/error-report.h"
> @@ -111,6 +112,7 @@ static void hexagon_common_init(MachineState *machine, Rev_t rev,
>       MemoryRegion *address_space;
>       DeviceState *glob_regs_dev;
>       DeviceState *tlb_dev;
> +    DeviceState *cpu0 = NULL;
>   
>       memset(&hexagon_binfo, 0, sizeof(hexagon_binfo));
>       if (machine->kernel_filename) {
> @@ -131,11 +133,21 @@ static void hexagon_common_init(MachineState *machine, Rev_t rev,
>                              machine->ram_size, &error_fatal);
>       memory_region_add_subregion(address_space, 0x0, &hms->ram);
>   
> +    hms->l2vic_dev = qdev_new(TYPE_HEX_L2VIC);
> +    object_property_add_child(OBJECT(machine), "l2vic",
> +                              OBJECT(hms->l2vic_dev));
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(hms->l2vic_dev), &error_fatal);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(hms->l2vic_dev), 0, m_cfg->l2vic_base);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(hms->l2vic_dev), 1,
> +                    m_cfg->cfgtable.fastl2vic_base << 16);
> +
>       glob_regs_dev = qdev_new(TYPE_HEXAGON_GLOBALREG);
>       object_property_add_child(OBJECT(machine), "global-regs",
>                                 OBJECT(glob_regs_dev));
>       qdev_prop_set_uint64(glob_regs_dev, "config-table-addr", m_cfg->cfgbase);
>       qdev_prop_set_uint32(glob_regs_dev, "dsp-rev", rev);
> +    object_property_set_link(OBJECT(glob_regs_dev), "l2vic",
> +                             OBJECT(hms->l2vic_dev), &error_fatal);
>       sysbus_realize_and_unref(SYS_BUS_DEVICE(glob_regs_dev), &error_fatal);
>   
>       tlb_dev = qdev_new(TYPE_HEXAGON_TLB);
> @@ -154,15 +166,23 @@ static void hexagon_common_init(MachineState *machine, Rev_t rev,
>            */
>           qdev_prop_set_bit(DEVICE(cpu), "start-powered-off", (i != 0));
>           if (i == 0) {
> +            cpu0 = DEVICE(cpu);

Alternatively call sysbus_connect_irq() here.

>               hexagon_init_bootstrap(dms, cpu);
>           }
>           object_property_set_link(OBJECT(cpu), "global-regs",
>                                    OBJECT(glob_regs_dev), &error_fatal);
>           object_property_set_link(OBJECT(cpu), "tlb",
>                                    OBJECT(tlb_dev), &error_fatal);
> +        object_property_set_link(OBJECT(cpu), "l2vic",
> +                                 OBJECT(hms->l2vic_dev), &error_fatal);
>           qdev_realize_and_unref(DEVICE(cpu), NULL, &error_fatal);
>       }
>   
> +    for (int i = 0; i < 8; i++) {
> +        sysbus_connect_irq(SYS_BUS_DEVICE(hms->l2vic_dev), i,
> +                           qdev_get_gpio_in(cpu0, i));
> +    }
> +
>       rom_add_blob_fixed_as("config_table.rom", &m_cfg->cfgtable,
>                             sizeof(m_cfg->cfgtable), m_cfg->cfgbase,
>                             &address_space_memory);
> diff --git a/hw/hexagon/hexagon_globalreg.c b/hw/hexagon/hexagon_globalreg.c
> index b5e5913507e..3d0d6f9516c 100644
> --- a/hw/hexagon/hexagon_globalreg.c
> +++ b/hw/hexagon/hexagon_globalreg.c
> @@ -11,6 +11,7 @@
>   #include "hw/core/qdev-properties.h"
>   #include "hw/core/sysbus.h"
>   #include "hw/core/resettable.h"
> +#include "hw/intc/hex-l2vic.h"
>   #include "migration/vmstate.h"
>   #include "qom/object.h"
>   #include "target/hexagon/cpu.h"
> @@ -135,6 +136,32 @@ static inline uint32_t apply_write_mask(uint32_t new_val, uint32_t cur_val,
>       return new_val;
>   }
>   
> +static inline bool is_vid_reg(uint32_t reg)
> +{
> +    return reg == HEX_SREG_VID || reg == HEX_SREG_VID1;
> +}
> +
> +/*
> + * HEX_SREG_VID/VID1 are backed by the L2VIC's VID group registers
> + * rather than the plain regs[] array, when an L2VIC is wired up.
> + */
> +static uint32_t get_reg_value(HexagonGlobalRegState *s, uint32_t reg)
> +{
> +    if (is_vid_reg(reg) && s->l2vic) {

Do we still want an optional l2vic? Otherwise we should make it
unconditional, checking the link is set in hexagon_globalreg_realize().

> +        return l2vic_read_vid(s->l2vic, reg == HEX_SREG_VID ? 0 : 1);
> +    }
> +    return s->regs[reg];
> +}
> +
> +static void set_reg_value(HexagonGlobalRegState *s, uint32_t reg,
> +                          uint32_t value)
> +{
> +    s->regs[reg] = value;

IIUC HEX_SREG_VID,1 are read-only and shouldn't be updated, is that right?

> +    if (is_vid_reg(reg) && s->l2vic) {
> +        l2vic_update_vid(s->l2vic, reg == HEX_SREG_VID ? 0 : 1, value);
> +    }
> +}
> +
>   uint32_t hexagon_globalreg_read(HexagonGlobalRegState *s, uint32_t reg,
>                                   uint32_t htid)
>   {
> @@ -146,7 +173,7 @@ uint32_t hexagon_globalreg_read(HexagonGlobalRegState *s, uint32_t reg,
>       g_assert(reg < NUM_SREGS);
>       g_assert(reg >= HEX_SREG_GLB_START);
>   
> -    value = s->regs[reg];
> +    value = get_reg_value(s, reg);
>   
>       trace_hexagon_globalreg_read(htid, get_sreg_name(reg), value);
>       return value;
> @@ -160,7 +187,7 @@ void hexagon_globalreg_write(HexagonGlobalRegState *s, uint32_t reg,
>       }
>       g_assert(reg < NUM_SREGS);
>       g_assert(reg >= HEX_SREG_GLB_START);
> -    s->regs[reg] = value;
> +    set_reg_value(s, reg, value);

A preliminary patch with extracting get_reg_value/set_reg_value stubs
would reduce this diff.

>       trace_hexagon_globalreg_write(htid, get_sreg_name(reg), value);
>   }
>   
> @@ -168,6 +195,7 @@ uint32_t hexagon_globalreg_masked_value(HexagonGlobalRegState *s, uint32_t reg,
>                                           uint32_t value)
>   {
>       uint32_t reg_mask;
> +    uint32_t cur_val;
>   
>       if (!s) {
>           return value;
> @@ -175,9 +203,10 @@ uint32_t hexagon_globalreg_masked_value(HexagonGlobalRegState *s, uint32_t reg,
>       g_assert(reg < NUM_SREGS);
>       g_assert(reg >= HEX_SREG_GLB_START);
>       reg_mask = global_sreg_immut_masks[reg];
> +    cur_val = get_reg_value(s, reg);
>       return reg_mask == IMMUTABLE ?
> -            s->regs[reg] :
> -            apply_write_mask(value, s->regs[reg], reg_mask);
> +            cur_val :
> +            apply_write_mask(value, cur_val, reg_mask);
>   }
>   
>   void hexagon_globalreg_write_masked(HexagonGlobalRegState *s, uint32_t reg,
> @@ -186,7 +215,7 @@ void hexagon_globalreg_write_masked(HexagonGlobalRegState *s, uint32_t reg,
>       if (!s) {
>           return;
>       }
> -    s->regs[reg] = hexagon_globalreg_masked_value(s, reg, value);
> +    set_reg_value(s, reg, hexagon_globalreg_masked_value(s, reg, value));
>   }
>   
>   uint64_t hexagon_globalreg_get_pcycle_base(HexagonGlobalRegState *s)
> @@ -275,6 +304,8 @@ static const VMStateDescription vmstate_hexagon_globalreg = {
>   };
>   
>   static const Property hexagon_globalreg_properties[] = {
> +    DEFINE_PROP_LINK("l2vic", HexagonGlobalRegState, l2vic,
> +                     TYPE_HEX_L2VIC_INTERFACE, HexL2VicInterface *),
>       DEFINE_PROP_UINT32("boot-evb", HexagonGlobalRegState, boot_evb, 0x0),
>       DEFINE_PROP_UINT64("config-table-addr", HexagonGlobalRegState,
>                          config_table_addr, 0xffffffffULL),
> diff --git a/hw/hexagon/virt.c b/hw/hexagon/virt.c
> index a3638998b87..2256d3d53a5 100644
> --- a/hw/hexagon/virt.c
> +++ b/hw/hexagon/virt.c
> @@ -15,6 +15,7 @@
>   #include "hw/hexagon/hexagon.h"
>   #include "hw/hexagon/hexagon_globalreg.h"
>   #include "hw/hexagon/hexagon_tlb.h"
> +#include "hw/intc/hex-l2vic.h"
>   #include "hw/core/loader.h"
>   #include "hw/core/qdev-properties.h"
>   #include "hw/core/qdev-clock.h"
> @@ -268,10 +269,22 @@ static void virt_init(MachineState *ms)
>                                   &vms->parent_obj.cfgtable_rom);
>       fdt_add_hvx(vms, m_cfg);
>   
> +    vms->parent_obj.l2vic_dev = qdev_new(TYPE_HEX_L2VIC);
> +    object_property_add_child(OBJECT(ms), "l2vic",
> +                              OBJECT(vms->parent_obj.l2vic_dev));
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(vms->parent_obj.l2vic_dev),
> +                             &error_fatal);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(vms->parent_obj.l2vic_dev), 0,
> +                    m_cfg->l2vic_base);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(vms->parent_obj.l2vic_dev), 1,
> +                    m_cfg->cfgtable.fastl2vic_base << 16);
> +
>       gsregs_dev = qdev_new(TYPE_HEXAGON_GLOBALREG);
>       object_property_add_child(OBJECT(ms), "global-regs", OBJECT(gsregs_dev));
>       qdev_prop_set_uint64(gsregs_dev, "config-table-addr", m_cfg->cfgbase);
>       qdev_prop_set_uint32(gsregs_dev, "dsp-rev", v68_rev);
> +    object_property_set_link(OBJECT(gsregs_dev), "l2vic",
> +                             OBJECT(vms->parent_obj.l2vic_dev), &error_fatal);
>       sysbus_realize_and_unref(SYS_BUS_DEVICE(gsregs_dev), &error_fatal);
>   
>       tlb_dev = qdev_new(TYPE_HEXAGON_TLB);
> @@ -301,9 +314,18 @@ static void virt_init(MachineState *ms)
>                                    OBJECT(gsregs_dev), &error_fatal);
>           object_property_set_link(OBJECT(cpu), "tlb",
>                                    OBJECT(tlb_dev), &error_fatal);
> +        object_property_set_link(OBJECT(cpu), "l2vic",
> +                                 OBJECT(vms->parent_obj.l2vic_dev),
> +                                 &error_fatal);
>   
>           qdev_realize_and_unref(DEVICE(cpu), NULL, &error_fatal);
>       }
> +
> +    for (int i = 0; i < 8; i++) {
> +        sysbus_connect_irq(SYS_BUS_DEVICE(vms->parent_obj.l2vic_dev), i,
> +                           qdev_get_gpio_in(cpu0, i));
> +    }
> +
>       fdt_add_cpu_nodes(vms);
>       clk_phandle = fdt_add_clocks(vms);
>       fdt_add_uart(vms, VIRT_UART0, clk_phandle);


