Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6AF3C43602
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 09:01:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgfC8-0000mo-M5; Mon, 06 Jul 2026 05:00:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgfBp-0000b9-Io
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 05:00:35 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgfBm-0000g9-Nl
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 05:00:31 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66641TUC3616929
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 09:00:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 M8o03K34IN6HUYTRNHYAq0K51TbMW8VZZxntZfzIYSU=; b=M2IS++Q6xFJ6TwID
 1RnDJKkbZMn1LmFFYMxkQrD4u3jWA+i1Qg4B4Ysuuckpvj+AMw9hQ2bJ2pdIQoIx
 W7tuLq8jYVFcKcdjcvfvtDJ7oezlqc/F9ajom8rbIOhP5VCcJ1O8heZv0gN+T4WK
 5jYpTURAEGMGmVjvv8oCYgzYS8fjLoKmB3UhISCeV21/P1ztXFEdRRmrzSZBvmUc
 53TVMdjxIhVl5n76tWC32Re6EBZVUmnFccbyJvSIgFst6ZyFxJAX6RxINJZoxV1u
 FNzuYC68dY/wvPS+nkVPrOxV1LPlfNUPMxBBUQMjSOtZNpBZQ8stGcRvFy6Fyi4m
 HKkH3Q==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6s64nhtr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 09:00:29 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e7ee64b25so474924385a.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 02:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783328429; x=1783933229; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=M8o03K34IN6HUYTRNHYAq0K51TbMW8VZZxntZfzIYSU=;
 b=XQWftvKjnHEjnqPwp89s/MST0Sbqxh7To31a3dso8ltH/SQ/XBsJsOhuwURQXs6zTH
 LyTkyDp3iolJQMC7No2nxR+LPYfMi/enjX5m0RTBqxbUZrmlNIfEORmmUIazF41euWhn
 80pKAZvYV0+A5rkCl79O4zJiM9VGXFSAlKBdX8N1JoK+OBlqUlG46M4zkz+hLVwZc5pi
 YUmmyM323qP1gTH+eK9ZNiFfjWiBfqjUWveqE15Saz4Vk5LI1WQaJsGui10zyIf8F5Bc
 tARRJml1RAZPRkwWYM5/hImevjy9EGHYZRr+WBpO+5vpQNZ3S8RTIegKPe9WBptQV+Nr
 ab2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783328429; x=1783933229;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=M8o03K34IN6HUYTRNHYAq0K51TbMW8VZZxntZfzIYSU=;
 b=JeriwD7UqQzPCkIysblVe392MxD9gi7/CDHcRvSQ3PCCeP5pfLMMVUFqt3CcJRqpkg
 pJSd/oMAscFSQG+1kMNoMLJOdDYlCoEkRCNR8Qqd5/zmFNSoi7oBs+A9McKwOmfBHLks
 O1VyAPYlgN0nvxu0dHbkOyr1EisvqNTNE2/UafNx2N4CAgFRVJVf0flxWPJ+r5aT4Ozo
 u9/OYjSOeyDebNWBi9JWtlCn/pEkekh1Kc0uoaDb1IMNH3NZ8rPrTgyiIwIuzJW/2S79
 7x8TSdFc1twVZOVtTht7HhTCBiJMMkeUFQl47cJEKhsAWkvZotZmpZ24s0FuYDt664rd
 AJHg==
X-Forwarded-Encrypted: i=1;
 AHgh+RprHTjDjx1qSoBu9JKEiKN5kVsJvGQWgk0ASSeorPv+rULZVkPlt54vdiQm45asIL1DIPGwKFlByf60@nongnu.org
X-Gm-Message-State: AOJu0Yxz7un7DZBSGz5gEv2f1F8J4efHbnFAe5tqLnmS323oj0CNVzfT
 bbDyhlI8XG1LbFFUgnUKScK/fAm5i8Q9rZLYFZtJyx9T12u1wNNjKuf6YVWCMhPsqdiuiOw+PGH
 vv+oXxP/smOJ3/vbaKaNEa9O7AmFpWLoxrG5uv4bhrjcAPORQV8W3/N2f3g==
X-Gm-Gg: AfdE7ck5+odGAffyyetbSNCWS9cXkHdx6uIeLGDAiBXJ3hy+wvIN9G8igPwbxMY1kI3
 Fq4SSrquuQuvc2otBtleepA1TPv9s+2RkigRcPZl4vbLOYWKMiqZk9bXOOL1qU9d1RblmTagHJt
 GxZRl0zJR9hVKm5VxQUFxmYF5xKQcssOgY8L0e6ILp7FIOwdLKD2qX4fjUfigJp6WkqoJNHcIMl
 0OI8gAUumJmezK0ofyZ+McQyz7BX5huwEUUWdoZSdsES/ghEHZvpvMCWua55QUQnQUxG9XfnTfR
 PgdyGizAvmJqX6bJIECT3BpVT6mqhipvZ3K+OibiIyBR63aksMVFBJSP2zh47fzRoplhA13Nzsw
 YzV3pOTSihugbtct5zrjo0Rtd00gb4rmckHlkW6e0xcKdmZBih+ATAFgdEntonQ==
X-Received: by 2002:a05:620a:44c2:b0:92e:5137:2830 with SMTP id
 af79cd13be357-92e9a4d281cmr1200675785a.72.1783328428157; 
 Mon, 06 Jul 2026 02:00:28 -0700 (PDT)
X-Received: by 2002:a05:620a:44c2:b0:92e:5137:2830 with SMTP id
 af79cd13be357-92e9a4d281cmr1200667985a.72.1783328427554; 
 Mon, 06 Jul 2026 02:00:27 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c12b62f38f3sm707917766b.57.2026.07.06.02.00.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 02:00:26 -0700 (PDT)
Message-ID: <adad2ea3-fce1-47d8-98ae-bae37c1a4a08@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 11:00:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/hyperv: Avoid crash if hyperv_find_cpu() passed
 invalid vp_index
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>
References: <20260630084855.2319838-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260630084855.2319838-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA5MCBTYWx0ZWRfX/3Y925WPaIMA
 wPqdPZxydikpyKNDh0KVi4bEnOWvPmsBgwsa+fwmXK10LeHwyReoTqKCNQlPPKNwNPUURBq21m+
 AEeG4omMCY12Sv6HFb1g6eCqefj9Ie/ha5aN44oI4CEcKWlrUvOfI6c5rgI8I0w8hRCw6ewe9rw
 HXTzVxmsoXvm69qCnGXpC9JrSynch7tIni4dXG0ya+8Y5eYg+PxRMwLa0tZ+j+jS2UZ1zcJoLOJ
 RuVk4RYNG3mmyzNJNKAWw3w03wx8aMBnDot0ypO01fRrkNF6/d/mjli/6nSifVjaUe6yNG2CoGl
 a8lcO1gmh26XSKz9frQiqdldyrz0oo/zT4NGGYQCXSC5/q4j1XYfKc7Vlcpf9ZM6wddIZtYPSz2
 K9lizKKdkoaY8iKnhrWUuqU6qaRnpGWl89NxXfN2AAbtflTxsV5Pxx2pGz50WiSeUawu48QO6UQ
 kd4TuvjuEhvdft+BtWw==
X-Authority-Analysis: v=2.4 cv=VvITxe2n c=1 sm=1 tr=0 ts=6a4b6ead cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=p0WdMEafAAAA:8 a=KKAkSRfTAAAA:8 a=eNRvlODAyYeRk_z16H8A:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: Qgw0OP5xA4xdKabRBmipRu6I_XmxQimO
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA5MCBTYWx0ZWRfX/qM3FyhOPzbK
 Fp/gXLPUsXiLUTDO29w8T0ZVtWZW/lW7cLH8ZnLNiOaxcBt7rqM95H1qvbefT72aivvNCFmLWiJ
 cKgRI1YnWB8r8xcjiomcTUtzVjEAR5o=
X-Proofpoint-GUID: Qgw0OP5xA4xdKabRBmipRu6I_XmxQimO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060090
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 30/6/26 10:48, Peter Maydell wrote:
> The hyperv_find_cpu() function finds a CPU from a CPU index; this is
> basically a wrapper around qemu_get_cpu().  It is allowed to fail, in
> which case it returns NULL, which its caller handles.  However, it
> includes an assertion check which accidentally assumes the CPU
> pointer is non-NULL.
> 
> We could assert only if cs != NULL, but the assertion here is not
> doing anything interesting -- hyperv_vp_index() is a trivial wrapper
> returning cs->cpu_index, so this is effectively asserting that
> qemu_get_cpu() did what it claims to do, i.e.  returned us the CPU
> matching the index we gave it.  qemu_get_cpu() is a simple "iterate
> through list and find matching CPU" which is unlikely to be buggy,
> and we don't feel the need to sanity-check it in any of our other
> many uses of it.  Drop the assertion entirely.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3568
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Checked only with make check / check-functional...
> ---
>   hw/hyperv/hyperv.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)

Queued via hw-misc tree, thanks.

