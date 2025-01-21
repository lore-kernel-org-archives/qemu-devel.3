Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1547CC0218B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 17:41:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taIEV-0005Pl-EV; Tue, 21 Jan 2025 12:40:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1taIEB-0005Ix-Qu
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 12:39:53 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1taIE9-0002zE-Tp
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 12:39:51 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50LA40eZ017865
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 17:39:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 urqt7a22dhLPtw1A6TPrAusY6/mCkSDM1vs/YAPMn5w=; b=PoQbsQ6jOqqsoXpJ
 EHszinBtOI5uluh9wNOzNzKRCujZUe5TC/1o1gl4dlrb4IBArMTWsrBtqEFdWKOy
 MdcXhcgVaC2KqUAKuYh7vt2dnd3rOl7A2inrsvsILQL4REfdj5crJllzrlJ/j5Jy
 9sEN7Qrz2i07nU0h2eOvM1IGHdA0ULQiWzw22tdzUArej5zzfyPNMsJFF/jF5vYQ
 Zn7q2vfdOdyHh4UqTniGAczRtmAEChO1P7Jc9gy0UUQhDpMLSC4k+xDvka76zLXa
 YTsigGqmGYkDra+TZsFgk2jkbU2/tgKLV/K3Fh6AQyZZodE1DwK/sanmfa19it1b
 qKAqCw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44a9gcs97a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 17:39:47 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6e19e09cc20so106219816d6.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 09:39:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737481186; x=1738085986;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=urqt7a22dhLPtw1A6TPrAusY6/mCkSDM1vs/YAPMn5w=;
 b=ewx2JXw5FLHC2+IExTrpwzPYDdumissCJ0wAVD7w0Q9Nwqxq/0bqQe9h7sb7nFuOm8
 vabxjQLUSZaIS+qVnRAWlDdW1N7/moy+Q9emZflvvH/eO+tbury+rKoygmGL3piBDapq
 yHDyPmKKRFDTAxJWeu6lzwXYUjBxytJSqIU2H3/oeLN7oE2Ea2xIZaU9Vpk9KL+I2Ipk
 KCPU8zfSjJzlZsafpQu5U3L5kSIzjLxB7uxPQDbdylKT3rvyHLBqbGwkVIwS0GzvqZ33
 tgVNfwyDA+2F1tb6s2S8AKHkR5y3JDEuubAlSvPS4J7V4pa9V1KxmhJrlc2rLhqwpkq9
 f5Sw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrsaRUF2ToyS+8PTOyEbsYPilxx+AfiBxjLivsAS0WqYnznSBTR2gZeokHf7VQt0RQ9usyljWnDRuj@nongnu.org
X-Gm-Message-State: AOJu0YxMpvmIU9P8cRF2d74SF8UzWothkphe4fDeaeW6JkKtUapybbbn
 RPcV2OCuI2bRBGzmO9JxQawrS4rCsxLrxfi7w9yaN8R7gGbFrQDMWZJjzaQpseTrNRg4cgibdFG
 mbsg8qP5OkBavWtZolL+dBNVZY63G53wnCeKD6LmaGxLGgy8CFYFQXw==
X-Gm-Gg: ASbGncusP56zOBZgIyi8CZ9yKtAQ4or5pMSkzKTapf4T68GVal4W1AOJpRo3Szg04dp
 6NmVHtUa6DfqHvWfb0YWafPcMMbJngRBEVrRHhg+ZLJR2Zo7XGo3qxI9Bd+spqdphKF6ASP9ufV
 KGNWAv9cwy62ZvMCrr2V/FpG1thXZgrp8bTicOfGrFh3/bWxplp3e/VLCS96WwEW9r2r29330JF
 d1kgVxRHrdaZVp3LbyfriCZDJc0Fzt9LZo3EuftCnwuqtKNG54cPgJlLtgHQTGpaaYQHz7xamWc
 erGZlzSjEjzzQDKp5p8yLsQk4nUgIKkROqj2sm2EPoVqQ/oFCZEwyVgciMe64N7EJUTJzIQ=
X-Received: by 2002:ad4:596c:0:b0:6d8:aa52:74a3 with SMTP id
 6a1803df08f44-6e1b2213f57mr284730396d6.28.1737481186252; 
 Tue, 21 Jan 2025 09:39:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+5QDXGtbd1P6vJg1qxSMUJ5SCfZlVLCyU4FnnJfYtdUe/GN/qfPZGUsVZ+mVbZrhHWhrWHA==
X-Received: by 2002:ad4:596c:0:b0:6d8:aa52:74a3 with SMTP id
 6a1803df08f44-6e1b2213f57mr284729986d6.28.1737481185835; 
 Tue, 21 Jan 2025 09:39:45 -0800 (PST)
Received: from [192.168.1.157] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46e104027afsm54879231cf.50.2025.01.21.09.39.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2025 09:39:45 -0800 (PST)
Message-ID: <8df0bb65-9482-4b04-81ae-a8b7c5292142@oss.qualcomm.com>
Date: Tue, 21 Jan 2025 11:39:44 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/28] target/hexagon: Ensure not being build on system
 emulation
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250121142341.17001-1-philmd@linaro.org>
 <20250121142341.17001-2-philmd@linaro.org>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20250121142341.17001-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: vXLrcrtHEXNfwfwcFKHpM2QADtuW75bL
X-Proofpoint-ORIG-GUID: vXLrcrtHEXNfwfwcFKHpM2QADtuW75bL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-21_07,2025-01-21_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0
 mlxscore=0 bulkscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 mlxlogscore=726 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501210141
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 1/21/2025 8:23 AM, Philippe Mathieu-Daudé wrote:
> Currently only user emulation is supported.
> Assert no target code is built for system emulation.
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/hexagon/cpu.h | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
> index 79e60d4bfa1..f78c8f9c2a0 100644
> --- a/target/hexagon/cpu.h
> +++ b/target/hexagon/cpu.h
> @@ -26,6 +26,10 @@
>   #include "mmvec/mmvec.h"
>   #include "hw/registerfields.h"
>   
> +#ifndef CONFIG_USER_ONLY
> +#error "Hexagon does not support system emulation"
> +#endif
> +
>   #define NUM_PREGS 4
>   #define TOTAL_PER_THREAD_REGS 64
>   

We hope to mitigate this one in the not-too-distant future. Staged 
commits on my tree implement system emulation, undergoing some 
review/revision now. ;)

But of course this change makes sense for the time being.

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>


