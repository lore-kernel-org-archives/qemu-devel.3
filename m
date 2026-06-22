Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B661CDB471
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 07:57:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbZX4-0008Op-AE; Mon, 22 Jun 2026 03:57:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wbZX2-0008OY-HL
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 03:57:24 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wbZX0-0005Ep-RE
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 03:57:24 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65M59Bss3850480
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 07:57:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4U0qTUBtyRd68zcq9QaJsVbwdUqDZByCLaaFJ/NPhvo=; b=M2kMgDdRoOnM6zOT
 xJoAXBO0wwixIi+AMl44ofWiUtuf9itH1M2TePh1yWSZxgJmUMqMApoHGFRHRjG6
 TJ+siKdWpkOO4Po4oyl7fx+WeYmYpmEgKQJqzi706tR60FulFegBw31s/lKwqbuh
 pCr8AoXk0oTPrt4KNN1hofKV4+HsH/+uaQGVsCEVtVjVHJAO7QCyY5HsPSkPzP/7
 4y7c9/kP84sFDT+Rt/RYCukcfs83xO3iR54pDmGB2pVQt1UuGHT2bNXnIQEh898n
 9NWkAJGJzpgDhbZAgUN0YT4wFjCJ20U1ad2bH1mmxjIZksX/Jx4xuyaPsTw1m8/9
 lZeYSw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ewm5856ua-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 07:57:20 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-9157d38ab37so358001685a.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 00:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782115039; x=1782719839; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4U0qTUBtyRd68zcq9QaJsVbwdUqDZByCLaaFJ/NPhvo=;
 b=IrKjkRpJab4xhTp8GygBN3902uWgygRL4zo3XbtnNEio9S+3SdFPY0aNQqDIwIxzN/
 fs/4DNzKP6CZwCImRMoQ/pq+EWMmrmbJ1ID+BqAJ0If7hJWXRyRV8ZYU5+BtGQgt70qA
 jtZaa1PmjiNJB4JISovJVoYTbHk1WbntAZhtzbcgWstlxbg8I0eDPfk4eBoBhbOofb+3
 vzC0yEJkSEQOCygBxpmXyorhl0wvtGz4NeEQ0cENk+bP0d5X2N9ZsK32lAdsMYZyU+FM
 l0e9AU6Bl4Pi1bk9K8VefggM1HQPibb8k9GhLHa/xaBowqFVbxLQXw9md4f4C66+OpKH
 uIEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782115039; x=1782719839;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4U0qTUBtyRd68zcq9QaJsVbwdUqDZByCLaaFJ/NPhvo=;
 b=jqAV8SeCkYvqSJEXxAoLfH7VmQBFZfGyZrlS9s+JUl4acoHfJnX3EdIxzr9jRSR4V+
 VFOiZXd7myLj6WLXoX/tXqTGkTPV6FxJRfgDPb2LGLLsp8jMt9I8DzxKc0MjggpS9p2L
 OPGkUObBEcOSNcMPamd+0Jy0AQno+KBvU4Y2BZZS0xMpdl9q+wPUlIJ8n5tKB5+yJIQu
 6veTXcroKIdHLTXAuxu+z8q9EDAsS36jHCHCjBPOJtvSKkTLHNjazDe0KniCgkbpoPSd
 TplHSBKD4O/ZWG1hK+9fYrpipOTBj0EVZ/u/BfCmMnOAw+0h3n/wrn7n/E+A4AYlABJg
 wu+g==
X-Forwarded-Encrypted: i=1;
 AFNElJ8qZ7eFcJ5DKpnt1ciJn3afAdMpuCmDEXSdrbjOJXp3l9MeZpDEctuNFle+BeaBLmTRxQ3TBqzKhUtv@nongnu.org
X-Gm-Message-State: AOJu0Yyy1/CzJvrNAPhF0TCsyFEtNnaYIdwRFj0Tw1UKeKjxSa+1i5Hz
 UOwA8YaEipTkbU/0e3AiRcGLXKzx9oHz7YMRv29sG6WrZTj9dDa4NplRB8ck1zH8hEhqJ6fNqgk
 SAwoI0IaExs/2eoAWFDPHJKs+SVOgxqA2zCaCqs3HhGScLYDyfEjHE6oGFQ==
X-Gm-Gg: AfdE7ck1rJMdNV77hI39qvc7WzjCPajQ+ZoDvTJ/BydqslhBEIXhZqy09l8MuSMkkT7
 pa0rQMdCFPwCBsp2vK77SA3NEYB/W/ILaiQki5lmyrCnnWmDy7DSjOgk63oCX139bfh7I8f+7Fw
 EoO5z9SWRmLRgu1ZJkyNQrPEHTL9bRRQ3pOXpNUZddp72mIPjd4nKQQE2PhVDiZwNJmufj/J9Ua
 0mVerpFdtCIZQ0KRofMkO2QsJx5J5whtaOW6P15uMFGeqJLJs8BT3VdvCr6UBju25igmwTd1LmY
 qxKXOrjBDFdd4dZFEIi06wLrYjq8eDci8udUcxQ1w6YSSIq8YpxC7MaiLpx0XXz8XfFPZiQVvl2
 l/6du0zWFy1AO+bkS/4HEfBRKeVmILH6l3h6JMAAgKHIZjyAfUysdd/IkOUWwhH6JS/Q=
X-Received: by 2002:a05:620a:2592:b0:922:92b1:9dfc with SMTP id
 af79cd13be357-92292b1aff4mr1170358785a.14.1782115039358; 
 Mon, 22 Jun 2026 00:57:19 -0700 (PDT)
X-Received: by 2002:a05:620a:2592:b0:922:92b1:9dfc with SMTP id
 af79cd13be357-92292b1aff4mr1170356285a.14.1782115038892; 
 Mon, 22 Jun 2026 00:57:18 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4666722141csm22809473f8f.34.2026.06.22.00.57.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jun 2026 00:57:18 -0700 (PDT)
Message-ID: <b11f77bf-68e7-47f8-9c39-612edcf45467@oss.qualcomm.com>
Date: Mon, 22 Jun 2026 09:57:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] fifo32: add fifo32_peek()
Content-Language: en-US
To: Matt Jacobson <mhjacobson@me.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>
References: <20260617235032.21491-1-mhjacobson@me.com>
 <20260617235032.21491-3-mhjacobson@me.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260617235032.21491-3-mhjacobson@me.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: eh28szGgi7rhmCJTnDYbee-5tnPQBRf3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDA3NiBTYWx0ZWRfX1Qrzay0X9v+X
 861wMRUeM0pA7/Mk3WG+jQBQsk0xG/+ppiXC58Lv6IYCowot7Oc3XugSmeAi8uNiYt+cac94q9g
 9pR2xPWxONF7rEDrk8L5XgMBkELiUNs=
X-Proofpoint-GUID: eh28szGgi7rhmCJTnDYbee-5tnPQBRf3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDA3NiBTYWx0ZWRfX8RP76liqvdm8
 dmBMqjpXCvsCWzvukOIEm/WeIjZ71TuYpXPiUAml0ddR8raIWVMhhXhPMH4XX/ZaSIFBM/2uza1
 Ti2XgUbchTq2CH5MB/eWl5m2cqrf9Qu+pHi/EMm9dg/wmm1gkTGhHLong+MYLe4eXCe6ix08PnO
 NX+v3dUhSn1u6SeVC+OGDdJwEC1XKiepJ1sVTyKdGI6hjSP6M18y6f8/RWLFzYEiyKN8cA7MhMx
 2Qr5xHWrw7TdExtjr3sJMDdT/ULIKV2It1qLa0nau7u7u9OFeBICQCOpiTwv30WcRnF7oq/vc3z
 sBVO9mlAre4F0aGubJ5wbtt47AipwNlrIvo9S7Nn4YV/vWY+9aR3BIPdCHCvrIjsN+JKci3emlK
 3BYGVUDcuMp8XuY6gMprrCW8HCMkO7fAwYPCd2aJoBmelzYt5TLvyb+quWbdHFp8XbMKcPv74pf
 IiCtPxAadHmVsZ3fEkw==
X-Authority-Analysis: v=2.4 cv=FOQrAeos c=1 sm=1 tr=0 ts=6a38eae0 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=HHGDD-5mAAAA:8 a=u75_4Xg0zmV78RZO5TAA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_01,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 adultscore=0
 phishscore=0 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220076
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

Hi Matt,

On 18/6/26 01:50, Matt Jacobson wrote:
> Add fifo32_peek(), which, like the other Fifo32 functions, ultimately just
> delegates to the Fifo8 code.
> 
> Signed-off-by: Matt Jacobson <mhjacobson@me.com>
> ---
>   include/qemu/fifo32.h | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
> 
> diff --git a/include/qemu/fifo32.h b/include/qemu/fifo32.h
> index 4e9fd1b5ef..7601bcfbfe 100644
> --- a/include/qemu/fifo32.h
> +++ b/include/qemu/fifo32.h
> @@ -117,6 +117,31 @@ static inline void fifo32_push_all(Fifo32 *fifo, const uint32_t *data,
>       }
>   }
>   
> +/**
> + * fifo32_peek:
> + * @fifo: fifo to peek from
> + *
> + * Peek the data word at the current head of the FIFO. Clients are responsible
> + * for checking for emptiness using fifo32_is_empty().
> + *
> + * Returns: The peeked 32 bits data word.
> + */
> +
> +static inline uint32_t fifo32_peek(Fifo32 *fifo)
> +{
> +    uint8_t bytes[sizeof(uint32_t)];
> +    uint32_t ret = 0;
> +    int i;
> +
> +    fifo8_peek_buf(&fifo->fifo, bytes, sizeof bytes);

Could this work?

        fifo8_peek_buf(&fifo->fifo, (uint8_t *)&ret, sizeof(ret));

> +
> +    for (i = 0; i < sizeof(uint32_t); i++) {
> +        ret |= (uint32_t)bytes[i] << (i * 8);
> +    }
> +
> +    return ret;
> +}
> +
>   /**
>    * fifo32_pop:
>    * @fifo: fifo to pop from


