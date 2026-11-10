Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E98D606A8AF
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 20:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NDEwI889;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=O8hSu7Gm
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQsX1-0004UL-5h; Tue, 10 Nov 2026 15:33:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQsWi-0004KP-98
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 15:33:13 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQsWe-0002vy-IL
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 15:33:07 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AAJAIZv710817
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 20:33:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 l4tG7JpGT+NPI8b5PezvwCCxPAMep+kDg+knxlc1yb0=; b=NDEwI889x+n+7E1W
 oaMUep+YtqvDRa69twxizltWVPm5hG5xkS+FtSL9zuesRI/qHxhYmpVHffeYYTEz
 Lp+rMioKn9SJXN/j4I+y0pOLnTpyjSgzhp55olR2QMpQqr5CoK+6KwsEUmeznCqq
 EX2/BXetQZ5CEM2bcl54cEC7cKJqnytrh7AugxtLc3hgfN4zgExcvrZygQtw3hjv
 5D7x7FxWNDjdtLorXqvyTy2m35X/iixxxxNs8uNwAYEQmewnvLChjQEMpW8xjUVC
 HnI0jsAkQUQQ75+vWkx6fU8KT0BIWdhwSuBsGdTyw9PF+R+7v3Ons9t/ABuQ6dGH
 qjAizw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hv4pv9mmk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 20:33:01 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93e92aad34aso617437485a.0
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 12:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794342781; x=1794947581; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=l4tG7JpGT+NPI8b5PezvwCCxPAMep+kDg+knxlc1yb0=;
 b=O8hSu7Gmx8mm7faClpABdIGyginnrvvhvMRkT2goyOhxhm2SmOuXx0xVnqy4nqf2QS
 IgKCa+WfSbJ6TVTwIgKIhjwmO2qxA152wlVr/Sda9mN6R82kuU364PTmvJnnDmrBlLMf
 6I2ep5AKD/yDsZTss512oRiAo4ssQjILOzz43FiBXBi5/yBomlPKwWuQiMjjRsl3FrYZ
 03vK7XMeLxLUStOTx4S7idJ0a84x803GsiNNtV7bmYDNuAw1k9/CGco5GVZurdxgH0sM
 SRF5/VNJfFL1HCQAP4tzEVtfA94hkVVq7fQotqmlmuMSWVh55iHukFC8qm0fw29onhnF
 uGvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794342781; x=1794947581;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=l4tG7JpGT+NPI8b5PezvwCCxPAMep+kDg+knxlc1yb0=;
 b=OSAHo6gaaFdD17p2doW8lgbxzrDZHJkl8TiyCyw9DXUmbVXLPRynOszrErN4py2nez
 iUxQ12w2Gtnw7l2YR9FVNMgkgoZ3mRP9QUeOBNAzO0hlhZYp0TSC2pZbDoXAs7Rc6cQB
 A/hlXNoRZOPvp7YvI+e5tbpRoEqtNGSAeDWR9LffVRfwHENsBmfJy9hdXPNRdbz1DZj2
 Bx2ibTTtTXhl1XySTTJF0AX4p+Z7gIn8SZsk4xopjiCkgU883abFFz4DrwWWaAiX7jG3
 enMDvQhtpGL+U1IWfb0LmyHCmWlUdV4t1yuDB4imVyPs+Oyahq2mZiiktNHq7KyByyYb
 yEUA==
X-Forwarded-Encrypted: i=1;
 AL+hErG0SagcMqO3FD2pxi0LFLTy8Oz5LOIg0MFmcAB2EwjE/ZwVCbec5jSIpve2aENz4SQnND15+sAeGyYR@nongnu.org
X-Gm-Message-State: APuU4Z/iUiGaxIrfY+PyEjXiZ7ZNa57JL6IMekYlGwRofjOF6v6boENV
 GUg1PUH3U9JbL2uzPR4WKw3RYUryx9WhAQe/nh6UiPpbZUWoSxp5AEN1kWGOR7eYLkqnV5oGZcj
 pzF6hM2pXvrLHjxYq+mIhSNX4lC+dZcLtqGxs5Gnb2OLkmxxlNFF1iQU53A==
X-Gm-Gg: AYBFou2vGRFh1snpMuSyg5EZnpoUJ6YztIFpzlzGxhsXhd0AJMGvBP1eFXn5X0vWhoM
 nKcD48WN7g6DFATGRMaWyAxx7qb4VYb+jHHJjNJCA2pEQ39nPhytEWD+EUxv3qRSVTMBdIECjLA
 duXzIWkU7xHXguxYnwwvUDDHJ4gGcGuTLx+TVJfeDskkC2ufRpMX0C+3LTdR/F+mzeSa1IoDiXn
 jNFuuzxBrtKc2YuNmWeTKM8JYh4m14inMgnO8Upu3Jm+61VghJ52KZ+kJ9/H3usLQZAHuj4O2FY
 7RgYTver2T+HlkIRObT1yGlI1EpYmZNobHe1XxaCWRd8oI2I77vTRsR5fovs4ypFiVlCyFhHx6P
 5mv5M5zaKgZqo4of/UFTANlSnYfKYG8ays/OE/mTfk7pQuIKqHux1o5a4ytg4JBFbEXzN5coB7i
 T6nNZxmfjpHQ==
X-Received: by 2002:a05:620a:4048:b0:93e:c12c:43ff with SMTP id
 af79cd13be357-947b00a2e78mr17019585a.76.1794342780909; 
 Tue, 10 Nov 2026 12:33:00 -0800 (PST)
X-Received: by 2002:a05:620a:4048:b0:93e:c12c:43ff with SMTP id
 af79cd13be357-947b00a2e78mr17015985a.76.1794342780403; 
 Tue, 10 Nov 2026 12:33:00 -0800 (PST)
Received: from [192.168.68.105] ([152.234.124.231])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91ef04fb371sm29906346d6.25.2026.11.10.12.32.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Nov 2026 12:32:59 -0800 (PST)
Message-ID: <3caeec74-3ce9-484e-b9db-953a9db931b4@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 17:32:57 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 15/26] tests/qtest: Add PolarFire SoC RTC coverage
To: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>
Cc: Conor Dooley <conor@kernel.org>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>, qemu-riscv@nongnu.org
References: <20261104154207.641511-1-bin.meng@processmission.com>
 <20261104154207.641511-16-bin.meng@processmission.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261104154207.641511-16-bin.meng@processmission.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=XqZvqlF9 c=1 sm=1 tr=0 ts=6af37f7d cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=8elE1k/PHQNyZ14TNTodlQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=FRSEYCzRAAAA:8 a=EUspDBNiAAAA:8 a=69wJf7TsAAAA:8 a=hn0h2DJo3O1DtmxPrY4A:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=H4N_Y-AU75W7NKDNhZlT:22
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: ztlUzeFJvB9PorQ6HEGDWk4YvlQFwqGV
X-Proofpoint-GUID: ztlUzeFJvB9PorQ6HEGDWk4YvlQFwqGV
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA4MSBTYWx0ZWRfX/YtObzcFFuZK
 N8PZddlNaZjIEHSI/awxpCY1R70iRCnNHTHsVeMtDL9z811QmQwO3WV7El1uU0knLVw3Mydb0mq
 hat8PR2q4Z9HmB7zCX8i1/8ZNu5GF2w=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA4MSBTYWx0ZWRfXzOoI91jYhTuw
 w4csNc/6UE/XL/hPwj48Dvr828G6lKJeJYdOvppW8OVpjkxZ7AsdIO0VbxIDs/LNtvc+Rq06GNf
 1A2PIZ8JuUxK47VONUrpwvZ9leG75Pm9tP/Txi3TBPnjYZ4WjMVO0zhDRBtA4Bwt1kuaOuackVr
 WIHilbFeSwts36krGokz7/NN8TuAhR9JY7VWBx0FFLSge7SXxuB9+I6cUhTN+U4hDkG2jabgDk3
 NCAfj0qrqrGVS53niWNQtkzvhPcFv4TnAW8m+7AuFpf5bVES25Rf/6jvPK9VaABCmJfO2TYGT9y
 2jvN9F7vULY45iamlrWN8UA4css19KjVN4ZCXToIwimZmgOlbdD9LTv56vxFYDN9nsspLvHykeJ
 sKMwSwpdzLWGNtNVpgamXlGiLh8XnYQcyJaVHwqkc9qMsAmsRswCdRsa1btlwPcwT14lS6FV3Gi
 s6yFyfUnEquTSvVn+6Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611100081
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
> Exercise RTC register masks, binary counter, upload and stop controls,
> alarm and wakeup interrupt behavior, reset state, and PLIC wiring on
> the Icicle Kit.
> 
> Also verify RTC state and pending interrupt migration, including streams
> from QEMU versions that predate the RTC device.
> 
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
> 
> ---


Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

> 
> (no changes since v2)
> 
> Changes in v2:
> - Expect the documented hardware state after RTC reset
> 
>   MAINTAINERS                       |   1 +
>   tests/qtest/mchp_pfsoc_rtc_test.c | 315 ++++++++++++++++++++++++++++++
>   tests/qtest/meson.build           |   5 +-
>   3 files changed, 320 insertions(+), 1 deletion(-)
>   create mode 100644 tests/qtest/mchp_pfsoc_rtc_test.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a4e33654ef..a8343e3d55 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1834,6 +1834,7 @@ F: include/hw/misc/mchp_pfsoc_dmc.h
>   F: include/hw/misc/mchp_pfsoc_ioscb.h
>   F: include/hw/misc/mchp_pfsoc_sysreg.h
>   F: include/hw/rtc/mchp_pfsoc_rtc.h
> +F: tests/qtest/mchp_pfsoc_rtc_test.c
>   
>   Shakti C class SoC
>   L: qemu-riscv@nongnu.org
> diff --git a/tests/qtest/mchp_pfsoc_rtc_test.c b/tests/qtest/mchp_pfsoc_rtc_test.c
> new file mode 100644
> index 0000000000..ed96c15faa
> --- /dev/null
> +++ b/tests/qtest/mchp_pfsoc_rtc_test.c
> @@ -0,0 +1,315 @@
> +/*
> + * QTest testcase for the Microchip PolarFire SoC RTC
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
> +#include "qemu/bitops.h"
> +#include "qemu/bswap.h"
> +#include "qemu/timer.h"
> +#include "libqtest.h"
> +#include "migration/migration-qmp.h"
> +#include "migration/migration-util.h"
> +
> +#define RTC_BASE            0x20124000
> +#define RTC_CONTROL         0x00
> +#define RTC_MODE            0x04
> +#define RTC_PRESCALER       0x08
> +#define RTC_ALARM_LOWER     0x0c
> +#define RTC_ALARM_UPPER     0x10
> +#define RTC_COMPARE_LOWER   0x14
> +#define RTC_COMPARE_UPPER   0x18
> +#define RTC_DATETIME_LOWER  0x20
> +#define RTC_DATETIME_UPPER  0x24
> +#define RTC_RUNNING         BIT(0)
> +#define RTC_STOP            BIT(1)
> +#define RTC_ALARM_ON        BIT(2)
> +#define RTC_ALARM_OFF       BIT(3)
> +#define RTC_UPLOAD          BIT(5)
> +#define RTC_MATCH           BIT(7)
> +#define RTC_WAKEUP_CLEAR    BIT(8)
> +#define RTC_WAKEUP_SET      BIT(9)
> +#define RTC_UPDATED         BIT(10)
> +#define RTC_WAKEUP_ENABLE   BIT(1)
> +#define RTC_WAKEUP_RESET    BIT(2)
> +#define RTC_WAKEUP_CONTINUE BIT(3)
> +#define RTC_PRESCALER_MASK  0x03ffffff
> +#define RTC_UPPER_MASK      0x3fffffff
> +#define PLIC_BASE           0x0c000000
> +#define PLIC_PENDING        0x1000
> +#define PLIC_RTC_PENDING    (BIT(16) | BIT(17))
> +#define ENVM_BASE           0x20220000
> +#define HSS_HEADER_SIZE     0x100
> +#define HSS_HEADER_JUMP     0x1000006f
> +#define HSS_PAYLOAD_BASE    (ENVM_BASE + HSS_HEADER_SIZE)
> +#define HSS_PAYLOAD_SIZE    8
> +
> +static QTestState *microchip_icicle_kit_start_rtc(const char *firmware)
> +{
> +    return qtest_initf(
> +        "-machine microchip-icicle-kit -smp 5 -m 2G -bios \"%s\" "
> +        "-rtc clock=vm", firmware);
> +}
> +
> +static QTestState *microchip_icicle_kit_start_ext(const char *qemu_var,
> +                                                  const char *firmware)
> +{
> +    g_autofree char *args = g_strdup_printf(
> +        "-machine microchip-icicle-kit -smp 5 -m 2G -bios \"%s\"",
> +        firmware);
> +
> +    return qtest_init_ext(qemu_var, args, NULL, true);
> +}
> +
> +static char *create_firmware(void)
> +{
> +    uint8_t firmware[HSS_HEADER_SIZE + HSS_PAYLOAD_SIZE] = { 0 };
> +    static const uint8_t payload[] = {
> +        0x13, 0x00, 0x00, 0x00,
> +        0x6f, 0x00, 0x00, 0x00,
> +    };
> +    char *path;
> +    int fd;
> +    ssize_t written;
> +    unsigned int i;
> +
> +    stl_le_p(&firmware[0], HSS_HEADER_JUMP);
> +    stl_le_p(&firmware[4], HSS_PAYLOAD_SIZE);
> +    for (i = 0; i < 5; i++) {
> +        stl_le_p(&firmware[8 + i * sizeof(uint32_t)], HSS_PAYLOAD_BASE);
> +    }
> +    memcpy(&firmware[HSS_HEADER_SIZE], payload, sizeof(payload));
> +
> +    fd = g_file_open_tmp("microchip-icicle-kit-XXXXXX", &path, NULL);
> +    g_assert_cmpint(fd, >=, 0);
> +
> +    written = write(fd, firmware, sizeof(firmware));
> +    g_assert_cmpint(written, ==, sizeof(firmware));
> +    close(fd);
> +
> +    return path;
> +}
> +
> +static uint64_t rtc_read_binary_count(QTestState *qts)
> +{
> +    uint64_t count = qtest_readl(qts, RTC_BASE + RTC_DATETIME_LOWER);
> +
> +    count |= (uint64_t)qtest_readl(qts,
> +                                   RTC_BASE + RTC_DATETIME_UPPER) << 32;
> +    return count;
> +}
> +
> +static void test_rtc(void)
> +{
> +    g_autofree char *firmware = create_firmware();
> +    QTestState *qts = microchip_icicle_kit_start_rtc(firmware);
> +    uint32_t control;
> +
> +    unlink(firmware);
> +    qtest_irq_intercept_out_named(qts, "/machine/soc/rtc", "sysbus-irq");
> +
> +    g_assert_cmphex(qtest_readl(qts, RTC_BASE + RTC_CONTROL), ==, 0);
> +    g_assert_cmphex(rtc_read_binary_count(qts), ==, 0);
> +    qtest_clock_step(qts, 2 * NANOSECONDS_PER_SECOND);
> +    g_assert_cmphex(rtc_read_binary_count(qts), ==, 0);
> +
> +    qtest_writel(qts, RTC_BASE + RTC_MODE, UINT32_MAX);
> +    qtest_writel(qts, RTC_BASE + RTC_PRESCALER, UINT32_MAX);
> +    g_assert_cmphex(qtest_readl(qts, RTC_BASE + RTC_MODE), ==, 0xf);
> +    g_assert_cmphex(qtest_readl(qts, RTC_BASE + RTC_PRESCALER), ==,
> +                    RTC_PRESCALER_MASK);
> +    qtest_writel(qts, RTC_BASE + RTC_MODE, 0);
> +
> +    qtest_writel(qts, RTC_BASE + RTC_CONTROL, RTC_STOP);
> +    g_assert_cmphex(qtest_readl(qts, RTC_BASE + RTC_CONTROL) &
> +                    RTC_RUNNING, ==, 0);
> +    qtest_clock_step(qts, 2 * NANOSECONDS_PER_SECOND);
> +    g_assert_cmphex(rtc_read_binary_count(qts), ==, 0);
> +
> +    qtest_writel(qts, RTC_BASE + RTC_DATETIME_LOWER, 42);
> +    qtest_writel(qts, RTC_BASE + RTC_DATETIME_UPPER, 0);
> +    qtest_writel(qts, RTC_BASE + RTC_CONTROL, RTC_UPLOAD);
> +    g_assert_cmphex(rtc_read_binary_count(qts), ==, 42);
> +    g_assert_cmphex(qtest_readl(qts, RTC_BASE + RTC_CONTROL) &
> +                    (RTC_UPLOAD | RTC_UPDATED), ==, RTC_UPDATED);
> +
> +    qtest_writel(qts, RTC_BASE + RTC_CONTROL, RTC_RUNNING);
> +    qtest_clock_step(qts, NANOSECONDS_PER_SECOND);
> +    g_assert_cmphex(rtc_read_binary_count(qts), ==, 43);
> +    qtest_writel(qts, RTC_BASE + RTC_CONTROL, RTC_WAKEUP_SET);
> +    g_assert_true(qtest_get_irq(qts, 0));
> +    qtest_writel(qts, RTC_BASE + RTC_CONTROL, RTC_WAKEUP_CLEAR);
> +    g_assert_false(qtest_get_irq(qts, 0));
> +
> +    qtest_writel(qts, RTC_BASE + RTC_ALARM_LOWER, 45);
> +    qtest_writel(qts, RTC_BASE + RTC_ALARM_UPPER, 0);
> +    qtest_writel(qts, RTC_BASE + RTC_COMPARE_LOWER, UINT32_MAX);
> +    qtest_writel(qts, RTC_BASE + RTC_COMPARE_UPPER, RTC_UPPER_MASK);
> +    qtest_writel(qts, RTC_BASE + RTC_MODE,
> +                 RTC_WAKEUP_ENABLE | RTC_WAKEUP_CONTINUE);
> +    qtest_writel(qts, RTC_BASE + RTC_CONTROL, RTC_ALARM_ON);
> +    g_assert_false(qtest_get_irq(qts, 0));
> +    g_assert_false(qtest_get_irq(qts, 1));
> +    control = qtest_readl(qts, RTC_BASE + RTC_CONTROL);
> +    g_assert_cmphex(control & RTC_ALARM_ON, ==, RTC_ALARM_ON);
> +    qtest_writel(qts, RTC_BASE + RTC_CONTROL, control | RTC_ALARM_OFF);
> +    g_assert_cmphex(qtest_readl(qts, RTC_BASE + RTC_CONTROL) &
> +                    RTC_ALARM_ON, ==, 0);
> +    qtest_clock_step(qts, 2 * NANOSECONDS_PER_SECOND);
> +    g_assert_false(qtest_get_irq(qts, 0));
> +    g_assert_false(qtest_get_irq(qts, 1));
> +
> +    qtest_writel(qts, RTC_BASE + RTC_DATETIME_LOWER, 43);
> +    qtest_writel(qts, RTC_BASE + RTC_CONTROL, RTC_UPLOAD);
> +    qtest_writel(qts, RTC_BASE + RTC_CONTROL, RTC_ALARM_ON);
> +    qtest_clock_step(qts, 2 * NANOSECONDS_PER_SECOND);
> +    g_assert_true(qtest_get_irq(qts, 0));
> +    g_assert_true(qtest_get_irq(qts, 1));
> +    g_assert_cmphex(qtest_readl(qts, RTC_BASE + RTC_CONTROL) & RTC_MATCH,
> +                    ==, RTC_MATCH);
> +    qtest_writel(qts, RTC_BASE + RTC_CONTROL, RTC_ALARM_OFF);
> +    g_assert_false(qtest_get_irq(qts, 0));
> +    g_assert_false(qtest_get_irq(qts, 1));
> +
> +    qtest_writel(qts, RTC_BASE + RTC_DATETIME_LOWER, 0);
> +    qtest_writel(qts, RTC_BASE + RTC_DATETIME_UPPER, 0);
> +    qtest_writel(qts, RTC_BASE + RTC_CONTROL, RTC_UPLOAD);
> +    qtest_writel(qts, RTC_BASE + RTC_ALARM_LOWER, 2);
> +    qtest_writel(qts, RTC_BASE + RTC_MODE,
> +                 RTC_WAKEUP_ENABLE | RTC_WAKEUP_RESET |
> +                 RTC_WAKEUP_CONTINUE);
> +    qtest_writel(qts, RTC_BASE + RTC_CONTROL, RTC_ALARM_ON);
> +    qtest_clock_step(qts, 2 * NANOSECONDS_PER_SECOND);
> +    g_assert_true(qtest_get_irq(qts, 0));
> +    g_assert_cmphex(rtc_read_binary_count(qts), ==, 0);
> +    g_assert_cmphex(qtest_readl(qts, RTC_BASE + RTC_CONTROL) &
> +                    RTC_ALARM_ON, ==, RTC_ALARM_ON);
> +    qtest_writel(qts, RTC_BASE + RTC_CONTROL, RTC_WAKEUP_CLEAR);
> +    qtest_clock_step(qts, 2 * NANOSECONDS_PER_SECOND);
> +    g_assert_true(qtest_get_irq(qts, 0));
> +    g_assert_cmphex(rtc_read_binary_count(qts), ==, 0);
> +    qtest_writel(qts, RTC_BASE + RTC_CONTROL, RTC_ALARM_OFF);
> +    g_assert_false(qtest_get_irq(qts, 0));
> +    g_assert_false(qtest_get_irq(qts, 1));
> +
> +    qtest_system_reset(qts);
> +    g_assert_cmphex(qtest_readl(qts, RTC_BASE + RTC_CONTROL), ==, 0);
> +    g_assert_cmphex(qtest_readl(qts, RTC_BASE + RTC_MODE), ==, 0);
> +    g_assert_cmphex(qtest_readl(qts, RTC_BASE + RTC_PRESCALER), ==, 0);
> +    g_assert_false(qtest_get_irq(qts, 0));
> +    g_assert_false(qtest_get_irq(qts, 1));
> +
> +    qtest_quit(qts);
> +}
> +
> +static void test_rtc_plic(void)
> +{
> +    g_autofree char *firmware = create_firmware();
> +    QTestState *qts = microchip_icicle_kit_start_rtc(firmware);
> +
> +    unlink(firmware);
> +
> +    qtest_writel(qts, RTC_BASE + RTC_DATETIME_LOWER, 42);
> +    qtest_writel(qts, RTC_BASE + RTC_DATETIME_UPPER, 0);
> +    qtest_writel(qts, RTC_BASE + RTC_CONTROL, RTC_UPLOAD);
> +    qtest_writel(qts, RTC_BASE + RTC_CONTROL, RTC_RUNNING);
> +    qtest_writel(qts, RTC_BASE + RTC_ALARM_LOWER, 43);
> +    qtest_writel(qts, RTC_BASE + RTC_ALARM_UPPER, 0);
> +    qtest_writel(qts, RTC_BASE + RTC_COMPARE_LOWER, UINT32_MAX);
> +    qtest_writel(qts, RTC_BASE + RTC_COMPARE_UPPER, RTC_UPPER_MASK);
> +    qtest_writel(qts, RTC_BASE + RTC_MODE,
> +                 RTC_WAKEUP_ENABLE | RTC_WAKEUP_CONTINUE);
> +    qtest_writel(qts, RTC_BASE + RTC_CONTROL, RTC_ALARM_ON);
> +    qtest_clock_step(qts, NANOSECONDS_PER_SECOND);
> +
> +    g_assert_cmphex(qtest_readl(qts, PLIC_BASE + PLIC_PENDING + 8) &
> +                    PLIC_RTC_PENDING, ==, PLIC_RTC_PENDING);
> +
> +    qtest_quit(qts);
> +}
> +
> +static void test_machine_migration(void)
> +{
> +    g_autofree char *firmware = create_firmware();
> +    const char *old_qemu = g_getenv("QTEST_QEMU_BINARY_OLD");
> +    QTestState *from;
> +    QTestState *to = qtest_initf(
> +        "-machine microchip-icicle-kit -smp 5 -m 2G "
> +        "-bios \"%s\" -incoming defer "
> +        "-rtc clock=vm", firmware);
> +
> +    qtest_irq_intercept_out_named(to, "/machine/soc/rtc", "sysbus-irq");
> +
> +    /* Allow an older QEMU source to exercise migration compatibility */
> +    if (old_qemu) {
> +        from = microchip_icicle_kit_start_ext("QTEST_QEMU_BINARY_OLD",
> +                                              firmware);
> +    } else {
> +        from = microchip_icicle_kit_start_rtc(firmware);
> +        qtest_writel(from, RTC_BASE + RTC_DATETIME_LOWER, 0x23456789);
> +        qtest_writel(from, RTC_BASE + RTC_DATETIME_UPPER, 1);
> +        qtest_writel(from, RTC_BASE + RTC_CONTROL, RTC_UPLOAD);
> +        qtest_writel(from, RTC_BASE + RTC_CONTROL, RTC_RUNNING);
> +        qtest_writel(from, RTC_BASE + RTC_ALARM_LOWER, 0x2345678b);
> +        qtest_writel(from, RTC_BASE + RTC_ALARM_UPPER, 1);
> +        qtest_writel(from, RTC_BASE + RTC_COMPARE_LOWER, UINT32_MAX);
> +        qtest_writel(from, RTC_BASE + RTC_COMPARE_UPPER, RTC_UPPER_MASK);
> +        qtest_writel(from, RTC_BASE + RTC_MODE,
> +                     RTC_WAKEUP_ENABLE | RTC_WAKEUP_CONTINUE);
> +        qtest_writel(from, RTC_BASE + RTC_CONTROL, RTC_ALARM_ON);
> +        qtest_writel(from, RTC_BASE + RTC_CONTROL, RTC_WAKEUP_SET);
> +        qtest_writel(from, RTC_BASE + RTC_PRESCALER, 999999);
> +    }
> +
> +    unlink(firmware);
> +
> +    migrate_incoming_qmp(to, "tcp:127.0.0.1:0", NULL, "{}");
> +    migrate_qmp(from, to, NULL, NULL, "{}");
> +    wait_for_migration_complete(from);
> +
> +    if (old_qemu) {
> +        g_assert_cmphex(qtest_readl(to, RTC_BASE + RTC_CONTROL), ==, 0);
> +        g_assert_cmphex(qtest_readl(to, RTC_BASE + RTC_PRESCALER), ==, 0);
> +        g_assert_false(qtest_get_irq(to, 0));
> +        g_assert_false(qtest_get_irq(to, 1));
> +    } else {
> +        g_assert_cmphex(rtc_read_binary_count(to), ==, 0x123456789);
> +        g_assert_cmphex(qtest_readl(to, RTC_BASE + RTC_CONTROL) &
> +                        (RTC_RUNNING | RTC_ALARM_ON), ==,
> +                        RTC_RUNNING | RTC_ALARM_ON);
> +        g_assert_cmphex(qtest_readl(to, RTC_BASE + RTC_PRESCALER), ==,
> +                        999999);
> +        g_assert_true(qtest_get_irq(to, 0));
> +        g_assert_false(qtest_get_irq(to, 1));
> +        qtest_writel(to, RTC_BASE + RTC_CONTROL, RTC_WAKEUP_CLEAR);
> +        g_assert_false(qtest_get_irq(to, 0));
> +        qtest_clock_step(to, 2 * NANOSECONDS_PER_SECOND);
> +        g_assert_cmphex(rtc_read_binary_count(to), ==, 0x12345678b);
> +        g_assert_true(qtest_get_irq(to, 0));
> +        g_assert_true(qtest_get_irq(to, 1));
> +        qtest_writel(to, RTC_BASE + RTC_CONTROL, RTC_ALARM_OFF);
> +        g_assert_false(qtest_get_irq(to, 0));
> +        g_assert_false(qtest_get_irq(to, 1));
> +    }
> +
> +    qtest_quit(from);
> +    qtest_quit(to);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    g_test_init(&argc, &argv, NULL);
> +
> +    qtest_add_func("/mchp_pfsoc_rtc/registers", test_rtc);
> +    qtest_add_func("/mchp_pfsoc_rtc/plic", test_rtc_plic);
> +    qtest_add_func("/mchp_pfsoc_rtc/migration",
> +                   test_machine_migration);
> +
> +    return g_test_run();
> +}
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index d08fbc1eb7..3fe0786af2 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -318,7 +318,8 @@ qtests_riscv32 = \
>   qtests_riscv64 = ['riscv-csr-test'] + \
>     (unpack_edk2_blobs ? ['bios-tables-test'] : []) + \
>     (config_all_devices.has_key('CONFIG_MICROCHIP_PFSOC') ?
> -   ['cadence-sdhci-test'] : []) + \
> +   ['cadence-sdhci-test',
> +    'mchp_pfsoc_rtc_test'] : []) + \
>     (config_all_devices.has_key('CONFIG_SIFIVE_L2CC') ? ['sifive_l2cc_test'] : []) + \
>     (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') and
>      config_all_devices.has_key('CONFIG_RISCV_IOMMU') ?
> @@ -443,6 +444,8 @@ qtests = {
>     'migration-test': test_migration_files + migration_tls_files + migration_colo_files,
>     'sifive_l2cc_test': files('migration/migration-qmp.c',
>                              'migration/migration-util.c'),
> +  'mchp_pfsoc_rtc_test': files('migration/migration-qmp.c',
> +                               'migration/migration-util.c'),
>     'pxe-test': files('boot-sector.c'),
>     'pnv-xive2-test': files('pnv-xive2-common.c', 'pnv-xive2-flush-sync.c',
>                             'pnv-xive2-nvpg_bar.c'),


