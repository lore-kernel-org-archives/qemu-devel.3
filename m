Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CA9CCD8C9D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 19:47:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXlMd-0006is-Te; Thu, 11 Jun 2026 15:46:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXlMc-0006gL-AD
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 15:46:54 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXlMa-000266-Qz
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 15:46:54 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65BJ3S8s1479974
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 19:46:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 aNQ7+b7zsuOFuDbr+kHzEE3wVmJ9L0MHXUrmbqbPpP8=; b=LAJYPkpuULWk21WJ
 HavK4D3CQcKkEgTinIkXQOvGfAoqOJQJIpIqRexiXxEGTBRgM15IahNy6M8SuhTg
 rgdMupEcI+nZoPThWuV847VTp8Vp6hEUXOAiWX2gU+q9jf0MbzlPInxPAVcKR7JP
 ts0ayqvMV5T8utEGkeY9sEHIP3ooMOn6YH8qCe1SQ0XrW781EWUVEs6y+TpPGGPO
 ekdhpJRz4oXuki/z78Xrg31Kkh9NScUOYS47W6SRu97s5WvTMb0eggFDk7+9wv2j
 UapEdOzfhDnb90XjzWsMgbCFdpSFIDOeTpwcAtw1wefcrPAlwrrNVohZvdGWLje0
 7Nb/hQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er0x7grry-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 19:46:51 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51768072950so1933491cf.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 12:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781207210; x=1781812010; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aNQ7+b7zsuOFuDbr+kHzEE3wVmJ9L0MHXUrmbqbPpP8=;
 b=OJvHnzIoeGh2qj406evmhRkw6P3PmpvrAvDKPD9CkTeGKefJZRlUCOiC9PMWzszqSZ
 tATG4Bnwcp1H0PZEb4d2vdqNw7bpC8MyOFB099KjSO82Y9beWYU4NwAsb+TQBV6qrcwR
 PypqpVRscX54iAFdErVgJBieKTAguNXY5piLks9Bs+GxWLjTPxeXtB/c7h1tl+zkV+l5
 DeLR6AvESHr98eE7lF8RL2EBxBGLbU2diRo/LV0zuiW9hqE3zk+/dWi8rBCsQu81jrqm
 4Ztn1nckciRkZNCaI2gs9tA7bFJK3W+h0w9ujqgeQ1jVjTQMfs6p02FMzR5lnasbi8aF
 CPjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781207210; x=1781812010;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aNQ7+b7zsuOFuDbr+kHzEE3wVmJ9L0MHXUrmbqbPpP8=;
 b=AqSX//ao6d/X/RqAE37+p0hWYyIw2vJhSDO2izKueSHaqjw3w0+2woUoT/pMqV8N4L
 6S37fGm/pzu1/Ax/rui/t6VaDdtuHET5tHxVO7pcZ6mmPGxEVOUoNk+iMoZBhSKVlswF
 UOcLyKKbVmT6lDLRhhSXE3Uz8Zu33bgnrnNQ6Q41PvSLz5MbvYdvj2x+0H1TPdBOUX89
 tFJkeCe73x1Y8b4/hc0M8nDrOdIVhx8H//eaiDsCT2zIsNPJ+fn2OOJDdpsA6xNquzoh
 T2ZAmMbgh4xg4xYKc3tIe7IDVeoQCOi0YoNNE7JubJIAjl54g+bnWa0Fn8mN+QgcPir6
 03WA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/iGMMA0I+hETR84mazvUSKUYcN2e9olwd13DuNxXekiSviwaiaBKJTsb3nOap6t9bVIvJ7D11cumbY@nongnu.org
X-Gm-Message-State: AOJu0YyaO8IlTrRSgn4eCuHmf8i+7S8VjEG1Ui+2A2cyXwj0lVK7ldzw
 TMAi//0rYaR1PVIMIc+ItiR8MzKuADdwKIAgXtmVdfyejTzXXJ6uGrqlLUt5lzZ3UTI/Hb7cN0e
 LH7KatR2XKHiW0yMErv0Uci9ZPzVi3plK41/CXh8lomurcwKlaNrOSNT2CQ==
X-Gm-Gg: Acq92OFNpeOxPBtoJRM5MR1VjM4ETZWIqBiolvQY1P0rWAfmT0cEk9vy4Kx9zFEzHlH
 CdWSMm9umlOYToObyjvzIgFBlNRegxrLjkZLxur4GvI6hdDRWKi5GqSmoRSEJMo3kNg0EJvHpta
 kXmXt9NoeivdsbM3qFmOC0BMnjJvCjfZbbkjddJxVSbEalRuRkPUEsywr0P+hKvRFz9B00YbXJm
 LNR0fwIWVsaXOlN99TgyZ+BFVQMo6Y36cVg4wb/FDG4lc55MIB8ZAdsz1PxUVUR2z6eVYThwm0/
 f75B7F4jpn3X/xdYtmyg9eXQ1H+CP532Gyn726U/glXjRRdYsVKKHy3E9Frj+tl784EtjqZwVf2
 vBr1KTVLSOKPVv4TmxXvLjVZIuISA2t7hpM0H4vmrXd/YzHpRkfJhufZJpLKlhRZPlt61Mqae
X-Received: by 2002:a05:622a:164b:b0:517:9157:ecf0 with SMTP id
 d75a77b69052e-517ee1d6090mr63040771cf.29.1781207210330; 
 Thu, 11 Jun 2026 12:46:50 -0700 (PDT)
X-Received: by 2002:a05:622a:164b:b0:517:9157:ecf0 with SMTP id
 d75a77b69052e-517ee1d6090mr63040301cf.29.1781207209909; 
 Thu, 11 Jun 2026 12:46:49 -0700 (PDT)
Received: from [192.168.69.232] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606c0c2066sm2217346f8f.5.2026.06.11.12.46.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jun 2026 12:46:48 -0700 (PDT)
Message-ID: <0835ad74-2a62-444f-881e-2a9f8dbd61fc@oss.qualcomm.com>
Date: Thu, 11 Jun 2026 21:46:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 22/22] ui/input: remove old LED handler broadcast queue
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Jan Kiszka <jan.kiszka@web.de>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org,
 Thomas Huth <th.huth+qemu@posteo.eu>
References: <20260610-ui-input-v2-0-f68452dd6a22@redhat.com>
 <20260610-ui-input-v2-22-f68452dd6a22@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260610-ui-input-v2-22-f68452dd6a22@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: cyBlVS2cfUurI-Lwrn9p9CsvcI7eyNDT
X-Authority-Analysis: v=2.4 cv=c4abhx9l c=1 sm=1 tr=0 ts=6a2b10ab cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDE5OCBTYWx0ZWRfX2fC0UYGJAQiS
 s6uX3LO0j0e1oF/6DQt/6f5de/Znrd0sMq2/xSfWtKNCckxRIsUSrKgonLCSfM1MRKeN+cUdHZY
 ZTd/qGW3XJUoiQRrdbK7T4WToouf/wYGWypu9FXdWsj64UQXGRMKjyeRClyLLHsJ1aWZMvi+tjG
 VP3HTIZxpuZXteMS70dIgN8wn9hPu+c5zkaih/H2Q7QyZa6y2CRW5mEvXupvPFKCFFmHTmZJg4n
 FcrnIlZGttaGf4uv4Sqd/AgCRTE6whCqHyx2kvzrWigzIkWU/AZOMUd9FCvtf5pJauAyQJVaOAp
 6ZHPjlk9+rHlRM0UsYb+MVjm9zPL97bBXs9pv3X4zA3K4znIPzWbPmkLJ/k8JNMEGEZ0lC3oQmC
 IcOV8Pp5H/Cb9IezHqi6HxIKZ/7rIZEU5yNKpCua6EQxXrg+KLmSjOP7SYpHdKwB58BbKfve38z
 ruYt8no6nrCzSH3nWGQ==
X-Proofpoint-ORIG-GUID: cyBlVS2cfUurI-Lwrn9p9CsvcI7eyNDT
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDE5OCBTYWx0ZWRfXyC2Skl49OSMu
 tDtVw2NsKfCO14w9soAChS6Syuccj+nwtiF4N8wm7EEwpykToLGuVuFt+XV+0Gds2ED91CxhvkD
 SwnG8J0e6xlG9h5rDA/mCztv+fF0cSY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_04,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 malwarescore=0 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110198
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

On 10/6/26 12:57, Marc-André Lureau wrote:
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   include/ui/console.h |  9 ---------
>   ui/input.c           | 40 ----------------------------------------
>   2 files changed, 49 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

