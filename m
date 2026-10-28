Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEE6606A31D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 13:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=B46SfiHR;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WRLAAz67
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM49H-0005HM-8T; Wed, 28 Oct 2026 09:57:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prajwal.n@oss.qualcomm.com>)
 id 1xM497-0005Fa-1u
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 09:56:54 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prajwal.n@oss.qualcomm.com>)
 id 1xM491-000136-HI
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 09:56:52 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69SBe2V04154753
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 13:56:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qpL1Jz+LTl+962xGPbneGzNJZkCmiPVOxhZsO5Mdh7s=; b=B46SfiHRiV2MzzSf
 loNQ7whj0vRg+LPq+b6QIll1B1e321f5OoJznsQXkbLdxS6ISWu9+Fj3b0mObZgA
 HhPogX8e2reMiY3ISLDeor7teWLDCnwHwy4B5sscXjtx2CAfB7SIR4HPIHVnHkOV
 +O+uXJc+0BSOZh9WRKUw4EMcJrwrmPJ3RA0WC9bb9h+/BYv9HWCEPo2tAZUoT1EI
 tPlKhETBh2bP2KpDzvFrr6SIBgUWlrR35DeDDAsQfDAOoeBXwStbW1A4bQaf2AQ6
 mZ/QRo7J+q71xnf70I8Jij6ca/ZQljkfiA2WD5peGWkFyFQlmJVPRGGSfQBZUfkD
 crAGFg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkdsp13xp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 13:56:46 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso1902376eec.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 06:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793195805; x=1793800605; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=qpL1Jz+LTl+962xGPbneGzNJZkCmiPVOxhZsO5Mdh7s=;
 b=WRLAAz67ihkIy7OUDZW7rpd+hkM/KDOazU9G/ITlAcOGWIN3poGfTPTxETTgef5NsS
 2CJGM8C9yKfMEnfIH0jFdKMjp2nXubozZHe8rcmxu2Ukn/8pw7DHfd79+E1uPpL1DzVg
 ZYA1pxKFu7T9uDxtP+PZWry3w2WRrAFCcyck+PJ3bry0JoRCH0dBjf++3I8pQxFnVhST
 uJ6q8T49RsrMlZnj3oR3w2RE2DFb9z1mlvh86+jGT8xGQCP3Iv3E8uMyx8ehOGwn4X9C
 UBTZ4+FRa2CrJ2Px05fFCp9BZNd4b0kvN1JFwisTwlA/iLhyl4taXaRbdohx1smGZLx6
 7Mwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793195805; x=1793800605;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qpL1Jz+LTl+962xGPbneGzNJZkCmiPVOxhZsO5Mdh7s=;
 b=TkzpZPPGpg7Q0E6mzGwSnB8sV8Otozva37o8T6mUbdhDsJ7vv1qnqXxvkLPuo59Bwt
 EFHLqqGdwrlSD+WNoqmb9/umG0qJP2qaHVg5BS8ZQMSMw2sdSc5yuwcmVPd6g/TuKg1X
 efgLjYFPW3Cp0cOiZUoSLJV3+wA2yKS22WytxUQtuFrhhSg1/lqv0PFw464bi8X8GYII
 AEVPezVn17CK4kuNPqmR/PIUQYzNoSnUf+7ToLAR9Fweg6XHyCqw7KvQB1W+zf4pTDTP
 ihUnUKhDIegh+C1FYYpnXOsN2+RDhgh9zi/NNTIOcS1WMx+3r8PS978dzs7vN30kAKn0
 X9gg==
X-Forwarded-Encrypted: i=1;
 AKwUvByj+1k2bt187wJ0eYTve/P17I1Nfu6XlaT9mMdOj2KMc/wZrmVmZYzqTurNUDuleP2BzgJaXWgIAtXn@nongnu.org
X-Gm-Message-State: AFq9FYLW+jaNj/4Y/BXZxWK7GOicX2AsZbQCylvtsVeyl++1w7eXAQUb
 Jf5gF7jtK0DvKEGiUOE/uFgGrmQ1FBy7K0A7eHttjvqjW6njscv3x3Z08d5VfrGrkW+6O1/q5fm
 6s/ItbbETY7j0XHVQkGig+qmPFOi3O4uB4egk0gFsCH4hNipakmdFBHM+Hw==
X-Gm-Gg: AYBFou2vh83R0lYagfdM5gV4jLZuFV8pzsI1NmK8zaVO8M+2MayhOD2okPOz//5W4rr
 mGEPwYzLQ5NH4s8+AFt6sWoh0Dh0XBv6oUOLeu8HqJ6oAHAsclerbXrgeDRhMJubUsIEnR2EFlh
 qjmRGgNrgsSpFCTnx1Hr5052d8I1wS7ACjMAmq750wXL74BCur8+cmYqu+s2fKMuJi0kZBWIv3v
 ZOuW8BPva/a/aaEPbVWVAIBtl3ipq0ItBpRPdu5S3UrbtI284L3Q28E1JzwiEXsvQ5ABb00GyAS
 UYzAi/2wyTkU1EmdNf3DubwCFC0I+CMriDmscTtiMV2+lHTLOarxX/snlOGzmjuR5eDmPbskdHa
 wFbxDVTeyW55ZtRQ+Q1g8ageSDOcTjDeDoKr/Hg7gnivkJb5L5aNDEoodrap1uimKnhEXk90Ulw
 ==
X-Received: by 2002:a05:701b:458c:b0:17f:7280:134e with SMTP id
 a92af1059eb24-1a6cef7a368mr2765225c88.32.1793195804724; 
 Wed, 28 Oct 2026 06:56:44 -0700 (PDT)
X-Received: by 2002:a05:701b:458c:b0:17f:7280:134e with SMTP id
 a92af1059eb24-1a6cef7a368mr2765190c88.32.1793195804055; 
 Wed, 28 Oct 2026 06:56:44 -0700 (PDT)
Received: from [192.168.1.6] ([125.99.240.160])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1a75e5c6d4fsm11027199c88.14.2026.10.28.06.56.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 06:56:43 -0700 (PDT)
Message-ID: <af95947c-62aa-46ad-82e9-1720be6fefde@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 19:26:33 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/6] hw/riscv: add CBQRI controllers to virt machine
To: Drew Fustini <fustini@kernel.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Sunil V L <sunilvl@oss.qualcomm.com>,
 Anup Patel <anup.patel@oss.qualcomm.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Nicolas Pitre <npitre@baylibre.com>,
 =?UTF-8?Q?Kornel_Dul=C4=99ba?= <mindal@semihalf.com>,
 Atish Patra <atish.patra@linux.dev>,
 =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <radim.krcmar@oss.qualcomm.com>,
 yunhui cui <cuiyunhui@bytedance.com>,
 Chen Pei <cp0613@linux.alibaba.com>, guo.wenjia23@zte.com.cn,
 liu.qingtao2@zte.com.cn, prajwal.n.oss@gmail.com
References: <20261026-riscv-ssqosid-cbqri-v6-0-1a367a35cd0e@kernel.org>
 <20261026-riscv-ssqosid-cbqri-v6-6-1a367a35cd0e@kernel.org>
Content-Language: en-US
From: Prajwal N <prajwal.n@oss.qualcomm.com>
In-Reply-To: <20261026-riscv-ssqosid-cbqri-v6-6-1a367a35cd0e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: d63ZzAybMrXtTWKnhTGtP8tYqdaYYWxk
X-Proofpoint-ORIG-GUID: d63ZzAybMrXtTWKnhTGtP8tYqdaYYWxk
X-Authority-Analysis: v=2.4 cv=Cssq4X4D c=1 sm=1 tr=0 ts=6ae1ff1e cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=GuUutMOJDLuJj3+4/pSvWA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=IpJZQVW2AAAA:8 a=bDdBU3oEAAAA:8 a=VwQbUJbxAAAA:8 a=7HQ5lZ7GkhH3xUXdjy4A:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=IawgGOuG5U0WyFbmm1f5:22
 a=DN7SgORnOiO7RqxRx1GC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA1NSBTYWx0ZWRfX5XqsnO5R1LSf
 WSKeicLPbz7WVeZcfOPfM/TjySM7qBhhrUmTYvI0cToJHWl5dTwl4XUjNTKwpklyoV3DlGKxoCY
 PcthET9xEX8mExRR8n5zzcsrMEWZtmqwUXNesNx5RLrLqd3TK9JW9MqjsIKcrhzOjSzALjiHqTU
 NEkfM+mPwSdzSWakJFqL7fWoRfRiZhJqKRkSAQWotg6LfcyxXBWik3WQhWfrzqv1hBSUlRhG6k8
 dvgeznmu+gnyGaFry9GXdXOrMpm/EGi19LBkKc9fh7sPP48lpylReTwJpSzbZOuw87n1naOC5ys
 6JVCXYWZI9Lx4OuPx0FRgrkVtDFfTgyT7bOxd+JoI2QCiQCl/uudg/LzHsWRnOdewM29r1FigOL
 ipYv7wsAyfAAQTINYO0pdDsMTRT41uhYQ/T3VL7GVZ+ktPkemTnN4J5PyXpR6YQv2HqaYREqkZQ
 9Z2h39wYgLF+V859fJg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA1NSBTYWx0ZWRfX8SADZ32Yhj2j
 8w+98TI7aM+OXxFzpKiYcCpBryeulhR5ZJB8uUroZ3oSZ001gXoK41jzAEiJDX/mmT1bnXCwLDR
 MB2RwGI9995skUhnTjPt5VMf2vDRyiU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610280055
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=prajwal.n@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Drew,

On 26-10-2026 23:17, Drew Fustini wrote:
> From: Nicolas Pitre <npitre@baylibre.com>
> 
> Add CBQRI controllers to the RISC-V virt machine. The device properties
> can be fully configured from the command line:
> 
>   $ qemu-system-riscv64 -M virt ... \
>       -device riscv.cbqri.capacity,mmio_base=0x04828000[,...]
>       -device riscv.cbqri.bandwidth,mmio_base=0x04829000[,...]
> 
> The mmio_base option is mandatory, the others are optional.
> 
> Many -device arguments as wanted can be provided as long as their
> mmio regions don't conflict.
> 
> To see all possible options:
> 
>   $ qemu-system-riscv64 -device riscv.cbqri.capacity,help
>   riscv.cbqri.capacity options:
>     alloc_op_config_limit=<bool> -  (default: true)
>     alloc_op_flush_rcid=<bool> -  (default: true)
>     alloc_op_read_limit=<bool> -  (default: true)
>     at_code=<bool>         -  (default: true)
>     at_data=<bool>         -  (default: true)
>     max_mcids=<uint16>     -  (default: 256)
>     max_rcids=<uint16>     -  (default: 64)
>     mmio_base=<uint64>     -  (default: 0)
>     mon_evt_id_none=<bool> -  (default: true)
>     mon_evt_id_occupancy=<bool> -  (default: true)
>     mon_op_config_event=<bool> -  (default: true)
>     mon_op_read_counter=<bool> -  (default: true)
>     ncblks=<uint16>        -  (default: 16)
>     target=<str>
> 
>   $ qemu-system-riscv64 -device riscv.cbqri.bandwidth,help
>   riscv.cbqri.bandwidth options:
>     alloc_op_config_limit=<bool> -  (default: true)
>     alloc_op_read_limit=<bool> -  (default: true)
>     at_code=<bool>         -  (default: true)
>     at_data=<bool>         -  (default: true)
>     max_mcids=<uint16>     -  (default: 256)
>     max_rcids=<uint16>     -  (default: 64)
>     mmio_base=<uint64>     -  (default: 0)
>     mon_evt_id_none=<bool> -  (default: true)
>     mon_evt_id_rdonly_count=<bool> -  (default: true)
>     mon_evt_id_rdwr_count=<bool> -  (default: true)
>     mon_evt_id_wronly_count=<bool> -  (default: true)
>     mon_op_config_event=<bool> -  (default: true)
>     mon_op_read_counter=<bool> -  (default: true)
>     nbwblks=<uint16>       -  (default: 1024)
>     target=<str>
> 
> Boolean options correspond to hardware capabilities that can be disabled
> 
> Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Signed-off-by: Drew Fustini <fustini@kernel.org>
> ---
>  hw/core/sysbus-fdt.c | 4 ++++
>  hw/riscv/virt.c      | 3 +++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/hw/core/sysbus-fdt.c b/hw/core/sysbus-fdt.c
> index 12238570b5e1..265917ef573e 100644
> --- a/hw/core/sysbus-fdt.c
> +++ b/hw/core/sysbus-fdt.c
> @@ -35,6 +35,7 @@
>  #include "hw/core/platform-bus.h"
>  #include "hw/display/ramfb.h"
>  #include "hw/uefi/var-service-api.h"
> +#include "hw/riscv/cbqri.h"
>  #include "hw/arm/fdt.h"
>  #include "hw/watchdog/sbsa_gwdt.h"
>  
> @@ -142,6 +143,9 @@ static const BindingEntry bindings[] = {
>      TYPE_BINDING(TYPE_RAMFB_DEVICE, no_fdt_node),
>      TYPE_BINDING(TYPE_UEFI_VARS_SYSBUS, add_uefi_vars_node),
>      TYPE_BINDING(TYPE_WDT_SBSA, no_fdt_node),
> +    /* RISC-V CBQRI controllers have no generic device tree node */
> +    TYPE_BINDING(TYPE_RISCV_CBQRI_BC, no_fdt_node),
> +    TYPE_BINDING(TYPE_RISCV_CBQRI_CC, no_fdt_node),
>      TYPE_BINDING("", NULL), /* last element */
>  };
>  
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index d4b501802f60..dbc0f8cfc8d7 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -57,6 +57,7 @@
>  #include "hw/pci-host/gpex.h"
>  #include "hw/display/ramfb.h"
>  #include "hw/acpi/aml-build.h"
> +#include "hw/riscv/cbqri.h"
>  #include "qapi/qapi-visit-common.h"
>  #include "hw/virtio/virtio-iommu.h"
>  #include "hw/uefi/var-service-api.h"
> @@ -1157,6 +1158,8 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
>  #ifdef CONFIG_TPM
>      machine_class_allow_dynamic_sysbus_dev(mc, TYPE_TPM_TIS_SYSBUS);
>  #endif
> +    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_RISCV_CBQRI_BC);
> +    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_RISCV_CBQRI_CC);

When the controller device is created dynamically through the QEMU command line, the
corresponding device tree node must also be created. As I do not see the implementation
to add the DT node in this series, Could you please clarify how it is created.?

Thanks,
Prajwal N
>  
>      object_class_property_add_bool(oc, "aclint", virt_get_aclint,
>                                     virt_set_aclint);
> 


