Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89C83C4451C
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 12:57:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wki7D-0006iR-SH; Fri, 17 Jul 2026 08:56:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wki7A-0006gP-Q2
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 08:56:28 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wki77-0003WT-O5
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 08:56:28 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66HCTCdY1589780
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 12:56:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CALqcIXBn7lGkAEi/ogHX1RC+WA//XGozNhIeFuLvZE=; b=CXI4tui3/lCT7TK3
 RudTVfu7go19HQxQx0eEebQFYWAhmfOiRwoqn0ulQ5PXmLLqz8M0mZtKZslMdsbc
 J1Rn31ZnFXTm2SRNQKWkKeflyJxY1tmyr6czismlSSG11oem/W3ccCmh+O2JoCYn
 ViXGCbld3UNjLUifvNj/7IOJjLgNzG/Xdteu5v7SEDcpsj5amEDBF2PP4tWfPH6Z
 xHB1DwG+WQSbVJxR0t8KPuZL7AVg7xvPQIBxM429lcPYXFNUX24UVrRKtwUKMovi
 B2dk9FzMsGkmFUnIQDGFtmpLyBmRIER/a5Ny0a4WJ2hdL5gE/PS/hzoWr/1x5x1f
 qjgkyg==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ff3u8krw1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 12:56:23 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-81ee7494b6aso46105197b3.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 05:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784292983; x=1784897783; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=CALqcIXBn7lGkAEi/ogHX1RC+WA//XGozNhIeFuLvZE=;
 b=fRUu1grLj5PyKUzXHtwaLIOokJ9THwCTUi7Yw+V3u6y7ZS1x85qBLI4VkN3YR//wTl
 /Qlg6C4lNKE5QTu/qK13oNM7PZJVbywO1oJityXxgf8KBM0SlROCBifUunCnYhtA8Mcl
 LPAlC4e8RGTRnIO2a6Kid1FcpfO5j8QrCQydQ8Gk8R/24+NYRsYGZuqTRSfqdM96odxr
 L/BE+NMSBx6qLeG5yCkAEaIyPAd4BChF4PldR/pPzKdRQBhWBeSgEXi1yWl8uuWvRbXs
 4L3TzTly5zYgHs5jCtk2XFMhs76/+b0aALsV0Z32qtMftjr+IX1SdskE6ZNRvV2U61eJ
 8rRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784292983; x=1784897783;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CALqcIXBn7lGkAEi/ogHX1RC+WA//XGozNhIeFuLvZE=;
 b=CGxLiXg4BbO9DrZ1kHVuFC4aW4WeCHlzn3Ph6epCLY5j0thlwjbI9k0C5LuPuSPj5P
 IBfKNO0Gy15C+uteeDDeKs/UuYf2+/lqaM+6qH4dw0yjtUlciaCKQ6vnNm7Xehl2yQYU
 +wgVVsKTXz1aZcHcr/C0so/zd7BhV0GSrgU68s/T3uv2kQgsLOrVCfMmAKlX4jjTqvqx
 wrIwHwoXZMyGPCTrbzM7/hIQd5uIOJ+Ev56YCNsGUG7HToteI4flZ59T/lDKV2PLoGrc
 Zol3i/f37Iv6XYQRx0Nc4fGSxwBDGmcsevQhTYh4+WpwGWAPaYOmCgpzklDMiOCM45sy
 1vHg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqVlUUELUAXPfpMCv3a8BnUJNitojRhrOQRV8y1/WIya/rXMaFvzjjIFOLIe+f6uvcgg1UOF3fVjmvA@nongnu.org
X-Gm-Message-State: AOJu0YzT+I0PchyEqhUNRBD1iLSZDmimzu26qB0ovt4Ekx2Go47chhak
 LKZ/cif8hvzqZZphH2ELF2m7awMqAihA7c2vbH4SwGbYVLvCE6DQZRwlD+Tu0fsjAwiqPZxSRFV
 tYzw2ap7rD7x7n4Er216XoVeqhTGxfu7FxUNOgTA/m7m+vJEmhmOX90x5UA==
X-Gm-Gg: AfdE7ckTQ42aiKnWl9fahNOWuyWc3oJn0Jxwd346CkXnmMJp/W79eYbNo5jr4FXoRfx
 7hh/eL89oKhSzwjyEKEUozPwSxeNRjnrYg6H7LeWUNxNilBnMe2nY8/0WT8aId47V8MxM2Xi1x0
 PIRphCF1EpFXt1uteSmIqGnj7opp5TvfynQy6PF0LW3Zhq3szOZBxN+BAhwX3DqWu++BAKnLTCT
 Cz0mAbH1MO7Lt1CMGze9xJKDvhRP2aaaQGOCb+z5DZvX5TsscPYb9VJxAC8VchrRcPCxmFRJEeG
 MrH6KenWWgumYzErAjVeom5izRSjXMpzD3OoRGVoNeW33RpJ+xBvp581EQk7sLcJAWE6pWlC3DS
 0l2Nz1gUANLjO/lz4W+gGskbutxWNwcJcMPGAvA==
X-Received: by 2002:a05:690c:62c6:b0:81e:d001:e0ca with SMTP id
 00721157ae682-81ef158e2d2mr8985997b3.17.1784292982905; 
 Fri, 17 Jul 2026 05:56:22 -0700 (PDT)
X-Received: by 2002:a05:690c:62c6:b0:81e:d001:e0ca with SMTP id
 00721157ae682-81ef158e2d2mr8985847b3.17.1784292982421; 
 Fri, 17 Jul 2026 05:56:22 -0700 (PDT)
Received: from [192.168.68.105] ([152.234.122.204])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-81ef42e89e8sm8275317b3.44.2026.07.17.05.56.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jul 2026 05:56:21 -0700 (PDT)
Message-ID: <9d36c8c4-f5db-4fa0-ac79-c06bde8086a2@oss.qualcomm.com>
Date: Fri, 17 Jul 2026 09:56:17 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/10] hw/riscv: add RPMI FDT helpers
To: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
References: <20260714075659.2258023-1-subrahmanya.lingappa@oss.qualcomm.com>
 <20260714075659.2258023-4-subrahmanya.lingappa@oss.qualcomm.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260714075659.2258023-4-subrahmanya.lingappa@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: SmOhZGw-43iJWo3sWctK1oQ4JaTK21f0
X-Proofpoint-ORIG-GUID: SmOhZGw-43iJWo3sWctK1oQ4JaTK21f0
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDEzMSBTYWx0ZWRfX3++aoNa+dwYn
 /PL0Gp606XEAXMM5NmzcoWxczT3MYm+kUbwdMrftvkfS5tmfl/ZdeRe7lzXBm2in+wKLgPNwcis
 RSDX2tFfDHBGAQIClptmM10OXqlx/ss=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDEzMSBTYWx0ZWRfX8p1PBkqF8aec
 sHaC4dkmQ1eB4oQgf7ZGWI8co8fMDEYMbBu5OOtJBtLwncyfaK1A+neyNv9HDdvSv3am8Czet3U
 9eMOQ7upWbinTI4HG9V5yjE4xL1qPhUgUUTHxe0cLGV8FuvKlZKrT4AYwJg1bDhNipXE6/Ht/I1
 maUdxoVGlT6rkGCbx16fKbWIaI4RTLmQyEfNTnRyr83ng53xOWRqAzU5RIraeMp3jHArwUnM1Ie
 1xUjTGNpbA+WznprS78WPsGyx2pmIt81MvAp/0+uAw+Lzs6YNMpysjOp7p8dX2PgYEfURZIlJRW
 W/S/48wpG3Kl4woZPNlMkI66EX3MqK/yKnw+Qyxixiji+Mc8dodJNPAXkCvm4DoDgCueNPR0J0e
 m+z3gJF2J4I99j3cnqGg0D5bNHClMNMmwxtSQbCWd3zxQ5AAfsqgOyb2CQ2TrNfI9a7cJwQ3ejf
 xqay1nb+m3FSsHuP6Hg==
X-Authority-Analysis: v=2.4 cv=TL11jVla c=1 sm=1 tr=0 ts=6a5a2677 cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=J0RmenBMOwS19r/fhzI3tQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=TxwNAwi48Q_YvDeankcA:9 a=QEXdDO2ut3YA:10
 a=MFSWADHSvvjO3QEy5MdX:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_03,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607170131
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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



On 7/14/2026 4:56 AM, Subrahmanya Lingappa wrote:
> Add helper routines for describing RPMI shared-memory mailbox transports
> and service child nodes in the RISC-V virt device tree.
> 
> The helpers keep RPMI node construction in one place so the virt machine
> can add service groups without open-coding compatible strings, channel
> IDs, interrupts, and shared-memory references at each call site.
> 
> Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>


>   hw/riscv/meson.build        |   1 +
>   hw/riscv/rpmi-fdt.c         | 103 ++++++++++++++++++++++++++++++++++++
>   include/hw/riscv/rpmi-fdt.h |  30 +++++++++++
>   3 files changed, 134 insertions(+)
>   create mode 100644 hw/riscv/rpmi-fdt.c
>   create mode 100644 include/hw/riscv/rpmi-fdt.h
> 
> diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
> index b70a054579..529ec273fd 100644
> --- a/hw/riscv/meson.build
> +++ b/hw/riscv/meson.build
> @@ -3,6 +3,7 @@ riscv_ss.add(files('boot.c'))
>   riscv_ss.add(files('fdt-common.c'))
>   riscv_ss.add(when: 'CONFIG_RISCV_NUMA', if_true: files('numa.c'))
>   riscv_ss.add(files('riscv_hart.c'))
> +riscv_ss.add(files('rpmi-fdt.c'))
>   riscv_ss.add(when: 'CONFIG_OPENTITAN', if_true: files('opentitan.c'))
>   riscv_ss.add(when: 'CONFIG_RISCV_VIRT', if_true: files('virt.c'))
>   riscv_ss.add(when: 'CONFIG_SHAKTI_C', if_true: files('shakti_c.c'))
> diff --git a/hw/riscv/rpmi-fdt.c b/hw/riscv/rpmi-fdt.c
> new file mode 100644
> index 0000000000..b2b3daea1c
> --- /dev/null
> +++ b/hw/riscv/rpmi-fdt.c
> @@ -0,0 +1,103 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * RISC-V RPMI device-tree helpers
> + *
> + * Copyright (c) 2026 Qualcomm Technologies, Inc.
> + * Author:
> + *  Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/bswap.h"
> +#include "hw/riscv/rpmi-fdt.h"
> +#include "hw/misc/riscv_rpmi.h"
> +#include "system/device_tree.h"
> +
> +void riscv_rpmi_fdt_add_mbox(void *fdt,
> +                             const RiscvRpmiFdtMboxConfig *cfg,
> +                             uint32_t *phandle,
> +                             uint32_t *mbox_handle)
> +{
> +    g_autofree char *name = NULL;
> +    hwaddr a2p_req_base, p2a_ack_base, p2a_req_base, a2p_ack_base;
> +    static const char * const regnames_all[RPMI_ALL_NUM_REGS] = {
> +        "a2p-req", "p2a-ack", "p2a-req", "a2p-ack", "a2p-doorbell"
> +    };
> +    static const char * const regnames_a2p[RPMI_A2P_NUM_REGS] = {
> +        "a2p-req", "p2a-ack", "a2p-doorbell"
> +    };
> +
> +    a2p_req_base = cfg->shmem_base;
> +    p2a_ack_base = a2p_req_base + cfg->a2p_req_size;
> +    p2a_req_base = p2a_ack_base + cfg->a2p_req_size;
> +    a2p_ack_base = p2a_req_base + cfg->p2a_req_size;
> +
> +    *mbox_handle = (*phandle)++;
> +    name = g_strdup_printf("/soc/mailbox@%" HWADDR_PRIx, cfg->shmem_base);
> +    qemu_fdt_add_subnode(fdt, name);
> +    qemu_fdt_setprop_string(fdt, name, "compatible", "riscv,rpmi-shmem-mbox");
> +    qemu_fdt_setprop_cell(fdt, name, "riscv,slot-size", RPMI_QUEUE_SLOT_SIZE);
> +    qemu_fdt_setprop_cell(fdt, name, "#mbox-cells", 1);
> +
> +    if (cfg->p2a_req_size) {
> +        qemu_fdt_setprop_string_array(fdt, name, "reg-names",
> +                                      (char **)&regnames_all,
> +                                      ARRAY_SIZE(regnames_all));
> +        qemu_fdt_setprop_cells(fdt, name, "reg",
> +            (uint32_t)(a2p_req_base >> 32), (uint32_t)a2p_req_base,
> +            0x0, cfg->a2p_req_size,
> +            (uint32_t)(p2a_ack_base >> 32), (uint32_t)p2a_ack_base,
> +            0x0, cfg->a2p_req_size,
> +            (uint32_t)(p2a_req_base >> 32), (uint32_t)p2a_req_base,
> +            0x0, cfg->p2a_req_size,
> +            (uint32_t)(a2p_ack_base >> 32), (uint32_t)a2p_ack_base,
> +            0x0, cfg->p2a_req_size,
> +            (uint32_t)(cfg->doorbell_base >> 32), (uint32_t)cfg->doorbell_base,
> +            0x0, cfg->doorbell_size);
> +    } else {
> +        qemu_fdt_setprop_string_array(fdt, name, "reg-names",
> +                                      (char **)&regnames_a2p,
> +                                      ARRAY_SIZE(regnames_a2p));
> +        qemu_fdt_setprop_cells(fdt, name, "reg",
> +            (uint32_t)(a2p_req_base >> 32), (uint32_t)a2p_req_base,
> +            0x0, cfg->a2p_req_size,
> +            (uint32_t)(p2a_ack_base >> 32), (uint32_t)p2a_ack_base,
> +            0x0, cfg->a2p_req_size,
> +            (uint32_t)(cfg->doorbell_base >> 32), (uint32_t)cfg->doorbell_base,
> +            0x0, cfg->doorbell_size);
> +    }
> +
> +    qemu_fdt_setprop_cells(fdt, name, "phandle", *mbox_handle);
> +}
> +
> +void riscv_rpmi_fdt_add_service(void *fdt, hwaddr shmem_base,
> +                                const char *node_name,
> +                                const char *compatible,
> +                                uint32_t mbox_handle,
> +                                uint32_t service_group,
> +                                bool has_mpxy_channel,
> +                                uint32_t mpxy_channel)
> +{
> +    g_autofree char *name = g_strdup_printf("/soc/mailbox@%" HWADDR_PRIx "/%s",
> +                                            shmem_base, node_name);
> +
> +    qemu_fdt_add_subnode(fdt, name);
> +    qemu_fdt_setprop_string(fdt, name, "compatible", compatible);
> +    qemu_fdt_setprop_cells(fdt, name, "mboxes", mbox_handle, service_group);
> +    if (has_mpxy_channel) {
> +        qemu_fdt_setprop_cell(fdt, name, "riscv,sbi-mpxy-channel-id",
> +                              mpxy_channel);
> +    }
> +}
> +
> +void riscv_rpmi_fdt_add_service_node(void *fdt, hwaddr shmem_base,
> +                                     const RiscvRpmiServiceConfig *service,
> +                                     uint32_t mbox_handle)
> +{
> +    riscv_rpmi_fdt_add_service(fdt, shmem_base, service->node_name,
> +                               service->compatible, mbox_handle,
> +                               service->service_group,
> +                               service->has_mpxy_channel,
> +                               service->mpxy_channel);
> +}
> diff --git a/include/hw/riscv/rpmi-fdt.h b/include/hw/riscv/rpmi-fdt.h
> new file mode 100644
> index 0000000000..f053ae5d57
> --- /dev/null
> +++ b/include/hw/riscv/rpmi-fdt.h
> @@ -0,0 +1,30 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * RISC-V RPMI device-tree helpers
> + *
> + * Copyright (c) 2026 Qualcomm Technologies, Inc.
> + * Author:
> + *  Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
> + */
> +
> +#ifndef HW_RISCV_RPMI_FDT_H
> +#define HW_RISCV_RPMI_FDT_H
> +
> +#include "exec/hwaddr.h"
> +#include "hw/misc/riscv_rpmi.h"
> +
> +typedef struct RiscvRpmiFdtMboxConfig {
> +    hwaddr shmem_base;
> +    hwaddr doorbell_base;
> +    uint32_t a2p_req_size;
> +    uint32_t p2a_req_size;
> +    uint32_t doorbell_size;
> +} RiscvRpmiFdtMboxConfig;
> +
> +void riscv_rpmi_fdt_add_mbox(void *fdt,
> +                             const RiscvRpmiFdtMboxConfig *cfg,
> +                             uint32_t *phandle,
> +                             uint32_t *mbox_handle);
> +
> +#endif


