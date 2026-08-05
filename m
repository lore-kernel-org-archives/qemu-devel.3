Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87066C55ABF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 20:11:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrhwh-00064g-SI; Wed, 05 Aug 2026 16:10:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wrhwd-00061z-Ag
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 16:10:31 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wrhwZ-00075i-Vc
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 16:10:31 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 675HS0pZ3326266
 for <qemu-devel@nongnu.org>; Wed, 5 Aug 2026 20:10:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0liHBcA91bQSihYo5fL6Oh6Aa3hnHcsvXsi2zC4+8UA=; b=UX4r8LX68o4N3DKG
 1fb7+pXgZOSCn5rcASdqFBnln3JZXHCyDryNdn/RkMg4/pbHn5xmTrfTps4nP65l
 X2GkBCmmvSDxa32fFyXlxPfOAGZ0q84iTxDCwJc4REYeGupQW/cayMHvL+ldjU+g
 DhPOk7pqylO1p11DtIOXez3OTHFgnFgWMTl+pJbuDZEytdAW1Jm9AojEIqzFogfD
 G+YxE7QCzVB3KAbc7W5IU2dz2cbi/h7Hw5b2AQBqWDQdytMtdILZEFCvK9UEKBwU
 20ePTeJcZ3mAiA5D6ZY8gWeTUwrEq3MjHniNzcfpt9zF7PzwMAM4tNYsun8+EcH4
 Hwru4Q==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fv1qgb2uq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 20:10:24 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c1a9764f0so14767381cf.1
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 13:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785960624; x=1786565424; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0liHBcA91bQSihYo5fL6Oh6Aa3hnHcsvXsi2zC4+8UA=;
 b=XLiJmpHdLncQdUPJqRkxRSO40KBN+UQ/ONthFx+pGGyHiJLyXkX+1RaEqANtN3bz1r
 JehjqW+eBCEvhF0sAy5XpRQ6HeqYZO/lPW8jQPpVfLSblCBB/MYWXgunBmbrFntI7U+L
 Eie5aPfdkcFI2Spi5/g2NhmYUo4EsT9pWfJmcUGHLM7HpAKFxyZZND2JbiQ7VzBrFoeN
 U06dIHUPJ6el4SAT8TLOkKt4gy5zFfaa9Iq6so/+h8dnlUJHAb/pwTbi9PTW9oIe0B/L
 9c+sIxt2waxsm56HaB66V1Bf1eIEw5eNdTloBobgYGzuaV1f9564ZXT0zxeGECyStnTd
 ecrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785960624; x=1786565424;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0liHBcA91bQSihYo5fL6Oh6Aa3hnHcsvXsi2zC4+8UA=;
 b=YDQgxFarq47ZwTg1giuaqK+iq746ARvKOkC7C21DPE5QNDkPakOALPXSA5zDwBIjEy
 7HIb5Ir2rbluXMflSt+7MW544cLa35tDRgeMxsFPAV9vlv7ZE+MNqD+2bGozTDX2c8FF
 5f94t19gEd05RJq1C/ZtBxwwAg0QwMgGQL3bivZcNLxZJPlsA+R1QFStaFb9ctcCmWR2
 8DPnNzxC/6f0mgxk8EvBvzEn0+enEG35SBlsHNRKk1KedhP7enme75VEuuhZ1wInhEpZ
 o4PQEF0U2sBGYWGJENEyMag444NOroJNy6wEjANJWa8yU0mTfHAWc5sTl18jIbqwpqUR
 ZloA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrpigdIsV8FMYnznXuHH7hTKDP+ZMiuN1o4oBw6Wv4VSP8E960kzTKxkk6Ylh4BXAmAXhj3xZEwOKvO@nongnu.org
X-Gm-Message-State: AOJu0YyMLPbqGDDfbfLB6KKKVvg/7ZsbHWEvT4gau/+5hKXqfZPAgcbt
 f/eHQvBYRRO2F66DQvTP34weec03VB3JHNSdV+tm6O3zfZkM4CEAS0LktoZeY3TlPP9+75czvlh
 LpEBNlq7/Ycx6fSDsZf+iYSHmMhL/V7V6HkaSCKBYftWr+sKqeqiKMUmzhg==
X-Gm-Gg: AR+sD10mGwOgeFX6k4saMb7RHZfRRuo4qdJRMLojaJ9w3ZZkGep4qzK+yvAn48eFD2K
 OJgdAo42tAJl/50uBZ8pg2dNbhJ24o5H6v7uKLLKv0kBHOlb7vpozHKHToNqBlD9x5LEMiGBbSd
 +3wAGdmuKgF7QAsBwTsFYQXurPcI2o2QgSKAqPQXo0XH0b7MdUCoYDSGvdnoA5HqHYUWTd6ZShO
 uXA2+ndNT6647MPrntopeyfa1n+E621RWTiP2BHPPrcr5MdFm3rOOb9XS477a9A6W2gRfCbDMuv
 pDBFjkDjMqWS6+wdC99QEYGzSL9gwJPj9V95BCg0niIM+ZRS46bBrOkscNuW6VCgfUOD4dSCtKI
 owbumJPtkLTuXks7hE2FvPVqw3V1a+ZSWtibt
X-Received: by 2002:a05:622a:480a:b0:528:3b9b:4f50 with SMTP id
 d75a77b69052e-52ce5f8f69dmr101289291cf.9.1785960623496; 
 Wed, 05 Aug 2026 13:10:23 -0700 (PDT)
X-Received: by 2002:a05:622a:480a:b0:528:3b9b:4f50 with SMTP id
 d75a77b69052e-52ce5f8f69dmr101288511cf.9.1785960622951; 
 Wed, 05 Aug 2026 13:10:22 -0700 (PDT)
Received: from [192.168.68.104] ([187.11.154.152])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52ce87d2f6bsm27381551cf.10.2026.08.05.13.10.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Aug 2026 13:10:22 -0700 (PDT)
Message-ID: <af3d837c-e7f2-48ce-9b9c-c2ea9e4d8fb8@oss.qualcomm.com>
Date: Wed, 5 Aug 2026 17:10:17 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2 3/3] tests/qtest: add K230 UART test
To: WX Chen <wxchen0913@gmail.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
References: <20260725-feat-k230-uart-v2-v2-0-d5fe82c47c28@gmail.com>
 <20260725-feat-k230-uart-v2-v2-3-d5fe82c47c28@gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260725-feat-k230-uart-v2-v2-3-d5fe82c47c28@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=I+hVgtgg c=1 sm=1 tr=0 ts=6a7398b0 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=iMfxv9gflPUPBcmW7/Gq5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=pGLkceISAAAA:8 a=VxrKFGbl1GlyxEfYH6wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: 6kggNLh0JfrCQ5tBr1QHTumBRpVzPmcq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDE2NSBTYWx0ZWRfX1/ogoKUMMi7U
 PHI5mOy3IGm+2noyos0NeQZTNPvGnSoxXDriF8dDvX/pERLICg6nN4Id8Z/gX7LJGU0GQnzWTcC
 gFUJpTfcSFEfZ+2OZMOjgwHk7kEPlUkSNokiU+aVv0XuamUWE5HVmUVIX1iUDOKCubhqhNAxjnM
 f5++pK5THRSFmzV20doTJ1VwvY1St2dboG0ci1V13+mQVIYJ4QIBdm/cRlYa+6YqvMAc+TYuZEk
 lQpBjuiP7rQWuCfa4dcNDiRkAP2tvWyJESwcMY01bpHoHR3nrKr2pp0P9a3s6SlA/JwsBGHwaYU
 Fe9XOVM3t9mE1yvMbG6AzN/WOLUQsS6GkSzuKjYvIXG03pRp/fVNmNwTT76yximnhcEvyQ0tnXq
 WdsaejS3uaQTqIi77vanA8UXi6cojAlwK3gWyszxGN7r8LLo36iyKBoII/Tpo5Decy6qTx7jkUK
 8qHuAjmHPvggqrOLiAw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDE2NSBTYWx0ZWRfX7nOIh1phKPK3
 KpUlJjGGjbtXE4oAIRUQ7b0LxcxOHzuUPKH7H/Mhe8wgQafVKPC36txG7L6BDn7kpAT0YIZa9fk
 yYFk9nuaMVEqt6vgdAHD3LPbF4fnMLg=
X-Proofpoint-GUID: 6kggNLh0JfrCQ5tBr1QHTumBRpVzPmcq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_05,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050165
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



On 7/25/2026 12:52 AM, WX Chen wrote:
> Add 8 test cases covering the main register paths and driver usage
> scenarios: device probe, init & baud, TX/RX datapath, THRE interrupt,
> RX interrupts (timeout & trigger level), error interrupts & IIR
> priority, USR & busy detect, and advanced features (shadow registers,
> HTX, SRR, PTIME/TET).
> 
> All tests pass.
> 
> Signed-off-by: WX Chen <wxchen0913@gmail.com>
> ---

This also LGTM with a minor observation down there:



>   tests/qtest/k230-uart-test.c | 514 +++++++++++++++++++++++++++++++++++++++++++
>   tests/qtest/meson.build      |   2 +-
>   2 files changed, 515 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/k230-uart-test.c b/tests/qtest/k230-uart-test.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..f85c690ebb57abb5b7f753f36c06c0900c3cfbb9
> --- /dev/null
> +++ b/tests/qtest/k230-uart-test.c
> @@ -0,0 +1,514 @@
> +/*
> + * QTest for the K230 UART — functional-path coverage.
> + *
> + * Tests are organised around driver usage scenarios rather than
> + * enumerating every register in isolation.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "libqtest.h"
> +#include <string.h>
> +
> +#define UART_BASE  0x91400000
> +#define R(off)     (UART_BASE + (off))
> +
> +/* register offsets */
> +#define THR    0x00
> +#define IER    0x04
> +#define IIR    0x08
> +#define LCR    0x0c
> +#define MCR    0x10
> +#define LSR    0x14
> +#define SCR    0x1c
> +#define USR    0x7c
> +#define TFL    0x80
> +#define RFL    0x84
> +#define SRR    0x88
> +#define SRTS   0x8c
> +#define SBCR   0x90
> +#define SDMAM  0x94
> +#define SFE    0x98
> +#define SRT    0x9c
> +#define STET   0xa0
> +#define HTX    0xa4
> +#define CPR    0xf4
> +#define CTR    0xfc
> +
> +/* bit fields */
> +#define LCR_DLAB     0x80
> +#define LCR_BC       0x40
> +#define LCR_8N1      0x03
> +
> +#define LSR_DR       0x01
> +#define LSR_OE       0x02
> +#define LSR_THRE     0x20
> +#define LSR_TEMT     0x40
> +#define LSR_RESET    0x60
> +
> +#define IIR_IID      0x0f
> +#define IIR_NONE     0x01
> +#define IIR_THR      0x02
> +#define IIR_RX       0x04
> +#define IIR_LINE     0x06
> +#define IIR_BUSY     0x07
> +#define IIR_TO       0x0c
> +#define IIR_FF       0xc0
> +
> +#define IER_RX       0x01
> +#define IER_TX       0x02
> +#define IER_LS       0x04
> +#define IER_COLR     0x10
> +#define IER_PTIME    0x80
> +
> +#define MCR_LB       0x10
> +#define MCR_RTS      0x02
> +
> +#define FCR_FE       0x01
> +#define FCR_RR       0x02
> +#define FCR_XR       0x04
> +#define FCR_TET_H    (3 << 4)
> +#define FCR_RT_Q     (1 << 6)
> +#define FCR_RT_F     (3 << 6)
> +
> +#define USR_BUSY     0x01
> +#define USR_RESET    0x06
> +
> +#define SRR_UR       0x01
> +#define SRR_RFR      0x02
> +
> +/* helpers */
> +static uint32_t rd(QTestState *qts, uint32_t o)
> +{
> +    return qtest_readl(qts, R(o));
> +}
> +static uint32_t iid(QTestState *qts)
> +{
> +    return rd(qts, IIR) & IIR_IID;
> +}
> +
> +static void poll_lsr(QTestState *qts, uint32_t m)
> +{
> +    int i;
> +
> +    for (i = 0; i < 1000; i++) {
> +        if (rd(qts, LSR) & m) {
> +            return;
> +        }
> +        g_usleep(1000);

Any reason to use g_usleep() instead of qtest_clock_step()?  There are a couple
of g_usleep() uses in the code but you used lots of qtest_clock_step() too.

AFAIK g_usleep() is wall time and qtest_clock_step() is simulated time, and
I guess you should be using qtest_clock_step() for all the pollings you're
doing in this file.


Thanks,
Daniel


> +    }
> +    g_assert_not_reached();
> +}
> +
> +static void s1(QTestState *qts, int fd, char c)
> +{
> +    g_assert_cmpint(send(fd, &c, 1, 0), ==, 1);
> +    poll_lsr(qts, LSR_DR);
> +}
> +
> +static void sn(QTestState *qts, int fd, const char *d, int n)
> +{
> +    g_assert_cmpint(send(fd, d, n, 0), ==, n);
> +    poll_lsr(qts, LSR_DR);
> +}
> +
> +static void oe_nf(QTestState *qts, int fd)
> +{
> +    int i;
> +
> +    s1(qts, fd, 'A');
> +    {
> +        char c = 'B';
> +        g_assert_cmpint(send(fd, &c, 1, 0), ==, 1);
> +    }
> +    for (i = 0; i < 200; i++) {
> +        rd(qts, SCR);
> +        g_usleep(1000);
> +    }
> +}
> +
> +/* 1. device probe */
> +static void test_device_probe(void)
> +{
> +    QTestState *qts = qtest_init("-machine k230");
> +    uint32_t cpr = rd(qts, CPR);
> +
> +    g_assert_cmphex(cpr & 0x3, ==, 0x2);
> +    g_assert_cmphex(cpr & (1 << 5), ==, (1 << 5));
> +    g_assert_cmphex(cpr & (1 << 8), ==, (1 << 8));
> +    g_assert_cmphex((cpr >> 16) & 0xff, ==, 0x2);
> +    g_assert_cmphex(cpr & (1 << 4), ==, 0);
> +    g_assert_cmphex(rd(qts, CTR), ==, 0x44570110);
> +    g_assert_cmphex(rd(qts, LSR), ==, LSR_RESET);
> +    g_assert_cmphex(rd(qts, USR), ==, USR_RESET);
> +    g_assert_cmphex(iid(qts), ==, IIR_NONE);
> +    g_assert_cmphex(rd(qts, IIR) & IIR_FF, ==, 0);
> +    g_assert_cmphex(rd(qts, USR) & USR_BUSY, ==, 0);
> +
> +    qtest_writel(qts, R(IIR), FCR_FE);
> +    g_assert_cmphex(rd(qts, IIR) & IIR_FF, ==, IIR_FF);
> +    qtest_quit(qts);
> +}
> +
> +/* 2. init & baud */
> +static void test_init_and_baud(void)
> +{
> +    int fd;
> +    QTestState *qts = qtest_init_with_serial("-machine k230", &fd);
> +
> +    qtest_writel(qts, R(LCR), LCR_DLAB);
> +    qtest_writel(qts, R(THR), 0x55);
> +    g_assert_cmphex(rd(qts, THR), ==, 0x55);
> +    qtest_writel(qts, R(LCR), LCR_8N1);
> +    g_assert_cmphex(rd(qts, THR), ==, 0x00);
> +
> +    qtest_writel(qts, R(IIR), FCR_FE | FCR_RT_F);
> +    qtest_writel(qts, R(IER), IER_RX);
> +
> +    /* divisor=1 -> timeout=12800ns */
> +    qtest_writel(qts, R(LCR), LCR_8N1 | LCR_DLAB);
> +    qtest_writel(qts, R(THR), 1); qtest_writel(qts, R(IER), 0);
> +    qtest_writel(qts, R(LCR), LCR_8N1);
> +    s1(qts, fd, 'X');
> +    qtest_clock_step(qts, 13000);
> +    g_assert_cmphex(iid(qts), ==, IIR_TO);
> +
> +    /* divisor=100 -> timeout=1.28e6ns; 13000ns too short */
> +    rd(qts, THR);
> +    qtest_writel(qts, R(LCR), LCR_8N1 | LCR_DLAB);
> +    qtest_writel(qts, R(THR), 100); qtest_writel(qts, R(IER), 0);
> +    qtest_writel(qts, R(LCR), LCR_8N1);
> +    s1(qts, fd, 'Y');
> +    qtest_clock_step(qts, 13000);
> +    g_assert_cmphex(iid(qts), !=, IIR_TO);
> +    qtest_clock_step(qts, 1300000);
> +    g_assert_cmphex(iid(qts), ==, IIR_TO);
> +
> +    close(fd); qtest_quit(qts);
> +}
> +
> +/* 3. TX / RX datapath */
> +static void test_tx_rx_datapath(void)
> +{
> +    int fd;
> +    QTestState *qts = qtest_init_with_serial("-machine k230", &fd);
> +
> +    qtest_writel(qts, R(LCR), LCR_8N1);
> +    g_assert_cmphex(rd(qts, LSR) & (LSR_THRE | LSR_TEMT),
> +                    ==, LSR_THRE | LSR_TEMT);
> +    qtest_writel(qts, R(THR), 'A');
> +    g_assert_cmphex(rd(qts, LSR) & (LSR_THRE | LSR_TEMT),
> +                    ==, LSR_THRE | LSR_TEMT);
> +
> +    /* external RX (FIFO mode) */
> +    qtest_writel(qts, R(IIR), FCR_FE);
> +    qtest_writel(qts, R(IER), IER_RX);
> +    sn(qts, fd, "K230", 4);
> +    for (int i = 0; i < 4; i++) {
> +        if (i < 3) {
> +            g_assert_cmphex(iid(qts), ==, IIR_RX);
> +        }
> +        g_assert_cmphex(rd(qts, THR), ==, "K230"[i]);
> +    }
> +    g_assert_cmphex(rd(qts, LSR) & LSR_DR, ==, 0);
> +
> +    /* loopback */
> +    qtest_writel(qts, R(MCR), MCR_LB);
> +    qtest_writel(qts, R(THR), 'L');
> +    g_assert_cmphex(rd(qts, THR), ==, 'L');
> +    g_assert_cmphex(rd(qts, LSR) & LSR_DR, ==, 0);
> +
> +    /* no loopback */
> +    qtest_writel(qts, R(MCR), 0);
> +    qtest_writel(qts, R(THR), 'Z');
> +    g_assert_cmphex(rd(qts, LSR) & LSR_DR, ==, 0);
> +
> +    /* TFL / RFL */
> +    qtest_writel(qts, R(MCR), MCR_LB);
> +    qtest_writel(qts, R(IIR), FCR_FE | FCR_RR | FCR_XR);
> +    qtest_writel(qts, R(THR), 'X'); qtest_writel(qts, R(THR), 'Y');
> +    g_assert_cmphex(rd(qts, TFL), ==, 0);
> +    g_assert_cmphex(rd(qts, RFL), ==, 2);
> +
> +    /* non-FIFO mode */
> +    qtest_writel(qts, R(MCR), 0);
> +    qtest_writel(qts, R(IIR), 0);
> +    s1(qts, fd, 'N');
> +    g_assert_cmphex(rd(qts, THR), ==, 'N');
> +    g_assert_cmphex(rd(qts, LSR) & LSR_DR, ==, 0);
> +
> +    /* non-FIFO overrun */
> +    int i;
> +    s1(qts, fd, 'n');
> +    g_assert_cmphex(rd(qts, LSR) & LSR_DR, ==, LSR_DR);
> +    {
> +        char c = 'o';
> +        send(fd, &c, 1, 0);
> +    }
> +    for (i = 0; i < 200; i++) {
> +        rd(qts, SCR);
> +        g_usleep(1000);
> +    }
> +    g_assert_cmphex(rd(qts, LSR) & LSR_OE, ==, LSR_OE);
> +
> +    close(fd); qtest_quit(qts);
> +}
> +
> +/* 4. THRE interrupt */
> +static void test_thre_interrupt(void)
> +{
> +    QTestState *qts = qtest_init("-machine k230 "
> +                                 "-chardev null,id=c0 -serial chardev:c0");
> +    qtest_writel(qts, R(LCR), LCR_8N1);
> +
> +    qtest_writel(qts, R(THR), 'A');
> +    g_assert_cmphex(iid(qts), ==, IIR_NONE);
> +
> +    qtest_writel(qts, R(IER), IER_TX);
> +    g_assert_cmphex(iid(qts), ==, IIR_THR);
> +
> +    qtest_writel(qts, R(THR), 'B');
> +    g_assert_cmphex(iid(qts), ==, IIR_THR);
> +
> +    g_assert_cmphex(iid(qts), ==, IIR_NONE);
> +    qtest_quit(qts);
> +}
> +
> +/* 5. RX interrupts: timeout & trigger level */
> +static void test_rx_interrupts(void)
> +{
> +    int fd;
> +    QTestState *qts = qtest_init_with_serial("-machine k230", &fd);
> +
> +    qtest_writel(qts, R(LCR), LCR_8N1);
> +    qtest_writel(qts, R(IIR), FCR_FE | FCR_RT_F);
> +    qtest_writel(qts, R(IER), IER_RX);
> +
> +    /* basic timeout */
> +    s1(qts, fd, 'T');
> +    qtest_clock_step(qts, 400000);
> +    g_assert_cmphex(iid(qts), ==, IIR_TO);
> +    g_assert_cmphex(rd(qts, THR), ==, 'T');
> +    g_assert_cmphex(iid(qts), !=, IIR_TO);
> +
> +    /* timeout reset by new byte */
> +    s1(qts, fd, 'A'); qtest_clock_step(qts, 200000);
> +    s1(qts, fd, 'B');
> +    qtest_clock_step(qts, 200000);
> +    g_assert_cmphex(iid(qts), ==, IIR_NONE);
> +    qtest_clock_step(qts, 200000);
> +    g_assert_cmphex(iid(qts), ==, IIR_TO);
> +    rd(qts, THR);
> +    rd(qts, THR);
> +
> +    /* timeout rearmed by partial drain */
> +    s1(qts, fd, 'X');
> +    s1(qts, fd, 'Y');
> +    qtest_clock_step(qts, 400000);
> +    g_assert_cmphex(iid(qts), ==, IIR_TO);
> +    g_assert_cmphex(rd(qts, THR), ==, 'X');
> +    qtest_clock_step(qts, 200000);
> +    g_assert_cmphex(iid(qts), !=, IIR_TO);
> +    qtest_clock_step(qts, 250000);
> +    g_assert_cmphex(iid(qts), ==, IIR_TO);
> +    g_assert_cmphex(rd(qts, THR), ==, 'Y');
> +
> +    /* RX trigger level: RT=Q -> trigger at 8 bytes */
> +    qtest_writel(qts, R(IIR), FCR_FE | FCR_RT_Q);
> +    sn(qts, fd, "ABCDEFG", 7);
> +    g_usleep(20000);
> +    g_assert_cmphex(iid(qts), ==, IIR_NONE);
> +    qtest_clock_step(qts, 400000);
> +    g_assert_cmphex(iid(qts), ==, IIR_TO);
> +    for (int i = 0; i < 7; i++) {
> +        rd(qts, THR);
> +    }
> +
> +    sn(qts, fd, "12345678", 8);
> +    for (int i = 0; i < 1000; i++) {
> +        if (iid(qts) == IIR_RX) {
> +            break;
> +        }
> +        g_usleep(1000);
> +    }
> +    g_assert_cmphex(iid(qts), ==, IIR_RX);
> +
> +    close(fd); qtest_quit(qts);
> +}
> +
> +/* 6. error interrupts & IIR priority */
> +static void test_error_interrupts(void)
> +{
> +    int fd;
> +    QTestState *qts = qtest_init_with_serial("-machine k230", &fd);
> +
> +    qtest_writel(qts, R(LCR), LCR_8N1);
> +    qtest_writel(qts, R(IER), IER_LS);
> +
> +    /* OE -> IIR=0x6; LSR clears; ELCOLR=0: RBR clears; ELCOLR=1: RBR keeps */
> +    oe_nf(qts, fd);
> +    g_assert_cmphex(iid(qts), ==, IIR_LINE);
> +    rd(qts, LSR);
> +    g_assert_cmphex(iid(qts), !=, IIR_LINE);
> +
> +    oe_nf(qts, fd);
> +    g_assert_cmphex(iid(qts), ==, IIR_LINE);
> +    rd(qts, THR);
> +    g_assert_cmphex(iid(qts), !=, IIR_LINE);
> +
> +    qtest_writel(qts, R(IER), IER_LS | IER_COLR);
> +    oe_nf(qts, fd);
> +    g_assert_cmphex(iid(qts), ==, IIR_LINE);
> +    rd(qts, THR);
> +    g_assert_cmphex(iid(qts), ==, IIR_LINE);
> +    rd(qts, LSR);
> +    g_assert_cmphex(iid(qts), !=, IIR_LINE);
> +
> +    /* IIR priority: RX > TX (loopback) */
> +    qtest_writel(qts, R(IIR), FCR_FE);
> +    qtest_writel(qts, R(MCR), MCR_LB);
> +    qtest_writel(qts, R(IER), IER_TX | IER_RX);
> +    qtest_writel(qts, R(THR), 'P');
> +    g_assert_cmphex(iid(qts), ==, IIR_RX);
> +    g_assert_cmphex(rd(qts, THR), ==, 'P');
> +    g_assert_cmphex(iid(qts), ==, IIR_THR);
> +    iid(qts);
> +    g_assert_cmphex(iid(qts), ==, IIR_NONE);
> +
> +    /* OE in FIFO mode via loopback */
> +    qtest_writel(qts, R(IER), IER_LS);
> +    for (int i = 0; i < 32; i++) {
> +        qtest_writel(qts, R(THR), 'a');
> +    }
> +    g_assert_cmphex(rd(qts, LSR) & LSR_OE, ==, 0);
> +    qtest_writel(qts, R(THR), 'z');
> +    g_assert_cmphex(iid(qts), ==, IIR_LINE);
> +    g_assert_cmphex(rd(qts, LSR) & LSR_OE, ==, LSR_OE);
> +
> +    close(fd); qtest_quit(qts);
> +}
> +
> +/* 7. USR & busy detect */
> +static void test_busy_detect(void)
> +{
> +    int fd;
> +    QTestState *qts = qtest_init_with_serial("-machine k230", &fd);
> +
> +    qtest_writel(qts, R(LCR), LCR_8N1);
> +    qtest_writel(qts, R(IIR), FCR_FE);
> +
> +    g_assert_cmphex(rd(qts, USR) & 0x1e, ==, 0x06);
> +
> +    qtest_writel(qts, R(MCR), MCR_LB);
> +    qtest_writel(qts, R(THR), 'A');
> +    g_assert_cmphex(rd(qts, USR) & 0x08, ==, 0x08);
> +    rd(qts, THR);
> +    g_assert_cmphex(rd(qts, USR) & 0x08, ==, 0);
> +    qtest_writel(qts, R(MCR), 0);
> +
> +    /* BUSY via RX & loopback */
> +    g_assert_cmphex(rd(qts, USR) & USR_BUSY, ==, 0);
> +    s1(qts, fd, 'Z');
> +    g_assert_cmphex(rd(qts, USR) & USR_BUSY, ==, USR_BUSY);
> +    rd(qts, THR);
> +    g_assert_cmphex(rd(qts, USR) & USR_BUSY, ==, 0);
> +
> +    qtest_writel(qts, R(MCR), MCR_LB);
> +    qtest_writel(qts, R(THR), 'L');
> +    g_assert_cmphex(rd(qts, USR) & USR_BUSY, ==, USR_BUSY);
> +    rd(qts, THR);
> +    g_assert_cmphex(rd(qts, USR) & USR_BUSY, ==, 0);
> +
> +    /* busy-detect: LCR write rejected while BUSY=1 */
> +    qtest_writel(qts, R(MCR), 0);
> +    qtest_writel(qts, R(IIR), FCR_FE | FCR_RR | FCR_XR);
> +    s1(qts, fd, 'B');
> +    g_assert_cmphex(rd(qts, USR) & USR_BUSY, ==, USR_BUSY);
> +    qtest_writel(qts, R(LCR), LCR_8N1 | LCR_DLAB);
> +    g_assert_cmphex(rd(qts, LCR), ==, LCR_8N1);
> +    g_assert_cmphex(iid(qts), ==, IIR_BUSY);
> +    rd(qts, USR);
> +    g_assert_cmphex(iid(qts), ==, IIR_NONE);
> +    qtest_writel(qts, R(IIR), FCR_FE | FCR_RR);
> +    g_assert_cmphex(rd(qts, USR) & USR_BUSY, ==, 0);
> +    qtest_writel(qts, R(LCR), LCR_8N1 | LCR_DLAB);
> +    g_assert_cmphex(rd(qts, LCR), ==, LCR_8N1 | LCR_DLAB);
> +
> +    close(fd); qtest_quit(qts);
> +}
> +
> +/* 8. advanced features */
> +static void test_advanced_features(void)
> +{
> +    QTestState *qts = qtest_init("-machine k230 "
> +                                 "-chardev null,id=c0 -serial chardev:c0");
> +
> +    /* shadow: SRTS<->MCR.RTS, SBCR<->LCR.BC, SDMAM, SFE, SRT, STET, HTX */
> +    qtest_writel(qts, R(SRTS), 1);
> +    g_assert_cmphex(rd(qts, MCR) & MCR_RTS, ==, MCR_RTS);
> +    qtest_writel(qts, R(MCR), 0); g_assert_cmphex(rd(qts, SRTS), ==, 0);
> +    qtest_writel(qts, R(SBCR), 1);
> +    g_assert_cmphex(rd(qts, LCR) & LCR_BC, ==, LCR_BC);
> +    qtest_writel(qts, R(LCR), 0); g_assert_cmphex(rd(qts, SBCR), ==, 0);
> +    qtest_writel(qts, R(SDMAM), 1); g_assert_cmphex(rd(qts, SDMAM), ==, 1);
> +    qtest_writel(qts, R(SRT), 0x2); g_assert_cmphex(rd(qts, SRT), ==, 0x2);
> +    qtest_writel(qts, R(STET), 0x3); g_assert_cmphex(rd(qts, STET), ==, 0x3);
> +    qtest_writel(qts, R(SFE), 1); g_assert_cmphex(rd(qts, SFE), ==, 1);
> +    g_assert_cmphex(rd(qts, IIR) & IIR_FF, ==, IIR_FF);
> +    qtest_writel(qts, R(HTX), 1); g_assert_cmphex(rd(qts, HTX), ==, 1);
> +    qtest_writel(qts, R(HTX), 0); g_assert_cmphex(rd(qts, HTX), ==, 0);
> +
> +    /* HTX halt TX */
> +    qtest_writel(qts, R(LCR), LCR_8N1);
> +    qtest_writel(qts, R(IIR), FCR_FE);
> +    qtest_writel(qts, R(MCR), MCR_LB);
> +
> +    qtest_writel(qts, R(HTX), 1);
> +    qtest_writel(qts, R(THR), 'H');
> +    g_assert_cmphex(rd(qts, TFL), ==, 1);
> +    g_assert_cmphex(rd(qts, RFL), ==, 0);
> +
> +    qtest_writel(qts, R(HTX), 0);
> +    g_assert_cmphex(rd(qts, TFL), ==, 0);
> +    g_assert_cmphex(rd(qts, RFL), ==, 1);
> +    g_assert_cmphex(rd(qts, THR), ==, 'H');
> +
> +    /* SRR: RFR & UR */
> +    qtest_writel(qts, R(THR), 'Z');
> +    g_assert_cmphex(rd(qts, RFL), ==, 1);
> +    g_assert_cmphex(rd(qts, LSR) & LSR_DR, ==, LSR_DR);
> +    qtest_writel(qts, R(SRR), SRR_RFR);
> +    g_assert_cmphex(rd(qts, RFL), ==, 0);
> +    g_assert_cmphex(rd(qts, LSR) & LSR_DR, ==, 0);
> +    g_assert_cmphex(rd(qts, SRR), ==, 0);
> +    qtest_writel(qts, R(THR), 'Y');
> +    qtest_writel(qts, R(SRR), SRR_UR);
> +    g_assert_cmphex(rd(qts, LSR), ==, LSR_RESET);
> +    g_assert_cmphex(iid(qts), ==, IIR_NONE);
> +    g_assert_cmphex(rd(qts, RFL), ==, 0);
> +
> +    /* PTIME + TET programmable THRE */
> +    qtest_writel(qts, R(LCR), LCR_8N1);
> +    qtest_writel(qts, R(IIR), FCR_FE | FCR_TET_H);
> +    qtest_writel(qts, R(IER), IER_TX | IER_PTIME);
> +    qtest_writel(qts, R(THR), 'A');
> +    g_assert_cmphex(rd(qts, LSR) & LSR_THRE, ==, LSR_THRE);
> +    g_assert_cmphex(iid(qts), ==, IIR_THR);
> +
> +    qtest_quit(qts);
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +    g_test_init(&argc, &argv, NULL);
> +    qtest_add_func("/k230-uart/device_probe",       test_device_probe);
> +    qtest_add_func("/k230-uart/init_and_baud",      test_init_and_baud);
> +    qtest_add_func("/k230-uart/tx_rx_datapath",     test_tx_rx_datapath);
> +    qtest_add_func("/k230-uart/thre_interrupt",     test_thre_interrupt);
> +    qtest_add_func("/k230-uart/rx_interrupts",      test_rx_interrupts);
> +    qtest_add_func("/k230-uart/error_interrupts",   test_error_interrupts);
> +    qtest_add_func("/k230-uart/busy_detect",        test_busy_detect);
> +    qtest_add_func("/k230-uart/advanced_features",  test_advanced_features);
> +    return g_test_run();
> +}
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 822e0bd286970339fe28127649feb131ce8a81b2..93246d9bf77206e9cebb9d8ade5801f4541d3b8d 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -294,7 +294,7 @@ qtests_riscv64 = ['riscv-csr-test'] + \
>     (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') and
>      config_all_devices.has_key('CONFIG_RISCV_IOMMU') ?
>      ['iommu-riscv-test'] : []) + \
> -  (config_all_devices.has_key('CONFIG_K230') ? ['k230-wdt-test'] : [])
> +  (config_all_devices.has_key('CONFIG_K230') ? ['k230-wdt-test', 'k230-uart-test'] : [])
>   
>   qtests_hexagon = ['boot-serial-test']
>   
> 


