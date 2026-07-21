Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41350C44532
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 15:08:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmC4q-0002w1-KC; Tue, 21 Jul 2026 11:08:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wmC4o-0002uF-13
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 11:08:10 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wmC4j-0004Ue-VU
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 11:08:08 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LDgG8U1399813
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 15:08:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9OzkRurjKJbcihQ33q5FHvyCTx9Tr6zk5X9BBevs/fg=; b=WiNHR4kmljtWUgt2
 IiahOPWwobkqTbxpypz8QpQHX20soLPMIxG70wxS3mxnDbEjCyLFNF3YWhDe0Oj1
 tlvUf/bbwC01Zs/5wSfgaqH87hpQKrDaediswJhRQEeStDR+uV6uTEJpbuVwY0g5
 Qt7mA7xxlHEPrFICqjdjeu7IVVtXMJnzor4Tg9Lw3Fw1T3OOU/DXdsy9kcL2JJ3/
 d6zZ+f86NeFl3HzZ29Okh849EHLI1jaPPahuhkrgyKx3ZI8tCCsCzEg8qf85GWx+
 T6PR75DHZQnjNo+r9HByeAwRxWQDHBvBGXbmCRYRahmnIGWw77JUBpoILIp5qncX
 5wLyjA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj1es3312-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 15:08:02 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38dc085b0a7so17617899a91.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 08:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784646482; x=1785251282; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9OzkRurjKJbcihQ33q5FHvyCTx9Tr6zk5X9BBevs/fg=;
 b=QVThTig8/eCltN7arroWM9e6qxCDIF1LWrTtcFiQyNL7AFh+vDD248h9NrdMBYA7SM
 FxOsVuQ1S0v6Q9IBps0jKpMy40wcCQopOGwMFX57aksx/I2D6rwv6ucNHIafXj6blYNi
 nukhdQWmFb0SFKJTuFQgifV+T1Pd2RJINU4oU/pBT0l3J/VNir/MTM/gL8tePdYbC/kf
 r+8ucZpH4h+GCnOfvi219tfm2Tlw/e3y7HspKO0ecrHEnfkg520AKL3V5wLW7hqXP8iW
 fje9MUjJ+fLbuPToISinN4YYBkTab2foZGILR6LqdHA+lihKDt5VU+A9MJff4tdNXUd9
 YcZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784646482; x=1785251282;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9OzkRurjKJbcihQ33q5FHvyCTx9Tr6zk5X9BBevs/fg=;
 b=dZP34TDGgEGqt4+WBkyEufFEpVnRzJjshsRW2BOafuFnlxdALenJkRMdR/tLh1legj
 2FGuoWerIuSNsd8twXLGglGewg9wpJntJMWA9wV1j1634n5UwZPrfa28PmCgjDdvzr2l
 BSTwE9AdU94fH8fdsGYWNlq5+3dXAg6NsZp6clwVPVQve2DsFpMBuYHwuEauXr0kUJz7
 wzGawAAb+jWiI9rTzh4KYWWJRLCB9Z8CFsfUcpjD5T8hPkk4IbT1M8nRgfWSigygK4Qo
 tcmSYeJMoKy8thKKtyqLMKn6GBITFmUeLNHezmKmcMplebsJFWfP9ErvUCeuLdA8E7D+
 JKTw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpxJiRpNn2nBKir4iu9ThGbf8Vbc2KNFguHbizOsORLX2z68Q3La9VCZ/nQzer0ibYAKYP/iZ0ejLsr@nongnu.org
X-Gm-Message-State: AOJu0YwnYnrTB8lu2yhRYJ30GcwtPEiSnUP9ELbB6AiO2kqTkiHRuWpR
 85UN3OtPRiMHk6arIM9tn/SXU5JqiVHN9ambi5BZydLRYy8EVk6tYZwkFY47onqE5z9UBUvmxXG
 Ka02buwZQHhulijjBeAqIjaps+Je5k5gKrIn4t0ioB1Ct8X9/5kcMVX+F5Q==
X-Gm-Gg: AR+sD13++Kw9MiGWuJQGfYMzBSWAWJLX3OKD5SoIUVFmKK0dJj0P6XbnGFjaIch+3FA
 LHIIy082WeojUl/apbm9wyac9NBqtSTREQXa62XjV7vxjVjsjuGrWxwrTsW1HcqRE5dotwvObo6
 QIAUBV0lAbYv5goTIHkDeL7BgBDEPN5muG9ZFwDF7IQYUQ6G6tkFZTkbYRia+iTIzUvrzeHgGmm
 j3HVHJ2LFyPGHSyrzlYkPPcxdZSUP9HB0YfddnDMBldZCMD2KWE7zlj6L/eP4fe681oKojOE9MR
 AhA+sxvR2aSYT0z1ANg2tVR6rBmR6MRwRQ3XtUqedD/WY5icgJmNe5G+wAmhA9ABvQK/FioPT06
 uJqsaO52JIeiqCXI5ZpU1P4Ikfexw0VFhl186LoC0k/0ME5RzHmGNIHlm9ufkdT7YVw4y
X-Received: by 2002:a17:90b:2807:b0:37e:9e9:6ffc with SMTP id
 98e67ed59e1d1-38e4b532703mr19733652a91.25.1784646481569; 
 Tue, 21 Jul 2026 08:08:01 -0700 (PDT)
X-Received: by 2002:a17:90b:2807:b0:37e:9e9:6ffc with SMTP id
 98e67ed59e1d1-38e4b532703mr19733600a91.25.1784646480942; 
 Tue, 21 Jul 2026 08:08:00 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13ce2a129f3sm38526814c88.7.2026.07.21.08.07.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 08:08:00 -0700 (PDT)
Message-ID: <2b79064b-2cc4-4f29-afba-964db80d7652@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 08:07:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] tests/qtest: add qct-qtimer qtest
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: philmd@oss.qualcomm.com, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 matheus.bernardino@oss.qualcomm.com
References: <20260718013241.1550124-1-brian.cain@oss.qualcomm.com>
 <20260718013241.1550124-4-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260718013241.1550124-4-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=SPZykuvH c=1 sm=1 tr=0 ts=6a5f8b52 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=w0l9nLhl7B5hx7oss10A:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: xTFL5bcSP4vNsStRB7DJux8gQ_p6hZy6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDE2MCBTYWx0ZWRfXyUR3lCRVZYAo
 QDlA8Dnnut9CwclzlMnD6X5u+uszYnUGEI0rxsIws4y+f4oCr5DSFOtJKOM84XhxSu7kcoQWcte
 wAueSIVHyVFluxd+WicR2IC0wBPsYQfB6zc1ob4WSSQlaRdyoqX5wE5WqP0BeBIFE18iEX03Dff
 mPnISNMxc6HVsSvrvbmocLV6PJsbbCQXONfPD62NnMLt0Lf3Bj3vBpdOxl03pdsZcdaD6/ddY/c
 bPYog0YnxgSvSew5nxIKpmbts5zPRAj/n+pl4PanY8Y5kxIDa38vXskhaIi+bpSVQ5sDw1d/ZKt
 IS9kPbCRiuJGXuNcSXIM3D+VlqwQAuoLzqJHaJ/r42GFkGbmxaijEQ8Xk05iV4/hTFOtdChHIeP
 L6Whdt7GMnJSI6IwSV2kLUZXqNGAwd6JSqtg1jDRjjClc7jh7bjMxPKZ272vLV74Dny6EQPs17x
 5mQErbshB7fXzz7SM9w==
X-Proofpoint-ORIG-GUID: xTFL5bcSP4vNsStRB7DJux8gQ_p6hZy6
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDE2MCBTYWx0ZWRfX+4p44QUWfdEL
 GXtpoLSOKRZ7g4C37plsB5Wd4jGieTy0Xbt4bJ0iOBCOEny5nL5CBcBTZxSRLHjPQ2sWe7IJxDv
 En672luJImFlGlS2cFg+K3ayL4oKkjU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 suspectscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210160
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 7/17/2026 6:32 PM, Brian Cain wrote:
> Add a qtest exercising the QCT QTimer's register access, view-region
> frame addressing, and one-shot timer firing behavior.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  MAINTAINERS                   |   1 +
>  tests/qtest/qct-qtimer-test.c | 213 ++++++++++++++++++++++++++++++++++
>  tests/qtest/meson.build       |   2 +-
>  3 files changed, 215 insertions(+), 1 deletion(-)
>  create mode 100644 tests/qtest/qct-qtimer-test.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2c73705c727..94977c3be77 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -255,6 +255,7 @@ F: include/hw/intc/hex-l2vic.h
>  F: tests/qtest/l2vic-test.c
>  F: hw/timer/qct-qtimer.c
>  F: include/hw/timer/qct-qtimer.h
> +F: tests/qtest/qct-qtimer-test.c
>  X: target/hexagon/idef-parser/
>  X: target/hexagon/gen_idef_parser_funcs.py
>  F: linux-user/hexagon/
> diff --git a/tests/qtest/qct-qtimer-test.c b/tests/qtest/qct-qtimer-test.c
> new file mode 100644
> index 00000000000..146d98126ac
> --- /dev/null
> +++ b/tests/qtest/qct-qtimer-test.c
> @@ -0,0 +1,213 @@
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * QTest testcase for the QCT QTimer
> + */
> +
> +#include "qemu/osdep.h"
> +#include "libqtest-single.h"
> +#include "hw/timer/qct-qtimer.h"
> +#include "qemu/bitops.h"
> +
> +#define QTIMER_DEFAULT_FREQ_HZ 19200000ULL
> +#define QTIMER_VIEW_BASE 0xfc921000

Should this be properties, in case another sec maps this at a different
address/has different freq?

> +
> +#define TIMER_TEST_OFFSET 1000
> +/* TIMER_TEST_OFFSET ticks expressed in nanoseconds of QEMU_CLOCK_VIRTUAL */
> +#define TIMER_TEST_NS \
> +    ((TIMER_TEST_OFFSET * 1000000000ULL) / QTIMER_DEFAULT_FREQ_HZ)
> +
> +static uint32_t qtimer_read32(uint64_t base, uint32_t offset)
> +{
> +    return readl(base + offset);
> +}
> +
> +static void qtimer_write32(uint64_t base, uint32_t offset, uint32_t value)
> +{
> +    writel(base + offset, value);
> +}
> +
> +static uint64_t qtimer_read64(uint64_t base, uint32_t offset)
> +{
> +    uint32_t lo = qtimer_read32(base, offset);
> +    uint32_t hi = qtimer_read32(base, offset + 4);
> +
> +    return ((uint64_t)hi << 32) | lo;
> +}
> +
> +static void qtimer_write64(uint64_t base, uint32_t offset, uint64_t value)
> +{
> +    qtimer_write32(base, offset, extract64(value, 0, 32));
> +    qtimer_write32(base, offset + 4, extract64(value, 32, 32));
> +}
> +
> +/* Test basic device presence and register access */
> +static void test_qtimer_basic_access(void)
> +{
> +    uint32_t val;
> +
> +    val = qtimer_read32(QTIMER_VIEW_BASE, QCT_QTIMER_CNT_FREQ);
> +    g_assert_cmpuint(val, ==, QTIMER_DEFAULT_FREQ_HZ);
> +}
> +
> +/* Test multiple timer frames */
> +static void test_qtimer_multiple_frames(void)
> +{
> +    uint32_t val;
> +    uint64_t frame0_base = QTIMER_VIEW_BASE;
> +    uint64_t frame1_base = QTIMER_VIEW_BASE + 0x1000;
> +
> +    val = qtimer_read32(frame0_base, QCT_QTIMER_CNT_FREQ);
> +    g_assert_cmpuint(val, ==, QTIMER_DEFAULT_FREQ_HZ);
> +
> +    val = qtimer_read32(frame1_base, QCT_QTIMER_CNT_FREQ);
> +    g_assert_cmpuint(val, ==, QTIMER_DEFAULT_FREQ_HZ);
> +}
> +
> +/* Test that registers exist and can be accessed */
> +static void test_qtimer_register_reads(void)
> +{
> +    qtimer_read32(QTIMER_VIEW_BASE, QCT_QTIMER_CNT_FREQ);
> +    qtimer_read64(QTIMER_VIEW_BASE, QCT_QTIMER_CNTPCT_LO);
> +    qtimer_read64(QTIMER_VIEW_BASE, QCT_QTIMER_CNTP_CVAL_LO);
> +    qtimer_read32(QTIMER_VIEW_BASE, QCT_QTIMER_CNTP_CTL);
> +    qtimer_read32(QTIMER_VIEW_BASE, QCT_QTIMER_CNTP_TVAL);
> +}
> +
> +/* Test timer control and value registers */
> +static void test_qtimer_control_registers(void)
> +{
> +    uint32_t ctl_val;
> +    uint64_t cval_before, cval_after;
> +
> +    cval_before = qtimer_read64(QTIMER_VIEW_BASE, QCT_QTIMER_CNTPCT_LO);
> +
> +    qtimer_write32(QTIMER_VIEW_BASE, QCT_QTIMER_CNTP_TVAL, 1000);
> +
> +    qtimer_write32(QTIMER_VIEW_BASE, QCT_QTIMER_CNTP_CTL, 1);
> +    ctl_val = qtimer_read32(QTIMER_VIEW_BASE, QCT_QTIMER_CNTP_CTL);
> +    if (ctl_val & 1) {
> +        g_assert_cmpuint(ctl_val & 1, ==, 1);
> +    }

Seems like this if can be reduced to:
g_assert(ctl_val)?

> +
> +    /* CVAL should be greater than before since we set TVAL */
> +    cval_after = qtimer_read64(QTIMER_VIEW_BASE, QCT_QTIMER_CNTP_CVAL_LO);
> +    g_assert_cmpuint(cval_after, >, cval_before);
> +
> +    qtimer_write32(QTIMER_VIEW_BASE, QCT_QTIMER_CNTP_CTL, 0);
> +    ctl_val = qtimer_read32(QTIMER_VIEW_BASE, QCT_QTIMER_CNTP_CTL);
> +    g_assert_cmpuint(ctl_val & 1, ==, 0);
> +}
> +
> +/* Test CVAL register direct access */
> +static void test_qtimer_cval_access(void)
> +{
> +    uint64_t current_time, test_cval, read_cval;
> +
> +    current_time = qtimer_read64(QTIMER_VIEW_BASE, QCT_QTIMER_CNTPCT_LO);
> +    test_cval = current_time + 10000;
> +
> +    qtimer_write64(QTIMER_VIEW_BASE, QCT_QTIMER_CNTP_CVAL_LO, test_cval);
> +    read_cval = qtimer_read64(QTIMER_VIEW_BASE, QCT_QTIMER_CNTP_CVAL_LO);
> +    g_assert_cmpuint(read_cval, ==, test_cval);
> +}
> +
> +/* Test counter progression */
> +static void test_qtimer_counter_progression(void)
> +{
> +    uint32_t freq;
> +    uint64_t count1, count2;
> +
> +    /*
> +     * In qtest mode the virtual clock does not advance on its own, so
> +     * reading the counter twice must give the same value.
> +     */
> +    count1 = qtimer_read64(QTIMER_VIEW_BASE, QCT_QTIMER_CNTPCT_LO);
> +    count2 = qtimer_read64(QTIMER_VIEW_BASE, QCT_QTIMER_CNTPCT_LO);
> +    g_assert_cmpuint(count2, ==, count1);
> +
> +    freq = qtimer_read32(QTIMER_VIEW_BASE, QCT_QTIMER_CNT_FREQ);
> +    g_assert_cmpuint(freq, ==, QTIMER_DEFAULT_FREQ_HZ);
> +}
> +
> +/* Test timer behavior with clock control */
> +static void test_qtimer_timer_behavior(void)
> +{
> +    uint64_t current_count, target_count, read_cval, new_count;
> +    uint64_t ctl_val, count_after_disable;
> +
> +    current_count = qtimer_read64(QTIMER_VIEW_BASE, QCT_QTIMER_CNTPCT_LO);
> +
> +    target_count = current_count + TIMER_TEST_OFFSET;
> +    qtimer_write64(QTIMER_VIEW_BASE, QCT_QTIMER_CNTP_CVAL_LO, target_count);
> +
> +    read_cval = qtimer_read64(QTIMER_VIEW_BASE, QCT_QTIMER_CNTP_CVAL_LO);
> +    g_assert_cmpuint(read_cval, ==, target_count);
> +
> +    qtimer_write32(QTIMER_VIEW_BASE, QCT_QTIMER_CNTP_CTL, 1);
> +
> +    ctl_val = qtimer_read64(QTIMER_VIEW_BASE, QCT_QTIMER_CNTP_CTL);
> +    /* EN set, IMASK clear, ISTAT not yet pending */
> +    g_assert_cmpuint(ctl_val, ==, 0x1);
> +
> +    /* Step forward but not past the target */
> +    qtest_clock_step(global_qtest, TIMER_TEST_NS / 2);
> +    new_count = qtimer_read64(QTIMER_VIEW_BASE, QCT_QTIMER_CNTPCT_LO);
> +    g_assert_cmpuint(new_count, >=, current_count);
> +
> +    /* Step past the target */
> +    qtest_clock_step(global_qtest, TIMER_TEST_NS);
> +    new_count = qtimer_read64(QTIMER_VIEW_BASE, QCT_QTIMER_CNTPCT_LO);
> +    g_assert_cmpuint(new_count, >=, target_count);
> +
> +    qtimer_write32(QTIMER_VIEW_BASE, QCT_QTIMER_CNTP_CTL, 0);
> +
> +    ctl_val = qtimer_read64(QTIMER_VIEW_BASE, QCT_QTIMER_CNTP_CTL);
> +    /* EN cleared, ISTAT set since new_count >= target_count */
> +    g_assert_cmpuint(ctl_val, ==, 0x4);
> +
> +    /*
> +     * CNTPCT runs independently of CNTP_CTL.EN: only the compare/IRQ
> +     * logic is gated by EN, so the counter must keep advancing.
> +     */
> +    qtest_clock_step(global_qtest, TIMER_TEST_NS / 2);
> +    count_after_disable = qtimer_read64(QTIMER_VIEW_BASE,
> +                                        QCT_QTIMER_CNTPCT_LO);
> +    g_assert_cmpuint(count_after_disable, >, new_count);
> +
> +    /* ISTAT remains set while CNTPCT >= CVAL, even with EN=0 */
> +    ctl_val = qtimer_read64(QTIMER_VIEW_BASE, QCT_QTIMER_CNTP_CTL);
> +    g_assert_cmpuint(ctl_val, ==, 0x4);
> +}
> +
> +static void test_qtimer_on_machine(gconstpointer data)
> +{
> +    const char *machine = (const char *)data;
> +    g_autofree char *args = g_strdup_printf(
> +        "-machine %s -global qct-qtimer.freq-scale=1", machine);
> +
> +    qtest_start(args);
> +
> +    test_qtimer_basic_access();
> +    test_qtimer_multiple_frames();
> +    test_qtimer_register_reads();
> +    test_qtimer_control_registers();
> +    test_qtimer_cval_access();
> +    test_qtimer_counter_progression();
> +    test_qtimer_timer_behavior();
> +
> +    qtest_end();
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    g_test_init(&argc, &argv, NULL);
> +
> +    qtest_add_data_func("/qct-qtimer/virt/all-tests", "virt",
> +                        test_qtimer_on_machine);
> +    qtest_add_data_func("/qct-qtimer/V66G_1024/all-tests", "V66G_1024",
> +                        test_qtimer_on_machine);
> +
> +    return g_test_run();
> +}
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index a76863c7dd6..651246b2ebb 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -299,7 +299,7 @@ qtests_riscv64 = ['riscv-csr-test'] + \
>     ['iommu-riscv-test'] : []) + \
>    (config_all_devices.has_key('CONFIG_K230') ? ['k230-wdt-test'] : [])
>  
> -qtests_hexagon = ['boot-serial-test', 'l2vic-test']
> +qtests_hexagon = ['boot-serial-test', 'l2vic-test', 'qct-qtimer-test']
>  
>  qos_test_ss = ss.source_set()
>  qos_test_ss.add(


