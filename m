Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74E09CD3427
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 11:14:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKwgI-0007Xf-3x; Thu, 07 May 2026 07:14:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wKwgG-0007XJ-Aj
 for qemu-devel@nongnu.org; Thu, 07 May 2026 07:14:12 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wKwgD-0006m3-Hh
 for qemu-devel@nongnu.org; Thu, 07 May 2026 07:14:12 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6475LJuk1067863
 for <qemu-devel@nongnu.org>; Thu, 7 May 2026 11:14:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 aG1VkJm9Cl89SRF6w+Sej3FQ4XE2ddgp5BXyGU2sJ3g=; b=dgboCT7kRSU6KUIv
 D92qPNnnKwF3JewA+6w/Gn1qqAgAvb0IU6xkdkvdu6QG8vJOcUvfqgSIoXvWOTWX
 RJP1Lvym3ufwTgfpdLdq5EBgP8iWTZQGF9IlJ3wVLKn8t9kDnMDRZuJuXGAY+7GH
 fsxN3ysPqobE05pfa2c87mQXpNLKOuzmeszvMXOWZALGDi5oGvcbDEj4UVLwRy8r
 xkI31WGPQ8+Y7K+8MpTuP471ZAaC0I+s6n3LK1wV8dfAgM+zlD3MW5tF9zluAwKq
 lBuvLtH7bFwypiJY2eZHr5uiJZLhgRs1rCOw8dUrl0U7Om9k/xFXgIcaSkJTzoe7
 jxjYHw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0mh199gw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 11:14:07 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8eaee67d1afso71480985a.1
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 04:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778152446; x=1778757246; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aG1VkJm9Cl89SRF6w+Sej3FQ4XE2ddgp5BXyGU2sJ3g=;
 b=Y8k+tse9Gw/Y0W4kg9N/PRhwwE0elakwuJ1df8v+Fb+s5fMj5htToUutMqcBmj9udV
 yaCVUDd2EoJ4c2Ad4ZW7acqgFZwlTvklEz4IBN30408LzShkc3vgqFLw/Zw5mCp34ZBk
 ragNTDjeB9pwF0xEO0PwKFOEvpI7o3q+XF0xbXwSpIyjVUiooTtvjYq8HIUzVsXBT5fw
 TUWLXdEhWKegORhQLowbzPgPY+Fdcv1+3quslkzrZa9/9wBbFJ1sJWyFD2Bd8JXzZjrK
 8TgCl+GMHLw75OxruLc9m7RqigMXQGnye9tNA25FmXkdhItR0+jXQRG8b7z9HTvccno6
 dKjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778152446; x=1778757246;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aG1VkJm9Cl89SRF6w+Sej3FQ4XE2ddgp5BXyGU2sJ3g=;
 b=beLmHi5IxdJVjbfDtXyNXMcCykw3aBO4xbFQ9Hv/r5KonfU7RlQezcHAVT1QFCMaiF
 xAMV0J5B7hYJlOgqcgzPxFy9QHV9V7MMlRw5HoaP0oEeYKwMNbFKoObUJLky2XRlPKdM
 6PexVyz9pmUGMjF9PpRWpnnAsQIysGgUKIzbtEqSXY/zMED7/Ck8XJGjW8MRJmQsPWbP
 jDWFIab40pHf1Y7zRQZ0fBSSMtuLq0Klyy3Ufyat5qrCB/xJBhsR21BQQ7/jgzcI1Ay9
 vUtkelDgQhlRGEc2FfjMXvvXUheLExddg2CidOlfuVtNzWsGeNiUJiE+RWjkKL8NVtib
 2tig==
X-Forwarded-Encrypted: i=1;
 AFNElJ+abfsLDW7Oin1yu9s8mK9shjBiledT4ctaRn+ceQQL5VUR6QsQy6cbchoMbpCBwCut2ty7XJPhyfIn@nongnu.org
X-Gm-Message-State: AOJu0YyuXe8wm37Nq6moU2bUWUZXlqFADlZZpNNDhV9fkkLRLFlwJRbm
 Ypi09Jt3RAxB9DcrlBAunCGNVaT10NkmX36rfvIWGvITSs7J0xvu0qFmDGV6enRWGnGx+vWvGGC
 m30x7ZrtMeGgT7JPFKMlodUZbd3gcWyt64qhFYWXbcvpASb7mm8gvcV4+ZA==
X-Gm-Gg: AeBDietNYUoukwjYu0hoh68XMuyPLpaGuS0oS3zjXqtX6dYxEDsKI6O1K2wIXpexapD
 fyfxohTgCUcEXC7AMPhHCNrRKxd8V0XVIInQtW4klzO04+dwUitFXfd5B8I+BPEpdMdb+gko4xg
 pjYu0q9M9gY6i3bauRgwK9NnziZyvCqQq1RCqLIJyqG+ji8owAAZ78N/t1XfwrNIhxwC8pXhw+I
 98Qfs/0NB0PTIZFpkgwJh5uflq/7FVkz8jFI00z78Z2+fQTaCuTSmQWZl/URvlN621nC+ADkKum
 Fwoi+YqN056nNY3nijZq6htv5+QSpQlcd3GjYV4iXXT1fdGInIE95mk49HQ6FJZIGzsP/7THNbj
 xS1UY1K5NWWireHu8WTdJ1hOuIyV6qOLRaCe+fV4+QC9Va0v8jaivLqeCAxLOYLlJrk6YCg==
X-Received: by 2002:a05:620a:4624:b0:8ef:3312:a150 with SMTP id
 af79cd13be357-904d4a61a03mr1145679785a.17.1778152445888; 
 Thu, 07 May 2026 04:14:05 -0700 (PDT)
X-Received: by 2002:a05:620a:4624:b0:8ef:3312:a150 with SMTP id
 af79cd13be357-904d4a61a03mr1145671885a.17.1778152445221; 
 Thu, 07 May 2026 04:14:05 -0700 (PDT)
Received: from [192.168.68.106] ([191.202.237.136])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8fc2938d20fsm1923490885a.1.2026.05.07.04.14.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 May 2026 04:14:04 -0700 (PDT)
Message-ID: <90009760-e20d-485f-b2e1-d33f73b9d887@oss.qualcomm.com>
Date: Thu, 7 May 2026 08:14:00 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/6] target/riscv: Implement core SMMPT lookup logic
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, chao.liu.zevorn@gmail.com, palmer@dabbelt.com,
 alistair23@gmail.com, liwei1518@gmail.com,
 Huang Tao <eric.huang@linux.alibaba.com>,
 TANG Tiancheng <lyndra@linux.alibaba.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20260408140635.42546-1-zhiwei_liu@linux.alibaba.com>
 <20260408140635.42546-3-zhiwei_liu@linux.alibaba.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260408140635.42546-3-zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: a16cPB2E0NRS8d_cBP7QpQxpX1tWRUZH
X-Proofpoint-ORIG-GUID: a16cPB2E0NRS8d_cBP7QpQxpX1tWRUZH
X-Authority-Analysis: v=2.4 cv=P9gKQCAu c=1 sm=1 tr=0 ts=69fc73ff cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=IZaa5BNpKBTNMhuJoHisKw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=SRrdq9N9AAAA:8 a=bDdBU3oEAAAA:8 a=-35DOFFSn7V3pmNHYCwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=DN7SgORnOiO7RqxRx1GC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDExMSBTYWx0ZWRfX6MS339mm+xTE
 MHb5tFNVSPmggkoAIvPQzCz55qSjSCune6GJ7UEeSwlBjPDupBIIh5abO4YkbHcYP2yJlRbBgUx
 dQvIHrzx68svLk9QdMB47Twj9Blwk9iGB0FB50/mHne8Dx3aEar5dwRTarGfmOeKtNn5l+kAUoM
 XguZZZk81+EeXqFZ3k2h4AixmR5Yfd924IHIfqL94oMv2mafL+ROfJu7v1ZsI+G8rYoI23v2mAD
 m+IvMN0WWESdqJu7oC4WZCQEJNm6YGyUSk/uHorLPeRPvxkM6ckpR08PHWMAnWE/V6rrSdkh3T4
 X+pN7UYx3BAif9RKEmWxYJSQWubGVX7sDH5sldwgPcf6b1BQysLPf4vbUDZkBWkLjNuQDb1i9Jn
 G/zgk6PHdIvdG+U3obDJn/q9GKO1l+ZunoihNWIDPsJzmP2yEjo0Q/O8+DEZr+U1+oOcocXfiVy
 TUWpfK37Tu3XKzpmzpA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 spamscore=0 impostorscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605070111
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Zhiwei,

On 4/8/2026 11:06 AM, LIU Zhiwei wrote:
> This patch introduces the core implementation for the Memory Protection Table
> (MPT) walk, which is the central mechanism of the SMMPT extension.
> 
> A new file, `riscv_smmpt.c`, is added to encapsulate the MPT logic. It
> implements the `smmpt_lookup()` function, which performs a multi-level
> page table-like walk starting from the physical address specified in the
> `mptppn` CSR field. This walk determines the access permissions (read,
> write, execute) for a given physical address.
> 
> The implementation supports various SMMPT modes (SMMPT34, SMMPT43, etc.) and
> correctly handles leaf and non-leaf entries, including reserved bit
> checks. Helper functions for parsing MPT entries and converting access
> permissions are also included in the new `riscv_smmpt.h` header.
> 
> Co-authored-by: Huang Tao <eric.huang@linux.alibaba.com>
> Co-authored-by: TANG Tiancheng <lyndra@linux.alibaba.com>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>   target/riscv/cpu_helper.c  |   5 +-
>   target/riscv/meson.build   |   1 +
>   target/riscv/pmp.h         |   3 +
>   target/riscv/riscv_smmpt.c | 274 +++++++++++++++++++++++++++++++++++++
>   target/riscv/riscv_smmpt.h |  15 ++
>   5 files changed, 295 insertions(+), 3 deletions(-)
>   create mode 100644 target/riscv/riscv_smmpt.c
> 
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index dd6c861a90..e3361fadae 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -1089,9 +1089,8 @@ void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv, bool virt_en)
>    * @access_type: The type of MMU access
>    * @mode: Indicates current privilege level.
>    */
> -static int get_physical_address_pmp(CPURISCVState *env, int *prot, hwaddr addr,
> -                                    int size, MMUAccessType access_type,
> -                                    int mode)
> +int get_physical_address_pmp(CPURISCVState *env, int *prot, hwaddr addr,
> +                             int size, MMUAccessType access_type, int mode)
>   {
>       pmp_priv_t pmp_priv;
>       bool pmp_has_privs;
> diff --git a/target/riscv/meson.build b/target/riscv/meson.build
> index 3842c7c1a8..bd1c2e8fad 100644
> --- a/target/riscv/meson.build
> +++ b/target/riscv/meson.build
> @@ -34,6 +34,7 @@ riscv_system_ss = ss.source_set()
>   riscv_system_ss.add(files(
>     'arch_dump.c',
>     'pmp.c',
> +  'riscv_smmpt.c',
>     'debug.c',
>     'monitor.c',
>     'machine.c',
> diff --git a/target/riscv/pmp.h b/target/riscv/pmp.h
> index 467fb6b4b1..1ed574227c 100644
> --- a/target/riscv/pmp.h
> +++ b/target/riscv/pmp.h
> @@ -86,6 +86,9 @@ void pmp_update_rule_nums(CPURISCVState *env);
>   uint32_t pmp_get_num_rules(CPURISCVState *env);
>   int pmp_priv_to_page_prot(pmp_priv_t pmp_priv);
>   void pmp_unlock_entries(CPURISCVState *env);
> +int get_physical_address_pmp(CPURISCVState *env, int *prot, hwaddr addr,
> +                             int size, MMUAccessType access_type,
> +                             int mode);
>   
>   #define MSECCFG_MML_ISSET(env) get_field(env->mseccfg, MSECCFG_MML)
>   #define MSECCFG_MMWP_ISSET(env) get_field(env->mseccfg, MSECCFG_MMWP)
> diff --git a/target/riscv/riscv_smmpt.c b/target/riscv/riscv_smmpt.c
> new file mode 100644
> index 0000000000..b7b47c5ae1
> --- /dev/null
> +++ b/target/riscv/riscv_smmpt.c
> @@ -0,0 +1,274 @@
> +/*
> + * QEMU RISC-V Smmpt (Memory Protection Table)
> + *
> + * Copyright (c) 2024 Alibaba Group. All rights reserved.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "riscv_smmpt.h"
> +#include "pmp.h"
> +#include "system/memory.h"
> +
> +typedef uint64_t load_entry_fn(AddressSpace *, hwaddr,
> +                               MemTxAttrs, MemTxResult *);
> +
> +static uint64_t load_entry_32(AddressSpace *as, hwaddr addr,
> +                              MemTxAttrs attrs, MemTxResult *result)
> +{
> +    return address_space_ldl(as, addr, attrs, result);
> +}
> +
> +static uint64_t load_entry_64(AddressSpace *as, hwaddr addr,
> +                              MemTxAttrs attrs, MemTxResult *result)
> +{
> +    return address_space_ldq(as, addr, attrs, result);
> +}
> +

So it seems like we have upstream changes that impacted this code.

(Phil, feel free to chime in).

When building this series I face this error:


FAILED: libqemu-riscv64-softmmu.a.p/target_riscv_riscv_smmpt.c.o
cc -Ilibqemu-riscv64-softmmu.a.p -I. -I.. -Itarget/riscv -I../target/riscv -Isubprojects/libvduse -I../subprojects/libvduse -Iqapi -Itrace -Iui -Iui/shader -I/usr/include/pixman-1 -I/usr/include/glib-2.0 -I/usr/lib/aarch64-linux-gnu/glib-2.0/include -I/usr/include/libmount -I/usr/include/blkid -I/usr/include/gio-unix-2.0 -I/usr/include/slirp -fdiagnostics-color=auto -Wall -Winvalid-pch -Werror -std=gnu11 -O0 -g -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -fno-strict-aliasing 
-fno-common -fwrapv -ftrivial-auto-var-init=zero -fzero-call-used-regs=used-gpr -fstack-protector-strong -Wempty-body -Wendif-labels -Wexpansion-to-defined -Wformat-overflow=2 -Wformat-security -Wformat-y2k -Wignored-qualifiers -Wimplicit-fallthrough=2 -Winit-self -Wmissing-format-attribute -Wmissing-prototypes -Wnested-externs -Wold-style-declaration -Wold-style-definition -Wredundant-decls -Wshadow=local -Wstrict-prototypes -Wtype-limits -Wundef -Wvla -Wwrite-strings -Wno-missing-include-dirs 
-Wno-psabi -Wno-shift-negative-value -isystem /home/dbarboza/work/qemu/linux-headers -isystem linux-headers -iquote . -iquote /home/dbarboza/work/qemu -iquote /home/dbarboza/work/qemu/include -iquote /home/dbarboza/work/qemu/host/include/aarch64 -iquote /home/dbarboza/work/qemu/host/include/generic -iquote /home/dbarboza/work/qemu/tcg/aarch64 -pthread -fPIE -D_DEFAULT_SOURCE -D_XOPEN_SOURCE=600 -DNCURSES_WIDECHAR=1 -isystem../linux-headers -isystemlinux-headers -DCOMPILING_PER_TARGET 
'-DCONFIG_TARGET="riscv64-softmmu-config-target.h"' '-DCONFIG_DEVICES="riscv64-softmmu-config-devices.h"' -MD -MQ libqemu-riscv64-softmmu.a.p/target_riscv_riscv_smmpt.c.o -MF libqemu-riscv64-softmmu.a.p/target_riscv_riscv_smmpt.c.o.d -o libqemu-riscv64-softmmu.a.p/target_riscv_riscv_smmpt.c.o -c ../target/riscv/riscv_smmpt.c
../target/riscv/riscv_smmpt.c: In function ‘load_entry_32’:
../target/riscv/riscv_smmpt.c:20:12: error: implicit declaration of function ‘address_space_ldl’; did you mean ‘address_space_ldub’? [-Werror=implicit-function-declaration]
    20 |     return address_space_ldl(as, addr, attrs, result);
       |            ^~~~~~~~~~~~~~~~~
       |            address_space_ldub
../target/riscv/riscv_smmpt.c:20:12: error: nested extern declaration of ‘address_space_ldl’ [-Werror=nested-externs]
../target/riscv/riscv_smmpt.c: In function ‘load_entry_64’:
../target/riscv/riscv_smmpt.c:26:12: error: implicit declaration of function ‘address_space_ldq’; did you mean ‘address_space_ldub’? [-Werror=implicit-function-declaration]
    26 |     return address_space_ldq(as, addr, attrs, result);
       |            ^~~~~~~~~~~~~~~~~
       |            address_space_ldub
../target/riscv/riscv_smmpt.c:26:12: error: nested extern declaration of ‘address_space_ldq’ [-Werror=nested-externs]
cc1: all warnings being treated as errors
[1638/2623] Generating docs/QEMU manual with a custom command
ninja: build stopped: subcommand failed.


I'm not sure why that is since the (seemly) appropriate header system/memmory.h
is included.

With this change I can get it to build:


$ git diff
diff --git a/target/riscv/riscv_smmpt.c b/target/riscv/riscv_smmpt.c
index b7b47c5ae1..ddc8cd9932 100644
--- a/target/riscv/riscv_smmpt.c
+++ b/target/riscv/riscv_smmpt.c
@@ -17,13 +17,13 @@ typedef uint64_t load_entry_fn(AddressSpace *, hwaddr,
  static uint64_t load_entry_32(AddressSpace *as, hwaddr addr,
                                MemTxAttrs attrs, MemTxResult *result)
  {
-    return address_space_ldl(as, addr, attrs, result);
+    return address_space_ldl_le(as, addr, attrs, result);
  }

  static uint64_t load_entry_64(AddressSpace *as, hwaddr addr,
                                MemTxAttrs attrs, MemTxResult *result)
  {
-    return address_space_ldq(as, addr, attrs, result);
+    return address_space_ldq_le(as, addr, attrs, result);
  }

  typedef union {



I ***think*** this is a fair change since we're reading/writing memory using
the same endianess, and our memory operations are usually LE, e.g. in
get_physical_address:


         if (riscv_cpu_mxl(env) == MXL_RV32) {
             pte = address_space_ldl_le(cs->as, pte_addr, attrs, &res);
         } else {
             pte = address_space_ldq_le(cs->as, pte_addr, attrs, &res);
         }


I'll defer to you what we should do here.  Thanks,

Daniel

> +typedef union {
> +    uint64_t raw;
> +    struct {
> +        uint32_t v:1;
> +        uint32_t l:1;
> +        uint32_t rsv1:5;
> +        uint32_t perms:24;
> +        uint32_t n:1;
> +    } leaf32;
> +    struct {
> +        uint32_t v:1;
> +        uint32_t l:1;
> +        uint32_t rsv1:8;
> +        uint32_t ppn:22;
> +    } nonleaf32;
> +    struct {
> +        uint64_t v:1;
> +        uint64_t l:1;
> +        uint64_t rsv1:8;
> +        uint64_t perms:48;
> +        uint64_t rsv2:5;
> +        uint64_t n:1;
> +    } leaf64;
> +    struct {
> +        uint64_t v:1;
> +        uint64_t l:1;
> +        uint64_t rsv1:8;
> +        uint64_t ppn:52;
> +        uint64_t rsv2:1;
> +        uint64_t n:1;
> +    } nonleaf64;
> +} mpte_union_t;
> +
> +static inline bool mpte_is_leaf(uint64_t mpte)
> +{
> +   return mpte & 0x2;
> +}
> +
> +static inline bool mpte_is_valid(uint64_t mpte)
> +{
> +    return mpte & 0x1;
> +}
> +
> +static uint64_t mpte_get_rsv(CPURISCVState *env, uint64_t mpte)
> +{
> +    RISCVMXL mxl = riscv_cpu_mxl(env);
> +    bool leaf = mpte_is_leaf(mpte);
> +    mpte_union_t *u = (mpte_union_t *)&mpte;
> +
> +    if (mxl == MXL_RV32) {
> +        return leaf ? u->leaf32.rsv1 : u->nonleaf32.rsv1;
> +    }
> +    return leaf ? (u->leaf64.rsv1 << 5) | u->leaf64.rsv2
> +                : (u->nonleaf64.rsv1 << 1) | u->nonleaf64.rsv2;
> +}
> +
> +static uint64_t mpte_get_perms(CPURISCVState *env, uint64_t mpte)
> +{
> +    RISCVMXL mxl = riscv_cpu_mxl(env);
> +    mpte_union_t *u = (mpte_union_t *)&mpte;
> +
> +    return (mxl == MXL_RV32) ? u->leaf32.perms : u->leaf64.perms;
> +}
> +
> +static bool mpte_check_nlnapot(CPURISCVState *env, uint64_t mpte, bool *nlnapot)
> +{
> +    RISCVMXL mxl = riscv_cpu_mxl(env);
> +    mpte_union_t *u = (mpte_union_t *)&mpte;
> +    if (mxl == MXL_RV32) {
> +        *nlnapot = false;
> +        return true;
> +    }
> +    *nlnapot = u->nonleaf64.n;
> +    return u->nonleaf64.n ? (u->nonleaf64.ppn & 0x1ff) == 0x100 : true;
> +}
> +
> +static uint64_t mpte_get_ppn(CPURISCVState *env, uint64_t mpte, int pn,
> +                             bool nlnapot)
> +{
> +    RISCVMXL mxl = riscv_cpu_mxl(env);
> +    mpte_union_t *u = (mpte_union_t *)&mpte;
> +
> +    if (nlnapot) {
> +        return deposit64(u->nonleaf64.ppn, 0, 9, pn & 0x1ff);
> +    }
> +    return (mxl == MXL_RV32) ? u->nonleaf32.ppn : u->nonleaf64.ppn;
> +}
> +
> +/* Caller should assert i before call this interface */
> +static int mpt_get_pn(hwaddr addr, int i, mpt_mode_t mode)
> +{
> +    if (mode == SMMPT34) {
> +        return i == 0
> +            ? extract64(addr, 15, 10)
> +            : extract64(addr, 25, 9);
> +    } else {
> +        int offset = 16 + i * 9;
> +        if ((mode == SMMPT64) && (i == 4)) {
> +            return extract64(addr, offset, 12);
> +        } else {
> +            return extract64(addr, offset, 9);
> +        }
> +    }
> +}
> +
> +/* Caller should assert i before call this interface */
> +static int mpt_get_pi(hwaddr addr, int i, mpt_mode_t mode)
> +{
> +    if (mode == SMMPT34) {
> +        return i == 0
> +            ? extract64(addr, 12, 3)
> +            : extract64(addr, 22, 3);
> +    } else {
> +        int offset = 16 + i * 9;
> +        return extract64(addr, offset - 4, 4);
> +    }
> +}
> +
> +static bool smmpt_lookup(CPURISCVState *env, hwaddr addr, mpt_mode_t mode,
> +                         mpt_access_t *allowed_access,
> +                         MMUAccessType access_type)
> +{
> +    MemTxResult res;
> +    MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
> +    CPUState *cs = env_cpu(env);
> +    hwaddr mpte_addr, base = (hwaddr)env->mptppn << PGSHIFT;
> +    load_entry_fn *load_entry;
> +    uint32_t mptesize, levels, xwr;
> +    int pn, pi, pmp_prot, pmp_ret;
> +    uint64_t mpte, perms;
> +
> +    switch (mode) {
> +    case SMMPT34:
> +        load_entry = &load_entry_32; levels = 2; mptesize = 4; break;
> +    case SMMPT43:
> +        load_entry = &load_entry_64; levels = 3; mptesize = 8; break;
> +        break;
> +    case SMMPT52:
> +        load_entry = &load_entry_64; levels = 4; mptesize = 8; break;
> +    case SMMPT64:
> +        load_entry = &load_entry_64; levels = 5; mptesize = 8; break;
> +    case SMMPTBARE:
> +        *allowed_access = ACCESS_ALLOW_RWX;
> +        return true;
> +    default:
> +        g_assert_not_reached();
> +        break;
> +    }
> +    for (int i = levels - 1; i >= 0 ; i--) {
> +        /* 1. Get pn[i] as the mpt index */
> +        pn = mpt_get_pn(addr, i, mode);
> +        /* 2. Get mpte address and get mpte */
> +        mpte_addr = base + pn * mptesize;
> +        pmp_ret = get_physical_address_pmp(env, &pmp_prot, mpte_addr,
> +                                           mptesize, MMU_DATA_LOAD, PRV_M);
> +        if (pmp_ret != TRANSLATE_SUCCESS) {
> +            return false;
> +        }
> +        mpte = load_entry(cs->as, mpte_addr, attrs, &res);
> +        /* 3. Check valid bit and reserve bits of mpte */
> +        if (!mpte_is_valid(mpte) || mpte_get_rsv(env, mpte)) {
> +            return false;
> +        }
> +
> +        /* 4. Process non-leaf node */
> +        if (!mpte_is_leaf(mpte)) {
> +            bool nlnapot = false;
> +            if (i == 0) {
> +                return false;
> +            }
> +            if (!mpte_check_nlnapot(env, mpte, &nlnapot)) {
> +                return false;
> +            }
> +            base = mpte_get_ppn(env, mpte, pn, nlnapot) << PGSHIFT;
> +            continue;
> +        }
> +
> +        /* 5. Process leaf node */
> +        pi = mpt_get_pi(addr, i, mode);
> +        perms = mpte_get_perms(env, mpte);
> +        xwr = (perms >> (pi * 3)) & 0x7;
> +        switch (xwr) {
> +        case ACCESS_ALLOW_R:
> +            *allowed_access = ACCESS_ALLOW_R;
> +            return access_type == MMU_DATA_LOAD;
> +        case ACCESS_ALLOW_X:
> +            *allowed_access = ACCESS_ALLOW_X;
> +            return access_type == MMU_INST_FETCH;
> +        case ACCESS_ALLOW_RX:
> +            *allowed_access = ACCESS_ALLOW_R;
> +            return (access_type == MMU_DATA_LOAD ||
> +                    access_type == MMU_INST_FETCH);
> +        case ACCESS_ALLOW_RW:
> +            *allowed_access = ACCESS_ALLOW_RW;
> +            return (access_type == MMU_DATA_LOAD ||
> +                    access_type == MMU_DATA_STORE);
> +        case ACCESS_ALLOW_RWX:
> +            *allowed_access = ACCESS_ALLOW_RWX;
> +            return true;
> +        default:
> +            return false;
> +        }
> +    }
> +    return false;
> +}
> +
> +bool smmpt_check_access(CPURISCVState *env, hwaddr addr,
> +                        mpt_access_t *allowed_access, MMUAccessType access_type)
> +{
> +    bool mpt_has_access;
> +    mpt_mode_t mode = env->mptmode;
> +
> +    mpt_has_access = smmpt_lookup(env, addr, mode,
> +                                  allowed_access, access_type);
> +    return mpt_has_access;
> +}
> +
> +/*
> + * Convert MPT access to TLB page privilege.
> + */
> +int smmpt_access_to_page_prot(mpt_access_t mpt_access)
> +{
> +    int prot;
> +    switch (mpt_access) {
> +    case ACCESS_ALLOW_R:
> +        prot = PAGE_READ;
> +        break;
> +    case ACCESS_ALLOW_X:
> +        prot = PAGE_EXEC;
> +        break;
> +    case ACCESS_ALLOW_RX:
> +        prot = PAGE_READ | PAGE_EXEC;
> +        break;
> +    case ACCESS_ALLOW_RW:
> +        prot = PAGE_READ | PAGE_WRITE;
> +        break;
> +    case ACCESS_ALLOW_RWX:
> +        prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
> +        break;
> +    default:
> +        prot = 0;
> +        break;
> +    }
> +
> +    return prot;
> +}
> diff --git a/target/riscv/riscv_smmpt.h b/target/riscv/riscv_smmpt.h
> index 74dcccf4be..0d0597f8eb 100644
> --- a/target/riscv/riscv_smmpt.h
> +++ b/target/riscv/riscv_smmpt.h
> @@ -9,6 +9,9 @@
>   #ifndef RISCV_SMMPT_H
>   #define RISCV_SMMPT_H
>   
> +#include "cpu.h"
> +#include "exec/mmu-access-type.h"
> +
>   typedef enum {
>       SMMPTBARE = 0,
>       SMMPT34   = 1,
> @@ -18,4 +21,16 @@ typedef enum {
>       SMMPTMAX
>   } mpt_mode_t;
>   
> +typedef enum {
> +    ACCESS_ALLOW_R = 0b001,
> +    ACCESS_ALLOW_X = 0b100,
> +    ACCESS_ALLOW_RX = 0b101 ,
> +    ACCESS_ALLOW_RW = 0b011,
> +    ACCESS_ALLOW_RWX = 0b111,
> +} mpt_access_t;
> +
> +int smmpt_access_to_page_prot(mpt_access_t mpt_access);
> +bool smmpt_check_access(CPURISCVState *env, hwaddr addr,
> +                        mpt_access_t *allowed_access,
> +                        MMUAccessType access_type);
>   #endif


