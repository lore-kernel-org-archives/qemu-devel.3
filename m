Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47A4BF5A8A9
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 17:55:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEspp-0007aK-JO; Mon, 20 Apr 2026 13:55:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wEspX-0007Xd-37
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 13:54:44 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wEspU-0001Yo-Qn
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 13:54:42 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63KFQk5w1599907
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 17:54:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JeRtHsD3N2bASsP5AMxBfiCqMspYJTUNsKw4nvShjuA=; b=M0vGRHf1MVaJBByt
 hdfytYefD9JMTwjwmrS8lvLYyGOiblvAoJ9e1OTrwF6ZhiBoimOsoKuy8nFTgMnq
 pOZn5FDW4ox9ye9Ds09Q/L/MT8e0eOfIOHUw6LSOYo8rUxRXQdSdA5ReJVyb29kz
 Op2YzGlyAsNIriWuvZYSMBADpTtzx/iKVLzJY9ArWrGeZsGn94BfTqIau4ach70k
 nCKOvIzWdGyERGjTDeJqQDHU3ylUB1caRc2DtHC/1CMLSqqLzQhSIuvryYxF/NSW
 QZsmcwK356odTenmdzRNKRI8I6KJqY93Gq0k5MzB4D7z2tGUE8tA/cCcthBU26gb
 ZSVKiA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnh899xsh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 17:54:39 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2bdf75bc88fso3814967eec.0
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 10:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776707679; x=1777312479; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JeRtHsD3N2bASsP5AMxBfiCqMspYJTUNsKw4nvShjuA=;
 b=AScJrMTOK0q4+DbcGpBNL/aJPYd4m+VJHNKJGrr+J81vVriDV6WvUno5lmMdIWypu7
 jGxTzXawsqQiKxIRNhwOCUN+sEfs4s11V8YVbdKGfk/TGaCSlFqTI8rjhIXRnEtUM99v
 RqZMpHtHGm5SDKEqARLbfbbt8nXaowmOuU7lRQqrKpu77zaUIyQxFGHE3/agtGeFSgBt
 k2ECuPkciG6TeVKYvDhaFzGNowrvRYQEKZmQlo8fvcmgwmfCfYiOLogwQ88Ikziy5X7a
 X5AWFvRcdMu+FK6qFCkhv9pcuL76qWGyundWeWr2cH76XDI1dOw/sH6gKfD8ht9vPFr3
 Z2og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776707679; x=1777312479;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JeRtHsD3N2bASsP5AMxBfiCqMspYJTUNsKw4nvShjuA=;
 b=KFrSPJRxrncQVAHtF9NKwJ3df9hAHtZHX0L4LRNf2b4ulfmrl2tHm5rG95ppqvW7WA
 HLXxRl0opZWroziC4aI0f4VBy9YaVguYAt3qQUFz+u0hvKCkN3XYvWpT/qMyj7TW0pcL
 Ff/dlBVyX7I1CAdMtBIp3jNGlnUzk/El3XD/iDnkVtdI3ZjM6LJq9QXsebhRcqXxG/7j
 uckUhrTdeICZxInZBpcTajZWPfLxYgKNZalO29qkHsmRSdBE1B/jr4WnPE9Xnrsa/Cex
 YUjfHZnPjlG0M053gMN3oitSg3NWne/PwJfD2WNE3eXp/OdnpjU0FGVFuKjeB3TstkX/
 1UNQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+shI7Su5M3XghDPpu2wj9fnMtC8wQobxtgB84JaGqTfAG80CvDqw6MrxxB/7Qqu2UI/QYnsbmJYLGC@nongnu.org
X-Gm-Message-State: AOJu0YwVM4sgu+Wb1j68OGcUDU0O2ToP+Wwe7Z89OtMYjN6KXvKVfVOU
 q9ZDNoyw5GfcuVIX33PnoJc+UObNCIOJwoKSF/tIzBMOj3Pr57z9anhNPFjc7GML2BtG8FqO/VA
 pfGD623AKj5MhQHqCwTdhRtl7vpAwhg2g7d/iq4gm4mz3S5GVXePy+7TMTg==
X-Gm-Gg: AeBDievV1SoVFFNvx3/id3iAd/EotBZNk2GWvzF0cB0wDvLLn524AlW7kHDkqZCk+IN
 RAXe55yVbpCg77ea203Py8tiCx6uTLXkd9tBx6h87W15t4O/YCSMMT9Mhssbx17cd2zbcwRqLjK
 1AsNYWOOcgwZyEaLJbiTZeygL32dpnFm9xCV2jGnR8ILXgZ8Ub9iKM1TzqZrwSE5gVoaMwWrLRJ
 xPMG9U+59Foxz4dnfzD3gvxn3QfCLihogFa2j2SR+jW05RuK8KWOh2ogvmaKqF+FTgc9JxTaIX8
 mk5k1CpHNnwCmT2323gDoHKwsChOvjkEaQ9iRGcLkbrxih0BJf0bD2VvVF0H3Ol5q67xgPCu/nk
 GIfhKC6lwj7fgRT3rRkMxz3atcpP/3vn1wtbp3RdbDdjCsgeIV7DzFgW3decWHHZ2MOjnICKOkU
 wllWX2Zfk+N1LmBbw6dYYTKRzN
X-Received: by 2002:a05:701b:2611:b0:12c:87b9:94b2 with SMTP id
 a92af1059eb24-12c87b99785mr1499982c88.28.1776707678557; 
 Mon, 20 Apr 2026 10:54:38 -0700 (PDT)
X-Received: by 2002:a05:701b:2611:b0:12c:87b9:94b2 with SMTP id
 a92af1059eb24-12c87b99785mr1499958c88.28.1776707677962; 
 Mon, 20 Apr 2026 10:54:37 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c74a20eb5sm19429618c88.14.2026.04.20.10.54.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Apr 2026 10:54:37 -0700 (PDT)
Message-ID: <24680b2d-b776-47b1-9db6-a4174cbddc02@oss.qualcomm.com>
Date: Mon, 20 Apr 2026 10:54:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/hyperv: remove duplicate include
To: Osama Abdelkader <osama.abdelkader@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Anthony Krowiak <akrowiak@linux.ibm.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
References: <20260420163452.327350-2-osama.abdelkader@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260420163452.327350-2-osama.abdelkader@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDE3MyBTYWx0ZWRfX3TQ3bLiRdO5o
 ptOhnizV3e6yaEbuhsxQvMKGodFc2De3J1KVKoRFZckHZrB46TtTiNNSerVeI+0O/lSD1XLF64n
 qLzbssRsDBXz6iKYvk/fMVXd3OPa6wvW6ExLUUUBgJrmruYCGL+tbPwcZcZ+rR+h+XpK5bTPuuv
 tldooxQ7lldtY9vST2bonNJPknQMNpvJUTMZ2c8j07bwe0ta8IdbKKe2IVyeDlisBnXPgKW0CKA
 y4vR5K2oMI/uAhZV6jeOobxd2VaLpWogV9d+7krPuFYnsHP/0Xq3OYTgcv8q/SSPIOE8rAWAlhl
 Uf38EiX6H4xEou+zR0mu9q7zDm+VIy+wcBmCEIdvwiCFMXc3CuKjkTcVd05JNP5hd179bBwZpn2
 bYvpaZZRewUPwy2DqYGdryA6oBf1sMaphskyjkpKO5NT4z9f/aqJEOOFt7/va1zpfJ2YMct4YAB
 oJjYTCrnZR0trLYoDAQ==
X-Authority-Analysis: v=2.4 cv=D6B37PRj c=1 sm=1 tr=0 ts=69e6685f cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=QlogZ3VhnaXr_P-1wRoA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: PfUPRpQliODBdnIvLvzDKg9Oc1hjmCuC
X-Proofpoint-GUID: PfUPRpQliODBdnIvLvzDKg9Oc1hjmCuC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_03,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604200173
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 4/20/2026 9:34 AM, Osama Abdelkader wrote:
> exec/target_page.h is included twice
> 
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> ---
>   hw/hyperv/hyperv.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
> index a42c2850e3..ffd79fdbf7 100644
> --- a/hw/hyperv/hyperv.c
> +++ b/hw/hyperv/hyperv.c
> @@ -26,7 +26,6 @@
>   #include "hw/hyperv/hyperv.h"
>   #include "qom/object.h"
>   #include "target/i386/kvm/hyperv-proto.h"
> -#include "exec/target_page.h"
>   
>   struct SynICState {
>       DeviceState parent_obj;

Thanks for catching this,
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

