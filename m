Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F81606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 18:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mLr99mBY;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ry44jKz5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMV2L-0000az-Av; Thu, 29 Oct 2026 14:39:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMV2E-0000ap-Qs
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 14:39:35 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMV2A-0001Eh-IW
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 14:39:34 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGDRAH227681
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 18:39:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lPwwIdQCM4F3CjLpVjCliLrrr8v/Ux9EMHYMexI/bZA=; b=mLr99mBY/ZKoyFA6
 WQIeY2MhU/TfsZPxrWC4VETGdCGoy+olNe92SF3+bi3J3TlaoKQKugp1AulAbCEE
 Qh+qbeHxZkS5K+tNbjQPsOaVdAv0ugtOAUo77RwKVqIywhovabG/d55YLs28CnJb
 IyCJ4izsCuXoLI8y9p6LLE7pVee1QyuaI5C9LZUNHWpiRTPgLS5hwredjZTu3VGk
 gTIvOzg2+B5FdilkyOfE8hLtrM2F/8kztvn7tiWOuD3pbSrUX7RWtb1l6uAHbK+6
 tCnIwgfCEt5HU2FcbyQELrNUxVw3JdiZmkB4aVEnJhwBkpopNshNgZXTr3zSbVaM
 U9sx6A==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm42fk8g1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 18:39:29 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5376f1853bfso49878071cf.0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 11:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793299168; x=1793903968; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=lPwwIdQCM4F3CjLpVjCliLrrr8v/Ux9EMHYMexI/bZA=;
 b=Ry44jKz5o8Ov6DPkeyv8UKZEEeU+gQUpvtx+4VuP2X0FjCoyaUrrM9aCuGs1ty6pgs
 QxvFSLDq+OoKr5TAPuN8DQ85xq5JDkUQIMjigwBUn3ywIA01+HKZWZaPe5u0/+oi4kiy
 JSJZaALe8o2XBICt22a7OpFzQSSwT+cgfJKiWYQ+rnZ7GSlJchhgOD/T7tJJSrWNnvda
 Hg1P9BSFvQVxcgF7qfJRbKLjyefdxEF2LhjO6iLflbUGI/JzJ1xC1STxHFWKoUD4XNX+
 px4uDJsz7mNtng+pH+ImrGgPhn6zqbpZoCkmgu/thjJrT+bdSIWuVEG3mCQPVKG5C0tB
 NzJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793299168; x=1793903968;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lPwwIdQCM4F3CjLpVjCliLrrr8v/Ux9EMHYMexI/bZA=;
 b=T63adsXK+DLLRYx2BbtvfEUL0eTysgKQ/+7dMFrWy6sT7KEiMOiwqBDMh9RuEzkja2
 9ELPZikBTpNUL4L4OpjGHorcXz4P2TQGNS3Da7ef8FY67/Kz3P+9brzCPN33upWGHJn6
 lADkaNBsfMQ2/ifi9NHufL8vthhHLXiUYT7ynHw4HnCzBUOB7MSqCdX47u4vYA17G25G
 FGEn1WT+qa/iXN208XJk8qTDSyl0kWnPtwk5CDtys/u8NjtXydCqVRQa4lkiuu85ELV/
 CbVUUw8LRzz3KsOFMikk51SY2U/HWDK1hmaPdJ/mUBnD2eGKdPDfnOS8uDIEYIlZ1EqA
 XbpA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxrs9WmUuGCA5JJ7zQHAlVu7++ChQbqeiWOslXy0hzgk6V0YTxOCwt8X69E4zJgfdJHwPnL2MP2JOwA@nongnu.org
X-Gm-Message-State: AFq9FYIrE+7/b1tzJXwyxuhGqi1lNgCxGqfSYfkvPz54ydlF6v0jwWdO
 aZUHFcfpypmKfTxkWxguNsfXY5XMPE6HdzJH/aSDqNcW6AS/XQY7rlRA8RjZl4rKnAqRLQLZAvo
 pR6Rm86arWBwMcz1/Hpmw4cCBYaDqaXd5hcQ/pNd9A86Xzq+Rl9vHOeprQg==
X-Gm-Gg: AYBFou2/URyP/qCJUy6tzr6yTrkSjLXboM3FNeFZLmdFGai+ndJ4RXqEj8lu8Pj346M
 4wMsA/PtZkHHZjmR5tNziE+W0Te2vweEykIs2uKxM1qtm+6YEmzOYadA+710tQb2t5xeSc7npPz
 ZJZ1jZr0fI+JXczho2ulgAcu9B2sghZ0m1zHWC+AQaIWQV5LfuLPbx8LojswMh6IY4W/lI1+wj+
 UWnvZZCfxpUx0JGJ9RoTpTwFPQN7OxT1Apd1jf0BjIZA76JfUK0+nQe7aG1qu2Lu8ztMLMuVAlv
 YZfE070WKp/Xni/jFhIHyVS007ano3N4brGQk8MFBYBvdLGznc3XnFFR03AwVmpHe8DLWnrulOn
 o/O/XO12eSCVK0v/fergyFBPGyQn2xzAFXyg8DKncpEaU0IZetqYQgQ2zhQxUIhoVXCjwKkt+fw
 fr3CgOun4imbNNMKm+ZffYfHsevsSEGNqdgEis9Q==
X-Received: by 2002:a05:622a:1ba9:b0:531:11ac:23d8 with SMTP id
 d75a77b69052e-53fcbee19c7mr104133131cf.49.1793299168069; 
 Thu, 29 Oct 2026 11:39:28 -0700 (PDT)
X-Received: by 2002:a05:622a:1ba9:b0:531:11ac:23d8 with SMTP id
 d75a77b69052e-53fcbee19c7mr104132421cf.49.1793299167360; 
 Thu, 29 Oct 2026 11:39:27 -0700 (PDT)
Received: from [10.222.168.219] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-542a4025168sm845631cf.5.2026.10.29.11.39.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 11:39:26 -0700 (PDT)
Message-ID: <b784ec8f-4bbd-4a35-9f73-a85eaad08f21@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 13:39:24 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/20] target/hexagon: manage HLX contexts through CCR
To: Marco Liebel <marco.liebel@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Alessandro Di Federico <ale@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
References: <20261029174413.643130-1-marco.liebel@oss.qualcomm.com>
 <20261029174413.643130-2-marco.liebel@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20261029174413.643130-2-marco.liebel@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA3MyBTYWx0ZWRfX3hlbqu1Eh6cj
 OWyqY8WR3H31bCuJdXcx8RfRKodzhEoJw3BgIgJ7WgZg1e2DE0yZZEehCqXFIE2f+QdcEpm14uW
 ADqkmZLhc7qYEed1oYOBG/zOTkEMR2BwfkGXFX96ceNC+xYnH/573ydNtWwYONRM0Y3YXMWlqk6
 aI3mj2z2gkGlPYBVMMT2ST3d07hCAnfl8E/sqC7ln5Q1MGAsjtnKCYeNSv2ZddGgkg0XaRwy5Ux
 1+XVlQ3ercm7n5GGKxyeVIKPQ8jZedSwMiFSrYU9rkhVyzvt3UMz0WynVSRaXeYph0OJPopmIlw
 tz4JsTjaWItlW4e+1q/LRBnWhv5GgJEjDYHlJUM6OxIKMBk8vPHC44vn4uc98qHgKNiklIzTT2+
 p5LBQNyG0abesTbDcGt1ZMNGG94JQg==
X-Proofpoint-GUID: wDydwUt367u-pRB3ig1TNjYEBuDrcUJ3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA3MyBTYWx0ZWRfX801ZaQVvHTmL
 cDX8qB7azPSbEk/wa0F9Wr/Jmth4QhXDDFq+4owW25cmXhBv1jV+g1DJ2ewwuiXB/sx//IVnw7N
 pxcHPP2P/MxMPJj5WEg2overfMZ6Bbw=
X-Authority-Analysis: v=2.4 cv=UN9Ijyfy c=1 sm=1 tr=0 ts=6ae392e1 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=wOjq6_WW299fA8aaPT0A:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: wDydwUt367u-pRB3ig1TNjYEBuDrcUJ3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2610190000 definitions=main-2610290073
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 10/29/2026 12:43 PM, Marco Liebel wrote:
> Add an HLX context pool and select the active context from CCR.XE3
> and CCR.XA3. Preserve it across reset, migration and debugger writes.
> Commit CCR changes at the packet boundary and end the TB.
>
> Add a CCR enablement test.
>
> Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   hw/hexagon/hex-subsys.c             |  16 ++++
>   hw/hexagon/hexagon_hlx.c            | 113 ++++++++++++++++++++++++++++
>   hw/hexagon/meson.build              |   1 +
>   include/hw/hexagon/hexagon.h        |   1 +
>   include/hw/hexagon/hexagon_hlx.h    |  33 ++++++++
>   target/hexagon/cpu.c                |  16 ++++
>   target/hexagon/cpu.h                |  20 +++++
>   target/hexagon/cpu_helper.c         |  36 +++++++++
>   target/hexagon/cpu_helper.h         |   1 +
>   target/hexagon/gdbstub.c            |   5 ++
>   target/hexagon/genptr.c             |   5 +-
>   target/hexagon/helper.h             |   1 +
>   target/hexagon/hlx/hlx.h            |  64 ++++++++++++++++
>   target/hexagon/machine.c            |  47 +++++++++++-
>   target/hexagon/op_helper.c          |   6 ++
>   target/hexagon/reg_fields_def.h.inc |   2 +
>   target/hexagon/translate.c          |   8 ++
>   17 files changed, 372 insertions(+), 3 deletions(-)
>   create mode 100644 hw/hexagon/hexagon_hlx.c
>   create mode 100644 include/hw/hexagon/hexagon_hlx.h
>   create mode 100644 target/hexagon/hlx/hlx.h

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>


>
> diff --git a/hw/hexagon/hex-subsys.c b/hw/hexagon/hex-subsys.c
> index 1e6578255e..1a043818f6 100644
> --- a/hw/hexagon/hex-subsys.c
> +++ b/hw/hexagon/hex-subsys.c
> @@ -9,6 +9,7 @@
>   #include "qapi/error.h"
>   #include "hw/hexagon/hex-subsys.h"
>   #include "hw/hexagon/hexagon_globalreg.h"
> +#include "hw/hexagon/hexagon_hlx.h"
>   #include "hw/hexagon/hexagon_hvx_context.h"
>   #include "hw/hexagon/hexagon_tlb.h"
>   #include "hw/intc/hex-l2vic.h"
> @@ -120,6 +121,18 @@ static void hvx_contexts_create(HexagonCommonMachineState *hms,
>       hms->num_hvx_ctx = n;
>   }
>   
> +static DeviceState *hlx_create(HexagonCommonMachineState *hms,
> +                               const struct hexagon_machine_config *m_cfg)
> +{
> +    DeviceState *hlx = qdev_new(TYPE_HEXAGON_HLX);
> +
> +    object_property_add_child(OBJECT(hms), "hexagon-hlx", OBJECT(hlx));
> +    qdev_prop_set_uint32(hlx, "contexts-bitmap", m_cfg->cfgtable.coproc2_reg2);
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(hlx), &error_fatal);
> +
> +    return hlx;
> +}
> +
>   static DeviceState *cluster_create(HexagonCommonMachineState *hms)
>   {
>       DeviceState *cluster = qdev_new(TYPE_CPU_CLUSTER);
> @@ -167,6 +180,7 @@ void hex_subsys_create(HexagonCommonMachineState *hms,
>       hms->glob_regs = globalreg_create(hms, m_cfg, rev);
>       hms->tlb = tlb_create(hms, m_cfg);
>       hvx_contexts_create(hms, m_cfg);
> +    hms->hlx = hlx_create(hms, m_cfg);
>   }
>   
>   void hex_subsys_add_cpu(HexagonCommonMachineState *hms, DeviceState *cpu)
> @@ -178,6 +192,8 @@ void hex_subsys_add_cpu(HexagonCommonMachineState *hms, DeviceState *cpu)
>                                &error_fatal);
>       object_property_set_link(OBJECT(cpu), "l2vic", OBJECT(hms->l2vic),
>                                &error_fatal);
> +    object_property_set_link(OBJECT(cpu), "hlx", OBJECT(hms->hlx),
> +                             &error_fatal);
>       for (unsigned i = 0; i < hms->num_hvx_ctx; i++) {
>           g_autofree char *name = g_strdup_printf("hvx-context[%u]", i);
>           Object *ctx = object_resolve_path_component(OBJECT(hms), name);
> diff --git a/hw/hexagon/hexagon_hlx.c b/hw/hexagon/hexagon_hlx.c
> new file mode 100644
> index 0000000000..3ac21500e0
> --- /dev/null
> +++ b/hw/hexagon/hexagon_hlx.c
> @@ -0,0 +1,113 @@
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/host-utils.h"
> +#include "hw/core/qdev-properties.h"
> +#include "hw/hexagon/hexagon_hlx.h"
> +#include "migration/vmstate.h"
> +
> +static int hlx_xa3_to_pool_idx(uint32_t contexts_bitmap, uint32_t xa3)
> +{
> +    uint32_t below_mask;
> +
> +    if (!((contexts_bitmap >> xa3) & 1u)) {
> +        return -1;
> +    }
> +    below_mask = (xa3 == 0) ? 0u : ((1u << xa3) - 1u);
> +    return ctpop32(contexts_bitmap & below_mask);
> +}
> +
> +HexagonHLXContext *hexagon_hlx_get_context(HexagonHLXState *s, uint32_t xa3)
> +{
> +    int idx = hlx_xa3_to_pool_idx(s->contexts_bitmap, xa3);
> +    if (idx < 0 || idx >= s->num_contexts) {
> +        return NULL;
> +    }
> +    return &s->contexts[idx];
> +}
> +
> +void hexagon_hlx_reset_all(HexagonHLXState *s)
> +{
> +    if (!s->contexts) {
> +        return;
> +    }
> +    memset(s->contexts, 0, sizeof(HexagonHLXContext) * (size_t)s->num_contexts);
> +}
> +
> +static void hexagon_hlx_realize(DeviceState *dev, Error **errp)
> +{
> +    HexagonHLXState *s = HEXAGON_HLX(dev);
> +
> +    s->num_contexts = (int32_t)ctpop32(s->contexts_bitmap);
> +    if (s->num_contexts == 0) {
> +        s->contexts = NULL;
> +        return;
> +    }
> +    s->contexts = g_new0(HexagonHLXContext, (size_t)s->num_contexts);
> +}
> +
> +static void hexagon_hlx_unrealize(DeviceState *dev)
> +{
> +    HexagonHLXState *s = HEXAGON_HLX(dev);
> +    g_clear_pointer(&s->contexts, g_free);
> +    s->num_contexts = 0;
> +}
> +
> +static const Property hexagon_hlx_properties[] = {
> +    DEFINE_PROP_UINT32("contexts-bitmap", HexagonHLXState, contexts_bitmap, 0),
> +};
> +
> +/* VMSTATE_BUFFER requires a uint8_t array field. */
> +static const VMStateDescription vmstate_hexagon_hlx_context = {
> +    .name = "hexagon-hlx-context",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_BUFFER_UNSAFE_INFO_TEST(LRegs, HexagonHLXContext, NULL,
> +                                        0, vmstate_info_buffer,
> +                                        sizeof_field(HexagonHLXContext,
> +                                                     LRegs)),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static const VMStateDescription vmstate_hexagon_hlx = {
> +    .name = TYPE_HEXAGON_HLX,
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT32(contexts_bitmap, HexagonHLXState),
> +        VMSTATE_INT32(num_contexts,     HexagonHLXState),
> +        VMSTATE_STRUCT_VARRAY_ALLOC(contexts, HexagonHLXState,
> +                                    num_contexts, 1,
> +                                    vmstate_hexagon_hlx_context,
> +                                    HexagonHLXContext),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static void hexagon_hlx_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    dc->realize   = hexagon_hlx_realize;
> +    dc->unrealize = hexagon_hlx_unrealize;
> +    dc->vmsd      = &vmstate_hexagon_hlx;
> +    device_class_set_props(dc, hexagon_hlx_properties);
> +}
> +
> +static const TypeInfo hexagon_hlx_info = {
> +    .name          = TYPE_HEXAGON_HLX,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(HexagonHLXState),
> +    .class_init    = hexagon_hlx_class_init,
> +};
> +
> +static void hexagon_hlx_register_types(void)
> +{
> +    type_register_static(&hexagon_hlx_info);
> +}
> +
> +type_init(hexagon_hlx_register_types)
> diff --git a/hw/hexagon/meson.build b/hw/hexagon/meson.build
> index fa5bc5eb9f..46e9f8de9c 100644
> --- a/hw/hexagon/meson.build
> +++ b/hw/hexagon/meson.build
> @@ -3,6 +3,7 @@ hexagon_ss.add(files('hexagon_tlb.c'))
>   hexagon_ss.add(files('hexagon_globalreg.c'))
>   hexagon_ss.add(files('hexagon_hvx_context.c'))
>   hexagon_ss.add(when: 'CONFIG_HEX_DSP', if_true: files('hex-subsys.c'))
> +hexagon_ss.add(files('hexagon_hlx.c'))
>   hexagon_ss.add(when: 'CONFIG_HEX_DSP', if_true: files('hexagon_dsp.c'))
>   hexagon_ss.add(when: 'CONFIG_HEX_BOARD', if_true: files('hex-board.c'))
>   hexagon_ss.add(when: 'CONFIG_HEX_VIRT', if_true: files('virt.c'))
> diff --git a/include/hw/hexagon/hexagon.h b/include/hw/hexagon/hexagon.h
> index 678e658a6d..e01e2bb464 100644
> --- a/include/hw/hexagon/hexagon.h
> +++ b/include/hw/hexagon/hexagon.h
> @@ -187,6 +187,7 @@ struct HexagonCommonMachineState {
>       DeviceState *qtimer;
>       DeviceState *glob_regs;
>       DeviceState *tlb;
> +    DeviceState *hlx;
>       unsigned num_hvx_ctx;
>   };
>   
> diff --git a/include/hw/hexagon/hexagon_hlx.h b/include/hw/hexagon/hexagon_hlx.h
> new file mode 100644
> index 0000000000..68c3f001aa
> --- /dev/null
> +++ b/include/hw/hexagon/hexagon_hlx.h
> @@ -0,0 +1,33 @@
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_HEXAGON_HEXAGON_HLX_H
> +#define HW_HEXAGON_HEXAGON_HLX_H
> +
> +#include "hw/core/qdev.h"
> +#include "hw/core/sysbus.h"
> +#include "qom/object.h"
> +#include "target/hexagon/hlx/hlx.h"
> +
> +#define TYPE_HEXAGON_HLX "hexagon-hlx"
> +OBJECT_DECLARE_SIMPLE_TYPE(HexagonHLXState, HEXAGON_HLX)
> +
> +typedef struct HexagonHLXContext {
> +    HLXVector LRegs[NUM_LREGS] QEMU_ALIGNED(16);
> +} HexagonHLXContext;
> +
> +struct HexagonHLXState {
> +    SysBusDevice parent_obj;
> +
> +    uint32_t contexts_bitmap;
> +    int32_t num_contexts;
> +    HexagonHLXContext *contexts;
> +};
> +
> +HexagonHLXContext *hexagon_hlx_get_context(HexagonHLXState *s, uint32_t xa3);
> +
> +void hexagon_hlx_reset_all(HexagonHLXState *s);
> +
> +#endif
> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
> index 281d201250..c3930ab4e4 100644
> --- a/target/hexagon/cpu.c
> +++ b/target/hexagon/cpu.c
> @@ -42,6 +42,7 @@
>   #include "hexswi.h"
>   #include "exec/cpu-interrupt.h"
>   #include "exec/page-protection.h"
> +#include "hw/hexagon/hexagon_hlx.h"
>   #include "exec/target_page.h"
>   #include "hw/hexagon/hexagon_globalreg.h"
>   #include "hw/hexagon/hexagon_hvx_context.h"
> @@ -72,6 +73,8 @@ static const Property hexagon_cpu_properties[] = {
>       DEFINE_PROP_LINK("global-regs", HexagonCPU, globalregs,
>           TYPE_HEXAGON_GLOBALREG, HexagonGlobalRegState *),
>       DEFINE_PROP_UINT32("htid", HexagonCPU, htid, 0),
> +    DEFINE_PROP_LINK("hlx", HexagonCPU, hlx,
> +                     TYPE_HEXAGON_HLX, HexagonHLXState *),
>   #endif
>       DEFINE_PROP_BOOL("lldb-compat", HexagonCPU, cfg.lldb_compat, false),
>       DEFINE_PROP_UNSIGNED("lldb-stack-adjust", HexagonCPU, cfg.lldb_stack_adjust,
> @@ -498,6 +501,12 @@ static void hexagon_cpu_reset_hold(Object *obj, ResetType type)
>       env->cfi_active = 0;
>       env->cfi_active_log = 0;
>       env->cfi_updated = 0;
> +#ifdef CONFIG_USER_ONLY
> +    memset(&env->hlx_user_ctx, 0, sizeof(env->hlx_user_ctx));
> +    env->hlx_ctx = &env->hlx_user_ctx;
> +#else
> +    env->hlx_ctx = NULL;
> +#endif
>   #ifndef CONFIG_USER_ONLY
>       memset(env->t_sreg, 0, sizeof(uint32_t) * NUM_SREGS);
>       memset(env->greg, 0, sizeof(uint32_t) * NUM_GREGS);
> @@ -508,11 +517,18 @@ static void hexagon_cpu_reset_hold(Object *obj, ResetType type)
>   
>       env->t_sreg[HEX_SREG_HTID] = cpu->htid;
>       env->threadId = cpu->htid;
> +    if (cs->cpu_index == 0 && cpu->hlx) {
> +        hexagon_hlx_reset_all(cpu->hlx);
> +    }
> +
>       hexagon_cpu_soft_reset(env);
>       hexagon_hvx_select_context(env, env->t_sreg[HEX_SREG_SSR]);
>       env->cause_code = HEX_EVENT_NONE;
>       env->gpr[HEX_REG_PC] = cpu->boot_addr;
>   #endif
> +
> +    memset(env->future_LRegs, 0, sizeof(env->future_LRegs));
> +    memset(env->tmp_LRegs, 0, sizeof(env->tmp_LRegs));
>   }
>   
>   static void hexagon_cpu_disas_set_info(const CPUState *cs,
> diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
> index feb8036823..904dcc2e7d 100644
> --- a/target/hexagon/cpu.h
> +++ b/target/hexagon/cpu.h
> @@ -18,6 +18,13 @@
>   #ifndef HEXAGON_CPU_H
>   #define HEXAGON_CPU_H
>   
> +typedef struct HexagonHLXContext HexagonHLXContext;
> +
> +#ifdef CONFIG_USER_ONLY
> +/* linux-user embeds an HLX context and needs the full type. */
> +#include "hw/hexagon/hexagon_hlx.h"
> +#endif
> +
>   #include "fpu/softfloat-types.h"
>   
>   #ifndef CONFIG_USER_ONLY
> @@ -30,11 +37,13 @@
>   typedef struct HexagonTLBState HexagonTLBState;
>   typedef struct HexagonGlobalRegState HexagonGlobalRegState;
>   typedef struct HexagonHVXContextState HexagonHVXContextState;
> +typedef struct HexagonHLXState HexagonHLXState;
>   
>   #include "cpu-qom.h"
>   #include "exec/cpu-common.h"
>   #include "exec/target_long.h"
>   #include "hex_regs.h"
> +#include "hlx/hlx.h"
>   #include "mmvec/mmvec.h"
>   #include "hw/core/registerfields.h"
>   #include "qemu/bitmap.h"
> @@ -186,6 +195,16 @@ typedef struct CPUArchState {
>   
>       MMQReg future_QRegs[NUM_QREGS] QEMU_ALIGNED(16);
>   
> +    /* Active HLX context, or NULL when disabled or unavailable. */
> +    HexagonHLXContext *hlx_ctx;
> +
> +#ifdef CONFIG_USER_ONLY
> +    HexagonHLXContext hlx_user_ctx;
> +#endif
> +
> +    HLXVector future_LRegs[NUM_LREGS] QEMU_ALIGNED(16);
> +    HLXVector tmp_LRegs[NUM_LREGS] QEMU_ALIGNED(16);
> +
>       /* Temporaries used within instructions */
>       MMVectorPair VuuV QEMU_ALIGNED(16);
>       MMVectorPair VvvV QEMU_ALIGNED(16);
> @@ -222,6 +241,7 @@ struct ArchCPU {
>       HexagonGlobalRegState *globalregs;
>       uint32_t htid;
>       HexL2VicInterface *l2vic;
> +    HexagonHLXState *hlx;
>   #endif
>   };
>   
> diff --git a/target/hexagon/cpu_helper.c b/target/hexagon/cpu_helper.c
> index baffe6bbaa..940c724be9 100644
> --- a/target/hexagon/cpu_helper.c
> +++ b/target/hexagon/cpu_helper.c
> @@ -25,6 +25,7 @@
>   #include "macros.h"
>   #include "sys_macros.h"
>   #include "arch.h"
> +#include "hw/hexagon/hexagon_hlx.h"
>   
>   #ifndef CONFIG_USER_ONLY
>   
> @@ -327,6 +328,41 @@ static uint32_t set_enable_mask(CPUHexagonState *env)
>       return thread_enabled_mask;
>   }
>   
> +void hexagon_modify_ccr(CPUHexagonState *env, uint32_t new, uint32_t old)
> +{
> +    const uint32_t mask = (1u << reg_field_info[CCR_XA3].offset) |
> +                          (1u << reg_field_info[CCR_XE3].offset);
> +    bool old_XE3;
> +    bool new_XE3;
> +    uint32_t old_XA3;
> +    uint32_t new_XA3;
> +    HexagonCPU *cpu;
> +    HexagonHLXState *pool;
> +
> +    g_assert(bql_locked());
> +
> +    if (((old ^ new) & mask) == 0) {
> +        return;
> +    }
> +
> +    old_XE3 = GET_FIELD(CCR_XE3, old);
> +    new_XE3 = GET_FIELD(CCR_XE3, new);
> +    old_XA3 = GET_FIELD(CCR_XA3, old);
> +    new_XA3 = GET_FIELD(CCR_XA3, new);
> +    cpu = HEXAGON_CPU(env_cpu(env));
> +    pool = cpu->hlx;
> +
> +    if (!new_XE3) {
> +        env->hlx_ctx = NULL;
> +        return;
> +    }
> +
> +    if (!old_XE3 || old_XA3 != new_XA3) {
> +        env->hlx_ctx = pool ? hexagon_hlx_get_context(pool, new_XA3) : NULL;
> +        /* A missing XA3 context makes HLX instructions trap. */
> +    }
> +}
> +
>   static uint32_t clear_enable_mask(CPUHexagonState *env)
>   {
>       HexagonCPU *cpu;
> diff --git a/target/hexagon/cpu_helper.h b/target/hexagon/cpu_helper.h
> index b261b9177b..5c0c129dfd 100644
> --- a/target/hexagon/cpu_helper.h
> +++ b/target/hexagon/cpu_helper.h
> @@ -13,6 +13,7 @@ void hexagon_peek_memory_range(CPUHexagonState *env, uint32_t start_addr,
>                                  uint32_t length, uintptr_t retaddr);
>   uint32_t hexagon_get_pmu_counter(CPUHexagonState *cur_env, int index);
>   void hexagon_modify_ssr(CPUHexagonState *env, uint32_t new, uint32_t old);
> +void hexagon_modify_ccr(CPUHexagonState *env, uint32_t new, uint32_t old);
>   unsigned hexagon_hvx_select_context(CPUHexagonState *env, uint32_t ssr);
>   int get_cpu_mode(const CPUHexagonState *env);
>   int get_exe_mode(const CPUHexagonState *env);
> diff --git a/target/hexagon/gdbstub.c b/target/hexagon/gdbstub.c
> index 85d9845cc9..5b79e42c4d 100644
> --- a/target/hexagon/gdbstub.c
> +++ b/target/hexagon/gdbstub.c
> @@ -23,6 +23,7 @@
>   #ifndef CONFIG_USER_ONLY
>   #include "cpu_helper.h"
>   #include "hw/hexagon/hexagon_globalreg.h"
> +#include "hw/hexagon/hexagon_hlx.h"
>   #endif
>   
>   int hexagon_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
> @@ -120,6 +121,10 @@ int hexagon_sys_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
>               uint32_t old = env->t_sreg[HEX_SREG_SSR];
>               env->t_sreg[HEX_SREG_SSR] = val;
>               hexagon_modify_ssr(env, val, old);
> +        } else if (n == HEX_SREG_CCR) {
> +            uint32_t old = env->t_sreg[HEX_SREG_CCR];
> +            env->t_sreg[HEX_SREG_CCR] = val;
> +            hexagon_modify_ccr(env, val, old);
>           } else if (n < HEX_SREG_GLB_START) {
>               env->t_sreg[n] = val;
>           } else if (cpu->globalregs) {
> diff --git a/target/hexagon/genptr.c b/target/hexagon/genptr.c
> index 7ef36e336f..d0aabacf35 100644
> --- a/target/hexagon/genptr.c
> +++ b/target/hexagon/genptr.c
> @@ -287,7 +287,7 @@ static const uint32_t sreg_immut_masks[NUM_SREGS] = {
>       [HEX_SREG_STID] = 0xff00ff00,
>       [HEX_SREG_ELR] = 0x00000003,
>       [HEX_SREG_SSR] = 0x00008000,
> -    [HEX_SREG_CCR] = 0x10e0ff24,
> +    [HEX_SREG_CCR] = 0x00c0ff24,
>       [HEX_SREG_HTID] = IMMUTABLE,
>       [HEX_SREG_GEVB] = 0x000000ff,
>   };
> @@ -308,7 +308,8 @@ static void gen_log_sreg_write(DisasContext *ctx, int rnum, TCGv_i32 val)
>       if (reg_mask != IMMUTABLE) {
>           if (rnum < HEX_SREG_GLB_START) {
>               gen_masked_reg_write(val, hex_t_sreg[rnum], reg_mask);
> -            if (ctx->need_commit || rnum == HEX_SREG_SSR) {
> +            if (ctx->need_commit || rnum == HEX_SREG_SSR ||
> +                rnum == HEX_SREG_CCR) {
>                   tcg_gen_mov_i32(ctx->t_sreg_new_value[rnum], val);
>               } else {
>                   tcg_gen_mov_i32(hex_t_sreg[rnum], val);
> diff --git a/target/hexagon/helper.h b/target/hexagon/helper.h
> index 8c49e79809..8a2a6563d2 100644
> --- a/target/hexagon/helper.h
> +++ b/target/hexagon/helper.h
> @@ -147,6 +147,7 @@ DEF_HELPER_1(wait, void, env)
>   DEF_HELPER_2(resume, void, env, i32)
>   DEF_HELPER_1(resched, void, env)
>   DEF_HELPER_3(modify_ssr, void, env, i32, i32)
> +DEF_HELPER_3(modify_ccr, void, env, i32, i32)
>   DEF_HELPER_1(pending_interrupt, void, env)
>   DEF_HELPER_2(tlbinvasid, void, env, i32)
>   #endif
> diff --git a/target/hexagon/hlx/hlx.h b/target/hexagon/hlx/hlx.h
> new file mode 100644
> index 0000000000..81c0434df7
> --- /dev/null
> +++ b/target/hexagon/hlx/hlx.h
> @@ -0,0 +1,64 @@
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +#ifndef HEXAGON_HLX_H
> +#define HEXAGON_HLX_H
> +
> +#define NUM_LREGS 16
> +#define HLX_VEC_SIZE_BYTES 2048
> +
> +typedef union {
> +    uint8_t  ub[4];
> +    int8_t   b[4];
> +    uint16_t uh[2];
> +    int16_t  h[2];
> +    uint32_t uw;
> +    int32_t  w;
> +} lreg_element_t;
> +
> +typedef struct {
> +    union {
> +        uint64_t ud[HLX_VEC_SIZE_BYTES / 8];
> +        int64_t  d[HLX_VEC_SIZE_BYTES / 8];
> +        uint32_t uw[HLX_VEC_SIZE_BYTES / 4];
> +        int32_t  w[HLX_VEC_SIZE_BYTES / 4];
> +        uint16_t uh[HLX_VEC_SIZE_BYTES / 2];
> +        int16_t  h[HLX_VEC_SIZE_BYTES / 2];
> +        uint8_t  ub[HLX_VEC_SIZE_BYTES / 1];
> +        int8_t   b[HLX_VEC_SIZE_BYTES / 1];
> +    };
> +} HLXVector;
> +
> +typedef union {
> +    lreg_element_t l[HLX_VEC_SIZE_BYTES / 2];
> +} HLXVectorPair;
> +
> +static inline HLXVector hlx_zero_vector(void)
> +{
> +    HLXVector ret;
> +    memset(&ret, 0, sizeof(ret));
> +    return ret;
> +}
> +
> +/* Interleave separate low and high halfwords as {lo, hi}. */
> +static inline void hlx_interleave_pair(HLXVectorPair *pair,
> +                                       const HLXVector *lo,
> +                                       const HLXVector *hi)
> +{
> +    for (int i = 0; i < HLX_VEC_SIZE_BYTES / 2; i++) {
> +        pair->l[i].h[0] = lo->h[i];
> +        pair->l[i].h[1] = hi->h[i];
> +    }
> +}
> +
> +static inline void hlx_deinterleave_pair(HLXVector *lo, HLXVector *hi,
> +                                         const HLXVectorPair *pair)
> +{
> +    for (int i = 0; i < HLX_VEC_SIZE_BYTES / 2; i++) {
> +        lo->h[i] = pair->l[i].h[0];
> +        hi->h[i] = pair->l[i].h[1];
> +    }
> +}
> +
> +#endif
> diff --git a/target/hexagon/machine.c b/target/hexagon/machine.c
> index 6a41551d8f..4d2b09c519 100644
> --- a/target/hexagon/machine.c
> +++ b/target/hexagon/machine.c
> @@ -5,23 +5,67 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include "migration/cpu.h"
> +#include "migration/qemu-file-types.h"
>   #include "migration/vmstate.h"
>   #include "cpu.h"
>   #include "cpu_helper.h"
> +#include "macros.h"
> +#include "hlx/hlx.h"
> +#include "hw/hexagon/hexagon_hlx.h"
>   
>   static int hexagon_cpu_post_load(void *opaque, int version_id)
>   {
>       HexagonCPU *cpu = opaque;
>       CPUHexagonState *env = &cpu->env;
> +    uint32_t ccr;
> +    bool xe3;
> +    uint32_t xa3;
>   
>       hexagon_hvx_select_context(env, env->t_sreg[HEX_SREG_SSR]);
> +    if (!cpu->hlx) {
> +        env->hlx_ctx = NULL;
> +        return 0;
> +    }
>   
> +    ccr = env->t_sreg[HEX_SREG_CCR];
> +    xe3 = GET_FIELD(CCR_XE3, ccr);
> +    xa3 = GET_FIELD(CCR_XA3, ccr);
> +    env->hlx_ctx = xe3 ? hexagon_hlx_get_context(cpu->hlx, xa3) : NULL;
>       return 0;
>   }
>   
> +static int get_hlxvector(QEMUFile *f, void *pv, size_t size,
> +                         const VMStateField *field)
> +{
> +    HLXVector *v = pv;
> +    for (int i = 0; i < HLX_VEC_SIZE_BYTES / 8; i++) {
> +        v->ud[i] = qemu_get_be64(f);
> +    }
> +    return 0;
> +}
> +
> +static int put_hlxvector(QEMUFile *f, void *pv, size_t size,
> +                         const VMStateField *field, JSONWriter *vmdesc)
> +{
> +    HLXVector *v = pv;
> +    for (int i = 0; i < HLX_VEC_SIZE_BYTES / 8; i++) {
> +        qemu_put_be64(f, v->ud[i]);
> +    }
> +    return 0;
> +}
> +
> +static const VMStateInfo vmstate_info_hlxvector = {
> +    .name = "hlxvector",
> +    .get  = get_hlxvector,
> +    .put  = put_hlxvector,
> +};
> +
> +#define VMSTATE_HLXVECTOR_ARRAY_V(_f, _s, _n, _v) \
> +    VMSTATE_SUB_ARRAY(_f, _s, 0, _n, _v, vmstate_info_hlxvector, HLXVector)
>   const VMStateDescription vmstate_hexagon_cpu = {
>       .name = "cpu",
> -    .version_id = 3,
> +    .version_id = 4,
>       .minimum_version_id = 2,
>       .post_load = hexagon_cpu_post_load,
>       .fields = (const VMStateField[]) {
> @@ -38,6 +82,7 @@ const VMStateDescription vmstate_hexagon_cpu = {
>           VMSTATE_UNUSED(sizeof(uint64_t)),
>           VMSTATE_UINT32(env.imprecise_exception, HexagonCPU),
>           VMSTATE_UINT32_V(env.cfi_active, HexagonCPU, 3),
> +        VMSTATE_HLXVECTOR_ARRAY_V(env.future_LRegs, HexagonCPU, NUM_LREGS, 4),
>   
>           VMSTATE_END_OF_LIST()
>       },
> diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
> index 6076a5f29f..477c8d6b66 100644
> --- a/target/hexagon/op_helper.c
> +++ b/target/hexagon/op_helper.c
> @@ -1356,6 +1356,12 @@ void HELPER(modify_ssr)(CPUHexagonState *env, uint32_t new, uint32_t old)
>       hexagon_modify_ssr(env, new, old);
>   }
>   
> +void HELPER(modify_ccr)(CPUHexagonState *env, uint32_t new, uint32_t old)
> +{
> +    BQL_LOCK_GUARD();
> +    hexagon_modify_ccr(env, new, old);
> +}
> +
>   static void hex_k0_lock(CPUHexagonState *env, uint32_t PC)
>   {
>       HexagonCPU *cpu = env_archcpu(env);
> diff --git a/target/hexagon/reg_fields_def.h.inc b/target/hexagon/reg_fields_def.h.inc
> index 21babbbb98..a490b0e07f 100644
> --- a/target/hexagon/reg_fields_def.h.inc
> +++ b/target/hexagon/reg_fields_def.h.inc
> @@ -130,10 +130,12 @@ DEF_REG_FIELD(CCR_HFIL2, 18, 1)
>   DEF_REG_FIELD(CCR_HFDL2, 19, 1)
>   DEF_REG_FIELD(CCR_SFD, 20, 1)
>   
> +DEF_REG_FIELD(CCR_XA3, 21, 1)
>   DEF_REG_FIELD(CCR_GIE, 24, 1)
>   DEF_REG_FIELD(CCR_GTE, 25, 1)
>   DEF_REG_FIELD(CCR_GEE, 26, 1)
>   DEF_REG_FIELD(CCR_GRE, 27, 1)
> +DEF_REG_FIELD(CCR_XE3, 28, 1)
>   DEF_REG_FIELD(CCR_VV1, 29, 1)
>   DEF_REG_FIELD(CCR_VV2, 30, 1)
>   DEF_REG_FIELD(CCR_VV3, 31, 1)
> diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
> index 91925d2ddb..ed246e226f 100644
> --- a/target/hexagon/translate.c
> +++ b/target/hexagon/translate.c
> @@ -345,6 +345,7 @@ static bool need_slot_cancelled(Packet *pkt)
>   static bool sreg_write_ends_tb(int reg_num)
>   {
>       return reg_num == HEX_SREG_SSR ||
> +           reg_num == HEX_SREG_CCR ||
>              reg_num == HEX_SREG_STID ||
>              reg_num == HEX_SREG_IMASK ||
>              reg_num == HEX_SREG_IPENDAD ||
> @@ -986,6 +987,13 @@ static void gen_sreg_writes(DisasContext *ctx)
>               tcg_gen_mov_tl(hex_t_sreg[reg_num], ctx->t_sreg_new_value[reg_num]);
>               gen_helper_modify_ssr(tcg_env, ctx->t_sreg_new_value[reg_num],
>                                     old_reg);
> +        } else if (reg_num == HEX_SREG_CCR) {
> +            tcg_gen_mov_tl(old_reg, hex_t_sreg[reg_num]);
> +            tcg_gen_mov_tl(hex_t_sreg[reg_num], ctx->t_sreg_new_value[reg_num]);
> +            gen_helper_modify_ccr(tcg_env, ctx->t_sreg_new_value[reg_num],
> +                                  old_reg);
> +            /* A CCR write can change context, so end the TB. */
> +            ctx->base.is_jmp = DISAS_NORETURN;
>           } else if ((reg_num == HEX_SREG_STID) ||
>                       (reg_num == HEX_SREG_IMASK) ||
>                      (reg_num == HEX_SREG_IPENDAD) ||

