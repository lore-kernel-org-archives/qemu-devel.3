Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DE37C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 12:04:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjFO3-0007Ct-6I; Mon, 13 Jul 2026 08:03:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjFO0-0007CM-Pl
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 08:03:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjFNz-0005dr-55
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 08:03:48 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66D9M3q31090518
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 12:03:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ve6Umm0umf9Da5rneGkVZBwsUhiwDalnxGrxC0H5nRc=; b=dVI5MwHUn9K1+HNf
 9Jx1sGQeqXMCCHNMC7LeTs8ukR1pIOGiFXzcms6Y/LJKlQVmc2BKsOZ22LqoBGqR
 bXgHCfFDWx63JJUkFE5wrFJFlHR0RX8beOI9tdV+/rVvicSh5qW5p9Wft34iGd5E
 7rensZoP5Jlo0ZNghzX1zzLMIge5O55gJv6tR/RCU9ryXDgUqysAm8h48ubRdCti
 n4FL/fgbSd1XS/VZgJPp6YH02AUELaLs8xZBuLwnjD8O9cMUZSWwlpwJIrAPw3IF
 AsHn4Aq1/uGVnc0isrTLcM2XlLEn/g87Tvk/h4OvfvEyTmRDo2i+gEDrpH2vT1tP
 63khTw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcwavrjh6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 12:03:43 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51bec738909so26047531cf.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 05:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783944223; x=1784549023; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ve6Umm0umf9Da5rneGkVZBwsUhiwDalnxGrxC0H5nRc=;
 b=DZxZVOMriwnGOysBQIau9cyOVLpf47zTEwkqJiVwJnfDP47fJhYEVVMJibMOmw8MvR
 yh/bJ5IaFVhma9u/7pUDzObXN4udmvb7knuSgMCJMnd2MEhRm0E/XV91iTIYgKteCThn
 d3FmBMZvrIm+ezHrJWtHzqw4zZLhhwq08k+mbljl83mWtrceRINIXSaAToYSk52PpjEJ
 CTw/mYnJ7wJqNDJbfCt9+RIAmpatFQyqB+qOZ/9Xz9dfPl0pryrKrD+1W0E6tLxIcCit
 jg4pxy5mmist3oiDxjn8BoUPhqOKtrMwe8iIhKEpIWzc9BN93kYgoz8EvJ4cobz6CRBx
 mUSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783944223; x=1784549023;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ve6Umm0umf9Da5rneGkVZBwsUhiwDalnxGrxC0H5nRc=;
 b=pVlMePXjxJfX9uTKORCbv1NJziHMpAXeVvI16/CHHcY66gAKgEKuJvmrgTUgGV4+GO
 UUh6zG2j5D7qihTJFrnbNB/Tx1dnqQE4usjcoLYB64C8Pcd3B16Ytd99VtkG/tlwUMtJ
 DtgRf1k/LmmZS9BCi0XxjrZoy385V9BK+hu4R/2S7IwXbUEF+vrjMlLmRITzemeUP0PG
 odcZ7oWr3o9FQreouaRR/tCOKhFfdPa0rtwaQ170xtg6deb2wo83/YdwJao5fI2WnbC6
 eTTIAoisYECrVbVOzzi7NUVNuJvXkBlp21uBvmewyHIsTV65yv9TQNWZZ7rPb+e0cuY3
 57+w==
X-Forwarded-Encrypted: i=1;
 AHgh+RpURF8BpV599QRDIQY/To+QLRJuI2/vNYUjqnWbmhgKD0czb4LZA7hpSrEFHzDK8eWQh2Pm1ESPNAM1@nongnu.org
X-Gm-Message-State: AOJu0Yzz9DYlO70cv3BcX2hFL2cKHXez7WEw1/L+fDnojB2GTuLaHp2Y
 ptQRbcnMoeYsHVKJrPOootjazp8b0AQWqTpLH5o/o4Vduy+Y+F1SR2uslaU666zI6JyU88dvvqg
 TvsbboTX0UPoZbIJyR8WXPPM8EPeQOv2z/M4UJlp1McM5pcKqP2Mhiwz+zQ==
X-Gm-Gg: AfdE7ckGnkAJzpWzzd9wb/YGM4OOwYE0i50dvi4tlrpmfKIvRFi5aCbv9b2ty+mLg/9
 0XDu32JpQjcJbQnXOJiqEv16ZSifrVL7vxB/HYTHAO0OucYRN3y3TBqLDRQLckIs51t+U7G8pHe
 dxYH2yZgKtRjrSPipttoFEO7NwwYf1FAcBOl9FDXVz8tzsJ3RtVX4JniUML+pJEFXu0Z37ARwD7
 ZprZJ3rXEV6ENV7V3PiY2UoLNYgN1rfn8Y5N4B29jt1RTP6N86ZwrsutCek7YBp4B32p9crr0t2
 6iPOZr89JVN6gQWT6n/virB86QIll6dKtU0BN2lWskRd1U7BTasYKk+grh2doeMcL2NjAAvL9S6
 tCfHy3DeGU8mK7FxYvbF92n0dOu/WYqdwyVWn3x5QRmeWwjmXQoX9IsW288cqtw==
X-Received: by 2002:ac8:5850:0:b0:517:9003:e1a with SMTP id
 d75a77b69052e-51cbf0b8354mr86392321cf.21.1783944222841; 
 Mon, 13 Jul 2026 05:03:42 -0700 (PDT)
X-Received: by 2002:ac8:5850:0:b0:517:9003:e1a with SMTP id
 d75a77b69052e-51cbf0b8354mr86391551cf.21.1783944222006; 
 Mon, 13 Jul 2026 05:03:42 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb6df6d9sm424662525e9.7.2026.07.13.05.03.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2026 05:03:41 -0700 (PDT)
Message-ID: <68b3691c-8b8a-497c-8d60-969d25fa7d26@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 14:03:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/sparc64/niagara: use int64_t for vdisk size to avoid
 truncation
Content-Language: en-US
To: Dmitry Pimenov <sun4qemu@gmail.com>, qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20260710222350.9185-1-sun4qemu@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260710222350.9185-1-sun4qemu@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 16T1LPdsAxkCEEA859fLSxlaIO6HcmpD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDEyNiBTYWx0ZWRfX7DMlHdakFLiW
 OoakQnL3L2TxpH/IEWWw/R5MTdefYIcKepFQoY2cwqcamV53m8aIM06fgT0ySDhNs1pxewWAJVi
 q45JqucPuCTNU0d+jnCPSF0JPx0IiHvG/9EMrxBZlgeTumNCMTfOBOm6jhT2iwERH3x+9gzYsE8
 eWvw3Y+XrVbmmQMWltY3VTMz0+lTxPoDK7HGWp8onEU7gSkoXblytoRBrK4sStdp90RFPqR8tqV
 GyzRVSRg9sME90dMmqbDjxRB846rZzrheUXZvpvgGvCMxh15iuh7Kcv1e5TA/bEcYI+bcir+Yn4
 QyNk5qnjuGhRnbqJ6Z3b+XTWWhyqWwaB+N0/L9KDqSzOv6AxP9vR72vLxYYK6t2da24jWf+/2KC
 7wShm5Idv9qzqf2s6Q1W50lFwDmiZHG8KuhBIsP3xsVYptSXO+9ZOrT9q4PU2qSZtHC5JwrGdE0
 Tm5ltQOZBOMQXQUtkYw==
X-Proofpoint-ORIG-GUID: 16T1LPdsAxkCEEA859fLSxlaIO6HcmpD
X-Authority-Analysis: v=2.4 cv=dZSwG3Xe c=1 sm=1 tr=0 ts=6a54d41f cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDEyNiBTYWx0ZWRfX9TIw/q+lXHg3
 OR7uBJDMguf9BOYzGNDIxawC3CeEkkVoQGa55R2CTPM8Xk3yB5T1hotbhidyugFhLNdeemAzxN+
 XhjPTLe4+Ee64V0NOrUos9awKIRXuh8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 adultscore=0 malwarescore=0 spamscore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130126
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

On 11/7/26 00:23, Dmitry Pimenov wrote:
> blk_getlength() returns int64_t, but niagara_init() stored it in an int,
> truncating the if=pflash virtual-ramdisk size for images >= 2 GiB. A ~4 GiB
> image truncated to 0/negative, failed the `size > 0` check, and exit(1)'d
> before the CPU ran, ending with:
> 
>    qemu-system-sparc64: could not load ram disk
> 
> AI-used-for: code (bug fix)
> Signed-off-by: Dmitry Pimenov <sun4qemu@gmail.com>
> ---
>   hw/sparc64/niagara.c | 2 +-

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

