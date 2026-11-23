Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3175606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 13:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UIDKiIFF;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BonLpzsb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVTm0-0000yX-0B; Mon, 23 Nov 2026 08:07:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xVTlv-0000wE-KH
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 08:07:52 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xVTlr-0003qe-4J
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 08:07:51 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ANCG6Hi2928622
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 13:07:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dtJDvJSIwKXN6n5/Zr++rtTlhIBEoazb3hCnbzSK10s=; b=UIDKiIFFZnpVsDxr
 GIWqveuvGALZDZvgH1DS+6v4hD+Vd0wN4CGIajqPBL68QQ1R8nR/XAlRB8Uu5f/H
 2FtcREwGGpPO8z6AlNIgH82uNSgvmRmSmtufVcBqECz3qGXKd4GvIhiBqG3r1R8c
 miks1XScgRMuX5q2bVcOqdqqqJa0hoP0SmYkaSWhkCjsK8Cv/LseNxYvmY5KbSMx
 +0fCD4tZ5PS7OFBOU2qQtWRM/LUqq5S+6tMY0mHqsjOyjKM/TEadcSKh+bYDQl1W
 Hb4yILbZTMACfh7wDcUbTquUV2m2Fuj9LrtvpWFPalNYmY/E2ITlpwkdqloNR8sH
 FhyThQ==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4hn7s434-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 13:07:46 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-8520e83f715so3611436a34.2
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 05:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795439265; x=1796044065; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=dtJDvJSIwKXN6n5/Zr++rtTlhIBEoazb3hCnbzSK10s=;
 b=BonLpzsbJneax1wRiQ10PKpPBEU44XZmbz4kqT21xgf/HpGaGsgJW4ZDdJyCEhyE0j
 d/Av73na1In4/ILJJchafn7K4TGW63/0DG7FgrfgCQBZC9QLrLOKEnWsa6WU9W1wO8Qr
 67ux3ax2EtaCzPP/YTlZ1ladXV5NOI+36YWpzW6oNm9iDj9lhRlD6EzeHSVDRF4UG9BH
 gpSnBZl/1DB8qzNX9EgEIyvomTrd4FxYCy04SHzJyxfaIjlY8J5z+fDM0bVoFmk6tbhN
 mgGGG/KtTZgt05ngRhtN/PdhBLyMftW99EoTDCFOwfQh9WJMrJHT2fJcFtgQTI7tpmqT
 O45g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795439265; x=1796044065;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dtJDvJSIwKXN6n5/Zr++rtTlhIBEoazb3hCnbzSK10s=;
 b=lMhysS2H2PYZtk0OlyZb6z72fn5rBJLgfYj2n2q5Bo+z2f754XcNJ4JVYvd5Mf/ij7
 rUrdR6aPDiKndObxmnBBIzze+Rjr5eMyNn14dnFZOwJYzzxCIG7Idb5D5Y0AEwC1FlMe
 /84+8cMCDNl6pbs0VIUspkwgx/6iGrDtO6JVsyKh5YbhzNVt+VJm3RfM62zmtskfhUF3
 4QMZOc06xVBQAMgqlZj7BDLzWAudv16oyiM4yJj6vLtvCZVEQGiycSOkGv1LmLb+DTE3
 bGHQupqNuK4Ilv2FWXzuXKgm6Y26JnfB+XZvodwCXcnuBQOmH8aQOR05+IFL19S54ngy
 9KvQ==
X-Forwarded-Encrypted: i=1;
 AL+hErED+JdfuL7hPS4FOTTUKohDXCIKQKDs0N9UDaVVPKpT9+GlFKfDKIKIOJL6ZHPTvt6lkQOryz7QBMi5@nongnu.org
X-Gm-Message-State: APuU4Z8/aLyPKmptYtDtbrH86Ec/IXfPfe3ukO0HxfwF+n1CqTccI7xc
 cT3eYp7mz4vTXnNsmtQERi7B8fKh68VfN5QeqWOZkIp3V08z8UVEKNOaWKyM94+fdLbrgn1MJu0
 9G2G4VDO+Bh55xbxLnoam/V92ozeOiEdwVlrBCo2ceuOZ3/zv3tiTAF2VHi6Oc5SBXA==
X-Gm-Gg: AZFdTZfEHwdh8fEeNUwF9S3gd/PUhpB52JnKjnSqxLHii6FCwxJ8ws9qHPCCN3Xup8l
 N1iqaeqYLaudkWbwo7Mf3Al6Yxn+jpM6/y9/KSEXfkdOZkzYZXdwbJIxfe0GbduAt8t9rzxvufF
 Eg7cUMvhSF7hYXkSUg2r77uvp3tJjz4ebXQo7F99d2+BgqytfSwuzHSVUT4jH3MhCpuXcrKCXz1
 JOwx+ymO0QBK7RXxQg9fWPXtrNGsZd/l0VDSnVCVI4FdHK88hyZGRouVOu18nAnKPOF93cqNajm
 ekOhMwQTKYMYetFwj8BylrYcRGWNYWRtC7kvom0fbq/bhXjasS3U7ORNP1Fn7bH0hbs5k02kPCe
 w+Rb1ZmFUjQ34yk+abms8MhZe/y8cIzoUimNbNcXLIxwDboXYfjWFPFd+oyEg6qgQjs6bMJa17D
 9HyBUYdJbV
X-Received: by 2002:a05:6808:3084:b0:55c:844:98ff with SMTP id
 5614622812f47-57a0a93940fmr13426671b6e.34.1795439265201; 
 Mon, 23 Nov 2026 05:07:45 -0800 (PST)
X-Received: by 2002:a05:6214:8001:b0:921:1ba6:1601 with SMTP id
 6a1803df08f44-92134af7403mr180555256d6.55.1795438883828; 
 Mon, 23 Nov 2026 05:01:23 -0800 (PST)
Received: from [192.168.68.101] ([189.110.107.17])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-921349cd592sm106807396d6.16.2026.11.23.05.01.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2026 05:01:23 -0800 (PST)
Message-ID: <2c4e4c17-1b6f-491b-aa92-7ba1ffdb2a47@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 10:01:19 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 02/10] hw/misc: add RISC-V RPMI transport and Base
 support
To: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
References: <20261111060403.3777501-1-subrahmanya.lingappa@oss.qualcomm.com>
 <20261111060403.3777501-3-subrahmanya.lingappa@oss.qualcomm.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261111060403.3777501-3-subrahmanya.lingappa@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Ls0HWXdc c=1 sm=1 tr=0 ts=6b043aa2 cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=2Chh/y2wedAoPG2p3qwUfw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=V1jnuoLLAAAA:20 a=NEAV23lmAAAA:8 a=hwM_GrIuAAAA:20 a=EUspDBNiAAAA:8
 a=oQwRP8PjHQFr195L1A8A:9 a=QEXdDO2ut3YA:10 a=EXS-LbY8YePsIyqnH6vw:22
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA1MiBTYWx0ZWRfX0cEyZHrympEq
 +uQXqz1PpSv+kDLmB+IuujewhOPxE0ySnu5RyoS8KTMlSi/NA6uhPDJ8lSZtsvq3c/u4V4HoPgo
 Y0yrEEv8OOWnznc3ssFs+i/isP2qX7+iFRs95A0lQdBiP64RMeC2gp9I2kWBCB2wpeT/paqRmYq
 +VjAw2J6HKyENUqtFXtbqfDUFnr1cKjJvDGtt2woX3wk1XSztbDsk0Ue4IYSZ9QV0MLzRFfOv5S
 44x7WRwQNqBEaUB0Zab2eus0zejKMmT4N9PS1DWIjKY5F1q/RAoOAyUsm1YgXK9JTJD50zgWeWQ
 CTsS06KutQYgTTm5HPKKuyfpw3q7pbQ+glSBZZdlCBn5pbHTq0SqhtGa73vlV3VT9Ed9dHk3lhC
 ypJBQQtKYQfeSexOSjwanYAgs4EmaIwYWLre/x9hSONmEJfygG8PPCtS9ZimBsiSrrW3cSk+qbY
 A8mwR/Upcp3ehwqrDBw==
X-Proofpoint-GUID: 4MGo6VPFlzqRZvAk-gYfqsFAyDeOq6Oi
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA1MiBTYWx0ZWRfXxLorde898/mu
 LJuNj9cDkU8RiRDhal3IHLIvKH30J+Z/F26JaOtTSmC9ddHoygG0QlpcMVRNdYzI3qdVPXJY1zt
 vLP0Wm8afG3FpXZ624HhgYGBwtdc/SQ=
X-Proofpoint-ORIG-GUID: 4MGo6VPFlzqRZvAk-gYfqsFAyDeOq6Oi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611230052
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/11/2026 3:03 AM, Subrahmanya Lingappa wrote:
> RPMI (RISC-V Platform Management Interface) is the RISC-V non-ISA
> platform management specification. It defines a shared-memory transport,
> message protocol, and service groups for platform management.
> 
> Add the QEMU transport backend and Base service plumbing for virt using
> librpmi. Keep context lifecycle, service-group changes, and request
> dispatch under the existing device paths' BQL ownership. Document that
> the librpmi environment lock hooks are no-ops because QEMU provides
> synchronization at the call sites that need it.
> 
> This implementation targets the RISC-V Platform Management Interface
> (RPMI) Specification v1.0 Ratified:
> 
> https://github.com/riscv-non-isa/riscv-rpmi/releases/download/v1.0/riscv-rpmi.pdf
> 
> The librpmi backend is maintained at:
> 
> https://github.com/riscv-software-src/librpmi
> 
> Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   MAINTAINERS                   |   2 +
>   hw/misc/Kconfig               |   4 +
>   hw/misc/meson.build           |   4 +
>   hw/misc/riscv_rpmi-stub.c     |  16 ++
>   hw/misc/riscv_rpmi.c          | 514 ++++++++++++++++++++++++++++++++++
>   hw/misc/riscv_rpmi_internal.h |  25 ++
>   include/hw/misc/riscv_rpmi.h  |  92 ++++++
>   7 files changed, 657 insertions(+)
>   create mode 100644 hw/misc/riscv_rpmi-stub.c
>   create mode 100644 hw/misc/riscv_rpmi.c
>   create mode 100644 hw/misc/riscv_rpmi_internal.h
>   create mode 100644 include/hw/misc/riscv_rpmi.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 55463103ff..7f7764b03b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -379,6 +379,8 @@ F: gdbstub/gdb-xml/riscv*.xml
>   F: hw/char/riscv_htif.c
>   F: hw/riscv/
>   F: hw/intc/riscv*
> +F: hw/misc/riscv_rpmi*
> +F: include/hw/misc/riscv_rpmi.h
>   F: include/hw/char/riscv_htif.h
>   F: include/hw/riscv/
>   F: common-user/host/riscv*
> diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
> index 685b7ff1e7..cabdf3473c 100644
> --- a/hw/misc/Kconfig
> +++ b/hw/misc/Kconfig
> @@ -303,3 +303,7 @@ source macio/Kconfig
>   
>   config QCOM_QDSP6SS_CLK
>       bool
> +
> +config RISCV_RPMI
> +    bool
> +    depends on LIBRPMI
> diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> index fc3800baec..b755796170 100644
> --- a/hw/misc/meson.build
> +++ b/hw/misc/meson.build
> @@ -182,3 +182,7 @@ system_ss.add(when: 'CONFIG_AXIADO_CLK', if_true: files('axiado_clk.c'))
>   
>   # Qualcomm Hexagon DSP subsystems
>   system_ss.add(when: 'CONFIG_QCOM_QDSP6SS_CLK', if_true: files('qcom-qdsp6ss-clk.c'))
> +
> +system_ss.add(when: 'CONFIG_RISCV_RPMI', if_true: [files(
> +  'riscv_rpmi.c',
> +), librpmi], if_false: files('riscv_rpmi-stub.c'))
> diff --git a/hw/misc/riscv_rpmi-stub.c b/hw/misc/riscv_rpmi-stub.c
> new file mode 100644
> index 0000000000..dc32b43227
> --- /dev/null
> +++ b/hw/misc/riscv_rpmi-stub.c
> @@ -0,0 +1,16 @@
> +/*
> + * RISC-V RPMI stubs.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "hw/misc/riscv_rpmi.h"
> +
> +DeviceState *riscv_rpmi_create(const RiscvRpmiConfig *cfg G_GNUC_UNUSED,
> +                               Error **errp)
> +{
> +    error_setg(errp, "RISC-V RPMI support is not compiled in");
> +    return NULL;
> +}
> diff --git a/hw/misc/riscv_rpmi.c b/hw/misc/riscv_rpmi.c
> new file mode 100644
> index 0000000000..3a30d879aa
> --- /dev/null
> +++ b/hw/misc/riscv_rpmi.c
> @@ -0,0 +1,514 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * RISC-V RPMI transport device.
> + *
> + * Copyright (c) 2026 Qualcomm Technologies, Inc.
> + * Author:
> + *  Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qemu/log.h"
> +#include "qemu/module.h"
> +#include "hw/core/qdev-properties.h"
> +#include "hw/misc/riscv_rpmi.h"
> +#include "hw/misc/riscv_rpmi_internal.h"
> +#include "migration/vmstate.h"
> +#include "system/address-spaces.h"
> +#include "system/memory.h"
> +#include "system/runstate.h"
> +#include "librpmi.h"
> +#include "librpmi_env.h"
> +
> +/*
> + * These functions implement the platform hooks declared by librpmi_env.h.
> + * See https://github.com/riscv-software-src/librpmi/blob/main/include/
> + * librpmi_env.h for the external hook declarations and their contract.
> + */
> +void *rpmi_env_zalloc(rpmi_size_t size)
> +{
> +    return g_malloc0(size);
> +}
> +
> +void rpmi_env_free(void *ptr)
> +{
> +    g_free(ptr);
> +}
> +
> +void rpmi_env_writel(rpmi_uint64_t addr, rpmi_uint32_t val)
> +{
> +    MemTxResult result;
> +
> +    address_space_stl_le(&address_space_memory, addr, val,
> +                         MEMTXATTRS_UNSPECIFIED, &result);
> +    if (result != MEMTX_OK) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: failed write at 0x%" PRIx64
> +                      " (result 0x%x)\n",
> +                      __func__, (uint64_t)addr, result);
> +    }
> +}
> +
> +static enum rpmi_error riscv_rpmi_memtx_result_to_error(MemTxResult result)
> +{
> +    return result == MEMTX_OK ? RPMI_SUCCESS : RPMI_ERR_IO;
> +}
> +
> +static bool riscv_rpmi_addr_in_range(uint64_t addr, uint32_t len,
> +                                     uint64_t base, uint64_t size)
> +{
> +    return len && size >= len && addr >= base && addr - base <= size - len;
> +}
> +
> +static enum rpmi_error shmem_qemu_read(void *priv, rpmi_uint64_t addr,
> +                                       void *buf, rpmi_uint32_t len)
> +{
> +    RiscvRpmiState *s = RISCV_RPMI(priv);
> +
> +    if (!s || !buf ||
> +        !riscv_rpmi_addr_in_range(addr, len, s->shmem_base,
> +                                  s->shmem_size)) {
> +        return RPMI_ERR_BAD_RANGE;
> +    }
> +
> +    return riscv_rpmi_memtx_result_to_error(
> +        address_space_read(&address_space_memory, addr,
> +                           MEMTXATTRS_UNSPECIFIED, buf, len));
> +}
> +
> +static enum rpmi_error shmem_qemu_write(void *priv, rpmi_uint64_t addr,
> +                                       const void *buf, rpmi_uint32_t len)
> +{
> +    RiscvRpmiState *s = RISCV_RPMI(priv);
> +
> +    if (!s || !buf ||
> +        !riscv_rpmi_addr_in_range(addr, len, s->shmem_base,
> +                                  s->shmem_size)) {
> +        return RPMI_ERR_BAD_RANGE;
> +    }
> +
> +    return riscv_rpmi_memtx_result_to_error(
> +        address_space_write(&address_space_memory, addr,
> +                            MEMTXATTRS_UNSPECIFIED, buf, len));
> +}
> +
> +static enum rpmi_error shmem_qemu_fill(void *priv, rpmi_uint64_t addr,
> +                                       char ch, rpmi_uint32_t len)
> +{
> +    RiscvRpmiState *s = RISCV_RPMI(priv);
> +
> +    if (!s ||
> +        !riscv_rpmi_addr_in_range(addr, len, s->shmem_base,
> +                                  s->shmem_size)) {
> +        return RPMI_ERR_BAD_RANGE;
> +    }
> +
> +    return riscv_rpmi_memtx_result_to_error(
> +        address_space_set(&address_space_memory, addr, (uint8_t)ch, len,
> +                          MEMTXATTRS_UNSPECIFIED));
> +}
> +
> +const struct rpmi_shmem_platform_ops rpmi_shmem_qemu_ops = {
> +    .read = shmem_qemu_read,
> +    .write = shmem_qemu_write,
> +    .fill = shmem_qemu_fill,
> +};
> +
> +static uint64_t riscv_rpmi_read(void *opaque, hwaddr offset, unsigned int size)
> +{
> +    RiscvRpmiState *s = opaque;
> +
> +    if (offset != 0 || size != 4) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: invalid read at 0x%" HWADDR_PRIx " size %u\n",
> +                      __func__, offset, size);
> +        return 0;
> +    }
> +
> +    return s->doorbell;
> +}
> +
> +static bool riscv_rpmi_transport_indices_valid(RiscvRpmiState *s);
> +
> +static void riscv_rpmi_write(void *opaque, hwaddr offset, uint64_t value,
> +                             unsigned int size)
> +{
> +    RiscvRpmiState *s = opaque;
> +
> +    if (offset != 0 || size != 4) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: invalid write at 0x%" HWADDR_PRIx " size %u\n",
> +                      __func__, offset, size);
> +        return;
> +    }
> +
> +    s->doorbell = value;
> +
> +    if (value == 1) {
> +        if (s->context && riscv_rpmi_transport_indices_valid(s)) {
> +            riscv_rpmi_context_process_a2p_request(s);
> +        }
> +        s->doorbell = 0;
> +    }
> +}
> +
> +static const MemoryRegionOps riscv_rpmi_ops = {
> +    .read = riscv_rpmi_read,
> +    .write = riscv_rpmi_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid = {
> +        .min_access_size = 4,
> +        .max_access_size = 4,
> +    },
> +};
> +
> +static bool riscv_rpmi_queue_indices_valid(RiscvRpmiState *s,
> +                                           uint64_t queue_base,
> +                                           uint32_t queue_size)
> +{
> +    uint8_t *shmem = memory_region_get_ram_ptr(&s->shmem);
> +    uint32_t data_slots = queue_size / RPMI_QUEUE_SLOT_SIZE - 2;
> +    uint32_t head;
> +    uint32_t tail;
> +
> +    head = ldl_le_p(shmem + queue_base);
> +    tail = ldl_le_p(shmem + queue_base + RPMI_QUEUE_SLOT_SIZE);
> +    if (head >= data_slots || tail >= data_slots) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: invalid queue indices head %u tail %u slots %u\n",
> +                      __func__, head, tail, data_slots);
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
> +static bool riscv_rpmi_transport_indices_valid(RiscvRpmiState *s)
> +{
> +    if (!s->has_shmem || !s->a2p_req_size) {
> +        return false;
> +    }
> +
> +    if (!riscv_rpmi_queue_indices_valid(s, 0, s->a2p_req_size)) {
> +        return false;
> +    }
> +
> +    return riscv_rpmi_queue_indices_valid(s, s->a2p_req_size,
> +                                          s->a2p_req_size);
> +}
> +
> +static void riscv_rpmi_configure_base(RiscvRpmiState *s,
> +                                      const RiscvRpmiConfig *cfg)
> +{
> +    s->platform_info = g_strdup(cfg->platform_info);
> +    s->services = cfg->services;
> +    s->service_count = cfg->service_count;
> +
> +    s->hart_count = cfg->hart_count;
> +    if (cfg->hart_ids) {
> +        s->hart_ids = g_memdup2(cfg->hart_ids,
> +                                cfg->hart_count * sizeof(*cfg->hart_ids));
> +    }
> +}
> +
> +static void riscv_rpmi_init(Object *obj)
> +{
> +    RiscvRpmiState *s = RISCV_RPMI(obj);
> +
> +    memory_region_init_io(&s->mmio, obj, &riscv_rpmi_ops, s,
> +                          TYPE_RISCV_RPMI, RPMI_DBREG_SIZE);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
> +}
> +
> +static void riscv_rpmi_reset_hold(Object *obj, ResetType type)
> +{
> +    RiscvRpmiState *s = RISCV_RPMI(obj);
> +
> +    s->doorbell = 0;
> +
> +    if (s->has_shmem) {
> +        memset(memory_region_get_ram_ptr(&s->shmem), 0, s->shmem_size);
> +        memory_region_set_dirty(&s->shmem, 0, s->shmem_size);
> +    }
> +}
> +
> +static void riscv_rpmi_cleanup(RiscvRpmiState *s)
> +{
> +    if (s->context) {
> +        rpmi_context_destroy(s->context);
> +        s->context = NULL;
> +    }
> +
> +    if (s->transport) {
> +        rpmi_transport_shmem_destroy(s->transport);
> +        s->transport = NULL;
> +    }
> +
> +    if (s->rpmi_shmem) {
> +        rpmi_shmem_destroy(s->rpmi_shmem);
> +        s->rpmi_shmem = NULL;
> +    }
> +
> +    if (s->has_shmem) {
> +        memory_region_del_subregion(get_system_memory(), &s->shmem);
> +        s->has_shmem = false;
> +    }
> +}
> +
> +bool riscv_rpmi_service_enabled(RiscvRpmiState *s,
> +                                enum rpmi_servicegroup_id service_group)
> +{
> +    uint32_t i;
> +
> +    for (i = 0; i < s->service_count; i++) {
> +        if (s->services[i].service_group == service_group) {
> +            return true;
> +        }
> +    }
> +
> +    return false;
> +}
> +
> +void riscv_rpmi_context_process_a2p_request(RiscvRpmiState *s)
> +{
> +    if (s->context) {
> +        rpmi_context_process_a2p_request(s->context);
> +    }
> +}
> +
> +static bool riscv_rpmi_validate_config(RiscvRpmiState *s, Error **errp)
> +{
> +    uint64_t queue_bytes;
> +
> +    if (!s->shmem_size) {
> +        error_setg(errp, "RPMI shared memory size must be non-zero");
> +        return false;
> +    }
> +
> +    if (s->shmem_base & (RPMI_QUEUE_SLOT_SIZE - 1)) {
> +        error_setg(errp, "RPMI shared memory base must be %u-byte aligned",
> +                   RPMI_QUEUE_SLOT_SIZE);
> +        return false;
> +    }
> +
> +    if (s->a2p_req_size < RPMI_DATA_SLOT_SIZE) {
> +        error_setg(errp,
> +                   "RPMI A2P request queue needs at least one data slot");
> +        return false;
> +    }
> +
> +    if (!s->hart_count || !s->hart_ids) {
> +        error_setg(errp, "RPMI transport requires hart IDs");
> +        return false;
> +    }
> +
> +    for (uint32_t i = 0; i < s->hart_count; i++) {
> +        for (uint32_t j = i + 1; j < s->hart_count; j++) {
> +            if (s->hart_ids[i] == s->hart_ids[j]) {
> +                error_setg(errp, "RPMI hart ID %u is duplicated",
> +                           s->hart_ids[i]);
> +                return false;
> +            }
> +        }
> +    }
> +
> +    if (s->service_count && !s->services) {
> +        error_setg(errp, "RPMI service count requires service descriptors");
> +        return false;
> +    }
> +
> +    if (s->a2p_req_size % RPMI_QUEUE_SLOT_SIZE) {
> +        error_setg(errp,
> +                   "RPMI A2P request queue size must be a multiple of %u",
> +                   RPMI_QUEUE_SLOT_SIZE);
> +        return false;
> +    }
> +
> +    if (s->p2a_req_size &&
> +        s->p2a_req_size < RPMI_DATA_SLOT_SIZE) {
> +        error_setg(errp,
> +                   "RPMI P2A request queue needs at least one data slot");
> +        return false;
> +    }
> +
> +    if (s->p2a_req_size % RPMI_QUEUE_SLOT_SIZE) {
> +        error_setg(errp,
> +                   "RPMI P2A request queue size must be a multiple of %u",
> +                   RPMI_QUEUE_SLOT_SIZE);
> +        return false;
> +    }
> +
> +    queue_bytes = 2 * (uint64_t)s->a2p_req_size +
> +                  2 * (uint64_t)s->p2a_req_size;
> +    if (queue_bytes > s->shmem_size) {
> +        error_setg(errp,
> +                   "RPMI shared memory size 0x%" PRIx64
> +                   " is too small for queues 0x%" PRIx64,
> +                   s->shmem_size, queue_bytes);
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
> +static bool riscv_rpmi_add_service_group(RiscvRpmiState *s,
> +                                         const RiscvRpmiServiceConfig *service,
> +                                         Error **errp)
> +{
> +    error_setg(errp, "unsupported RPMI service group %u",
> +               service->service_group);
> +    return false;
> +}
> +
> +static bool riscv_rpmi_init_services(RiscvRpmiState *s, Error **errp)
> +{
> +    uint32_t i;
> +
> +    for (i = 0; i < s->service_count; i++) {
> +        if (!riscv_rpmi_add_service_group(s, &s->services[i], errp)) {
> +            return false;
> +        }
> +    }
> +
> +    return true;
> +}
> +
> +static bool riscv_rpmi_init_context(RiscvRpmiState *s, Error **errp)
> +{
> +    const char *platform_info = s->platform_info ?: RPMI_PLAT_INFO;
> +
> +    s->rpmi_shmem = rpmi_shmem_create("rpmi-shmem", s->shmem_base,
> +                                      s->shmem_size,
> +                                      &rpmi_shmem_qemu_ops, s);
> +    if (!s->rpmi_shmem) {
> +        error_setg(errp, "failed to create RPMI shared memory backend");
> +        return false;
> +    }
> +
> +    s->transport = rpmi_transport_shmem_create("rpmi-shmem-transport",
> +                                               RPMI_QUEUE_SLOT_SIZE,
> +                                               s->a2p_req_size,
> +                                               s->p2a_req_size,
> +                                               s->rpmi_shmem);
> +    if (!s->transport) {
> +        error_setg(errp, "failed to create RPMI shared memory transport");
> +        return false;
> +    }
> +
> +    s->context = rpmi_context_create("rpmi-virt", s->transport,
> +                                     RPMI_SRVGRP_ID_MAX_COUNT,
> +                                     RPMI_PRIVILEGE_M_MODE,
> +                                     strlen(platform_info) + 1,
> +                                     platform_info);
> +    if (!s->context) {
> +        error_setg(errp, "failed to create RPMI context");
> +        return false;
> +    }
> +
> +    return riscv_rpmi_init_services(s, errp);
> +}
> +
> +static void riscv_rpmi_realize(DeviceState *dev, Error **errp)
> +{
> +    RiscvRpmiState *s = RISCV_RPMI(dev);
> +    g_autofree char *name = NULL;
> +
> +    if (!riscv_rpmi_validate_config(s, errp)) {
> +        return;
> +    }
> +
> +    name = g_strdup_printf("rpmi-shmem@%" PRIx64, s->shmem_base);
> +    if (!memory_region_init_ram(&s->shmem, OBJECT(dev), name, s->shmem_size,
> +                                errp)) {
> +        return;
> +    }
> +
> +    memory_region_add_subregion(get_system_memory(), s->shmem_base, &s->shmem);
> +    s->has_shmem = true;
> +
> +    if (!riscv_rpmi_init_context(s, errp)) {
> +        riscv_rpmi_cleanup(s);
> +    }
> +}
> +
> +static void riscv_rpmi_unrealize(DeviceState *dev)
> +{
> +    riscv_rpmi_cleanup(RISCV_RPMI(dev));
> +}
> +
> +static const VMStateDescription riscv_rpmi_vmstate = {
> +    .name = TYPE_RISCV_RPMI,
> +    .unmigratable = 1,
> +};
> +
> +static const Property riscv_rpmi_properties[] = {
> +    DEFINE_PROP_UINT64("shmem-base", RiscvRpmiState, shmem_base, 0),
> +    DEFINE_PROP_UINT64("shmem-size", RiscvRpmiState, shmem_size, 0),
> +    DEFINE_PROP_UINT32("a2p-req-size", RiscvRpmiState, a2p_req_size, 0),
> +    DEFINE_PROP_UINT32("p2a-req-size", RiscvRpmiState, p2a_req_size, 0),
> +};
> +
> +static void riscv_rpmi_finalize(Object *obj)
> +{
> +    RiscvRpmiState *s = RISCV_RPMI(obj);
> +
> +    g_free(s->platform_info);
> +    g_free(s->hart_ids);
> +}
> +
> +static void riscv_rpmi_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
> +
> +    dc->realize = riscv_rpmi_realize;
> +    dc->unrealize = riscv_rpmi_unrealize;
> +    dc->vmsd = &riscv_rpmi_vmstate;
> +    rc->phases.hold = riscv_rpmi_reset_hold;
> +    device_class_set_props(dc, riscv_rpmi_properties);
> +}
> +
> +static const TypeInfo riscv_rpmi_info = {
> +    .name          = TYPE_RISCV_RPMI,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(RiscvRpmiState),
> +    .instance_init = riscv_rpmi_init,
> +    .instance_finalize = riscv_rpmi_finalize,
> +    .class_init    = riscv_rpmi_class_init,
> +};
> +
> +static void riscv_rpmi_register_types(void)
> +{
> +    type_register_static(&riscv_rpmi_info);
> +}
> +
> +type_init(riscv_rpmi_register_types)
> +
> +DeviceState *riscv_rpmi_create(const RiscvRpmiConfig *cfg, Error **errp)
> +{
> +    DeviceState *dev;
> +    RiscvRpmiState *s;
> +
> +    if (!cfg) {
> +        error_setg(errp, "missing RPMI configuration");
> +        return NULL;
> +    }
> +
> +    dev = qdev_new(TYPE_RISCV_RPMI);
> +    qdev_prop_set_uint64(dev, "shmem-base", cfg->shmem_base);
> +    qdev_prop_set_uint64(dev, "shmem-size", cfg->shmem_size);
> +    qdev_prop_set_uint32(dev, "a2p-req-size", cfg->a2p_req_size);
> +    qdev_prop_set_uint32(dev, "p2a-req-size", cfg->p2a_req_size);
> +
> +    s = RISCV_RPMI(dev);
> +    riscv_rpmi_configure_base(s, cfg);
> +
> +    if (!sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), errp)) {
> +        return NULL;
> +    }
> +
> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, cfg->doorbell_base);
> +    return dev;
> +}
> diff --git a/hw/misc/riscv_rpmi_internal.h b/hw/misc/riscv_rpmi_internal.h
> new file mode 100644
> index 0000000000..95aa8dec14
> --- /dev/null
> +++ b/hw/misc/riscv_rpmi_internal.h
> @@ -0,0 +1,25 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * RISC-V RPMI internal service helpers.
> + *
> + * Copyright (c) 2026 Qualcomm Technologies, Inc.
> + * Author:
> + *  Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
> + */
> +
> +#ifndef HW_MISC_RISCV_RPMI_INTERNAL_H
> +#define HW_MISC_RISCV_RPMI_INTERNAL_H
> +
> +#include "qapi/error.h"
> +#include "hw/misc/riscv_rpmi.h"
> +#include "librpmi.h"
> +
> +#define RPMI_PLAT_INFO "QEMU RISC-V RPMI"
> +
> +extern const struct rpmi_shmem_platform_ops rpmi_shmem_qemu_ops;
> +bool riscv_rpmi_service_enabled(RiscvRpmiState *s,
> +                                enum rpmi_servicegroup_id service_group);
> +void riscv_rpmi_context_process_a2p_request(RiscvRpmiState *s);
> +
> +#endif
> diff --git a/include/hw/misc/riscv_rpmi.h b/include/hw/misc/riscv_rpmi.h
> new file mode 100644
> index 0000000000..c207501405
> --- /dev/null
> +++ b/include/hw/misc/riscv_rpmi.h
> @@ -0,0 +1,92 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * RISC-V RPMI definitions shared by RPMI transport and FDT helpers.
> + *
> + * Copyright (c) 2026 Qualcomm Technologies, Inc.
> + * Author:
> + *  Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
> + */
> +
> +#ifndef HW_MISC_RISCV_RPMI_H
> +#define HW_MISC_RISCV_RPMI_H
> +
> +#include "exec/hwaddr.h"
> +#include "hw/core/sysbus.h"
> +#include "qom/object.h"
> +
> +#ifdef CONFIG_LIBRPMI
> +#include "librpmi.h"
> +#else
> +enum rpmi_servicegroup_id {
> +    RPMI_SRVGRP_SYSTEM_RESET = 0x0003,
> +    RPMI_SRVGRP_SYSTEM_SUSPEND = 0x0004,
> +    RPMI_SRVGRP_HSM = 0x0005,
> +};
> +#endif
> +
> +#define RPMI_QUEUE_SLOT_SIZE 64
> +/* Minimum queue size: head, tail, and one data slot. */
> +#define RPMI_DATA_SLOT_SIZE  (3 * RPMI_QUEUE_SLOT_SIZE)
> +#define RPMI_DBREG_SIZE      0x1000
> +
> +#define RPMI_ALL_NUM_QUEUES 4
> +#define RPMI_A2P_NUM_QUEUES 2
> +#define RPMI_ALL_NUM_REGS   (RPMI_ALL_NUM_QUEUES + 1)
> +#define RPMI_A2P_NUM_REGS   (RPMI_A2P_NUM_QUEUES + 1)
> +
> +#define TYPE_RISCV_RPMI "riscv-rpmi"
> +OBJECT_DECLARE_SIMPLE_TYPE(RiscvRpmiState, RISCV_RPMI)
> +
> +struct rpmi_context;
> +struct rpmi_service_group;
> +struct rpmi_shmem;
> +struct rpmi_transport;
> +
> +typedef struct RiscvRpmiServiceConfig {
> +    const char *node_name;
> +    const char *compatible;
> +    enum rpmi_servicegroup_id service_group;
> +    bool has_mpxy_channel;
> +    uint32_t mpxy_channel;
> +} RiscvRpmiServiceConfig;
> +
> +typedef struct RiscvRpmiConfig {
> +    hwaddr doorbell_base;
> +    hwaddr shmem_base;
> +    hwaddr shmem_size;
> +    uint32_t a2p_req_size;
> +    uint32_t p2a_req_size;
> +    const char *platform_info;
> +
> +    const uint32_t *hart_ids;
> +    uint32_t hart_count;
> +    const RiscvRpmiServiceConfig *services;
> +    uint32_t service_count;
> +} RiscvRpmiConfig;
> +
> +struct RiscvRpmiState {
> +    SysBusDevice parent_obj;
> +
> +    MemoryRegion mmio;
> +    MemoryRegion shmem;
> +    uint64_t shmem_base;
> +    uint64_t shmem_size;
> +    uint32_t a2p_req_size;
> +    uint32_t p2a_req_size;
> +    char *platform_info;
> +
> +    uint32_t *hart_ids;
> +    uint32_t hart_count;
> +    const RiscvRpmiServiceConfig *services;
> +    uint32_t service_count;
> +    uint32_t doorbell;
> +    struct rpmi_shmem *rpmi_shmem;
> +    struct rpmi_transport *transport;
> +    struct rpmi_context *context;
> +    bool has_shmem;
> +};
> +
> +DeviceState *riscv_rpmi_create(const RiscvRpmiConfig *cfg, Error **errp);
> +
> +#endif


