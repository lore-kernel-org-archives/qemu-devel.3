Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01181606A338
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 11:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=F2xySGtO;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ib25KSo3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOCw3-0001GS-Qv; Tue, 03 Nov 2026 06:44:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xOCvy-00015V-F2
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 06:44:11 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xOCvw-0007vy-Id
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 06:44:10 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A3AAG2q2522035
 for <qemu-devel@nongnu.org>; Tue, 3 Nov 2026 11:44:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BSr1uh+4en6BHWcJyDPsY70tIhPteqCGsHEzAwe/neg=; b=F2xySGtOkm5zK9Xh
 EeP+p6yK/lvyge6F3XXQSHBptQddnNHlr3FS67Afs1ILNFEQzmOmp81plm1BAjBx
 zOLuvTJk3yB2xH6HDvJW6u64tyGPzwU9qLb9HcU5nd3tsDOrJnaTrXY1bX897RVV
 qT9vOiKhLee/y4/6t1PbwJ8gDG+rPRlVNKp/8Q+QQKhs0wvEddP6unAmooGR3vIL
 m1JiKxUA6hSahmCqoTz+MXt4aNEg5lGJbpKVhetXFmuomHHQTTP6FUCgaCKQDAub
 B1X7RMUhymJS/bn4QDtNpHI5fKVOnyTDl6aIwx8A5SnPrwLH8n6zfW0VI7ifbpHj
 Dqw/Ig==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq4v5jffu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 11:44:07 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-91c7c7e8becso114453856d6.0
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 03:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793706246; x=1794311046; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BSr1uh+4en6BHWcJyDPsY70tIhPteqCGsHEzAwe/neg=;
 b=ib25KSo3w8GkbQJx0Xv3yYJT1pv/30dbaKatpUuogJBgens1jlSXiBKYBFS3tCULiZ
 qYi8ozQXsjgc0hSVJAKeHlTW95ET5gyFSjlodY61cphViK1TLGZtHck4MdRbGsRyApYS
 cwA9bONxDlVD9L+MEoDjo0EYx/dBJU5EEEhAhvf+xGmQ5j6Yb86gTnaCXeEU0EE9K5fx
 eagKy6R3Qz3ZlvBsowHR+JjOMYQZmN1Sl/YAcV8lUQblL0O99pitYvjmmOVTZm1AIyet
 YiqcR9lc3yu0gxOp1lZxHLHF4b+6o8YWnaL4mObYVtXP2LqPxcCum+w5V3qH2s4R3Jgs
 Q8lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793706246; x=1794311046;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BSr1uh+4en6BHWcJyDPsY70tIhPteqCGsHEzAwe/neg=;
 b=VLs0eA196QT52brzaJzGSiGZq93ndvqXNkJHailDiKpxycfW170QsCGBo2G7UpsenB
 zPr0Jadmiq12DCnCFFkthCcEE+ozQhEOr8na49pnjJhlWVDZDMAnB7krebsr26UPsxhM
 r4Q/61Q1eMeOCpLxj+TCSl7VAG49MYBVT7yLsc0DCYtvL3gMxdjOof3uDCnV8CSAP/s/
 fOAOKSLkyswn2y3QT9j8gGFMbjupS3fYYTbsOH+Xb1IlMY2UYCrZ8JVfc+7mf/diGRAM
 iYCRtR5LEghPsiu/R9jXyR6gmoHRqaj/roMsGUJv9vL7mUZCzCKB3BsD4hZCX5qMEBTJ
 Vt2Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxTOVNuaJ5B2mGj9Rb5Wi3J+OLoLLkpdxy+LPEvEf+FXegQ8hJRIX8cKkSdxJX0OKewYIYlRyfLrOCV@nongnu.org
X-Gm-Message-State: APuU4Z/ug/BQqWWknTRLhG6kj33OAp8uiXv2REMv8pDsEWkNqQSUjnH9
 5azX4jqqTGwX4muydEDb9uReiprwLHvvbSa3OlAJsslrz3MghOErE5dwD1iFS4LPZssUdtGNNif
 sVszoqs9n10egKnQRcx1K35c1akIZZoc2MW60OvWqKPxF8+vbW328kXYg7A==
X-Gm-Gg: AYBFou12m7wBiVYMoGB8ylJ+aJ2m6tO1wBDXTBLGcKEsQ+h+bx7lGMTnuhp3c2vjdbl
 7HZ6CsNRG9Awbl5efcP3FJu1zyKw06cezsZ9TohTAStf5PA+peLXGx63UQOHhw7Eval3kMYWbHV
 wnUoTXo53bU8AVp3ne3kzzdyKAf/oPtLDfz1WDEWTeS7Y4FaBg3EDJWdD9LFeOWjRHgC9kd7PWt
 HoSdFUF+Yxkse7iITv/MHI7r7rNJ3Cv94I+bm3UF3FV0Y22mezpvUAOr+M1sBBTjwyAxcsD/PWP
 FY15AZIJYhrhq0Q70YlolK5N43GoApZezrR8xS99ws2SOudilPTjnX4JFmUKR/D9q7Dki67mRJb
 V0Zf0WhcuRrwbkeh195U1t9PbLPSFQ68KWN3DbmK5fKgrI5Va+JJLfBXBKPzLv23TSywikcbtjT
 I9Mzb+Mg==
X-Received: by 2002:a05:6214:2263:b0:91c:7a7c:4491 with SMTP id
 6a1803df08f44-91ca4bbd308mr202053416d6.43.1793706246103; 
 Tue, 03 Nov 2026 03:44:06 -0800 (PST)
X-Received: by 2002:a05:6214:2263:b0:91c:7a7c:4491 with SMTP id
 6a1803df08f44-91ca4bbd308mr202053046d6.43.1793706245409; 
 Tue, 03 Nov 2026 03:44:05 -0800 (PST)
Received: from [192.168.15.12] ([187.56.223.122])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91ca8071408sm114205156d6.40.2026.11.03.03.44.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2026 03:44:04 -0800 (PST)
Message-ID: <10817279-7b09-4e90-9f26-80d26316e422@oss.qualcomm.com>
Date: Tue, 3 Nov 2026 08:44:01 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] hw/riscv: Move platform bus FDT creation to machine
 code
To: Tan Chi <tanchi25@mails.ucas.ac.cn>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, pbonzini@redhat.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com
References: <20261101031547.125591-1-tanchi25@mails.ucas.ac.cn>
 <20261101031547.125591-4-tanchi25@mails.ucas.ac.cn>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261101031547.125591-4-tanchi25@mails.ucas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: b9hG5w8ICYux-JRhqJwCLVjcrKSlemvw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA0NiBTYWx0ZWRfX6ZXBQZ0kSTk4
 SmTQJidb5miY9qctSGRT1Lvm2crzBd3RDi0SyXlDPFKJtNDitXxCzRqnIMPi6NsuVm95cM6TdM3
 YnuankmNI4b8FZmgJHfKfBNgii0luOInFp4U3WWDW5c8hp5lQaqKpGUHI91XCG6WPvcxnhDk1R7
 M5pmkDRKXglWRzJasvMLLZptQND2UUyMl8UoDULbvgf5T4uQYVCEvQ9OwGRP5KcuhsZJ4hdpEiW
 cN0sfe5jTfXLtV+Sp5kOEEg2O+UcOgOsNBLaAX4iVTh8Kn+l8XNu/WuVCHnChsaxLPk03xpX80J
 y221l6+Tg2kImzbzFfaz1+TnsCPMnczdwJaKeMciQi5dNgOeXgVC5whCfnxM5H9kkuUOrJGdHog
 bDSPgbxwxY7hc4QBG4pqqkEiSCEGSNG1pIn8p4ZtHQ+6H0shZW9DyaxdgecyMbwBF+juhK/rBkh
 32G3oRh1k2xvyXjVQhA==
X-Proofpoint-GUID: b9hG5w8ICYux-JRhqJwCLVjcrKSlemvw
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA0NiBTYWx0ZWRfX9RaNDkmLXh7b
 EIX1WtciverhjRAu17C27tmeTophGc27mYmN6GNf7ZIGmrabDgzt00ExGe7odsJy6aeFHlaahub
 gUOksFS/95guyc0l+RmQybhqrmFPeEk=
X-Authority-Analysis: v=2.4 cv=NeZzRGD4 c=1 sm=1 tr=0 ts=6ae9c907 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=bus90iwuyia7r0C3gDGjVg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=D7o_hD9mWaW8g6JlauUA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_02,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 adultscore=0 suspectscore=0 clxscore=1015 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030046
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/1/2026 12:15 AM, Tan Chi wrote:
> riscv_create_fdt_socket_aplic() contains a direct reference to
> platform_bus_add_all_fdt_nodes(), even though fdt-common.c is
> built unconditionally and CONFIG_PLATFORM_BUS may be disabled.
> 
> This causes an undefined reference in minimal RISC-V builds
> without platform bus support.
> 
> Move platform bus FDT creation to the virt and server reference
> machines, which both select CONFIG_PLATFORM_BUS. Export a helper
> to obtain the APLIC node name and remove the platform bus fields
> from APLICFdtProps.
> 
> This removes the dependency from the common APLIC FDT helper
> while preserving the platform bus interrupt-parent configuration.
> 
> Signed-off-by: Tan Chi <tanchi25@mails.ucas.ac.cn>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   hw/riscv/fdt-common.c          | 13 ++-----------
>   hw/riscv/server_platform_ref.c |  9 +++++++--
>   hw/riscv/virt.c                | 11 +++++++++--
>   include/hw/riscv/fdt-common.h  |  3 +--
>   4 files changed, 19 insertions(+), 17 deletions(-)
> 
> diff --git a/hw/riscv/fdt-common.c b/hw/riscv/fdt-common.c
> index ce2dcb43b4..e90502b1bc 100644
> --- a/hw/riscv/fdt-common.c
> +++ b/hw/riscv/fdt-common.c
> @@ -11,7 +11,6 @@
>   #include "qemu/error-report.h"
>   #include "system/device_tree.h"
>   #include "hw/core/boards.h"
> -#include "hw/core/sysbus-fdt.h"
>   #include "hw/riscv/fdt-common.h"
>   #include "target/riscv/cpu_bits.h"
>   #include "hw/riscv/riscv-iommu-bits.h"
> @@ -599,7 +598,7 @@ void riscv_create_fdt_imsic(void *fdt, IMSICFdtProps *props,
>   }
>   
>   /* Caller must free string after use */
> -static char *fdt_get_aplic_nodename(hwaddr aplic_addr)
> +char *riscv_fdt_get_aplic_nodename(hwaddr aplic_addr)
>   {
>       return g_strdup_printf("/soc/interrupt-controller@%"HWADDR_PRIx,
>                              aplic_addr);
> @@ -613,7 +612,7 @@ static void create_fdt_one_aplic(void *fdt, APLICFdtProps *props,
>                                    uint32_t aplic_child_phandle,
>                                    bool m_mode)
>   {
> -    g_autofree char *aplic_name = fdt_get_aplic_nodename(aplic_addr);
> +    g_autofree char *aplic_name = riscv_fdt_get_aplic_nodename(aplic_addr);
>       g_autofree uint32_t *aplic_cells = g_new0(uint32_t, props->num_harts * 2);
>       static const char * const aplic_compat[2] = {
>           "qemu,aplic", "riscv,aplic"
> @@ -695,14 +694,6 @@ void riscv_create_fdt_socket_aplic(void *fdt, APLICFdtProps *props,
>                            aplic_s_phandle, 0,
>                            false);
>   
> -    if (!props->socket && props->platform_bus_irq) {
> -        g_autofree char *aplic_name = fdt_get_aplic_nodename(aplic_addr);
> -        platform_bus_add_all_fdt_nodes(fdt, aplic_name,
> -                                       props->platform_bus->base,
> -                                       props->platform_bus->size,
> -                                       props->platform_bus_irq);
> -    }
> -
>       aplic_phandles[props->socket] = aplic_s_phandle;
>   }
>   
> diff --git a/hw/riscv/server_platform_ref.c b/hw/riscv/server_platform_ref.c
> index 5f485b1c79..3526c80d79 100644
> --- a/hw/riscv/server_platform_ref.c
> +++ b/hw/riscv/server_platform_ref.c
> @@ -192,6 +192,7 @@ static void create_fdt_sockets(RISCVServerRefMachineState *s,
>   {
>       int socket, phandle_pos;
>       MachineState *ms = MACHINE(s);
> +    g_autofree char *aplic_name = NULL;
>       uint32_t msi_m_phandle = 0, msi_s_phandle = 0;
>       uint32_t xplic_phandles[MAX_NODES];
>       g_autofree uint32_t *intc_phandles = NULL;
> @@ -251,8 +252,6 @@ static void create_fdt_sockets(RISCVServerRefMachineState *s,
>       aplic_fdt_props.aplic_m = !kvm_enabled()
>                                 ? &memmap[RVSERVER_APLIC_M] : NULL;
>       aplic_fdt_props.aplic_s = &memmap[RVSERVER_APLIC_S];
> -    aplic_fdt_props.platform_bus = &memmap[RVSERVER_PLATFORM_BUS];
> -    aplic_fdt_props.platform_bus_irq = RVSERVER_PLATFORM_BUS_IRQ;
>       aplic_fdt_props.num_harts = ms->smp.cpus;
>       aplic_fdt_props.numa_enabled = numa_enabled;
>       aplic_fdt_props.irqchip_num_sources = RVSERVER_IRQCHIP_NUM_SOURCES;
> @@ -270,6 +269,12 @@ static void create_fdt_sockets(RISCVServerRefMachineState *s,
>                                         xplic_phandles);
>       }
>   
> +    aplic_name = riscv_fdt_get_aplic_nodename(memmap[RVSERVER_APLIC_S].base);
> +    platform_bus_add_all_fdt_nodes(ms->fdt, aplic_name,
> +                                   memmap[RVSERVER_PLATFORM_BUS].base,
> +                                   memmap[RVSERVER_PLATFORM_BUS].size,
> +                                   RVSERVER_PLATFORM_BUS_IRQ);
> +
>       for (socket = 0; socket < socket_count; socket++) {
>           if (socket == 0) {
>               *irq_mmio_phandle = xplic_phandles[socket];
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index d4b501802f..7ec7596b24 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -290,8 +290,6 @@ static void create_fdt_sockets(RISCVVirtState *s,
>       if (s->aia_type != VIRT_AIA_TYPE_NONE) {
>           aplic_props.aplic_m = !kvm_enabled() ? &s->memmap[VIRT_APLIC_M] : NULL;
>           aplic_props.aplic_s = &s->memmap[VIRT_APLIC_S];
> -        aplic_props.platform_bus = &s->memmap[VIRT_PLATFORM_BUS];
> -        aplic_props.platform_bus_irq = VIRT_PLATFORM_BUS_IRQ;
>           aplic_props.socket = 0;
>           aplic_props.num_harts = ms->smp.cpus;
>           aplic_props.numa_enabled = numa_enabled;
> @@ -347,6 +345,15 @@ static void create_fdt_sockets(RISCVVirtState *s,
>           }
>       }
>   
> +    if (s->aia_type != VIRT_AIA_TYPE_NONE) {
> +        g_autofree char *aplic_name =
> +            riscv_fdt_get_aplic_nodename(s->memmap[VIRT_APLIC_S].base);
> +        platform_bus_add_all_fdt_nodes(ms->fdt, aplic_name,
> +                                       s->memmap[VIRT_PLATFORM_BUS].base,
> +                                       s->memmap[VIRT_PLATFORM_BUS].size,
> +                                       VIRT_PLATFORM_BUS_IRQ);
> +    }
> +
>       riscv_socket_fdt_write_distance_matrix(ms);
>   }
>   
> diff --git a/include/hw/riscv/fdt-common.h b/include/hw/riscv/fdt-common.h
> index eb9db8278d..b3b14ada0a 100644
> --- a/include/hw/riscv/fdt-common.h
> +++ b/include/hw/riscv/fdt-common.h
> @@ -54,8 +54,6 @@ typedef struct IMSICFdtProps {
>   typedef struct APLICFdtProps {
>       const MemMapEntry *aplic_m;
>       const MemMapEntry *aplic_s;
> -    const MemMapEntry *platform_bus;
> -    int platform_bus_irq;
>       int socket;
>       int num_harts;
>       bool numa_enabled;
> @@ -129,6 +127,7 @@ void riscv_create_fdt_socket_aplic(void *fdt, APLICFdtProps *props,
>   void riscv_create_fdt_socket_aclint(void *fdt, ACLINTFdtProps *props,
>                                       uint32_t *intc_phandles);
>   /* Caller must free the returned string.  */
> +char *riscv_fdt_get_aplic_nodename(hwaddr addr);
>   char *riscv_fdt_get_uart_nodename(hwaddr addr);
>   void riscv_create_fdt_uart(void *fdt, const MemMapEntry *uart_mem,
>                              int uart_irq, int aia_type,


