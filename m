Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06903CDB471
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 08:05:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbZeL-0001Q0-2Q; Mon, 22 Jun 2026 04:04:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wbZeK-0001Ph-3T
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 04:04:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wbZeI-0006US-49
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 04:04:55 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65M59Q2f3800850
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 08:04:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8pxC8uySDUu3vPuTVcIE2LHiRoUPrC08f5/xg7GC4bo=; b=b9YQpbLh4w47qABS
 YwkwDTe2iY/Hp6DaqA1n4CXzj/mgF2kpihdTwhuE644D0qpYWdS3rrZ3ZKQTjlhj
 MONCVSkrlpaAyROpe7hYiDcG9Zjnp0ytr0du5FzfZWgXib8DzpZf6RoaBze7VPr8
 n7BE4YSvypSkSFX3eOQ5bZJ5XS1X90C8YGUirqWc7VBeenD5C/9mS/CvGMsBu6MJ
 tdfXncZH8zDgI6GsyAAMAoxge4qoJtS5au2QF8FEe/cpe0EVmUjm40n4Nk57OcIg
 SyC4pUGly/dC5+LvZVkK3N+Fspw7uX8yJIIKkO00mmqhu6T+cyTWI1IT9zl1lnkc
 124spw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ewm1k58qw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 08:04:51 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8dba00e17b5so53130696d6.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 01:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782115490; x=1782720290; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8pxC8uySDUu3vPuTVcIE2LHiRoUPrC08f5/xg7GC4bo=;
 b=kvuEZ252sdrSfISUgSwmq95c05Zr2+n8baawgPvw0Lv0flziAKFcyJxI+axcRTnA6+
 +05PQkZSL0LPiyA6FWNyVLetYrH03jxiMRviTBzGWpj7qJw1cEyhXldx9TIbUmsARMCu
 IyAzp8MRM5XA+sSx2TYy67K/B2D1x/JWpIzhf7h195icJsR4nntX9tAQEDUMESER4+Yp
 C4h9l48W4Ioft/XiaThazraC9smSdZzKebM8BTmpvozbMoa+aknfYQa588VylTA1wSJx
 d2BdGktx2H/Z+cENXwERa+sf24/IbxUJtlGW0Blq/LZlcznMXf5dJJX8or+3Ly5G1yod
 HXnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782115490; x=1782720290;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8pxC8uySDUu3vPuTVcIE2LHiRoUPrC08f5/xg7GC4bo=;
 b=QsC+pwWZYnkCzMue+pfYQjS/JCr/5fFJF3eKTAmbDw37gnqcGlfFBi4/CTh6HdxKTm
 zivCvP2uEHdTch167j6fQhvwTTjkgl1MZ3lS0aRe4HBeJq9BABDA+gdyBq9n/nXanV68
 zKwapN5mkukVfMaZBjtlNuKC3KuD6eU74MkoKfJ7MbYjj+ORJK4DPjQjsdrUOzoKmiDh
 GhrN+4mVTf5QNsGkazkAHvEiSruBCls3QsrTeaQEUvNb2+p1e9udgGFa2/whoPealoYG
 G+HJ7QJIYp+65r8y0AOcAe3S8V36/6OwfE3Xwm4iN634URnfwB8p+cagN2AvaPAmB9i8
 purg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8p9SM6C2n3OoKe0AQ4HDsAQ+xFRidXI78jH2uzTvaWL7Ey/SWta13OPbfg5jI+ygfAQ39Wbti5/qHC@nongnu.org
X-Gm-Message-State: AOJu0YyN8qq9PPZzqaI+fdIWCqZnYLKbit51koqa58/AAon9uD4J7+eH
 urIbE4kv3euAcgQ1rOeyemnypj9FtMPqcEvvjkyHorf8Oa1ezlZrPq7JUDADAqzOxFq1cdnvw+A
 JOMGOzJLWfYyVfY3FyDiJ6hiUhYF6gBa7TzkqGyh+b83s320kdGo+4XOvHQ==
X-Gm-Gg: AfdE7clHW5Eh1ud0Off7eTDwGMNCOh/00qEOfi/VfqbQWBOdM4Pz7AD5BRZxGUJHaZx
 kjszAEFfAvwW8c72DfRp1WzG98uKH/dIvmMTAAPE3wC3eb1oQVeAFdZxdO7oJkefjKcqeMGfUMX
 TqNEzN/Zr17OV0xWtmMu8wsWqysJjlShZYxFiB5LanALF1YGLreLlyRp8hKHf+Pl6EDd4ltaE0S
 UvE93VjQvp0F5vrfOxoi6vwJo8T0R32AFyY52smBtuVVEF/axZAiHYMViZVV+QEu46nhXDfa9tS
 QlIAi1SFHi3y8Xc/kJCfpIsh1qy+MRG6LsVTfkNOuaMeiQnnmiCQk3+Lj1xgH8d+SazZjn9+MDK
 A5qoq8VAtJsgOqI0uvpZYgmpKXrJcAUlQcVKTVOjUsLzfF5HIixLeEStLzmgB3NWKXhE=
X-Received: by 2002:a05:620a:470e:b0:914:c0e8:242 with SMTP id
 af79cd13be357-9208ccfe1ebmr2118123385a.30.1782115490060; 
 Mon, 22 Jun 2026 01:04:50 -0700 (PDT)
X-Received: by 2002:a05:620a:470e:b0:914:c0e8:242 with SMTP id
 af79cd13be357-9208ccfe1ebmr2118118785a.30.1782115489479; 
 Mon, 22 Jun 2026 01:04:49 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492494496d8sm195433715e9.9.2026.06.22.01.04.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jun 2026 01:04:48 -0700 (PDT)
Message-ID: <83222104-c88d-4ed5-ad11-1dd4fbd2b11f@oss.qualcomm.com>
Date: Mon, 22 Jun 2026 10:04:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] hw/block: add SWIM2 floppy controller for q800
Content-Language: en-US
To: Matt Jacobson <mhjacobson@me.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>
References: <20260617235032.21491-1-mhjacobson@me.com>
 <20260617235032.21491-4-mhjacobson@me.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260617235032.21491-4-mhjacobson@me.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: eW8mercC7LyNG5HWidVG9osnUvSl4VlG
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDA3OCBTYWx0ZWRfXx01gMU2SVV4D
 Ui310I3YRsjR3BQW0UbqfVhnCof8bvWLkAIoxQzyvNOUQsUU4BX8O9WH35L2sC23Mv+Jmd3qsUj
 w5BCImiCJ5ovs0rN33UFzIuUlT/Sw5s=
X-Authority-Analysis: v=2.4 cv=T6S8ifKQ c=1 sm=1 tr=0 ts=6a38eca3 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=HHGDD-5mAAAA:8 a=KPJqd5kihLInaK8Iy9sA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDA3OCBTYWx0ZWRfXyL0OVinoWVCv
 c8u5JW2Zx1y8oxEfx4uXm4NILzYbyyrL7GPZREewD9zK9Mgsko/oAQDLRFhzf134FKW1vZxjnl3
 yGIdVi8oqy53tLyEQj+4SHqcCSCmHVEb6nqEIuIjh0Qq93SPEOJVXvKksldhX2kvi8+aUVeHYhv
 RRCacAMSTwXgdT5VwS/0hs5PED29/L3iEB9AJcGalPkM4YvPiaw3byLlSGNELmM4uGfUJFNSlxn
 d+gHI2MNvcIpXe+8HdrSmRvAmH57hlsGsgamKFlBcdwodQMUoOoGEgH0/YP36M92Vgezdx/K7Ro
 KkDl/jpLbqLu8lYzClgM9CA1dOLlGf4FLhqXN8xQZMgJXVpbjs006vijMml+vjK3znA83YL6q3V
 d/C6Hbb0nlnprTQ7q0RZ9cGmoWvqGu310Ao1A6WHdMMNTMfbnkjHZLVosKRGhmd3tyJjzS2hIkO
 xYeM1aV3/0qqf6dK+LQ==
X-Proofpoint-ORIG-GUID: eW8mercC7LyNG5HWidVG9osnUvSl4VlG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_01,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 adultscore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220078
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

On 18/6/26 01:50, Matt Jacobson wrote:
> The Quadra 800 contains a SWIM2 floppy controller, which is a
> simplified revision of the original SWIM controller.  Implement it
> based on publicly available specs; a future commit will connect it
> to q800.
> 
> Signed-off-by: Matt Jacobson <mhjacobson@me.com>
> ---
>   hw/block/meson.build     |   2 +-
>   hw/block/swim2.c         | 722 +++++++++++++++++++++++++++++++++++++++
>   hw/block/trace-events    |   9 +
>   include/hw/block/swim2.h |  60 ++++
>   4 files changed, 792 insertions(+), 1 deletion(-)
>   create mode 100644 hw/block/swim2.c
>   create mode 100644 include/hw/block/swim2.h

> diff --git a/hw/block/swim2.c b/hw/block/swim2.c
> new file mode 100644
> index 0000000000..f10be40678
> --- /dev/null
> +++ b/hw/block/swim2.c
> @@ -0,0 +1,722 @@
> +/*
> + * QEMU Macintosh floppy disk controller emulator (SWIM2)
> + *
> + * Copyright (c) 2025 Matt Jacobson <mhjacobson@me.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include <assert.h>
> +#include <stdbool.h>
> +#include <stdint.h>

These 3 system headers are already provided by "qemu/osdep.h".

> +#include "qemu/log.h"
> +#include "qapi/error.h"
> +#include "hw/core/qdev-properties.h"
> +#include "hw/core/qdev.h"
> +#include "hw/core/sysbus.h"
> +#include "hw/block/sony_superdrive.h"
> +#include "hw/block/swim2.h"
> +#include "system/block-backend.h"
> +#include "system/blockdev.h"
> +#include "trace.h"


> +static const TypeInfo swim2_info = {
> +    .name = TYPE_SWIM2,
> +    .parent = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(SWIM2State),
> +    .instance_init = swim2_init,
> +    .instance_finalize = swim2_finalize,
> +    .class_init = swim2_class_init,
> +};
> +
> +static const TypeInfo swim2_bus_info = {
> +    .name = TYPE_SWIM2_BUS,
> +    .parent = TYPE_BUS,
> +    .instance_size = 0,
> +    .class_init = swim2_bus_class_init,
> +};
> +
> +static const TypeInfo swim2_drive_info = {
> +    .name = TYPE_SWIM2_DRIVE,
> +    .parent = TYPE_DEVICE,
> +    .instance_size = sizeof(SWIM2Drive),
> +    .class_init = swim2_drive_class_init,
> +};
> +
> +static void swim2_register_types(void)
> +{
> +    type_register_static(&swim2_info);
> +    type_register_static(&swim2_bus_info);
> +    type_register_static(&swim2_drive_info);
> +}

Preferably DEFINE_TYPES().

> +
> +type_init(swim2_register_types)


> diff --git a/include/hw/block/swim2.h b/include/hw/block/swim2.h
> new file mode 100644
> index 0000000000..72be21ea4e
> --- /dev/null
> +++ b/include/hw/block/swim2.h
> @@ -0,0 +1,60 @@
> +/*
> + * QEMU Macintosh floppy disk controller emulator (SWIM2)
> + *
> + * Copyright (c) 2025 Matt Jacobson <mhjacobson@me.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_BLOCK_SWIM2_H
> +#define HW_BLOCK_SWIM2_H
> +
> +#include <stdbool.h>
> +#include <stdint.h>

No need to include these system headers.

> +#include "hw/core/qdev.h"
> +#include "hw/core/sysbus.h"
> +#include "hw/block/block.h"
> +#include "hw/block/sony_superdrive.h"
> +#include "qemu/fifo32.h"
> +#include "qom/object.h"
> +
> +#define TYPE_SWIM2 "swim2"
> +#define TYPE_SWIM2_BUS "swim2-bus"
> +#define TYPE_SWIM2_DRIVE "swim2-drive"
> +
> +OBJECT_DECLARE_SIMPLE_TYPE(SWIM2State, SWIM2)
> +OBJECT_DECLARE_SIMPLE_TYPE(SWIM2Drive, SWIM2_DRIVE)
> +
> +#define SWIM2_MAX_FD 2
> +
> +struct SWIM2Drive {
> +    DeviceState parent_obj;
> +
> +    BlockConf conf;
> +    SonyDrive sony;
> +    int32_t unit;
> +};
> +
> +struct SWIM2State {
> +    SysBusDevice parent_obj;
> +
> +    MemoryRegion mmio;
> +    BusState *bus;
> +
> +    SWIM2Drive *drives[SWIM2_MAX_FD];
> +
> +    uint8_t parameter_data[4];
> +    uint8_t parameter_index;
> +    uint8_t phase_reg;
> +    uint8_t setup_reg;
> +    uint8_t mode_reg;
> +    uint8_t error_reg;
> +    bool did_handshake;
> +    bool wait_for_mark;
> +
> +    Fifo32 fifo;
> +};
> +
> +void swim2_set_sel(SWIM2State *ctrl, bool sel);
> +
> +#endif /* HW_BLOCK_SWIM2_H */


