Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13CEBC61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 17:16:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzHE9-0005hg-Ho; Wed, 26 Aug 2026 13:15:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzHE1-0005gv-3g
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 13:15:45 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzHDy-00081Y-Ga
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 13:15:44 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QGum9s1522385
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 17:15:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bktZ5UDV74FzmlTBZeBb+5Q5a/AQJS8HbxGNS1zKGX8=; b=PF/WQexwew3pKYOH
 xbFS1szOxkt94le0+pE5fGOZpTuGxOxyMxzfUZp4gER5ZOYRzglhaf/02dOy7iZp
 rPxqo2lzgc8vZoKx/5OnaGHc1RDEdeoNpmF5HB/QQn/99nitYPrWT3obPXODnVR+
 Rc5pUKidA/fIEZB5ytTaaaap/RSMaY4fwvp2m630xl8MMXBX8Bk90b0+qyk+AlUJ
 /5IV70AOfeuZAbTU0D8U3vqZi1T/Bh13tvObvprSmA0WncKHmGw0/6xPp7miCKGo
 BnVn+EKyJk1DC3vxuVYAjeDMwgzbeyCojDHSrmGpR7QLnEL0MGJ4+SE0e05NZ0wf
 DsbpcA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9r0k38cm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 17:15:40 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c19493ac2so13751981cf.1
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 10:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787764539; x=1788369339; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bktZ5UDV74FzmlTBZeBb+5Q5a/AQJS8HbxGNS1zKGX8=;
 b=Lb5FNAe+SHPSSMxSYmJqBY1l9na/HTC/noXzd3u7BPj2FIEgAuxQM8dfHAUo8lzzUR
 ATykDEGu6GureuzG3pKWv9H2Q8Cz8zTlTfnfuUQZD/ZY0NklqzPs7GAezvFdv0wwqhki
 sebzxrXNNxBD2D3KyNeWcjR1XsbJ+1l3yUOjB3LKDVQB/YjOGdFbHHEXGT3Zo+6zV1M1
 Exhcp0S9gLK5s2hbKpN402bG32TbVmSufQYJJT6JbQHUyhPZem/zd7e9rlIiIQrcz3DD
 I6+bWDVc6fY03pue8W9OpP0LYfNqtnBmOOqDwqMgFDkPNNmpVvjNIpJ6AvkxfsyAYKe+
 9NyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787764539; x=1788369339;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bktZ5UDV74FzmlTBZeBb+5Q5a/AQJS8HbxGNS1zKGX8=;
 b=oXqls/RyjUnFHXzyIIz98Xm6jTUV0LMwjd7sRMqtl9G9LKW8bZ8fvQPnFeXUZx6ezf
 AXqAWMZ1eP+x8dE4TLGCOEbeW0lyASVwB0fn7NjUee1Hv57mWJ4xxWIHHGL++GOqAULJ
 haD8JJg9+CP8pPXLwlSyxPCLU6rZvgHJSNRv91q91wuTqJJ2zLL28I6s6MIIKtv/a3Yf
 7drri20A6dzP74HGdjSpqP3Cezysf/59zCt9B6RWI6gYClukttZf4+EaZoZPMnuENFFk
 UK5DLPBuHGzFHxlZd0fM8ZnRPT21lPWS8B7r4GTzLFMdEQQGVo1vMIqXRtBCaYGOa5cu
 thbQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpQiHA5PPo5zdzWNdEjeAdc1YqEjchS3CWR54sjGRLJ7J+yqxOTelQELIQut2XrT5q1EJbiVO4cSxkw@nongnu.org
X-Gm-Message-State: AFuF++leTJDUnasSSRLOScFXOZnOCvmuqNzr/qXFw0/81AxsPPfByQlx
 LnHzEl2D9lViLy8SEk02ebQdpzWhThHou5YgVeNqzKVJfgtbfpvxYetWJNYMGlLphtTBbv/Y/hB
 CnlGSdCV1D8oCmnQQEhukT9jAfyXt51i5mhsQuD67tGSTcfxe5PzPS3Ji29Juadfzuw==
X-Gm-Gg: AR+sD10McmqReHurbmu7aELHWy7qPGDHoOZcO+2iWktHPfpjlEDEFtLFcOYx7KBnWNt
 uq3KF8pIqdFG0Pq9+zbXfUFXa2LFphDmickrypWwbCgAgKPogs/rAWRmbtRg0joHWoZyJRQHfrA
 v01JsMBdlMK1O8ct+aBGAIOj0aanLcrOAPLfGRSsDM5PRT7FjixUDTKT3TUH5Oi/NCWqq+8+iJx
 a1XRViWJ9xWbqDJzxmNQrLtbZv5/GfiI7CYnJB92nAauZpHKp7SRZ6p4V/zO2sWaNYmRszz4qkD
 KCURYa/3huHNzIuaXWkcnGP3xdDM7v1wkyC3bjl8j7qBm1607zjwQpfMtPrPIbdKvQHdbskIUon
 dn6z7N2YSsp3ueKS5XOpuGxHi18Mz0MNX4l6hlNK5Yp2w
X-Received: by 2002:a05:622a:1308:b0:52b:6543:d8b with SMTP id
 d75a77b69052e-52e4228d1f7mr86394161cf.12.1787764539210; 
 Wed, 26 Aug 2026 10:15:39 -0700 (PDT)
X-Received: by 2002:a05:622a:1308:b0:52b:6543:d8b with SMTP id
 d75a77b69052e-52e4228d1f7mr86393121cf.12.1787764538766; 
 Wed, 26 Aug 2026 10:15:38 -0700 (PDT)
Received: from [10.254.188.74] (134.171.88.92.rev.sfr.net. [92.88.171.134])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a6fda44sm655266366b.14.2026.08.26.10.15.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 10:15:37 -0700 (PDT)
Message-ID: <51f3a71d-0585-4bbb-9cdc-7a4dce5808f3@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 19:15:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/13] hw/riscv/device-common, virt.c: add
 create_platform_bus()
Content-Language: en-US
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>
References: <20260826164814.44335-1-daniel.barboza@oss.qualcomm.com>
 <20260826164814.44335-11-daniel.barboza@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260826164814.44335-11-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=fPEJG5ae c=1 sm=1 tr=0 ts=6a8f1f3c cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=o1isufRNksZXpKP+aqnsag==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=6F-_tfBp55IIpCGbshYA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE0NCBTYWx0ZWRfX5/JG0umpPair
 DAYRagzLDQbbWhKZYUJOiV6xvTkVR6b6RBOgGSugvvDjp1w5A561iUM11U2Ja37MjZdGIc1h3K3
 rceMH9ZpkqjDNrmMrWMOHGOhK2QmlnY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE0NCBTYWx0ZWRfX5DzZkAJ2IpdF
 kLej1dOnWzEwOvDGNEOTGA9ameox4s0AI3lXE8XNIp+HFX3kuEOe1WBHSBAyGoGmVJYtXh+tqj0
 uUATwWVw3v5ymaeDURi9QSzvFqmZS8QWKRWT1RgiIFfxxQYJNSzmxFSqMk209w89ClFITe8p7AP
 ceC4D1YlXcW05ncFZ26eB9efG9kSi9jvHoYTejxeAd5Yt2RdeeV++/ZHwXrdpiOZHXwAycw7MHU
 JDXRuJNjNY1ggt96hXP39M6EWK9TOaFbFrzRt10wwQi+ET5lCS68jnfKxszXrIhOz1XKj+hk5Hh
 z4t1xIRe1ZV6RFqJZkJr1ba/S65SlhP3bc2yIjyMUPflf6vQMCY2ifAdI9HhCglvVRbcmSlY5Wu
 nSVUkOEoUNU5GyQdAzxzh9p2mBXIbmyBwT0rhYOLQbICdTCnT2UkZxzEC65uhJK8MuP1+0wBrM2
 7uxfy2KFcVrSOH0u7dA==
X-Proofpoint-ORIG-GUID: KGlIn5AN9ZN6sO9GZjA2RdWvD0WOtLyn
X-Proofpoint-GUID: KGlIn5AN9ZN6sO9GZjA2RdWvD0WOtLyn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_05,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 adultscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
> There will be code repetition instances added by the 'riscv-server-ref'
> board w.r.t device creation and initialization.  Instead of waiting for
> that code to land we're adding helpers beforehand.  The idea is to make
> the new board code shorter and more palatable for reviewers.
> 
> A new 'device-common' file is created for such helpers.  We'll start
> with the platform bus, a nice piece of software that only the 'virt'
> board uses so far, and the 'riscv-server-ref' will use to support TPM
> devices.
> 
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> ---
>   hw/riscv/device-common.c         | 48 ++++++++++++++++++++++++++++++++
>   hw/riscv/meson.build             |  1 +
>   hw/riscv/virt.c                  | 31 ++++-----------------
>   include/hw/riscv/device-common.h | 19 +++++++++++++
>   4 files changed, 73 insertions(+), 26 deletions(-)
>   create mode 100644 hw/riscv/device-common.c
>   create mode 100644 include/hw/riscv/device-common.h


> diff --git a/include/hw/riscv/device-common.h b/include/hw/riscv/device-common.h
> new file mode 100644
> index 0000000000..f91c39511f
> --- /dev/null
> +++ b/include/hw/riscv/device-common.h
> @@ -0,0 +1,19 @@
> +/*
> + * RISC-V board helpers for FDT generation.
> + *
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef RISCV_DEVICE_COMMON_H
> +#define RISCV_DEVICE_COMMON_H
> +
> +#include "exec/hwaddr.h"
> +#include "hw/core/qdev.h"
> +
> +DeviceState *create_platform_bus(DeviceState *irqchip,
> +                                 const MemMapEntry *platform_bus_mem,
> +                                 int platform_bus_base_irq,
> +                                 int platform_bus_num_irqs);

Ditto 'riscv_' prefix.

> +#endif


