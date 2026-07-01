Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96718C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 06:35:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weoWa-00041T-VY; Wed, 01 Jul 2026 02:34:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1weoWU-0003zQ-Js
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 02:34:14 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1weoWR-0002FX-A7
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 02:34:13 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6615lQ5W065853
 for <qemu-devel@nongnu.org>; Wed, 1 Jul 2026 06:34:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 d0pnVWhEsVq7YT/Qga9RXWsjPnzzjQIBkMTUUnigOOw=; b=Vp7ebSsisCuihsCT
 F97oMhSplnxQndpDjUg5kbyCbCWDDsaAKLG5lY4OoWw+DQ0xFcGpB4FgAdShA/I1
 IfeMjYoF2cEcOuEaCvnvCvL9tTRMrf6XKvEfDd7exzQbaC+BAtwzuL8fPPb8ZEKl
 Paljf9B1YS5AkvrsS95AG4W5Lz7oYrGqfSou4sxBND0VNFShm3aIQ8TKQOA20FOX
 yJQUGd6BJ1g2JMdWads6oVPoSRijVKxjjALF/o9+Cbtbl4vEWqnqGGKRt8caScLF
 TQPYvg9Vwc22wvoxdiRydg4W0yRO5IRV7/gn7o7uKorMv/m5xg8PrXiHgjUhAHKT
 bLBxRQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4jtqjm8q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 06:34:09 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92ad11e2197so72009285a.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 23:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782887649; x=1783492449; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=d0pnVWhEsVq7YT/Qga9RXWsjPnzzjQIBkMTUUnigOOw=;
 b=HhmZRD8Y/+0M6CZvldoRSwytPFbfmsjCH+BLZNAFpjsgoPpPwTx9YiWp9IqPC5G9KJ
 0A9QaUWPxAgBfo9m8DPb10mvxZUGW5iYKpYphC8g0m7WQnnAvB++U9yve3f6XCfE27Nl
 zVkmSppHIrHBU6ejwtfKDbipaxecTSvR9leD3sUowaZ3wZkmTKxZjBvAo0nBDBxBFLYN
 vEpgDIghPuMTaxroKRJE+D8fMMNoQc7t80Hj2bl174aF39VpQq58nRsenHH867i20gkW
 kbyMHVKJraFc7zVgNCif1h3By7OX1NycsfbNItjn1Ij2fsOpjm01so98XkjUuwn0bCgb
 vPvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782887649; x=1783492449;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=d0pnVWhEsVq7YT/Qga9RXWsjPnzzjQIBkMTUUnigOOw=;
 b=Fv553qYi/l1kfyS89qdK10/1ByeEEOCAcJsLFxPtmAkA3YnQIVyROIDxbgQwivyi8v
 d7d4f+oDbHG8hYvTiQIQO9L90zSXtoSUbWHNEMdY0KceHq5EprSbbrxIMS8mDZbWNkYN
 Bb5ZdpPXBneAwWn4rQDhNqjpdYqv51lWAIvzwdkvYICm+yogTj4HNXV64ZONdZJCL/zr
 flKGVCz2vBS6Zz1AXwrXSe2KyYQYoBAer+0JO89FviJWGcCkkJAcGglWXnBolc13mEhn
 I249i/pBdvMTaNd5fzx4DG+R5R8v8C+TLCtl3irJx7Py760D6AhuyU+eFe/V+7PVFoFa
 VBEg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/iyTjC+HQNmFaXvBG5LDV0qF//1rjQD9AXqYPmH8LotdxTJRunhGXtoP3wF7k9Rbg3/ZsIZBHR0nbB@nongnu.org
X-Gm-Message-State: AOJu0Yz3zjaIrG5XkJtxC8uLE/2mc/LYlG5vnrBT87iWJv4RaBO/0gXq
 B4wX21uDd84dl6m12KCstBRc2ZybAkEotvtMN+ManSfKdgzTICQzwTyqzMqirG9ZQWp0hJjMkp6
 DguyC70UyHDHIF2RSaWKXxGqBQI6zH57bmYr//FzPTAHaC72VYbhCS7Iqng==
X-Gm-Gg: AfdE7cm44BiZwoIRDaVka8jeJPzXmBG/UyigGaBZppoXYjRuk+QbQZjc4+MVoHVkCBn
 +qs/VoUgNOhBll2e9TKr15rov5RhRX6cTtdXEhBco3IQZnnGtqU9GwBAMVZhNNZO9jVxKpt0+xR
 p+Lba7l3SifkMqxUSEBmA2tkyqiix2xXNOXpIR4RnFwBzURVdRvJsdloAjmkTbLtpehujQ966A0
 zQGSTPBY4Ks1Be0+vvGrjtnzZkHtnj+fNrjjyp5KjtIPKGtVEFqTkggPhP09kaLYUbyZLta6vvc
 KEWhG7Gn1MT9KHWpQAslTJobaZQQmi7tIHlSP9yZjAbGuU3bdjGQtLQed4ytH/oj0Or1jMFXTE8
 Akl2UyXHnjJfUuMwo3QsQEiXB8xetx/vM2NKdet34nds9qNH17poh6xrYRimLvg==
X-Received: by 2002:a05:620a:410c:b0:92b:6805:917f with SMTP id
 af79cd13be357-92e785438d6mr48673685a.71.1782887648846; 
 Tue, 30 Jun 2026 23:34:08 -0700 (PDT)
X-Received: by 2002:a05:620a:410c:b0:92b:6805:917f with SMTP id
 af79cd13be357-92e785438d6mr48671985a.71.1782887648408; 
 Tue, 30 Jun 2026 23:34:08 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493bfc32992sm39108355e9.11.2026.06.30.23.34.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2026 23:34:07 -0700 (PDT)
Message-ID: <16e61e6c-79d7-4764-b418-2a0f1bd482ce@oss.qualcomm.com>
Date: Wed, 1 Jul 2026 08:34:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/17] accel/tcg: Constify CPUWatchpoint for
 debug_check_watchpoint
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: shivangu@linux.ibm.com, qemu-arm@nongnu.org, qemu-riscv@nongnu.org
References: <20260701030443.1382447-1-richard.henderson@linaro.org>
 <20260701030443.1382447-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260701030443.1382447-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Dq44mFTzwErtRUoWWLPRGz4vOAJ0BnB0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDA2NiBTYWx0ZWRfX/ZeU37sXXnPh
 8wc13d0R5fuqUUPcgtmic05S3AIsySq6qC5G9tmBvT+L+e8c+Yb3IT9GPO3JSrO44yNnKtxcil3
 wFbOZdhDhuYuSmAZQOvD7G4wn/ATlCnU1/S3hO/6TY3gQFZWniefCmiET+zJ/L4vZfB4gqttu1C
 DxXnAfu866gQNw+vsAb/JMuZSjGrXvyKG4ZIjxZsyEhcwIhIYy1WtFUn9IdPxvKfVvfYW7V4nOn
 j7B7IN6tVv29cm2ozr7EFOIfSX3Th1alYGzWTZjzQhxd0a5klgzGud4Ie0IMpl8YEDFn18tMK3z
 1Nq/lv9VU0aLHZEh1GleEVkaMUNnBi1rA2Od0hxU4E5oryR/n+K6QYl424ePFHrKHdeJabjtXM1
 EwFCQka1Io2AOP0j102kKIGCMNkPalIm/vi5p7+3tgm8YY3UBILXLu3VSO6qX4rEcLIFcoLBYn2
 MDj7zgz8LcMj9ht+6Og==
X-Proofpoint-GUID: Dq44mFTzwErtRUoWWLPRGz4vOAJ0BnB0
X-Authority-Analysis: v=2.4 cv=LIZWhpW9 c=1 sm=1 tr=0 ts=6a44b4e1 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDA2NiBTYWx0ZWRfX7JG/dZIwhDS/
 AdT3u/pm8zlK3qLC8uh2QdNSbmOVOXvwgs2tQOqc9tnRHInv3rQpLvjEw06054j/hiENdz0dqAu
 6/98StZQQLU7SfhWWGGp2YwyrfzEhr8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607010066
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

On 1/7/26 05:04, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/accel/tcg/cpu-ops.h  | 2 +-
>   target/arm/internals.h       | 2 +-
>   target/ppc/internal.h        | 2 +-
>   target/riscv/debug.h         | 2 +-
>   target/arm/tcg/debug.c       | 2 +-
>   target/ppc/tcg-excp_helper.c | 2 +-
>   target/riscv/debug.c         | 2 +-
>   7 files changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

