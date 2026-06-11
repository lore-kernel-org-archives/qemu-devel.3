Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2BBACD98C7
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 18:38:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXkIA-00025U-U1; Thu, 11 Jun 2026 14:38:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXkI9-000256-8H
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 14:38:13 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXkI7-0004sf-6a
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 14:38:13 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65BIQFdE1398287
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 18:38:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 N+M3p5J9REGJXDuMEogfBCLafrrolYGy/B45Yp8mflM=; b=icU82okUU2WduMAS
 bydJhToZfkA9aqPDjmVvvpqCQ6jcRCSe9oqtIPFR0LLDtjztZ4TvpPg9o6wr623/
 dW1gpphYaXvd+cIA+8AIzS6bJCJKiL8CUMU3VrBXgodAY/kn4mxjm6DjQiEU4RaV
 TzncnFqOy8tXioEnVBUH88B6U/QWHaZfSmwNcn14ooiUBoBE1K7l7qfKfTPEhBiN
 lKLrigsLltvqUYehqwf/uciC4yUdUblw7mwOhdSgCl7O5MPcvK59p/mn2G9K5kjO
 EU2nfERBJ6OBSBShi7AwTOc7xhMMnviaWS61qwjG52uL05VWJtpoJ7XGFkIUM+pS
 kQzUOA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er0x7gfw0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 18:38:08 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5174a23afcbso1006851cf.3
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 11:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781203087; x=1781807887; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=N+M3p5J9REGJXDuMEogfBCLafrrolYGy/B45Yp8mflM=;
 b=BsYt45iIcfAFHhGnqxx7v7zEcOSQ7rDbWnTyGw4fwkeB2rwpEiZWT5ie6kTXAZ0q9a
 tOEe+U8Fzsk7ESRqNnsedO0hUJDzu9ASxsxTi8eXgYOZgEYc/LWFT/AjaDKfZNFLYZo7
 YhHyeo3tdsCa7fpPr6K5FXttP2rIcUooNy5fnui1KKMgNh64eJ91NJ5CkAyr1nkMMjnx
 k/4srC3sa37BWcn+6QP4ixX5kxgEwMHZbg9gAoBk6aygAeTZ/1mviKzbtbKxKlUSBSNj
 rwMLjAWhRJvU9KE0T2KTxuB135wk0AGWY04zuIvPN+cOyX73XhYQc9ntZ4ZwJCZw1Fcf
 FR8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781203087; x=1781807887;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N+M3p5J9REGJXDuMEogfBCLafrrolYGy/B45Yp8mflM=;
 b=kP87UvfZNSnTwFWw3uSCDL048Wklw0b1DJH6J8PN3RPAjVTffV3HY5zFaKPRFWDIX4
 JQ1Z/8o2CkvKjqJGLWfV9UURl4d8SjE8ardGK+8eKEedxS5j0vTEp+1idgR/Yy+fGVDm
 GpmByN/18F5mFXHh+22TshJEL7POb/bRP82xHBmHvNAfrvPXkfTzl9xtpCPVAOE1u3Td
 tCd/HKxb/0QbG6j8/VAQy34JfQL2alVpn7glOcTtRUmqXmfQjObspH09ayXMA8jSkmIM
 ddFy6AGS9F3g+/ARgUPnDxzzsBjtKcst0sWqpRRiXnj7//IKUMsc1XBDrYpev7g8ILmw
 TqZQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/XXC8bFgAa4e0/M81nioMJi3obdP73BbsSSZdzOkrjSp/H6GCJTVV1TqFhrPaWMoIW9Q4EmC1a2mh4@nongnu.org
X-Gm-Message-State: AOJu0YyPQmUajpiQZoOjEe4ZgK4su2T2TQyJdTDhbWhJtRZ7lPJeXn6u
 SQiLnk8Ay5I/1glrKGeK3eeCCsIkvTBXyLpox3OWbRG1YakihvEU6veiZ20MxYv0hk09kpozfn4
 I7B7TwhB032cPje7zaxIlLpvS5Ma3AWg+9zgAZHI4PscUGVk6xZj/q4VUVQ==
X-Gm-Gg: Acq92OFdFNe2Wnl7rvUfiNi0vwfcowjlliupEQyhV78Ldsai/mkdsuSMALVZ7Xtiz2a
 EXBxqw4yME9jQP30FlJMmGl1AFJnURPC3mqoyYVvfo6ZjuE8BqqXHUKjLZGCQdFRdAaoQIxfFzo
 BpFasBdh9rIIgR0Ut32Om99Ln4ojGicDwgpofSf+ZwQrgdb0Ts0ho86OcTYVqYQXKMzSb2Bi4tG
 VsN4QSgW/Q/PP78A/4EI5FsOQcRAhZI2Th8+es9svbmkA10covKN4cu6VCmbkPQXcWxqH+B5lDa
 cNgH0Fjqvs+zsrpr0bhN6Gt0NsUPgdyonoAU1xtpdYojbGUEvsgFcYhGMnlSN7q/c7IlJFjMhIE
 BhsKMu6YSpXYc2kEDTVnAWOl4+xpgrJff1WoPYPwHKljEhIIBoPqgMvrnLbO1yxBFSHk12RBPc9
 XvoQ==
X-Received: by 2002:a05:622a:130a:b0:517:75d8:b95d with SMTP id
 d75a77b69052e-517ee2141d3mr57914611cf.40.1781203087421; 
 Thu, 11 Jun 2026 11:38:07 -0700 (PDT)
X-Received: by 2002:a05:622a:130a:b0:517:75d8:b95d with SMTP id
 d75a77b69052e-517ee2141d3mr57913961cf.40.1781203086766; 
 Thu, 11 Jun 2026 11:38:06 -0700 (PDT)
Received: from [192.168.69.232] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490e2c7ea52sm91407815e9.2.2026.06.11.11.38.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jun 2026 11:38:06 -0700 (PDT)
Message-ID: <9b3384bd-bf7f-433e-8427-7b278bb7ff8d@oss.qualcomm.com>
Date: Thu, 11 Jun 2026 20:38:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 1/4] hw/mem: add sp-mem device for Specific Purpose
 Memory
Content-Language: en-US
To: fanhuang <FangSheng.Huang@amd.com>, qemu-devel@nongnu.org,
 david@kernel.org, imammedo@redhat.com, gourry@gourry.net
Cc: Zhigang.Luo@amd.com, Lianjie.Shi@amd.com
References: <20260611100637.2460507-1-FangSheng.Huang@amd.com>
 <20260611100637.2460507-2-FangSheng.Huang@amd.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260611100637.2460507-2-FangSheng.Huang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: gLN2mrmE1LJZjE9e27hEupMxg-EjFFqF
X-Authority-Analysis: v=2.4 cv=c4abhx9l c=1 sm=1 tr=0 ts=6a2b0090 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=zd2uoN0lAAAA:8 a=FmMMexCXBUatOKZlFeEA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDE4NyBTYWx0ZWRfXxktCs07Kqw7P
 aAyIQKISFTa7O2p3Kp772dpYFItteKv/1j+/WXx27seKIOgpJy4f7iQXfqRTZMZAKTdyn4OkDH3
 0CBCdfEARPht2HxnEM0dzlRMxTm0osh5ePJey8kH08Ji3GfxhOKdy3ZlvQ76mVm1SUwBnprL7Ix
 sxvcZPd+k688XdSQ2SKbHn7H2sei8lZx6N91DfkVdjcVJ3G5VxiHl253QAysUKfCCuZ/+VHoeK9
 ppHN8uCBMA80zVke4e50mziMME1eHaWB6kjbzIyhchxoKmN/ExnvchqtEmt2pEiRsUPrSnGCBjb
 D1vHap4bkb9ybrcz3DH6QRcxKOjhpTEJb7mFfGs3lG+2EqLMJanxWYeuQwX9f9OiQLIxkc7UCeq
 8lhpAdRuhq5JWfFBHASimGQvJCSOwpORQL87wFlzmU5Ow38am2fB6NkNMv32DTfd0+cD1ZQSxt6
 10h4h7gRvM95T0hO/Ug==
X-Proofpoint-ORIG-GUID: gLN2mrmE1LJZjE9e27hEupMxg-EjFFqF
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDE4NyBTYWx0ZWRfX+jfKTdKBgsqT
 ueQWleyKbSqRPBs2hFtYnVEmu/9dMrDitm5mbfDFlOdnEAMjadLbZC6Rt9h6um03XGgCDJ2HmPG
 /Q5A2SmCpxJd4fegCbmB0GOewhKoOK8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_04,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 malwarescore=0 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110187
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 11/6/26 12:06, fanhuang wrote:
> Introduce a TYPE_MEMORY_DEVICE subclass `sp-mem` for boot-time
> SOFT_RESERVED memory exposed to the guest with a per-device NUMA
> proximity domain.
> 
> The device targets accelerator memory (HBM and similar) that the
> firmware hands to the guest OS as SOFT_RESERVED memory, so a driver
> in the guest -- rather than the kernel's general allocator -- owns
> the range.
> 
> Usage:
> 
>      -object memory-backend-ram,id=spm0,size=$SIZE
>      -numa node,nodeid=$N
>      -device sp-mem,id=dev0,memdev=spm0,node=$N[,addr=$GPA]
> 
> The device is boot-time only (no hotplug).
> 
> Signed-off-by: FangSheng Huang <FangSheng.Huang@amd.com>
> ---
>   qapi/machine.json          |  43 +++++++++++-
>   include/hw/mem/sp-mem.h    |  35 ++++++++++
>   hw/core/machine-hmp-cmds.c |  11 +++
>   hw/mem/sp-mem.c            | 136 +++++++++++++++++++++++++++++++++++++
>   hw/mem/Kconfig             |   4 ++
>   hw/mem/meson.build         |   1 +
>   6 files changed, 228 insertions(+), 2 deletions(-)
>   create mode 100644 include/hw/mem/sp-mem.h
>   create mode 100644 hw/mem/sp-mem.c


> diff --git a/include/hw/mem/sp-mem.h b/include/hw/mem/sp-mem.h
> new file mode 100644
> index 0000000000..5c0b6ec4f8
> --- /dev/null
> +++ b/include/hw/mem/sp-mem.h
> @@ -0,0 +1,35 @@
> +/*
> + * Specific Purpose Memory (SPM) device
> + *
> + * TYPE_MEMORY_DEVICE subclass for boot-time-only memory exposed to the
> + * guest as an E820 SOFT_RESERVED range with a SRAT memory-affinity entry.
> + *
> + * Copyright (c) 2026 Advanced Micro Devices, Inc.
> + *
> + * Authors:
> + *  FangSheng Huang <FangSheng.Huang@amd.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef QEMU_SP_MEM_H
> +#define QEMU_SP_MEM_H
> +
> +#include "hw/mem/memory-device.h"

Not needed AFAICT.

> +#include "hw/core/qdev.h"
> +#include "qom/object.h"
> +#include "system/hostmem.h"

Not needed (HostMemoryBackend is forward declared in "qemu/typedefs.h").

> +
> +#define TYPE_SP_MEM "sp-mem"
> +
> +OBJECT_DECLARE_SIMPLE_TYPE(SpMemDevice, SP_MEM)
> +
> +struct SpMemDevice {
> +    DeviceState parent_obj;
> +
> +    HostMemoryBackend *hostmem;
> +    uint32_t node;
> +    uint64_t addr;
> +};


> diff --git a/hw/mem/sp-mem.c b/hw/mem/sp-mem.c
> new file mode 100644
> index 0000000000..d0244a8f70
> --- /dev/null
> +++ b/hw/mem/sp-mem.c
> @@ -0,0 +1,136 @@
> +/*
> + * Specific Purpose Memory (SPM) device
> + *
> + * Copyright (c) 2026 Advanced Micro Devices, Inc.
> + *
> + * Authors:
> + *  FangSheng Huang <FangSheng.Huang@amd.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/module.h"
> +#include "qapi/error.h"
> +#include "hw/core/qdev-properties.h"
> +#include "hw/core/qdev.h"
> +#include "hw/mem/sp-mem.h"
> +#include "hw/mem/memory-device.h"
> +#include "migration/vmstate.h"
> +#include "system/hostmem.h"
> +
> +#define SP_MEM_MEMDEV_PROP    "memdev"
> +#define SP_MEM_NODE_PROP      "node"
> +#define SP_MEM_ADDR_PROP      "addr"
> +
> +static const Property sp_mem_properties[] = {
> +    DEFINE_PROP_LINK(SP_MEM_MEMDEV_PROP, SpMemDevice, hostmem,
> +                     TYPE_MEMORY_BACKEND, HostMemoryBackend *),
> +    DEFINE_PROP_UINT32(SP_MEM_NODE_PROP, SpMemDevice, node, 0),
> +    DEFINE_PROP_UINT64(SP_MEM_ADDR_PROP, SpMemDevice, addr, 0),
> +};
> +
> +static uint64_t sp_mem_get_addr(const MemoryDeviceState *md)
> +{
> +    return object_property_get_uint(OBJECT(md), SP_MEM_ADDR_PROP,
> +                                    &error_abort);
> +}
> +
> +static void sp_mem_set_addr(MemoryDeviceState *md, uint64_t addr,
> +                            Error **errp)
> +{
> +    object_property_set_uint(OBJECT(md), SP_MEM_ADDR_PROP, addr, errp);
> +}
> +
> +static MemoryRegion *sp_mem_get_memory_region(MemoryDeviceState *md,
> +                                              Error **errp)
> +{
> +    SpMemDevice *spm = SP_MEM(md);
> +
> +    if (!spm->hostmem) {
> +        error_setg(errp, "'memdev' property must be set");

Already checked in Realize? Or is this for the introspection test?
If so, use SP_MEM_MEMDEV_PROP like in Realize.

> +        return NULL;
> +    }
> +    return host_memory_backend_get_memory(spm->hostmem);
> +}
> +
> +static void sp_mem_fill_device_info(const MemoryDeviceState *md,
> +                                    MemoryDeviceInfo *info)
> +{
> +    SpMemDeviceInfo *di = g_new0(SpMemDeviceInfo, 1);
> +    SpMemDevice *spm = SP_MEM(md);
> +    DeviceState *dev = DEVICE(md);
> +
> +    di->id = dev->id ? g_strdup(dev->id) : NULL;
> +    di->addr = spm->addr;
> +    di->size = memory_region_size(
> +                   host_memory_backend_get_memory(spm->hostmem));
> +    di->node = spm->node;
> +    di->memdev = object_get_canonical_path(OBJECT(spm->hostmem));
> +
> +    info->u.sp_mem.data = di;
> +    info->type = MEMORY_DEVICE_INFO_KIND_SP_MEM;
> +}
> +
> +static void sp_mem_realize(DeviceState *dev, Error **errp)
> +{
> +    SpMemDevice *spm = SP_MEM(dev);
> +
> +    if (!spm->hostmem) {
> +        error_setg(errp, "'%s' property is required", SP_MEM_MEMDEV_PROP);
> +        return;
> +    }
> +    if (host_memory_backend_is_mapped(spm->hostmem)) {
> +        error_setg(errp, "memory backend '%s' is already in use",
> +                   object_get_canonical_path_component(OBJECT(spm->hostmem)));
> +        return;
> +    }
> +    host_memory_backend_set_mapped(spm->hostmem, true);
> +}
> +
> +static void sp_mem_unrealize(DeviceState *dev)
> +{
> +    SpMemDevice *spm = SP_MEM(dev);
> +
> +    host_memory_backend_set_mapped(spm->hostmem, false);
> +}
> +
> +/* boot-time only; no plug/unplug state to migrate */

Please move that comment ...

> +static const VMStateDescription vmstate_sp_mem = {
> +    .name = TYPE_SP_MEM,

... here.

> +    .unmigratable = 1,
> +};
Only minor comments, patch LGTM otherwise!

