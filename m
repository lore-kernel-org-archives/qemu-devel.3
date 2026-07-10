Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27378C44501
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 14:36:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiCLF-0008JF-5X; Fri, 10 Jul 2026 10:36:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wiCLC-0008Ix-1q
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 10:36:35 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wiCL9-00047h-NF
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 10:36:33 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AD5vuW919856
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:36:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 twji/UENts/c1PezN6IXQljJwgtiSH7XcHIYH2EMIcw=; b=ovl4/yifKc8MMi5T
 9WvHaxDDKbslltygswB8feJXvI3ZS+cESRLM0Af6++vCUE9BjaAtCsvUr8u86lsv
 SVDc+2uW4mfbZWweRrD3mow3/Yr0/BKK3nA1DxiAfcV9ok8Z3yVLNe4JdgQUH9Eu
 dI6F1iu8RbMS/IT5kAmS4OJtfakNM1rxLUriJwQxpDcRau8ZEzK2yq783yV2llEq
 9nDA0vhM/yC10msWxDRsdMxHQiUp+WbiciDZx1cY/mjp5lmsjPvoT5iSaZ1VYTqj
 arZsFk+ljQyNfPaLkLSzjTQaBi+9YEyKh/HtesB2pvoaOjVAc/QZUQiLqsicDQMz
 cEHg0A==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fajte3jba-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:36:29 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51a8db414c7so14110861cf.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 07:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783694188; x=1784298988; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=twji/UENts/c1PezN6IXQljJwgtiSH7XcHIYH2EMIcw=;
 b=XsSZ+D8jLt9H4aoCCf/kcZ6hrYFYOlleFvKCRNw20NENIEoh7/P8F7MOh/tGjVjjV1
 e5+EvRCa6t9gg6er6UIAkyG1MWRTn76t2SBsS2paShqtbaR2lmqxL6WjVGAHxCkxRycD
 rSa449Wra1TFHsmNhj0CJWtk0FdaqfIcLdK1OTrByL0z65ornV2Hk6pT4bjGlwfoyMnZ
 CXAsKwqsRBIdvNjuobY3dn/5QZ+fLjWiO8xLJ/F5dQKDoV+Rzb6oo4Nxj/hMw+WMBDQb
 Zzu2UX6VZW3RvtjJvRFb6FuzTrKzTXwGX8cblKK91G1pH6voNb5lhZKtvJrZI+uQjl+j
 TwdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783694188; x=1784298988;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=twji/UENts/c1PezN6IXQljJwgtiSH7XcHIYH2EMIcw=;
 b=FuwpFhMVwAMKeUmZRwPYLmjUTDuQlFQS7FryQ2ItX080H7honj6ScvzxmUwktahQaC
 lwIxuXPkwFiwCouw18+AYWNDOxeShErkqtylXBE2qKeUMKPmXFROgM3CLKa3LtUB0r/U
 z/op5IRQu19Xg/z/2TKKzf+yr5M2JP2O6Z8E3xV243j6xkUuPbWF+z5F4j6HcMvEZ/Eo
 AMcdvZQhDlwMwKhXliWCZNvgcPEXV+CueeJYEF3EC4r2hljWatAGHAkTg3ouHpJvAzyF
 TxnPRTDHFUik547zobXwuh/L0XGx4PLIorNuWpaSX7QfyhbFcWrdTpLZRys/Oqmi2ErK
 vjEQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrVQT77r+V8icoSmdCeleGxYcfbNs1DeJiMfeFGQ6NFWqS99Ld+yiht9BIZcqUdpSTA6Ypgg4WIODtp@nongnu.org
X-Gm-Message-State: AOJu0YwVyL2sAveacUwMnO7vTBS7QZcp9oSAUnc2H2HAmFra1BAJP1KV
 8NGyt0EjnmsfQ85cd0Bqwu+4yGf6o7tV+wuY343He+gvtjU1Gvuj/RkK1x3yc7fvMcBB3zvWcV8
 jpfiD5yJtTlzI8oRk/h/FmkBKqyJcINRExrt7CYQBIDeTWLUFq78Dadi+kQ==
X-Gm-Gg: AfdE7cn65LoONBd0LAab8ZN586oO/o8hRyd4TyLvrsVTVjIZi2lOocOaMgsHn/KURhy
 BVO/1o2YvL6rmcpsBmc7diUxagHrng/D95DQA1hbEp1y4bYrCw9IL0dLeJyyZ2DoBp9fzFS62ql
 xZdToYUh0W0+tdrCv+aRFkMH3dMpU9Hd8KcadeG80ZJaVnuz9YuM3HbTev/RtzYYNw9ibZUVHyZ
 5syey73Q9v+Vqkty4q26jedMO0jkL3dM81SaabrDNLgPUGHlTvyO+cLZAAtCwvENxbybnVtx5aC
 WRVu2FDheZtwv7FLEyv2fvFInfJ6f+7MkIXdiAu1gBiMH48g4ZQkOVgz4gqe1PB4cmqkhSpaqPg
 gRRkwPuqePIJ8OsiyM1VoRK/VU38E9s7GYTInW9sA1X3bAfPeDUnrLfUEIbUnXQ==
X-Received: by 2002:ac8:6f0c:0:b0:51c:1027:34d4 with SMTP id
 d75a77b69052e-51c8b39fe48mr146801381cf.11.1783694188361; 
 Fri, 10 Jul 2026 07:36:28 -0700 (PDT)
X-Received: by 2002:ac8:6f0c:0:b0:51c:1027:34d4 with SMTP id
 d75a77b69052e-51c8b39fe48mr146801111cf.11.1783694187952; 
 Fri, 10 Jul 2026 07:36:27 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0f214d2sm59416091f8f.33.2026.07.10.07.36.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2026 07:36:27 -0700 (PDT)
Message-ID: <98470e76-bd6a-4a01-af1d-6f03ac9fcdbe@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 16:36:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/usb/hcd-xhci: Turn guest-triggerable abort() into
 qemu_log_mask()
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
References: <20260710142727.592667-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260710142727.592667-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: uE-n8_r2uXKYLnnUo1FNINyjvRrvCVXa
X-Proofpoint-ORIG-GUID: uE-n8_r2uXKYLnnUo1FNINyjvRrvCVXa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDE0NSBTYWx0ZWRfX0Q2AcL9UtYtP
 1Xa2ZHyf6e9rK2XOg13O8gHmEXFIf6MPlbRSbCY+ALmoAuZYs079wpNEoUJdcn5DDM4dYAPAGOq
 f6FsypQppLRatPsvIkaC4kU4pcCD/aaSruHa2qfvOynspi1YgOMF9dPDrGCCTXj2uM+6779zLNm
 wm/btOncqofFcyzbmw0rSPPuWD/fM93GC0z8bvk5JPM15jEtjg5dW/HWR/uPAI8aesrY28edC9m
 8064JIiGJSsizdKvyMt8ljk+j/jO3j2v9nZ1Fd83cVcJHlb6tAt154jSl1Yxi0lQLwcxdjfiEZj
 9+8Mdr6RNK4jQn2mRkTH41nZx/+rjecrDIImowLAFj/kaGkIr5+VXoOjyH00EdEUIe4dNb/dn5z
 hkKjtttR0ACKZDzla/USdY7xpGWU4oWmw6X1F07hHGqjNOjDQLv2Oz8HOeognboeBVzBIX+EklY
 hzJ9gt+50kEQ1UY/c9g==
X-Authority-Analysis: v=2.4 cv=N7MZ0W9B c=1 sm=1 tr=0 ts=6a51036d cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=p0WdMEafAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=KcFzjVdSTcdEk0ENZCsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDE0NSBTYWx0ZWRfXyHGGfn1G7uvw
 oWS+YTRwPhsIve2K1A5cw2K4IWu4lYWoMrzT5/HdVsvhSHkADovohDHoKQq48s1jh6mElHPYOiw
 NDUAjIHAMwYaAeUbBz8e9Nt0KKWUV2c=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 suspectscore=0 adultscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100145
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

On 10/7/26 16:27, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> The FIXME macros in xhci_alloc_device_streams() can be triggered
> by a (malicious) guest. Since the macro also contains an abort()
> statement, this terminates QEMU. Turn the FIXME statements into
> a qemu_log_mask() instead to avoid that a guest can shoot itself
> this way.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3784
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/usb/hcd-xhci.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
> index 2cdab3ba0e4..9ff50d0b7f9 100644
> --- a/hw/usb/hcd-xhci.c
> +++ b/hw/usb/hcd-xhci.c
> @@ -965,11 +965,13 @@ static TRBCCode xhci_alloc_device_streams(XHCIState *xhci, unsigned int slotid,
>            * together and make an usb_device_alloc_streams call per group.
>            */
>           if (epctxs[i]->nr_pstreams != req_nr_streams) {
> -            FIXME("guest streams config not identical for all eps");
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "guest streams config not identical for all eps");

With trailing \n:

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

>               return CC_RESOURCE_ERROR;
>           }
>           if (eps[i]->max_streams != dev_max_streams) {
> -            FIXME("device streams config not identical for all eps");
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "device streams config not identical for all eps");
>               return CC_RESOURCE_ERROR;
>           }
>       }


