Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 621C1C5AC7A
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 16:41:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsNd6-0001mB-Na; Fri, 07 Aug 2026 12:41:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wsNd4-0001l1-LM
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 12:41:06 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wsNd1-0003q5-Qh
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 12:41:06 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 677GOFDs1149865
 for <qemu-devel@nongnu.org>; Fri, 7 Aug 2026 16:41:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PcumGsmvmvxvWZt6EQnxRugUtRGODPJixspYkK0rgKc=; b=Aopc2FoO7wRG7wxA
 IUUGuLGA8rteAShXQbIKwny1912QpD0wdqMHJXcm0ptfWdJxOTud4a7pLhhHIc4C
 Lak1+J+uZbylG683Yo+YaslMHIRIt19MvVrvDGatYYhsJFicgOHZAPsqv7zmC9kX
 r64RQYV5Pm8WUhmnEbuejwNbiJCsBwr6KWtcb0/FGx+qJHbVElinbdEIUbYmnGCx
 Pvz7lMw+uuVI9MT3MfyoLUhUgkxu5cX92hqE8+CWgVj4Gwm2Llxf1bmOu32XtNHD
 FNjJIfVITbVA8aBOVYIRjrt+ZN127QoslNwprUw4hN4jj39pcM2dZrPSFNjTJipy
 eMRD3w==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwhk3genm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 16:41:02 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c1b4d961dso19179711cf.1
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 09:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786120861; x=1786725661; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PcumGsmvmvxvWZt6EQnxRugUtRGODPJixspYkK0rgKc=;
 b=SErxqM4fdyJmm+61XwWCa4U2bWDVLvYuw4/FDJToWgoXxCEWHjZVpuwRpHuk5VLR3H
 qoqVsNN3TuT8kV0bie6IEKPSGlKzawxMD5Hl5xo+EdrRQ2ZUyOB/7LrqDGFZQns97981
 CUNqRMI9fAiDF+vrem6fH7yjIdlPgaLhdD3FjelIOEDlBl53RndrPmDdNGfELpzKdgBd
 gwv85QWksHHqiLCOXSSMFLe686Sdo9ADRpo1UwnzkBsgZEiOVc2krxRm5AEr+A8GOmfH
 Pk6tWoCFwPz42qPPRO/fElvDlQhOTeQb8kNXAaU1MjiuX6newEGMUQvNSwxmkZ4jyZqx
 +ORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786120861; x=1786725661;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PcumGsmvmvxvWZt6EQnxRugUtRGODPJixspYkK0rgKc=;
 b=amKVXuUJEW4pcrcWjGd4eVjvtnUDwDs8Sg/UL7TOY7R8qHiC/o4AxUvHtJGCHLqJ4/
 MRjZp/6Pk9kvMsIeRR9BVfBvvkAwNunKZksaTDMGq1OFqJr9BetMzVxsUsZveFJneRta
 5YuxItc1b07Gbx1NHBHksXBf0kWjUk5tpTRhNL07/oI0S3H8uNZg2Fv4JyfPjDj3GF5w
 RsRk88yFotjCfJaytRCxsqmOhpWpcMAESswVeGTtU9UhSLbZbIKroi2UPcyxZ3pVWlVv
 ENTnl5IKhzdwJUe+xtfSoYCLONDpa6KmUVbcInbFMU+YSr1f9sQv4ItbmJkcdD3EIELW
 p9bQ==
X-Gm-Message-State: AOJu0YwxcbXemx+it0hq50thysYfV4fo3i+2qrJ8vj6eVqe8bvwtG3nw
 9uAnE6jUdGpAXxdx6tsGxPrI++dnUkMboX93ExtS7jpuZV9ZXmfES6skylNFdbHiBPwFkAuxIMI
 eAB3SH4T8K+toFGZTY/zRVspB13+3PanXxMHzSGeYvH+jblGFNzHs4DSUxA==
X-Gm-Gg: AR+sD10rl7VBVOq1b3me5sHG4WIrycUK9naKcdasBVhs5m5T9elnilm5ZBFIKaBg/rG
 +oaw4gAvCyHEZGkOFX1GI6f9ZWCFmSp4UIwc4cCuj/td7LlKk9P279uaW3EGsy53FIUhD3RPj2o
 iJwUeRy2n/5W975XtClL5a9ecoqn3dL24Hc7FoTcmBi84sjOBVgNzbiTYwh2MTOKHG/dyVZuaAh
 31/osTrh8kH/kNBX8VHvdIpAq9SIlWbBZTfOuEASRXEjWT4b9hMJ+LtdW4Bn8tBPUGC6VuYvl/2
 xNWnHC9xd/EMgC9oLWHh1FqexPcXdribxzDD+TFg98j76Y2WX1fW4VIU+sMmAeEulPnvkI6TL8d
 q307a7KgCvM7trIsk9rypCNuFJjWhrAt1PpzE
X-Received: by 2002:ac8:5949:0:b0:51b:e946:45cd with SMTP id
 d75a77b69052e-52d218e82e5mr15110151cf.14.1786120860808; 
 Fri, 07 Aug 2026 09:41:00 -0700 (PDT)
X-Received: by 2002:ac8:5949:0:b0:51b:e946:45cd with SMTP id
 d75a77b69052e-52d218e82e5mr15109121cf.14.1786120860251; 
 Fri, 07 Aug 2026 09:41:00 -0700 (PDT)
Received: from [192.168.68.104] ([187.11.154.152])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52d1659c1d8sm15807131cf.16.2026.08.07.09.40.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Aug 2026 09:40:59 -0700 (PDT)
Message-ID: <dbe4c9c0-b202-4265-bdcc-6f900409a972@oss.qualcomm.com>
Date: Fri, 7 Aug 2026 13:40:55 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] tests/qtest: expand K230 I2C controller tests
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
 <20260807152830.6833-5-wzy15515798875@gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260807152830.6833-5-wzy15515798875@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=RKaD2Yi+ c=1 sm=1 tr=0 ts=6a760a9e cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=iMfxv9gflPUPBcmW7/Gq5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=FxexUvcVwA1O1iOrnkgA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDEzMCBTYWx0ZWRfXzfZm3bQX9EQZ
 E7RfXjGbE6eQMnP6w2xoZzUP7l8L0vOfyWJ908auowI0Ge81QoMM/if1tT6BfTPQeAXarW354rf
 9laQzZGV89gEfO4U9I1bR+gUdhNJ7Jg=
X-Proofpoint-ORIG-GUID: G93OitY1JW7-s2rSFzE69hgXfFkqv6pQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDEzMCBTYWx0ZWRfX0CHuopD0wc6l
 KSx4+byL14Lb44KIbgUIIrdeNuwBsb/DhRr+vEhzXOPXJtb2OzZSSs4N8y4xvFVq3n09SYk6hZ6
 StSwR5agKo7yAEAn25i1M6aCOpvHsZKRZ7/T5X1AJgqs79TztguO48OEMoI9O4jZXuzxAAFl/x0
 XzVgcIY3pq7hw+BxQ8g10SRw13AwtagulwLGKepB1OWRxlHosmWdFYuLGX0XMiQaxx+q8ScIfmO
 /SL5QeTGXtRgcpzRyfZobLMUgp36u9xCc0tkG0LPFPDx5q09oG/zQZ1/JOkNFRqOgxgNnsMgR6M
 3oBDOGEM9FyKeT9M/muimjzbJhdqtZiuFySkx16N68MXL9Giuvc+1+tWWenxs9ewKfQ3LufMw/M
 FZGzNLg/3UG6Jm7aabRW1twHRvkCVecbdUFw5zDmIcO7fqbGWLTrxA3v1LodlKAZL9IIXYBSuZH
 cBwLsxt6PtswBL/Vnpw==
X-Proofpoint-GUID: G93OitY1JW7-s2rSFzE69hgXfFkqv6pQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 phishscore=0 impostorscore=0
 adultscore=0 spamscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070130
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
> Expand the K230 I2C qtests to cover instance isolation, read-only
> registers, system reset, read-to-clear interrupts, abort source
> reporting, and START BYTE abort handling.
> 
> Signed-off-by: Wang Zhongyu <wzy15515798875@gmail.com>
> ---


Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   tests/qtest/k230-i2c-test.c | 532 +++++++++++++++++++++++++++++++++++-
>   1 file changed, 529 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/qtest/k230-i2c-test.c b/tests/qtest/k230-i2c-test.c
> index cc8dd54153..1d134de5d0 100644
> --- a/tests/qtest/k230-i2c-test.c
> +++ b/tests/qtest/k230-i2c-test.c
> @@ -25,11 +25,18 @@
>   #define K230_IC_SAR                    0x08
>   #define K230_IC_HS_MADDR               0x0c
>   #define K230_IC_DATA_CMD               0x10
> +#define K230_IC_SS_SCL_HCNT            0x14
> +#define K230_IC_SS_SCL_LCNT            0x18
> +#define K230_IC_FS_SCL_HCNT            0x1c
> +#define K230_IC_FS_SCL_LCNT            0x20
> +#define K230_IC_HS_SCL_HCNT            0x24
> +#define K230_IC_HS_SCL_LCNT            0x28
>   #define K230_IC_INTR_STAT              0x2c
>   #define K230_IC_INTR_MASK              0x30
>   #define K230_IC_RAW_INTR_STAT          0x34
>   #define K230_IC_RX_TL                  0x38
>   #define K230_IC_TX_TL                  0x3c
> +#define K230_IC_CLR_INTR               0x40
>   #define K230_IC_CLR_RX_UNDER           0x44
>   #define K230_IC_CLR_TX_ABRT            0x54
>   #define K230_IC_ENABLE                 0x6c
> @@ -37,20 +44,32 @@
>   #define K230_IC_TXFLR                  0x74
>   #define K230_IC_RXFLR                  0x78
>   #define K230_IC_TX_ABRT_SOURCE         0x80
> +#define K230_IC_SDA_SETUP              0x94
> +#define K230_IC_ACK_GENERAL_CALL       0x98
>   #define K230_IC_ENABLE_STATUS          0x9c
>   #define K230_IC_COMP_PARAM_1           0xf4
>   #define K230_IC_COMP_VERSION           0xf8
>   #define K230_IC_COMP_TYPE              0xfc
>   
> +/* IC_CON */
> +#define IC_CON_MASTER_MODE             BIT(0)
>   #define IC_CON_10BITADDR_MASTER        BIT(4)
> +#define IC_CON_RESTART_EN              BIT(5)
> +
> +/* IC_TAR */
> +#define IC_TAR_GC_OR_START             BIT(10)
> +#define IC_TAR_SPECIAL                 BIT(11)
>   
>   /* IC_DATA_CMD */
> +#define IC_DATA_CMD_READ               BIT(8)
>   #define IC_DATA_CMD_STOP               BIT(9)
>   
>   /* IC_INTR_STAT and IC_RAW_INTR_STAT */
>   #define IC_INTR_RX_UNDER               BIT(0)
>   #define IC_INTR_TX_EMPTY               BIT(4)
>   #define IC_INTR_TX_ABRT                BIT(6)
> +#define IC_INTR_ACTIVITY               BIT(8)
> +#define IC_INTR_START_DET              BIT(10)
>   
>   /* IC_STATUS */
>   #define IC_STATUS_TFNF                 BIT(1)
> @@ -58,6 +77,10 @@
>   
>   /* IC_TX_ABRT_SOURCE */
>   #define IC_ABRT_7B_ADDR_NOACK          BIT(0)
> +#define IC_ABRT_GCALL_NOACK            BIT(4)
> +#define IC_ABRT_GCALL_READ             BIT(5)
> +#define IC_ABRT_SBYTE_NORSTRT          BIT(9)
> +#define IC_ABRT_MASTER_DIS             BIT(11)
>   
>   #define K230_IC_COMP_PARAM_1_VALUE     0x001f3fae
>   #define K230_IC_COMP_VERSION_VALUE     0x3132302a
> @@ -131,6 +154,38 @@ static void test_all_instances(void)
>       qtest_quit(qts);
>   }
>   
> +static void test_instance_isolation(void)
> +{
> +    QTestState *qts = qtest_init("-machine k230");
> +
> +    qtest_writel(qts, K230_I2C0_BASE + K230_IC_TAR, 0x2a);
> +    qtest_writel(qts, K230_I2C0_BASE + K230_IC_RX_TL, 17);
> +    qtest_writel(qts, K230_I2C0_BASE + K230_IC_INTR_MASK, 0x41);
> +
> +    g_assert_cmphex(qtest_readl(qts, K230_I2C0_BASE + K230_IC_TAR),
> +                    ==, 0x2a);
> +    g_assert_cmphex(qtest_readl(qts, K230_I2C0_BASE + K230_IC_RX_TL),
> +                    ==, 17);
> +    g_assert_cmphex(qtest_readl(qts,
> +                               K230_I2C0_BASE + K230_IC_INTR_MASK),
> +                    ==, 0x41);
> +
> +    for (int i = 1; i < K230_I2C_COUNT; i++) {
> +        g_assert_cmphex(qtest_readl(qts,
> +                                   k230_i2c_base[i] + K230_IC_TAR),
> +                        ==, 0x55);
> +        g_assert_cmphex(qtest_readl(qts,
> +                                   k230_i2c_base[i] + K230_IC_RX_TL),
> +                        ==, 0);
> +        g_assert_cmphex(qtest_readl(qts,
> +                                   k230_i2c_base[i] +
> +                                   K230_IC_INTR_MASK),
> +                        ==, 0x8ff);
> +    }
> +
> +    qtest_quit(qts);
> +}
> +
>   static void test_register_access(void)
>   {
>       QTestState *qts = qtest_init("-machine k230");
> @@ -163,6 +218,82 @@ static void test_register_access(void)
>       g_assert_cmphex(qtest_readl(qts, K230_I2C0_BASE + K230_IC_TX_TL),
>                       ==, 32);
>   
> +    qtest_writel(qts, K230_I2C0_BASE + K230_IC_INTR_MASK,
> +                 UINT32_MAX);
> +    g_assert_cmphex(qtest_readl(qts,
> +                               K230_I2C0_BASE + K230_IC_INTR_MASK),
> +                    ==, 0xfff);
> +
> +    qtest_writel(qts, K230_I2C0_BASE + K230_IC_SDA_SETUP,
> +                 UINT32_MAX);
> +    g_assert_cmphex(qtest_readl(qts,
> +                               K230_I2C0_BASE + K230_IC_SDA_SETUP),
> +                    ==, 0xff);
> +
> +    qtest_writel(qts, K230_I2C0_BASE + K230_IC_ACK_GENERAL_CALL,
> +                 UINT32_MAX);
> +    g_assert_cmphex(qtest_readl(qts,
> +                               K230_I2C0_BASE +
> +                               K230_IC_ACK_GENERAL_CALL),
> +                    ==, 1);
> +
> +    qtest_writel(qts, K230_I2C0_BASE + K230_IC_TX_ABRT_SOURCE,
> +                 UINT32_MAX);
> +    g_assert_cmphex(qtest_readl(qts,
> +                               K230_I2C0_BASE +
> +                               K230_IC_TX_ABRT_SOURCE),
> +                    ==, 0xffff);
> +
> +    qtest_writel(qts, K230_I2C0_BASE + K230_IC_SS_SCL_HCNT,
> +                 65525);
> +    g_assert_cmphex(qtest_readl(qts,
> +                               K230_I2C0_BASE +
> +                               K230_IC_SS_SCL_HCNT),
> +                    ==, 65525);
> +
> +    /*
> +     * Values greater than 65525 are rejected. The previous valid
> +     * value must be preserved.
> +     */
> +    qtest_writel(qts, K230_I2C0_BASE + K230_IC_SS_SCL_HCNT,
> +                 65526);
> +    g_assert_cmphex(qtest_readl(qts,
> +                               K230_I2C0_BASE +
> +                               K230_IC_SS_SCL_HCNT),
> +                    ==, 65525);
> +
> +    qtest_quit(qts);
> +}
> +
> +static void test_readonly_registers(void)
> +{
> +    static const struct {
> +        uint32_t offset;
> +        uint32_t expected;
> +    } registers[] = {
> +        { K230_IC_INTR_STAT,     0 },
> +        { K230_IC_RAW_INTR_STAT, 0 },
> +        { K230_IC_STATUS,        IC_STATUS_TFNF | IC_STATUS_TFE },
> +        { K230_IC_TXFLR,         0 },
> +        { K230_IC_RXFLR,         0 },
> +        { K230_IC_ENABLE_STATUS, 0 },
> +        { K230_IC_COMP_PARAM_1,  K230_IC_COMP_PARAM_1_VALUE },
> +        { K230_IC_COMP_VERSION,  K230_IC_COMP_VERSION_VALUE },
> +        { K230_IC_COMP_TYPE,     K230_IC_COMP_TYPE_VALUE },
> +    };
> +    QTestState *qts = qtest_init("-machine k230");
> +
> +    for (size_t i = 0; i < G_N_ELEMENTS(registers); i++) {
> +        qtest_writel(qts,
> +                     K230_I2C0_BASE + registers[i].offset,
> +                     UINT32_MAX);
> +
> +        g_assert_cmphex(qtest_readl(qts,
> +                                   K230_I2C0_BASE +
> +                                   registers[i].offset),
> +                        ==, registers[i].expected);
> +    }
> +
>       qtest_quit(qts);
>   }
>   
> @@ -171,15 +302,78 @@ static void test_register_lock_while_enabled(void)
>       QTestState *qts = qtest_init("-machine k230");
>   
>       qtest_writel(qts, K230_I2C0_BASE + K230_IC_TAR, 0x22);
> +    qtest_writel(qts, K230_I2C0_BASE + K230_IC_SAR, 0x155);
> +    qtest_writel(qts, K230_I2C0_BASE + K230_IC_HS_MADDR, 0x3);
> +
> +    qtest_writel(qts, K230_I2C0_BASE + K230_IC_SS_SCL_HCNT, 20);
> +    qtest_writel(qts, K230_I2C0_BASE + K230_IC_SS_SCL_LCNT, 21);
> +    qtest_writel(qts, K230_I2C0_BASE + K230_IC_FS_SCL_HCNT, 22);
> +    qtest_writel(qts, K230_I2C0_BASE + K230_IC_FS_SCL_LCNT, 23);
> +    qtest_writel(qts, K230_I2C0_BASE + K230_IC_HS_SCL_HCNT, 24);
> +    qtest_writel(qts, K230_I2C0_BASE + K230_IC_HS_SCL_LCNT, 25);
> +
>       qtest_writel(qts, K230_I2C0_BASE + K230_IC_ENABLE, 1);
>   
> -    qtest_writel(qts, K230_I2C0_BASE + K230_IC_TAR, 0x33);
> +    /*
> +     * Configuration registers cannot be changed while the
> +     * controller is enabled.
> +     */
>       qtest_writel(qts, K230_I2C0_BASE + K230_IC_CON, 0);
> +    qtest_writel(qts, K230_I2C0_BASE + K230_IC_TAR, 0x33);
> +    qtest_writel(qts, K230_I2C0_BASE + K230_IC_SAR, 0x222);
> +    qtest_writel(qts, K230_I2C0_BASE + K230_IC_HS_MADDR, 0x7);
> +
> +    qtest_writel(qts, K230_I2C0_BASE + K230_IC_SS_SCL_HCNT, 30);
> +    qtest_writel(qts, K230_I2C0_BASE + K230_IC_SS_SCL_LCNT, 31);
> +    qtest_writel(qts, K230_I2C0_BASE + K230_IC_FS_SCL_HCNT, 32);
> +    qtest_writel(qts, K230_I2C0_BASE + K230_IC_FS_SCL_LCNT, 33);
> +    qtest_writel(qts, K230_I2C0_BASE + K230_IC_HS_SCL_HCNT, 34);
> +    qtest_writel(qts, K230_I2C0_BASE + K230_IC_HS_SCL_LCNT, 35);
>   
> -    g_assert_cmphex(qtest_readl(qts, K230_I2C0_BASE + K230_IC_TAR),
> -                    ==, 0x22);
>       g_assert_cmphex(qtest_readl(qts, K230_I2C0_BASE + K230_IC_CON),
>                       ==, 0x7f);
> +    g_assert_cmphex(qtest_readl(qts, K230_I2C0_BASE + K230_IC_TAR),
> +                    ==, 0x22);
> +    g_assert_cmphex(qtest_readl(qts, K230_I2C0_BASE + K230_IC_SAR),
> +                    ==, 0x155);
> +    g_assert_cmphex(qtest_readl(qts,
> +                               K230_I2C0_BASE + K230_IC_HS_MADDR),
> +                    ==, 0x3);
> +
> +    g_assert_cmphex(qtest_readl(qts,
> +                               K230_I2C0_BASE +
> +                               K230_IC_SS_SCL_HCNT),
> +                    ==, 20);
> +    g_assert_cmphex(qtest_readl(qts,
> +                               K230_I2C0_BASE +
> +                               K230_IC_SS_SCL_LCNT),
> +                    ==, 21);
> +    g_assert_cmphex(qtest_readl(qts,
> +                               K230_I2C0_BASE +
> +                               K230_IC_FS_SCL_HCNT),
> +                    ==, 22);
> +    g_assert_cmphex(qtest_readl(qts,
> +                               K230_I2C0_BASE +
> +                               K230_IC_FS_SCL_LCNT),
> +                    ==, 23);
> +    g_assert_cmphex(qtest_readl(qts,
> +                               K230_I2C0_BASE +
> +                               K230_IC_HS_SCL_HCNT),
> +                    ==, 24);
> +    g_assert_cmphex(qtest_readl(qts,
> +                               K230_I2C0_BASE +
> +                               K230_IC_HS_SCL_LCNT),
> +                    ==, 25);
> +
> +    /*
> +     * Configuration registers become writable again after the
> +     * controller is disabled.
> +     */
> +    qtest_writel(qts, K230_I2C0_BASE + K230_IC_ENABLE, 0);
> +    qtest_writel(qts, K230_I2C0_BASE + K230_IC_TAR, 0x33);
> +
> +    g_assert_cmphex(qtest_readl(qts, K230_I2C0_BASE + K230_IC_TAR),
> +                    ==, 0x33);
>   
>       qtest_quit(qts);
>   }
> @@ -281,6 +475,7 @@ static void test_address_nack(void)
>        */
>       con = qtest_readl(qts, K230_I2C0_BASE + K230_IC_CON);
>       con &= ~IC_CON_10BITADDR_MASTER;
> +
>       qtest_writel(qts, K230_I2C0_BASE + K230_IC_CON, con);
>       qtest_writel(qts, K230_I2C0_BASE + K230_IC_TAR, 0x7f);
>       qtest_writel(qts, K230_I2C0_BASE + K230_IC_ENABLE, 1);
> @@ -310,6 +505,325 @@ static void test_address_nack(void)
>       qtest_quit(qts);
>   }
>   
> +static void test_system_reset(void)
> +{
> +    QTestState *qts = qtest_init("-machine k230");
> +    uint32_t raw;
> +
> +    qtest_writel(qts, K230_I2C0_BASE + K230_IC_TAR, 0x2a);
> +    qtest_writel(qts, K230_I2C0_BASE + K230_IC_SAR, 0x123);
> +    qtest_writel(qts, K230_I2C0_BASE + K230_IC_RX_TL, 10);
> +    qtest_writel(qts, K230_I2C0_BASE + K230_IC_TX_TL, 12);
> +    qtest_writel(qts, K230_I2C0_BASE + K230_IC_INTR_MASK, 0);
> +    qtest_writel(qts, K230_I2C0_BASE + K230_IC_ENABLE, 1);
> +
> +    /*
> +     * Reading an empty RX FIFO produces RX_UNDER.
> +     */
> +    qtest_readl(qts, K230_I2C0_BASE + K230_IC_DATA_CMD);
> +
> +    raw = qtest_readl(qts,
> +                      K230_I2C0_BASE + K230_IC_RAW_INTR_STAT);
> +    g_assert_cmphex(raw & IC_INTR_RX_UNDER, ==, IC_INTR_RX_UNDER);
> +
> +    qtest_system_reset(qts);
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
> +    g_assert_cmphex(qtest_readl(qts,
> +                               K230_I2C0_BASE + K230_IC_INTR_MASK),
> +                    ==, 0x8ff);
> +    g_assert_cmphex(qtest_readl(qts, K230_I2C0_BASE + K230_IC_RX_TL),
> +                    ==, 0);
> +    g_assert_cmphex(qtest_readl(qts, K230_I2C0_BASE + K230_IC_TX_TL),
> +                    ==, 0);
> +    g_assert_cmphex(qtest_readl(qts, K230_I2C0_BASE + K230_IC_ENABLE),
> +                    ==, 0);
> +    g_assert_cmphex(qtest_readl(qts,
> +                               K230_I2C0_BASE + K230_IC_ENABLE_STATUS),
> +                    ==, 0);
> +    g_assert_cmphex(qtest_readl(qts,
> +                               K230_I2C0_BASE + K230_IC_RAW_INTR_STAT),
> +                    ==, 0);
> +    g_assert_cmphex(qtest_readl(qts,
> +                               K230_I2C0_BASE +
> +                               K230_IC_TX_ABRT_SOURCE),
> +                    ==, 0);
> +    g_assert_cmphex(qtest_readl(qts, K230_I2C0_BASE + K230_IC_TXFLR),
> +                    ==, 0);
> +    g_assert_cmphex(qtest_readl(qts, K230_I2C0_BASE + K230_IC_RXFLR),
> +                    ==, 0);
> +    g_assert_cmphex(qtest_readl(qts, K230_I2C0_BASE + K230_IC_STATUS),
> +                    ==, IC_STATUS_TFNF | IC_STATUS_TFE);
> +
> +    qtest_quit(qts);
> +}
> +
> +static void test_clear_on_read(void)
> +{
> +    QTestState *qts = qtest_init("-machine k230");
> +    uint32_t con;
> +    uint32_t raw;
> +    uint32_t source;
> +
> +    /*
> +     * Produce RX_UNDER.
> +     */
> +    qtest_readl(qts, K230_I2C0_BASE + K230_IC_DATA_CMD);
> +
> +    raw = qtest_readl(qts,
> +                      K230_I2C0_BASE + K230_IC_RAW_INTR_STAT);
> +    g_assert_cmphex(raw & IC_INTR_RX_UNDER, ==, IC_INTR_RX_UNDER);
> +
> +    /*
> +     * Writing a clear register must not clear the interrupt.
> +     */
> +    qtest_writel(qts, K230_I2C0_BASE + K230_IC_CLR_RX_UNDER, 1);
> +
> +    raw = qtest_readl(qts,
> +                      K230_I2C0_BASE + K230_IC_RAW_INTR_STAT);
> +    g_assert_cmphex(raw & IC_INTR_RX_UNDER, ==, IC_INTR_RX_UNDER);
> +
> +    /*
> +     * Produce an independent TX_ABRT interrupt.
> +     */
> +    con = qtest_readl(qts, K230_I2C0_BASE + K230_IC_CON);
> +    con &= ~IC_CON_10BITADDR_MASTER;
> +
> +    qtest_writel(qts, K230_I2C0_BASE + K230_IC_CON, con);
> +    qtest_writel(qts, K230_I2C0_BASE + K230_IC_TAR, 0x7f);
> +    qtest_writel(qts, K230_I2C0_BASE + K230_IC_ENABLE, 1);
> +    qtest_writel(qts, K230_I2C0_BASE + K230_IC_DATA_CMD,
> +                 IC_DATA_CMD_STOP | 0x55);
> +
> +    raw = qtest_readl(qts,
> +                      K230_I2C0_BASE + K230_IC_RAW_INTR_STAT);
> +    source = qtest_readl(qts,
> +                         K230_I2C0_BASE + K230_IC_TX_ABRT_SOURCE);
> +
> +    g_assert_cmphex(raw & IC_INTR_RX_UNDER, ==, IC_INTR_RX_UNDER);
> +    g_assert_cmphex(raw & IC_INTR_TX_ABRT, ==, IC_INTR_TX_ABRT);
> +    g_assert_cmphex(source & IC_ABRT_7B_ADDR_NOACK,
> +                    ==, IC_ABRT_7B_ADDR_NOACK);
> +
> +    /*
> +     * Reading CLR_RX_UNDER clears only RX_UNDER.
> +     */
> +    qtest_readl(qts, K230_I2C0_BASE + K230_IC_CLR_RX_UNDER);
> +
> +    raw = qtest_readl(qts,
> +                      K230_I2C0_BASE + K230_IC_RAW_INTR_STAT);
> +
> +    g_assert_cmphex(raw & IC_INTR_RX_UNDER, ==, 0);
> +    g_assert_cmphex(raw & IC_INTR_TX_ABRT, ==, IC_INTR_TX_ABRT);
> +
> +    /*
> +     * Writing CLR_TX_ABRT must not clear TX_ABRT.
> +     */
> +    qtest_writel(qts, K230_I2C0_BASE + K230_IC_CLR_TX_ABRT, 1);
> +
> +    raw = qtest_readl(qts,
> +                      K230_I2C0_BASE + K230_IC_RAW_INTR_STAT);
> +    g_assert_cmphex(raw & IC_INTR_TX_ABRT, ==, IC_INTR_TX_ABRT);
> +
> +    /*
> +     * Reading CLR_TX_ABRT clears TX_ABRT and its source.
> +     */
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
> +    /*
> +     * CLR_INTR clears latched interrupts. TX_EMPTY remains asserted
> +     * because it is recalculated from the empty TX FIFO.
> +     */
> +    qtest_readl(qts, K230_I2C0_BASE + K230_IC_CLR_INTR);
> +
> +    raw = qtest_readl(qts,
> +                      K230_I2C0_BASE + K230_IC_RAW_INTR_STAT);
> +
> +    g_assert_cmphex(raw & IC_INTR_RX_UNDER, ==, 0);
> +    g_assert_cmphex(raw & IC_INTR_TX_ABRT, ==, 0);
> +    g_assert_cmphex(raw & IC_INTR_ACTIVITY, ==, 0);
> +    g_assert_cmphex(raw & IC_INTR_START_DET, ==, 0);
> +    g_assert_cmphex(raw & IC_INTR_TX_EMPTY, ==, IC_INTR_TX_EMPTY);
> +
> +    qtest_quit(qts);
> +}
> +
> +static void test_abort_sources(void)
> +{
> +    QTestState *qts = qtest_init("-machine k230");
> +    uint32_t con;
> +    uint32_t raw;
> +    uint32_t source;
> +
> +    /*
> +     * Master mode disabled.
> +     */
> +    con = qtest_readl(qts, K230_I2C0_BASE + K230_IC_CON);
> +    con &= ~(IC_CON_MASTER_MODE | IC_CON_10BITADDR_MASTER);
> +
> +    qtest_writel(qts, K230_I2C0_BASE + K230_IC_CON, con);
> +    qtest_writel(qts, K230_I2C0_BASE + K230_IC_TAR, 0x7f);
> +    qtest_writel(qts, K230_I2C0_BASE + K230_IC_ENABLE, 1);
> +    qtest_writel(qts, K230_I2C0_BASE + K230_IC_DATA_CMD,
> +                 IC_DATA_CMD_STOP | 0x55);
> +
> +    raw = qtest_readl(qts,
> +                      K230_I2C0_BASE + K230_IC_RAW_INTR_STAT);
> +    source = qtest_readl(qts,
> +                         K230_I2C0_BASE + K230_IC_TX_ABRT_SOURCE);
> +
> +    g_assert_cmphex(raw & IC_INTR_TX_ABRT, ==, IC_INTR_TX_ABRT);
> +    g_assert_cmphex(source & IC_ABRT_MASTER_DIS,
> +                    ==, IC_ABRT_MASTER_DIS);
> +
> +    qtest_system_reset(qts);
> +
> +    /*
> +     * A read command cannot target the General Call address.
> +     */
> +    con = qtest_readl(qts, K230_I2C0_BASE + K230_IC_CON);
> +    con &= ~IC_CON_10BITADDR_MASTER;
> +
> +    qtest_writel(qts, K230_I2C0_BASE + K230_IC_CON, con);
> +    qtest_writel(qts, K230_I2C0_BASE + K230_IC_TAR,
> +                 IC_TAR_SPECIAL);
> +    qtest_writel(qts, K230_I2C0_BASE + K230_IC_ENABLE, 1);
> +    qtest_writel(qts, K230_I2C0_BASE + K230_IC_DATA_CMD,
> +                 IC_DATA_CMD_READ | IC_DATA_CMD_STOP);
> +
> +    raw = qtest_readl(qts,
> +                      K230_I2C0_BASE + K230_IC_RAW_INTR_STAT);
> +    source = qtest_readl(qts,
> +                         K230_I2C0_BASE + K230_IC_TX_ABRT_SOURCE);
> +
> +    g_assert_cmphex(raw & IC_INTR_TX_ABRT, ==, IC_INTR_TX_ABRT);
> +    g_assert_cmphex(source & IC_ABRT_GCALL_READ,
> +                    ==, IC_ABRT_GCALL_READ);
> +
> +    qtest_system_reset(qts);
> +
> +    /*
> +     * No slave is attached to acknowledge the General Call.
> +     */
> +    con = qtest_readl(qts, K230_I2C0_BASE + K230_IC_CON);
> +    con &= ~IC_CON_10BITADDR_MASTER;
> +
> +    qtest_writel(qts, K230_I2C0_BASE + K230_IC_CON, con);
> +    qtest_writel(qts, K230_I2C0_BASE + K230_IC_TAR,
> +                 IC_TAR_SPECIAL);
> +    qtest_writel(qts, K230_I2C0_BASE + K230_IC_ENABLE, 1);
> +    qtest_writel(qts, K230_I2C0_BASE + K230_IC_DATA_CMD,
> +                 IC_DATA_CMD_STOP | 0x55);
> +
> +    raw = qtest_readl(qts,
> +                      K230_I2C0_BASE + K230_IC_RAW_INTR_STAT);
> +    source = qtest_readl(qts,
> +                         K230_I2C0_BASE + K230_IC_TX_ABRT_SOURCE);
> +
> +    g_assert_cmphex(raw & IC_INTR_TX_ABRT, ==, IC_INTR_TX_ABRT);
> +    g_assert_cmphex(source & IC_ABRT_GCALL_NOACK,
> +                    ==, IC_ABRT_GCALL_NOACK);
> +
> +    qtest_system_reset(qts);
> +
> +    /*
> +     * 10-bit master addressing is deliberately unsupported.
> +     */
> +    qtest_writel(qts, K230_I2C0_BASE + K230_IC_ENABLE, 1);
> +    qtest_writel(qts, K230_I2C0_BASE + K230_IC_DATA_CMD,
> +                 IC_DATA_CMD_STOP | 0x55);
> +
> +    raw = qtest_readl(qts,
> +                      K230_I2C0_BASE + K230_IC_RAW_INTR_STAT);
> +    source = qtest_readl(qts,
> +                         K230_I2C0_BASE + K230_IC_TX_ABRT_SOURCE);
> +
> +    g_assert_cmphex(raw & IC_INTR_TX_ABRT, ==, IC_INTR_TX_ABRT);
> +    g_assert_cmphex(source, ==, 0);
> +
> +    qtest_quit(qts);
> +}
> +
> +static void test_start_byte_abort(void)
> +{
> +    QTestState *qts = qtest_init("-machine k230");
> +    uint32_t con;
> +    uint32_t raw;
> +    uint32_t source;
> +
> +    /*
> +     * START BYTE requires RESTART_EN.
> +     */
> +    con = qtest_readl(qts, K230_I2C0_BASE + K230_IC_CON);
> +    con &= ~(IC_CON_10BITADDR_MASTER | IC_CON_RESTART_EN);
> +
> +    qtest_writel(qts, K230_I2C0_BASE + K230_IC_CON, con);
> +    qtest_writel(qts, K230_I2C0_BASE + K230_IC_TAR,
> +                 IC_TAR_SPECIAL | IC_TAR_GC_OR_START);
> +    qtest_writel(qts, K230_I2C0_BASE + K230_IC_ENABLE, 1);
> +    qtest_writel(qts, K230_I2C0_BASE + K230_IC_DATA_CMD,
> +                 IC_DATA_CMD_STOP | 0x55);
> +
> +    raw = qtest_readl(qts,
> +                      K230_I2C0_BASE + K230_IC_RAW_INTR_STAT);
> +    source = qtest_readl(qts,
> +                         K230_I2C0_BASE + K230_IC_TX_ABRT_SOURCE);
> +
> +    g_assert_cmphex(raw & IC_INTR_TX_ABRT, ==, IC_INTR_TX_ABRT);
> +    g_assert_cmphex(source & IC_ABRT_SBYTE_NORSTRT,
> +                    ==, IC_ABRT_SBYTE_NORSTRT);
> +
> +    /*
> +     * Bit 9 remains set while the invalid configuration remains.
> +     */
> +    qtest_readl(qts, K230_I2C0_BASE + K230_IC_CLR_TX_ABRT);
> +
> +    raw = qtest_readl(qts,
> +                      K230_I2C0_BASE + K230_IC_RAW_INTR_STAT);
> +    source = qtest_readl(qts,
> +                         K230_I2C0_BASE + K230_IC_TX_ABRT_SOURCE);
> +
> +    g_assert_cmphex(raw & IC_INTR_TX_ABRT, ==, IC_INTR_TX_ABRT);
> +    g_assert_cmphex(source & IC_ABRT_SBYTE_NORSTRT,
> +                    ==, IC_ABRT_SBYTE_NORSTRT);
> +
> +    /*
> +     * Remove the cause by enabling RESTART_EN, then clear again.
> +     */
> +    qtest_writel(qts, K230_I2C0_BASE + K230_IC_ENABLE, 0);
> +
> +    con |= IC_CON_RESTART_EN;
> +    qtest_writel(qts, K230_I2C0_BASE + K230_IC_CON, con);
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
>   int main(int argc, char **argv)
>   {
>       g_test_init(&argc, &argv, NULL);
> @@ -318,8 +832,12 @@ int main(int argc, char **argv)
>                      test_reset_values);
>       qtest_add_func("/k230-i2c/all-instances",
>                      test_all_instances);
> +    qtest_add_func("/k230-i2c/instance-isolation",
> +                   test_instance_isolation);
>       qtest_add_func("/k230-i2c/register-access",
>                      test_register_access);
> +    qtest_add_func("/k230-i2c/readonly-registers",
> +                   test_readonly_registers);
>       qtest_add_func("/k230-i2c/register-lock-while-enabled",
>                      test_register_lock_while_enabled);
>       qtest_add_func("/k230-i2c/enable-disable",
> @@ -330,6 +848,14 @@ int main(int argc, char **argv)
>                      test_rx_underflow);
>       qtest_add_func("/k230-i2c/address-nack",
>                      test_address_nack);
> +    qtest_add_func("/k230-i2c/system-reset",
> +                   test_system_reset);
> +    qtest_add_func("/k230-i2c/clear-on-read",
> +                   test_clear_on_read);
> +    qtest_add_func("/k230-i2c/abort-sources",
> +                   test_abort_sources);
> +    qtest_add_func("/k230-i2c/start-byte-abort",
> +                   test_start_byte_abort);
>   
>       return g_test_run();
>   }


