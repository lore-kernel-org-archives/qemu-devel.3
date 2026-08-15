Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E93C5C5DF6A
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2026 14:20:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvFEv-00088y-6O; Sat, 15 Aug 2026 10:20:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvFEu-00088g-FL
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 10:20:00 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvFEr-00005j-B3
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 10:19:58 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67FDMMDf219305
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 14:19:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wwHAmoGVzST5R214zpOZH3mE6WRqBlVDr7IQoG8x1AI=; b=YeA7waqp6p+V20M1
 fuok2QoNEgy/XWQ1x0mb3QV5LhFsuBhU07WzCHat608aPRwifyPQdRSaZ3Bkvug0
 Ca40y1Tt6o4xz6hbXA0+a1R5Xm4k/f9uYJapm3qwvVVjnfrLgjZPsGf/tqxJp2sd
 wOeCPEgxWIqlo82K+k0PmC0TjBkv+C5iQ1JB5FWpXDh3jrgghWp2WgPi6Yk54mBQ
 dMwgMdGVVnSz4kMI3hYcp8lPd6b8+BtJHdAbJo8nvrUfEQIX8z91i8tF8t6PrHGD
 /8S0D+9IdniMxtyXC+hHwwQ5pFFNjeqWbdqLxTh70QAw7BHId6xl2eaQRu9vpKuU
 QNWAvQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2hd7s0bm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 14:19:55 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51a8db414c7so28340271cf.0
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 07:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786803594; x=1787408394; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wwHAmoGVzST5R214zpOZH3mE6WRqBlVDr7IQoG8x1AI=;
 b=Jtyv73IH6adbIzCcoU+Zw1AZu7vTXjif0FR5Z5wn2StRXK5ZUSdTNBLfUsls09P7Kr
 VBDWdYNChi0UbNItaO2m5mfWQd4RUMlKa0mYYfOde9WIT7DhwKAkDqwk4F/KLcciNCYX
 CWralObSJxO5wKLOaDi6Y1q/h5ZfqB1xK8RBYcqsDvi+KB9c/GaiXwprDB7hy+jygVG4
 HIqYDUkczY1SqY2J3OGytIebQuqQBoo2R6H/l2Y1QgpQxz6pRy9j+J6RY+3kFsfH24+W
 jsezny6T1DI6KfQgC0HFHXtDhBcZwovJGPlg7D5pqGUgfi+fmbstVt2khznRLwI42msu
 I10Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786803594; x=1787408394;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wwHAmoGVzST5R214zpOZH3mE6WRqBlVDr7IQoG8x1AI=;
 b=lDYPgUrozcwM1J+ja7uNRfyNnSDaUvaGsSVMBzVpUOkNKlssYBz3muwcMvaLpIv6VU
 M9hsq8KdP4HXdv4GOT3A1FDVTxJA90Q3RXHxR8HHTi5ItDWf1N2zDl7YTGpwnhXxDeuy
 Aky7iKoAsHl1/ndCkiyKZW0GeTPOEJICsF773zZpX4ieSWC+Jlp6yvyM8RoQ0l8MRgvu
 O0mfpxgG+XDygPNKvLFFkq3xrN9bek1Tla7TZprFio91RIJ6nLZspkGIowpwGDUgxdAv
 wt++5qyeNR60F+E8cWpK/AjS5tkJ8CtTl2ml7rdGuN4aAaE7ZOXOmlAtGDFMa0zNMaB1
 f9KA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpBBLLkMhBnZ1er8Hgz/PGMpMJTMKlEWj2ujnOF6J0qBXp2hZoDJfh4pAduvEbj3FbuaQ4oA5z5UQOV@nongnu.org
X-Gm-Message-State: AOJu0YxJN/9UqPk4VTKurBvHaIje4DraOoNCFwOloDm3FuZxg342veN0
 HvHX+r9JC1vMbb/2mkIFsqsEdpR1BLP348W8Bb/bnjFzz3W6mpqw8pzi1xEcQQocWSk8pRqlA1z
 Hfp+lLIA53KafziukuJyJ33KUpdrT2eyDLV2cUkk0Y41NIjkzFA1I8QerBA==
X-Gm-Gg: AR+sD10Abq6ZHtXh9FNLeBE3FF+P8h4YW2HX4beKvwpWkUg3jkTxc9Tm0QfgC/erDZv
 A3FrjcXorjfDAPX13d7aXN0XR4e1tPQJUGUrqI9x0yP835bd7H4X+p61lkQ2/lh2fwrO1FtrfkA
 DJz2xfkTPTlkBeDW+sgEFTjJmXNE2s5gBlPW9ZGjvGH1FD3McufS/PVZ1AGeN/Zn0h8i2mmR/rR
 4drwPiYxXpQBrfKRhYX7L4eFTyVEdULjFNUDYMl/RMJ4bUYvKfQyw2twzjg8jUpGPJMbvtK2Pem
 M4+WsCLp6ZFTjXxkT89MZvSVoJsgRf+0g00LoVIKKSzpaT3GuxFFkSE5NneDO2s4Q2bBfj2DHMo
 jmNl0UsR1FxKBY6MV2OTli1RfyvxzwBK1+U4=
X-Received: by 2002:a05:622a:1653:b0:517:a7ff:935f with SMTP id
 d75a77b69052e-52d85375906mr130227171cf.9.1786803594434; 
 Sat, 15 Aug 2026 07:19:54 -0700 (PDT)
X-Received: by 2002:a05:622a:1653:b0:517:a7ff:935f with SMTP id
 d75a77b69052e-52d85375906mr130226571cf.9.1786803593958; 
 Sat, 15 Aug 2026 07:19:53 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f21df13sm13992506f8f.15.2026.08.15.07.19.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 15 Aug 2026 07:19:53 -0700 (PDT)
Message-ID: <d2e7c7c6-cf3e-4eab-a8a1-a28559c194a1@oss.qualcomm.com>
Date: Sat, 15 Aug 2026 16:19:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/26] hw/sd: sdhci: Support version 4 ADMA 64-bit
 addressing
Content-Language: en-US
To: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>, qemu-block@nongnu.org
References: <20260723151853.2143177-1-bin.meng@processmission.com>
 <20260723151853.2143177-11-bin.meng@processmission.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260723151853.2143177-11-bin.meng@processmission.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE1MDEwMyBTYWx0ZWRfXw2usaHT6b7CG
 jjdAL7gZRE/UGdNLhE7nbiu8P3rxKvP8YciPNCzpL6HQ1qQbti/Tr+exJRM8zLpnZYDHNlQmKdx
 cOwyllWI1KkCCb7CL/w+EVpj+m+0hKm3WXTLdDD9c5SYQowVaD24bOkVaGlwwTUna7CZ3+kmDxS
 E39u7PzyN/TsmeSKP1gXdj28bdpTwf+q451jhmtLAi+3GH35c+4snClCFiAYfF+hKvU16uwqzim
 /93+lXSv1IfbuGI3Opqgt3+v4U9Yl1L1TD6vTE4s/AN11yejr8gUbkzNgKzPfaFzpmi6uvhkwcp
 eK0VAXMV3Vg79l4nJK1MDVKvDD7u7e3UWdI4113eaY5mnnYWnilaalP0d1vorgszj/vgARzc9bo
 gba2JcRajzD+05Lt9ObyBkpzmZ9/R99EbzRdhg84u9TMW4iNAsRxEU5PtJE/uzxefovf9by8evK
 AzRAuWCv7HHvJ3SQuhQ==
X-Proofpoint-GUID: zp0FZayAzG0UFj7JdnhELJfPAHsctjLJ
X-Authority-Analysis: v=2.4 cv=Ja2Ma0KV c=1 sm=1 tr=0 ts=6a80758b cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=FRSEYCzRAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-ORIG-GUID: zp0FZayAzG0UFj7JdnhELJfPAHsctjLJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE1MDEwMyBTYWx0ZWRfX4e8nSHJtR44g
 IJOXVqFSX+OFp7rrLly7k36a1jEB2v23u4bEPX3/e+W/CkIrqzY2/WStbdgMe6LP/wSoM8AJhPd
 tKqwUvZ/zsEFjRPKG3bzWKoPO/IosRc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-15_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 adultscore=0
 bulkscore=0 impostorscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608150103
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

On 23/7/26 17:18, Bin Meng wrote:
> The Cadence Linux driver enables version 4 mode and 64-bit addressing in
> Host Control 2 but retains the ADMA2 encoding in Host Control 1. QEMU
> treats the transfer as 32-bit ADMA and uses 12-byte descriptors because
> it only decodes Host Control 1.
> 
> Resolve the DMA type from both control registers and use 16-byte version
> 4 descriptors. Preserve the legacy 12-byte ADMA2 64-bit format when
> version 4 mode is disabled.
> 
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
> ---
> 
>   hw/sd/sdhci.c | 25 ++++++++++++++++++++++---
>   1 file changed, 22 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

