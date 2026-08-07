Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C7EDC5AC7A
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 10:55:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsIDI-00053u-Ur; Fri, 07 Aug 2026 06:54:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wsIDH-00053j-Li
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 06:54:07 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wsIDE-0004oj-VO
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 06:54:07 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6777w85W3251819
 for <qemu-devel@nongnu.org>; Fri, 7 Aug 2026 10:54:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nOaWC0YKOfOnGJRq9se//vmM4GV+0lqUYRXcTBxuOVk=; b=btv2sFEveV16tOG/
 qgcldllMDOuigrxeUM5p5js1qMsbV9RFbmI2e/o/AN6K/TsLc1+BApfpl4FkyiUO
 50kDZvomCWcTueCzBCozIYVRhJeOvadaZIr/18Rp/8S8sjcY1rsAsgoHCrp4jVOw
 Kbk1kKMq/NF9ZPAFFxpYvDoMHsWBMjZvUbSGTz37+hWMzg4Dy+mp5SzbRl2F1bH9
 m5Q7SiDUNhBbb38pDwpv5HK45QzuGmb6kHXGAVVJtQ5t70w+Zl/CAj8YPQRL3r3H
 64HztcJJUXu5/FtBHsdtMy9Ioz+MfMn0yN58f9WKhZ2SklK6coeOJJKNNxENKlTD
 8ksPsA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvy6k3kft-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 10:54:02 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51a8db414c7so40333691cf.0
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 03:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786100042; x=1786704842; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=nOaWC0YKOfOnGJRq9se//vmM4GV+0lqUYRXcTBxuOVk=;
 b=gxdG6IEerk433BvSKQY0CCGvs85sAxx2L9N8nktYzzHsgSyjXmNIn3sjn/dsSjIzVM
 x6tR/8tuvWtrCRVQBiTvoTZmN412NrcTKN2IT8lbZ929cvbz/FyNW7hRmM6Ugy8pIRSQ
 sKanSEFct7hPeWEMGAu5f3JRH+QqRawWHwe/6rhd9hoKqf466LVw0K4qVt/PH3Y7lCfc
 cMfnj2taC6+YDWUEiJrz0niCpWQTG7xb+uQeBUmbVH5kZk5NKsjXWTEg8fUTptBdiGib
 CI8zSvCKOwueXPOjQ9Sz5GnRB7qXkopZzZBs+MoakO4iFOyhBS5T+UQTJi76DysByljL
 nE5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786100042; x=1786704842;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nOaWC0YKOfOnGJRq9se//vmM4GV+0lqUYRXcTBxuOVk=;
 b=ka84ZBLVBdrurk7OVpsfNL7H0Ij8iClEJj20BXxZ2aA4XAY0nke+QddxNJsfm4C8qc
 iCGF52YWa9kVAC7Sd1K4Qquh/lO9HcvU9pfr+/SDKhAPPnDoFp3mV9yWj+khSWIJT1sf
 wIkLQjrDrBW/oA73QJKM6SwwNXhvpTJzmArd9wA+leGIdj1mIHy1S4o8LBp/ldBktqEI
 mMNYMrtlkBZceNsPwIX5Sz8ZxU3cVdU/Mvy3SCE41d8r8mbl7qC+kU2+o01kNJ6jmvnp
 0m0efmJHcJSPvmeuqh0dLMAHjqYnCUQq6Khl7osdaOlr6k84XyfMmWipeLAq2aGbqQri
 xYpw==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro63XTwyrlXDFeQOkQeVkBkFSV2J9WHwlwLunRXLDDbU0JNw33kz6Vj3LXA0MNn7wYqfRiJNVRUYI+j@nongnu.org
X-Gm-Message-State: AOJu0Yw3AL0J6ZxS6/aMH5tgx+FlABN4fPO+MObOuXue9XrLV5EXRW50
 KJUWfykFd/y775tbdbCUs1Hj6VYIwbT9MAMGOuhcs3w6uBYacyY6OsrzmMivCFLUavPV1kNBVIA
 sGLuM3wTHBn4xxD7eADc+Uljd9AHmeFt2sl/oFTbWfzNP5pHNT+1k3ggBiw==
X-Gm-Gg: AR+sD13oX4ZP6xZONT86C5IAsZx3HRB02P21H2IbXuMRKCQsF408ZK7jkIfQOcpWxHW
 HHGxvxaaamhn8tnGcr8no+ejLYyUDzzRlWItYZ2GaAJWfQrc/fndZYHIJuw8RZfbEJsqJr5tmyx
 Z8Rbrcmn3uoG+CZJeGOjfaoOZOF1E8MtGAzbWx91V4NK/GO+XsfK4OBn5AW/fshMz0WAJGNBl7S
 A4bDG4azkG6PJ5i1aLilHTYseFfbTJuwVLvVmmuO74/1XDxZJFwSZJj/mmyzAECdJ9Xevrqp/Ag
 AaPAZs/+jh3WDUwzG6TXjDNYehtMtMy5fOkxpq+pwUclgECY/kL9nK3usjhytTCYjChQ9loyRDE
 yQ0JQhU8dHrpOeS0bjINJzr02I1fxSKZYVyLr
X-Received: by 2002:a05:622a:34c:b0:517:9570:c1bd with SMTP id
 d75a77b69052e-52ce612ecbbmr207802361cf.25.1786100041952; 
 Fri, 07 Aug 2026 03:54:01 -0700 (PDT)
X-Received: by 2002:a05:622a:34c:b0:517:9570:c1bd with SMTP id
 d75a77b69052e-52ce612ecbbmr207802091cf.25.1786100041464; 
 Fri, 07 Aug 2026 03:54:01 -0700 (PDT)
Received: from [192.168.68.104] ([187.11.154.152])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-908a92fe515sm6117036d6.24.2026.08.07.03.53.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Aug 2026 03:54:00 -0700 (PDT)
Message-ID: <b3df560d-7256-4ae4-850f-7986e3c68e4d@oss.qualcomm.com>
Date: Fri, 7 Aug 2026 07:53:56 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] hw/sd: add Kendryte K230 SDHCI controller
To: Xin Xie <xinxie908@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>
References: <20260729105904.272939-1-xinxie908@gmail.com>
 <20260729105904.272939-2-xinxie908@gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260729105904.272939-2-xinxie908@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=RpX16imK c=1 sm=1 tr=0 ts=6a75b94a cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=iMfxv9gflPUPBcmW7/Gq5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=sHK5QkyxqHE3Z37EADQA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: nry0q7SfbBY3UlUBllRJSpE2jxtoHrqQ
X-Proofpoint-GUID: nry0q7SfbBY3UlUBllRJSpE2jxtoHrqQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA4MyBTYWx0ZWRfXzEaYK3OqV1DB
 SjyjATSNczqHuaoDLQpamPs5ROnr8aeAhD4hZR8Hleh0HrKpwtUiaQyWcbKF9w9gKA3ER5juEUd
 42vuCeCfPU/iY/MPq0LZavQ2fnIdyPkNWFalxEowq7KcwcLciwcIawz+b4RpGXlkzkd4P/rKGoG
 UG4ScJdwcEYbSYm2UcyLYAkY2HydGxJdmKwrpypnmGZvu2/2/wSRkvfA33hpoFcddwQVuoSNCRO
 N4cfdB7zvcDMsJbN4BihtxX5EjUq1Nt4OVDMgs2QnNplgrN/9t/PBCnV7tUmONgluYs1gWoFyoU
 6IAPFEdQfqYx+Ve076VKXxEBVN1O5znHNedDGNxlOeM55Ou3OCt+icZq7iYQBTaIN64lqH5EUOb
 Ev3DyoZYfpPqX3BczmWRDpaeDo7wZRge6IC8uLvDJ0wiZxdsKKoy/hbD7jNRjEu3JBnDd2QQNGl
 1YBUyB68tP+ME7IWWWQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA4MyBTYWx0ZWRfX7XxIRcA8t+Gy
 9+bPD12eJ9fVpO/9ERg94q/SHCFTBNkVE6jTtCVYLjrdnMntTbmy24gM0CqBUuk/pLKDCLB4tXP
 ITdIS/sjijYAk8gWRAd6Gs5j65BiqXQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 impostorscore=0
 suspectscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608070083
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



On 7/29/2026 7:59 AM, Xin Xie wrote:
> Add a minimal K230 SDHCI model based on the generic SDHCI model. Reuse
> the generic commands and data paths while providing the extended register
> layout and documented reset values.
> 
> K230 SDHCI controller contains the standard SDHCI register block followed
> by preset, extension pointer, PHY and vendor-specific registers. This model
> implements the preset and extension pointer registers as read-only, retain
> writes to most PHY and vendor-specific registers, and keep PHY_PWRGOOD
> asserted so that the K230 SDK reset sequence can complete.
> 
> The SDHCI version is set to 3 due to the absence of ADMA3 support in the
> generic model.
> 
> Signed-off-by: Xin Xie <xinxie908@gmail.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   MAINTAINERS                |   2 +
>   hw/sd/Kconfig              |   4 +
>   hw/sd/k230_sdhci.c         | 311 +++++++++++++++++++++++++++++++++++++
>   hw/sd/meson.build          |   1 +
>   include/hw/sd/k230_sdhci.h |  82 ++++++++++
>   5 files changed, 400 insertions(+)
>   create mode 100644 hw/sd/k230_sdhci.c
>   create mode 100644 include/hw/sd/k230_sdhci.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6171cc7494..06285352c4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1826,8 +1826,10 @@ S: Maintained
>   F: docs/system/riscv/k230.rst
>   F: hw/riscv/k230.c
>   F: hw/watchdog/k230_wdt.c
> +F: hw/sd/k230_sdhci.c
>   F: include/hw/riscv/k230.h
>   F: include/hw/watchdog/k230_wdt.h
> +F: include/hw/sd/k230_sdhci.h
>   F: tests/qtest/k230-wdt-test.c
>   
>   RX Machines
> diff --git a/hw/sd/Kconfig b/hw/sd/Kconfig
> index 633b9afec9..e9a5d63b4d 100644
> --- a/hw/sd/Kconfig
> +++ b/hw/sd/Kconfig
> @@ -23,3 +23,7 @@ config SDHCI_PCI
>   config CADENCE_SDHCI
>       bool
>       select SDHCI
> +
> +config K230_SDHCI
> +    bool
> +    select SDHCI
> diff --git a/hw/sd/k230_sdhci.c b/hw/sd/k230_sdhci.c
> new file mode 100644
> index 0000000000..34c972a2f7
> --- /dev/null
> +++ b/hw/sd/k230_sdhci.c
> @@ -0,0 +1,311 @@
> +/*
> + * Kendryte K230 SDHCI controller
> + *
> + * Copyright (c) 2026 Xin Xie <xinxie908@gmail.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "hw/sd/k230_sdhci.h"
> +#include "hw/sd/sdhci-internal.h"
> +#include "migration/vmstate.h"
> +
> +/*
> + * The TRM describes an SDHCI v4.20 DWC MSHC, including the v4 block-count
> + * mode, ADMA3, and extension-area registers.  QEMU's generic controller
> + * supports up to v3 and does not implement those v4 transfer semantics.
> + */
> +#define K230_SDHCI_SPEC_VERSION 3
> +
> +/*
> + * K230's Capabilities registers describe more functionality than the generic
> + * QEMU SDHCI data path currently implements.  Do not expose the following TRM
> + * capabilities to the guest:
> + *
> + * - ASYNC_INT requires an SDIO card-interrupt input and asynchronous interrupt
> + *   signalling while the SD clock is stopped.  SDBus has no such input.
> + * - TIMER_RETUNING and RETUNING_MODE require a re-tuning timer and generation
> + *   of a re-tuning request.  The generic controller only completes an initial
> + *   command-based tuning operation; it never schedules periodic re-tuning.
> + * - ADMA3 requires the SDHCI v4.20 ADMA3 descriptor and command semantics,
> + *   whereas the generic controller implements SDMA and ADMA2 only.
> + */
> +#define K230_SDHCI_CAPABILITIES_UNSUPPORTED \
> +    (R_SDHC_CAPAB_ASYNC_INT_MASK | \
> +     R_SDHC_CAPAB_TIMER_RETUNING_MASK | \
> +     R_SDHC_CAPAB_RETUNING_MODE_MASK | \
> +     R_SDHC_CAPAB_ADMA3_MASK)
> +#define K230_SDHCI_CAPAREG_IMPLEMENTED \
> +    (K230_SDHCI_CAPAREG_RESET & ~K230_SDHCI_CAPABILITIES_UNSUPPORTED)
> +
> +#define K230_LO8(value)     ((value) & 0xff)
> +#define K230_HI8(value)     (((value) >> 8) & 0xff)
> +
> +static const uint8_t k230_sdhci_preset_reset[K230_SDHCI_PRESET_SIZE] = {
> +    [K230_SDHCI_PRESET_INIT - K230_SDHCI_PRESET_BASE] =
> +        K230_LO8(K230_SDHCI_PRESET_INIT_RESET),
> +    [K230_SDHCI_PRESET_INIT - K230_SDHCI_PRESET_BASE + 1] =
> +        K230_HI8(K230_SDHCI_PRESET_INIT_RESET),
> +    [K230_SDHCI_PRESET_DEFAULT_SPEED - K230_SDHCI_PRESET_BASE] =
> +        K230_LO8(K230_SDHCI_PRESET_DEFAULT_SPEED_RESET),
> +    [K230_SDHCI_PRESET_DEFAULT_SPEED - K230_SDHCI_PRESET_BASE + 1] =
> +        K230_HI8(K230_SDHCI_PRESET_DEFAULT_SPEED_RESET),
> +    [K230_SDHCI_PRESET_HIGH_SPEED - K230_SDHCI_PRESET_BASE] =
> +        K230_LO8(K230_SDHCI_PRESET_HIGH_SPEED_RESET),
> +    [K230_SDHCI_PRESET_HIGH_SPEED - K230_SDHCI_PRESET_BASE + 1] =
> +        K230_HI8(K230_SDHCI_PRESET_HIGH_SPEED_RESET),
> +    [K230_SDHCI_PRESET_SDR12 - K230_SDHCI_PRESET_BASE] =
> +        K230_LO8(K230_SDHCI_PRESET_SDR12_RESET),
> +    [K230_SDHCI_PRESET_SDR12 - K230_SDHCI_PRESET_BASE + 1] =
> +        K230_HI8(K230_SDHCI_PRESET_SDR12_RESET),
> +    [K230_SDHCI_PRESET_SDR25 - K230_SDHCI_PRESET_BASE] =
> +        K230_LO8(K230_SDHCI_PRESET_SDR25_RESET),
> +    [K230_SDHCI_PRESET_SDR25 - K230_SDHCI_PRESET_BASE + 1] =
> +        K230_HI8(K230_SDHCI_PRESET_SDR25_RESET),
> +    [K230_SDHCI_PRESET_SDR50 - K230_SDHCI_PRESET_BASE] =
> +        K230_LO8(K230_SDHCI_PRESET_SDR50_RESET),
> +    [K230_SDHCI_PRESET_SDR50 - K230_SDHCI_PRESET_BASE + 1] =
> +        K230_HI8(K230_SDHCI_PRESET_SDR50_RESET),
> +    [K230_SDHCI_PRESET_SDR104 - K230_SDHCI_PRESET_BASE] =
> +        K230_LO8(K230_SDHCI_PRESET_SDR104_RESET),
> +    [K230_SDHCI_PRESET_SDR104 - K230_SDHCI_PRESET_BASE + 1] =
> +        K230_HI8(K230_SDHCI_PRESET_SDR104_RESET),
> +    [K230_SDHCI_PRESET_DDR50 - K230_SDHCI_PRESET_BASE] =
> +        K230_LO8(K230_SDHCI_PRESET_DDR50_RESET),
> +    [K230_SDHCI_PRESET_DDR50 - K230_SDHCI_PRESET_BASE + 1] =
> +        K230_HI8(K230_SDHCI_PRESET_DDR50_RESET),
> +};
> +
> +static uint64_t k230_sdhci_preset_read(void *opaque, hwaddr addr,
> +                                      unsigned int size)
> +{
> +    return ldn_le_p(&k230_sdhci_preset_reset[addr], size);
> +}
> +
> +static void k230_sdhci_preset_write(void *opaque, hwaddr addr, uint64_t value,
> +                                   unsigned int size)
> +{
> +    qemu_log_mask(LOG_GUEST_ERROR,
> +                  "K230 SDHCI: write to read-only Preset Value register "
> +                  "0x%03" HWADDR_PRIx "\n",
> +                  K230_SDHCI_PRESET_BASE + addr);
> +}
> +
> +static const MemoryRegionOps k230_sdhci_preset_ops = {
> +    .read = k230_sdhci_preset_read,
> +    .write = k230_sdhci_preset_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid = {
> +        .min_access_size = 1,
> +        .max_access_size = 4,
> +        .unaligned = false,
> +    },
> +};
> +
> +static const uint8_t k230_sdhci_pointer_reset[K230_SDHCI_POINTER_SIZE] = {
> +    [K230_SDHCI_P_UHS2_SETTINGS - K230_SDHCI_POINTER_BASE] =
> +        K230_LO8(K230_SDHCI_P_UHS2_SETTINGS_RESET),
> +    [K230_SDHCI_P_UHS2_SETTINGS - K230_SDHCI_POINTER_BASE + 1] =
> +        K230_HI8(K230_SDHCI_P_UHS2_SETTINGS_RESET),
> +    [K230_SDHCI_P_UHS2_HOST_CAPAB - K230_SDHCI_POINTER_BASE] =
> +        K230_LO8(K230_SDHCI_P_UHS2_HOST_CAPAB_RESET),
> +    [K230_SDHCI_P_UHS2_HOST_CAPAB - K230_SDHCI_POINTER_BASE + 1] =
> +        K230_HI8(K230_SDHCI_P_UHS2_HOST_CAPAB_RESET),
> +    [K230_SDHCI_P_UHS2_TEST - K230_SDHCI_POINTER_BASE] =
> +        K230_LO8(K230_SDHCI_P_UHS2_TEST_RESET),
> +    [K230_SDHCI_P_UHS2_TEST - K230_SDHCI_POINTER_BASE + 1] =
> +        K230_HI8(K230_SDHCI_P_UHS2_TEST_RESET),
> +    [K230_SDHCI_P_EMBEDDED_CNTRL - K230_SDHCI_POINTER_BASE] =
> +        K230_LO8(K230_SDHCI_P_EMBEDDED_CNTRL_RESET),
> +    [K230_SDHCI_P_EMBEDDED_CNTRL - K230_SDHCI_POINTER_BASE + 1] =
> +        K230_HI8(K230_SDHCI_P_EMBEDDED_CNTRL_RESET),
> +    [K230_SDHCI_P_VENDOR_AREA1 - K230_SDHCI_POINTER_BASE] =
> +        K230_LO8(K230_SDHCI_P_VENDOR_AREA1_RESET),
> +    [K230_SDHCI_P_VENDOR_AREA1 - K230_SDHCI_POINTER_BASE + 1] =
> +        K230_HI8(K230_SDHCI_P_VENDOR_AREA1_RESET),
> +    [K230_SDHCI_P_VENDOR_AREA2 - K230_SDHCI_POINTER_BASE] =
> +        K230_LO8(K230_SDHCI_P_VENDOR_AREA2_RESET),
> +    [K230_SDHCI_P_VENDOR_AREA2 - K230_SDHCI_POINTER_BASE + 1] =
> +        K230_HI8(K230_SDHCI_P_VENDOR_AREA2_RESET),
> +};
> +
> +static uint64_t k230_sdhci_pointer_read(void *opaque, hwaddr addr,
> +                                       unsigned int size)
> +{
> +    return ldn_le_p(&k230_sdhci_pointer_reset[addr], size);
> +}
> +
> +static void k230_sdhci_pointer_write(void *opaque, hwaddr addr, uint64_t value,
> +                                    unsigned int size)
> +{
> +    qemu_log_mask(LOG_GUEST_ERROR,
> +                  "K230 SDHCI: write to read-only pointer register "
> +                  "0x%03" HWADDR_PRIx "\n",
> +                  K230_SDHCI_POINTER_BASE + addr);
> +}
> +
> +static const MemoryRegionOps k230_sdhci_pointer_ops = {
> +    .read = k230_sdhci_pointer_read,
> +    .write = k230_sdhci_pointer_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid = {
> +        .min_access_size = 1,
> +        .max_access_size = 4,
> +        .unaligned = false,
> +    },
> +};
> +
> +/*
> + * K230 uses the standard SDHCI register set at offset zero, followed by
> + * UHS-II, DWC MSHC PHY, Embedded Control, and vendor-specific blocks. Most
> + * side effects of analogue PHY behaviors not simulated.
> + *
> + * PHY_PWRGOOD is the sole synthesized status bit.  Real hardware asserts it
> + * after PHY power and reset sequencing; the SDK driver polls it during every
> + * full controller reset.  A virtual PHY has no settling interval or failure
> + * condition, so the bit is permanently asserted and cannot be cleared by a
> + * guest write.
> + */
> +static uint64_t k230_sdhci_fallback_read(void *opaque, hwaddr addr,
> +                                        unsigned int size)
> +{
> +    K230SDHCIState *s = opaque;
> +    uint64_t value = ldn_le_p(&s->fallback_regs[addr], size);
> +
> +    if (ranges_overlap(addr, size, K230_SDHCI_PHY_CNFG,
> +                       sizeof(uint32_t)) && addr <= K230_SDHCI_PHY_CNFG) {
> +        unsigned int shift = (K230_SDHCI_PHY_CNFG - addr) * 8;
> +
> +        value |= (uint64_t)K230_SDHCI_PHY_CNFG_PWRGOOD << shift;
> +    }
> +
> +    return value;
> +}
> +
> +static void k230_sdhci_fallback_write(void *opaque, hwaddr addr,
> +                                     uint64_t value, unsigned int size)
> +{
> +    K230SDHCIState *s = opaque;
> +
> +    stn_le_p(&s->fallback_regs[addr], size, value);
> +
> +    /* PWRGOOD reflects PHY state and is not software writable. */
> +    s->fallback_regs[K230_SDHCI_PHY_CNFG] |=
> +        K230_SDHCI_PHY_CNFG_PWRGOOD;
> +}
> +
> +static const MemoryRegionOps k230_sdhci_fallback_ops = {
> +    .read = k230_sdhci_fallback_read,
> +    .write = k230_sdhci_fallback_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid = {
> +        .min_access_size = 1,
> +        .max_access_size = 4,
> +        .unaligned = false,
> +    },
> +};
> +
> +static void k230_sdhci_reset(DeviceState *dev)
> +{
> +    K230SDHCIState *s = K230_SDHCI(dev);
> +
> +    memset(s->fallback_regs, 0, sizeof(s->fallback_regs));
> +    s->fallback_regs[K230_SDHCI_PHY_CNFG] =
> +        K230_SDHCI_PHY_CNFG_PWRGOOD;
> +    device_cold_reset(DEVICE(&s->sdhci));
> +}
> +
> +static void k230_sdhci_realize(DeviceState *dev, Error **errp)
> +{
> +    K230SDHCIState *s = K230_SDHCI(dev);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> +    SysBusDevice *sdhci_sbd = SYS_BUS_DEVICE(&s->sdhci);
> +
> +    memory_region_init(&s->container, OBJECT(s), "k230.sdhci-container",
> +                       K230_SDHCI_REG_SIZE);
> +    sysbus_init_mmio(sbd, &s->container);
> +
> +    memory_region_init_io(&s->iomem_fallback, OBJECT(s),
> +                          &k230_sdhci_fallback_ops, s,
> +                          "k230.sdhci-fallback",
> +                          K230_SDHCI_REG_SIZE);
> +    memory_region_add_subregion(&s->container, 0, &s->iomem_fallback);
> +
> +    if (!sysbus_realize(sdhci_sbd, errp)) {
> +        return;
> +    }
> +    memory_region_add_subregion_overlap(
> +        &s->container, 0, sysbus_mmio_get_region(sdhci_sbd, 0), 1);
> +
> +    memory_region_init_io(&s->iomem_preset, OBJECT(s),
> +                          &k230_sdhci_preset_ops, s,
> +                          "k230.sdhci-preset", K230_SDHCI_PRESET_SIZE);
> +    memory_region_add_subregion_overlap(&s->container,
> +                                        K230_SDHCI_PRESET_BASE,
> +                                        &s->iomem_preset, 2);
> +
> +    memory_region_init_io(&s->iomem_pointer, OBJECT(s),
> +                          &k230_sdhci_pointer_ops, s,
> +                          "k230.sdhci-pointers", K230_SDHCI_POINTER_SIZE);
> +    memory_region_add_subregion_overlap(&s->container,
> +                                        K230_SDHCI_POINTER_BASE,
> +                                        &s->iomem_pointer, 2);
> +
> +    sysbus_pass_irq(sbd, sdhci_sbd);
> +    s->bus = qdev_get_child_bus(DEVICE(sdhci_sbd), "sd-bus");
> +}
> +
> +static const VMStateDescription vmstate_k230_sdhci = {
> +    .name = TYPE_K230_SDHCI,
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT8_ARRAY(fallback_regs, K230SDHCIState,
> +                            K230_SDHCI_REG_SIZE),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
> +static void k230_sdhci_instance_init(Object *obj)
> +{
> +    K230SDHCIState *s = K230_SDHCI(obj);
> +
> +    object_initialize_child(obj, "generic-sdhci", &s->sdhci,
> +                            TYPE_SYSBUS_SDHCI);
> +
> +    object_property_set_uint(OBJECT(&s->sdhci), "sd-spec-version",
> +                             K230_SDHCI_SPEC_VERSION,
> +                             &error_abort);
> +    object_property_set_uint(OBJECT(&s->sdhci), "capareg",
> +                             K230_SDHCI_CAPAREG_IMPLEMENTED,
> +                             &error_abort);
> +    object_property_set_uint(OBJECT(&s->sdhci), "uhs", UHS_I, &error_abort);
> +}
> +
> +static void k230_sdhci_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->desc = "Kendryte K230 SDHCI Controller";
> +    dc->realize = k230_sdhci_realize;
> +    device_class_set_legacy_reset(dc, k230_sdhci_reset);
> +    dc->vmsd = &vmstate_k230_sdhci;
> +    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
> +}
> +
> +static const TypeInfo k230_sdhci_type_info = {
> +    .name = TYPE_K230_SDHCI,
> +    .parent = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(K230SDHCIState),
> +    .instance_init = k230_sdhci_instance_init,
> +    .class_init = k230_sdhci_class_init,
> +};
> +
> +static void k230_sdhci_register_types(void)
> +{
> +    type_register_static(&k230_sdhci_type_info);
> +}
> +
> +type_init(k230_sdhci_register_types)
> diff --git a/hw/sd/meson.build b/hw/sd/meson.build
> index b43d45bc56..a109635233 100644
> --- a/hw/sd/meson.build
> +++ b/hw/sd/meson.build
> @@ -10,3 +10,4 @@ system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_sdhci.c'))
>   system_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-sdhost.c'))
>   system_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx_sdhci.c'))
>   system_ss.add(when: 'CONFIG_CADENCE_SDHCI', if_true: files('cadence_sdhci.c'))
> +system_ss.add(when: 'CONFIG_K230_SDHCI', if_true: files('k230_sdhci.c'))
> diff --git a/include/hw/sd/k230_sdhci.h b/include/hw/sd/k230_sdhci.h
> new file mode 100644
> index 0000000000..a8389f1de4
> --- /dev/null
> +++ b/include/hw/sd/k230_sdhci.h
> @@ -0,0 +1,82 @@
> +/*
> + * Kendryte K230 SDHCI controller
> + *
> + * Copyright (c) 2026 Xin Xie <xinxie908@gmail.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_SD_K230_SDHCI_H
> +#define HW_SD_K230_SDHCI_H
> +
> +#include "qemu/bitops.h"
> +#include "hw/sd/sdhci.h"
> +#include "qom/object.h"
> +
> +#define TYPE_K230_SDHCI "k230.sdhci"
> +OBJECT_DECLARE_SIMPLE_TYPE(K230SDHCIState, K230_SDHCI)
> +
> +#define K230_SDHCI_REG_SIZE             0x1000
> +
> +/* K230 TRM reset values for Capabilities Registers 1 and 2. */
> +#define K230_SDHCI_CAPABILITIES1_RESET  0x256ec881ULL
> +#define K230_SDHCI_CAPABILITIES2_RESET  0x0800a177ULL
> +#define K230_SDHCI_CAPAREG_RESET \
> +    ((K230_SDHCI_CAPABILITIES2_RESET << 32) \
> +    | K230_SDHCI_CAPABILITIES1_RESET)
> +
> +/* SDHCI Preset Value registers. */
> +#define K230_SDHCI_PRESET_BASE           0x060
> +#define K230_SDHCI_PRESET_SIZE           0x010
> +#define K230_SDHCI_PRESET_INIT           0x060
> +#define K230_SDHCI_PRESET_DEFAULT_SPEED  0x062
> +#define K230_SDHCI_PRESET_HIGH_SPEED     0x064
> +#define K230_SDHCI_PRESET_SDR12          0x066
> +#define K230_SDHCI_PRESET_SDR25          0x068
> +#define K230_SDHCI_PRESET_SDR50          0x06a
> +#define K230_SDHCI_PRESET_SDR104         0x06c
> +#define K230_SDHCI_PRESET_DDR50          0x06e
> +#define K230_SDHCI_PRESET_INIT_RESET          0x00fa
> +#define K230_SDHCI_PRESET_DEFAULT_SPEED_RESET 0x0004
> +#define K230_SDHCI_PRESET_HIGH_SPEED_RESET    0x0002
> +#define K230_SDHCI_PRESET_SDR12_RESET         0x0004
> +#define K230_SDHCI_PRESET_SDR25_RESET         0x0002
> +#define K230_SDHCI_PRESET_SDR50_RESET         0x0001
> +#define K230_SDHCI_PRESET_SDR104_RESET        0x0000
> +#define K230_SDHCI_PRESET_DDR50_RESET         0x0002
> +
> +/* SDHCI v4 extension-area pointer registers. */
> +#define K230_SDHCI_POINTER_BASE         0x0e0
> +#define K230_SDHCI_POINTER_SIZE         0x00c
> +#define K230_SDHCI_P_UHS2_SETTINGS      0x0e0
> +#define K230_SDHCI_P_UHS2_HOST_CAPAB    0x0e2
> +#define K230_SDHCI_P_UHS2_TEST          0x0e4
> +#define K230_SDHCI_P_EMBEDDED_CNTRL     0x0e6
> +#define K230_SDHCI_P_VENDOR_AREA1       0x0e8
> +#define K230_SDHCI_P_VENDOR_AREA2       0x0ea
> +#define K230_SDHCI_P_UHS2_SETTINGS_RESET    0x0000
> +#define K230_SDHCI_P_UHS2_HOST_CAPAB_RESET  0x0f58
> +#define K230_SDHCI_P_UHS2_TEST_RESET        0x0f68
> +#define K230_SDHCI_P_EMBEDDED_CNTRL_RESET   0x0f6c
> +#define K230_SDHCI_P_VENDOR_AREA1_RESET     0x0500
> +#define K230_SDHCI_P_VENDOR_AREA2_RESET     0x0384
> +
> +/* DWC MSHC PHY register block. */
> +#define K230_SDHCI_PHY_CNFG             0x300
> +#define K230_SDHCI_PHY_CNFG_RSTN        BIT(0)
> +#define K230_SDHCI_PHY_CNFG_PWRGOOD     BIT(1)
> +
> +struct K230SDHCIState {
> +    SysBusDevice parent_obj;
> +
> +    MemoryRegion container;
> +    MemoryRegion iomem_fallback;
> +    MemoryRegion iomem_preset;
> +    MemoryRegion iomem_pointer;
> +    BusState *bus;
> +    uint8_t fallback_regs[K230_SDHCI_REG_SIZE];
> +
> +    SDHCIState sdhci;
> +};
> +
> +#endif


