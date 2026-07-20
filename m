Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C4B2C44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 07:31:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wliSb-0007vs-1n; Mon, 20 Jul 2026 03:30:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wliSZ-0007vX-D1
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 03:30:43 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wliSX-0003k4-LI
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 03:30:43 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66K6RVV41520116
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 07:30:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qqBY1i/Xz0JVX2iw45NEKQP4haCtXdZAyyJwANTxUFc=; b=I5QZCKUlx9OE9zk9
 6r0Rvo6qftelC3kAVhMSPq+bimgU6qdRwAtjcC3P/if738AC3lE8AQ5ecgFvSYY6
 3fCf4RAkP3YfT2HEIEOZr+4lozGBLZVd4kgmpBRaOZ8bofc7fsDgWZMEoxIPsCPE
 2jr0qHtyqw11bhuBmboJhS7xjYtyYqCMx+SBA0Tw8bThY9HhcNYhnNDu+m+o+IVv
 ntfWzj4WNSbFVNYNUSPj2ahszxPA2IvT58pQEXn+Q4s+7Zn3/GuQFDn13WLbqgHz
 BjrJNMl05mf+o/H1NSYNKqGdh4F+g3FXsTcMs4NZkGPQZWJ2rmb5HjFkKFUEHcWr
 b9YWig==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2chmxj6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 07:30:38 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c1852a86fso138306821cf.0
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 00:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784532637; x=1785137437; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qqBY1i/Xz0JVX2iw45NEKQP4haCtXdZAyyJwANTxUFc=;
 b=ijSauJJfOXywzheQk8SLKi2/O31p+wmGDKLM8BqWb31zMmC1UxD7K6y6ylqTj+e2JE
 pyCe1MxyfZ47L7hJ9uAb814rMdBm5hYoQTEXmWNQ1qGBrPTMtoPIGtOC5vPjxUWyoFUP
 p2F4qU+ZnpGVNjWnekoQQrUoPFzGzkWhAgmOq+tkNVfzSTme1CgwvDH5vwRncmbhYbgf
 agQA0GAX7eqdA8LM/hvZRUTqh05kG42e0zDAPDxlzOv+w6HMGGNELQdJ2QilQTfEKZQr
 qk0jnsEWaAHhcXp/rSZNwM/0ebz+zTPKCeUSQdlsyuLp7S1a1m93ZB/ApWR1YNkrK6rY
 i+1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784532637; x=1785137437;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qqBY1i/Xz0JVX2iw45NEKQP4haCtXdZAyyJwANTxUFc=;
 b=Q7qfWvtUYycb/SJlmid0z0aVWoyV/m39P+AJPddPrgmpUzLICbECii/ne5zR7aXgsT
 Jd+6QI/u4VYiy9L6SrONkYljVLZ8MqNCqDeOO/lfe5D0HingJnwQEzXV4vjBUJYlo0b8
 FNmFK5ffoYYbTpmrCTGYavJN2LDtVoZBavl7SqR5lzBpUFaFOolbJ4sv0xaDqRRB1GwY
 bQxiP9DnGKC1jCAitDJZk0ATerQge666ApohKh384+8Z0jZ/qRExktxenC/vdYjDR+5s
 JEh5kA7DJF57DKzrv4nQYeMWkEpabqCZguIdt6RpW8EvVFO/oZ9A2T4D1ZI4dTnSJmG9
 zPUg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrVQ8cpv4pUTeRw5YMDXJuZwsAAji+31izV2Vhr5Aj81DpwA2zrTQpI+VSn226+X3LIM6vTBlIzPODT@nongnu.org
X-Gm-Message-State: AOJu0Yz1xoFCbHZCcZKNOvq7PhgkC+CUOEDmy1xsV5NPmhYwhfBZzkaD
 vyxt0E8vpX1ALKs07xxIbptf9p3Mvi0uhFlLkwnmYRoixZfQh2wxN9glLHXldb5j949sw89EHG2
 tWORoTul+z48jtIp3jkPq4ZD2cbq0hp7gZ0+1JctbxsmvFzcSIMVgw5ioxg==
X-Gm-Gg: AfdE7ck7dHP9RdtmjAp8QryJmkaY15xmllmVbWZD5zeO4E5l7+7mzgFSO65LRub2deY
 3YAeQ4dUSMciKtvNmkNs4PsY3PQ+u2ldgHYMCDkuRKvpLjP2zA+TiL+0yrEdAAALMbsV2AeinOF
 a4xGx8WrxVxmcny1PeB8xiw3HAA6jBAkQAF22yu8PuBTdSmZEpzZmvRJCGHaJZL6XAkipXXqGZV
 s9eV/Nu02OEyMO/Rc/bvzcP58XshlebT8OC/y4uwzsnFiY4s/wiWsJTcb9GV8fOovV4q5huWzon
 yzA28nVzqxeqHJIvWiXaNqTfpvk2hhjn65qr1vxLhGOMvwEE74HN/lhRz0/KMlwXag9giS/L4XZ
 c+Xyhfw6GD3Ip4GSjyQr9KREloCHEcPdSyxRuajxw+1QrOEdsTGY=
X-Received: by 2002:a05:622a:1909:b0:517:8470:2d2d with SMTP id
 d75a77b69052e-5213c9dc20bmr120595491cf.29.1784532637396; 
 Mon, 20 Jul 2026 00:30:37 -0700 (PDT)
X-Received: by 2002:a05:622a:1909:b0:517:8470:2d2d with SMTP id
 d75a77b69052e-5213c9dc20bmr120595271cf.29.1784532636919; 
 Mon, 20 Jul 2026 00:30:36 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-495499a5847sm187372315e9.2.2026.07.20.00.30.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 00:30:35 -0700 (PDT)
Message-ID: <b2a28eca-20e1-4af5-a861-68b19d3cde7f@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 09:30:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/display/virtio-gpu: Remove the bytes_pp field
Content-Language: en-US
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-stable@nongnu.org
References: <20260719-bpp-v1-1-9b91946d6cf3@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260719-bpp-v1-1-9b91946d6cf3@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA4MCBTYWx0ZWRfXy2npjHOpyS2d
 QKpBRJW19HK0nHe2EJ7REd7yRZRBPOPPp+1sLKlstgU5rvNTDC+1tC0r3Y32zRRwVtZdWugWHPR
 vWITeqixweKyNpLon3LpZqyHvL9bBfU=
X-Proofpoint-GUID: 8z0_3AAB0yA68UhHZgpnyb1cG0ISWzRt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA4MCBTYWx0ZWRfX6a6pWuj+KTaf
 B2yBx9g82toS4A0wppUGEjw4esdkjcaNdCYf0Nu1UH/xvczJXpUslpsdPZuUEj6F4e9JiIc+9rZ
 RXa7bTlAoi73UvFCQdFt8vEYpLe/RNsUSv/edIjl4pLPBxCK2fzABN0xM4vcDn56FsFxFT/eFTT
 RANCuL9MaAQbyaqgUx635nljwx8yZnrCQJle6x0nXHeCNtyH01jC8bp2f0uzX7HDNJ9hqYlvtZr
 IIUXto2B7/JEpROtvIdahWUYTzbr3pAEQ/BR26zvhSW2dshspGea42RfRWoZHFT8jiA2AEyktrP
 DDH3woUMwZwFyrej7T3+GFHLbQPBr4LRr7JDplyfcsyFQWI+ogRiPNsimxMCQZV6yEvkPywa0bc
 TmCuIQnRNenqNUQ1UVU7PrfVg3ALAqypaZnRMV/tzAKpoxGZ+Y9VVHSQfPwAMdT9l9Al7SVvJPq
 ex3jMeDpNdBseso4ksw==
X-Authority-Analysis: v=2.4 cv=T5K8ifKQ c=1 sm=1 tr=0 ts=6a5dce9e cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=69wJf7TsAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=LfsA7Cq2GQzuzbZ-N0YA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: 8z0_3AAB0yA68UhHZgpnyb1cG0ISWzRt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 impostorscore=0 bulkscore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200080
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

On 19/7/26 13:35, Akihiko Odaki wrote:
> virtio_gpu_do_set_scanout() validates the stride field of struct
> virtio_gpu_framebuffer against the bytes_pp field, but bytes_pp in the
> migration stream may be inconsistent with the format field, which
> pixman_image_create_bits() uses when it accesses the framebuffer.
> That validation is therefore incomplete.
> 
> To avoid the trouble of synchronizing the two fields, remove bytes_pp,
> and always derive its value from format. Removing bytes_pp is safe
> because no released version of QEMU uses its migrated value.
> 
> Fixes: 7b5574225429 ("hw/display: check frame buffer can hold blob")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
> Based-on: <20260715201055.2465320-1-marcandre.lureau@redhat.com>
> ("[PATCH] hw/display/virtio-gpu: validate stride against width on scanout")
> ---
>   include/hw/virtio/virtio-gpu.h |  1 -
>   hw/display/virtio-gpu.c        | 27 +++++++++++++++++----------
>   2 files changed, 17 insertions(+), 11 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

