Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99830606A32A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 20:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KlMxYd2U;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JUU/v2Ri
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQsSb-00011C-9f; Tue, 10 Nov 2026 15:28:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQsS9-0000lA-S2
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 15:28:29 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQsS5-0001z2-UA
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 15:28:25 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AAIooZv3136083
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 20:28:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uoRHEa9HgQ/evpqIcvlVMUjEbScNQMN+bRmCWvo2uxM=; b=KlMxYd2UfYphI1Ns
 2TbGA9OGBUyd2V07gxkZs5kAUssTxueRJUVUb87PFP3C3jqOK4nYZ0lxtrrNCxGr
 VKln4ci6MADskKDj4IdcKTgv34fqUIXeQzdqM3xEu4nTW8BtMjVLFzwz0DLWJmGh
 v13xbiwpmhllxhoMVk2hDM8L1N3MKsRXTF/+LDe5dFgXBfQjOIOdHLjKU9HCzBy1
 7bRa81woOGwa/D0ioZhN2yFLvr2pJrm84Ohx0UM0ZOeyptT1HrdOzznXvWi2+5Bc
 +bmptJRbtxR5ZM/B1eXmpww//mK6PqWC9VNsIwUcfufcxeCNEqUr8dub95sXza8Q
 XoOlzg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hv7c5gvu6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 20:28:14 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-945c60b470dso368133685a.1
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 12:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794342494; x=1794947294; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=uoRHEa9HgQ/evpqIcvlVMUjEbScNQMN+bRmCWvo2uxM=;
 b=JUU/v2RiqLa+XRmQEWtMjJ3FCL2yweaZVslTsAD2k6Mjo2JLKEoEEecOy8pDnlmqqc
 WdXEi0mCFlIsGbn+lvUaZAyT1H8vC6jSUFND/g1yHWBPJXvLnf3zCwZEcsokFKGoaqHt
 IGGRGDC01QG12CR13hCxQfvg0CYZDGIQNRnxWCANd03OiJYR6434OXO2PcURvLuA3qX1
 NDh3J8e9E9GKPIqQbaaQsgvfMuD0TW3w0rn4vSeTHJvpCPfwtkkMT4+9GN84HOLSSw2W
 4ghTMg/q/4CK79HajNbY5IU404pcTxLsk+/8uyFCWP4gECZu4+Wt8DxdTxBcfIT+JgDy
 vLrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794342494; x=1794947294;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uoRHEa9HgQ/evpqIcvlVMUjEbScNQMN+bRmCWvo2uxM=;
 b=Q8Rujbi6mH4DZX/K5le7jau3HuuIp9y8MqI876BQx2XROHXqeZcLbQEKyg400e2sbs
 PbuDQF1QiXm/k4x8TqAgOk+f3GKcd08Q2NedPmQvzB0TsHSjbvJQcTrXv366eymrOBod
 vsYQOA9izdQAKJO4UGkqqAJWiTzx8a8LZFVkT/SDJhmKcEJxctDQJ9KBKh3hx1Emic0Z
 Wg90rXPPSyHeZC+B7G+pCKmEQ4bclH23ZNF9pBNneGebmUrmPXB+GPOOCdNn/27lYlaG
 2FH70DEbTLiEJEJXSPL9P9ggpGHD9Y81p3HWaLQBis4kiirwib/s9fHZ5hfR+/9JF8ZL
 FJbg==
X-Forwarded-Encrypted: i=1;
 AL+hErGraXxydnpm/2HBmRSr98S+2UCHMqmsxJP+/MCqQa6SXmMRUtS1ckKKNf1klpLQvSUuGoFhEB7esz7S@nongnu.org
X-Gm-Message-State: APuU4Z+XDpWLtRSsMCKU8uffGzZBENgDinFnIFvsnijwuB60VPwVKSUv
 j0GO7xQLe6fxT9wf3P1Ot2Sp/8x677Cit2Thw2juU/5X6yPu2P+oYGRFUS01a2Uyhb7Dc2DFnrM
 lXTWWLiHwtDDBiB6b3rIQF2FHzkDtT1nXksU/hHVlP/2iKjMMlYeln4VKfw==
X-Gm-Gg: AYBFou2duZbCh1ekkVbSJA+NHL2SUDHhQsOYypsbm+6NKEh2iAeRhQEiPGt/sOf3xKY
 GTJg3fDMa8igjVMDeGkO8nU7Bze7cu0Q8xnodrfpDjEdHMk5PxoFqVPwK43fu7aJJHSoNZDELza
 /wrNTbppKdps0L7OVVeD56dq+sxbB+gDxp7a0XID0a/cy5mYR8LH7VaRHlJghf+DyztbScHQ5GW
 Yi7WpZmfn0cMTxOevuzL8B+K23vTmKG6RJ0OkyOSwfdpRuue8wjidXAvLZuKd9JVswhJ2NwaxbE
 ZTMVtpgepZGeHVN1Kkga/YZRb9gPPbIi3dOAfCXvliZ6st5QUyrh8HZlxixNUeS1OOP0IlJT4+m
 WKAC7RJpY9Kl8OeeNLUOTbo80WRxJR85zcnw/NPVLoPO1tcC/Qs8lPx7EqqaE6gzhR9euhp6T46
 SU3Zh5ErvyiQ==
X-Received: by 2002:a05:620a:4484:b0:93c:6534:d04d with SMTP id
 af79cd13be357-947b00016f6mr17788385a.35.1794342493711; 
 Tue, 10 Nov 2026 12:28:13 -0800 (PST)
X-Received: by 2002:a05:620a:4484:b0:93c:6534:d04d with SMTP id
 af79cd13be357-947b00016f6mr17783385a.35.1794342493106; 
 Tue, 10 Nov 2026 12:28:13 -0800 (PST)
Received: from [192.168.68.105] ([152.234.124.231])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9479e73c3d0sm313675985a.11.2026.11.10.12.28.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Nov 2026 12:28:12 -0800 (PST)
Message-ID: <911beffb-1018-4be7-b56c-427b5948ef44@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 17:28:09 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/26] tests/qtest: Add SiFive L2 cache controller
 coverage
To: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org
References: <20261104154207.641511-1-bin.meng@processmission.com>
 <20261104154207.641511-9-bin.meng@processmission.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261104154207.641511-9-bin.meng@processmission.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA4MSBTYWx0ZWRfX45ZC8++thgP2
 Symn+/+faT/Da8gTQZvaTU9r+WhF8kC4CJmKmn+XCsWy9qQNO6IzWIYopfuyOm+YpLFKjE1daD9
 U8sSVu3uStImixeQ86EKZxLbde568NvbOKARbhHeMQaSc3p/Ewr3Il7YUGs9P/K6apcRn4PexIC
 OrlKMpDf+8gXjvEZ+PD+vciBYtBD7gI6OOhQgOH2bF+JAK2GnWAqnbOnUG5Mz8yrUO0O6nuo3LC
 cqbdgPipdOxD8paBkKLvUftYszUVYf+1tsZygPhlTSgKvL0giOlQJ8Y8lXxN+brMXCVnRO0T3sW
 hwrcwZ4E7qlcxv+NXknFZA72RtsGGsBXxf8ECQl0GVA/ZhKSuX6oO4qVzYoRAUrSyD6/OQyj0jW
 UTn9mKv1SDU/72fM0BZ3tP0q7XupDn9ySHbcyoDfm6tW1aTawEv4h1UXj+S8+uu/HTvi9tGeN7w
 6c2iS7a1xFlcmA1VraA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA4MSBTYWx0ZWRfX+XkMbyWcW6lD
 rk7t0HGwqiSOXEjDmkKi0S+FlHNr67H+0J52VupACvq3H2SmY2VW82poQCbcPr2Yi0LQOz2t06c
 2Smwlj+ih3HAEoX211vNE4/tZU927yQ=
X-Proofpoint-ORIG-GUID: IySv3UChM0w9v5OXdDdHqaTYXmY9yNd4
X-Authority-Analysis: v=2.4 cv=eq9KXYpX c=1 sm=1 tr=0 ts=6af37e5e cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=8elE1k/PHQNyZ14TNTodlQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=FRSEYCzRAAAA:8 a=EUspDBNiAAAA:8 a=hn0h2DJo3O1DtmxPrY4A:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-GUID: IySv3UChM0w9v5OXdDdHqaTYXmY9yNd4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 spamscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100081
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



On 11/4/2026 12:41 PM, Bin Meng wrote:
> Exercise Config, WayEnable, and indexed WayMask registers on the
> PolarFire and FU540 integrations, including their different master
> counts, reset, monotonic writes, and unimplemented-register logging.
> 
> Verify that enabling cache ways hides the corresponding LIM range,
> while the controller's Zero window stays accessible. Check that reset
> restores hidden LIM data without clearing the Zero RAM stand-in.
> 
> Migrate register state and both RAM backings, verify the destination
> LIM view, and confirm that writes to hidden addresses do not alter the
> data restored by a later reset.
> 
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
> 
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

> 
> (no changes since v3)
> 
> Changes in v3:
> - Rename the test for the shared SiFive L2CC model
> - Exercise 15 masters on PolarFire and 21 masters on FU540
> 
>   MAINTAINERS                    |   1 +
>   tests/qtest/sifive_l2cc_test.c | 306 +++++++++++++++++++++++++++++++++
>   tests/qtest/meson.build        |   3 +
>   3 files changed, 310 insertions(+)
>   create mode 100644 tests/qtest/sifive_l2cc_test.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 55463103ff..4bef2dffb0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1851,6 +1851,7 @@ F: docs/system/riscv/sifive_u.rst
>   F: hw/*/*sifive*.c
>   F: include/hw/*/*sifive*.h
>   F: tests/functional/riscv64/test_sifive_u.py
> +F: tests/qtest/sifive_l2cc_test.c
>   
>   Tenstorrent Machines
>   M: Joel Stanley <joel@jms.id.au>
> diff --git a/tests/qtest/sifive_l2cc_test.c b/tests/qtest/sifive_l2cc_test.c
> new file mode 100644
> index 0000000000..fef80f3438
> --- /dev/null
> +++ b/tests/qtest/sifive_l2cc_test.c
> @@ -0,0 +1,306 @@
> +/*
> + * QTest testcase for the SiFive L2 cache controller
> + *
> + * Copyright (c) 2026 Process Mission
> + *
> + * Author:
> + *   Bin Meng <bin.meng@processmission.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/units.h"
> +#include "libqtest.h"
> +#include "migration/migration-qmp.h"
> +#include "migration/migration-util.h"
> +
> +#define L2CC_BASE                       0x02010000
> +#define L2CC_CONFIG                     0x000
> +#define L2CC_CONFIG_VALUE               0x06091004
> +#define L2CC_WAY_ENABLE                 0x008
> +#define L2CC_ECC_INJECT                 0x040
> +#define L2CC_FLUSH64                    0x200
> +#define L2CC_WAY_MASK_BASE              0x800
> +#define L2CC_WAY_MASK_COUNT             15
> +#define L2CC_MAX_MASTERS                21
> +#define L2CC_WAY_MASK(n)                (L2CC_WAY_MASK_BASE + 8 * (n))
> +#define L2CC_MASTER15                   L2CC_WAY_MASK(L2CC_WAY_MASK_COUNT)
> +#define L2CC_WAY_ENABLE_RESET           0
> +#define L2CC_WAY_MASK_RESET             UINT64_MAX
> +
> +#define L2_LIM_BASE                     0x08000000
> +#define L2_WAY_SIZE                     (128 * KiB)
> +#define L2_LIM_RESET_WAYS               15
> +#define L2_ZERO_BASE                    0x0a000000
> +#define L2_ZERO_SIZE                    (2 * MiB)
> +
> +static QTestState *sifive_l2cc_start(const char *firmware)
> +{
> +    return qtest_initf("-machine microchip-icicle-kit -smp 5 -m 2G "
> +                       "-bios \"%s\"", firmware);
> +}
> +
> +static char *sifive_l2cc_create_firmware(void)
> +{
> +    static const uint8_t firmware[] = {
> +        0x13, 0x00, 0x00, 0x00,
> +        0x6f, 0x00, 0x00, 0x00,
> +    };
> +    char *path;
> +    int fd;
> +    ssize_t written;
> +
> +    fd = g_file_open_tmp("sifive_l2cc_XXXXXX", &path, NULL);
> +    g_assert_cmpint(fd, >=, 0);
> +
> +    written = write(fd, firmware, sizeof(firmware));
> +    g_assert_cmpint(written, ==, sizeof(firmware));
> +    close(fd);
> +
> +    return path;
> +}
> +
> +static uint64_t l2cc_way_mask_test_value(unsigned int master)
> +{
> +    return UINT64_C(0xfedcba9876543201) + master;
> +}
> +
> +static void test_l2cc_registers(void)
> +{
> +    g_autofree char *firmware = sifive_l2cc_create_firmware();
> +    QTestState *qts = sifive_l2cc_start(firmware);
> +    unsigned int i;
> +
> +    unlink(firmware);
> +
> +    g_assert_cmphex(qtest_readl(qts, L2CC_BASE + L2CC_CONFIG), ==,
> +                    L2CC_CONFIG_VALUE);
> +    qtest_writel(qts, L2CC_BASE + L2CC_CONFIG, UINT32_MAX);
> +    g_assert_cmphex(qtest_readl(qts, L2CC_BASE + L2CC_CONFIG), ==,
> +                    L2CC_CONFIG_VALUE);
> +
> +    g_assert_cmphex(qtest_readb(qts, L2CC_BASE + L2CC_WAY_ENABLE), ==,
> +                    L2CC_WAY_ENABLE_RESET);
> +    qtest_writeb(qts, L2CC_BASE + L2CC_WAY_ENABLE, 0xd);
> +    g_assert_cmphex(qtest_readb(qts, L2CC_BASE + L2CC_WAY_ENABLE), ==, 0xd);
> +    qtest_writeb(qts, L2CC_BASE + L2CC_WAY_ENABLE, 3);
> +    g_assert_cmphex(qtest_readb(qts, L2CC_BASE + L2CC_WAY_ENABLE), ==, 0xd);
> +    qtest_writeq(qts, L2CC_BASE + L2CC_WAY_ENABLE, 0xf);
> +    g_assert_cmphex(qtest_readq(qts, L2CC_BASE + L2CC_WAY_ENABLE), ==, 0xf);
> +    qtest_writeb(qts, L2CC_BASE + L2CC_WAY_ENABLE, 0xe);
> +    g_assert_cmphex(qtest_readb(qts, L2CC_BASE + L2CC_WAY_ENABLE), ==, 0xf);
> +
> +    for (i = 0; i < L2CC_WAY_MASK_COUNT; i++) {
> +        g_assert_cmphex(qtest_readq(qts, L2CC_BASE + L2CC_WAY_MASK(i)), ==,
> +                        L2CC_WAY_MASK_RESET);
> +        qtest_writeq(qts, L2CC_BASE + L2CC_WAY_MASK(i),
> +                     l2cc_way_mask_test_value(i));
> +    }
> +    for (i = 0; i < L2CC_WAY_MASK_COUNT; i++) {
> +        g_assert_cmphex(qtest_readq(qts, L2CC_BASE + L2CC_WAY_MASK(i)), ==,
> +                        l2cc_way_mask_test_value(i));
> +    }
> +
> +    qtest_system_reset(qts);
> +    g_assert_cmphex(qtest_readl(qts, L2CC_BASE + L2CC_CONFIG), ==,
> +                    L2CC_CONFIG_VALUE);
> +    g_assert_cmphex(qtest_readb(qts, L2CC_BASE + L2CC_WAY_ENABLE), ==,
> +                    L2CC_WAY_ENABLE_RESET);
> +    for (i = 0; i < L2CC_WAY_MASK_COUNT; i++) {
> +        g_assert_cmphex(qtest_readq(qts, L2CC_BASE + L2CC_WAY_MASK(i)), ==,
> +                        L2CC_WAY_MASK_RESET);
> +    }
> +
> +    qtest_quit(qts);
> +}
> +
> +static void test_l2lim_topology(void)
> +{
> +    g_autofree char *firmware = sifive_l2cc_create_firmware();
> +    uint32_t original[L2_LIM_RESET_WAYS];
> +    const uint32_t poison = 0xdeadc0de;
> +    const uint64_t zero_last = L2_ZERO_BASE + L2_ZERO_SIZE - 4;
> +    QTestState *qts = sifive_l2cc_start(firmware);
> +    unsigned int i;
> +
> +    unlink(firmware);
> +
> +    /* Check the fixed aperture, not the RAM stand-in's eviction behavior */
> +    qtest_writel(qts, zero_last, 0xa55a9669);
> +    g_assert_cmphex(qtest_readl(qts, zero_last), ==, 0xa55a9669);
> +
> +    for (i = 1; i <= L2_LIM_RESET_WAYS; i++) {
> +        uint64_t l2lim_size = (L2_LIM_RESET_WAYS - i) * L2_WAY_SIZE;
> +        uint64_t hidden = L2_LIM_BASE + l2lim_size;
> +        uint32_t tail = 0x96000000 | i;
> +
> +        original[i - 1] = 0x69000000 | i;
> +        qtest_writel(qts, hidden, original[i - 1]);
> +        g_assert_cmphex(qtest_readl(qts, hidden), ==, original[i - 1]);
> +
> +        if (l2lim_size) {
> +            qtest_writel(qts, hidden - 4, tail);
> +            g_assert_cmphex(qtest_readl(qts, hidden - 4), ==, tail);
> +        }
> +
> +        qtest_writeb(qts, L2CC_BASE + L2CC_WAY_ENABLE, i);
> +        g_assert_cmphex(qtest_readb(qts,
> +                                   L2CC_BASE + L2CC_WAY_ENABLE), ==, i);
> +        if (l2lim_size) {
> +            g_assert_cmphex(qtest_readl(qts, hidden - 4), ==, tail);
> +        }
> +        g_assert_cmphex(qtest_readl(qts, hidden), ==, 0);
> +        qtest_writel(qts, hidden, poison);
> +        g_assert_cmphex(qtest_readl(qts, hidden), ==, 0);
> +        g_assert_cmphex(qtest_readl(qts, zero_last), ==, 0xa55a9669);
> +    }
> +
> +    qtest_writeb(qts, L2CC_BASE + L2CC_WAY_ENABLE, UINT8_MAX);
> +    g_assert_cmphex(qtest_readb(qts, L2CC_BASE + L2CC_WAY_ENABLE), ==,
> +                    UINT8_MAX);
> +    g_assert_cmphex(qtest_readl(qts, L2_LIM_BASE), ==, 0);
> +    qtest_writeb(qts, L2CC_BASE + L2CC_WAY_ENABLE, 3);
> +    g_assert_cmphex(qtest_readb(qts, L2CC_BASE + L2CC_WAY_ENABLE), ==,
> +                    UINT8_MAX);
> +    g_assert_cmphex(qtest_readl(qts, L2_LIM_BASE), ==, 0);
> +
> +    qtest_system_reset(qts);
> +    g_assert_cmphex(qtest_readb(qts, L2CC_BASE + L2CC_WAY_ENABLE), ==,
> +                    L2CC_WAY_ENABLE_RESET);
> +    for (i = 1; i <= L2_LIM_RESET_WAYS; i++) {
> +        uint64_t restored = L2_LIM_BASE +
> +                            (L2_LIM_RESET_WAYS - i) * L2_WAY_SIZE;
> +
> +        g_assert_cmphex(qtest_readl(qts, restored), ==, original[i - 1]);
> +    }
> +    g_assert_cmphex(qtest_readl(qts, zero_last), ==, 0xa55a9669);
> +
> +    qtest_quit(qts);
> +}
> +
> +static void test_l2cc_master_count(void)
> +{
> +    g_autofree char *firmware = sifive_l2cc_create_firmware();
> +    QTestState *qts = qtest_initf(
> +        "-machine sifive_u -smp 5 -bios \"%s\"", firmware);
> +    const uint64_t zero_last = L2_ZERO_BASE + L2_ZERO_SIZE - 4;
> +    unsigned int i;
> +
> +    unlink(firmware);
> +
> +    for (i = 0; i < L2CC_MAX_MASTERS; i++) {
> +        g_assert_cmphex(qtest_readq(qts, L2CC_BASE + L2CC_WAY_MASK(i)), ==,
> +                        L2CC_WAY_MASK_RESET);
> +        qtest_writeq(qts, L2CC_BASE + L2CC_WAY_MASK(i),
> +                     l2cc_way_mask_test_value(i));
> +    }
> +    for (i = 0; i < L2CC_MAX_MASTERS; i++) {
> +        g_assert_cmphex(qtest_readq(qts, L2CC_BASE + L2CC_WAY_MASK(i)), ==,
> +                        l2cc_way_mask_test_value(i));
> +    }
> +    g_assert_cmphex(qtest_readq(qts,
> +                                L2CC_BASE + L2CC_WAY_MASK(L2CC_MAX_MASTERS)),
> +                    ==, 0);
> +    qtest_writel(qts, zero_last, 0x12345678);
> +    qtest_writel(qts, L2_ZERO_BASE + L2_ZERO_SIZE, 0xdeadc0de);
> +    g_assert_cmphex(qtest_readl(qts, L2_ZERO_BASE + L2_ZERO_SIZE), ==, 0);
> +    qtest_writeb(qts, L2CC_BASE + L2CC_WAY_ENABLE, 15);
> +    g_assert_cmphex(qtest_readl(qts, zero_last), ==, 0x12345678);
> +    g_assert_cmphex(qtest_readl(qts, L2_LIM_BASE), ==, 0);
> +
> +    qtest_system_reset(qts);
> +    for (i = 0; i < L2CC_MAX_MASTERS; i++) {
> +        g_assert_cmphex(qtest_readq(qts, L2CC_BASE + L2CC_WAY_MASK(i)), ==,
> +                        L2CC_WAY_MASK_RESET);
> +    }
> +    qtest_quit(qts);
> +}
> +
> +static void test_l2cc_migration(void)
> +{
> +    g_autofree char *firmware = sifive_l2cc_create_firmware();
> +    QTestState *from = sifive_l2cc_start(firmware);
> +    QTestState *to = qtest_initf(
> +        "-machine microchip-icicle-kit -smp 5 -m 2G "
> +        "-bios \"%s\" -incoming defer", firmware);
> +    const uint64_t hidden = L2_LIM_BASE + 8 * L2_WAY_SIZE;
> +    const uint64_t zero_last = L2_ZERO_BASE + L2_ZERO_SIZE - 4;
> +
> +    unlink(firmware);
> +
> +    qtest_writel(from, L2_LIM_BASE, 0x11223344);
> +    qtest_writel(from, hidden, 0x55667788);
> +    qtest_writel(from, zero_last, 0x99aabbcc);
> +    qtest_writeb(from, L2CC_BASE + L2CC_WAY_ENABLE, 7);
> +    qtest_writeq(from, L2CC_BASE + L2CC_WAY_MASK(14), 0x1234);
> +    g_assert_cmphex(qtest_readl(from, hidden), ==, 0);
> +
> +    migrate_incoming_qmp(to, "tcp:127.0.0.1:0", NULL, "{}");
> +    migrate_qmp(from, to, NULL, NULL, "{}");
> +    wait_for_migration_complete(from);
> +
> +    g_assert_cmphex(qtest_readb(to, L2CC_BASE + L2CC_WAY_ENABLE), ==, 7);
> +    g_assert_cmphex(qtest_readq(to, L2CC_BASE + L2CC_WAY_MASK(14)), ==, 0x1234);
> +    g_assert_cmphex(qtest_readl(to, L2_LIM_BASE), ==, 0x11223344);
> +    g_assert_cmphex(qtest_readl(to, hidden), ==, 0);
> +    qtest_writel(to, hidden, 0xdeadc0de);
> +    g_assert_cmphex(qtest_readl(to, zero_last), ==, 0x99aabbcc);
> +
> +    qtest_system_reset(to);
> +    g_assert_cmphex(qtest_readb(to, L2CC_BASE + L2CC_WAY_ENABLE), ==, 0);
> +    g_assert_cmphex(qtest_readl(to, hidden), ==, 0x55667788);
> +    g_assert_cmphex(qtest_readl(to, zero_last), ==, 0x99aabbcc);
> +
> +    qtest_quit(from);
> +    qtest_quit(to);
> +}
> +
> +static void test_l2cc_unimplemented(void)
> +{
> +    g_autofree char *firmware = sifive_l2cc_create_firmware();
> +    g_autofree char *log_path = NULL;
> +    g_autofree char *log = NULL;
> +    QTestState *qts;
> +    int fd;
> +
> +    fd = g_file_open_tmp("sifive_l2cc_unimp_XXXXXX", &log_path, NULL);
> +    g_assert_cmpint(fd, >=, 0);
> +    close(fd);
> +
> +    qts = qtest_initf(
> +        "-machine microchip-icicle-kit -smp 5 -m 2G -bios \"%s\" "
> +        "-d unimp -D \"%s\"", firmware, log_path);
> +    unlink(firmware);
> +
> +    g_assert_cmphex(qtest_readl(qts, L2CC_BASE + L2CC_ECC_INJECT), ==, 0);
> +    qtest_writeq(qts, L2CC_BASE + L2CC_FLUSH64, 0x1234);
> +    g_assert_cmphex(qtest_readq(qts, L2CC_BASE + L2CC_MASTER15), ==, 0);
> +    qtest_quit(qts);
> +
> +    g_assert_true(g_file_get_contents(log_path, &log, NULL, NULL));
> +    g_assert_nonnull(strstr(log,
> +        "unimplemented device read (size 4, offset 0x40)"));
> +    g_assert_nonnull(strstr(log,
> +        "unimplemented device write (size 8, value 0x1234, offset 0x200)"));
> +    g_assert_nonnull(strstr(log,
> +        "unimplemented device read (size 8, offset 0x878)"));
> +    unlink(log_path);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    g_test_init(&argc, &argv, NULL);
> +
> +    if (qtest_has_machine("microchip-icicle-kit")) {
> +        qtest_add_func("/sifive_l2cc/registers", test_l2cc_registers);
> +        qtest_add_func("/sifive_l2cc/l2lim_topology", test_l2lim_topology);
> +        qtest_add_func("/sifive_l2cc/unimplemented", test_l2cc_unimplemented);
> +        qtest_add_func("/sifive_l2cc/migration", test_l2cc_migration);
> +    }
> +    if (qtest_has_machine("sifive_u")) {
> +        qtest_add_func("/sifive_l2cc/master_count", test_l2cc_master_count);
> +    }
> +
> +    return g_test_run();
> +}
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index ff4bf9528a..a001409de2 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -317,6 +317,7 @@ qtests_riscv32 = \
>   
>   qtests_riscv64 = ['riscv-csr-test'] + \
>     (unpack_edk2_blobs ? ['bios-tables-test'] : []) + \
> +  (config_all_devices.has_key('CONFIG_SIFIVE_L2CC') ? ['sifive_l2cc_test'] : []) + \
>     (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') and
>      config_all_devices.has_key('CONFIG_RISCV_IOMMU') ?
>      ['iommu-riscv-test'] : []) + \
> @@ -438,6 +439,8 @@ qtests = {
>     'erst-test': files('erst-test.c'),
>     'ivshmem-test': [rt, '../../contrib/ivshmem-server/ivshmem-server.c'],
>     'migration-test': test_migration_files + migration_tls_files + migration_colo_files,
> +  'sifive_l2cc_test': files('migration/migration-qmp.c',
> +                           'migration/migration-util.c'),
>     'pxe-test': files('boot-sector.c'),
>     'pnv-xive2-test': files('pnv-xive2-common.c', 'pnv-xive2-flush-sync.c',
>                             'pnv-xive2-nvpg_bar.c'),


