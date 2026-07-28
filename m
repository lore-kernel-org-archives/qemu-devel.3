Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC5BFC54EFC
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 09:34:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woeCZ-0007h1-4v; Tue, 28 Jul 2026 05:34:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1woeCX-0007fN-Cg
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 05:34:17 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1woeCV-0006EZ-Rt
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 05:34:17 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S82DJO2480120
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 09:34:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 c2DPCJD6Y8Bczzg42UWD1M088tXV2op0P3q42R6Dftg=; b=GeP8e+Vc58LwGK0/
 RqeW6t7s6d3Ua/gFyTWW7e1aNB6Nsw8z7rDKlEfVgXOw4U6TAegqC7+OA6DJkrWL
 6fwSTs4vQxhlVZCL1+Gpmxfr65tNLGpffyOG64H0Gcqr3TWXp+YaXVVORI53u+oY
 afLmw4sm7hIEn3QWsae3wss6hBgvtcEzgQo5a6WmhsX+pBgW3P162soGXAE2MK/2
 zkjAeiqyBuMZnNR/3mQPIA1tSg0+B6CvJrmK4yQoeqzpk/9K/s9we8NkcfE3TGnh
 dWve7PHPyBQpJ/L52VgueyFF9gyPHvzG/G/nRanEjYIZ32O93nZPL49DzTh41npd
 bhTd5g==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpmy118dp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 09:34:14 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-904ee4473a8so45490256d6.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 02:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785231253; x=1785836053; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=c2DPCJD6Y8Bczzg42UWD1M088tXV2op0P3q42R6Dftg=;
 b=F5mS+wIzqaifrvBaazeIMFmWHtvnCpw8bDWEs6l+70CVZ7fBZ7D3i4oekJCOWgbmOq
 sRY0CrPMI6rKatfJSXXK2bZ7vPLFhqXEu63fJJtIDXCTI6Fcon5B24HJhSf6uWdhK3m4
 bzHEkzShpl94TWnLE8d6iAct0TXikQYm9s8dFd3dpu7o7+L9J9yWAtp17VIhD9zhHdlK
 vmwBAjMznCJDKfemUQAbDx/YXOOdTComzYYhkH8Ff157q2ep0IGARWdTXOkxodW6z8Tr
 4BPNUIev/KWvASXmg4SboAnYBDtZQorKXJk2hlqKqYkhYfpUJdxnDmwcrswA/WAolOIy
 MSHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785231253; x=1785836053;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=c2DPCJD6Y8Bczzg42UWD1M088tXV2op0P3q42R6Dftg=;
 b=Vq5gMxwRXZGdnc3a6bY5hWi8nQPX20g+Je2qijPOd9HG+jbYGSkEWcOMpEMAuRc1zY
 Jo4WNc0WvML01qdDoFk5z0f01EehqXs7dZnpg/ORiRm8roQFIZF2HRa7AvCfsLIY8IRd
 WMcGUuz0Y4NWvnI8+y8Noli5xVT6pmYlU3ndK/uQT+lmK8A3zJ259P3PhxoBv9DfTOXy
 2kKzsC8XipcFNxe65aQHjUYOLfafmPWxYxDpgilDgb3t37dFSIcJr1XusQuMH+xTv8GD
 NrhH9KLCfHlzoufUnOro1jEDoU7ROCCyuJul5END/4CgI1ccF3UorZKNcEucnk0Yfvs7
 pxDQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoCju/EdHjI7vkYGytx/QzZpStf2kBv5NqC/4Pe0JAVJaKN+0o4ZdqgaNdByWi9sZNnQLu4yISl3VcG@nongnu.org
X-Gm-Message-State: AOJu0Yz/zcHm7GDIXGaUhb9b+UWbh33TYPbDMltPJ65cu9Ur2FlrB7HB
 LXT6JKNJkcXGFyZUG+hchnInK7JoMNRU5Q8NzFtgjkBH+tlj7kmJMnK4Z4AvSN0s98TlviyxsxS
 iSqOGCuExx+nTQMf35o4h07lpeEmMkexIKjW/sHLOQmwW1XctZ6sYoyrp7A+5A1xhBg==
X-Gm-Gg: AR+sD12osTANwk6hnmeCD5UG9Gudxw7u5YZiVkdB1Gb7BXeDOiNjlecueB8k+sPkqby
 5XbdNSOW8YHJtqzOx5ubujI1CWiTs39HmVgpGXDAuZjLBnd+IUYVTzO0N1OjpwtwOb2pl0pKXnS
 DtqAWSX0EzwiFLmB39Ml/1OyR5IIPL73AnIyyaqgiAG2oNtnO6l3+k1YUpfuZTzvQPZ20LAL5Hd
 qmj5POCmp2u7OFyBqk7gfrZDk5OD4AW4zRdyk6YUBs4O1lYY04hjY2mSzllLFkvz7qI8IYiGJoh
 o0bK86ObilYLt6cD7UPZAKOFMC3KNjwiZiqCmQ3oh1Yh6Rhyxjnfxov6AftOBoX/ddrXeoKDpU1
 6SZPd+tFghTyMpoacMUdQwk3mYn2Ufcmb0wFfZ1q/mWRmTK44HnI=
X-Received: by 2002:a05:622a:1e17:b0:51c:14f5:8f9c with SMTP id
 d75a77b69052e-529d6ffd2a9mr11043091cf.27.1785231252959; 
 Tue, 28 Jul 2026 02:34:12 -0700 (PDT)
X-Received: by 2002:a05:622a:1e17:b0:51c:14f5:8f9c with SMTP id
 d75a77b69052e-529d6ffd2a9mr11042921cf.27.1785231252536; 
 Tue, 28 Jul 2026 02:34:12 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957bfc2ff2sm268123185e9.4.2026.07.28.02.34.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jul 2026 02:34:11 -0700 (PDT)
Message-ID: <7428df68-ffb9-429b-b0ab-8c009c0c42ad@oss.qualcomm.com>
Date: Tue, 28 Jul 2026 11:34:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/nvme: fix unintentional integer overflow in shift
Content-Language: en-US
To: Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org,
 Keith Busch <kbusch@kernel.org>, Jesper Devantier <foss@defmacro.it>,
 qemu-block@nongnu.org
Cc: Klaus Jensen <k.jensen@samsung.com>, qemu-stable@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20260728-fix-shift-v1-1-bdb98c205233@samsung.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260728-fix-shift-v1-1-bdb98c205233@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Vl5iGk7fHelOffKxV02dxc0jjU5I-9sV
X-Proofpoint-ORIG-GUID: Vl5iGk7fHelOffKxV02dxc0jjU5I-9sV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA4MiBTYWx0ZWRfX9KDKBWEjovXl
 kgclmUnZhGmodRtB3hxJfK6dfMGyJlgJ7kvDYPtjiet3K1BFthng6YwAfI7YOPEcv/OnPBztaWP
 SObkQLlQz58hnSPH9ZC9FbnizosewukvLLf3Foj0qI8pQtCkYiolrXNl6rw0nQ6cSbLjuH/vge8
 o56faFjYf0vLbF4Y/tVU4CaNEpr+ADa2ljmbstHfyI8VKnWbJBTDVnjKYSyQp0Z9YdXYccpSZRF
 eKqfTKqgWKu5Dr02EkQY0oXD+eALgppwkRdJXldrMavPzMf4Q025uYCSrOHV2LAYQuTkninPRJA
 cL+8Ncc/2Fvu0TNtvCwzCvzkqkouewDxb3n6eMCaxrvaQbh+RJ7ztrMCHdLi1PS+SJRNRyM/QXT
 oawe/umGfkiirxK7VfwfAuvpHCPtSl35Jugi7XWfHoTcFKtYbSTBLS9szLXQXa6L1C+hsEZnYqV
 +y3IPoU5sOl9EaGFiCQ==
X-Authority-Analysis: v=2.4 cv=PJo/P/qC c=1 sm=1 tr=0 ts=6a687796 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=hD80L64hAAAA:8 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=-7QTDa_z8tIhhbArkiEA:9
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22 a=Fg1AiH1G6rFz08G2ETeA:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA4MiBTYWx0ZWRfX73YcMjWnaPha
 Bk+oO8O47RWXi6LPVLQBH4AvXxjW9bNHSg/M3ILrQz7gU47pbjw17HmUO5d6qwtYJMqcMZlEl5C
 Tx6s2UV6W0Dp6rP27XIAMZKsnpTOLR8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_02,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 adultscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280082
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

On 28/7/26 11:26, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> Fix potentially overflowing shift operation.
> 
> Cc: qemu-stable@nongnu.org
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Resolves: Coverity CID 1663674
> Fixes: ec917cd49918 ("hw/nvme: fix FDP set FDP events")
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>   hw/nvme/ctrl.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index a67e1598891c..40f22fdc40bd 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -6622,7 +6622,7 @@ static uint16_t nvme_set_feature_fdp_events(NvmeCtrl *n, NvmeNamespace *ns,
>           if (!shift && event_type) {
>               continue;
>           }
> -        event_mask |= (1 << nvme_fdp_evf_shifts[events[i]]);
> +        event_mask |= (1ULL << nvme_fdp_evf_shifts[events[i]]);

Alternatively:

   event_mask = deposit64(event_mask, nvme_fdp_evf_shifts[events[i]], 1);

>       }
>   
>       if (enable) {
> 
> ---
> base-commit: 299e7557ed15a9a325620698add379a3ce2d1d95
> change-id: 20260728-fix-shift-525e53c1df6f
> 
> Best regards,


