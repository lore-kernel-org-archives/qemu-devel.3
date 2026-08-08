Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4B6CC5AC67
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2026 11:49:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsfYI-0007R5-Ak; Sat, 08 Aug 2026 07:49:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wsfYA-0007Nz-Cl
 for qemu-devel@nongnu.org; Sat, 08 Aug 2026 07:49:14 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wsfY7-0003xK-90
 for qemu-devel@nongnu.org; Sat, 08 Aug 2026 07:49:14 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 678AJ6I33470893
 for <qemu-devel@nongnu.org>; Sat, 8 Aug 2026 11:49:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Z16Cf3moPrUfMzkYoJ6gMw7mDY4E3rqUcYCK7REbEYg=; b=eL84AbvensjhswTX
 ylRPpQS0LlCEPnvsf6Uy425isJ0p/H0654mhHyHwBA01qobnhhrj0NZLR0hlXCYc
 54SvelD3l7ahWgPJ7bIkWaUhWLA+ydfbG23eUj+8eDhuVMug6X4dxosMxk0YZM5b
 V0qqRlWsChDHJzfZHgA+6cxiLoti+0g5JzP9ynp+SQ5pmlKdGSCR4Ogt/q4ycsgR
 Pc7xzhRtILxgNNtzSpEBJQeiVEnR0wupuTSlWAWU6f591BaBFIDH9UmM4bOq5cuA
 WaHRfzj0mdMzJSVX6jv4tiB0l4Qj+ptiA9uZ8EbeJ3HiSjnRpi7cpwowugYYJnC6
 t3OS8g==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwvu8gq6f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 08 Aug 2026 11:49:09 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-9308eafb465so72073285a.2
 for <qemu-devel@nongnu.org>; Sat, 08 Aug 2026 04:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786189749; x=1786794549; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Z16Cf3moPrUfMzkYoJ6gMw7mDY4E3rqUcYCK7REbEYg=;
 b=HK6qRPwk7ZehrZkTl4bWLxj8y8X2tVp3dzbb1Qgq0y/oEH4XhuM8GIcyzdyhkVCgwR
 0RT/vmv8YkJDsxt2ikq2EApFlI3kJWXX4M+lcfECTK5trObxsomCJzGf9BerZWonOwry
 +AeyfiI9YDLIrKh5Nv9DBt+vheJVho3so9fGWVjk9pxfT8Txd2vWUbzRsfBl9Zp2WT2Q
 Hf4bslVYWsqlq/osuBvIfVaOGyZ57WcFB92vl8U3LWVP7U5m1vgwBvg1SQMwJF+TTDEo
 1w0L2uA3BQLGjA5rgQlY6pp0oMgBsJebLcbaQbRnG/XVTAM9AWDZLVQFhnF1nEdMcGnB
 8yCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786189749; x=1786794549;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Z16Cf3moPrUfMzkYoJ6gMw7mDY4E3rqUcYCK7REbEYg=;
 b=fvm03mYmCChwPEwcfk10f5Ej223UnUmhUlvXT9iLPTcvbAAKA1tRj2tOTYpVJpAxgz
 8PGW3nwuMqQmmorU/gY4gObwoPeDflOmzYxfG3HAY+QukdcEuV3IHzj4LYl8rbfP5iD2
 4nrg95UKxBfCkrCP+CAiHIgyW+kJA/C8KWpGfAnWuX1MXaFjwiO25T3x9AjcRVnrZIKM
 xzl605o0V7ylOQsQJtey+KwGldilMgpxGYtILK/h26unSqghtWKJt3qGhaevpMPmESIj
 Cmjn+jxT2CM0jD+pR1FzDz/MlO0oSkV2sF/J31T1NsqhhFQRQbAQtjiVXDsa2FTWH5gQ
 pUXQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqWNXyM8dRwBOxoyq2oCGTDE6W38VZCEN9b8ilLKfJPxFrsH058wLPnMsp/YpygfPzi8ombUNPvhrEs@nongnu.org
X-Gm-Message-State: AOJu0YyrKjCaEB6/MtUoWIzOf5y0uz1bmmLwF0J5khBoADs9dN06B0bG
 FggcNA4Yu+eBiOShQ1JgrFDaitE1E1X5sBSqAR3q6sx8ELJPG9ok+tcWxiruz3CLma5KypbBjQV
 CThGq1WO3uDdyjtq5yjARgtnqukxZq9FKK0wVH5Wl9W7sKZHZqiQ9Whxsxw==
X-Gm-Gg: AR+sD12WAxr3dxtDIMY95PK2dfVLE6sBM6uCUqpHh5KK+CA0/L320X05IyVepzkcRLZ
 kqfRippQFlayBe7pMtvgcqupM32RZgrvEwsyJXcIojI2ckxCkESckKXa0rtS+qWWQuCy8IM1vFK
 eQFsB9+syHPUlgtVtDTn/uB9EQUEcJcrogcoPuMKu2Zt4mYoyf+j4g7dQbpZyQZugIzgs4mlBGG
 cdYcMR3ayO0P+oZytp26jYvM6YjSJr1ThZc4xhJqGD90UX0aZ4KGYEKRanQtIX0Hl2EDZSD7fWB
 41WDc3IfyL/SU0XfO1RqCUXzk/ys+93SgxWu/M5necjv7IFt1MieWeKGT1z1LUgsLPq89uyxej4
 HBDpyRiID6BqyQ8muKGHR2L/4g32E6XovyFGz
X-Received: by 2002:a05:620a:a713:b0:934:7ffc:7f90 with SMTP id
 af79cd13be357-9367991a162mr617871585a.36.1786189748854; 
 Sat, 08 Aug 2026 04:49:08 -0700 (PDT)
X-Received: by 2002:a05:620a:a713:b0:934:7ffc:7f90 with SMTP id
 af79cd13be357-9367991a162mr617855085a.36.1786189746725; 
 Sat, 08 Aug 2026 04:49:06 -0700 (PDT)
Received: from [192.168.68.100] ([177.198.100.18])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9366e22995fsm363058885a.29.2026.08.08.04.49.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 08 Aug 2026 04:49:06 -0700 (PDT)
Message-ID: <76169498-3311-4b0d-8c78-c70bce9e3046@oss.qualcomm.com>
Date: Sat, 8 Aug 2026 08:49:02 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/7] hw/misc: add K230 decomp gzip
To: Tao Ding <dingtao0430@163.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, pbonzini@redhat.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 farosas@suse.de, lvivier@redhat.com, pierrick.bouvier@oss.qualcomm.com,
 caojunze424@gmail.com
References: <20260808062227.66961-1-dingtao0430@163.com>
 <20260808062227.66961-5-dingtao0430@163.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260808062227.66961-5-dingtao0430@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: -ehKiyI9z4uRQb7COVn4sh99LG9AtCHs
X-Authority-Analysis: v=2.4 cv=M8p97Sws c=1 sm=1 tr=0 ts=6a7717b5 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=el0UrXJS4K3zujXh0Vdy/w==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=Rull5dLDAAAA:8 a=Byx-y9mGAAAA:8 a=EUspDBNiAAAA:8 a=Gjycqjudg96wIF8vplIA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=WpjELI0oDsu8BIz5_MMC:22
X-Proofpoint-ORIG-GUID: -ehKiyI9z4uRQb7COVn4sh99LG9AtCHs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA4MDA5OSBTYWx0ZWRfX0qag9D/RybYB
 Jm2eUMdmQBxCW8aw4fair1xQAVyWOG7Uc6FeOaJAG4yxBrOjnLbU3tidW9onSRSZh8diUeiE07I
 E7g4oLu5CefLUkCNezw8V2uXN3AHUomnNmYdFgELj7+htncH/MxPomnNT8GoaHeUtkAth8V2VoM
 4ajhITMCu6nLmhBYdlJnUKLGuP0roqHyFIChnVyX67E4xUbWOnhMBGBztItq5FwoanTf9Snx5O8
 YSivsSkc/5AchY6THihXhM9vEHYiD2QbvCfPttIpVUpcnl1JN3XSElR1q3laqYqBltaFVgCQE3K
 ihMpcG0MSGWzeAwu7yQ1Az6VCqoepX6kY9dnS5tyKxyvcV/j6/flycVn6IAlpu23cYjikxpS1Rd
 Ac5bGYzFqz/Hv42Q57EBSaFXmyVFoZte9VtrX4b61PlNfrukt0t0usBRD/ceoGVInTmG8ihXYqN
 8KZFToo/IuVFo3Hx+Xw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA4MDA5OSBTYWx0ZWRfX8ZSOAnPHvPza
 o1hd+9gKMo7k5/ggd9PdKUVNBIfN99KpErIUo2m3fsG/oZDu/XMKMd/SKRrdvOZL9RKOyiyCt1C
 kDKfMPKiSGInLQKM6DWMJdNn+sP6pEo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-08_04,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608080099
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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



On 8/8/2026 3:22 AM, Tao Ding wrote:
> Decompression accelerator is mainly used to implement hardware GZIP decompression function.
> According to the k230 SDK, this hardware will be used during the uboot phase to decompress
> compressed files.
> 
> Decomp_gzip does not have the ability to access the system bus.
> Therefore, SDMA is required for data transmission. A typical scenario is SDMA moving compressed
> data from DDR to SRAM, and Decomp_gzip reading data from SRAM. After decompression, decomp_gzip
> writes the data back to SRAM, and SDMA moves the data from SRAM to DDR.
> 
> According to "K230 Technical Reference Manual v0.3.1" section 15.
> https://download.kendryte.com/developer/k230/HDK/K230%E7%A1%AC%E4%BB%B6%E6%96%87%E6%A1%A3/K230_Technical_Reference_Manual_V0.3.1_20241118.pdf
> 
> Signed-off-by: Tao Ding <dingtao0430@163.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

> In patchv2, reviewer suggests using qemu_log_mask to print when receiving an incorrect ack signal.
> Added unexpected value printing in the k230_decomp_gzip_handle_ack function in this commit.
> 
>   MAINTAINERS                        |   2 +
>   docs/system/riscv/k230.rst         |   1 +
>   hw/misc/Kconfig                    |   3 +
>   hw/misc/k230_decomp_gzip.c         | 511 +++++++++++++++++++++++++++++
>   hw/misc/meson.build                |   1 +
>   hw/misc/trace-events               |   4 +
>   include/hw/misc/k230_decomp_gzip.h |  92 ++++++
>   7 files changed, 614 insertions(+)
>   create mode 100644 hw/misc/k230_decomp_gzip.c
>   create mode 100644 include/hw/misc/k230_decomp_gzip.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9c546596e7..c260199142 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1830,9 +1830,11 @@ F: docs/system/riscv/k230.rst
>   F: hw/riscv/k230.c
>   F: hw/watchdog/k230_wdt.c
>   F: hw/dma/k230_gsdma.c
> +F: hw/misc/k230_decomp_gzip.c
>   F: include/hw/riscv/k230.h
>   F: include/hw/watchdog/k230_wdt.h
>   F: include/hw/dma/k230_gsdma.h
> +F: include/hw/misc/k230_decomp_gzip.h
>   F: tests/functional/riscv64/test_k230.py
>   F: tests/qtest/k230-wdt-test.c
>   F: tests/qtest/k230-gsdma-test.c
> diff --git a/docs/system/riscv/k230.rst b/docs/system/riscv/k230.rst
> index a426a1d776..ebd002b62f 100644
> --- a/docs/system/riscv/k230.rst
> +++ b/docs/system/riscv/k230.rst
> @@ -21,6 +21,7 @@ The ``k230`` machine supports the following devices:
>   * 2 K230 Watchdog Timer
>   * 5 UART
>   * System Direct Memory Access (SDMA)
> +* GZIP Decompress Engine (Decomp_gzip)
>   
>   Boot options
>   ------------
> diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
> index 1543ee6653..28687482f8 100644
> --- a/hw/misc/Kconfig
> +++ b/hw/misc/Kconfig
> @@ -257,4 +257,7 @@ config XLNX_VERSAL_TRNG
>   config XLNX_ZYNQ_DDRC
>       bool
>   
> +config K230_DECOMP_GZIP
> +    bool
> +
>   source macio/Kconfig
> diff --git a/hw/misc/k230_decomp_gzip.c b/hw/misc/k230_decomp_gzip.c
> new file mode 100644
> index 0000000000..0d8a3b2d2e
> --- /dev/null
> +++ b/hw/misc/k230_decomp_gzip.c
> @@ -0,0 +1,511 @@
> +/*
> + * Kendryte K230 GZIP decompression engine
> + *
> + * Copyright (c) 2026 Tao Ding <dingtao0430@163.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Decompression accelerator is mainly used to implement hardware
> + * GZIP decompression function. (K230 TRM section 15)
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "qemu/module.h"
> +#include "hw/core/qdev-properties.h"
> +#include "migration/vmstate.h"
> +#include "system/address-spaces.h"
> +#include "hw/core/irq.h"
> +#include "hw/misc/k230_decomp_gzip.h"
> +#include "trace.h"
> +
> +#define GZIP_METHOD_DEFLATE    8
> +#define GZIP_METHOD_VENDOR_9   9
> +
> +#define DEFLATE_BTYPE_DYNAMIC  2
> +
> +#define K230_DECOMP_GZIP_OUTPUT_SLOTS 4
> +#define K230_DECOMP_GZIP_INPUT_SLOTS 2
> +
> +static void k230_decomp_gzip_set_output(K230DecompGzipState *s, int line,
> +                                        int level)
> +{
> +    qemu_set_irq(s->signal_out[line], level);
> +}
> +
> +static bool k230_decomp_gzip_read_mem(K230DecompGzipState *s, hwaddr addr,
> +                                      void *buf, size_t len)
> +{
> +    MemTxResult ret = address_space_read(&address_space_memory,
> +                                         s->sram_base + addr,
> +                                         MEMTXATTRS_UNSPECIFIED, buf, len);
> +
> +    return ret == MEMTX_OK;
> +}
> +
> +static bool k230_decomp_gzip_write_mem(K230DecompGzipState *s, hwaddr addr,
> +                                       const void *buf, size_t len)
> +{
> +    return address_space_write(&address_space_memory, s->sram_base + addr,
> +                               MEMTXATTRS_UNSPECIFIED, buf, len) == MEMTX_OK;
> +}
> +
> +static hwaddr k230_decomp_gzip_output_addr(K230DecompGzipState *s)
> +{
> +    return K230_DECOMP_GZIP_SRAM_OUT_BASE +
> +           s->output.slot * K230_DECOMP_GZIP_BLOCK_SIZE +
> +           s->output.current_offset;
> +}
> +
> +static hwaddr k230_decomp_gzip_input_addr(K230DecompGzipState *s)
> +{
> +    return s->input.slot * K230_DECOMP_GZIP_BLOCK_SIZE +
> +           K230_DECOMP_GZIP_SRAM_IN_BASE;
> +}
> +
> +static uint32_t k230_decomp_gzip_current_input_size(K230DecompGzipState *s)
> +{
> +    if (s->total_requested == 0) {
> +        return 0;
> +    }
> +
> +    return ((s->total_requested - 1) % K230_DECOMP_GZIP_BLOCK_SIZE) + 1;
> +}
> +
> +static void k230_decomp_gzip_update_ctrl_en(K230DecompGzipState *s)
> +{
> +    int level = s->active && !!(s->gzip_src_size & K230_DECOMP_GZIP_CTRL_EN);
> +
> +    k230_decomp_gzip_set_output(s, K230_DECOMP_GZIP_GPIO_DECOMP_CTRL_EN,
> +                                level);
> +}
> +
> +static void k230_decomp_gzip_reset_stream(K230DecompGzipState *s)
> +{
> +    if (s->zstream_inited) {
> +        inflateEnd(&s->zs);
> +        s->zstream_inited = false;
> +    }
> +    memset(&s->zs, 0, sizeof(s->zs));
> +}
> +
> +static void k230_decomp_gzip_finish(K230DecompGzipState *s, bool crc_ok)
> +{
> +    s->active = false;
> +    k230_decomp_gzip_reset_stream(s);
> +    k230_decomp_gzip_update_ctrl_en(s);
> +    if (crc_ok) {
> +        s->decomp_stat |= K230_DECOMP_GZIP_STAT_CRC_OK;
> +    } else {
> +        s->decomp_stat &= ~K230_DECOMP_GZIP_STAT_CRC_OK;
> +    }
> +}
> +
> +static bool k230_decomp_gzip_load_input(K230DecompGzipState *s,
> +                                        uint32_t addr, uint32_t size)
> +{
> +    s->input.current_offset = 0;
> +
> +    return k230_decomp_gzip_read_mem(s, addr, s->input_buf, size);
> +}
> +
> +static bool k230_decomp_gzip_request_input(K230DecompGzipState *s)
> +{
> +    uint32_t total_requested = s->total_requested;
> +
> +    k230_decomp_gzip_set_output(s, K230_DECOMP_GZIP_GPIO_DMA_WRITE_REQ, 1);
> +    if (s->total_requested == total_requested) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: dma write request not acknowledged\n",
> +                      TYPE_K230_DECOMP_GZIP);
> +        return false;
> +    }
> +    return true;
> +}
> +
> +static bool k230_decomp_gzip_request_output(K230DecompGzipState *s)
> +{
> +    uint32_t slot = s->output.slot;
> +    uint32_t current_offset = s->output.current_offset;
> +
> +    k230_decomp_gzip_set_output(s, K230_DECOMP_GZIP_GPIO_DMA_READ_REQ, 1);
> +    if (s->output.slot == slot &&
> +        s->output.current_offset == current_offset) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: dma read request not acknowledged\n",
> +                      TYPE_K230_DECOMP_GZIP);
> +        return false;
> +    }
> +    return true;
> +}
> +
> +static bool k230_decomp_gzip_init_stream(K230DecompGzipState *s)
> +{
> +    uint8_t btype = (s->input_buf[10] >> 1) & 0x3;
> +    if (btype != DEFLATE_BTYPE_DYNAMIC) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: unsupported DEFLATE BTYPE %u\n",
> +                      TYPE_K230_DECOMP_GZIP, btype);
> +        return false;
> +    }
> +
> +    /* The compression script for K230 will modify the third byte to 0x9 */
> +    if (s->input_buf[2] == GZIP_METHOD_VENDOR_9) {
> +        s->input_buf[2] = GZIP_METHOD_DEFLATE;
> +    }
> +
> +    if (inflateInit2(&s->zs, 15 + 16) != Z_OK) {
> +        return false;
> +    }
> +
> +    s->zstream_inited = true;
> +    return true;
> +}
> +
> +static bool k230_decomp_gzip_run_inflate(K230DecompGzipState *s)
> +{
> +    uint32_t output_size = s->gzip_out_size;
> +    uint32_t current_input_size = k230_decomp_gzip_current_input_size(s);
> +    uint32_t avail_in;
> +    uint32_t avail_out;
> +    uint32_t consumed;
> +    uint32_t produced;
> +    int ret;
> +
> +    avail_in = current_input_size - s->input.current_offset;
> +    avail_out = K230_DECOMP_GZIP_BLOCK_SIZE - s->output.current_offset;
> +
> +    s->zs.next_in = s->input_buf + s->input.current_offset;
> +    s->zs.avail_in = avail_in;
> +    s->zs.next_out = s->output_buf;
> +    s->zs.avail_out = avail_out;
> +
> +    ret = inflate(&s->zs, Z_NO_FLUSH);
> +    if (ret != Z_OK && ret != Z_STREAM_END && ret != Z_BUF_ERROR) {
> +        return false;
> +    }
> +
> +    consumed = avail_in - s->zs.avail_in;
> +    produced = avail_out - s->zs.avail_out;
> +
> +    if (produced) {
> +        if (s->total_produced + produced > output_size ||
> +            !k230_decomp_gzip_write_mem(s, k230_decomp_gzip_output_addr(s),
> +                                        s->output_buf, produced)) {
> +            return false;
> +        }
> +        s->output.current_offset += produced;
> +        s->total_produced += produced;
> +    }
> +
> +    if (consumed) {
> +        s->input.current_offset += consumed;
> +    }
> +
> +    if (ret == Z_STREAM_END) {
> +        s->stream_end = true;
> +        if (s->total_produced != output_size) {
> +            return false;
> +        }
> +    }
> +
> +    return true;
> +}
> +
> +static void k230_decomp_gzip_kick(K230DecompGzipState *s)
> +{
> +    if (!s->active || s->in_kick) {
> +        return;
> +    }
> +
> +    uint32_t input_size = s->gzip_src_size & K230_DECOMP_GZIP_DMA_IN_MASK;
> +    s->in_kick = true;
> +    while (s->active) {
> +        uint32_t current_input_size = k230_decomp_gzip_current_input_size(s);
> +        /* Output is full or last block */
> +        if (s->output.current_offset == K230_DECOMP_GZIP_BLOCK_SIZE ||
> +            (s->stream_end && s->output.current_offset != 0)) {
> +            if (!k230_decomp_gzip_request_output(s)) {
> +                k230_decomp_gzip_finish(s, false);
> +                break;
> +            }
> +            continue;
> +        }
> +
> +        if (!s->zstream_inited) {
> +            if (!k230_decomp_gzip_request_input(s) ||
> +                !k230_decomp_gzip_init_stream(s)) {
> +                k230_decomp_gzip_finish(s, false);
> +                break;
> +            }
> +            continue;
> +        }
> +
> +        /* Transfer finish */
> +        if (s->stream_end) {
> +            k230_decomp_gzip_finish(s,
> +                                    s->total_produced == s->gzip_out_size);
> +            break;
> +        }
> +
> +        /* Input buf has has been fully decompreed, need request more */
> +        if (s->input.current_offset == current_input_size) {
> +            if (s->total_requested < input_size) {
> +                if (!k230_decomp_gzip_request_input(s)) {
> +                    k230_decomp_gzip_finish(s, false);
> +                    break;
> +                }
> +                continue;
> +            }
> +            k230_decomp_gzip_finish(s, false);
> +            break;
> +        }
> +
> +        /* Decompress the data, input buf or output buf are consumed in one block */
> +        if (!k230_decomp_gzip_run_inflate(s)) {
> +            k230_decomp_gzip_finish(s, false);
> +            break;
> +        }
> +    }
> +    s->in_kick = false;
> +}
> +
> +static void k230_decomp_gzip_handle_ack(void *opaque, int n, int level)
> +{
> +    K230DecompGzipState *s = opaque;
> +
> +    if (!level || !s->active) {
> +        return;
> +    }
> +
> +    switch (n) {
> +    case K230_DECOMP_GZIP_GPIO_DMA_WRITE_ACK:
> +    {
> +        uint32_t input_size = s->gzip_src_size & K230_DECOMP_GZIP_DMA_IN_MASK;
> +        uint32_t chunk = MIN(K230_DECOMP_GZIP_BLOCK_SIZE,
> +                             input_size - s->total_requested);
> +
> +        if (!k230_decomp_gzip_load_input(s, k230_decomp_gzip_input_addr(s),
> +                                         chunk)) {
> +            k230_decomp_gzip_finish(s, false);
> +            return;
> +        }
> +        s->total_requested += chunk;
> +        s->input.slot = (s->input.slot + 1) % K230_DECOMP_GZIP_INPUT_SLOTS;
> +        break;
> +    }
> +    case K230_DECOMP_GZIP_GPIO_DMA_READ_ACK:
> +        if (s->output.current_offset == 0) {
> +            k230_decomp_gzip_finish(s, false);
> +            return;
> +        }
> +        s->output.slot = (s->output.slot + 1) % K230_DECOMP_GZIP_OUTPUT_SLOTS;
> +        s->output.current_offset = 0;
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: invalid DMA acknowledgment signal %d\n",
> +                      TYPE_K230_DECOMP_GZIP, n);
> +        return;
> +    }
> +
> +    k230_decomp_gzip_kick(s);
> +}
> +
> +static void k230_decomp_gzip_start(K230DecompGzipState *s)
> +{
> +    uint32_t input_size = s->gzip_src_size & K230_DECOMP_GZIP_DMA_IN_MASK;
> +
> +    k230_decomp_gzip_reset_stream(s);
> +    s->decomp_stat &= ~K230_DECOMP_GZIP_STAT_CRC_OK;
> +    s->total_requested = 0;
> +    s->total_produced = 0;
> +    s->stream_end = false;
> +    memset(&s->input, 0, sizeof(s->input));
> +    memset(&s->output, 0, sizeof(s->output));
> +
> +    if (!(s->gzip_src_size & K230_DECOMP_GZIP_CTRL_EN) ||
> +        input_size == 0 || s->gzip_out_size == 0) {
> +        k230_decomp_gzip_finish(s, false);
> +        return;
> +    }
> +
> +    s->active = true;
> +    k230_decomp_gzip_update_ctrl_en(s);
> +    k230_decomp_gzip_kick(s);
> +}
> +
> +static uint64_t k230_decomp_gzip_read(void *opaque, hwaddr offset,
> +                                      unsigned size)
> +{
> +    K230DecompGzipState *s = opaque;
> +    uint64_t value = 0;
> +
> +    switch (offset) {
> +    case K230_DECOMP_GZIP_DECOMP_START:
> +        value = s->decomp_start & ~K230_DECOMP_GZIP_START; /* start bit is write only */
> +        break;
> +    case K230_DECOMP_GZIP_GZIP_SRC_SIZE:
> +        value = s->gzip_src_size;
> +        break;
> +    case K230_DECOMP_GZIP_GZIP_OUT_SIZE:
> +        value = s->gzip_out_size;
> +        break;
> +    case K230_DECOMP_GZIP_DECOMP_STAT:
> +        value = s->decomp_stat;
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: bad read offset 0x%" HWADDR_PRIx "\n",
> +                      TYPE_K230_DECOMP_GZIP, offset);
> +        break;
> +    }
> +
> +    trace_k230_decomp_gzip_read(offset, size, value);
> +    return value;
> +}
> +
> +static void k230_decomp_gzip_write(void *opaque, hwaddr offset,
> +                                   uint64_t value, unsigned size)
> +{
> +    K230DecompGzipState *s = opaque;
> +
> +    trace_k230_decomp_gzip_write(offset, size, value);
> +
> +    switch (offset) {
> +    case K230_DECOMP_GZIP_DECOMP_START:
> +        s->decomp_start = value;
> +        if (value & K230_DECOMP_GZIP_START) {
> +            k230_decomp_gzip_start(s);
> +        }
> +        break;
> +    case K230_DECOMP_GZIP_GZIP_SRC_SIZE:
> +        s->gzip_src_size = value;
> +        k230_decomp_gzip_update_ctrl_en(s);
> +        break;
> +    case K230_DECOMP_GZIP_GZIP_OUT_SIZE:
> +        s->gzip_out_size = value;
> +        break;
> +    case K230_DECOMP_GZIP_DECOMP_STAT:
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: bad write offset 0x%" HWADDR_PRIx "\n",
> +                      TYPE_K230_DECOMP_GZIP, offset);
> +        break;
> +    }
> +}
> +
> +static const MemoryRegionOps k230_decomp_gzip_ops = {
> +    .read = k230_decomp_gzip_read,
> +    .write = k230_decomp_gzip_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid.min_access_size = 4,
> +    .valid.max_access_size = 4,
> +    .impl.min_access_size = 4,
> +    .impl.max_access_size = 4,
> +};
> +
> +static const VMStateDescription vmstate_k230_decomp_gzip_slot = {
> +    .name = "k230.decomp-gzip.slot",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT32(slot, K230DecompGzipSlotState),
> +        VMSTATE_UINT32(current_offset, K230DecompGzipSlotState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static const VMStateDescription vmstate_k230_decomp_gzip = {
> +    .name = "k230.decomp-gzip",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT32(decomp_start, K230DecompGzipState),
> +        VMSTATE_UINT32(gzip_src_size, K230DecompGzipState),
> +        VMSTATE_UINT32(gzip_out_size, K230DecompGzipState),
> +        VMSTATE_UINT32(decomp_stat, K230DecompGzipState),
> +        VMSTATE_STRUCT(input, K230DecompGzipState, 1,
> +                       vmstate_k230_decomp_gzip_slot,
> +                       K230DecompGzipSlotState),
> +        VMSTATE_STRUCT(output, K230DecompGzipState, 1,
> +                       vmstate_k230_decomp_gzip_slot,
> +                       K230DecompGzipSlotState),
> +        VMSTATE_UINT32(total_requested, K230DecompGzipState),
> +        VMSTATE_UINT32(total_produced, K230DecompGzipState),
> +        VMSTATE_BOOL(active, K230DecompGzipState),
> +        VMSTATE_BOOL(in_kick, K230DecompGzipState),
> +        VMSTATE_BOOL(zstream_inited, K230DecompGzipState),
> +        VMSTATE_BOOL(stream_end, K230DecompGzipState),
> +        VMSTATE_UINT8_ARRAY(input_buf, K230DecompGzipState,
> +                            K230_DECOMP_GZIP_BLOCK_SIZE),
> +        VMSTATE_UINT8_ARRAY(output_buf, K230DecompGzipState,
> +                            K230_DECOMP_GZIP_BLOCK_SIZE),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static void k230_decomp_gzip_reset_hold(Object *obj, ResetType type)
> +{
> +    K230DecompGzipState *s = K230_DECOMP_GZIP(obj);
> +
> +    k230_decomp_gzip_reset_stream(s);
> +    memset(&s->zs, 0, sizeof(s->zs));
> +    s->decomp_start = 0;
> +    s->gzip_src_size = 0;
> +    s->gzip_out_size = 0;
> +    s->decomp_stat = 0;
> +    memset(&s->input, 0, sizeof(s->input));
> +    memset(&s->output, 0, sizeof(s->output));
> +    s->total_requested = 0;
> +    s->total_produced = 0;
> +    s->active = false;
> +    s->in_kick = false;
> +    s->stream_end = false;
> +}
> +
> +static void k230_decomp_gzip_realize(DeviceState *dev, Error **errp)
> +{
> +    K230DecompGzipState *s = K230_DECOMP_GZIP(dev);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> +
> +    memory_region_init_io(&s->iomem, OBJECT(dev), &k230_decomp_gzip_ops, s,
> +                          TYPE_K230_DECOMP_GZIP,
> +                          K230_DECOMP_GZIP_MMIO_SIZE);
> +    sysbus_init_mmio(sbd, &s->iomem);
> +    qdev_init_gpio_in(dev, k230_decomp_gzip_handle_ack,
> +                      K230_DECOMP_GZIP_NUM_GPIOS_IN);
> +    qdev_init_gpio_out(dev, s->signal_out,
> +                       K230_DECOMP_GZIP_NUM_GPIOS_OUT);
> +}
> +
> +static const Property k230_decomp_gzip_properties[] = {
> +    DEFINE_PROP_UINT64("sram-base", K230DecompGzipState, sram_base, 0),
> +};
> +
> +static void k230_decomp_gzip_class_init(ObjectClass *oc, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(oc);
> +    ResettableClass *rc = RESETTABLE_CLASS(oc);
> +
> +    dc->realize = k230_decomp_gzip_realize;
> +    rc->phases.hold = k230_decomp_gzip_reset_hold;
> +    device_class_set_props(dc, k230_decomp_gzip_properties);
> +    dc->vmsd = &vmstate_k230_decomp_gzip;
> +    dc->desc = "Kendryte K230 GZIP decompression engine";
> +}
> +
> +static const TypeInfo k230_decomp_gzip_info = {
> +    .name = TYPE_K230_DECOMP_GZIP,
> +    .parent = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(K230DecompGzipState),
> +    .class_init = k230_decomp_gzip_class_init,
> +};
> +
> +static void k230_decomp_gzip_register_types(void)
> +{
> +    type_register_static(&k230_decomp_gzip_info);
> +}
> +
> +type_init(k230_decomp_gzip_register_types)
> diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> index 23265f6035..6f6bf3c85c 100644
> --- a/hw/misc/meson.build
> +++ b/hw/misc/meson.build
> @@ -36,6 +36,7 @@ system_ss.add(when: 'CONFIG_SIFIVE_E_PRCI', if_true: files('sifive_e_prci.c'))
>   system_ss.add(when: 'CONFIG_SIFIVE_E_AON', if_true: files('sifive_e_aon.c'))
>   system_ss.add(when: 'CONFIG_SIFIVE_U_OTP', if_true: files('sifive_u_otp.c'))
>   system_ss.add(when: 'CONFIG_SIFIVE_U_PRCI', if_true: files('sifive_u_prci.c'))
> +system_ss.add(when: 'CONFIG_K230_DECOMP_GZIP', if_true: files('k230_decomp_gzip.c'))
>   
>   subdir('macio')
>   
> diff --git a/hw/misc/trace-events b/hw/misc/trace-events
> index c9a868b3ef..16db4ba0cc 100644
> --- a/hw/misc/trace-events
> +++ b/hw/misc/trace-events
> @@ -442,3 +442,7 @@ iommu_testdev_dma_read(uint64_t gva, uint32_t len) "gva=0x%" PRIx64 " len=%u"
>   iommu_testdev_dma_verify(uint32_t expected, uint32_t actual) "expected=0x%x actual=0x%x"
>   iommu_testdev_dma_result(uint32_t result) "DMA completed result=0x%x"
>   iommu_testdev_dma_armed(bool armed) "armed=%d"
> +
> +# k230_decomp_gzip.c
> +k230_decomp_gzip_read(uint64_t offset, unsigned int size, uint64_t value) "K230 DECOMP GZIP read: [0x%"PRIx64"] size %u -> 0x%"PRIx64
> +k230_decomp_gzip_write(uint64_t offset, unsigned int size, uint64_t value) "K230 DECOMP GZIP write: [0x%"PRIx64"] size %u <- 0x%"PRIx64
> diff --git a/include/hw/misc/k230_decomp_gzip.h b/include/hw/misc/k230_decomp_gzip.h
> new file mode 100644
> index 0000000000..9911af0095
> --- /dev/null
> +++ b/include/hw/misc/k230_decomp_gzip.h
> @@ -0,0 +1,92 @@
> +/*
> + * K230 Decompress Engine
> + *
> + * Copyright (c) 2026 Tao Ding <dingtao0430@163.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_MISC_K230_DECOMP_GZIP_H
> +#define HW_MISC_K230_DECOMP_GZIP_H
> +
> +#include <zlib.h>
> +#include "hw/core/sysbus.h"
> +
> +#define TYPE_K230_DECOMP_GZIP "riscv.k230.decomp-gzip"
> +OBJECT_DECLARE_SIMPLE_TYPE(K230DecompGzipState, K230_DECOMP_GZIP)
> +
> +/* K230 DECOMP GZIP ACK input */
> +enum {
> +    K230_DECOMP_GZIP_GPIO_DMA_WRITE_ACK,
> +    K230_DECOMP_GZIP_GPIO_DMA_READ_ACK,
> +    K230_DECOMP_GZIP_NUM_GPIOS_IN,
> +};
> +
> +/* K230 DECOMP GZIP REQ output */
> +enum {
> +    K230_DECOMP_GZIP_GPIO_DECOMP_CTRL_EN,
> +    K230_DECOMP_GZIP_GPIO_DMA_WRITE_REQ,
> +    K230_DECOMP_GZIP_GPIO_DMA_READ_REQ,
> +    K230_DECOMP_GZIP_NUM_GPIOS_OUT,
> +};
> +
> +#define K230_DECOMP_GZIP_MMIO_SIZE       0x4000
> +
> +/* K230 DECOMP GZIP Registers map */
> +/* Start decompression controller */
> +#define K230_DECOMP_GZIP_DECOMP_START    0x00
> +/* Source data length register */
> +#define K230_DECOMP_GZIP_GZIP_SRC_SIZE   0x04
> +/* Output data length register */
> +#define K230_DECOMP_GZIP_GZIP_OUT_SIZE   0x08
> +/* Decompress status register */
> +#define K230_DECOMP_GZIP_DECOMP_STAT     0x0c
> +
> +/* Start decompression controller */
> +#define K230_DECOMP_GZIP_START           (1U << 0)
> +
> +#define K230_DECOMP_GZIP_CTRL_EN         (1U << 31)
> +#define K230_DECOMP_GZIP_DMA_IN_MASK     0x7fffffffU
> +
> +#define K230_DECOMP_GZIP_STAT_CRC_OK     (1U << 10)
> +#define K230_DECOMP_GZIP_STAT_STATE_MASK 0xfU
> +
> +#define K230_DECOMP_GZIP_BLOCK_SIZE      0x00020000
> +#define K230_DECOMP_GZIP_SRAM_IN_BASE    0x80000
> +#define K230_DECOMP_GZIP_SRAM_OUT_BASE   0
> +
> +typedef struct K230DecompGzipSlotState {
> +    uint32_t slot;  /* Slot index */
> +    /*
> +     * Data offset in current slot.
> +     * First valid data in input buffer. Last valid data in output buffer.
> +     */
> +    uint32_t current_offset;
> +} K230DecompGzipSlotState;
> +
> +struct K230DecompGzipState {
> +    SysBusDevice parent_obj;
> +
> +    MemoryRegion iomem;
> +    hwaddr sram_base;
> +    qemu_irq signal_out[K230_DECOMP_GZIP_NUM_GPIOS_OUT];
> +    uint32_t decomp_start;
> +    uint32_t gzip_src_size;
> +    uint32_t gzip_out_size;
> +    uint32_t decomp_stat;
> +    K230DecompGzipSlotState input;  /* decomp gzip ring input */
> +    K230DecompGzipSlotState output; /* decomp gzip ring output */
> +    uint32_t total_requested;
> +    uint32_t total_produced;
> +    bool active;
> +    bool in_kick;
> +    bool zstream_inited;
> +    bool stream_end;
> +    /* Read from ring input. */
> +    uint8_t input_buf[K230_DECOMP_GZIP_BLOCK_SIZE];
> +    /* Write to ring output. */
> +    uint8_t output_buf[K230_DECOMP_GZIP_BLOCK_SIZE];
> +    z_stream zs;
> +};
> +
> +#endif


