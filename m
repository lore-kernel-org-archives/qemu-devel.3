Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B605ECA6002
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 20:27:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEYEH-0001TP-Fl; Wed, 07 Oct 2026 16:27:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEYEE-0001Sf-5O
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 16:27:07 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEYEB-0003RB-SM
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 16:27:05 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 697JNrAm532653
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 20:27:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 h59Ts/p/wMMqbb0DmVBe23sg47yJvcAXxGAB99IKbXc=; b=OV6sDZ12q6p2b39x
 7Ku/qz/wdxwHHws1sbx2x12TZ9lin+IEXHXs2HAamXDHCIYnDAwjME+/v7Pli5mL
 aOtUVb9uSKsG1Mm5+ik/hyEvcLpHpbytbYzhIK/V33wtghYjPxwptnGKSQX22Vad
 0SEwutxXSJR32HUb3rPoeV2R9yRt1yZ8yhj0rNy1QEVgA+ll8Z9l28Px+7RiiKIy
 JynCbNhzV1ZE/CkIdPICFHWzQD/iCLw/q2wtZB8SKdxWYPkKJRFXdTkgRYwAG5J2
 S8b4ElbRq3j+uE6LIxWNxEOThtqGrSQ91ppehbGp6XMVTCgbRV3Lg+M1Ia7VYfnb
 XGrR/A==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5mgraara-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 20:27:02 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30f1b904861so5777868eec.0
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 13:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791404821; x=1792009621; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=h59Ts/p/wMMqbb0DmVBe23sg47yJvcAXxGAB99IKbXc=;
 b=QxsUUavTX3HNFQcg0b5tcXcmel9UVf+zt/ggz9agY4nLpDm+Q1Ypvwf6X0oN9HCGyf
 cTHjE6xnN9RwIVDuKcGlcoHBZY/zc2t8NZqSZGwpaFLyUNtr8WkTikz2BHWHfNig7by8
 zew8/hdB+3OUOv7mB6os3MnOj+PFsFOGGEsfXssVORQO8YrflZ/Twu0xlqzfBzCVZ7Rk
 4nM6//E8WcsaifPvlNqvNZpzZtwWMPIjQ6oUgN+ldFd6iyjVFOC2Am/v8KL9Ppjphvl4
 ftjAIZotQceFIGd/gR3otN82My3Z7xFUNgc4AlaRBbA/nsF8UCliheH4gujrvDgBsnzv
 g7qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791404821; x=1792009621;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=h59Ts/p/wMMqbb0DmVBe23sg47yJvcAXxGAB99IKbXc=;
 b=lIFs0kPtOkA/JRrediZ0Q5M01gMBb5mnIGunUX/mKzScGnuXbtDxk3U36FFfLQvcH8
 DMDljZGCrhSiCAEWfoYEjarw8lpFKAjn8Pave1iUS7hjI8DtTkq758QzbSWeKKLy3A/V
 PxHcqh8blvbzyPpEZUI1VW3EgFiJhR08gKfi1CVPtUKYc+9A+onq82BOHdxW4LB7jbOx
 +GS3jS61fw+MJDOvcEN6noxcltCKsGyi4OeLIq2KA3SOMAEqdrjJ7TGVTQ/jHl0/xtHt
 MPccyw4ntAzTfxWqbPrRVf6yYTw4UrOUq+HS2/UJvWh3v5Q86K3OYJ5PTUObGkBHh1I7
 kXvg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx0hxCM0eth+upExlGSE1uxnJTVBQv+WO2/FCRdVBM/kEIuW4yaq5jf+Ge0oJqVaY80z7TYiwkj2rXJ@nongnu.org
X-Gm-Message-State: AFq9FYKkzKYkdhyMXEeuTFS+q/6tp98cd6mO35DYRCxhx6OjsKXRTSdb
 VN1vU81sKY1QHfmnTZ1xUMvaqJ06JEiXgUu/rrRZhwnOJktOrenTofFBJIGnA66opH1OGqkI0YJ
 lDA4SXCj5ddbmlXQppLx2/H7zDdjt/EqxA/0M3GPvtiai43qsBJTkS5eqBg==
X-Gm-Gg: AYBFou1E5Tl14xQCTkL3b3UCGtq76OGmuKYpO8Xq+z75B4A+TLsjMvDs4bFeAP7u2sG
 9+Ue/5wPY8GbjWZAuXBAHwpFVveQnP/ubrLtsW9IF1K59hLs8u+hlYGFYKGXYQVLnjg2TsbyKTw
 GDivZk8F77J/cu8NOJitqCY/h+2G2XxKFbhAXVa9/hcxj9I1swxXDAn36XoiTUT93JMZb9Pwkd7
 Mrbo672Y8t4kmnhL1GZF6EC4ny0x7lgZdaz1KCBED8gL9c+Ja7yMYug3QyV3W55GCEfdlEqR1aP
 Wtj5mKyZCq3Ijzla0tRIt06b2t499uSW34IAYgmpYkFRQ3ArvZ/0pUUy/DDkPxqLYpJdf+C4C3U
 oCdRNNJK1JBht6+lzWC+fe+Q/qCzhzkZA4V3ZqSrxsNrqSdtZKNY/TvT3M13bpXgoOyU5Pg==
X-Received: by 2002:a05:7301:4882:b0:34b:f279:2c29 with SMTP id
 5a478bee46e88-3515dd058eemr3997377eec.13.1791404821289; 
 Wed, 07 Oct 2026 13:27:01 -0700 (PDT)
X-Received: by 2002:a05:7301:4882:b0:34b:f279:2c29 with SMTP id
 5a478bee46e88-3515dd058eemr3997294eec.13.1791404820210; 
 Wed, 07 Oct 2026 13:27:00 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-351735e316fsm1936806eec.11.2026.10.07.13.26.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2026 13:26:59 -0700 (PDT)
Message-ID: <15ffddbe-c5ef-420a-9eef-3ef96e385d81@oss.qualcomm.com>
Date: Wed, 7 Oct 2026 13:26:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] configs/targets: remove target info definitions
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Laurent Vivier <lvivier@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 John Snow <jsnow@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Joel Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Stafford Horne <shorne@gmail.com>, qemu-arm@nongnu.org,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Steven Lee <steven_lee@aspeedtech.com>,
 Alexander Bulekov <alxndr@bu.edu>, Darren Kenny <darren.kenny@oracle.com>
References: <20261007115253.328-1-luoyonggang@gmail.com>
 <20261007115253.328-2-luoyonggang@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261007115253.328-2-luoyonggang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA4MSBTYWx0ZWRfX8vfLOf72Zka4
 N8WDwqjaXRQ6UXhx+ifFPli6cs9lDLVmVFJ84WUctust5c0frKib6wx4sLcfG7xZfszJL6ItJXa
 6fZ9KrLD4C5m6yLhpihRlb1Fi1Gtn3iUtrbg0awrX1A9xhdlH6qAo+ZW1VC8/OHRm23Pobywr+n
 BmX42NHjlQnNy0U0JM1+3au+R8V8vTmZ3IX5dIdrRSl636+jJfEzYXGmExiRinI2DtuxUeImYva
 BwdBKFZG7pLTI8hESSbxuikFdkvsdy1MR7Lp6c61qatjP6mT1QquQ+uD3DJD7kFN9St5kozGBrf
 tsfrznDC8M5y6zzQms6G7tcmn19f0vZ6Jdw+MJeHHd7ToIzKUYlAFmnsoQE6GbHebtwYMNsezUL
 LWu1hL1i7nwgZU7r/zJsnkQyTqN8zmH8znn0FOR83lRAkX9CRHOq4Ap2/TzqmmU27RuV42CIhbI
 QIsdZho3ynDcccwm0SQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA4MSBTYWx0ZWRfX/rRLbSAz+r/h
 /Lk7DPOtRkvYV3dna98QUis4l0qc1EzQlrl1slR4BYN1YhIVb3fUXi+syG6hzpjwyo0n1smN8sI
 O8xwb2DSOScmP9cO9EmnW+mrA/J1QIg=
X-Proofpoint-ORIG-GUID: -0P-PikQoG2SZ5T9dp1XpfAyo16DYz7O
X-Proofpoint-GUID: -0P-PikQoG2SZ5T9dp1XpfAyo16DYz7O
X-Authority-Analysis: v=2.4 cv=OYkNnRTY c=1 sm=1 tr=0 ts=6ac6ab16 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=Hw4NnLk0O3TVtCU2cgYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_06,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070081
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 10/7/2026 4:47 AM, Yonggang Luo wrote:
> From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> 
> Now that we remove machine_typename, we don't need to keep duplicated
> file per target anymore. So we can just rely on target-info-stub.c.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  MAINTAINERS                       |  1 -
>  configs/targets/aarch64-softmmu.c | 25 -------------------------
>  configs/targets/arm-softmmu.c     | 25 -------------------------
>  configs/targets/meson.build       |  6 ------
>  configs/targets/riscv32-softmmu.c | 24 ------------------------
>  configs/targets/riscv64-softmmu.c | 24 ------------------------
>  meson.build                       |  7 +------
>  7 files changed, 1 insertion(+), 111 deletions(-)
>  delete mode 100644 configs/targets/aarch64-softmmu.c
>  delete mode 100644 configs/targets/arm-softmmu.c
>  delete mode 100644 configs/targets/meson.build
>  delete mode 100644 configs/targets/riscv32-softmmu.c
>  delete mode 100644 configs/targets/riscv64-softmmu.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1312bbd1bd8..cfe39dc2883 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2148,7 +2148,6 @@ M: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>  S: Supported
>  F: include/qemu/target-info*.h
>  F: target-info*.c
> -F: configs/targets/*.c
>  F: tests/unit/test-multi-targets.c
>  
>  Xtensa Machines
> diff --git a/configs/targets/aarch64-softmmu.c b/configs/targets/aarch64-softmmu.c
> deleted file mode 100644
> index fdebdcc3582..00000000000
> --- a/configs/targets/aarch64-softmmu.c
> +++ /dev/null
> @@ -1,25 +0,0 @@
> -/*
> - * QEMU binary/target API (qemu-system-aarch64)
> - *
> - *  Copyright (c) Linaro
> - *
> - * SPDX-License-Identifier: GPL-2.0-or-later
> - */
> -
> -#include "qemu/osdep.h"
> -#include "qemu/target-info-impl.h"
> -#include "qemu/target-info-init.h"
> -#include "target/arm/cpu-qom.h"
> -#include "target/arm/cpu-param.h"
> -
> -static const TargetInfo target_info_aarch64_system = {
> -    .target_name = "aarch64",
> -    .target_arch = SYS_EMU_TARGET_AARCH64,
> -    .long_bits = 64,
> -    .cpu_type = TYPE_ARM_CPU,
> -    .endianness = ENDIAN_MODE_LITTLE,
> -    .page_bits_vary = true,
> -    .page_bits_init = TARGET_PAGE_BITS_LEGACY,
> -};
> -
> -target_info_init(target_info_aarch64_system)
> diff --git a/configs/targets/arm-softmmu.c b/configs/targets/arm-softmmu.c
> deleted file mode 100644
> index 2b98f65a0f8..00000000000
> --- a/configs/targets/arm-softmmu.c
> +++ /dev/null
> @@ -1,25 +0,0 @@
> -/*
> - * QEMU binary/target API (qemu-system-arm)
> - *
> - *  Copyright (c) Linaro
> - *
> - * SPDX-License-Identifier: GPL-2.0-or-later
> - */
> -
> -#include "qemu/osdep.h"
> -#include "qemu/target-info-impl.h"
> -#include "qemu/target-info-init.h"
> -#include "target/arm/cpu-qom.h"
> -#include "target/arm/cpu-param.h"
> -
> -static const TargetInfo target_info_arm_system = {
> -    .target_name = "arm",
> -    .target_arch = SYS_EMU_TARGET_ARM,
> -    .long_bits = 32,
> -    .cpu_type = TYPE_ARM_CPU,
> -    .endianness = ENDIAN_MODE_LITTLE,
> -    .page_bits_vary = true,
> -    .page_bits_init = TARGET_PAGE_BITS_LEGACY,
> -};
> -
> -target_info_init(target_info_arm_system)
> diff --git a/configs/targets/meson.build b/configs/targets/meson.build
> deleted file mode 100644
> index 2ab4d27eaf5..00000000000
> --- a/configs/targets/meson.build
> +++ /dev/null
> @@ -1,6 +0,0 @@
> -foreach target : [
> -      'arm-softmmu', 'aarch64-softmmu',
> -      'riscv32-softmmu', 'riscv64-softmmu'
> -  ]
> -  config_target_info += {target : files(target + '.c')}
> -endforeach
> diff --git a/configs/targets/riscv32-softmmu.c b/configs/targets/riscv32-softmmu.c
> deleted file mode 100644
> index 0829ab84de5..00000000000
> --- a/configs/targets/riscv32-softmmu.c
> +++ /dev/null
> @@ -1,24 +0,0 @@
> -/*
> - * QEMU binary/target API (qemu-system-riscv32)
> - *
> - *  Copyright (c) rev.ng Labs Srl.
> - *
> - * SPDX-License-Identifier: GPL-2.0-or-later
> - */
> -
> -#include "qemu/osdep.h"
> -#include "qemu/target-info-impl.h"
> -#include "qemu/target-info-init.h"
> -#include "target/riscv/cpu-qom.h"
> -#include "target/riscv/cpu-param.h"
> -
> -static const TargetInfo target_info_riscv32_system = {
> -    .target_name = "riscv32",
> -    .target_arch = SYS_EMU_TARGET_RISCV32,
> -    .long_bits = 32,
> -    .cpu_type = TYPE_RISCV_CPU,
> -    .endianness = ENDIAN_MODE_LITTLE,
> -    .page_bits_init = TARGET_PAGE_BITS,
> -};
> -
> -target_info_init(target_info_riscv32_system)
> diff --git a/configs/targets/riscv64-softmmu.c b/configs/targets/riscv64-softmmu.c
> deleted file mode 100644
> index 553bd1f75fe..00000000000
> --- a/configs/targets/riscv64-softmmu.c
> +++ /dev/null
> @@ -1,24 +0,0 @@
> -/*
> - * QEMU binary/target API (qemu-system-riscv64)
> - *
> - *  Copyright (c) rev.ng Labs Srl.
> - *
> - * SPDX-License-Identifier: GPL-2.0-or-later
> - */
> -
> -#include "qemu/osdep.h"
> -#include "qemu/target-info-impl.h"
> -#include "qemu/target-info-init.h"
> -#include "target/riscv/cpu-qom.h"
> -#include "target/riscv/cpu-param.h"
> -
> -static const TargetInfo target_info_riscv64_system = {
> -    .target_name = "riscv64",
> -    .target_arch = SYS_EMU_TARGET_RISCV64,
> -    .long_bits = 64,
> -    .cpu_type = TYPE_RISCV_CPU,
> -    .endianness = ENDIAN_MODE_LITTLE,
> -    .page_bits_init = TARGET_PAGE_BITS,
> -};
> -
> -target_info_init(target_info_riscv64_system)
> diff --git a/meson.build b/meson.build
> index 828100de816..64d3f7675f7 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -3754,7 +3754,6 @@ subdir('dump')
>  subdir('accel')
>  
>  subdir('backends')
> -subdir('configs/targets')
>  subdir('disas')
>  subdir('migration')
>  subdir('monitor')
> @@ -4346,11 +4345,7 @@ foreach target : target_dirs
>      endif
>    endif
>  
> -  if target in config_target_info
> -    arch_srcs += config_target_info[target]
> -  else
> -    arch_srcs += files('target-info-stub.c')
> -  endif
> +  arch_srcs += files('target-info-stub.c')
>  
>    if target_base_arch in target_arch
>      t = target_arch[target_base_arch].apply(config_target, strict: false)

We delayed this patch because initially we thought we might need to add
other things in this struct (per target). However, it was not proven it
was needed, thus I'll pull this.

Thanks,
Pierrick

