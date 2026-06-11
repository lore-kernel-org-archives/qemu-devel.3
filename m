Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8E71CD98D2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 12:23:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXeRG-0005sq-UY; Thu, 11 Jun 2026 08:23:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXeRF-0005sf-Iy
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 08:23:13 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXeRD-0006FN-8F
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 08:23:12 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B9xIea284127
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 12:23:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yEdAFt4/T2JviNK4D5D/tIY5VqdckwZtqvrkDHbOqFM=; b=hRBKPP7r09hCl2nK
 JLTEGzqKC77rFQdjHSWnRzZua20aTG57dSz5ZOrtaT9obadVp/lXMqDiGGyjxC58
 e5TEMvWIAyUwyiByrkvcH4d3U513ylGdCCJIdg9C6JwL1Ovo6OGyy0TVpOzb3yuQ
 05x97kr25fZzdbvmWGe/dyvVX/TqXztAqkDBwlCvKW5iy43H6YILWcq3OdaXyxKB
 eve3JCDVrBPFUSnTnwMobR/6s7vQfHi/jD8/0dumOedNKFzuUYHIkVI9A1zGGuKZ
 ekDqJwyGblGFTCr9m02kN4YznJOpcdfPCCHm/wR70OpFh5RZe4/IEg+0PTlRx0tx
 ttSWNw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6tkc6p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 12:23:09 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5177bddf6e0so19907911cf.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781180588; x=1781785388; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yEdAFt4/T2JviNK4D5D/tIY5VqdckwZtqvrkDHbOqFM=;
 b=abDGbINctbdWIUB5AgCfZjY8z6emsuO2OFO/yDvaPmCzT6a2TyqvDli+cnF+DvsRdN
 muO6mAD71uIHlq0edNVJRPYoIzDNMKzfeHzVH3l++t5D5gGcsxWuZ3JORgTF/Gw9gcCO
 h0tQLTMr6GJGddOmFU1CxwFIz3GpLvBokwlIHsZ0AOXKW5BdX93uShM7KbjorJ0VDccc
 jGi25gDfu59LLKswtO8FYDP0eBDv673Qb+S0oIyCVtZztZvb1e+xNLn6X18VhsMkaEYT
 cb6NKt+3unEPv1ffYmzIEkcuLByJJeP3It0Y24AYrpvwzftrqz3bHkZ8ducPNPh7v0++
 0cyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781180588; x=1781785388;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yEdAFt4/T2JviNK4D5D/tIY5VqdckwZtqvrkDHbOqFM=;
 b=kLsBw586wPzbhdAKQIHXIIF/M2vtPS8fENSCjPoN6nBzdRrlH9JPNp/2+tN7jL/Hn+
 YyjZcq7TIKYlD4hB9dc8QSfFi2RVTVi9+FWoqgH776uekGWlhSFUfEzlwNk9xKqgIvje
 deQS72cWV7oTtsi6AHAKRViQHtWLb8T+kAXdDyx6tMV7BsCUaepZg6RKBZSffIKY8fmG
 d26Lg0IavUrJgMoJHVQJMYRsoqQW3TPaCliZsPKFJy9otsJNFvmFZz+MH0Il/efBdhSe
 S3wbxTmLWfpRFXR4n4HZFQi/egwZUL6y7URa7TfMguLOtGseYa/Ugtr7uaS+RYVNoqQw
 nJ+g==
X-Forwarded-Encrypted: i=1;
 AFNElJ+MRXu6kyk3lzeTLPpOWhih5m6uL9biuHCZ3m3wQM3D4mw0FYtyOBKQ3cw0bqEUYKI7z2/rhbYUiL4n@nongnu.org
X-Gm-Message-State: AOJu0YzYoMuQ+i2zToQ34VZTCrI3B2V9eEvSBISubTJVREkj6Cc9I4s8
 l4gjlv/eUHl+D+p9GP4W9y65iIQvOFD7g9Qzw846p1K6us9uBbaoXK+YKXEuaXDoRwl3BcdOJ3/
 30WPZJEp8PmQuw2uKU+aW8J1PLhnyWvgFanaSphxgLeSTGbL/VAxKJlcIhA==
X-Gm-Gg: Acq92OFPmt4u3cb2dViadduDac0/K9alnvY3nnBKix/ezXlPB4QEgUPQW5urwcW2+p0
 n3CPWZFYcyk6fsHCOwICx3WocXu8MYq4hqDY34Dtl1UVoDyLXAaQPw7n1DynbISUQtfQUKISap9
 3P1kr8M7u0AkUMOSftjkitogpHvJ7Cls4dnmKd85H483SrOscobc90Tew1N47+eIyXDvbeqjW8G
 YK7J0TuwCt00vbXn6ilzlCrpkbvzDvWpbIIuAnpOgET29B7PeRWZ+vrh9V7pH1JZHuUb5eHWIIf
 kxZYLGVG/km7QQE9EN30iteYF3l8oHeMktLho1qw7sL6BavnA2afa4NpEl5pjjWcTrw2oQ6QqOt
 +MPU7w9AXcFXv+6d1qOR+gPltWggU1LJgwthpEW63375M+XNdbE5Mz3ihZrwJE9MpI8aCykjWbr
 qav/h8BjA=
X-Received: by 2002:a05:622a:410a:b0:516:ddfa:b6b9 with SMTP id
 d75a77b69052e-517ef0b7dc3mr26341431cf.23.1781180588277; 
 Thu, 11 Jun 2026 05:23:08 -0700 (PDT)
X-Received: by 2002:a05:622a:410a:b0:516:ddfa:b6b9 with SMTP id
 d75a77b69052e-517ef0b7dc3mr26341041cf.23.1781180587846; 
 Thu, 11 Jun 2026 05:23:07 -0700 (PDT)
Received: from [192.168.69.208] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcb13sm81753242f8f.2.2026.06.11.05.23.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jun 2026 05:23:06 -0700 (PDT)
Message-ID: <b3fc0df6-13ce-480d-be7c-d3cac2544828@oss.qualcomm.com>
Date: Thu, 11 Jun 2026 14:23:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/35] irq: add per-IRQ observer to fix
 qemu_irq_intercept_in leak
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
References: <20260611-b4-ui-v3-0-72bcbbea0fae@redhat.com>
 <20260611-b4-ui-v3-3-72bcbbea0fae@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260611-b4-ui-v3-3-72bcbbea0fae@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDEyNSBTYWx0ZWRfXyK8qV1yQdMoH
 UNCmy5yBzPdQNuImlo+fiHgx4DyxdONCAUZhqHHa/RCTQdVvi62yi5HghoKbjeIRXrAsre0vGcl
 fsO5s6fVzsBAgEQjubP07ZZa9E2baE3SxpOMXua7LvvSElw0TctFyYLqiSNHT5FRtOilEEOB2fc
 plgPxwtaX5Oc0ZbvgD+6Ju3BflXddSW3uFyFASeIsmZtTGmUIjoev7YPj3pGcK9vS4Zbm/5eLNR
 rUlGBbUumHNDTiw5oyJBYBuCd3K+T82nhjXThAVfrD3MuBq9dwgBhm3O3KdkFFNrR1w/6uSTdUs
 Ak3tqRBJDgP49QvRMZXtjq28e+QInB/FUDQVZWXt6qfvWUKIa3Okf/UioE3cZOdjwEZ9IsEkfil
 puRxA2cPiSF0iZ86Ek6toK10HN53U2YhI6qVhcTKg2aF71cWbHFJBc3x44uJvjKwGcih0NMqf5u
 7Jw0123kP5U09RnSS2w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDEyNSBTYWx0ZWRfX38uJYccQ4Tr2
 dGGofGinRYbsUq00c5y4+X9PivCQRnT+eeVDk60QJmbV762yAe7qa+pLe04EvaoFcg9thdwg9/9
 Z5uE4/LZw3dwd0rGp926nmxv9xgn+6M=
X-Authority-Analysis: v=2.4 cv=AaiB2XXG c=1 sm=1 tr=0 ts=6a2aa8ad cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=OjBiz94cRWXKSK-G1PsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: Vu-ORT7r18R2XlttAQtEVBOH45jSI0p4
X-Proofpoint-GUID: Vu-ORT7r18R2XlttAQtEVBOH45jSI0p4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 adultscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110125
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 11/6/26 11:03, Marc-AndrÃ© Lureau wrote:
> qemu_irq_intercept_in() saves original IRQ handlers by allocating
> new QOM objects, which are never freed. On a PC machine, this leaks
> IRQ objects (one per IOAPIC pin) on every qtest run.
> 
> Rather than tracking allocations to free later, avoid them: add an
> "observer" field to IRQState, called by qemu_set_irq() after the
> real handler. Interception sets the observer instead of rewriting
> handlers, so there's nothing to save and nothing to leak.
> 
> Fix qemu_notirq() to route through qemu_set_irq() so inverted IRQs
> trigger observers too. Drop the LSan suppression.
> 
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   include/hw/core/irq.h         |  6 +++---
>   hw/core/irq.c                 | 12 ++++++------
>   system/qtest.c                |  5 +----
>   scripts/lsan_suppressions.txt |  8 --------
>   4 files changed, 10 insertions(+), 21 deletions(-)


> diff --git a/hw/core/irq.c b/hw/core/irq.c
> index 106805e2417..1b610e75e15 100644
> --- a/hw/core/irq.c
> +++ b/hw/core/irq.c
> @@ -32,6 +32,9 @@ void qemu_set_irq(qemu_irq irq, int level)
>           return;
>   
>       irq->handler(irq->opaque, irq->n, level);
> +    if (unlikely(irq->observer)) {
> +        irq->observer(irq->opaque, irq->n, level);

I note there is a behavioral change here: before the observer
was called *before* the normal handler, now it is called *after*.

I suppose there is not impact with current QTest implementation.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

> +    }
>   }


