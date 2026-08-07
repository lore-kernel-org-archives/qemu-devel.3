Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A866EC5AC80
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 10:59:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsII3-0007Uc-1Z; Fri, 07 Aug 2026 06:59:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wsII2-0007UJ-5p
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 06:59:02 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wsII0-0005MC-98
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 06:59:01 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6777u2TG3822004
 for <qemu-devel@nongnu.org>; Fri, 7 Aug 2026 10:58:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Q5JGj+RFeNMQA3Y0dMKVB34VT6Ay76sI1yXCt6aZFQA=; b=JGicZj2Pg+gqAabS
 xsWcGThsozLB9khqYalvIbN0iTJGG/sAtJuETPRbO9cwWIUSsZHzWYlXDKx+crQC
 mE7o3DQSpnhdHxZhAHOzBrktUd94TttugZneoU7+nOtL1nzUYBCYpRChcSlnUc8R
 MY75OMMnpqMWL7AGVKvdgLhnrpULzs787TXqo/kLH4yfsDkxerazyYBU+gvuZGKB
 gr/fiVrsPPcguvcGvbcd0dPSuA+xG6o3ppSZWnLVGnvenI0hpZ3aZSDEhtQVtHKI
 qrS4mSyyZpM9fVqIR8hEWObs2eOFSeQ1/zxmKsRXrhEo66Ppvz7BpAq5Cf9U3Ywj
 5ZsZ7A==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvy6gum4g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 10:58:58 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c07f25de2so26197221cf.3
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 03:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786100338; x=1786705138; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Q5JGj+RFeNMQA3Y0dMKVB34VT6Ay76sI1yXCt6aZFQA=;
 b=EmA44FuhlbJYdyU/3nUz9WRxV065JwboXthX7Z5EldYwbqekHcW+zza4N4AXbHt4Kr
 ecEfcUIKF7IYBH0aLNwdoMScEpEDPwAZ4jGP+EW5deQK2B81jYDekkzb8mwjYjbAobB3
 cIr4DJntKwvXnm1AgAD/KqCiBIZ80aMI6u1ywjk8H5PcQWouXdfbLTvc46AUKeSN9jOj
 sUaWxrkGxGpKxYPnj923dHQUK0ikA+tXeLVRyGk323x+cJ5YNMjtdXzv9JQoMDq4NwHu
 tx7fciLJca4YpeROwYLvEuiWkvIgg4UgidlU5H60RZTvjcF8HlHPHTUyZwT7PTSdemox
 XR3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786100338; x=1786705138;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Q5JGj+RFeNMQA3Y0dMKVB34VT6Ay76sI1yXCt6aZFQA=;
 b=H27wn27/UwWeDLbTEVHakBIVZDl03LwEkrWni99V5lAYuIDvy3QsC4/QlRNeBhNRD6
 KrR2NsUqMZEJNGCrML6a00X0FFZQTDTZi/eBZtsjx8f4bK7zH/h1eE0NY4J5jfeKVDeq
 T2ryJ8gxbkkJmwngwHCxBURtBf0F4K61ByDvVPkZaOH+rIYcYhO0eDhSuLOwiDxKgw5+
 nT1cCs/p3wMS72M1n4tAUq8uzJsLha0QeUZnCWzIzF0kO4KSCE3PB3dzA5FEumaEhEh0
 Ua3/yjmWKxAS8tVYf0qzB2itlaW9YQ4RI5WS/EMvnXtXLWhp4py0yoSBLgmS1EFIXuI7
 JWcg==
X-Forwarded-Encrypted: i=1;
 AHgh+RouV4xzitunyaWeqGFllO1oxSKpqzHy4fGcS7HKimGDrrGbIZEbZ13EZna6dI7zI/eT5p8I+Clf6/Fm@nongnu.org
X-Gm-Message-State: AOJu0Yy5mbauzWKtaSxQ0vNx94fnF3Opioz+NkzKVDLw15b6PWD2Eye+
 szA/0x/xBbZmavPWBTIfzShcf4osnzxHVp591zchqIZBXFl2Bcq9OUaS2bbrN6UmViqxAPLwit4
 5Cutda2JuKrREH+Meh0KlCvQwq1KCWPUWjBJdJM1c885rgRtUWtElAUkoOw==
X-Gm-Gg: AR+sD11ELG5BLG60XGXhP3qmDWFUO5Je8wslPRyIc4Ac2T+iFPVt1peSpoEagYV4Xob
 VH9iB7bjYFk+BOqYN1tgLLT16OvqMhJM+8QLTEFvtTKVgeflRsI7cGCCtQVgsu3TuPPUpd6IpBG
 fy/10h2L6dodr0ymB/BBah2edw/EeVpg9EDLcmAoNziDJ157MDFkA2Doz9cbP+xOOX5xeSFOWiO
 5Vrel2DsAzIxUwlfmxKF+ZSfqI/+eoqE2LOCbq/CsNzJbfwBC+z8oXBsJZBjvEAIPdxCMXxBWcR
 9X76vLpsGysR6XsbPOTTHfPmz7JRuKcgP4KoUpTvh0vWkDiyrkuBiZrmfAMV4gbE9rG2vhiX/3Q
 FJ1i2uzTHcDNhXgkXLxS8aOmzzSj6oTzflrTW
X-Received: by 2002:a05:622a:1e12:b0:516:dda7:51e0 with SMTP id
 d75a77b69052e-52ce5ff11acmr232472331cf.17.1786100338043; 
 Fri, 07 Aug 2026 03:58:58 -0700 (PDT)
X-Received: by 2002:a05:622a:1e12:b0:516:dda7:51e0 with SMTP id
 d75a77b69052e-52ce5ff11acmr232471991cf.17.1786100337543; 
 Fri, 07 Aug 2026 03:58:57 -0700 (PDT)
Received: from [192.168.68.104] ([187.11.154.152])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52d1637f4a1sm9546241cf.9.2026.08.07.03.58.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Aug 2026 03:58:57 -0700 (PDT)
Message-ID: <e2863b2a-83e2-4a9f-937e-e2f122a5f190@oss.qualcomm.com>
Date: Fri, 7 Aug 2026 07:58:53 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] tests/qtest: add K230 SDHCI tests
To: Xin Xie <xinxie908@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>
References: <20260729105904.272939-1-xinxie908@gmail.com>
 <20260729105904.272939-4-xinxie908@gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260729105904.272939-4-xinxie908@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=EYH4hvmC c=1 sm=1 tr=0 ts=6a75ba72 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=iMfxv9gflPUPBcmW7/Gq5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=5XHA67EirIWxhrRuoN8A:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: OgFo6hgHoRGjEiAQb3fZpxCd3lOeX3XN
X-Proofpoint-GUID: OgFo6hgHoRGjEiAQb3fZpxCd3lOeX3XN
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA4NCBTYWx0ZWRfX6zm0FlYhxFlK
 XH88BHPGrwSDn3rAAz586EaPY4pObzr21DUICNFEtRVZ962wc19PGF8ChMbyzr9Uk3A64gJVPIk
 +YzXR4dFAcqBP8jBHWl2I1ZzW+vHMXs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA4NCBTYWx0ZWRfX/GXtXXTczW6R
 WEYe2j05ioTE7l91yxAMADEPFYAShjRh4Vrl0sNGxosLp0QiFzCJCLOghLiWauAXZc50cuCk9KV
 jJ4rFyKKgdZ869u1LBYNM+BPAUtXvE3HDXNc63kxZEg3Nwx2HsyMlj8fJPHqUukER5x+A0htwqG
 xiauMAcXh5qWDunxyrxk7GQvoroyRm8gZlRb65//2YFrg/HNWnnyc72G9jBIz8HtfEiQCJbG75M
 TVi3QYjOLpilVmGAV1qJuoh0dc1r6o3qW/foTypXSCTffC4KB6nmW8t0GAhFpzBjrwZu3xbXh7n
 estFYcEen0lcm98Zp+jFU76mExD6vGMmNmGKqUI4nqFsm7r6ahaaWBYdgJYwUJzfUeuSuUSVdpj
 lCjV0Wy1Jb/eY6wSoyODg8r84nvCrYzS1HdEQ+P60QTmDKNmIJR05J068wsKG0ZAMi+ieaim2Jw
 zpH7vP6WFV13U6FXEKQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070084
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
> Add qtests covering the K230-specific SDHCI register layout, capability
> masking, preset values, extension pointers, PHY power status and
> per-controller vendor register storage.
> 
> Verify card detection and interrupt delivery through the K230 PLIC.
> Exercise basic PIO reads and writes with an attached SD card image and
> check that written data reaches the backing file.
> 
> Signed-off-by: Xin Xie <xinxie908@gmail.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   MAINTAINERS                   |   1 +
>   tests/qtest/k230-sdhci-test.c | 214 ++++++++++++++++++++++++++++++++++
>   tests/qtest/meson.build       |   5 +-
>   3 files changed, 219 insertions(+), 1 deletion(-)
>   create mode 100644 tests/qtest/k230-sdhci-test.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 06285352c4..99c4c3294b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1831,6 +1831,7 @@ F: include/hw/riscv/k230.h
>   F: include/hw/watchdog/k230_wdt.h
>   F: include/hw/sd/k230_sdhci.h
>   F: tests/qtest/k230-wdt-test.c
> +F: tests/qtest/k230-sdhci-test.c
>   
>   RX Machines
>   -----------
> diff --git a/tests/qtest/k230-sdhci-test.c b/tests/qtest/k230-sdhci-test.c
> new file mode 100644
> index 0000000000..5eedb130c3
> --- /dev/null
> +++ b/tests/qtest/k230-sdhci-test.c
> @@ -0,0 +1,214 @@
> +/*
> + * QTest testcase for the Kendryte K230 SDHCI controllers
> + *
> + * Copyright (c) 2026 Xin Xie <xinxie908@gmail.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/timer.h"
> +#include "qemu/units.h"
> +#include "libqtest.h"
> +#include "libqos/sdhci-cmd.h"
> +#include "hw/sd/k230_sdhci.h"
> +#include "hw/sd/sdhci-internal.h"
> +
> +#define K230_SD0_BASE          0x91580000
> +#define K230_SD1_BASE          0x91581000
> +#define K230_PLIC_PENDING      0xf00001000ULL
> +#define K230_SD1_IRQ           144
> +
> +#define K230_SD_TEST_IMAGE_SIZE (2 * MiB)
> +#define K230_SD_TEST_BLOCK_SIZE 512
> +
> +static void test_registers(void)
> +{
> +    QTestState *qts = qtest_init("-machine k230");
> +    uint64_t capabilities;
> +    uint64_t expected = K230_SDHCI_CAPAREG_RESET;
> +
> +    /* Only capabilities unsupported by the QEMU model are removed. */
> +    expected = FIELD_DP64(expected, SDHC_CAPAB, ASYNC_INT, 0);
> +    expected = FIELD_DP64(expected, SDHC_CAPAB, TIMER_RETUNING, 0);
> +    expected = FIELD_DP64(expected, SDHC_CAPAB, RETUNING_MODE, 0);
> +    expected = FIELD_DP64(expected, SDHC_CAPAB, ADMA3, 0);
> +    capabilities = qtest_readq(qts, K230_SD0_BASE + SDHC_CAPAB);
> +    g_assert_cmphex(capabilities, ==, expected);
> +
> +    /* Preset Value registers use the TRM reset values and are read-only. */
> +    g_assert(qtest_readw(qts, K230_SD0_BASE + K230_SDHCI_PRESET_INIT) ==
> +             K230_SDHCI_PRESET_INIT_RESET);
> +    g_assert(qtest_readw(qts, K230_SD0_BASE +
> +                         K230_SDHCI_PRESET_DEFAULT_SPEED) ==
> +             K230_SDHCI_PRESET_DEFAULT_SPEED_RESET);
> +    g_assert(qtest_readw(qts, K230_SD0_BASE +
> +                         K230_SDHCI_PRESET_HIGH_SPEED) ==
> +             K230_SDHCI_PRESET_HIGH_SPEED_RESET);
> +    g_assert(qtest_readw(qts, K230_SD0_BASE + K230_SDHCI_PRESET_SDR12) ==
> +             K230_SDHCI_PRESET_SDR12_RESET);
> +    g_assert(qtest_readw(qts, K230_SD0_BASE + K230_SDHCI_PRESET_SDR25) ==
> +             K230_SDHCI_PRESET_SDR25_RESET);
> +    g_assert(qtest_readw(qts, K230_SD0_BASE + K230_SDHCI_PRESET_SDR50) ==
> +             K230_SDHCI_PRESET_SDR50_RESET);
> +    g_assert(qtest_readw(qts, K230_SD0_BASE + K230_SDHCI_PRESET_SDR104) ==
> +             K230_SDHCI_PRESET_SDR104_RESET);
> +    g_assert(qtest_readw(qts, K230_SD0_BASE + K230_SDHCI_PRESET_DDR50) ==
> +             K230_SDHCI_PRESET_DDR50_RESET);
> +
> +    qtest_writew(qts, K230_SD0_BASE + K230_SDHCI_PRESET_SDR50, 0xffff);
> +    g_assert(qtest_readw(qts, K230_SD0_BASE + K230_SDHCI_PRESET_SDR50) ==
> +             K230_SDHCI_PRESET_SDR50_RESET);
> +
> +    /* Extension-area pointers use their documented read-only reset values. */
> +    g_assert(qtest_readw(qts, K230_SD0_BASE + K230_SDHCI_P_UHS2_SETTINGS) ==
> +             K230_SDHCI_P_UHS2_SETTINGS_RESET);
> +    g_assert(qtest_readw(qts, K230_SD0_BASE + K230_SDHCI_P_UHS2_HOST_CAPAB) ==
> +             K230_SDHCI_P_UHS2_HOST_CAPAB_RESET);
> +    g_assert(qtest_readw(qts, K230_SD0_BASE + K230_SDHCI_P_UHS2_TEST) ==
> +             K230_SDHCI_P_UHS2_TEST_RESET);
> +    g_assert(qtest_readw(qts, K230_SD0_BASE + K230_SDHCI_P_EMBEDDED_CNTRL) ==
> +             K230_SDHCI_P_EMBEDDED_CNTRL_RESET);
> +    g_assert(qtest_readw(qts, K230_SD0_BASE + K230_SDHCI_P_VENDOR_AREA1) ==
> +             K230_SDHCI_P_VENDOR_AREA1_RESET);
> +    g_assert(qtest_readw(qts, K230_SD0_BASE + K230_SDHCI_P_VENDOR_AREA2) ==
> +             K230_SDHCI_P_VENDOR_AREA2_RESET);
> +
> +    qtest_writew(qts, K230_SD0_BASE + K230_SDHCI_P_VENDOR_AREA1, 0xffff);
> +    g_assert(qtest_readw(qts, K230_SD0_BASE + K230_SDHCI_P_VENDOR_AREA1) ==
> +             K230_SDHCI_P_VENDOR_AREA1_RESET);
> +
> +    /* The virtual PHY is always ready and software cannot clear PWRGOOD. */
> +    g_assert((qtest_readl(qts, K230_SD0_BASE + K230_SDHCI_PHY_CNFG) &
> +              K230_SDHCI_PHY_CNFG_PWRGOOD) == K230_SDHCI_PHY_CNFG_PWRGOOD);
> +    qtest_writel(qts, K230_SD0_BASE + K230_SDHCI_PHY_CNFG, 0);
> +    g_assert(qtest_readl(qts, K230_SD0_BASE + K230_SDHCI_PHY_CNFG) ==
> +             K230_SDHCI_PHY_CNFG_PWRGOOD);
> +
> +    /* Vendor storage is writable and private to each controller instance. */
> +    qtest_writel(qts, K230_SD0_BASE + K230_SDHCI_P_VENDOR_AREA1_RESET,
> +                 0x89abcdef);
> +    g_assert(qtest_readl(qts, K230_SD0_BASE +
> +                         K230_SDHCI_P_VENDOR_AREA1_RESET) ==
> +             0x89abcdef);
> +    g_assert(qtest_readl(qts, K230_SD1_BASE +
> +                         K230_SDHCI_P_VENDOR_AREA1_RESET) == 0);
> +
> +    qtest_quit(qts);
> +}
> +
> +static void test_card_detect(void)
> +{
> +    g_autofree char *path = NULL;
> +    int fd = g_file_open_tmp("k230-sd-XXXXXX.img", &path, NULL);
> +    QTestState *qts;
> +
> +    g_assert(fd >= 0);
> +    g_assert(ftruncate(fd, K230_SD_TEST_IMAGE_SIZE) == 0);
> +    close(fd);
> +
> +    qts = qtest_initf("-machine k230 "
> +                      "-drive if=sd,index=1,format=raw,file=%s", path);
> +
> +    /* Card insertion becomes visible after the generic insertion delay. */
> +    qtest_clock_step(qts, NANOSECONDS_PER_SECOND);
> +    g_assert((qtest_readl(qts, K230_SD1_BASE + SDHC_PRNSTS) &
> +              SDHC_CARD_PRESENT) == SDHC_CARD_PRESENT);
> +    g_assert((qtest_readl(qts, K230_SD0_BASE + SDHC_PRNSTS) &
> +              SDHC_CARD_PRESENT) == 0);
> +
> +    /* Route a command-complete event through SDHCI to the K230 PLIC. */
> +    qtest_writew(qts, K230_SD1_BASE + SDHC_NORINTSTSEN,
> +                 SDHC_NISEN_CMDCMP);
> +    qtest_writew(qts, K230_SD1_BASE + SDHC_NORINTSIGEN,
> +                 SDHC_NISEN_CMDCMP);
> +    g_assert((qtest_readw(qts, K230_SD1_BASE + SDHC_NORINTSTSEN) &
> +              SDHC_NISEN_CMDCMP) != 0);
> +    g_assert((qtest_readw(qts, K230_SD1_BASE + SDHC_NORINTSIGEN) &
> +              SDHC_NISEN_CMDCMP) != 0);
> +    qtest_writew(qts, K230_SD1_BASE + SDHC_CLKCON,
> +                 SDHC_CLOCK_INT_EN | SDHC_CLOCK_SDCLK_EN);
> +    qtest_writew(qts, K230_SD1_BASE + SDHC_CMDREG,
> +                 SDHC_APP_CMD | SDHC_CMD_RESPONSE);
> +    g_assert((qtest_readw(qts, K230_SD1_BASE + SDHC_NORINTSTS) &
> +              SDHC_NIS_CMDCMP) != 0);
> +    g_assert((qtest_readl(qts, K230_PLIC_PENDING +
> +                          K230_SD1_IRQ / 32 * sizeof(uint32_t)) &
> +              BIT(K230_SD1_IRQ % 32)) != 0);
> +
> +    qtest_quit(qts);
> +    unlink(path);
> +}
> +
> +static void k230_sdhci_select_card(QTestState *qts)
> +{
> +    uint16_t rca;
> +
> +    /* Reset the controller and enable its internal and SD clocks. */
> +    qtest_writeb(qts, K230_SD1_BASE + SDHC_SWRST, SDHC_RESET_ALL);
> +    qtest_writew(qts, K230_SD1_BASE + SDHC_CLKCON,
> +                 SDHC_CLOCK_INT_EN | SDHC_CLOCK_INT_STABLE |
> +                 SDHC_CLOCK_SDCLK_EN);
> +
> +    /* Run the SD identification sequence and select the assigned RCA. */
> +    sdhci_cmd_regs(qts, K230_SD1_BASE, 0, 0, 0, 0, SDHC_APP_CMD);
> +    sdhci_cmd_regs(qts, K230_SD1_BASE, 0, 0, 0x41200000, 0, 41 << 8);
> +    sdhci_cmd_regs(qts, K230_SD1_BASE, 0, 0, 0, 0, SDHC_ALL_SEND_CID);
> +    sdhci_cmd_regs(qts, K230_SD1_BASE, 0, 0, 0, 0,
> +                   SDHC_SEND_RELATIVE_ADDR | SDHC_CMD_RESPONSE);
> +    rca = qtest_readl(qts, K230_SD1_BASE + SDHC_RSPREG0) >> 16;
> +    sdhci_cmd_regs(qts, K230_SD1_BASE, 0, 0, rca << 16, 0,
> +                   SDHC_SELECT_DESELECT_CARD);
> +}
> +
> +static void test_card_io(void)
> +{
> +    static const char read_data[] = "K230 SDHCI read";
> +    static const char write_data[] = "K230 SDHCI write";
> +    g_autofree char *path = NULL;
> +    char buffer[K230_SD_TEST_BLOCK_SIZE];
> +    int fd = g_file_open_tmp("k230-sd-XXXXXX.img", &path, NULL);
> +    QTestState *qts;
> +
> +    /* Seed block zero so the controller read can be checked independently. */
> +    g_assert(fd >= 0);
> +    g_assert(ftruncate(fd, K230_SD_TEST_IMAGE_SIZE) == 0);
> +    g_assert(pwrite(fd, read_data, sizeof(read_data), 0) == sizeof(read_data));
> +    close(fd);
> +
> +    qts = qtest_initf("-machine k230 "
> +                      "-drive if=sd,index=1,format=raw,auto-read-only=off,"
> +                      "file=%s", path);
> +    k230_sdhci_select_card(qts);
> +
> +    /* Read block zero through the SDHCI PIO data port. */
> +    memset(buffer, 0, sizeof(buffer));
> +    g_assert(sdhci_read_cmd(qts, K230_SD1_BASE, buffer,
> +                            sizeof(read_data)) == sizeof(read_data));
> +    g_assert(memcmp(buffer, read_data, sizeof(read_data)) == 0);
> +
> +    /* Write through SDHCI, then verify the data reached the backing image. */
> +    sdhci_write_cmd(qts, K230_SD1_BASE, write_data, sizeof(write_data),
> +                    K230_SD_TEST_BLOCK_SIZE);
> +    qtest_quit(qts);
> +
> +    fd = open(path, O_RDONLY);
> +    g_assert(fd >= 0);
> +    memset(buffer, 0, sizeof(buffer));
> +    g_assert(pread(fd, buffer, sizeof(write_data), 0) == sizeof(write_data));
> +    close(fd);
> +    g_assert(memcmp(buffer, write_data, sizeof(write_data)) == 0);
> +
> +    unlink(path);
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +    g_test_init(&argc, &argv, NULL);
> +
> +    qtest_add_func("/k230-sdhci/registers", test_registers);
> +    qtest_add_func("/k230-sdhci/card-detect", test_card_detect);
> +    qtest_add_func("/k230-sdhci/card-io", test_card_io);
> +
> +    return g_test_run();
> +}
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 56ff860e21..0600b1e807 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -297,7 +297,10 @@ qtests_riscv64 = ['riscv-csr-test'] + \
>     (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') and
>      config_all_devices.has_key('CONFIG_RISCV_IOMMU') ?
>      ['iommu-riscv-test'] : []) + \
> -  (config_all_devices.has_key('CONFIG_K230') ? ['k230-wdt-test'] : [])
> +  (config_all_devices.has_key('CONFIG_K230') ? [
> +    'k230-wdt-test',
> +    'k230-sdhci-test',
> +  ] : [])
>   
>   qtests_hexagon = ['boot-serial-test']
>   


