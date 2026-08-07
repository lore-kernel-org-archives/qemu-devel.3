Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35CD2C5AC7A
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 16:40:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsNcL-00017h-7R; Fri, 07 Aug 2026 12:40:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wsNcJ-000179-1W
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 12:40:19 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wsNcG-0003l8-Rb
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 12:40:18 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 677GOAQM2039836
 for <qemu-devel@nongnu.org>; Fri, 7 Aug 2026 16:40:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +jCmurvZ9olvhTuKi7fdT5IwQS+I8EnBOs0xrshh6FM=; b=bdnARS+SCP5o7pK3
 ePhoxFbgTNn6Yo5KCezyBiKKT025rrjeI7g1DKcaSvaabjR/8skeY0CfMMPTXhaN
 VWoe1fGaTysxjsOr7U+ps8gHVjVQ1eS56z37G6j3SO4TuqTHBZMUTZSOd/yJDeUF
 Hwd6hc5vN6NLFVKRWKIavcoVqKmKkyiR6dUletGIEqPiyKo+mjckZAC6NoOQlnrq
 XF/8XjD1VqjvTR26Jbh51rEuvraVWKNaRe1/YXA3v/v0LiaKCvpTojQ7+f3ICmX4
 Hf+JaKAJaW8WJkQbOXBBukN9C6P9VI9nHTmP/NSduFw3pp7BCvDR4jOpYcmCoc4C
 1a+uXw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwcjb1qqt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 16:40:15 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8ee593a5a2fso29020126d6.1
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 09:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786120809; x=1786725609; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+jCmurvZ9olvhTuKi7fdT5IwQS+I8EnBOs0xrshh6FM=;
 b=dnUePgNVowYwgu0NXhtx5bL96xNy9Jp8/vUVPQaaQTIlQu4UJgO+hqwhQt4eZrNxXn
 uwe6YEV/UwJz2/GDq8I7VvoV8FQ/0CBVtBRWyB75DA8V9NI05ZENlsR+pJjky4e62qPb
 tcs76c0wdc0wJZwx1jl0nk+y6sL0topIDpUKFM5sYm2NCyIb63PQBPFGvZe4MxT53C1M
 BuEjimWGDP/8M0nCvL81B9QFaGcF04lWpArZW8QIfTlK8Ui8VlUiFc5chI8KOxNR/ICO
 V436JkkXfb5cbKDoqroNe05pcmh3u227slRq0FUu0+PEtbMRwkFccbUz6OpLC6VCg6+r
 UvWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786120809; x=1786725609;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+jCmurvZ9olvhTuKi7fdT5IwQS+I8EnBOs0xrshh6FM=;
 b=m61Ix6UruUReJRs+SbrGJZx2L6LHVgJ/IcX+IpmoJjt4WwOoifjgEFS1mu51rhr1nT
 hZ6e7brg/y4TooeVUllaIIRoc+5BDVDC/lSZwbXFxtZJkwq18FLOiq0xlD+L0yNe0TRx
 fjXofO6MfX5jUfV+WJj+7J/ULT2XnBV44NTzHh+3hxtSQgXWgY86yqKHbR8cMvr7/CjC
 lxi9apNw43X6Y+36+BThw8QxtCTyOzkk46rZrW4Zs4ndmaDN1Zqy6kE/gB5BPlpsweIK
 HbIXP0EP+BGk+7R0CeNoRGd6vSZ58PlDgXyZcSWr92bGibnPf3cTEx49GWb/Ee0OjEPi
 ysqA==
X-Gm-Message-State: AOJu0YxLhXcmugJ9Y6ZLGIoohlB66EDxHHy13BsKAXB6uoLigsbMh90t
 nfQbXogQqVF1Gi2uUCp4mGQAafj3a81VQ0lPQ6c69unDg/ThHQ32FwWFscEzoj+b5OIrCBdEq9V
 ho/9ru5k1ey/Z+TFo8QAGaumDGXKVXGu7mVJPic90LaDFe+9NXTB1gp/S2A==
X-Gm-Gg: AR+sD10V7reZv3XMWALmuoDlxAQq27JxU4SGR4fP2Uq5kl7a5eZQvTvxb1ON6fm5ETc
 TIoqSsAhXdSG8+7wCrqbP1A0Rkbw0gMlR57kjicQnwQ7lw4vsyrPp6HcDrDFJ5qX0DlDAoMz6Pi
 Lvl65QWorLjjTjm/YbBNAP5FpF8wTXvIfcEcMCSpkGt3BKZClC8Qyq9M30ijcQo4JkBfP5QoYil
 7jT/Iof0xR5/6zr9enppYagkKQ4BquC2uzDVVosaC8o/vQ/QOddrhH+0hPWZjuMGaAtgx1VTi8d
 GrfitwTunjp09RKLzxFDRHC+t1isZTjr8pmSNfZEkjbxi03p5zgdDDEE3pHjZ4ON24+XrOSnF4Z
 AkvPah1YNXhqo2b80sOib3fMDPhWLe4Pp7vtP
X-Received: by 2002:a05:6214:19ea:b0:907:785e:61a6 with SMTP id
 6a1803df08f44-90a34f425a0mr11846826d6.16.1786120809372; 
 Fri, 07 Aug 2026 09:40:09 -0700 (PDT)
X-Received: by 2002:a05:6214:19ea:b0:907:785e:61a6 with SMTP id
 6a1803df08f44-90a34f425a0mr11845946d6.16.1786120808748; 
 Fri, 07 Aug 2026 09:40:08 -0700 (PDT)
Received: from [192.168.68.104] ([187.11.154.152])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-908a9331213sm12243406d6.41.2026.08.07.09.40.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Aug 2026 09:40:08 -0700 (PDT)
Message-ID: <ff21d3e7-06e9-4f37-b30c-14c07b0fb06c@oss.qualcomm.com>
Date: Fri, 7 Aug 2026 13:40:04 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] tests/qtest: add K230 I2C controller tests
To: Wang Zhongyu <wzy15515798875@gmail.com>,
 Chao Liu <chao.liu@processmission.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20260807152830.6833-1-wzy15515798875@gmail.com>
 <20260807152830.6833-4-wzy15515798875@gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260807152830.6833-4-wzy15515798875@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDEzMCBTYWx0ZWRfX3DlmRbfnxZ/C
 NSJCaTsG5SBsUtn+YxtG9Q4M40QJKocF/d7LA+nmgOVBU3icYqQG4cKFQZlyD6DE1aqfhugyeIM
 hbRJimZZbAtFQiEXOLYhLKmRUVc2HRv2myUUxdE4kZ68ajXSXhDLrvW5EeTpZNE2BeNNQploAIj
 eoA5K6nyTpBV5vnz0Cj1gW85VGrVK/UkDlg0mbSg1xvDNclagNon+3XBLF9HGsFDQJaE/XXI3MZ
 vVN2wsAF5FxIkH7uzyRYWnIRU7ZH0sYBTGpoPttRjLqPlNCBPbOV9tT7N8FpQOmngAx2ExVr9FS
 xM2HAfQWm2M8Y1P4vFkf+y3WK9SXU9O6x9wLGC8i65MndWv+RlbTKKMG8J80r4OClp5maiacW8I
 PaxPdzX3dGpKhO6bv3Hoj0jL/Q+f6BNfHoGE7kLBqc3+Av1usOW2WfaIcTyinEp9Rej7fA+SFeZ
 89/nZpvOiZDA9KcueAg==
X-Authority-Analysis: v=2.4 cv=QsBuG1yd c=1 sm=1 tr=0 ts=6a760a6f cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=iMfxv9gflPUPBcmW7/Gq5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=FJ9iTOcQHNM-PfJOvhsA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDEzMCBTYWx0ZWRfX2YU33zS2BU4U
 4HtKXv/6ZsGK5/ur7OM5JtIoQWEX2WX3hjJJkrro62aaKJbR9hT2KsxUEvdlooi0mJluc9DjgS3
 rWsaK/koS0d6rywTKuooo2l99NWjLEo=
X-Proofpoint-ORIG-GUID: 7erpHrnzRJT1hgzNViQClnCS8tLy58gW
X-Proofpoint-GUID: 7erpHrnzRJT1hgzNViQClnCS8tLy58gW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608070130
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



On 8/7/2026 12:28 PM, Wang Zhongyu wrote:
> Add qtests covering reset values, all five controller instances,
> register access and locking, enable and disable behavior, interrupt
> masking, RX underflow, and address NACK reporting.
> 
> Signed-off-by: Wang Zhongyu <wzy15515798875@gmail.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   MAINTAINERS                 |   1 +
>   tests/qtest/k230-i2c-test.c | 335 ++++++++++++++++++++++++++++++++++++
>   tests/qtest/meson.build     |   2 +-
>   3 files changed, 337 insertions(+), 1 deletion(-)
>   create mode 100644 tests/qtest/k230-i2c-test.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ac61054dd1..d0053441a2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1834,6 +1834,7 @@ F: include/hw/i2c/k230_i2c.h
>   F: include/hw/riscv/k230.h
>   F: include/hw/watchdog/k230_wdt.h
>   F: tests/functional/riscv64/test_k230.py
> +F: tests/qtest/k230-i2c-test.c
>   F: tests/qtest/k230-wdt-test.c
>   
>   RX Machines
> diff --git a/tests/qtest/k230-i2c-test.c b/tests/qtest/k230-i2c-test.c
> new file mode 100644
> index 0000000000..cc8dd54153
> --- /dev/null
> +++ b/tests/qtest/k230-i2c-test.c
> @@ -0,0 +1,335 @@
> +/*
> + * QTest testcase for K230 DesignWare I2C controller
> + *
> + * Copyright (c) 2026 Wang Zhongyu <wzy15515798875@gmail.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "libqtest.h"
> +#include "qemu/bitops.h"
> +
> +/* K230 I2C controller base addresses */
> +#define K230_I2C0_BASE                 0x91405000
> +#define K230_I2C1_BASE                 0x91406000
> +#define K230_I2C2_BASE                 0x91407000
> +#define K230_I2C3_BASE                 0x91408000
> +#define K230_I2C4_BASE                 0x91409000
> +
> +#define K230_I2C_COUNT                 5
> +
> +/* Register offsets used by the tests */
> +#define K230_IC_CON                    0x00
> +#define K230_IC_TAR                    0x04
> +#define K230_IC_SAR                    0x08
> +#define K230_IC_HS_MADDR               0x0c
> +#define K230_IC_DATA_CMD               0x10
> +#define K230_IC_INTR_STAT              0x2c
> +#define K230_IC_INTR_MASK              0x30
> +#define K230_IC_RAW_INTR_STAT          0x34
> +#define K230_IC_RX_TL                  0x38
> +#define K230_IC_TX_TL                  0x3c
> +#define K230_IC_CLR_RX_UNDER           0x44
> +#define K230_IC_CLR_TX_ABRT            0x54
> +#define K230_IC_ENABLE                 0x6c
> +#define K230_IC_STATUS                 0x70
> +#define K230_IC_TXFLR                  0x74
> +#define K230_IC_RXFLR                  0x78
> +#define K230_IC_TX_ABRT_SOURCE         0x80
> +#define K230_IC_ENABLE_STATUS          0x9c
> +#define K230_IC_COMP_PARAM_1           0xf4
> +#define K230_IC_COMP_VERSION           0xf8
> +#define K230_IC_COMP_TYPE              0xfc
> +
> +#define IC_CON_10BITADDR_MASTER        BIT(4)
> +
> +/* IC_DATA_CMD */
> +#define IC_DATA_CMD_STOP               BIT(9)
> +
> +/* IC_INTR_STAT and IC_RAW_INTR_STAT */
> +#define IC_INTR_RX_UNDER               BIT(0)
> +#define IC_INTR_TX_EMPTY               BIT(4)
> +#define IC_INTR_TX_ABRT                BIT(6)
> +
> +/* IC_STATUS */
> +#define IC_STATUS_TFNF                 BIT(1)
> +#define IC_STATUS_TFE                  BIT(2)
> +
> +/* IC_TX_ABRT_SOURCE */
> +#define IC_ABRT_7B_ADDR_NOACK          BIT(0)
> +
> +#define K230_IC_COMP_PARAM_1_VALUE     0x001f3fae
> +#define K230_IC_COMP_VERSION_VALUE     0x3132302a
> +#define K230_IC_COMP_TYPE_VALUE        0x44570140
> +
> +static const uint64_t k230_i2c_base[K230_I2C_COUNT] = {
> +    K230_I2C0_BASE,
> +    K230_I2C1_BASE,
> +    K230_I2C2_BASE,
> +    K230_I2C3_BASE,
> +    K230_I2C4_BASE,
> +};
> +
> +static void test_reset_values(void)
> +{
> +    QTestState *qts = qtest_init("-machine k230");
> +    uint32_t status;
> +
> +    g_assert_cmphex(qtest_readl(qts, K230_I2C0_BASE + K230_IC_CON),
> +                    ==, 0x7f);
> +    g_assert_cmphex(qtest_readl(qts, K230_I2C0_BASE + K230_IC_TAR),
> +                    ==, 0x55);
> +    g_assert_cmphex(qtest_readl(qts, K230_I2C0_BASE + K230_IC_SAR),
> +                    ==, 0x55);
> +    g_assert_cmphex(qtest_readl(qts,
> +                               K230_I2C0_BASE + K230_IC_HS_MADDR),
> +                    ==, 0x1);
> +
> +    g_assert_cmphex(qtest_readl(qts, K230_I2C0_BASE + K230_IC_ENABLE),
> +                    ==, 0);
> +    g_assert_cmphex(qtest_readl(qts,
> +                               K230_I2C0_BASE + K230_IC_ENABLE_STATUS),
> +                    ==, 0);
> +
> +    g_assert_cmphex(qtest_readl(qts, K230_I2C0_BASE + K230_IC_TXFLR),
> +                    ==, 0);
> +    g_assert_cmphex(qtest_readl(qts, K230_I2C0_BASE + K230_IC_RXFLR),
> +                    ==, 0);
> +
> +    status = qtest_readl(qts, K230_I2C0_BASE + K230_IC_STATUS);
> +    g_assert_cmphex(status, ==, IC_STATUS_TFNF | IC_STATUS_TFE);
> +
> +    g_assert_cmphex(qtest_readl(qts,
> +                               K230_I2C0_BASE + K230_IC_RAW_INTR_STAT),
> +                    ==, 0);
> +
> +    g_assert_cmphex(qtest_readl(qts,
> +                               K230_I2C0_BASE + K230_IC_COMP_PARAM_1),
> +                    ==, K230_IC_COMP_PARAM_1_VALUE);
> +    g_assert_cmphex(qtest_readl(qts,
> +                               K230_I2C0_BASE + K230_IC_COMP_VERSION),
> +                    ==, K230_IC_COMP_VERSION_VALUE);
> +    g_assert_cmphex(qtest_readl(qts,
> +                               K230_I2C0_BASE + K230_IC_COMP_TYPE),
> +                    ==, K230_IC_COMP_TYPE_VALUE);
> +
> +    qtest_quit(qts);
> +}
> +
> +static void test_all_instances(void)
> +{
> +    QTestState *qts = qtest_init("-machine k230");
> +
> +    for (int i = 0; i < K230_I2C_COUNT; i++) {
> +        g_assert_cmphex(qtest_readl(qts,
> +                                   k230_i2c_base[i] +
> +                                   K230_IC_COMP_TYPE),
> +                        ==, K230_IC_COMP_TYPE_VALUE);
> +    }
> +
> +    qtest_quit(qts);
> +}
> +
> +static void test_register_access(void)
> +{
> +    QTestState *qts = qtest_init("-machine k230");
> +
> +    qtest_writel(qts, K230_I2C0_BASE + K230_IC_CON, UINT32_MAX);
> +    g_assert_cmphex(qtest_readl(qts, K230_I2C0_BASE + K230_IC_CON),
> +                    ==, 0x7f);
> +
> +    qtest_writel(qts, K230_I2C0_BASE + K230_IC_TAR, UINT32_MAX);
> +    g_assert_cmphex(qtest_readl(qts, K230_I2C0_BASE + K230_IC_TAR),
> +                    ==, 0xfff);
> +
> +    qtest_writel(qts, K230_I2C0_BASE + K230_IC_SAR, UINT32_MAX);
> +    g_assert_cmphex(qtest_readl(qts, K230_I2C0_BASE + K230_IC_SAR),
> +                    ==, 0x3ff);
> +
> +    qtest_writel(qts, K230_I2C0_BASE + K230_IC_HS_MADDR,
> +                 UINT32_MAX);
> +    g_assert_cmphex(qtest_readl(qts,
> +                               K230_I2C0_BASE + K230_IC_HS_MADDR),
> +                    ==, 0x7);
> +
> +    qtest_writel(qts, K230_I2C0_BASE + K230_IC_RX_TL,
> +                 UINT32_MAX);
> +    g_assert_cmphex(qtest_readl(qts, K230_I2C0_BASE + K230_IC_RX_TL),
> +                    ==, 63);
> +
> +    qtest_writel(qts, K230_I2C0_BASE + K230_IC_TX_TL,
> +                 UINT32_MAX);
> +    g_assert_cmphex(qtest_readl(qts, K230_I2C0_BASE + K230_IC_TX_TL),
> +                    ==, 32);
> +
> +    qtest_quit(qts);
> +}
> +
> +static void test_register_lock_while_enabled(void)
> +{
> +    QTestState *qts = qtest_init("-machine k230");
> +
> +    qtest_writel(qts, K230_I2C0_BASE + K230_IC_TAR, 0x22);
> +    qtest_writel(qts, K230_I2C0_BASE + K230_IC_ENABLE, 1);
> +
> +    qtest_writel(qts, K230_I2C0_BASE + K230_IC_TAR, 0x33);
> +    qtest_writel(qts, K230_I2C0_BASE + K230_IC_CON, 0);
> +
> +    g_assert_cmphex(qtest_readl(qts, K230_I2C0_BASE + K230_IC_TAR),
> +                    ==, 0x22);
> +    g_assert_cmphex(qtest_readl(qts, K230_I2C0_BASE + K230_IC_CON),
> +                    ==, 0x7f);
> +
> +    qtest_quit(qts);
> +}
> +
> +static void test_enable_disable(void)
> +{
> +    QTestState *qts = qtest_init("-machine k230");
> +    uint32_t raw;
> +
> +    qtest_writel(qts, K230_I2C0_BASE + K230_IC_ENABLE, 1);
> +
> +    g_assert_cmphex(qtest_readl(qts, K230_I2C0_BASE + K230_IC_ENABLE),
> +                    ==, 1);
> +    g_assert_cmphex(qtest_readl(qts,
> +                               K230_I2C0_BASE + K230_IC_ENABLE_STATUS),
> +                    ==, 1);
> +
> +    raw = qtest_readl(qts,
> +                      K230_I2C0_BASE + K230_IC_RAW_INTR_STAT);
> +    g_assert_cmphex(raw & IC_INTR_TX_EMPTY, ==, IC_INTR_TX_EMPTY);
> +
> +    qtest_writel(qts, K230_I2C0_BASE + K230_IC_ENABLE, 0);
> +
> +    g_assert_cmphex(qtest_readl(qts, K230_I2C0_BASE + K230_IC_ENABLE),
> +                    ==, 0);
> +    g_assert_cmphex(qtest_readl(qts,
> +                               K230_I2C0_BASE + K230_IC_ENABLE_STATUS),
> +                    ==, 0);
> +
> +    raw = qtest_readl(qts,
> +                      K230_I2C0_BASE + K230_IC_RAW_INTR_STAT);
> +    g_assert_cmphex(raw & IC_INTR_TX_EMPTY, ==, 0);
> +
> +    qtest_quit(qts);
> +}
> +
> +static void test_interrupt_mask(void)
> +{
> +    QTestState *qts = qtest_init("-machine k230");
> +    uint32_t raw;
> +    uint32_t stat;
> +
> +    qtest_writel(qts, K230_I2C0_BASE + K230_IC_ENABLE, 1);
> +
> +    raw = qtest_readl(qts,
> +                      K230_I2C0_BASE + K230_IC_RAW_INTR_STAT);
> +    g_assert_cmphex(raw & IC_INTR_TX_EMPTY, ==, IC_INTR_TX_EMPTY);
> +
> +    qtest_writel(qts, K230_I2C0_BASE + K230_IC_INTR_MASK, 0);
> +
> +    stat = qtest_readl(qts, K230_I2C0_BASE + K230_IC_INTR_STAT);
> +    g_assert_cmphex(stat, ==, 0);
> +
> +    raw = qtest_readl(qts,
> +                      K230_I2C0_BASE + K230_IC_RAW_INTR_STAT);
> +    g_assert_cmphex(raw & IC_INTR_TX_EMPTY, ==, IC_INTR_TX_EMPTY);
> +
> +    qtest_writel(qts, K230_I2C0_BASE + K230_IC_INTR_MASK,
> +                 IC_INTR_TX_EMPTY);
> +
> +    stat = qtest_readl(qts, K230_I2C0_BASE + K230_IC_INTR_STAT);
> +    g_assert_cmphex(stat & IC_INTR_TX_EMPTY, ==, IC_INTR_TX_EMPTY);
> +
> +    qtest_quit(qts);
> +}
> +
> +static void test_rx_underflow(void)
> +{
> +    QTestState *qts = qtest_init("-machine k230");
> +    uint32_t raw;
> +
> +    g_assert_cmphex(qtest_readl(qts,
> +                               K230_I2C0_BASE + K230_IC_DATA_CMD),
> +                    ==, 0);
> +
> +    raw = qtest_readl(qts,
> +                      K230_I2C0_BASE + K230_IC_RAW_INTR_STAT);
> +    g_assert_cmphex(raw & IC_INTR_RX_UNDER, ==, IC_INTR_RX_UNDER);
> +
> +    qtest_readl(qts, K230_I2C0_BASE + K230_IC_CLR_RX_UNDER);
> +
> +    raw = qtest_readl(qts,
> +                      K230_I2C0_BASE + K230_IC_RAW_INTR_STAT);
> +    g_assert_cmphex(raw & IC_INTR_RX_UNDER, ==, 0);
> +
> +    qtest_quit(qts);
> +}
> +
> +static void test_address_nack(void)
> +{
> +    QTestState *qts = qtest_init("-machine k230");
> +    uint32_t con;
> +    uint32_t raw;
> +    uint32_t source;
> +
> +    /*
> +     * No slave is attached at address 0x7f, so the address phase
> +     * must terminate with TX_ABRT.
> +     */
> +    con = qtest_readl(qts, K230_I2C0_BASE + K230_IC_CON);
> +    con &= ~IC_CON_10BITADDR_MASTER;
> +    qtest_writel(qts, K230_I2C0_BASE + K230_IC_CON, con);
> +    qtest_writel(qts, K230_I2C0_BASE + K230_IC_TAR, 0x7f);
> +    qtest_writel(qts, K230_I2C0_BASE + K230_IC_ENABLE, 1);
> +
> +    qtest_writel(qts, K230_I2C0_BASE + K230_IC_DATA_CMD,
> +                 IC_DATA_CMD_STOP | 0x55);
> +
> +    raw = qtest_readl(qts,
> +                      K230_I2C0_BASE + K230_IC_RAW_INTR_STAT);
> +    source = qtest_readl(qts,
> +                         K230_I2C0_BASE + K230_IC_TX_ABRT_SOURCE);
> +
> +    g_assert_cmphex(raw & IC_INTR_TX_ABRT, ==, IC_INTR_TX_ABRT);
> +    g_assert_cmphex(source & IC_ABRT_7B_ADDR_NOACK,
> +                    ==, IC_ABRT_7B_ADDR_NOACK);
> +
> +    qtest_readl(qts, K230_I2C0_BASE + K230_IC_CLR_TX_ABRT);
> +
> +    raw = qtest_readl(qts,
> +                      K230_I2C0_BASE + K230_IC_RAW_INTR_STAT);
> +    source = qtest_readl(qts,
> +                         K230_I2C0_BASE + K230_IC_TX_ABRT_SOURCE);
> +
> +    g_assert_cmphex(raw & IC_INTR_TX_ABRT, ==, 0);
> +    g_assert_cmphex(source, ==, 0);
> +
> +    qtest_quit(qts);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    g_test_init(&argc, &argv, NULL);
> +
> +    qtest_add_func("/k230-i2c/reset-values",
> +                   test_reset_values);
> +    qtest_add_func("/k230-i2c/all-instances",
> +                   test_all_instances);
> +    qtest_add_func("/k230-i2c/register-access",
> +                   test_register_access);
> +    qtest_add_func("/k230-i2c/register-lock-while-enabled",
> +                   test_register_lock_while_enabled);
> +    qtest_add_func("/k230-i2c/enable-disable",
> +                   test_enable_disable);
> +    qtest_add_func("/k230-i2c/interrupt-mask",
> +                   test_interrupt_mask);
> +    qtest_add_func("/k230-i2c/rx-underflow",
> +                   test_rx_underflow);
> +    qtest_add_func("/k230-i2c/address-nack",
> +                   test_address_nack);
> +
> +    return g_test_run();
> +}
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 56ff860e21..56fb0af800 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -297,7 +297,7 @@ qtests_riscv64 = ['riscv-csr-test'] + \
>     (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') and
>      config_all_devices.has_key('CONFIG_RISCV_IOMMU') ?
>      ['iommu-riscv-test'] : []) + \
> -  (config_all_devices.has_key('CONFIG_K230') ? ['k230-wdt-test'] : [])
> +  (config_all_devices.has_key('CONFIG_K230') ? ['k230-wdt-test', 'k230-i2c-test'] : [])
>   
>   qtests_hexagon = ['boot-serial-test']
>   


