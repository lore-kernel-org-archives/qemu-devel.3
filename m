Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB912C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 12:34:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh50N-00033l-Dh; Tue, 07 Jul 2026 08:34:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh50K-00031U-M9
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 08:34:25 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh50I-00013Y-Sj
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 08:34:24 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667C9cxX3619376
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 12:34:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jYWBVnoPSrAoz/JBdXWYPTlbT8PXiq5lvfGIdL/HWMo=; b=Jvr+MAliyVVDFf0X
 Ef4UqIvDMyM4f8ewt35jgGX6cyahliQ2V0CdFtmOczIFvN/V8afmjsfz/tRzmPoP
 xP8FXiBs/dOgjwmVgAr0XPgoAaKHjqWD5cirnA2I4SKw/LG6QihcdkZReKvUnEIw
 0tojZl7WQ1j3xBrwpoo4VmYpYSXOUUcy6bievpyxFq9tQTIqKcWY3p2IVFhttDsv
 1qD1qA6K8IETgtiOFzLH1EBelZ7kTauGO5zb/ng341diKQLFM/AvHqxGjfSANcTF
 RgSgaqdhKI5z6xYaktju3RYaJlUkfJ3F67ESDMd3lWZKYJZpNrrDJxop4ebvB+wj
 UJ9q1Q==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8vun18a7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 12:34:20 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c1d7886cdso86447811cf.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 05:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783427660; x=1784032460; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jYWBVnoPSrAoz/JBdXWYPTlbT8PXiq5lvfGIdL/HWMo=;
 b=Y2I72yNWs5wz6NM3C33aff5rYxOtHbiuGvl1TFyPj61lF9b2v9OSApTEYHKJmAccla
 hzKmnYF13og4rUe1ovMCC8SDGDD143ByJ1pkVGKXrn3NYkFTn9lhnJy3Bx3QTo72enpu
 6VWsorYHSVJtgTeteQSkZFRufMPgT9bmkIDHeSvMbmsLqBh5X5I43L2DPy+3ZHcUOA2M
 in+K0vdS+q5411qTmJPg+SzHAKcadbixSZ8MmI9MGIABacSfzenxx7BqEhNOVX7gDEFf
 RXobPpluG2OBBl+n3GMXwbtFV37C1BH7j1Ax40QVzjwvqVyDwr7rAHNFxQDoOgVdRbnj
 jPEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783427660; x=1784032460;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jYWBVnoPSrAoz/JBdXWYPTlbT8PXiq5lvfGIdL/HWMo=;
 b=L86e9k7dPnE3ywucf2+nEI43kUCic1+/xEM25rxnMNhdk/B3eRQsTAsiHE9lQMJiM1
 Fyft+iW/Zfg3qbwCatTTTr9RgJzYBKKZcnUjCdlxgv8HtfOz6SSOiYKk8Uy5YmACoyti
 o7hEzHLqFoSeUORYmu51koBtB1SRDbmSoIOcJTi/MSQRk07moGLZkHnchsXRgPrXPeBx
 KOPTgmWCv7eHPvNCDzw8STU33mWQ/gnTyUhGPWlL6lIbu8Ox33GfLCM/Z2SDMBfVcG6X
 G1S8ULl18xsXOb8lP00Vti7ZxnU4Ue17o7MFP6aT08zQ4gnmlwkbInnAF67C03y9kSmQ
 7Ysg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqpNIX9Yc9AjGPsinYGaS2L7D+euG4DegMVoBFzuJTYexoivpSuLh4bzQ2msTS4XfRUtIHklelNLwV+@nongnu.org
X-Gm-Message-State: AOJu0Yx3pR//e5GxUbocy/HcFEqRzQw2aaellhl4dnaGxyQAf4enxY9g
 lKc29hVa3bqpwek5atkZo0jBdODJBkYEKqAuOQcowc5gitDtmsIfIFnmlBPkplsD7n+2adpJxJV
 2P3xo0NGoB5eZcXtA09X6QJTcVf3ThEmveOw0OcFtBGDt9izL438iSvvZaQ==
X-Gm-Gg: AfdE7cmpu+iZ49C+FybEfgRfUI3JOQLykhciVZlrCmrgUbjqwRx6uqVZzS1u96QRw2Y
 NoHMNJJN5HhZDigoZtjj4TbcvEAJaj43NDyaVlJszB8fqOXZRNXMT8LM7b7fJmSyocrROvbwX5t
 XDP8PPPHFYQuhsMaCGcI8jvqQoXJq/Wh9YT+Df7SmapSVpirloXQ6GkceI4QYpmnXNXXWIp5Jtd
 QfroJLVAKZ8cSQKJdlkWmVLWVsgKItI6bocE1WIGl5h4dK87vq9ErkCl2ojyaWvomvvjayu0He6
 Vw34ZxiNxM7wH/P/CbDigWgmgx47HDU5uAkvKhqGlHbIVKsDi/14Wvy8h7VtC2aPFdmjT4fdDud
 5gqz73GQoWejNqSTKG65BCBwSieUYYD7lABpvQ+EMGZ6ZF3PmyKmNLJkhTUCOAQ==
X-Received: by 2002:a05:622a:5908:b0:51a:1a44:101f with SMTP id
 d75a77b69052e-51c747ce739mr54968061cf.21.1783427660006; 
 Tue, 07 Jul 2026 05:34:20 -0700 (PDT)
X-Received: by 2002:a05:622a:5908:b0:51a:1a44:101f with SMTP id
 d75a77b69052e-51c747ce739mr54966991cf.21.1783427658733; 
 Tue, 07 Jul 2026 05:34:18 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c15ad9bca25sm124395266b.35.2026.07.07.05.34.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2026 05:34:18 -0700 (PDT)
Message-ID: <92dd132e-e4d5-43f9-a207-c59697c87204@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 14:34:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/10] hw/block: m25p80: Fix dummy byte handling for
 Spansion flash
Content-Language: en-US
To: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org
References: <20260707083431.219671-1-bin.meng@processmission.com>
 <20260707083431.219671-5-bin.meng@processmission.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260707083431.219671-5-bin.meng@processmission.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDEyMiBTYWx0ZWRfX9GjsrslPTky/
 4SuScy/Ekcr5l9+6e7NrYXuvGmqtO6uxSYnv4JYVKbj+CzfUPlIhd5r8U3Wi+CI6mI/zX8tDtVZ
 TKVPXcFjJCbQdGuxBJ2W515Y0DB6U1c=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDEyMiBTYWx0ZWRfX33Xfa9ddUVNj
 umfaeuRi3MEgpza4rAvqDavLr7Y4IurT8kFVFPMH9L4RcFoXAeeckY2p/9MpP2TGhOw01Hba1ez
 8u9hWNccoHzo0zbynDhxlVW+VDLzknHBk7VSTEUe08tquttYlyxFQH8o8dVckGtFZxC7589i+6a
 b6AckYF7EDE20eN0yIj20J8pYpz206sqj48s9jw8vz7RmwJ7DTp6zd86LDge/0RDddQti2DqDZO
 NvHqQpqTQXyGZ3BcNfP3iXrR1xWmVDLUmZSn4nMGySi0YoBawNMU4Hyx9pqpY+XzDg8Lp8EwOlW
 RyG39pjCRcVI8kRa1hZw5yr0qCceEztRuiG1PV1FdVXA3dd8zgdROhPTdQ8lXnAwXJqcQCgsPc9
 MM0iXLw2bC8B0kFoDeJBw1RWoYN/eSbdZri1ACIbeDCzS6Kzu41DbTc51kA9IegLr+JyLvB5xDf
 2iChzrSQoEs/pwETKLg==
X-Proofpoint-GUID: IfsGNK-Ib8PEHyidDkkOGxQggAQ9zZtU
X-Authority-Analysis: v=2.4 cv=N+IZ0W9B c=1 sm=1 tr=0 ts=6a4cf24c cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=bUQKSiCPAAAA:8 a=FRSEYCzRAAAA:8 a=20KFwNOVAAAA:8 a=vxV16xnnkWMIQUmMLa0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
 a=-fHZXUhsFbuwFN3fwQAr:22 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-ORIG-GUID: IfsGNK-Ib8PEHyidDkkOGxQggAQ9zZtU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070122
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 7/7/26 10:34, Bin Meng wrote:
> Spansion flashes expose the number of dummy clock cycles through CR2V
> register [1]. The value is a cycle count, not a byte count, so the
> m25p80 model has to convert it to the number of whole SSI transfer
> bytes consumed while collecting read command data.
> 
> Add a helper that multiplies the CR2V dummy cycle count by the phase
> width and rounds up non-byte-aligned counts, matching the byte-oriented
> SSI model. The default eight-cycle configuration keeps the same byte
> counts as before.
> 
> [1] https://www.infineon.com/assets/row/public/documents/10/49/infineon-s25fs128s-s25fs256s-1-datasheet-en.pdf
> 
> Fixes: cf6f1efe0b57 ("m25p80: Fast read commands family changes")
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
> Tested-by: Cédric Le Goater <clg@redhat.com>
> 
> ---
> 
> Changes in v2:
> - change spansion_extract_cfg_num_dummies() to spansion_extract_cfg_dummy_bytes()
>    to avoid confusion
> - use assert() when the dummy bit count is not byte-aligned
> 
>   hw/block/m25p80.c | 32 ++++++++++++++++++++------------
>   1 file changed, 20 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
> index d7a9d79373..545e0b5728 100644
> --- a/hw/block/m25p80.c
> +++ b/hw/block/m25p80.c
> @@ -1057,6 +1057,23 @@ static uint8_t macronix_extract_cfg_dummy_bytes(Flash *s, uint8_t bus_width)
>       return dummy_bits / 8;
>   }
>   
> +static uint8_t spansion_extract_cfg_dummy_bytes(Flash *s, uint8_t bus_width)
> +{
> +    uint8_t dummy_bits;
> +
> +    dummy_bits = extract32(s->spansion_cr2v, SPANSION_DUMMY_CLK_POS,
> +                            SPANSION_DUMMY_CLK_LEN);
> +    dummy_bits *= bus_width;
> +
> +    /*
> +     * Assert that the dummy bit count is byte-aligned
> +     * as SSI core can only consume whole dummy bytes.
> +     */
> +    assert(dummy_bits % 8 == 0);
> +
> +    return dummy_bits / 8;
> +}
> +
>   static void decode_fast_read_cmd(Flash *s)
>   {
>       s->needed_bytes = get_addr_length(s);
> @@ -1075,10 +1092,7 @@ static void decode_fast_read_cmd(Flash *s)
>           s->needed_bytes += macronix_extract_cfg_dummy_bytes(s, 1);
>           break;
>       case MAN_SPANSION:
> -        s->needed_bytes += extract32(s->spansion_cr2v,
> -                                    SPANSION_DUMMY_CLK_POS,
> -                                    SPANSION_DUMMY_CLK_LEN
> -                                    );
> +        s->needed_bytes += spansion_extract_cfg_dummy_bytes(s, 1);
>           break;
>       case MAN_ISSI:
>           /*
> @@ -1111,10 +1125,7 @@ static void decode_dio_read_cmd(Flash *s)
>           break;
>       case MAN_SPANSION:
>           s->needed_bytes += SPANSION_CONTINUOUS_READ_MODE_CMD_LEN;
> -        s->needed_bytes += extract32(s->spansion_cr2v,
> -                                    SPANSION_DUMMY_CLK_POS,
> -                                    SPANSION_DUMMY_CLK_LEN
> -                                    );
> +        s->needed_bytes += spansion_extract_cfg_dummy_bytes(s, 2);
>           break;
>       case MAN_NUMONYX:
>           s->needed_bytes += numonyx_extract_cfg_dummy_bytes(s);
> @@ -1151,10 +1162,7 @@ static void decode_qio_read_cmd(Flash *s)
>           break;
>       case MAN_SPANSION:
>           s->needed_bytes += SPANSION_CONTINUOUS_READ_MODE_CMD_LEN;
> -        s->needed_bytes += extract32(s->spansion_cr2v,
> -                                    SPANSION_DUMMY_CLK_POS,
> -                                    SANSION_DUMMY_CLK_LEN
> -                                    );
> +        s->needed_bytes += spansion_extract_cfg_dummy_bytes(s, 4);
>           break;
>       case MAN_NUMONYX:
>           s->needed_bytes += numonyx_extract_cfg_dummy_bytes(s);

This breaks the test_arm_emcraft_sf2 functional test:

not ok 1 test_emcraft_sf2.EmcraftSf2Machine.test_arm_emcraft_sf2


