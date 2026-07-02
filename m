Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B64C6C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 12:41:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfGjj-0007Td-VV; Thu, 02 Jul 2026 08:41:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfGji-0007TL-7u
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 08:41:46 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfGjf-0001UJ-RS
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 08:41:45 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 662AVWrt3591605
 for <qemu-devel@nongnu.org>; Thu, 2 Jul 2026 12:41:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HmeWTMY5baCvBxoj9fBfK3yr4ylXRxPCjo0b9RdInrU=; b=kXZ51t0jrbEBGVvr
 qhsBH80zRlbZkfTe3PQh9pGuYhbv+OK+vucOZ8efVQyZZuMC612wBFcXwkeTvnJm
 jTrhFrGIRhVbupg4vUvDds7IyfvfbCR1zR1KybLs+qNV0XU6Gsof1FerqLECIJ3w
 tdH6JKf5+T3AoTzDFM8jsiYyOuGb4UoaGY0bOb8RI4Vv82KOsYV+7sfBWd+thz0R
 OVPKr1RClsLHP7g2Ojcu6khgeF7WdemL5YWX3cSdsD2n2Jq3g7Xa3ZqSLf2NpEB8
 /a+STRe8CjMFTInDKaB+5zUMuT3oFQsEh5VG4ZbS+pMZvQ9MvrhDQ90jp8uYeXEg
 diZQlA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5h7n9r8p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 12:41:41 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e6ed4fe99so322073785a.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 05:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782996101; x=1783600901; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HmeWTMY5baCvBxoj9fBfK3yr4ylXRxPCjo0b9RdInrU=;
 b=jIMqbYbZKy1VojCqmatlXNSNwHqgboRo9u6mwR+G17/u/rcVcr3lRZGjXOyuCl3TRS
 dknvY4bqN5mE40133WD7ztI6y+Qp0QO2KtP+o4Ybl8EW8OgF9qC8+z70DKzoJGmFvGpW
 D7JzHdWNpuDbigrB3ZJuCqdvow/jZoJsmRNvZYZCQ0L7FaYM+tcGsX6ndvlo2Xe93JYU
 1ZTVeaeJKImoXhmLtV///4mVxxRPIkEul52IYgPPZhF7+qhXX1XwetY5iDn50A6uPWZa
 cdZiQImlGMePSkqnm8bHxPqz0dzF1uMyL+Wsc4S79xmTPVtX4LQehGWm+LsQvFGJxCF7
 D1LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782996101; x=1783600901;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HmeWTMY5baCvBxoj9fBfK3yr4ylXRxPCjo0b9RdInrU=;
 b=WD1cLd/8lGODRuEu3wMw1gdEWMRCRGHwEUFkiwTN8tRVp1lHWxdx5r+9RKho4+8XrF
 IXxnLd66GNoy5+OumMYbcThXFhBUlD4LsRRCs5JobHMt4RFIasroZgneZM3ArgwNT++D
 iHLEiGGm0iQtxH7UCA8iclffqx14NK403J01J1B7pB3ljhaFb8s06vs5tck5Nxl2+NaP
 /ZIY9XndeITaeESBmXmNKqab/9anBA9hbleh65CZiGPeKw1fiScvkQXWAz2wXBG8k+Jn
 wcmaT9sI/ivq+JA/0e6wYrpqvc/W4d/9Dpf+cCQy1Bldi04F4DIxfedx/c12Mm9nBwSk
 YEVA==
X-Forwarded-Encrypted: i=1;
 AFNElJ//yYaKo/TH8RFMzEyAkJGTubbQ6PbSR9W4gOZSTnGuAYtQECt+8BLnuutG7bTPYp3FMVS/kLrAdUQ9@nongnu.org
X-Gm-Message-State: AOJu0YzxfVmReLRCMUlSUP9REaTJTHl9TxVDJ7XQAwu9aNHEkitJWjC1
 40eCkxeuZbmrr4gpF7wU2uT2oo2RdjVDsAFeO8+ET0oHM7DHLS8tVMADlxF07pQPNEY905pxnPF
 GO8+ucnnyYG9g9ggktoUBfowIxU5UI8v9NUoN2/gsu471M4R2IwpBJmpKpg==
X-Gm-Gg: AfdE7ckhwCGIsNyDTz7LY8mow1/u7LKXp2oy3P8TCqFs/3E+8MaDmgBxI8mLU2oamLV
 rKJW0xSNuq1x5GJ4JsY98KvraBBrkA6Qu6FQCzUbp15igjH9rm1edPz9/j6us7bMCwYUdE0T62X
 oW79tTj5LJeXjv+0V5lZnLPNd+/OZFQftuMYElo8irtMJQ1c6/zcHXB8ZJo3ie2yY6mjKOLJvSO
 LAcv4To6M7R5+RZIzUGDaU34GKUVURQs9eautycDJOZwcyxRW/uA1+p76KTwml1jDlK8JooXyeP
 i8sLvjKQmaPooapnsvUNunp/VG64DWyoRJ/8Eb8w2zCV0tT9+woXAtZvhY8Kpxqp0mi9z+/3MPt
 TvT+QV24DjjbhLP8SLGy/7+RmtOh4U2jrA8bXgKW0ivHyIZ7XhO3MJj7YLfew2w==
X-Received: by 2002:a05:620a:1d0b:b0:915:ba3c:8c2b with SMTP id
 af79cd13be357-92e782055b9mr786419785a.19.1782996100962; 
 Thu, 02 Jul 2026 05:41:40 -0700 (PDT)
X-Received: by 2002:a05:620a:1d0b:b0:915:ba3c:8c2b with SMTP id
 af79cd13be357-92e782055b9mr786414885a.19.1782996100311; 
 Thu, 02 Jul 2026 05:41:40 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477de3dd53fsm8524669f8f.37.2026.07.02.05.41.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 05:41:39 -0700 (PDT)
Message-ID: <01f8f321-bf1d-4cd2-989a-17ff8e2bb998@oss.qualcomm.com>
Date: Thu, 2 Jul 2026 14:41:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] hw/arm: Add basic FlexCAN3 support to TYPE_FSL_IMX8MP
 and imx8mp-evk
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>, Jason Wang <jasowang@redhat.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Matyas Bobek <matyas.bobek@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260701224612.48342-1-shentey@gmail.com>
 <20260701224612.48342-5-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260701224612.48342-5-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDEzMyBTYWx0ZWRfX53CZ1lOF7MlA
 AViXwkniOf4JI55hwbd9J5GhbPOR2vdLuDpYc+QPMHIKbQiqsN5uHZ63ArbQg4zIZi/uU0HG9UV
 Fs4lLRCYzs0Gwp/5RRF3eVzfCu9zySsnPY51mqcYg2aBShiaIyoqYfUXO+oQr124rc3urBFDMI5
 sBzYdjAeWwwgDrMMLKL1Wyb9Co8ldwYCB0FmpzHplI4iEA4k+uAEFnZwqAz92vNIRukCbZtI/ZS
 mBc3c8UUg9bcppe+revOaCWvcMFtQTI0DyYFFZYY5FU+fivEHJMvZ/NfW+Ezix2c1EoyDpwABmT
 Kc9QbN7JVj97j4p0YZoB0qJ6EyLpNyZ1NN11Zu+HgHVwcG+2noC0Bj41FDKZRX8kOYP/WWHHvue
 PvxJA5RqmEcH77mO1Z7pf9SfuG439HAua3og5Z9ZWBQdr+qIMblNUTO4Syz4VScxXL+4A6/UGSe
 jA4Bpx567ATs1kmNJjg==
X-Proofpoint-ORIG-GUID: ETakPbVLbQE2huFJkDutnumWUdU4KSfW
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDEzMyBTYWx0ZWRfX33j1fP6jCUCq
 2JFXKYM0BBDvK3LllHrDPPobfd2EJ6mF4Cl19BD2Wh+TOTmV5JAs4WcRzyBlSnH9+6mS4w/VveS
 xuVxKW2msCk2FhtQ6j9me2Ymxz43Zls=
X-Proofpoint-GUID: ETakPbVLbQE2huFJkDutnumWUdU4KSfW
X-Authority-Analysis: v=2.4 cv=WMBPmHsR c=1 sm=1 tr=0 ts=6a465c86 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=_2WZOeEKI9IBzgM_DNAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 adultscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020133
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 2/7/26 00:46, Bernhard Beschow wrote:
> Real hardware supports CAN FD which is missing in the emulation and is
> considered future work. Still, CAN communication already works under Linux.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   docs/system/arm/imx8m.rst   |  1 +
>   include/hw/arm/fsl-imx8mp.h |  8 ++++++++
>   hw/arm/fsl-imx8mp.c         | 37 +++++++++++++++++++++++++++++++++++++
>   hw/arm/imx8mp-evk.c         | 21 +++++++++++++++++++++
>   hw/misc/imx8mp_ccm.c        |  3 +++
>   hw/arm/Kconfig              |  1 +
>   6 files changed, 71 insertions(+)


> +    /* FLEXCANs */
> +    for (i = 0; i < FSL_IMX8MP_NUM_CANS; i++) {
> +        static const struct {
> +            hwaddr addr;
> +            unsigned int irq;
> +        } flexcan_table[FSL_IMX8MP_NUM_CANS] = {
> +            {
> +                fsl_imx8mp_memmap[FSL_IMX8MP_FLEXCAN1].addr,
> +                FSL_IMX8MP_FLEXCAN1_IRQ
> +            }, {
> +                fsl_imx8mp_memmap[FSL_IMX8MP_FLEXCAN2].addr,
> +                FSL_IMX8MP_FLEXCAN2_IRQ
> +            },
> +        };
> +
> +        s->flexcan[i].ccm = IMX_CCM(&s->ccm);

Conditional to setting this using object_property_set_link(), see
https://lore.kernel.org/qemu-devel/77d5891c-de12-467e-8746-02fe43121e3e@oss.qualcomm.com/, 
then:

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

> +        object_property_set_link(OBJECT(&s->flexcan[i]), "canbus",
> +                                 OBJECT(s->canbus[i]), &error_abort);
> +
> +        sysbus_realize(SYS_BUS_DEVICE(&s->flexcan[i]), &error_abort);
> +
> +        sysbus_mmio_map(SYS_BUS_DEVICE(&s->flexcan[i]), 0,
> +                        flexcan_table[i].addr);
> +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->flexcan[i]), 0,
> +                           qdev_get_gpio_in(gicdev, flexcan_table[i].irq));
> +    }

